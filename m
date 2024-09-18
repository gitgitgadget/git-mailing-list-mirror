Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C699149C70
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 04:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726633889; cv=none; b=mlEQ4VC2vylL7VqFVrPGt4H19CdVQyczavZh2dDp4pXcUE2knofkN5VmJcwPUwo/pHIJmUDyIVLQL0nkXn1FzuDDohSNd7B5qCgm9A/vZiVAIIaSWUBP9+WLGC1ZvUIgFGTPeBY0K1iY4rney0cDDLvkMI0cxliLxaKmQiuf2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726633889; c=relaxed/simple;
	bh=vC9HTUlayZUwa0zMuh/QcgvmoQA0pHZmpr4+tefyq4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfv5CzPEHEPrU18K5nuIxAmdtx8V8MJ/w796iBU40uCmJOuS4e+PftxY83ThhPsKvDCji6bjl6pn0sxxPptkViOBGcnYjpIVcoU1/uY269EDBGQ1RaK36I0GJaEYH+kRXRTwo/Q6p5htOoMb+eShFNV3p0moS8oNhLlDX/ap/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GLq0vn/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BbyEjzPa; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GLq0vn/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BbyEjzPa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6446E11402A0;
	Wed, 18 Sep 2024 00:31:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 18 Sep 2024 00:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726633886; x=1726720286; bh=QXuqGRPBfz
	nk0wOWjWRgwztppS6zMnmkqeApICY8A5w=; b=GLq0vn/NUpup6frOT+XZVSb/+7
	qAfumkMXWDdrZ4uwAZBJpxgMIZ9zcqWgo24XIxVnD6m1Kkl0vZIXnXX5tftY7VdB
	OUQaqpn4946H7MN9Z5S6y0AaqHI6TSIMqOwhMsM9YFnSkgoGXPoOKxIRFpczlydL
	z262+tx7ePywiMiihccsCOJlcT95jFekGAVSydW5ZodLBznGsOGTCvcodvdzJmjT
	v+MHCJ9C+zXztPA6LC4VhKajdYpZRn95YbI82C709YnDEr1I0+Pb+g0mPxUFaOlC
	OMltDZD6rcWqcHWKcbLVB9EMtH08TPOj0qsF8PCHtSEwIdkiJA1YGei3wGbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726633886; x=1726720286; bh=QXuqGRPBfznk0wOWjWRgwztppS6z
	MnmkqeApICY8A5w=; b=BbyEjzPaSQX+30L/yv+Nzv6cwy8nIE7rfYXY1rbC44w1
	8HcUQKLKrO43Gs2Y0GUSGX65+pPRNTwMvAEeU9BMCF3p0S9vIJLBnqdAa3AJ1nxp
	ua6H1NBCviNx3JRs/uQfC7kaW2UqoExuP2LWdBuuLz4lggL25F7C/3Re6Ldb3uSp
	j8Rv6fFltSZrVOFXAVn7HcxMEDADo32i8vR8MYpcLuRz8/qagN4kNP7KwHlWWH3M
	YpMZs+rUiTnzwz6OdouFHgPwrYlvvmQv083XDIbJah+wTx+qFDaqoy+9S3C5FvBo
	hkqKdGjT16G0Nx8M/hfDvineB/84Nb/i0iYWMh/ISA==
X-ME-Sender: <xms:nlfqZkwggwLI0IN8xJ-6Bf_YGEPEagcj1fEYpCNBzZoYbcG5SUiMfQ>
    <xme:nlfqZoQk39b3m3gqiEsC_0SjJpdFKI-cZgl8sxw1eCHes-MXvsSdRUlUNcdRVAIPt
    _4e-j1BMQ7_6doWmA>
X-ME-Received: <xmr:nlfqZmV84RC0INAOgi6wp7V5_LwWZkU5aA6HjZsZZ6Op6qU2hH4eoyhi4QS-TX_Shz3Dy4IIWs_t5X23Y1Cwo2wO77bEXW9Jc5nk_XZfHQSURQRu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:nlfqZighxE3Wdb_Msd8a6leLhsSCFZGbOB59zMXcDsv4-uLYe0AijA>
    <xmx:nlfqZmDSb8-lSeRNSBJRg5rLW8meVgmT6thqLyrtiF8ZlctoFm0-SQ>
    <xmx:nlfqZjJvBXviV8B3r5gn5fcFVCUpPNtKo7aDnJ1kTnYi4pcFgIuHwA>
    <xmx:nlfqZtDV7JO_vE12GB-dFx2pzV4O-M_MpS8aTbBakovcdM2_G3kd7g>
    <xmx:nlfqZpPLvvUHuOztyyR44HAwF-lAnnsR0BD56k5s_0mclUXKgZ_uzst->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 00:31:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 89d7c03f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 04:31:05 +0000 (UTC)
Date: Wed, 18 Sep 2024 06:31:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] reftable: graceful concurrent writes
Message-ID: <ZupXncLHidkSW3j8@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <CAOLa=ZRwLYLba4_mze5cDRZqyG+5+-F+sQmuzf4Lt1LKVo5_CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRwLYLba4_mze5cDRZqyG+5+-F+sQmuzf4Lt1LKVo5_CQ@mail.gmail.com>

On Tue, Sep 17, 2024 at 11:26:58AM -0700, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > the reftable backend cannot properly handle concurrent writes due to two
> > reasons:
> >
> >   - It will bail out immediately when it sees a locked "tables.list"
> >     file. This is being addressed by introducing a configurable locking
> >     timeout, similar to how we have it for both loose and packed refs.
> >
> >   - It will bail out when it notices that its stack is out-of-date after
> >     having locked the "tables.list" file. This is addressed by reloading
> >     the stack as requested after locking it, which is fine because our
> >     transactional API would verify queued ref updates against their
> >     expected state after the lock was acquired anyway.
> >
> > So with this patch series we can now spawn concurrent writers and they
> > are expected to succeed, which is demonstrated by the test added by the
> > last patch.
> >
> 
> I only had a comment in the first commit. The rest two look good to me.
> I do wonder if we really need a flag? But that's just a nit.

I didn't carefully vet all locations where we could pass that flag, so
right now we only pass it in a single location. Also, we need to keep in
mind that this is library code: even if we had converted all callsites
to pass the new flag I still it's a sensibe thing to wish for to disable
the automatic refresh and abort instead.

Thanks for your review!

Patrick
