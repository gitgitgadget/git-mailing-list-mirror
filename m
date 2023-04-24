Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E0FC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 18:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjDXSnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 14:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjDXSnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 14:43:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D355A6
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682361794; x=1713897794;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kC2ljbEDTMzxl/IxeUb1ro4TUj5mj+F01hKo72iQNwI=;
  b=dFfXCwbidE5M/2t9IXPcCN58+I6AfwnwVOEVU1DxY/RbcExV6/S3e5bB
   Wn24VRd72uIxXE3f5Gjaj2LqMJjB7O+uFJSEvOcnycxI5T8i5y+GaCt02
   6Rb0afT1GaQCPO6ClQM6TvdaB08U3Q6rql1/5qIz+FE1TUgQkmqDkpAHW
   D+uupCUPJWENbYF/LjLgCGSim6jE1anTcWnaXsUMajPloeCbzbLxX38T6
   bRaUiLWf2hCFW+hgv+F8l86ENJ7486lhoffufUqfUhLODW6ULETzmsw52
   piahXXTZqnwQemYdxFt8yR5+lFIpHMGD2LYPJAvh3WRIsTLzk89sUk9hg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="349335381"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="349335381"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 11:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="725793575"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="725793575"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2023 11:37:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 11:37:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 11:37:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 11:37:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhsNAHhB+ujUbhXuCUngOktnj+JOquYH10QiPSFR9BmgkUugCjSDnhkkSTEPYHxiWgCwxxhlMv/1a6oi+GOFm3qTBpPZkax9dGsI1I8kBPaFrCnYWrWlyldf5LcC6mYlwAEaqASHCHkuT4lFxkF3sTzA2OaEbEaeY3nVwcz1H0XFBI+CdfS8lv3f8UdZm0AXUsH4LdrGT/CvjS10WeNfSiyZWoeZtxWHIgaBKjusK2V2x9NokSko/PepV4x0dQ3KY6mb59Ej8QYndjRmK6oI6WqORTi9XwUMfR283Idt5vsFnAoPotUkaKpOL/0ECGsIr2l6fEBB5s7TXx2oK3GGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GebpoAMzL+3wVCBwpcAP9r3vqG06flt53qSgTMvsBPs=;
 b=YIlAPQDJ+i00ew6UsLT5Hs9zHP2yOolEJnKxUrU0mSqPdbrieA0CUikJbG33yxSIVRNnfmS5jwrC8ww20CSutEV7KnE2DPX40X18dcgksoPUwwn9quLBoKeAfb5qFk2PGVGj5UkvKQ6URu0Ip6SVyhyReLff3ll0XZdPUee0sjfr6wVRV2CRnfK4Nfd9xhhlaThtw//D45lF+f0UMCbZ2kUPX8Ag2q1d6Pz6Q+ncdd9ZN/3KPPPwVflR0r93oNI5b1tCuvtNg9cdY6HN80bspKNGiBNjgRv81qDmTCo7Kwqn9uczWZqBVyEy1ew3s6p1M9fiEnG3D0xs7p38Z84bYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 18:37:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 18:37:22 +0000
