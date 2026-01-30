Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D359C350A36
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777883; cv=none; b=BSmV42JRMPJKq5akkzFU4HxCElGlPzHBx1NSw4kHS4lJPfNV3NVIRmUkT0tRbPRCuJfyHxrX4/I9uh3i57P/oCpWKsGP3FmA/2bRamHS1d/5q38lsmIzINrQ02eCZGmY8JU2Fvl4cDy9eLZkvTnTUuXzVLgbskV3AGt1rW3Tyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777883; c=relaxed/simple;
	bh=Be6XPUslAHD7ZviZiJCe5s8GTUcUgq6vDVEz2a1qwwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asw7Rn79CvlbOa04ywTUTJtxPwMYNRBJQBozBgPOxGnUMuhoQGff74xchBPPL7+fIvsdqeo25F++WAJk5FC24SWtBJUrQTbTzL9R6XNZOcRZ/qKvcEOxOQi18AvKgt5uzb41MZ4DEezazzWBPX94aDZI9ls9E1yS1YD1grYtsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oU/0wBzo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NNFiRngR; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oU/0wBzo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NNFiRngR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8D59140008B;
	Fri, 30 Jan 2026 07:58:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 30 Jan 2026 07:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769777880; x=1769864280; bh=0JoetKf+HP
	qjS5Wah02crvnZ+n9KKvtl5DEYRmyzNaI=; b=oU/0wBzo87O6HhhjNRpBDPpKFa
	TjAaPMFFftPIgjD0KHncn3qQQ2yPLR43V99VMGb0g5UenRm1q+tuVjC/7uf7mC38
	i0v5fpbwNZe4CXxgABrxO+M7lV11t8LvI9LLN9X8zY3WUActVNdUr5gClwAPJSJz
	nHx9hbCXank+NwHQZ6WiMzlKOfif93iPyC167vcpRTT5GlXFLdxwmY5h03TZl6tL
	Mxv4mTg9qXe/wwPca6WDsU5TO/3QW0leu+I0K+pT/NECaK2EV2VdmaDfnCN34rbn
	flELWoH3MnQuL1AzKWG9PmyTn40AR02FdVPKr8sfft0qo3wDwaZSEPuOAYcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769777880; x=1769864280; bh=0JoetKf+HPqjS5Wah02crvnZ+n9KKvtl5DE
	YRmyzNaI=; b=NNFiRngRGWljuVhz6uxfzIGAuZsHT1VDHSU75/byXNu6IITIt9s
	0U81/Wbj9+7ZvfRQxa6piSSR3gw3+B/YFHMT51y1xX5OeJV7j27+vfqlDC9+JynB
	scME0AOwPwXE+BxxjgRdMCu6eKckhoBB0gaVMXXxnxXjHBB3+ocF41VqCVWX8ZEW
	j5cuS5hdZ+nIlAIdly7nprwRx03D2cDm4gFxPEtksis80UrnCz9FjK7cjnWcVlNF
	TwhQbC/N5Jid1ipDki2NQCksZ/59t/B2Iu2Z2OpboS17VTuVEuZC/f6IB4omvDpg
	ABUl6KEcw60fQAZgOFFDIo9I1+VwrS3wcuA==
X-ME-Sender: <xms:2Kp8aXCgTqqoeqlTgWsGwrxzsdlS_DHZymkla7BYfaClgrm-BybKig>
    <xme:2Kp8aV9KonfjmlqCLy4ciR7bJ-c8XUpkeSJ_gpG7-H8T-N09erOcedlH91QwVdm9Z
    UvPD25os-kSUbJZHTw3KKwvmtDN7T8E4oiUGM77aqdQfqlXmoBLhg>
X-ME-Received: <xmr:2Kp8aTB0bJQXu7bDZZJvWZMgpv8Y2S0McTEqKNxL0gpRjG_d4FSwL59is9zukpYYDyn8gi0XVHVOzSSFkHjF4Ql_7Fk6pIoK2wulVrXAQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeluddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:2Kp8aaRnRsVT77y8Jh684rQ967Y6u1LqYwUtBIB6G3EuTVOt8vFpyA>
    <xmx:2Kp8aauXd5LntJaUI1M16JkpU5A7UXA5fhMSev6dmpY1VPRD6vw05Q>
    <xmx:2Kp8aW2s2_ixbOneA7_NazMGuZ7IIohXKeILKFEO5CWwZgDoW5SwWA>
    <xmx:2Kp8abVcvMuy1C6vZGeCXus9N7qFUGeHb4u1gDugMeZgaT6F6Ob8jA>
    <xmx:2Kp8aZbHNlr1oQh3yboCZcLsX2nKeH5CFCvXyISyESp6XeMWQZESHrLy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 07:57:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4df818c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Jan 2026 12:57:57 +0000 (UTC)
