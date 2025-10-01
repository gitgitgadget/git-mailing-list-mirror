Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF682110E
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350980; cv=none; b=Sl8nqDZyIZ5uVTPzWgdF3HJ51rf9LWmb/RwOW/kBjvLzMxIki0LDD9SbpajLOCBa1mfvKa1R/ndGgQKoCplEWQPGrqHVbF/Qk/EsBiGLqis0BXQlXfbS8k833RY10yMHmSYJgyqF2xvFNvG/5s138/ZPvOUg9LmBmd/FkYNbc5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350980; c=relaxed/simple;
	bh=Dpb6y6pWTevuTMSIbu82tGhaRxvyIvvnTlC0rXs0ynU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DazNBN76OcXRGfJMNgT+qRDAq9Zvfm6Nv9s6jSxYy8DklVLP6sCgPJI6bsNS4VCSRW1Ap2+EEsu2WwQ2vNHQyRuj7qGtyYze+S+zwVFMRhOXvei8yyW5j8UV+L2s4crndA5W67dNKpu84IIwZDKUIvVz6hJwUzXeGFLcTbn+2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f/MZUn//; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1gJ65Bv; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f/MZUn//";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1gJ65Bv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1525E1D004A9;
	Wed,  1 Oct 2025 16:36:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 01 Oct 2025 16:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759350976;
	 x=1759437376; bh=OUmspZjvBGgWYo7DZ/YlcJIf86O867ZZJ5ZKehDlv4k=; b=
	f/MZUn//Y05oBXg8+DZCqN7KkNS5CxZk9URP2VbS4fBZzLeyIrREfZbE246koZnQ
	bGt6yKEhb3tDhGVOOn0AoJVtlMO9aBfabsP6y6W7x9HgVcNKFWY4wlmhtjko8HEQ
	Py66bldmZKc1lO8Mh8F5W7P/GFZatv78tQXitx09ZvyaxL5Zig5jmgNCILfEGztH
	tFc2dzD9mjoItgh6YIYQ32XqDD2OzhMN2paIQPSRR1sqA7e82FtNFhV+0sv+q7zS
	vXtZL1lEZB/EkLFTuXE1gSB/FAyQjAdAy0EuBpZHM/8IEdrBkhFiWjQptCUF7RRU
	rYQ7af7BMGqBJzEE/qOKKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759350976; x=
	1759437376; bh=OUmspZjvBGgWYo7DZ/YlcJIf86O867ZZJ5ZKehDlv4k=; b=W
	1gJ65BvQT3KbqsIakOunTTc3AF0PjdNqeMT2vtPZj8hCwGbprrfV+Jpy6dVlb/zr
	A8EOxyuafVrCsMaXyngPTCRmpkaSpeFo696pEUUrc0Of3xeMVa7vNU+bY7LFQ3wq
	BTgagWd/dsikJ0vnZk9jm+i/UeH+Mce1OlLlpE6Hu6dZSVsTGRfEbHr+Vm9DL/j7
	63tL1Pa575EXAv/9m9SRBepWkNoL6px7ffZeKzGi0IfZPLoK+OBdSM73i3BTZMoG
	xNjYE+8zrz+ubOwpgGZI8qgPzGAae5jbr5beSjOnA5KGRm+vmPmuqsIHtxMM3QI/
	MV7kY8S+Us+VKOiRr82dQ==
X-ME-Sender: <xms:wJDdaEloxSJvammpirBmnt36aE6Qvt3_By06HpXaf3Y_VkFWTfVvVw>
    <xme:wJDdaK29Of57fabX5zayqN_kL2sp1KPh5rS79fS6cs4UXSobW_kUZF0FsAGudZ6SR
    LqL4tSf8nKZNvpYMlhyY56bwT_XsNLIVOcbANriUMC-NWgEo_aM5sI>
