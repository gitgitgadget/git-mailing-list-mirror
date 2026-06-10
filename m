Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A613C2D0C97
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781128338; cv=none; b=KitSdI469YFXSDkmxX8QhyH/ymRzDEjN1rm4DFiHeEf9GBGDUf+imoJI/eTj7xhYCg1VIf6T2da14hm09Ox16KBmp5iNSvmk5UA3SlUZxDYM9eOOU2+JU/uCgPjMUa1CWfXnURtLD+305ZTcZgSZL49c7pOIt8zr8n+z8foJ4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781128338; c=relaxed/simple;
	bh=9OMrn38YeuG5CtXiStfJsZiNNNBeNrqNnU3HBEBoarE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJhgU60fyOWZi1C6L/g0wMEmum1hEgqwLimHbKF5CMwPD8ZNhAg1vDC1uEMirAMyE2CE0Oauo1qO/arZBKOTCgvwDRHI+pyubLIvlpN8dIFe+Z8+pgn9iL6O8XBHz9jXnnPGXEP2IrlP7nPz1HIidatrNKPEpJFtr4MmSLl6wMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSv+oYSw; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSv+oYSw"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-487167d083bso197382b6e.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781128336; x=1781733136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZacks5wKwH5Bi5jU92Jsa0wWy/piajWBpwjvsTRlrA=;
        b=fSv+oYSwgbATNd6efMmGB6FiGGybpJxVv68ZuWoXOsxBLAtkiSu0dvkWsIFXJ0LwqT
         W7RjLFUn8RhyYvx+PPiIkqFRFr7KWpAz9gndB8RU1XOkPbz2hY/rIGJffC2oBw7rKxA7
         ZamPI+1abWzrB8fGc2JA6eI0rDNCdHbFB0wbMpyyf0AyBM93Q+pyWREROYTPszN0uuWs
         L+k1LGLxuWO+RLOjWARV2QBar0eaAuLC14EHuOLnrZ+kmG1GHgGYwkxtpmJGOyNJw3Ss
         oE2aH8GvhBgkodc+6+juGNNG4vHH0eUY+zcqkMvqPOp9yCZeLjCtq3p5x9OBjVWS6+vW
         YR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781128336; x=1781733136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZacks5wKwH5Bi5jU92Jsa0wWy/piajWBpwjvsTRlrA=;
        b=WwSWdeE+04Xz4UkTjjXIvNUxcIHjNadOmtsfEozdAyl6j/QJBA64ErTfFuhpv5UyMX
         1iAzdZtdRYazC6RvO7JiT7t9a+o1amXvsHDDq4gA1zzvjMkHXzW9Sk8ZDaQ/tuOJGKbg
         Y6GwxdI9ttjX6FTCNkCh427tR/lw1fXsaGDQV8loQrAbYQKyvDxE+miEOpGKcGsCdVP9
         tPqdbuMNH32zG1oKyfz+cRXJRKikCGCMvKFnhOrutShGK42c+trDe0K5Jb+gHqCZVxfn
         ESp/+Qgw5fvye8xa/OnyoSIoT7jvLJSPZqqxMXuu0FIOpkqH0Qq639LOFWkrwAwzPp+S
         ROog==
X-Gm-Message-State: AOJu0Yzi+6CWbR2hCupSjlHFUrWE/RcRrNsUJIyGgO5hjjz711ypXMcE
	gfEpg/eeSe/RmIz4gHgU7+P90PuOHObI6poEjRoPB5AK+Wf8s7Y+x2Q7
X-Gm-Gg: Acq92OGir7mdWpxzcqh3uQ2nghaydu2P0FxPaqXksavs/eXfFVckL4Zvc5dfdRA9yPf
	W5XFlC0jsseXWwGvPvZwQQ3FtESdyp45QfjDje9NLQOUT61OYkiXseYdfgw8eK5DbZJp24V4/wq
	XN/0p9lkHpD08X2Pn//Q8Ce+oy3gIRumipVRRWh5+MTEKHz/JkTXr8xc6Pdy5kvzN4hKp7g+NjG
	nafiNCG4YFX9mXqhOxO1BsmwGLuJbLY+6j9/SEnHO6boGPfPaD6pmOQoQHpdv3BR5NqPIf1IJ50
	uYRFFeoMIi82HvagCOWgIG7fWIFCejX+FZYUQunyi7XBQVf1WrHHZVHk5u14PjFyURBxyM9BGDQ
	/VMr01FQtZqnvdY5lv3yJ8d79deTpElJs1Bqi+SYlo0oouC6V60O+/cDtVlX54BKs4E7ARsrmfJ
	bEu/QcxpDsnt+qU8zVIzy2rYARPxw=
X-Received: by 2002:a05:6808:4f68:b0:486:3537:218b with SMTP id 5614622812f47-4868dceec5emr17858787b6e.11.1781128336129;
        Wed, 10 Jun 2026 14:52:16 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b91eaffsm19210782b6e.11.2026.06.10.14.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 14:52:15 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:52:12 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] setup: remove global `git_work_tree_cfg` variable
Message-ID: <ainXM84fGggtEZzM@denethor>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260610-b4-pks-setup-drop-global-state-v1-3-5dff3eec8f06@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-3-5dff3eec8f06@pks.im>

On 26/06/10 08:56AM, Patrick Steinhardt wrote:
> The global `git_work_tree_cfg` variable used to be modified by both
> "setup.c" and by "builtin/init-db.c". We have refactored the latter user
> to not use that variable at all anymore in a preceding commit, which
> makes "setup.c" the only remaining user.
> 
> Even for "setup.c" it is unnecessary though, as we only ever set it to
> the value we have stored in the discovered repository format. The
> consequence is that we only ever set it in case we already have it set
> to the same value in our discovered repository format, which makes it
> redundant.

Nice. I was wondering in the first patch if there would really be any
need to keep `git_work_tree_cfg` around here at all. Makes sense to me
to just set the repository worktree directly.

> Refactor the code so that we instead use the worktree configuration as
> discovered via the repository format. Drop the global variable.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  setup.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/setup.c b/setup.c
> index 52228b42a1..71fc6b33da 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -31,9 +31,6 @@ enum allowed_bare_repo {
>  	ALLOWED_BARE_REPO_ALL,
>  };
>  
> -/* This is set by setup_git_directory_gently() and/or git_default_config() */
> -static char *git_work_tree_cfg;
> -
>  static struct startup_info the_startup_info;
>  struct startup_info *startup_info = &the_startup_info;
>  const char *tmp_original_cwd;
> @@ -799,13 +796,10 @@ static int check_repository_format_gently(const char *gitdir,
>  	}
>  
>  	if (!has_common) {
> -		if (candidate->is_bare != -1) {
> +		if (candidate->is_bare != -1)
>  			is_bare_repository_cfg = candidate->is_bare;
> -		}
> -		if (candidate->work_tree) {
> -			free(git_work_tree_cfg);
> -			git_work_tree_cfg = xstrdup(candidate->work_tree);

Ok, we no longer set `git_work_tree_cfg` in favor of just relying on the
worktree specified in the repository format.

> -		}
> +	} else {
> +		FREE_AND_NULL(candidate->work_tree);

Huh, we were not previously freeing the worktree here, but I assume this
to avoid a resource leak?

The remainder of this patch replaces `git_work_tree_cfg` usage with the
repository format worktree and looks good.

-Justin
