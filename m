Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B630123ABA1
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907675; cv=none; b=RzptnOPzf6wuPiUwfoOq88JsuorzFpVXF+nRQQ9KgkrabaH5H49GHnUvdWs6HVDBB4N4g0wiCvHr5E3oarD3ioeM3ZlxitvZcZ/eHXpYGBYTBIHrPcEMZb1Ey2+Y4glVvF3KWDoglTw1TIz5y2Ta/8CGk8rV1k4CWdtctBK8I2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907675; c=relaxed/simple;
	bh=vFdUQ8YmQgQlHl3i6PM0QanhDG8bxbFUfZ+OY3ZuzJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asqbWZphoU6n/SwCHiwhtFXoHbvWmv2vJf66K0b8zgB4jxfPBSjbss01LCiqofGDlDligAGVUIjaClCjzl3QNlg9MFbELJfk+DAgOKgQR7OBknd73Zojsqe/6cAvzxOpXbV4Egt3HkBJIC+Q7G5k+xrTfBH8YPZBZEF+2au9tRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DpzxLTDe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YX4myiKw; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DpzxLTDe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YX4myiKw"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C41C37A0762;
	Wed,  8 Oct 2025 03:14:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 08 Oct 2025 03:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759907672; x=1759994072; bh=4Y94BOcxug
	c8Bd6vjpjcU1m674yDf+c2NSOcR/uypvA=; b=DpzxLTDeCWiwJOot7nR+s7h8dg
	j8x+Sbouy4n0jTgtb+gmN5aPwy7Mpy2FMcXICNjC3CuP/3K/quOfMT5cD1xqz4+4
	w874qLJhPNO0GcchrnFwe4IJLQogVUdb1ZCYNATwmG1nFFWdyZxxxFAFd/k4QCxO
	HjainrXmKKm3H3JxfrXUkZquXYPUKfxN55nJGV3hNR9MsujUeteTa9gIuEtAF2Pz
	laUhTtYbPMNiH2Wr1LKM3foY2FsOmUGLUfNpECV3SI1t8G3jF0tMWLrVqM6HI0v1
	nXqlmc8h+j7alUCztkwzE6tp+3g8bFo1QrNrQX4Tx4BOiu40SeTo8WuIucbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759907672; x=1759994072; bh=4Y94BOcxugc8Bd6vjpjcU1m674yDf+c2NSO
	cR/uypvA=; b=YX4myiKwzK3narLv3Gmi7tO/ET3zXQ7LjG/p+TpIPTaSAWLGGJQ
	plFZsGczvhO3Cefs9egiABgHWc5MDiIlU0PrEUfvxsRN7iZfof3p7aXmaQTDxC+i
	CDlfR5+AZvRUE7NsrZnmmNHFHaS2c0u8GPGaigGFHs8L9BdZZtfbcyqYHL6QYAvJ
	yeuduT2JgtDGAYxxlxJ9Kdn/Y6UWootcytHYD9K6EV4Lz1R6Wi8Akg2t2+ti5Yaj
	oXW8rjvHPH0gD0Kx+zmgr3RmzDa2uYaLQyVUKHPHyFzqR+xXnfjb2XKcixTDzWoA
	1/f9zGxROsm3VhIQtZPO0R7y6uT9Me5yKbw==
X-ME-Sender: <xms:WA_maHU7OQmSKqXzPlxPI5R0kjXmIoWM_i2ZYiu3nzOrGUngSQ0ZSw>
    <xme:WA_maOppDi070l7SU6BncBUsr7Qe_1ZVEYeITfivv2CZNiJqkrBwP-fSnvKEM1fEd
    P_BZ_YTH0g6HdlEaIzCEJn0t5DQM_CJy9UnhmCIGe96QhCBMnF9RA>
X-ME-Received: <xmr:WA_maJkSkEXXKNvie_zaRp96WFeXcIO1LuKFpNRaaKd8meBw3W-6aswNUHE5Gos4d19CMTaKYlMu4d5qqXeDx5ByaCuQ63MU2yIPkaGv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:WA_maO1-AldBu8HKMT7SAe4Jh80ua_3e1YE1EU1_rYWeZtf1O09PGQ>
    <xmx:WA_maGSH0_rEDdVaSK4b7kawMy121H0GPG0GHr0XjVA9G16kIPR0lw>
    <xmx:WA_maHx7nEBouMPR1mjtuhAfkv3nvQ09fbJDmte35SBMItf2faGbrg>
    <xmx:WA_maGBMpfqPOdtc7EnR0zaQeisU0QZ3oa3uSZ2F6F_qvViIoWFq6g>
    <xmx:WA_maDtINS49OtcgIYHd7Satgg1r7VGtQZb4DKEJVtz0A64keB_DmDTm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 03:14:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d7587a1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 07:14:30 +0000 (UTC)
Date: Wed, 8 Oct 2025 09:14:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/5] t9350: properly count annotated tags
Message-ID: <aOYPUyKJPFyfKD46@pks.im>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-4-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007122958.1089680-4-christian.couder@gmail.com>

On Tue, Oct 07, 2025 at 02:29:56PM +0200, Christian Couder wrote:
> In t9350-fast-export.sh, these existing tests:
> 
>   - 'fast-export | fast-import when main is tagged'
>   - 'cope with tagger-less tags'
> 
> are checking the number of annotated tags in the test repo by comparing
> it with some hardcoded values.
> 
> This could be an issue if some new tests that have some prerequisites
> add new annotated tags to the repo before these existing tests. When
> the prerequisites would be satisfied, the number of annotated tags
> would be different from when some prerequisites would not be satisfied.
> 
> As we are going to add new tests that add new annotated tags in a
> following commit, let's properly count the number of annotated tag in
> the repo by incrementing a counter each time a new annotated tag is
> added, and then by comparing the number of annotated tags to the value
> of the counter when checking the number of annotated tags.

Hm, okay. I think having tests interdepend on one another is bad test
design in the first place, but it's not a new problem you create. An
alternative solution could of course be to change the new test so that
it works in a standalone repository, or to add it towards the end of the
test suite.

Have you considered these alternatives?

Patrick
