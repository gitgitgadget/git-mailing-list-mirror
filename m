Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2E20C029
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130129; cv=none; b=AerHryrAGqlDR1B+drOaOjh9Udns8fY5j9O3o7afMI67O35WXmtmd4M14umN1ZTJXxAAdf38Al4L0S07Jw5LS0QphCKeStcImMpd5d7h7+h7BACnUZQxHlPj/qEXLn3aw661ILI1gEgkkcwaxXOq7ktHo9set0BxSaFa2yzJBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130129; c=relaxed/simple;
	bh=g+dDuHFgs5Qt6lTiT5Sa65XOCmtZHqqXXLL/U+3lISk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUXWhuSDkFVxRtlfqy/4WWMsEUZqgU3hwWcSEwbarlq7MAvsg2taDmvgdJ5TVnqfCIvBYJlZ1kgpinIX3rb71TQi/cc7+sTSA0ohJSgHIa6OB6tLysMQMBCChdmU1qjlKRX6c+JzpVpp4PIoFsrkbJL9Zk1aEPIb1ByP8T//ETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9TRVdo/; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9TRVdo/"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69e9b037d82so2441209eaf.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781130127; x=1781734927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucEzvcT8UXy8ZAL7HrvIAovYOfAhNFS4vJ6yU0C2ER4=;
        b=s9TRVdo/vsjDFt75robD+LZr1a9yGxWz+YfbLmj6jOg4gzTv+2y0bibqMbGXDfzqQC
         92URE7LcIMkUIxNNBjRGmcfJEljaN6uGluZ5cbtwMvVlvjwh9+K1PvBLlw7xGySrqj1b
         KeWnxPYvizJ5t/WJuyuNnc09DYXL6IrZWJpiqwHkcWbgg3p3R1BjbzWp5IIipjA7dsBD
         TzujNZIsGD9lYDrAG5oDXuz1wWWMksoculKgwYp+WusD9MOWVtiEqmD8DI0wC3fWzQ7r
         YXt/5cPUcLuJcVfhSUa85mqKknf1zzq+RNjvvAxwscxCZtItO/Pl9YNrJQi/PuUIlriM
         SN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130127; x=1781734927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucEzvcT8UXy8ZAL7HrvIAovYOfAhNFS4vJ6yU0C2ER4=;
        b=qY1jswrssuyQeGGRa+CHk10AAJUiucSKt2pHFKB8Qu4++vpvL7MXHYpFEniSpElbN+
         QJUmYbMjifwxZvDj3np92JFz2PUQlZAuYRmfQ8L4cFkHx5PcmU7L35alLYtv6qTNkFaV
         +dxY8VSF/bHrOdyLUpbrcMYJu6twfKkynHQx5MBM1M8x1Jfoq7oYUJ/N50JeGAxNc182
         wY0jhQ6UcoYTFccvg+e8Wf4O1V+LDMhK8tIYOxZoE1jftDIfqWtrpkNn/+AjIaCcjG3y
         TiGdA9XXRVE6LbnFBWgWZvfAJH2fpSu7sLyhEnrKWEs/PYlWZp1n9v0YTKeD7bE4ONKI
         QffQ==
X-Gm-Message-State: AOJu0Yw+ff3HXuPDqMz8SJ3w66NGbvIiys69UEnMNkJIVZPHaClUBaWJ
	501E5y+hvsK6ir++3GB/az/Pxj3CRxWWgqks1Q1lcCwrYR1FdUVqnlhfRPeU3w==
X-Gm-Gg: Acq92OFM3YOjxfEAz0fEelwQhAmAW1bYNCGVHPfXfInSnA19tW89ZCezgGLo51encJ0
	I249+12cAyzXyxdDiAWVnkzHmLEP2rPrM0MWwXsci6NP9d4KHqakJroX2BvJAVs2YtMOZF4lIto
	Quq1H5A27Oy/8TBI7lbpi3we9S7kqRSICu26bju3Pw/JDWem/1zMDsCtc+MEUtSeLyCC6HAT9hZ
	NZOaCGwizhhLKBl6lU51GepN3Y6CT6MyQhoN52A+rLDq7RKw3LbVy1VHLw6EUboVVRYdjQ9kafX
	+eoNVOZ/zEuBmhFiMIBRplgQ2/eWHRfahJsrsFOsL6dFsb9Ch/NV9Luohn549MRiY6mnX3DNe7e
	m7CwJyHIp6+gnx5Nagnmzml7pMPZxe7ycIjtSNWNoc45LSmEJk/M3NGQIGL3xxAKe/pstxMfuQ9
	wZIPEkk+C9csFat3FyhErdGyDsQ5o=
