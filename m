Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D442EC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 09:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhLPJEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 04:04:25 -0500
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:9028
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232643AbhLPJEY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 04:04:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFfzP3qLei2LzBGjxVOXS/MjUxVhhUZDoOy94bWR00X70wJmiR+8mxehAYQGq6qKAhxP6hGU0+CWQjQm0P/mPDKCBlmzTbXPTylvYlUpMhZEEA+XauxnqSeUZopEZCVFyp9YC3oRCZenY13uX+NnqZ82r78763N/a6GDuOvR7wE/ctM8EPXuQqk3pYGmH2DZhDNIjVXLIosqcvXcKvoXJJywC668sZtKVTr5YqkQfH2nmdPWC6w2zrJ44DLIKVpWMehmtgiFjA5eRfDGuI3WdY/w6T7op3zcc8UC3zkJbDyIgtdBqC+ym9Nro8HewkjonDFpR/JolzKb/VdtHNL+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9e0M+LErw41C9VG1iZ9m5AFc6KVaWRwbbjA2aTFNJpU=;
 b=jAqo5Up347j+1uJbtjM/fTwIJNEZY44sgL339tegTb56SqhNo9kajw6cN1anVf72xbS5eVp3MZtGA7KcBLqj9tKKaBUDHodbnUxFpFUrOyBULeV1t0rbX4ejM9NY5dB4Kwv9xvvzvCl76z63/UyDRxcwh3KCXQVDTLIYTFU9kAGQsHuUhOohVukpOR4l4AW6r5YJCRZ4SsFfXEFNDas8xNCm6iY0E56DNUO4ybkC88lp49rHvaVT/zvylWR8v5TSIevDmqhBUvq1UmgGcf/SqBk2MfpwdxDfs1+Q7aYmMuy+drGrzb7oDD5xoyODzpLvWnLcGJPxCtLGMpooIGVSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e0M+LErw41C9VG1iZ9m5AFc6KVaWRwbbjA2aTFNJpU=;
 b=Yge8Svz/gzsLdSbKk50cWSFM/h2xCQVNdSsnFQHS2Zxqtzc2mgNYF7knyI8XceT0M59UFfWcdZaiHHKT08emodT/D+M6bLzpRZfc0AGLr81r2EAathIE9W8LpQWthN8Zf8MbFq7DwE9gqbAzssgPff67DdEZsg3kVB6dVc0iVkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 16 Dec
 2021 09:04:22 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%4]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 09:04:22 +0000
