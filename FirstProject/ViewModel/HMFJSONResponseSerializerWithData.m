//
//  HMFJSONResponseSerializerWithData.m
//  FirstProject
//
//  Created by 谢政 on 2020/5/29.
//  Copyright © 2020 maimemo. All rights reserved.
//



#import "HMFJSONResponseSerializerWithData.h"
 

@implementation HMFJSONResponseSerializerWithData
 
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error {
    id JSONObject = [super responseObjectForResponse:response data:data error:error]; // may mutate `error`
 
        if (*error != nil) {
            NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
            [userInfo setValue:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] forKey:JSONResponseSerializerWithDataKey];
//            NSLog(@"%@", userInfo);
            [userInfo setValue:[response valueForKey:JSONResponseSerializerWithBodyKey] forKey:JSONResponseSerializerWithBodyKey];
            NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
            (*error) = newError;
        }
    return JSONObject;
}
 
@end
