Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4885225779
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294812; cv=none; b=ROVCACe6YfDJe7lHmPujjiPgWJazP0gYbwWIPEiZT5cQIPVQPyqZKv3XHVkLpRiN79ucv3aM2Re2w3k+52gA5efQE/Djrq3HKMIrZpbSKkHc6iiMf9C7+fsjEAapOlMX5YK3TodyF2zWjcVEwTkIqEHAc/7gyu1uLw48Gkfy5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294812; c=relaxed/simple;
	bh=LSY+azS26PmtxS3obg2Rikb35BEvrrmISwz/jOzeLAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAEeWCv8bMPzSpvCKFJKaP//2/tkC//9cRJYayjvCjxV1/a8O52wckOhxZztViJSQFDMLxxFTxoAA1mJWWY3Ka8+VbZ/+INqX4I8IvtWaqPUO2uBBaCebbw3kHoSXr5nDruVZBSIBFQpvi3TowwOP2giTVVegnKQ7sHNuzVV3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbVSsO8+; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbVSsO8+"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-615a4b504b2so62663eaf.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 11:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753294810; x=1753899610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGHYdxH7O6k7ZcLl03CRJ7nsXGzsEJLfjRuMTVs+9jc=;
        b=VbVSsO8+2FlXJ2V5Abaz8rC7b1l6dHCjifLBREmtRHGCG5/w4idlyIDylDsVc9VcEX
         vjbXZgHUu2zi8txuRUr6FXnN5MjZaufEM5k51N5wK/fag/rP4mRQCPj/BvOgZ0tyy1OM
         CVPDMcvug6SPA82H/WQu3kBPzdtza62kxEzvwHgRG9IpGKGkKZ0vr2/oAAhruKbLqlSh
         Ni16lFutg9eIWGMbxQrUqqW+34TvIyRsX9xFU5aeziI48Ke13a6aCKah2N3FPreSW0Zo
         M7HLAAbJhEtB8GweuXHZu9C7/4NCY7SNeW/bDSD0QESCSlzH4wkJcANR3tqg4k/n2J69
         kp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753294810; x=1753899610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGHYdxH7O6k7ZcLl03CRJ7nsXGzsEJLfjRuMTVs+9jc=;
        b=Dg+g1wNBSz4gcpGh1/rj6mbriBCVSlM+z+TjQc5kNYgo8WxP06ZAywWC2xMko8AHUa
         DVyP56mA99RLu1OtxaAZjT7uDCyfrKmvw43/0FN6N1qLRnswtzSJ+lCQX0aXUm3BQaXX
         Qzg87j1xpX4dNBhzP1GbQ5/ya6tJctSxVrlYd/SkISCFzCat24mJDBpUeU+0Qp06p0GL
         IUw36ywmyye80KrNI4tf6dIWvrfkl/t48Je0Cpklh3FxdgFkst+GvGrxXYoYHOq5cJ/h
         TUIgL2w7fLisD0u1DeUAUi6F5tTLQ1zQodzMRLaGvUEbrCJa3TGltiq1FS3JOGhqWwv1
         gJhQ==
X-Gm-Message-State: AOJu0YzXQmhZKLzxQ1uKho5kqoe41BGIcI4J8waYG6wqiVcktsVQG1MX
	OW2/ScSXivGQD/VyclMORkaNJGHsYAb+lg80+QySJCkJLVR9wLh+TGnO
X-Gm-Gg: ASbGncujKk90kY5hcrOnebP8PE3NN7Ayf3ZbQj8wsFzxT73X+6O/sFHuBnzoR72grZH
	DjKuUkqjZOGGW6L9rlZipe/wPYTXWGX/Kr9v9MnoutpdNR9odK+2fwzO+t7L47nP9fqdg4qug+f
	bUTBRwySCb2+WPLaceCL7+Z98XPyGWdVxGnvuZVJkuGDu+UAI5gh++tZm2YKlVYi6WnpruTHSN0
	JchOZdp2EoIj372qQdr7XAphEk7EfdLEUNP0IIxrhOuDAGS2Jy0cX2dn1wARI61CUFdnz9Hd0HX
	SprEC0N3J3NF+81l6dji+UU+cbqzyynQyIeVzQUXzyzZ3edm+ZWqAePOWbCHoR6GXtfkyA7gcNQ
	jEibWZ6vDI5p0mR0=
X-Google-Smtp-Source: AGHT+IHdJ11xn9+cfI2Rp7ai4svt7lJzGiZwUTbbWzLS6Itzp1cHl+5KSmu2plAxD8IGi7K/1hVGDQ==
X-Received: by 2002:a05:6870:61ca:b0:2c2:30e9:b15f with SMTP id 586e51a60fabf-306c72006bfmr2774527fac.20.1753294809558;
        Wed, 23 Jul 2025 11:20:09 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-30104256720sm5163895fac.33.2025.07.23.11.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:20:09 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:14:19 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/8] builtin/reflog: improve grouping of subcommands
Message-ID: <32gvkjmjz6otqwpaxafmz5xuznowhn4iwcdyn52qhbvzohyih4@oeimg3xvqj5u>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-2-183e5949de16@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-pks-reflog-append-v1-2-183e5949de16@pks.im>

On 25/07/22 01:20PM, Patrick Steinhardt wrote:
> The way subcommands of git-reflog(1) are layed out does not make any

