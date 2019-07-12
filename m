Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E639A1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 05:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfGLFVL (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 01:21:11 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:27989 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfGLFVL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 01:21:11 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45lLqm5sGTz5tlC;
        Fri, 12 Jul 2019 07:21:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3DE821E78;
        Fri, 12 Jul 2019 07:21:08 +0200 (CEST)
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org>
Date:   Fri, 12 Jul 2019 07:21:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.07.19 um 00:03 schrieb Ramsay Jones:
> diff --git a/range-diff.c b/range-diff.c
> index ba1e9a4265..0f24a4ad12 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -102,7 +102,7 @@ static int read_patches(const char *range, struct string_list *list)
>  		}
>  
>  		if (starts_with(line, "diff --git")) {
> -			struct patch patch = { 0 };
> +			struct patch patch = { NULL };

There is nothing wrong with 0 here. IMHO, zero-initialization should
*always* be written as = { 0 } and nothing else. Changing 0 to NULL to
pacify sparse encourages a wrong style.

-- Hannes
