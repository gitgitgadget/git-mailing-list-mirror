Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E819CC14
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770878274; cv=none; b=KIqW0g2h/Wi5BIj3iqMyDs1/actYKZtSHggNIOEiVUzZucDNPVb/xKy+o3b6098zm+47nS9cKAvloO+2V1nb8R5rvk5d3Ngwuh2ZRHw6LjtcTbLoLbDyZM9mXMIrXwKTuFEulSUuYye63iPK5YrXw6lMgEkhnxn88ZwGsAN/oBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770878274; c=relaxed/simple;
	bh=fR1qK0M4WStquVW/bZ36dMKk6r7bW5lW209jM9kj5KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkfE2ygr4NO7BEUwQsFv7+PrOnuQpQLEjYDLRfWOQpw8IhtPl2tZlRqWE4AVCwFIdgWkwUOe9nPbeGj/7rNNJJxSk439ZJYLOv2QG5cIkfMZmo7c9solzYUKIhDk/Pf61c1+6h35L9R5mokDY/huPOvzPRGpqX383r22YZYlxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LYYio1xO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODZmG67K; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LYYio1xO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODZmG67K"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 044F3EC05EB;
	Thu, 12 Feb 2026 01:37:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Feb 2026 01:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770878272; x=1770964672; bh=k7FR7C4xKW
	VR9yQy7v6jdiCbER4mTgYSeMfUJG9jS4E=; b=LYYio1xOjmXvkACWcOdMqRUH3x
	rtPqXPMGYZi0fAMgqeYWDuGkXjVI5vmrawXheNDvvBTYBttk68VzenzqSYShC0/B
	MJaHM3Kz0yH1UZuS+X43sGqrx40fY3T69AmgGSxptZNA7POns4RneG+vsDb3q8l+
	qHUKEHhQHr0/33yiCYG5zGJav7+7wJw5uuuf9DFgtp+gtlwWVd8QUd9BSmxIFo3+
	9IhDN6plamRgdf5s6eHgc70OlbWiK4/V98dj09pJK7CsFW/0iLKWxuHHbnMRpUDM
	A8iIfWqgOgKfVEzz87Y069LO1L3hgjgDY3axhSyzZresyIHRiRdD+yskfPOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770878272; x=1770964672; bh=k7FR7C4xKWVR9yQy7v6jdiCbER4mTgYSeMf
	UJG9jS4E=; b=ODZmG67KZxKyaDLPX132iJb09Yc5LletvHow87Tn0aTOrOxh0dX
	UpCaLaRgVoOFeNuNleP8+8pyJAnGUQlzpKOeLc+XuPnxN8tYXMUC8aTMXWNDDDRT
	6tMCw+laCC4yyDpSAHRkDsWUUwnxQHUkxrJ3ndPLtBuXgI8sGiC3DQDJqqFfIHw3
	KmIa764P7cfnDRpqNnNAWGW38rNN/691W60wnDDckc5ky4xox4NzJNOD4qdmOsyO
	VCCNECU7I8FG3RpjPyQzMeBHtfAdt/V7WBlHPMb1HiPyrNUSxdPyOzy0kmpkAavV
	z+dmxikDmiOWFQhHe8M0zNQFRek3Sb3YHWQ==
X-ME-Sender: <xms:P3WNaReISWF2DIH2gqLFY2jHB3n6ABg75pHH6vW3OrIc8yOtJkA9SA>
    <xme:P3WNaWqTmZWAOhrH-tstEyzADvLZHendXImfOYYkp07IE6PST21nsYMO__tUwT7K8
    VTuaiFIFzCoqCEZqrvRrrr60mk81-E1WKv3wrRorCITf5r6kXzvtw>
X-ME-Received: <xmr:P3WNaX4IC7NYQJ4mwiixeP0J4pegOWVsjqukU2Fqs3-oA_q20L_po7ogCHrGectAADUL7ea_ySm4JCGfYVmbdjAvUI-ZoW7qE7YKuY18DTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhifrghnkhhosehgihhtlhgrsgdrtgho
    mh
X-ME-Proxy: <xmx:P3WNaUpVRiaZH4g3sVDhm2I6Ok19YllAocsCDV9XS88g8WwRdnzDsA>
    <xmx:P3WNaRhILLNipe2kXrB-9hH0kyq9O9iMbJmK11L4pgT1v_XODmWlhA>
    <xmx:P3WNaWLDUWOqtF0yk86L8_qCDGruqHcWrQm4DjmnhYfRx6ke0vmTtA>
    <xmx:P3WNaZBGhUe4d2mLtrUIg_e6nid1dBXqlxDCxf3lag-VBSkHyUdIEw>
    <xmx:QHWNaSrmj4YagWVxFSnCBThAlbfMDb6HkmPmRdFbaRKhhRvagNRaOrSN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 01:37:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50c54090 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Feb 2026 06:37:50 +0000 (UTC)
Date: Thu, 12 Feb 2026 07:37:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Lukas Wanko <lwanko@gitlab.com>
Subject: Re: [PATCH] builtin/pack-objects: don't fetch objects when merging
 packs
Message-ID: <aY11O5pc1Sty7IaJ@pks.im>
References: <20260211-pks-pack-objects-stdin-skip-backfill-fetch-v1-1-870cad56d8ae@pks.im>
 <xmqqseb7urg3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseb7urg3.fsf@gitster.g>

On Wed, Feb 11, 2026 at 09:21:16AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "--stdin-packs" option can be used to merge objects from multiple
> > packfiles given via stdin into a new packfile. One big upside of this
> > option is that we don't have to perform a complete rev walk to enumerate
> > objects. Instead, we can simply enumerate all objects that are part of
> > the specified packfiles, which can be significantly faster in very large
> > repositories.
> >
> > There is one downside though: when we don't perform a rev walk we also
> > don't have a good way to learn about the respective object's names. As a
> > consequence, we cannot use the name hashes as a heuristic to get better
> > delta selection.
> >
> > We try to offset this downside though by performing a localized rev
> > walk: we queue all objects that we're about to repack as interesting,
> > and all objects from excluded packfiles as uninteresting. We then
> > perform a best-effort rev walk that allows us to fill in object names.
> >
> > There is one gotcha here though: when "--exclude-promisor-objects" has
> > not been given we will perform backfill fetches for any promised objects
> > that are missing. This used to not be an issue though as this option was
> > mutually exclusive with "--stdin-packs". But that has changed recently,
> > and starting with dcc9c7ef47 (builtin/repack: handle promisor packs with
> > geometric repacking, 2026-01-05) we will now repack promisor packs
> > during geometric compaction. The consequence is that a geometric repack
> > may now perform a bunch of backfill fetches.
> >
> > We of course cannot passe "--exclude-promisor-objects" to fix this
> > issue -- after all, the whole intent is to repack objects part of a
> > promisor pack. But arguably we don't have to: the rev walk is intended
> > as best effort, and we already configure it to ignore missing links to
> > other objects. So we can adapt the walk to unconditionally disable
> > fetching any missing objects.
> 
> "passe" -> "pass".

Oops, right. Fixed locally, and I saw that you also fixed it in your
version.

> Other than that, very nicely described, and the implementation is
> surprisingly simple (thanks to a single global variable, and
> asumption that makes it safe to use such a single global variable,
> i.e., there is just one packing operation running at a time).
> 
> Will queue.  Thanks.

Thanks!

Patrick
