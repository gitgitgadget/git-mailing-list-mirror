Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD813D276
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321401; cv=none; b=XUfQ8UrNaXHX8Ez82XQT9NISw22KNX6lBZ3qc2HwTKeoiATjwh4J2q0RKuUfRUxy6o42ZKLqETLppd+KJI3nKRr0sE5p5XMPJE3o1fjFLgm4kq7m31NCk3S41nqwBLicp0jD/vsMA1R4FDp01CYI4QhLd9mdX5iyF9HRQ64HpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321401; c=relaxed/simple;
	bh=wXiGN0xYoj4kGjJlPDFrhbpgXt/yYTrWz6ZR/9JfjmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWjoUhvVlgoPUBur8emgyV2BeAEULrwhJr/vB0paMBSUk09Bi7hiH4EgHYZN205Aan7qjd8YCHVIDnbHLP8d50GhOv+NQkUKcGfN3SlNEvkE+IL4q/Vq/yDP55lt+jnzCKmySl6LBoXMX5qLU3vWj0YVZxLHwJUoKZHUT6/rzQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ibW2dBat; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kUIdxPVY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ibW2dBat";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kUIdxPVY"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC2A1114015C;
	Mon, 11 Nov 2024 05:36:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 05:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731321398; x=1731407798; bh=nDe1OrRhPw
	Hd4dgzUcSjIbkm+NcPUUmOScRuVTw+cMU=; b=ibW2dBatQQUygCoqOFMjgAFCkq
	hl1/ax6k5tID6XpiKDuUE4saudfWXvnIFBJmHPGgDrWiAy3zv3uHwJVUezodCX+S
	Jqw6cqgCQp/fs8W4BLdmuEti5vHTCojLWfiPlkV6+UzJxsnOIYYmGwT81YDpqxEW
	2Sker0IVdurVq8Wih0UuG94F264ABo24ItPuo1p2cugnwggN4Crff2NKnMV79Jl3
	yzdmpbdOqmlXcxDApQiTodthG0aMLRwpikS4Quah5KiYOVIywFaMDXKR/lHymnYs
	+DhAj7SPOLIFQumtY8OLAU2HIvU49Aoy9J8U7l0gL/+EiCRC1BZT19IIcljw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731321398; x=1731407798; bh=nDe1OrRhPwHd4dgzUcSjIbkm+NcPUUmOScR
	uVTw+cMU=; b=kUIdxPVYNSsXs9kUjjC4MxmjOAiMqkNW1vzQALMoG6s66mXY5iD
	WA4UpSew20KRDnf2hKDPesqVIefUrJeAKcJgUESWvYHRKygcPz4ekn+gESDI39tY
	Vo0kVHtY5pk/oX4J8tuxer/WVp31Y4go4dhEfGQySj2+Z/tH0z1ysyQ3SNyx7BCP
	3Qxlh5NPpf6qTtTW+ThUl6FWXsKL7HvlgmHatyOYH1E9t8StdHDnYsn4g0E8GQDw
	zGj4aNCQ2kWFpldrx9Byg9JrYOxGL5yp9h86WSav9Epvyup/cxJZNzRKSIHXMcaH
	w12SNDpnIea6UUpbg1w4yyTGjfkh4z5axrw==
X-ME-Sender: <xms:Nt4xZ_NDj2rVmK2l7DqyErOrnCXI2s7ZGW446ngZEwyD08vrZgXpmQ>
    <xme:Nt4xZ59cBrx0rAOPha3o6olkrHJpQFPzc8hWduNUYWu6imF0ka0nFqLXf21pEuNtj
    noX8AMOpZ8Dnf-m0Q>
X-ME-Received: <xmr:Nt4xZ-Sh4AHhR_yspPz8O2TqEDwlXgGblBeFoLr3IZZJTDDhnoCq_h6axkVdKlJrTWWQRYigOgYS5IyN4kY1HS3CeJpVUxpwBk7UvGgRfrYxkcRR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgr
    mhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtii
    esghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:Nt4xZzsyK9nm28OqhMk9Btef_pA0ML0qz0gb6WPAEPLdV9Z4bumxSQ>
    <xmx:Nt4xZ3cpLfuCxRtJ14FV5QafwR319iUvg46V-sQv7nmZ3RY_0qHKpw>
    <xmx:Nt4xZ_0tFnL4-M8j4OA2dnjv6mqotlsOu01Cw4O7I3q9XMjl9eKk2w>
    <xmx:Nt4xZz90nL5DkPvGC3WkEcxEVv--D_SA-A1aMYstGyV1AacnWLukFA>
    <xmx:Nt4xZ5tMzFQU2PYM8SjuXgTZFBJ1yb2M6fSdp40xp4JX0DY_eRaiRsTg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:36:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b5c19cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:36:01 +0000 (UTC)
Date: Mon, 11 Nov 2024 11:36:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZzHeKkrOt8Tp3OaJ@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <2dc3433a-4440-4216-8fd1-3776c8293674@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dc3433a-4440-4216-8fd1-3776c8293674@gentoo.org>

On Mon, Nov 04, 2024 at 10:03:17AM -0500, Eli Schwartz wrote:
> On 11/4/24 7:17 AM, Patrick Steinhardt wrote:
> > The solution to that problem is autoconfiguration by detecting platform
> > specific bits and pieces. And we _also_ have such a build system in the
> > form of autoconf, but now we're entering territory that is awfully hard
> > to maintain. Most people don't use it at all, the only user seems to
> > really be distros. And they tend to hit many issues with autoconf
> > because we devs don't use that infra in the first place, creating a bit
> > of an awkward situation. Unifying this infrastructure such that devs and
> > packagers use the same build infra is thus another goal of my series.
> 
> 
> As a distro packager (not of git specifically), my understanding was
> that *no* distros use the autoconf, and that at least some distros say
> the reason for this is that the autoconf is so unused that it doesn't
> actually work.
> 
> We tried to use the autoconf but failed.

I thought I saw some distros using autoconf, so it at least isn't
_completely_ broken. Let me double check... FreeBSD uses it, but other
than that all the others that I've checked use the Makefile directly.

Patrick
