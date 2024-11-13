Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A724200BB7
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504571; cv=none; b=gzEo0M/L8gVtKH5yeE9Dsm1BJmSoBNPIPQ+MZBYO/DP64HQDHzPD2sTtJFEGIYMtNhCrU3lTBPuaZ38xPql8OvbbKQo1iPC2FTA9E5PerH7kxIXgfAFYcDF/mwyYv0p+aYFUmEDfzgHxiIhTV8R3u/0BDEBXn5PF/VM/Z2QkcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504571; c=relaxed/simple;
	bh=IVf4cn/dBFiJP0mQUT3ImaWo80HEd7dpUfcoQFL7uqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQxOt+uG9qHIO0t3jBaiUBHW+prx7RiTMDxTtqU1AmvlUtyLcfK35uwkySjKvjbOSpoIWAj97O34Ln40PMEADrsDT5ulF84kNTA3jjxRmDIUyzYlq2TLR5a4mzrOJpHps3vidJwQRjDJx2xRp6Nl3FbYBKUEXzIgpqTzQ6XG3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ciXXzEID; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFKiClce; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ciXXzEID";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFKiClce"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38E7A11401E4;
	Wed, 13 Nov 2024 08:29:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 13 Nov 2024 08:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731504568; x=1731590968; bh=hBHy27/KnA
	Z35QHJ4/gSA7pWn+MurZk3TrYYMcRlhEM=; b=ciXXzEIDjb0KXFQ6OY78Kp40BE
	tY8qsTDeZPQILaw0GxqDcww0J4/TtqqS2YapBe0A6EbmwNqG4k4NjMrR4rpO4CET
	bY81Ust6iQeiz7qqILzoUaleAeGPtWFmoDCxDeSITPCBE1fm+kW7RUoZkBBJWmRE
	d9E9DwhZXs0uhCQQFSIl/VYA/lXkwuLQXt0wqb+JUugjeP8nf6U8yNdHCtrBj7N9
	SJimYvcI6WvY6w1bNv8sSjev0JPwKBsHhswDDSAzXh2f2FSHtX/DQ2PzVpekpZDd
	+8hcmvRXxGS51/+wkNVmyXhUfyCFsvu7MKVY4/YzXb5aBScax+mfPzujd9ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731504568; x=1731590968; bh=hBHy27/KnAZ35QHJ4/gSA7pWn+MurZk3TrY
	YMcRlhEM=; b=PFKiClce6jR9fKSilCEJVn9kBYc4Lb4xkfE9LjKkATGHNw85xl3
	O4HepaEW1bkJkSB4b3wb+UW03Rfe2ZpbdrNmSh/YA40PZ3CqdddrRO2p6qdqeH5g
	VwNwxC0x2nQdrseQdc6egwleyROIvB1q+mm0rS1l5Xqbz97p33PXM1qwo5gDshzq
	QI41Za5ETJseUWQdk60L3JSLxrZH4Z13alQCbFicXidWjDkIujGDmlW+75hjyFci
	nKlJnWiMrToWWe71yoZG6dYwkS79EwZFFDue84m2QXO97Yv5RqFNnrs6wb3tXVaz
	+Bf8KY/vUZa2WPtV5qOCI7Eor83Tez6S6Zg==
X-ME-Sender: <xms:t6k0Z7SCD1hNPyMOq8uA5p_IjXHwaFcMu63mjZJPKDpxmZH5wVnYVA>
    <xme:t6k0Z8x67ksg0bZWz5KNsMzHemnj_xeGnOI4HJ06Y1x_X2daW1JDxCGy8fMNaPx7T
    JoyiQWRKEdzuKqyqw>
