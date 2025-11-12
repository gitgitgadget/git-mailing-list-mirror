Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475973002A6
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942879; cv=none; b=J0HSDrRWH+f1E7/aIKGkD0gOYldu4507FQzGS9NysIuR5HHhE5o/jc0z9Bjd7MVb02jfPtOGEIt/4/Rg+5C7EelQYDjfp7KwteJSPOCYop3qTkPjk6qrblPBeskRlXXWefaF+Qci9oOZw7OZsthlJzLZd8niUqsISd6eYkRa6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942879; c=relaxed/simple;
	bh=JfOYpiqV7buFT60hJWgkKz/3rCATcnhEhhImXZ0lPds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfWwRTNkQQ1CqCaFm0B1a7njUGdh5c7BbMTbePuC3kqjVP8/P6hzPcbziXt7gMS4YJWCt3gtfMBaHReN5zFwysTOZVupVHUe5iaqwrtSsi4n/asI6XGG/VLspawpLE036zXpuM0lnBmsa/zZ+S3hMcqRDVn5G9zusydhQYeQrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=alVu0pbd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1Qy8TPlS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="alVu0pbd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1Qy8TPlS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45B8E7A010E;
	Wed, 12 Nov 2025 05:21:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 12 Nov 2025 05:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762942876; x=1763029276; bh=ceGP8rDWi+
	yAZWz0P4ARQiC/ER0FsgXnZ6i3Vt0XdJM=; b=alVu0pbdNE927X5q+vIA184Umi
	xjXmNcjdQPyrTB4aWD1t9m1BD7mAzHELihviwphTWp/houThkHmCPB8lsfoOgU11
	ndjlJafwcCMwnqNgTILtL4DtNf0VcuAp47ZbGPCAj8J5aU8Vr7m0sykDn/XS0v6+
	Ye689VX+hn8gChq0+Vc0S0wCEvqnpE2VYg6/unn7HEx34dAM6gMels9YnwM9Hg1M
	+nHM5CX9WVXIHIFdF5alVgCQ3/UX9wGIzR/ahnUXX/fdHbyKGv0rrP1XXTGLyTxy
	yKZCaIjIhZ6SkKtudwJNOezIVOpt6Z0WyD+zI6g9tR+VrBJBFyj+xr8wtRUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762942876; x=1763029276; bh=ceGP8rDWi+yAZWz0P4ARQiC/ER0FsgXnZ6i
	3Vt0XdJM=; b=1Qy8TPlSWm15F0E3EUX2KcpZrjra5+qzobcxCFv9yDuTLNVJu3N
	6IU3cGXquQ1fHXBnIeTyTCJzjUpDga6W44/GyxSS2GD2o+zwT2KmMFtABRYJW3UR
	P0CIcYrx7ORr4sWIPvI/LlyI89gmmmJaufcounpsVmgyp+xyW4cz7htxPMG/WfSg
	Z9Sa6M0P3CTuGdDPCRzmsHp3r3hP3eyV9YNIeAUc8UourQYo5mhUAwMAQN+mc+oU
	f3FOSisK3aisbqM+ICztI5/MCkjZwgf4X7eWNdeE8o9mX3HNmLMqYag50LzCHS/N
	hZQIe21msYA78dsxyDujvW13uOkMwipy6ig==
X-ME-Sender: <xms:m18UaUqR30xlaN0zj1x6poHw41M6HNgOVHybI-gvhhRiXefvlFUVNw>
    <xme:m18UaSFQw2Ucq1DlIFRFBKqPhuNyxvdLjT5s_1vAVxfvGBY14XUCf3Ka3GIzY9wa9
    u59pwfUhIRJ6RZjwci8gxJ2kWHbE40N9WPlC3XJxrk338XiwBjf9A>
X-ME-Received: <xmr:m18UaWnMEH8DorpJMHXrcdjjeeoRRveIjhZdUZRd87W6fkMks2WPPZryU91fQZEeXVe9lYvFg1lvDaXa2lIjgaFAamZlCeKHh8ftDDljXXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnshhtrghvsehmihhggh
    hordhiohdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:m18UaVniY5mYlzbBPjDg_61NvSWxRcHh_nafrRcu6xk2MritnlDXOQ>
    <xmx:m18UaXvRUE8dddkj64rDNgnZxP6kJVu-p4t1nPACsFRN2d-_dW8csg>
    <xmx:m18UaYk0kzM_hyWxI5V65IDR2-8KHq540MU8uZ79YDg6ZcQjtVznwQ>
    <xmx:m18UaSt-_-ABpJhZEYHgTKADKd_G_YT7DqbI_ZZSS3zPM9vW3YWZPw>
    <xmx:nF8UaWyosWmAlob4wKgS3mM3m_7wUVeV3k1l1RYWBRnGCADTgxDyHt0O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 05:21:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f734c2ba (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 12 Nov 2025 10:21:11 +0000 (UTC)
Date: Wed, 12 Nov 2025 11:21:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Ben Stav <benstav@miggo.io>
Subject: Re: [PATCH] attr: avoid recursion when expanding attribute macros
Message-ID: <aRRflKWKpUtfn9tw@pks.im>
References: <20251111223647.GA4055973@coredump.intra.peff.net>
 <aRQvyvMq61syGT7_@pks.im>
 <20251112071651.GB431661@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112071651.GB431661@coredump.intra.peff.net>

On Wed, Nov 12, 2025 at 02:16:51AM -0500, Jeff King wrote:
> On Wed, Nov 12, 2025 at 07:57:14AM +0100, Patrick Steinhardt wrote:
> 
> > So personally I would've probably leaned into the direction of enforcing
> > a hard limit. I don't see a reason why anybody would need more than a
> > couple of recursions, it culls both compute and memory growth, and it
> > allows us to have a proper error message in case the limit is busted.
> > Furthermore, we can demonstrate right now that it wasn't possible to
> > have unlimited recursion anyway, which makes it easier to put a new
> > limit into place.
> > 
> > But following my above reasoning I think it's okay to turn this into
> > iteration, as well, though, but I'd like to hear whether my train of
> > thought matches yours.
> 
> Yeah, it does match mine. If I wanted to waste a bunch of CPU and memory
> on a hosting site, there are a lot easier ways to do that than with
> really long gitattributes.
> 
> I'm not at all opposed to putting in a hard limit on top. My general
> feeling is that it never hurts to convert recursion to iteration; it
> only gives us more options. I'm not planning to work on a hard limit
> myself, but if you want to, be my guest. :)
> 
> I think if we do (or even if we don't), it may also be reasonable to
> shrink the max attribute file size to 10MB or even smaller.

I think for now it's okay to convert this into iteration and not
introduce a limit, at least as long as we keep an open mind about
introducing such a limit in the future. I don't really expect that
anyone will ever abuse this, but if I'm wrong and this happens at one
point in time we may have to introduce the limit retroactively.

So: I'm happy with your patch, but it might make sense to summarize the
discussion in the commit message.

Thanks!

Patrick
