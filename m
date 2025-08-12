Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1C305E08
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018328; cv=none; b=mGP50fYCP/gnpBQeHI2RhpTkiIwq+hPhrE4Mu2R5+C8NHUr3mStiY9n7C14TBnyYconJAl2M5bqtS0yV/4b/fjJkVWGB4XvAgB5rQCQLRqQjOY0ZxcrNvYCKjLezottu4pHlvBQ3GWnb48HyChEgQpsxfgZUE9eQKgcPgIjNsKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018328; c=relaxed/simple;
	bh=1p2i5KRi7eQ3ESJMbPY/V9HUqQNGg29TBycIUtNfAf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuF9bW8UtgB7h8J6NQgU5iiz07R57W2G4xHRfOf+sHZIMDX1HQJpXynWtj6fFPllzgt7JMsgQ7hOl1MSmBfvAjZNagvQ9xKhYXiESG/+c/3bTJsy81fPJMq66reQM9J98WHAkb9oxh5TXbZXcaNc4ojNhTXECAqDfFTvfRuQNCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIwhlUPv; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIwhlUPv"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61b50eddbc8so2397674eaf.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018326; x=1755623126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj60eioOa23D9i7DaY57jJ1ZJaTusVYEQR48zZJAmaw=;
        b=iIwhlUPv07uO6AeyjMWeofwBpWFdzh0Hb4JPV5Rn5D11/GNuFSE1Bi+P+lmsks7HbA
         913usuCT3ybxQdBr0ZO8ZVeJF2x+gMDpxOP2QGCb4p8F4qP5hljZgMvqUL2sBSd4ls3f
         /bkazZ77tYdQHDqHW3RBzncFw3HPUrM0Xslc0kEPOKSPw+7I/qdz7qVDoonliUNC5b6r
         R8kVJQdaiMne9PF27mOV/eOfZGefB/bEwqHl7TbwnbWQdUsyo4TogOVW5eq8AMcPADL7
         5jpU50LOcOw1qS8CXxHdnVXKVfkXtN2Bjs9XUDfAAT2uwRxoGVsSTSlG4oDuQb7y6OPg
         HCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018326; x=1755623126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cj60eioOa23D9i7DaY57jJ1ZJaTusVYEQR48zZJAmaw=;
        b=IIk/5oFukc5Hc5sa4g+IqgF2nW5TU+tF4Ch4QI3a7qXAzfCCRG75mxcyaYG94JRied
         ZyoG5Gw2QshtHWnRhDqTtlEyXnf/dA6YWZHDR9FU5n/badnAhidGh8D8lot6BbfrlhK4
         gumOGPT9xOEudzW0ez8cY/ZLorvjcy6/sMu8T5P6QJqeKuxkj/QJDJRZ8Pv0DuSkeWb7
         wMP1B9oa7dJ2Dp60rjbeMA0FzA1AXBtXMdbZTsli4IM2ep7awxATzbdcXzeQuVs3Rib/
         wwrBoJT5A0QyVdpWNC8RK0U1QYIlLV635RS1cgnxE3JSBaQU32LEdRdd6RGvH1Hij41S
         5iSg==
X-Gm-Message-State: AOJu0YxssKNLCmNpnn73nSPxlAVoXH15tHiQc0Lgujd5zVb4H5xRgTjO
	HK5LxeRiI1QL/rov2L2lXALLHUrM5SN3jG8e8eyOarwOiXa7nbiEjnDb
X-Gm-Gg: ASbGncur9pNP5BUbMXTiuNVq1FmAGerM8qZckMDniD1WD5T19LJJ509/9ARRe5S2dBv
	gFow3FJ9jGeZ1fqtQxeVngxiSTwXmrlb7ckcDJKg/7IcJVl9RCTUWoXcqYVxJMHluY3XolI2a20
	nXZklATIYw1SLFFKlEUhoRmLl4OMjfNz62Fngjji5nG0Z6ZljOUGyp4MQs4h4nNZ35j2jEkOalO
	BnEroTlpbREHJJnnosUOuaTp9qHtd6E4H6W3cREpwpn5wE0BgXcr6vtqD32TJ3YGgKIzkT4JLCc
	gNooLEKU5To9qBe4FFjOPgKYMCEmlOXDxxPJ6KQZvrgHrXQacCNvq9sXtNb44n5UEmbMDDCokKz
	YYquagTM0eNbPwLs=
X-Google-Smtp-Source: AGHT+IHTrbWBhSuUdVmaWkCJ5HYwaF01ViSYAGLxB0Of3T2jCrtm7isShHGts813WzChpjFxUpoi7w==
X-Received: by 2002:a05:6820:16aa:b0:61b:931a:a9a5 with SMTP id 006d021491bc7-61bc45ffe0bmr339501eaf.4.1755018325990;
        Tue, 12 Aug 2025 10:05:25 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-61b7caa0a42sm1343596eaf.24.2025.08.12.10.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:05:25 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:05:25 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Junio C Hamano <gitster@pobox.com>, Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v3 7/8] reftable: don't second-guess errors from flock
 interface
Message-ID: <ckadsyx65an4seplaytey5fd3mdfwc3pnbtlpkslulod76l3s4@56mra6ydeg2p>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
 <20250812-pks-reftable-fixes-for-libgit2-v3-7-cf3b2267867e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-7-cf3b2267867e@pks.im>

