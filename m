Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66A288B8
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783963; cv=none; b=K2O18u/+j1RybzJTV20iHMx699jdxGObiJrpcVz/gb7/HEQB64DVP+VSQsbmhNDFRfx0DoRgrFKuEZ5tqnLXobGGNJzLz7a7PICdn/RDGTuR8whdYpIVA1578jY3urU1a8/hV925ZOrGwyHDjtSb6TPVmT5yuN3pIFfycyY+di0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783963; c=relaxed/simple;
	bh=nNaNm8ZYQdCKcSekq8G5eijpR3UDNwN0bzbREnabJtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIfBDEyNhm74pHbAR8ljuVTuKc7hL/sRs03vllQHsjVfFHien3nBXKDLtQCnZW4BUMdtPsRivrBITd7wdEM56w7j1mA5MRhFUMTjsE1sJIaiGUNTUPGGV3i77P19K5p6GwITtxItXG6+uH2ot9hjipF/kREnatkurqNvSF8DZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G4nNeTqv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R8Kw/MS1; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G4nNeTqv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8Kw/MS1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CA1B27A01C0;
	Tue, 17 Mar 2026 17:46:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 17:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773783960; x=1773870360; bh=aujYTUJ/DU
	4vRoTAojCohX1XqxfQy9978XQmkHMwlNo=; b=G4nNeTqvg0uBsTeTgZ1+7TadPL
	giNLNYqY1sm5ik9EtcKi5/bXpAEOvhJyjPVqTSuQQDqm3aq4mEU6GeUYqK7eeBDx
	69BAObNeH+FoZ1oUydEjBIIlLMerGrJbh6akdzD02xnQVgZ6enf0xFSlv3qYtjEP
	TEXi7Uvni/aHDhlIzaLGwwAbTjO06QzC6odOHpT1OwqkRDaV9XSaBayleABr9B1c
	i3rLOrnIs950/0PaM1B35wK9J2OjVgFhAi1arQ4XgQzkVaVjgd1wAj4XX/qz3/z4
	HdJoGZ21b8uH+8qrywBWhVNRNm2T+rcw1Fk+m8lfeQGfQe3O+JVvyEgaxx+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773783960; x=1773870360; bh=aujYTUJ/DU4vRoTAojCohX1XqxfQy9978XQ
	mkHMwlNo=; b=R8Kw/MS1nCd9nzGyE1asU0GvqonBj1lDg+fIVdeUuIwYD3GGkfr
	Fb7vMyn6OJsSE+wVWye0yUlGL9la1Wut+8qqIOoH6JruUGJEAcP0itN4LZhiEpeP
	LrQFrpjcg1zAuzjSK7N2JFF9/8j/FYf9D47JMOOm7xVtCsC2D95YZqG7bfcQNT4M
	GLbSJbNmBoeFgcmzWqkSprALgCwUzcnsCKKYoy39AC1KmN+JWMbt9fP1Wvh5S3JI
	G1rT1AA3+kH5qkCcY1OrBU6Xr/vJOKS8RGqx4lkNeEzeVbaPPgMy0R+yZfoPAsp9
	6PqttNi/y2Sm14s52ms13RpXExmBG+kVqXw==
X-ME-Sender: <xms:mMu5aXn0Qf7L1hYT8q6bbQOtJsrC8jz2QlqwtfWtg_Lellmu1w9ilQ>
    <xme:mMu5aR2OdDQgq3nRLhGcCN90b0wr6G8L5ViyyXUrrthcUdbtctXayWBXy2tC2vMan
    vLcGXpFjA1yKl0X-rpzu7DmvqwF1bFhJxEvqtMahHKVntgD3_e1pw>
X-ME-Received: <xmr:mMu5aSqe9KNwU3wCcGGBRsAFzlXpzV2q5yXP3fGvSEoZBYD5gQr7h65YfYLv50gPtS2-c14A49yjfvYr1uDd8Y_N0fyv0_VU1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:mMu5aechGakVPtPgbaBp4qsXIAxINstxyckrFy0oKZV4hub2fSLjvA>
    <xmx:mMu5aRovXtSKd1o75vUa_OT5hFtpsKfzbM7S1W4P3KZZCq3rGNfazg>
    <xmx:mMu5afG3-VAAbHnoChLmBUAWDM2O7Dz2vVCi8jt_P5C9ltVATnJQyQ>
    <xmx:mMu5aRvrrO3Y8Gu-xv4Wa8l3uUttxaClSirMTzTw3IfePX7Y72HtqQ>
    <xmx:mMu5aeJc0TYhtFjd73AfNHZ7X6mYNNEP2d5VQ315mOn-OFmuwESadiWm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 17:46:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/5] backfill: accept revision arguments
In-Reply-To: <pull.2070.git.1773707361.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Tue, 17 Mar 2026 00:29:16 +0000")
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 14:45:58 -0700
Message-ID: <xmqq7brajfjd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The git backfill command assists in downloading missing blobs for blobless
> partial clones. However, its current version lacks some valuable
> functionality. It currently:
>
>  1. Only walks commits reachable from HEAD.
>  2. It walks all reachable commits to the full history.
>  3. It can focus on the current sparse-checkout definition, but otherwise it
>     doesn't focus on a given pathspec.
>
> All of these are being updated by this patch series, which allows rev-list
> options to impact the path-walk. These include:
>
>  1. Specifying a given refspec, including --all.

Makes sense.  You can only be on a single branch at a time, but may
want to work on multiple topics in reasonably quick succession in a
single repository.  Being able to prepare enough material to go back
to when working on whichever topic in a single backfill invocation
would be a welcome addition.

>  2. Modifying the commit walk, including --first-parent, commit ranges, or
>     recency using --since.
>  3. Modifying the set of paths to download using pathspecs.

Both are good mechanisms to express which subset of history you will
be working on.

> One particularly valuable situation here is that now a user can run git
> backfill -- <path> to download all versions of a specific file or a specific
> directory, accelerating history queries within that path without downloading
> more than necessary. This can accelerate git blame or git log -L for these
> paths, where normally those commands download missing blobs one-by-one
> during its diff algorithms.

Yup.  Even if your project is a huge monorepo that contains all, you
do not necessarily have to look at everything the organization has
all the time.  "git blame -C -C -C" would of course not work in such
an environment (would it end up on-demand lazy fetch these blobs, or
are there ways to say "I know the object store of my repository is
only sparsely populated, and I do not want you to on-demand download
the missing blobs---do your best to work with only what is already
available?), but that's a tradeoff a monorepo makes.

