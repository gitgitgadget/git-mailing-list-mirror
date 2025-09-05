Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F511D9663
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055023; cv=none; b=DYhgQZgZIz35lcMQEauL8kEQphnXew4MBqTlf6ZdAbbYH/V+hN4JOPieFQjhAyFvc4NzZnF8wD9e91pEwmvsKetY5dHSAQRnSl3yfPoDWOALZUlM9s0y2NQIEob+g1ScHUEiWWFCR65zUrgMbqodEGTbSgm54M7LxEmTfx3u7Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055023; c=relaxed/simple;
	bh=G2XzUricI78J5lDdqPn9KrmIaZj1sgryvRs9ZqCzNnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP4hRn9rxgs5FB2GspKmXo/D7FoFmPo61nb6v9IAdZ4HYv76v+3WFm18fOllcvfvVEtkuEx7U/desID146YqfZcyt+LTKBVd8Err5ISBrEknIi/UcHgNbZZ02i5z+81Ha+X3C5tu6M7btGXiisVtD89Nw53hxmPFCSdgrzLqLNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZJmMfyZt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OzyOQDdo; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZJmMfyZt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OzyOQDdo"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42B697A03DD;
	Fri,  5 Sep 2025 02:50:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 05 Sep 2025 02:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757055019;
	 x=1757141419; bh=RYYcXH4cepkUDc0ESyrh5OxfRHVdJD3dn/cvNr5PkXU=; b=
	ZJmMfyZt4EyhWpA1yYqwnGUvBG8ykd6UhsMfsoYvgckmyGOeqDuBPXacsDD7M6dv
	L+KbTRcgiCKDml+MiDpj/DUxEYERL65sUy9VK5D6BV1sfHKdVG+Y/R/MQN9nIy5b
	mJ6RvtzwPX23Mtv4pBsUd1HB0FzYxq/uV43CE0ChrqhRtBjwRijVE0UpOIJOyOUB
	e+XpEr9H4MU/r3UW5OC4ViH1AYMbrqHoMSHLOkfIpGf0oGOhsk+xZEiQND7QSmJg
	clRrb4eusYXn+SwUo3qcjuPMor8GbLXuFW6OM+MPf+/01R4AQVdTLxsgeflX2Lvf
	pzXn7UiUErF9LPAukhdZHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757055019; x=
	1757141419; bh=RYYcXH4cepkUDc0ESyrh5OxfRHVdJD3dn/cvNr5PkXU=; b=O
	zyOQDdoivct6s92W6MgVX7RcRZPUsyOeBS4fm0HA6SdbFXZnV3tCtV0bOl1MEn7Y
	fRSYXdFbw0nWsfTkHihjPXFq6WXvzm1MtlAJQ0iwqkMRheSUPy14S7yrvGS/BfwS
	u9BUifcsdeKw41GkGCEbcJRrH71AaSCy1Wvj1KNCHRIaSDmgRhadMIyLkUb6k7EN
	4UB9FmmcoD+a0S/xs6sxRLVL2ukDgsst6rPKUyKoEXNedAAEtXiTD6X/kpv7HaOY
	f2AcuWXM49CWsheNnyqeIp89XlUkqEipnVmJwFnuCuq3t5BBm/GPtJc95Rt/UyMt
	AX1FtHvVw2m/NdNAYKsGQ==
X-ME-Sender: <xms:KYi6aF_1IUbFzI8rWwIS_IOBBa1zD-7-jy5eIolSr1HnkiuhhWhE0g>
    <xme:KYi6aBVMNOwV3OF2wK52mDfDe3KDNUO_RaFMHdSYXSWwSjssN_fYtg8VoHWkezLUH
    2nhtFwjcuO3F5ET5w>
X-ME-Received: <xmr:KYi6aDNKxP2XluNvvtuB_NEd4055Ee9diIOWJS5OUhYM2CoUdS4RBaUqG0Gfi15aJGBC6N3sj6vkpBsNyPlV5I70q8KP3KsfBwY8TRPIEEvC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptggssedvheeisghithdrohhrghdprhgtphhtthhopehsthgvrggumhhonhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhp
    lhhushdrtghomhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrh
    ihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghn
    thhoohdrohhrghdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvg
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgr
    mhesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:KYi6aBdPA288OegzF1zMylwgUtO4W41e9SurQ9enZ8gN76yuF3dcaA>
    <xmx:KYi6aKz9vN4qs0tygn6Esgc9jPOpY0CXVALvODDT1XWMg5CJSR_uKA>
    <xmx:KYi6aKgm63KLY9oGdVswT1MoYf3vlMzVYxw65TVjjHkQzrQtgNOQOg>
    <xmx:KYi6aP5YC4h9BZ5UrfWVeQBvBecDTAsmbR-LdP3kXqBRNA0TYgt5Ug>
    <xmx:K4i6aKvkbK3RTSSY8ENWyVPJHVrj9qQwazfVmddNX5ugrNG2lRSqWG0m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 02:50:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5584b922 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 06:50:13 +0000 (UTC)
