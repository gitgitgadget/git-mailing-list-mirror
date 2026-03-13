Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1F6279DAD
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433849; cv=none; b=QE1mc5PCPgiYdrYLSScobYe3oP9zEWMFXAJsoFcCRNvFBDek1JMdApYchkIDNA1Dau/r7D66DpkLWGOX21TAMHRtAa2cPQ75y+NWKH2xiIEwIYJ+k6Qsk2Vdcua5bAXWor/TAZvfGZjKiArOdSsSH7GbMeIwc6yHBb8eUD5ay8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433849; c=relaxed/simple;
	bh=6NkxE3PQkE9J1foo1oWN3wxX4BD6uHVJHU2qKyGHhLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pxxJRyWuJtWWKMfydzaHVsbd72rFnmCkOTr1g/g7bXdEb9z6mc14dTw1W0fsuLK4/g+jnTNPsU1BP+3AVKFGO1RnkD2POq9W4S63hx90HHRTwamG/jrF59dxC9uOGSEOXCZS5xhmGnihFz9RcpxCjDON2Aa//6D7I/FBs3DL/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OKrcyhtZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zuAxVkja; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OKrcyhtZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zuAxVkja"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D29C1D001CC;
	Fri, 13 Mar 2026 16:30:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 13 Mar 2026 16:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773433846; x=1773520246; bh=3jUBM00fOZ
	KfwQRIjw8iRsCGORxhEIjAiqxpNB+YEWM=; b=OKrcyhtZbqpDsU7/yfCauGitWL
	BakOQDAmDSAkXkA5FdesGRa18lqR7O/IzO76pQbBkA0uXpjUbn2FcMkBSc2POm7v
	7cFbqkhWhRp2XvjGd7iZzBD+m8gnmRb3sk43pEWT8CBBQUhd63cbnNd8VcvnNce3
	KMEjAtPsDIngeQA48kYrLk4uDXGcZQXoVejmhVxKt+prggxN5qsSB+pYC1KCYYqL
	WCxuiiJToddO3u5e4y+8pIUEjzZ00cmzEaTvOmfzsS+I+rf+xaFlYoGV4aW9d9IW
	9AZh4Aqfj0/cxXI8tFcoAGvd6NuHTOBNQKR0a7cZnLo7Sa8OvJ2YTnB7U/jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773433846; x=1773520246; bh=3jUBM00fOZKfwQRIjw8iRsCGORxhEIjAiqx
	pNB+YEWM=; b=zuAxVkjaI3GYEii7oB6U9eecdRQVks64ZqRTnDv2SBwnelZl/Bb
	Q1SMV4s7dQZ7CVffIEruY8AlkgsK3yJFdTARailPl7wVZdpB21CQcbRW667qJUtO
	iG7QnIkhsY1s7B5Pvvnq2KvOVGBdU9YbDQdh7dEVBwoVRP79x5Za7239cKwJIPjf
	Mx1f2TOs0y+WemYQ0R5Xyd72XHvSG4S8d5gfAxYRAXd+rV47fqHIHaZxO1MrYcre
	PHg55Q3rY4KcOJWx8L0IXczGpFykQhKN28EhxJ+MuZujRsrnlgVXe8MHhRO/cQ91
	tE6hNhs0iX/MjrsUdy/vgKfu/irTEbz+G2Q==
X-ME-Sender: <xms:9nO0aUnF1asr_q_Efnesx-d-rt2JF6_Sn3DS0OiFAk2ie_zfsdqm2A>
    <xme:9nO0aa1Wv8n5j_bEXnxFQR8rdv-iQyvtLs6byYKxhrUYaKZw8yOI0lDuPrWC07G4V
    M-zuC9YAx5-TTRUoJalZavMfR_aHLg8YOcL6ZuA3_QPPFXPKt7V8A>
X-ME-Received: <xmr:9nO0aXpjvSkcnZoryrajFsIUtifRoHg6CeKZyZzDNBm9i6Z39S2hQYQWNXMxCsUvFhS3NQ-K8QxJSUNY8dkd8u70YCiMIvGHhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9nO0afcEm0a0tGN-FEk2RGDECllIZpkf-qw_SJ45krgavtnFu8YmQA>
    <xmx:9nO0aeo8bMnMPujq2Z-AnATWpv2Tf6vad-US1qWz-uWzs9PsJLoAtg>
    <xmx:9nO0aYF5HmSmEIXP1s9o6Lw69jTXUol8d3NN6pIlN6kOYegHAuSoKQ>
    <xmx:9nO0aWu1-mpYpJGHQy1Jn-RyzH69hyZafs6tj2f_4NqdzyXfl4oE7w>
    <xmx:9nO0aTLm9814bQzFhgLenJEk11m7Yg2cGCswhCPEsJma3q8X6QkjCMlW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 16:30:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <20260313193320.42832-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Fri, 13 Mar 2026 20:33:20 +0100")
References: <xmqqv7ez6455.fsf@gitster.g>
	<20260313193320.42832-1-haraldnordgren@gmail.com>
Date: Fri, 13 Mar 2026 13:30:44 -0700
Message-ID: <xmqq4imj4gln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Almost all of the above is now stale, as we no longer call this the
>> "autostash" feature.  It turned into a project to vastly improve the
>> "checkout --merge" option, so the proposed log message needs to be
>> revamped to match.
>
> My feeling is that this feature will drift far away from what I initially
> needed. I have never used 'checkout -m' but stash->checkout-unstash is a
> pattern I use a lot.

Perhaps.  But things like "checkout --autostash", which can entirely
be done by the end user via a wrapper script or an alias, is not
interesting enough from my point of view.
