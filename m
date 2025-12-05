Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19682F5A0C
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975946; cv=none; b=rWrKcLdSpRQrBhP6lb1rPB2I5R1oGwJ1dNCeoB/nvkjxrre+Ae/kYwEazr1ifJHhBSyjonvCGAXytxr8gqdWI0agKTjCChb+GUR5ykNUdJUJrtVIUBcfbIkBbp2H+hHb442dxvmU+/6MTQIquC+iUCWRyP1QVcfp1EmDdyf7P9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975946; c=relaxed/simple;
	bh=cfjbvHBmTlxoksc731Q3qWkQytJ6ro8UcgW51E5nvPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SR0usrww+/flsisWBD09Ua9oaFIxxIOn3gwhAxsIizDZxuP8I2PVeFd48vNF1VYqfkn8Z5mK5npny3lpQeC/nOTTOo+Yjo8adadXw9XTMm+iHWDohFAD8UFqVlhl+p+lT35CxXhmxzzLqcuQ7BYGLjQKU9o06UXxiE2yNNAvG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AcsjFrGd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kJamgp88; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AcsjFrGd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJamgp88"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1DC7A7A0145;
	Fri,  5 Dec 2025 18:05:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 05 Dec 2025 18:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764975941; x=1765062341; bh=cfjbvHBmTl
	xoksc731Q3qWkQytJ6ro8UcgW51E5nvPw=; b=AcsjFrGdl8nOTI7n7Ipv5UdKff
	ixC15O65Z3WNq7qpj6quKMPz5Wsjaj+nyn1m/1POqbXbIlnSX8Rz/kAVQNdyGE77
	vMUyPhSSbV1YGEQ+qyBRevA5fcpZhhZs7FPBJsn1KjTIFSWzWIwCFeJBKcDi+vai
	0rr6oB5MRsWTwWvsa77UCrhxFgVHMcyqmrpvTrdcyrrs8QTsBQQet2RFzmgDSRBp
	A1uMiAle1efJRcpG3nbc7OGWi6Awu3y+BJ2MiyE/3Q3naJ3yWowSzX5jDW221nSX
	bWC0fIm9vQZHmGsOveWla6w1N4kvdqeZhoHt3i5th5F9mVdnX9QE+kLEFnHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764975941; x=1765062341; bh=cfjbvHBmTlxoksc731Q3qWkQytJ6ro8UcgW
	51E5nvPw=; b=kJamgp88XJPI3Ct5seYo6h0DVyGvmlJoryAYXY8JpfdODFezcd+
	ToQulzFJUR27tj1LlvzIeZyiwwKYZ5nrdjf//2nZF6P9dvaiy79amwLedxk4By3e
	MOg2KkoGMk0BOHOD5AUFzaMh4iuaWgFxWbvns/GjId+aMUM7+vn5ezY5S5UCIMto
	jwDzQQRokfRQkfpib5S6TlT3LTFwEhEWm4S06pJXe0pW5jx9LnereMIqclvw/91n
	ivbIrwi8Ek2VEQ9MstlZqyCeHTgYPU1mU/u7J9UbrJxc3eqr+BFJhURRdshKVX29
	n6wSQ1Ne2tNrrVyRycrCgQ+2DGr3uUBxVug==
X-ME-Sender: <xms:RWUzaRBN79Fu05KVfLNgMm2mtVbhcuhF9RvPMUOt-coDHy4JM4fmFg>
    <xme:RWUzaWjwDrC_KnxfK8SD6c0fCtmXBIyR2FXPst-ORFdW9Ov4owZdMtEiHTjzrbH5r
    mWruPcQwryK4T-WDBfddV84nHPAQsUo0Ur9Mky-XVA1-25nurNlcQ>
X-ME-Received: <xmr:RWUzaRnaI6DvcJ--OT4bmIArsOBaQlc0UunerD_iYT7JxrS5rbL_mT9dhYyhmRqspnBk7N_AwTR_g4zrcWLhLC25hkuNMUBuXpn7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:RWUzaapgYvsfFFBSVFTKSNqahnjWcdywJO7mWs9L50IbgN-yiUQG-w>
    <xmx:RWUzaSEataHLYHy7AXPkteuEf5OhUX847TCFpAZfuEq1pBBTKbw0Uw>
    <xmx:RWUzaewTmJJbO8KOvpgoD06JQjIY07gUibym5K1Pg2reAkGKtgVYCQ>
    <xmx:RWUzafqWIZrf8TFyj7vsRB2DDjeTpu-kL0_xBq5gehkhLR8zsxoQpQ>
    <xmx:RWUzad6--127wZd320VIktvLzVBjv3sH5Xd5Xn8dg1I7PZFbeGCDIdNG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 18:05:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] compat: use git_mkdtemp()
In-Reply-To: <20251203161154.GA44940@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 3 Dec 2025 11:11:54 -0500")
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
	<4c70b527-9c40-4396-8c8c-95177c5d92f0@web.de>
	<20251203161154.GA44940@coredump.intra.peff.net>
Date: Sat, 06 Dec 2025 08:05:40 +0900
Message-ID: <xmqqecp87cmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> This one is a conditionally-compiled wrapper for NO_MKDTEMP. But since
> we always have git_mkdtemp() available (as of your first patch), can't
> we just point at it directly with the macro?

Yup, that is much nicer.
