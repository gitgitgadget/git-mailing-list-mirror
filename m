Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277FB30FC33
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771021788; cv=none; b=EG0pS2rzD9GTXl4o6oemKpNmyFoH1Fo9qQ14O+4QjkxSpXexFzExLtaL3KlSkOcdEt1A9+CJNiQfUu0RYqIbTPLrrlOI92uMQBJVL87FxNHDv2nOE481LvhaouKebPfhFN8IoNMcSIDMKa9/LZ9whVS0wFV7KBN/LzMsbl3XW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771021788; c=relaxed/simple;
	bh=BcSAMljIVi/E1swUvZ7xYgvoAT9reo/0Jk1hJ82wlYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F0/s4UuT8wxqFphwJli2/7uSIwkiUMMPM+owLCxSwCk+jYEAje9XxEbhysrbbnJzV2rNWPUH9WIu128jSbF09geQB3D5NbKQ9XOW5xVqP63QI8eFvIHbQ15L5IoeDT4xI+XX6hbTnW1zEB4WNY1E1l9txQPRS2P9yByseNYJRXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2SqZrVjr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IXK4BR7L; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2SqZrVjr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IXK4BR7L"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 09D071D00078;
	Fri, 13 Feb 2026 17:29:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 13 Feb 2026 17:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771021785; x=1771108185; bh=j5966VgTNs
	GcGAz++bo9kowS2XdDsnr+le+hcu1dXYs=; b=2SqZrVjrKaaAUA7nMLUmNIt3Mq
	FR9cf9+JhXvZp9idsxblVLJlPQ8dsAJT93z1OXHqhrrgDEJasCvYHKfSx5Mipp4C
	MlfRx4vMkst+oQ1X5RWXSIOqOH/SE5Q6mfOVgUF3zRclP5xGH0hAi8FC2q8jqsff
	ke/rsZz1pyKKsps5Wd6GAdlCGE/onyPBSk7yjz1IQET/4M/e/zm6kudeym38HGSG
	yx26ifOwzkO/TbjYHPDL8VQqqjyMG7Ru5ylzPAnqnRhb56/f5THJo7T6Fc3rzJJv
	n4UXsN5kfryI/QNfIklPXQ31OdOTb+O5fvYmwvBjYoJmned8zNXBQWiz6VVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771021785; x=1771108185; bh=j5966VgTNsGcGAz++bo9kowS2XdDsnr+le+
	hcu1dXYs=; b=IXK4BR7LiEIdMKhL7ou4TZ1nEy+7LkdaMdVGwMUF4C9HiI+VeHq
	ynxyufppWcF02I3vFoUJlmHleC5S/fwYixZFHtqwBgHuYo6d2Yy88NTDXRVV6e8H
	6ZmP2BplqrEqOlWqQHPSVmkdOXUVwoKYdKexIufCLUodBk8eqUkC/OK+FvoD+p26
	IbMWU6zlYKcpSZfZd0vYan42lGVvzFF/F4bSfiI/xfh2xxhZye4lPp239QBFZYhq
	MNpTqpY6soa/XT3xkeTcbTqqKa8d55CMLw027bARP/dzZoxLmLXgWzKYr7EpaSHK
	TQUjH2y4JmNto5+UtmTqznU0FEECL1D2/jw==
X-ME-Sender: <xms:2aWPaaVSD2_3QEGvQ3klDGbMpyLAI4ApVLg36PDz8tJMQCYRBM9W0Q>
    <xme:2aWPadkuEbdNjH4zB8wB5JVq6wr5r_XygwRHCtmaW4a1GD2PwigSbJJGGbfwxIRqS
    Y5u1pjQTqM2AXJX6Uwo6ziN8qiBd2rT3DXknTchRM9L-hWlKJCmAwA>
X-ME-Received: <xmr:2aWPaTb2XS5BrwYB3TjYoOUIIicHOyhj5Sqea6I4frLy4f49XFlSUjLYHzL8udC5s2kqiqWhVKob_JeGgqNAqWm5wCiBzzCDQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:2aWPaQNnHtAltlPaMebhVsgwvRUVadP8sYnyARHYgR0BMR7E_QcCbA>
    <xmx:2aWPaQbEgyvPvoog1ynRDDFJZyBCJN31msvfl18G5FMmfGp0iU9hEg>
    <xmx:2aWPaW0oViFGgj0rTZ8o4-W47PhqDU5Sbvk6XS4dbFNHsxH70Ga1Hw>
    <xmx:2aWPaec3aOw06QXMLXzjVFHw4iojSoUHRHM8gI9G1rVRueu_RGf58w>
    <xmx:2aWPae67yGkICiu8MBTGMssVMa7j02t455tRAELe27twkRCaeVA16gcT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 17:29:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [RFC][PATCH 2/2] worktree: stop passing NULL as primary worktree
