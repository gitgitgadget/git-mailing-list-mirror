Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315B2D543E
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831174; cv=none; b=Q7cZ4MKjzGqqeq5tyJimv2KmzLy61EobAozPCznKIpRRCB7PkUxej1ZYlmhruta9GqIfvTnuMrreaR9VLwk4ckmjdkrxi5LzZTQwlJK191Ygri7Wz1fKGzj9+IJ/6n1zceqFCHDqBrC+G264rElSbBcP3ZKYmoJMslyJE4FAV68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831174; c=relaxed/simple;
	bh=YTnVt/sVKiKhFxsMhnpzWYr/F+1KWug07fhXRokktXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otBTdMzqO36u8iK+ahtN2SWdl3bKdNNlLIbnMmev11B2yW28pionnmkLY+dOw96N6uon90j18tKdVxboOYZ2AH2MSy7YJEh+CydHDFxjI6JKduHXNHeMcVtirlHlE1de6WwzRZUBEb54dcE7SN3i2GuoEJDDfE3Xg1nj26MKPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iaVqRiB2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OfgHelSe; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iaVqRiB2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OfgHelSe"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D98FD1D00234;
	Tue,  7 Oct 2025 05:59:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 07 Oct 2025 05:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759831170; x=1759917570; bh=zriOyUspPm
	cnQTmlyEn3GHKJNWpC8Jc70gbRptnkBIg=; b=iaVqRiB2rtQ8+kvW09M5GdHATV
	Lxf+45Q1oce3mIXkIaHB1A3jYpsGz90o2hoven/E8NWj5kPF6K5yvwR9eOiAicGS
	D5WLdHnHDvTLrzDOcXVsGM3k8Oke5zsW3U712HfKagcDwqzvct3fqSblL1KcY1sH
	YOqugapnWlcip3Bse7sXjJXYZS7XNKliW5jb6cOTCnXdclfX3I+3PCbF9hO3jMaG
	6TjGWaZCHoWdHGboCCpP33HBLQWlONX8cme7tKkf1TobGRNC98E9PIywk36QAB+X
	UJki93LQLAzzKELhmdx/WmE1BUkd6WUflQOpvdDWMmk3P2mTtOBODy9cRdfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759831170; x=1759917570; bh=zriOyUspPmcnQTmlyEn3GHKJNWpC8Jc70gb
	RptnkBIg=; b=OfgHelSe/HHTqqclAUA7ho1mMBt30+mOFhKvGXAHhreQgkIAKxC
	2z6KH8K+2XZ8JVbLkBdoeOj9RH39aU1YfeKpGDb7GAzJhdP7Qr05qv5aPmx8/rgS
	dRA0Cc2uR/clGoId4MGSZqop5aIFpRN/57Qqd0l7vVkFXjDm+1dT77H57IJlEq8f
	jmYMa9oSa0EoIXAAR4EXJQJYe9KDvTPmTDE1PLzAAygSjLEZzfqa8AWz2oqD5IqL
	D/i3rIu4azuJXln4EvdnO7BFrydxdFPkXO+Ysm9mnpLfcQQZJ9kDunNtm4cqkAuP
	B18m6cSoP6eSZx/HdppyVtyXdT91PSD7YNw==
X-ME-Sender: <xms:guTkaImuNVDBWaNPIgrvtr8cU4TtDIKrxsX_KjesYHw6aXPc5vd1Dg>
    <xme:guTkaITZoEm0xSjI6g64s_ear3rzzt6tk3aX-luJ0US-qSRXhYIVGDYBcKexy0r4T
    PG5Kykyh-R9tVfZsTVqU3Xn1kCk3dI5AmpwxZm4krUJuaaoDLSS>
X-ME-Received: <xmr:guTkaGalfDvUlStC_h6WcnHxQ-N7vMCxB-QYXl0SOv3PQq1ZtTST8mmZzFnYl1w31l8MJTDEnd3cW_qLyQ6Mpm4xzHr0akFdh_ZDXnsMpRc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegtohhnthgr
    tghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhg
X-ME-Proxy: <xmx:guTkaA_gRZVZBvgD_bZJCviNd0kYB6H4SyirlUd0SOyzjxh2rj_7NQ>
    <xmx:guTkaAnrjABvGpUzeMJPxIAXxiZDZsvc959UZEF3-xJZE3VGARUlIA>
    <xmx:guTkaFaIKQXYnavvMvSRv22UTRobskQ0Gce-FlM4IAzd5f9w78eB3w>
    <xmx:guTkaIPYxdqiB2yzXelrvZ0_DhvIbFQJad4kscTnU97Qqp0UN5nF8Q>
    <xmx:guTkaOBjgkEg8UKmVScKRxCMOdbV9fa07xLGUXJZ8u5z5FGIbpIlNlKi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 05:59:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 304317b8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 09:59:26 +0000 (UTC)
Date: Tue, 7 Oct 2025 11:59:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v8 0/9] Introduce Rust and announce that it will become
 mandatory
Message-ID: <aOTkezur2PO9Pr4x@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
 <xmqq4ishxnr8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ishxnr8.fsf@gitster.g>

On Thu, Oct 02, 2025 at 09:38:19AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Changes in v2:
> > ...
> > Changes in v3:
> > ...
> > Changes in v4:
> > ...
> > Changes in v5:
> > ...
> > Changes in v6:
> > ...
> > Changes in v7:
> > ...
> > Changes in v8:
> >   - Some final typo fixes.
> >   - Link to v7: https://lore.kernel.org/r/20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im
> 
> Indeed.  I have a slight preference to see these "deltas" in reverse
> order but it may be just me.  I can read backwards, especially if
> each item is small ;-)

I can change that ordering going forward. I don't really mind it much
either way.

Patrick