X-Received: by 2002:a05:6820:5705:10b0:69e:ba3c:124 with SMTP id 006d021491bc7-69eba3c03d0mr2409350eaf.43.1781130127097;
        Wed, 10 Jun 2026 15:22:07 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e46405105sm13009465eaf.10.2026.06.10.15.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:22:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:22:04 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/7] environment: split up concerns of
 `is_bare_repository_cfg`
Message-ID: <ainesoUOuhspKxHF@denethor>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260610-b4-pks-setup-drop-global-state-v1-5-5dff3eec8f06@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-5-5dff3eec8f06@pks.im>

On 26/06/10 08:56AM, Patrick Steinhardt wrote:
> The `is_bare_repository_cfg` variable tracks two different pieces of
> information:
> 
>   - It tracks whether the user has invoked git with the "--bare" flag,
>     which makes us treat any discovered Git repository as if it was a
>     bare repository.
> 
>   - Otherwise it tracks whether the discovered `the_repository` is bare.
> 
> This makes the flag extremely confusing and creates a bit of a challenge
> when handling multiple repositories in the same process.

Indeed, this does seem rather confusing.

> Split up the concerns of this variable into two pieces:
> 
>   - `startup_info.force_bare_repository` tracks whether the user has
>     passed the "--bare" flag. This is used as a hint to treat newly set
>     up repositories as bare regardless of whether or not they have a
>     worktree.
> 
>   - `struct repository::bare_cfg` tracks whether or not a repository is
>     considered bare. This takes into account both whether the user has
>     passed "--bare" and the discovered state of the repository itself.
> 
> Whether or not a repository is bare is now resolved when checking the
> repository's format, and is then later applied to the repository itself
> via `apply_repository_format()`.

Nice. These seem like they should be tracked separately, so splitting
them up sounds like a good idea.

> This enables a subsequent change where we make `is_bare_repository()`
> not depend on global state anymore.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/init-db.c |  2 +-
>  environment.c     |  5 ++---
>  environment.h     |  1 -
>  git.c             |  2 +-
>  repository.c      |  1 +
>  repository.h      |  7 +++++++
>  setup.c           | 21 ++++++++++++++-------
>  setup.h           |  6 ++++++
>  worktree.c        |  2 +-
>  9 files changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 52aa92fb0a..566732c9f4 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -81,7 +81,7 @@ int cmd_init_db(int argc,
>  	const char *template_dir = NULL;
>  	char *template_dir_to_free = NULL;
>  	unsigned int flags = 0;
> -	int bare = is_bare_repository_cfg;
> +	int bare = startup_info->force_bare_repository ? 1 : -1;

Any particular reason to continue mapping `force_bare_repository=false`
to -1? Or was this to just minimize changes?

>  	const char *object_format = NULL;
>  	const char *ref_format = NULL;
>  	const char *initial_branch = NULL;
[snip]
> diff --git a/repository.h b/repository.h
> index 36e2db2633..7d649e32e7 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -117,6 +117,13 @@ struct repository {
>  	bool worktree_initialized;
>  	bool worktree_config_is_bogus;
>  
> +	/*
> +	 * Whether the repository is bare, as set by "core.bare" config or
> +	 * inferred during repository discovery. -1 means unset/unknown, 0
> +	 * means non-bare, 1 means bare.
> +	 */
> +	int bare_cfg;

Now we track whether a repository is bare in `struct repository` and
removes the need to a separate global to track this state.

> +
>  	/*
>  	 * Path from the root of the top-level superproject down to this
>  	 * repository.  This is only non-NULL if the repository is initialized
> diff --git a/setup.c b/setup.c
> index 71fc6b33da..2b690da8ca 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -795,10 +795,16 @@ static int check_repository_format_gently(const char *gitdir,
>  		has_common = 0;
>  	}
>  
> -	if (!has_common) {
> -		if (candidate->is_bare != -1)
> -			is_bare_repository_cfg = candidate->is_bare;
> -	} else {
> +	if (startup_info->force_bare_repository) {
> +		candidate->is_bare = 1;
> +		FREE_AND_NULL(candidate->work_tree);
> +	} else if (has_common) {
> +		/*
> +		 * When sharing a common dir with another repository (e.g. a
> +		 * linked worktree), do not let this repository's config
> +		 * dictate bareness; it is inherited from the main worktree.
> +		 */
> +		candidate->is_bare = -1;
>  		FREE_AND_NULL(candidate->work_tree);

Previously, when there was a common dir, `candidate->work_tree` was left
untouched, but now we are expclicitly setting it. I'm not sure I fully
understand this change.

-Justin
