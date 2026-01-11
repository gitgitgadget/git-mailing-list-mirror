Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FED1F30A9
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768104297; cv=none; b=C8afDd3RTAXO00zcYtBRTFgF+wdXTm+Z9sHMtD5i+lAY+vj65TeoMON1puAxAOW58LeO8LkoxsPK2SFq+dye0Mq1z/0ClwIrYuHVIZx1C6mb15PqH7TU4moAx3czS3gyQDayQg1zkTn4LMN1ExoXxZX6v3+OJbCoVJI9GzGni6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768104297; c=relaxed/simple;
	bh=yZxGg6AZKyFzh4Js10Toji+uHr2h7fWTkzFL7vrkoWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UZvplH74ScqtA/OOWCkpo+dhfkWPJtNuR+OTd7zUc+y4ZcUhY4cv9SqeXPbdeBZCMouajxerp9piLzfSMtR1x470/WpGXeWjckdk1vuehs2zmrIlr+hfcQh81DEXlkE/ojJK22YRVdvxgQ5gx62IVDvR1YoF6jLebwSRJahn2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bCxzA1S4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bb+7iOuY; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bCxzA1S4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bb+7iOuY"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B1077A006B;
	Sat, 10 Jan 2026 23:04:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sat, 10 Jan 2026 23:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768104295; x=1768190695; bh=u1ZRjr6Egl
	PWIlDDQOCzoCq4PsisMkgcErKuNN2+oSc=; b=bCxzA1S4y0d4lb7VAkT8TSe0QM
	XirkBdZYRiO729H8RVwB7cW6B4NYbqoPEe0KuM3Qx1Gx2n1bf+xEUxt5TFeJj0QD
	sLSa4/KUk9SWXiqGkLLck2k1sTNtpftWyGvMb2gNa39eDzLnSfnA+yDXaYN4McTf
	jWfwx86VfqDtSKc23Gl9KXryOynEgInYwHtXi06Tw/+Kr4A3ru0Ub4TqZ47IyLD/
	p3UUr3dL+IEE3dXbDrF5EXyglfjKRSKaDQwkv+sqfUlc0zxZb/ytcwGcQA4zK7us
	kWtPnXm7ee329npTsXHO6e4E0pvQB7ir4rvt+m7vUbntp9Klerdb4e5RIMtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768104295; x=1768190695; bh=u1ZRjr6EglPWIlDDQOCzoCq4PsisMkgcErK
	uNN2+oSc=; b=bb+7iOuY+GItqXQC4QO0msD5IEIe2yvMOH6IlgMw8ZAS8u/VGnI
	4ARj8/8uLNejVcccx4AKMCRZJ3yJw6PDKcmolNBaOG55GIXjZpqtlCSGRVCwwnBM
	8fUzcf+AIEbqtqZwBUdXX6f5ABHUg9e4ynTEgF0ZoVFQInDngBy4J00YnpWgZewt
	/hKxuQby6rWJyUobH0dA6Jv01qQaZY2CxC5KM9aXB7bPKdk0LRf7743O9HL1KN9p
	opLSsM0BAMxyF6W6ADW7QA06DJ1RswuybGkdoDYBtOTMBP1ui31EtwrNtoom5o4E
	I4MW4mvK44zlh6Osj7KO/rR4xU00h2mxK1w==
X-ME-Sender: <xms:ZyFjaU_IAeNktiyjYbF7sPurPM2wVZz318RWtXSixz5Sgxzhcku7-Q>
    <xme:ZyFjaTkquofY6B_3LaOmU4m26R9ENdGQRhEDfkm7IJxixDRG7CBPz9FA3pdQtCmB0
    1SNKUqjbEFRZzLl8rsQ_nxxyYpqUA1zwtt91Dci9fr6vKThN10gig>
X-ME-Received: <xmr:ZyFjaSXD0QlirM3WQqfei69XrB1zSaX2FGwPsW8R9R95W-7rTAIPTNYL_d68d-hauyhbprvu1ovNPa32tHXfCTuRFcHs0TEr8fDhry0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudefheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZyFjaQF_YCVRj6drfob4nkr3_ZaZSG9x8P_iOjptDyRcR8osSDGWtw>
    <xmx:ZyFjaWe2MsS5gwCVORqk9uWSLzS5wZvg0WtndDKoEnWnBEQGq0yOBA>
    <xmx:ZyFjaZKNaJb2Za8cW7YzAGNFLEny64DnfiMJmXQuTbUpZQPkhlreSA>
    <xmx:ZyFjaTG7hm5iYEaXfaD5S1qIaxmJ3vTyHp4TzWfeH-9emLuO0QIrRA>
    <xmx:ZyFjaefm9u8szB9DoYm6iNdOYwqFep2sFUQA4lQx4OJXf_OG8WakqWyz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 23:04:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] Last preparations before upstreaming Git for
 Windows' symlink support
In-Reply-To: <pull.2017.v2.git.1767989109.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 09 Jan 2026 20:05:04
	+0000")
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
	<pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 20:04:53 -0800
Message-ID: <xmqqh5ssrdzu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> After preparing Git's test suite for the upcoming support for symlinks on
> Windows, this patch series touches up a couple of code paths that might not
> seem to be related at first, but need to be adjusted for the symlink support
> to work as expected.
>
> This is based on js/test-symlink-windows.
>
> Changes since v1:
>
>  * Fixed Karsten's email address
>  * Instead of allowing unlimited symlink target lengths, it is now increased
>    from 2*PATH_MAX to 32,767.

Looking good.

Let's wait for a few days to see if others have further input, and
then mark the topic, together with the other windows-symlink topic
that comes on top of this one, for 'next'.

Thanks.
