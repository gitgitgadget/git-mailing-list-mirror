Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB416419
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960738; cv=none; b=D77n1wKkWAuy5LqFchE+liA79vCG4kmvROryZaSZ4iKFc5YMNcuP30fJCw9HNVVW7TkrwPQVicYxiiT3RzLt7cEzL4H8D+ZyPCY40qCefInfuIb3TpjWsrLINwqfJKiVq5tfLln83/7+eDowXihCbTTHJGdfpWZBkIhzSJWEHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960738; c=relaxed/simple;
	bh=eF/3NTP3QpyNTGoiN7ckR+jfk9ThPUX5XHXBQcevpvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G9zUx1J4z2UF1nZok58PedE1Iq7dXMxii7yOnDytc4zy7r2JHDn7YDId7DMDQyN6LdjBKzZ96vmqCkoq3yzLa7RRzSBS0RI440TVoCyDqcgtA187vrhAQpbbco7+cjAE8yQsWcIhXkH2l7/A9FKJkh5qhDu2Z6fgrDPmQiX6Fhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DSfJKFiz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l8fOl0sn; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DSfJKFiz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l8fOl0sn"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE84B254016D;
	Thu,  7 Nov 2024 01:25:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 07 Nov 2024 01:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730960734; x=1731047134; bh=ty1TCODvbJ
	tTZFQWax1mjkjLgutzd/uL6eWsusU2i5g=; b=DSfJKFizJ67K7goSv2nT5vuivK
	z/ImBqQ2J5MAgDbRhLkMwfUTnTG97PjI3v/a0PzDA0TIG4Hj7kR/2SwVcdRXkkVl
	huTdcMkxnvFkyhCfmoTe/S6PTBnGIA4ay25C5kQorHmdgxHzfceNoYMZ3tAIEdcl
	S4UhQ0/+uMmgnjRQ+AbOD0CcARpqsHJ9xfsblVms8SxWFGe4h9ZjhipaPfJ6qs32
	f5jhtQR3zPp373wiIQDDPnPQRD5ywSp8eWXVU2cb2gamn2LGl5gQlbrsJR7Q4gzb
	Nt5BXUBAGH+cpWOQhNnVeqgiBws1QJOU6PQLOP9FOyywpvmL7PJiftldZcJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730960734; x=1731047134; bh=ty1TCODvbJtTZFQWax1mjkjLgutzd/uL6eW
	susU2i5g=; b=l8fOl0sn0Z0WDGhhcxincSKI43yeTGp6mOIeENnTnivrZt+6LYn
	BlFbSIsBMFBATJCET5A6hMv1/J06OniaNq4UN/Nllj+LhOYHO5KOMiMBBYCOFWJW
	U//DanlIHFq1UQW7udik7k6ruswcSQjsSXuA/biDr3Z5/lMTLpkB+3063Uetveai
	fhIsM8nGMrVNVnBW/xnfqbtk33HE/zl4ICZPAVtWsLwNlwyyUwK4KBTeJxy4YVu3
	ua+tzxAHSSkgBTXWS/LA9ZOIkUpsbgAAwBatmhglA9dBTjoyYCISSm5zzOMAnDyY
	kV8Ig5q3FQIkoA7Guxhf0inaX+nMD5Geakw==
X-ME-Sender: <xms:Xl0sZ0SeFoWrPStGCq7OCdmjsxtU4ILSWYYvKOPxyZnOZ_8g_F8-tg>
    <xme:Xl0sZxyXeCN0qStLfP1Qn-duuHgC-YExTUzQsS3tfwLKRV8SZEiE9gQ5Jv5vGtTDu
    knbEKblxpyLklxbgg>
X-ME-Received: <xmr:Xl0sZx3XS_96BUTnZWdfQnpNXyMqAv4x-tXmbFnQiruNHLW6A8vsXlmwfO9qc9__qcem7PLp_sVIm1BKO-xPbWpMfOLIDpsYmmKW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtph
    htthhopehjtggrihesghhithhlrggsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:Xl0sZ4ARLpCEFYub1tT2bQbhZDpCAzUZayb5oRzN3VngwdyZ7Rp8qA>
    <xmx:Xl0sZ9g3miXRsfrO5j87z5jsiw9Z8dyl3fftMrPKtrta3f0f1JplxQ>
    <xmx:Xl0sZ0pz3NzLIfHsYGZfuRE5pHXu-tpzAu_ls-xP6oAE9-o8Ne1RYA>
    <xmx:Xl0sZwgkRwA_58HGuc9z8ldNq3qgbw0Eatt5PQZqELlDHYxfQ22HZw>
    <xmx:Xl0sZ7bKoNQyWRqlRymkWWqwlPHJPHktR5oX7b4FfPuviE0W2W1HLJD3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 01:25:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  John Cai
 <jcai@gitlab.com>
