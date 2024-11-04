Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9861B6CEA
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722631; cv=none; b=BZmk2R3sD/jcdqpVoL/ZOWxBf7fI/cAPLZA818/xRlp/r06dArBnK3XxFSWGwH5eIK87+TkjrUBR0JKozVNg8eo0hCVmD6G6Jy2gN7g/hFKqbgkEyukXPAeqIYNmEySM6aribmcyitX5YlOeYvSl7og2yvODlFHwfwyadfwIUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722631; c=relaxed/simple;
	bh=SUR0d6E+0cBSmcgmz/0ZMWfSrLmS0pFgkxcFRJogRqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbAXh/UeOjCUK5LgVPBi+5MwnCbhpt7Y/X11LavHPATxiWLyjvC1sZMfl5WS9JagvNdhiDDRdyjAW82UVpwvWgUw8LVrnFui1VSjTTGmD0JMvdWZxw0owjadQ8jp0h4eXTyF27OnCfiBmLBvrREFMv9/zs3McKkDWqKROQXoTcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RDExOgTm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WOMsmy4V; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RDExOgTm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WOMsmy4V"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A7E211400BA;
	Mon,  4 Nov 2024 07:17:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 04 Nov 2024 07:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730722628; x=1730809028; bh=MA3GXY9AFI
	uTrxBgs+mSgXujepu5G+wNg8sSVXusaRM=; b=RDExOgTm3QMmBJNSoW9xLU2WLI
	hkxp8O/YuWCjm/GfZZd/UCpnm3yKzlMD8tIaq2tflX3Nj6ihdonn3BCnUnB/34NK
	E7IzTkkxnQr1tnaFE1/WR0KMLBMK7iNLCigNnQg3WpeKOO2JPyqkY5XFmWPNjiQn
	c0ytt37fbrXMlxV+I5Li4dWSWy7KOQ0yoPYwKcYnEYkioc2Uya0M/G1Kkk4qq1bw
	w4qapEwl3GXd3kkCcUP4cFPF7V+UKFrHRCbWt+cYwxWAA6w/fzSIlEzGC/YWubyM
	/AbetLzNmpVMyy9tkpGvMU/jVYkP8aWAf5XKni4fMH7ACCtwu1thh3b53lCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730722628; x=1730809028; bh=MA3GXY9AFIuTrxBgs+mSgXujepu5G+wNg8s
	SVXusaRM=; b=WOMsmy4V3IcK4rSzuwOpKxRlH0ZURKyOeMSWrQNUqeag/H5Qcxi
	HojRRKHhzRO/SWJ46Exjkazu2X55TdA4HkVPeKmvjUMEjTGQdL6NlWfZ5E9H1NBy
	djgFIJAlmXCIfpjFHxxhVNmLFOmtuz67IM8C42POgX4+DX9oE2U1uhPR34L+IO1o
	2diuF54Zz3pO4eSF6zhIsE46xwPYDvXPwOeYsTB47yNNByeMlU0cKgFNOwbiHV30
	KlsQq9fvPQjrQYWpGX9xL64SV350dMyxBg8fhbIqZDtolruY323aHTO0ddfs1CFM
	InfNB0BURnFej40U7AqJOCNpou0r5GnmV1w==
X-ME-Sender: <xms:RLsoZ1uqR1iG2MffqLdYbn4mNZ0UoOaND8Fnmx4a5R-A9x4-kYslcQ>
    <xme:RLsoZ-dmazeA8icBHkODBf0E7ro8WGE9WX1jlmi0Ex2OS1HmiAm8Cy2DNEecGNbjn
    wPPkX80NJCF4howYg>
X-ME-Received: <xmr:RLsoZ4yygj25s4cnXE8RfLmQffPTZMUwS1RfIVc5JbRrQBp90ScS86UOQXhAHCzjJZq-nEQuLHVQlPX4YLTSL56izMi0v8MgjQAOyOC_XumFI5-8AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    vghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RLsoZ8M5A-MfgOsEsfNLgOxhWuajmiyuvmMYl4i9GbnUsiysXdGaHA>
    <xmx:RLsoZ1-OTCTO4P0hiIGv3L94AXub5puCyRfpcT0R7dF74w4QGsku5w>
    <xmx:RLsoZ8WU_F5lxgKxhlrk780jcD8E6AClM873vP45dWib2MMWFu8a-Q>
    <xmx:RLsoZ2fnbc3rMKOnCUXjst1p91z3r3uDSVwkdS-zNU-gc2o-N1xB5g>
    <xmx:RLsoZ-N4KBzEdcDfIvVvzQDwYKuJtHpHoVJW2IAmntHvwthQuRvFz7CL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 07:17:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c2f8dce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Nov 2024 12:16:47 +0000 (UTC)