Date: Fri, 5 Sep 2025 08:50:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	rsbecker@nexbridge.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Christian Brabandt <cb@256bit.org>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aLqIHCdlbwF5X6Cm@pks.im>
References: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g>
 <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g>
 <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im>
 <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
 <aLl6iFXeAvL_hvqR@pks.im>
 <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>

On Thu, Sep 04, 2025 at 08:54:19PM -0700, Elijah Newren wrote:
> On Thu, Sep 4, 2025 at 4:40 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Thu, Sep 04, 2025 at 12:57:25AM +0000, brian m. carlson wrote:
> > > On 2025-09-03 at 05:40:54, Patrick Steinhardt wrote:
> > > Also, the approach of making it an optional component directly
> > > contradicts the proposed policy I wrote up.  That's a recipe for
> > > additional burdensome work maintaining two implementations, when we
> > > actually want to make it easier for people to contribute functionality.
> > > It also doesn't provide any of the memory safety benefits or address any
> > > of the concerns from governments, security professionals, and other
> > > parties about the real and substantial risks of continuing to develop in
> > > C.
> >
> > The only reason why we want to have it as an optional component is to
> > make the transitioning period easier for downstream distributors. And
> > the intent is not to convert major components -- it should be trivial
> > components that we can use as test balloons, similar to how we did it
> > for all of our C99 test balloons.
> >
> > We cannot just pull the rug away under their feet without advance notice
> > that this is going to happen.
> 
> I find this statement a bit problematic for four reasons:
> 
> (1) "without advance notice" was already pointed out to be inaccurate
> in this thread, including in the exact email you are responding to;
> you could argue that there hasn't been _sufficient_ advance notice,
> but then there should be more details about what is and isn't
> sufficient.  Merely repeating this claim which brian just barely
> pointed out to you as false almost feels dishonest.

I think there is a difference between communication that happens on the
mailing list/contributors summit and communication that is intended for
the broader ecosystem:

  - The former is basically us developers discussing potential futures
    and reviewing patches. It would be _nice_ if distro maintainers of
    Git were to read these, but given the large volume of traffic in
    general I think it unlikely that majority of maintainers is keeping
    up with that traffic.

  - The latter is in the form of e.g. our release notes as well as our
    BreakingChanges document. These _are_ intended to be reviewed by
    maintainers, and the blame is on them if they don't do so.

We have never communicated either via release notes or via any kind of
committed document that Rust is going to become mandatory. There have
been lots of large threads discussing it, true. But navigating these
threads and estimating consensus isn't easy even for us developers, so
it's going to be even harder for outsiders to the community.

> (2) "pull the rug away" seems hyperbolic.  I would have liked some
> explanation as to how a transition period is expected to help, and how
> the existing transition period has been insufficient.  You do hint a
> little at the former, which I'll discuss more in point 4, but you
> neglect the latter to the point of pretending it didn't exist.   In
> short, why is a further transition period needed, and how will it
> differ from the existing one we've already had?  It's not clear to me
> why distributors must immediately update to the latest git version.
> Taylor discussed this aspect in detail in this thread; you even
> responded briefly (and tangentially?), but still as far as I can tell
> presume the latest and greatest is mandatory for them to adopt without
> stating why.  Maybe they do need to adopt the latest and greatest, but
> I haven't seen folks state why that's the case.  Did I miss it?

The problem here is that we don't have a story to tell yet. I agree that
not everyone always needs the latest and greatest, which is also why I
mentioned that I think it's fine for _new_ features to be developed in
Rust right away.

But the story is altogether different for bug and security fixes.

  - We of course backport security fixes, but would that also be the
    case if we had ported the subsystem to Rust already and now had to
    implement the security fix twice?

  - What happens if only the old C version has a security bug? Do we
    still fix it?

  - Likewise, what happens with important bug fixes? We tend to backport
    those that are easy-ish to backport, but if people are potentially
    stuck with an older Git version for years it will become harder for
    us to do so.

