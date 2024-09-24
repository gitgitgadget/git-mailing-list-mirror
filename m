Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EE1A7065
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180009; cv=none; b=diJeEj3vfZGXMbbxJ+klJebvZXAD3Vo4PlR8iPFVfZ4xEZEGakWgaLMa2tsQGTXMIq/tF8RJ+nSv1OxZ0lvDaNaW3aW7w3dg0a+6rkb+xpauzXS8qXGYxAG5wp0AnJ6colbZ8GSp5r+Ea4fil0+7R6Hw1Ck+AWdhUITYW+VVVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180009; c=relaxed/simple;
	bh=TPPrCXB0vglREvN4cZ+OEyo5LU9qR4zCTiNeJ44rPn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOg29vaoWySlGbAhoV7HGbCZl95D9UyaDqSazgsRHb0WQV03a0ZL5CIDf/BAEc477gBp2lhshIhZUtU8JUDGp3XD0rinpiuQUw0WqV1ZLrotdHEsepyOi5uappcunlrr79022iLzmPIccLHhZBKUAU8FZUTFAmy46J2GzQ7KDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h+SSYiB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AWo0FWcI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h+SSYiB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AWo0FWcI"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 853AE11401DD;
	Tue, 24 Sep 2024 08:13:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Sep 2024 08:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727180005; x=1727266405; bh=SsSLZlK1L0
	9y4ayCPz20BjxEjy9VZwn8P4gNgZgZ/p4=; b=h+SSYiB8z2bu2CEtcNrZ1sS8ea
	aTqM9GohJO6qVHw/BTD7YE+BxR5V0NqGJ7kzsQjTdUthggrw3Pm+vzZ3ltDPxgMJ
	/YAzVxnIgQg2A+rf4jZfLG49I2wWTtAWIVjOZgkmYUsmvxWzSb7I2bBXVfgyc408
	hI7i8ivwtfBjBqdReJUI1U/3WiuQd6t+njrZIg/mdrIlf4PJLWbfJOMG7VgbgGLg
	XUxskWSSP3D1EpjKEe8VznGpw9st6SlerBo6y4wqraDcHesc6rJUtVIGuXYKWgYw
	GaffJUcv2amnuF7PF9orvesrEnphFMmmYh+Cv1aytFDNyvWh26Qldd1kFPcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727180005; x=1727266405; bh=SsSLZlK1L09y4ayCPz20BjxEjy9V
	Zwn8P4gNgZgZ/p4=; b=AWo0FWcIggktrn5ZpMYX4cG3JqxVD64+or8KJmmTZ5Va
	+L3yVgXCBBWcn5vaATapIbl/QhHGZnCqpggjqRFXcwJTb7YilanGRO3524htd7NW
	XTx4gF4riC7vuY6EIG+Wmx8VkTYfIJ03P7G9A0r1gSuU/i37wSmZkPGCFgT7edhs
	EGeIePw40did3Zs3xwnq0bySuYLCqWhawgPDnUGhVCSUqIrIaEQWPt00CiZUVfgW
	dqZQS1+I6lGTMP3t3CmRTdycacpPVOszHRREzJy7QlQvhZ85Zl1o9V8k6XSvtoQA
	tanqA89WKB06wbd0oubZ4CM9yHL9TBE+S5igghx+gA==
X-ME-Sender: <xms:5azyZiLyAuUKdx9lYghAX5F7vPSj1l40oWXbtxI5T8ccT0D7SiAzdg>
    <xme:5azyZqLAGSPQtDpMg_kIUN-LN6xF0CxqFj8xNgvzy9F6EWBnOKJjrT-knRMzyLVdz
    -HMKyDVZ7o38riCVQ>
X-ME-Received: <xmr:5azyZivpwB2xXYFbPN_vpeHbVF2vy-Qpob6FbY7ExKtRWimViWWKLVi2LZzqOEQZF-Dyb9eZ25XvbnMTFMFEWvs_2phabd-Ub4nDv7EahfQ5iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigr
    rhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:5azyZnZVJ39x5CtcCW8U3sqsFL3e_ORS5GI039caHYhjOCxgzpsnrg>
    <xmx:5azyZpYrk9MVywojg4Z_wtlRGhziZQjLQHi6wD9Fl1YkC-NFCYCx6g>
    <xmx:5azyZjDvABK-DWXKDoKKCCs7ihr3wQIO5D-xRK-jI9UaJQbRAjmb-g>
    <xmx:5azyZvaIKBS0QbgQEZFx1smmotL8696anPxllFOFIN6v79MzRBHhRg>
    <xmx:5azyZtEKRi40I9YYzWuyqNVGcnCHVKXhLhatGjkXXgV7sw4W98xO9bZS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 08:13:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b6326e05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 12:12:50 +0000 (UTC)
Date: Tue, 24 Sep 2024 14:13:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [TOPIC 08/11] Modern Build Systems
Message-ID: <ZvKs6BrX-Ht7sFJN@pks.im>
References: <Zu2DmS30E0kKug2a@nand.local>
 <Zu2E3vIcTzywWOx3@nand.local>
 <0864bd25-d5c4-45ac-a59e-e6f7d24002de@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0864bd25-d5c4-45ac-a59e-e6f7d24002de@gentoo.org>

