Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE2199D8
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762626781; cv=none; b=YwOqtOurJ68Z6ckPyDY27xx/7ak6yjNnSv3qARb33eQ0xD4HXF+0VL22ipip5L1Br6qljhbfhNLWSv1B9EK2wJIxKwV7o+DF+G2sDhV3K4bvGDVQ3UKPHG8Y+AUltRc0v+O5ke15Ocl+bct00mJFFu8g2YrW9/LvBdCBb0e40T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762626781; c=relaxed/simple;
	bh=nXFRtd87SaspNBF2lF4a88SPO63qGGEvKZRfiJqxg+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JVuLyk3mcyRpdcBV9X1aB3HFuGC4xKdtqDKEyIPrvgYCypOZL9YFtyZ29XMz+rbcD3CpD3JmxPazhzUML4fkiiS/l0YCkwcqMUqljEIh8o7Q+MWyifoEI/ZXTh/YjkOy535x9ZYHKlszgmnB8aOnFCbO0couqlzgFCqf1iDEdOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z2pCW50I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y+hCg07Q; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z2pCW50I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y+hCg07Q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A9BE3EC0254;
	Sat,  8 Nov 2025 13:32:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 08 Nov 2025 13:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762626777; x=1762713177; bh=TFLdaU7OuX
	R3BA5TisuKgPfTCRfr9TbfDo8m7r0lGIg=; b=Z2pCW50ItAvOwLc0ysPTqU6goU
	pXoEriSPG4L/0mLhzUC0a/N5F7gbs5rxqokgLorH6CtQ5p/4Gp5c34WlinMv5MVz
	SX4357d2HdyBIbmIoSa+QA4yggPVTkC1uHkMFYtpeeU3gR2xzFRE3HI2mcMz5vfx
	pNqEZSSwibZQn3CsAAHyRSCpqHaMKa9p/apTr4as9jO+pZU1jW3n+EWyJ1pfxXXM
	kKmxFAxD7ln8pMQnnDjea8zium3kdvWM4whxgbhLgNaHoJTw8Iw2jSnSRUzWQraH
	Qy4cnhxC204J6nOH5XpaVJXHZAS8lJ/c8ZYO3OLShDqHgc3nlPKWtWkucoFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762626777; x=1762713177; bh=TFLdaU7OuXR3BA5TisuKgPfTCRfr9TbfDo8
	m7r0lGIg=; b=y+hCg07QZBG8CU2csN/Q/Vf3MlyfnnnY5mn16DzsC0TdXrO9Y2M
	Ibh9k5zGh3BB/hayCD9rxkI27gZYUzFbm/mAav0aqAp82K9rD9zrEzRF+wVlP4vy
	doht1d+GknZHoxTFV+EyqHXuu2vBT2fZ/bx3VCQ44WjotgXcd7efL8MZ3e98Siza
	1drNN8tPtug958Dic2LIpNZiWLfA80TFr7375XOU/yLBX39NSSxfz9L9g5egZof7
	4cL/Mjc4WWQvORtBEg7wpc9mQF9Dnz88LpLtaoHjIJWVuMDJcMqreY+LzR2Hmvc3
	JiZzB9NrR0vdGGh4EKXDCZ9JtUVez5O4RaA==
X-ME-Sender: <xms:2YwPaWx6QASUgXhCNWxoLD27Vjazlte86ZM0kmPOYs-N0xTsZLkDng>
    <xme:2YwPaU0ItXO9snWcEMh-0B5vdh0rQ8_s65j0v3U_5EE_gm_elBmm1ildhg1BFXRdK
    GorDO9j8lkLQRyfRjpP7RmgeLlfhcTLtS8I-j2yE6PIT1az8kGQnA>
X-ME-Received: <xmr:2YwPab-Lo90GhOuQqOKrBKa7G95j4JctixchW4Lfkc6Db3yEgarrzQIKMP2Yu-zqFkdEvX9yxg5saaD1bh4RK-k1975Sf0uGBLgB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegthhhr
    ihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:2YwPacrP0NHTUw6tiGGhLRJ2LXvsVVFP4dCY1s0AWNyWWx57gMuq1w>
    <xmx:2YwPadQkUCyw1cg3BBCGKXcxHE6wqam0HtE5XrM1pQ_lXZkPC8_BCg>
    <xmx:2YwPaXPcR7wnB-ocqS968ksn8IBLLWxmMnOkoGWozWvsGcrmvcJy9A>
    <xmx:2YwPaTgrs3e-kCYsTFNAa91wq6APjkQlaYzDwIOs8g1a2DyfgQ5NXQ>
    <xmx:2YwPaYyuni3CiBwGN-L3_E4gnq68GF7A3SEpo3tsYtWYbmstzoDMYUQW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Nov 2025 13:32:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m
 . carlson" <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] fast-import: add 'strip-if-invalid' mode to
 --signed-commits=<mode>
In-Reply-To: <20251105061918.3688870-4-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 5 Nov 2025 07:19:18 +0100")
References: <20251105061918.3688870-1-christian.couder@gmail.com>
	<20251105061918.3688870-4-christian.couder@gmail.com>
Date: Sat, 08 Nov 2025 10:32:55 -0800
Message-ID: <xmqqjz00e5ns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>  t/t9305-fast-import-signatures.sh  | 118 ++++++++++++++++++++++++++++-
>  6 files changed, 226 insertions(+), 28 deletions(-)

Unfortunately all these tests that assume that explicit-sha256
repository as a subdirectory exists would fail when the topic is
merged to 'seen' and the tree is built without the optional Rust
support.  This is because brian's f6581e23 (repository: require Rust
support for interoperability, 2025-10-27) changes a couple of tests
to require RUST prerequisite.  One of them is what creates the
explicit-sha256 repository.

I do not think this topic to preserve or strip GPG signatures
particularly cares about the dual hash interoperability, so can you
rearrange the tests in this series to avoid crashing with the other
topic?

Thanks.
