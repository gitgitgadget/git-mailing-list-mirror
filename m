Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CEB1ACED5
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716976; cv=none; b=NB//wLSV3GyUBAZLDCmhUjX1cC2UBfWUGoGbCmcQCv1zKxFPTBuUhS/nKjI2Bzgr05cswjL51INoeq4hLBb5GqjE0khVVvEAdxIJlL5hPiO10zkqXtDitqqSOc2YrzFH/Llg8Xk/mYRnaW3SNgvH/O1Fq7Wu3sCkcCARoMt6bGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716976; c=relaxed/simple;
	bh=wK8qU6Yhjjpp6A8uoTrmbjPU1TOZ+9bseQiJlphkNJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hS+f5ItKvgYxpDFAc/GMf1dVfLJ2oj1tx2kzQt2I0hD+sXqiLEnQDFT8EV//+y7ux8HLKE/NNcFhwFXduRJH3ocDBhBavEq2UXIcF1r3Ivh26ORmdl1H0Kn5BAgU3/Yqmd6JciuUt1jIpfaEKaIpc9uTxz73b+Cnomk48aPHaj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4WWrW0A; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4WWrW0A"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-48670d35a87so846512b6e.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781716974; x=1782321774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o837Mp6/lPGzBKP2hiUhwtCuiM6Q+8ciQw8TRCfQxWo=;
        b=q4WWrW0ABVp4H4xwlDkH4O4D3HuEyiwN14CQBdJQiR5gqMbc9/3dhSvMcXEgzNOTj3
         5j+6rOEL7C07rQDfxf09QM1c1Ci+JQ8evHsXC+gf0HngxFQph9OlwOJCkCqiVtUW//WV
         XBM7y5z26OgrogIm5NiwYFk+RETlHwO5oDAgMG48xyujLf3MhYzhukGIyek0+Tbkf8BF
         bMpLWKo7ErWQQMzu9UdwlkanOykAMyvNhX7mtRnPZW1cL7g/p0GS0obvrdUNHwf6suXE
         0TiZ58CF1+0NJo+rSMzBMns0Jce59JoW/vA2TfO4QqKQ6kmZ6LGRwJEq+hezZOzk4ogw
         L/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716974; x=1782321774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o837Mp6/lPGzBKP2hiUhwtCuiM6Q+8ciQw8TRCfQxWo=;
        b=Ud+xWY/JzrcI7HqXfFK14kOX1dJ6xFVKOmS61pY/OcbjOHMU0S19/AbAcva3AqYPpa
         0XeMNJtMiq3VnAlpkctbbRT6+JiCXmtIJBw5SMaYzYMm8/vRVr7msgmntAe8Tfo0vMEz
         gDEHVVlzzV0PXzcQrscsGGEE3iHxjLw9b1+S33Tjm59UOuTMGyMtlHSu/WVFvyj+td9E
         qGIz3Ip6P3Fra6MPWEwsGdB4s5PYxdt5gBQh9uZ3OUhoKqFaFrRyzYtni7F2JXZyq5m2
         Pa9uifRMWvEdbPkjTNjddgZXp80UXTHbsQSd3GpPT9oFwv3tYLdAi90Ti/fBScCYz5NF
         4llw==
X-Gm-Message-State: AOJu0YzivFmcwRLJLtHIhTpgvtX9Pm2V7l0IaS6i+FHhjz4tdVWcZsDQ
	mwA0kXGfZwtA9ZI6+ngf+dZo8ZqmOGAi7rXwzNp2mf2jzDdzIt6mc0Tz
X-Gm-Gg: Acq92OFHEyMoVH9/15zg0v+1/ANKA5qHoGNhhKS6KYE061Yyhr0xcSSR+/67k4x8Sjj
	eT5v/kDwV0z6JNl0YmSksUc8BbvJPoKz70lQsc7Dy2J4DxOR5/wL1yR5QoCzLw116yyE/hJI094
	m97yOPv3JIx+LYCYP6DAeuDdpE0wZF69Yp5wbJmOWSeEIjvfWyap39DPJZQCAWte+SWmo0TaZTj
	Zf6u/1ussRjPGr4MhwajU+MVpT+ey1TUvisbtmYDHCSzcWFG+HlCyL1K+0lnF+6uEEtBsg/q4E1
	Abz9BpAC8MyTsfvh1QWrvC9IXBelmyCthp0rkzPB2WUntlG/h8sdZvh9MJ5WiMZ+qoY3CTHgdHf
	Y7c42JEnmoPjFEiddDkcyX94Ruu6TCsQVEOHtYVOuXDJFu3Ge6IiPVVlLm7n3/5ZgPD7A5SNpLR
	iOqbpimQ==
X-Received: by 2002:a05:6808:118e:b0:485:724c:36fa with SMTP id 5614622812f47-48955e5364bmr291049b6e.0.1781716974098;
        Wed, 17 Jun 2026 10:22:54 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6de65bsm9724234a34.19.2026.06.17.10.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:22:53 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:22:50 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/8] setup: stop applying repository format twice
Message-ID: <ajLV1if5XYO-pyNb@denethor>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-2-f4854aa99859@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-2-f4854aa99859@pks.im>

On 26/06/15 03:56PM, Patrick Steinhardt wrote:
> When discovering the repository in "setup.c" we apply the final
> repository format multiple times:
> 
>   - Once via `repository_format_configure()`, where we apply the hash
>     algorithm and ref storage format to both `struct repository_format`
>     and `struct repository`.
> 
>   - And once via `apply_repository_format()`, where we apply these two
>     settings from `struct repository_format` to `struct repository`.
> 
> With the current flow both of these are in fact necessary. But this is
> only because we call `repository_format_configure()` after we have
> called `apply_repository_format()`. Consequently, if we only changed the
> repository format in `repository_format_configure()` it would never
> propagate to the repository.

Ok, so because `repository_format_configure()` is invoked after the
repository format was already applied, it had to explictly configure the
repository as well.

> Refactor the code so that we first configure the repository format
> before applying it to the repository so that we can stop setting the
> hash and reference storage format multiple times.

Makes sense. Sounds like a good change.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  setup.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/setup.c b/setup.c
> index a9db1f2c23..2748155964 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2710,8 +2710,7 @@ static int read_default_format_config(const char *key, const char *value,
>  	return ret;
>  }
>  
> -static void repository_format_configure(struct repository *repo,
> -					struct repository_format *repo_fmt,
> +static void repository_format_configure(struct repository_format *repo_fmt,
>  					int hash, enum ref_storage_format ref_format)

We now only care about configuring the repository format and will let
`apply_repository_format()` handle setting the repository. Looks good.

[snip]
> @@ -2830,10 +2825,10 @@ int init_db(struct repository *repo,
>  	 * is an attempt to reinitialize new repository with an old tool.
>  	 */
>  	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
> +	repository_format_configure(&repo_fmt, hash, ref_storage_format);
>  	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
>  		die("%s", err.buf);
>  	startup_info->have_repository = 1;
> -	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);

`apply_repository_format()` already has the logic to set the hash algo
and ref storage format from the repository format, so change changing
the order here is ok and a good change.

-Justin
