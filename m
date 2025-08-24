Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C82D73BB
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756056329; cv=none; b=QEPtb9zcQek9QDHsgKxbOaNzh9v96NU6+VHWfj1EeqAn4vBHSUHCwfctozJ1EV1r/3ZqJ+VYT5BdT3sVyA0+YkJLo4g3S3/QWFjwrFxP9erqRCmJikagiKHGie59a6jjJlFPlaWMluTikqFEuhOzwjrMLan3mXikV8R1vBBNkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756056329; c=relaxed/simple;
	bh=nom654CCcblnJ7InqzR3z1WVKRRf4s2gCHfsPT8KWp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee5/q+ca47zo+s9X9tORNwJEuHcbLaUFtcbxKdHbcuaacMyns2JdWX9O21TS0KEWsnYxJAYI9a6KTI47UuTGPMVaUiTeHY63MDNAlzSDl8hmlYqdnw4ji0AYZVTCNi0orZ8ntHAW0YC7WvYq+wRWYyRY1X8VhoWtRCvwU6/mfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ly9zUw2W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dcL+Hckt; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ly9zUw2W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dcL+Hckt"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FADF7A00C3;
	Sun, 24 Aug 2025 13:25:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 24 Aug 2025 13:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756056326; x=1756142726; bh=CArN36e2ZW
	FPWfB/HZ1TTW+0dhaS/selbpf4010OLDI=; b=ly9zUw2WTnEBu5NSQ6zoaJtDqb
	xCqv/EU1oUKQ4WdFY3XL4DG4edSIKxY/i97uWTkG9VWGiJTef5cdFRDoxlSedn4/
	1d1Fr1xPEgI8trB+N1JyiJQy8MZEuaEWjxLAXT2en6N8gIekv5irO6B0cYXxn2o9
	GFh60bY5WO5lxvhtyTCNBVhfUraVEVNLE7rXXzbjctizhMR9JyRnEmGdSzlJPnsw
	X65GP2mOU8z5KIhu525X3MElIiM7Q9CMKot9nX5HcnFx++LmN4I1BjYIwE/kMpU8
	o6rquhb7XpJFCfDhLJua2vR7EgLRiESQPrCQGOd3oUEKnL3hlmcB4jpGzmqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756056326; x=1756142726; bh=CArN36e2ZWFPWfB/HZ1TTW+0dhaS/selbpf
	4010OLDI=; b=dcL+HcktY3afiyZJCz5ueA/FwbW1TLO7IqdLEB0XqDmyxhRrHY+
	ufAiBUh5Cyy4gOgni5Qz4gTYcY0vOwc/4uH4duPNaygVixAD+8CGI60+r+HSYvIY
	SZ5PYuvZOwDBNFPo218lLT30lgA+EOytCEvLz5VoJtx1CTHKpNd7rAVeSYXdK74t
	U9ATMTfF4uxukb1fTZYDUSQTx8s7/gjz259A45D4V7fY4awzdHNrDkavcRSHQC80
	Ga7pqnU5jsSTPWe2Ui0CVVQP+W36i41oOgStvCWXLYVr1SzPieyxHlI15O8JWRJF
	DV76RlMuXpZr+LYrdR8zhcu9V9TODwPj/Hw==
X-ME-Sender: <xms:BUuraE8cwnZmkZI9Ix0ZfG1o5myG6rgn2yR6F9wY7z1dxYm1fudaTQ>
    <xme:BUuraDmDSvsBe_JJKLQTXhsbLTq2_PUG7g8KE7NvF9CpEC6PACOg5sRqZEI65ZThE
    h7BqoCHuqqnkt7oWg>
X-ME-Received: <xmr:BUuraG-WvGGIwxDNTh8h9X0BBrrnWTVOGzTdRLvu813ErDb5NMmmh8jHfstKOQ7ut2KBYVbAY0nqlGahlA6oDNFmxEP5Bdq2ldbngiDn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgu
    sghgrdhorhhg
X-ME-Proxy: <xmx:BUuraBnRmmob2oT8-lUaJIqHfUbTTr9RKC85v9TEVePdbZ34XOrP1g>
    <xmx:BUuraD0-AlBQoESgNTH-tH4xJH240tv1Ig2EobFCO6kWOQ7ovBqvKw>
    <xmx:BUuraMpbBcm9JxkAlBmEbg71kpIw41bQ6EJOqI-1TKhziwjE9u4_DQ>
    <xmx:BUuraAefFwtQcBljsZ9i5m9GYg5oVGhZbIov8-9V59iMqMwG7Xg4Aw>
    <xmx:BkuraB9VMnK0GbgzUoU-kjXaFcptalL-5easWgTWuRZDpSiT9VHQkgqY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:25:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27e824e5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:25:24 +0000 (UTC)
Date: Sun, 24 Aug 2025 19:25:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/3] meson: wire up gitk and git-gui
Message-ID: <aKtK_4GMLo4_e1dt@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <3571209f-2f4d-4549-978b-ad262ab3b274@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3571209f-2f4d-4549-978b-ad262ab3b274@ramsayjones.plus.com>

On Tue, Aug 19, 2025 at 11:25:02PM +0100, Ramsay Jones wrote:
> 
> 
> On 19/08/2025 09:18, Patrick Steinhardt wrote:
> > Hi,
> > 
> > I have upstreamed support for Meson into both gitk [1] and git-gui [2].
> > This small patch series wires up support in Git.
> 
> Just a quick FYI, but I think git-gui needs some changes equivalent to
> commit 586919c3b2 ("meson: fix installation when -Dlibexexdir is set",
> 2025-07-16).

Ah, thanks for the hint. Will eventually fix it upstream.

> [I don't understand the difference between subdir() and subproject(), so
> I'm not quite sure how to proceed, but I guess git-gui is a separate
> project root and 'options' will be passed as-is with a new context?]

Yup. This is done so that both gitk and git-gui can also be installed
standalone.

> gitk doesn't install anything in the libexecdir, so should not need a
> similar change.
> 
> > To the best of my knowledge this is the last missing piece for feature
> > compatibility with our Makefile. As such, from my point of view, I think
> > that we can stop treating the Meson build system as experimental and
> > instead officially endorse it. Once merged I'll thus send another patch
> > series that updates our documentation in various different places to
> > also mention how to build Git with Meson.
> 
> Hmm, that seems a little soon to me. ;) I still have quite a few 'misc build
> updates (part #3)' patches to send to the list (yes, I have been a bit tardy;
> sorry about that).

Looking forward to them : 

> Also, let's not forget the 'quoting nightmare' [0], which has still not been
> addressed.

Fair, that one is still outstanding. But I guess with "feature
compatibility" I was rather referring to actually user-facing things
that Meson cannot do yet. I guess overall it will still take a bit of
time for smaller follow-up fixes to land. But in most cases I think that
Meson can be used without issues now.

Patrick
