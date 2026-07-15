Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6503242CA
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096541; cv=none; b=iAJ8Yufv6uYtJkunE5dtNfUYYNMJikALye2xmdzZHjWiQSzzlF70UUNfNm6rHBlg4zxsBenM0wqG2eDTk0/T2Ej4vOsmpsLKnj8MNAje+hJQ5FM/dYLheOBJQZUhnLP3N9gP203kY+c8EO3uKv2Ilvk78RhAAc6yFRd1RGs0IFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096541; c=relaxed/simple;
	bh=0clqbeJDgMpwZwVZuHLCJwDj9I4onw2CgkTEDjKJ2A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZK9Or958maCfy37EirSuzxtI8h43ENujUwHkEji/eTG2Co0YvVBsgYpcJctq+mumIA4Wouam23XEkvk3a9sE94jFKnynh7wE0z+5Zx4TT9kX4dmMqafg/fwbQ2MbmSvYvw5qx16jjLynpXZnJMiSdqxhAbTqi/VrRNjJvzc1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M+S4rR2f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d38X/sDI; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M+S4rR2f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d38X/sDI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id F3F8A1D0014E;
	Wed, 15 Jul 2026 02:22:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 02:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784096538; x=1784182938; bh=nI0ez0r0W+
	CX8jPGBLnJ/fCoocUsbbDQwE/omot9wxY=; b=M+S4rR2f/jAXjM5se+5lOqqLVo
	21tqGkn+TupCh9vVIcSDvWWBq2JrBtkePREZ33wMj2Tkd3vYy4v4mrYPCDsGC1um
	dOXYlpz2wE6TMHileUz39k6/9R6CsoTVpLfuapx+Q7VgosrwrlNk4IAVrvBQQHrA
	NYT2doSYj/MH5tfse5px5uIjeLNj/V+w1+Winr6xEGsHrw2MR2sazk2/RS6paBQt
	SvWYS3oX9jNgUvkUbg/xhsa8/z1/cMo1RtaRvWi8gAuqXYi4NGntBnO7ptXrV2a6
	pU/k1W1W8k2MoadAoVRz90NHUv64yAXqpM+mkfaTWJuyKm7WpqqFBOTCvp8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784096538; x=1784182938; bh=nI0ez0r0W+CX8jPGBLnJ/fCoocUsbbDQwE/
	omot9wxY=; b=d38X/sDI5yNQjmkDD+OW2P5IJn1H3a9UHvQtQXn/3NJVy1BvKJs
	uqOvsAmhbruMDXuELn/CgXHRKRDy7l3txZPy7vewtw+otOkv2Hf7NGIuQm1bbKbs
	0EEPfZeayN2C7aOqTkUNShooaEWAA82l+QB7fYDAkCCtcmJ+hvjJwApowyNqQEOJ
	1KYTGES3lrYw3ikfHNKU5iYKNPBjDMp4XUqsIEgSeqv4ow6FA/FV8jt4j1sUuQN9
	vHJvgfQKg3ogWeA3oUKnK7eGFPLmvNzwehmQ/Kj89DCZ0tyiAoY3zrGey2H9M9LG
	oVBZzRyDk/q0aXoapKVFAaNVjRINGs70Ojg==
X-ME-Sender: <xms:GidXasx4K911WmZjIDbtU-rP6qmH6VKeTdd0Y1-9tjrszX2nMBeR1w>
    <xme:GidXaj_4inUYslHA7jNm1TbOAcSuPHh1hx_apYEXtYMc4QBlKQpuMWWTD5j-_6q6x
    -dp_qlFQp67RROVsCxNfWMW41M6lkamQKX7iqsLJfqyYjTQbOKJAg>
