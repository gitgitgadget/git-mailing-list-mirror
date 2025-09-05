Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E62C21FB
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058610; cv=none; b=HYK1VSAzOunaI/rvo5wYkOooOSrkVMqjJzls1gCyWcnESIVxCn7KyRUSAnMahWZSfMLBjVE4HaF3hEepoflXiJCqaT4T9bOC0+gwCfBoU7ZCadaTRnyK+JgCQj1iPnhWE7+TtZleOiOhcdWeHyXOIEFhdDHVnflmYZKEneeP8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058610; c=relaxed/simple;
	bh=NP6Xs8rWbrxnL4U73FEqBMJ9MWUMAj22u3SrwHSzLNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkQjzEvOwf6X/U5rgekSQvyTRiZbqBxncWaahgqvBgrJ5CyWKxu4kbBm+UrUhc8EVB2n7nMiTAjDwyTXWvgg1GCzLRCgyH9FC3wxsMIsnPyEO0qoM8SOt9OIDjx0w+0KABtqYE4Gd3t0AEWFvEbQ3rSy7Hq5pI44MVP0IjAMwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sz2P9dtJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KZswkeSM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sz2P9dtJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KZswkeSM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A3F481D00471;
	Fri,  5 Sep 2025 03:50:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 05 Sep 2025 03:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757058607; x=1757145007; bh=MLMP/0Jztd
	E9JtcF8N7hMpb/jOdIrIcyWhA1n45hPPs=; b=sz2P9dtJKPROo34JUfP3/de4wc
	I6chtaBZckpW4DYYMN2b1HFoyBvMThfs3zhEGPn5opaNfIaEsSjNFrV6VNivbc6s
	wXTGbqKaLDIWgPOHjlCf5HQCBv1oi2tlKd2YyV+67W0dx88MARm0WhOa2AFQqN3o
	F3Fu8eJnmsREvjnx8FNAGrlmAwVMAy8Jl6oaSP+H1c9gCXxKv5NCbgSU+fiHJg6O
	7hzkbNLzFNYkNiSjIOPAyUiNfStRAKx84a4BAMN7KKuPfkdyaj9nKpIrxkvwiIyh
	aIqJ+9/LuMWvKh6rDZboAU2N4MCZ6Pd4n4adSyfzZuIppSlQtmkd5uHJfrJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757058607; x=1757145007; bh=MLMP/0JztdE9JtcF8N7hMpb/jOdIrIcyWhA
	1n45hPPs=; b=KZswkeSMtx9875pCk/xU2/ZN56L8aWKYsdyjM58sKv1jOwDC4nz
	JJYOpOzuFBvUWpop1SFlK2tzK54deTTgT7ehiqgyADjObT5MdV222GeSc4ghLXpE
	fLZuKonrmCZYEBbYh6Bhn/R9l4/AkukOtacB0IByhHjTrInkOjhd5er9CWwTK7uT
	WKp2pZNnlaFLPEwna3n8S2xOUnHpESLLRTENZBYW0YygR8nY1TSxGHDEf9/a8Ech
	qJtYJVBjpRRdig6pimmnDPJOMfKZ98aIoUKCAn9nV4vr+gTb5VJEkB/5zjmpWl0s
	6FCZZKSnv+S2dmKu2ECfTPZFf/9yADYS9rA==
X-ME-Sender: <xms:L5a6aOEjDl38KU67bA46Qsm5hbgAdGDQllo1SlV4JuGUCJ4JZ8s7kQ>
    <xme:L5a6aPf9aMc5jyubWc9nfEueCvc6KpDstGTsbABU7pomti2e0Jit9i6RRtlaQnO3A
    3cjLvgYZwuii1mO8w>
X-ME-Received: <xmr:L5a6aPkgyRQLgOcCbLpAV9B2xdX4JYy7M7TRAEcFVNGNnfFQjzwYSNRp5rawYzFeMplhfoGlJp65k4Qs32qqNQPbxTRtjZnDnwgyKpdirrzq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    fgffefudfhvdejudduieejtdffgfegvdekiefgkeetveekgefhfeduueetvdehnecuffho
    mhgrihhnpehmvghsohhnsghuihhlugdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtg
    hpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthho
    pehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopegtohhllhhinhdrfhhunhhkud
    esghhmrghilhdrtghomhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhp
    rghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiise
    hgvghnthhoohdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:L5a6aOpflY3MNVRv28whBwlfNH2ExNra9NbfbeTmNRvwe0rdcW-80w>
    <xmx:L5a6aME25e-6dmTQte5uQjYdW0YzabwauzZDe7eoqHsHOFyzWDG1Hg>
    <xmx:L5a6aES74H_Wj0-WlR1yUcfSqfapnuPf0NvllT8RlkTde5B2d-2gpw>
    <xmx:L5a6aCNHSSkFQT0IDDjr20-ue3reR90TFPsiEeALm92kq9J0fvwTyw>
    <xmx:L5a6aIIXERw9aVr_B1jKzThelxp5_V9Y8xedJQfo0SgmGrG32r0Z9eCg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 03:50:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 261a0ec0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 07:50:04 +0000 (UTC)
Date: Fri, 5 Sep 2025 09:50:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC 1/3] meson: add infrastructure to build internal Rust
 library
Message-ID: <aLqWKYkj98QUDxRi@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
 <aLoNc5S6PVW8jLu5@fruit.crustytoothpaste.net>
 <013a3006-d220-424d-a28d-fb273c523c71@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013a3006-d220-424d-a28d-fb273c523c71@gentoo.org>

On Thu, Sep 04, 2025 at 09:16:03PM -0400, Eli Schwartz wrote:
> On 9/4/25 6:06 PM, brian m. carlson wrote:
> 
> >> +if meson.version().version_compare('>=1.9.0')
> > 
> > I think we need a different approach.  Debian 13, which was just
> > released, only supports meson 1.7.0, and you have to use testing or
> > unstable to get 1.9.0.  There are no versions of Ubuntu, released or
> > not, that support meson 1.9.0.
> > 
> > If we require this version, practically nobody is going to actually test
> > this case.
> > 
> > Our platform support policy implies that we should be requiring nothing
> > greater than meson 0.56.2, which is available in Debian 11 and has LTS
> > support until 2026-08-31.  Ubuntu 22.04 offers 0.61.2.
> 
> 
> Hmm. Patrick -- do you mind documenting why you decided to use this
> version guard at all? Off the top of my head I'm not sure why you'd need
> this.
> 
> In src/meson.build,
> 
> +libgit_rs = static_library('git_rs',
> +  sources: [
> +    'lib.rs',
> +  ],
> +  rust_abi: 'c',
> +)
> 
> 
> 
> rust_abi is new in meson 1.3.0, but it's just a rename for clarity of
> rust_crate_type, available since meson 0.42.0, so please use the
> backwards-compatible name...

Oh. I think I misunderstood the following sentence [1]:

    (Since 1.9.0) Rust supports mixed targets, but only supports using
    rustc as the linker for such targets. If you need to use a non-Rust
    linker, or support Meson < 1.9.0, see below.

I thought that only with Meson 1.9 you could link Rust libraries with C
libraries. But I guess this rather means that you can now have a single
target that has both '.c' and '.rs' sources?

In any way, thanks for the hint, will drop.

Patrick

[1]: https://mesonbuild.com/Rust.html#mixing-rust-and-nonrust-sources