s/layed/laid/

> immediate sense. Reorder them such that read-only subcommands precede
> writing commands for a bit more structure.
> 
> Furthermore, move the "expire" subcommand last. This prepares for a
> subsequent change where we are about to introduce a new "write" command
> to append reflog entries. Like this, the writing subcommands are ordered
> such that those affecting a single reflog come before those spanning
> across all reflogs.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-reflog.adoc |  8 ++++----
>  builtin/reflog.c              | 38 +++++++++++++++++++-------------------
>  2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
> index 707a9b39edb..6ae13e772b8 100644
> --- a/Documentation/git-reflog.adoc
> +++ b/Documentation/git-reflog.adoc
> @@ -11,13 +11,13 @@ SYNOPSIS
>  [synopsis]
>  git reflog [show] [<log-options>] [<ref>]
>  git reflog list
> -git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
> -	[--rewrite] [--updateref] [--stale-fix]
> -	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
> +git reflog exists <ref>
>  git reflog delete [--rewrite] [--updateref]
>  	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
>  git reflog drop [--all [--single-worktree] | <refs>...]
> -git reflog exists <ref>
> +git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
> +	[--rewrite] [--updateref] [--stale-fix]
> +	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
>  
>  DESCRIPTION
>  -----------
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 3acaf3e32c2..b00b3f9edc9 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -17,21 +17,21 @@
>  #define BUILTIN_REFLOG_LIST_USAGE \
>  	N_("git reflog list")
>  
> -#define BUILTIN_REFLOG_EXPIRE_USAGE \
> -	N_("git reflog expire [--expire=<time>] [--expire-unreachable=<time>]\n" \
> -	   "                  [--rewrite] [--updateref] [--stale-fix]\n" \
> -	   "                  [--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]")
> +#define BUILTIN_REFLOG_EXISTS_USAGE \
> +	N_("git reflog exists <ref>")
>  
>  #define BUILTIN_REFLOG_DELETE_USAGE \
>  	N_("git reflog delete [--rewrite] [--updateref]\n" \
>  	   "                  [--dry-run | -n] [--verbose] <ref>@{<specifier>}...")
>  
> -#define BUILTIN_REFLOG_EXISTS_USAGE \
> -	N_("git reflog exists <ref>")
> -
>  #define BUILTIN_REFLOG_DROP_USAGE \
>  	N_("git reflog drop [--all [--single-worktree] | <refs>...]")
>  
> +#define BUILTIN_REFLOG_EXPIRE_USAGE \
> +	N_("git reflog expire [--expire=<time>] [--expire-unreachable=<time>]\n" \
> +	   "                  [--rewrite] [--updateref] [--stale-fix]\n" \
> +	   "                  [--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]")
> +
>  static const char *const reflog_show_usage[] = {
>  	BUILTIN_REFLOG_SHOW_USAGE,
>  	NULL,
> @@ -42,9 +42,9 @@ static const char *const reflog_list_usage[] = {
>  	NULL,
>  };
>  
> -static const char *const reflog_expire_usage[] = {
> -	BUILTIN_REFLOG_EXPIRE_USAGE,
> -	NULL
> +static const char *const reflog_exists_usage[] = {
> +	BUILTIN_REFLOG_EXISTS_USAGE,
> +	NULL,
>  };
>  
>  static const char *const reflog_delete_usage[] = {
> @@ -52,23 +52,23 @@ static const char *const reflog_delete_usage[] = {
>  	NULL
>  };
>  
> -static const char *const reflog_exists_usage[] = {
> -	BUILTIN_REFLOG_EXISTS_USAGE,
> -	NULL,
> -};
> -
>  static const char *const reflog_drop_usage[] = {
>  	BUILTIN_REFLOG_DROP_USAGE,
>  	NULL,
>  };
>  
> +static const char *const reflog_expire_usage[] = {
> +	BUILTIN_REFLOG_EXPIRE_USAGE,
> +	NULL
> +};
> +
>  static const char *const reflog_usage[] = {
>  	BUILTIN_REFLOG_SHOW_USAGE,
>  	BUILTIN_REFLOG_LIST_USAGE,
> -	BUILTIN_REFLOG_EXPIRE_USAGE,
> +	BUILTIN_REFLOG_EXISTS_USAGE,
>  	BUILTIN_REFLOG_DELETE_USAGE,
>  	BUILTIN_REFLOG_DROP_USAGE,
> -	BUILTIN_REFLOG_EXISTS_USAGE,
> +	BUILTIN_REFLOG_EXPIRE_USAGE,
>  	NULL
>  };
>  
> @@ -404,10 +404,10 @@ int cmd_reflog(int argc,
>  	struct option options[] = {
>  		OPT_SUBCOMMAND("show", &fn, cmd_reflog_show),
>  		OPT_SUBCOMMAND("list", &fn, cmd_reflog_list),
> -		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
> -		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
>  		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
> +		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
>  		OPT_SUBCOMMAND("drop", &fn, cmd_reflog_drop),
> +		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
>  		OPT_END()
>  	};

Structing the subcommands order in such a manner seems sensible, but I'm
not sure the pattern will be recognized by others that may add
subcommands in the future. Maybe we could leave a comment that mentions
the order?

-Justin
