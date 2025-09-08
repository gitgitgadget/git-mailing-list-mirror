Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D81A262A
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313632; cv=none; b=HqONqZNYRiFJ6gjDNy1yGJD4kl94kkLMuSJurNn0blrNiX/gBE7bWriYtVPNosaFNO5nZPe+I22o38kNIqoHh6d4tbmpwmRVmNhQj7l98DMybE55/m6bCNe6g1tiKHhRnMwpeu9XXL/dL5bEOJzrxQb3hp5Rt6LBZyvg222gIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313632; c=relaxed/simple;
	bh=RjNJNZJRZx0akT3M1ZzQfdPs9E45xEzI2wjszVFgwGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ij/MBOlU48EMgO/6lBPQS9XFN/TGJVjsc/Sk9Qb5E/N2llzvCt0Rjab42XJByPjxAAm5g0nKsqXJiBX4CWGeLZuiURltjkFNYkW7eru1s3YzyoQzeQXz7GXhsm91vScodNHZMQMft/JI5NEUQBqaJMmoPnSsMnCTnURbX9fpC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iRWw05hU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=odi+19cM; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iRWw05hU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="odi+19cM"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id BE9091D00135;
	Mon,  8 Sep 2025 02:40:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 08 Sep 2025 02:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757313627;
	 x=1757400027; bh=61zbKzdoq0yeltxUrMZhCyhqJqdWkLmxsJgaDhIjD7c=; b=
	iRWw05hU0pmnt5eKS2rIePswVZZufWxphRUeDxqQYrp7nsqjHo9sIlC8ECtr3nuR
	tm5KC/hJr5V6A/so0w+//zqYB7QQ1ChNlSYmsjBzo+WY8Y55qJUdJKJ1ou07wTM/
	rzP4YXsm/M/d6j3rWcLagG9CNXYamYsKYInnGyfS87IjHY7euFPd2A4uZf7GDJ/y
	VJ7wAGnGi3xnV1Wls051ed1cTamOO1OOsBJi8f3+nTMpIyw0JzGrpkIpz8M0N7j4
	FI6eERne/hlmeBIKNi+guWtYzHpu3KA325OQrV4E3I4X218+qneA8SBU1LGIkQlz
	u02REmzUpPPwmqCpjNqvPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757313627; x=
	1757400027; bh=61zbKzdoq0yeltxUrMZhCyhqJqdWkLmxsJgaDhIjD7c=; b=o
	di+19cMb0iHqiTqHB1RcgwyXaNzvmszrdtFUsOh+M3O8zKvHqu6x4y3dDT7ndsZY
	lKmpDqy4LD79QUNN2WAb/DDGHqrnK8CUg/Y5lhj3FR9Yeja1VWTZis07hums32mD
	TF2MB0FIsIlyoEumL366VghRfgpmnGADxHDb52/SqpSdQEQ1EFQ8fZkKqARcSCkp
	2+iusu8BnCyiyimNBZ/e6vdpXcGhZSLEn3sqH1cE3qnOS7mSdk8BGpyAcdnnFR09
	8yDygB/28tsPxHOjYXtqoHr4d+LvyNLmq5Rh9XszIJEwjhZ1uDHsJBn4RZisydg1
	73k6eveHpAzV54YDY5Iiw==
X-ME-Sender: <xms:Wnq-aKF93jXTd_juHbw2a8Ssga3pFRLwFG4VJn0VLKUYrTPvVu5oBQ>
    <xme:Wnq-aC-cvToJ6McaxaLzc7_Ieut08AXzY3yCFqD5i3CgIPsxXjK43Jllidj8w-VAa
    W66rR_cBLbzvwfp7A>
X-ME-Received: <xmr:Wnq-aEXBKjAixktW9zrcs8ixTydiXByV2DOCqdAK7H833Z3Nd_--Aj-6lMl-Zc0n5OeyHcQEX9bAujRsFhSnncStTBli26mRhvOmycHEERJUWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteehffdvtdeltedtteeuueekudegteetuddtgeeuueekteehfeeuvedviedttdevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedv
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepmhhhrgduleelfeeslhhivhgvrdguvgdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegtohhnthgrtght
    sehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:Wnq-aMEtNlTA3rCZ8Jw87pGRpLTlLkII6kHSGcPBSTn7d8nMxGo9YA>
    <xmx:Wnq-aA6IKtoz17HZ9iTwHdeck6WTbBQmYPrzZllu1Ztu8I_hesxJOA>
    <xmx:Wnq-aGIeO3mMqGZ6Q42-Tle7NQLbbPEuRSF2lzFTgguDI1n-7ZEBig>
    <xmx:Wnq-aDDvILyyg6KLyEGztpIjYN9WJ4QiQ0xxAAQ6P3FVQMtZMIQz-g>
    <xmx:W3q-aPU-aygal2qnx6DwWbi8N0FcBdkL2tX65q2t1FwKd1j4awYODxke>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:40:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea601989 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:40:21 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:40:12 +0200
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
Message-ID: <aL56TGLvqpDzmrSn@pks.im>
References: <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g>
 <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im>
 <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
 <aLl6iFXeAvL_hvqR@pks.im>
 <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
 <aLqIHCdlbwF5X6Cm@pks.im>
 <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com>