I think without us having a proper answer to these questions we _are_
pulling the rug away. Distros may be stuck with an old version of Git
for a significant time, and from my point of view we have to do a couple
of compromises there.

> It also feels like Rust support is being lumped in with "breaking
> changes", which to me feels misleading.  Historically, we have talked
> about breaking changes and deprecation periods and such so that users
> could adjust scripts or their command lines such that they would work
> across multiple versions of Git.  The Rust case is somewhat different
> in that we're not discussing behavioral changes of git, merely
> implementation differences.  If someone has both a C-only version of
> git and a newer version of git that was built with both Rust and C,
> any commands they run should behave the same as far as the C-vs-Rust
> goes (unless we have our normal discussions about specific behavior
> and any deprecations we want to do related to it, of course).
> 
> I do agree that reduced platform support is a negative change (though
> Rust brings other advantages that may offset this downside depending
> on your viewpoint), but I don't see why it's a breaking change and
> especially not a "pull the rug away under their feet" change.

I honestly don't quite understand this perspective. How isn't it
breaking that you cannot use that Git version at all anymore?

> (3) the use of "cannot" presupposes the policy stance which we are
> having a discussion about, which, whether intended or not, feels like
> an unfair way to attempt to shut down the conversation.

Sorry, that's not my intent.

> (4) you suggest that adding Rust as an optional component should avoid
> the problem, yet we've already had Rust as an optional component for
> the last three releases, going back to 2.49.0.  (libgit-rs and
> libgit-sys).

I don't really think that either libgit-rs or libgit-sys help in any
way. These are part of "contrib/", not built by default, and neither are
they consumed by anyone out there. So there is no reason for anyone to
build that library to the best of my knowledge.

> In this case, you helpfully provided some details distinguishing the
> type of optional component you want -- the reference to a test balloon
> suggests you want an optional component that is turned on by default
> (but which users can easily turn off). Am I correct that this is your
> intention?  If that's the case, then that's a useful distinction, but
> I think that distinction needs to be made a bit more clearly (and as a
> side effect, acknowledge that Rust has already been optionally shipped
> in some form, and was even specifically highlighted by GitHub's and
> GitLab's blog posts about the v2.49.0 release, among other places)

Yes. I think we need to have a test balloon that allows us to iterate on
the build infrastructure and allows distributors to test with them. I
think that test balloon needs to be integrated into core Git so that it
is part of the normal build process, because otherwise it wouldn't have
any exposure at all and thus not serve its purpose.

> > > For example, there is zero chance I will implement any of the
> > > SHA-1/SHA-256 compatibility code twice.  I'm already doing that in my
> > > free time without any compensation at all and it's unreasonable to
> > > expect me to do it twice or even to #ifdef out all the places it would
> > > need to go.  I am happy to let someone else take responsibility for the
> > > project instead, however, if they would like to do those things.
> >
> > And that's totally fair. From my point of view, this compatibility code
> > is a _new_ feature that we are adding to Git. And as I mentioned, I
> > think it is reasonable to say that new features may be implemented in
> > Rust now already, as platforms that aren't yet ready wouldn't lose any
> > existing functionality.
> 
> Am I correct to understand that you're suggesting a policy where brian
> cannot modify any existing code to be written in Rust, and can only
> add new Rust code?  Perhaps the SHA-1/SHA-256 compatibility code is
> just new code, or can be done with minimal changes to existing C code
> while adding new code.  If so, maybe this is a workable solution for
> him.

Yeah, that's my hope, as well. There's probably nouances to this though,
and we'll have to figure it out once the series hits the mailing list.
So...

> But if it can't be done with minimal changes to existing C code and
> this policy would impair brian's ability to deliver the compatibility
> code, then I think this policy would be unworkable.  I really don't
> want to hamstring brian's ability to implement the compatibility code.
> It has sat dormant for years with no one else stepping up to the
> plate, it's a really important project, and brian has time and energy
> now.  I don't want any chicken-and-egg problems introduced for him
> with the 3.0 release.  Even though I've been working with Ezekiel on
> xdiff, and I'm obviously a bit biased in that area, I find the
> sha1-sha256 compatibility work to be more critical and something we
> should do everything possible to facilitate.

... I guess we'll have to see how this looks like in the end. If the
series rewrites a bunch of subsystems in Rust I think we should figure
out whether we can do without that. Or, in the worst case, whether it is
feasible to conditionally compile some of the code with either C or
Rust, even though nobody likes that.

Patrick
