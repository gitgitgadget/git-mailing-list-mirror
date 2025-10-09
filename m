Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D839173
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759987388; cv=none; b=Ft1dPbygSvAXmRRLnwoe5M/LDQ/BmZ8b0SA8SDTwMHbAAyap3LZGq6viIYgMz+IzWIO385tjRUxplq59yfuvyD/S2NPPojs34BLkxOpRa11cMOMgaLqDDM1VYxYOVNWdEdknN0CGg+whTxw1FLN2lpijpDVSCK8BXKDbaUkdvy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759987388; c=relaxed/simple;
	bh=mbCkcdUnzzZKmfHMTjIX/b2NunoY98yALBEOY63FiBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAyV9n+yVSuQ7tiY/g16jXojMZS64sR349sNnvdlt7CJI63Z7WJXAK4LPji285sknAoRKnkCek4c09bofm6fLYSm7vNa6TQYsbYTB7eb041gSFHxHU0Or5Gmo338OdIjF5sA0ZHCiRRwDw+G6dADpudpgbdsFL9xMbyzxSgIClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KJbGYRVk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZUXnxGab; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KJbGYRVk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZUXnxGab"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A81AB1400077;
	Thu,  9 Oct 2025 01:23:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 09 Oct 2025 01:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759987384; x=1760073784; bh=74EJ0fTnNv
	74bkrPCeGA9gN0uCD+XSv90Q+c+V9YYQw=; b=KJbGYRVkkJ8wwv4F3MegkZDhVP
	N/UDyhTfuwoZ9g8d75a06eygYrOLoQ0esjC17XQSjV/uh8QPP854mITv39qbLywh
	CKxuvoTQWx//rN3rb6L/g2DEZmwp1HOeFIo7dqF78gqCYrDsjMa6yP0DYI9GEsgN
	Z+v+mBZYo5P7sMhlrwJ1ObkGbMtGV0uL/xZVbafwRUqlh4r3ZVK1DCkqaOTlFR1q
	yDkQDHkl/RK4vrTlRLUU6oTIOH8GQKFPIoy4A/Fp5c4m3Kokk4LFllBVlaXO0uPY
	r33JLLHlMCBg4/hYxzB7BqO6Q/sUvdOFGt7w9Qmp0mT1CipjGrwRTdqZBmWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759987384; x=1760073784; bh=74EJ0fTnNv74bkrPCeGA9gN0uCD+XSv90Q+
	c+V9YYQw=; b=ZUXnxGabux1ZPHfSpW8dRHxz9jfaJrVju7hZw80/8mbCy8vP+v9
	DNTJ+tqneBJV+1hBM3tKsOJlDjwtTPzbJ+XOswmIJlk3LjXMJFpTAieICZnH1eAe
	xuwziC6MiWkfW0BtvVTy0uHdmChqooGRosrqdYmJscOR+XCgA4Td97ADuHL/Pgpe
	iurV1K0iUQuNBp6slD/c4YF1qJgEAm09xJ9JakpAVEIxkKFb+fRKdOMsX2sFOtL1
	yUsqztzGX7R2pM4y3YIVLS6Mx2KIMrFmy9sphBCXxYr9cGCdD1II2Nonw7798ezU
	8yaHPLdB09d+fG0o3kvReQYyT2qUZ8XtbFQ==
X-ME-Sender: <xms:uEbnaNMU2roBReam0pHx6VORNZ5T2CaYxJIyasmabWXpUryQ3lYuPQ>
    <xme:uEbnaCN04qiqu50I8pyJ6BNz2hu6ZcdL--QHikxgs9j7S2idkTDqKJCDxOiRlH-vP
    6kbSCdvhZSD58SwoUrFMdTht8Q-iI607gQHa9CJCbeCJ1UHieNdFg>
