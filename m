Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8E6FBF
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958381; cv=none; b=mlyHu709lIeKHiSQYSQ7KhXTYRJtD8Fnt1d6t5BYRhjHdpq7n1lkZ/l5KQWDuhyo6QzbGusekSMhLJcq47D0+LSXczQ8NYyCvGBGTtvyMlfqT/dfnBklhqRCOHqJqmDaPECMI+2SGsPWJLCIxRCYNbQSLQHUqwsMrEoUxMkrulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958381; c=relaxed/simple;
	bh=tYlI9mqJglNF9xWglDF7iQEn44HVjT0oSp2j/1bUUN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kGWMhTgIzazw2xh1SNf+8M8cKkSbOTa3os6Hop98h6B1fBX3n3LblpbFfwRQAK+mRstPK+l0buOwNQekrRSEyYJT0OWlUfIgOy+mUzH3ynob+dzeMXaxZLP84Hq/O7gQoTaFr6G2nBM0ycQmWGRJnZjv2jI7hdr+pztSJQ4flP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jdSpTEG2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kWWumjWd; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jdSpTEG2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kWWumjWd"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1A5BA1140119;
	Thu,  7 Nov 2024 00:46:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 07 Nov 2024 00:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730958376; x=1731044776; bh=yW2GOJZ7UN
	6d/RD63I5uaFx0U+D1bPlfvzxCR2r9PzQ=; b=jdSpTEG2m0k/w1FhMdmX4lIdU/
	0/F6gV454qzhk2yia2oCdfp+WhVmMa0kWfYvsxjTNY2iMgjjYj32XQrx+iLXQlUi
	ZGHrAesuxbRu1b2p1C0pqZBWsQVmK5XQyBG+c4SRT6wI6HKKab7UKSvvp5sHHc77
	2inczHv/I4uSURAc9Y19A71Os7RJnJ20yzFRu3nknYKyXa4KAm54BP3VXoQ/uzwi
	Rv4LzkoQzq/ovKDJs8peS/b02dMubF0C9pM+1S8aZ4iP9OYdHUqiakZHIpTwBvkZ
	1Vf2PrJm58b+OGPh3LG+LssLSiA+9hYZuTWBS+yXZuoRcaskWMn8Xz8k5z+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730958376; x=1731044776; bh=yW2GOJZ7UN6d/RD63I5uaFx0U+D1bPlfvzx
	CR2r9PzQ=; b=kWWumjWd7Pvv+rxLLYTxMXdXZyvGf3BDjwrh5DWnxKXZGL00uLj
	KrF+q/6/gaMPzhOxE2CbyK4cRczoSG1TNucy11EfcPYHcPj+LBPDmL0l6CTx5igM
	GIK8vZ+BBDKhlb4RozdZ2sSZ0wzS/MZcgd40HCnHlKvYT84aa5pvaEi8xICRTdlt
	roYeDywTOdlrnFkDnHobOGiBoWSZtZezuZGhLtEAt5lalZ5CQ3o+DWrraQYFY44M
	Kq98xL9moWsG0jgbW+2TFjUm9KBtN2q1glcK1XkmPThbt6hbRVnA8iAXy9T68D/5
	mbcib7sw+c6IVSahtSaAxKMmPnr8aMibIBg==
X-ME-Sender: <xms:KFQsZ0Ymow7MYwembkmnsG9tmjkAu8VdYhRMf_u7a-CfCFLx5TykVw>
    <xme:KFQsZ_ZLWBTJI3wIoVe91RvD8zMjK2tK2Wgr590Zn8klMY2TPVizUog4IoEayZ4mp
    xNReDIs4OVBPn5RaA>
