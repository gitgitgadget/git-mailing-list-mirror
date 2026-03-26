Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B25405AB5
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540110; cv=none; b=fjezxppHnVDcqD9XvTvrzLRmiNawZwSdUpIpZSKkabC8UUsPAxlyG2oKq6AOeqnmDAFHyThCgWyEiSfi47v6CWOAJVEL4zo3T0qdjcKNtZATDK6XvBLREGElXFeYolb1xMJFOc16HE60kRCiXPXNXKtoGxAKiVzuLkZvqmaaSaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540110; c=relaxed/simple;
	bh=BNKkZbpSKS507Pji03DgeogJ1fdbWjbwi3nRlXlAZLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EevMGvkjwRIMUUsEUOH61JnAzoTrQAcd+JkI4+YFjxHl9d06ZisvR0RgBJqqzcfy6Pec9v8dM5m07K8YLIUTUB4v2iFfFxzdg+gH2NndRoiAolpPVQ2Fpk7DwqdRr+iUqeSzzfeA6mkQQA1vGKaI3Bt1M5Dvle/CFn1b9BplT7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SRHzbhcj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gx7X3WK6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SRHzbhcj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gx7X3WK6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A36487A0299;
	Thu, 26 Mar 2026 11:48:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 26 Mar 2026 11:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774540107; x=1774626507; bh=si0CUdixka
	pFIPcHv9ovjwn0eSvOO4zFwwIlh1NqOi8=; b=SRHzbhcjTw25rjrdWwgDL9d1gX
	ItqpzA6n9g5RvvrwnnTR2K/mK/v/n7DlgirwdZyzbQTiovz/2yFLY/IGJoOs3MY/
	+OXC2vRN9FV4Iz2Fb7gXLqergpRfboWFJt0xRz8Eo2R+ratzIuvcvsFOpaxJluED
	1ICbYdsOW7ly3hGGqwLNWDCbzG7XoCG0sME2uCEce6rgWoVszWkkMoUTe6xGQUNp
	DjClizKrpDnLhk22OEKFPSYg2/jeI1+K5/CIfTIInNhnBHL1rTJpFp7G8RhPeHyR
	QAP1Qemd78xdQ9Pt9HNMvPWiy6sh9/EpOr/Hz6V1I5QEFHpAS0QGPatEwYng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774540107; x=1774626507; bh=si0CUdixkapFIPcHv9ovjwn0eSvOO4zFwwI
	lh1NqOi8=; b=Gx7X3WK6heldR4XLRI6nFW8UY06czvCtL0f8XRD6+gnDNtx4RU8
	61BWqhjQnu4MEG/bBi7HeW0lEI2/xSyIlJtoGAZBmHfNCnGifXyFgyGoDIMcFvfu
	dw/kuBy3inYaW69OHikBacrmmz2gakW7/F/7psd8yBbzWhqkc/ld3FiGh1n5sh7x
	whPQEiAOUXd+soxhRL4ycCQbziJpg+jWn1qQ4ieU45gzBn1dKkBTWNBNCl6kPSzq
	enAnCY9yXRq3hr9SnHxkBgVz2Q/ruVtaXPTIxXx+lGrPoWX5CR6MC8foQ8wttwh+
	iYdUorXW/SVk7Dg+PkI07eHow02wWU5FbqQ==
X-ME-Sender: <xms:S1XFaYAKPkAsnlhIsFjLn8nI4qVu65RJRkRyicU-993q5uuED3Qn1A>
    <xme:S1XFaRg5CCm7ea1Qloq1PMDSeXVntCBC4euIffiXc6Uh7U9tc6HoB6FAhkG8f8dcV
    0WdOsvNm8PC_zvTqWtrO7Y-MVq2DXcU63cWFyrHGeU8eCrPzQyxEQ>
X-ME-Received: <xmr:S1XFaQnt1btCYEeWwCTrcNc215cQkSeu_AT3WMxXKzvuYP2ctPFXY8cUIDuOyVi_pYMXpongtq83CxhzmzzpCnlhLyXeBIMsSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:S1XFadoQeFhoyxlWd7_nICb0XNtNMWx_o-6OqH34XfGZ3GeRVGVe_Q>
    <xmx:S1XFaZE-fMzqcQ9pNn5UZDiVRLLnpOHYXYV_McN9NN0ER-qpJX-8HQ>
    <xmx:S1XFaZw3X2swS9uonIPpkQJU4IzyvBJiKpSgxW0QgoW9VgYFq2KrQA>
    <xmx:S1XFaeroO1daOSBf7-fYJSXy6IEfnvFd9OlXiGwxwryIa81_TxlUKQ>
    <xmx:S1XFaYFYl38WDpz_Ny9XGNSFQ2v94M58yt5n3WYgyFyapefJqIwaMFWf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 11:48:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 1/3] worktree: remove "the_repository" from
 is_current_worktree()
In-Reply-To: <5357c0dd53ee123a4ea064412c83983b0be5e400.1774534617.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 26 Mar 2026 14:16:57 +0000")
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
	<cover.1774534617.git.phillip.wood@dunelm.org.uk>
	<5357c0dd53ee123a4ea064412c83983b0be5e400.1774534617.git.phillip.wood@dunelm.org.uk>
