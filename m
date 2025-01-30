Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C598C2FB
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738222375; cv=none; b=lqpyC5xZPQ2ahgSp+6BA8PF/BDvM8M0miGUu8o5ZstU6cVGrZm1DSHokl6Kl7HhelnHPUL4LhgOhiM1C+uIzOfBy9Pbtt1XFPXuuEXfxY4Qjz5tebCLQ7wVGC36o6xg9MnSpzB3JpokvE4kQWx/d83XORMiL1bpGUHlJA1xcB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738222375; c=relaxed/simple;
	bh=HMELqwbRkU3ok1pxDVfhosop1q6BicTgyFK4ravKWTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANKD91h3q/tMqygaMVo4AVBEnMCoOxvTXTCMfCOWnd68ozRzeJwI8bfj3FBFD8LX8H3N1EfvniXJvXlDQoXk2D26JRUfyv82RlX9qODjBv9isMilSVN6XVlOOApQZTAI8FydyglfqrDkdJ52nsvbMD01+CCAp7czgTOSChPxbZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hD3RVfrR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vZtPoz0k; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hD3RVfrR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vZtPoz0k"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D0D51140140;
	Thu, 30 Jan 2025 02:32:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jan 2025 02:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738222372; x=1738308772; bh=RIvMw5pQqr
	x/IYSp2aWyjODoRQtKTZWiwmopinU2dBk=; b=hD3RVfrRf5X3x0Qu9QXucXqTX8
	W9CmK9SyHTziCGWj1CrWyM4mEY6738fK0fbM6OGkE/pag4rfafVZ/I99+iOz4FVi
	zTl2w+/Ou6gmD0Gb9JdOE6dlmejyB2ahXTuD4cK5MbZu0eXU5XY9p7g5/iV8MVia
	HOPK06QhYwWnfmY5vrT22Oy6Tdt65dQnqCAPixwxJxFO/jfjCDmSWytKR3jSSYR+
	z3A5luZj9K/T6Vf8awtmTer8qZJuKloP4jFsv4sul1d/rE1KWzehFmFvq0NIoNHX
	Uqkll295QCW11Tendvb3vRThzh+Uogy+InZi//IpEA37Yt3G/1BOkrjZz/0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738222372; x=1738308772; bh=RIvMw5pQqrx/IYSp2aWyjODoRQtKTZWiwmo
	pinU2dBk=; b=vZtPoz0kze8uN8UJppKgVzSSB9YGgV2tY0CAvSujtISBuSIpw5w
	iLscCzg+HMHWKeldI9Tp5dZF4hSVIA1zPqtu0908Iv50ySURUYx0DImtxmP3k3VV
	KVklv9PUyGfF1/DfJQBPxfn7QXnG6QioXIUhcjnWwZWMJPQiFws+Kq7dUwlWmDsp
	Khs9zpuL+buv1OeHcxYRiniDt4/n0y+5vvaDHmDBtiNxgBQtlsTuuttb08U6IjJ3
	swwrEYBU0MXi8txXk8WBAAYEiiYXf/3GOyqCiBI4xauuVM1ycFHn8VHs5LUpkDSy
	YZONXa/afhA/RpWGUuj97EYNK/w41mrDuxw==
X-ME-Sender: <xms:JCubZ80D_jOtpCBUJsfwModLunJqdo1SOEedUzS_37sPYlSpcMVrMg>
    <xme:JCubZ3Hog-kUc_t-Hb4hXkiQH8v0ZXFbXPJWjX5Fb4QqWm1Z2WbMXNav3qUSa6qg4
    2q8SElSsFtvrU5y4w>
X-ME-Received: <xmr:JCubZ07Wiy0_9kBzTefwnB9Zt1Z_x8zMhnmzzPoGPBfG-rb-rDB-aGVcqyNY_Io6TdqDuG2w-anThbxbpSVMkUhi8aYeWrbfnBouY3ogebpG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuuf
    htvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephfej
    hffgieetgeduffehteevgeduueegjefgfeegkeejjeevueeifeejffefudfhnecuffhomh
    grihhnpehgihhthhhusgdrtghomhdpghhithhhuhgsrdhiohdpshhotgdqvddtvdehqdhm
    ihgtrhhophhrohhjvggtthhsrdhmugenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:JCubZ12_338yutgxKQZ0p2J_ghZS7tuzBYJ0sBKrK2-fr7xD65-Sow>
    <xmx:JCubZ_HMMcR7Yroa_XjJG-fjBu0Z-yolFCgp40oT0pCiSgQICHsz3w>
    <xmx:JCubZ-9kZ7TJxqBJmv3FPVcWs_4A2CIs8PiI9jRlQwZ5GlAKduaGvQ>
    <xmx:JCubZ0lFpnWObTW_mp4Ba9cVlYOJbb9TZ5sJpbRxHs24HDa3F0ESqA>
    <xmx:JCubZzjU9R7l9H95S_l_1V-4gq_D1rjSvz5XVGLG91GF8dl6MFUPUAhZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 02:32:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e618d4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 07:32:49 +0000 (UTC)
