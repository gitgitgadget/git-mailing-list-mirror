Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718A0C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 08:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE7960FC4
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 08:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhKAIgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 04:36:19 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:6978
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231185AbhKAIgR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 04:36:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfg/tVj6+CtriZzw9kAymuwK+SEoUx/kqcfo2wwXM2o5/9kW5Lx7cY1Af3A1nTBnGHZWUUetDn81OJ/CFVOeeO2b1+BRFRSb7ZI2llDZsP9w9GXMRb3QXo8THKKFmNBxFDSWbneui+AXVFGqWEGS+meqfrtUN+4OskWqW4biCZOhlbYig5/taTaCZMpCoUqHVdvDiYXECqWURBAqzFHki4HKudzkY1QscHpiP72Hr1xYsCJVx/VXWX/oy6ELWYtT4EVfL9lUgdKOhwgw3neqz4Z/9f+KEybbz9811bW0w9ljHYPmmSEbxrxuQrNycA7rjzR4t4DlaM3zhB/mx1Yn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Zxl0Kpgb07RPtzA2SqDFbbJ8zAC95ENB7iXZQsJimQ=;
 b=CHD2be+HoiR0C1YOqrhczyyTMWJg0BAIIYVKE+hylNEuaNgJ674jhQ08dxGnLs8a//UeLdfOYP8UkQDAyA4TQtJP0mj69ssHvIMViqTEIXUse2SRNloSMnlVtFdMcXe/3LikFTkh56wVn8lKXjtUwox6h2M4hoOHmlU7RW2MiJPASvRM8FPikCTa1sJk+p3gzPkk1SpDkZMSkrjPRw0MLyoLc167YW7iqknrvAwmEvYftDQvb6oyySBSAK+Ga2XO7cjTV0zOweR7NctCtAhbnXOWYKWo/F7uubngnB4WGWufALDhpxEV5epMPBEXIG9Q0snZV1qZlDlhvZfTutPGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Zxl0Kpgb07RPtzA2SqDFbbJ8zAC95ENB7iXZQsJimQ=;
 b=LSlLIZhBG8juuBhC8xlfOTZFt3tT9OBUkVHtTXch/QQQh6SeEwTsMkKurRNBoHw6owCABI3xDmWVu8sqM6nNVzCuPSTDa2bU9nUMD+DgwAV5XaYXxEnqga/o5AwbquZiM0Mt6dEmASeRw32VcZpbZrKhNSpf+t1WhiEqKCwxGJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Mon, 1 Nov
 2021 08:33:43 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 08:33:42 +0000
