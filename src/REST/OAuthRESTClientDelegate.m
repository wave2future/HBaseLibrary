//
//  OAuthRESTClientDelegate.m
//  DrupalREST
//
//  Created by Hugo Wetterberg on 2009-08-03.
//  Copyright 2009 Hugo Wetterberg. All rights reserved.
//

#import "OAuthRESTClientDelegate.h"
#import "RESTClientRequest.h"

@implementation OAuthRESTClientDelegate

-(id)initWithAuthorizationManager:(AuthorizationManager *)aAuthManager {
    self = [super init];
    if (self) {
        authManager = aAuthManager;
        [authManager retain];
    }
    return self;
}

- (void)dealloc {
    [authManager release];
    [super dealloc];
}

-(NSMutableURLRequest *)RESTClient:(RESTClient *)client getURLRequestFor:(RESTClientRequest *)request {
    OAMutableURLRequest *ureq = [[[OAMutableURLRequest alloc] initWithURL:[request fullUrl]
                                                                 consumer:authManager.consumer
                                                                    token:authManager.accessToken 
                                                                    realm:nil 
                                                        signatureProvider:nil] autorelease];
    [ureq setHTTPMethod:request.method];
    [ureq setHTTPBody:request.body];
	for (NSString *header in request.headers) {
		[ureq setValue:[request.headers objectForKey:header] forHTTPHeaderField:header];
	}
    [ureq prepare];
    return ureq;
}

@end