X-ME-Received: <xmr:wJDdaHo-ZW6u10UyMPi6UPg1zYj2mel08RzKC0q6zSCZL6A5O7WspmNUyN8vB_LAlbLXkbS0ry7v8rYtg8yExlKAwcwZu-LRBa3B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhooh
    hthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wJDdaPdD1TTtIG8ciTViAQin0H1ELlNzVOSevwqreq9Rys6fxe5cbg>
    <xmx:wJDdaOoP06CIsp_IqoQGBdr0qwEhyEEy_5Yu_is-Ag_ZeA0pZxgOqg>
    <xmx:wJDdaIFQeABpRxymbw2Naxgu8fNwQ5WJhpfsMhyBwkqe9eZEHVkYSQ>
    <xmx:wJDdaGtAZejNJdH-A4pOtHcQAzDIXBO3U2w7TNa0uCTqtL05WfdPGw>
    <xmx:wJDdaMmrmfdSynOrM2LUSUC9U-DPJGsnOztu4cELCXqSqs7ebHUp63A3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 16:36:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
In-Reply-To: <aN1QUDzYli0GsGy9@nand.local> (Taylor Blau's message of "Wed, 1
	Oct 2025 12:01:20 -0400")
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
	<aN1QUDzYli0GsGy9@nand.local>
Date: Wed, 01 Oct 2025 13:36:14 -0700
Message-ID: <xmqqecrm1hs1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Sep 30, 2025 at 11:07:42PM +0000, brian m. carlson wrote:
>> Almost all of the functionality that we had wanted in Git 3.0 has been
>> implemented.  The two major things we may want to consider as blockers
>> for Git 3.0 are the following:
>>
>> * The SHA-256 interoperability work is not done yet.  My estimate of
>>   this work is 200–400 patches, of which about 100 are done.  If the
>>   original schedule is maintained, this would require writing up to 75
>>   patches and sending in 100 patches per cycle, which is unrealistic
>>   without additional contributors.
>
> I need to polish up the notes from the Contributor's Summit and share
> them with the list, but my general feeling at the end of the discussion
> on the SHA-256 interoperability work was that it wasn't clear whether or
> not it should be a blocker for Git 3.0.
>
> If post-3.0 repositories are using SHA-256, then either their post-Git
> 3.0 clients will also use SHA-256, or the pre-3.0 clients (without
> interop support) will be unable to interact with them. I don't think
> there would be any reason to have a interop-capable client use a SHA-256
> repository in SHA-1 mode.

What is the recommended workflow if you have unpublished work,
written back in your private SHA-1 clone of a project, meant to be
submit someday to your project, that used to use SHA-1 but has
migrated to SHA-256?  Convert locally your repository to SHA-256
primary with SHA-1 compat and then push to them?

Presumably the server side _has_ already done most of the conversion
work so, provided if (and this is a huge if) we assume that the
conversion done on the server side is trustable, we should be able
to _clone_ from the server in SHA-256 primary SHA-1 compat mode, and
push your unpublished changes from your SHA-1 private repository
into this clone using SHA-1 protocol (i.e. no conversion to the
original repository)?  And upon accepting such a push, the receiving
repository (which is still a local clone of the project, but the one
you recently made and is aware of SHA-256 world) would now have your
unpublished work in SHA-256 (with SHA-1 compat) objects and everybody
is happy?

>> We may also wish to stick to a stricter timeframe for this release
>> regardless and make four releases from now or the next release a year
>> away Git 3.0 regardless of whether those items above are completed.
>>
>> Discussions at the Contributor Summit did mention the advantage of
>> having a hard deadline would be that it would make projects and forges
>> spend the time to implement SHA-256 support if they're lacking it.
>
> My feeling on this portion of the discussion was that we should take
> into account the readiness of the ecosystem as a whole in deciding when
> to release Git 3.0.
>
> I agree that not having a deadline can lead to forges delaying the work
> necessary to support SHA-256 repositories, so I agree that we shouldn't
> push it off into the future indefinitely.
>
> On the other side of the coin, I don't think we should rush Git 3.0 out
> the door before the ecosystem is broadly ready for it. If we do that,
> we're creating a worse experience for a significant portion of Git users
> that use popular forges who may not have complete SHA-256 support at the
> time of the release.

Yeah, I wouldn't exactly say "we'll tag when the world is ready",
but declaring 3.0 when nobody is ready would miss the opportunity to
make a big impact.
