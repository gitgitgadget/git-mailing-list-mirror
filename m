Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97C5C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 00:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjDVAMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 20:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDVAMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 20:12:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A812D4B
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 17:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122320; x=1713658320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pa9hgBYzTmvk9mrkIzkqLUqrSCdS1qTPLZHIvp7+uG8=;
  b=YleelnViqxA9wZp6tN6CT/aB7pN51BPsAy3KBrTvZtGTzw7iu22U+4H9
   3mORr+6gqsyOB1dqbpbDLmdwsrCqZnhyp+g7r+bGF3i2uTGIC2TYYBWev
   bg8cXS4KWXIC3S/M5TSaorvral+Olqvc7wRjbwpS/THypIXp2mtdk68Pw
   pB/w8UM06nGPiIiZqBA2/80uqmKqgxoJAOw34GG0k0bF8ybHGrNZfDuTB
   pEVZS18u/rJDka7E5tU3bls83al+IhLQ9gmstUiZvoeS1mnvo/sqjfGg9
   u6WpqwJx9U3ahgPFOPNHn1NwBlllWuj8CIOCkDywvCSgxXopPnFMpJTkE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="344859814"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="344859814"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:12:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="803913986"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="803913986"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2023 17:11:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:11:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:11:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:11:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4QAz8j/CWAmplXntf9RyBfdl8yGPzz2mYGjcJOobk0l56xzKD9C/8QnjsBR4q7ePZf5i+L2I1dbS+l95SzIqZmKOINkDh1KCdpWAsBf0K2iQn2SbG766E2opRInFIHE3sw971v3UxZh2W2GN/ZRl0jen4SjsTRCFSN+z/Z3ZPCSwjww0KuPCJ8nqCFB5HNKn2Z0ltWY3xpKNqODjq5ZA26i6sHzddNVJCj7GtDDOrq3N3aYW7jHjtwZo2yd5LD8xA/MGptK1j1+/UEPEZyn9qtHKQ/D+ZkFW8Cl14VYlcKInYmO6aEz1fXIZm/ehCfJgfVJR5WDhI5XEKm0kA2Y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZG/f3g+9BWm7USTVjkYBu5ZHHgCVNFd3FXo8QwBfLA=;
 b=oMTcG5hbsLLCA7qgGTny3sVMU7KJRy6x41yoVMt1mp3lubZhuU9HnqYyQk/x0lYv3YwTOEIJOtfm9tUvWM8ApNi/KlvbOJ4JlbrTmhRuZgpUtem3B5u9/Rw9pT9JJKUqvNNT17qH2L01WO76oI7E6v96NKKx5NRHUo4Q4fZbW7SuGG+XHO7OmmTP0r/cT3qRRaARZcsJyDyCA8JabP4uS1k2PrmCwdi1LlhBsJMfSUcezq50IuYoLFdDG9Umc39+O08hQ0JLPuL/IsicZkvNs6LkHmhFGiJsPWm1q5Vs2TpEY411CFmh8Mqh7ycHiFNA7oFQG9SJOWj49/V283dQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6893.namprd11.prod.outlook.com (2603:10b6:806:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Sat, 22 Apr
 2023 00:11:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3c6f:a70d:414b:98f7%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:11:56 +0000
Message-ID: <019057ab-c917-80cd-063b-4871e47dc382@intel.com>
Date:   Fri, 21 Apr 2023 17:11:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] blame: use different author name for fake commit
 generated by --contents
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
CC:     <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>,
        Glen Choo <chooglen@google.com>
