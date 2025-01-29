Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7061FC8
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170511; cv=none; b=hoL9ei/gp5XWzBakKCt8tkJXXccjGk5EBdJzmGjyk/PFBbSSvklM/rNDA5ja9XV6dG9nv2QlIBf7KJv4mkvXO9vM35lXJ9TTUXld+g4/VB4bvjs3ghASEyRPgjluI3hVmlinfhZt90BIHYgQOKRS48ZYEwSXJEJbQEBKcKR8ixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170511; c=relaxed/simple;
	bh=B1UbV62RiL2QSll71s9cU0Eic/0oC1qOCiW5D+jzsEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GqdN6kWt+aE9N1Rtkryg/ysrwtYKDQ7/+Yjq1v+Pl/+/Xsv2xeWtFjmd1Q+9r+otEkQey90cumBVoNgwsiX/zWn8XrvqIZeIuYOM0g0BR/EvDAAmM22DMygecLBGygWVT1IJYJo7B8xI+BiL7m9KFwIAa09cS1LJYnVryKaK8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lcrfAnnR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t9HZJmOw; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lcrfAnnR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t9HZJmOw"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6A4151140051;
	Wed, 29 Jan 2025 12:08:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 29 Jan 2025 12:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738170508;
	 x=1738256908; bh=HQQJqrqK4P/uhI+ELrkt+OAa0Gn5rAVAFooBsaMNHKI=; b=
	lcrfAnnRu9oqLx8L+LqMYHONaFB1HuaEpMBB+mfbjB351egZNOtiyMTkkOGORVbI
	kYEgqB0vZv4vdL+LsMQReEx/hlwbebswUPPsonL6UOgc7AY3I/neJpcJ5M403NDI
	SCMY9uTHA6FNWEYgLBuoX+VW3ZvpYJotbebyHI8aAlBCnViiNHHV6wxokAcOSsw0
	oZt6GAHvnfjoNb5qki1Jdj05hiHKzjErCToLMxqDpXgPAZ8nRWn4MqyWat3OKjTP
	PIiRsMF/nVPaQsjCgWWVapNmZgD6X3YWKA2I/d87CpIiz7QTc1o22/j71lkZCmjQ
	rjr3pZdvE/Yf77A4NG+C9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738170508; x=
	1738256908; bh=HQQJqrqK4P/uhI+ELrkt+OAa0Gn5rAVAFooBsaMNHKI=; b=t
	9HZJmOw8IzG37uVNnzN3InU5UGheSLRnDrheH+R8ZcIy+R4SQevLIvNbgtHjNctq
	nFF2zBHRfkF4LBToGFHyX8o7sqlZAEYglYmANgMX6EzGCwbNKkbdOyhBfU53D90a
	jMku/6+ZlaDeD1SKrALm5DLVeH9B8V2omsUkA5F5dGwvXR1v1p1CTtEyOn3H2Pkz
	+VWS4i65pdqspClOfmhtJTmfmN4aqg7wc1C3kb2OYKpzDsitRnHcMxWWiaVnpW35
	0AfICW4Md4vHGSjM/jB+CrC7aUAjM4mgJgJEWOHy+G4HJgPe9I1NokCG2ms6MahZ
	ohdzoNuiI6+1cSvQOQSSA==
X-ME-Sender: <xms:i2CaZ5XaSFQA61Jnc66YU_zo5HjNLo5gjZwQlC6cVKMJYQg0HnX45g>
    <xme:i2CaZ5kLuVZYccocIY2j5rjImtnntOgAfeBy04pIyCaqAJkPDB4ksSYJZbhSDRq8V
    6snmOdUVYvPl67hEg>
X-ME-Received: <xmr:i2CaZ1a-oYMcBJThygp9iUT3E02_oxgvLac4CPQAoITEUhUls5jkQ599wW3ApiqKGZvG4EJqIsvaqiLGnMYHo_7s-bWagJB2qDYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepohhlghgrrdhpihhlihhpvghn
    tghosehshhhophhifhihrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheplhdrshdrrhesfigvsgdr
    uggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:i2CaZ8W6Cq0h4ai-U_FGN2IfPDHZaTN69m0pF9s7a_D17nCsyfPrPw>
    <xmx:i2CaZzlIPpFCHq5NZoIhXzi7TxdgvkPuSeFBwjXFG7EAh7yexWf-iQ>
    <xmx:i2CaZ5eS2k_AFnfcQizrVm5leVJ54Mf0_755U76etsqYzc55Dl3H0A>
    <xmx:i2CaZ9GllecHzs2ZOXG_Vx51fM95jyDMohCcIsQGJ6xbafjl0dbNqA>
    <xmx:jGCaZ17oNGY8t9ssy5mZ-Ar1YGMMcfnmxQgL_KdBAiyuqf-E5kmB2LF7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 12:08:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Olga Pilipenco <olga.pilipenco@shopify.com>,  Olga Pilipenco via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] worktree: detect from secondary worktree if main
 worktree is bare
In-Reply-To: <CAPig+cSdbjzTmsBOmFnMxzYLGrUzY46=mkW9S+si2KxLhS623Q@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 29 Jan 2025 08:41:54 -0500")
References: <pull.1829.git.1731653548549.gitgitgadget@gmail.com>
	<pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
	<CAPig+cRpKKpVHT8x6nOx1KNjWR=hywz-nHZga9fhiXMXD7KOSw@mail.gmail.com>
	<116C27A8-EF7B-42E1-9606-815FDA3CF94C@shopify.com>
	<CAPig+cSdbjzTmsBOmFnMxzYLGrUzY46=mkW9S+si2KxLhS623Q@mail.gmail.com>
Date: Wed, 29 Jan 2025 09:08:26 -0800
Message-ID: <xmqq7c6dk0ol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Wow, your explanation is so much better than mine.Thank you for
>> “translating" it for the world :) I’m still trying to get used to
>> the terminology used in this codebase.  I’ll steal your description
>> for sure (if you don’t mind).
>
> You are more than welcome to use the proposed commit message rewrite.
>
> (If you want to acknowledge assistance rendered, a Helped-by: trailer,
> preceding your Signed-off-by:, is the way to do so. Or not. It's up to
> you.)
> ...

> Agreed about the is-bare checks -- and indeed the entire Git startup
> sequence -- being difficult to digest, however...
> ...

Thanks for an easy-to-read review (and thanks OP for working on it,
of course).