On 25/08/12 11:54AM, Patrick Steinhardt wrote:
> The `flock` interface is implemented as part of "reftable/system.c" and
> thus needs to be implemented by the integrator between the reftable
> library and its parent code base. As such, we cannot rely on any
> specific implementation thereof.
> 
> Regardless of that, users of the `flock` subsystem rely on `errno` being
> set to specific values. This is fragile and not documented anywhere and
> doesn't really make for a good interface.
> 
> Refactor the code so that the implementations themselves are expected to
> return reftable-specific error codes. Our implementation of the `flock`
> subsystem already knows to do this for all error paths except one.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c  | 37 ++++++++-----------------------------
>  reftable/system.c |  2 +-
>  reftable/system.h |  4 +++-
>  3 files changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index af0f94d882..f91ce50bcd 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -698,14 +698,9 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>  
>  	err = flock_acquire(&add->tables_list_lock, st->list_file,
>  			    st->opts.lock_timeout_ms);
> -	if (err < 0) {
> -		if (errno == EEXIST) {
> -			err = REFTABLE_LOCK_ERROR;
> -		} else {
> -			err = REFTABLE_IO_ERROR;
> -		}
> +	if (err < 0)
>  		goto done;
> -	}
> +
>  	if (st->opts.default_permissions) {
>  		if (chmod(add->tables_list_lock.path,
>  			  st->opts.default_permissions) < 0) {
> @@ -1212,13 +1207,8 @@ static int stack_compact_range(struct reftable_stack *st,
>  	 * which are part of the user-specified range.
>  	 */
>  	err = flock_acquire(&tables_list_lock, st->list_file, st->opts.lock_timeout_ms);
> -	if (err < 0) {
> -		if (errno == EEXIST)
> -			err = REFTABLE_LOCK_ERROR;
> -		else
> -			err = REFTABLE_IO_ERROR;
> +	if (err < 0)
>  		goto done;
> -	}
>  
>  	/*
>  	 * Check whether the stack is up-to-date. We unfortunately cannot
> @@ -1272,7 +1262,7 @@ static int stack_compact_range(struct reftable_stack *st,
>  			 * tables, otherwise there would be nothing to compact.
>  			 * In that case, we return a lock error to our caller.
>  			 */
> -			if (errno == EEXIST && last - (i - 1) >= 2 &&
> +			if (err == REFTABLE_LOCK_ERROR && last - (i - 1) >= 2 &&
>  			    flags & STACK_COMPACT_RANGE_BEST_EFFORT) {
>  				err = 0;
>  				/*
> @@ -1284,13 +1274,9 @@ static int stack_compact_range(struct reftable_stack *st,
>  				 */
>  				first = (i - 1) + 1;
>  				break;
> -			} else if (errno == EEXIST) {
> -				err = REFTABLE_LOCK_ERROR;
> -				goto done;
> -			} else {
> -				err = REFTABLE_IO_ERROR;
> -				goto done;
>  			}
> +
> +			goto done;
>  		}
>  
>  		/*
> @@ -1299,10 +1285,8 @@ static int stack_compact_range(struct reftable_stack *st,
>  		 * of tables.
>  		 */
>  		err = flock_close(&table_locks[nlocks++]);
> -		if (err < 0) {
> -			err = REFTABLE_IO_ERROR;
> +		if (err < 0)
>  			goto done;
> -		}
>  	}
>  
>  	/*
> @@ -1334,13 +1318,8 @@ static int stack_compact_range(struct reftable_stack *st,
>  	 * the new table.
>  	 */
>  	err = flock_acquire(&tables_list_lock, st->list_file, st->opts.lock_timeout_ms);
> -	if (err < 0) {
> -		if (errno == EEXIST)
> -			err = REFTABLE_LOCK_ERROR;
> -		else
> -			err = REFTABLE_IO_ERROR;
> +	if (err < 0)

Now we no longer rely on errno to determine the correct err to return.
Nice.

>  		goto done;
> -	}
>  
>  	if (st->opts.default_permissions) {
>  		if (chmod(tables_list_lock.path,
> diff --git a/reftable/system.c b/reftable/system.c
> index 1ee268b125..725a25844e 100644
> --- a/reftable/system.c
> +++ b/reftable/system.c
> @@ -72,7 +72,7 @@ int flock_acquire(struct reftable_flock *l, const char *target_path,
>  		reftable_free(lockfile);
>  		if (errno == EEXIST)
>  			return REFTABLE_LOCK_ERROR;
> -		return -1;
> +		return REFTABLE_IO_ERROR;
>  	}
>  
>  	l->fd = get_lock_file_fd(lockfile);
> diff --git a/reftable/system.h b/reftable/system.h
> index beb9d2431f..c54ed4cad6 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -81,7 +81,9 @@ struct reftable_flock {
>   * to acquire the lock. If `timeout_ms` is 0 we don't wait, if it is negative
>   * we block indefinitely.
>   *
> - * Retrun 0 on success, a reftable error code on error.
> + * Retrun 0 on success, a reftable error code on error. Specifically,

Not a new typo, but we could fix it:

s/Retrun/Return/

> + * `REFTABLE_LOCK_ERROR` should be returned in case the target path is already
> + * locked.
>   */
>  int flock_acquire(struct reftable_flock *l, const char *target_path,
>  		  long timeout_ms);
> 
> -- 
> 2.51.0.rc1.163.g2494970778.dirty
> 