Date: Mon, 4 Nov 2024 13:17:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <Zyi7PA2m2YX9MpBu@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxv4osnjmuiGzy94@nand.local>

On Fri, Oct 25, 2024 at 03:59:30PM -0400, Taylor Blau wrote:
> On Thu, Oct 24, 2024 at 02:39:43PM +0200, Patrick Steinhardt wrote:
> > Hi,
> >
> > this is the fourth version of my patch series that modernizes our build
> > system. It refactors various parts of it to make it possible to perform
> > out-of-tree builds in theory and then wires up Meson.
> 
> I was thinking a little bit about this topic last night and wanted to
> collect my thoughts somewhere.
> 
> I think that there are a couple of things that I'm not 100% clear or
> sold on, which are:
> 
>   - What is the eventual goal of this series? Do we plan to transition
>     the existing make-driven builds to instead be built with Meson? Will
>     we have both? Something else?
> 
>   - What is the eventual plan for CMake, which is maintained currently
>     in the contrib directory? Will it be deprecated in favor of Meson?
>     Will we continue to support it?

My goal is to end up with a single build system eventually, so yes, we'd
at one point in time drop both the Makefile and our CMake build
instructions. That would of course not happen over night, but across
multiple releases such that devs and packagers can start exercising the
new build infra before we remove it.

> Let me expand a little on each of those in turn:
> 
> == What is the eventual goal?
> 
> From reading [PATCH 17/19], it seems the main arguments in favor of
> using Meson are:
> 
>   - Ease of use: easy to use, discovering available options is easy. The
>     scripting language is straight-forward to use.
>   - IDE support: Supports generating build instructions for Xcode and Microsoft
>     Visual Studio, a plugin exists for Visual Studio Code.
>   - Out-of-tree builds: supported.
>   - Cross-platform builds: supported.
>   - Language support:
>     - C: Supported for GCC, Clang, MSVC and other toolchains.
>     - Rust: Supported for rustc.
>   - Test integration: supported. Interactive tests are supported starting with
>     Meson 1.5.0 via the `--interactive` flag.
> 
> I don't think that when reading these any of them stick out to me and
> compel me to learn a new build system. I understand and am sympathetic
> to the fact that GNU Make has odd syntax and can be cumbersome. But I
> don't think that incrementally modifying our Makefile over time is
> difficult, and it has certainly worked well over the years.

My main goal isn't necessarily to make things work better for old
timers, but _especially_ to make it easier for newcomers. You of course
can wire up many missing features with Makefiles, but that only goes so
far. What you won't get with them is good cross-platform support, deep
integration with IDEs and good discoverability.

> Certainly there is ample support for IDE integration with Make.

Not quite. While there is ample support for executing Makefile targets,
there isn't really a lot of integration for "advanced" features:

  - Auto-configuration.
  - Multiple build types.
  - Code completion.
  - Discovery of the working set of source files.

So the integration that exists for Makefiles is for most of the part
extremely shallow.

Also, I'd claim that Makefiles are really only well-integrated on Linux
or BSDs. For other systems like Windows it is extremely awkward and you
don't really have a nice developer experience there.

There are other factors as well, like auto-detection of the system. Our
Makefile only works well for specific platforms that somebody uses on a
regular basis, and wiring up a new platform requires manual code in our
"config.mak.uname" file. That's somewhat awkward and hard to maintain
going forward as every single platform requires its own bits and pieces.

The solution to that problem is autoconfiguration by detecting platform
specific bits and pieces. And we _also_ have such a build system in the
form of autoconf, but now we're entering territory that is awfully hard
to maintain. Most people don't use it at all, the only user seems to
really be distros. And they tend to hit many issues with autoconf
because we devs don't use that infra in the first place, creating a bit
of an awkward situation. Unifying this infrastructure such that devs and
packagers use the same build infra is thus another goal of my series.

