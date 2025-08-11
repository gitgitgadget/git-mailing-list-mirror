Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E630526E71F
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942649; cv=none; b=jxcTqMkSVN5LOpks2yzyImGogXA55fWNRyJZI2m6lZkzJEmxVRIPJ8iEA4Ly7ZfmVQilAWOngbN+LMwYYQ1U79qLmRuOWhso/05YB7gE0tH3s74mOkeOCfCTN1YlI18kjVjbTUhrGQfpceuOaEfXtBUy78TiSbcVePjKHcsxRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942649; c=relaxed/simple;
	bh=WZlUidRwdcIOrN06mxOfIURgVzSDc7yibJFkFD+FRRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrmCUUrkTXBHHU6+oe7PSudZByB6Oftv4rvmYGQratWHEk4dZaUrAz6ZYK2jCvjN2TopefP26l1g2VHmgHzZNJVoNH5RzA32QGVyuSaU2of1RF89DfdsQYWkvlxSUYJOhm7BUXCrHM9AA4+qZc1P/F5BxyJoYpBNE4MLdgXmCuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae76CmsX; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae76CmsX"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c47631b4cso3222435a34.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754942647; x=1755547447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpzLjnH8NGXmsbd6cqBFNVLh2wASTfNKN/p+A1+UNa8=;
        b=Ae76CmsXWioLCQDDerIZObB8F+98zmN9YMA0H1D/tqBtoYNny4v/Q593hlFv5nbDk+
         kjZqVlazMk2Sy0ZV175ISd8dAOAVajv9lCc5DMg1aSciRybsV5t+STRwlU7uFgxuX3bF
         b5Saw2sXYADCkaBBaUbJiL8+vyOEfxEXRcPjhL9hH4coS3G+NPGDWSG5WYjHW6OfhhtA
         c9jvdgxubIcKOm7zc2QLLsKBvApY1dDcYWzEH9mZ66WZpTw8sK33jegnINi4JtvpVpy/
         sGhF5w+sl3oLaLtLGXfRaIHYyzNvODYo2WNVwLgTRIsvZe8SHntCSjfQBr3iItcYA0tg
         6oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942647; x=1755547447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpzLjnH8NGXmsbd6cqBFNVLh2wASTfNKN/p+A1+UNa8=;
        b=RrVpy0yovHLYGgdkwd73snrvdgF3RDPz+nV34qCKZxGE+jK3Y3zWuqYkPkhH4xI+32
         2LAwpy3TRQDibfeWKMuNJFT6eBYdO4PeKTGgbuD5iSm3PWsmwtruPyMRmGqAkhtA2y8Q
         CFPZeQOWqCeS5N/JsISCmrt97kdHAFUGuzH7u1Dp5uq+r208S3JqYgq2X5AwHnQBFlHM
         bDAy05rC1oC6lyI/gcgn+b45IeM2yu7ouhlGm1DsK16+b5PGW2Jzp5HbMWFcBDvmi/cu
         lBeWho8Vbn5A/rduU5487d0LyylvYgl2WkQ1tmCMu0Tj3WQjwcRegklj+nrSU82uqe0C
         PfeQ==
X-Gm-Message-State: AOJu0Yyv6tFN/Dt8KSId3xWVtUoNO0XXonZOwp1YnQNTGPSHUeTtdwSr
	qOMe02bRmXBE2DXiXfZEYgSYCRfxOvArAULabJ8gXkEuWERWh1ZKihVqrGTUi/oK
X-Gm-Gg: ASbGnctnFENBJe9QWo0hmDpuvseCszZKA4tfRfgX9rZbQUnaqlWlWJOLl8NTy3YwPnC
	aZe65Yhoz8DIdF+gvbfjhC9fUc4DYT8F74VWP7ZWxYF1xjJ73vriF3yRxXgMIwMZPMSEWTPSLxe
	sMeSYpA50XGGEqXiP+iTDMhHHTk3vgnVB8ZCdEqt26qRhhi3WswnpB4LfxQj3xNQPceTFJQVSP2
	cDo6XU5Ck/6t2FoQx1BE/v2BomxkqCcaEQFDK7MxU4+Un6C1L0Cl/CRhCDcLkWXapejfdYvuVK4
	bZF/TDbYzx3oc4lNDw/YmKCzngvmdUWnu0xh8E0n048cRLeKUY8ChLsQoaFXkT/ufWnCdTbxgvN
	N2Cl9PeGZ/1CfGJQ=
