Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE2170A1A
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321403; cv=none; b=q5BW4WMc3GOJzFQS506MvyyvxDOl+O02t8bBLJNBS7haXxW6d5hZoq5CTnOCwt9V5GEu4xv1tdns64ezZNQ6kPpXB0cai2b4AZjel22u8lLNxelSeCc/u4T8QSQMdoqtua+sdQ12rINUjulFIadEM4hPz0WipaysisYG0MV+n1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321403; c=relaxed/simple;
	bh=S+uEWH0NqqiNzkgFUgNaMLjiZc5TOuz3zEuGogmYUxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXoSsNPaaInNJ9rS79LrZR3vRMjy6FaJcoeQtOFsIvqrsJQFhwraFP+IO6CTMfFzOQsPXYcPxhsxEFBpv+fAN5Av/ld7FKv1H/oMwZh+9/OmvQxUVdJOjwgU++wHv5eZHwdwM2738SfF/AjvWLaLPKsBZth2uEBIG9MtQ1HDO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qm70/b1S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ais+KdHq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qm70/b1S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ais+KdHq"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7110B1140102;
	Mon, 11 Nov 2024 05:36:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 11 Nov 2024 05:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731321400; x=1731407800; bh=V7/6enSfaA
	vdy8/+NwFV2wl6d5uRrg/hVvXqARpKY7M=; b=Qm70/b1S8O8L3PBGZhOCYxk9jJ
	fonWCQYSqnmA16NmgOhb0FWIDc9kdCeZ5Z5MDPPUDcGz3ylkSnM1WAgYrsw2lzjf
	nJa2iKwSWKOk55/3aqDAC3pvFx17SDml/aRCrer/+hCOAzzNQgsan5dPIC4X7zRR
	wd0NfZ9nHGlGgogwaUHDve+BlieyknJCI6yzhnhIeKdZKtLW0BqqttCIi8FUeuxe
	D6+NljFZ5J2GANWYiaBdek7CUg0MnQjS9hHpdo8K8ufjkY2B74+HI5DtGQBaU9ZW
	g+HEgru/7D4Jjzz9COWPQm0HdR7PUlbbhyI3rtcNCnSs5olHhtU7juDNNDTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731321400; x=1731407800; bh=V7/6enSfaAvdy8/+NwFV2wl6d5uRrg/hVvX
	qARpKY7M=; b=Ais+KdHqtb9f/VTBNofBDGafFc+FOAriDut3vQllanJE4RLI7kj
	EDYL8JkPnP2OYjOMY1b2hHa2O6g6bZSCm3bj89D9C1bIkOsirix8ywkJ8HdGkdjq
	KEqHyNEYH7vsYWCedt7c+lSKRPBZCJYfmnTmYLa89SHsMQ/ywOZEijbsbc6/LZcI
	YCe64troYLrNxP4FCM1bCh6NdTL4jjHz0XaXySPwerodF6Pz9PrEepVdlFGI3reM
	Ebdl0/gDe8BuFvIsaDWXw8FrTfgXSSdLUSFLZnwE6wTgjyvP5CnxE0LbSVlPTIEg
	R0hPvewsjh+qUo3stBQaSY41bDzG5qlzMhA==
X-ME-Sender: <xms:ON4xZ2gY2UxsPlEyBfp7r5-3JXjtbJPzdR6qXiFs108sypSahT51Jg>
    <xme:ON4xZ3DwMrzV24G4Rz_D9_pEZsKskZ-uMRgezxWq3llKULBRO5YVD2SyiZhZFdVCA
    FXKcwzjh9Ix6Xr7Og>