Message-ID: <d758381f-064a-1d0a-afab-cb2160ea2eec@gigacodes.de>
Date:   Mon, 1 Nov 2021 09:33:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] gpg-interface: avoid buffer overrun in
 parse_ssh_output()
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <f6fca7c0-079c-4337-23d9-cd970c79b8ad@web.de>
 <a72ebd19-9871-f811-cd5c-72b89dad6c6f@web.de>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <a72ebd19-9871-f811-cd5c-72b89dad6c6f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0601CA0045.eurprd06.prod.outlook.com
 (2603:10a6:203:68::31) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:c042:75a0:fd5e:1472] (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5PR0601CA0045.eurprd06.prod.outlook.com (2603:10a6:203:68::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Mon, 1 Nov 2021 08:33:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9c15b9d-03ec-401e-b4a3-08d99d125018
X-MS-TrafficTypeDiagnostic: PAXPR10MB4672:
X-Microsoft-Antispam-PRVS: <PAXPR10MB46724FE9A048838076BA7A6EB68A9@PAXPR10MB4672.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnH4zaSvov3fPaPXNGE6BbTk4RWMTlWVBEHKtgPOmxXVEVhsN3BFoh6FLwoIjmnuQknsIJ7HUULx2HP9FBYNAwIIrImv1tS7rq1Id8tGxhF+SQLmgQg1tamBbWrjyvXQ/TctOFULqZozWwxteetgpr9j1WGLm3InzUKyzLz7bT00i8W2AMm2PofdcYj12MY+P6eISz62ZB33TrMVelzS/uKx29VmcVKyOOvPD+uL00kJZg0e3ZA2JCbtNXbCwnH1fVmkpHICIb8jtMmbcep1qhvPSFnowiQPGg6buKUjjCX5Dktk5An6jPGtu4XSMCsQfeoNfbfKO6+GKBWC/j+tZKxqAK33OPegr0WL3x6/RfmaZHq0izHulm3TDaRHTm5ULDramna9QK8df2T5lawCtnyRU6KI2wdOvfVb+sWnQAqn68pDZ87Wo/t2oG/9NSCioAsKhfxaVQjDsYZB55snku9UkayBpe4jp0I+ATA0FeGLrAYzSpNvGhNA/vQufngSylUd8mpOke4FdzxZxXIdsynat6ZmB1UCILjsQKmYN2ECQsGiLcCIl5EnVSEeucbvEBWxOBfZ4m30D+poPbi6nOVjgHRzcsL4Mizjd1mfX3GKyAIpxB+Fl5vwZ/oc1+2ir7SwcqxkmjGjzlniB4Esg+M7RZIpdrQui/PHAqNz20i3YG/uaxojTGSurN+HZHgB2pEN3T3OTkFPLw34hb+JUtxQ038Wnv+Z7XxLFrLp4/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(396003)(136003)(346002)(366004)(6486002)(5660300002)(66556008)(66476007)(110136005)(316002)(2616005)(8676002)(83380400001)(2906002)(8936002)(53546011)(4326008)(52116002)(38100700002)(6666004)(508600001)(36756003)(66946007)(31696002)(86362001)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnNsS09pT1RTdVpjNlRFejV5ZEZCSDFkRVkreFExTGF5RlNWQUVmN0hXYnZl?=
 =?utf-8?B?ajloMDYxQ2JmdWtvbTV0amhHcWl0c25wQ0Q0NmM5dkNFN3hXQngycmtFS3Vn?=
 =?utf-8?B?TDRZYU1oa0RucUIra1pRZGdPVW9WekMwL3MvT041WUtvbFc2S3BqYmxpZjNq?=
 =?utf-8?B?cE5SK1pyTjdyR25YQy92NytLWCtIZFN5Y2Q1Vngzc3hxR1FuNXMwNzVXYzM5?=
 =?utf-8?B?dllUaHB5cjg3MVd5ZEJTOWdYbXNUZVh4QndFR1FXNHVoOUYzb1lRbHBkN0ov?=
 =?utf-8?B?c2UrVEtYNlVkd1JFWFNGK0d6RFBBVkROWUJGZTVITENiaTJTZkRwWHBWbjZG?=
 =?utf-8?B?VzIwOGREZCtEem5LczhicUhFNFQ1dGlQYjNZTU9IMm94NkswaXRhUjFLaG5k?=
 =?utf-8?B?QkFSY0UzcmcyL2k2RTgyNlQrRmJHckEybnVEZU9uZ3IyYjhvNGw4dVc5dGpO?=
 =?utf-8?B?d3lFVTc5aUM4T2xEd2ZFeTZGMnpLdDdWMnlSN1lwYmtyN3NBcWJXU3VCYmVz?=
 =?utf-8?B?K0JOVEllc1dBZFRxZVpxNUpsWFlkd05lL2UvczRlMHZtS2RrOHlEcUF4RTJr?=
 =?utf-8?B?UlJhdXphTE90a1ZmaDMva2dqUit6dmZkNS9mdlY5dUVQVUFCdVlhUXFKVWVr?=
 =?utf-8?B?djgrVHU1T0VzKzB0Zk15bWoxeG91c21HS1BNa0U1bTF2MUpJaEIzeWZ6RHJI?=
 =?utf-8?B?cDlvNzlGakJuRVhWUExKV3h0Y0M0MGRiR2NiVDkwUXVlbDY5UkVPUnZzNFEw?=
 =?utf-8?B?SG93WHl2WWJjdFVweEtRZDlRYXBMUitWRlJpRWlVUTBzMkc2UkZjbHFWUEFY?=
 =?utf-8?B?OUdIZWhVQW5adXZuRUZTbFIwM01zcEMxNEc1TXpDYVA4UUhkRXZLakpzZHB5?=
 =?utf-8?B?OE53TTBabk12Q3pFeVVuMzQ0RkFhNkJaajdtWGt4Q1ZkekUyb2lWQU92OXBC?=
 =?utf-8?B?UGxaQ2lneVgvU3ltcWFsVGJXTS91S3daUjdsajUxOUFQemVRT1V0L2NHa0gx?=
 =?utf-8?B?ajFVSzZ1eVloLzNsRk9BRlhuYWRlYis4UmswSWU4QjhyWndxOS9kVmFBbkZ4?=
 =?utf-8?B?SXFrQnl4VkY3NG4yWEtLc1BobGx3bkVlZWJjNjBzRG90MjloQ2xnbURlVndz?=
 =?utf-8?B?NFNrSWMxTGxYbnAyQStZY3VvemI3dk9EUmJ4NzR5TkEzSHR1U1VuS05EMGhY?=
 =?utf-8?B?OXJyOG50aHpLZUlZT1hDSjBIOHRzSTQwM0RZdFl5N2FPMG5hdUp0VmZZZ3ZC?=
 =?utf-8?B?Wmt0UzhYYXhCV3hUbmRKbVEreXQwNnJMNUlTa0xTV00xL0FIMm9WUUJybmkr?=
 =?utf-8?B?UTl5VmUzcXVXaTZ2UUJJZG9SSVRLT0ZBKzdlSUNxWTRTSm9rZ25SaUp6SUxk?=
 =?utf-8?B?NEpMQUVKZVFoYU9mM1FCWUJJeGpiWVgxd2lFRnZDMVVjRmZmLzdlRUJzU09P?=
 =?utf-8?B?WVNsTFZxaE1RSHhld253blBaam1Id0R5ckF6YUNiaE82N2VQcnI1Y1VFSjlY?=
 =?utf-8?B?b0F3NDJCSElERVJUQUJOZEszdDZMMjRrdStnTkFkMEZjUFZSR1B1bkRwYjF5?=
 =?utf-8?B?Z1k1eEhMaDlneHNWN1hqRXljbTUwbHVrVWdYdnhlblVJbWRNbEdRS1dOcXp6?=
 =?utf-8?B?TU1mbXhCTWp1ekprdmlNMmd4QXF0R3RqZTRnYm10S2NTN1kwcGJjNktycFJn?=
 =?utf-8?B?bmNMNVRscEhsVDVsZFlRZUx0bnBPd1hOQjZ0NXdpU1YyQ0VVejlSc2FPSXFG?=
 =?utf-8?B?MGY5ZTBJclc4TGo4UU0zVG9WdzFUU3BKQ0crZFJ4STVTZ05OQjYyMEpRQWtx?=
 =?utf-8?B?ZkdnOU1iZ2hOSkVNVHNVNmFpcWFiRTQxTjh6OUU3VGZhay9KWjlRSlN1Y2Fm?=
 =?utf-8?B?L3VPM0hiMFBOUjY4SitSSWlCUlhqdm1qM3F5STUvVE1lY2UzUHg3Wm9GWU41?=
 =?utf-8?B?a3N2Q1p4NStRMWpRN3kxa3R4eXVSYm1CZmQrbWUwTVZKbTVhN2VUWE5aVTZW?=
 =?utf-8?B?Nm9CemFNUmJIbWJlY2cyUFdhUFRTek1JT1JGME16SDNNT2VWVE9JNXQvT0FU?=
 =?utf-8?B?Wm1JQU9HcDRnMkxaM2ExNTA2OFczU0tCbHN0N08wcVE5UWV1Snp4U3NXUEF6?=
 =?utf-8?B?OWd6NzFTak1uT05zUXp6Y3ZUYkJ1ZU8vSEtVbC9WVDlSSEowTlBQdHZIT3Fz?=
 =?utf-8?B?TWpIRmxjWDBGSGF0R1oxaTdoMVhmZHR4NjJCa24xd2d1WkpjdmxNUWVLclhs?=
 =?utf-8?B?dDlaUVFzYzRMRFFRVUZsZE83d3BiVkJ6WEh6bm5ESU5jSllxYmcrU3IxZi9s?=
 =?utf-8?B?UW53TFFQVUx3R0hDSGd2d1lHMWExdGUyZU83RFl2NUxNN3BrM0JLZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c15b9d-03ec-401e-b4a3-08d99d125018
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 08:33:42.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otHst26O8YIvQVIr1vzZQFBI0OJgN1hsgyLsghRnQrlixXmc0ynlXS0hvsO89EtJwyZL58wa/C+TvI76MQkjQvKKrGNSwcwmO4vFXj+6di4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4672
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.10.21 19:07, René Scharfe wrote:
> If the string "key" we found in the output of ssh-keygen happens to be
> located at the very end of the line, then going four characters further
> leaves us beyond the end of the string.  Explicitly search for the
> space after "key" to handle a missing one gracefully.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> This code was added after v2.33.0.
> 
>  gpg-interface.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 62d340e78a..3838536f0a 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -409,9 +409,9 @@ static void parse_ssh_output(struct signature_check *sigc)
>  		goto cleanup;
>  	}
> 
> -	key = strstr(line, "key");
> +	key = strstr(line, "key ");
>  	if (key) {
> -		sigc->fingerprint = xstrdup(strstr(line, "key") + 4);
> +		sigc->fingerprint = xstrdup(strstr(line, "key ") + 4);
>  		sigc->key = xstrdup(sigc->fingerprint);
>  	} else {
>  		/*
> --
> 2.33.1
> 

Thanks. This is obviously correct.
