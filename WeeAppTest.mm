#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController-Protocol.h"

@interface WeeAppTestController : NSObject <BBWeeAppController>
{
    UIView *_view;
}

+ (void)initialize;
- (UIView *)view;

@end

@implementation WeeAppTestController

+ (void)initialize
{
    
}

unsigned int countdown()
{
    struct tm now, future;
    time_t t = time(NULL);
    time_t fut;
    
    gmtime_r(&t, &now);
    future = now;
    
    future.tm_year = 112;
    future.tm_mon = 9;
    future.tm_mday = 23;
    future.tm_hour = future.tm_min = future.tm_sec = 0;
    
    fut = mktime(&future);
    double diff = difftime(fut, t);
    unsigned int day = (diff / 86400) + 1;
    
    return day;
}

- (void)dealloc
{
    [_view release];
    [super dealloc];
}

- (UIView *)view
{
    if (_view == nil)
    {
        _view = [[UIView alloc] initWithFrame:CGRectMake(2, 0, 316, 101)];
        
        UIImage *bg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/WeeAppTest.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:71];
        UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
        bgView.frame = CGRectMake(0, 0, 316, 71);
        [_view addSubview:bgView];
        [bgView release];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 316, 71)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = [UIColor whiteColor];
//        lbl.text = @"林軒宇是大帥哥";
        lbl.text = [NSString stringWithFormat:@"退伍倒數 %d 天唷！😄", countdown()];
        lbl.textAlignment = UITextAlignmentCenter;
        [_view addSubview:lbl];
        [lbl release];
    }
    
    return _view;
}

- (float)viewHeight
{
    return 71.0f;
}

@end
