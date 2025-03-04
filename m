Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5AF251791
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130839; cv=none; b=ePFW5EHREHvgQ4o8CWGJKnhk9yQ1BxBsPUq5WW1I0ov1Wx0r778dk6r0oLEmvbdd9+/uHgAmNLqDfWZQidFlSOvMbYiVUVTJ/mK6nZQSFNvoirOVBrZycLRxUGIKSUmcYGp9Guaoe0y+XqfVzQrEen2x/1VRv3CbETrL7yPj+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130839; c=relaxed/simple;
	bh=vpWNh0vTKbp7ezwgABMkq3dTexFnH9wzo9jd5JDQMPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1pK5i+pxFsxCiSWOWdnotty/ZIEPxMpqMlGii4uzidIwj7wgzx0pdVxtbNRpszYq9L7AP2azmqCYWSj/r1pHYw62nSseWZk/GRNFeY32P8CgmDi7/8YXjvGUj0Deoy6ijW7Hx+83ejJ0WH14QQpo35csIG4GtzpwZJj+ElC0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ6LLMxV; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ6LLMxV"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f66dfc205dso1568545b6e.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 15:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741130835; x=1741735635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAktBLQSMLy4Qk6gWu+1Vbg70PjAU+LS/b5n1k9BT0Q=;
        b=ZJ6LLMxVgNJv4jgy0D40qV8+aiCh2Kn4yhE+kfRO/NVeifV5q8JmKfUPbdm4RmcAoF
         QLzo9FKTS2dnNeOX7YwQpZgNqjfzwi5xVWcGA/I5dqyW6DueoF5SIFJldTu+EtoEhhb5
         8TapOQpLZw5dMJzyHF2SGM1c0BY+bLPxahXdbTyQ0hW+KuUTKs9lPRpqEoKJgt76Mh51
         UfjgpsD4XVyQYMqFFXnkRLv5zxNkE/K2QxwfhXi3I686wVwmUnS7+e6y3lAhXtBa31Zn
         lR1vPssi4GFb4K5ik8t+5In1ZnELk+POSGQeS/75e9SSoprr1jFfyqniBM6niCWrpiJZ
         1+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741130835; x=1741735635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAktBLQSMLy4Qk6gWu+1Vbg70PjAU+LS/b5n1k9BT0Q=;
        b=bWQSeOHM9xWQ/0F2J2uwtZpSVozYnFRuW6XvJujtHVhYonNGxUia7C1hnbg0ADRFJ0
         dcdm71O4zhBfG+TaW4itUStzVwSMWjImHleQgj2u8nmZjjWUDUDGDQ6wNP10c6d3/csq
         pDMlcvhP/zVF0fezlbUPVg4bEzEa0XMS6AklExM4/Uacg/r5G+K6eUrIxggX1HUFS6eg
         SOq9917yajZq2mxOoyRS2vvXWdVc9lGUvnTkpUNSGNj2zmbpbdXCDoqDE4t+ax80l5hY
         DhJV3sAc1EKajgtid+0uraLgKQWleab0v0rUyh8cS6Mjlb6Gcc4Iht07UoOqBFKsw+o8
         CqDw==
X-Gm-Message-State: AOJu0YxrtCFk3b+FsLt0jrdpsxsoaw/wDvEgIP7nweNE9VZiiI3jecDK
	iQclhKdBG4ttF4T+6v0nmPypTm+RMkW0zY8xgQYXjrgfK7QqsIcW
X-Gm-Gg: ASbGncvxpxG7pCJfG3HLmSOoFnRyLYuMAU0Z0JLwRFMt92wspa81NbGlS3OPqXsb63h
	eqClCSvwH+oi3FNaGjDMeeNiPoLLZr/ROjd/G9GyVA+Pso8ukfoxa3b3blhz7OwPf/QkWyUe878
	cbtuRHG3G1V1ba1OqgydzEcBhwlhquSXDNImgP5wVmhEkwM1pisbFRRY5/l4YJKvcTI3Y1uUTmK
	mSuXtvHgLJEKHiGeKTuIQ4lgRQexJlHfIW7vRLx1+vf21LAkS+u1ezY8pknY6m8guYrkwnh1w49
	c/PxPZ3ZjSPYqPRXuF6A1zMllL+HHDDUyaE0wQ==
X-Google-Smtp-Source: AGHT+IGLHmRBUIoJ4QXqvhqUTIcRQMQsxnUjnO/XCpSukAOHXVeo3y/necQafEP4pvPWfDxd5Mae+Q==
X-Received: by 2002:a05:6808:1a18:b0:3f4:1838:be72 with SMTP id 5614622812f47-3f6831f46e1mr502191b6e.28.1741130835244;
        Tue, 04 Mar 2025 15:27:15 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f67b0bfa85sm451982b6e.13.2025.03.04.15.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 15:27:14 -0800 (PST)
Date: Tue, 4 Mar 2025 17:23:53 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Markus Gerstel <2025@uxp.de>, 
	Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/6] builtin/reflog: stop storing default reflog expiry
 dates globally