X-Google-Smtp-Source: AGHT+IH85PnRApedQ3W6VRtFHJaTGb/TV1EK4CspxYNowFlbX3FOIzwHhjobDXUeSOGJhbV8X0M2dw==
X-Received: by 2002:a05:6808:1446:b0:435:6f4c:8b1e with SMTP id 5614622812f47-43597b4268bmr7956737b6e.6.1754942646834;
        Mon, 11 Aug 2025 13:04:06 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-434131af52dsm3604793b6e.18.2025.08.11.13.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:04:05 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:04:05 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 6/6] reftable/stack: handle outdated stacks when
 compacting
Message-ID: <3vkwdsqcas22um2djaic43ntapedwz4wqnrrnhvhngqdul2vmj@2rwfqngzyuup>
References: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
 <20250804-pks-reftable-fixes-for-libgit2-v2-6-fef06209a984@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-pks-reftable-fixes-for-libgit2-v2-6-fef06209a984@pks.im>

On 25/08/04 11:40AM, Patrick Steinhardt wrote:
> When we compact the reftable stack we first acquire the lock for the
> "tables.list" file and then reload the stack to check that it is still
> up-to-date. This is done by calling `stack_uptodate()`, which knows to
> return zero in case the stack is up-to-date, a positive value if it is
> not and a negative error code on unexpected conditions.

So `stack_uptodate()` returns a negative value for error cases and a
positive value if the stack is out of date. `REFTABLE_OUTDATED_ERROR` is
really also an error, but it is special cased to differentiate it from
the others.

> We don't do proper error checking though, but instead we only check
> whether the returned error code is non-zero. If so, we simply bubble it
> up the calling stack, which means that callers may see an unexpected
> positive value.
> 
> Fix this issue by translating to `REFTABLE_OUTDATED_ERROR` instead.
> Handle this situation in `reftable_addition_commit()`, where we perform
> a best-effort auto-compaction.
> 
> All other callsites of `stack_uptodate()` know to handle a positive
> return value and thus don't need to be fixed.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index f77d7f58e8..effa2fc8cb 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -579,9 +579,11 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
>  	return err;
>  }
>  
> -/* -1 = error
> - 0 = up to date
> - 1 = changed. */
> +/*
> + * Check whether the given stack is up-to-date with what we have in memory.
> + * Returns 0 if so, 1 if the stack is out-of-date or a negative error code
> + * otherwise.
> + */
>  static int stack_uptodate(struct reftable_stack *st)
>  {
>  	char **names = NULL;
> @@ -849,10 +851,13 @@ int reftable_addition_commit(struct reftable_addition *add)
>  		 * control. It is possible that a concurrent writer is already
>  		 * trying to compact parts of the stack, which would lead to a
>  		 * `REFTABLE_LOCK_ERROR` because parts of the stack are locked
> -		 * already. This is a benign error though, so we ignore it.
> +		 * already. Similarly, the stack may have been rewritten by a
> +		 * concurrent writer, which causes `REFTABLE_OUTDATED_ERROR`.
> +		 * Both of these errors are benign, so we simply ignore them.
>  		 */
>  		err = reftable_stack_auto_compact(add->stack);
> -		if (err < 0 && err != REFTABLE_LOCK_ERROR)
> +		if (err < 0 && err != REFTABLE_LOCK_ERROR &&
> +		    err != REFTABLE_OUTDATED_ERROR)
>  			goto done;
>  		err = 0;
>  	}
> @@ -1215,9 +1220,24 @@ static int stack_compact_range(struct reftable_stack *st,
>  		goto done;
>  	}
>  
> +	/*
> +	 * Check whether the stack is up-to-date. We unfortunately cannot
> +	 * handle the situation gracefully in case it's _not_ up-to-date
> +	 * because the range of tables that the user has requested us to
> +	 * compact may have been changed. So instead we abort.
> +	 *
> +	 * We could in theory improve the situation by having the caller not
> +	 * pass in a range, but instead the list of tables to compact. If so,
> +	 * we could check that relevant tables still exist. But for now it's
> +	 * good enough to just abort.
> +	 */
>  	err = stack_uptodate(st);
> -	if (err)
> +	if (err < 0)
>  		goto done;
> +	if (err > 0) {
> +		err = REFTABLE_OUTDATED_ERROR;
> +		goto done;
> +	}

I was thinking that maybe `stack_uptodate()` could maybe handle
returning the `REFTABLE_OUTDATED_ERROR` directly so we could avoid
having to map the error here. This could require callers to check for
`err == REFTABLE_OUTDATED_ERROR` instead of `err > 0`. Probably not a
big deal either way though.

Otherwise this looks good to me :)

-Justin

>  
>  	/*
>  	 * Lock all tables in the user-provided range. This is the slice of our
> 
> -- 
> 2.50.1.723.g3e08bea96f.dirty
> 
> 