X-ME-Received: <xmr:ON4xZ-FXVaTOmobc26z5HzLLBDoVxwwkELVfMj3AuLacuyvv5GE6ukzMwxA9292wcYTiSMXXu6G74ktB6NMKLdlk48nQxDyhfJuGAnzgRBr9sC49>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegv
    shgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ON4xZ_T8mQue4HDJ5O8VP8TfUa3ub2EWw8ghmgWHSf5d2KYgwJKtJA>
    <xmx:ON4xZzywB0-euMt2XVi--zB-NssKXBu8eb9h4pbLv9kCoD-KR65blg>
    <xmx:ON4xZ96N0o73vVUMiCdYd9Ga_ywEcydoT-3l_2cmlNQdLXpiBzoDkg>
    <xmx:ON4xZwxtYbqZGcuDCo3iqdj7BjmkduupZs6VoUtM_WDIT9ojy5YI5g>
    <xmx:ON4xZ6x2-RON_p3DtvOE1dkF_AXI1cPDeHWTWNrzoTEAAZ_zvMtYCchS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:36:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33e94fff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:36:05 +0000 (UTC)
Date: Mon, 11 Nov 2024 11:36:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZzHeLlYu8Gwk1FPj@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyjlvNJ4peffmGZ1@nand.local>

On Mon, Nov 04, 2024 at 10:18:20AM -0500, Taylor Blau wrote:
> On Mon, Nov 04, 2024 at 01:17:00PM +0100, Patrick Steinhardt wrote:
> > > I admittedly have a hard time squaring the benefits and goals we have
> > > with Meson with the cost of learning a new build system, and/or moving
> > > away from Make entirely.
> >
> > I guess this depends on the exact persona you're optimizing for. There
> > are three main personas involved here:
> >
> >   - Long-time Git contributors. I don't worry about that persona too
> >     much. Folks in this category tend to be highly skilled, and they
> >     should not have much of an issue with adapting to Meson.
> >
> >   - New contributors. This is a group of people that I think would
> >     benefit from Meson. They get integration with their favorite IDE,
> >     have easy ways to discover how to tweak build instructions and can
> >     use standard invocations for Meson that they might already know from
> >     other projects.
> >
> >   - Packagers. This is another group of people that would benefit from
> >     my point of view. This is mostly because Meson has certain standards
> >     for how to approach problems, and thus the packager would know for
> >     how to handle things. They don't have to manually track build
> >     options and changes thereof, as these can be easily discovered and
> >     because Meson will error out in case invalid options are passed.
> 
> I appreciate your thoughtful response to my concerns here. Please feel
> free to correct me if I am wrong, but I think the bulk of your argument
> is captured fairly well by these three points, so I want to focus my
> response here.
> 
> Responding in turn, I think my feeling is something like:
> 
>   - Long-time Git contributors are going to be the ones who will most
>     frequently use the new build system. I am definitely sympathetic to
>     getting too comfortable with our existing tools, but so far in your
>     response I have not seen a compelling reason to switch the project
>     to use Meson.

Yes, that's certainly true. And while I think we should optimize more
for newcomers as stated, I still think that Meson is very much
preferable over Makefiles for long-time contributors, as well. The
transition period may take some time, but in the end it just feels
superior to Make from my poin of view.

Out of curiosity: did you try the Meson build? I personally have to say
that I already prefer working with it because the workflow with it is so
much nicer. It has nicer output, is faster, has out-of-tree builds,
makes it easier to configure and test execution feels way nicer compared
to my previous workflow with make.

This is all subjective of course.

>     What I really want to say here is that I don't think we should be
>     over-correcting on things that we are all comfortable with when they
>     are indeed not the optimal solution.
> 
>     We can and should challenge those assumptions. But I think what I
>     see here is us challenging the assumption that 'make' is not the
>     right tool for the project, and (at least personally) not seeing
>     that it isn't.

As said, Makefiles have some problems that aren't really solveable from
my perspective. And I think part of the problem in this context is that
the typical developer working on Git is very much centered around Unix.
The experience on non-Unix systems is kind of a pain though as there is
no proper integration with anything.

And that's not only true for non-Unix-like platforms, but basically for
anyone who isn't comfortable working from the command line. Integration
of the project into an IDE with our Makefile is hard to pull off. While
many editors can of course trivially execute the Makefile for you,
setting things up such that it is _properly_ integrated into the IDE is
hard.

Overall, I don't think we old time contributors lose anything by using
Meson instead of Makefiles, quite on the contrary we get speedier builds
and nicer integration. We'd have to adapt eventually, but I don't see
that as a huge barrier.

