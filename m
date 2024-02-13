Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62822319
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818530; cv=none; b=tgC84MF9S1uWvv0ke7Lwbj97i6SzAacPmD2S0fFyFfo8A18xToH8JogVqDmFPIfpY2c+pXnY5yRNoSQfduvEzQKmfye9DzmAk2yhK6HuULaPY99fK94n8MEKPlBmf+5lI/ZiZ01fOMeO18F/6s8PX9lcAMJWS0tpFw3YSoN2EHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818530; c=relaxed/simple;
	bh=MaLnqENoavq1UCVH+AJTeaoLZuLPnMhZl9V00N7lcaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OWalCoClGxqlYsMyQgGoQFzb9vBum0sUFEtISYwFvVruXEOBVRcukxTNXydlyVlNXPFkXaCyoFdvMzZm9/aLPt0Dgo/wtWH3HG5wsSrlQXPGEKIMzHFxbAZH94+c+vGTg03sWqxuaZMC9SqTnaS7KSHjsQSsowvXLRVZVImz8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tKKVJ0Ab; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tKKVJ0Ab"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so6547919276.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 02:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707818527; x=1708423327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvrhwn/ox0ozEe5vqTXaPl2yhVDxRIwBVCjDc+n4llE=;
        b=tKKVJ0AbDr+6NE2HF3RDgEZWBuVvkY4fkq8dFXa/m4ty5hPD2g4LKwLIM1iDR2pkog
         BmfTZLJQ0HorxWymSubH7rnzJpNlmAt4BQvp/LXMWl2gANUGJ7KxEyJ05FVg1siCWPrX
         6dP/x5esO0AyvvyQqM8wx3dELAPngrmDGYtGeM6OOgsZxwkz61WKjkGDkOqathYsGs1E
         gpK51kdk8m9laPupqsqEI9NfgO69/olWA706Dy/9Hn+gyFEPARF0fnmPEoArw2v9ri1J
         yT9p416E+6PtJNV4C6+eUZPZflpez2fKih+rZJegux8s9axCyEHezx9cXSC2QYlhIgc9
         EgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707818527; x=1708423327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvrhwn/ox0ozEe5vqTXaPl2yhVDxRIwBVCjDc+n4llE=;
        b=lrKyO4nDJPVwLpU/j300m7xmOhHAZqIjZL9/tNNmo4TFEuqvhoVd8DxMUaY0d8GiL6
         dVfokSI6SuxwrMR/Ux+jbwN4G6xJTJ4VQfsCjJC7wcrX5SwUKubTg5p1DEK2OYpnY4dt
         qUjkWSWamrAGOoOYdGhXKiGjLQCvuE20wYq0NFz64lBaA9yNVGalQBSrk7m5qrl8XkDK
         IOjE5lkKtsspWCM3tKXPCWGqCCuF5N/7jaen+YxNwc6OZl7No0XrIybMuJCgUT4SBegK
         /wJmSBDMMiQSmFjYaZnlJGcOtEXPWu/a0bq+I+m55VXHHJn8maZREBe+U2WN7VtAYRHF
         J1DQ==
X-Gm-Message-State: AOJu0YyLoO4eubPVqvJ3YSuplQU7I398CsNlLdwvgONLnOZQhyc5Jm4N
	RmE4u37FtX10+JPhnBRGoLLzhtvLuRnwyel15tS9Awk0KnmJaxgbD/PcCkNyKHTtFqED1Fb2MDz
	T3w==
X-Google-Smtp-Source: AGHT+IFX8EbqK7TeKYW/SYYrXX+p7Pf4RoBHIrJcvQ0V6H0Y0afY5cpjKhqqZK3TC81pxchV/SsC92WrFB4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a5b:7c4:0:b0:dcc:a58:2ddc with SMTP id
 t4-20020a5b07c4000000b00dcc0a582ddcmr478804ybq.5.1707818527367; Tue, 13 Feb
 2024 02:02:07 -0800 (PST)
Date: Tue, 13 Feb 2024 02:02:05 -0800
In-Reply-To: <20231002024034.2611-4-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org> <20231002024034.2611-4-ebiederm@gmail.com>
Message-ID: <owly4jecd6n6.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 04/30] repository: add a compatibility hash algorithm
From: Linus Arver <linusa@google.com>
To: "Eric W. Biederman" <ebiederm@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Eric Sunshine <sunshine@sunshineco.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> We currently have support for using a full stage 4 SHA-256
> implementation.  However, we'd like to support interoperability with
> SHA-1 repositories as well.  The transition plan anticipates a
> compatibility hash algorithm configuration option that we can use to
> implement support for this.

Perhaps add

    See section "Object names on the command line" in
    git/Documentation/technical/hash-function-transition.txt .

? That section does not use the language "compatibility hash algorithm"
though, and I think "hash compatibility option" is easier to say.

Hmm, or are you talking about "compatObjectFormat" discussed in that doc?

