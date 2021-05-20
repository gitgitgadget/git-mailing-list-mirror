Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10064C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 23:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6A66135C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 23:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhETXpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 19:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbhETXpu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 19:45:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661AFC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 16:44:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q15so12919161pgg.12
        for <git@vger.kernel.org>; Thu, 20 May 2021 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=65Vep+GXxw4dFfVdHrOltjDvFDNHqnA82AzLIDlPyKY=;
        b=ketyijnJSWo4I5gUDLFyjafsnbDwIGBjcBudTa4HySevar1iKMqLc54FsMlbXnkNyq
         aZ9HPoDCJQ9TGunP/hwSaYQHlBRtq0zywXraVY8RUY+ihCh2xiFpMUKT4mYG7/hJ97+7
         3HSmLXk+VSf0awLxX4Y8kPND8VyIwqpoePUvVAzSbmTRMiywYf8YtBIwIMFIu09HIiS+
         Sb3MDV/wf639Z6oYfJ5PpsBlzKuq/AVGYhiAVvRZW8hQ3kgzWfcpNwvUyg75swUD3Vb6
         tbewa3g2LxIceyuQX9eD7IIUnW6273sjaeE0lkAtOeeju6bkXMBPPNux0mLNkikxvHrj
         r8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=65Vep+GXxw4dFfVdHrOltjDvFDNHqnA82AzLIDlPyKY=;
        b=CeBzD4c0mbJywaZaTHRh2IbQaV+VESWQ8J/mttcB/tF9fSd5hnPho29KV6m/htH9RW
         NaWBRNe81NKvuwy/i/PoB7DVkbjZ+DPZSxirgUU7VIh9ytSbMbQeAWSivBULWYBYpq9b
         FfwafjJ7B9u5hM8BfF2zR4s3ZCdAaNvnlhPVZMuWxYV9Zmku/IsLJoWUCQiqFHmf5+OB
         odnJeJXRSBsiwuP+AXWDGMFONB29DUqmiypWC1mzNTrccP6oF1aaP7E90M+pG6BD5CRE
         nBbU6Tj09494IrwhTIm+LgLaMfz53U/yoDm64v9tps/DpcMpTRjdF6mxJ6JQi77PVWyU
         WeJw==
X-Gm-Message-State: AOAM530zTjkxUwkpAIcucPmFTFhjlJYwWFEjLGbrlSTtk+3ub/q4PmX8
        vP82iq+/AANFyfx0pvAw7GE=
X-Google-Smtp-Source: ABdhPJxfKIV8a1kt5BOc6cSJoa8nq9Fnox+tvc2cDkho5yeEWS4CBPkPjN/KYlx9Igf/qkIcX7dvfQ==
X-Received: by 2002:a63:a1c:: with SMTP id 28mr3412582pgk.440.1621554266897;
        Thu, 20 May 2021 16:44:26 -0700 (PDT)
Received: from localhost ([2402:800:63b8:812a:adcf:8995:bb0b:8236])
        by smtp.gmail.com with ESMTPSA id l64sm3000719pgd.20.2021.05.20.16.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:44:26 -0700 (PDT)
Date:   Fri, 21 May 2021 06:44:24 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/4] cache.h: rename "xdg_config_home" to
 "xdg_config_home_git"
Message-ID: <YKb0WImFLYpluHrQ@danh.dev>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210520221359.75615-2-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520221359.75615-2-lenaic@lhuard.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-21 00:13:56+0200, Lénaïc Huard <lenaic@lhuard.fr> wrote:
> Current implementation of `xdg_config_home(str)` returns
> `$XDG_CONFIG_HOME/git/$str`, with the `git` subdirectory inserted
> between the `XDG_CONFIG_HOME` environment variable and the parameter.
> 
> This patch re-purposes `xdg_config_home(…)` to be more generic. It now
> only concatenates "$XDG_CONFIG_HOME", or "$HOME/.config" if the former
> isn’t defined, with the parameter, without adding `git` in between.
> Its parameter is now a format string.

Intended or not, this change is going to make a logical conflict,
should other topics also call to xdg_config_home, i.e. no textual
conflicts, programs compiled successfully but run into failure.

I think we shouldn't re-purpose xdg_config_home, we should add a new
function named something like
xdg_config_home_{for,nongit,other,generic} instead.

> -char *xdg_config_home(const char *filename)
> +char *xdg_config_home(const char *fmt, ...)

In my opinion, we don't even need to over-engineer this function
with variadic arguments, I think below function should be enough for
most (all?) cases:

	char *xdg_config_home_prog(const char *prog, const char *filename)

>  {
>  	const char *home, *config_home;
> +	struct strbuf buf = STRBUF_INIT;
> +	char *out = NULL;
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	strbuf_vaddf(&buf, fmt, args);
> +	va_end(args);

If my imagination is sensible, it's not necessary to use a temporary
strbuf and strbuf_vaddf here ...

>  
> -	assert(filename);
>  	config_home = getenv("XDG_CONFIG_HOME");
> -	if (config_home && *config_home)
> -		return mkpathdup("%s/git/%s", config_home, filename);
> +	if (config_home && *config_home) {
> +		out = mkpathdup("%s/%s", config_home, buf.buf);
> +		goto done;
> +	}
>  
>  	home = getenv("HOME");
> -	if (home)
> -		return mkpathdup("%s/.config/git/%s", home, filename);
> -	return NULL;
> +	if (home) {
> +		out = mkpathdup("%s/.config/%s", home, buf.buf);
> +		goto done;
> +	}
> +
> +done:
> +	strbuf_release(&buf);

... and go though the restructure of this function.


-- 
Danh
