Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BECF230D1E
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767944258; cv=none; b=GnibT7auirqAnvTuYKs8bYFLnOJcBP2Skb6dR7Oeuu4yMRwQGJvXsLzrctnF2vP0Vc8jjpuiIK+yvonJL8i5h8DfnM93tE1JSp7nrewsdMSDUDgGAez+ElOpz0yVx9gjPmFWpJr/MBd2ZgSvUXVFogDK3u5soK0CUbnbMHOf/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767944258; c=relaxed/simple;
	bh=wWKZrvmABU0bCyczHijLbxJ5ycyP8utsw9bwxBjiaAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUY15cwZe8x3IcOFiczHnBhNRKPJbNn5FSweIh5GznOdQ0fUjCXTniSLbIb0Y2CHJ6vgP/grjIiFwNOATTmbt16CEbJ69hGm912EFpitYX37iPzYHsmf6Cl7Fm4LM77bY2pUrTto65NOESOgXPAV610Pq/8d4yK6O/BEgvETi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZmMySn+x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pxfuIvcF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZmMySn+x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pxfuIvcF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C1FBCEC018A;
	Fri,  9 Jan 2026 02:37:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 02:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767944255;
	 x=1768030655; bh=2hA60u36G5MNRcSG4u05r1kDWtEkWtvFQ6qR2s7VXrI=; b=
	ZmMySn+xey+6CYBZY8nRgjqrGeEq+0gPEBvWG3+1+N+lEo3mXQvMSzvWURomrBAd
	294uUgDLTpm1Tzjh+mgKpSahWWiz4ZCP+TygEccNT0cp3E6jpO5ZeRAXeWkuKpK4
	6D578DLkOO7/SDj2WO8M5hHt0maFuQuDJ6hmvqb+XG3ZUbUlfrAXBgwiKBLdiORE
	lVLWbsJ2XnhT0eM+uXtLwEs9YjlxWCsfnLN6IolWOl8oXfRnE1FNlYyitHr2Vucp
	Q0RftJUrG+77GABHWBqbqAkGbWu6QFErx94K5co7EJvNv6XAEXcccxLW5ekW8pOI
	CPC1DRMyzEGNWtBDftRzdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767944255; x=
	1768030655; bh=2hA60u36G5MNRcSG4u05r1kDWtEkWtvFQ6qR2s7VXrI=; b=p
	xfuIvcFlIFB/AEzFeCvx0paSFTX3wg6XXeXjQh2AVeW3v4TjFM66eWVfXEB4D9pp
	Qgq7HnnL4N+arZNZcVgRBXMN21ZpZ9tJqrFr2YxkqyqC6dwgjnCwLyFfiFB+1Dce
	jysYQODhR+IeaL5y9Lh30VrPMrhY/c7B9RAnWak7eYQBsnyuKVjmqSS7WTbeLq2m
	NQJQh9TIafCfU9VKl273kpIkOxADTqYYUOUaQ2MiUClXBvwdXvYm6UYjJ4mmYGOQ
	Lp88RNPfnCjSAm6NLxmsBa/g96q4B4RH44aIIpHAmoZrpfsZcMtJpa14vNPgHTUP
	M4BSuqTlLEO74HVW8ld7Q==
X-ME-Sender: <xms:P7BgaS3C6ysaUAtgtnTnYHP4pzmjVD2baocDD9KY4G-YBmNl-SLg9Q>
    <xme:P7BgaQ6Gg0i0hAeLBVFa4fq1gLINcA4uhXHvDAfwWJXnrHo6Hrun9fRkSYTSI-tat
    ZZxOiv3EB9wCjlqI1mv345fQVTqerobGetE4ifQ8N1svaAflAtxHA>
X-ME-Received: <xmr:P7BgaWThqYsYAI93ghIKPS_qc99vgIkRcKIaiRvIAc2joYmdEVo2pmJA5pvT1ZV0PpiLZaCZbaI55x7RZnlbDwNh6INUbhysCpIpa2JP8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehm
    rghilhessggvhigvrhhmrghtthhhihgrshdruggvpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:P7BgadUMs8qvYnpZz29xlkVpGw8JM08e7otTJHRiliNJHbvhd183TQ>
    <xmx:P7BgaTFrqvzgFlWZlVOG4jLjZPqTTXubhd60SvRHZ2bAkSV9ZuXwTQ>
    <xmx:P7BgaYd7CCvK35sMmAKe4TgTtU4jV93V1HRNTl1UtZy05BWd4o0K3Q>
    <xmx:P7BgaUrwpK22re2iL3sUN4y_OQtno2rG0Og-L2Z5GLNy0My40vv-bw>
    <xmx:P7BgaZ0TRJHeebBcBm-oXcSxYs74BZQaN-Q2WeajhQ8EakcLkvJEy0Xt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 02:37:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2af2c48e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 07:37:33 +0000 (UTC)
Date: Fri, 9 Jan 2026 08:37:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v8 7/7] builtin/history: implement "reword" subcommand
Message-ID: <aWCwOjKG_ZwqPCpz@pks.im>
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
 <20260107-b4-pks-history-builtin-v8-7-18e9779e3a26@pks.im>
 <CALnO6CDG222mhCeWyBCpGU3fQiHPVwBh=5EygRFrFN3JOcx6Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CDG222mhCeWyBCpGU3fQiHPVwBh=5EygRFrFN3JOcx6Sw@mail.gmail.com>

On Wed, Jan 07, 2026 at 01:01:11PM -0500, D. Ben Knoble wrote:
> On Wed, Jan 7, 2026 at 5:10 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Implement a new "reword" subcommand for git-history(1). This subcommand
> > is similar to the user performing an interactive rebase with a single
> > commit changed to use the "reword" instruction.
> 
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index 5a9d931efc..4eea317e5c 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -32,8 +32,9 @@ Overall, linkgit:git-history[1] aims to provide a more opinionated way to modify
> >  your commit history that is simpler to use compared to linkgit:git-rebase[1] in
> >  general.
> >
> > -If you want to reapply a range of commits onto a different base, or interactive
> > -rebases if you want to edit a range of commits.
> > +Use linkgit:git-rebase[1] if you want to reapply a range of commits onto a
> > +different base, or interactive rebases if you want to edit a range of commits
> > +at once.
> >
> >  LIMITATIONS
> >  -----------
> 
> Ah, looks like this commit fixed one of my befuddlements during the range-diff.
> Bad history edit? :)

Huh, something's weird here indeed, the range-diff and the actual
changes do not match. I use b4 though, so this isn't an issue that was
caused by weird manual munging of patches. Hum.

Well, I'll not go down this rabbit hole today :) Thanks for your review!

Patrick
