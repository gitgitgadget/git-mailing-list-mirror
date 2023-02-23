Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5B8C64ED6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 22:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBWW6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 17:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBWW6A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 17:58:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4291630D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 14:57:58 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id q11so15148980plx.5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 14:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iud4g/afUxTKgn87Vdj1fCbvL2XPfFapL1M92pPT8Qo=;
        b=hKYRVGKQs1ZVvWFr+gsl/MmnhAtY3oxHCiwKfScX0R671YFDXKqFntIOSNB4sleZwb
         ukTmxmccF4yLwa66FrD0VT9L+c/UNd6Z8MpfvSecGsEftljO9vvm42O588SNLR8Bb+cx
         Q8AQS9dOxzYkA02Owf86hoKdIbVIWpZOjXdgUvGiCcaLdMWyOwINfGpXPF70kPNyHssp
         nUS8oGxh9VZ0gfVwlxcPYceT8cEfD+ADXBwD+/FDWtxDu5E7IKLjoNUfIsI4Wp9u9ZcS
         8zrKayFfHq7DF+JDedoVPUswSpg8tbN7zow+PuRgAOgj+HALGwSqYaRBJfDvDUDcHls3
         DZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iud4g/afUxTKgn87Vdj1fCbvL2XPfFapL1M92pPT8Qo=;
        b=c+jZTXDSbliccErCAUyUB6x1mDsBn3MEE0WdImloCTswp9VkgLngs/Tk3vRZ7pPM+0
         hfZcHNdl1R00yAm35R1lwg18yQnW8FQUeGksGCjfHTZ9dGBW9xRVqTOChWM0MThR3U25
         M+2qaTKf1IGkxlXIWvtN/ArggWgSoGdAGzT8B7LgdBLkfzbYmDJN2BYfBpJLc+gYTKLj
         42KcOn/rjpUv/i72iKk8aF1dxI0zAxpP3vRxV/FkTL+HF7wNT00a6LV0W2dptHmAioEr
         51OIEaNALBR3RVioKTGyjbGDVmTlfpeMVhyvlz1UWjwJHrYT2rrlXaFMCWcGKTKUkCvc
         pVow==
X-Gm-Message-State: AO0yUKXogNECVKL7PuhI/4XJHYkfAqr+aPuLTVvQssgKxvs5BB+G2CdJ
        I45BwZMMB23wT703N5VQVGY=
