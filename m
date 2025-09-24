Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C620E6
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734958; cv=none; b=AuoJ3DEL8K715/uP/7f++qHTUFQjoWAlsElxR1AM/1Bw49/t/de5f/mYMnn3AMhRikwD5Wp+qG7tEjaDX4ZnSqo77DOk+pIXSH2bk+pSmlnuIipl5PRMmJzr0JNR7wgyaT8RUdFTeU2EFzVCUYam/s0cP8jBhfcQ6F/XgyGYQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734958; c=relaxed/simple;
	bh=vdZAbsC8XB05fX6Y9SFQJpzNjsvVXOHoM7qgLQiBkLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LGdN8sFbsJqbnnC4CAC03iVge6s1bxFLd+mKrbSwR0+itx8GrB6+dqUqc2Q7exO+Zms+pGub6461GFYgf2wLsYKCzbKP9TW8sAKLhMX91KWAAeRAMa/lCJB+931UqsI8Z0sIfGBy9Kt4OalRUUXH3rItOJsVFo4ycSDtPe7eLig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W/UnvAwg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HeMtMP7x; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W/UnvAwg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HeMtMP7x"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E7FA0EC008C;
	Wed, 24 Sep 2025 13:29:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 24 Sep 2025 13:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758734953; x=1758821353; bh=jgsiL7bnWn
	WbtR64NijepMOA55LZu0l/w6ebT/h/4mM=; b=W/UnvAwgaRBCumQVkf26xLaj17
	q2xapdlpeQLgv24ZJHOKGJ8OSTtmmVv09F5C9j1sgDqmlkiq0qhwnmPB9JywDXHR
	WTby6cMc73eknoUAYeHNCBNuMGWpQ2mOW6Pad5hgUsiiVoPiBX2ws5p6TTodnNZ2
	O+GJgK1VOkdQbfcV63RAkeuN7yti4SPYEwTvy0aVGSwmUgfxQfM+qpGCIgWz89rb
	fhhDvv5fCZ+PrsKSVsEifDTAGkVOSP2fFumI748jolU1ivLkePx+qdU7vp6mb6xl
	d8yvgZWck0QxoOw8dWuT7hg2d1VCoa1W118SNuAYgfdf62HzMi8c0JePI/Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758734953; x=1758821353; bh=jgsiL7bnWnWbtR64NijepMOA55LZu0l/w6e
	bT/h/4mM=; b=HeMtMP7xBPyHclLn/ZJMlOXK77/WuuLz2UdIkPEE7+0UIG3RceQ
	NBPZmNwLiPjBsEv78r0CXcK4gDwxGjlAGspyHdW/2QiLaENlJoQINx8EwdH5d6Jj
	mb0EsfCqjNKeb7X22Sv2N5m9yvpI+WV07IpsmAGCzJKzx6cFEkwFNbzK4Rsw7P7P
	MALotePYKaXv44LiBKwFH9V0Y+yPMEHsIfgmoi5knR68kW58RWBY4+brp9lbBQbQ
	lboaAZmKnHVySrLr5hjB37pQxIJ28qhV/kSqenRq08rbKRVDjVBPm0gWEfZRya/m
	MK8zEZXDaw27mf9NPEiUpgkfGWsKcndocxg==
X-ME-Sender: <xms:aSrUaOfeMqywOS74TLkWWaVJJqIbFik8UGQld-mmx41roiGrRGw4pg>
    <xme:aSrUaHRtSWNOWv4VW-AqygezMhww76050MfvVABdUyPEd7b0nFpYOZeAB9PBgmJGX
    lT5nC24RumbvOelUecY6l91brRbn3vlcBAAS_JEyChDG5IjOIaagQ>
X-ME-Received: <xmr:aSrUaFuQFlGcVFKH36SFjnfBkMeb_z8mfdzP79LIWw6u0ndq__DQZfwf8LU_Ok4GN_PnpoLHPT_tVJOOKCOIq-7B9S_EKnCGTg4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aSrUaIdWGj_TJR-iGcozZ4ysqswl7Joz2-bFzVv16_MAR4BtonQPrQ>
    <xmx:aSrUaPavpoa0dNSQx08KFrfNXZ3-QITdVsio2n7ZUp5NvcpFPkOQlg>
    <xmx:aSrUaKbtj4Ke1wWXlycnwxdoiqMCsoKAFkKNozoEqKwnJwpu5iVivg>
    <xmx:aSrUaEKklnIHS4UP4gxDWLjugPN1rWT7lvATM22BidJ4VBSjUja23g>
    <xmx:aSrUaKPzFbNe3ml6xHBqOL4ByLIW3ex2-R27nlYPYevatr2Omwg7KF4m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 13:29:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v5 12/13] xdiff: use enum macros NONE(0), SOME(1),
 TOO_MANY(2) in xprepare.c
In-Reply-To: <1c3461c3-09bb-404d-a4dc-a895baba68f2@gmail.com> (Phillip Wood's
	message of "Wed, 24 Sep 2025 16:18:28 +0100")
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<08a0fceb72b2bd0a2803d24b9874b7f9bd03703a.1758662670.git.gitgitgadget@gmail.com>
	<311f7dbe-b970-4a5b-9d53-05f019cc54cd@gmail.com>
	<CAH=ZcbBcEbTqQ-FpYSdr_QjSM5sKerECKsSVdTyHoSQqG-V9iA@mail.gmail.com>
	<1c3461c3-09bb-404d-a4dc-a895baba68f2@gmail.com>
Date: Wed, 24 Sep 2025 10:29:12 -0700
Message-ID: <xmqqtt0rlpxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Our coding guidelines say not to use "!!x" (I assume we're supposed to
> do "x != 0" instead) but in practice it's pretty common to see it in
> our codebase. I'd maybe try a (bool) cast and see what people say.

Offtopic.  I am perfectly fine to remove the "avoid !!x, as it is
too clever and confusing to others" entry from the guidelines.  As
we have many of them and it is a fairly well understood idiom in C,
I would imagine that it have become less confusing already since the
entry was written.

> Thanks for cleaning up the xdiff code, it is much appreciated

Hear, hear.