On Sat, Sep 06, 2025 at 09:10:28PM -0700, Elijah Newren wrote:
> On Thu, Sep 4, 2025 at 11:50 PM Patrick Steinhardt <ps@pks.im> wrote:
> > The problem here is that we don't have a story to tell yet. I agree that
> > not everyone always needs the latest and greatest, which is also why I
> > mentioned that I think it's fine for _new_ features to be developed in
> > Rust right away.
> >
> > But the story is altogether different for bug and security fixes.
> >
> >   - We of course backport security fixes, but would that also be the
> >     case if we had ported the subsystem to Rust already and now had to
> >     implement the security fix twice?
> >
> >   - What happens if only the old C version has a security bug? Do we
> >     still fix it?
> >
> >   - Likewise, what happens with important bug fixes? We tend to backport
> >     those that are easy-ish to backport, but if people are potentially
> >     stuck with an older Git version for years it will become harder for
> >     us to do so.
> >
> > I think without us having a proper answer to these questions we _are_
> > pulling the rug away. Distros may be stuck with an old version of Git
> > for a significant time, and from my point of view we have to do a couple
> > of compromises there.
> 
> These are good questions...but they are ones to which I suspect
> delaying will not provide the answer.  In fact, I don't think we'll
> _ever_ have the answer to these questions, no matter how much we delay
> or discuss.  Traditionally, if an issue was more severe, it has been
> backported to more versions, even if the backport wasn't trivial.
> There's a cost/benefit tradeoff to be had for each vulnerability, and
> changes to the area making backports either be easy or hard always
> need to be weighed against the severity of the vulnerability.  I don't
> see that changing, and overpromising hurts in the long run probably
> more than having no guidance.  I just don't see us coming up with
> "proper answers" (which I'm guessing means fully spelled out answers?)
> to these questions ahead of time.

That's fair, I guess. I don't think we need to fully spell out the
answer to each of these questions. But I think we should have some
general alignment on how we'll handle the last non-Rust release, and
what some guarantees are that we can and want to provide.

> The answer to all of them is
> probably "we'll weigh the severity of the issue and the cost to
> backport and give the last C-only version significant extra weight in
> our considerations".  I doubt we'll ever be able to promise any more
> detail than that until we get concrete cases; I'm not even sure that
> this statement is acceptable to everyone on the list from the
> overpromising angle despite being as incomplete as it is.

True, we don't want to overburden us, either. This is mostly why I
proposed the compromise of saying "We provide you with updates for the
LTS version for X amount of time. If you still depend on it after that
time, we will be happy to pass over maintainership of that branch to the
community."

[snip]
> I still don't see why distributors _must_ ship the latest version of
> Git and why folks on some platforms are considered broken if they are
> using a slightly older version.  Let me ask again: has anyone answered
> why this is considered mandatory?  If they have, I've missed it, but
> I've asked multiple times.  Even if you want to lump "distributors
> cannot build a newer version" under the umbrella of "breaking
> changes", I argue it's a much different kind of break and one which
> merits different timelines for handling than e.g. lumping it in with
> 3.0.

To me it's not necessarily about the _latest_ version, rather about
_any_ version. Some distributions will not be able to build Git at all
anymore, so they are stuck at the last non-Rust version for the time
being. And seeing that the timeline is years for them to get Rust
support they may not be on a slightly older version, but on an ancient
version eventually.

So the question to me is less whether users of that distro will miss out
on new features, which I think is acceptable. Hence my statement that it
is fine from my point of view for new features to be written in Rust
immediately.

    NB: There's some nuance here. If newer features mean that users
    cannot interact with modern upstreams anymore the picture would
    change quite significantly. But the only work that really comes to
    my mind is SHA256, which already exists. I don't know whether the
    interop code may fall into this category, I hope it doesn't.

But the bigger question is whether that old version still gets security
updates and important bug fixes. If the only available non-Rust version
is riddled with security holes then these distros won't be able to
provide it at all anymore.

> > > (4) you suggest that adding Rust as an optional component should avoid
> > > the problem, yet we've already had Rust as an optional component for
> > > the last three releases, going back to 2.49.0.  (libgit-rs and
> > > libgit-sys).
> >
> > I don't really think that either libgit-rs or libgit-sys help in any
> > way. These are part of "contrib/", not built by default, and neither are
> > they consumed by anyone out there. So there is no reason for anyone to
> > build that library to the best of my knowledge.
> 
> I'm fully willing to accept they are inadequate notice (and perhaps
> even barely helpful), but disagree with the characterization that they
> don't help at all:
>   * they were consumed in the past by Google
>   * they recently received patches from someone outside Google
> (https://lore.kernel.org/git/20250826233525.2635432-1-davvid@gmail.com/)
>   * they were mentioned in the release notes highlighting at a minimum
> that Rust is being added to Git.
>   * they were highlighted in blog posts from both GitLab and GitHub as
> being noteworthy new things in the v2.49.0 release

Okay, fair.

> I agree with you there is certainly more we can do, and I like your
> idea of a test ballon.  Let's just avoid repeating the problem of
> adding an optional component that no one will try to build except for
> those for whom we know can build it; doing that would provide no more
> notice and thus provide no incremental benefit over libgit-rs and
> libgit-sys.

Fully agreed. My current proposal includes several steps of how we
tighten the screws here, where we gradually start to require Rust by
default on more platforms. Before Git 3.0 it's still possible to opt
out, but eventually distributors need to opt out explicitly. So that
should hopefully alert them that something is cooking.

Patrick
