Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7123A58F
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764526271; cv=none; b=Jd66STucd526ccRcSDSjDAM4gSr0IlbeVip3VsR8km3MWxz6X6FnIGgSK8+I3Y8egbhuz8QiKvoTEXf6QFB3u+8WtZsGXDYNNY87l18J4xU0TN+NFa2IkT2554Wa+Pb652tATFPZjbD/OEu3FGBgl61lmx/BrsOfmd8gzKMLOa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764526271; c=relaxed/simple;
	bh=3DLEiIdXB604i5LH51531txh4TBBFh3FWDe/nduxvS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UiYI4Xtwbd57LekkfrzEzZXpB8uyKOzSggvQjzaHy8IWKxbrbpigatd1EDYinxl2aSrqnIv6gHxxJMo5klRHWTAF2rTN/wqgw1nd5fqkLzSkDBK3oa4u3OS0DKJ0XZA/t9aJy0kqsr8KmxMi4TWgfpE9kshvws5NDcOYpgO2CRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZLjsDGvb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O0SjputL; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZLjsDGvb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O0SjputL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40E077A007D;
	Sun, 30 Nov 2025 13:11:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 30 Nov 2025 13:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764526268; x=1764612668; bh=JxIiFXI2YS
	xncb1/4hjlYE/1ds42J0Dd3mbXAcNkz4A=; b=ZLjsDGvbmtbRq0RubmVVacjX1I
	S0y1SHX8Gm8Ew+SV1NMsn7iBHyjYzd5geJfuAN/kb0wWMt/wotN+S2aCQmaXKpma
	DOCwF3/HLvMwokggB/sdRuxgtsOuWm+I6dKttvvL34K0mL5R7YVO0NLCi6lzRK7D
	WKQ3RpYkVqprWU2Q4L2jAVPtjGrZ5IYpV6Vyr+KDaJh4UKpblw0mZkirtHEyolsJ
	IDoVaVsZgqEvx27joTXoZNJU3k3kwEWa0hbvNowZJFp53tZ2LvZV8VDUUIdr7hZP
	34mHvoENvKXgdABRGbVo1JPvNeM2tWG19gdWeE++A5qzG69uo4Vnp7y4bn3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764526268; x=1764612668; bh=JxIiFXI2YSxncb1/4hjlYE/1ds42J0Dd3mb
	XAcNkz4A=; b=O0SjputLpGHuZDmUIysofKpK4H5KzqSZm6dU4Kbr2I9gCM29EXr
	kU+tq755ybjufDyGMGnYx29XTKyJ1+APIjurXYf4JqTAKTkDBltCX9ITQxDIWGP9
	2qtdVaHxMdWO7Ul+IJrcVl3qQzH0j61ACD2DQre+K/q2itpo8Pbw3xeyCAr3ncaJ
	pC25YBao/xQ7f/SvZeS0oBDIWlGFzXG4LmNXAfEsoZJ3JoN9zB69jM51u1RXgmBS
	fVEXh6FNPJS/v9U9ltadEMESb2ZM8+eYwOqnrLPmnzDNOLKX04ajyktlq/Wj7Mt2
	Q+Fyl5Qi4w/SODYm38hEoq5FMGd0GuAq05Q==
X-ME-Sender: <xms:u4gsabBUuqYcZjqQhFMvIgTXfdEYlc8h_7cWpz5qwvI0QKnGP7g8wA>
    <xme:u4gsaVNwHQ8B0nT_OnCjxPPR_adho3ntyG5BlL217sJZVJ7ONBd2kVUrF-uDv9GsB
    E-zDsOIfzQ-uZHQ-It_5YyLwndhO8vOr2c49BQ4ddOkVmQiLBCCKQ>
X-ME-Received: <xmr:u4gsaQbAurGCDUtwHjmqDiEPUXI0XUL9ipeYdqkHMJYtIkJFQCGF9_Qi-2pF-PTIngD8LvcjE9mAG63OHhYZW82BDAkrKKyVuz6L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfkgffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhieeflefgfeeuudejleegtdfhieeivdffteevfeeivdevhffghefhhedt
    hfejvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehrrghnrdgrrhhighhurhdoghhithesshgrmhhsrghrrg
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhgrrgdrlhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:u4gsaUuWfpL1Uj-0Jc5Vbt4qCpIgQEIdy608oN26b6SM8VHHFvw6Tw>
    <xmx:u4gsaSMvhxgvJFWXXMEMnv8KSJf7t0Md5FnW7DaXKRMMVtQVN1gVrQ>
    <xmx:u4gsab6iXENi4crTWsmJ-R7eeS-EKwhWHgnUCB2AHz7gckjHqKjg5Q>
    <xmx:u4gsaYR12MGsO20o1dVkuaeU5zu3asOmimmru8Kc4nnYh6n2uDaEEA>
    <xmx:vIgsaQoFrowb6fLpd7YlA-SyouXn95a9BC7W1I8sDupoGn6BwVYemCdj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Nov 2025 13:11:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Ran Ari-Gur
 <ran.arigur+git@samsara.com>,  git@vger.kernel.org,  "raa.lkml@gmail.com"
 <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
In-Reply-To: <20251130134930.GB199421@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 30 Nov 2025 08:49:30 -0500")
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
	<CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
	<xmqq8qfvw2lh.fsf@gitster.g>
	<20251124235530.GC2051672@coredump.intra.peff.net>
	<xmqqo6oqucka.fsf@gitster.g> <xmqq8qftrcqb.fsf@gitster.g>
	<20251126150215.GB4143292@coredump.intra.peff.net>
	<xmqqtsygoh96.fsf@gitster.g>
	<20251130134930.GB199421@coredump.intra.peff.net>
Importance: high
Date: Sun, 30 Nov 2025 10:11:06 -0800
Message-ID: <xmqqzf83bdc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That's about where I'm at, though I'm a little worried by Dscho's
> mention that apparently git-lfs has the same problem. So maybe it's more
> widespread than I am giving it credit for?

Reading <https://github.com/git-for-windows/git/issues/5972>, I
think the mention of LFS in Dscho's message on this list was a
red-herring, as corrected by Dscho himself at

  https://github.com/git-for-windows/git/issues/5972#issuecomment-3577520017

I do not know if buggily constructed command line by Atlassian
Bamboo is something we want to bend over backwards to help papering
over, but probably not.

> I dunno. I certainly do not want to get into a deprecation period and
> all of that mess. Maybe the breakage in v2.52.0 would be enough for
> callers to notice and fix their invocations, and we could just quietly
> remove the hack later? But then, I am not sure what makes "later" any
> better than "now".

Yes.  Let's write it off as an inadvertent bugfix ;-)

Thanks.