X-ME-Received: <xmr:t6k0Zw3pTaox7CGNbfhOqENg-lSpClF3nVlTZHSzHQTZ6fxR7-OFG15-7YzxKSuk-JQvNllCphI-gEeG5fePtYZPCjCz2SVK0hMzPU_VAFYDCf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpefgudfftdejgedulefgtdejffekjefgteeukeegueekueev
    gfeiffehtdetudfhvdenucffohhmrghinhepmhhuohhnrdgsuhhilhgupdhmvghsohhnsg
    huihhlugdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
    pdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtph
    htthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:t6k0Z7BUbeV-gaWw0_PA8hQDj-zmMyzK0HTs8W-SD5Th6PTX1kQJhg>
    <xmx:t6k0Z0jzJtjifnLJIlxrfM5MJfmjSbZQAPuCip5czDF77m8u_1IOGg>
    <xmx:t6k0Z_rhbj6TLxfgBIzn3WGHllvkTWXH9_XQBHAYgiKb2jvdT9jmsA>
    <xmx:t6k0Z_hkUsU6LKQxWpsK5QKAtpRIAUfr461HFPoms5qhKPmzdj8Ffw>
    <xmx:uKk0Z3MBQZg9KKsELxqtRqPP1BKpwUCtf_olKDprOOhR34_ENDY6YQmA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 08:29:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 932cd54a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 13:28:47 +0000 (UTC)
Date: Wed, 13 Nov 2024 14:29:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: David Aguilar <davvid@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZzSprTl5Z3uIx0_d@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im>
 <ZzRvsOeLsq3dJbGw@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzRvsOeLsq3dJbGw@gmail.com>

On Wed, Nov 13, 2024 at 01:21:52AM -0800, David Aguilar wrote:
> On Mon, Nov 11, 2024 at 11:36:34AM +0100, Patrick Steinhardt wrote:
> > On Sat, Nov 09, 2024 at 04:58:56AM -0800, David Aguilar wrote:
> > > That said, if we mean, "Linux/Unix-savvy New Contributors," then
> > > I can understand why Meson might be a favorite, and perhaps this
> > > might be the crowd we are looking to target [...]
> > 
> > My goal is to not only make things easier to use for Linux users, but
> > also for users on other platforms like Windows while also catering to
> > the typical developer of Git and making the solution for them as tasty
> > as possible.
> > 
> > I agree that CMake is a tad easier to use and set up on Windows, mostly
> > because it is directly integrated into MSVC. But I also think that CMake
> > is a harder sell towards the power users because it is comparatively
> > hard to maintain due to its somewhat arcane syntax, implicit variables
> > and things like this.
> > 
> > So I'm basically trying to find a good middle ground where all of the
> > respective target audiences get benefit:
> > 
> >   - For Unix devs I think that Meson is easier to maintain and use
> >     compared to CMake. We also get nice features like out-of-source
> >     builds, good integration with the test suite and easy integration
> >     with IDEs.
> > 
> >   - For Windows devs we have an officially supported way to build Meson
> >     from MSVC and co. Also, subprojects allow us to have as easy story
> >     for how to build Git without preinstalled dependencies, which is not
> >     currently possible with CMake to the best of my knowledge.
> > 
> >   - For packagers I think that Meson provides better discoverability of
> >     options than CMake.
> > 
> > So Meson may not be the perfect solution for everyone of these target
> > audiences, and better solutions may exist to cater specific needs. But
> > it provides a net benefit for every single one of these audiences from
> > my point of view. And when taking the benefits for all target audiences
> > combined I think that Meson provides the bigger win compared to CMake.
> 
> Thanks for clarifying. Not that it matters, but you've convinced me.
> Constructive criticism follows below in the hope that it can help you
> further harden the arguments for Meson.

Very happy to hear!

> > > > Patrick Steinhardt wrote:
> > > > >   - Packagers. This is another group of people that would benefit from
> > > > >     my point of view. This is mostly because Meson has certain standards
> > > > >     for how to approach problems, and thus the packager would know for
> > > > >     how to handle things. They don't have to manually track build
> > > > >     options and changes thereof, as these can be easily discovered and
> > > > >     because Meson will error out in case invalid options are passed.
> > > 
> > > CMake's option() variables and its GNUInstallDirs module pretty much
> > > handles all of the standardization that packagers are looking for on
> > > this front, so this argument doesn't push the needle towards Meson over
> > > CMake from my perspective.
> > 
> > I think that discoverability of Meson is way better. Here you can simply
> > say `meson configure` and it provides you a nice list of all options
> > that are available. For CMake it always used to be a big pain.
> 
> The pain of discovering options with CMake is true in the general case.
> 
> A specific project can enforce conventions so that all option()s are
> specified at the top of the main build script or a designated file
> specifically for options. That would trivially make the options easily
> discoverable in that there's only a single place to look, but that's
> nowhere near the rigor that Meson enforces.
> 
> Following a sensible convention is why I didn't originally vibe with the
> argument that option()s are insufficient, but that would merely be one
> project's conventions and is by no means a universal practice.
> 
> Elsewhere in this thread it was also mentioned that unknown options are
> blindly accepted by CMake. That's actually not true.
> 
> While it's not as rigorous as Meson because it doesn't error out by
> default, CMake does issue a warning when you specify variables/options
> that are not used by the project. IIRC this warning can be made into an
> error by using the "cmake -Werror=dev" option, but I appreciate Meson
> taking the stricter route as it results in better overall usability.

