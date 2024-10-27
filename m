Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA02BB1B
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730034068; cv=none; b=BQ79hC8t2X6cz38XPcupYyyQaix+y3+2Q0VluI+Xfps6NQGdKCFxU8nILJ8lRxs205LG9DJxx631XTSCoOLqyRMJkIRRIY3eT1SZUf8UYMQR92fKWwJqUgCM+DJVHyj6moVXwJW5oMu9KgGGXOPPaaOptpjEQKVkCTOBhH8pqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730034068; c=relaxed/simple;
	bh=wB8YGVCtLvmsVNaNmRiKe/LPguhDmYAiMqj+KxdyE6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fbh02Awf9YtnELI4BEC4fbTooP16EOrAlRBO0AzXyd/j4ZXdwGvrkk3aOhefyTUyrS0CDdKriEogA0IxwNC2YHPxkhHJA2edhAcKIXY1EnQ+FBdVWHRpP2aHDk4p9LkR1segF/wIZbBS6LpkNtYI5F7/iph8OWGcqo6E0r4f4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oiuPbzOt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f4xCUbUS; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oiuPbzOt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f4xCUbUS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D71611400C9;
	Sun, 27 Oct 2024 09:01:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 27 Oct 2024 09:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730034063; x=1730120463; bh=1R1OIZgAyw
	LG044JhGb7PBUxTzaWJUwvvDxCDQu24tE=; b=oiuPbzOt47hq4soBDW2DGk2z3k
	Ac3VcD5u3bAxCLc1Tp1GS7H3ivimw7RgMMx9oPV4AUO8BlhDT8OV2yAF6NR+2XMA
	nZ85BzNcm6JTzgHXEuHftTbivtkdr44gHPm7s7XrrFLVMGTIO8jqPTeuxnpWVBYM
	K2yjWJVP8Cr5PdVuVYqJi7L7jy8Z1tnakk5HnCuw9iR2YQYGOPMwCPjQX9+zqSFH
	6Z93WA/Dukvq8jD32GJOgNPskuu471zYFn6RHfqnKVeLNoRy6DhCoBBu4VzwD+5Q
	DV0H1qJ7e57DWL0jmaOd0UFMGPNzVcqHqswrDaf/eL+BpW9nFs+IvrH5GZ1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730034063; x=1730120463; bh=1R1OIZgAywLG044JhGb7PBUxTzaW
	JUwvvDxCDQu24tE=; b=f4xCUbUS6xK30xuiKKRObJq1x+soiiI9BhzM8TJXfXEu
	pRntDUVcFJQhWJk0qNdLjkzNI178C1LWEaIdv/uszkpgybAG225JyJvnRW687qtl
	/1F+gi7Ny7xbukoJVt7K/5hj8FYF8eDsQ1oVPb79VjrQU4ADFXx8wcNfwjWRvWXl
	wloKTWX209oZW68FFc+0Cr4MwgospnhqFQXLYVsFlPQvKFLSpV/67MKa6jZLkza0
	uVjGnAJ0AGRelKptoziJG3A0rAJ48zKIKGNILzXfMv1MH7jxuf6m4ELvpzBnMjk7
	0FUOKoBX7NxSMHclAfRKhfv7c62D5gJwzzqrRguhvg==
X-ME-Sender: <xms:jTkeZ-G9bIEO5NoCjKFA6MZxL0URU64DJqTxvygGISmgvxQrL9C_bw>
    <xme:jTkeZ_UaRz-EbqDeFHcR1uzZ5bppgIS070jR-kF5iOB_FEPM7icwm_Jhxm2ytgSHL
    aExlUjNHYbk4qWH8w>
X-ME-Received: <xmr:jTkeZ4LwuhpwNQgpYl5bxtDwtVSLpglmrNAdTnjzBgMjCjLcgejHpGJkVij1c826z64FQmMjDZfrRqFHBSv9JjFG4dy6yDz1_PYX4PqUwnjdig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepsghonhgvthesghhrvghnohgslhgvrdgtnhhrshdrfhhrpdhrtghpthhtoheprghsvg
    guvghnohesmhhithdrvgguuhdprhgtphhtthhopegvughrvggvlhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegsrghgrghsughothhmvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jTkeZ4GfaA4kk_BOiR0xqHKYqlX30reA9iYJYTy27jIQc5Lq7srQsQ>
    <xmx:jTkeZ0WUCUcQDT3ehEsWRUeT9s6-CYrNPCVP7WMBAhmDiK7AbroJxw>
    <xmx:jTkeZ7O7zOAgU45L641cdUWQGp_F9-asDMmgBQkiW4J0BZI0nxcz0w>
    <xmx:jTkeZ71OcF2Va2LNn8SgRZL6n4OC9vXzqrejp7Kp7tlV2dbwkIoKpw>
    <xmx:jzkeZ9PBQbz1jDXRx4lwc9kFWBeMPxjuCA0Zw7Zg2y0iJ2rB4uYvbU35>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 09:00:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e87482fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 27 Oct 2024 13:00:52 +0000 (UTC)
Date: Sun, 27 Oct 2024 14:01:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: git@vger.kernel.org,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>,
	Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/5] t/unit-tests: improve clar platform compatibility
Message-ID: <Zx45nXPWdFIqVPTo@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
 <Zxx3nmfp61DR6vvB@archie.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxx3nmfp61DR6vvB@archie.me>

On Sat, Oct 26, 2024 at 12:01:18PM +0700, Bagas Sanjaya wrote:
> On Mon, Oct 21, 2024 at 12:56:30PM +0200, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this is the second version of my patch series that addresses some
> > platform compatibility issues with clar. Changes compared to v1:
> > 
> >   - I've merged the CMake fixes at [1] into this patch series to avoid
> >     conflicts. @Taylor, please drop that other series, which is
> >     "ps/cmake-clar".
> > 
> >   - I've fixed up the "generate-clar-decls.h" script.
> > 
> >   - I've updated the clar such that it includes upstreamed changes for
> >     improved uClibc support when we lack support for `wchar_t`.
> > 
> 
> Git builds successfully on Buildroot (aarch64 uClibc with and without wchar,
> aarch64 glibc).
> 
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

Great, thanks a lot for verifying whether this fixes your issues!

Patrick