X-ME-Received: <xmr:uEbnaOjASrLRoJgpb4qdP2lhvvKJl9emQXurDqfXuH4tLb9QfP6NUnTwiOcvFMqupxPl8xNMPBYDW6vs57eKM32agBo8Uy0BxvcUk7CWuXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uEbnaPsAtKdDX8ooIx6JyvwCbzCMqDjpAA7DuceBO0Ln0kg4wPlGGg>
    <xmx:uEbnaETBnvmU2F-jDUVzLphiNXjDWMEdiQqyCKa86sJTiuAi1Z_L6Q>
    <xmx:uEbnaL3BOF8qqzhrM1yaRNZNhDx5jBXOe0iJBlaRwO33Cdqe9PywGg>
    <xmx:uEbnaBunUH3tFLDXjP7VSYds3akScf63zUgy8lEw01_1Q1DXxHyiHw>
    <xmx:uEbnaB0ccf85p1rw8Rw_IBjXz-kj2u2_QR76uFG4rIMonCV20HM_2ih_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 01:23:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99f1610f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 05:23:01 +0000 (UTC)
Date: Thu, 9 Oct 2025 07:22:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 12/14] refs: don't store peeled object IDs for invalid
 tags
Message-ID: <aOdGsqgyy5K6Lynu@pks.im>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
 <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-12-76e30d5c9542@pks.im>
 <aOaRDhwZ0YkPdjkd@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOaRDhwZ0YkPdjkd@ArchLinux>

On Thu, Oct 09, 2025 at 12:27:58AM +0800, shejialuo wrote:
> On Wed, Oct 08, 2025 at 05:50:27PM +0200, Patrick Steinhardt wrote:
> > Both the "files" and "reftable" backend store peeled object IDs for
> > references that point to tags:
> > 
> >   - The "files" backend stores the value when packing refs, where each
> >     peeled object ID is prefixed with "^".
> > 
> >   - The "reftable" backend stores the value whenever writing a new
> >     reference that points to a tag via a special ref record type.
> > 
> > Both of these backends use `peel_object()` to find the peeled object ID.
> > But as explained in the preceding commit, that function does not detect
> > the case where the tag's tagged object and its claimed type mismatch.
> > 
> > The consequence of storing these bogus peeled object IDs is that we're
> > less likely to detect such corruption in other parts of Git.
> > git-for-each-ref(1) for example does not notice anymore that the tag is
> > broken when using "--format=%(*objectname)" to dereference tags.
> > 
> > One could claim that this is good, because it still allows us to mostly
> > use the tag as intended. But the biggest problem here is that we now
> > have different behaviour for such a broken tag depending on whether or
> > not we have its peeled value in the refdb.
> > 
> > Fix the issue by verifying the object type when peeling the object. If
> > that verification fails we simply skip storing the peeled value in
> > either of the reference formats.
> > 
> 
> I have a design question here: should we just report an error to the
> user or just die instead of skipping storing the peeled value? If the
> annotated tag is corrupted in the first place, it means the refdb is
> also corrupted. And "git-fsck(1)" would definitely report an error to
> the user. But here we just ignore the problem and give an illusion that
> everything is fine.

The question is whether the user can do anything about it. The tag may
exist due to whatever reason, and it may not be prunable from the repo's
references.

Tools like git-fsck(1) should definitely complain about this, and they
in fact already do:

    $ git fsck
    Checking ref database: 100% (1/1), done.
    error: object d10476e1da82e779f64cfa12bd655b579c3fddbe is a commit, not a blob
    error: bad tag pointer to d10476e1da82e779f64cfa12bd655b579c3fddbe in ef5b01be3c1ad24fae2181040ced5776456a197a
    error: ef5b01be3c1ad24fae2181040ced5776456a197a: object could not be parsed: .git/objects/ef/5b01be3c1ad24fae2181040ced5776456a197a
    Checking object directories: 100% (256/256), done.
    error: object d10476e1da82e779f64cfa12bd655b579c3fddbe is a commit, not a blob
    error: bad tag pointer to d10476e1da82e779f64cfa12bd655b579c3fddbe in ef5b01be3c1ad24fae2181040ced5776456a197a
    error: refs/tags/tag-2: invalid sha1 pointer ef5b01be3c1ad24fae2181040ced5776456a197a

But for operations like optimizing references it is not as clean-cut
from my perspective. We definitely don't want to error out, as it would
mean that the user cannot have their reference optimized as long as such
a broken reference exist. And other operations should make sure that
they don't return invalid data in face of such a corrupted repository,
too.

We may want to add a warning in such cases though? I'd like to have some
more opinions on this.

Patrick
