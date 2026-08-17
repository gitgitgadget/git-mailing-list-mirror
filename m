Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA32E7F25
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959768; cv=none; b=n7RyUW3oH7+73efLaOYTrT5e0o7YqxCFU2hd8T3MHCpRbXYR6BuRPYTp6rmXCMz2q3mM68J5YvMspst5QXfopTq8j/TnYBVor6yb7UDuveijVgHm4oZ3QOXVI6hyXbXSeSfYfUcGpWfsSF0nGGOh8bkGxwB8YUcVWg7OQ/tLEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959768; c=relaxed/simple;
	bh=Zh6u+VkUBCpKTfF9+4QXaU2xs04McMbVZoj4Cw3CUFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPJvswSOg7PHq7OUXJHKGSlOeZYq8zEPFKzICO8WU28/nMfwA3ErsLji6aPsK6RVk55v3jvFwDjJRTXmeJjcTuEM7f8R/XfH5Bjgqk0DMIGgLjmiVHy2iTQQfdGamXk1IW8KPj622r+0uhIFpY+3aAWLCG4tM+ped3oAcvOsRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dr9UDWh7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUtmM5+b; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dr9UDWh7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUtmM5+b"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D48751400032;
	Mon, 17 Aug 2026 05:42:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 17 Aug 2026 05:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786959761; x=1787046161; bh=zoL1qWswLh
	ljlL4E10kd9Nc4oHST4T1z8lizUfZ3U68=; b=Dr9UDWh7lw7Oir6mnsYYMpbOqc
	hgSCA3Ekdj0tRUNcrKVkr4GeQoHnQBnetQmR5b+yFZEzn8qaDBQNyJHM4oaFVhBH
	otiqNgqUZRna1/G58U3f44Wb4tnZtSRTvJ1kFbfXOYhgSVzNjn5Hn2RiAxpo78mY
	oeIQCe1nVvkBjx0ndnZUmTNynf1GO1/SbW1g8Yx67J0+xtSonb4SG/aBeqv0WAMm
	810U3qSsXBlMVU6UTOIUi5CWkzCdmBOjG2HjFgkAblmLa0BgKBY0R3XzWfs8nuLC
	Jaod5gXOraK9nwUAQdm0IglDvFA8gI0CXFd/Dt9k1GojxUEiQl17XBj0sNJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786959761; x=1787046161; bh=zoL1qWswLhljlL4E10kd9Nc4oHST4T1z8li
	zUfZ3U68=; b=DUtmM5+bT1fOL+KwQkrgV8hothELxjhJLoB+j+8+IYvyY/wExCX
	vHzRcMrIJBPJLtQdjWHI5QDjZ5vxbjzqyciBnVOe6u18G61plc7+eyoa90tmEans
	HFi4tSAOE5cDPURxyVKdTbrelV4T0ywJ66ttivf6wN5wAujeNh8WsNrxk1c6oj9v
	EhL1BohTwxJ98j4ZjtABlmYxcXLT3IQQuX3bKTUVWHsn7HeWSVyhWFLj3eZnYabJ
	/K6T1hZyWdRq3hkNBQLX5Qx3CFs7dTEnxS3Q5xuymrm2ds7J7tcib6SUvNaOVot+
	yQj1nDjpSHBuXeZwzhF6PLx8lTYSk88Ry6A==
X-ME-Sender: <xms:kdeCahaelR1qdCZKfTC0L5M9hg8_w3y4WLVfP-7JbGUK_gMgLrEt6Q>
    <xme:kdeCav0K1obNmPJCv6uiyPfGVL7Tbxnc1GDGywHUjhFOr_a50Q-7EZDgv0kAoSiqe
    YjtSaJwTMP0PvveJ8YQRV-Sn68D2EIDQLOT4_QkihWD_62OZ8SlkA>
