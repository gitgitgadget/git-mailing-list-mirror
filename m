Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE2253932
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771063856; cv=none; b=rU4adJliED8RclExheyyNIZWRqs7/Nnyoa28UDhXOxwwxMexLPx2HQYJHNQzLZMz4daPff3AVbZdgzNDdCgOHfIx3Dy8ZoOpMHvrvkkmU6vC/O3weMXKnAgnkpqSyoj0g81/AxM5p+fy3POPRE2E4bPYJTzSoR6PMcTvHh2udJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771063856; c=relaxed/simple;
	bh=I+/qpmajfcqJdRJ78+EheomYQxVAmEnqwBUvnV/0x1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9R7PUNEmS5kAaRF37GhEkaA1bSRvIGYLAYNS6rtgfNhJ4Srlrc92Sc9XwMJU2cTqKzXG4IjvufxSZ0IJH8JyND6NcFxEhWv+rcTZBnNzaxkWuSDzF3a2jCM8/fmh7ffvZm8kT7tLfMKL3pZGFvOrW3xxOJ54L2L25P+6n17LzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj5OrZGw; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj5OrZGw"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a7a23f5915so10125495ad.2
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 02:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771063855; x=1771668655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf/LSUlfbnzOJsi8PfKw0ZdiFgsgmzeFVHv6VzqFzGU=;
        b=Pj5OrZGwvKlMT2mClb4Iql7Tgi+hxny5DmKh7wJEGS6Bj2+Z/qcV1hgKP3nMHa1oZU
         vElIrkz5MOZe5hnuBQ+Qnin2EG7P0IIV3SZXdT7WagRi+xiNnJSrtReUMEd9BDrtdzx8
         XS+k9JF+jyAmtpXXIN5uoSOqT6ebxagdLJ7/r3sbihK26PDd44S0buvG8Cc7789AlFB/
         wfuA0bTjGn5LB8x9KFBZW1m7rtXuHaJAgrgqsjSpl6IOnPeGva40m+CdfT0ZNlj6YG4F
         n42qalqZKNNMg/O4Tw3jPuF28hK6TYVA0eJaX9H+pOh00P8ISvEQeH4U6kaZGOgNFToh
         R1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771063855; x=1771668655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mf/LSUlfbnzOJsi8PfKw0ZdiFgsgmzeFVHv6VzqFzGU=;
        b=OG7fvwbr/11mVy1XOZVsyz5QhHkmxM6iKUTaheNPCu6YfwMnG6mOQ/Nj+Ijum0M8DM
         sbpI6UO+UD0jP/E0WBnkGW7ISG+7/ZzFvTOANlh3GiOw6QkQ4ZE6U3UbJQ7hZbZYJtlf
         WE5ttdFvNtktSzTkZ+DcxewrhyKXVNTRfNsIOn79rmSbArx6SvLBkm3vXvshM16shuDs
         1K74zIFvkXzpcGEw42+wAe4SImD/iBkidr4IzJliN/P4fCmaOc+5eUDAGx5Yp0jBxkuR
         scM3uv1YkPa1NPvtpTv1dS+VC9t+qvh5LjVzeEJBlfJqo4GKuHp8zcI7L2KKFUJ8vo3c
         2isg==
X-Gm-Message-State: AOJu0YwgHRZB0/5a80rQKOsoS1/dk0UGTsl7lkd5/jlfTHWQpEOgSS/W
	GNGf+Iq+sNMh+SHVI13k9CwbnIgDYlEMTMPflvxc4lJiGnHP629lqzM0965I3CUq