X-Google-Smtp-Source: AK7set+4IyvDBiFx7sBJCOpGubHKeh609cJ6SR0PmvwygTLSk77Ass8iMKLvfwrTS7DhQAjhSce1PQ==
X-Received: by 2002:a05:6a21:6d81:b0:be:da0c:fc62 with SMTP id wl1-20020a056a216d8100b000beda0cfc62mr14689603pzb.38.1677193078028;
        Thu, 23 Feb 2023 14:57:58 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 10-20020aa7914a000000b0058bacd6c4e8sm1972548pfi.207.2023.02.23.14.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 14:57:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/config-multi-and-nonbool (was Re: What's cooking in git.git
 (Feb 2023, #04; Wed, 22))
References: <xmqqbkllaxd7.fsf@gitster.g>
        <kl6lfsaw84vo.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 23 Feb 2023 14:57:57 -0800
In-Reply-To: <kl6lfsaw84vo.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 23 Feb 2023 13:10:35 -0800")
Message-ID: <xmqqa61456ru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I would prefer to eject 06/10 [1] for now and leave it in for a future
> cleanup series. I haven't confirmed whether it's safe (the practical
> effect of that patch is that the *_get() functions can now return -1
> instead of 1, so the patch is safe if all callers only check if the
> return value is zero, and not whether it has a particular sign), and I
> don't think 06/10 is absolutely necessary to the series.

If somebody wants to help auditing potential breakage the patch in
question causes, "are callers happy to declare an error upon
non-zero return?" is not exactly sufficient.  While all of these
functions return 0 upon success, some of them return 1 on certain
cases while error() on other cases, and we need to ensure that the
callers are not behaving differently upon these values.

So let's see how many functions does the patch in question touch.

> diff --git a/config.c b/config.c
> index 1f654daf6f..74d453f5f9 100644
> --- a/config.c
> +++ b/config.c
> @@ -2449,86 +2449,93 @@ int git_configset_get(struct config_set *cs, const char *key)
>  int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
>  {
>  	const char *value;
> -	if (!git_configset_get_value(cs, key, &value))
> -		return git_config_string((const char **)dest, key, value);
> -	else
> -		return 1;
> +	int ret;
> +
> +	if ((ret = git_configset_get_value(cs, key, &value)))
> +		return ret;
> +	return git_config_string((const char **)dest, key, value);
>  }

This used to return 1 when there is no such value, and get whatever
error signal git_config_string() gave if git_config_string() failed.

Luckily, git_configset_get_value() returns 1 when there is no such
value, so I think this hunk is an expensive-to-audit no-op.

>  static int git_configset_get_string_tmp(struct config_set *cs, const char *key,
>  					const char **dest)
>  {
>  	const char *value;
> -	if (!git_configset_get_value(cs, key, &value)) {
> -		if (!value)
> -			return config_error_nonbool(key);
> -		*dest = value;
> -		return 0;
> -	} else {
> -		return 1;
> -	}
> +	int ret;
> +
> +	if ((ret = git_configset_get_value(cs, key, &value)))
> +		return ret;
> +	if (!value)
> +		return config_error_nonbool(key);
> +	*dest = value;
> +	return 0;
>  }

Ditto.

>  int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
>  {
>  	const char *value;
> -	if (!git_configset_get_value(cs, key, &value)) {
> -		*dest = git_config_int(key, value);
> -		return 0;
> -	} else
> -		return 1;
> +	int ret;
> +
> +	if ((ret = git_configset_get_value(cs, key, &value)))
> +		return ret;
> +	*dest = git_config_int(key, value);
> +	return 0;
>  }

Ditto.

>  int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest)
>  {
>  	const char *value;
> -	if (!git_configset_get_value(cs, key, &value)) {
> -		*dest = git_config_ulong(key, value);
> -		return 0;
> -	} else
> -		return 1;
> +	int ret;
> +
> +	if ((ret = git_configset_get_value(cs, key, &value)))
> +		return ret;
> +	*dest = git_config_ulong(key, value);
> +	return 0;
>  }

Ditto.

>  int git_configset_get_bool(struct config_set *cs, const char *key, int *dest)
>  {
>  	const char *value;
> -	if (!git_configset_get_value(cs, key, &value)) {
> -		*dest = git_config_bool(key, value);
> -		return 0;
> -	} else
> -		return 1;
> +	int ret;
> +
> +	if ((ret = git_configset_get_value(cs, key, &value)))
> +		return ret;
> +	*dest = git_config_bool(key, value);
> +	return 0;
>  }

Ditto.

>  int git_configset_get_bool_or_int(struct config_set *cs, const char *key,
>  				int *is_bool, int *dest)
>  {
>  	const char *value;
> -	if (!git_configset_get_value(cs, key, &value)) {
> -		*dest = git_config_bool_or_int(key, value, is_bool);
> -		return 0;
> -	} else
> -		return 1;
> +	int ret;
> +
> +	if ((ret = git_configset_get_value(cs, key, &value)))
> +		return ret;
> +	*dest = git_config_bool_or_int(key, value, is_bool);
> +	return 0;
>  }

Ditto.

>  int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest)
>  {
>  	const char *value;
> -	if (!git_configset_get_value(cs, key, &value)) {
> -		*dest = git_parse_maybe_bool(value);
> -		if (*dest == -1)
> -			return -1;
> -		return 0;
> -	} else
> -		return 1;
> +	int ret;
> +
> +	if ((ret = git_configset_get_value(cs, key, &value)))
> +		return ret;
> +	*dest = git_parse_maybe_bool(value);
> +	if (*dest == -1)
> +		return -1;
> +	return 0;
>  }

Ditto.

>  int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest)
>  {
>  	const char *value;
> -	if (!git_configset_get_value(cs, key, &value))
> -		return git_config_pathname(dest, key, value);
> -	else
> -		return 1;
> +	int ret;
> +
> +	if ((ret = git_configset_get_value(cs, key, &value)))
> +		return ret;
> +	return git_config_pathname(dest, key, value);
>  }

Ditto.

> @@ -2775,9 +2782,11 @@ int git_config_get_expiry_in_days(const char *key, timestamp_t *expiry, timestam
>  	const char *expiry_string;
>  	intmax_t days;
>  	timestamp_t when;
> +	int ret;
>  
> -	if (git_config_get_string_tmp(key, &expiry_string))
> -		return 1; /* no such thing */
> +	if ((ret = git_config_get_string_tmp(key, &expiry_string)))
> +		/* no such thing, or git_config_parse_key() failure etc. */
> +		return ret;

This was returning -1 for an error (at the end of the function), as
well as 1 for "no such thing".  Now, this is a breaking change if
any callers wanted to tell between -1 and 1.

Luckily, I think its two callers discard the error return; they
initialize expiry to some reasonable default and rely on the fact
that the expiry is not updated when these configuration API calls
did not find anything interesting.

> @@ -2827,15 +2837,14 @@ int git_config_get_index_threads(int *dest)

You can easily find output in "git grep git_config_get_index_threads"
that all four callers only care if they get 0 or not, so this one
should be safe.