References: <20230421223013.467142-1-jacob.e.keller@intel.com>
 <xmqqbkjgizcv.fsf@gitster.g>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <xmqqbkjgizcv.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 9183ffab-260d-4add-572f-08db42c62ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuZmE/wextixRoR52EYe/6C6WYMAAPqsJkLBUJ3w6YM8VrrRhKKty7nyRDNld/rmfWEunV3tdvzUM/ab77zRmI0IfmBHobc8MjtAbdvz78LGyI5yceLlCwBvWTPquoqoL+LQc2s+cBR2jASOl/Qv+Rw/Mkrkd3JpYn9cH/muK9cpZZDnFmUxX7aYKbHjc0turw07uVlR3EvlOjXOUfwLWP64hPzHIdeFMpOcdI46uuifKT/eTXav2rVSQUqFE4pqXJgBrDYhKgphdQOaPaJco5miBPtvsAEYkv49i2WgApfThhgGsAhVFxIQ2TBJOWrPkypnKsdAnehHc4rKFS9P5RtHuCwoBjMFwpGlr+NYaSMgtNbPaYxjx8xsekuxGJXL/ORFKtKlUuGyshJZIcS/ShPxoRrbET815JkmtdGwuLEoL3K/gr8V7qS2Ag2FqSYVv9cZMECQzjzzbEpAsEOv904QIzUuPHIh2CQHNc4WMbpMzzCjKbwn26i8eR+DwpEXFnDgXmFMFC6C/d/eDRhiZ13xPfKQI6FASu6/0gkJvgo07hO9gJF6x6d7BKwdWkVjKn/5GnJVlc9y+AlaQ2KriIJGjSfydWEeFsCQxwgYwDXwmyF1+6Ll/0JSvxx7THLZ0ALP+m39e/aWmufTq2qfWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(2906002)(86362001)(6916009)(38100700002)(8676002)(66556008)(66946007)(66476007)(186003)(53546011)(31696002)(6512007)(6506007)(4326008)(26005)(54906003)(5660300002)(478600001)(82960400001)(316002)(83380400001)(36756003)(8936002)(41300700001)(31686004)(2616005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlZiNklVbkptOGpKQzUreXF4bEhJS1NxeW9JNk1YbWp0aWg3MXZ1UVhIWG03?=
 =?utf-8?B?RzhhY2paY0VGb3N5VzE4SjNOd2piaklnTVd0WExKNElOSHdDU0JsbzdscjV4?=
 =?utf-8?B?YzdZMmJ6MXpLcDFQMmxCRUxkR2Vodk5QSm9VajdleDdqUmRJMk9KNG9Ndjd0?=
 =?utf-8?B?NmxtbkEvWllnRTFycldYVVFRaEFUa3dqN3pDL3RYSzVhR0FNaFBVV29ZL0hx?=
 =?utf-8?B?TTFWWmNpSXNMa0lDRyt6dEF1dkxSVmQrdHhMWkIvL2crM29nZU5IMFNPK3Nn?=
 =?utf-8?B?OGRabE9nYklMME93SHQybndsL0hvMlluWFJYR2paTjVoRzRFdExmODhFNnNa?=
 =?utf-8?B?UlFJbFdJQ09mOVFna3hWYzVQTTNkT01FODV2UkRMd2VFVnVtNmU5UzRpVlJ4?=
 =?utf-8?B?d0diRUlKV2RWN2FuRDZTNGtqWjBOUFE5OTNZbWtMM3BIb002WmhMaUt3Q1pO?=
 =?utf-8?B?VFQ1UUpaWU0rM3RiNmRGZWhkclVSUHpJTkgyNzBYRUI2VlZOeWIya3grVmZk?=
 =?utf-8?B?MEZlK1pPRjUxVWM5WklYbjJneWdxZEsycGRvMVdFaSs4T1pFdHNPeWxZQnZ6?=
 =?utf-8?B?NWFvdXc1NU54Q05OTmNWRzFBSUJEM0VVT3pVdnE1VkdhUGpKZmZYa1dVRWto?=
 =?utf-8?B?OUk5bVN6dTdnTlZMWHpQVHlqODNOOVQ2SiszZGlqWDU2MTcySFljYjR1dU9q?=
 =?utf-8?B?WG9PdE1uV2RSb0o3TUVDY3lDbmpDNSt5YU9vZDlVTlc2SnVaM2dqcWJLVjJS?=
 =?utf-8?B?a3BmZEV1dDh2YXRIaUN4NnNaTm5oaWlXbmMvMjdlZW5ZNlVxM2tXUnFveUhE?=
 =?utf-8?B?VitWNTlGMGFlVHhjVzQybmFIR3J0c1JuOVJ1N0RZR04veFhJUXd6c21oUGpN?=
 =?utf-8?B?citrOVJQMjczdi9zZmp4d2FnRHdjOXFReUw1TGpZUHZSMlpHU0FRN1VNVzFz?=
 =?utf-8?B?dDlGNUVFSVI0WUVoTjdWRHhDaVdRWldva3NVbUVUOGw3eDhWZk5YTFBiNml2?=
 =?utf-8?B?L2pLVFRqTlhlb0FmbFBtOExFK2F1TzNkSWd3ZVlGWjlVMitYTk9GZHkxVHlm?=
 =?utf-8?B?dk05bXhydk56a3ZqdExjMXdFaTl1dnJsSkV0SUhiaVI2OGRrcWlnOFdXSFBC?=
 =?utf-8?B?QlM1TVVBNmJZcFlFUHpmaWNVL0RsZmpEQ2FxMTVwNE1BZURibERaMTZkTXM3?=
 =?utf-8?B?SnhWMGNLTWVMV0RFeHRmY3hoa3haV3Mrek5wdHExLzdSd3hVeDlHQmorQTlW?=
 =?utf-8?B?bk40TVZZWkh6eGM5T0xyS2Y1RDJmcGhnbE0vQnJFMk5mcFY3QzVEL01XdnJ6?=
 =?utf-8?B?WFoyRmhQUDFyUi9JZktZeENOTHFyLzRuWllYWldSYVZtdStXYnhRa2xmcm11?=
 =?utf-8?B?ZDRkVThHamN1UmpzL3Z6YlVnMWp6VmdwbDJ3ZTg1NnZiMEJBamJUaU9weHNH?=
 =?utf-8?B?VlhYd2F5YklDeHI0cmJacDVzZFY5eFdkb01CaEp0UGtKWi80d2F3ejIyYWRs?=
 =?utf-8?B?Sko2MzRnVGx5K3ZLT1ZiaUFab2NGSmwzRExsUUd1YjBteUx6alhPbXlBNXAy?=
 =?utf-8?B?blYxd2FlUk5TOVpkUDRlY3oyWWswVFUxVzJzUFRlbnFQWjRFejB3OFRLZW4z?=
 =?utf-8?B?UzlUZnQyaFllZ01EZld0akZxdjRGbnV3d2RlWjJFWjl6MDZ2Zjc5WVdVTVY3?=
 =?utf-8?B?ZVFvR25ob3VITDBPeDNjVFozVTJzL0xvWlduQXdQcUZGenI4VlltbndxR2xY?=
 =?utf-8?B?cC9nU2hzcTRCckNlRG40TStQa0s2Y0lzelJGam5HM2IzSmJoamt2dW1VV0J6?=
 =?utf-8?B?dGRqM3lsT2JoM1hzRFFIczRLQUh1WnMvL1ZVcGR5SUdONEYrMGZRb25DbVlQ?=
 =?utf-8?B?VWtJaEFaMWdEa1I3V2ZRZWE2WW5LMXJMeUhoKzE2QmcrTXhUbm93clhsdWx2?=
 =?utf-8?B?K0VMWHhuek1ZdkZCSXNMd1RybHlWcGYvcUJTQkNoUmRSYVJzd0w1cHh4Tk1E?=
 =?utf-8?B?VDc3QWljbjkvK2JQandoM0h3MzlyZTRHSzdmejJDQTZDcURrTzlzcGZ4Wnp1?=
 =?utf-8?B?WkxRMjRRamk4aEpVNWhxOEVnRVh3SXhnWjNTSVJuTFZvbWk4MmZYUDdmVGdl?=
 =?utf-8?B?MEMrdTAwUEo0OFlzbTV5NkpFeS9ORmw0VWNQeC9uS3R0UEN2cEliWGdJMWQ1?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9183ffab-260d-4add-572f-08db42c62ebc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:11:56.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUJyG7w9fM1F9b4ZX/XhoATY7wjzm4XOiaSHV7OxL3mMIeMUU9uLyUZxCxSJ81lZrAb2Pp3NiH17uFDWi+cfaNGWh6potflLNOOxJ8mtnWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6893
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/21/2023 4:34 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> +test_expect_success 'blame working copy' '
>> +	test_when_finished "git restore file" &&
>> +	echo "1A quick brown fox jumps over" >file &&
>> +	echo "another lazy dog" >> file &&
> 
> Lose the SP between ">>" redirection operator and its operand
> "file".
> 

Yep.

> So, we have "1A quick brown fox jumps over the" and "lazy dog"
> in :file and HEAD:file, and both of these lines are different
> in the working tree files as shown above.
> 
>> +	check_count A 1 "Not Committed Yet" 1
> 
> So why do we expect one is attributed to A while the other is
> attributed to the working tree file?  Shouldn't we be expecting both
> to be attributed to "Not Committed Yet"?
> 
> WIth this updated like the attached, 8001, 8002, and 8012 seem to
> all pass (and without, they all fail).
> 

I think I just missed a "the".

>  t/annotate-tests.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git c/t/annotate-tests.sh w/t/annotate-tests.sh
> index 859693949b..4238ce45f8 100644
> --- c/t/annotate-tests.sh
> +++ w/t/annotate-tests.sh
> @@ -74,8 +74,8 @@ test_expect_success 'blame 1 author' '
>  
>  test_expect_success 'blame working copy' '
>  	test_when_finished "git restore file" &&
> -	echo "1A quick brown fox jumps over" >file &&
> -	echo "another lazy dog" >> file &&
> +	echo "11A quick brown fox jumps over the" >file &&
> +	echo "lazy dog" >>file &&

I think the right fix for this test is to keep the first line (1A) the
same, and include the missing "the" I had removed before, and keep the
2nd line as the changed line with "another lazy dog".

Will fix in v2, and double check the tests. I had run them but my local
system sometimes fails the following test:

> not ok 46 - passing hostname resolution information works
> #
> #               BOGUS_HOST=gitbogusexamplehost.invalid &&
> #               BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
> #               test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null &&
> #               git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
> #

I had thought this was the only failure, and that it has something to do
with my system configuration (possibly proxy settings) which affect
this.. I checked the firewall configuration and it doesn't appear to be
that...

It would be nice to figure out what makes it so the tests fail so that I
can make sure tests properly pass on my submissions before sending them
in the future.

Thanks,
Jake


>  	check_count A 1 "Not Committed Yet" 1
>  '
>  
> 
> 