Date:   Thu, 16 Dec 2021 10:04:21 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/config: mark ssh allowedSigners example as literal
Message-ID: <20211216090421.ckkuurql5dn2myux@fs>
References: <YboWlOG3vZD/7Osx@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YboWlOG3vZD/7Osx@coredump.intra.peff.net>
X-ClientProxiedBy: AM6P191CA0049.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::26) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da89c63d-e99b-42d0-ddd1-08d9c0730cda
X-MS-TrafficTypeDiagnostic: PAXPR10MB4815:
X-Microsoft-Antispam-PRVS: <PAXPR10MB481589B97082A2710CADB946B6779@PAXPR10MB4815.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxAqHPlV5mAFclBfE5Cfhng+BhgoSwUlGLR5mEYMFqeWJ5VkvVuudqdZljviRFoC+1lIxvWT5RJRP/M4ZJJR602I8E3AbkOv5BDfpKzSqmA9RJwyMsysXt8a4T14zdMcl8FfgM+s8cgxUoRVmpEK9nqweEf67MNZonvAZLJ/sUXLpmF4nQvgxT8xx4R5tdi2+95gzAjARa9pGR1sONHs5FJr/BqCSSwYoN33+7NdNQQc64gxOHSLzSXDyW9iWp+edDM/Wm5Kjnme5EjUy6vPPNwBt0bUGDglxrw3Du+coy4gFHNbOacW8aZYcBFW/vET/DOdfRWrDJCRq2trbpeSc0VpFktA77ZZTg06T4QBiHaLNy9YGOmXfXbYk956JqIdaVnLZqFzdKq8C6L11bc84WU0eFG2wxWNO9l3d2293trII4CtP47LUr9wQ514xJT0tfBLz+0iPk3Tzaz4dQftkodyTZBSvn6DWj/2OFU5aswlTvPJXF3zxqV1tdQUWAqSh3CxgRPS/9xJMrXEYKiUtTc5kZtZ6qEJ9ZVtK1QoPcRWzsy+mZXJ5FGs9acBE2hq+FGbVKHec9zHNdVpFGJqHyFhi56Zgd/fJZbnggehzc10BbzxpXAHpWESNDXKLwFauVbeWM5Cmtq7Ybd4EBwl6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(39840400004)(136003)(366004)(346002)(376002)(38100700002)(53546011)(6486002)(66476007)(6506007)(66946007)(4326008)(6512007)(5660300002)(8676002)(2906002)(66556008)(186003)(1076003)(33716001)(508600001)(316002)(6916009)(83380400001)(8936002)(86362001)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U09OK1Y4a1ZVRlFCOWtuRWJ6NS9mTGhyZjdsMmFxQWNYdlpDaEhyUVJ2VzNG?=
 =?utf-8?B?bGo4ZEtuL052NXpCRUdmeU5JZHBteVVQcU1wSFBsUjA1am9sVXRvL2NMNzh2?=
 =?utf-8?B?Z1RuQ3h2SFV0MllzOFdQQmkvNFROREtRWituVzhuRmRldXRIeUh5eHdyTldB?=
 =?utf-8?B?Tks4MmFJRUk1Qk4zUy9weXIwMFhSYmhmcjEza3BUUmJoMlQrNGFxT2E5LzBN?=
 =?utf-8?B?aWJ5RXlnaHR4V3ZUSERKaGJpS1VEOTN1Njk4Z2ZqOUtXOGdtRW14VlBYSHYy?=
 =?utf-8?B?R09WbkFIaSsrTUN6a3BNeTVlVVVCV091MkZvUkpSd2Z4L1lIb3VTNlRSck5B?=
 =?utf-8?B?NzlEcm1BV0luaUJaKy9sKzBmcFV3VStZOWZya2xaekcxdGtwWGVhNDJlUVBJ?=
 =?utf-8?B?c1FkL2xjSUcxOWNJY3JGbFpkbEZLTXdvb3dNS1AxT3cyY0VxY09iKzkzSDNn?=
 =?utf-8?B?S1k4eU5BNTFRSFdGZVplN21pSW5qM2pwWmhWdGh6blJoRnlaaUtQeGRjZ2h2?=
 =?utf-8?B?U2hBQVZnd1NOZFRzdmRGbmNWQWM4cFRqMTcxQmFEc29XNmUwMHFUV3UxNEYr?=
 =?utf-8?B?bkF1Q1hxU2prMzlQVDNzbTBGdDExTFd3ZU9ZWlN0YzQ0YjA3MXhJY3pQL0Iv?=
 =?utf-8?B?cVZhajJuaDQ3Y1ZSNXl3UVZ3S3d4REp4Y3RsN25sMFc2SUFENVc5NFg0cmp6?=
 =?utf-8?B?a3I3aTRLVmRGQzVvcG5hU2pMWmlUTDliOEJXQkdxWG1GMmNyNWt2TGhNVUdC?=
 =?utf-8?B?d0Qza1hYL3JCUWtaMU42SVpyMXZxbDdZOW1xejREL1Q2RHFhTStpYnJ1Q3N3?=
 =?utf-8?B?K05zMDB5Wmg5V3dZQ3U1eng2eWhoSDN2TTAwRUZ3Q3JmczRvckh0MGFSM1dr?=
 =?utf-8?B?NlkxWEZWM013MTFnL0ViczRFTktCRVVRVjFuMVlWRnpZRVYxLzdvTkZrbEE2?=
 =?utf-8?B?a0RoOHJHcERBT2VvUEhLQWJNd2NmWHVRM1FZNkgrOFZQLzhFVWthcDJJdEFI?=
 =?utf-8?B?ZWprai9WQXBJTk81Q1FmbmNjM2tZQTA5VjhQQThVa3dnMCtjanA2ajFOM2FV?=
 =?utf-8?B?VFJYZ1pROUdXM0tBSE1LcVZReGdaSUI4cTlYN0h5dmEyWlVoQW94WmZ1Tmp0?=
 =?utf-8?B?cS8yNGtnTG0weGFyZktiNVpxSC9OUURDQ1EyOVdxRCs2bGIzemxPUkJKZkxm?=
 =?utf-8?B?cmN4K3JTZUdBU1hVQjBSZlRoZitGVmpWRnFRd1VVSmh1aXdpQXg3aGl3cXZr?=
 =?utf-8?B?dlNvRWtxMWdselpyOVJkcVRrMmxwMDBqNk80UEVla1JxL2lwN0ViaFcwOEhj?=
 =?utf-8?B?akNjMExNbXJ0UU4zMDVsSXFoUzdGKzhIRytmeFlCQkVQWmhSRmJ0T1Q0NGRG?=
 =?utf-8?B?cDZpYjRPY0hBdkZQMGxyTGZSTGJnWis4amhtTmlSYmhSclY0M2dXdlloemlp?=
 =?utf-8?B?UE1ISXN0d0s5aWQ0TTVpaW9vdFNRVGxldjhDZmlOOTgxNVROdzNveS9DT2pM?=
 =?utf-8?B?SWtOWDFydVVobzVqSUl2VnlDeGp6aG1xc0lFclZibXVKRS8zUzg3RytsYm5s?=
 =?utf-8?B?b3FPdTBla3o3eVlyclhFWURTbERHRnJBN05IdXArRzROdWlNT2VuMVRBa25j?=
 =?utf-8?B?dTl1TXpybFE4V1Y2MVdyQzc0dG9YV2tENFRIZk4xOVVFcWwzY3ZuRThoalNQ?=
 =?utf-8?B?bTN3MkJDS3dZWW9QekxBV2RxRHJzZXRneGZKaGhmeUVsN3p0RXlWWGtYV3JM?=
 =?utf-8?B?cU9qZEh2bWhid0RSM0d6VnhyU2FGcktheXJyeWI4em8xSjZqM0RaWGFYMzdp?=
 =?utf-8?B?MEZiUm9FeWNXNTgvMS96YWhNZFUyTng1NG42c25objlJVUYyTHQxS1FKUzlP?=
 =?utf-8?B?WHFvNTV2bGJMNlFYTzJ5dk5CT1VXNFRvNkptbHJ0QldzRC8xbFprck1Renlw?=
 =?utf-8?B?aHVjbXhVNWxxc2ExY1JXV2R0UkFsK1hESlBSY0xBQXlWa09kbXV6VkhieEpo?=
 =?utf-8?B?cHJvbWoxdTl0M0hCeHJ4NXd3d1N3Q1QwcFBpdE1oWUtTa0ZGRThOeE0xNjJj?=
 =?utf-8?B?Wms3cEl6dUk2WHNUb0grVDluZWR1cWs2TW1iNm9iZjBBc0FRNkpQL2pvQ3I0?=
 =?utf-8?B?NnM4eHpwSU5oWDJNVkFGMUlPQWxTUjRRRUREcUpZS3N1MGkrTk5zOWY3Z0VX?=
 =?utf-8?B?MFB0bDRjQ0RKNGhTT0xJdy95emVRQmVSMk5scnpiN01hcmxVYkJONnJERGR5?=
 =?utf-8?B?VG9FNUhodllrdU9FZ040YkR6enFYUWJBQ0JYek9YRUVnL0ZoRW1BWkhrS3VP?=
 =?utf-8?B?OUxNN2ZVOEROWHZrVktxTEQ5ZmNCUUZORnUrRldmK05BdkxKaVZEUUdhenNJ?=
 =?utf-8?Q?MIiAY6bltPvzasE4=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: da89c63d-e99b-42d0-ddd1-08d9c0730cda
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 09:04:22.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QsKLnJewmJ4NR9x1IBKfwUnwsjtG/l56cSLwIYqWwdBmmG2xn7oz7jqx3sJJryYRJG0BOgj0iXvwZCreTbc0ajT65ucTNsKL9WeUl1im7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4815
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15.12.2021 11:23, Jeff King wrote:
>The discussion for gpg.ssh.allowedSignersFile shows an example string
>that contains "user1@example.com,user2@example.com". Asciidoc thinks
>these are real email addresses and generates "mailto" footnotes for
>them. This makes the rendered content more confusing, as it has extra
>"[1]" markers:
>
>  The file consists of one or more lines of principals followed by an
>  ssh public key. e.g.: user1@example.com[1],user2@example.com[2]
>  ssh-rsa AAAAX1... See ssh-keygen(1) "ALLOWED SIGNERS" for details.
>
>and also generates pointless notes at the end of the page:
>
>  NOTES
>        1. user1@example.com
>           mailto:user1@example.com
>
>        2. user2@example.com
>           mailto:user2@example.com
>
>We can fix this by putting the example into a backtick literal block.
>That inhibits the mailto generation, and as a bonus typesets the example
>text in a way that sets it off from the regular prose (a tt font for
>html, or bold in the roff manpage).
>
>Signed-off-by: Jeff King <peff@peff.net>
>---
>Possibly this could actually be done in a separate example block, but I
>think this looks OK and fixes the most obvious problem.
>
> Documentation/config/gpg.txt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
>index 4f30c7dbdd..7875f4fccc 100644
>--- a/Documentation/config/gpg.txt
>+++ b/Documentation/config/gpg.txt
>@@ -44,7 +44,7 @@ gpg.ssh.allowedSignersFile::
> 	A file containing ssh public keys which you are willing to trust.
> 	The file consists of one or more lines of principals followed by an ssh
> 	public key.
>-	e.g.: user1@example.com,user2@example.com ssh-rsa AAAAX1...
>+	e.g.: `user1@example.com,user2@example.com ssh-rsa AAAAX1...`
> 	See ssh-keygen(1) "ALLOWED SIGNERS" for details.
> 	The principal is only used to identify the key and is available when
> 	verifying a signature.
>-- 

Thanks, this is obviously good. I don't think for this simple example an 
extra block is not needed unless we want to document the other options the 
allowedSigners file has in the git docs as well. I think it's better to 
reference the ssh-keygen manpage though.