On Sun, Sep 22, 2024 at 10:01:32PM -0400, Eli Schwartz wrote:
> On 9/20/24 10:21 AM, Taylor Blau wrote:
> > Modern Build System
> > ===================
> > 
> > (moderator: Patrick; notetaker: brian)
> > 
> > * Patrick: three different build system; should get rid of at least one
> >   of them
> >   * Should delete autoconf because it's not really maintained
> >   * Think about a proper build system
> >   * Obvious choice: cmake
> > * Taylor: What's the problem with Makefiles
> > * Patrick: Non-standard
> >   * Meson is nicer than cmake as an alternative
> 
> 
> I suppose I'm pretty biased but yes, I do feel we (meson) have managed
> to make some great workflow improvements here. :)
> 
> Please do feel free to ask me questions about it.
> 
> 
> > * Jonathan: xz compromise shows autoconf is a risk
> > * Autoconf isn't a problem for distro
> > * Taylor: distro builds that can't handle "make" without configure are a
> >   distro problem
> 
> 
> Anyone can handle "make" without configure without breaking a sweat,
> that isn't even remotely challenging, and every distro already does it.
> The problem is that "make" is stateless, which is another way of saying
> it has amnesia. By that token, everyone cobbles together their own state
> system on top of "make".
> 
> Admittedly, once set up it doesn't require much maintenance from version
> bump to version bump.
> 
> 
> > * Jonathan: Modern build system can reflect the structure of how your
> >   code is set up
> >   * Declared dependencies
> > * Brian: Rust will make the decision for us: cargo
> 
> 
> I would just like to note that this is not really true. There is one
> other build system that supports rust and its name is... meson. :)
> 
> Meson supports rust as a language for creating libraries (cdylib or
> rlib) and executables. You can import a crate from crates.io and meson
> will synthesize the build system from the existing Cargo.toml to expose
> it as an rlib dependency.
> 
> You still get full build script option parsing, system probing, control
> flow etc using the meson.build DSL, you can freely mix libraries or
> executables in any of meson's supported languages (C, C++, Cython, C#,
> D, Fortran, java, ObjC, Rust, swift, Vala...), process custom commands
> for data files, run gettext on translations, and more. Meson is designed
> to be a polyglot build system in ways that cargo will probably never be.
> 
> Cargo is probably best thought of as a compiler wrapper: it can spit out
> an executable if you run it on *.rs sources, but it doesn't replace most
> of the interesting parts of a build system and it doesn't even provide
> an "install" rule. No, `cargo install` does not count unfortunately as
> it has a nasty habit of recompiling the binaries you already compiled,
> but now with the wrong options.
> 
> You really want something that provides a project lifecycle workflow for
> building, testing, installing, and making dist tarballs with integrated
> distcheck. The current Makefiles mostly kind of work, given sufficient
> care, but cargo provides exactly zero of anything so you're back to
> cobbling together your entire workflow using Makefiles wrapped around
> cargo. I would call that the very furthest opposite from "make the
> decision for us".
> 
> 
> >   * BSDs use Make (granted, not GNU make) for building
> > * Patrick: Is anyone else in favour of a proper build system
> >   * Ninja is way faster than make to build the projects
> 
> 
> It is! Yes. Mostly because it does very, very little other than execute
> a precalculated build graph, whereas the current Makefile runs a bunch
> of stateless external commands each time in order to calculate top-level
> Make variables.
> 
> 
> > * Taylor: Feels odd to build with a fancy tool that might have a
> >   dependency on Git
> > * Dscho: --help is a autoconf feature and removed features are detected
> > * Patrick: Isn't that an argument for cmake over autoconf? Dscho: yes
> 
> 
> cmake does not have an equivalent of ./configure --help. The best you
> can get is to try to somehow successfully configure cmake once, and then
> run a cmake command that prints every internal control flow variable
> used by cmake, then hope that the ones you care about include descriptions.
> 
> (Say what you will about GNU autotools but they knew very well how to
> write good interaction standards, as evidenced by all the Makefile
> variables git.git already uses from the GNU Coding Standards docs on how
> to architect a release process.) It is fundamental to the UX design of
> ./configure that a user may query the build system to find out what
> choices they can / are expected to make, before committing to those choices.
> 
> cmake is actively a severe regression compared to autoconf for these
> purposes.
> 
> 
> > * Kyle: Editor integration is useful
> > * brian: standard structure is helpful for LSPs
> 
> 
> These tend to mostly be solved by compile_commands.json, which most
> modern build systems can produce. In particular, anything that creates a
> ninja file essentially gets you this for free, because ninja can create
> one for you.
> 
> Plain Makefiles, and GNU automake, don't do very well at this at all,
> since Make has too irregular a build graph to reliably compute any such
> thing. Same reason why there isn't much in the way of dedicated editor
> integration (both cmake and meson have introspection APIs which editor
> plugins can use to directly query info from the build system, to provide
> finer-grained control than what compile_commands.json can do).
> 
> 
> > * Emily: libification has shown that makefile is cumbersome
> > * Jonathan: Should we do a comparison of build systems in terms of what
> >   we need from them on the list? Similar to
> >   Documentation/technical/unit-tests.txt
> >   * Patrick: I can write such a thing.
> > * Patrick: Are their any features we need to consider?
> > * Johannes Sixt: Consider supported platforms
> > * Patrick: Want to verify that cmake is up to the task by testing in CI?
> >   * Will volunteer to post something to the list

Thanks for your input, Eli, I highly appreciate it to get feedback from
a distro maintainer's point of view! I'm not going to answer here,
because there already is an ongoing thread at [1].

So I'd propose to consolidate it into that thread. I've put you into Cc
there.

Patrick

[1]: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
