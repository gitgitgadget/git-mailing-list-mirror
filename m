Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5ED6FC5
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730679742; cv=none; b=ZMwKogyuIAxySNMEiTVIjDkMt/NH9TjiIO1bHDUq13c+Lh7/y6pw13JcMy0mWmKoJH7QWprhQ82Afrlhf16r9EXmX7JqPK7nKJlfpqRX4Xl4vAyovSr6AjK2T8M5kun31gn+0Ya0lp+27+G0XxUIm8wX5V87F0TIghWPWgq+IMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730679742; c=relaxed/simple;
	bh=Mzb9nLjpv6uLziOQljTy5YQUUVmvgl9nWYywEQxrs5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tq4h1dTH7Budsw16iOc5wxLVWXVRdiu2FOZbEQnHepAJZ7fPd21DlZiqiUxfweksR192YZ/mEAdWyd+1t5n3ZDkEuKIAVzFdbCMjDKUmeBoZAdkB6vScMz3LoReB5pCvzyj6IgWgB03nCifjp8MaB3P42gj3CNxPliEHEfKeHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VlQRsg+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hyntE4NI; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VlQRsg+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyntE4NI"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B58411400CE;
	Sun,  3 Nov 2024 19:22:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 03 Nov 2024 19:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730679738; x=1730766138; bh=xJz740xc2Q
	M4PVYRVvGZH3yij+t1tKxIvCcORbbDeRo=; b=VlQRsg+YwQgl+c0swpMOoscn8/
	uKWextHkVCRQopDe8fLcWGHe7ZBmWtqqOATpBCpC4aHKAL1mPAlvZiLgCdg1E/xL
	XKiYVz/c+EsADLc8tGdTBVQwhn4cQo+WxAEJeqhRNta3nyQsM4OoJwG60kzjzpVO
	M+sQjylm/HmBP+g9nn9WNEvK4I4yHwMhy8OgJFcRx/Pyub2wlqjEUZWnD7jtOe4s
	nwRlR+2RDeJ3Uxq0rkf+b7Ek7p+U9kdbtkYdjiYTRXS8NhIIuIUZN9cJN7ljm0x6
	lVA/SMZZvhO567DDEfHek3DZXvN7/ZUE6fYXV0TVRW94dNERX6polzi9NKdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730679738; x=1730766138; bh=xJz740xc2QM4PVYRVvGZH3yij+t1tKxIvCc
	ORbbDeRo=; b=hyntE4NIwhKD8iEfu97kE2CeKYfkcNXMVfd/ZdLPF9Ab4/KHS0u
	RoQ0US/lg0hNHOLoGVcjnHwt+ZHk2bQEOQK4FqqWbwZRbmwZbsLpOvrBUCVp6vta
	jzmX3lb6WIa02nz0FijEKrYVaEjoGw0qqkrdKh3eLZbksWs93YqK4iuM5HYLbriV
	qj5r5cXA6GuHUMUh7C24moTborNnqtxSHstLekD7Jgg0fxHPmAvZLU1N3J8EKHoq
	ysIMRaVT8rmGRI5QGxEb48+/vofnWVG+UeqRF0ps/y1/srSazB/dwM4DOXVhjsay
	OFYYgQxRGbaXdn3TQQT6D4rk/rlSQuOpcCA==
X-ME-Sender: <xms:uRMoZ2bFFtVJgrezg6OAX-Mz_hUA86sRiydinI6XP3NhaevR1MP1nA>
    <xme:uRMoZ5bMCeZIU10Zj3rehey1BcBJFwuGiK--6yVkoY7Dt4JlXufUNhGLqQ7E83KEY
    CkeXRtT-Pz3J6ZXuw>
X-ME-Received: <xmr:uRMoZw84o2XHkTuDbl2j3-E6NuTT_JB3RusQUfU1fxAKg2G7CkcH8dpTWR9B3ndowqtnvqIxnE81WrTkQdC2OFIR910He7509M8O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelhedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffie
    etueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhonhgrthhhrghnth
    grnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohephhgrnhihrghnghdrthhonhihsegshihtvggurghntggvrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uRMoZ4rEk99FCLtqq2auCuz0rk-q8n_kzxr3a53EvraeR-A5ZtPUnQ>
    <xmx:uRMoZxpv-gsllOERZJJul_8AFpHCoiW_f03YDORrgP8oxAaDT7Lnbw>
    <xmx:uRMoZ2RGUZLt3E00GJThRpexEnnHHcnU5T9nL7-CN8zi6hE73hccfg>
    <xmx:uRMoZxpipmAcd6jKUs7Nl-Qzr5PN-IuNH7t7oZUJftfKPRr_LRJcTQ>
    <xmx:uhMoZydQ-KUX3w0_0obyE7Ny7C7WFt-C2jgAn6JDl28pDeHNBcy8lDV_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Nov 2024 19:22:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com,  hanyang.tony@bytedance.com,
  me@ttaylorr.com
Subject: Re: [PATCH v2 0/4] When fetching from a promisor remote, repack
 local objects referenced
In-Reply-To: <cover.1730491845.git.jonathantanmy@google.com> (Jonathan Tan's
	message of "Fri, 1 Nov 2024 13:11:44 -0700")
References: <cover.1729792911.git.jonathantanmy@google.com>
	<cover.1730491845.git.jonathantanmy@google.com>
Date: Sun, 03 Nov 2024 16:22:16 -0800
Message-ID: <xmqq7c9jyhjb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks everyone for looking at it. Here's version 2.
>
> Jonathan Tan (4):
>   t0410: make test description clearer
>   t0410: use from-scratch server
>   t5300: move --window clamp test next to unclamped
>   index-pack: repack local links into promisor packs
>
>  Documentation/git-index-pack.txt |   5 ++
>  builtin/index-pack.c             | 110 ++++++++++++++++++++++++++++++-
>  builtin/pack-objects.c           |  28 ++++++++
>  t/t0410-partial-clone.sh         |   6 +-
>  t/t5300-pack-object.sh           |  10 +--
>  t/t5616-partial-clone.sh         |  30 +++++++++
>  6 files changed, 179 insertions(+), 10 deletions(-)

The reasoning behind each commit seems to be very well described.

Thanks, queued.

You may already have noticed this, but with this topic merged,
'seen' seems to start failing leak checker jobs e.g.

https://github.com/git/git/actions/runs/11642458705
  https://github.com/git/git/actions/runs/11642458705/job/32422074222#step:4:1964
  https://github.com/git/git/actions/runs/11642458705/job/32422074132#step:4:1963

