Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28351D4150
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156607; cv=none; b=eBvNHoZZtX21la0Zemkx/Kkl384GMhA4VGYnA5d1CoaP/FUhdMCf2bR7PClueXOEAK2JnFkILUROPae0SYeT45NCz2W2Xk/LHY7vJxr34/rAszERQySWKf8EyfbRUYZL/3cyy08Zy/FhNT1QhX8pW0//KdwxtPtfneQmmiFLBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156607; c=relaxed/simple;
	bh=kaeYLQ6IhofpkNrjtx6nMUqUrxxF9gZRePu7fO4kLJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm0qfupKthb4o27OgwvGDWz5JrxVEVKNHcaqGDV4wGzmpv63/GkJAXCoh2Mf9tX99AJFyRwxkWKwpJj9AKgND1mcGxDWf1+PdTeiyd0BzO7H8iDqHcvC8ghXJLZGHwGC0y4T4U4+y7IDmoc4Z+fd2rp0x2zdqkRXqby5M3EOF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IUMqcNbP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ETClhZbL; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IUMqcNbP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ETClhZbL"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4E4A254008D;
	Thu, 17 Oct 2024 05:16:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 17 Oct 2024 05:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729156604; x=1729243004; bh=aGXSA+ceGq
	ZG8fX1GRSbIgYRM9BVMrQ2S7cuJPJ+gK4=; b=IUMqcNbPWEgAIWK9uGHpsY+vQZ
	eVeuTlMrWiDoGF8xwSjr4Qa+LmECJcYrkMfysLdFzKkqlZS3RwrOiQ2tunUhJ7MI
	RPNtAhmAL+wYFfS2b/XW280IwUWz+MhPs9vjp0+xV2s05jLVIqepJ4wDFMDA3upc
	jz9c6rq9aBEFgK72GgFyHJohevZymsy6OLXW6e9m18C/DPzFq4mWa164uB59IKth
	BqbtGM5lZDnM53xm6hV5TpPPdr+VoZPKFGyzRmw+RdSnDjo8e7exbK586z7rvb47
	UJ7DYMa8I8Yv1nwR0U2DG7Sl7mOHEO//lFxzHYLbrGtw/rbEHbQvkzSkA09A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729156604; x=1729243004; bh=aGXSA+ceGqZG8fX1GRSbIgYRM9BV
	MrQ2S7cuJPJ+gK4=; b=ETClhZbLIv+4U/PDrsZHiIB+gBNRtxp9YaEO98N3aCDe
	WQPPuZ8uxrTHtM9ylDLC15ywQWhLTaE0p38DSZ8NQ1oZwQxdKR0Z1z9ftcsUSp7j
	eaz69NCoIxO5cXSR+mEcvvO36m5Zxbi3jQfQmB6gKLmeTxD5WD/1OdU5eBe8QU3a
	zPL+pMcHfDcCggB0p1qQ5KFYWKsgwxg4MTwrWXB0/gFD9bTYytA+CtXjgGG5BGwQ
	oCsLueuMGT+vk8t8zkZ8Kp4A2clawf1pQfR2SADUrbXBME0eIEg2v7tTykbawhxR
	rSAEvsfelwwG6v/RpXF0H6kGAVPfFmg/FL04/+tuJQ==
X-ME-Sender: <xms:_NUQZ674-d_1ArmHBz-A8zxfVkSbYZuhe3yyeLNWzw3KaPmvjDW4aw>
    <xme:_NUQZz5SOV-cYv_R-9H_RSLPtm8uOvDsPFpHU3esovCzvQri-pixp0pZfN11JXpFn
    YlGY9dE3gzU4NGrGw>
X-ME-Received: <xmr:_NUQZ5cQ1Jf6l2jwtPfXh4_bHINFr-rBYdUymBH3vh-zDLJyzHxhVMXaDl8RfsrvzIB1bHlKLRdjAuBSeeHBdcs_e3AW76BinC8UKIqIyHSSng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:_NUQZ3ImSq7N2q_bfppG9t5v-CtLaOpQcmeb_ykR7Mw79h4lGYsLyw>
    <xmx:_NUQZ-KOeF1FuHHC0vs66phOnFQzlH_T6Xmgj-Q9FPbsPJzoE2_iRg>
    <xmx:_NUQZ4x-8lH00ZHiVPqhpzo5968_jmqRiAGrNPai10I7hOgLtfyz5w>
    <xmx:_NUQZyI7n0URE54TqQqszGx8aRDcJnjj7LRQg5yKrtfhIHb5t0jmIw>
    <xmx:_NUQZwht9e0HLQKYV1Gx77eUpybd1j_bbluprI3wiEi5C0PDoHaAkl1c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 05:16:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d62a182f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 09:15:22 +0000 (UTC)
Date: Thu, 17 Oct 2024 11:16:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
Message-ID: <ZxDV8cf8yfzhYk6d@pks.im>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>

On Thu, Oct 10, 2024 at 11:56:08PM +0000, brian m. carlson wrote:
> For a long time, we ended up with protracted discussions on the mailing
> list about what versions of software we should support.  Oftentimes, we
> broke long-obsolete operating system versions by using something shipped
> slightly more recently.
> 
> Fortunately, we now have a platform support policy to guide us in our
> approach to dependencies, so we can make updates without worrying about
> breaking systems that have not received security support in several
> years.
> 
> This series updates our requirements for libcurl to 7.61.0 (the version
> in RHEL 8) and for Perl to 5.26.0 (the version in 15.6).  I considered
> the mainstream LTS versions of RHEL, Debian, Ubuntu, and SLES, but
> omitted consideration of paid support extended LTS, since we cannot
> expect Git developers to have to pay a large corporation lots of money
> just to test functionality.  This is in conformance with our policy,
> which states that versions must be "in line with the version used by
> other long-term-support distributions", which does not include extended
> LTS distributions.

For what it's worth, this patch series breaks our GitLab pipeline
because we still exercise Ubuntu 16.04, which uses an old version of
curl that's not supported anymore after this patch series lands. We have
just recently started adopted that job in GitLab because GitHub couldn't
support it anymore, but we wanted to keep around the test coverage for
such oldish platforms.

So if we want to declare Ubuntu 16.04 as unsupported, this patch series
would also have to remove the CI job.

Patrick
