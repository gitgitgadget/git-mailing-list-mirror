Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D015AC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 09:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AB560F4F
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 09:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhJYJC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:02:28 -0400
Received: from mail-am6eur05on2074.outbound.protection.outlook.com ([40.107.22.74]:5088
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232404AbhJYJCS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 05:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUr0XxNjtfgbAmqH8r/qAG93e3YeySLQ4JTuLoZZE20VnVgPcatcWi2mtiGzFPu9V/Z1OrHNQk36PwqX/TUJsnJtEibj8w8OEwIQJr1RJYUigvtGF8Q7bQCHbEFQYkNhWnC31+EW89oFn0JVx+BVLJl9/y292MYuWllADp/lWZ7h48X4RZrI7TC2yIIqunRHh3rVLYpprAZjdNYegZDkXac9juiAjU5JdEM4+EPH7E85C6xHmBEZsY0H1OViSaR/QCDRWu0emeCCnYZnMCaDlSovlI+YzAnsFgXJp2edMxGAZKQVFCJEytKbEDbhN3Og2zY5BfhY7zxavmgBBHBIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pODchNPH8N3e/LwUNbnYNfVw6Ikkh6x6qpfwPpItbn8=;
 b=fCIjdFc3R9eWpYDTAh1jhlS+OPbU2r/NZfKcM1blwU8jMc7zZpYbBm6xB8AnNUjAJy6Flkxqo/YYL321x25JngekxIbMN5WVbkJNk2ZPJ5wM5bgy/pK9KAMZYRtF3tJDtbsz1Fl4DUSnJANrDp9VU0sf36PgdXvWVYz4EYA0V8nE4HrLmUEP9UakqmLGCiir8iXRkxGH3LXZvgwv01UgNkFzAmz6+1666VT9o4+A7UpeMP3yxuadsk83PDvz4aacnx+QSMQ0ZzgWoZ1Kfwy6AB8ftmDtYYRqFUc9dxBCZXg8H74XM8Q+oALHnsvGzHUk462i6jnUJGang/wVvsxZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pODchNPH8N3e/LwUNbnYNfVw6Ikkh6x6qpfwPpItbn8=;
 b=EazbT90yNjOJ4U+odbpcvpJCgpKOM2lc5Ck3TAHDTIed2D7iLSz4uaTiWx73pGfi5qyeMhuJtDuQnQ1BwBJUo+V3iRgi1Cg9/aWNZGR+F1ORQbYEUkZGm1RBAQlbDOgT/FgFQzXCmeIEU59VndKhB0tYGJtc8MySO6P6hdw29tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 25 Oct
 2021 08:59:54 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 08:59:54 +0000
Message-ID: <006c186e-c005-28a3-7a5c-27d365ffe026@gigacodes.de>
Date:   Mon, 25 Oct 2021 10:59:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: SubmittingPatchs: clarify choice of base and testing
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1634787555.git.me@ttaylorr.com>
 <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
 <211021.86ee8emx57.gmgdl@evledraar.gmail.com> <xmqqpmrykys9.fsf@gitster.g>
 <xmqqilxncwpr.fsf@gitster.g> <xmqqa6izcwio.fsf_-_@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <xmqqa6izcwio.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0068.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::45) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:c042:75a0:fd5e:1472] (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P193CA0068.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 08:59:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ec0682-e3fb-4c59-8227-08d99795cfdd
X-MS-TrafficTypeDiagnostic: PR3PR10MB3834:
X-Microsoft-Antispam-PRVS: <PR3PR10MB38348A1EB06952B6CE0A1944B6839@PR3PR10MB3834.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NcaSwbTelX2YFBD+8Q+7wiIMHJzCbMaGmy6iPxnm4mCsNiVe+XIRMeBSMVt61vP+R9STEuBK50qo2KY+rTnJy/7gFSr5jVv/EaBIpH+OIVeiZobkprjNZ8+yuaxKgR2dpGuBzcImtF/660S/q39gW16u8nOHnUsqHxzRYC3jmwNuysqDrTnrIXcblfGHFS2Rg/3RwKlVkYOnw5kcvWjQavCJ92QNzl/LMgtg0q4rTH3bMbiTGDfT2T9/Z2LUk3Vkc9m0dO5bLfg5NJkln3ZbJIbUZm73eHoyiJNotau3b2O5P9GIdoulknnTBxeNIsRdLOgnsCBKhfcp6+eSIn9c48wyRbC8hEBQHg7vCUl/KDEdboLDYRYrnqn7hnFrwlaDB61ZN4RbX5/iuLZDzbJR4jzGEHnB8FqB3MRouXewg2EyWl4Wt1lf7iTi5/Z49biQbldhVuRYoABumV+PUyRg6Ypml9VckfF9lmpv/mGo0ID1uhK3eDsrI6pvwpndmA2bb3i+Ar0EsY4pJ7TJlQhYs0hqz8D8zA5qtfFjdHwNCYW77rsXsotVCci5h7TGMbP154hyDt6fKN9DwVAgRL36Rn8ywGGsaZkIrlx3PgoKYFkD0dEDiDFkyf425n96oh9qtUqAOuzJ/7E9NYHF2yr3oTFlHl5TGlGCR7xLourTy/BuRUEzhryuOoRU4C/J77OtJrwdO/Fog1VifWxXSbEWmcLe3F4BMPrx1A3DzylbarRJRx9t9pIzpG9slhySlI2k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39840400004)(366004)(376002)(36756003)(66946007)(66476007)(66556008)(316002)(86362001)(38100700002)(186003)(31696002)(8676002)(2906002)(5660300002)(2616005)(31686004)(6486002)(8936002)(508600001)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YrBpPKfVAsFKFErU+BV+jeAPjZ+xtAayfKM8rW698f75amuyOduw07NiqKVc5PRujIknYNhvXsIdxlhfHKjW4V3HOAe0PRHo8HTDv05MXWrsLm8lbw7uvPLGVB2dsbhZQa8v3bPlKJzLrkuAMk9s94BnspmqynAA7cAhjF4Jgbw+rC116kQozTxoVH3wBXQYB6S8xdC79IZsdUkKNexwXH6mQD3y8Ai9Ox1aUfvWwe2onZpbC+ax7eztm4cusVH06oj6Cp5LQ/3UVtD98W/Y8S3AxBrlz0hMjTgdjzfLS4CupEnvAAQKoleRsWbq+32fzYLZH/nMN3Mmn69GKczkBKQeYNgOnb9u6w6ojMZfaHqFW/2V8iJ9HZBfRyTrGaVQiqOY3Gy57BZrmNeKOa2a/bMTRBLIigbEuVDcU5S/0vlx8AkTKRII6gCPfT6PsxZ+pizcsQOqvpUCLuiBO9Ll0PU+nPNsl+CYy9QBHHg/GSFtv+CUJGmcM5IRGSjDU+03tdUZc0WAl/ZhWqV3S1aR/XneFkbPp+8SrNGFUjBBy/k=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ec0682-e3fb-4c59-8227-08d99795cfdd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:59:54.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCF6WozJvlnw0YpaZQFqGuO+1pkxe3eq/iSxf7EIfF9w8shioAZElyVHWMmbogJ0L4/56Sbq6qcGqQveRfs2+CRZXDOIVErHorVkvlL+oGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3834
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.10.21 22:32, Junio C Hamano wrote:>  * A new feature should be
based on `master` in general. If the new
> -  feature depends on a topic that is in `seen`, but not in `master`,
> -  base your work on the tip of that topic.
> +  feature depends on other topics that are in `next`, but not in
> +  `master`, fork a branch from the tip of `master`, merge these topics
> +  to the branch, and work on that branch.  You can remind yourself of
> +  how you prepared the base with `git log --first-parent master..`
> +  easily by doing so.

Using the topic branches from gitster/git that were merged? Or by
selecting the specific commits from the merge into next?

> @@ -260,8 +281,8 @@ or include any extra files which do not relate to what your patch
>  is trying to achieve. Make sure to review
>  your patch after generating it, to ensure accuracy.  Before
>  sending out, please make sure it cleanly applies to the `master`
> -branch head.  If you are preparing a work based on "next" branch,
> -that is fine, but please mark it as such.
> +branch head.  If you are preparing a work based on selected topics
> +merged to `master`, please mark your patch as such.

I think this meant to say 'merged to "next|maint|seen"'?
Or topics selected for being merged into master?

Thanks,
Fabian
