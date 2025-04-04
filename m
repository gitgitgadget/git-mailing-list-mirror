Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBE19D8BC
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759691; cv=none; b=n++mRERvlVVEGKoPiVDoW4Nlt8CIxA9a3cfezdDyCw5mMB9RsoJNKueU/0z1zzpuu4na4MrOaSq23/TIGTBdsExs7T+f6LUJuTrHzPMM5Og9/FbkK/2dbcPrUS60PqQkuTTg3UiYLbNKrH8Qz43n/+fnizCmJHzWSVqNxmUxHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759691; c=relaxed/simple;
	bh=Xepk8Z/Na4AVrXp3IWMRArIpNTiZzoOCDh7kaZnB5lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cqs6CWZiaIADcJL09KxCrp2f5UusnMLDQuJNvamMvDZWqXxR4/RlEO2Mc233XomqDd0MFiIHSjG2vMdi6XHU1+BNGI9SeLinP1Mwn5GPCSt08ODlKrktTuMxqddRo2XTNr5nRyUhk0aMkpMuaCFfAROgE6HA5MJqQCFFx3+yPyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K881meB/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KiMe7Nzw; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K881meB/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KiMe7Nzw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BFDB4254011B;
	Fri,  4 Apr 2025 05:41:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 04 Apr 2025 05:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743759687;
	 x=1743846087; bh=ydUohPUOzKmgcvuEPbaEndOurSi8BvqWkkHakefHwRA=; b=
	K881meB/KKgTAfXWC6ofx43ne2DFfZv+VvuUwet3t10++K9EtGDYcH1PAtH3U23i
	BPccb4hrC1Jsxrz/OkyXvUyCf9O9/ySTj0pTajeJIUziCGefugKdT/HFrji751G1
	SIu6fCU3qWSSOxOcf3gAhZAlB4e0Yvy90zLOrA07wtb5yLGY+jRFpJROPX4i0ELO
	xTYjGMx93eU0OkV/oJUWdvnAsV2b55CH5O/KmiiAq6hOYiWaworQ8MTsN3G5cZQW
	Dp8OXfWNNlt/iKSuxRkVdhp7uNC2iDho0SYHLTqBbDqUXhzlvDVkWcy6MfyiGIxI
	6gTvLM2HYVo/4R4hHkUt7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743759687; x=
	1743846087; bh=ydUohPUOzKmgcvuEPbaEndOurSi8BvqWkkHakefHwRA=; b=K
	iMe7NzwYcTzgAwOtdj0wgKB26kp5Jzag7H0foOhIOS2M78qC9h9kklpslSofyGEO
	Cg5dDhfTaQMJhVRq/Wrpv/Gn8G+myMlcojpu3cZ+MBW87KwDcDBnv18aAlWi6rha
	xNJ2NLT+rpBUEL3CQ8nAKfWu6W2La3tnlAn5EvzhUr1NXoZn6DMyy7gK894HykIb
	eaNgARMRqjG0vC4mP5vOJVH3djLvw02o2uPI4M5CptyxGp7bjeDK7G1jkM5bdAsY
	6LSdpYUv4uBbKGhN8EEEDiFqcLJZJCgbbcs7itXK16ca+WIEJnhGoWfzgYW7MZg5
	Np+JwMvfLOuA2YjR24kvg==
X-ME-Sender: <xms:R6nvZ_6nm2tvRYIwrapTmexOj9wz1sUw00FRKS1pU0757yHsP0gMvg>
    <xme:R6nvZ07XUhRAVQM8zL1h1fyH4yUZQRShrcXygdgFLrA5gGqvB3BaBtTZVuZX8HUjR
    TJ3wZA3F3ON3sxLVw>
