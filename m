Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C25A288C24
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546085; cv=none; b=WOLdzC/s4vQU3oi00mlrJLAAwdV+WCjsU+d6EruFJcZmR1Cf05tHbJ1ovA/U/mQxx9fhRWES/eQU/OMTucPqNRETJHnsWUxJPmM0hmnM/UZueYMpxuKHF0r4EBxqb0TApDoXbyu+b0ITXhQK8gEeM+62sctOJhvS2OERZUvfNwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546085; c=relaxed/simple;
	bh=GuIXqPY2qhYQMhmDddEl4UTCp16T6R00A7fhA2qXyWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6+jr+BjNx4WkMCf5PEmF8DyF2ZL5/61m5D33tteooN/Yapg36ztVx2zPp7M4y7bOVc9RelMsGOxYr1aSdhwTcUt/FrWkgIHu4qv0egeiITJF5s5HiiZnnHHsNUB9yteYTM4JstxxMWtIzK0EyrAuggdOwLkt4doIAVp+KBXSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=COIYtvw5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDDW1hZC; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="COIYtvw5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDDW1hZC"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 283FD7A021B;
	Mon, 22 Sep 2025 09:01:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 22 Sep 2025 09:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758546081; x=1758632481; bh=MZXFmaN4CY
	iv2EVxEy/omr2vz0RLvLyr1iUhPZqTMbM=; b=COIYtvw5XsWbu+4rsE+RPsewUw
	rc6sL4L7dxJIZH46Uzxt6n3gY3CnD5Dg+oCaA81q3Z/0gxmxnnh4iGK9M5jf5IxB
	YE1V8eFbCISJFw+GV04QixFb9Ni11TWb8Yd1POE+t2o4BxJPy4vqK03z+wotrVKZ
	PwTCBiXqMT4dnzXQ2N5M8tu1moN0AgkrCgTHOC5hl1sTgv4g3huRkjDihz6ry+qa
	VCXGHWESCxdztZbW0q8Pv3cCY97UIK0WjJP8p/OiTIiBaadoGKVNUJUIqgSHZzsk
	riDLUeZjcu4HMRfWClShxCBlulv/vEk0jOgU4TKQHS6xeffi8lqEfM4+Q/Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758546081; x=1758632481; bh=MZXFmaN4CYiv2EVxEy/omr2vz0RLvLyr1iU
	hPZqTMbM=; b=KDDW1hZCCxBcglwiUZRPw6QHF+Cwro7ERxFREz8fFh9FGZRJZUb
	jUeikNLzIZy0O6x08xIeqgzWGbf4Py+BmDqtDguqTiic6RAJG9N4vVuylYaSoJFj
	powOstj1hF6fe0qP587Ffh6ah0KrtSonjjRnTnFdFvoTHiWZRB8dAINt6vy9s9Xv
	EokJwiCWx+oMXDfAGPh+D5eFnP79iLgcsJOK9pjTvB9SUjDgQXM3xfSlAEd/dQiN
	Ngn/WPrBRkX6jA2ds1xgjAnI1oVMCrR0OBZiViKCh4FDZGCGizuU0B/1pzuHWNHs
	c4HtYKa+H6vRSUrlg37Re9cd7lsD358QDFQ==
X-ME-Sender: <xms:oEjRaD-52NLfmY_v3dn6ao8Z3XJ8lCvsvSYZ9T3OpdXanzBFQSU-DA>
    <xme:oEjRaHmEdP8gaQU-OcjJtqPwoxAWc0AO6y_1sBXzx63Esbgl99L-zxUKGLJsliB_0
    ihCWAKHjxeptbYZsQ>
