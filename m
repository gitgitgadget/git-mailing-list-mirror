Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A4185B47
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321407; cv=none; b=F0yuQcTgspWr7ZeRjqLhblpQ3bBqs2+zGNFyRiL4iUVyokYOkCn+JgszzkI1jF+zMOKz8Ceb4nDwinoANHNpI/lh/s4Ynup61H0jIyL1jMQvF+/s5d20ZvgS/PEZ9CzdOOc8JG1wlVZSuf1EoWNnZZM1Rb67qTRioOa4ajxSMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321407; c=relaxed/simple;
	bh=GmDhvdHQf/3Kp7Mbd4j2ndai4TQJOEpU7H03cxmwwaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf7T+6Rki41CA5HZwGMqtfQv/mIuTPcGW6zj1amoCrwmVLanpKAMAOLMZ4s0b6JWsGJIUoDhsipBJwcG6SD2UARxSWOeqifsTZ6GHtWgxk7Rw28ep36wRShHwv6auAMjde+WF7OSBGsHXlSUtBuWuNjXiznLFRipi1/J41R9msA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L0Ompjn6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HlDlfFHj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L0Ompjn6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlDlfFHj"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CCE3114015E;
	Mon, 11 Nov 2024 05:36:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 05:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731321404; x=1731407804; bh=F96ou/SqiV
	n4rxQft4C6/9C1vxIjuV0/qe8ZAD6d9eY=; b=L0Ompjn6SiVkWa8Q90TOXHIVd2
	01khXO3fqwu4cLH7hnKuxde5FstDnnx0p/fi1L4u1/3UIxITz7O6T2CEaCYbKrOO
	yXQXusPOr1/DHpebMhTh5i7bwjFE9KhK2wlfeKTlOg7KDgrgEn9x2w6a611RqQYm
	omevU+AfKWBISo0zZ4cJ2o6OjNkwuxqvZCN7oRYlNxz27jc/g+SbCH4KLCUo5/Ao
	A59ZB2s4SRz1rbVIORa8nn6FY/YSiAXl9YXwttSN13/CC3XXJF/UHk8sqXvcj4NT
	ozmZShKAXxqd+Ff2VrmjRTMVfI2uOODMR2d05oTtff/WDchZpmhyjeXtG5uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731321404; x=1731407804; bh=F96ou/SqiVn4rxQft4C6/9C1vxIjuV0/qe8
	ZAD6d9eY=; b=HlDlfFHj3aVJPUUl3tk27jxh9mG+n5bvmBDuynM2erBZIkuI5sj
	Pj5Kvj5ryqqtJwNyGAOfmwrAGpN/aM9qq7X71hMb6HY0F3tkQjZIqy3v59O2B0ZJ
	YF1skHM2nGqmBo57ZOhGWYUscRyNDaM7W4LgL8exB+3kCx3QkoKH2HRjDCDedKXq
	xDwD7RTfa01OpFMb86D7YfWTPigC3PuKIT/D5RNjvfBj+OkFzXOMuhH0ZQ+bI8T6
	s08ckrhfURrPXYNrW8xK9mem4aZXDLlh4D1yt1FDwBHPaM4G25JIju2AHDtVQKEo
	U/t8s07X/ITnxH+mqbvulGqfI/KThk/gF8Q==
X-ME-Sender: <xms:PN4xZ49D1TUCP2UR2nVedqUUlIMJt2rDIcAgm3zsTLvyLKU6vSzXwA>
    <xme:PN4xZwtaShhRP2kfmsxhKn9z5aZc7W1DLpGiRbFTyjvfek6513X05wGMH2zFf0BPQ
    dZUFNnlt1mKWsskdQ>
X-ME-Received: <xmr:PN4xZ-CQEqj7lckY1s-CTwhYQ3IxcVuu7Aex04s580zcTuWTGO-R36hP6WkQdLLebWm8lGYbveJGn1iJTVI3lzEHSp4s17GWYBNxAY75rTZkm4gl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeetffffteelvdefheevfeetieekfefggeelhfekgeelffek
    ffeggfehffefveekkeenucffohhmrghinhepmhhuohhnrdgsuhhilhgunecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehrrghm
    shgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtoh
    hordhorhhg
X-ME-Proxy: <xmx:PN4xZ4dbdFERrYSi5_grwVZep40rNWXHHovTuCjNlpfK5-y15KrS6g>
    <xmx:PN4xZ9MGfueGE-eh9cC4SmJgAZ3COqF287ej0CNDDgW64nrBXhbCVw>
    <xmx:PN4xZykWNZBZ81lEnD4jDU7VMzXjvEFeSdHq3XoreVS1Y9PD9oJNPQ>
    <xmx:PN4xZ_vW7IYIYHTCrlGjc9aGr4a6elhF3bmr5m2jzHV6A0OS9kaHqw>
    <xmx:PN4xZ2hxB69qSbvF7etqJ498SA9idONPPjNbb41u93FNUvXwWlLPtx-X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:36:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22b3ede1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:36:08 +0000 (UTC)
