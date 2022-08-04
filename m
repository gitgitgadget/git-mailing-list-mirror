Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9698DC00144
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 06:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiHDGWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 02:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiHDGWw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 02:22:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6A529823
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 23:22:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id tl27so17236156ejc.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=xSTN9ZnLjRQwrJwVmDUr2A1ZhxEjYHQEsBXWLMpkfSQ=;
        b=kIm3BUtgOxvEWD6u3UFN1FQJQlTl6VaOeBb6txkWQQWfwk5el2ckFo2A9BZfWWBFeQ
         kXcCqGSMXyJkMO9JqydGuK/hWnN6ZT16gI0X456uUWkCxbmklmP/brJTSHpARRr3jooN
         i9vJ0lkAIj4/lZE1fJihelufvb06uHbyepzco5SEZ9IJpaEgKsAzYgXC739rQDxV7/12
         mv1vZbCeK4W8PamEHsOfJKjp2Cl7/likeQHgJf5U/jIxh1X67mw2IYf4uyCNl+wEWnym
         6JL04iV8Ngw27tMbAtYGenxqIWlONMb8YkC9id7tmg+87L/kkhlOjPRR1kiAFhsjmFij
         eLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xSTN9ZnLjRQwrJwVmDUr2A1ZhxEjYHQEsBXWLMpkfSQ=;
        b=D0BR0aJQi67wK3Md79P2bOXUVJF/ZprKBgk8XBNjWRxS9Se85SXbYHgOl7047D2k03
         XcFSmQh6hMCyAaay6+7OXKLqY5OHX6KCrXbJjwzdk1tlNAdSyMINYgWOYF0vzMCAhJYh
         0MiNWLbEMPPbDF3XlX4Dbt3+BPJ6OegSzhy08ARGrltexlRoaCX5oLR0YYBf3giVcxXM
         zrdbjpfKskIuxMc6lIwDstU9chYXNot+5oyaBbNKPLq9oO/LMZWeTUz0nN51241hse38
         Id1RgxiQYx8kENfGf/Cy3QCaT5kUR5w2QVOjGPyt5HOyE/xV2c3wo612y5+t6hmEchGd
         MWew==
X-Gm-Message-State: ACgBeo3S3ZROlh2hnnfBpCijZHWnam9I9nhtYUNdDBo98tkXhGtc9RRH
        oN/R/BMN6jpOnAMxxUQw1ww=
X-Google-Smtp-Source: AA6agR4bJuwlhp2NH4m1SY3kMthZemU3pt1vOJB6q30MHIHhnfKDH7jjDI6sAd/DCfjZ7OUVo89deA==
X-Received: by 2002:a17:907:6930:b0:72b:6da5:7c08 with SMTP id rb48-20020a170907693000b0072b6da57c08mr280133ejc.187.1659594168806;
        Wed, 03 Aug 2022 23:22:48 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fg15-20020a056402548f00b0043aba618bf6sm159743edb.80.2022.08.03.23.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 23:22:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJUFr-009dUN-09;
        Thu, 04 Aug 2022 08:22:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 03/10] scalar-diagnose: add directory to archiver
 more gently
Date:   Thu, 04 Aug 2022 08:19:53 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <23349bfaf8fc5f5001f1ed1fa19e9b3909466ae3.1659577543.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <23349bfaf8fc5f5001f1ed1fa19e9b3909466ae3.1659577543.git.gitgitgadget@gmail.com>
Message-ID: <220804.868ro4fryg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 04 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> If a directory added to the 'scalar diagnose' archiver does not exist, warn
> and return 0 from 'add_directory_to_archiver()' rather than failing with a
> fatal error. This handles a failure edge case where the '.git/logs' has not
> yet been created when running 'scalar diagnose', but extends to any
> situation where a directory may be missing in the '.git' dir.
>
> Now, when a directory is missing a warning is captured in the diagnostic
> logs. This provides a user with more complete information than if 'scalar
> diagnose' simply failed with an error.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  contrib/scalar/scalar.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 04046452284..b9092f0b612 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -266,14 +266,20 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
>  					  const char *path, int recurse)
>  {
>  	int at_root = !*path;
> -	DIR *dir = opendir(at_root ? "." : path);
> +	DIR *dir;
>  	struct dirent *e;
>  	struct strbuf buf = STRBUF_INIT;
>  	size_t len;
>  	int res = 0;
>  
> -	if (!dir)
> +	dir = opendir(at_root ? "." : path);
> +	if (!dir) {
> +		if (errno == ENOENT) {

Per [1] I think this is incorrect or overly strict. Let's not spew
warnings if the user "rm -rf .git/hooks" or whatever.

It might be valuable to note in some file in the archive such oddities
we find, but warning() won't give us that.

> +			warning(_("could not archive missing directory '%s'"), path);

In any case, this should be e.g.:

	warning_errno(_("could not archive directory '%s'"), path);

You already have an errno, so using *_errno() will add the standard
information about what the issue is.

> +			return 0;
> +		}
>  		return error_errno(_("could not open directory '%s'"), path);
> +	}
>  
>  	if (!at_root)
>  		strbuf_addf(&buf, "%s/", path);

1. https://lore.kernel.org/git/220610.86ilp9s1x7.gmgdl@evledraar.gmail.com/