X-Gm-Gg: AZuq6aJCDb52T8YTTBHQYeAPv3znCd+O9AZymTo2K6AHMIgwxXl9xHFtZKLrKOs6vY6
	I9bn+ASYMremMsY6+b3G429oU8Hh9whO5MvGXhLsi/o6ezpklRdauy0GzAiuj24NuzN3d1Ay5i7
	pMqMsnp+eVdD3vaYYyB2dRAGxcE6pPpxTOsc6C6QHVfYTIKwQAtDY/bI/5ciUYOuX1Wr2i5DG/r
	wZuq+NexBqgkLzVgbwr+BdAS1nDvB03QBinLbEgk5dwhTXg6Mo30KL01nCTwfhhp3nADws8I1iO
	cOtnboqp0hQGBVI6/NEeyKPQ/E5RudOm5M5ZOuoIm/lkiRJBcPdENIYlCd4XqC+xM10rU6+pfEI
	hg7wjhOMyP8l9S5eu7wsEhfG+PXkwqvi/EeZkzYVyTfSQhHiH9hf2lizCZglpFkflmR9IWIwHdk
	PCPmPNJ0xjNQ0NecOMIMTH7Fw1C1tv1AU1XaPwPCfUxetEGF90uZDCCscmVvM=
X-Received: by 2002:a17:903:2f0f:b0:2aa:d5b1:1954 with SMTP id d9443c01a7336-2ab505468d3mr43702885ad.16.1771063854826;
        Sat, 14 Feb 2026 02:10:54 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:fdd2:ec18:ed48:b60d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5bc8sm15380325ad.60.2026.02.14.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 02:10:54 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [RFC][PATCH 2/2] worktree: stop passing NULL as primary worktree