Date: Mon, 11 Nov 2024 11:36:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: David Aguilar <davvid@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZzHeMjqUjzWpdX-Y@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <Zy9ckDezMSKVA5Qi@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy9ckDezMSKVA5Qi@gmail.com>

On Sat, Nov 09, 2024 at 04:58:56AM -0800, David Aguilar wrote:
> On Mon, Nov 04, 2024 at 10:18:20AM -0500, Taylor Blau wrote:
> > On Mon, Nov 04, 2024 at 01:17:00PM +0100, Patrick Steinhardt wrote:
> > > > I admittedly have a hard time squaring the benefits and goals we have
> > > > with Meson with the cost of learning a new build system, and/or moving
> > > > away from Make entirely.
> > >
> > > I guess this depends on the exact persona you're optimizing for. There
> > > are three main personas involved here:
> > >
> > >   - New contributors. This is a group of people that I think would
> > >     benefit from Meson. They get integration with their favorite IDE,
> > >     have easy ways to discover how to tweak build instructions and can
> > >     use standard invocations for Meson that they might already know from
> > >     other projects.
> 
> As someone that was once a New Contributor, my perception is that new
> contributors are more likely to be familiar with CMake due to its longer
> history and wider general popularity.
> 
> CMake has standard invocations and IDE integration so this isn't really
> a Meson-specific feature.
> 
> That said, if we mean, "Linux/Unix-savvy New Contributors," then
> I can understand why Meson might be a favorite, and perhaps this
> might be the crowd we are looking to target (in the same vein of
> the original argument for why Git uses C instead of C++).
> 
> The remainder of my reply assumes that we are targetting a general
> audience (in other words, including Windows users).
> 
> Disclaimer ~ I don't use Windows so I'm making some broad assumptions and
> generalizations about that userbase.

My goal is to not only make things easier to use for Linux users, but
also for users on other platforms like Windows while also catering to
the typical developer of Git and making the solution for them as tasty
as possible.

I agree that CMake is a tad easier to use and set up on Windows, mostly
because it is directly integrated into MSVC. But I also think that CMake
is a harder sell towards the power users because it is comparatively
hard to maintain due to its somewhat arcane syntax, implicit variables
and things like this.

So I'm basically trying to find a good middle ground where all of the
respective target audiences get benefit:

  - For Unix devs I think that Meson is easier to maintain and use
    compared to CMake. We also get nice features like out-of-source
    builds, good integration with the test suite and easy integration
    with IDEs.

  - For Windows devs we have an officially supported way to build Meson
    from MSVC and co. Also, subprojects allow us to have as easy story
    for how to build Git without preinstalled dependencies, which is not
    currently possible with CMake to the best of my knowledge.

  - For packagers I think that Meson provides better discoverability of
    options than CMake.

So Meson may not be the perfect solution for everyone of these target
audiences, and better solutions may exist to cater specific needs. But
it provides a net benefit for every single one of these audiences from
my point of view. And when taking the benefits for all target audiences
combined I think that Meson provides the bigger win compared to CMake.

> > Patrick Steinhardt wrote:
> > >   - Packagers. This is another group of people that would benefit from
> > >     my point of view. This is mostly because Meson has certain standards
> > >     for how to approach problems, and thus the packager would know for
> > >     how to handle things. They don't have to manually track build
> > >     options and changes thereof, as these can be easily discovered and
> > >     because Meson will error out in case invalid options are passed.
> 
> CMake's option() variables and its GNUInstallDirs module pretty much
> handles all of the standardization that packagers are looking for on
> this front, so this argument doesn't push the needle towards Meson over
> CMake from my perspective.

I think that discoverability of Meson is way better. Here you can simply
say `meson configure` and it provides you a nice list of all options
that are available. For CMake it always used to be a big pain.

> > Taylor Blau wrote:
> > I appreciate your thoughtful response to my concerns here. Please feel
> > free to correct me if I am wrong, but I think the bulk of your argument
> > is captured fairly well by these three points, so I want to focus my
> > response here.
> > 
> > Responding in turn, I think my feeling is something like:
> > 
> >   - Long-time Git contributors are going to be the ones who will most
> >     frequently use the new build system. I am definitely sympathetic to
> >     getting too comfortable with our existing tools, but so far in your
> >     response I have not seen a compelling reason to switch the project
> >     to use Meson.
> 
> Likewise, I have not seen a compelling reason to not focus the
> effort on CMake instead. In other words, why not enhance the current
> status quo (Make + CMake) instead of trying to replace it?

As mentioned above, I mostly think that Meson makes for a more
compelling overall package. That being said, if we eventually come to
the conclusion that we as a community want CMake instead of Meson, then
I am willing to go there.

