Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1920ADD8
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729889; cv=none; b=pnYhbn2598ONxsnhyuWpUX1BpyIsN7nrxDhcnoaHDbn/ryoaT1IBawcL5hczDnSE2Q+tUHkfwHN2tCjknInzX8zpDWjQ/uz+RiO7oysU48RYTSIrsylQyq/o2goJeGi4E0ZI4edUJ0An47FQdi7n/LjrzTwjSEOoU0xhg8R9dYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729889; c=relaxed/simple;
	bh=6spYnK/2in4ZrILWxr7jnlEt3AS/KhrPd8BT2FY+Zdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RBwJpJmTwDYxkkBeIl7woIOSvJyl4qDORv/3wKTAX4kXCSN3Ily/vFLhNDYdijSW2rmP7fm0Oo2pN41PtmS/G7qvt8FHFrSGQb2xuJlVv/Nyp6dDpBlGM+Hphqgc4VNhdTL0b/IgbnN0XQifHOqblaDv5WIC7tObbAdndMzwlwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tPNS7vuJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g1/2yW5B; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tPNS7vuJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g1/2yW5B"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 893662540184;
	Tue, 15 Apr 2025 11:11:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 15 Apr 2025 11:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744729886; x=1744816286; bh=6spYnK/2in
	4ZrILWxr7jnlEt3AS/KhrPd8BT2FY+Zdo=; b=tPNS7vuJCP+wYCsZGdYEOLvkFi
	1b37LdrzVbaSeecmbVYjRPh53OKWPLFRDJ1TwIKGc6PTwXTtJnYQ5J6vimfBmbby
	W2L+MOsgR4K/PeYL1Dd9DaP01TIAS8Mn9PsxnZNzrZ0QPMmcFqdk/NxYri6A5brt
	sFa3cBU67FzYs04ftRyZNtLec/Rv+McD1YN0dg6ozSMenAK0mInu5nlmpv+y6hOY
	734rSVHtEh6YAjfXFnQkQ0N5mBe5pwzKT6Ds2ELeHAYtn8c84Pd1UKmqkGxYVyoF
	Gz9Q3FI5/N/EpLartWT2TzsaOczVGe/iRCfzNC006dgNptkKMKR/OeixO48w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744729886; x=1744816286; bh=6spYnK/2in4ZrILWxr7jnlEt3AS/KhrPd8B
	T2FY+Zdo=; b=g1/2yW5B+Fs9xWR2pT9mFMwIJM1BjXnDGXS92fi1FetYA43y77e
	CDiO1mkz72tF3bhr5dENWE6elpKaRxhvfJsOb3jwNxB7TUkfTi7py8SaHR0EX5dx
	yMlhUiAbeUnyVaF1Zm7jm/AmZmMMOCCd7NI5AK3bSv4Q46Xg7Hy236vgZDILsRQE
	y/MERFKddFOu8AlLsfQncbkwbVFROcCm46aXfvN/HshCAp9nx56NTWY4EygXF1yz
	xgpKbY8A2iw6patuOuDhYql3zlvFND3RWdAhzVAWpBJF9AAcwnFxPfbuSnqyZpZK
	Ynjq8GoGWr8YRJb2OaIga04q3R2l0hHLvag==
X-ME-Sender: <xms:Hnf-Z6u-l8v_JUMlF2duZMDSpDB_5UL0QgtHiuM7l414f79W183tqg>
    <xme:Hnf-Z_fsg1yzR-6rj5DVFTB5_078Y9-COb5lHO93pWsWpU9LGurOOceEmbmXdJbEY
    dmct4ZOG6WUX_NtDg>
X-ME-Received: <xmr:Hnf-Z1wnJoiMi_0vyY2Wq65xvcTQGENDzN5HId0-0Y7ICPGAKv15V5GcbsO8G0deaxcE0LOKJCDXS2Bx9FMLaMbEshDLKfLYoIsR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:Hnf-Z1PWTpVxm32PKnnMM87Tbi9f4n4WouHEwsrJReFQrLahmutZUg>
    <xmx:Hnf-Z6-X5zH3lyQhZ_SptrxiVYneUAUwa88P3LtOxaWLPDgp2Tvalw>
    <xmx:Hnf-Z9VrHWrumoc3qmYcYzT8z5n5LHV0owNJqg7Vx10BDJinqlArYg>
    <xmx:Hnf-ZzfZYS6jY4fG60R9-9wAHkJoB78XDRmF9Y27lyfKhvS1k-HyGA>
    <xmx:Hnf-ZxrTnYYr4UAViHe7FKGCUa7fCk6E4k7b3k1KhNHigtLTOCFzTNQY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 11:11:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/9] object-file: move
 `safe_create_leading_directories()` into "dir.c"
In-Reply-To: <Z_4kmF8NjtERSsBz@pks.im> (Patrick Steinhardt's message of "Tue,
	15 Apr 2025 11:19:20 +0200")
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
	<20250408-pks-split-object-file-v1-1-f1fd50191143@pks.im>
	<CABPp-BFpU5iLUN6Fh_+UG2Y593TWp4E+C_QQxLg6b=Cb-30F6A@mail.gmail.com>
	<Z_jgdV7Tkw0hkvgj@pks.im>
	<CABPp-BHJHPx7orf-jjgbcPtJo=tGeDZzYWEKvPU-qzXTa1fNSw@mail.gmail.com>
	<Z_4kmF8NjtERSsBz@pks.im>
Date: Tue, 15 Apr 2025 08:11:24 -0700
Message-ID: <xmqq7c3lo3xf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> better fix. I'm using that as an opportunity to rename the function to
> `safe_create_dir_in_gitdir()` so that it matches `safe_create_dir()`,
> which is functionally similar.

Excellent.

Thanks.
