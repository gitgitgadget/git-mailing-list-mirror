Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69029ACC0
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313713; cv=none; b=YgfDbE3xJa4+S1mv5Rb+AV91xnxhgPTZIgV2V3K5EVo5W0QFL1pvSM1JcYkxgGaXAnrgBfZoGe80vwKdGd9JmXH82Y3nkGvNt6K61uiepgLZHIk1oYnmdczVeixLf3T/hhDLPyXoCY9KRmCNEQ/yI70HKdEXQB9Yw3qJQ8zISVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313713; c=relaxed/simple;
	bh=ysCWY9pOWfPKEn61JUWteNUHZwRVDMGL1847PhH6bmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5TE8WgC2jb11v8Z/DfqJ2eSE39g1YmSvX5Cyr9AVBCBebb/T2x2HpxJvnpoq/dkIrhGCmDS4DwYJwl/Ik28n2AQOK9ah39UX/VaWSuJZHGGz2BwngMfFI8665IN49p7jbUkqztf5rMOOblfl2mmoHSiHpT0ZGxjN1f8NRO+2gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XHHih4Cg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BGUVXavf; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XHHih4Cg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BGUVXavf"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 058BA7A0030;
	Mon,  8 Sep 2025 02:41:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 02:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757313709;
	 x=1757400109; bh=EFi0T94zpKEMMVeHLVlDZYV42+l0HzIwokor2uMb53g=; b=
	XHHih4CghtRUFfqVTtfHsp88W5sCoRQpOuj00YEawP0n0DY+YUe3yJRnG4QvQ9qd
	R6n3yDXXXg98DqFU6Z8kaWaZztmKIXPrPiMjCM2ui5s///nVbcfa3POL43hR5oUv
	cGhXIr9HQwM+e5dc0hDuuGJtnukfeEhSYTbVgQisbtEpFQMUwsgraHZxUqKWBWpN
	v3E9LmP7AAMsMfD0X8d2gBac/nqNc25Q2MLeTegFTpvQolva0Cnl03h4GZ0hx88b
	a4wRIKizMqeBA5l/3F7wC/QhmUnEYBJebD8dMh5pOotniIUbU848LR1bQb3XtEll
	NCKR3CKb2VTaTgOG8PwGeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757313709; x=
	1757400109; bh=EFi0T94zpKEMMVeHLVlDZYV42+l0HzIwokor2uMb53g=; b=B
	GUVXavf5H3zSG0zELzftdP0TCJyedeMpz8+Zh94+SfhmbuS08FLDM3CK6OAMTgRn
	1zHquKCT4ifOhXAr1dLVCEBK/MmfTGMIhPRmRPc8fRyFbcA3rvfc597jUWhV1sRe
	/8E0bbSzac/tNDwZygtIrNo7KEAR78hxvOmPwbK7Btk+xTZXoDC9tm5tlHRB9HHp
	XVN1rq3kPdw50RRnQ+c1JnZMMv2GkM32/FHIcHItqOkqWAjfhX+uKnvQMFx1bvqJ
	ctV3FSrrEsJ1H8Z3AVcbz4gvvqG+nbpzIkyiL32z7JkYwfClZx10iGzg+8UdQ6pD
	UIho4YjHjW36/22SqZKMQ==
X-ME-Sender: <xms:rXq-aPAKeWGcd3RZh5chrSFhjgmK7z9E2YSXNtDkjTPQdm2y0DfSvQ>
    <xme:rXq-aNEXL8yTcOjhCNGvRqoQb-s4CJ0-wqO5IDBdRwqO02vjv_o6VRVRwLLM-y4_B
    J9C43HVejuDFsRLVQ>
X-ME-Received: <xmr:rXq-aKP0yYzOUStRXg1fDcMhKFhH7VijcXm_UoEVtVEnN1YOsCoOyYK7ObdTLs8Bzu6ZuWFdQvbs1yya621260VMEXkEXsERuILRJpUXfn2pDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrdguvghv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopehnvg
    ifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhht
    ihhvihhsrdhmvgdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:rXq-aOj6vvde9VAtwAHxTKE-t7YmlAghrFwGjEcurhOSiqhDCCWNOw>
    <xmx:rXq-aK3M7qN2x6qbn3pe5Sl6QcYCe_iP7pQRBp6V1-1fZUZFVIsVQA>
    <xmx:rXq-aLnRku0h4lSIRpmVPA7YiEz0vv6SBQJcbwbyQamY6PHX1yT-AQ>
    <xmx:rXq-aJudd0rYSX2fvUFozwQvVHEwRPHQwGdzJp0OueeUZ0Zw1Yerpw>
    <xmx:rXq-aHW6wFoQ_bXvOZcbk8H32eBdlHNXvf_xDcG1Jy2x6e1jV6q0JaZ1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:41:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f2bd065 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:41:47 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:41:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
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
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 2/7] Makefile: introduce infrastructure to build
 internal Rust library
Message-ID: <aL56pzCk0Qmb5gRN@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-2-6939cbf4a0b8@pks.im>
 <aL2kPUokmioiXCOG@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aL2kPUokmioiXCOG@szeder.dev>

On Sun, Sep 07, 2025 at 05:26:53PM +0200, SZEDER Gábor wrote:
> On Fri, Sep 05, 2025 at 01:50:58PM +0200, Patrick Steinhardt wrote:
> > diff --git a/Makefile b/Makefile
> > index 555b7f4dc3..e7b3c8e57b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2918,6 +2948,16 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
> >  $(LIB_FILE): $(LIB_OBJS)
> >  	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
> >  
> > +$(RUST_LIB): FORCE
> 
> Why is this target FORCE-d instead of declaring its dependencies?

I was mostly doing that because cargo itself doesn't take any arguments,
so it's quite easy for the list to grow stale. Let me adapt it though to
take proper dependencies for now.

Patrick
