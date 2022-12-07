Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7ADC47089
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 05:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLGFBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 00:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGFBM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 00:01:12 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B35C32BBA
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 21:01:11 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m18so9736113eji.5
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 21:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdP/DvkXSzqRdeLjqrHuDfsy0nf82LC4J7bgHBX4e/w=;
        b=GKMLEl95XwrFRPdffiNgyY4phps/6MhovctmMAcuoeTrBW98Mq/6e11uxIcOwkBG7H
         yDZ2OM5xmkBCYrQ8PDFODbF3TKCJXwvaDyNnguekiuOYji3EkXZ5GIKJExAcWh+YUm3D
         ULJiKO3cAxFnvAjA7cw3G1swiK9ata7JTb27AfM8F6InrJ7NtEJeGheXAbydi+ZX/7+i
         xFfSZLMJqdcQx0ij7D/JdLkIulTMqKCLxCYcDiaG11k3Mw7o4lZBtm6w/HfNI0A+ZSjF
         7hliFO4fjYLg6Fy8vRLQFuhNpWVdWHR9MCviwCCo+Z2/lAB65cHJ+IfeQMKrs4cvOINJ
         0+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdP/DvkXSzqRdeLjqrHuDfsy0nf82LC4J7bgHBX4e/w=;
        b=3dhlY2Jciskr757LfLsDgRS6ZUgaWACdhAAdRvw9hHDzmaLgkJSJ36RliiyvA0Ouwr
         D6s70Aob/cpA9k3GL95gLUq49MBpkFUkremUYaLShBA01Ru4NgYAWFCzuFsg868y4jWB
         CtkRWnA+WgNWA7sayIaiQufe3qfJWhT5SV9qpQlNtRQhqTsiSVXD1pcC2Rpr2w9iqPD9
         5Jsb3fRkZXR7k2Bpdps7QaRZqlUpYvB+z/ARB4gl3GaQGgH86zbVx7r652PXGi8k/TW4
         fz9zQT1kS/8ElVP07VnfCdNc/1k4x20uJFx29BjGhoqtytFHy3B9+lH3HFUoBCB2ig13
         w+Dg==
X-Gm-Message-State: ANoB5plLrdHWsg4byEAU+bCLWNGPmPQ4KSH9qPsaHPN6GGqzg05YmPk7
        nDwKt/T/q+zEwmqwKRHfnPA++MxOsGdjIA==
X-Google-Smtp-Source: AA0mqf6Z2DpNCmRTyURg4eLaAEhqPaj01iT/C21YGtT2yjMAVCnlFFM9O3A4GeE7tm8SbvFpUh/4Pg==
X-Received: by 2002:a17:907:a06e:b0:7c0:dfb7:3525 with SMTP id ia14-20020a170907a06e00b007c0dfb73525mr13616557ejc.205.1670389269563;
        Tue, 06 Dec 2022 21:01:09 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id y16-20020aa7c250000000b0046b6bc19439sm1737473edo.47.2022.12.06.21.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 21:01:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2mYO-004LRa-1o;
        Wed, 07 Dec 2022 06:01:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lars Kellogg-Stedman <lars@oddbit.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] line-range: Fix infinite loop bug with degenerate regex
Date:   Wed, 07 Dec 2022 05:52:04 +0100
References: <20221205193625.2424202-1-lars@oddbit.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221205193625.2424202-1-lars@oddbit.com>
Message-ID: <221207.86tu27aju3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 05 2022, Lars Kellogg-Stedman wrote:

> When the -L argument to "git log" is passed the degenerate regular
> expression "$" (as in "-L :$:line-range.c"), this results in an
> infinite loop in find_funcname_matching_regexp() (the function
> iterates through the file correctly, but when it reaches the end of
> the file it matches $ against the empty string, "", and at that points
> loops forever).
>
> Modify the loop condition from while (1) to while (*start) so that the
> loop exits when start is the empty string. In this case, "git log" exits
> with the error:
>
>     fatal: -L parameter '$' starting at line 1: no match
>
> Originally reported in <https://stackoverflow.com/q/74690545/147356>.
>
> Signed-off-by: Lars Kellogg-Stedman <lars@oddbit.com>
> ---
>  line-range.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/line-range.c b/line-range.c
> index 955a8a9535..bdcb810485 100644
> --- a/line-range.c
> +++ b/line-range.c
> @@ -135,7 +135,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
>  {
>  	int reg_error;
>  	regmatch_t match[1];
> -	while (1) {
> +	while (*start) {
>  		const char *bol, *eol;
>  		reg_error = regexec(regexp, start, 1, match, 0);
>  		if (reg_error == REG_NOMATCH)
> @@ -161,6 +161,8 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
>  			return bol;
>  		start = eol;
>  	}
> +
> +    return NULL;
>  }
>  
>  static const char *parse_range_funcname(

We really should fix this, but why not just count this as a match,
rather than erroring out?

That we're mixing up whether '$' always matches here with our iteration
loop is our own internal bug, we shouldn't error out on a '$'. It's just
a regex that happens to match everything.

It's perfectly OK to provide a zero-width regex in general, e.g. try:

     git config --get-regexp '$'

Or for a non-git tool:

	grep '$' FILE

I think the real bug here is that we are pointing our regexec() at the
haystack of multiple lines as an optimization.

Then in "determine extent of line matched" and "is it a funcname line"
assuming that a positive match must be non-zero-width. But that's just
because the optimization is leaky.