Date: Thu, 30 Jan 2025 08:32:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
Message-ID: <Z5srHBSPKQlsuH53@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
 <Z44u7od-mDiKcKVZ@pks.im>
 <xmqqr04vzyz9.fsf@gitster.g>
 <b784f612-4b6b-414a-9742-86611c50c55f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b784f612-4b6b-414a-9742-86611c50c55f@gmail.com>

On Thu, Jan 30, 2025 at 11:14:06AM +0530, Kaartic Sivaraam wrote:
> Hi Patrick and Junio,
> 
> On 22/01/25 02:05, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > I was wondering whether it might make sense to also move the list of
> > > microprojects into the Git project itself, e.g. as something like
> > > "Documentation/Projects.txt". This would make it easier for us to update
> > > the list of long-running projects whenever a new project is added and
> > > makes it easier for people to discover it.
> > > 
> > > It would also help to document consensus in the Git project. The file
> > > would likely not always be 100% accurate, but it'd probably be more so
> > > compared to tracking it out of our tree.
> > 
> > I am OK with the general idea, with one condition.  Each item in the
> > list should have clear expiration date that makes it automatically
> > eligible to be dropped from there.  Another uncurated list of random
> > things is not what I want to add to and carry in my tree (the other
> > uncurated list of random things being the set of topic branches that
> > go stale without hitting 'next').
> > 
> 
> Understood. We could certainly curate it from time to time. I wonder how
> we could set the timeline for a microproject idea, though. Would it make
> sense to fix a rough timeline such as 1 year or so and remove any idea
> whose age is more than the same?

That'd be fine with me. Ideas don't necessarily have to get removed
immediately, but may get "refreshed" in case they are still accurate.
So personally I'd frame it less like an expiration date and more like
the following:

    Every topic added to the list will need to be checked regularly for
    whether it is still accurate so that we can avoid an ever-growing
    list of stale topics. As such, every topic needs to be accompanied
    by a "best-before" date that indicates when the next check for this
    topic is due.

    It is the responsibility of the owner of the topic to determine
    whether it is still accurate. This check should happen close to the
    noted best-before date and come in the form of a patch that either
    bumps the date in case it _is_ accurate, or alternatively removes
    the topic from the list in case it is _not_ accurate anymore.

    In case the topic owner does not send such a patch, contributors
    other than the owner are encouraged to send a patch that removes the
    topic, putting the owner into Cc.

Well... maybe it _is_ an expiration date. I dunno, I don't mind which
exact term we use for it.

In any case, my proposal would be to add this paragraph or a variant
thereof to a preamble explaining the purpose of the document as well as
how to use it. This is somewhat similar to how our "BreakingChanges.txt"
lays out expectations, which I think should be an inspiration for the
new document, as well.

> Also, the current list of ideas could roughly be seen here:
> 
> 
> https://github.com/git/git.github.io/blob/2025-microprojects/SoC-2025-Microprojects.md#ideas-for-microprojects
> 
> The topics are:
> 
>   - Fix Sign Comparison Warnings in Git's Codebase
> 
>   - Modernize Test Path Checking in Git's Test Suite
> 
>   - Add more builtin patterns for userdiff

This one doesn't feel like a sensible addition to me as it is
open-ended.

>   - Replace a run_command*() call by direct calls to C functions

This one, too.

>   - Avoid suppressing git's exit code in test scripts
> 
>   - Use unsigned integral type for collection of bits.
> 
>   - Modernize a test script
> 
> Do share your thoughts on which of these you find being relevant
> currently. That would help in preparing the first version of the in-tree
> project ideas list.

All the other topics are ongoing topics indeed and would be a good fit
from my perspective.

Note that Chris is also preparing such a doc right now, so you might
want to coordinate with him.

Patrick