X-ME-Received: <xmr:KFQsZ--z_0-2x6SIoblR1PCh_PtabvBhQg2xb3HYv8sp67OxG1JFjgWWOHBcdZR1cr1NfqEcGqTcrUNxhM2sXsSJEd9Ct3slA2fx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KFQsZ-rCvzL3MHV3c1_vVYFlgII1DDu2vr0_8g2kosUNqKunKzSRgg>
    <xmx:KFQsZ_r9v7xonbJgKwdKkomvprMv0vr8LUacD6J9hEOMIIaZrRnDTw>
    <xmx:KFQsZ8RbTEtIZZXBmbqaDmRQ77F3Vi6UuVZ_JkYQ-alPDVSafGbNVQ>
    <xmx:KFQsZ_q7Qq1UXBXcIp_LLcV7LW9lHO-dO3tGOFvBToohEZ3ubSZqCA>
    <xmx:KFQsZwkQbo44Li-2sgctNynSoh2AKpzawlNoI6evhrkAeepLUAPWeiux>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 00:46:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] git: remove is_bare_repository_cfg global variable
In-Reply-To: <3d341a9ae4ef1d2776734fa82a45913f91e6083c.1730926082.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Wed, 06 Nov 2024 20:48:00
	+0000")
References: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
	<3d341a9ae4ef1d2776734fa82a45913f91e6083c.1730926082.git.gitgitgadget@gmail.com>
Date: Thu, 07 Nov 2024 14:46:15 +0900
Message-ID: <xmqqv7wzsijc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The is_bare_repository_cfg global variable is used for storing a bare
> repository setting, either through the config, an env var, or the
> commandline.

I found it curious that the above enumeration does not include the
case where we go through the repository discovery process and find
that we are in a bare repository.  Looking at the original
implementation of is_bare_repository() call, we do check if the
directory structure does have a working tree when these three
sources you listed above say "we are bare" or "we do not know yet".

So it would be be helpful if we made these two points

 - The above enumeration is not meant to be exhausitive.

 - The answer to anybody who asks "is this repository bare?" is more
   subtle than just reading the variable.

clear to readers.

> This variable is global, and hence introduces global state
> everywhere it is used.
>
> In order to reduce global state, add a member to the repository struct
> to keep track of the setting there. For now, the_repository is what's
> used to set the member, which still represents global state. However,
> there is a parallel effort to replace calls to the_repository with a
> repository struct that is passed into builtins, see [1]. Hence, this
> change will help the overall effort in reducing global state.

OK.

