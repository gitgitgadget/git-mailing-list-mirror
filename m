Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517FC1A7274
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106505; cv=none; b=uUCAwSA4Qpu73az4Ii1O0NrTTIhbJiLxB52UDUwxMfQJLg/lylsyFPrIf+hjvcbVJVYXSZks60OPmn5/oHVxycFZ5uxpwYj28DjE6B/gMY59lst5BL4aVAtWbct16povjFM/l965geALq2Xv/eK55VzPMugIWF2K3DSluiLlniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106505; c=relaxed/simple;
	bh=VO4a0QxUEtGdytxsY28Ys16Q11yXjeLNIQ91j8MQnOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2FWUAhGzXKrYAu29y7I2U1rPXhADctqTZvycNj/e2aqIvDAq+CaEojgnNjqoyFER6VOTPXtqV3ehf7eU7NgLhzvaXnozbST60KkZM9Ex055wL2xdwiRs8ZYrSVX5ox+h4gLi0pcvK9envfasYZ3/q8pez0sYSzavHmn8sAX/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=imnM+iua; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCRnizj/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="imnM+iua";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCRnizj/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48F54114011A;
	Wed, 20 Nov 2024 07:41:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 20 Nov 2024 07:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732106502; x=1732192902; bh=7GNiD3JEAv
	cBehFnv6ySIZ7G7w1I20b6ydcwo+lQjE8=; b=imnM+iuar1UOmTJIF85hcnbHc5
	EQQuPvwkonfdeEB4uM0FMPhRYm9lnCfxNDVNiQZmPWVT1qoTmZUiGq9VcAmpsOIw
	7kbxT2C3Uh5sKX63TdAWy0MLG0smaz0eopjKi3KZnZDvAzdpm41AW0XThjiuAM+x
	YTd6w/1rgDUrOaAr6C6usLjSQz2x6z/wPRjUlG6kOaeNAiXkJGlWan7zfL79ld5Y
	Ia46DqVPIIye9Jt5K381ZlxIJdKvZoZog6IKsWwSrBw9+G7aa5/qBnsWn1BaNQ/P
	QvO2dskmHtKRLHD93lbqVEYiaTpV0czFsTKYzE9SkCttSZ84MMb5J8oAT5UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732106502; x=1732192902; bh=7GNiD3JEAvcBehFnv6ySIZ7G7w1I20b6ydc
	wo+lQjE8=; b=VCRnizj/+h3akUe/W+hUFg37KGjnROFLRfydOOdS4ebLyFoFVFd
	rM58RMibfs7MRJL/bl1Cy03vuE+vBMo0JaPmZyu6AshFhASJBgckgUuwAteQ0ner
	sP3oXVaaq3OVIPg95UC2fUaOPCrC+OG2Oc+yb+152REUC4dqw9SaffKD2B6Bcne9
	uqLEAlVpl11Prcw3/7ASXGI6l08u5C9uvkj4Uee4gRKpMMG1rAgRA9cfmAu4ggZl
	XrtZRK3G1mfYL3DqVnksl+ESGvZzQV7Hh+nK83w74Y5QL75/TM8EMveqJ+9U/UE3
	wQzZ7xfeNUWdUhbZcWSuH1frDFje00Dxidg==
X-ME-Sender: <xms:Btk9ZyHLP50H8CV_R7_Bd5DUGlXlzMRvUerZK3TKYvNhS2Au4_vd4g>
    <xme:Btk9ZzU_C20z4St47PFSIF5vZ0ki6Ekm_QS_ta_GjskJIPyoJ2St_2clkCh4BVGKd
    CkLU7QfMZ2Rasx7mQ>
X-ME-Received: <xmr:Btk9Z8Lfz7oRIof46TecFK8lW30mCaMiAleaUO8VeFcbdK8YK5A5kyX4EBemfhRxDNxXneoSv1BSXnAYfuOepDVWigNWEf4Iv5cfvOer8GnXpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrjhhushhtohesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhm
X-ME-Proxy: <xmx:Btk9Z8H9RRXLcm4Y7aMn8cz0Ic9nFsiVDrRQandr2t4Q89c4xaCu9Q>
    <xmx:Btk9Z4U1-HiJx569jw-y8XG08eDseJt_KiYVYLmcRwDH_1zaCrThpw>
    <xmx:Btk9Z_PjRq_GzHC-u86YrJ_5ik-1FdpGLQce2k-iL62Ha8felDQ9ww>
    <xmx:Btk9Z_3xnKLc8WWHJ6UUpqHv2h6Hpb0TDOUHjFT0MzLoPnDqLhm10Q>
    <xmx:Btk9Z_S0fmRjo6DslMxRMX_S4O6WnqvENAG0xknZ7P2fMHdXEGopRsq->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 07:41:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 04cd1c73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 12:40:49 +0000 (UTC)
Date: Wed, 20 Nov 2024 13:41:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 27/27] t: remove TEST_PASSES_SANITIZE_LEAK annotations
Message-ID: <Zz3Y-yEqgaHeyLvB@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-27-6154bf91f0b0@pks.im>
 <87y11erxww.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y11erxww.fsf@iotcl.com>

On Wed, Nov 20, 2024 at 11:40:15AM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Now that the default value for TEST_PASSES_SANITIZE_LEAK is `true` there
> > is no longer a need to have that variable declared in all of our tests.
> > Drop it.
> 
> Amazing to see this finally fall into place. Thanks for all the hard
> work. I've sent you some comments on some of the patches, and the other
> look good to me.

Thanks for your review!

Patrick
