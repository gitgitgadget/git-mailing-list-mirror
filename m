Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEDB245028
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492542; cv=none; b=A0U8Y5FzfiqQYsHw87zbuUQ7BqJkmsZsXIZ7guOES5pFlzMM+8RJmdti4Zs1yfLztnULAFnPe2uj2H541p+07BS0ogZX9H3NhPM5y12hESbihIvp533tJR70WMCHaeOU9BdAgPr20223a/tzyihF6GYf0G7OToBc2vhyWcrzoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492542; c=relaxed/simple;
	bh=Nue9Y935qiAILsLM4jznUmRNjU38FFJRxe0ZWgZGdUQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1oBeCvMWe2nu041lWCiA21wu/VRSLgFqKNOqRj8XGc2rnCY9BEkMwuef3k5gfUdAPTOPZ+3HphHF8bjlo13CSzXVzUsaclI5Ang1pqGEg4yVerqP2paHCLQyWYtqQpXk5gAkWp0AoHTUg6JXFPw7Ai9PXJpC1Puy/Hq+is4yUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qa2eG//R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gBCnF2Od; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qa2eG//R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBCnF2Od"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96B927A01B2;
	Wed, 10 Sep 2025 04:22:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 04:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757492538; x=1757578938; bh=ra5IuRb0ep
	Va7JPwaCkaOSDcljAWZxQSdJMXYsLImS0=; b=Qa2eG//RZ5u64VVBu8G9JDeUt3
	57WGnDlDGJ39ojLnMpbZzHdC2OxsYC5A/+/HGzhhuZaJSgL1xsVJvJbiyP3H0K51
	l5NqjgHa6iMIfyB8bXHofJsEYM2BZKcYnHuplB+TcmQOCyi74l65/4/7MIlBqIRJ
	MKVvRHBvrZsmQKK8VKXpNdicGWBp6xaWTkVKBdVsXDa7xQr0ZN5El53o/ePZckAg
	m6YItgBTvOgjTRUIgStqG/3kIrgGKqKDv7xCSFKH0H+Mm2CI2LH4cFyNHG345Jd2
	TqjDyXyjXG4FCxJGdUr4lo418nDFRvKzKAEqDdGAH+Y3izBXo4VVw8ukegyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757492538; x=1757578938; bh=ra5IuRb0epVa7JPwaCkaOSDcljAWZxQSdJM
	XYsLImS0=; b=gBCnF2OdsSaFDdSv82fRFjF5lQIp5KE6IM3RqcrzHihvaVyK8IC
	S+84nGSAm7f9wzL/JSbHUNOp/MI9lCANukKv8pHIK9W0+0+v7ydFx/9dertPaI9y
	m1RF+wh3dZzTWxGifedPZJIheU5Dksac4aWu0/y/zN8N3Dh7XDE1ynM2GZEG8kKQ
	a5WOFk09TuALE169APsqYSLwQWdz9/4pUxDoNR8qm5xzSy7a32FA9QwyKJ44ljA/
	24hGeaD5jSMYV80cuRDJoH6U7JkUaWKyS/XZeeMd7l0JO/F1M2+bnRmDiurTgP4o
	+hVbJrOYYT2FUPBJqL++oJR/Svn2SsCWs1g==
X-ME-Sender: <xms:OTXBaFQlf9ZHow3lVfRG3aBwG38PKS2BOHwJOJ0gElbl4culPusTjA>
    <xme:OTXBaO7t1xMB0Y0uRCiyBVCZBH9Sml2MG_oXxEgGZUfThQ2GCa1XPJUOMC8iUDK01
    LdRrz249YePrGFB5A>
X-ME-Received: <xmr:OTXBaCQ3UbVpDma39QC6d8yh7sI42BUYviBcBMHiHFiJ_yjqYCjslu7Cao0GTv1BdxDBod8QwvzuNKZkodrqAEKVhoMESU9lzLg9-B9WrUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephe
    ekfeefgeegvdegvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegtohhllhhinh
    drfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdho
    rhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehg
    vghnthhoohdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrd
    hmvg
X-ME-Proxy: <xmx:OTXBaDlyFeVPc_H1LjIcdXzl_zGSyD7L8sUj0JctrAdo2YpI4EsSfg>
    <xmx:OTXBaGT8s6Ribjd_cMeV6ys8dmr9fQJdyylA4aE4bezUuB4UJliHag>
    <xmx:OTXBaKtTv81dxTrRBGj7EN16hLVDfHXbXZyM6CZWUwGoy4YelfuM8A>
    <xmx:OTXBaP608B4CHl30r2W-CzBmQCnZ1a03mdKqgnVDxVqgHfG9_GMRYQ>
    <xmx:OjXBaPFfSmI_tbPTu1QNFCuWpz5TCWJAIcpDG00kYmdyrEuaXTLXbIJv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 04:22:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 634cbfd7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 08:22:15 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:22:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v3 1/8] meson: add infrastructure to build internal
 Rust library