Date: Thu, 26 Mar 2026 08:48:25 -0700
Message-ID: <xmqqy0jer3qu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... it calls get_workree_git_dir() which also depends on
> "the_repository". This means that even if "wt->path" matches
> "wt->repo->worktree" is_current_worktree(wt) will return false when
> "wt->repo" is not "the_repository". Consequently die_if_checked_out()
> will fail to skip such a worktree when checking if a branch is already
> checked out and may die errounously. Fix this by using the worktree's
> repository instance instead of "the_repository" when comparing gitdirs.

It sounds like the above is something we can write in a test to make
sure the code with this fix won't regress in the future.  Can we add
one?

> The use of "the_repository" in is_current_wortree() comes from
> replacing get_git_dir() with repo_get_git_dir() in 246deeac951
> (environment: make `get_git_dir()` accept a repository, 2024-09-12). In
> get_worktree_git_dir() it comes from replacing git_common_path() with
> repo_common_path() in 07242c2a5af (path: drop `git_common_path()`
> in favor of `repo_common_path()`, 2025-02-07). In both cases the
> replacements appear to have been mechanical.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  worktree.c | 8 ++++----
>  worktree.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/worktree.c b/worktree.c
> index e9ff6e6ef2e..344ad0c031b 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -58,7 +58,7 @@ static void add_head_info(struct worktree *wt)
>  
>  static int is_current_worktree(struct worktree *wt)
>  {
> -	char *git_dir = absolute_pathdup(repo_get_git_dir(the_repository));
> +	char *git_dir = absolute_pathdup(repo_get_git_dir(wt->repo));
>  	char *wt_git_dir = get_worktree_git_dir(wt);
>  	int is_current = !fspathcmp(git_dir, absolute_path(wt_git_dir));
>  	free(wt_git_dir);
> @@ -78,7 +78,7 @@ struct worktree *get_worktree_from_repository(struct repository *repo)
>  	wt->is_bare = !repo->worktree;
>  	if (fspathcmp(gitdir, commondir))
>  		wt->id = xstrdup(find_last_dir_sep(gitdir) + 1);
> -	wt->is_current = is_current_worktree(wt);
> +	wt->is_current = true;
>  	add_head_info(wt);
>  
>  	free(gitdir);

I think I found the semantics of get_worktree_from_repository()
unclear when we discussed a different patch series, so I may have
asked the same question already, but what exactly does it mean to
"get worktree from repository", i.e., this function does?  A
repository can have one or more worktrees attached to it (that was
the whole point of introducing the worktree mechanism), so "I have
this repository, give me the worktree for it" is not a sensible
request.  The function's comment in <worktree.h> talks only at the
implementation level "construct a worktree struct from repo->gitdir
and repo->worktree" as if it is so obvious what the resulting
worktree struct means at a higher layer's point of view, which does
not help, either.

I am asking the above because I find this unconditional assignment
of "true" utterly confusing.  Is it because "we created a brand new
worktree structure that by definition is current out of a repository
structure, so as far as the caller is concerned by definition it is
what it is currently working on"?

Stepping back a bit, how do "is_current_worktree(wt)" and
"wt->is_current" relate to each other?  Here is what happens in the
former:

        static int is_current_worktree(struct worktree *wt)
        {
                char *git_dir = absolute_pathdup(repo_get_git_dir(wt->repo));
                char *wt_git_dir = get_worktree_git_dir(wt);
                int is_current = !fspathcmp(git_dir, absolute_path(wt_git_dir));
                free(wt_git_dir);
                free(git_dir);
                return is_current;
        }

and given the definition of get_worktree_git_dir(), which gives
either the "common" .git directory for the primary worktree, or the
worktree specific .git directory for the secondaries, the is_current
being computed here sounds more like "is wt the primary worktree
among the ones that are attached to the same repository?"

But given that there are API functions with "main" in their names,
like is_main_worktree() and internal function get_main_worktree(),
what I said apparently is not the intention of whoever built the
worktree subsystem.  I am still confused... X-<.

> @@ -229,9 +229,9 @@ char *get_worktree_git_dir(const struct worktree *wt)
>  	if (!wt)
>  		return xstrdup(repo_get_git_dir(the_repository));
>  	else if (!wt->id)
> -		return xstrdup(repo_get_common_dir(the_repository));
> +		return xstrdup(repo_get_common_dir(wt->repo));
>  	else
> -		return repo_common_path(the_repository, "worktrees/%s", wt->id);
> +		return repo_common_path(wt->repo, "worktrees/%s", wt->id);
>  }
>  
>  static struct worktree *find_worktree_by_suffix(struct worktree **list,
> diff --git a/worktree.h b/worktree.h
> index e450d1a3317..94ae58db973 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -16,7 +16,7 @@ struct worktree {
>  	struct object_id head_oid;
>  	int is_detached;
>  	int is_bare;
> -	int is_current;
> +	int is_current;		/* does `path` match `repo->worktree` */

This new comment also talks only at the lowest implementation level.
What significance does it have to the upper layer that calls into
the API if `path` matches or does not match `repo->worktree` is
totally unclear, at least to me.

>  	int lock_reason_valid; /* private */
>  	int prune_reason_valid; /* private */
>  };

Thanks.