X-ME-Received: <xmr:kdeCahUEvHKIohNqSKmgqCSinjUlrhFFFw0gSmh9-evyL1_10eYsa3PvkAiJXvXCS5r-x-GwMeu8xIrIbASw6jcBMrbj-bdeM99kSvHpdg>
X-ME-Proxy-Cause: dmFkZTGcTh/Vj3y+Y3H9oVXE0udpgeDAjqRhk2BExwyZx2lbugY8xrTWR19jChz9yeD6Yq
    DUMjs+1i7spjg8jm0DrPzWe9j6VXXCtUGRXuOjqroH7HC13qldzcnejVHR7vJeVw0rfgjS
    EiHUyhSUsAOG4hlywgzRN6y/L44MYxXL5PGm3TJPlkFi7fEADtaoLpuXcrU/DUyUoQ8Qpa
    c9sFq0ExguYR4UkEqkQuCjnh7IoImHKLjZEXsi20V3aaOgeL+ur4DABzoHFaidRVsxlvKS
    4XeupFNvJPAW2gcpwIyTQOr0DT0HBnA1gurbATeVFyyqQbCUJh+mtdpTPe9+/GOg9xq3Y9
    LLBr8KqV4Vp76rTOKy0XHpy6RVZ1Rd5DJ9EB6Dr9p08mkcZ5McuPpbvZexP/nWVN8IJMuo
    IeTdDSM52+tZHor2BEhl3X9lMR+pCnM4giMI7Cgn39R8JrRi+7ae9ChFpKp+HBYsXPk7fB
    zC+5v6oXgep4By9ZtNy+Bnye7+syo7av6OnspXhzu3hDch4Ra83jhxDnx6sdRL9RKYBq/p
    lkSo6ucPzuOB8FRb7Ayova+wT4UxB3IHRy2ti03GyQNTh2EQnLhbBqsWuCEvGz84NiOmBx
    PZJpZLY94aOS2r3gOvkb75hfPeIxAxk6PkKg0WN61lt0mPiOUWaujM/gS31g
X-ME-Proxy: <xmx:kdeCapUe36dw1Blkp66_KOOVEOd5vRmrQuUyeRPcTQXBNi2OMU_shg>
    <xmx:kdeCagdfN8HKn20OQJv5HqAfuazjkEIbhMt1XuCmK8_91lo2B3RFwA>
    <xmx:kdeCaiVB-bqKiN4xcypRUjMS4BNXHip9BS5G3Stb5setgWHSph8Nww>
    <xmx:kdeCapcElx5faajdAGHUquMXA8QrtaWkfNIj-4lvSi_moymJhZCHjA>
    <xmx:kdeCaoioMUrt2XbiurE1Z-KMMThfUYsTQf2pkY8UTsc2lYySUe5sFMSC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 05:42:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f48a0ac5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 09:42:37 +0000 (UTC)
Date: Mon, 17 Aug 2026 11:42:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <aoLXioIecFZdGe_O@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
 <20260814171724.GB2563235@coredump.intra.peff.net>
 <aoKeeQMps50rjhWi@pks.im>
 <aoK1ZYfqh5PnNin6@pks.im>
 <20260817073621.GC690018@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817073621.GC690018@coredump.intra.peff.net>

On Mon, Aug 17, 2026 at 03:36:21AM -0400, Jeff King wrote:
> On Mon, Aug 17, 2026 at 09:16:53AM +0200, Patrick Steinhardt wrote:
> 
> > > So if we want to go down this path I'm inclined to just unconditionally
> > > use case sensitive matching and not introduce any secondary machinery.
> > 
> > Thinking about this a bit more: I'd suggest that we leave this out of
> > this patch and instead document this as a NEEDSWORK area for now. I
> > _think_ that this proposed refactoring should be generally fine, and I
> > quite like the simplification that results from it. But the risk for
> > regression is quite a bit higher compared to the origanal patch that
> > I've proposed.
> 
> OK. The inline lookup of core.ignoreCase feels quite gross to me, but
> it's _probably_ OK.
> 
> There are all kinds of weird timing issues lurking with config lookup,
> though. In particular you cache the result in o->source_paths_icase. But
> would we ever load odb source paths before the repo is fully loaded into
> memory (or in the case of clone, even fully formed on disk)? In that
> case we'd cache the wrong value forever.

Good callout, there's one gotcha here that I was already fixing in a
subsequent patch series. Namely, we call `create_object_directory()`
before we set "core.sharedRepository" in `init_db()`. But in all the
other cases we should be fine.

I'll cherry-pick that patch into this series.

> I think we have repo_ignore_case() now, since e6a79c9eb8 (config: use
> repo_ignore_case() to access core.ignorecase, 2026-06-19). That's in
> 'master', so it might be worth building on that instead. And then if
> there's any cache invalidation to do, it would eventually happen there.

We can't use that one though, as it uses `repo_config_values()`, and
that function only works with `the_repository`. So that'd break with
submodule repositories.

Patrick
