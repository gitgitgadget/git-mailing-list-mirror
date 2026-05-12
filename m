Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D55426688
	for <git@vger.kernel.org>; Tue, 12 May 2026 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565804; cv=none; b=gf9BSQnJPnvXDkME9bjpPIHVrVCYsMczjE4DpWUgZfyu7RKbsnnvhevQgooNLLErxykUpcUbzC1wD5t1PXR3TcCwDoDahf+5Ax3rgfYDUR3pLCTQvrNFnglfFew2Mt1c4H/W0oLVTyEm5XbwkGHdmvGkIg0Wp6L/vgb+wwk4X5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565804; c=relaxed/simple;
	bh=6WBlr1uDJvaCrf9Hz9HImDaIa6pMcE2RaE7XIWKbcfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mC2gqRYQRqLuchgZE2AaLrVktTa5HlSSvxWAO2LKsMECaA6txKZ4CE6+SINnr1i8GTgZGFRhh6mWvJjCgaLiE7kwvqzkaUFkSSMHc2wcOjCzEhdtacF4jMLTH2epe638E2VxHM5iLw+r7J3+lLLxSL+ywC8XNbQz0+PApiTtUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N2mmf2qn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JTtmDUhJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N2mmf2qn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JTtmDUhJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 173F1EC00C9;
	Tue, 12 May 2026 02:03:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 12 May 2026 02:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778565788; x=1778652188; bh=q0Il7qq40e
	qfDpnN426WqAjs+pKHJry7tdm3Qf//Ees=; b=N2mmf2qnKtN+0YyR6bSm1KIZi+
	yQvafURY7RUsM4dQTgcIyxQRJJm3YxwlbWKkKbr88+1xl/6QCoaHlC5pMyl/ZTy9
	nn652FQLQrrI4K4WB+6bfmUIkFhuwLfa1xkiUHeHiKYfbKMMsJV2CFJQrVvurN3B
	LA94iTrpHDsjph4axHM3Enfmi43myUWYW3rG7vJvjj+9zZLrRf1fm4sL5SmHHqFy
	2D498UxN0w5RWC9mYC8QhvdoXFx+85/GK5ieCGlnrdMFqLpkdZqi5Ci/SyuwnNha
	vsrNy7+ubjdNXE1fltZBf2fSEBpsx0IupNoDCP7Vm7bNbkHpI0yVNladdIhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778565788; x=1778652188; bh=q0Il7qq40eqfDpnN426WqAjs+pKHJry7tdm
	3Qf//Ees=; b=JTtmDUhJ4GOjF0eldRSg07HE/yFGXxQQU+Ltl1jsCF9KLmsVwvI
	8EK9l6FynIZSa+mdS/IqVzcOuxKH0AMsVhAL4KvX7WMXQVqZvDF7knCdeNbZc9Kg
	IoJOurzG9ZJE32LsCN2KH4PAQXTfoYqV5xikx7zPtJRME9yBCOAlboGs/evwWWQ/
	CM6ywfSptOK50/HcI5dBO5cMPO6LR1Yck4w4lrJCYaP7dmR1hGkzhnH8cZsHM5uT
	X/+SH3nMIw781bFWIJEwmoWhlKu6uvqX3n+R7p11Zc7jY4e4IIqUiM7z3pNQrzSq
	OMgSE5Z2Lv8AUjONHr2+mt5XjZUHMg1CZow==
X-ME-Sender: <xms:m8ICarhdo3JN_45ueg3hIzphYv8A2gFzXh2tZ2MO2tejcNfO0bv3Yg>
    <xme:m8ICau4dj6a-0KLw8OGZf3xsvnetvVyHdjR0CMOPs1Asvq9a1WCfiSlvl4r-rWohU
    Xvl51jy7SHQvfiWkugo4zuvMEIdm1iBlROt94o1fJSwZIzvtNII>
X-ME-Received: <xmr:m8ICajYlTh6lH-8VhewFHuaO1wd6b9H15in_pI_yTHRsNLiiPpVtq3C02CtJlec8hCKS4Q2ggcGZdWWpq78H4SvqsOvfFLxEbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddutdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtph
    htthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:m8ICaj6GHcToCdo_wy24CevQ1yL3q8dui6wnY0u7FP6vCrj9Xm2dPQ>
    <xmx:m8ICamCZa8Epdrd3EBLmOtumnXdXYYDKjwurcqC2jbZDHkPipwOQxg>
    <xmx:m8ICapfnGK_6eQRmeJI4CQ2SPpwJvlQ9lyy_9BcEsAgCdB6ZwQcx3w>
    <xmx:m8ICalKNGbVpNAjQP_uLDbAG8aXN67g-9P53TBGCkt_d_1AvD90EWQ>
    <xmx:nMICamGXQjrZybd3-lPbTiwKvDb_dT-eKYFHxKdEmiPbvbqt9pOOzJPT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 02:03:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 0/2] doc: log: fix --decorate description list
In-Reply-To: <CV_doc_log_--decorate_list.626@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 27 Apr 2026
	21:06:48 +0200")
References: <CV_doc_log_--decorate_list.626@msgid.xyz>
Date: Tue, 12 May 2026 15:03:06 +0900
Message-ID: <xmqqpl31np0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name: kh/doc-log-decorate-list
>
> Topic summary: Fix formatting of the '--decorate' description list.
>
> [1/2] doc: log: fix --decorate description list
> [2/2] doc: log: use the same delimiter in description list
>
>  Documentation/git-log.adoc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f

This does give us a solid improvement.  Let me mark the topic for
'next'.

Thanks.
