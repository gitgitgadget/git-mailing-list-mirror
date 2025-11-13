Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4A29CEB
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064465; cv=none; b=kNxEeFuUxfibSTeDX5FBBtYuRpqUk9nCx+S5PAdC2NVniiojGRoIp+8GKSoFCZ7Xi5BmABYeoiH6LGZMsYa527Db2QIgSXb7lESAW8XoxARyM5+1j8vXGgF2kPNeJwLq4fFmLB3dm0rWLJLAaIpclAw5HL4cEvbEn8jFW0AcZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064465; c=relaxed/simple;
	bh=R2ZzpCiOdRv0egqScqITc7KeXgl7wvtkc6+8oAs0Xig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T1r0lJ3Dk7jh524JyTRadR212lhPcWSfhVBBYYf+Y9sWPoWE3xb6XNibcUjBxyJGzBajugUE56axQLvaxCF0oRGo7xdkj2ROsMWHaBWzoEEK0o65gptJGiAmxS7TFLiYb6AHxqIqn2GHCfipMmmiBjVulidUF25yVBSN6rp4VlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VzHak5go; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aNOMorN5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VzHak5go";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aNOMorN5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C943514000D7;
	Thu, 13 Nov 2025 15:07:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 13 Nov 2025 15:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763064462; x=1763150862; bh=QHyYM3TRAP
	7yRrdwmF9EpPRN88CP8uQrJ44pMoVC0d8=; b=VzHak5goHoXkfVoiAruK4Vy7BG
	ag0VF4aR3enHgEVkH3g5b26hIkKAER+Ih+8IxDzQj4hMrkhn8DFgP2GyBo6FoC+I
	ueg0C5/Xe7SWNmdvzYSN8zhxhB8B2s+FqAey6kNkKpjroHvhbwXix/7WBH0pw728
	apG9XH1AS6c4Ici2YYKpwrF+S/ogjjCc8UW0yepP8KHnJP31Rbl+L3l1TPyO7hbJ
	PFlOEV7VRrRVctRClkBs3SewsnkLyd73yBpywkY5adoJ+v8IJtAX0TD7XgzIxvFE
	6llWuKx7abRkjUJmRq9gAdzeWkj+t+FFmu/e7ywoVjmUM1ae74Tb/4sZbYjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763064462; x=1763150862; bh=QHyYM3TRAP7yRrdwmF9EpPRN88CP8uQrJ44
	pMoVC0d8=; b=aNOMorN5bHgwU4oj5Wkp3OO6bKHrpYmHl2I/faNL9vwnkAiN2Jb
	+PVWLRE5Hod77Nlwt153xZErVZgl+r7PhwRNRuwCudXFhN1VPGlRJrEYTXihhqk0
	2GxTaDnsB0tHPr5gMHr55Vgj61+gF1dijXcRMtQfpALjBgvqBmzIufNORF5xluEw
	AeSAP0XFByfdrdOpaULOqzBW39FKa9gVSpabReBLZ0U6+FMokXv5REhBXQZIiyLa
	wbPPQDRCmSrjl76BcSlyFCtuRVr21W/KGBpKhmspXmYdsLbABcXNDXAJLrMo3BYf
	OrcHQCQrRyOika2eGDo5srbwWDeauk4xSiQ==
X-ME-Sender: <xms:jjoWaaQG_XrwcKQXnXj88S1xcmXdsZkouO4aiKdOxG3DBYnyhNGbmQ>
    <xme:jjoWaSAwsQeZbOqUnlUUDcK_vFdJ-QTZryBy18nGTeQTMf96d48ioPJoPTcQ-T0Vj
    ADs5S1rk_CWd-_V3UzrBjKC563SoMMkc0mSLJRSy-MR5byr1EAJUQ>
X-ME-Received: <xmr:jjoWaaEZcoDwqchQp4ckyMI4Wpj614529SvUmARncj0TVfFyAU0OIST3Rb8eL8XGO0BIdFPR_R4A388PHs8KXz2umBpAU5jgdvUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jjoWacD9tgDFaDVlVKYmLNQeVz1aaDYzojCLWnSkL5iHHbgAOQ7h8Q>
    <xmx:jjoWaSVfmWrb3HAHmhHb7RhfTyUTrOwMcn5ygl-1Iikhs0sZlJCjvQ>
    <xmx:jjoWaYogMk09QqscWxbWQGxS6_iorJbhhtx5byuXQDu7MzR0leRPiA>
    <xmx:jjoWaWQypgYA-35c75AvoIyUBwaM1pBwpqF_O8QvjxLlLUk_WYAYow>
    <xmx:jjoWaU0lbcauBryP8wF1Z2MoX2qZSua3F6OV0a1qGzzeP_RNEYpz0OhH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 15:07:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
In-Reply-To: <2265ecb5-b0ba-4a28-904f-186ef5318562@app.fastmail.com> (Julia
	Evans's message of "Thu, 13 Nov 2025 14:50:13 -0500")
References: <xmqqo6pde90w.fsf@gitster.g>
	<D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com>
	<xmqqa50v4x8n.fsf@gitster.g>
	<150f3442-93a6-4469-9c25-5bca24accc80@app.fastmail.com>
	<xmqqfrakyj0w.fsf@gitster.g>
	<2474339d-67bc-4a68-9f26-fe7edd172ec4@app.fastmail.com>
	<xmqqa50rqcy1.fsf@gitster.g> <xmqqo6p6q32v.fsf@gitster.g>
	<2265ecb5-b0ba-4a28-904f-186ef5318562@app.fastmail.com>
Date: Thu, 13 Nov 2025 12:07:40 -0800
Message-ID: <xmqqv7jdlmr7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> From my point of view as a Git user one of Git's biggest strengths is its
> flexibility; because branches _can_ be moved to point at a different
> commit at any time in various ways (via `git reset --hard`, `git rebase`, or
> `git commit --amend`), there's a lot of flexibility in how someone can
> choose to use Git, including never using branches at all. 
> (the flexibility is also one of the things that makes Git hard of course :) )
>
> So I'd prefer to keep editorializing about what a branch "means"
> to a minimum.

OK.

If you go to such an extreme and make readers oblivious to what a
branch means, some of the sanity measures we have (e.g., a branch
ref will never point at anything but a commit object, not even a
commit-ish tag is allowed) would become "unnecessary nuisance" to
them.  In other words, as I hinted, it takes a delicate balancing
act.
