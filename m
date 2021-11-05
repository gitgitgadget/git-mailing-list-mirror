Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B43FC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 19:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B03360F55
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 19:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhKETsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 15:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhKETs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 15:48:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9151AC061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 12:45:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso4098028pjo.3
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jjg6ztcni91PqlA9ZwpJQImZZoJa9+xtgat8mWn0wOU=;
        b=b9MOo7aNJgt6XSy0pYSLPhTQWoMV43Btca+mHlN/MJtODBzUsAnyir14SFnkQH1aF8
         xn1dydI05GtyIl1oJwO69KtepDijRhCcKXljOowvLKk8QZguBwxrsplB/PBuTbkGN3qJ
         tvr6klVBK4bXkgDBPkEpTiR8SecVrMykGJaPg4Qc77R/o+BbAnjI3fku9lQ4n/soowGX
         y51i85gUkFpbxZ4yiTT2LAh7VBlhxSOjeBPZbC2cy5x5Hkt1lzmSaa2pX/f+62qB7w+5
         ut4tm3+9Jr7MAw3TsbQM25vYAoR9Iso/Vtf/CRTDunxh69moEkG4Xe0fV/T2qzGN2WeP
         ZIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jjg6ztcni91PqlA9ZwpJQImZZoJa9+xtgat8mWn0wOU=;
        b=eLoOrs4h3cL0YARg37p5lxB5WbriPTQoaVTeg0C8w7FFSh5galMxLng728rKX2t+5l
         5HAzbbbblfS1460DKW6/mEy2u7remqa+rtfkCHkPC1L1MQZfG+Zl9j19Rn2R7KmPwmQ5
         LIDQcyYEmLPsnP3SrxMWuJ2uKLvacQzBGfJqJN9jeCpYmgwk7Hc8sdn3wYLRiZW96xXq
         7Qk5DV+khpKcLctmd6gmb2xe69QJMYAiPVTesHqvyeqSX+7Q5gfuv0bAkHisS4dkDaAX
         hIs6evUHrz/gNJ6Mu2V5pStTXkbUQh1B3AJaxs21Z4qA+2YEX85fhEqK7W6dEpIEzm2t
         a8ng==
X-Gm-Message-State: AOAM533SX4VvvM+wQ9EV3H6NTKEdxFA3sdjs/EQo4ficqQsuxPXRGPI8
        H/Sns1akMkGicY8EQgnqAtbrkA==
X-Google-Smtp-Source: ABdhPJxDeHBOrxnuVfWT2haLgKroMh9daVY16luVzJwtttx9t5Axi711t13t1a/6SDSNrdLRB0hg+Q==
X-Received: by 2002:a17:902:6941:b0:142:5b55:28a6 with SMTP id k1-20020a170902694100b001425b5528a6mr194758plt.31.1636141548724;
        Fri, 05 Nov 2021 12:45:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:2b10:976d:eb88:7e7f])
        by smtp.gmail.com with ESMTPSA id u22sm438493pfi.187.2021.11.05.12.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:45:47 -0700 (PDT)
Date:   Fri, 5 Nov 2021 12:45:43 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [WIP v2 1/2] config: make git_config_include() static
Message-ID: <YYWJ57gFiSGIQI7j@google.com>
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1635527389.git.jonathantanmy@google.com>
 <3879e94c822421774001c823635f06235f50bfde.1635527389.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3879e94c822421774001c823635f06235f50bfde.1635527389.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 10:31:09AM -0700, Jonathan Tan wrote:
> 
> It is not used from outside the file in which it is declared.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  config.c | 12 +++++++++++-
>  config.h | 37 ++++---------------------------------
>  2 files changed, 15 insertions(+), 34 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 2dcbe901b6..94ad5ce913 100644
> --- a/config.c
> +++ b/config.c
> @@ -120,6 +120,16 @@ static long config_buf_ftell(struct config_source *conf)
>  	return conf->u.buf.pos;
>  }
>  
> +struct config_include_data {
> +	int depth;
> +	config_fn_t fn;
> +	void *data;
> +	const struct config_options *opts;
> +};
> +#define CONFIG_INCLUDE_INIT { 0 }
> +
> +static int git_config_include(const char *var, const char *value, void *data);
> +
>  #define MAX_INCLUDE_DEPTH 10
>  static const char include_depth_advice[] = N_(
>  "exceeded maximum include depth (%d) while including\n"
> @@ -306,7 +316,7 @@ static int include_condition_is_true(const struct config_options *opts,
>  	return 0;
>  }
>  
> -int git_config_include(const char *var, const char *value, void *data)
> +static int git_config_include(const char *var, const char *value, void *data)
>  {
>  	struct config_include_data *inc = data;
>  	const char *cond, *key;
> diff --git a/config.h b/config.h
> index f119de0130..48a5e472ca 100644
> --- a/config.h
> +++ b/config.h
> @@ -126,6 +126,8 @@ int git_default_config(const char *, const char *, void *);
>  /**
>   * Read a specific file in git-config format.
>   * This function takes the same callback and data parameters as `git_config`.
> + *
> + * Unlike git_config(), this function does not respect includes.
>   */
>  int git_config_from_file(config_fn_t fn, const char *, void *);
>  
> @@ -158,6 +160,8 @@ void read_very_early_config(config_fn_t cb, void *data);
>   * will first feed the user-wide one to the callback, and then the
>   * repo-specific one; by overwriting, the higher-priority repo-specific
>   * value is left at the end).
> + *
> + * Unlike git_config_from_file(), this function respects includes.
>   */
>  void git_config(config_fn_t fn, void *);
>  
> @@ -338,39 +342,6 @@ const char *current_config_origin_type(void);
>  const char *current_config_name(void);
>  int current_config_line(void);
>  
> -/**
> - * Include Directives
> - * ------------------
> - *
> - * By default, the config parser does not respect include directives.
> - * However, a caller can use the special `git_config_include` wrapper
> - * callback to support them. To do so, you simply wrap your "real" callback
> - * function and data pointer in a `struct config_include_data`, and pass
> - * the wrapper to the regular config-reading functions. For example:
> - *
> - * -------------------------------------------
> - * int read_file_with_include(const char *file, config_fn_t fn, void *data)
> - * {
> - * struct config_include_data inc = CONFIG_INCLUDE_INIT;
> - * inc.fn = fn;
> - * inc.data = data;
> - * return git_config_from_file(git_config_include, file, &inc);
> - * }
> - * -------------------------------------------
> - *
> - * `git_config` respects includes automatically. The lower-level
> - * `git_config_from_file` does not.
> - *
> - */

It is a shame to lose the comprehensive usage documentation. Can we move
it into the source near the static definition instead?

> -struct config_include_data {
> -	int depth;
> -	config_fn_t fn;
> -	void *data;
> -	const struct config_options *opts;
> -};
> -#define CONFIG_INCLUDE_INIT { 0 }
> -int git_config_include(const char *name, const char *value, void *data);

I wondered why we even had this here, if we were only calling
'git_config_include()' from config.c. The last time this definition was
touched was when it was moved out of cache.h (e67a57fc518) and the time
before that was when it was introduced in 2012 (9b25a0b52e0). At the
time of its introduction it was only called in config.c, anyways. So I
guess it is just a matter of history.

It's still a WIP so I won't leave a reviewed-by line, but this patch
looks fine.

 - Emily

> -
>  /*
>   * Match and parse a config key of the form:
>   *
> -- 
> 2.33.1.1089.g2158813163f-goog
> 
