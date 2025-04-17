Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95925333D
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903044; cv=none; b=d/z6zflvzwBA7/sM0HRt+GKDoPufLYGrnupguCfYUiNL5pGxARmMOes5xEjQ8DyUSDcnReeAp8w4DgBjtf6OvaCfQkReDyuS23oIqFm9fEM7DsoBLMcESAcXA6kHSzZeklMZMxmgUMS2SFhtgOfaNgeWzHtBu6H0o3NrzxaWKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903044; c=relaxed/simple;
	bh=a2Px+/yflfNgGk3/5OJ7taNyZqCUhKi0hDkQM3+Y0T8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z1l1c8atsmVt61faA0vNPS0kSeeW5Ima5t1dUJQAE5soCB9GZ1C/iJAIWonpBI4sLkqqO0nUAcGxEaLXZXRNsyE0k6X1j8hlR2mpEb1HB3IwRBmDrjcaFp7mLMerN24vlHSy0v8+YLAui3mxw0lBF9OV8it9RNiokWZz+x/6+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l65AzpoD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A8C9KbaV; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l65AzpoD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8C9KbaV"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C0A125401F1;
	Thu, 17 Apr 2025 11:17:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 17 Apr 2025 11:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744903041; x=1744989441; bh=815I3Qfegz
	NZBg+42FyjUg8z/Rt84hkSflZqiIM99k4=; b=l65AzpoD1hC66Ptfw3eIFe5S77
	SaaR+veXxszik3y4dZmakMyZx/6up+rj9uUbqKogvt9+S0PowBWVhKBuxwyqVhjv
	mdVryu+cZnu3QD/RtjfEUlN0X1zRvzRxJSOkmaAQH3FkuyzQkJEhxM6521zRqHau
	qLGnz0u/9MZ39laTUDkDkdB3F7NOTqdbFZ5gVAnvn0q8cSf/nF8QBhkU4bVrezk3
	Fj2MJkjZldXJ1yFi7adFVjozjE4NMd4CF/f26nBqhc9DfvAbGVEnx1T8vPu0m3ro
	MSDaTcipx6SKgKlK/DaOELFKNYPqBqz9eBNxFosrouSMCeyyOWC41sMTu3YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744903041; x=1744989441; bh=815I3QfegzNZBg+42FyjUg8z/Rt84hkSflZ
	qiIM99k4=; b=A8C9KbaVn6w1e5JTkpgMe3o661+sFWswFnvwTN5Wbu2lZk+DLmK
	sABAZeq9VnHE7SSuZ6tLCnfOYbxVYuFsxx4atg28Ebz8onpYoLCGKU4kTNFxIktn
	giqjyTj/SC2YHyHbzg+KY0ZjhAh2zwmuza2eX/yEq+0jMd4+oUpBhKj+Nt29UjgJ
	JmtgcqQrkR1jn2AJ51h758DihggEl9uTKAIsDJhqAXKFlslVf45P/9lFsk4uThcp
	pgwyaesP7gPYEXLsU1+bZnRaHl9W71wVpSAkjGt40Uj+mp0mpCXkRQ/JxaQkSWim
	eU9jfrc5T+4PQrrj526k/m6i33fUoXhIClA==
X-ME-Sender: <xms:gBsBaJ6L_Q-ZGTTITs8W0cE5mWuLAuO_nipj08Jp6kpbpumDeico-g>
    <xme:gBsBaG6CApyPtP7f5AUYsVqh0O6xg1VVKpV00Nz-kudI-jvdsrWJpps3WCWxK2Ue4
    Lxl91s_YUnnkrTupw>
X-ME-Received: <xmr:gBsBaAe1CEeAnZqROmSCGQZABku8tJaY8NauF2hvZLPNhH_KhZZ6FLXo6ymLaq9Ie1RjFQ65RCGdmLIuTlXnizdDs21azPUx7mCz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeliedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtph
    htthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdr
    uggvpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:gBsBaCLKsErBSocLBWKXkd2rIPozE02xDOuxTTa4IKwLgxEaQ7TWCw>
    <xmx:gBsBaNJgfLLCHJyUdgxLRKszYDj6Qjy7P9Fki2_Zwl5mj5ta3A90jw>
    <xmx:gBsBaLyBcJxbWTC1sxucnjTYvo9IZRG3wfgN9PKMcRNOJ8FFI562-w>
    <xmx:gBsBaJK2Y8SksKZEDl_c-hFGgMQaVIR1UbGsUUe5TGEPkHsH_Yx-og>
    <xmx:gRsBaIY-eJyA8V-Kw-XRCBPYNdxlkIoq_8mYbBtVP9jXlp3rxmOrcxSL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 11:17:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Todd Zullinger <tmz@pobox.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Derrick
 Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/7] parse-options: rename `OPT_MAGNITUDE()` to
 `OPT_UNSIGNED()`
In-Reply-To: <20250417-b4-pks-parse-options-integers-v4-4-9cbc76b61cfe@pks.im>
	(Patrick Steinhardt's message of "Thu, 17 Apr 2025 12:49:39 +0200")
References: <20250417-b4-pks-parse-options-integers-v4-0-9cbc76b61cfe@pks.im>
	<20250417-b4-pks-parse-options-integers-v4-4-9cbc76b61cfe@pks.im>
Date: Thu, 17 Apr 2025 08:17:18 -0700
Message-ID: <xmqqv7r2es1t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> With the preceding commit, `OPT_INTEGER()` has learned to support unit
> factors. Consequently, the major differencen between `OPT_INTEGER()` and
> `OPT_MAGNITUDE()` isn't the support of unit factors anymore, as both of
> them do support them now. Instead, the difference is that one handles
> signed and the other handles unsigned integers.
>
> Adapt the name of `OPT_MAGNITUDE()` accordingly by renaming it to
> `OPT_UNSIGNED()`.

Very good move.  It would have been very confusing if a new
developer had to choose between INTEGER and MAGNITUDE, and this
change nicely removes that "Huh?" factor.

Thanks.