Date: Fri, 30 Jan 2026 13:57:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 12/14] builtin/pack-objects: use
 `packfile_store_for_each_object()`
Message-ID: <aXyqPhWDNeKJv2re@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-12-12c4dfd24227@pks.im>
 <aXLNM+AOpdQtmisC@nand.local>
 <aXNCtCZwP57Tfu60@pks.im>
 <aXO/YLzRlDXD5IPY@nand.local>
 <aXcrftLpfcG4S5AX@pks.im>
 <20260129110839.GA1285720@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129110839.GA1285720@coredump.intra.peff.net>

On Thu, Jan 29, 2026 at 06:08:39AM -0500, Jeff King wrote:
> On Mon, Jan 26, 2026 at 09:53:18AM +0100, Patrick Steinhardt wrote:
> 
> > > Yes, the end result is the same, both your patch and what I wrote here
> > > implement the same GC-specific definition of an object's "mtime". I am
> > > not following the argument about pluggability, though. The concern I
> > > have above is that we are pushing domain-specific logic into the object
> > > storage backend, not the other way around.
> > 
> > To expand on the pluggability bit: every time you add a new backend
> > you'll have to extend the above logic to understand how it represents
> > the mtime. That by itself might be doable, but let's for example
> > consider a backend that is a black box to us (like a shared library that
> > may plug in arbitrary storage logic). In that case you would not even be
> > able to derive the information unless you have a generic layer that lets
> > you convey it to the caller.
> > 
> > So overall I agree with you that there are nuances here, and that the
> > mtimep pointer _can_ be used incorrectly. But I still think that the
> > concept is generic enough across backends, and the refactored logic
> > still works as extended. I'll try to expand the docs and commit message
> > a bit to cover this discussion.
> 
> There's a related concept that I saw while reading some of the earlier
> patches. When you converted fsck, I wondered how you would handle the
> call to read_loose_object(), which takes an actual path. And it needs to
> do so, because we want to make sure we are opening and reading that
> particular copy of the object, and not one from elsewhere.
> 
> The answer is that you punted on it for this series, and we still get
> the path via for_each_loose_file_in_source(). ;) That is OK, but I think
> it will eventually run into the same issue: we will need some kind of
> cursor or context for the iterator to be able to get extended
> information about a particular copy of an object.
> 
> I think there are probably two approaches here:
> 
>   1. The abstract odb API tries to share as little as possible. It gives
>      the caller back an opaque context struct, and that struct can be
>      handed back to the odb to get object contents or other information
>      (perhaps even an mtime!). Under the hood for the current odb
>      implementation this is probably just a pointer to a string with the
>      filesystem path for loose objects, and the usual packed_git/offset
>      pair for packed objects.
> 
>   2. The odb API provides a set of information that a particular backend
>      _might_ implement, and callers can poke at that information and
>      decide how to handle it when it's not available. And so that might
>      include a filesystem path for loose objects, which some backends
>      may choose to leave NULL.
> 
> Option (1) presents a cleaner API for the odb, but it's also more
> restrictive. Anything that a caller _might_ want to do has to be pushed
> down into the API, and it has to start learning about things like
> mtimes. And how to decide what "mtime" means for non-filesystem
> backends.
> 
> Option (2) pushes more work onto the callers. They need to not only look
> up the mtimes themselves (like they do now), but they have to decide how
> to handle the case when no path is available. Which in the worst case
> means a special case for each type of backend, though I think in
> practice they'd probably fall into rough groups.
> 
> I think one thing that appeals to me about option 2, though, is that it
> keeps a lot of the specialized "business logic" together in those
> callers. Most code doesn't are about concepts like mtime or specific
> copies of objects. But when it does, like in repack or fsck, there are
> often subtle assumptions and interpretations. I'd rather see all of that
> lumped together in the fsck code than have it split half-and-half
> between them and the odb code (which is really going to be some backends
> idea of how its concepts can be shoe-horned into the abstract API).

Yup. One thing that I'm planning to do in one of the subsequent patch
series is to expand `struct object_info` to handle this.

Right now, the sturcture contains a `whence` pointer that tells us which
backend the information is stored in. But that concept can be extended
to surface more info: instead of only telling the caller the type, we
can instead return the actual source that the object has been looked up
in.

Furthermore, the `struct object_info::u` union already contains enough
information for us to uniquely identify a specific option. So what we
would do then is to call `odb_source_read_object_info()` on the specific
source and pass it the union.

The loose source wouldn't have to do anything in that case, as the
location of the object is deterministic and there can only be one copy.
But the packed source would inspect `u.packed.pack` and thus know which
specific object we refer to.

This still hinges on a couple intermediate steps, but I think with this
plan we should be able to handle this issue in a way where the caller
doesn't need to know _anything_ about how exactly the ODB source itself
works.

Thanks!

Patrick