X-ME-Received: <xmr:oEjRaAZ94DQntQ0U52q9psrpK3NYJ7egxwJwjDZ23CBhmPGbz93ysZ0VEh2SzHjDoqhWFSmig8GAExJ4BrP1tm_4yVDoEAxCpthdU4k9pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhesghgvnhhtoh
    hordhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohep
    phhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpd
    hrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oEjRaHMnwr0F6z3dqZKL8JuMsxCyaOF0kYipoMSEEpRMz6dI11_-Pg>
    <xmx:oEjRaAdcpjL3xPrHnfgEU72YK9k5SctMFsr7nQe7Mz24fsZ2ibUoMQ>
    <xmx:oEjRaNGU82XTeDyZrNcWst7uRdAfQTTKar5TiFw2f7JwOpGNqt1pug>
    <xmx:oEjRaLtufIBx5_3euJZuomKEnh6798KCkJnVeLfj-tYEWc4o-J-GAg>
    <xmx:oEjRaBnZ-F3OnaMO8dLzabK8xYUzIeyke8PHOQZ6pDDWhtZdM7Z_aw8R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 09:01:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3798cddf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 13:01:17 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:01:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
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
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
Message-ID: <aNFImn9toejLzIJR@pks.im>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
 <72d0a316-ee3d-45a0-8122-77c52911614b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72d0a316-ee3d-45a0-8122-77c52911614b@gmail.com>

On Fri, Sep 19, 2025 at 02:59:58PM +0100, Phillip Wood wrote:
> On 15/09/2025 12:22, Patrick Steinhardt wrote:
> > Over the last couple of years the appetite for bringing Rust into the
> > codebase has grown significantly across the developer base. Introducing
> > Rust is a major change though and has ramifications for the whole
> > ecosystem:
> > 
> >    - Some platforms have a Rust toolchain available, but have not yet
> >      integrated it into their build infrastructure.
> > 
> >    - Some platforms don't have any support for Rust at all.
> > 
> >    - Some platforms may have to figure out how to fit Rust into their
> >      bootstrapping sequence.
> > 
> > Due to this, and given that Git is a critical piece of infrastructure
> > for the whole industry, we cannot just introduce such a heavyweight
> > dependency without doing our due diligence.
> 
> I'm not sure what you mean by "doing our due diligence" here. We already
> know that requiring a rust compiler will make it impossible to build git on
> some currently supported platforms. Isn't the purpose of this patch to give
> them notice so they have some time to come up with a plan for either (a)
> accelerating rust support on their platform, or (b) for how maintain the LTS
> branch after the we stop supporting it?

Yeah, I consider having an announcement of our intent out there as being
that "due diligence". The scope of breakage may be much bigger than we
currently anticipate, and if we eventually see that a significant
portion of the ecosystem would break I think we should take a step back
and reevaluate.

> > +1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
> > +   disabled in our Makefile so that the project can sort out the initial
> > +   infrastructure.
> > +2. In Git 2.53, both build systems will default-enable support for Rust.
> > +   Consequently, builds will break by default if Rust is not available on the
> > +   build host. The use of Rust can still be explicitly disabled via build
> > +   flags.
> > +3. In Git 3.0, the build options will be removed and support for Rust is
> > +   mandatory.
> > +--
> > ++
> > +You can explicitly ask both Meson and our Makefile-based system to enable Rust
> > +by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
> > +respectively.
> 
> This is helpful but ideally before Git 2.53 we'd make the Makefile and meson
> print that information if they fail due to a missing rust compiler.

The intent here is to allow us a bit of time to iterate on the build
infra before making either of the build systems error out. Ezekiel has a
bunch of follow-ups that we'll want to land to also unblock support on
Windows and to implement things we don't yet have, like Rust-accessible
C bindings.

Is there any particular reason why you want to accelerate this timeline
and make the build systems error out right from the start?

> > +The Git project will declare the last version before Git 3.0 to be a long-term
> > +support release. This long-term release will receive important bug fixes for at
> > +least four release cycles and security fixes for six release cycles. The Git
> > +project will hand over maintainership of the long-term release to distributors
> > +in case they need to extend the life of that long-term release even further. In
> > +that case, the backporting process will be handled by these distributors, but
> > +the backported patches will be reviewed on the mailing list and pulled in by the
> > +Git maintainer.
> 
> Didn't Junio have some qualms about the last part of this paragraph? I
> thought he suggested that once we hand over maintaining the LTS release the
> people responsible for it could use the security list to coordinate their
> work and would be responsible for pushing fixes the the LTS branch
> themselves.
> 
> Thanks for working on this, it will be good to have a formal plan in our
> Documentation that we can refer to.

Yeah, I addressed that feedback in [1]. Junio didn't reply to that part
yet, and I didn't have any idea for how to improve that part. I'm happy
to do so though if this still feels problematic to anyone.

Patrick

[1]: <aMfwGHL7dh8dk2cQ@pks.im>
