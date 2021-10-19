Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AFEC433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 08:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5017560EB4
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 08:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhJSITA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 04:19:00 -0400
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:52146
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231758AbhJSIS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 04:18:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/Ejc+6K7OKSKBpRH2MO4iYthyl862NNoQKQKiORXXq4d/C1aj0vNVmEAkZP+Kj6e9cg5Z+lTpYJjLzQBkEuw3DbBoBwX8Y3RsyZyRdOw+Nt0h8UcIg+Kn8obytKvUv3RnlLdIN1TtF8pYKzW8jdE1yjmvoBgaKda/acfZcjGdS5Gc2eLbSeM1rm4tHoHSCLpWi1DxP3XfYIVtGAZAdE4hzfQ2ImZn8/hFakdUDO0o3GUBId5ll899u8xPDpknVv7RH4kent3D+wSVUoEgz7pWFJyzW02DIGZU9WkQtTD5m4wzFK3iuglH89fMI/yxHuGCYpFFpb6HbKQ2LwfMDG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8OCa1Y/RnFnFyngYG9f1UkG2pcvwDoYxPqJC3DB00k=;
 b=gUUOeEVbzvoYwjmMPh7/cjcPJkUi3tOtKWYyHbVr6rYR8xIRe4lSG73sDAWTVfN56QUl039ojEhnmVEudIn9xATW8e2FKkb45/jNGKyMdT+vd3zea/ahfSc1q47bPGym707Dq4rj9IfQkwOeLLbukFgSjFzJnnqJ6ToPYgDuQA3ZHbg0/mX5g5KcpHzqPlY2m9rqKNP1Dtq05Zm9O4o59XKKlVUJCgsyc7OWGranNV/CZjy2YESfo+opIQ8aHVPClrbP8o0gDs4TVB87WbYnE++sNyAv1TkI9R/StqOZg9P/xjzmv9sPTS2t+0A01Y206Xre9ivmRSx1iBAyTkRogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8OCa1Y/RnFnFyngYG9f1UkG2pcvwDoYxPqJC3DB00k=;
 b=bj6qdtQlf92nWtBSj51WfEVdbXArCZ82m45MRFmLx4TCprPgpsLe6LmQ8u9jTBlJBJeTknqe8sJ60KXF44/Y3ZlZ6zWH9tBe4FVMjTI7RMYIkSFJodPnE4FbsUbz8BMYp4K1WOi8eux0iZDvdemWq1Vtqi6MqHfnGFDOEyMORPI=
