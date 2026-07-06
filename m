Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25547D920
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374588; cv=none; b=hGF5IQXyt/GLj3xECY+LvHbJMAyGHJGfXVkhsRh10DuzB+hpznAoDhRj9pVKYdRB/yMLwJxdHum5uPTVHD84PAmzMsZz1ijMLd9cXTgUmO2YbcRwOZmgYUfLQkBazpCzbRA5AqV/2hnHMH18K8eM4/KAqb95NdfiDLP6+UsU5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374588; c=relaxed/simple;
	bh=XLCYbhP7UjGedxS1Qb9cbLCbmpGvgCNjnqWk4TU7VpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUoWqUMTNSxw+Rs78jX95y8QyD7niw4aAgzjXHv6CROv3d6I1CC9Oh5Le945HL5LcZ6JPVp+dj9rp9428z+18LIjYuYJJKSRXPfYUdv5caSzY6MpGQ/kcCwejDxY6OvD+X4ZRrV67EgvGP+UCyG4V0PLwbdiW8kfELzMcU9YJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpV6zHCu; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpV6zHCu"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6b554044fso2736921a34.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783374586; x=1783979386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9ugkbt3rMhOslB4/xNd+ZL9+Sd3imPSX449qkLcvVY=;
        b=OpV6zHCudVzZtRGq0s7A+0ljhY9IA+uRDS7p6VwBXUwsatduX8/XpB918C5q6b95bO
         5R+eFWuMdC6T4ktW1hO8bcceCxeoESCiu/HueY4JLfVvovMjq2Cji3YLWbXfGuc5O/dg
         mL4HfHBFqnP8Yvf6E1xBFcUuHmUzqX+XArNYz7KnZCtpJuU50xBqtaKuSZyBzqtxX41f
         ptKWUjtyxjVWihqJCcFuVBUqVdYkVoRoN1LepwduwBFJ/vNHKcwo0nOozWPCUbvOgDx5
         +WOzGTlzwF5qdqGJ2hIn9mihfUACq5EulqSoPrkybEmMCwfcLG6y1uI9rHs7jUAlGmG9
         9+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374586; x=1783979386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9ugkbt3rMhOslB4/xNd+ZL9+Sd3imPSX449qkLcvVY=;
        b=N/J+idHhVfYrUC+7fXVJufJNg0K5kQZOgjx7PRV9WuD57x6fxIkZgSkYgeDIY4zKdy
         dM6elOIF8KLhQW6ZqXB7+fTkgXZZSRgpOlV4AK4GskLKVH6hRoF2I490naBgw7oS00Ni
         QToZvty3PLaXtR5hfD42z51SUlr+YF/ZMVqkRRtI+5q8QIjwVHZFo40zXaldn2O272l5
         fvlGtuqsGPIqIYQpORLAB9L9xGtb/3h2tTm3MSiehoY/s9NIFeY+oKH5cBLGM32LMmeu
         vW+DVSZ+Za2u+ZHd1YsQH6t3K5a852G277LvbPhUrJWQQHs+AwfQ8Abi1r/QUPgS9NEN
         Kg4w==
X-Gm-Message-State: AOJu0YzQnGCEyC2hOlQcReBAu/rA7RFLaRkw3yLOhWW/tST0ogQKcnIt
	u+I7r450ecF9x+znmR3bT/xw7ttBEv1570yucSaxuFesDWhMgwunx4dD
X-Gm-Gg: AfdE7cmpjgrxCWJb1GFq8QjAbw2o+YrXlLWyYOrtwlvgYleGUfKx2k9+TZ+nZxKKVzs
	LSZEriGxH3uo24CU7w2QockE76LgMKoq8u88H8IOoTEeD8EhbgwwCYT/oEVDvbHRK3RIZ0a/u9F
	lgrf4oba9KnfaiawsKkQ0NP5PG5feJLPqyYwmW1cixXg27CCAzVUaLEscj8klHm6qD5nk1FDpJl
	FlkWymGtOx9/oqSTdyA5aDYgs6ePpVQX+dGorLZzpGV2k6FvASWgY+sUwbvG0rGYcoxh4yVIgz9
	+QR/jIVjKAr+lj5XvJ9T6gFBRODfTXwm8gfJFbK1sGhWEHTZvu/vVoM1jDf3MKcdatCos2DOCfC
	o0M8ht6qHWIppfVWuBk8Kk6+lVZeLVWLR70F3dhkL6tR78uQTHxpJGBll5FJlXG5tYXRlJ55vEZ
	EYK/sWNg==
X-Received: by 2002:a05:6808:1314:b0:489:b7d1:db7b with SMTP id 5614622812f47-49fde0e8034mr2244393b6e.22.1783374585361;
        Mon, 06 Jul 2026 14:49:45 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-49acd63b6b1sm5593901b6e.0.2026.07.06.14.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:49:44 -0700 (PDT)