> diff --git a/attr.c b/attr.c
> index c605d2c1703..053cd59af26 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -716,7 +716,7 @@ static enum git_attr_direction direction;
>  
>  void git_attr_set_direction(enum git_attr_direction new_direction)
>  {
> -	if (is_bare_repository() && new_direction != GIT_ATTR_INDEX)
> +	if (repo_is_bare(the_repository) && new_direction != GIT_ATTR_INDEX)
>  		BUG("non-INDEX attr direction in a bare repo");

So everybody called is_bare_repository() which implicitly relied on
the global variable now calls repo_is_bare() on the_repository,
where the new member in the struct serves the purpose of the old
global variable.

This replacement to repo_is_bare(the_repository) from
is_bare_repository() is a recurring pattern in this patch, so I'll
remove them from my quoting.

I've used coccinelle to apply this semantic patchlet

    - is_bare_repository()
    + repo_is_bare(the_repository)

and then compared the result with applying this patch to see what
else this patch contains, so I can comment on them.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 59fcb317a68..80b594c6011 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1415,7 +1415,7 @@ int cmd_clone(int argc,
>  		repo_clear(the_repository);
>  
>  		/* At this point, we need the_repository to match the cloned repo. */
> -		if (repo_init(the_repository, git_dir, work_tree))
> +		if (repo_init(the_repository, git_dir, work_tree, -1))
>  			warning(_("failed to initialize the repo, skipping bundle URI"));
>  		else if (fetch_bundle_uri(the_repository, bundle_uri, &has_heuristic))
>  			warning(_("failed to fetch objects from bundle URI '%s'"),
> @@ -1446,7 +1446,7 @@ int cmd_clone(int argc,
>  			repo_clear(the_repository);
>  
>  			/* At this point, we need the_repository to match the cloned repo. */
> -			if (repo_init(the_repository, git_dir, work_tree))
> +			if (repo_init(the_repository, git_dir, work_tree, -1))
>  				warning(_("failed to initialize the repo, skipping bundle URI"));
>  			else if (fetch_bundle_list(the_repository,
>  						   transport->bundles))

OK, so our repo_init() now takes one extra parameter.  We'll see what
the new parameter means when we look at the changes to repository.c.

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 7e00d57d654..901bf30b508 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -89,7 +89,7 @@ int cmd_init_db(int argc,
>  	const struct option init_db_options[] = {
>  		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
>  				N_("directory from which templates will be used")),
> -		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
> +		OPT_SET_INT(0, "bare", &the_repository->is_bare_cfg,
>  				N_("create a bare repository"), 1),
>  		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
>  			N_("permissions"),

As you said, this depends on the fact that the_repository is a
pointer pointing at the static singleton variable the_repo at the
compile time, so while it is already safe to take the address of
the_repository->is_bare_cfg to prepare the array of options here, we
haven't really solved the "we shouldn't be using this global
variable" yet.  But we can go one step at a time.

The remaining hunks in the file now all access the "global variable"
via the_repository pointer, but the fact remains that the address of
the thing being accessed is determined at the compile time, so it is
just like accessing a global variable.

Which is naturally expected.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b6b5f1ebde7..7bff99bf08f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1591,7 +1591,7 @@ static int add_possible_reference_from_superproject(
>  		struct strbuf err = STRBUF_INIT;
>  		strbuf_add(&sb, odb->path, len);
>  
> -		if (repo_init(&alternate, sb.buf, NULL) < 0)
> +		if (repo_init(&alternate, sb.buf, NULL, the_repository->is_bare_cfg) < 0)

OK.  I do not recall what the original repo_init() did, but I
presume that it initialized the new one depending on what the global
variable said.  We now propagate the setting from the superproject
down to the submodule, which amounts to the same thing but probably
is better as the "inheritance" is more explicitly visible here?

> diff --git a/config.c b/config.c
> index a11bb85da30..c1b14c89947 100644
> --- a/config.c
> +++ b/config.c
> @@ -1441,7 +1441,7 @@ static int git_default_core_config(const char *var, const char *value,
>  	}
>  
>  	if (!strcmp(var, "core.bare")) {
> -		is_bare_repository_cfg = git_config_bool(var, value);
> +		the_repository->is_bare_cfg = git_config_bool(var, value);
>  		return 0;
>  	}

OK.  This is the same as what init-db did.

> diff --git a/dir.c b/dir.c
> index e3ddd5b5296..c995668e54c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -4008,7 +4008,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
>  	const struct submodule *sub;
>  
>  	/* If the submodule has no working tree, we can ignore it. */
> -	if (repo_init(&subrepo, sub_gitdir, sub_worktree))
> +	if (repo_init(&subrepo, sub_gitdir, sub_worktree, the_repository->is_bare_cfg))
>  		return;

Same logic for submodule inheriting from the superproject?

> diff --git a/environment.c b/environment.c
> index a2ce9980818..9af20d5e34e 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -34,7 +34,6 @@ int has_symlinks = 1;
>  int minimum_abbrev = 4, default_abbrev = -1;
>  int ignore_case;
>  int assume_unchanged;
> -int is_bare_repository_cfg = -1; /* unspecified */

This is now gone.  We'll see a corresponding change in repository.c
where the_repo instance is initialized, I presume.

> @@ -146,12 +145,6 @@ const char *getenv_safe(struct strvec *argv, const char *name)
>  	return argv->v[argv->nr - 1];
>  }
>  
> -int is_bare_repository(void)
> -{
> -	/* if core.bare is not 'false', let's see if there is a work tree */
> -	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
> -}

This is now gone, and we'll see a corresponding change in
repository.c, I presume.

It is somewhat curious that in a repository where core.bare says
true, we countermand it if we cannot figure out where its working
tree is and say "core.bare is lying; we are in a bare repository".

The curiousity is not the fault of this patch, of course.  The
updated code in repository.c would hopefully have the same
curiousity (or we'd be looking at an unintended behaviour change,
if it didn't).

> diff --git a/environment.h b/environment.h
> index 923e12661e1..23f29a4df05 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -144,8 +144,7 @@ void set_shared_repository(int value);
>  int get_shared_repository(void);
>  void reset_shared_repository(void);
>  
> -extern int is_bare_repository_cfg;
> -int is_bare_repository(void);
> +int is_bare_repository(struct repository *repo);

Curious.  I somehow thought is_bare_repository() will be gone, and
everybody is supposed to call repo_is_bare(the_repository), instead.

What makes a caller pick one over the other?


> diff --git a/git.c b/git.c
> index c2c1b8e22c2..c8ed29b2295 100644
> --- a/git.c
> +++ b/git.c
> @@ -251,7 +251,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  				*envchanged = 1;
>  		} else if (!strcmp(cmd, "--bare")) {
>  			char *cwd = xgetcwd();
> -			is_bare_repository_cfg = 1;
> +			the_repository->is_bare_cfg = 1;

OK.  The same as how init-db and config now access the new member of
the global singleton the_repository instead of the global variable.

> diff --git a/repository.c b/repository.c
> index f988b8ae68a..96608058b61 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -25,7 +25,9 @@
>  extern struct repository *the_repository;
>  
>  /* The main repository */
> -static struct repository the_repo;
> +static struct repository the_repo = {
> +	.is_bare_cfg = -1,
> +};

OK, this is just as expected by reading the patch so far.

> @@ -263,10 +265,13 @@ static int read_and_verify_repository_format(struct repository_format *format,
>  /*
>   * Initialize 'repo' based on the provided 'gitdir'.
>   * Return 0 upon success and a non-zero value upon failure.
> + * is_bare can be passed to indicate whether or not the repository should be
> + * treated as bare when repo_init() is used to initiate a secondary repository.

"initiate" -> "initialize" perhaps?

>  int repo_init(struct repository *repo,
>  	      const char *gitdir,
> -	      const char *worktree)
> +	      const char *worktree,
> +	      int is_bare)
>  {
>  	struct repository_format format = REPOSITORY_FORMAT_INIT;
>  	memset(repo, 0, sizeof(*repo));
> @@ -283,6 +288,8 @@ int repo_init(struct repository *repo,
>  	repo_set_compat_hash_algo(repo, format.compat_hash_algo);
>  	repo_set_ref_storage_format(repo, format.ref_storage_format);
>  	repo->repository_format_worktree_config = format.worktree_config;
> +	if (is_bare > 0)
> +		repo->is_bare_cfg = is_bare;

When repo_init() is called with anything other than &the_repo, who
initializes repo->is_bare_cfg?  If the answer is "nobody", shouldn't
this function be doing something like

	repo->is_bare_cfg = (0 <= is_bare) ? is_bare : -1;

which actually amounts to an unconditional

	repo->is_bare_cfg = is_bare;

as is_bare can only take one of (-1, 0, 1).

Perhaps I am missing some subtleties in the original construction
you wrote?  You leave repo->is_bare_cfg unset when is_bare parameter
explicitly says "false", which I suspect might be related to the
source of confusion I am having.

> +int repo_is_bare(struct repository *repo)
> +{
> +	/* if core.bare is not 'false', let's see if there is a work tree */
> +	return repo->is_bare_cfg && !repo_get_work_tree(repo);
> +}

The curiosity we saw in the original implementation of
is_bare_repository() above is faithfully reproduced, which is good.

> diff --git a/repository.h b/repository.h
> index 24a66a496a6..c243653492b 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -153,6 +153,14 @@ struct repository {
>  
>  	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
>  	unsigned different_commondir:1;
> +
> +	/*
> +	 * Indicates if the repository is set to be treated as a bare repository,
> +	 * through a command line argument, configuration, or environment
> +	 * variable.
> +	 * -1 means unspecified, 0 indicates non-bare, and 1 indicates bare.
> +	 */
> +	int is_bare_cfg;
>  };

I am very happy with the above phrasing.  The member tells us what
the repo is "set to be treated as", which implies that the code does
a bit more on top of that setting.

> diff --git a/scalar.c b/scalar.c
> index ac0cb579d3f..c2ec1f3e745 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -722,7 +722,7 @@ static int cmd_reconfigure(int argc, const char **argv)
>  
>  		git_config_clear();
>  
> -		if (repo_init(&r, gitdir.buf, commondir.buf))
> +		if (repo_init(&r, gitdir.buf, commondir.buf, the_repository->is_bare_cfg))
>  			goto loop_end;

Given this caller, if is_bare_cfg of the current state says "I am
set to be treated as a non-bare repository" by having 0, shouldn't
repo_init() copy it to the repository at r?  IOW, this yells at me
saying that repo_init() patch we saw earlier is somewhat buggy.

> diff --git a/setup.c b/setup.c
> index 7b648de0279..6bc4aef3a8b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -766,8 +766,8 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
>  
>  	if (!has_common) {
>  		if (candidate->is_bare != -1) {
> -			is_bare_repository_cfg = candidate->is_bare;
> -			if (is_bare_repository_cfg == 1)
> +			the_repository->is_bare_cfg = candidate->is_bare;
> +			if (the_repository->is_bare_cfg == 1)
>  				inside_work_tree = -1;

OK, this is as expected.

All other hunks to this file, except for the last one, follow the
same pattern as init-db and config to access the member of the
singleton struct instead of global variable.  And the last one is to
call repo_is_bare(the_repository) instead of is_bare_repository().

Makes sense.

> diff --git a/transport.c b/transport.c
> index 47fda6a7732..d72b8380846 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1428,7 +1428,7 @@ int transport_push(struct repository *r,
>  
>  	if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
>  		      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
> -	    !is_bare_repository()) {
> +	    !repo_is_bare(r)) {
>  		struct ref *ref = remote_refs;
>  		struct oid_array commits = OID_ARRAY_INIT;
>  
> @@ -1455,7 +1455,7 @@ int transport_push(struct repository *r,
>  	if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
>  	     ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
>  			TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
> -	      !pretend)) && !is_bare_repository()) {
> +	      !pretend)) && !repo_is_bare(r)) {
>  		struct ref *ref = remote_refs;
>  		struct string_list needs_pushing = STRING_LIST_INIT_DUP;
>  		struct oid_array commits = OID_ARRAY_INIT;

OK, these are better than the mechanical "singleton the_repository
is the new home for the global".  It makes it even more important
for us to answer "Who initializes the repository r?  Is is_bare_cfg
initialized to -1 just like the_repo.is_bare_cfg is?  Is repo_init()
doing the right thing to update it by doing only when it is set to 1
but ignoring -1 and 0 as incoming parameter?" questions, though.

> diff --git a/worktree.c b/worktree.c
> index 77ff484d3ec..c9d5b228959 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -85,8 +85,8 @@ static struct worktree *get_main_worktree(int skip_reading_head)
>  	 * This means that worktree->is_bare may be set to 0 even if the main
>  	 * worktree is configured to be bare.
>  	 */
> -	worktree->is_bare = (is_bare_repository_cfg == 1) ||
> -		is_bare_repository();
> +
> +	worktree->is_bare = the_repository->is_bare_cfg == 1;

If this changes the behaviour subtly without explaining, it needs to
be justified, I suspect.

We used to pay attention to what is_bare_repository() says, which is
a bit more than "set to bbe treated as" with config.  We no longer
do so, and also unconfigured case is always treated as non-bare.