Authentication-Results: peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4526.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 08:16:45 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 08:16:45 +0000
Message-ID: <af0cf842-a16c-6cc3-fb61-b61422b24b17@gigacodes.de>
Date:   Tue, 19 Oct 2021 10:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/2] some leak fixes on fs/ssh-signing-fix
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <YW2qpuosxr9PNwVa@coredump.intra.peff.net>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <YW2qpuosxr9PNwVa@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0107.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::48) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:c042:75a0:fd5e:1472] (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P191CA0107.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 08:16:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c17b1b-fc13-494e-365f-08d992d8c9fc
X-MS-TrafficTypeDiagnostic: PA4PR10MB4526:
X-Microsoft-Antispam-PRVS: <PA4PR10MB45269ED87307C6C50FA4997FB6BD9@PA4PR10MB4526.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JHyBnsyjvlbwwSIlD9taP66bObnbTfaUlHRIXQPs9tmmOIB61EiXmimRh8SmFvfr7xZ8iicm7natvaS/iDwYQpRjgbcPu0PI6pNnXTVvk7yUZpLO+aFOT5ztIWNqG1WzkAvPZdGuCeaaRFtc+SUQcjXiT+MpFtrjwvb5pr3iFhmzLt2tnhRarBCfLvzI8hVEimHPOEm4p8NBQWJfM9Dleu203BMTffgR+OwGTJ2MJ6DKZRzeT/nyntHhQxZOBTqt/8gTnNYYSdgigu+/cZU6ekkLkHWfUBYgCa0DgG+4wsARELUi7+3+Y/7+AvpnpnYKPWUX4C5e6LYP85T8Vfv4u5QZKV/2AJGaKZ/SeZkcr0ttZLiB+lwWZ+KHKAH0pEfihYH2o9lnLQ4t7CzATOsn7FzuFgyp+LUdKhRO8XS4yN6zoC6k9sTDymY6PZ2pdQTeXioUhWlNATcS1MdNLPVK+IA/HAD+IhXELSeZYlVULU6+TUjYZqTGkaNIrysN/fuKBTj4XErZMtBUU7lWwP8JqLswIc0NNhXGvNr+S79A+X+dKMvnAbDY9VbXS7QD2zfCcD0KU2KeVp1MPYAZBOPpbT0sjZ7o8bV/g+1WpgoYs1CWRdvBv3F7RC87x3KwWh0BfxgxbbjmQ+e0deTvr5vH5PTZyVIWpnH2Li55wb5TuEI47P6ZoqSdJPzXfAzdbpV/4fLb0LsakXoxbRfUrdeOtTbAT776P6G9QXcIpogSxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(376002)(136003)(346002)(396003)(38100700002)(316002)(83380400001)(2616005)(31686004)(186003)(66556008)(8936002)(5660300002)(4744005)(86362001)(2906002)(36756003)(508600001)(53546011)(31696002)(6666004)(8676002)(66476007)(6486002)(66946007)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1pMQ1VGY2lkNE55MkZ6V2FNQWlNRUZWck5YU3cxVEVuOUxjeDUrT2NZNWZG?=
 =?utf-8?B?ZFBqa2xnNnNRdHl4M3MzamVnaDkvZWVaaXpTTHhvMGtxczBBSGV0d2ZZU09L?=
 =?utf-8?B?SEN5VFAyVGIvTDlGZnBNNmVSa2NMUTYzd3p6byttcUw2WXFyQWYwZ05rSnN5?=
 =?utf-8?B?MjFZd3YzaWJyQnMyNURkNkpZZWtyL2hKTjNHSnVnZHJ0bEtoWlVTV0VoelZF?=
 =?utf-8?B?RVdWa1JiTkk4d292Vk5uN21jZm5acjN4RGUrRU53d2dWUmx0Qm5SSHhUa213?=
 =?utf-8?B?aDlTdHNuRitZWFNzTzFvL3RHRlA4SjVvNllabDgvbjAxOFRHa0FKYi93N1Rm?=
 =?utf-8?B?dHZDMGdYYlJDZk5abEw4QjV5dGxkUDZZZlpMZFJGMjV6ckxXN3lBS1BlT0NM?=
 =?utf-8?B?Ym1NUkxNWml2WXNKYnNUeDhRTllLdUVPUWRhZWR5V3RkUm1OY2dWZzN0cVlm?=
 =?utf-8?B?bHg5c3pqcDNXZUx5bkd5MERYWE1rd1Vhc2ZBRHBBNi9ZR2VvcU9qVG1XVUNV?=
 =?utf-8?B?bDdrazlJa254aC9VdXJDVDNCV25MNHpjdTFRREJ5ZlJKcUllbEEvbTI3c0Fw?=
 =?utf-8?B?YUlsSjBkNWVxdmNNaXFEdG1pS2lEdWVULytDU0l0SmJtbE1GMEl6bURaOE1z?=
 =?utf-8?B?NzNOWTFGdUNwa1IwZHIzcUJQVkJicS9OczZ1WXgraUMvOEthbFhyNDZ1QnNx?=
 =?utf-8?B?NmhCRUdrMVFvdzBwdEFHK3pHL0VqRGtBamszYmVWam41T2VyM1BnR3lHNlNx?=
 =?utf-8?B?NjRhMFF1dDBQU0huTWFSejF3VnhwcGlYOUJRek5XZWd2SjhCbDN3WTZ1Z2I2?=
 =?utf-8?B?LzI5a1hlMlRDMTJVRnB0QVNDc0F5V1Q1a3BzWjkwMk15Z1hNa1dzTStySlNJ?=
 =?utf-8?B?RXhqY1pselR6TFM0cGtJeGR3VEZ4L3k1NVB3d3FGYUs3WWQzcFMzaXUydHd0?=
 =?utf-8?B?MUpKb2daOXRDSFJZL0F1enZjeGYwUVZGR0dmQzRJRWtMSVRURWg2WEIxWlZp?=
 =?utf-8?B?eHB0L3QyQjBvejh4c0VZSlQvc0FZTll6LzlQUFluVllVT3VJNWZBSkZvcVBZ?=
 =?utf-8?B?OU5sRjROczZSRmdIVHYyWjdMRDRFczBjeTk2Z215WEwzTi83UjMzcjZoTCtr?=
 =?utf-8?B?dXNQWXJpd2QweHQ4YUJYQUtYYzhteXhsSmx0UEMvRExWbjJSM3V1UzM5anZW?=
 =?utf-8?B?YXNRMHQvWVlBU0h2NWpheUFmUXBrL09IV1o2T09JMFV2RFVzZjRNZi91Uk12?=
 =?utf-8?B?Y2xvNFJuWWtOM1BXOUNvL1hDZ2VuY3lEaHZPNHk3MXdWQ2ZiTVRuM2l2dnhv?=
 =?utf-8?B?QTRTM05uTlhSeHVhRWY5ajFnWDlxMVlSeUc5ZVUyMVk5SUdaL1hHaVkycnBm?=
 =?utf-8?B?cVFhUlVGVEpTK0doUDNzN1dJNjdrMmxQbEhKVTJQWnEyMC9HcXRKTjlTMklY?=
 =?utf-8?B?L3RHWlZ1azhrRnRJQldzdk5ESGJ6UHBlK2dvMDUrVFJEK08vQzQ1ajJDZW5R?=
 =?utf-8?B?Y1hoV0ZyUGxSTkRkQUk0QmVGTnhEdU8rSTZRNldNeVFhRXE0V3N4d0g2MHo4?=
 =?utf-8?B?S2VZa3FtTnR0RlhFU09OeVRhUTdQbWJhZzZuRi9mOEJMOGozM3JCUzliUDdY?=
 =?utf-8?B?aEttNjgrVVF1ZGd0MVFNVUdOTkFJdlpNWXBiWEY5V1ZaQkxVNGt3aXdTUmk1?=
 =?utf-8?B?UDgrOGVsWFd4VXpXRWZUMU8xeTIwNUI3S1J3L3VRUnJRLzFPTjRXZGpRaXls?=
 =?utf-8?B?ZmRUN3dQQmNHV2lwSnZEVWdXV2dLaEFrN2t4N0VUM3ByQlVvNVhNUnROMVNr?=
 =?utf-8?B?ME8wSjMyNHlNT01JREl5L1JTeDFTSEtJK3NTMWc2ZG9PQVRCUTl1SnpaTjRz?=
 =?utf-8?Q?bLwiqwe0mfdoU?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c17b1b-fc13-494e-365f-08d992d8c9fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 08:16:45.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roBOeh6G9nFLbq7/8lr3bvD1ieJCn6d8ihgB7Z7xC//XHeeEn4Q1f2hNzOWqNAmq6K0TwHpf+UkHXo0CV0i4a2KjapxuP/96lDB2GtEeUI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4526
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.10.21 19:11, Jeff King wrote:
> This fixes two small leaks on top of fs/ssh-signing-fix noticed by
> Coverity. I guess it's too late to squash them in, so I prepared patches
> on top.
> 
>   [1/2]: gpg-interface: fix leak of "line" in parse_ssh_output()
>   [2/2]: gpg-interface: fix leak of strbufs in get_ssh_key_fingerprint()
> 
>  gpg-interface.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> -Peff
> 

Thanks.
Both of these look good.

Is coverity included in the ci/gh actions? Where would these notices
show up?

Kind regards,
Fabian
