Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F31F428F
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347878; cv=none; b=d97hk+oQKAQe/4rCYE7ImwY5EWgTRZud7El0VzkrWkyD0Rv+MbE4MJugVgNVdTKMTemDCCQcg9vT7FM4rLQQ3+6yngwdr9DX4yY7Td59ayU3mYh2ZB8At0UqOKo9KFFjfqwgnTKyqcMpEQHXtNBiP1hmgNhgqig4cr6H+y+BEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347878; c=relaxed/simple;
	bh=CCFUbv/VuZfUf4r8curXFXEzAOqg3EbY0VdYJVOHnd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dcm8y3siLRD1Nf71XwWMV800r8OZZlOdm6GAE76kGb7cK8hGHuCcSItlAt2OD2vk5N66BaLEqARzyETWJnMj29XaLesz7GhKXDPOiOx3rBLs7Ws8IUShqBTwUKhQQTpODPCTS59N/Vsxl78JN6MOKLaj5xHMamVmniNOfK8Q36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T35FBK4d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hFZ4AQfL; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T35FBK4d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFZ4AQfL"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 715FE1D0007B;
	Wed,  1 Oct 2025 15:44:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 01 Oct 2025 15:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759347874;
	 x=1759434274; bh=yl5AMqb8jHnso8QxihUoh3opPqO5ChccS9IN9/wZzSA=; b=
	T35FBK4dB1F2+GSf18r0FMNWm9a+xqTO1xURBZPI+re+johiXzouhJ5KI8yRrcpI
	XIqJig6keyi7DUpgIMqwBZDHvNEljXou2EP1hpv5EwQ32a8WlAm41K7xe6GFkEBG
	CdfDJlUrUHb3/j2seyofK5VKjOu69LIzKoOpmF2smCb8l8OnOSQ2L62eZ83b/nDL
	RlsYYb+bGOaLmAh97ISvM+aHH/44pCxWCEw2Sp/MdE0Cc/h6J51zNPc6U5k1dQ+c
	dXZ3Hwf2Ww0PubhqZl7mp8IsQO0mx9KgYZjYH+nKN2sZs36DMcKzXb4ZxE2wlcUD
	MW5bALITI06dIueIBYldfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759347874; x=
	1759434274; bh=yl5AMqb8jHnso8QxihUoh3opPqO5ChccS9IN9/wZzSA=; b=h
	FZ4AQfLzhbGIREt+tgyZjFCORt1AXVxn4VB2KLcbAkt8fs4U53bUyXdAerRunue1
	EDjdIE3xKT3LTlrse5OjChVseV2rUzOQEb3sVYEDPR9zbbP6YeuVgkoBlPql5EXy
	UgC2MMnZVZT885tTtMEZI1wLiepAaU30AO9rzIhBPEil2NtbSWMUsVsSGLRzCby6
	aZHoZHL5ljLsdQeQwCVCYCJ0PvP6zHq7GbUwBkQwUTAUiGGact98BBGhKU7ZYsVV
	/9VRqVPBBkRitbMbhiy8pGTXfkEeysOkKSx+Wl0bxikhtwTW1tHftvNYaSSNa8i9
	zc2iTnEp2AJV+j/GmZgYQ==
X-ME-Sender: <xms:oYTdaGCOMdtfF_xjrvXXqmSD-qO_ijJnIoXwjZ2uS9x9QMVW5CUNsw>
    <xme:oYTdaPAcCjoA6_Yra1zWbclp0RXi-uNkFLHfXfLG0Ih5PxSCVswvRoocpIQ373X1O
    gwt7KShcgZCUF1MgHIZII1xe9_lQy-qsq06DIzxiCLkKEOgXwJCrQ>
X-ME-Received: <xmr:oYTdaAYOig-QODH2V27cRY_w-kg7NRoaduYDmAg0YSpSqokcUQSJkJVEepJ2o-TqQMLFxDx1v7qQle9vIYmDrqu86MCvAAkbjDsX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivh
    hishdrmhgvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhllhhinhdr
    fhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvg
    hnthhoohdrohhrgh
X-ME-Proxy: <xmx:oYTdaEyoT5mXP9dTJH5mPl-4DZR0cL6IFMnRTlAMz-qDLW-CuE76Zg>
    <xmx:oYTdaDcuLrZbHM5lzLB_YtP90Vd14r8hZx7HN6sLJV1nZLFH7vb_9g>
    <xmx:oYTdaKKVG5jJEUdzUlmNHwVairV2nrJATMNnXNl0PfL25jZAu8WGHQ>
    <xmx:oYTdaM1HM9gBWiGnmbVLdfclEw-aMCeFxJl-qxotNP5plEae-mIyJQ>
    <xmx:ooTdaFxOgsDuLS0kTe6fFupJLLMDEuwJZ8bQJTt4QprZ9Ulv3LzDx7HP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 15:44:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "Haelwenn
 (lanodan) Monnier" <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,  Sam James
 <sam@gentoo.org>,  Taylor Blau <me@ttaylorr.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 6/9] varint: reimplement as test balloon for Rust
In-Reply-To: <CAH=ZcbC6jMUBMLrmwzksAzLM3t=XH+hBnf+=wLdjAcAiWTx7vw@mail.gmail.com>
	(Ezekiel Newren's message of "Wed, 1 Oct 2025 11:21:25 -0600")
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
	<20250925-b4-pks-rust-breaking-change-v7-6-4e49dcb904d5@pks.im>
	<CAH=ZcbC6jMUBMLrmwzksAzLM3t=XH+hBnf+=wLdjAcAiWTx7vw@mail.gmail.com>
Date: Wed, 01 Oct 2025 12:44:31 -0700
Message-ID: <xmqqo6qq1k68.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Thu, Sep 25, 2025 at 12:30 AM Patrick Steinhardt <ps@pks.im> wrote:
>>  Makefile        |  3 ++
>>  meson.build     |  5 +++-
>>  src/lib.rs      |  1 +
>>  src/meson.build |  1 +
>>  src/varint.rs   | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 101 insertions(+), 1 deletion(-)
>...
>
> Looks good.

Thanks.
