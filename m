Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17850276
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288119; cv=none; b=S/6Jru8O0wEPoyOFNyq2kNj3eKJUQGe4nZBat5d749kTPrOp0ABHRvnIxBjfD+mwa9vPrVRoXuuN7ETBhHN4BPTvTPDo+qs8nFV23xhQk4o7ZW7CgRWz9Tkb+yI0CllmvVmn3+BqV099gFYqnWMSnP6St1GlXZ963OIyNSY2qO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288119; c=relaxed/simple;
	bh=46ATkKQ11XL7nIz5xYziGePWa/C/mgANYN/rjxwgGsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uCVpSh1N57JJftSRGuglkHLnp3g0TJzyMAGP7H033gJGjdrGhom3nWOFCd935OD+JzK7KReYiApRZPjCze5tg6hOaKFJ1Xz1YWZNR1cUk0XcBjPUlvzHr/WcMwybd6WnP+jEFLTvnBOeA13SxGpDtZj6utbPNotg/3o0sGZc4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ey9MOG94; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVyYSS+G; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ey9MOG94";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVyYSS+G"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 389D4EC00AD;
	Fri, 15 Aug 2025 16:01:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 15 Aug 2025 16:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755288116; x=1755374516; bh=lmBDLcM1j2
	tEMEX0TKsrwdV3JjoYU+SXWa2ZtjV2bow=; b=ey9MOG94c3cqLVrVKaWrM/Cd9y
	UN73EhbnU2bAeAPO6fd6fWQ6LupZJ5FxbY1I12WpaJEk6O6h2C9rhqwc0CTb/C9X
	JxCst8qk94g9IF+FHGbx38co1K5PWbg/U1vJQ8J5X2K0Z01bYW0rqjYHsHqKpwq9
	JwbpB8q3S/QaDWGU4iZ4Mlxth/F2VqyCxWHTgxR35/DoUCmTc2m13wXxpH7StsI9
	xDbgDkBDrwdiItt/IjcfhOEpeELVKw4HIUroq46oLWG+62OCbIWdCpFNVeFQzK+H
	DGhFyzQ/orCikaP2/Iluo2rTXUWzYD3jmTnXiRutUHXpLpjGAhPHIMHSnmkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755288116; x=1755374516; bh=lmBDLcM1j2tEMEX0TKsrwdV3JjoYU+SXWa2
	ZtjV2bow=; b=GVyYSS+GHn5RiJtQ0queY8e2IjtnCNyEFs87e/cpZARy5mvMe41
	2mZHvkGhyv8BoXGxtvXPR+hVHCJgi1GKwU7ZB8YNO8VCSF8N552f1bS5Dms/omuy
	FLJODiB5g/PHqPDzsjn/EMAo69fsBwf+e/WAqMIqdCjMIhdW5VzylUdzKyNZm9BI
	rl1Rk1DgfiYEHE8jzmKUdq3JcQS7DvIqGg2DJjzLyE4DOwYdJ1qNc53TpH7F4u2E
	T+ORfppPphb3wtV1tCf32e3/hjCikY7s86PtHQLLpbk9ZcR5o9Tea75/8lxI5RX9
	YDHY+IP8ucdM5/P/5oM7VfpswGriOSPA3gA==
X-ME-Sender: <xms:M5KfaMdiQyKOLY_Na_KFQVZPmon1dPfeSDM0p-Eqk_amW99lZ33y9Q>
    <xme:M5KfaLy0J67Bqn3enzZDVz2TN6rRfqLDDeZx12FC3Y1-nIFfQqfBzjFu5vCS-qXK9
    QxjNTrkoz3EdBzDDA>
X-ME-Received: <xmr:M5KfaD9KSAcpH8dIkWp3omeyNFzDliNdg43E9AjBEzVaHmCpxar5EN7djvl5XeJXvn-dOqC1284h-yVGqIB_rl6EG6HzmkdPyT04ax8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:M5KfaDgLRWjBB44gtiN8sR3-Ae6YxnrjWhJMtHE2Ejy9aRPmB5ZpnQ>
    <xmx:M5KfaKF2Z6f8DHZx7toHO3Tg_-lkxu9LHtT--OM8N-wQ86V5WChQxg>
    <xmx:M5KfaC-E6Kky4mQ49g1sp54egztM1fYZyPEJb7nZfmU3xTV9zcxX0g>
    <xmx:M5KfaBx9f2qfQaepvXP_bOqaMoIl6lOBxProD77eQrnj6dZB0zdajw>
    <xmx:NJKfaJrjDvXTSZgfOWi--QXrToqrM7SVkhXyD3sQk7DO6keHve7pvt5K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 16:01:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Julia Evans <julia@jvns.ca>,  Julia Evans <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  =?utf-8?Q?Je?=
 =?utf-8?Q?an-No=C3=ABl?=
 AVILA <jn.avila@free.fr>
Subject: Re: [PATCH v2 3/4] doc: git-add: make explanation less dry
In-Reply-To: <CALnO6CCvL_wc9tkjHCa-9wp7fJMVDt-WHvHZnuOai5HzZb_j8w@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 15 Aug 2025 14:25:50 -0400")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<ce1eafb02860b390da9359f92fcf098b7cdd3a94.1755127218.git.gitgitgadget@gmail.com>
	<xmqq349ty254.fsf@gitster.g>
	<886787d2-26b5-4451-a105-9ab522e38ad6@app.fastmail.com>
	<CALnO6CCvL_wc9tkjHCa-9wp7fJMVDt-WHvHZnuOai5HzZb_j8w@mail.gmail.com>
Date: Fri, 15 Aug 2025 13:01:53 -0700
Message-ID: <xmqqbjogpd5a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> As Junio likes to say, a mistake being old is no good reason to carry
> it forward into the future (or replicate it).

I say no such thing, though.  What I say about past mistakes is that
you shouldn't use it as an excuse to make similar ones in the
future.

I'd prefer to let a sleeping dog lie.

But in the context of this discussion, I think what we carefully and
honestly need to look at are not past mistakes.  It is importance to
adjust to the new world we live in.

In early days of Git, people from older SCM systems did not grok the
index very well, so our explanation of the concept of index and
adding content to it may have focused on teaching the difference
between our system and the back-then-major SCM systems.  Unless you
have used Bitkeeper, the "you can commit and your doing so would not
bother anybody else" plus "you can rewrite your private history
until you can pretend to be a super developer who came to the best
solution with a single attempt" freedom were something quite new,
and we needed to educate folks the way to think and work well in the
distributed world.  Earlier in one of my messages, I said "making a
commit and switching to another commit is cheap", and that comment
came out of habit, but that is only understood by folks who have
used older SCM systems we displaced.

But with so many new users who haven't even touched anything other
than Git, none of the above examples certainly may not be the best
way to teach these things to these new crop of users.

