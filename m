Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AB326D65
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249413; cv=none; b=k94qcYigEPkzXfCrdSAaHV+HFgFd9R/kbZgyFnrKFs9l0uWr9nqVMr3vSqx8NZkVZCTIm7mS8swXyr47n3jV+0ekTJjuZWN3tXeQC9GqbEcg0uFOwcI/oXW74sdI9bvTI9nk8wG8SxCYrBcJlfM0qp9O6gdyyeyZ9zEHD/kV46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249413; c=relaxed/simple;
	bh=N7r/AuMegXqeSvs7ZbNO8l4dOkGy8CdboKRrvPx/BXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hl6xGbjprTDjLN9kjMyt3BjFKTMS8pm7vj89cvT2a08imkLCCDvRcG54tF0oxw3TGKyjoMPi9smlGO7hWtnS623QyvQwGvreNFlK9HDgGLUGsYArFOWX1GBvYtcduJ8Cpsd8Rpq8egatR9apQY39rfTpaEFrHJRAKD19wiGIwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HwjpCgyc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GezFULSA; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HwjpCgyc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GezFULSA"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C5FD37A014E;
	Mon, 12 Jan 2026 15:23:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 12 Jan 2026 15:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768249399; x=1768335799; bh=SGkPPjtPHn
	Wlejeh66wF2DJG6r8ed/dwZUOR6hqEkdA=; b=HwjpCgyc9CT9jyhOW2jJ2jwZS+
	MbKT9jZEHvKx0LTREGb9sQ/DDP4HdjT1dEXcsd54iZ8oQeMzeEjTVpsR5uc0Vewo
	W8clE7O4T3aMnApA37PqPECrDmeJCU6XQOCfpHSc3Mn0H8vmEspiTDyW3g1xLxu7
	/q1aOa9DzldAbhcPh5D+dcYHvvYT/jUV8LuINR0Tegwky5QiDHZKqmnWvhiHugko
	deczFC1tsp93UcRZx6XJzl9fxzlbXvW2oinICuKcrkKvRAV97/Od0txTG6A7mci+
	Yg/7xFS79EGItpmJoJGZhOdqkPutnKo4htYqEfO7jE7OlttnbAKyli7qgvFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768249399; x=1768335799; bh=SGkPPjtPHnWlejeh66wF2DJG6r8ed/dwZUO
	R6hqEkdA=; b=GezFULSAfpyF3uEcvQPqIgQ/T4Z5cPKcNm7HD487KZgDy3be731
	K0QlrIpOrt05bfnwiNlcmeKm95NuYwGTdF2l0x7c/+xgLrhRmSOdLtP+ucpx/x4F
	BIrFVU8yY6lX+MqGlTWeGMhT9vq6ETB7VnXJs4Ux6IfgpBlOko4Jt71yYSCvcuu5
	7rYwVBq3w/55hyHrS4HoHdpeX/0WgSMj5tsid/+HSayCTf9h8LD0BOjsyeuBruO2
	02qjXjUS9qTEE0o2qkef0z7QoFMo4+Tc+Oekh6hax5mxhil+yE4iLeqw4o1jfRUG
	b/stcCX2hg64mKh+vbqGpGmJp04a+Z/Jy6A==
X-ME-Sender: <xms:N1hlaRd54uMpUUAdSwO6Dpc-pUYaxHBsurCeig1ghj7PDE3KehkrCQ>
    <xme:N1hlaWEfmS7I_gaCI2bzHulV4jH6BDiAlz3RhT0RDRR1bio3ECb_yCAb0Sl1dZHn9
    7mYPB1axEU_lT7hdTBIB3cD7PKIawqBL0th-_vPGQxBFq_XnCka1g>
X-ME-Received: <xmr:N1hlaS0V4hecfgUja6laFkhKc_IUavFL-wUtoUh0JR4O3y9zW8Gin8xqpr8eHCH3D_q72y0PMW34likZupfvnS2xtAPH_r_C_ulaE3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudekgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhushhtvggusegtohguvggsvghrghdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:N1hlaWmcZlu1UyNmwc1YYPBQdxXPFWMg5ZnjGeB9PVaa6kzhVaUqmQ>
    <xmx:N1hlaa-rGI-Svkq4p2tZ4gRZAHpacteBT9iJElNFyndHMSAudWW_Xg>
    <xmx:N1hlaTqtECNBhdhdf4EO2ymwYxP5Utm_ABCj9EvSod9GZkuNgBKQQQ>
    <xmx:N1hlabklbT0jwWRmF3gm_tKjXyd8Lwt9vYyajmRaY_o3EHj0cBNeIA>
    <xmx:N1hlaQgmTJLiDiAWg7F5QArpBKp6H1zSBPueHXZC7on02JIhm-qxGXE1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 15:23:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Gusted
 <gusted@codeberg.org>
Subject: Re: [PATCH] last-modified: verify revision argument is a commit-ish
In-Reply-To: <20260112-toon-last-modified-tree-v1-1-ecbc78341f76@iotcl.com>
	(Toon Claes's message of "Mon, 12 Jan 2026 17:17:41 +0100")
References: <20260112-toon-last-modified-tree-v1-1-ecbc78341f76@iotcl.com>
Date: Mon, 12 Jan 2026 12:23:17 -0800
Message-ID: <xmqq344amvgq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Passing a tree OID to git-last-modified(1) would trigger BUG behavior.
>
>     git last-modified HEAD^{tree}
>     BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified

Of course, the starting point last-modified needs to be something
that will yield series of commits when given to get_revision() ;-)

> Fix this error by verifying the parsed revision is peels to a
> commit-ish.

OK.