> Out-of-tree builds and cross-platform builds could be supported in
> theory as you note within the existing build system. Another suggestion
> you make is that Meson has better native support for Rust, which I agree
> may be important to consider in the future.
> 
> But I don't think that any of those three (out-of-tree builds,
> cross-compilation, or Rust support) are insurmountable challenges in
> Make. Certainly there is a lot of inertia there, but I don't think
> that's a bad thing. Contributors are used to the existing build system,
> it has worked well for us, works across many platforms and has (IMO)
> stood the test of time.

We indeed can wire up all of these features. But the way things are
wired up right now is extremely fragile and very manual. I don't
disagree with your statement that we old-timers know our way around the
build system. But I certainly don't think it is easy to hack on, and
that is a problem especially if we want to set up Git for success for
the next decade. I want to ensure that the Git project is easily
accessible to people.

> I admittedly have a hard time squaring the benefits and goals we have
> with Meson with the cost of learning a new build system, and/or moving
> away from Make entirely.

I guess this depends on the exact persona you're optimizing for. There
are three main personas involved here:

  - Long-time Git contributors. I don't worry about that persona too
    much. Folks in this category tend to be highly skilled, and they
    should not have much of an issue with adapting to Meson.

  - New contributors. This is a group of people that I think would
    benefit from Meson. They get integration with their favorite IDE,
    have easy ways to discover how to tweak build instructions and can
    use standard invocations for Meson that they might already know from
    other projects.

  - Packagers. This is another group of people that would benefit from
    my point of view. This is mostly because Meson has certain standards
    for how to approach problems, and thus the packager would know for
    how to handle things. They don't have to manually track build
    options and changes thereof, as these can be easily discovered and
    because Meson will error out in case invalid options are passed.

> I am entirely open to the possibility that there is something that I am
> missing here, and that Meson really is a better choice for Git given our
> current direction. But I think if that's true, then the series needs to
> explain that more prominently.

Sure, I am happy to update the commit message.

> == What is the eventual plan for CMake?
> 
> From [PATCH 18/19], you write:
> 
> > If this patch lands the expectation is that it will coexist
> > with our other build systems for a while. Like this, distributions can
> > slowly migrate over to Meson and report any findings they have to us
> > such that we can continue to iterate. A potential cutoff date for other
> > build systems may be Git 3.0.
> 
> I don't view this is a good intermediate state, and is in my view making
> an existing problem that we have worse. On the "existing problem": I
> think that landing CMake support in contrib was a mistake. In my view,
> CMake support should have either been a first-class citizen in Git (such
> that we don't consider a change "done" until it can be built by CMake),
> or should have been maintained out-of-tree.
> 
> But I think we struck a worst-of-both-worlds balance by landing it in
> contrib. It's maintained in the tree, so people expect to be able to
> build the project with it because it comes with a bog-standard clone of
> git.git.
> 
> But despite living in the project's tree, it is not a first-class
> citizen, and subjectively it seems that we get an awful lot of mail
> asking why something doesn't build in CMake, etc. (To your credit, I
> think you have been one of the main people to help with that, often
> fixing those bugs yourself, which is greatly appreciated).
> 
> I don't want to see the project have to pseudo-maintain three build
> systems. It seems like doing so would be cumbersome, and error-prone. I
> am already probably guilty of breaking CMake builds when I add a new
> compilation unit to the project, because of a combination of my lack of
> familiarity with CMake, and the fact that we don't have a project-wide
> convention of treating it with the same care as we do the Makefile. I
> think that having three build systems (even if they only co-existed
> until Git 3.0) would make that problem worse.
> 
> I feel that if we are going to pursue Meson over CMake and/or Make, we
> should have a clear plan to either get rid of CMake, keep it up-to-date,
> or something else.

I fully agree with all you're saying here. Whatever the solution, the
new build system should be a proper first-class citizen and should be
exercised by our CI systems such that they don't silently break.

I also agree that it's going to be a hassle to maintain three (or three
and a half if you count autoconf) build systems. But I don't want to
break any users out there by dropping everything but Meson immediately,
so I think we just have to accept multiple build systems as an
intermediate step. How exactly that would look like is certainly up for
debate. My take would be:

  1. Adopt the new build system and start exercising it via CI.

  2. Drop CMake.

  3. Drop autoconf.

  4. Drop Makefiles.

This should happen over multiple releases such that every step will pull
in additional user groups, which will make the new build system more
solid overall. I could see that one step corresponds to one release
cycle, but I'm also happy to adapt the pacing as necessary.

Patrick
