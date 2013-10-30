//
//  RestaurantViewController.m
//  Shadal
//
//  Created by SukWon Choi on 13. 10. 6..
//  Copyright (c) 2013년 Wafflestudio. All rights reserved.
//

#import "RestaurantViewController.h"
#import "MenuCell.h"
#import "Constants.h"

@interface RestaurantViewController ()  

@end

@implementation RestaurantViewController
@synthesize tableView;
@synthesize restaurant, titleLabel, phoneNumber;

- (void)setDetailItem:(id)detailItem{
    restaurant = (Restaurant *)detailItem;
}

- (IBAction)call:(id)sender{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSNumber numberWithBool:NO] forKey:@"callBool"];
    [prefs setObject:restaurant.phoneNumber forKey:@"phoneNumber"];
    
    
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:restaurant.phoneNumber]];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:url]];
    /*
    NSString * urlString = [NSString stringWithFormat:@"tel://%@", restaurant.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
*/}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = [restaurant name];
    [phoneNumber setTitle:[restaurant phoneNumber] forState:UIControlStateNormal];
    
	// Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [restaurant.menu count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[restaurant.menu objectAtIndex:section] objectAtIndex:1] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[restaurant.menu objectAtIndex:section] objectAtIndex:0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MenuCell *cell = (MenuCell *) [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        NSArray * array;
        array = [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    NSArray * menuArray = [[[restaurant.menu objectAtIndex:indexPath.section] objectAtIndex:1] objectAtIndex:indexPath.row];
    cell.menuLabel.text = [menuArray objectAtIndex:0];
    cell.priceLabel.text = [menuArray objectAtIndex:1];
    if([cell.priceLabel.text isEqualToString:@"0"]){
        cell.priceLabel.text = @"";
    }else{
        cell.priceLabel.text = [NSString stringWithFormat:@"%@원", cell.priceLabel.text];
    }
    cell.userInteractionEnabled = NO;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end