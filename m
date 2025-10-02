Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E52313276
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411885; cv=none; b=N7dp/YC4W9w+jZGEXwUY+8wtg2lZct1D3OK8oBpUtuHxRIox5Ot3khaXDsBbqOSwZ4u1JLWtnRZ18uyZa2rmye57q5XjzHdZDjP89rvfIBQE545IYI2yAOw/3Mq518tWRQ9/YDS9hwcVFmjkfn2q/A3njb/R/7tUYVgsa1xtTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411885; c=relaxed/simple;
	bh=N5wErHgr2crnOVnuome2+AUhjVh6gbhdrVYu0r6eehU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ywb52ztm/2UB6RRooGnbtF4czo1Lo4VCcHS4pqRVaMGJ4UfytOWmSSIwU9+Bxp7Jvm3s7HWFe6YlhvYkPZ21vJgv1472aGAQ20rlKQ1Qi+4TYYfrZj12rd7ba/XrTrUPJkFHahbGOlgEWOri61FjcO3HZrlsrbHm/es0T/9wuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kWKBzvHi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DtSV2s8h; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kWKBzvHi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DtSV2s8h"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A1F251D007C8;
	Thu,  2 Oct 2025 09:31:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 02 Oct 2025 09:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759411881;
	 x=1759498281; bh=IoMnmkbFDOprjca1sTK3Xq/boEL2OzCqpVwomDhwn0w=; b=
	kWKBzvHiMBXiIMtSPmCaZoMfCCUycowqIVGRFAQJf3JWjA7dpWrdSTHGy2X2zt6Q
	S1waDwYgvDtDebhyW8P0UhnP/NK/Z0HKg1Ljgp6ZdKdPGkEEfNrBRR7dmL9biUqB
	HyXjU1CzYjEwx516QxzBYUuChPLXS1G6Lx4PP2aVXgK5cGE/ygwh39B4xdTV/RDR
	cte1KY9oQ8HbLRdFKsTyCs7MH4GQDGm4LESTWKZTcJBpnCl2Con9nAw564AtHVjc
	QZv/LyvnHUGH6Lg/Cp7QW089L9NIuUU1Jsj93hCw6HHQNOjbV90hWbdszUn3dFyn
	iU3JycklOtDHwXgWJAMCRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759411881; x=
	1759498281; bh=IoMnmkbFDOprjca1sTK3Xq/boEL2OzCqpVwomDhwn0w=; b=D
	tSV2s8hEd4YsWfR82z92Yc81Eip+LppeUlyVXkYBXx9rHRnRV7MDB1brfjxCT7Vs
	ZISGOOXriSByWiEIpaS8ckDNuOXSSvM6ttlQVlvCBuOZUQkpmJvWAlT2ePdiD4ns
	hU0bW6gD6JCA2AZ3QIwms/drUK0syS05U70B/D4yJblPIP1TGnxVKmJRUZmCQPB+
	5TewrQZ2/q/lfxTwt8+SASlsPsPiiw/a5Pb8uJWKlBE+cTV4AhpWazr5boL98J0E
	QycRGgRj/JQdUtFpSaR/r0DK7zOUMxAKrQolADkGYO2nWGDa7JNgQFfQlKT9oTZo
	5+28BbMaH4bQG5wj6q0Rg==
X-ME-Sender: <xms:qX7eaN10gDGDUoH_qmSzICL9KqdXSLCWa2eoB4P0VqOWE3ADImIvJA>
    <xme:qX7eaLhHPpC4YC0waTW7yA8GgKsOSu8RMyoknVdZvreOHZKHTPjEJA4pO_Tps9giK
    PIR19e8epo9gMQaeKT6CxYgrSuWhuOd7DWDNsxt7EkD6aTE4F5jwg>
X-ME-Received: <xmr:qX7eaLThEUGk0MGk-yc3TaTds3ebTHnWt5HMY9W4dU1ilH3ZY4IvzohqHOdKU7mUB973AY3BFSY-JYiNewinPFnD9gAnA1-9ZohbWlaspg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrrdhmihhlrghnvghsihhosehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:qX7eaEhVH9jopS2mXuTDpfVencs_f1CK6Zt5nDosPdpG3Kvc6-nQ3Q>
    <xmx:qX7eaD57t6QVsHIsw95Y5lC0EiG2ndX7VyZhMusRSNb9NTHROMRMAg>
    <xmx:qX7eaJCukmZkxdeg6syY9NLwgA7M2FLffjfZ4T1oddUUPxii0SKp0A>
    <xmx:qX7eaCa93K9qU0FfZ9hlqr-sjriOuah_3Db2-CUeT_iR0WdxBV9HLg>
    <xmx:qX7eaH8eb3kavJJiHGkv0fajlR1NFK8hPHS8LBG2R-zYsnJc-x2neApm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 09:31:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36e6ed69 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 13:31:18 +0000 (UTC)
Date: Thu, 2 Oct 2025 15:31:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aN5-n_ArhQqaQZgt@pks.im>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN1RFvz7uGPnepxe@nand.local>

On Wed, Oct 01, 2025 at 12:04:38PM -0400, Taylor Blau wrote:
> On Wed, Oct 01, 2025 at 08:13:12AM +0100, Luca Milanesio wrote:
> > I am worried that if we rush into Git 3.0 with breaking changes that
> > would make other “forges” (e.g. JGit) incompatible, we would be in a
> > difficult situation with the other Git ecosystem that isn’t based on
> > the C-Git implementation.
> 
> That's a good point. I am not familiar enough with JGit (or really any
> non-standard Git implementations) to know where SHA-256 support is in
> those respective implementations.
> 
> But regardless of whether we're talking about a forge that is based on
> git.git or some other implementation, there is very likely lots of other
> work to be done to support SHA-256 outside of flipping the hash function
> within Git.
> 
> (I'm thinking here about database migrations for columns that may store
> 40-character SHA-1 hashes, for example, which can take a potentially
> significant amount of time to migrate depending on the size of the
> database, etc.)
> 
> So my feeling here is that we should take into account not just the
> readiness of the underlying Git implementation used by hosting providers
> in the Git ecosystem, but also the readiness of the hosting providers
> themselves to do the work necessary to facilitate that transition
> outside of their Git implementation.

We definitely should take into account the readiness. But what I think
we'll need is a roadmap from impacted Git implementations and hosting
providers so that we can answer the question when they plan to have
SHA256 support ready.

Without such a roadmap it's basically impossible for us to set up any
realistic date. In that case, we only have one of two options:

  - We just wait until eventually everyone has SHA256 support. This has
    the effect that there is no pressure on anybody, and thus it is more
    likely than not that it'll just never happen.

  - We set a strict, "uninformed" deadline that may be too ambitious and
    unrealistic.

Once we have roadmaps, we should set a strict deadline that takes them
into account. Any hosting provider or implementation of Git that doesn't
provide a roadmap will not be taken into account in our planning.

We should of course actively reach out to the projects that we're aware
of so that they have a chance to provide such a roadmap in the first
place.

Patrick
