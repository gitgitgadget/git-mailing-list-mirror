Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41421A952
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438053; cv=none; b=Bj+o1y7GXWROwbbMFMjmlVnIWD7YDQw7B9fhR5r9ziCmncqMBPnwbSe/e3khLhzyn7oAyqvtbEYvBjB5wcSTtHnHEREJ/FM7BgxxvU703WY+2VuUGujLh/a/i3q57zULRRjrM8Fn2Tp6Ilu6+N2meamsZey/0+Erp+oJhJ9KAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438053; c=relaxed/simple;
	bh=kZmrzSGWBliZ9Cmw8z8+zZpfzerFTon7jqw9oerGPgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BKr/juaoDz1Sr9l6yIcdhqWe2+wytjuHW4j3Yz/GsUWsOCjNt+elsQgP0kxzPX63koGGYAn6IwQLWCON16Hy4ry2q9hjpXN3FkQgLYfzeUR8zJho2ZfWfOFMP2mf5lAzO5OIsw3U9BTt1fxWRE1yvw/wmAkEtEvjTPnrG9ceYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pSjZK4vP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dz1XeCD7; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pSjZK4vP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dz1XeCD7"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9896114010A;
	Thu,  9 Jan 2025 10:54:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 09 Jan 2025 10:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736438049; x=1736524449; bh=dMYjY1UZi4
	grA/WLmMWqag4aNLD8/fmAYcwHDtnXVuk=; b=pSjZK4vP52V90iM/qmAlx8ZawL
	tJjsKApvuVYdckB6bjRgv/U+mP6lEeRgbNc0vu3jqhh1+F+0ZQ3CZw/AXloBaXEK
	NGn+RQJtSD3370kiZwvnV/+lsZCvAT4xSAcVfYEGVMubN5xOc9aR/vdeC/sYyCsG
	fNLfLr/GWT8eu10AXBV1xy+KgPw5cvEsShSOzpdyP4ia3Kh+UQ/ZSu00+y0cEAuq
	WJbmKDUA2/xc90reYQWF1ZcJfVhVcg/ofk8rw5gmxfbLlh3dszyXgESulgBWiKFP
	lP0hKPhZSy9bja+lEdpu9efJdHcJ7fYCQEF5wWqm8gkP83gg4pHr2GMcTHPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736438049; x=1736524449; bh=dMYjY1UZi4grA/WLmMWqag4aNLD8/fmAYcw
	HDtnXVuk=; b=dz1XeCD7XeuO44XuGk3IfIjxh7nuBO+I+a/8FOxXY+5wuhl09uy
	iY7Spb7Nv79Q2N1IJ7fHf5tg2MhANg4K/XFHNMnzemXHb3mf7QgYjusXwiGnx9Wm
	tkc0rNCqg3RlHSwYbxe2cYA7ZeiH0F/COCqmRJ33OXWJDgc2QiX4i4JYdx0xTAQL
	hW/YytWrY7Rbw/5xvgLz81MuZ/LM9TP91V0TpwQp6AKt44Ld67tBuqe+KHYXoobr
	8KEQVH0BHzPyWNitTAIY1QZfB+vZ37sZHe1gd7uQa5rwOr3WswPma9Kx7NijJ1QN
	f9s+C0sDt3oTraaOHctBTHPxSbi4k7+BX9w==
X-ME-Sender: <xms:IfF_Z6P22M3p4r8_T2GnKRouM3Uy9OFWI97XVlTSCEXfHXcNuhqk7w>
    <xme:IfF_Z4-RMZOWHh90LKtF36yRAc-VBUhxeXQYLt3nNYxZ37ayxM1AymD3NQFC3BudB
    KHuTy6nags0s4qsOA>
X-ME-Received: <xmr:IfF_ZxTMFV6bWThQ4KOy-K4ZvIae3BPzAAUn8rt_Jh1kJmAptJO3ca9axPaaGjFGEuge5s-DJiALBhMMga9NrbndnJ7yR_tz7suD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:IfF_Z6tI9WOscNeSj8I1vZ1dqxqI1U3dIIh08oodTw3A_YUZZZIWiA>
    <xmx:IfF_ZydXoXIhCOoPOx0XIRZ4pRanAWxgAeK6GvO8wWTYHSWzCVD8yw>
    <xmx:IfF_Z-3B2W1uqRu1UorzVUagvsl74Nb3b3L3OBzKQT6nbcmltUIhsA>
    <xmx:IfF_Z28RDCmT8KweNGikJoPg3AcCjFCAOMnrPl5gwjUlWhGBHpfuFw>
    <xmx:IfF_Z_FJ_bNs0sxYWL7fgKWV5fix6KNB-PwfMAtIBRV_vx6sYX0mmu99>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 10:54:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 5/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <Z3-i5mB4JVeONy4O@pks.im> (Patrick Steinhardt's message of "Thu,
	9 Jan 2025 11:20:29 +0100")
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
	<20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
	<CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
	<xmqq34hw0whh.fsf@gitster.g> <Z30hnx43mEwjWqzA@pks.im>
	<xmqq8qrmvap5.fsf@gitster.g> <xmqq4j2avaam.fsf@gitster.g>
	<Z3-i5mB4JVeONy4O@pks.im>
Date: Thu, 09 Jan 2025 07:54:08 -0800
Message-ID: <xmqqy0zkj84f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So I'm inclined to leave this as-is, maybe adding an escape hatch to
> silence the warnings via an environment variable to give users a bit of
> time to migrate.

OK.  I strongly prefer simpler implementation, as long as it won't
make end-user experience (over time across Git 3.0 boundary) overly
unpleasant.

Numbing the pain for short-term gain and letting the inevitable
removal (not deprecation) suddenly hit them is also extremely
unpleasant at Git 3.0 boundary, and such a pain is probably a
problem of their own creation, but I learned after Git 1.6 fiasco
that users always blame us for their own failings, so I still am
fairly reluctant to see us offer a way to squelch the warnings too
easily and forget about it.

Thanks.
