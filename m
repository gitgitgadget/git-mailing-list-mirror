Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7F285CB2
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079499; cv=none; b=Ms5jYQW4bzWFatc/FnucxYHnhnjjor+kP6S2FxIxg6dpf5XDDRAHq3beH/ehQmY/ngSn6LmwVTeWT2m79MUfXPHAmuCWYXTOCppQ68bCI//HN6Hp6KAXUz20aFgUlLQxL0ACV8++l84w/5DXX4HMfoEeZUlk8v839gUz2JSBWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079499; c=relaxed/simple;
	bh=C7hvp5uho0mDMj5QUzw8u9sWNoBK72qHE54fjAZBY/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThEfWBpyGd7h6KRbapO30P8/EMDcPx2xEVKmcGPM6xW3aX41rUxxdWu7zGggYnS1raFU0p0gDJVrkaKiHJVCyStqAf7clt7GzEIXvBpJYFD0wIlA9oDJCAzUbEr+aXCsGAq7UvgFTCv+ayZVD24N0oPnVJqzAjU1zDMZs67bOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jz5ZPshB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZivVBJnV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jz5ZPshB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZivVBJnV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D51E14003E0;
	Fri,  5 Sep 2025 09:38:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 05 Sep 2025 09:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757079496;
	 x=1757165896; bh=ajaiFkBKHUpinaUmnFNbUuyFwIiVYofRDdcGFBJApyQ=; b=
	Jz5ZPshBdrZCQYuX1RhsUapyPlbFoakvlWav3fE/lqaIKVkLZut/px1H1nX12G9v
	uZrhPg2yikeTL+nblBCM5LUOGQkLhjAz3Tq+uuHbpZNsYHcp9r2M1Q6qEPC+aWtr
	Fuy6vV+MO3jjFivlD1XVI0/xehlYVmp1la1x2j9Ah6yeXMoEMFcHgSlTl83tHGZ0
	Io7bezrWmgnkCl/qOQbbVGq8PjSrnK/5KqawuRZ2NbtyOfKvEjcWOpkrNEsOtwla
	zlBg20/LHhD5HwhqgEn+EcUtXFEzoGp/ipDnaznNhhiFd5WDp/YJqLlaDCVCdb61
	cl+5Fm4siboipOFPXb2Ifw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757079496; x=
	1757165896; bh=ajaiFkBKHUpinaUmnFNbUuyFwIiVYofRDdcGFBJApyQ=; b=Z
	ivVBJnVhIE5ja8zWioMPW9wY/OFE869pMGEQYKgDyLpgycSGacsosp8F/PwK1lFq
	jLmq0KhKp1GsWxzi8nqy/bAuZ4+W+Xyn6sSIhitFrCwLDrolEhY7v/PxVZFj2aZK
	f8FKWC9TGFspfKufUg9uXWpUIC0blgilBP80xuNkWhWiEiUEyEyDKDdp3Nx1KlUc
	+VklWegQ7TcG9vmJcTAqHHhm/Gh59IOSDslIc5sQUbArwxp85HsLg+GDAYzdaJS1
	cMPou5Lzvvoim7xjly8vAYod8IOj4RFLFRKOjmei50OxE1tpHiuQyTLmKDvNcyYU
	OtNKb7IZJeEzlDSYe4GXg==
X-ME-Sender: <xms:x-e6aLy6FC3wEbtDb8qvOnEhlkde1M5LEIvFXXsIibZ7vPcE7YgHVg>
    <xme:x-e6aD7ay1_ykSfyMtBzYcj3ZkfYBs29NNqnXSlaGsZCU74PjaZAZZhP5bd8nbkVj
    bixm3WyflHcyQZBrw>
X-ME-Received: <xmr:x-e6aAdwmTtVNlTdV3vzu7F4xMS-rukS2g-F4uKEY8CsK5dG5P79aLz4y7DLcRHpPzWBjbYqXWnOneYeUqhXpxsHx6-Tso6SWgMlQE4wyrEG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeltddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopegtsgesvdehiegsihht
    rdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhhhrgduleelfeeslhhivhgvrdguvg
X-ME-Proxy: <xmx:x-e6aKEHGq4Na5bBnX8PY4MAN276OjgHhTejrV8iIGQQujfDBC56tQ>
    <xmx:x-e6aA5FD97463nPSwYRbolRxbCKvhdvMjDII-0M4mkVAVOqx8BHLQ>
    <xmx:x-e6aNuCxCUjoKmePwgwzs3AXMFH_PlHQ3Tkb-hkA2f1ZPE5_Qal7w>
    <xmx:x-e6aE-3pg0zOm9NjnPAWWrrIharE--yET6fpw99MKZH4vuejHPK5w>
    <xmx:yOe6aPUBX34kThSCPvR1bBtDtTprK-6vdI-lnlza4_wYE02M9VfJkY4U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 09:38:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90a938b5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 13:38:12 +0000 (UTC)
Date: Fri, 5 Sep 2025 15:38:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
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
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming
 mandatory
Message-ID: <aLrnwOGKaAjLj0Bo@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
 <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>