> Let's add an element to the repository
> structure that indicates the compatibility hash algorithm so we can use
> it when we need to consider interoperability between algorithms.

How about just

    Add a hash compatibility option to the repository structure to
    consider interoperability between hash algorithms.

?

Aside: already we are seeing multiple keywords "compatibility",
"transition", "interoperability" to all mean roughly similar things. I
hope we can settle on just one (ideally) in the codebase by the end of
this series.

> Add a helper function repo_set_compat_hash_algo that takes a
> compatibility hash algorithm and sets "repo->compat_hash_algo".  If
> GIT_HASH_UNKNOWN is passed as the compatibility hash algorithm
> "repo->compat_hash_algo" is set to NULL.
>
> For now, the code results in "repo->compat_hash_algo" always being set
> to NULL, but that will change once a configuration option is added.

It's not clear to me whether you are talking about a config option to
describe the different stages of transition around algorithms, or a hash
algorithm itself (SHA1, SHA256, UNKNOWN).

> Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  repository.c | 8 ++++++++
>  repository.h | 4 ++++
>  setup.c      | 3 +++
>  3 files changed, 15 insertions(+)
>
> diff --git a/repository.c b/repository.c
> index a7679ceeaa45..80252b79e93e 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -104,6 +104,13 @@ void repo_set_hash_algo(struct repository *repo, int hash_algo)
>  	repo->hash_algo = &hash_algos[hash_algo];
>  }
>  
> +void repo_set_compat_hash_algo(struct repository *repo, int algo)
> +{
> +	if (hash_algo_by_ptr(repo->hash_algo) == algo)
> +		BUG("hash_algo and compat_hash_algo match");
> +	repo->compat_hash_algo = algo ? &hash_algos[algo] : NULL;
> +}

Ah, OK. So we are talking about an algorithm itself. Looking at this
code it seems like a compat_hash_algo is something like "the hash
algorithm I want my repository to start using but which has not
already". Such a description would have been useful in the commit
message.

Nit: I think 

    BUG("compat_hash_algo may not be the same as hash_algo");

is more natural because the error message should explain the badness of
the behavior rather than merely reflect the triggering condition. And
the "star of the show" here is the new compat_hash_algo member, so it
makes sense to emphasize that more as the only subject of the sentence
instead of grouping it together with hash_algo (given them equal
importance).

> +
>  /*
>   * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
>   * Return 0 upon success and a non-zero value upon failure.
> @@ -184,6 +191,7 @@ int repo_init(struct repository *repo,
>  		goto error;
>  
>  	repo_set_hash_algo(repo, format.hash_algo);
> +	repo_set_compat_hash_algo(repo, GIT_HASH_UNKNOWN);
>  	repo->repository_format_worktree_config = format.worktree_config;
>  
>  	/* take ownership of format.partial_clone */
> diff --git a/repository.h b/repository.h
> index 5f18486f6465..bf3fc601cc53 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -160,6 +160,9 @@ struct repository {
>  	/* Repository's current hash algorithm, as serialized on disk. */
>  	const struct git_hash_algo *hash_algo;
>  
> +	/* Repository's compatibility hash algorithm. */

Perhaps add "May not be the same as hash_algo." ?

> +	const struct git_hash_algo *compat_hash_algo;
> +
>  	/* A unique-id for tracing purposes. */
>  	int trace2_repo_id;
>  
> @@ -199,6 +202,7 @@ void repo_set_gitdir(struct repository *repo, const char *root,
>  		     const struct set_gitdir_args *extra_args);
>  void repo_set_worktree(struct repository *repo, const char *path);
>  void repo_set_hash_algo(struct repository *repo, int algo);
> +void repo_set_compat_hash_algo(struct repository *repo, int compat_algo);
>  void initialize_the_repository(void);
>  RESULT_MUST_BE_USED
>  int repo_init(struct repository *r, const char *gitdir, const char *worktree);
> diff --git a/setup.c b/setup.c
> index 18927a847b86..aa8bf5da5226 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1564,6 +1564,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		}
>  		if (startup_info->have_repository) {
>  			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
> +			repo_set_compat_hash_algo(the_repository,
> +						  GIT_HASH_UNKNOWN);
>  			the_repository->repository_format_worktree_config =
>  				repo_fmt.worktree_config;
>  			/* take ownership of repo_fmt.partial_clone */
> @@ -1657,6 +1659,7 @@ void check_repository_format(struct repository_format *fmt)
>  	check_repository_format_gently(get_git_dir(), fmt, NULL);
>  	startup_info->have_repository = 1;
>  	repo_set_hash_algo(the_repository, fmt->hash_algo);
> +	repo_set_compat_hash_algo(the_repository, GIT_HASH_UNKNOWN);
>  	the_repository->repository_format_worktree_config =
>  		fmt->worktree_config;
>  	the_repository->repository_format_partial_clone =
> -- 
> 2.41.0
