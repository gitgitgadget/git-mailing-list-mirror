Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11A1D9699
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881245; cv=none; b=nTY/CKv1IKfWcA3bbBmyZHpNvBI5xnoveNTeyzcuQe/cqqryJk+vc8KtqWggbSYOO0iaoHI9V/J7d3+keGwXmUmZCDUK8PcuRSJspajdrDvUltnY5q8fj5ERdo12MbKC2vnmtcLFW9Bx3/ZIOM49zbyoPVQBbz5UYhsx3MIMCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881245; c=relaxed/simple;
	bh=fSwz8N1fXKHEFbQh6ffnq2OxyGsfNzIDwCDytWpepTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pmFmzEl4EJZ741dHmf97rTSPgDrarmbBgk1zZxnRHCMsm5kuoMthpF6KsQE3vLC102SbIxlDSxu6PT6UhfwyRq4+l4VxOOajsKaAVbyoP1rCdN+7WMGrkSk6j6AM87ZhwFpqsQyYaIv5zj8jbCOb45HmkrD+wt3k5hW+PeTm8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N4IfMhaX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDJtJM0e; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N4IfMhaX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDJtJM0e"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B3291140168;
	Wed,  6 Nov 2024 03:20:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 06 Nov 2024 03:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730881241; x=1730967641; bh=fSwz8N1fXK
	HEFbQh6ffnq2OxyGsfNzIDwCDytWpepTk=; b=N4IfMhaXJXEW8HsIEfRgWkBVsN
	A6Gyk+wAbi35ucDZ0hGjTgcucCdgkCt65ogjekjy3l3uESJLMUOKTUuxVezxMDJS
	xS5x8l28L8flbMuTONRo/RmNhZ3wxPL1ktR5L4LefehSCJFIVqo6+lNWt7hzG12T
	R1e+FOlIaVsHaU90u9NjGsPnqpvV0owxg/pxlK5mA7n5M/AekUkmYi5Hd5Z+HzeL
	YGAGBoQcBvKRhGFm2jNZbzHAZfh/483V2+oIa9gFCBL3hP1mFyx2cbv0wLSnftZO
	UIFZOWm5Spe1pe195aWBtrn/49ShHmPC1VZCoJRMe0GUAN6to1OdPvP9LbCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730881241; x=1730967641; bh=fSwz8N1fXKHEFbQh6ffnq2OxyGsfNzIDwCD
	ytWpepTk=; b=hDJtJM0ezRJbwiAOK8gN6pk6kjZTpYte1PrF4bLCZ7eaq0uKg2X
	QK4lP8qUGFf0sTFx8vBNeDxvLD1lMFNpDTk446v+PM7pxTmeaKO2tB8glH9qHFig
	GvvfMpTSZwL+JDfTeFg2AZtlR5Ecd8YRfZK10iv7dJh+4gLSfVNyTXbG0CNfpjB5
	rjcXA+5Xr3QYhZd7BU8jKHnpIN74G0YSB6O0cluY5noSSfouBo7chV3CKGnUGnsx
	jffv+EhiCJZx30Y8Mvx4bsvUnOu3SxnB9QuqLLJFbzncFIYkxS/pbPu2r06iSW/Z
	PuyfAkR/TNWNaxQwnxE+aNBaZ4AdNswrExA==
X-ME-Sender: <xms:2SYrZxeNbcV_TFD46l953DALJWUlH1-b-ngCRE1QhkZ22ENAhXr9xw>
    <xme:2SYrZ_PYkcfXmwSh0q8Ej0D46aTpgsrVThcfMIIWBgQMAVBqJuwDeuiiC8OoOUhzs
    XveAWBVN6wgCO9cyQ>
X-ME-Received: <xmr:2SYrZ6gJaLPi8Up41SlkvDuPq9dL4E9OD0L8wIDmuKxe6RGKWtg__r-t0kJHotkik01fqL7FRVH0AHe35zsdkLhRL5dzdt-o73V->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2SYrZ694vLelgaErPpsP_CQJIEwS4XbG0hlIklV3yUPvwZH3zHXwbw>
    <xmx:2SYrZ9tgRM_rL1LSqcZLerLCiG1oG-y69n8CBZTbgNkbBdtVYLuNQw>
    <xmx:2SYrZ5Gb7GOKltrKHs2Sr54dFoQHOkIkUDR_kU3_91qMJO_cLPx9cQ>
    <xmx:2SYrZ0MUzLlqSK-BQKIkL5BCLMA4TTmbmRdnXMhUITcqhXbDdWwR-w>
    <xmx:2SYrZ--FPzCbFzA67L_6j_hke4NhyQW6KC-XMpDq9-mAGS5e3bBH4BKh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 03:20:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Shubham Kanodia via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v4] remote: allow specifying refs to prefetch
In-Reply-To: <ZysSEJUqSKUq4PKb@pks.im> (Patrick Steinhardt's message of "Wed,
	6 Nov 2024 07:52:05 +0100")
References: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
	<pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
	<Zym--GVNJt_lsQEz@pks.im>
	<b548c532-e54a-4edc-94aa-f3c2925602e6@gmail.com>
	<CAG=Um+3D3iGPRv4t4DcCP=Bh7gbAQ6cSJ79jmg2h-qbSiQRkUA@mail.gmail.com>
	<xmqqy11xqjpx.fsf@gitster.g> <ZysSEJUqSKUq4PKb@pks.im>
Date: Wed, 06 Nov 2024 00:20:39 -0800
Message-ID: <xmqqo72spyco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So yes, we'd have to teach Git to ignore "*" remotes in many places. I
> would hope that it isn't all that involved and that we only need to
> adjust a couple of places to ignore "*". But the remote logic is
> somewhat outside of my area of expertise, so my hope might be misplaced.

I am hoping that it would not be too painful to exclude '*' from
enumeration, and also, "git fetch '*'" and other things that expect
the name of a remote do not say silly things like "ah, there is
"remote.*.<something>" configuration defined, so '*' must be a name
of a remote" ;-)

It might take certain refactoring, but if it results in a cleaner
codebase, that is also a welcome outcome.

Thanks.


