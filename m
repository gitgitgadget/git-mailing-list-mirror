Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4449B2F24
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 03:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744861540; cv=none; b=rreAdvRX6pMB/o+BSrU1wzGUkD1U2InEruefl8V04Uls0t0/VWh0+EOTvwNXtHNk78zHZpKSeM1MTSdQZm6glfNX7K36Sw3a3uAoRSHEg0RqdP5CK2HPcsMgA+zoyTm34y/03b5w0Um5L2ukONHxdfMWZR22746KAUsqk/2YKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744861540; c=relaxed/simple;
	bh=hbfvcct0RKiJP6zi06bZTVKSBrMNzqkkj9COOnivSE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jNT5HJvsjB6uJWDFqqQp2cy4kdpjlm05ox1rSKZoaadyqrmBC6fZj1IUoGWkvZb+1LYUsIg2bMOUhvaDdkAJQ1aTRBoSaFAYrF1X/4xJDlGxgE5M8kP/xHllo8iiV1OtmLQVUQuWIjFLUdMa58oNkoHW20hyAN/YZ+bcH2NQGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AYbN6DGY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p/KjjtR2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AYbN6DGY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p/KjjtR2"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 345C313803E9;
	Wed, 16 Apr 2025 23:45:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 16 Apr 2025 23:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744861537; x=1744947937; bh=WKrC2EcF9w
	/gLGD9A3Lt+Bc/6wmPqlwD9UR0DNmY8ko=; b=AYbN6DGYa7uAPhcp37fhzXb5Ue
	0DrDYG2ceyY1aLBPJvNO1/70GWUzRi6+Lg8OtgHBwx6fzO4GQfpHDI3b2QkC206r
	JhOCiEvwT3Hvt7tTtDzhcRgMdXaaBakqmQ5XPP1qT9IcLxPgZoJ0qJ9U3t6QVTU5
	0VtQv9BqkUXEUlPbNg4r1ZPCV1thhykc5xvcwnFxuTXuQtlFde85RO06QoD7mSym
	pZZ0jBydB8m5o1uILibCe8Tv8PiiaKa5KqfK61g3z779L8MkwopoU6Th9RNp8w44
	+g95MbV4Qt2a3fgstJvtdoyjsdzT4wypcVN7CAbryNn1S/99X9phRCApTZ2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744861537; x=1744947937; bh=WKrC2EcF9w/gLGD9A3Lt+Bc/6wmPqlwD9UR
	0DNmY8ko=; b=p/KjjtR2cd5pi0W8ler40q93fH8UGRo+fZozueqW2UwE2Otpf9o
	yxJfDrRjneeOlAVmLyi97k72zeYzk+dSQLVwMMDdbBIp1Hv1xPIh6dKqxEG0PHqx
	YpWrp6AxyX8Vq/mDo0oSfbcqs68T6+ApGddNKqtx/VboSFxibZWfs1V6TXEeRmKu
	jcD0+2L5VxXvjpBJsfYde1W/mI+jsDATBWosN8CE5v6MeJPqV0s5NSsGxcBAHeII
	mmbxL9zugnJzNwrrlWw3/28UFmzSKvZbB5TGJncePSLjjtL3+f0pRXtZR23q8lpl
	bMg4efip/ksjT98OFBFv5HthHtZxtdv6w+A==
X-ME-Sender: <xms:YHkAaOclNLLPsJbk6to0rGAL1ys4hFh3ulzTVXDb0bMrowcR5rlfTg>
    <xme:YHkAaIPJK0VoA1kVJ2W8xJK7ELox2caRshtzImmn-CXZ003o2FbhYtqnzwVUAH_E6
    RBJyb1TZi5P0NBmMA>
X-ME-Received: <xmr:YHkAaPjW1CDSDYyWIc9y0cg6RsXJZf6ScPjFQz7Uo_LLUJo51mX91ifu9PPA5oDgw-pwn0wx855EONJYpN_BH9v5sKF0_mseJ1fS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:YHkAaL_DRbVPC5vsUFSqUHzT4IwKZZB5Nl7ShtwS5rBwv98K3g_sNA>
    <xmx:YHkAaKu26S402nqBtZsTs3mOWdlS2FKASTxAAy9ncySkKReM0qmXlg>
    <xmx:YHkAaCEFKyTSXKsVHxXiC-PrqO9NjTtJ6zYtYA0YU92uxEp7EIy9JA>
    <xmx:YHkAaJNm9telBWnvNRE_lSZuP0zTMspSchn96L0kB4UCpFi3SoHxPg>
    <xmx:YXkAaN5HaKT6qDt02chv5PiUs8k3JopmrueuT8QUKzr9IZ2n-01Hws5R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 23:45:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH v3 00/13] miscellaneous build mods (part 1)
In-Reply-To: <20250416231835.2492562-1-ramsay@ramsayjones.plus.com> (Ramsay
	Jones's message of "Thu, 17 Apr 2025 00:18:21 +0100")
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
	<20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
Date: Wed, 16 Apr 2025 20:45:34 -0700
Message-ID: <xmqqa58ffo2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> changes in v3:
> --------------
>
> - patch #9 adds some whitespace around the '=' sign in the
>   assignment to HAVE_CLOCK_GETTIME and HAVE_CLOCK_MONOTONIC
>   build variables
>
> The range-diff below was generated with a 'creation-factor'
> of 80%, otherwise patches after #9 are shown as complete
> re-writes.
>
> I have built and tested both the make and meson builds on Linux,
> along with the make build and meson build and test on cygwin.
> (A 'make test' on cygwin takes 6 hours, so I will test that
> tomorrow and let you know if it fails! ;) Highly unlikely to
> fail, since the v2 patches passed just fine).

Thanks, will queue.
