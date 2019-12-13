Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003E9C80D4C
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2C32477E
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfLMTYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:24:51 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:21983 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfLMTYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:24:51 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47ZLG86yWjz5tlD;
        Fri, 13 Dec 2019 20:24:48 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6D0D9237;
        Fri, 13 Dec 2019 20:24:47 +0100 (CET)
Subject: Re: [PATCH v2] userdiff: remove empty subexpression from elixir regex
To:     Ed Maste <emaste@FreeBSD.org>
Cc:     git@vger.kernel.org, peff@peff.net, lukasz@niemier.pl
References: <20191213173902.71541-1-emaste@FreeBSD.org>
 <20191213175535.87725-1-emaste@FreeBSD.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0c9d891e-382f-03d1-bcbd-d652f1d58f4d@kdbg.org>
Date:   Fri, 13 Dec 2019 20:24:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191213175535.87725-1-emaste@FreeBSD.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.12.19 um 18:55 schrieb Ed Maste:
> The regex failed to compile on FreeBSD.
> 
> Fixes: a807200f67588f6e

Having a references is this form is unusual for our codebase. (Not that
I mind a lot, though.) I expect that Junio will commit the fix on top of
the commit that introduced the bogus regex anyway (branch
ln/userdiff-elixir), and then it will be easy find.

> Signed-off-by: Ed Maste <emaste@FreeBSD.org>
> ---
> Add /* -- */ to make things more clear and be consistent with other
> patterns.

This text would be nice to have in the commit message.

> 
>  userdiff.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/userdiff.c b/userdiff.c
> index 324916f20f..efbe05e5a5 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -34,8 +34,9 @@ PATTERNS("dts",
>  	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
>  PATTERNS("elixir",
>  	 "^[ \t]*((def(macro|module|impl|protocol|p)?|test)[ \t].*)$",
> +	 /* -- */
>  	 /* Atoms, names, and module attributes */
> -	 "|[@:]?[a-zA-Z0-9@_?!]+"
> +	 "[@:]?[a-zA-Z0-9@_?!]+"
>  	 /* Numbers with specific base */
>  	 "|[-+]?0[xob][0-9a-fA-F]+"
>  	 /* Numbers */
> 

Good catch!

Tested-by: Johannes Sixt <j6t@kdbg.org>

Thanks!

-- Hannes
