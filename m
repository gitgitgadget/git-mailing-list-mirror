Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604F23C51C
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984227; cv=none; b=OqzhQ5RRJKctt3hFRvjZseC2Kcn//N/l+L46TEW5a+uULnwK67ecfwL5cqLkdyfFHgP5E+7/C+L4+n9sPVfngxCGtpD61IxAetztS4McgYSngQJG6YCUPnAO65BjLplgXY07BxDxSRhbFjJbOPVoXeAVSsWcJ6n3RlB+gNa88H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984227; c=relaxed/simple;
	bh=INwBCWBHiYME1hxZg9GqHAoohptAIHgnWeKslBpYOKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU6cqIwb0i9bR9sxS001OLZugjiKwcVfQQJb4OddMbspZw97qfEFC+b+DkOxIu1oreBoHbibSbnkk/EvL1P68cWyJtltBIFhAPU8yzSri9BzHyM6sM4Qvw4Bt2W3Bukcdc6ZH6u0ETt+kkHkaKnpi9HQutFnI1JbCKNkQzY4hig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nLPX5hSa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1/H3atz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nLPX5hSa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1/H3atz"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 32088EC0259;
	Thu,  4 Sep 2025 07:10:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 04 Sep 2025 07:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756984223; x=1757070623; bh=Kj66P0K5hc
	yfmVrKCtlWzikEGirtnwu7tywSHgp68+Q=; b=nLPX5hSaQqX0AkwxtUNt6BTAeI
	dVEIrX0748NeqYUejVEcdkqR1B1jI3MXxUAsR3/XQeuGt2SSVwIvq8TKjKnSAFRX
	kM4e39UJqfQBzmXH4kVxCtz/4HKMiU3fcYrthE9CUU2iW7OMySyMfZMFr9ZLRBOk
	KWh6GAnCKPzUejUhauwaXWkAc6ti9Q6IxHuDYq7nIcdzRWQg/AOCuatotd4oi/7/
	HGhJZlFdsEmAgJHkJVZ2gqnIn1BjslsnIzXUFdFIp3H6y9ft2iBJ33DRR7NHjv9H
	ubSSirnuabqoT7qfbKLkOBuay4FUyfFH73RO2+RuFR8BK1gjy/D2FiPFo44g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756984223; x=1757070623; bh=Kj66P0K5hcyfmVrKCtlWzikEGirtnwu7tyw
	SHgp68+Q=; b=Q1/H3atzsh8CLabyvdMRSEUAmHQ2WtR2Rz66gHxKWGAvbWwgyGo
	bgAkpyNHRN257XYvawGamZ/WecjqRMHv2cZsLry48po6jSkE1wekyvS2fBdI6x1u
	HTAHIhhULlyvDEJgF89Si2+bm21u9n4Q8PNVrbKyU4HDL/PJmGn8RXYI6xYd5Kgc
	I2Ur8R9TuNQ4wUaWot3ZYQEuCn5M36S9lbifuhQE3eTqRNBxY+VdlChmA6jyOwea
	62uGUiELh+jVfyBUTkBC+gwISePRzGvTLbLlxL2/PirK5x5ibAms4J9XoQqKdqW0
	HMzGwYL8eTBTFcWkg9sdtCEGCPHGdCc9ZGw==
X-ME-Sender: <xms:nHO5aLiffeqdmqIaoaUsc0NtsXJZLm6QgVRdyDWnAuk2hY8gc7bOSQ>
    <xme:nHO5aPrJU3rQVOro-ByGW4bMJPS577ij5Ssj-iTzkGr5y2f4SvuUfZioPKrPVPyvw
    DldQW_waFDtb-7DAA>
X-ME-Received: <xmr:nHO5aLSiZHGnTkCUFaWwE--bQF0elDQeZJjcF6yzc_jbfIXsSdpMhJAphlYPh7sGDkCVb2nm-aghToc7lX1sZbQhOf7AxnSZ3oWKFnE82QGlww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigr
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlh
    drphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhn
    vgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsthgvrggumhho
    nhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:nHO5aATkuC5ivYPRhMp__0XkSEwoLiChhrZRaQ1ESMSOI3QU7THDhw>
    <xmx:nHO5aJVUVnM0-_ci8MSENZLDB8PxvAxw_dyOooCk8xgTzpIIoEjJbA>
    <xmx:nHO5aN19FqnWhup35dh_dc0M9lPeGZtoMe2SYB68oun-A-2DP7B7pw>
    <xmx:nHO5aI8YtePhy9SXMU4diIBkjmgv8G_wLXKczfuD6UPISE8-tBmP5Q>
    <xmx:n3O5aLrxZybxleFsPg_P6mT5T25X3QutIn_HjDU43UqQo5uYvo8aK54L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 07:10:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2fb9393 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 11:10:15 +0000 (UTC)
Date: Thu, 4 Sep 2025 13:10:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com,
	'Elijah Newren' <newren@gmail.com>,
	'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
	'Christian Brabandt' <cb@256bit.org>,
	'Phillip Wood' <phillip.wood123@gmail.com>,
	'Eli Schwartz' <eschwartz@gentoo.org>,
	"'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>,
	'Sam James' <sam@gentoo.org>,
	'Collin Funk' <collin.funk1@gmail.com>,
	'Mike Hommey' <mh@glandium.org>,
	'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
	"'D. Ben Knoble'" <ben.knoble@gmail.com>,
	'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
	'Ezekiel Newren' <ezekielnewren@gmail.com>,
	'Josh Steadmon' <steadmon@google.com>,
	'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aLlzj-FxXCmBXTQz@pks.im>
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local>
 <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g>
 <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g>
 <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im>
 <xmqqms7bchln.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms7bchln.fsf@gitster.g>

On Wed, Sep 03, 2025 at 03:10:44PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Note that I'm not saying that we need to have both a C and Rust
> > implementation for everything written in Rust. I don't think that's
> > sustainable in any way. But any feature written in Rust should be a
> > _new_ feature that can be disabled and that users can live without for
> > the time being.
> 
> Yes, if we can find such modular niche, it would be ideal.  But how
> many areas that we can cleanly plug an optional thing in without
> disrupting existing codebase are there?  Offhand, all I'd think of
> are a new merge backend, a new rebase backend, a transport helper,
> or perhaps a new diff-algorithm?

Not too many, I guess.

If we cannot find anything, an alternative could also be to take a very
simple subsystem that doesn't see a lot of changes and convert that to
Rust. We'd retain both implementations in that case, which I mentioned
is painful because we now have to keep both in sync. But if we say that
this is a testballoon, only, and that we don't continue to convert other
code until Git 3.0, then that might be fine.

"varint.c" could be a good match. It's trivial, only 30 lines of code,
and completely standalone.

We could still build new and optional functionality via Rust, but I
guess it also doesn't hurt to have a test balloon that is part of
libgit.a to test interoperability.

I'll send patches later today.

Patrick
