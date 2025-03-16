Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05CF8F5E
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742154288; cv=none; b=LDm3kMn2yc3jD6o2atLfVlBAmMyvNzAcTzlyaz6tzDodrd6ZCdV6tDqwH+iBYj/EDTgXFdA8vRV4dUFfYT1ndTAJfi9ontpeiyi7f4BhBmfbyE7LeanMJrcTISgfYGrCtL4BSzDM8DzZDvMneLeDI9epdrIeot93hV15GOz80T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742154288; c=relaxed/simple;
	bh=8idX71rmGWH1npS4esgpFJTagcZ5LX1uH5B9jNWqLEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T4YXfTkb8pt8htTP3NlO2XyxUEGjA3qY8uW9VIf56pTapQLRSM+aFONX7G1AU4nchTTVcDYY6ykRBVSHuwj5IBiKI0QT63LIzbewQOZb1QwXdLMkRAmX2uUzRjauQvY4jWkR+vX57PDlVQHjgYyuKsBxW8E10jIw4ogF1fihdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r15jtg0w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=njgmjaOi; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r15jtg0w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="njgmjaOi"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88E4C2540127;
	Sun, 16 Mar 2025 15:44:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sun, 16 Mar 2025 15:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742154284; x=1742240684; bh=IlHhh+I8Bc
	42EWI/ItyfWgCGMukAZTKx8agAdKqxIjQ=; b=r15jtg0wuoCkFCbq/XnKZt8LMN
	Ek41C688n9b3KM8iQ7I9iu2SVL0g+K+awf5/y1ALk6IYPJSvLXDqvxP/P4TNoUar
	pdY0oruH6qAdpFyTpUUFs0u1g1NlDh6S9jJGj2BGybU9maKTtuifIe++2vAivzFM
	LtcFRBXzQ0ROtvTcixEVC28K1JdU2JkP7sCKo0HmhhEahTfzEU+5aHpNYwfl/i6t
	yHDc9cOBGttAALJEGv+K/2oOQinpKEwNVSQAbnhPphtUMenxLOiAwDc2DRWNom2v
	00vJJ9hH6nGMalR1r80czQrka8nLKCHuR8RFe69lDNaqR+mDePxi60oRjoOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742154284; x=1742240684; bh=IlHhh+I8Bc42EWI/ItyfWgCGMukAZTKx8ag
	AdKqxIjQ=; b=njgmjaOieAA3Rt1eM610C8P0nrHELZUvIcxBk1xg4iDlJvXjIKW
	UiHj9XOX6WzJtpOCVdNsnxK3KQlZUKWqsN3GZH38seiADZeTrn7MwKWe4lxiTbTC
	fNpNMNRrnIa4UtHMHAbkSuClhS2XvHp8AgX+HTn+GB/Vksi1WVzEjWC8fT8iqUH2
	rTPY2IGcCppG7R4a6z9i1VQBZIUrRdj0k/OhntibyqE7HsPXmDSVY6aATdVzt2wP
	aOlHIg7AG7KQypvj0Z9GKnhD1AiYMH+fj8vU5fBsq5LRFK/Xn8ahQD1oLcXurbTt
	gYpw+LRhYVMmrEpYSB/XUQis4LdiQIYnytg==
X-ME-Sender: <xms:LCrXZ8HX9kSrV1hl30IGZPKaP2WcAUfKF3eNTaQ7y4BbYAwhvqsk5A>
    <xme:LCrXZ1Vf065Fn8baaZc-DpJYxFRSzqhWsOh4397T26V07gEvdax_TNVCowspNXch2
    FyPn0bLYrRnReYPSg>
X-ME-Received: <xmr:LCrXZ2JNYucRsq5pgfMJxrkZVBWeg0biuEdxW6ZuZ3KZWN4xLzD-6TUEdR6BrJ7egsp6Z3M8BoY-uVtuYYMDrULgnUtUa9mKpIajdFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepohhsfigrlhgurdgs
    uhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LCrXZ-FqnG1JsMzhcrNkM0yA4fjxMCg5ecRWPGdUMzgUcHS9FCeXuQ>
    <xmx:LCrXZyVsTxWotntEcnJVgb6IxbQQ9qqfWwEk1mNczTIUFuNcuNkbuw>
    <xmx:LCrXZxPm_LbfENDia46D_vBgHeD3aTSoLae0dn9EEu1nei7vayyAEw>
    <xmx:LCrXZ52ZhCY8iURrfb-PKRnyKiNR_YQfkUhIFWrcMAmPc7DEUfv2fA>
    <xmx:LCrXZwzfIl78hDDMCoS9uKqxo5rJ4sw3t46QgMZ5CUF79i4BXzsNAdaj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 15:44:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org
Subject: Re: path-restricted log vs. subtree merges
In-Reply-To: <2d53bebd-e85e-7414-c7ba-bd1f31810cea@gmx.de> (Johannes
	Schindelin's message of "Sun, 16 Mar 2025 17:32:04 +0100 (CET)")
References: <Z9WSbUQw4VBQiOqi@ugly>
	<2d53bebd-e85e-7414-c7ba-bd1f31810cea@gmx.de>
Date: Sun, 16 Mar 2025 12:44:42 -0700
Message-ID: <xmqqo6y0dal1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I had a quick look at the relevant function (`try_to_follow_renames()` in
> `tree-diff.c`), and my intuition told me that
>
> - `choice = q->queue[0];` would need to be replaced with a loop that adds
>   the `q->queue` elements to a `strset`,
>
> - `!strcmp(p->two->path, opt->pathspec.items[0].match)` would need to be
>   scrapped in favor of testing in a loop whether `p->two->path` is matched
>   by any of `opt->pathspec.items` (because there would now be more than
>   1),

These are needed regardless of "following renames of directory".
The fact that there is one single path being followed globally means
that the current "check-box item" design of --follow-renames would
not work in a mergy history, where the path that holds the contents
being followed is called differently on different branches and given
a name (either taking one of the names from these branches, or a
nname entirely different from any of the ancestors) at the merge, or
a path is renamed differently along the forked history, eventually
getting merged back.  Even in a "follow this single path" mode, you'd
need the notion of "this is the path being followed while we are on
this single strand of commits" that is kept per ancestors whenever
you hit a merge while traversing from child to its parents.

The current "following single path" would need to be done correctly,
and then "following more than one paths from anywhere in the tree"
would fall out as a natural consequence once it is done.  "following
renames of a directory" would mostly be a special case of "following
more than one paths from anywhere in the tree".

Thanks.