Ah, fair enough, I remember seeing these warnings myself. As you say, I
also prefer being as strict as possible, as otherwise it is so easy to
miss the fact that a build option has been mistyped, removed or renamed.
The warning helps the dev if they pay attention, but especially in
automated systems I'd expect it to go unnoticed quite often.

> > > > Taylor Blau wrote:
> > > > I appreciate your thoughtful response to my concerns here. Please feel
> > > > free to correct me if I am wrong, but I think the bulk of your argument
> > > > is captured fairly well by these three points, so I want to focus my
> > > > response here.
> > > > 
> > > > Responding in turn, I think my feeling is something like:
> > > > 
> > > >   - Long-time Git contributors are going to be the ones who will most
> > > >     frequently use the new build system. I am definitely sympathetic to
> > > >     getting too comfortable with our existing tools, but so far in your
> > > >     response I have not seen a compelling reason to switch the project
> > > >     to use Meson.
> > > 
> > > Likewise, I have not seen a compelling reason to not focus the
> > > effort on CMake instead. In other words, why not enhance the current
> > > status quo (Make + CMake) instead of trying to replace it?
> > 
> > As mentioned above, I mostly think that Meson makes for a more
> > compelling overall package. That being said, if we eventually come to
> > the conclusion that we as a community want CMake instead of Meson, then
> > I am willing to go there.
> 
> I hope that's not where things land because the separation of
> configuration vs. build steps does provide a benefit in day-to-day use
> (specifically, faster incremental builds) due to the clean separation
> of the configuration and build steps.
> 
> It seems like it would be nice if the Meson build were eventually
> hooked up so that we can continue typing "make prefix=... install"
> (perhaps through an opt-in "enable meson" variable) and the Makefile
> would handle driving Meson + Ninja, but that's probably an untenable
> feature given the complexity of the current Makefile.
> 
> If the Makefile were completely replaced one day then that would be
> a nice to have, but it would probably be a bad crutch because the
> natural tendency would be to shadow all of Meson's options behind
> Makefile knobs. Encouraging users to just run meson directly
> seems like a better overall situation. Bisecting is the only
> reason why something like that might seem appealing, but
> I probably wouldn't push for it myself and maybe there's a better
> way to handle that when we cross that bridge.

In theory it is of course possible to have a thin wrapper around Meson,
but as you say it'd likely be a bit more on the painful side to write.
One could be pragmatic and only map the most commonly used options and
otherwise let the autodetection of features do its thing, which could be
good enough for bisectability.

On the other hand I don't see that our Makefile would go away anytime
soon. I would eventually want to remove it so that we have a single
build system, only, but I'd think that the timeline here would rather be
a year or two before we do so. So maybe that reduces the need for such a
mechanism.

