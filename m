Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C03241CA0
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676092; cv=none; b=ilB/z/F997E6lQKCZxJ7pyMAMLQCqX2jhV/fjGiCCCAT53GK2AU8t5UHMrqQjlbMuAGM+2+3swDCs2CpFjb5EGKbqawLhAvEfIFbR3UnmCARCwjn7mp69Ys64Ygew/3JEQdzoUfwlMCSd0Bld9oos/TF9G+xR1di8bbES1whIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676092; c=relaxed/simple;
	bh=1HyRBPwB/t/33YXPunDOxFJcKqIllfTJieX4WXs9k2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXZu77GF/PKfq/L01+EQsxZwLR9n3GpuQmNM/np6gDECTVxC2iTxjU8t9W/bxWNNIdmIthOPkgAXx4GMlbWh+q2LDbD+pw0DfE1VccJU72JC0AVsCNMyBLnFU4f0IBGxaJvnGB3ZtlCQ1hpfa2SeNK7PaGEkXMFudtH2SRNFwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LGUqbxkc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTY4CAqq; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LGUqbxkc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTY4CAqq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E4C8611401AD;
	Thu,  3 Apr 2025 06:28:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 03 Apr 2025 06:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743676089;
	 x=1743762489; bh=p2cnaWpn5U81VTg43JCcvoJr4WshSznYsfiy+Y3/BEE=; b=
	LGUqbxkcWqolbznhxZi/u0YncaDSZ63iQmBv5lgMIpyTx4fb8/HGAlWDPOTNN96C
	mf/euStWkMRN6nT7TKE6AKXwQXv1cSKiZtxZ0cnsVOf5w4jR9VL+ryY9tvAjWGKJ
	v0/bJ6rsKnwN0bHVcSKxr42tEUp7xZ52lKdhFddMpGRo0E3njogcAlNFHtzTC7wd
	HT4cXzk3iZIgvILmAHu9aMf5KmF5Vb/sEbDUVVyMwVUc5p0dkDXnIFKow3caKGjK
	2OLbmfaoxrSV+x1bMoG103YRLlWO96AsNUiSBEGMzGXmBcST2ElWdXKl/A9+yg2H
	q4V5c5r4uFIZPsT1iuY2Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743676089; x=
	1743762489; bh=p2cnaWpn5U81VTg43JCcvoJr4WshSznYsfiy+Y3/BEE=; b=G
	TY4CAqqkfMStXH6BzDfmKRy0RLE0ka1QsOHuj+gV4jI3Ctdu/9mxK8ycA4f1gapR
	IPbVESPjYhQCrGp2Uo4p9WnpBvKPyqz+uyGBholX/6JsyuTRoKFFLL8jJTjqbh5g
	qeSM8WeqGvshQZRVKmaGMZIkY9qJNYuoaNhwYePneC5WsZKdCfTIXiN0Gqtc+4rM
	pGZM0zs7ER+GDiMc4ry+uY4+6IpNYJiQ+Qazvtf1p6c+LWzeSDg94zAAw3o7LlPY
	iZQMAfKl/kSQ+guhCh81BcquvkgZo/gRCRNSi8XObYe1pjtpMh8hITbKWklvo26y
	/ahg+zE7B+NdCuRL182Zg==
X-ME-Sender: <xms:uWLuZ1tq_7-sdy0vc3hQ0DDnnuC4dGojX2iJghmybVRE_AD978UaXw>
    <xme:uWLuZ-cmKHeKnvF6fKL81oYG7VrVdnCWc0W74jAfIgNt9v_vAV2-_gaNzzCNB5ZDC
    cTR1zE5eWodQGSY2A>
X-ME-Received: <xmr:uWLuZ4xyYPWFNbDt53CT6FshHoV4CPMmMsCnh87hR10BGFFfCYuuSReW1AxsljdcVLLW6IC4OIGTTjzRRBR1MQGhkU5ARo0lCQMSHWPm3bRpcjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphht
    thhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uWLuZ8P57WabTOtohZzODiw4gX8LXDOAexeo0ZY28yjEuWlIz_kzjw>
    <xmx:uWLuZ19OwDevEMsZDfs0VGGZ7a4mzm_xC8ZrLrEh-yGI9q6x9qd48w>
    <xmx:uWLuZ8VUxaXSpeaEJtza-mpGm6vopePNgG3IjgF1vAfLSqGY7p8R6g>
    <xmx:uWLuZ2enZ01o8NONykPoGs8AYuvv7Io2_x6mZuYZBjmj_zzmj0rOKQ>
    <xmx:uWLuZ5GI1Zp70D5G2WzJIZJfHIGURewnmMAqbWWXywyMCDnaJIh1LWvE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 06:28:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c7e2633 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 10:28:07 +0000 (UTC)
Date: Thu, 3 Apr 2025 12:28:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, shejialuo@gmail.com,
	karthik nayak <karthik.188@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: Re: [GSoC][Proposal RFC] Consolidate ref-related functionality into
 git-refs
Message-ID: <Z-5itjoHBV-dEPwU@pks.im>
References: <CAPhwyn3McL-2rwjkexsDUWqxt0Kr4UsDVy_G=s1DmKhrw5BZ-A@mail.gmail.com>
 <Z-zzbOrZde8B1kA6@pks.im>
 <CAPhwyn2GugzXg5LgcdMGjrvP9kAvCFj31RXrUpp7ZJdoGfiyKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhwyn2GugzXg5LgcdMGjrvP9kAvCFj31RXrUpp7ZJdoGfiyKA@mail.gmail.com>

On Thu, Apr 03, 2025 at 03:35:09PM +0530, Meet Soni wrote:
> On Wed, 2 Apr 2025 at 13:51, Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Apr 01, 2025 at 07:07:21AM +0530, Meet Soni wrote:
> > >     2. Tests:
> > >       Develop comprehensive tests to verify that the new subcommands function as
> > >       expected. This will involve creating a range of tests, including shell
> > >       scripts and/or unit tests located in the t/ directory. For the existing
> > >       tests covering the legacy commands targeted for consolidation, the plan is
> > >       to retain them initially—even if this results in some duplication—with the
> > >       intention of deprecating them gradually over time.
> > >     3. Update old usage:
> > >       Modify all call sites of the legacy commands to invoke the newly created
> > >       subcommands, ensuring a smooth transition and seamless integration with
> > >       the consolidated command.
> >
> > This would be nice indeed, but it's not necessary as part of the GSoC
> > project from my point of view. The old commands won't go away anytime
> > soon as they are extensively used in scripts outside of our control.
> >
> I wonder if this is a better candidate for "Post GSoC" section maybe?

Potentially, yeah. It doesn't really have to be part of the proposal in
the first place from my point of view, but having a section about future
work after the GSoC wouldn't hurt, either.

> > > I think if permitted to start early, I can consolidate one more command within
> > > the GSoC period.
> >
> > We cannot keep you from doing this, but please keep in mind that if we
> > end up picking a different candidate for this project we would favor
> > their work so that they can successfully finish GSoC. So I would
> > definitely wait until you've been selected before starting to work on
> > anything.
> >
> I completely understand. Just to clarify, I meant that if I'm fortunate enough
> to be selected, I’d be eager to start contributing during the community
> bonding period--only if it's allowed--so that I can try to consolidate one more
> command within the GSoC period.

We won't give you a strict time schedule of "you first do that and then
do that". Only thing that I'd like to avoid is that you're basically
already done before the project starts ;)

I'd just define these additinoal subcommands as stretch goals and then
it's fine.

Patrick
