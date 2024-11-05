Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065A6286A1
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786122; cv=none; b=kYot10mUihoy28Yo2tjkao/oREoUGibMu89kYcJqsT0uJFrOAZBNuerw2lcZ7XnXGi0TS++nPHcHj2OXc2763SZazLGJ42Vex0UfTvhVJGcx6SmE0a262APCL77HVbazDFAUyIqbalDofrUO8hd66gqncQDfVh60XXH8gfkTk0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786122; c=relaxed/simple;
	bh=1K3x23EzLWFLL1OQJiWpU0rLV32a+Z5CuH66WR0Msts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFeUVDd6CylT0AxBiTtjyEGzGo92sza89ICXZze/Oil0AIZcTdWiVikSa8d5TLIbxEJNzHLlb3ET9JVnno7OiM3w2Au3SiQ/f0aE1bdnzFCFIHP0c6351SD7oxu1mcQVIOLNznkleC3yKOtg+TPW1IHyzoBNTWjZxhLqEC6+seY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uHQTrH27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WiHpIjYX; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uHQTrH27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WiHpIjYX"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 003301140166;
	Tue,  5 Nov 2024 00:55:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Nov 2024 00:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730786117; x=1730872517; bh=glbB6luBZK
	h4DeAbWZulUiwQx0fbZjqUmbocQz/eNHI=; b=uHQTrH27yMBr7Psxm1o2d9CQEF
	mWy2EPeAji8P+SzhvUtRWeExL2A1u2GFOYbPzrt2N4olQ4DdLhBh7jfxRKgpsiqQ
	SNAyWPNJoBkUX5d8ll5pfCyc5L/YYbtuoIbqWNiPTNYSZhwZXcaSF/fiNIsp3FEU
	1reJN16vx2tUBMWORxVoARZJ094n5ew1RQElpp8s+C0/NXAhgSbmWbdPuMJhiAMG
	M58cM8PmfypYMU0LBNfRU9J4WZDqYhzceAG4w+tePawIzUxnefjka65bM8NesV9X
	V7ZO0uLuSp9OErkzkjK/akHs1++qfDhlevkC7TZdeNbcHxRPLc0Dlo4vIEwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730786117; x=1730872517; bh=glbB6luBZKh4DeAbWZulUiwQx0fbZjqUmbo
	cQz/eNHI=; b=WiHpIjYXVRM3BMfBt3ItJAcwX6zuK5IK0xHqPXB+FgixdSVJd4t
	Z96CxjNyjOhg9nY/eu2BhHwZ5cLf3ZWK/R/ru23KORNmOeVESM/QcZung0hKoIqm
	AKg2htP0c/hwYtE7ZdgwjIziFG5HQ536m9cF7yGXTLJBmkSW1L99HdfB4TvT+vkq
	Yh56ffRhT4mK1/0YqDP6SjnCtxPl+jNE7iECTKimz4SIGac9f4LDTBqw+iUclRmX
	Ejdekes6M1B0ga0KAlloLHS0adTzwCMCOBCsKsBS/Jvu83Cm5ZOk6JIUSjNTcGWb
	m9N6wd0ywowtTdppB6hmkfEyZCm3Cb97Gsg==
X-ME-Sender: <xms:RbMpZ1eBXzrF3xt-Q2aFqxJlW7u22WgPFfafiKI47awAPehZ7MvIdg>
    <xme:RbMpZzNYCJ_tvYt8Ti6rN07EU2e5aDB6gdmRV9-PEu3xZ8-StBHSliN8OfWpSIpxZ
    8TeV4CZA-TfN2WW-A>
X-ME-Received: <xmr:RbMpZ-i3L7Zn2EespOKoQPWer7AT7tr3ZhUrI3SQ0Es68zXRvhwUuW69hpDu4AktONbE1qG2CGpPwKl0SCb3mi4kGWaFYIQ6V2oIdqnoNvRrQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:RbMpZ-8pT3BgS9wSLh-vq08yPtQtIoy95S83O3tV2Ypo7sGC1yxgTA>
    <xmx:RbMpZxtZ-RdsRxuc8gfcH3kJ7qWFg74GwRpMmSKSYolmcZ8ddkLQtw>
    <xmx:RbMpZ9HOA0sj0Cl9p3onYh6Dkzrk2y9bFeCvrpWHuaU2OgdMPyzxWQ>
    <xmx:RbMpZ4NmuLU2n4NxKnLooXLqTXz921YrjqISabGHD6JkneJDsebzDQ>
    <xmx:RbMpZ7IiUXdhEllKm0k9FgF7iS8ecm__SPVXAuqWmFg7woAtoax5Hq5Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 00:55:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f64ce2a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 05:54:55 +0000 (UTC)
Date: Tue, 5 Nov 2024 06:55:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.9)
Message-ID: <ZymzPdjKy9AFBuvM@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <v4cfsfnmvqhedtsoykax4wkq2ug6ke4c2rrtbwmtanmc2fonzj@4il4rzkuyffa>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v4cfsfnmvqhedtsoykax4wkq2ug6ke4c2rrtbwmtanmc2fonzj@4il4rzkuyffa>

On Mon, Nov 04, 2024 at 04:46:57PM -0600, Justin Tobler wrote:
> On 24/10/21 11:27AM, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this is the second version of my 9th series of memory leak fixes.
> > 
> > Changes compared to v1:
> > 
> >   - Split up the trailer fixes into two separate patches so that we can
> >     explain them standalone.
> > 
> >   - Adapt the second trailer memory leak fix to instead pull up the
> >     strbufs out of the loop such that we can reuse them. This makes the
> >     code flow more naturally and optimizes the loop.
> > 
> > Thanks!
> > 
> > Patrick
> 
> I've reviewed all the patches in this version and left a few
> non-blocking thoughts. Overall, this version looks good to me though. :)

Thanks for your review!

Patrick