> >       * New contributors do not interact with build system internals
> >         nearly as much as more experienced contributors. I would imagine
> >         that the vast majority of those interactions are simply running
> >         "make" or "make test".
> > 
> >         You mention a handful of other niceties that Meson provides,
> >         like language server support, but I am not sure that I agree
> >         those are (a) the responsibility of the build system to provide,
> >         or (b) that those needs aren't already well met by the vast
> >         number of existing tools and IDE integrations that can work with
> >         ctags.
> 
> CMake has all of these same bells and whistles, and it's already present
> in git.git. LSP support just means being able to generate a
> compile_commands.json file, and the current CMake setup already does
> that.
> 
> The one thing that no one has mentioned is dependencies.
> 
> CMake has less dependencies. Python is arguably a liability in the build
> system arena, and Meson requires it.

Eli has menitoned [muon](https://muon.build/), which is a drop-in
replacement for Meson written in plain C99. I don't know whether it is
currently able to compile the Git project, but if this is going to be a
concern for people I can try to make sure that it does.

> Furthermore, if you must have your fast Ninja builds then CMake supports
> that too, but, critically, it's optional. If you don't have Ninja then
> you can use CMake's Makefile generator. Meson, OTOH, requires
> Ninja. CMake seems like a more pragmatic option in that regard.
> 
> Sorry for derailing this thread to share my Meson vs. CMake opinion, but
> if the main con that the Meson website has to say about CMake is, "The
> scripting language is cumbersome to work with. Some simple things are
> more complicated than necessary." [1] then my general feeling is that
> it's not a very strong reason for Git's needs.

No need to be sorry at all, the whole thread is marked as an RFC exactly
so that people can provide their opinions.

> > > I fully agree with all you're saying here. Whatever the solution, the
> > > new build system should be a proper first-class citizen and should be
> > > exercised by our CI systems such that they don't silently break.
> > >
> > > I also agree that it's going to be a hassle to maintain three (or three
> > > and a half if you count autoconf) build systems. But I don't want to
> > > break any users out there by dropping everything but Meson immediately,
> > > so I think we just have to accept multiple build systems as an
> > > intermediate step. How exactly that would look like is certainly up for
> > > debate. My take would be:
> > >
> > >   1. Adopt the new build system and start exercising it via CI.
> > >
> > >   2. Drop CMake.
> > >
> > >   3. Drop autoconf.
> > >
> > >   4. Drop Makefiles.
> > >
> > > This should happen over multiple releases such that every step will pull
> > > in additional user groups, which will make the new build system more
> > > solid overall. I could see that one step corresponds to one release
> > > cycle, but I'm also happy to adapt the pacing as necessary.
> 
> My take would be:
> 
> 1. Enhance CMake
> 2. Drop Autoconf
> 3. Profit?
> 
> This would not need to happen over multiple releases. There'd just be
> one minor or major release where (2) would happen once (1) has reached
> some substantial level of maturity, and that'd be it.
> 
> Arguably, we could even do (2) before (1) and it'd be fine.

I'd honestly be sad if we go down the CMake route, mostly because I
think that it is an inferior build system compared to Meson. I have
worked with it extensively in the context of libgit2 and always found it
to be a pain due to its esoteric syntax, the use of so many implicit
variables, platform CMake policies, and there being so many ways to do
the same thing and, where the easiest solution is typically the wrong
one to pick.

That being said, I'm trying to be as pragmatic is possible: my main goal
is to have a modern build system that is easier to use. So while I think
that Meson fits better into that role, the next-best thing would be
CMake from my point of view.

So I'll continue to champion Meson, but if the project as a whole agrees
to take up CMake as another official build system then I'll adapt and
make that happen.

> > I have a hard time imagining the project ever dropping its Makefile
> > entirely, if for no other reason that make is available nearly
> > everywhere that we want to build Git, and the Makefile is the product of
> > nearly two decades of work to make it compile anywhere.
> > 
> > If our tree really is going to have a Makefile in it forever, then I
> > think adding Meson (even if we remove CMake support) has many of the
> > same challenges as the state we're in today "supporting" Make and CMake
> > in parallel.
> 
> I agree, and from my outsider perspective it seems like a simpler answer
> would be to double-down on CMake rather than having to adopt another
> system and do the whole deprecation dance.
> 
> My perception is that any benefits we would get from supporting Meson
> would also be present with CMake, but with less effort.

I doubt the "less effort" part. The Meson build instructions are way
more complete compared to the CMake build instructions by now -- many
things that work with Meson don't work with CMake. So we would have to
invest significant resources to polish CMake.

> That's just my opinion, though. Perhaps there are strong reasons for why
> Meson is a better tool for the purposes of attracting New Contributors
> and improving our day-to-day usage, but the benefits are not immediately
> obvious to me at least.

Thanks for your input, highly appreciated!

Patrick