Date: Mon, 6 Jul 2026 16:49:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] setup: mark bogus worktree in
 `apply_repository_format()`
Message-ID: <akwfAmyeIVJYXj1h@denethor>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
 <20260630-pks-setup-split-discovery-and-setup-v1-2-13864eb5a032@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-2-13864eb5a032@pks.im>

On 26/06/30 01:47PM, Patrick Steinhardt wrote:
> When a repository is configured to have both "core.worktree" and
> "core.bare" we emit a warning and mark the worktree configuration as
> bogus so that the next call to `setup_work_tree()` will cause us to die.
> This allows us to still use the misconfigured repository, at least as
> long as we don't try to use its worktree.

Ok.

> This condition is handled in `setup_explicit_git_dir()`. In a subsequent
> commit we'll refactor this function so that it doesn't receive a repo as
> input anymore though, and consequently we cannot set the "bogus" bit
> anymore.

Ok IIUC, `setup_explicit_git_dir()` is currently responsible for
checking if both "core.worktree" and "core.bare" are set. 

> Move the logic into `apply_repository_format()` instead to prepare for
> this. While at it, fix up formatting a bit.

So `apply_repository_format()` is expected to still have the repository
info which has access to the "bogus" field.

> Note that this change requires us to also explicitly unset the value of
> "core.worktree" in case we have the "GIT_WORK_TREE" environment variable
> set. This is because the environment variable overrides the repository's
> configuration, and we don't want to warn or die in case the work tree
> has been configured explicitly regardless of whether or not "core.bare"
> is set.

Hmmm, does this mean we now just silently ignore the misconfiguration if
done via environment variable?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  setup.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/setup.c b/setup.c
> index 118416e350..f54eac5e5a 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1147,24 +1147,24 @@ static const char *setup_explicit_git_dir(struct repository *repo,
>  	}
>  
>  	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
> -	if (work_tree_env)
> +	if (work_tree_env) {
> +		/*
> +		 * The environment variable overrides "core.worktree". This
> +		 * also has the consequence that we don't want to flag cases as
> +		 * bogus where we have both "core.worktree" and "core.bare", so
> +		 * we have to exlicitly unset the configuration.
> +		 */
> +		FREE_AND_NULL(repo_fmt->work_tree);

Ok, this confused me a bit a first, but IIUC we have to unset the
environment variable because we now defer setting the bogus flag to a
later point when `apply_repository_format()` is executed.

>  		set_git_work_tree(repo, work_tree_env);
> -	else if (repo_fmt->is_bare > 0) {
> -		if (repo_fmt->work_tree) {
> -			/* #22.2, #30 */
> -			warning("core.bare and core.worktree do not make sense");
> -			repo->worktree_config_is_bogus = true;
> -		}
> -
> +	} else if (repo_fmt->is_bare > 0) {
>  		/* #18, #26 */
>  		set_git_dir(repo, gitdirenv, 0);
>  		free(gitfile);
>  		return NULL;
> -	}
> -	else if (repo_fmt->work_tree) { /* #6, #14 */
> -		if (is_absolute_path(repo_fmt->work_tree))
> +	} else if (repo_fmt->work_tree) { /* #6, #14 */
> +		if (is_absolute_path(repo_fmt->work_tree)) {
>  			set_git_work_tree(repo, repo_fmt->work_tree);
> -		else {
> +		} else {
>  			char *core_worktree;
>  			if (chdir(gitdirenv))
>  				die_errno(_("cannot chdir to '%s'"), gitdirenv);
> @@ -1176,15 +1176,14 @@ static const char *setup_explicit_git_dir(struct repository *repo,
>  			set_git_work_tree(repo, core_worktree);
>  			free(core_worktree);
>  		}
> -	}
> -	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
> +	} else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
>  		/* #16d */
>  		set_git_dir(repo, gitdirenv, 0);
>  		free(gitfile);
>  		return NULL;
> -	}
> -	else /* #2, #10 */
> +	} else { /* #2, #10 */
>  		set_git_work_tree(repo, ".");
> +	}

Some random curly brace cleanup above.

>  
>  	/* set_git_work_tree() must have been called by now */
>  	worktree = repo_get_work_tree(repo);
> @@ -1768,6 +1767,12 @@ int apply_repository_format(struct repository *repo,
>  	if (verify_repository_format(format, err) < 0)
>  		return -1;
>  
> +	if (format->is_bare > 0 && format->work_tree) {
> +		/* #22.2, #30 */
> +		warning("core.bare and core.worktree do not make sense");
> +		repo->worktree_config_is_bogus = true;
> +	}

We now perform this validation in `apply_repository_format()`. Does
deferring this check have any meaningful impact? Or is
`apply_repository_format()` always called after
`setup_explicit_git_dir()`?

-Justin