Subject: Re: [PATCH 2/3] setup: initialize is_bare_cfg
In-Reply-To: <19c97feb06ef2f01f89b462678fe304b58fcba37.1730926082.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Wed, 06 Nov 2024 20:48:01
	+0000")
References: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
	<19c97feb06ef2f01f89b462678fe304b58fcba37.1730926082.git.gitgitgadget@gmail.com>
Date: Thu, 07 Nov 2024 15:25:33 +0900
Message-ID: <xmqq8qtvsgpu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <jcai@gitlab.com>
>
> A subsequent commit will BUG() when the is_bare_cfg member is
> uninitialized. Since there are still some codepaths that initializing the
> is_bare_cfg variable, initialize them.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  setup.c | 7 +++++++
>  1 file changed, 7 insertions(+)

I am not sure about the wisdom of this step (and the next one).
Before this step, it used to be that the global variable (or
the_repository->is_bare_cfg) can be inspected to see if there is an
explicit "set to be treated as", or nobody told us if the repository
ought to be bare (or not).  With this and the next step, that is no
longer possible, yet we still do the "core.bare says it is either
true or unconfigured, so we ask repo_get_work_tree() and it returns
NULL, so it is bare", which feels awfully inconsistent.  Especially
the change from the next patch

> diff --git a/repository.c b/repository.c
> index 96608058b61..cd1d59ea1b9 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -464,5 +464,7 @@ int repo_hold_locked_index(struct repository *repo,
>  int repo_is_bare(struct repository *repo)
>  {
>  	/* if core.bare is not 'false', let's see if there is a work tree */
> +	if (repo->is_bare_cfg < 0 )
> +		BUG("is_bare_cfg unspecified");
>  	return repo->is_bare_cfg && !repo_get_work_tree(repo);
>  }

the returned value does not make much sense anymore.  One half of it
used to be "if not configured, we can ask if there is worktree and
the lack of one by definition means we are bare", which made perfect
sense, but now what remains is "the configuration says it is, but
when we ask if there is a worktree, there is, so it is not bare
after all", which is somewhat dubious.

And if the goal of steps 2 & 3 is to redefine what is_bare_cfg means
and make it "this is the only thing we need to check if the
repository is bare" (which by itself is not a bad thing), shouldn't
the checking of worktree be done where the code assigns true to the
repo->is_bare_cfg, no?

> diff --git a/setup.c b/setup.c
> index 6bc4aef3a8b..5680976c598 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -741,6 +741,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
>  
>  	if (verify_repository_format(candidate, &err) < 0) {
>  		if (nongit_ok) {
> +			the_repository->is_bare_cfg = 1;

It is unclear how we can be certain that we are looking at a bare
repository in this case.  We do not even understand the repository
format, GIT_DIR we were given to decide which file called "config"
may not even be a repository.  We are losing a bit of information
(i.e. nobody has told us if we ought to treat the repository as a
bare one, or a non-bare one") by overriding the value here.

> @@ -1017,6 +1018,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
>  		if (nongit_ok) {
>  			*nongit_ok = 1;
>  			free(gitfile);
> +			the_repository->is_bare_cfg = 0;
>  			return NULL;

Ditto.

> @@ -1069,6 +1071,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
>  
>  	/* set_git_work_tree() must have been called by now */
>  	worktree = repo_get_work_tree(the_repository);
> +	the_repository->is_bare_cfg = 0;

What if worktree is NULL?  Wouldn't it be more meaningful to say
is_bare_cfg is true in such a case?

> @@ -1125,6 +1128,9 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>  
>  	/* #0, #1, #5, #8, #9, #12, #13 */
>  	set_git_work_tree(".");
> +
> +	if (the_repository->is_bare_cfg < 0)
> +		the_repository->is_bare_cfg = 0;

OK.  We did discovery, is_bare_cfg did not say true (it would have
returned before we got here if is_bare_cfg were set to true).  We
decided to treat the current directory as the top of the working tree,
so by definition, we are not treating the repository as bare.

But this makes me wonder what should happen
the_repository->is_bare_cfg is already set to true.  Shouldn't that
be a BUG()?

> @@ -1767,6 +1773,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  			die(_("not a git repository (or any of the parent directories): %s"),
>  			    DEFAULT_GIT_DIR_ENVIRONMENT);
>  		*nongit_ok = 1;
> +		the_repository->is_bare_cfg = 1;

This is not bare nor non-bare---simply we did not find any usable
git repository, and we lose the single bit of information "nobody
told us to treat the repository as bare or non-bare".

Not that the loss of information is a huge deal.  But having to make
an arbitrary choice like the above (and similar ones in previous
hunks where we didn't have any repository to begin with) is an
indication that the entire "is_bare_cfg must mean if our repository
is bare or non-bare" premise patch 3/3 wants to enforce may be
misguided, I am afraid.

>  		break;
>  	case GIT_DIR_HIT_MOUNT_POINT:
>  		if (!nongit_ok)
