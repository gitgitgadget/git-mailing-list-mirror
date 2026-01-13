Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8C19CD0A
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289452; cv=none; b=asFejHx7c71O2ml7XxQtp3NLhZGDiXOE0F70akKdbommv1FPQeWBWfKwAKfUyGfQjNHaHWG83Fnt2o63bbNvqn970Q4AbsTi5T2bhqRHI0ZffG8zbEaRxjhLuHlYHXVruF0nIqDxnjoPXI2H+zyb/MyxwyBrEqQ9xrWDHHYOZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289452; c=relaxed/simple;
	bh=QvVtmjGDDvfPMTwgNBc2MaBWCz3vhZ67NV3LiZE2HFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CE3Fqoth61sZaPPYJeKRVDbaNCk/LXXWM2bqQRA2cjHTeOwo8K2Ax4QR2ydPfomwC49vTZbsQDPEGjBp6HdBPAsehP2j7b8udj62YEUhDT5IjvUf21sC5Ns5I7p1GU75bg1W2nQkTrfcSaCcItvqxesKkk0PVmeDpkjbd6tyWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AVTHNw3n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mt6mFqyt; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AVTHNw3n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mt6mFqyt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A42B7EC02CA;
	Tue, 13 Jan 2026 02:30:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 02:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768289449;
	 x=1768375849; bh=lx9Tas0isfsPnyo6CgP9JL8pFeNPeVfkMCpNk1NCNz4=; b=
	AVTHNw3n+3H+d9cIR8e5qOFqvBVECg6zMtEjOogMTdYRWs+5/sT578k7/bYXjSjo
	ppvoCnNACy9AS3Zfp+Pqom1Cq2WlbufaYs9SLyT7GUVupd0+dQxDi67OYnqOQLRh
	XMqBIS4uFR6A4StSstCtVvqJD+xuze/oZD8Kzvi9MO6KXK4nLe1SJq9zFByGyo/X
	YnSuYkznqJ/A9fiDiCLQiArUGIWSKlKXxT9lyxKfgJ0+Zh2wmE/sH1e4yoXqfMRt
	QDZVSag10umL3Pd0uArGrlAl9WkqmFFx8pLVbOdf50OFp1PCNyMbS5xPVqvlafp1
	apic2qQokFeSPLbxsFrSlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768289449; x=
	1768375849; bh=lx9Tas0isfsPnyo6CgP9JL8pFeNPeVfkMCpNk1NCNz4=; b=M
	t6mFqytNM2Ypga/xlHPwbbgni3BfJDRLlq4+R5Zt44Z6BIqH5cC0dOoAmZNUNHOo
	RHu9X6i2tt6R1+PotJHN/PBCmvzVq0zPRdrBM5gl5IriDALSjRrvgoNtEqnKfyUz
	9mJTEUdmUDqWLWXGi1dImMGM4Cn5Qk+iAcBnXe8tcTkVKE9BMu6WRfaLmFV36/kk
	UB1+QHZ/1Bhz2EievhqyufcTawwHMUilrrBLK/SlWlEgluzM93Duaq++Y9tersh7
	No3cYdkpDIga7Q1jsIN8F0cqtLySR8SHv2nfa1uZ6WiWO3Vwr7D51zY8qjDW1aWI
	nOkmjciKuN0NF3W2g6Iww==
X-ME-Sender: <xms:qfRlaSrazjDx7tpfXDX0aCX3LAgVKJqOMf3rNNMmz0HWFowe2c31kA>
    <xme:qfRlaccK_udD6wlKjHlXm3Fnl9lmfa_y9u8HHecFOSKobLhShsOCv7h5_sjnL-Xz6
    SU-g-_GberFv-cDL7d7VNAZMlyf5hF0QGkYpciiIAYeg0byF_2B>
X-ME-Received: <xmr:qfRlaSmank597pfrwmaPLCL3uj53kdsAxO_DeFTpgvVR58HrEVEpNCFZirrw7FW5Cg23F81mZwa0taVNYo3maj-Uy51jeW-9gC8Xcd613Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepshhorhhgrghnoh
    hvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:qfRlaba2gtb-gEMCrt1R3fwIkJRkQlYZF8IKZh6yBM8AQwbrR-JVog>
    <xmx:qfRlaf7lIVB3Rd6meHPynTDbI3iSaILAXqOr4kQfkTKG-nzcXNW3sA>
    <xmx:qfRladDyNwjn7_Ib15fEpQDheUKu0cMOUbanLmGPHzeISWXjJdUTrA>
    <xmx:qfRlaV9QUsXr2sry-8c6a2iNhtmj7SMMK1O0qJqc4XmotYKPS8EvLg>
    <xmx:qfRlaYqq8k93L0yMkBuHUsL0L-fCx7D9-vQsfskd4Px4W3kTqoB4JflP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 02:30:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be5c9f40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 07:30:46 +0000 (UTC)
Date: Tue, 13 Jan 2026 08:30:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v10 5/8] replay: support updating detached HEAD
Message-ID: <aWX0nsiqdOJMwGHH@pks.im>
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
 <20260112-b4-pks-history-builtin-v10-5-e3c6aa5b4cec@pks.im>
 <CABPp-BFvi0xmpP1jcU0qc7c-KhYXgzpCVbXyto3FMSFSSwrKoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFvi0xmpP1jcU0qc7c-KhYXgzpCVbXyto3FMSFSSwrKoA@mail.gmail.com>

On Mon, Jan 12, 2026 at 10:00:53PM -0800, Elijah Newren wrote:
> On Mon, Jan 12, 2026 at 6:17 AM Patrick Steinhardt <ps@pks.im> wrote:
> [...]
> > +       refs_read_ref_full(get_main_ref_store(repo), "HEAD",
> > +                          RESOLVE_REF_NO_RECURSE, NULL, &head_flags);
> > +       *detached_head = !(head_flags & REF_ISSYMREF);
> 
> Ah, I like this simpler way to determine if we have a detached HEAD.
> Out of curiosity, though, is there a need to specify
> RESOLVE_REF_NO_RECURSE?  I waffled on that for a bit and just left it
> out.

There isn't, but I felt like it clarifies that we really only care about
the immediate ref's value. It's also more efficient, even though that
does not matter at all in the grand scheme of things.

Patrick
