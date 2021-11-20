Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FF7C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 11:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbhKTLVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 06:21:49 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:60535
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231252AbhKTLVt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 06:21:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQNHT/fOF7MhKmOl3/TA6/kSpfrwQNX7ZHKro/FZrm5VqO5Ka3xcmqWjW2FyinWZS2PRUxH8FZcvNN1j8gILX1tbr8exTozkvORwE75dJzlb0FINsETr3hc1HO2k+Cv1PS9cayQaPyYCj5gPq4QNlAH3BDEucRGtCfpfanzwpnl2LfZ5wrRM9FOxSzwCba2fHTjxYfDRD+U4BOn602nuVBeUKoj83kdEG1cj9wn1FnlwyZlDkkY2Ot6PXa5nzks70PgqCoezMQyvrki2VmJgUL8GiDSwWczh8yxnjbWMghEhKD2N/BFm+4SZdVKDkXFg3BGBo8sfvbu8+IdtgAUTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY0o/SCSazH3Vk4rU6RbsQ4OeQdvn79aUmhJXoQzG1k=;
 b=Aw4FICE+FqDJgGYQUqu5hmGxTsGN0Lxi1Q1YpWrYDT/KYtThpWtWUTbbrQj8G3uaIbeDsXb/6jxkY8dyiVPTwbyrIS2x5l7QVonPwptZGAvLI91pG0UDHV2N+I1FSRyaRg4e/RzQSSNvUYV1GF3oFph7xdpwwBnWAepcW44UUjp4Xb0AHtaP78U8Ts2wSB/T5iGhGyF7dmZ6FaesIhALZpmNKwrWXHjg8fUu3xdNbyXXQdFHDJ9hNUD+lyiigDxr9h1XbjWoa2FNvnbIuAr0U3ZDGd7ydj8SfgZXuXG4CJV9mCERjSJFTh/Ws+gYkkBpvLxjpCrGh/TzjQmhoP8zOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY0o/SCSazH3Vk4rU6RbsQ4OeQdvn79aUmhJXoQzG1k=;
 b=Jz3uvdNLPprIK8zdSxl+16OFDDYQKnUPENlYCdvXctEOHyTXkJAbf+dmqiefkw+sS7f2ZuNOkQwUndNR0f1u1CquQzbrWLc6MRwjvFr/i1pOIZiCWm2tsXN0n/gk+qxVos0ZGXQPSHprYcSJnXpMmucPSamx+CFypTtN5iumgp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4334.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Sat, 20 Nov
 2021 11:18:43 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.024; Sat, 20 Nov 2021
 11:18:43 +0000
