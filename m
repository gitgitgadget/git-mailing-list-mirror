Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B62E410
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711222096; cv=none; b=jRbjeM9Yveu/9JZLnTsaz4dIYfpRpADjcFm0FSLVWXmA+6uHBZMSIaiXQ1NBmhLNS67pD5xIwgENrSEpDH4Rh9EAg8IaaBh22A3GKYfaul7mPmDPwUdD+35HZ3gYw66GgG7BRTUELs9sH5fIlhzaoEp1owd7OJR5L310DAOIvBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711222096; c=relaxed/simple;
	bh=gxStqiw+eYl1OMJwQflN2vfTCWZPHiM9OOVnZvoKWg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vvp4LolDyJKhJZqccjQl6pWPI2EdYflviVFneuB06gq/u9JrPRbPid74+NpmDe9rsuVZKpvwQKS046CijHMUcInVe+YihtUDvOBYcvjkYLaObO3L0CsdY4T8yxTGOYrEOFuvc3KaWqDCa3cFrXzCFK4wwR5WUx0wtybar3GmClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cyKpDdvO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyKpDdvO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29fbe140c24so2243573a91.0
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711222093; x=1711826893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdTcAyUMyJnlEXEGk8QxWJKFD+dIS4DeWy41lwSecsM=;
        b=cyKpDdvOLovF9w/IbWtA0tppmWkg5ISg7afUvxokm8DscO6BRBiuegtX+RZMgcvH29
         RbzVZDSQB2Ab0wHGsiMp1XiPZkNEEUyjPyBGIyvpXfOII8GbpCl8IuLwWYIlPQHRksYy
         Bozrz2uGi0hsXLwd9tuOR7P/V5Y/Nn70EIB5QmiVK/Ihp7fK7pP6nV/F95d0VInKUJoK
         1XlXsEjQPkIjFgZv3tXzEzBImwYsLu7girH1t7K3XRb1BYIvOkx6FVOgEThbIRoZTiUz
         pKKSorSCAzk2DjOUukj2z4QyNkXZ8JlyFCMKwBuYuHiQPQygH6ZEPNaWUZIhj6EzwQPy
         LdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711222093; x=1711826893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdTcAyUMyJnlEXEGk8QxWJKFD+dIS4DeWy41lwSecsM=;
        b=lAEq8UlqGb01X8+v4ZPUBrvB2HRRVroBVFRF/UdkiDIpvcKHCEf/PLPi5uZO+l+GlD
         GU4BrcTvD7t1TqEeX1PMyVZ56Cj3m0p9K85eSe6Kv83U0cxdYimNAWgW54p5zdB3aJDW
         w40Ay8FG0DPro5m586qkEnkneL8Lyf8a8YyefIGyfejrTuYrKrwS8G6mRn2efy82Of2N
         5z+6sizhJboMBCKvit15EdIu6ZkVmrco3kYm2y42/nKo9MXMKD6K2uTdJkKatT3nkczc
         x4mu3h2/oc524R0SmOhu0z04Vd5FbfEjh52qnoeu0dxeRynT0vmF+GfZaO+A9C+YMHVr
         1JRg==
X-Gm-Message-State: AOJu0YwBD0D/1QnIrBdfVgpg7qASxcaOgJo61IFnbVfUFHWHEaqU5A4b
	Bt61dYBLGD7XXnLs8Se9ZqP8FPlKBd0EQlmim6z2Gfg1tKIS9XH8AevKI46kIA==
X-Google-Smtp-Source: AGHT+IEYPyq6AFaxbhZ8ZD9UJpPA4wrxwaZ8piY9sG0C/XeWFIm8CC5oCqUpnzz9XiUWYJbwFjG6Wg==
X-Received: by 2002:a17:90a:e2c9:b0:29f:8b48:b390 with SMTP id fr9-20020a17090ae2c900b0029f8b48b390mr2327630pjb.16.1711222093227;
        Sat, 23 Mar 2024 12:28:13 -0700 (PDT)
Received: from google.com (144.44.83.34.bc.googleusercontent.com. [34.83.44.144])
        by smtp.gmail.com with ESMTPSA id cp5-20020a17090afb8500b0029c472ec962sm7558233pjb.47.2024.03.23.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 12:28:12 -0700 (PDT)
Date: Sat, 23 Mar 2024 12:28:09 -0700
From: Kyle Lippincott <spectral@google.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 1/5] MyFirstObjectWalk: use additional arg in
 config_fn_t
Message-ID: <2jc6piaupfi33npe6kpjo6ij46ioyofoimdybc7budsgmvyp7b@ttbhwbyv6xgz>
References: <cover.1710840596.git.dirk@gouders.net>
 <babf04295ee461a5c37574a032c6bc105bb1f31e.1710840596.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <babf04295ee461a5c37574a032c6bc105bb1f31e.1710840596.git.dirk@gouders.net>

On Tue, Mar 19, 2024 at 12:23:11PM +0100, Dirk Gouders wrote:
> Commit a4e7e317 (config: add ctx arg to config_fn_t) added a fourth
> argument to config_fn_t but did not change relevant function calls
> in Documentation/MyFirstObjectWalk.txt.
> 
> Fix those calls and the example git_walken_config() to use
> that additional argument.
> 
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---
>  Documentation/MyFirstObjectWalk.txt | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Looks good, thanks.

> 
> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> index c68cdb11b9..cceac2df95 100644
> --- a/Documentation/MyFirstObjectWalk.txt
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -210,13 +210,14 @@ We'll also need to include the `config.h` header:
>  
>  ...
>  
> -static int git_walken_config(const char *var, const char *value, void *cb)
> +static int git_walken_config(const char *var, const char *value,
> +			     const struct config_context *ctx, void *cb)
>  {
>  	/*
>  	 * For now, we don't have any custom configuration, so fall back to
>  	 * the default config.
>  	 */
> -	return git_default_config(var, value, cb);
> +	return git_default_config(var, value, ctx, cb);
>  }
>  ----
>  
> @@ -389,10 +390,11 @@ modifying `rev_info.grep_filter`, which is a `struct grep_opt`.
>  First some setup. Add `grep_config()` to `git_walken_config()`:
>  
>  ----
> -static int git_walken_config(const char *var, const char *value, void *cb)
> +static int git_walken_config(const char *var, const char *value,
> +			     const struct config_context *ctx, void *cb)
>  {
> -	grep_config(var, value, cb);
> -	return git_default_config(var, value, cb);
> +	grep_config(var, value, ctx, cb);
> +	return git_default_config(var, value, ctx, cb);
>  }
>  ----
>  
> -- 
> 2.43.0
> 
> 
