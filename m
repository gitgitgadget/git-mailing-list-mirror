Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4F1AC8B2
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070458; cv=none; b=PL06u5/oPN0lDiV5KqwRkFJ8FTRqrmNf8fQONMxtR21OZS8erLFdnLHGztT0IzV8wT7MgUWtZkQ0iyzj476+3uI7zuNy+nnZr3pQmfU5eeALr3Le/wwFNpzhb9VNO56Hen5UU5wSoJa/Li1VYnu27Ze3eYq8ThV2qCUgRPbyalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070458; c=relaxed/simple;
	bh=wr3ZjglG1JthV13T7FfF5geb2nk6uoTPaptA39GIxP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk0I4chbheskiy841vs8sFf4BBuUr9TAHiQCohRlr23ghG8oQdYYagNO47JvgHx0x3/dzfzKweiSUAlG0Va5AxwrrzWJPOFgt31MUOUEIaR7QcxOEo5DmeSMB0mPkYsrdzGGEXLe16nOiODwInexDAg41QLI9qj8vRPakcRK278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh9Z12LI; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh9Z12LI"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e06b72f3e7so314602b6e.0
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726070456; x=1726675256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUh967056gxcTZPIBhBEbLLOdIC6Ulo7yunOvNTOwe0=;
        b=Lh9Z12LIMva/8NIpyGSHfeOeSWsXQXN4mvrGulsQV/8J0PomJ14RhdFBQNVLORfHrt
         93KIR1y5deC/wqnCUd0OfpHQmI/Dg/38FmDtMAEAj93LE+o94LKA04HUgRC+z6jB/uuh
         5bDR0oSLe6YyN8FZuP++Xqme5JDsk6SmrBZVntPyCK4H2UsE/htdgeWRTvbqQS4c7mGP
         ZUqv5BsA3xEBH4as37I3mPsYs1KLfBoNIgAHd2ZayUd3eBo1D3QAQznQs5kgYcMSW1y6
         Jk3QqrIaJofsIVVJp/UOJqvCiiHZwNEQBZMF5AkMPNPMnjF3+91tpyURL+1uwXbm7mvb
         XARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070456; x=1726675256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUh967056gxcTZPIBhBEbLLOdIC6Ulo7yunOvNTOwe0=;
        b=rhcg/QHuvvw+RkZUN0WuVf9+ZkXpe7VQ0SbS1e9PPqIe0ecvlm7Nv0y/WGC9P23KFc
         TGH0MBHDmUjHMOOy64J8j+Stns/LUUUZzm1Ysn6kV72nx8AqMLQb2LXkrCO2g8ZA7t9v
         uR+8cg+ttAGc0BTrG5JqsFy4x/vDK7OQ1jtercqTMwNi5leIhgRtMclaO/YjkeOO0sSE
         NxZJBabhUG7h/hlTFON/G3OiqWIb9lHmBCnd3aVZ3bV+/7MBLBMeFPAOlV6XwHk+zLlk
         swO4Ahn+A5E7ZrwkDn7/9kD9rpww7inu3AUDZO/JGXwx/ZAw6LXc/hIK+O5Rq25/blia
         hlCg==
X-Gm-Message-State: AOJu0YwUVEEhAlMgFiuNCwyPgztV/CAd+dZP5UxFmUjNNnEazaTV4+I7
	oAb6mVm5UnlO1TM1g3ZFxLG7o7rUwehoWGSj51MAZjhn51A4w0Lo
X-Google-Smtp-Source: AGHT+IH0QRWnSYKQthGWDSAE7L6rWwBe+jZKr4CHGTOrjqKxdiph/nKVkJPthfx2wrHxWn/7dfzodQ==
X-Received: by 2002:a05:6808:23d6:b0:3dd:1eec:6517 with SMTP id 5614622812f47-3e04e23e44cmr2850266b6e.3.1726070455607;
        Wed, 11 Sep 2024 09:00:55 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e039c059b8sm2049679b6e.43.2024.09.11.09.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 09:00:54 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:59:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/21] config: document `read_early_config()` and
 `read_very_early_config()`
Message-ID: <q4bmhi7dhadwhhuijatrpiayi7zjhrlgshcgucfp2s7uiczkth@o4jtzzqv2dmt>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <ec4804a99bf70f9a97d1faea60bd55aaa97d1b80.1725008898.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec4804a99bf70f9a97d1faea60bd55aaa97d1b80.1725008898.git.ps@pks.im>

On 24/08/30 11:09AM, Patrick Steinhardt wrote:
> It's not clear what `read_early_config()` and `read_very_early_config()`
> do differently compared to `repo_read_config()` from just looking at
> their names. Document both of these in the header file to clarify their
> intent.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  config.c |  4 ----
>  config.h | 11 +++++++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 0b87f0f9050..a8357ea9544 100644
> --- a/config.c
> +++ b/config.c
> @@ -2234,10 +2234,6 @@ void read_early_config(config_fn_t cb, void *data)
>  	strbuf_release(&gitdir);
>  }
>  
> -/*
> - * Read config but only enumerate system and global settings.
> - * Omit any repo-local, worktree-local, or command-line settings.
> - */
>  void read_very_early_config(config_fn_t cb, void *data)
>  {
>  	struct config_options opts = { 0 };
> diff --git a/config.h b/config.h
> index d0497157c52..f5fa833cb98 100644
> --- a/config.h
> +++ b/config.h
> @@ -192,7 +192,18 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
>  void git_config_push_parameter(const char *text);
>  void git_config_push_env(const char *spec);
>  int git_config_from_parameters(config_fn_t fn, void *data);
> +
> +/*
> + * Read config when the Git directory has not yet been set up. In case
> + * `the_repository` has not yet been set up, try to discover the Git
> + * directory to read the configuration from.
> + */
>  void read_early_config(config_fn_t cb, void *data);

To restate in my own words, `read_early_config()` allows a config to be
read before `the_repository` is setup by discovering the git dir itself.
Out of curiousity, what prevents us from just ensuring `the_repository`
is properly setup first?

> +
> +/*
> + * Read config but only enumerate system and global settings.
> + * Omit any repo-local, worktree-local, or command-line settings.
> + */
>  void read_very_early_config(config_fn_t cb, void *data);

Here `read_very_early_config()` looks like it only cares about system
and global configuration so it doesn't require a git dir or
`the_repository` to be set up. Makes sense.

Not really related to this change, but it would be nice if the name of
the function itself was more descript. Something like
`config_read_system_and_global()`.

Overall, I find these new comments to be very helpful. Thanks! :)