Date:   Sat, 20 Nov 2021 12:18:42 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2021, #05; Fri, 19)
Message-ID: <20211120111842.mrryee6kvffhpegs@fs>
References: <xmqqa6hznvz1.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqa6hznvz1.fsf@gitster.g>
X-ClientProxiedBy: AM6P195CA0069.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::46) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM6P195CA0069.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Sat, 20 Nov 2021 11:18:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41e426e3-d21b-48bc-e9f5-08d9ac178316
X-MS-TrafficTypeDiagnostic: PA4PR10MB4334:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4334C39B71FF87B0720304EBB69D9@PA4PR10MB4334.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gmdlXwA40ed7AaB7yYJdtQHqa7CikhcMnp0FnAmX3E/TkfA/lvJBLm6sgZMubQdV7YCscryCKlKl/CnlTFRn4e1n7PhE2aOFKEdyUC5TvQAd78K2+q0pnRGCq3uSXNpAP/GVZr9TbSx38j+dCV5OvFFeFNMByvTg+n7eTiOdg6ODQ/rKuuLuwRIB7mEJwQaeNdOq/NGxB4kupIvHUr72RW/aQxvFi6P9zFewGBatej0M+e0yedTVQXrh/mst/xihBnb0tdQ63/wgQDbJEZH5FrFiP+qvlZM/HuWuVZLmWu68PohI1HGZjoP02DlckjWujPBQ7ZbdAi7y9eTQ/FdGJMi2P7EBvA4EA8dYGBw++tV9u+qeUfYmcB/ujK8TFcqYsxWLCFISUmbFPUeigM1eDKCsqGUyCecWOlBTIDxPx1+gwswJ00F3weig/LQuQHPPM9pIj275IiGYd6BPGsgSssspPD8NwGTroWN7AqxWyuuBd6l0TlYZ0ey0ZW+dNoaVUGID5rijvt1vRQRdEwkJuOXaPkrGL6rdRDCAjGc6HVwKrg3K+QuqH7ocw8PORxzwwz/qqR9kB7miThL+qL0RGoMSNuJDkWWkDsgnmHjsLmgcd0Wc3UJgNtEmUpbU+j+ow/uLuxSfiezP7t28f0Z3Ucr3moLzIqIfKm/GZTH5D/BPo5KsFM+HbRcCYY5WJTrstOsIIr0N1CtJD7zBixsha0zsEBey9xVCmD4OQ8rELw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39840400004)(346002)(396003)(376002)(366004)(136003)(966005)(52116002)(6916009)(316002)(33716001)(8936002)(508600001)(4326008)(66556008)(4001150100001)(6486002)(53546011)(83380400001)(66476007)(1076003)(6496006)(5660300002)(2906002)(66946007)(86362001)(9686003)(8676002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y05nL1RVK29wcXBTT2grOWZ6WHpuRGFrVlRvcVg2cm5McTFKbDR3RDJrUGVv?=
 =?utf-8?B?SkVPc242eVFkM01wMmVJN1ErQkhGRWRMbUMxbk5sdmdWWkozcjBGNzFaZUxX?=
 =?utf-8?B?WEs3Qjl5N0hmMDJ1NEhoL1Q3WXFyYlNSMC91RUNCT0VISUV6SXY5eGlOKzM4?=
 =?utf-8?B?eVY2dVJ1NmJCT3F5eXJwNEdBSm9TY3hiOXlPVDdFRE5yUUpBSFVEVGt6ZFRi?=
 =?utf-8?B?b1RjNXFPRDZBK2lRdml3bkZDbFE1emNpcnR6MXBwNDFKTG0rVVZicHRuclRm?=
 =?utf-8?B?YzR1V0lZanVXMkxnUHlrbERWRmRzYW15V2pUYUVvMUFER0diSEJsRVNsNlIx?=
 =?utf-8?B?Yy9IL0pRU1FHTFFTcngvVFowanJiV1FUb3g4dW1RckFzdEw5RVFFOE1oZE15?=
 =?utf-8?B?Wk5udllCelNtRHdHZUEvZmMxaGh1anN5TVV0YUVvTTZlcHowRzJWc0dFMUNq?=
 =?utf-8?B?cHR4ODlUYTBIc3FURGYyQU9RUHFaYzlRanlWeUpLMmpaSGg0dS9pZkJwZy8r?=
 =?utf-8?B?cnZVK2VOWnlQWEZQZzJLYUNJOHM5bGFOWEM2NC90U0s4MGYyUHd0d2VwTXli?=
 =?utf-8?B?L3ErMEZiT2RZZlR5YzR2eG1FOHJoUk05ZHZLM1hkRmRxQnFaaUhPMUhWTWlE?=
 =?utf-8?B?Mi9sWmFvQ2d3Q1QrZUZET2wwK0gzeDh3Y0JmcGNiQXVlRjEwYzJPaGRhM2hL?=
 =?utf-8?B?KzJ1ZDkvdlVYSlgwT3NQL3FDSytnMlViZXMzMEZxdFRLTW9kVFQxUTRLaS8w?=
 =?utf-8?B?TzdTVVJ1eklmdmExMHd0d0pqdlJmVENvUzkySHh0TTltOGFEc3E2blMzNUdq?=
 =?utf-8?B?VDRWRVVCd0daaWhpa2RzaEtDS2o2N3ZUOW1Ed2M0RmhVYXd4a25UeUxEUWlY?=
 =?utf-8?B?QjRmTWVENStOV1F6NlRodmljMWJrTWxERlZ2bjg1RWNWNkZxK2pjdGRvUXJC?=
 =?utf-8?B?anFwNGFxdUZyUUs3S05EUEZydXlMTXBIWXpIUkppQjlObzNvdC9rUDBGbllX?=
 =?utf-8?B?R0JnQUJtTE5lRmFzRXczWW1uRnVhMlpsNjlkR1V2bXZvNEtDaVg2RU1lenpL?=
 =?utf-8?B?b2t6b0xscVRIbmt2Yk4xbU1yaVBwbTBDWjBwcVhVZzdNWWd2NHpvandrVTVB?=
 =?utf-8?B?Y3VROTBZSVAyZ2dYUGVhNjJmVlVYaUMvNWZPNXlrTHRxbHJ5bTNwOGtIMW1i?=
 =?utf-8?B?a1d3WmNXbHNUYTdGdHhhcjdEZDh6THFGWXdLZzVDRWhjVHpUUVNxeVhVVzlW?=
 =?utf-8?B?WDVXQmpuVFkwNzNNbFl2S2xXS3dBL1lXT3hFUWg2SUpkSWlrdU1HdTRnMGh3?=
 =?utf-8?B?cUE3c1JKWUtHOU1lVXZNakhkY3BsNlJ5ckF2ajRRMlcxMEhVd0FuTkV4RFdZ?=
 =?utf-8?B?N1IxQmJybGtEZDdOWjQxL1RFenpsd3FGOWU0YjR1Z1A2bEwwZjRpVGF2Qk92?=
 =?utf-8?B?NGFyZkxZSDZTUjFBV2hrak5VblFZWHFIeWljUWdRaWwyRTJJRkxvbmZhb1hp?=
 =?utf-8?B?V3hHVS9VRjl0aEJENG5LYXhubXJYU0c1ZmtmNHByTEd0ZFJyUTNOWnFYcTJ2?=
 =?utf-8?B?WjVVandjRE9rLzBuY1dhMWtJQXE2SzhvUW16QVRiRXpBWUowOXl3QVFGVTZ1?=
 =?utf-8?B?V1dwUjdVN1d1T3U0VGNjRGJPNE1mRmI5WlF5UE9RMy9EWlMzK0lXVlpCQTlM?=
 =?utf-8?B?M1FqaUhkb3cwVlZ4dFhXUkRzUmV3WlAvSno4R1B6YXVUdFhjNzFqWWhCbXRZ?=
 =?utf-8?B?VGNCaWdKRzFFcmxDZmZ6cXFHRWladHlrQXdQQzdqT3FTd20xMTVkeW5abm5p?=
 =?utf-8?B?V0dZcHJjQ3RpbldEOUtidWlqMDR6bXBmMVh1dzVZVkdwQkpQOE13YS9KZzN4?=
 =?utf-8?B?RE9BNHFvVUdHREJxNVN5QUE5dVRES3FyUE5CRDMwT043THk5cWVFYjVJSi8v?=
 =?utf-8?B?Sll3cTloci9uTjdWbjNDS3hyQ24wQTBFQVBKWEVGMUlFeHhSUlJCRUk4WTFI?=
 =?utf-8?B?bTZ4R0FXcDZ6eGFneStwUGg4Qm9CUXhXNTlKOUxOK2VlZXlFZi9yVXdwS0Zk?=
 =?utf-8?B?VHBhMUd1WnI2RlVXd2RQcWtobFBHNm9UY2VuYjNTMWFQUmNuY2lpc1Naak9v?=
 =?utf-8?B?MGNiZ3c4Q2ZYeVl4UmN0U0theC9WT1o2L2dlaXhoK3FObzFQb2VRejB5cGJz?=
 =?utf-8?B?eHRmSzlKMHp3dzV1WUhxTGV2MEFUQlNZN3ZLMW1rZzZDWUpWYW9IRW1TMzZZ?=
 =?utf-8?B?MWhsZnNuS2lPdlB3MjMzMDNhTHVFciszckhhcUgxZENKT1QrbXBHS3NtaWJB?=
 =?utf-8?B?NERWQU1hR2JqcE44a1Z3WUZhcDI4akhBaXZXdTRFYW5Pb3BpMHpyQT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e426e3-d21b-48bc-e9f5-08d9ac178316
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2021 11:18:43.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S36qyHxojM+cdn2Vff4RoB57O4ne/5VZwIS13qO3Kt936luHuskJ52lasTD7Vy4PFWz3V3Xgl/QMDi3KSEI7CEg+zvveQwdw496IqMfmZTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4334
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.11.2021 23:10, Junio C Hamano wrote:
>
>* fs/ssh-signing-other-keytypes (2021-11-19) 2 commits
> - ssh signing: make sign/amend test more resilient
> - ssh signing: support non ssh-* keytypes
>
>
>* fs/ssh-signing-key-lifetime (2021-11-18) 10 commits
> - ssh signing: verify ssh-keygen in test prereq
> - ssh signing: make fmt-merge-msg consider key lifetime
> - ssh signing: make verify-tag consider key lifetime
> - ssh signing: make git log verify key lifetime
> - ssh signing: make verify-commit consider key lifetime
> - ssh signing: add key lifetime test prereqs
> - ssh signing: use sigc struct to pass payload
> - Merge branch 'ad/ssh-signing-testfix' into fs/ssh-signing-key-lifetime
> - Merge branch 'fs/ssh-signing-fix' into fs/ssh-signing-key-lifetime
> - Merge branch 'fs/ssh-signing' into fs/ssh-signing-key-lifetime
>
> Extend the signing of objects with SSH keys and learn to pay
> attention to the key validity time range when verifying.
>
> Will merge to 'next'?
>

I have some cleanup / code style changes for the ssh siginig test prereq
code like you suggested in
https://lore.kernel.org/git/xmqqfsrssmar.fsf@gitster.g/ that would
conflict between these two series. Depending on which lands first or if
the keytpye fix goes into `maint` I could apply it to either one and
rebase the other. Or since it's just style changes I can attach it to
some future ssh signing series. I don't mind either way. Otherwise I
think this is ready for `next`.

