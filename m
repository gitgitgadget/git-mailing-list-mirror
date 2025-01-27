Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE425A65E
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737961249; cv=none; b=kMaSZ28++SEwvuwsdLX7yCMZeuEVKDda8rbUC3Ian6boaCXCTgaZ00E0Htb3E5zlqXRPl25L51uygDVVtB51tpjn2YTtA7T5lJONePvSRrKtS+Pf36WULFPl8TfPt28MqHSMRJuwv43R9Ysj3L2USBB/VFwEutBpzK4eOVXTahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737961249; c=relaxed/simple;
	bh=ucWgEcpDBVzgCwazqqwz56Hf0L5y2liwSFPIgSHGC3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q445EqTcKZZUlc9i/PJvWmWG02fM/82KQDiYtd672VPPMA40f7WL4Q3/szza+tDEAmkbTFx3/nnAr/A1ll4YhCUYMuqDRu8JMvINZIRfvjZN7/GtWRpOC29+Wp0AAsBWC/FEYw6dq7s+BxlXNmqkpG1//q2q61nJr8NDIiGac4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KKlr28Nl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uzM5vmaq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KKlr28Nl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uzM5vmaq"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9188525401A9;
	Mon, 27 Jan 2025 02:00:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jan 2025 02:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737961245;
	 x=1738047645; bh=s6mGCgexOqBdpAf1xCGrpWGT7Bk1pSGJv7y0dvG48nE=; b=
	KKlr28Nl9MvWck3rzqjrTQzzDU614LdeePxPg8eQwKLBX05S+aInPqiWyVYhrFA8
	BYRtOaS19n8AXzaJLcNWK84DEGhT+7CUBaqnkVNrCXunZG+9ubQTiOndKFrZQkNz
	wq06gaR48ZS65GmbcYasseTHhGYi/nkTWxsy7XX3WLEKqXAhRv2Lq9mZZ94CS8dG
	b2MBpZQ3tZYns5jmk0uM2zpJvWPgVEBWFjAM9GfwlVUn6Rvif7ZwL//lv42DSHTF
	WEU1oPbH7YXpooHAkDlMcJ+VdP+RSc4DubCjulbMTX/tlwWaU0hP1CejvhSRLAZA
	d32PMxK6Mmdu+Gq5zEXLKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737961245; x=
	1738047645; bh=s6mGCgexOqBdpAf1xCGrpWGT7Bk1pSGJv7y0dvG48nE=; b=u
	zM5vmaqhoacvGpDrbo63XRb8Qc8sCSr27O+soaYyDUie+b/TTd1VcyvAplMk0lvn
	CL/jRc889jJROrsr4YwQR2sAjp8teD63yTS3mQ52WKKp70//nUCm753q4oumtuw+
	1Fh2Z4Kg0FDDbjOx7RfUwdBbe+c7XfGrybDoQuQgbGD39DA8zE1Ii39DYi2ld4U5
	GY7w1PM4sfNX76/EcCCpKjm8WCNxjDZXAAxUmvHCqEWp3UCco24X3zZSYQGr1HSd
	ThHyIqfm+qhtjvmb0cm7fRMWEKBR7tOQuIeLTFEwXAzvO1TK0VCTliY8VNLYo05D
	Ti1xb2yLaEkqeAbnF2cqg==
X-ME-Sender: <xms:HC-XZyMoiTwjBi9opJELEGEIkvpfWDhRwASqxs1Rp6VRtMNPQAQm-Q>
    <xme:HC-XZw-lr6LzW_ND7JNSH__JKCDje6IERZ_B_kmsEqJjWvqo2Twyk_sTkDT741knD
    mVFLteXasBpSuo8sA>
X-ME-Received: <xmr:HC-XZ5QZSTbjmdV97M73CUoLtHhFRALfF4kyVFxpMCwhnqa7PhWCizIOCEdMvsA0ltOWlZBhWvx3iEVITLs0sdtssFxGlcrb6Lt0CIJUciYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HC-XZytIbvu2dynjrRBLFLRuwbxeBqMkRiJGpI3EfeOLD1l4g7jFSg>
    <xmx:HC-XZ6cgszCBTEe2b4y2i8XRlBV_9UHtmTkiDOdI0J6IBnQWAuiDKw>
    <xmx:HC-XZ22NdRiwje8bGj9O_9jmKwb8qnCOzmdAgSbbRIILsgEbPRkL_w>
    <xmx:HC-XZ--2NmC6rAwNH3YUdXY-M_-YPLWOLMzrL8bxxhVyG0W57PHM_w>
    <xmx:HS-XZ3ExvuW9_GnpH9HbHrLRu1-Ot_Qp_fbf_vpvHe5dgY_KyO0uMAT->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 02:00:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 53e3f894 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 07:00:40 +0000 (UTC)
Date: Mon, 27 Jan 2025 08:00:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 00/10] A couple of CI improvements
Message-ID: <Z5cvE8DkgTANo_0U@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
 <CAP8UFD0oYM6Cp=NQfN4p+FS3Mfdng1kXQxObtoOG2QuhPN-Aeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0oYM6Cp=NQfN4p+FS3Mfdng1kXQxObtoOG2QuhPN-Aeg@mail.gmail.com>

On Fri, Jan 24, 2025 at 10:59:04AM +0100, Christian Couder wrote:
> On Fri, Jan 10, 2025 at 12:34 PM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > this patch series addresses a couple of issues I've found while
> > investigating flaky CI jobs. Besides two more fixes for flaky jobs it
> > also removes some stale code and simplifies the setup on GitHub Actions
> > to always use containerized jobs on Linux.
> 
> I left a few comments but I don't think they require a reroll. This
> series looks good to me too.

Thanks for your review!

Patrick