Date: Sat, 14 Feb 2026 15:29:33 +0530
Message-ID: <20260214101045.515941-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqcy28jmzs.fsf@gitster.g>
References: <xmqqcy28jmzs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index fbdaf2eb2e..27c5889c89 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -328,6 +328,8 @@ static void check_candidate_path(const char *path,
> >  	wt = find_worktree_by_path(worktrees, path);
> >  	if (!wt)
> >  		return;
> > +	if(is_main_worktree(wt))
> > +		die(_("'%s' is the main worktree"), path);
>
> Style (missing SP between "if" and "(condition)").

my bad, will fix that.

> Earlier, a failure from find_worktree_by_path(), presumably meaning
> "you gave me this path, but that is not where any of our worktrees
> live" gave wt==NULL and it silently returned.  Could the function
> returned wt==NULL to signal that the path is where the primary
> worktree is?  I guess not (it seems to give us a worktree instance
> with wt->id==NULL).
>
> So, we never cared about wt being the primary worktree, but now we
> care.  Why do we need to?

The function check_candidate_path() is basically to check the path we can
add a worktree, so if we are receiving primary worktree it shouldn't proceed
and further in the function we are calling delete_git_dir(wt->id)
below which then further calls repo_common_path_append() with id.
So to prevent feeding '/' to this we need to check if the worktree is
main or not.

> > @@ -660,7 +662,8 @@ static int can_use_local_refs(const struct add_opts *opts)
> >  		if (!opts->quiet) {
> >  			struct strbuf path = STRBUF_INIT;
> >  			struct strbuf contents = STRBUF_INIT;
> > -			char *wt_gitdir = get_worktree_git_dir(NULL);
> > +			struct worktree **worktrees = get_worktrees_repo(the_repository);
> > +			char *wt_gitdir = get_worktree_git_dir(worktrees[0]);
>
> We used to pass NULL to get_worktree_git_dir() to ask about the
> primary working tree, but the convention is no longer available.  So
> we use get_worktrees_repo(), presumably is a new function, that
> gives all the worktrees honoring the "first one in the resulting
> list is the primary one" convention, only to use the first element
> in the list.
>
> I wonder if making worktree.c:get_main_worktree(), which is a file
> scope static in worktree.c, available would allow us express this
> logic more directly?

Actually I thought about making get_main_worktree() available but then
I saw helpers like get_worktrees() so I thought that get_worktrees_repo()
would be better for every use case.
But I agree since there are so many sites to access the main worktree, we can
make get_main_worktree() available and use it instead of introducing
get_worktrees_repo().

> > diff --git a/path.c b/path.c
> > index d726537622..4ac86e1e58 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -408,9 +408,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
> >  				   const struct repository *repo,
> >  				   const struct worktree *wt)
> >  {
> > -	if (!wt)
> > -		strbuf_addstr(buf, repo->gitdir);
> > -	else if (!wt->id)
> > +	if (is_main_worktree(wt))
> >  		strbuf_addstr(buf, repo->commondir);
> >  	else
> >  		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
>
> This is curious.
>
> We used to treat "wt==NULL" and "wt->id==NULL" differently.  Now we
> use repo->commondir for both.  For the primary worktree, it ought to
> be the same as repo->gitdir, so it should not matter, but makes me
> wonder what the reason behind this difference in the original.
>
> We have been assuming that wt==NULL and wt->id==NULL both meant the
> same thing: "we are talking about the primary worktree".  But the
> code around here before this patch seems to behave differently.  Is
> our assumption incorrect and are we making a mistake by conflating
> these two conditions into one?

Yes it came into my mind as well. So if we check were strbuf_worktree_gitdir()
is called from, there is only one function repo_git_pathv() which is mostly
called with a NULL wt (primary worktree) and called once with an actual
worktreee once inside worktree_git_path() which had some NULL indirect callers
inside wt-status.c which again meant wt being primary.
I think different usecases for wt and wt->id being NULL was just an oversight
at this particular instance and both of them should refer to the main worktree.

> > diff --git a/worktree.c b/worktree.c
> > index b29934407f..1059c18115 100644
> > --- a/worktree.c
> > +++ b/worktree.c
> > @@ -91,16 +91,16 @@ static int is_main_worktree_bare(struct repository *repo)
> >  /**
> >   * get the main worktree
> >   */
> > -static struct worktree *get_main_worktree(int skip_reading_head)
> > +static struct worktree *get_main_worktree(struct repository *repo, int skip_reading_head)
> >  {
> >  	struct worktree *worktree = NULL;
> >  	struct strbuf worktree_path = STRBUF_INIT;
> >
> > -	strbuf_add_real_path(&worktree_path, repo_get_common_dir(the_repository));
> > +	strbuf_add_real_path(&worktree_path, repo_get_common_dir(repo));
> >  	strbuf_strip_suffix(&worktree_path, "/.git");
> >
> >  	CALLOC_ARRAY(worktree, 1);
> > -	worktree->repo = the_repository;
> > +	worktree->repo = repo;
> >  	worktree->id = xstrdup("/");
> >  	worktree->path = strbuf_detach(&worktree_path, NULL);
> >  	worktree->is_current = is_current_worktree(worktree);
> > @@ -112,7 +112,7 @@ static struct worktree *get_main_worktree(int skip_reading_head)
> >  		 * This check is unnecessary if we're currently in the main worktree,
> >  		 * as prior checks already consulted all configs of the current worktree.
> >  		 */
> > -		(!worktree->is_current && is_main_worktree_bare(the_repository));
> > +		(!worktree->is_current && is_main_worktree_bare(repo));
> >
> >  	if (!skip_reading_head)
> >  		add_head_info(worktree);
>
> Weaning the code from depending on the_repository is mixed into the
> refactoring, which makes me wonder if it is better done in a
> separate patch.  We seriously should consider making this function
> externally visible, as so many callers want to get hold of it.
>
> I also wonder if "struct repository" wants to have a member that
> points at the primary worktree instance, but I think I am getting
> way ahead of myself.

Yes agreed. I will in a seperate patch make get_main_worktree() available
with a struct repository * argument instead of the_repository and then
we can use it in all the places where we need to access the main worktree.

And I think that if we are making get_main_worktree() with a
struct repository * argument available, then we can skip adding a new member
to struct repository and just call get_main_worktree() whenever we need to
access the main worktree with respect to whatever instance of repository we
are working with.

Thanks for reviewing.

Best,
Shreyansh
