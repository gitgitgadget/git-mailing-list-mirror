Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93540254B1F
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535657; cv=none; b=YXSAwLae7iBcyi8Jar+lkrWyR6CyBVr6WvzIoW4YmUFxbm84TGLdXMDdcPY0Fs4MFyw21P8l3gCMpzgYjfFmdZyiKgZ97krDMc0KWIYhlU/DOFvGeviU0hsUsUW0LPDraX4AaewSrmte3oy8cTNNGu8w7wNXRaVDLlmew41XarM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535657; c=relaxed/simple;
	bh=x9EOKmfj9tVo/XrxoSGW987koMFs55tLpCCET/7U41U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MOIUDUNM62BqfpTowhA1SC7p+5drKTfYV9JhcgiUFzC+oA6g+5M+YFUpCRLwxjriemcD7l/hTtLFWnbDykYPQs0eOjzsoEykbZlP6abkg2zAEvMZFxPkfrKUK4/7bvkg1HVxRetRy028Q0OUdyce6NyDuhuPyy4+0DB8XsD0ovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WUZaiUko; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iiRlNgui; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WUZaiUko";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iiRlNgui"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 983711D000DC;
	Mon, 18 Aug 2025 12:47:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 18 Aug 2025 12:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755535653; x=1755622053; bh=C1jWw6wb2v
	HiyhWrHXEaKpAliZRkk7iNb0LHPJXgz1k=; b=WUZaiUkoUhgxvIb/wmHMswliT6
	DNi3BNnyqhLK2wzdeHU1GPak9XWB2r8o5wGEGOHg22m7kgJqHuhLrfgmb42046rH
	rISNENfguFU8evTpVZ/qmYWrMvWuojQ1fd/idIakeakbTpfQyerbB6ZQTt+S/V6V
	y8wzLPpuEKxKvdQ+v8oOkehwLVN9xdNyFcz6w5Rj0k0h4lv6v5FHU+qUehufKhm7
	msJT9ueswRxtH2elupDN9JiBBcj7KPS7NzRShwyVUydDPhRfWJu0F6JmEP7+2Kh/
	FvY4HxRPczqMkBDa0v2x/YaPoD2X2YePPczCyY40RpyMHnnOt3AOufjPVYdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755535653; x=1755622053; bh=C1jWw6wb2vHiyhWrHXEaKpAliZRkk7iNb0L
	HPJXgz1k=; b=iiRlNguiG38VZTiOfzZxS0GM1J5c6E4W6G2KTzULGAL2uhEZSYe
	eGG05qJOiqyIgN3Ot4S8JRRKZ9TUZ8aVEU0S5IlnH/ewpxyP5UUhL/6d0APj+kiI
	eF0d6C8qOcPrV1GtDISIkndqGcFhZaBjAD4jbZaX5Lv9OaQnTgupMs56xxGp5bIM
	Sg0kGzQ2jZ2O1b07k+CNxgk/nwb0QPqKBTybDUep8xVweZb2My/Pcgoa6LILmt4Q
	+9dt3a4Pt1rdJgNktmLTu/DibtZTCQEdrlCj3vRtNJ2Z73jeCg5v/FD/RJIwiMvg
	lBbZ/r7YMW3CNiUwQY0vNGALZNHJ00VthSw==
X-ME-Sender: <xms:JVmjaCoS76Pb2w_IBQwzu-OXpk6hX7kZ7lYGVdGx6hljM-iUD7r-zQ>
    <xme:JVmjaD6AUvY9M1El5g4cjhoGxQ8g6gegZTU8t7zPVD7vw2Sj214AEQn299bAE4xyd
    IAJpiDg_1Nw58n1kg>
X-ME-Received: <xmr:JVmjaArSSuahJIapzcY4E_ThlZqqin3mEJ5mX2TE9vTL8K5Dnbv9jV9zl3m9gGsgEPgShRotXK5YOnFVKEdz4-85FuNOG7yymLEN01U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhi
    hushhhrghrmhgrudejtdeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:JVmjaNjlKf7Doxi978Zoe1Qt2soMGBa0cqLdG43spRDPC9syXU8WLQ>
    <xmx:JVmjaCJuCBpMEweOG_RndetyFj16dQoi7MRl1KsOpHNYMiu-scPswg>
    <xmx:JVmjaFB6tBnOiW_mWzamsq5eZqXE1Foc5k6J9MkOzA6GiN3k5ZSzUQ>
    <xmx:JVmjaKi0qpykb7XgIuWjcL59RrLRfV0TJu-XNhiaCarwAv4IwX9Bpw>
    <xmx:JVmjaEhuFNTeQXJmBdpzmTTdgm60fffMGVGxd2ac5zT8Or62ovbVV9aw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 12:47:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Sharma <ayusharma1706@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Inquiry about feature request #1665: Conditional includeIf by
 hostname
In-Reply-To: <CAK8tCCJEAt33AMkPKZazcS1h9PKFig2ixCUC4V+D6--jyTuJnA@mail.gmail.com>
	(Ayush Sharma's message of "Mon, 18 Aug 2025 14:59:26 +0530")
References: <CAK8tCCJEAt33AMkPKZazcS1h9PKFig2ixCUC4V+D6--jyTuJnA@mail.gmail.com>
Date: Mon, 18 Aug 2025 09:47:31 -0700
Message-ID: <xmqqqzx8k258.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Sharma <ayusharma1706@gmail.com> writes:

> [includeIf "hostname:FIRSTMACHINE"]
>     path = /path/to/firstmachineconfig.inc

A quick lore search finds this thread

https://lore.kernel.org/git/20240319183722.211300-1-ignacio@iencinas.com/

which looks somewhat relevant.