>   - New contributors are a group that we should be optimizing for, I
>     certainly agree with you there. But I think there are a couple of
>     points that your response glosses over:
> 
>       * New contributors should be telling us what build system they
>         prefer, not the other way around. If we are going to switch to
>         using a new build system to better accommodate new contributors,
>         it should be because either (a) they have told us what doesn't
>         work with 'make', or (b) we have a bulk of evidence that new
>         contributors cannot easily build the project.

That's basically why the whole patch series is marked as an RFC: to get
feedback from people and ask them for their opinion.

>       * New contributors do not interact with build system internals
>         nearly as much as more experienced contributors. I would imagine
>         that the vast majority of those interactions are simply running
>         "make" or "make test".

Agreed.

I assume that what they are after is a streamlined process for how to
compile and test the project. The build system should be providing good
feedback for missing dependencies, for existing build options and how to
use them. These are all things that Meson provides by default, and our
Makefile doesn't.

>         You mention a handful of other niceties that Meson provides,
>         like language server support, but I am not sure that I agree
>         those are (a) the responsibility of the build system to provide,
>         or (b) that those needs aren't already well met by the vast
>         number of existing tools and IDE integrations that can work with
>         ctags.

From my own experience the integration with other IDEs isn't great at
all in Makefile-based projects. I don't use IDEs though, so I am
probably not the best resource to judge.

>   - Packagers are something that I admittedly have less exposure to than
>     the other groups listed here, but I think my feeling there is
>     similar. While they are more likely to exercise far more parts of
>     the build system, I think we should also only be switching to a new
>     build system if there is evidence of significant, unmet needs by
>     packagers, which I have not seen.

We have repeatedly gotten feedback that our autoconf-based build is
basically broken and does not work well. After all, that's what spawned
the whole discussion around a more modern build system that is able to
properly auto-detect what the host system provides.

> > > I feel that if we are going to pursue Meson over CMake and/or Make, we
> > > should have a clear plan to either get rid of CMake, keep it up-to-date,
> > > or something else.
> >
> > I fully agree with all you're saying here. Whatever the solution, the
> > new build system should be a proper first-class citizen and should be
> > exercised by our CI systems such that they don't silently break.
> >
> > I also agree that it's going to be a hassle to maintain three (or three
> > and a half if you count autoconf) build systems. But I don't want to
> > break any users out there by dropping everything but Meson immediately,
> > so I think we just have to accept multiple build systems as an
> > intermediate step. How exactly that would look like is certainly up for
> > debate. My take would be:
> >
> >   1. Adopt the new build system and start exercising it via CI.
> >
> >   2. Drop CMake.
> >
> >   3. Drop autoconf.
> >
> >   4. Drop Makefiles.
> >
> > This should happen over multiple releases such that every step will pull
> > in additional user groups, which will make the new build system more
> > solid overall. I could see that one step corresponds to one release
> > cycle, but I'm also happy to adapt the pacing as necessary.
> 
> I have a hard time imagining the project ever dropping its Makefile
> entirely, if for no other reason that make is available nearly
> everywhere that we want to build Git, and the Makefile is the product of
> nearly two decades of work to make it compile anywhere.
> 
> If our tree really is going to have a Makefile in it forever, then I
> think adding Meson (even if we remove CMake support) has many of the
> same challenges as the state we're in today "supporting" Make and CMake
> in parallel.

If our stance is that we cannot ever drop our Makefile because it has
grown for such a long time, but maintaing two official build systems at
the same time is not an option either, then our hands are tied. So I
don't think is a reasonable approach overall.

Yes, transitions like this will cause some pain, but I think that it is
relatively easy to avoid most of the pain by having a proper plan for
how to do the transition. The biggest pain will be that we have to
maintain multiple build systems and keep them in sync for some time, but
that also has a couple of advantages:

  - We can iteratively evolve the replacement build system over time
    until it is ready to fully replace the old one.

  - We don't have to screw anyone over by having a hard cutoff date.

  - We can decide that the replacement build system is insufficient and
    discard it.

  - Users of the build system can experiment with both build systems.

Patrick