X-ME-Received: <xmr:R6nvZ2cY_iu-4Fv3Jsw0abe4x4rMjMKxYt-v75reUUrfjJfrciDtyng6vhGishs8nI7UQ9bAO82rPvGT7a7XNVIdBcNrbM4TJjP8kiYoJQXhr7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleduuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehphhhi
    lhhiphhmvghtiihgvghrsegslhhuvgifihhnrdgthhdprhgtphhtthhopehrvghmohessg
    huvghniihlihdruggvvhdprhgtphhtthhopehstghothhtsehgihhtsghuthhlvghrrdgt
    ohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgohhoghhlvgdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:R6nvZwJa9BpHT5xAxDmg4GBDCPj0k10NQYX8dGSifu6XxOxpsOET8g>
    <xmx:R6nvZzLjA_UwtIPVvACXjn0dYehJMY6I2ZVIE3JTMjUUgRA4qtcaeg>
    <xmx:R6nvZ5xExR9utLLq4W8UhNIGgYwy81qGqjM-H8yY1EB8cASuna2UwA>
    <xmx:R6nvZ_LvD709XweVd3PwpVlgRIuV4QrTDzyDY7UbHe6KNzbVRtiErQ>
    <xmx:R6nvZ2ndfjy6sCXeTNTyhMHBHk7eb-fXcUR98CduTIIGv44zxfzzg2eh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 05:41:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 602944eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 09:41:24 +0000 (UTC)
Date: Fri, 4 Apr 2025 11:41:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z--pQ2ge47J_489a@pks.im>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <Z-5QR57zgSsm6jNP@pks.im>
 <CABPp-BGwXaiohvfSdr96hzKNPYXQqz+_okxLNj7P9KSjX2PW6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGwXaiohvfSdr96hzKNPYXQqz+_okxLNj7P9KSjX2PW6g@mail.gmail.com>

On Thu, Apr 03, 2025 at 08:56:01AM -0700, Elijah Newren wrote:
> On Thu, Apr 3, 2025 at 2:13 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> [...]
> > Agreed, change IDs solve a couple of issues that many users face:
> >
> >   - You can reliably track how a patch evolves over time. This helps
> >     various different tools to track identity of commits, like for
> >     example forges, but also tools like git-range-diff(1).
> >
> >   - It becomes trivial to see whether a commit has been cherry-picked
> >     into another branch. We do have git-cherry(1) to do that right now,
> >     but that command is based on heuristics and fails as soon as the
> >     patch itself needed to be adapted.
> >
> >   - Working with history rewrites becomes easier in the general case as
> >     you don't have to adapt to constantly changing commit IDs.
> 
> Could you elaborate?  I agree with the other points you raise, but I'm
> unsure how this helps with a history rewrite.  Do you mean the
> rewriting of history, or someone trying to consume the history
> rewrite?  If the former, I don't see it, and if the latter, didn't you
> already cover that in the two bullets above?  Or is there something
> else you are also getting at?

Yeah, this point wasn't quite clear. It's mostly based around my own
findings that I always end up copying a lot of object IDs around while
working on rebases. And the most annoying part to me is that those OIDs
also change on every rewrite, and as a consequence I always have to look
up the rewritten object IDs.

By using change IDs this issue would become easier as I only need to
remember one set of constant IDs that don't change on ever rewrite.

> > So what would it take to get change IDs into Git? I think the most
> > important items would be:
> >
> >   - Generating and writing change IDs in commands that support them.
> >     This includes e.g. git-commit(1), git-commit-tree(1), git-merge(1),
> >     git-merge-tree(1). This should of course be completely optional and
> >     probably be disabled by default.
> >
> >   - Making tools that rewrite commits aware of change IDs so that they
> >     know to retain change IDs. This involves e.g. git-cherry-pick(1),
> >     git-rebase(1), git-replay(1).
> 
> And also git-commit(1) [when passing --amend], and git-fast-export(1)
> and git-fast-import(1) -- though possibly with options for the last
> two to expunge them instead of preserving them, but probably
> defaulting to preserving them.
> 
> However, I think some of these might already handle this.  Commands
> which call read_commit_extra_headers() and pass those along to
> commit_tree_extended() may already preserve these.  It appears commit
> --amend and replay both do this.  sequencer has some code that looks
> relevant, but it appears to only be reading the headers from HEAD (at
> the time the nth commit is being replayed), which seems like it'd be
> looking at the wrong commit.  That might actually be a bug...

Yes, some tools already handle this correctly indeed.

> >   - Extending revisions to allow specifying commits by change ID.
> 
> Would this essentially be similar to <rev>^{/<text>} except searching
> specifically change-id headers rather than commit message?

Yeah, something like that. The exact format for such a new revision
would be up for debate, but I quite like the reverse hex format that JJ
itself uses as it is unambiguous compared to object IDs. Only problem of
course is that it's not unambiguous compared to refnames, so accepting
reverse object IDS as-is without any kind of prefix is probably a no-go.

Patrick
