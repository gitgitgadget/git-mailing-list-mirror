Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B8AC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 09:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242664AbiEZJnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 05:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiEZJnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 05:43:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746E2C1EF0
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:43:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jx22so1870493ejb.12
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BfSGVbOotNhpNwoVQYFymzHe2Wgd9I7knXbbSfCtFTQ=;
        b=cVMOnBSKNIPIMMiSFFiuQ8u2ILaE986Mzi5Yiq9M6RemCfhCR56fC6TWFjZr5ua4lx
         jy6A4sAhbCWK0FJegF6KRsiWNaxiIaK8GPJ9GirTshUyYaOaslECHH1qNosedBgTbdDH
         8dYl6H9+0RFp3AtCEYF4OO5KrWZPKQw8mTrYJEYkEP7G6OTXkQ8lWY/+/dF95/pfPkEP
         tpOJ04HiYw+b+D3XAk3iJlR0iHf/+B2B5zKZo50gua8UhwxovDRCJy045PV/kxHDkP5K
         iOP+utOLcg/jpsq9Mi8ccCWge+1i8c6L/2P5gQKPJ99kxnBsTnAhxBjsuebgOC/wF2ed
         11fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BfSGVbOotNhpNwoVQYFymzHe2Wgd9I7knXbbSfCtFTQ=;
        b=MNkmdagiKjRa6PrPQjz0g+FZ+kAqBA29cRnppFPwY3rXpkcc4q3ZX7EpTHFSF5Wk1M
         /EsQPRIM90UFYfPyalX8Wt3uhEPSy3EhsS93rg/ctNaaGbMTYfeLT9KchgpE1G8EjVfr
         PI+PraWKxL5dMbh71vzNefCghpxv5KE8ZOCL9gPJ3Mdzmj6lxQAr9xtbNoFGAj4a8MBM
         pJRkAfpTaYu2Cdq7/wPb3TSOjeYKhqw16xQgkkmi7etlcHMu0BVkbLv16/3zkl50WlvY
         sF9rHGajSiEep0FwAfiQxb2AjU/98iJw58Bfe9qb4vF10MzzAXdl3itP9EnvaDq0OuWm
         DOHA==
X-Gm-Message-State: AOAM533JosT3R1I0CBN64o8/wmAI6ZVWVOTgJVZ4q13s5t4y/KeDhFAS
        aQV1/orhmlJ+SM/aH3CdmO0=
X-Google-Smtp-Source: ABdhPJynjnzqbRGo6U5uJBLkr2svCIBhe1pXuPUcYMjPrMxu3e+Kz7jveMY4OfrGahlYcm3w+t7Plg==
X-Received: by 2002:a17:906:7949:b0:6ff:27a9:f024 with SMTP id l9-20020a170906794900b006ff27a9f024mr1335898ejo.277.1653558200909;
        Thu, 26 May 2022 02:43:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u26-20020a50c2da000000b0042a9fcd7c73sm565316edf.46.2022.05.26.02.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 02:43:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuA1X-000Aux-PQ;
        Thu, 26 May 2022 11:43:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 1/3] rebase.c: state preserve-merges has been removed
Date:   Thu, 26 May 2022 11:40:42 +0200
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
Message-ID: <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Philip Oakley via GitGitGadget wrote:

> From: Philip Oakley <philipoakley@iee.email>
>
> Since feebd2d256 (rebase: hide --preserve-merges option, 2019-10-18)
> this option is now removed as stated in the subsequent release notes.
>
> Fix the option tip.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>  builtin/rebase.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 7ab50cda2ad..6ce7e98a6f1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1110,7 +1110,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
>  			parse_opt_interactive),
>  		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
> -			      N_("(DEPRECATED) try to recreate merges instead of "
> +			      N_("(REMOVED) try to recreate merges instead of "
>  				 "ignoring them"),
>  			      1, PARSE_OPT_HIDDEN),
>  		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),

I have some local patches for this more generally, but for
PARSE_OPT_HIDDEN options we never do anything with the "argh" field,
i.e. it's only used for showing the "git <cmd> -h" output, and if it's
hidden it won't be there.

So there's no point in changing this string, nor to have translators
focus on it, it'll never be used.

This series shouldn't fix the general issue (which parse-options.c
should really be BUG()-ing about, after fixing the existing
occurances. But For this one we could just set this to have a string of
"" or something, only the string you're changing in 3/3 will be seen by
anyone.