X-ME-Received: <xmr:GidXaoKnC6w15-gjnNs6TWxEPb696-Fz8g7z_7CIROaos05axYiTHwh0Aea5Jec0Nx1pT6benE_NIUamC2Gu5oP0yaTk_99W5OETI-wb6Ac>
X-ME-Proxy-Cause: dmFkZTFnq6BjvV7j7CVhf1+vrvN2CADDGSCCA19lzUGse1RMkhClLiACu0cAuTwtpJbosK
    mc7toRsrYPrpm4r1Xgc2Pn/01n3Q43CnippLy5lwvcDqzPCxrOJ6SN1AcuSWVZiZTDBZFw
    BPX6WGLpK2rsVGLu/94pIUupXToBtAbiXd9+/hPKEGbPrbht1a8coKew3KS7ZyKo/6bWrx
    Amzlgy5gnXOq9hlXoVipvAD2pwp0XamrcEDpSTlg7auMZvrdlwNC/oRND5C79b2KdhKZIA
    O+Pr4ggEBKCiU2bQBikkpZp+RTZzJRnp8nW2Yzj91pb8y6EQANUSEQLAl4K5Zk5dxaI0Gw
    RRI8IbfYePCY5tG9vdAbXRyEIQsukFY5gU5a1WusYjmkmto2axFMfIkMZe8Z/PH62swLMY
    w+DP1sH1cuMhu8MVwRg8PFi74JOXG7Fc7R/LoYgt3NHYCapiKEoljXs7PoFqCgEUoMq3IV
    R0ZQO6YaMz/zYIOfNKNLyRBfs/yR8h8LTliQGuw4rJbHpKfiPHjaraRYv4h6196HuAtTA1
    M2YFCRx5PBp3QnU980I9T3pS9FBf0EccBhh6pYrl1dZuWP47ZjgLfYPKrk1LDmAZKP0ktN
    hQOdliKK8GBLnFfV58gksm6HyV/b8rTR/jzBBBfcVGEIlKF2/Y2jXXyQmxsQ
X-ME-Proxy: <xmx:GidXaheOOsWcJ6vcJe2BZpze5Bj493dqJgBXImkyXWhN3GZEM2TjMA>
    <xmx:GidXav_4QOvbkXe_c6gwjfCMt9vY8kGPjjFE5T9oF7aWVHb9I4G9Jw>
    <xmx:GidXamo9o8bxf8XJzgOzLfUWZx8o1WUhBfOKf2HjHQxh-n1U-ihTUw>
    <xmx:GidXasDYbtRFzCHJDAEB3S8qsB2D1ZdDfCBprHNtKgcfK1dnNnoVNw>
    <xmx:GidXain1JP5JftHa0VBa5UFzBXUMsLT_sr0gtVW7dY8BJLWCq6VLau5X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:22:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 243d232b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:22:16 +0000 (UTC)
Date: Wed, 15 Jul 2026 08:22:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Taylor Blau <ttaylorr@openai.com>
Subject: Re: [PATCH v3 7/9] pack-bitmap: introduce function to open bitmap
 for a single source
Message-ID: <alcnFcpxNWa150U2@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
 <20260713-pks-odb-for-each-object-filter-v3-7-b3c65c641073@pks.im>
 <875x2gn7rx.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x2gn7rx.fsf@emacs.iotcl.com>

On Wed, Jul 15, 2026 at 07:25:54AM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The function `prepare_bitmap_git()` opens the first bitmap it can find
> > in any of the object sources connected to the repository. In a
> > subsequent commit, the "packed" object database backend will learn to
> > use bitmaps to answer object filters when enumerating objects. That
> > backend operates on a single object source though, so using a bitmap
> > that potentially belongs to a different source would be wrong:
> >
> >   - The source would yield objects that are not part of the source
> >     itself.
> >
> >   - The object source info would be attributed to the wrong source.
> >
> >   - With multiple sources, each source would enumerate the same bitmap
> >     another time.
> >
> > Introduce a new function `prepare_source_bitmap_git()` that only opens
> > bitmaps belonging to the given object source.
> 
> Tinies nit: this should be `prepare_bitmap_git_for_source()`

Indeed it should be, good catch. Shows that I've been iterating on the
name a bit :)

Patrick