Message-ID: <90f8499b-891f-ec32-096c-9ae532ef65c2@intel.com>
Date:   Mon, 24 Apr 2023 11:37:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] blame: use different author name for fake commit
 generated by --contents
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>, Junio C Hamano <gitster@pobox.com>
CC:     <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
References: <20230421223013.467142-1-jacob.e.keller@intel.com>
 <xmqqbkjgizcv.fsf@gitster.g> <019057ab-c917-80cd-063b-4871e47dc382@intel.com>
 <kl6l354p9n52.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <kl6l354p9n52.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc1b926-8d6f-49f6-0021-08db44f2f161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTcRmTCispuQdYPe19XC4WBjZk8Lu9ukzQSVBKCUcYuC6sBlvU2RS7wQN7T0TG3cR91TCPD+LAF4tHLTeiLKOP97JSUOhfVkmKMHmg6QSmzjIqGdEi8zer6FSjCg7P/U7saysvQ73zhvYEzNWrwSlWY5g0WYVvtDkSMWyPq7SFkY7Jx04ZoYW/9smNsC+Uib4cczyAdVhAkK1ZRjj8RpXWkFTnE5h/d7gyOW+tq6s47oOjfzriy1aeR8cQCWSBt/Y1vVV9tmnOL6FYyYcJFxfCeS9U/W4rxafxaGqDyN7roLDRmP/Z2xpkCUtzCYqcXF8XkI4ipBw4RM9Wigpc3jlshfBzpZGEEwlAiSbY3mgbPVtPEAaHxbn5bTdEG0pQe/Li0bRp1Knx+hkUPwK6lPacuztb25RoB0lJvG9lEFuM6CRRM+t+Pzenw2eB0O1KkQ5l330VMk/Xp5paoUxY6Bx5EH5rLHVewgqX7VkwI4F4KA0/hy3ohiaQjNz58cbxs0UzhRf9Ph+Zwdf+EfH3mfW3XbwaimvBNJ2Nc9QJwzetouqjppKvHel6sjXjqfcdinbVyM13hHp1w4YBDUhlpX4YA22WJ7JI/KggChMyrSmC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(36756003)(110136005)(478600001)(82960400001)(316002)(4326008)(66476007)(66556008)(66946007)(41300700001)(2906002)(8936002)(8676002)(5660300002)(38100700002)(2616005)(31686004)(966005)(6512007)(6506007)(26005)(53546011)(86362001)(186003)(31696002)(83380400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a25RZElJSkZleU1vbTN4RkkyeDErZTdweVQzU251TnZ0Y04xc1BNQVlXUWE1?=
 =?utf-8?B?TGg1eVEzRk5lbGg1eElxcU4vM21Kd2NiK0luZkJmNk83KzJJSGhTWE5nSVZI?=
 =?utf-8?B?WFJQNGI1S0hGdjJHZjl0bDNjWEh0cm1VYlp5b2Y0OWpRdGJydmJqTUQzT3JN?=
 =?utf-8?B?a3FwNWRlYUw1Y0VsUUtZcGhISU04SkplNzZsWWJZV05ZeG1YbW1lWEw3RjYw?=
 =?utf-8?B?VXhWVllhVVd1QXlpZ3dUdmR5TDhNM0MvdTJGQllKZXZhQzBnYUp0bloxUEFP?=
 =?utf-8?B?VEkwM0x3SXM2SnFHSmR5RnMzOUwrR0haZVJjbUFXdE4vUzBCVzBrcjFGRlBF?=
 =?utf-8?B?OVNBTXFtbWtXUklwU0JTMDZLS2VDc1R2eGNHUEZwbko4ZXNLYWs5UldneXdY?=
 =?utf-8?B?KzBCVkJ3SlBRN285SDdkWjNLWCtqb0U5ME51aXRWV3ppcmNqZ1Y0WlhZNDNX?=
 =?utf-8?B?dFdmWUZGTy9JUFNYZmgrZ0E4V2tQR2tiR3hYMlBmWVA1WHltTmJZZlVwQ3pu?=
 =?utf-8?B?aFBoVm1SVVFJZDB3NDdvMHV6RW5yNmR6YzlhZU5seEZzOVlNQnMyd2pUa1c4?=
 =?utf-8?B?VStnTzFoT0ZYNnRzVk9LV2YyT0JlZXlZVnRkaEdweHFFeXkyWlFDeTZXSEZO?=
 =?utf-8?B?TUVPWXRDSUp3WXFVVTVjWURiWXJER2NwS1VJeDBhTHRLK2YwS0IvbTlsVlNq?=
 =?utf-8?B?Wk1vem16VnZnYkNNMmNSd2tSem43UWt3djFxZHhaZFBWb3dNYmFtY3ExRmlT?=
 =?utf-8?B?UjViT0xLanA3M3IybDZZSFNOMHZ4N1JNb28yakUyTEp4amd0ZDd0YjFURkNj?=
 =?utf-8?B?Y1JjYmNMRjAzVE1rUzhwVVVVVmhGY3VQVzNnSEdzUW0rem1jR1FUT3dsNmpw?=
 =?utf-8?B?eEZETkJFSnFSb1grT0dPTTYwTVphL1JEdGd0Yy81dVFINnQ3cWNyWHBNZmp0?=
 =?utf-8?B?Y3RsMkVZNmMvK0pXWU1KSTd5UlhIRkpLVUo4YjJJRnNhVG9TOXF2d0YycEd5?=
 =?utf-8?B?cnJWN1E3Yyt2TWRvd2xUbnVCVFpwV3ZFV1VyQ2VsTVlCQmhLWHBFT2tBZ3k2?=
 =?utf-8?B?Y2tXUWVqUjhmZmFUamFZeXpRd0VHZmtWS3dVVUNndVpSNHdYOFova0puZlFX?=
 =?utf-8?B?MlBwUURLQ1RpcnEyUWxZN0RqV1ZpWlVvUzY1eHZzWWhRN0NJMExVdVJuZmV0?=
 =?utf-8?B?SzhZcGxFNHlmdjhTUk1pbHZDM0h6YnhZODB1cTVseFBoamhnVFZtRWFCTmtN?=
 =?utf-8?B?SG94VHNqNzluYkVXUW9IV0VSUVRpd2ZyOE5QMFFHcldORlgwc0ZnMVNJRjVu?=
 =?utf-8?B?UHNFaXVTOHc4eE9jbkJvSG5yRkdEeEtrZ1BJWWJtc1pEU3lHVE1lOEEzbDBU?=
 =?utf-8?B?dTVVb2NSUmlhaEtSdThkeGR3TGNyZWZ5RUZPZ1RFa1FmVDVkbkRHbG1MMEhY?=
 =?utf-8?B?ZUZjRyt6cDlGOTNwd09PRUpVc2NFMnZMM2lCYnByYTlDUTZ5RlMySFZSNmhC?=
 =?utf-8?B?ZEVUMDB0cStkeUYrZmxod1ZQUklIdkNOeW1uZ2I2RXVwMW1VRkpncFpVUFhu?=
 =?utf-8?B?a081b2t1NzNpdi9KVmxGZDhpam51NStyd2ltWlErOFdKTTJwRitKUWJNdkJi?=
 =?utf-8?B?Y0lsSUhxUFBpV3NKcForTGJtUitzeWJsQ21ibkMrdmlrZG85MzU4cEJwZldW?=
 =?utf-8?B?TEVwelRFdi9kcyt4dVpBVCtnNFlmWlJaKzR0VmZEMXF4Q2pIYzFMZndWRUlo?=
 =?utf-8?B?U0tKYnFIa2F1RW1aUmtBRU9iMWYyMkJFR0cyVFZrMmRxcUI1bnNoMGdoaGJN?=
 =?utf-8?B?ZVpURWxHTTM5b2ZwNzM3djhQcXVmQlBaR1NDZWRnaHJId2VjdGxTMzNrSExh?=
 =?utf-8?B?TnVZR1hzNGVDYi9JSUt0WU1ZVCtCdURBcGlrbm5vb2JZeE50bndFcU1pN2tB?=
 =?utf-8?B?K2FIUW54T0Z3L2paNk41UGhDSmQ5RGFuNTBJZzhTcXdwSnRibUlLYkx4S1BJ?=
 =?utf-8?B?VUZGS0RaeE9MVC8yZXVrTFlzV0xUaURlczFJano3R0o5eUwzczEzWEkvQlFh?=
 =?utf-8?B?VnhOSHNhWXcyWDcwOE1kTmVyOGZxeU44WkkxSVhKZ3BvSTB0bDk3NEVFS3J1?=
 =?utf-8?B?ZFpBZHNKbXhnMlh4dHhHb0ViRTJLZlNiV3dmUXJGUUV3cVpTM0g1K2Y5WUUz?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc1b926-8d6f-49f6-0021-08db44f2f161
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 18:37:22.6830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTTII2idqhg1xFmqKehZE73mW5e6RjG8NDdmNLOI76FOMlNpwPhCLj6sP9X4I/5/lDfE1cFEZRrQgx61xJQm36ZI7I3vkmsUnb8cRAimqmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6218
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/24/2023 10:59 AM, Glen Choo wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>>> diff --git c/t/annotate-tests.sh w/t/annotate-tests.sh
>>> index 859693949b..4238ce45f8 100644
>>> --- c/t/annotate-tests.sh
>>> +++ w/t/annotate-tests.sh
>>> @@ -74,8 +74,8 @@ test_expect_success 'blame 1 author' '
>>>  
>>>  test_expect_success 'blame working copy' '
>>>  	test_when_finished "git restore file" &&
>>> -	echo "1A quick brown fox jumps over" >file &&
>>> -	echo "another lazy dog" >> file &&
>>> +	echo "11A quick brown fox jumps over the" >file &&
>>> +	echo "lazy dog" >>file &&
>>
>> I think the right fix for this test is to keep the first line (1A) the
>> same, and include the missing "the" I had removed before, and keep the
>> 2nd line as the changed line with "another lazy dog".
> 
> This sounds right to me; it's easier to read when the working copy test
> and the --contents test use the same data

Yep, will have it this way in v2.

>>
>>> not ok 46 - passing hostname resolution information works
>>> #
>>> #               BOGUS_HOST=gitbogusexamplehost.invalid &&
>>> #               BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
>>> #               test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null &&
>>> #               git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
>>> #
>>
>> I had thought this was the only failure, and that it has something to do
>> with my system configuration (possibly proxy settings) which affect
>> this.. I checked the firewall configuration and it doesn't appear to be
>> that...
>>
>> It would be nice to figure out what makes it so the tests fail so that I
>> can make sure tests properly pass on my submissions before sending them
>> in the future.
> 
> I remember seeing a similar, flaky failure on an older version of master
> (~2-3 months ago). But if you based this on a recent version, I'm afraid
> I haven't seen this :/

I'm running on 667fcf4e1537 ("The tenth batch", 2023-04-17) and the
failure is consistent.

I'm not familiar with the curlopt stuff but it does seem like some sort
of environment failure..

When running with -x and -v:

> ++ git -c http.curloptResolve=gitbogusexamplehost.invalid:5551:127.0.0.1 ls-remote http://gitbogusexamplehost.invalid:5551/smart/repo.git
> fatal: unable to access 'http://gitbogusexamplehost.invalid:5551/smart/repo.git/': The requested URL returned error: 503
> error: last command exited with $?=128

It looks like this is a straight wrapper around CURLOPT_RESOLVE. It
looks like the HTTPD server starts just fine but perhaps some firewall
configuration is blocking connections.

I found I can skip the tests by setting GIT_TEST_HTTPD=no so thats a
decent workaround for me for now.

Thanks,
Jake