> > > >       * New contributors do not interact with build system internals
> > > >         nearly as much as more experienced contributors. I would imagine
> > > >         that the vast majority of those interactions are simply running
> > > >         "make" or "make test".
> > > > 
> > > >         You mention a handful of other niceties that Meson provides,
> > > >         like language server support, but I am not sure that I agree
> > > >         those are (a) the responsibility of the build system to provide,
> > > >         or (b) that those needs aren't already well met by the vast
> > > >         number of existing tools and IDE integrations that can work with
> > > >         ctags.
> > > 
> > > CMake has all of these same bells and whistles, and it's already present
> > > in git.git. LSP support just means being able to generate a
> > > compile_commands.json file, and the current CMake setup already does
> > > that.
> > > 
> > > The one thing that no one has mentioned is dependencies.
> > > 
> > > CMake has less dependencies. Python is arguably a liability in the build
> > > system arena, and Meson requires it.
> > 
> > Eli has menitoned [muon](https://muon.build/), which is a drop-in
> > replacement for Meson written in plain C99. I don't know whether it is
> > currently able to compile the Git project, but if this is going to be a
> > concern for people I can try to make sure that it does.
> 
> Thanks both for confirming that muon is a viable alternative.
> 
> Elsewhere in this thread packaging metadata for CMake was shared
> arguing that CMake also has many dependencies. A subtle nuance there
> is that those are all either optional dependencies (e.g. Qt for the GUI
> parts) or they are dependencies that can be optionally supplied.
> 
> You can build CMake without those dependencies installed and CMake's
> vendored versions will be statically linked instead. So, from the
> perspective of wanting to go from 0 to 100 with just gcc/g++ installed,
> CMake has less dependencies. This might be slightly disingenuous because
> CMake vendors its dependencies and distros have to opt-in so that they
> can supply their own versions, but the main takeaway is that GCC is all
> you need and that's what I meant by, "less dependencies."
> 
> This is a moot point for most users, though, and it's even moreso moot
> if muon compatibility can be maintained.

Fair. I don't really expect anybody to use the combination of muon/sumo
for everyday work, mostly because the usability is not quite up to par
with Meson/Ninja. But there are two use cases that I deem important:

  - Esoteric platforms that may not have Python available. I don't know
    whether there actually are any relevant ones, but with muon/sumo it
    is possible to support these.

  - Bootstrappability, which I think is rather critical for a project
    like Git that is at the core of the whole software ecosystem.
    Depending only on a C99 compiler and a shell is a huge win here.

A bit of an anecdota, but CMake itself for example struggles with this
quite heavily because it has dependencies that use CMake themselves. So
it is nice that there is a clear path for bootstrapping with Meson and
thus Git.

> As to why I consider Python a liability ~ this is more of a concern for
> Meson and it doesn't really matter for end users, but Python has a
> proven track record of making breaking changes.
> 
> If you're building everything from scratch with new versions of
> compilers and tools then the C++ project is the one that's going to
> build just fine a decade from now with little to minimal effort.
> Python doesn't have that track record.
> 
> Even though CMake is written in C++ (which is unacceptable for some
> projects), this is subjectively one advantage that CMake seems to have.
> This is a moot point, though, and perhaps Python will eventually reach
> this same level of respect for not introducing breaking changes.
> 
> Furthermore, I suspect that most contributors are simply going to
> "apt install meson" or "brew install meson" so it's not really that much
> of an issue in practice for the majority of users/contributors.

Agreed.

> > I'd honestly be sad if we go down the CMake route, mostly because I
> > think that it is an inferior build system compared to Meson. I have
> > worked with it extensively in the context of libgit2 and always found it
> > to be a pain due to its esoteric syntax, the use of so many implicit
> > variables, platform CMake policies, and there being so many ways to do
> > the same thing and, where the easiest solution is typically the wrong
> > one to pick.
> > 
> > That being said, I'm trying to be as pragmatic is possible: my main goal
> > is to have a modern build system that is easier to use. So while I think
> > that Meson fits better into that role, the next-best thing would be
> > CMake from my point of view.
> > 
> > So I'll continue to champion Meson, but if the project as a whole agrees
> > to take up CMake as another official build system then I'll adapt and
> > make that happen.
> 
> I agree with you. Meson looks to be a technically better option.
> I kinda wonder how many folks are actually using the contrib/ CMakeLists.txt,
> and whether this effort would be helped by retiring it sooner rather
> than later?
> 
> Would it be worth adding a canary to the CMake build that forces it to
> fail to build unless "cmake -D ENABLE_DEPRECATED_BUILD=ON" option is
> specified?
> 
> It could error out with a message telling users to reach out to the
> list alongside the hint to specify the option if they just want
> to get a working build.

I think it's still a bit too early to think about the actual deprecation
road -- before removing things I want to connect with any stakeholders
that use the old system and figure out whether I've got everything
covered that they need. I know that Johannes for example uses CMake
extensively, so I will make sure to connect with him before proposing
its removal.

I've also shifted my thinking a bit: instead of removing CMake as a
first step I'd like to remove the autoconf code. It is known to be
broken in many situations and there is only a very small set of users
out there. So replacing that with Meson would be a good first target
from my point of view.

In any case I don't want to negatively surprise anybody, so I am of
course very happy to discuss the roadmap here and will work with anybody
who has needs that I haven't addressed yet.

> On a rather low-powered machine here are some timings:
> 
>     $ make clean
>     $ time make -j
>     181.36s user 15.35s system 99% cpu 3:17.33 total
> 
>     $ ninja -C build clean
>     $ time ninja -C build
>     11.23s user 4.67s system 47% cpu 33.605 total
> 
> 34s vs 3m17s ~ nice! That's also surprising.

Awesome!

> That large of a difference is not explained by the extra
> probes done by the Makefile; a no-op incremental build is 0.5s for
> Make and 0.02s for Meson so the Makefile probes seem to only account
> for at most 0.5s.
> 
> Is the Meson build simply building much less, and that's why
> it's currently so much faster?

We don't build documentation by default and don't have gitk wired up,
but other than that the builds should be mostly equivalent.

> Or.. is it because I have "sccache" installed and Meson automatically
> uses it? "ninja -C build -v" confirms that it's using sccache and
> "make V=1" does not, so maybe that's why.
> 
> How do we disable the sccache usage?
> "meson configure build" doesn't seem to list anything related to
> caching, but it is really nice seeing all of the other options in one
> place.

Yes, Meson knows to pick up sccache and ccache automatically. [1]
mentions that you can disable this by setting the compiler explicitly
via the CC environment variable.

[1]: https://mesonbuild.com/Feature-autodetection.html#ccache

> Improvement in build time seems like it could be something that sways
> long-time contributors towards Meson. It is pretty nice that it
> automatically picked up sccache in my $PATH and automatically gave me
> those speedups.

True.

> > Thanks for your input, highly appreciated!
> 
> Thanks. I don't want to be the CMake champion, so here are a few
> helpful/surprising details about the Meson build to help make it better.
> 
> 
> (1) I first built w/out having "curl-config" installed. I was surprised
> to find that "ninja -C build install" ended up installing "bin/curl" and
> "bin/curl-config" into the prefix.
> 
> Is there a way to have the install step only install Git without
> bringing along these other non-Git bits?

It definitely shouldn't install curl and curl-config, I'll have a look
at that. But other than that Meson is currently set up such that it will
automatically fall back to the subprojects in case certain dependencies
cannot be found. This can be disabled via `meson setup --wrap-mode
nofallback`.

> (2) There seems to be a difference in how symlinks and hardlinks are
> handled in the install step.
> 
> Running "make prefix=$PWD/dist install" ends up with real files in
> dist/bin/ (hardlinks) whereas with Meson all of the files in the bin/
> directory are symlinks into ../libexec/.

Yup, that's documented as part of the commit message that introduces
Meson as one of the main differences.

> (3) Not all of the same files seems to be getting installed.
> 
> I don't see bin/gitk or bin/git-cvsserver when building with Meson.
> 
> The share/git-core/templates/ directory is missing completely.
> 
> git-gui and its related files are missing. Perhaps this is
> intentional/todo at this stage and hasn't been added yet.
> 
> Meson installs bin/git-http-backend (symlinked to libexec)
> but in the original Makefile this file only exists in libexec/.
> 
> The contents of libexec/git-core/ seems to be missing dozens of
> files compared to the Makefile build.
> 
> share/perl5/ has a bunch of extra git-{cvsserver,send-email,svn,...}
> scripts so perhaps this is where some of those files went?
> The Makefile places these files in the libexec/ area instead
> of in the share/perl5/ area.
> 
> The Makefile does not install share/gitweb/static/js/.
> Instead, it seems to mash everything together into a single
> share/gitweb/static/gitweb.js file which Meson does not install.
> Meson installs separate files in the share/gitweb/static/js/ area.
> Was that intentional, or is that just another todo?

gitk and git-gui aren't currently wired up. All the other ones I'll have
a look at.

Thanks a lot for your feedback!

Patrick
