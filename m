Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310923C8CD
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390232; cv=none; b=n+Q2IDY31ijkUmdAXYkahWdJEdjb1kWMfY6T+srVz9Da74DPtSozUGSdKkBcGlM216ovjk+r7fE2z7fwoWrEJQ8pfwuh0WyYRLQb8r1qaEnUxHm9bc3KPuKbLYWEax2SduLXrjFTA31p8wulqMVbCZ/7LALZo+Ec9nFYD5kgN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390232; c=relaxed/simple;
	bh=1wnu7NyHRTZ0TvXnLSCliwIpRtauwpKdTVtUBHfm/KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0Cu8/A3LoC4PGQyhJwALTqtzgBCm/wzqck4x/fyHX/0q/NamiJ1afFjwWPl6FFPjhtogNxhEEzgchmnC481hT+UZgwr2FFITI04yfFVWM6lwHf3OCvSTnK4zZwGm7JFwKIria0YXn1onUA47qGk7SJ1SVaD5ysk8tPOmUdcNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rM671dhb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKjdug5g; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rM671dhb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKjdug5g"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 81BA01D007F0;
	Thu,  2 Oct 2025 03:30:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 02 Oct 2025 03:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759390229;
	 x=1759476629; bh=KU8xs/g3sZfYgo14olyUaOWpzBvrY/fw8lbPJiAm32E=; b=
	rM671dhbEeyfTXE1YARj+78TC6ilmZ+Z34vtcqvADbF7y7neH/CLm2LDvL4PpJH8
	VtsTTPFt/iDlMwoBEuv/5IEuuwjQ1+BaMld9OSEYIQ/fPkn/cPPOEJPTR0ae09cl
	gdlN8Y0zj6CXFCTbitrw8uRzpHHVKp2XP5PVNIX3Wbnw3bTfG7gmN0KhNaU2P/xk
	56qKE22ccGYEW09r9lw/o4eVKZhQSLiayU5Uwqf/jPc84MI1qP1vqecj9j+eVJvJ
	ceCdAllLEcD+6hWh12guQjsXn/3Z20LclRV1DsdOg8zH6z12Gb9YL1pOpJ16zoYM
	lE0Wsx0irOy/1xOj6e2e8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759390229; x=
	1759476629; bh=KU8xs/g3sZfYgo14olyUaOWpzBvrY/fw8lbPJiAm32E=; b=U
	Kjdug5gWSxWA0DYcJE5mLEMEhQS9s6T1NAtqLYcorhc4YahNRMaMz7F3A2SQBha9
	RMMU9yTzkwJEfwnsRjnQReAORK+WXIDyBzvM+s0pmxUXnt4wZlL3Yok7fYWan8Bk
	hvaNf5fr4pcGZySSHMVI+3iFL3ceWAjRv3AJWe7yAWu/cKYlMmRl77GXcxMQJC+I
	X4T2/uj/fDcnFEaaGK0aEg5u22IC9nITF7db2VxMNVyk7e3VtDML1ABI1WQzJ7Bm
	tYbwL1E0Qs+z9NYytXjIwgcPqE6MXDtAaegwzl2v3IDbIT249+yq/n2rnjbQopzk
	ZBr3G+xR1NWpP8gxoUmLQ==
X-ME-Sender: <xms:FCreaDPGQYdFrxcBYoSxJt3Q0yDQKG9RIQ7D5JFG3X9BRrss0FlEjw>
    <xme:FCreaOaowdMOx524W2KZuwx8XuOg5LMSkTqXNLGO_sr-o0ryPIFXnXmDKklf8R2rC
    yzoCFVyJbXp9HTEp3rpMETimR1fLoCxygiyxG3ybLGHS1RuM8o5Qg>
X-ME-Received: <xmr:FCreaCD-HrCs6A_IxC16-SzXZ3pTgtgAbnE4a0E1SUU7GUWV5Cy1lGNHnG3uyQqBq0mxklzRe7dNtrVCZRqCeKnoTmD70OqwDp7II7pebw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhr
    hiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FCreaEHDlDG5ThJv9-_YO5eeVwxVjTdy6m1Kgs6kQAfMr4qHKXPQNw>
    <xmx:FCreaFOTWjxqG2X8uJ78kEjk5LvTwl8LSabdmm-X8AgeQIN9hyGXKg>
    <xmx:FCreaNirJJGo99F5Dzcyt5_zAmUCr__HSG44NeJzY5idZ3PVyAOewg>
    <xmx:FCreaN3Cco6GcTskeIwcFym_gwSBuyLX6i6UcvQpFckXQvZNcDcSjQ>
    <xmx:FSreaMErTmNNbzsTsZpb484C_UuefFPC6oPjPFzG1IOgQy__L3fp3qfW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 03:30:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76451d30 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 07:30:24 +0000 (UTC)
Date: Thu, 2 Oct 2025 09:30:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v7 5/9] varint: use explicit width for integers
Message-ID: <aN4qDbvN10nvNMOo@pks.im>
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
 <20250925-b4-pks-rust-breaking-change-v7-5-4e49dcb904d5@pks.im>
 <037d8685-6521-4ac1-8251-d93e8a1d7081@app.fastmail.com>
 <CAH=ZcbBQk9xmTF-m6tX6F+PRmnUSoevyFFvK-fAc3uzL3NvqSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbBQk9xmTF-m6tX6F+PRmnUSoevyFFvK-fAc3uzL3NvqSQ@mail.gmail.com>

On Wed, Oct 01, 2025 at 11:22:44AM -0600, Ezekiel Newren wrote:
> On Tue, Sep 30, 2025 at 7:34 AM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
> >
> > On Thu, Sep 25, 2025, at 08:30, Patrick Steinhardt wrote:
> > > The varint subsystem currently uses implcit widths for integers. On the
> >
> > s/implcit/implicit/
> >
> > > one hand we use `uintmax_t` for the actual value. On the other hand, we
> > > use `int` for the length of the encoded varint.
> > >
> > > Both of these have known maximum vaules, as we only support at most 16
> >
> > s/vaules/values/
> 
> Other than the typos this looks good.

Thanks, both of you! I'll send another (hopefully the last) iteration
now. Guess we'll now have to decide whether we want to try this Rust
experiment or not.

Patrick
