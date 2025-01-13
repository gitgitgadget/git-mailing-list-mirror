Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE43240221
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785120; cv=none; b=DirBUk2I+S3rpD/eRn/jIwUjmwzyxsf1Mc3H017rDDlOdDdv4N7v1He6yRlsaL63WtXFekVPSOziBPSM4o84zGN0SoXk1krHiKMlcFeEwJpJiGbF4bRRSGWP9aoHjq9CZUAD49loSg44GzKbqUmHWfidyfXqZ4CT/IkAQXV3KRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785120; c=relaxed/simple;
	bh=Ze1DRSFJX15o9qb2WVd6YfqMYY5tpq+gy54lstPwRu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QDbuNIVCyShTgtlZuJ1tcwrdVZkyt5p5bjzJQFoGOWun746K/illBRe+AlmduEYRhsj9V1AmG+Zct/oKUfxnI3dYMSUn0naLpI98glHOZdNT/99jtINS8smNdXpvpKg77UFMvycgBH5DbrD0x18KuTOVsaU/hKjfG1KHccS3sQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mSlzptSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aE/P4T3u; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mSlzptSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aE/P4T3u"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1BFD425401AD;
	Mon, 13 Jan 2025 11:18:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 13 Jan 2025 11:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736785116; x=1736871516; bh=iwzv/HG24w
	R2VUg9Lw4Z0HEQEBOVP5m8Ej9F75VGj80=; b=mSlzptSBS6l77VjjWVxzcM8e41
	Ees9k4Iy+JAqB0QbG6tJX5QIf2Y5K6W0PEFTxoawqnJV3wC8fzFDF70lVoC7K0MK
	/njBAq6SOKqC1da3J0cfjUdHV51ka4YYzArN8rxq6B9xViI9bhwOx2yQmCnFdmFl
	Cv1q4UhUZrsscZVQoyCWtD4evYvKsn4kAi5ko0FYw28wr2GyvaOOHrBrLH7H36Fs
	KhyFzVsyYY8Xp4IyYik214rCLGpFXI3Em/8JM118qs7jpTOgu4qJYdWDzFOWz36R
	xAZq0Uo70LBTGuVFNMW/dzlXW7xtxdnm1L4nCpvUqC0bIjZKXZikcdBlg8Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736785116; x=1736871516; bh=iwzv/HG24wR2VUg9Lw4Z0HEQEBOVP5m8Ej9
	F75VGj80=; b=aE/P4T3ucpfQhY9+G8GKsyJuJps8npaiNY0Vy55npug8b64OX9p
	eXwdpxdJk/r1+B+pzEtVG8GT/8zUqdU8diu/jVHopWUfXpNAMVNxyU1k6FHSQa7d
	5DFh9eJ3miOh1VIOvV/WYpQ68i9tlUODRYvLaHJJwvf1gXwpB32C+3o/CSN4vBeJ
	2KbSVft9TA41YH8T60701KPLaDtwqK4c0bKcyvjRRkrD2a6Yd6ezza+B2L51PUfe
	uxZIBh30skHJVkYBUcrMewlEn7hI9rVe+uCM4kchLrSuJdpnoTnANLUASC6+G0Ls
	a1DGSVcYlJ5whrWIDs/Gz7BDgyXSLSGQZvA==
X-ME-Sender: <xms:3DyFZ65bmvH6cUrcPEZ0aI1_u-1zAARNXN8IxlZ1BBy7sne2_WGHEQ>
    <xme:3DyFZz55dT17PELw5U_IHGcu601g71eozLpqxc_sBLjhiGc_mFBAjD0n_AJNRzAf-
    O36lR9P2b7epM6viA>
X-ME-Received: <xmr:3DyFZ5erejY3X4n3-lQvXRNH_Bht5UF5_Vh342u1vKXxDcaSQUA-niOTa61H5eXV-6eGU8J7r62XE37I6LC0SdAP1-ckCMxn4LFW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpth
    htohephigvfihonhesrhgvvhhirdgvmhgrihhlpdhrtghpthhtohepshgthhgrtghonhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3DyFZ3IlfM5cSbisyDBajBvzbvEA3ymYNp0CQgGoDLRtL7LuHm4soA>
    <xmx:3DyFZ-Ih3BHsAyZtORbtECpapkMGSK_OCOOv3KCTTYxg1xvFR83lpw>
    <xmx:3DyFZ4wVahq9t8PCDEwAm6xTBWupPMM_S4R5jWDbivz8NW1YWqI1eQ>
    <xmx:3DyFZyKGNEYop4PGeRD-bZjcBWYC5Q43CzKzNTpNEELEiG-Mnr5ZJg>
    <xmx:3DyFZ9-nl2JeN_OUuxsIQvS_vInQpMfLe-UIsr6owEYwJzHzoazH33MY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 11:18:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Yongmin <yewon@revi.email>,  Scott Chacon
 <schacon@gmail.com>
Subject: Re: [PATCH v3] help: interpret boolean string values for
 help.autocorrect
In-Reply-To: <20250113054355.GB767856@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 13 Jan 2025 00:43:55 -0500")
References: <pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
	<pull.1869.v3.git.git.1736594839527.gitgitgadget@gmail.com>
	<20250113054355.GB767856@coredump.intra.peff.net>
Date: Mon, 13 Jan 2025 08:18:34 -0800
Message-ID: <xmqqikqibsbp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That's probably OK, though it is a little unlike other bools in that "0"
> is usually a strict synonym for "false". So we could go the other way,
> with "0, false, off, no" meaning "show but don't run" and leaving
> "never" by itself to mean "do nothing".

That's my fault.  Your version makes perfect sense.

Thanks for being extra careful (well, more careful than myself, that
is).
