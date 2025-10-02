Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF930FC00
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404102; cv=none; b=Toe9cd7bwvbqrCZrxwURfn3obOB6OFD8GInIT4RN9VShY0eL1fCf4Bwur7We4CX6cASsnrjOdW60N2v+IjWpURaeQQUV9be8Xp1ZMmpt7SNMuYJmjukzzfh3JwFllKSDW8rQQZdfV1cFBYQM1eJfCNI5T+ihf/8lITcWdCbmCaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404102; c=relaxed/simple;
	bh=MPWTbvb5ts9IpxygY2m9UWkRwTw9Qm/3SFgsK8e5lpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohES4sROHaKWILBYalHnu9KvF8z2j6uax6QQv7s2csIYK5RpekVUZ15vJd2H8LeHOFvPf0qtH3PxZWKUbq2iHRGeFuFxzSfAlviHAMru2szqOBxvZX1n0AAfJt/WrI2AmjLkicZ/j3+PCCPZcBSH66OtTj4ypHXydn1MWqWN/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nz0qLxiQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rwvMSrsH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nz0qLxiQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rwvMSrsH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 570207A00EC;
	Thu,  2 Oct 2025 07:21:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 02 Oct 2025 07:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759404100; x=1759490500; bh=VxNLHNBqYy
	g5tSAV7AroDmj4Od/qmy6E3KiF3CJxLw0=; b=Nz0qLxiQg1CfEkfE24AX2mz+Fa
	xyhTOGgd3I5yhNNrzozSVaVUUpjRrlffJzdMYFwYU37mZESbYjmxmgd8SUDCDNeU
	zqAe/YvzS2PbOIYyEU0huCzclkrWsB/NO6Uts+ywhaGSo75JHec/MxKXd2GwYgWw
	zmPJL2HolDpZx+/rRNP3To9YYhjZk1VgGsVy6G6pzonC7v0kAga7ee5bDktkvVvS
	lCSOjhNob4vBUMlgMmBxluT+fqEgUa8eS3Y8SBkNN8PVJRQPBQpD/+RM8F0ITlaL
	afiJB5jqBS96CASm93nGt3UyVROw+kl5PslmPOEX4u1OAyEgXYkb/GWILqMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759404100; x=1759490500; bh=VxNLHNBqYyg5tSAV7AroDmj4Od/qmy6E3Ki
	F3CJxLw0=; b=rwvMSrsHqA+I7HLWM5tSuTzRcM29ufPdOuLAfCnYw0IewYwEJZv
	UB7U+zAmbZGR5y3WQW0T4MvSIQh3L8JkgX5yZwyj0eMhsPwkvsOTeHme76m8nRaL
	j1jX9qKUmvANe5KYnS50kJNR4YIJ1G0TKUPpATKlYnx33vfb4dkQNm9yHBYZKZGe
	gbtfReCTSlF7ZBBGGAG7pw5jqBYIOKKLUHpHG6h35oQMLM5bKwC1eosqidVBZ5k5
	GcTSJQ9y0dwss1Oe5R3tQZ+WbpfL+UuxjdkLfYkQsD4Z6/WFYXji4Wr4Xcf+ohJD
	0HJv/8W/1UB8RUbTk96H5SXefXqkVkedvBA==
X-ME-Sender: <xms:Q2DeaBjH1EWFQ6jxQVg7UBu2X4jPSSzG7Zd9vgZqDfwqhowaPlyA9A>
    <xme:Q2DeaNAVx6NCNJu0y0VV8ViF_Q--OOe_I3KqYb5ofpb9hUOxe6QeX4wObqzw5cry1
    7eR1Gysb8iAa50Aq53N1aLR-q9lEjzBINtrnXhwRuxr6dZb--gNhtY>
