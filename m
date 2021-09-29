Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE02C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 08:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB5F613C8
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 08:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbhI2IO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 04:14:29 -0400
Received: from mail-am6eur05on2083.outbound.protection.outlook.com ([40.107.22.83]:64353
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243282AbhI2IO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 04:14:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyWj5+5PWhzFb6PllS53VwynXfdF2o5nLezNLJ0pVo6irEE4qxbhBd/Mche6BPzj1CU1cpAhIVCHXIjvmfDqdN8OT6z52RiDlriPHOSUts2hFcKiTPVwOUDJR5ROI4tdT/CTkwZRamS7VfmFH3JL32LzqOVXmoeRBEF+Dweh0PwankFN2Rl/+YuQIXl64el91JfrplKTrcrecpy/wYNn1ve7YuXnxxDSF8cpxda4z8MUH+70rnXRobAxYJm8bzIk+8NWRB2yQePGWPmV9vdfgu6ssrVvRBiWRGt+BICwVgr//ALv1tB7cCkQWuRvKeKZT9TzYjpUDNYjlCUjA+XR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=k4fA87HursWoOpr1UdRTMWg8UIEBJ7U26fg+g9GKDhA=;
 b=E7XdY3whGopWg6dJeZcihlTfjKiC22U9zGZtmJQ+Vcqdcs8XY5ln+talYlu7nABCwdvNBmmrzEK6rEHobksqt05zttUXLDb9EiRpO5LuP3YduOQ9HQZL7/j38+FbnbK/G+K62ZXK9R62lXXMGXk855vgMyHyVnbwfv9d3Nka7LBOlmH4RgGmgYGHX8hVLaoLsKzaAFoTyrOlDN0YdKlekg0CupGAmasG8ac+dHMrt0Dqws6FNe1vaV3PviXm/qVEu9/RKfrsFqzEu4aXd5+QuNKBhvdqWHCFfFYaNwrw72LgYK2V/1uyWD4t3W4nN+IzZCve/qwGnHgMJCywtLyGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4fA87HursWoOpr1UdRTMWg8UIEBJ7U26fg+g9GKDhA=;
 b=Cnw76bUC7v/V+gjB0Py0nlJ9snlo6K0qRnAmaJW3kXuf0jhg2lf4V+VHxBUATyjkrQHfzH3WknhPL5tzzZPbK6PZylF7RClsRp9y23ERGR7sP0+SMJPxS3Ls3bM+iCRvS3ZjSGmONNyw/3cGblIHD2A2J7d59jxaKNTnmjqrw58=
Authentication-Results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4528.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 08:12:46 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 08:12:46 +0000
Message-ID: <fd244131-84d4-7152-c88c-45f9ada6b609@gigacodes.de>
Date:   Wed, 29 Sep 2021 10:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8rzhmsi7.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <xmqq8rzhmsi7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0201.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::8) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:4db6:1dfa:2076:87b5] (2003:ea:5820:600:4db6:1dfa:2076:87b5) by AM0PR02CA0201.eurprd02.prod.outlook.com (2603:10a6:20b:28f::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Wed, 29 Sep 2021 08:12:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9f239d7-97ca-4533-39c0-08d98320eb45
X-MS-TrafficTypeDiagnostic: PA4PR10MB4528:
X-Microsoft-Antispam-PRVS: <PA4PR10MB45284C3499EB703A17BE2AE5B6A99@PA4PR10MB4528.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbt1JJeGn7dwAchSERxQ4xnY+krBisqUFSM19p+fw1xIgyEBNxnuTgO2Iq8YaMj0y9AIkY9G6pPpIIshwE3WX7BWepWUcsa5OhYn7cl7mtByzb7Y5PFO1bfLEQQL9UwI20EzVytWE7ehkbZV5pCheN2GzphnhikUEJDrUtfMGn5CnsAyxNqIY5wXzkqBhE/qmM4V+c43Todx9jmvHt05cMSEKpLKxfprucZAMxV5vPcLAAv3AfKRi66XF/nasza3aa8etRwpRyPehu3y84rS5uJd6bg7bFLb/zXKQdZT1zQlKZr5oegyzt9XkD4kaNJPYe7CmlWlyqZk7kjBuY9bnsRTs816+7NAsHHSDsJMP1R2NXdU3m2hpzgkP+x7i3qVcLfBhaiLdcVNUTA5Fn3SJSounUUNBWqv3Qjrc1aCzvkvay8UZy82BIo5X47lUe/93ZCp7C4wQhG/qIk+MGIbkQ4gJBGwDhDbmKQ9FlQP5NEra8peXcHUnCqV3gvrkJCw7LF1dCXSaC5M0QL6iZow9cIL1+YuoYneI8ckwkPmQUJCp0Zb+wAyEPF1h+ukpm7g8se8WI3N5WG5yE99DpcLASKRW9dKIE9B4J2j4bitQExwrfQ8gyJqyMD9wHQS5zM65X0PRN/qQxhX1LBBcMUGQTJ1+1KbNC8UWjcCHGfJhYmsMLiCz6C/DwUTDlN8q3aggaVdTmMv0nNuk4nUpAYuuoQ++RqH96wQLLQdJ8jKSIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(39840400004)(136003)(186003)(508600001)(52116002)(83380400001)(38100700002)(8676002)(5660300002)(2616005)(31686004)(86362001)(66556008)(66476007)(66946007)(8936002)(6486002)(316002)(6666004)(31696002)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzhxcndWL1F6LytzbXdKa1drTitxT2hIbXZtMkdGYkVlWk85TXpkenhXK0s2?=
 =?utf-8?B?UUUvVHZnZlRaUUd6RXEzbU13WjZnUFdHYnJVQ2pQZ3VSdTFFTlV4dDBrbHpa?=
 =?utf-8?B?RlpUUWhmb3luS1FNdlgwVVdTcEU5M25HZVFOamRkUE54cXd4VXM3bEtWMVhx?=
 =?utf-8?B?SlpMZmhwOTJaUzM5bUptUFhuaXhnQWFKYVZSeGdxQ1pKcGdjNU5CdEU2N3NF?=
 =?utf-8?B?aG1zc3diVUpFNHJYSjZNTjNvRFdGUmdaOFpUVTJkbTk1cDkwZHpqbDJieWRS?=
 =?utf-8?B?VGFZRHRxL0UxZGE4SGFZR09RMHYxWDhxcWNoUUJRU1k0K3BmL2pGTzhZdStm?=
 =?utf-8?B?bEdMNUNiTEhOUG45b0tId3RiWFlZODlLTEMrZzVFUlFUMVpTU3hRa2xSazJl?=
 =?utf-8?B?dmVIaXVZcU9rZ1krS1ZYbnJ2dkZ1dUhIVW1IRUM1SUYzUnFIRXZ3YjBsMFJW?=
 =?utf-8?B?ekNoVUhvVXl1OXJKT0JvQTVxS2Vyb3Zxam5xWXhHZWNkTDdpQXFjZy85WU1H?=
 =?utf-8?B?UzZDSzllbTRiT3dtTzhsUWhPS0xRUEhJZ2tLbHlvWDcxSVExVit6eTBKOVdj?=
 =?utf-8?B?ZnpYVUVhRnpPQzFtM3JRS1hPZzloaldsdG8xeDhxY2RHcm9oTEsvUG04Y3h3?=
 =?utf-8?B?L1hod1A1bHV0TTNiaU9TbFBhSFNvRzNHdFRHSnpOT0gvU1hxd2dVWWdDd3dT?=
 =?utf-8?B?UG9TREV5ek9kM3BrWU9Lb0Z2WldrT29pNXpCNVAyc2pzb3ZXTVdjSEtNYzNN?=
 =?utf-8?B?M0xGbFFVaXMvbldaclJTTitWODFUMnc3QnM0M3ppWVhSYTdRRHVBYTlZNzJi?=
 =?utf-8?B?VmMrR3hJZVZVWlUvSW13RDRPQ01Yb3JYSTV6ZlFNYzU1S1V1bytDMlhYOWk5?=
 =?utf-8?B?eDZDUW92bW5oeGF1aEN5LytzenJrQkZHOHdoeitXVUpJZ2N3ZmFvTDhxcFFx?=
 =?utf-8?B?V1ZMZWVZQ1ZPNVUyNUswK2RzY2xWQUovMjVsZ3M5RXdSclNuSjQwT2tSODhW?=
 =?utf-8?B?QmNtVER3L3F5c2gzV0REVmlqaWpqUzJJajJJRWF2L2tuVkVIOGVKSE5SQUdh?=
 =?utf-8?B?WG5GQUZiVHlvRkFXVWowQ1h6TjNzN241b2RaSTIyNU5iVlJFbVN3dUtSOWZl?=
 =?utf-8?B?NlVPRFpRL2orNGM3R3BEcUo4cjBGQXU5dHhhUjVGYmo0RlovbTRHQTlZQ24w?=
 =?utf-8?B?V0N3MTREbFVTeHBGRFpNeFhyWEFWM2tSZXVzS3lkUVVMTUdOZHZTSUtqUnc2?=
 =?utf-8?B?dnFFM1JpbHdkZWNzaXA5dzZqcEhXalZuRlpFd3BoRStCeEtGbTVuUUFPOXZL?=
 =?utf-8?B?cE1vOC83ZXluTEhRTWpvSEhPRGJxbjJWL3FqZHpXYUVFMXhwMTA0ejJqWFo0?=
 =?utf-8?B?SjRSa1Q1cWJsT0paYkhrbFRKWHArUDVWYU1WaDR0MG8wQmU5dkFMS1R4eG94?=
 =?utf-8?B?VnRJeDRIUVcvVFNWaU4xVTJ3b3dvWUZZazd0L0RJV1VETmxVd3ZhTDhpY01Z?=
 =?utf-8?B?SVN5OUR0UXFlc00rc0xvVVNWQUNLdXppMEhKTmFJdjF4WXZSQTVNd2RIMmpL?=
 =?utf-8?B?VGIwT1NqY1VHTkNUQ2ZtZVB0bjNTc2NrelQ3QzJzWWlpZDBzYlpmK3U1R0Jm?=
 =?utf-8?B?Zk5WRlVlTTh5clFMWlg3VW42NHRXQjJZeTlhZXAwNWtFTnA4REVDNGNZRWY0?=
 =?utf-8?B?aDNlSjhxOEZQTFlicFQxdVVFUkJPWlh4cFd3VDI5VXhQZUFKZnNNam9aT0gz?=
 =?utf-8?B?cWFCOE5nUURjV2RUSlFyY29ESDNqWGtVMkpVdjl6d0hyUzlQWTAwaHRwenNl?=
 =?utf-8?B?dzFtUk50dVFtU1kzTWZvZ2ZyMng2am5hK05KdDZKWG9jcHppd05SWXVpTUZO?=
 =?utf-8?Q?WdonY1TZCqasz?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f239d7-97ca-4533-39c0-08d98320eb45
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 08:12:46.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8uY9N4d1xV6S20C/22HNDCT7fBOvR6DRplVn4G0N7oDdJPRH0T0IH9YR5kKTlGHiDd90BqlrxM1t1aTwmsz0f2KHOxyfLwlCHnSWciuuX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4528
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28.09.21 02:52, Junio C Hamano wrote > * fs/ssh-signing (2021-09-10)
9 commits
>  - ssh signing: test that gpg fails for unknown keys
>  - ssh signing: tests for logs, tags & push certs
>  - ssh signing: duplicate t7510 tests for commits
>  - ssh signing: verify signatures using ssh-keygen
>  - ssh signing: provide a textual signing_key_id
>  - ssh signing: retrieve a default key from ssh-agent
>  - ssh signing: add ssh key format and signing code
>  - ssh signing: add test prereqs
>  - ssh signing: preliminary refactoring and clean-up
> 
>  Use ssh public crypto for object and push-cert signing.
> 
>  On hold.
>  cf. <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
>  cf. <532d97e7-8c91-df6a-6d90-70668256f513@gigacodes.de>
> 
>
Openssh 8.8 has been released a few days ago and includes the needed fix
for the find-principal segfault.
I ran the full git testsuite against it without issues.

Also, we (~30developers) have been running this patch with
openssh-portable (2d678c5e3bdc2f5c99f7af5122e9d054925d560d / post 8.7 -
pre 8.8) in our organization for the last 2 weeks without problems.

The only issues we saw with our users are related to some misleading
openssh error messages.
For example if you configure a public key and the private key is not
available via the ssh-agent the error message is: "invalid format".
Or if the public key contains a typo (forgot a char in copy&pase) it
will error with "no such file or directory".
I will need to dig a bit deeper into openssh to see if we can make these
more specific without breaking any compatibility. Both errors originate
from some lower level lib functions which i don't want to change.

But vverall i think this is ready for some broader usage/testing via next.

I'd suggest to send the additional patches for valid-before/after
functionality in a new patchset for review after.

Best regards,
Fabian
