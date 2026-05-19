Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014611917CD
	for <git@vger.kernel.org>; Tue, 19 May 2026 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178598; cv=none; b=MEs0RgxupmnwIk0Ve00sP4AqUhNG88d0UvFsGIbcfhkksIBWmzOublSIFeOOoB0GuVF+CyMdXwsT7V3pSp0BF7GXRnY/DLWJ71BX6dzE8ICEqSnYxSoLfNCbHObjDDv2uiwIS2s6aZ4i1d87ublHe48HguQ5THuzaC8xIeKUd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178598; c=relaxed/simple;
	bh=zVXgN2aofQ+vTrHHDX4OEDp3e5PBSGV0XDRW98/XdHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vd4RUvgxEatJMuC1cjd2mZyr451CIOW5+W4fCReSGtgUdxTcN1G4FKPSNqU9hZpjsC3duewx1mnP1U2TeiUK/BE8Y97yAKBafgYWxfumJyp/YEnvAgROuwwQWG+A5tdRhrIxWbbNQnSpKpP/oE6nnudPmYhZKWQnRl2mgsKUM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P70XU9CQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q/5XsEmk; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P70XU9CQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q/5XsEmk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CBD141D00114;
	Tue, 19 May 2026 04:16:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 04:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779178595; x=1779264995; bh=IF/x0brrxm
	5teshZbHBa2vBNwsPYJdKlQu/yYI8IhH8=; b=P70XU9CQTYpr9ElioMKVekQ9DB
	G64FjHqks8VXoxX0SEb9jrlQGvYVGhSQmziZMjY1mcfU011FVoOUJy1S5SHeNQ7W
	bQPDmk8xbcDxIZAY1f/A/ASZ/mfeGHFf9iqwNHjK7pnHXcYh+IyTlNpgiBGgXMw2
	8ke25fGv8kjhIO3kAIkWVhej/WWG1XDs95sPE2tjhtzFVrKFXDjEATNQ9ax31ole
	o8k01cKreKZayeqcHFNL1CrJ4IphSqxqO8Hmk6Oq5WJdLr/5fNgfyj5lyO+QaGkA
	0BBkLT+u2t9bxz2HTs7tXUcTHn6ilXF7gP0OAeK7rXhheqbGsgtVXBGPT3JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779178595; x=1779264995; bh=IF/x0brrxm5teshZbHBa2vBNwsPYJdKlQu/
	yYI8IhH8=; b=Q/5XsEmkuKXIlG3akYvxZHM8hfz8DI7FS4ZEni13PnuXwH//uyD
	Hke4EQFSrvp0x8qCMeKWtDCBhPJDpQmkLn77Qvc7B8ZxgQ0oBbAeMKMkSiObY+V+
	rGJ9lK7AVrnBdU5dMBtXHrSSm/pVM0pl30M2FOKLgyJTtnIsH0K4kK6L4Dtj8/1j
	J2c/AdXwWrvJL9MO+PZBz6RXJWq3v/I+DHsFBXEnmLuGSY7uJAIqZ9nO/DbB3xKF
	vmdgIL227OgWIqmIOVFPw58nLiWKXenHqQ4YyWjktfXO7SkVf88gBuX1mCwwBlhm
	cQ5pWRzilzhUV0dOWmO+bLxDsA97fbPzuCw==
X-ME-Sender: <xms:YxwMalJ2PauXwuvl78SaBDwDtzQWzbvPG0KoyJNC9_kHTlp2n2Aenw>
    <xme:YxwMamHCnV68T90oYqBGzMb3BoGQ8wxapl0f1K3dsUDsxpYEQ45r28jT7vFQ6mLpX
    Vu1Xauf4_RqSXGQBKm-ccv1MELXNfdVCfqJ6VH-PdWAjs2nLMzX8A>
X-ME-Received: <xmr:YxwMah8Zu9aHKB1X6gy4DSECztiv0UdB12FP5QrunV6RrmTvfOkJCzaMlpOXba-YvScmqMumtsmFnMTZfTKYa8aD099Q54ErKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeduvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrg
    hmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepsggv
    nhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgt
    nhgrrhgtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:YxwMamJCcaKjWrXeG1IIZ0PO0FZPfw07gII8pDWlbzt77t5PcmCDuQ>
    <xmx:YxwMavtLPOMq4cNCFV0uilbafHZKnTDBJomiBUJJ8zS0cKrD3Hi9TA>
    <xmx:YxwMatDCHxqKjA_eC2bXWI4o1cGz81WYetLJpZuqZTYxvJiTLLbDyQ>
    <xmx:YxwManML8xMSiXTWBTzvmOAgQYn7362M1WxL2syYo5HHSuRkRWZmLQ>
    <xmx:YxwMalQziJmmSpNQeCBqt-Vz9xZX25M9s4KLJEafKeBBdiAw5_xJqSG4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 04:16:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud <marcnarc@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v10] checkout: extend --track with a "fetch" mode to
 refresh start-point
In-Reply-To: <CAHwyqnUx=59MK5zKL0uuFXKrZ6PEc1j_2WT-_xtsGewVH3gBKQ@mail.gmail.com>
	(Harald Nordgren's message of "Tue, 19 May 2026 09:52:34 +0200")
References: <pull.2281.v9.git.git.1778583307774.gitgitgadget@gmail.com>
	<pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
	<xmqq8q9f9b5w.fsf@gitster.g>
	<CAHwyqnUx=59MK5zKL0uuFXKrZ6PEc1j_2WT-_xtsGewVH3gBKQ@mail.gmail.com>
Date: Tue, 19 May 2026 17:16:33 +0900
Message-ID: <xmqqfr3n7r1a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Yeah, good point. I will try to address this and send a new patch.

Please don't.

Next time, think deeply yourself and do not rob my time to think
these things for you.  I do not have infinite amount of time.  A
good balance may be if I find one issue in your current code, it is
likely that you'd better three more issues and fix them before
sending the next round, or something like that.

Thanks.
