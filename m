Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE6B3B19D2
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182378; cv=none; b=ewpeR3xs4CnqY6Vrd2ofiqsEMI9NguwgW5Kgdv0ODxed2jVSlLkXfGdJXqUxQXffRwNdJVtGCYz1Ysksg9kCnXEFS9F2JLuNth0V7unejyvZaB/WV8F1Y+T8Ps1wcz2/Du1TenuzwlSuMXf+tM4HRkwqRy6AYMWMdbTKoKWacoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182378; c=relaxed/simple;
	bh=Olne++hrwMWBWbtSL8ojuP4Znkd1FJ52mG7T+L/7i5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mmQ5DKtJ2/0BDAFPH+WDI8W/7+KoHk86vfKtB5+0iNMDY/++FQQY2ovE9wk3IZnVHH+NSBV23yVMA7sobN9rO7DEFvMcEkm6JL9YbdyTCGv1wed1Y3jwcfcpTirU7U+r6ZduMlzQGFszwFD89X8r0XiFowJwmpQW9DBXcFMCvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C1GSVc/a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tWGma0bq; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C1GSVc/a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tWGma0bq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E2A0EC0B76;
	Tue, 10 Mar 2026 18:39:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 18:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773182376; x=1773268776; bh=ewLEzLAbNx
	qka85Z3WlWoLLudfRoAKK1neIUK31P/t4=; b=C1GSVc/aFDN7TM3hbZULj9kwmc
	8gCMr8b5qWwOpBvgoPoRymUVLN8x1NO/FJLZNo/jrFNTvy9voTERtNv/e2LQsncw
	IvWcoULKgh2Cp7gFd/h57N/2r/UIsvoS82iuUXQK9jM7lbT4+oQF0Hcwx1BPETI2
	+xHk5i8b2xXrUJ3+rxNWjy/tvPdev2L5oXLEzPxIaUcXWHQOvqm4V9T+auKwfbNE
	DCwXb9UtfQPxHFwd/6SC9pfMa06M79B0QprDy1gOjerqaRWQMJ29B/mxgbAgMuYj
	Wu/M+YVs/twpNkD6EXfBj9kuy5aauhd+MT3x8JpIhjkHdjR3enxbUy2JCtCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773182376; x=1773268776; bh=ewLEzLAbNxqka85Z3WlWoLLudfRoAKK1neI
	UK31P/t4=; b=tWGma0bqhjvR1Ej6tp9aG624+uxwZiiQuiGmumlqculJer9/aFJ
	Z9Wj4a+L7B1ia6UdQPbKDaUHixSbkwgAI58d+JJBB5YR0oxe7vt6naspAxzO7e6+
	157pJNshoN37hW1MPZDghkp5aijWvJDxOkHy+0hTF3skYxzKKxIQqFNOyyYT6+hE
	hlN6CcI4gs7qQrGWDgVY+vQJ+yN6rdzAhvnk4ku1YzhEKQe8W3ItNXQf91TvHS9l
	rk4CjiL0ar3SyernBl0w0LLMeUhrEYtaQY6sNNWatpQs9WOFOffH4Q9D28fVSctd
	HgzTHzd+I1ns7UKTL2HdE/InNqPaB0DiF8A==
X-ME-Sender: <xms:qJ2waYNM5IYuBwTFBgmJFjpLgbGIZuRd4iaczNVdo_z0Sd7vrxMTrw>
    <xme:qJ2waSqHJ6b-VomQnRxUe-KTHiaPnbgPCaUHyy5TmkDenD4L74Qrsv_1sWO-kyYVa
    Uvet5VzRHKR6gKavITKa44dNut91QWAaSkaayBglCiEffrRQZQ-tA>
X-ME-Received: <xmr:qJ2waZGjv5EN5YVFQWMBCoPeQrXYApN51643AWZAJasdflHS0iJ39zErwxadExKERTcbxLGEloaAaURth1MOhLRv4eC0-05T1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qJ2waXpaJqdRKPVeLazFMaLr2Nj15k0SSh7Qjrdm-HR5BoQt6DZJnw>
    <xmx:qJ2waSbxizuYOQPcp5XQgkuzGXvHKzdcTqYRaXrguXvW2v6UQyBPlw>
    <xmx:qJ2waQXwdefpMd2mcSeW1PnPV0G1BZxN2BC0N6GMe5Vb-loEYA5wDQ>
    <xmx:qJ2wab8mgCuAhyFXP5QGLQaOxV0lUX-U0b7fVVp3GBY-l8DNUGJ5Og>
    <xmx:qJ2waS6u2NO863mx20q_pRxJvijiCi6mlO-LhDQikYwSprThkQ_V3cd0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 18:39:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,
  christian.couder@gmail.com,  ps@pks.im
Subject: Re: [PATCH v3 0/3] fast-import: add mode to re-sign invalid commit
 signatures
In-Reply-To: <abCTTaYCQIub_xjW@denethor> (Justin Tobler's message of "Tue, 10
	Mar 2026 17:13:34 -0500")
References: <20260306205359.1723254-1-jltobler@gmail.com>
	<20260310201116.1130160-1-jltobler@gmail.com>
	<xmqqv7f3s93l.fsf@gitster.g> <abCFKEHxu7OZr9bm@denethor>
	<xmqqqzprs7o3.fsf@gitster.g> <abCTTaYCQIub_xjW@denethor>
Date: Tue, 10 Mar 2026 15:39:34 -0700
Message-ID: <xmqq8qbzs40p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> This certainly seems like a reasonable use case, but if we want to
> support leaving previously unsigned objects unsigned too,
> `--signed-commits=strip-if-invalid --signed-commits` wouldn't be
> granular enough.

Yes, --signed-commits=(re-)sign-if-invalid is a perfect match for
that use case.  I am just saying that if you add the machinery
needed to re-sign, you would be able to reuse it to sign objects
that weren't signed in the first place, so that is wherea yet
another feature "--sign-commits=all" may fit.
