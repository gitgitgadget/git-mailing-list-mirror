Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B40DC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55C6611EE
	for <git@archiver.kernel.org>; Mon, 24 May 2021 09:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhEXJfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 05:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhEXJfD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 05:35:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4157CC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 02:33:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x8so27795464wrq.9
        for <git@vger.kernel.org>; Mon, 24 May 2021 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILo2jGok85x0DRx2CFvfFeG0xgtJg+jUq5SqZ8B1Onc=;
        b=hKD5lPn7tGdK7EkhplhacPE9O672XEgTkFdbimR9VBehVihRRqTZ40ExO3oxBLUBYE
         WoJnHJfD5W+r0GAc93k2GYXz789loQfJ1d1qL/PUEUK+Q5elFoOrpEOGxhinLWOjm6TO
         Scrpw7ZAsLf2V5++G/LFgA1+e2ky3FV/ogO1nPcIof2Daf2UZ7775mURA/TDHg8CRfJI
         kAafWY+zyxDlSVD9sRzGKGla6KTEWMbSDqn7rly5yMrnRwbiHRWM9SI/PMnsCFRbsbdw
         U5WZTlHp2xnFoL6w9IbdLNrXF8tlmoUtCxlNTbywkgj9J2/vNWQCiC/+dKtgJ5SP6S70
         /Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILo2jGok85x0DRx2CFvfFeG0xgtJg+jUq5SqZ8B1Onc=;
        b=pLXKAhnyyApuSe2DFVuXm+pyTe5UInBXkbhabVog9oPdvzV/pfQe70L5w9rdRRyMQG
         +7zj6oPts4tdDL0vAB1bSKjm9UQi9B8ZroB8+YuyD0Ozkf7ZIOgMmajqj/30iiZvBzz3
         3PM1K0YymMds0TE7zVPlAghuZuCvaQs0jB/usRVeANLyEF+JO47ylzhzgdSFqCjav0ft
         ehEro5XSUShiuWnXhTlBDAWu3WcD4aVupVCSfkodE+s2m1Ac79xVrNqyWotIpe568aYe
         uOnsxdeOWQs69UkEqLOVqyKWclmfAD+VWdDhANc2UXg/YVHPVAT9ek7Ry+ghyfscLhH7
         xTdg==
X-Gm-Message-State: AOAM5335oRT1q1L5sXlc7xBXXpSb7STKB5CVI5C/AZpK2THD3dQ2hjf1
        e9ucPa7rTTzhxYWmGff4UwI=
X-Google-Smtp-Source: ABdhPJxuLaTsEvyuoQ0Wn5Jk8JZ1RR2h/Q5vv1p0cl/sjrXdkv+AU3bh+AKF2xOmdFhN70/666u/Dw==
X-Received: by 2002:a05:6000:244:: with SMTP id m4mr21266478wrz.225.1621848812877;
        Mon, 24 May 2021 02:33:32 -0700 (PDT)
Received: from [192.168.1.201] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.googlemail.com with ESMTPSA id c194sm7418863wme.46.2021.05.24.02.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 02:33:32 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v4_1/4=5d_cache=2eh=3a_Introduce_a_generic?=
 =?UTF-8?B?ICJ4ZGdfY29uZmlnX2hvbWVfZm9yKOKApikiIGZ1bmN0aW9u?=
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210524071538.46862-2-lenaic@lhuard.fr>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <120b6b5c-ab30-6985-d5af-a0b0290b864f@gmail.com>
Date:   Mon, 24 May 2021 10:33:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210524071538.46862-2-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lénaïc

This looks fine to me. I'm not 100% sold on calling the parameter prog 
as our program name later in the series ends up being "systemd/user" so 
something like "subdir" might have been better but that is not worth 
rerolling for.

Best Wishes

Phillip

On 24/05/2021 08:15, Lénaïc Huard wrote:
> Current implementation of `xdg_config_home(filename)` returns
> `$XDG_CONFIG_HOME/git/$filename`, with the `git` subdirectory inserted
> between the `XDG_CONFIG_HOME` environment variable and the parameter.
> 
> This patch introduces a `xdg_config_home_for(prog, filename)` function
> which is more generic. It only concatenates "$XDG_CONFIG_HOME", or
> "$HOME/.config" if the former isn’t defined, with the parameters,
> without adding `git` in between.
> 
> `xdg_config_home(filename)` is now implemented by calling
> `xdg_config_home_for("git", filename)` but this new generic function can
> be used to compute the configuration directory of other programs.
> 
> Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
> ---
>   cache.h |  7 +++++++
>   path.c  | 13 ++++++++++---
>   2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 148d9ab5f1..8a2969414a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1263,6 +1263,13 @@ int is_ntfs_dotgitattributes(const char *name);
>    */
>   int looks_like_command_line_option(const char *str);
>   
> +/**
> + * Return a newly allocated string with the evaluation of
> + * "$XDG_CONFIG_HOME/$prog/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
> + * "$HOME/.config/$prog/$filename". Return NULL upon error.
> + */
> +char *xdg_config_home_for(const char *prog, const char *filename);
> +
>   /**
>    * Return a newly allocated string with the evaluation of
>    * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
> diff --git a/path.c b/path.c
> index 7b385e5eb2..3641d4c456 100644
> --- a/path.c
> +++ b/path.c
> @@ -1498,21 +1498,28 @@ int looks_like_command_line_option(const char *str)
>   	return str && str[0] == '-';
>   }
>   
> -char *xdg_config_home(const char *filename)
> +char *xdg_config_home_for(const char *prog, const char *filename)
>   {
>   	const char *home, *config_home;
>   
> +	assert(prog);
>   	assert(filename);
>   	config_home = getenv("XDG_CONFIG_HOME");
>   	if (config_home && *config_home)
> -		return mkpathdup("%s/git/%s", config_home, filename);
> +		return mkpathdup("%s/%s/%s", config_home, prog, filename);
>   
>   	home = getenv("HOME");
>   	if (home)
> -		return mkpathdup("%s/.config/git/%s", home, filename);
> +		return mkpathdup("%s/.config/%s/%s", home, prog, filename);
> +
>   	return NULL;
>   }
>   
> +char *xdg_config_home(const char *filename)
> +{
> +	return xdg_config_home_for("git", filename);
> +}
> +
>   char *xdg_cache_home(const char *filename)
>   {
>   	const char *home, *cache_home;
> 