Message-ID: <aME1M4YsMsrmu2Vg@pks.im>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
 <20250908-b4-pks-rust-breaking-change-v3-1-1cd7189fed3b@pks.im>
 <aL9UIeyUqmwwPt2c@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL9UIeyUqmwwPt2c@fruit.crustytoothpaste.net>

On Mon, Sep 08, 2025 at 10:09:37PM +0000, brian m. carlson wrote:
> On 2025-09-08 at 14:13:08, Patrick Steinhardt wrote:
> > diff --git a/Cargo.lock b/Cargo.lock
> > new file mode 100644
> > index 00000000000..2b80a01e22a
> > --- /dev/null
> > +++ b/Cargo.lock
> > @@ -0,0 +1,22 @@
> > +# This file is automatically @generated by Cargo.
> > +# It is not intended for manual editing.
> > +# Fix this to version 3. This is required so that older toolchains can still
> > +# read the lock file. Furthermore, while an argument could be made that we
> > +# should not even commit the "Cargo.lock" file in the first place, there's two
> > +# reasons to still do so:
> > +#
> > +#   - It thwarts supply-chain attacks by committing checksums into the
> > +#     repository.
> > +#
> > +#   - It is required by Meson so that it can extract Cargo dependencies.
> 
> If we check this in, then we basically cannot use any dependencies.  As
> I mentioned elsewhere, the problem is that invariably, if we're going to
> pin to an older version of Rust, we're going to be faced with the
> problem that some crate is going to require a security update that is
> also going to break older versions of Rust, and we will then have users
> aggressively demanding on the list that we update it immediately and
> ship a new release, breaking those older compilers.  (And yes, I've seen
> this happen with Go dependencies on Git LFS, even when the vulnerable
> code is not used.)

Hm. This one just feels weird to me. Doesn't it break reproducible
builds and create new attack vectors for supply-chain attacks?

> This is made worse by the fact that you want to support Rust 1.49
> instead of Rust 1.63, as I proposed.  Absent some compelling proposal on
> how we're going to deal with this situation, I think we need to omit
> `Cargo.lock`.

Just to clarify: this is only initially, until we have a good reason to
pick a later version of Rust. Right now, to the best of my knowledge
(and please correct me if I'm wrong), we don't have any reason to use
Rust 1.63 yet.

I'd like to pick the minimum version with a certain intent, where the
current intent is that 1.49 may ease the pressure on downstream users of
Git via gcc-rs at one point in time. Once there are reasons for why we
want a newer version of Rust though we should definitely discuss whether
it makes sense for us to bump the requirements.

Does that make sense?

> I think the better approach is to leave it out and use Cargo to build
> the Rust code instead of having Meson do it directly.
> 
> > +# Starting with Meson 1.5, it knows to parse the "Cargo.lock" file and extract
> > +# dependencies from it. So from hereon we don't need Cargo anymore to build
> > +# Git.
> 
> Ah, yes, I've already broken this in my branch (early this morning, in
> fact).  I've added a `build.rs` file (used by Cargo) which is necessary
> to properly link the tests against `libgit.a`.  (I'm using the hashing
> code in some of my tests.) Meson fails to honour that and so the
> compilation breaks.

Too bad.

> I don't think it's going to be viable to try to maintain two separate
> build systems that build the Rust code.  Everyone who uses rust-analyzer
> (the Rust LSP) will use Cargo because that's the build system it uses,
> and everyone uses Cargo anyway, so as a practical matter we need to
> support it.  Trying to have Meson do its own thing is unlikely to work
> here, and it demands that we use the `Cargo.lock` file, which we'd like
> to avoid.

Unfortunate, but probably fair. Let's take the simple route for now and
potentially iterate down the road.

> > +  cargo_command = [
> > +    cargo,
> > +    'build',
> > +    '--lib',
> > +    '--quiet',
> > +    '--manifest-path',
> > +    meson.project_source_root() / 'Cargo.toml',
> > +    '--target-dir',
> > +    meson.current_build_dir() / 'target',
> > +    # `--out-dir` is unstable, but supported since 2018. It's been recently
> > +    # renamed to `--artifact-dir`, but for now both options are supported.
> > +    '-Z',
> > +    'unstable-options',
> 
> `-Z` is only accepted in nightly versions of the compiler.  This won't
> work with stable Rust and it definitely won't work with either 1.63 or
> 1.49.  It didn't work for me using Rust 1.89.0 when I removed the other
> branch.

Huh, weird. No idea why it works on my system with Rust 1.89.0 then.

It's kind of puzzling that something as simple as specifying where Cargo
puts the build artifacts is a nightly feature. All I really want is to
say `cargo build -o $PATH`. Oh, well...

Patrick