X-ME-Received: <xmr:Q2DeaGE3B4NudZdCUilH--xtIfWlRQUaBuommAonpbitMeegWU7k7Hnw8RiD0tROpx4LeXE2UnemltKGelK4q4-E7LyrDuaDBlMyvmQu6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Q2DeaFLIX0oKdpXhPDJH4w1yjPEGI5fB7qibYLF5MEAeyFXCrPCSXA>
    <xmx:Q2DeaKksmy3CwOqhIydqKM9C8tDmvlmWYLjlOJv4dBKJFM36okrOog>
    <xmx:Q2DeaNQnlN0Brk1qJjgvxFnRq56HBHPLbodwFjsrtSviuDgOBVcOBw>
    <xmx:Q2DeaMKAOIu6aX4JinVtsCl-sy8pDBQSlcqf5fw4_3haIO96hetuNw>
    <xmx:RGDeaLddhwNkwj0huP_-mVcrdwNd_yIrNP-mGIi6wG3yrzvVSjs4bg-R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:21:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c366c8b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:21:37 +0000 (UTC)
Date: Thu, 2 Oct 2025 13:21:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
Message-ID: <aN5gPoPC4WEYw9CF@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <xmqq5xdx7qx4.fsf@gitster.g>
 <cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
 <aL67U0-tw7O-y6_X@pks.im>
 <4e67fb02-bbbb-4cd8-9892-6f65b4f82b26@gmail.com>
 <aMFjGoPhGsRCTihO@pks.im>
 <xmqqo6qyfijl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6qyfijl.fsf@gitster.g>

On Thu, Sep 25, 2025 at 12:17:50PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > There is no inherent reason why a new backend would not be able to use
> > the existing commit-graph infrastructure indeed. But there are reasons
> > that specific backends may not want to do so. If objects are already
> > stored in a database table, then it may make way more sense to store
> > additional metadata that is currently stored in the commit-graph in a
> > secondary database table instead of in the commit graph.
> > ...
> > This is roughly what I have in my head right now. And I realize that
> > this information really should be sitting in a design document. I'm
> > working on that, but still need to land two more patch series before I
> > want to send such a patch series to the list.
> 
> So is everybody happy with this line of thought that makes it
> mandatory for each backend to decide and implement the commit-graph
> support if they want to?
> 
> My reading of the later part of Taylor's message[*] tells me that at
> least Taylor does not agree with that position, and I am not sure
> about this design choice, either.  Surely, each backend can have its
> own optimization, but looking at the way data from the commit-graph
> and other auxiliary data files are used to optimize real operations
> (like populating the essential fields of the commit object first
> from the graph, only to read other things lazily from the object
> database, or switching to completely different traversal machinery
> when reachability bitmap is available), we cannot say that each
> backend can store whatever side data they please and leave it at
> that.  The code paths that are supposed to be generic need to be
> aware of these side data used for optimization to some degree, so
> conceptually it is much cleaner (well, at least to my eyes, that is)
> to declare that the auxiliary data files like commit-graph and
> reachability bitmaps are defined on the objects in the repository,
> no matter what backend is used to store them.

My intent here is mostly to allow us to swap out how exactly the data is
being cached. During the Git Merge I heard from some JJ developer (I
think) that they also have a pluggable cache, but they approach the
issue differently: instead of making the cache a property of the object
backend, they instead make the cache itself pluggable.

I think that's a worthwhile angle to explore. The cache would still sit
on the repository level, and it wouldn't have to care at all whether we
use loose objects/packfiles or any other backend. But in theory, we can
still swap it out for a different representation as desired.

Which overall means that we can defer this to a later point in time, as
we can make it pluggable independent from making the object database
itself pluggable.

So I'd propose to merge the first six patches, as everyone seemed to
agree that they improve the status quo, but drop the last patch that
moves the commit-graph into the ODB sources.

Does that seem reasonable to everyone? If so, I don't really see a
reason to reroll at this point. But please let me know in case I miss
anything that needs addressing.

Thanks!

Patrick
