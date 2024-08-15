Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C417BECA
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720929; cv=none; b=Ql3nTeMVJYH3P6KhnNgx7KOeK/sal6Ru06JAQ/s6aAWouOdk4aTR5BOhfU9KSI2tVdC3/NpzY3IA53LrJ74jD8GVseZmMlhuE12TWSUqzQiug+uiVL1qLBgwYPcaHUB1vCq3K7JgjoMcr/hH9PNZ4wPXczSI9uxOZ45JYtORQzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720929; c=relaxed/simple;
	bh=7kRX5Jon/VIe/EoFfV4o5jIO+LZg+7D4Ao2bBD2rfeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKnr3PTzpPDMWIKmSVvWnS9FxUS8v87mTc3hK7Y9kHe+im7oL34O1v1g8vrIKQDQ9tX6weSWqixFY9+6WF1mom5BlhR+dg21/tE9kKopNQaUI5HGVFChotpD+Zu8i3sD50gFkBWZnpxrfTsW5BUr6XpDDZyvbBhjGG5pA5gpWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lQRs2Qpp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R6GvWyPP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lQRs2Qpp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R6GvWyPP"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 71CAE1151D2C;
	Thu, 15 Aug 2024 05:41:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Aug 2024 05:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723714862; x=1723801262; bh=qM/iiY8XCt
	t39AMYBfeUn9KYYnskw1dIMvfS20NNtgc=; b=lQRs2QppnOGxNxaZEdt9rFXWED
	8htbl2HOTm8vg1BkNppaZSvs01qNsK8/K62F6k0uCs/LeVIDMeiFNksBs3fzgNo/
	FTakMDbXkPc/cb1BG7duE+9cTGOUgeNR/pfuwbX7g2Rp6u36ViPWp3zPhucUFFxD
	1r1cA6Ktn/5Ir9J4JKOu23L0AjhFvns5qe/h1DRARD4khUD/yl2neL++WB1A1rbx
	rzh2mTcmg+cBH0zU3+7E7IZsn0sSGPLf6fLZdCmvoGdw2PLnAIW34BEo2AVuYtmB
	wGdCTcsxcO5SfqHvllr/2Ju5vp0x+oRUaNgJZw8esifoP8VZwRckOGINmOTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723714862; x=1723801262; bh=qM/iiY8XCtt39AMYBfeUn9KYYnsk
	w1dIMvfS20NNtgc=; b=R6GvWyPPSj8+4PlYlEq3pYQIa8+POgXIoggXZim94Hkn
	OCWi7U2rGvAIej4ZOKRrOA+baTLyY5nR9PRnOu/ebeBnyy3YvUkihkfnW24N5taE
	XVPgYyYMLXvzd7TZhG6u5h8RPR85z5xi6Pjg7BUhuFq0Ec+glKp/O8mZTVyFx2Ty
	o7Z3VeP+wNs4df9TZYk/3FhM7KmojI9JQ6vPbBDtdbYG4JbLpBrTWhWO4qXOPhSi
	Qtoe+xwenEI5yloPZm89bDKhPhxVv0fvZ7uZrVy33myoxxgWMeQzcZRFHOC59zCx
	LO+WyTLJlQSm7nkCTFYZh7su8LQhvAKCpuOtZ/H3UQ==
X-ME-Sender: <xms:Ls29Zoq-QygGHLAspFieyEpgqDWK-5l6eEuQ5ORLLu0v86YRV5SG_A>
    <xme:Ls29Zuo4Np2TaUcm-tOU9z4nrsmZGGZOQjZvqZkmKorQ18W5MPRuPylOw9oMyH242
    Kq3twOcS_pRKapy-w>
X-ME-Received: <xmr:Ls29ZtPPUAKxHaLafwtKl-sdlgu3jom08qA_yR9gZ7zstOojT6C2S3Y7gwzDvBJV31HAiSqXByHE3dC9WGVEWa4v_I2ju_A3EVX2VAs7hx9fkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ls29Zv56h2wVeepfw74vlSZLi5_BWmG2ar_kmV58yoq3_46QY85YhA>
    <xmx:Ls29Zn5Wm9CHBNTMH_g5ddWnjpvx57BydsOSLlAK3LtgRDIY0Wzebw>
    <xmx:Ls29Zvij5-IWLZX9RcuypE2maDQoY-O3Uh2jLLpTJ3XrNW99dxIhsw>
    <xmx:Ls29Zh4yL2XFaiJVb0PCOhx1H6F9Ba8-fpqBgk5-b6ecp-C9b0NCdw>
    <xmx:Ls29ZpmQM7_GrJHhryeoA8VTNMR99nxbf3Ew9tGTVINW2odRc1IDbJRs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:41:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a4b708e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:40:41 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:40:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 05/10] t-reftable-block: use block_iter_reset() instead
 of block_iter_close()
Message-ID: <Zr3NKWOFlZlkkOSn@tanuki>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-6-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814121122.4642-6-chandrapratap3519@gmail.com>

On Wed, Aug 14, 2024 at 05:33:13PM +0530, Chandra Pratap wrote:
> block_iter_reset() restores a block iterator to its state at the time
> of initialization without freeing any memory while block_iter_close()
> deallocates the memory for the iterator.
> 
> In the current testing setup, a block iterator is allocated and
> deallocated for every iteration of a loop, which hurts performance.
> Improve upon this by using block_iter_reset() at the start of each
> iteration instead. This has the added benifit of testing
> block_iter_reset(), which currently remains untested.

I don't think that performance is a good argument, but exercising the
reset function certainly is.

> Similarly, remove reftable_record_release() for a reftable record
> that is still in use.

This is a welcome change, too, to verify that reading into the same
record multiple times does not leak memory and otherwise works as
expected.

Patrick