Message-ID: <ammsrvhyzo6f7hfcizlh42e3e5cznfb2j37tcicliqqpqaaqgs@4mniagc5ejzz>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
 <20250226-pks-maintenance-reflog-expire-v1-2-a1204a814952@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-pks-maintenance-reflog-expire-v1-2-a1204a814952@pks.im>

On 25/02/26 04:24PM, Patrick Steinhardt wrote:
> When expiring reflog entries, it is possible to configure expiry dates
> that depend on the name of the reflog. This requires us to store a
> couple of different expiry dates:
> 
>   - The default expiry date for reflog entries that aren't otherwise
>     specified.
> 
>   - The per-reflog expiry date.
> 
>   - The currently active set of expiry dates for a given reference.
> 
> While the last item is stored in `struct reflog_expiry_options`, the

s/reflog_expiry_options/reflog_expire_options/

> other items aren't, which makes it hard to reuse the structure in other
> places.
> 
> Refactor the code so that the default expiry date is stored as part of
> the structure. The per-reflog expiry dates will be adapted accordingly
> in the subsequent commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/reflog.c | 22 +++++++---------------
>  reflog.h         |  6 ++++++
>  2 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index dee49881d32..0910a4e25dc 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -63,9 +63,6 @@ static const char *const reflog_usage[] = {
>  	NULL
>  };
>  
> -static timestamp_t default_reflog_expire;
> -static timestamp_t default_reflog_expire_unreachable;
> -
>  struct worktree_reflogs {
>  	struct worktree *worktree;
>  	struct string_list reflogs;
> @@ -122,6 +119,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
>  static int reflog_expire_config(const char *var, const char *value,
>  				const struct config_context *ctx, void *cb)
>  {
> +	struct reflog_expire_options *opts = cb;
>  	const char *pattern, *key;
>  	size_t pattern_len;
>  	timestamp_t expire;
> @@ -145,10 +143,10 @@ static int reflog_expire_config(const char *var, const char *value,
>  	if (!pattern) {
>  		switch (slot) {
>  		case EXPIRE_TOTAL:
> -			default_reflog_expire = expire;
> +			opts->default_expire_total = expire;
>  			break;
>  		case EXPIRE_UNREACH:
> -			default_reflog_expire_unreachable = expire;
> +			opts->default_expire_unreachable = expire;

Ok, instead of setting the default fallback expiry values globably, it
is set in the options type.

>  			break;
>  		}
>  		return 0;
> @@ -198,9 +196,9 @@ static void set_reflog_expiry_param(struct reflog_expire_options *cb, const char
>  
>  	/* Nothing matched -- use the default value */
>  	if (!(cb->explicit_expiry & EXPIRE_TOTAL))
> -		cb->expire_total = default_reflog_expire;
> +		cb->expire_total = cb->default_expire_total;
>  	if (!(cb->explicit_expiry & EXPIRE_UNREACH))
> -		cb->expire_unreachable = default_reflog_expire_unreachable;
> +		cb->expire_unreachable = cb->default_expire_unreachable;

Here we update where the defaults are used.

>  }
>  
>  static int expire_unreachable_callback(const struct option *opt,
> @@ -276,8 +274,8 @@ static int cmd_reflog_list(int argc, const char **argv, const char *prefix,
>  static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
>  			     struct repository *repo UNUSED)
>  {
> -	struct reflog_expire_options opts = { 0 };
>  	timestamp_t now = time(NULL);
> +	struct reflog_expire_options opts = REFLOG_EXPIRE_OPTIONS_INIT(now);

The options type is initialized with the default defaults :)

>  	int i, status, do_all, single_worktree = 0;
>  	unsigned int flags = 0;
>  	int verbose = 0;
> @@ -308,17 +306,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
>  		OPT_END()
>  	};
>  
> -	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
> -	default_reflog_expire = now - 90 * 24 * 3600;
> -	git_config(reflog_expire_config, NULL);
> +	git_config(reflog_expire_config, &opts);
>  
>  	save_commit_buffer = 0;
>  	do_all = status = 0;
>  
> -	opts.explicit_expiry = 0;
> -	opts.expire_total = default_reflog_expire;
> -	opts.expire_unreachable = default_reflog_expire_unreachable;
> -
>  	argc = parse_options(argc, argv, prefix, options, reflog_expire_usage, 0);
>  
>  	if (verbose)
> diff --git a/reflog.h b/reflog.h
> index eb948119e53..a9d464bbf8c 100644
> --- a/reflog.h
> +++ b/reflog.h
> @@ -5,10 +5,16 @@
>  struct reflog_expire_options {
>  	int stalefix;
>  	int explicit_expiry;
> +	timestamp_t default_expire_total;
>  	timestamp_t expire_total;
> +	timestamp_t default_expire_unreachable;
>  	timestamp_t expire_unreachable;
>  	int recno;
>  };
> +#define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
> +	.default_expire_total = now - 30 * 24 * 3600, \
> +	.default_expire_unreachable = now - 90 * 24 * 3600, \
> +}

Looking good

>  
>  struct expire_reflog_policy_cb {
>  	enum {
> 
> -- 
> 2.48.1.741.g8a9f3a5cdc.dirty
> 
> 