On Fri, Sep 05, 2025 at 02:45:46PM +0200, Matthias Aßhauer wrote:
> On Fri, 5 Sep 2025, Patrick Steinhardt wrote:
> > Over the last couple of years the appetite for bringin Rust into the
> > codebase has grown significantly across the developer base. Introducing
> > Rust is a major change though and has ramifications for the whole
> > ecosystem:
> > 
> >  - Some platforms haven't yet been able to implement a Rust toolchain,
> >    even though it is possible in theory.
> > 
> >  - Some platforms don't have any support for Rust at all.
> 
> What's the difference between these two kinds of platform? It should be
> theoretically possible to build rust tooling for all of them, right?

The first platform is something where Rust just hasn't been wired up
yet. This involves for Cygwin, or the Darwin ports of Gentoo's portage
tree. Rust is available for those platforms in theory, but in practice
it's not there yet.

The second platform is where there is no Rust compiler available at all.
So for example NonStop, Intel Itanium, Alpha.

I'll try to clarify this in the next version.

> > diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> > index f8d2eba061..dbb15b6a57 100644
> > --- a/Documentation/BreakingChanges.adoc
> > +++ b/Documentation/BreakingChanges.adoc
> > @@ -165,6 +165,42 @@ A prerequisite for this change is that the ecosystem is ready to support the
> > "reftable" format. Most importantly, alternative implementations of Git like
> > JGit, libgit2 and Gitoxide need to support it.
> > 
> > +* Git will require Rust as a mandatory part of the build process. While Git
> > +  already started to adopt Rust in the Git 2.52, all parts written in Rust are
> > +  optional for the time being. This includes:
> > ++
> > +  ** Subsystems that have an alternative implementation in Rust to test
> > +     interoperability between our C and Rust codebase.
> > +  ** Newly written features that are not mission critical for a fully functional
> > +     Git client.
> > ++
> > +These changes are meant as test balloons to allow distributors of Git to prepare
> > +for Rust becoming a mandatory part of the build process. There will be multiple
> > +milestones for the introduction of Rust:
> > ++
> > +1. Initially, with Git 2.52, support for Rust will be auto-detected by Rust and
> 
> Support for Rust will be detected by Rust? Should that say "by Meson"?

Ah, yes.

> > +   disabled in our Makefile so that the project can sort out the initial
> > +   infrastructure.
> > +2. In Git 2.53, support for Rust will be made mandatory in case Git is compiled
> > +   with breaking changes. Breaking changes can be enabled for Meson by saying
> > +   `meson configure -Dbreaking_changes=true` and for Makefiles via `make
> > +   WITH_BREAKING_CHANGES=YesPlease`. It will still be possible to compile with
> > +   breaking changes, but explicitly disable Rust.
> 
> Mandatory, but not mandatory? opt-out?

True, this reads a bit awkward.

> > +3. In Git 2.54, both build systems will default-enable support for Rust so that
> > +   builds will break if Rust is not available on the build host. The use of Rust
> > +   can still be explicitly disabled via build flags.
> 
> I assume you mean that we will default to building with Rust, even when
> building without breaking changes, but I feel like the wording could be more
> explicit.
> 
> Assuming packagers read this when 2.52 is released, 2.54 would give them
> roughly 16-26 ish weeks of a heads up, assuming our typical 8-13 week
> development cycles.

Ok.

Does this revised version of the plan read better to you?

    1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
       disabled in our Makefile so that the project can sort out the initial
       infrastructure.
    2. In Git 2.53, support for Rust will be enabled by default in case Git is
       compiled with breaking changes. Breaking changes can be enabled for Meson by
       saying `meson configure -Dbreaking_changes=true` and for Makefile-based
       builds via `make WITH_BREAKING_CHANGES=YesPlease`. It will still be possible
       to compile with breaking changes, but explicitly disable Rust.
    3. In Git 2.54, both build systems will default-enable support for Rust even
       when breaking changes aren't enabled. Consequently, builds will break by
       default if Rust is not available on the build host. The use of Rust can still
       be explicitly disabled via build flags.
    4. In Git 3.0, the build options will be removed and support for Rust is
       mandatory.

> > +4. In Git 3.0, the build options will be removed and support for Rust is
> > +   mandatory.
> > ++
> > +You can explicitly ask both Meson and our Makefile-based system to enable Rust
> > +by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
> > +respectively.
> > ++
> > +The Git project will declare the last version before Git 3.0 to be a long-term
> > +support release that is maintained until alternate Rust backends like gcc-rs are
> > +able to build Git. The Git project may need to rely on distributions to help
> 
> Do we want to commit to promising support until gccrs is ready? What if
> gccrs ends up abandoned? Or takes an unexpectedly long time to reach a stage
> where it can build Git? It might make sense to give this LTS release a time
> limit instead, or in addidtion.

Yeah, I wasn't quite clear on that one, either. An alternative:

  - We will maintain the LTS release for 8 release cycles, which equates
    to roughly two years. It sounds like a lot, but recent security
    releases have stretched quite far into the past.

  - If there are still dependents after these two years we will hand
    over maintainership of the LTS branch to dependents. So they will be
    responsible for the backporting.

This really only is a suggestion though. I'm especially waiting for
Junio's feedback here to see whether he thinks that this is a reasonable
thing to do.

Patrick
