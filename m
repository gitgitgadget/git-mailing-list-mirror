Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3477115
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548458; cv=none; b=GuxMOwXNHLLd4+puUXjV0t+K+9z7pTIKh2IxVwE07JODF6j7nFtWqT11qsrGs/jxtR4uMsYZ4qaLa0PQZMIrJbAn1Sl4CnCP9FxPuKd1fsDtB9gqoqAJZhsmpdDR8tF0R0FSjElpVIEDdD3BaohQ2mN/Whneh4bDwHkrw7Ox3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548458; c=relaxed/simple;
	bh=WEuyIV9CiktTfzJsiG0U2tKnXOQzpi0LC8MKBpJL7IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr3OEw08SoNc9IPCE6EaeS9ZTm4aDNuJ8yhKYhJpPKBLWeOZE64yMtYCCNxT1mQqOADEsf9nTT+qKT/ykf7QMB5SVNaQItoLQmLMcTrC23ZA8T/4oaw3LKP0i6B/+HAFj00162MJIkAtPC7ZZWTqFCLEvGRNsA2B2dsAU40Z6So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cmQI/K4K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDU7IMo/; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cmQI/K4K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDU7IMo/"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FA3B138036D;
	Thu,  5 Sep 2024 11:00:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 11:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725548453; x=1725634853; bh=NoCMyenrfU
	jc5S7EC9aoXhI0/n+dd6PMxjBzqgnAYr8=; b=cmQI/K4K6q5lzG7dRRN9SuDTjn
	LIV/8hgtb9fk47bnqTwOV6qPwax+2d/tTGt/aqFB06B4BcH+r42UKx2kkuNw3k09
	nxErVRMVn8zC++SZmjHB1cR+JR6x57iXJkRtQJAGnuBPKBNDibdkZXhDJfCjJb7+
	DRpPh5+rWsZ1yhWmC0pKLyatOnLq0/YapBci02FTUI3BfftOS7caD2AdmxwV6yFx
	bQhz8nWhmfotEh2nVYK44MtMFAZGfyZSw/LPjAAGIXLnDwymFOiIZu7+oI8pLfOy
	RJxUPd62JlXEXeRPTtkRf1ODDRNZWRQRYl/ZJglTvYG6H1oF7zS3ubzObU8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725548453; x=1725634853; bh=NoCMyenrfUjc5S7EC9aoXhI0/n+d
	d6PMxjBzqgnAYr8=; b=SDU7IMo/jHLZAJAoaeUba2Lw3JU6IeNkMLAf/8mafUDV
	shWJ3rUDBBGk/ZVuPrK8W7k/B5Ma7tlqixy8BzLlk6Y4OwvsWG4I4QXv1QC8DcOf
	xSX6igLUg53vL+KnbNI4QlvJ27tJbjAc/FBsyEfNaRq+bIUNaYY1jxheqK01yMbP
	ESiBdD12QhuGHEAIxT2ZODgod3iVbuPBP8rPZ0S/7ngrRYTsnhzICWf8Pq1K9dif
	rxrpdcrk/Neep11KpzU5HdUmKFSKjsTl35oftBm92oYO6rXFnGOVfh+kqEuGR4R3
	Skjaa2X7E7AWu2zX1zx3HdW2CdD8aW0vRgDG/Id/9w==
X-ME-Sender: <xms:pMfZZqfTu7gA3v0rXGJmLn1W9PhnPF87aghsfRRQW_WxVcqfhighIg>
    <xme:pMfZZkNEC6B9jDFRUxqhn6fBdCB5bhFAHqxAH-EdH2TTwzwgxrMfH2bzEZvChCRov
    SgNDUtR1rVFkIsALg>
X-ME-Received: <xmr:pMfZZriaREMHL2NUbt0egkSizQka69EylxlwBhvxgk682LmrXzDU55R5-pRxUBmhcTJ9--7IgBBbdCw2ULOkRZucB9pVS9sfOJpyMux5U0SE3YM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pcfZZn-cur3aTdQwWbVZsTxemhVUQ9vz5K1TiiAZJe4hacWiF5lcxg>
    <xmx:pcfZZmuAZhTXuxolHT_ZIIjSqca_KLdfgGzcQzX39AqnsfsbPSXnHQ>
    <xmx:pcfZZuFrj3RXpQzGdZcZ9FrTUMzYeMADPbc0CtTfhCvZv3g0mcELqg>
    <xmx:pcfZZlOmBoCf5yWl1D2cCQVS66VNhjxq8DlLrqHgOzUdNg-s5JZMbQ>
    <xmx:pcfZZoKMGY5XD5Hwmh1Y_Y3IDHOA-K999dD1tUXJ29g9D5uWB42Yhs0A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 11:00:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aa2502a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 15:00:38 +0000 (UTC)
Date: Thu, 5 Sep 2024 17:00:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 1/6] t: move reftable/stack_test.c to the unit testing
 framework
Message-ID: <ZtnHoNYbBh0Gkqza@pks.im>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-2-chandrapratap3519@gmail.com>
 <xmqqmskn9w3o.fsf@gitster.g>
 <ZtlafDnM-geVUTQ9@pks.im>
 <CA+J6zkR35jgmCuWniqDBBcTOW68V3Kzn1x8Yc5PZLHxO_cPtaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+J6zkR35jgmCuWniqDBBcTOW68V3Kzn1x8Yc5PZLHxO_cPtaA@mail.gmail.com>

On Thu, Sep 05, 2024 at 08:15:53PM +0530, Chandra Pratap wrote:
> On Thu, 5 Sept 2024 at 12:45, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Wed, Sep 04, 2024 at 10:17:47AM -0700, Junio C Hamano wrote:
> > > Chandra Pratap <chandrapratap3519@gmail.com> writes:
> > >
> > > >  int cmd__reftable(int argc, const char **argv)
> > > >  {
> > > >     /* test from simple to complex. */
> > > > -   stack_test_main(argc, argv);
> > > >     return 0;
> > > >  }
> > >
> > > This makes cmd__reftable() a no-op.
> > >
> > > Even though you cannot remove t/helpter/test-reftable.c, as it
> > > contains the implementation for "test-tool dump-reftable", we should
> > > at least be able to do something like this.
> >
> > In addition to Junio's patch you can also remove
> > "reftable/reftable-tests.h".
> 
> Should we get rid of reftable/test_framework.{c, h} as well?

Ah, yeah. If it's not needed anymore we should remove it. I have a patch
series pending anyway where I deduplicate some of the functionality that
we have in multiple reftable tests now.

Patrick