In-Reply-To: <20260213120529.15475-3-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Fri, 13 Feb 2026 17:29:54 +0530")
References: <20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260213120529.15475-3-shreyanshpaliwalcmsmn@gmail.com>
Date: Fri, 13 Feb 2026 14:29:43 -0800
Message-ID: <xmqqcy28jmzs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> -			path = xstrdup(worktree_git_path(the_repository, wt, "index"));
> +			path = xstrdup(worktree_git_path(wt, "index"));

We'll understand this change when we read the changes to
worktree_git_path() later in this patch, I guess.  I will not
comment on the same changes around worktree_git_path() callers.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index fbdaf2eb2e..27c5889c89 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -328,6 +328,8 @@ static void check_candidate_path(const char *path,
>  	wt = find_worktree_by_path(worktrees, path);
>  	if (!wt)
>  		return;
> +	if(is_main_worktree(wt))
> +		die(_("'%s' is the main worktree"), path);

Style (missing SP between "if" and "(condition)").

Earlier, a failure from find_worktree_by_path(), presumably meaning
"you gave me this path, but that is not where any of our worktrees
live" gave wt==NULL and it silently returned.  Could the function
returned wt==NULL to signal that the path is where the primary
worktree is?  I guess not (it seems to give us a worktree instance
with wt->id==NULL).

So, we never cared about wt being the primary worktree, but now we
care.  Why do we need to?

> @@ -660,7 +662,8 @@ static int can_use_local_refs(const struct add_opts *opts)
>  		if (!opts->quiet) {
>  			struct strbuf path = STRBUF_INIT;
>  			struct strbuf contents = STRBUF_INIT;
> -			char *wt_gitdir = get_worktree_git_dir(NULL);
> +			struct worktree **worktrees = get_worktrees_repo(the_repository);
> +			char *wt_gitdir = get_worktree_git_dir(worktrees[0]);

We used to pass NULL to get_worktree_git_dir() to ask about the
primary working tree, but the convention is no longer available.  So
we use get_worktrees_repo(), presumably is a new function, that
gives all the worktrees honoring the "first one in the resulting
list is the primary one" convention, only to use the first element
in the list.

I wonder if making worktree.c:get_main_worktree(), which is a file
scope static in worktree.c, available would allow us express this
logic more directly?

>  			strbuf_add_real_path(&path, wt_gitdir);
>  			strbuf_addstr(&path, "/HEAD");
> @@ -675,6 +678,7 @@ static int can_use_local_refs(const struct add_opts *opts)
>  			strbuf_release(&path);
>  			strbuf_release(&contents);
>  			free(wt_gitdir);
> +			free_worktrees(worktrees);

Anyway, we need to release the list of worktrees here.

> @@ -1191,14 +1195,14 @@ static void validate_no_submodules(const struct worktree *wt)
>  
>  	wt_gitdir = get_worktree_git_dir(wt);
>  
> -	if (is_directory(worktree_git_path(the_repository, wt, "modules"))) {
> +	if (is_directory(worktree_git_path(wt, "modules"))) {
> -	} else if (read_index_from(&istate, worktree_git_path(the_repository, wt, "index"),
> +	} else if (read_index_from(&istate, worktree_git_path(wt, "index"),

Ditto on worktree_git_path().

> diff --git a/path.c b/path.c
> index d726537622..4ac86e1e58 100644
> --- a/path.c
> +++ b/path.c
> @@ -408,9 +408,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
>  				   const struct repository *repo,
>  				   const struct worktree *wt)
>  {
> -	if (!wt)
> -		strbuf_addstr(buf, repo->gitdir);
> -	else if (!wt->id)
> +	if (is_main_worktree(wt))
>  		strbuf_addstr(buf, repo->commondir);
>  	else
>  		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);

This is curious.

We used to treat "wt==NULL" and "wt->id==NULL" differently.  Now we
use repo->commondir for both.  For the primary worktree, it ought to
be the same as repo->gitdir, so it should not matter, but makes me
wonder what the reason behind this difference in the original.

We have been assuming that wt==NULL and wt->id==NULL both meant the
same thing: "we are talking about the primary worktree".  But the
code around here before this patch seems to behave differently.  Is
our assumption incorrect and are we making a mistake by conflating
these two conditions into one?

> @@ -437,8 +435,10 @@ char *repo_git_path(struct repository *repo,
>  	struct strbuf path = STRBUF_INIT;
>  	va_list args;
>  	va_start(args, fmt);
> -	repo_git_pathv(repo, NULL, &path, fmt, args);
> +	struct worktree **worktrees = get_worktrees_repo(repo);
> +	repo_git_pathv(repo, worktrees[0], &path, fmt, args);
>  	va_end(args);
> +	free_worktrees(worktrees);

The same "to pass the primary worktree, we need to grab everybody
and pass the first one" pattern is repeated here.

> @@ -448,8 +448,10 @@ const char *repo_git_path_append(struct repository *repo,
>  {
>  	va_list args;
>  	va_start(args, fmt);
> -	repo_git_pathv(repo, NULL, sb, fmt, args);
> +	struct worktree **worktrees = get_worktrees_repo(repo);
> +	repo_git_pathv(repo, worktrees[0], sb, fmt, args);
>  	va_end(args);
> +	free_worktrees(worktrees);

And again here.

> @@ -460,8 +462,10 @@ const char *repo_git_path_replace(struct repository *repo,
>  	va_list args;
>  	strbuf_reset(sb);
>  	va_start(args, fmt);
> -	repo_git_pathv(repo, NULL, sb, fmt, args);
> +	struct worktree **worktrees = get_worktrees_repo(repo);
> +	repo_git_pathv(repo, worktrees[0], sb, fmt, args);
>  	va_end(args);
> +	free_worktrees(worktrees);

And again here.

> @@ -486,17 +490,12 @@ const char *mkpath(const char *fmt, ...)
>  	return cleanup_path(pathname->buf);
>  }
>  
> -const char *worktree_git_path(struct repository *r,
> -			      const struct worktree *wt, const char *fmt, ...)
> +const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
>  {

Since we no longer use wt==NULL as the sign to work on the primary
working tree, we can rely on wt->repo being a valid repository the
caller wants to work with.

>  	struct strbuf *pathname = get_pathname();
>  	va_list args;
> -
> -	if (wt && wt->repo != r)
> -		BUG("worktree not connected to expected repository");
> -
>  	va_start(args, fmt);
> -	repo_git_pathv(r, wt, pathname, fmt, args);
> +	repo_git_pathv(wt->repo, wt, pathname, fmt, args);
>  	va_end(args);
>  	return pathname->buf;
>  }
> diff --git a/path.h b/path.h
> index 0ec95a0b07..54e09b2883 100644
> --- a/path.h
> +++ b/path.h
> @@ -66,13 +66,10 @@ const char *repo_git_path_replace(struct repository *repo,
>  
>  /*
>   * Similar to repo_git_path() but can produce paths for a specified
> - * worktree instead of current one. When no worktree is given, then the path is
> - * computed relative to main worktree of the given repository.
> + * worktree instead of current one.
>   */
> -const char *worktree_git_path(struct repository *r,
> -			      const struct worktree *wt,
> -			      const char *fmt, ...)
> -	__attribute__((format (printf, 3, 4)));
> +const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
> +	__attribute__((format (printf, 2, 3)));

Good.

> diff --git a/refs.c b/refs.c
> index 627b7f8698..98df2235e7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2324,12 +2324,12 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
>  	if (wt->is_current)
>  		return get_main_ref_store(wt->repo);
>  
> -	id = wt->id ? wt->id : "/";
> +	id = wt->id;
>  	refs = lookup_ref_store_map(&wt->repo->worktree_ref_stores, id);
>  	if (refs)
>  		return refs;
>  
> -	if (wt->id) {
> +	if (!is_main_worktree(wt)) {
>  		struct strbuf common_path = STRBUF_INIT;
>  		repo_common_path_append(wt->repo, &common_path,
>  					"worktrees/%s", wt->id);

Good.  The original uses local "id" as a pathname component (which
could be "/"), and wt->id==NULL as the sign that it is the primary.
The updated code is a faithful conversion of it to the new world
order.

> diff --git a/revision.c b/revision.c
> index 9b131670f7..a9d4f796ed 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1730,12 +1730,14 @@ void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
>  
>  	cb.all_revs = revs;
>  	cb.all_flags = flags;
> -	cb.wt = NULL;
> +	struct worktree **worktrees = get_worktrees_repo(the_repository);
> +	cb.wt = worktrees[0];
>  	refs_for_each_reflog(get_main_ref_store(the_repository),
>  			     handle_one_reflog, &cb);
>  
>  	if (!revs->single_worktree)
>  		add_other_reflogs_to_pending(&cb);
> +	free_worktrees(worktrees);

The same "to pass the primary worktree, we need to grab everybody
and pass the first one" pattern strikes again.

> diff --git a/worktree.c b/worktree.c
> index b29934407f..1059c18115 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -91,16 +91,16 @@ static int is_main_worktree_bare(struct repository *repo)
>  /**
>   * get the main worktree
>   */
> -static struct worktree *get_main_worktree(int skip_reading_head)
> +static struct worktree *get_main_worktree(struct repository *repo, int skip_reading_head)
>  {
>  	struct worktree *worktree = NULL;
>  	struct strbuf worktree_path = STRBUF_INIT;
>  
> -	strbuf_add_real_path(&worktree_path, repo_get_common_dir(the_repository));
> +	strbuf_add_real_path(&worktree_path, repo_get_common_dir(repo));
>  	strbuf_strip_suffix(&worktree_path, "/.git");
>  
>  	CALLOC_ARRAY(worktree, 1);
> -	worktree->repo = the_repository;
> +	worktree->repo = repo;
>  	worktree->id = xstrdup("/");
>  	worktree->path = strbuf_detach(&worktree_path, NULL);
>  	worktree->is_current = is_current_worktree(worktree);
> @@ -112,7 +112,7 @@ static struct worktree *get_main_worktree(int skip_reading_head)
>  		 * This check is unnecessary if we're currently in the main worktree,
>  		 * as prior checks already consulted all configs of the current worktree.
>  		 */
> -		(!worktree->is_current && is_main_worktree_bare(the_repository));
> +		(!worktree->is_current && is_main_worktree_bare(repo));
>  
>  	if (!skip_reading_head)
>  		add_head_info(worktree);

Weaning the code from depending on the_repository is mixed into the
refactoring, which makes me wonder if it is better done in a
separate patch.  We seriously should consider making this function
externally visible, as so many callers want to get hold of it.

I also wonder if "struct repository" wants to have a member that
points at the primary worktree instance, but I think I am getting
way ahead of myself.

> @@ -199,12 +199,15 @@ static struct worktree **get_worktrees_internal(int skip_reading_head)
>  
>  struct worktree **get_worktrees(void)
>  {
> -	return get_worktrees_internal(0);
> +	return get_worktrees_repo(the_repository);
> +}
> +struct worktree **get_worktrees_repo(struct repository *repo)
> +{
> +	return get_worktrees_internal(repo, 0);
>  }

OK.

> @@ -1795,18 +1795,19 @@ void wt_status_get_state(struct repository *r,
>  	struct stat st;
>  	struct object_id oid;
>  	enum replay_action action;
> +	struct worktree **worktrees = get_worktrees_repo(r);
>  
>  	if (!stat(git_path_merge_head(r), &st)) {
> -		wt_status_check_rebase(NULL, state);
> +		wt_status_check_rebase(worktrees[0], state);
>  		state->merge_in_progress = 1;
> -	} else if (wt_status_check_rebase(NULL, state)) {
> +	} else if (wt_status_check_rebase(worktrees[0], state)) {
>  		;		/* all set */
>  	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
>  		   !repo_get_oid(r, "CHERRY_PICK_HEAD", &oid)) {
>  		state->cherry_pick_in_progress = 1;
>  		oidcpy(&state->cherry_pick_head_oid, &oid);
>  	}
> -	wt_status_check_bisect(NULL, state);
> +	wt_status_check_bisect(worktrees[0], state);
>  	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
>  	    !repo_get_oid(r, "REVERT_HEAD", &oid)) {
>  		state->revert_in_progress = 1;
> @@ -1824,6 +1825,7 @@ void wt_status_get_state(struct repository *r,
>  	if (get_detached_from)
>  		wt_status_get_detached_from(r, state);
>  	wt_status_check_sparse_checkout(r, state);
> +	free_worktrees(worktrees);
>  }

The same "to pass the primary worktree, we need to grab everybody
and pass the first one" pattern strikes yet another time.

Thanks.
