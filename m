Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4520374160
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354082; cv=none; b=XOHrcF4OoXXH4OzHMXZLk9T/0t96ebY9kc3TUglREYS682vFY3ZdjfWaESo+ffXWl20nmPE6RFsVXIXodeJOg1r4QgkK6EHjAjuiYHwGPd3WD99e8ddTk2cFo2xaXXNF+Oyq0Plj2INvr+dJ98cR+hV1JbxFVIdx6ZvCzwvAT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354082; c=relaxed/simple;
	bh=xK/XyG8862cQB8EE/xcQ0Ho1/iBrLiYXf/hkYo54Qfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T11blaCNWHqHGYsF6k0K+tdazOPwywL3j1E9gBtPfISzjE9JgHrAB56YeK9dPds1pv24Kg4Ft4mge9N1p/FAcWPJGvCwAkqhGDgeX4V2mDN54I66+7Aak/6Qvz2yWX7IwIBcbEJxrBqpvOjVN+XxiMgJMFWUQ6BmXLMZOCp177s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t77dcome; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v/skej9K; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t77dcome";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v/skej9K"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DBECE1D000EB;
	Tue, 17 Feb 2026 13:47:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 17 Feb 2026 13:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771354079; x=1771440479; bh=6sfNtsk/47
	QXJvN48hH/g8Izhs9Of73x2m19lepHd3Y=; b=t77dcomeRDoEC692UQ4FE+52WD
	bXxueBeOkrSyJF6S0BB6hsuz9yOuIamij0rz4+rgFEeBTN//DOygnFze0ZZcsXIw
	dbNyPzZAXCaqO2Qqer4ClCgQv3TsHvxO/8rRFa/Ie0YGvFdcjifFpaK9Yluv6W7n
	nhQ3Y4p1+IZA+GTo8zci/EZJh0yiE7yH18hPv3ok5BcXpesj95+6bVhP1UmRVhLG
	rDlR5YJEFNWl+aKCupFsY5oSc+PbiTSx+XOwHym9OiD3gbJ6N7R17TL9y4cEjKYB
	BLU95D4iIqwTb7mAcqIIbTntSd7O9k4gdymOl/VBx4Y9KBiGUkLxAl8Pm18A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771354079; x=1771440479; bh=6sfNtsk/47QXJvN48hH/g8Izhs9Of73x2m1
	9lepHd3Y=; b=v/skej9KgNsRexOM9ap29ObEzWbD/+xLnsEPS/YTPGD4iKY5fPD
	QM5hld3dtzXFfosWpjxHNrvcTy0Rd3mjbprR7m789QdQMH9L2KXptIx+hhRdwQNW
	5L6djn63Aeq8rXIbXvPSWmpJdKZ/De8zCqsaUBcy/z41CF7PKKnuuNXZlDQ0MUD6
	9tP/vLunuo7zH7B9uCI9zfQcTCkyTsgp/n2/CXit6kpFPe15bXywCJCdoF9QR1o7
	Wr9MyvBlKh2+DXse7GlgdyMGKkpjgAETno+gwhcnL2rNvXpxHspJK0D4OqO7iFpt
	XjJnP1EoBvnwc+9AhJHP6BTi/EGH4goJClQ==
X-ME-Sender: <xms:37eUaQwuT6Nq22jr6LtYDw0eFeTTFnJKnecbElDCZ5R1enhKIVQygA>
    <xme:37eUaX-kln5FsHAqoJhqA-clRmIhYvR7vJCXx4K9pEpnMK9M6lk_4hqQ_xxq-I-oz
    1jBzf8bfMI8dTP9TLqxccW8ESZwmppt-ETF_5p515crcIs3XRLwUj4>
X-ME-Received: <xmr:37eUacJ-xU1aF5mDJ4A6pMCV_ykGJo94CWtGNjft31bp_b6lF2UYOZi7uxDBPDUILWAdvLOmD6yyHrPSYqf4MdZftG8IXCyCHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddthedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:37eUaVe0voc2juFDanHwu_iHoRzLnjnWP6AqZmH8Uxy5NF66GXxxBg>
    <xmx:37eUaT_C4jogtJh9YWiivVEwun4PqtlmuR0hkZTjCBbpmBCiK6a7lg>
    <xmx:37eUaaptVRDYXfarGNgxdWVhiUfM_dHLOYbbvl7jZkmS43f_AZUnNw>
    <xmx:37eUaQDkpkdsv5J-FJpC2uXg5iB680X37AZAuifTvx3wwyz1h7Ljgg>
    <xmx:37eUab-NwkKazbYj0q6TrGOggFtIq9E5BPkkeIVdz2wwdiS42ukPyUsH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 13:47:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Shreyansh Paliwal
 <shreyanshpaliwalcmsmn@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/2] wt-status: avoid passing NULL worktree
In-Reply-To: <409871a7d521b76c9eb811d3c49747e04de8defc.1771258688.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 16 Feb 2026 16:18:09 +0000")
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
	<cover.1771258688.git.phillip.wood@dunelm.org.uk>
	<409871a7d521b76c9eb811d3c49747e04de8defc.1771258688.git.phillip.wood@dunelm.org.uk>
Date: Tue, 17 Feb 2026 10:47:57 -0800
Message-ID: <xmqqa4x7cile.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> In preparation for removing the repository argument from
> worktree_git_path() add a function to construct a "struct worktree"
> from a "struct repository" and use that to avoid passing a NULL
> worktree to wt_status_check_bisect() and wt_status_check_rebase().

Hmph, I am afraid that

    "Construct a struct worktree from a struct repository"

is not quite sufficient.  A repository can have more than one
worktrees, so if you give a repository as a parameter, there needs a
way for the implementation of this helper function to identify which
one of them to construct a struct worktree for, and more importantly
for you as the caller to be able to expect which one the implementation
would pick, and what that particular worktree among many _means_ to you.

I know that the implementation uses repo->worktree but what does
that path mean in the world-view of the worktree API set?

I am guessing that it is what the worktree API calls "current", but
if so, perhaps the function should be explained with that word in
it, and the function name should also contain that word, no?

> +struct worktree *get_worktree_from_repository(struct repository *repo)
> +{
> +	struct worktree *wt = xcalloc(1, sizeof(*wt));
> +	char *gitdir = absolute_pathdup(repo->gitdir);
> +	char *commondir = absolute_pathdup(repo->commondir);
> +
> +	wt->repo = repo;
> +	if (repo->worktree)
> +		wt->path = absolute_pathdup(repo->worktree);

So, if the repository instance knows where the worktree is, we use
that to wt->path.  Otherwise wt->path is left NULL.

> +	wt->is_bare = !!repo->worktree;

I may be confused but don't we have one ! too many?  If we have a
worktree directory, "git checkout" would check the files there, and
that is not quite a "bare" repository, no?

> +	if (fspathcmp(gitdir, commondir))
> +		wt->id = xstrdup(find_last_dir_sep(commondir) + 1);

OK.  So gitdir and commondir would be the same for the primary and
for everybody else we'd have "id" as the last directory component of
the commondir.

> +	wt->is_current = is_current_worktree(wt);

Oh, so I guessed wrong and this is not about "current" worktree?
What does the directory pointed at by repo->worktree mean to the
callers of this function?  I somehow thought that is_current would
be always 1 here,.
