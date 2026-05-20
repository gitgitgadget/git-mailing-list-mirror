Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91192D0602
	for <git@vger.kernel.org>; Wed, 20 May 2026 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256359; cv=none; b=dHB6g1LfYeY2JqZnKgKAmYfGC82AMp9v/I6NFJ4PpQkpgD0DzVR2FLXU/9FDA62ZKRG/b/9h8RgNd/R09F9+bWEuWMTZww9Utbw3D4nA7JOlktdqEBI0Xt4XVjTvu3HbzD6toz6M1aUG7QnsC7qmiT3fSmwpULXGNLqXNGx3ijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256359; c=relaxed/simple;
	bh=kbJSQ9Ow9WLyPcdzfURW/tF12RuX/xjIBIO+ckMjefQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGZMdL85c1yRMSKJxDvQfLb0IRNDF8mYGfMjNKNz++KTMMfPpXy8otcA4G7SM2WDCIdR/3BDXJ1P+TWUZqduCBL+OSOYtBytwlhoKl0QAPuuzJ6tG9R/Rk+isduSq1EK5luqGRH8uXLrYr1p5laBZC5w+abBYjvFHNkPNz3d8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xmk62kha; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c1ntnkXa; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xmk62kha";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c1ntnkXa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DC3601D00060;
	Wed, 20 May 2026 01:52:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 20 May 2026 01:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779256356; x=1779342756; bh=XJriXNbdPQ
	npZISDBZZUKqoHWp1iRyfaGa8E/n5wNAM=; b=Xmk62kha7dVde0Ac2vhS7NKIcG
	8PqdBHk5TK7goo2A35AXT0KNNh556akuY00g1Huq5XKCURAP/AElrxjDC4ykYYTb
	ZfLuXKzGu3TWtdsta0LhaFzO+3Y11x6QuMoe+/BA1IoeDoAbT4S03WKHgeuSreZK
	FpWvV+68xvbESnFJlsPO8KZY6k7oHfYAdQWTHOohD9o0rKWbwX3S88UBRb/V6a3p
	7O6kx+VDLJPQvOrckPDP8mfVe2xGUmXL8G8BLoA8V/S2VILPFqb/90G7DdgTwVc4
	1ADoWo1hKpkaeyCcHoQPy6jwBCIY2vCIl2R+SZ4KtYmUHBQWV91R3Y/or6Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779256356; x=1779342756; bh=XJriXNbdPQnpZISDBZZUKqoHWp1iRyfaGa8
	E/n5wNAM=; b=c1ntnkXa2A877DhSk6Phm8oAr60A2BJ/zzfRzTCxB3aib0b7Run
	P4Azrgx5yx1tfrPbSPteXZkgTPPFHZBS7GAw81BWjpjuFAHtSJBUVYS2Gx1CHfuO
	8sCnZcu3y0TKFmIqqkAPNpRtoZEKO0TEep3b4ZAado4VeZd5aSZIRDPh7WZxqx0A
	m5bSlqr6k5GpgsSsLkMhR262ipf0HN3NaZ3xPwlZRhEbXkIUJKRd0hb307H5NJYZ
	XgILXVX/8vB5YgrAk9dsK8x6MyxZLuhB5gSWQiUkf41fa9oVK553qTrEsFLOMxes
	epKWUDp0H6QBzVNxZ2rsvyIC0tA5zEn1cEQ==
X-ME-Sender: <xms:JEwNasbc5FPfn8RpCW49-t60MbrsupcPdkrGtComQxfAqg3DqpClJw>
    <xme:JEwNaproIZAIemuZ8LPBdFuX7HYQWt1cjXz0cdGG5WUnRuZGG4XIi1jO_zKlECpbP
    PhIcL-wx26Y2xFAM-KvspNMNX7BljiQ8cw_VJ8cRi-bJPcZmPZbj_g>
X-ME-Received: <xmr:JEwNapNBprqFrJy3CRosNOZ2dJ6qyVHv0BiUD067mtcBzAgvvS0wjfbZgOgmwJD4YTx5ReSd16cnlPNizaycB5tk3YxLjh5oyApl62Yfug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtoheprggtthhiohhnmhihshhtihhquhgvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhhikhgrtghhuhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:JEwNaspr51NywZb_aiSpK7Az9G6m--D-7fcDrY19PXGxy60U21EcBw>
    <xmx:JEwNamc1TXbfSSCqoGgltAC6k8N2MH-klaorVA81vULVkEEjY6uFXQ>
    <xmx:JEwNaqSmG5zIfHOzgW2UCfnI1HAAnPy5HqCHXM1h2_o4oIN5tMSQCA>
    <xmx:JEwNananh5pwM3Me_CtH8bsyDtHOuTjGX30c-ARiTABWxthMIgPnhg>
    <xmx:JEwNaop9xi4TML55o45PaqO3mukMyYu6dwoTntS9s7Al-_xvbTRCMtKC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 01:52:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 540fcfb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 May 2026 05:52:32 +0000 (UTC)
Date: Wed, 20 May 2026 07:52:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	Jean-Christophe Manciot <actionmystique@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 1/2] builtin/maintenance: fix locking with "--detach"
Message-ID: <ag1MHje6-C6nmcO4@pks.im>
References: <20260513-pks-maintenance-fix-lock-with-detach-v3-0-f27a1ac82891@pks.im>
 <20260513-pks-maintenance-fix-lock-with-detach-v3-1-f27a1ac82891@pks.im>
 <xmqqy0hnipy4.fsf@gitster.g>
 <agz78jjYEAif4lZt@nand.local>
 <20260520054716.GB3849892@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520054716.GB3849892@coredump.intra.peff.net>

On Wed, May 20, 2026 at 01:47:16AM -0400, Jeff King wrote:
> On Tue, May 19, 2026 at 08:10:26PM -0400, Taylor Blau wrote:
> 
> > Thanks, Patrick, for making the change. I think that this series is in a
> > good spot, though I'd like to hear from Peff who had some comments on
> > the second patch from the previous round.
> 
> What's in v3 of the series looks good to me (both patches).

Thanks, both!

Patrick
