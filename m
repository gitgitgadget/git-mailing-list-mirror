Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCE303A01
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626772; cv=none; b=VhCuLvjT/W0mDhveXx1+eTfzi8eIKmCI5rYxAuwDz1AMW0t4H5BgK8296BroZANMPAYgLAjiMmjDs15e1cYQmA7mUlodLMIjLLwwDuogFw/JWkbOPSpQk2txg7F8wtnhNLy8HY63uG8RbtxzCLYef45ddXXY0xSccVI3NWI9uRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626772; c=relaxed/simple;
	bh=S6TkXIQ5xSLt7dhvnI5+Huv0mps0hW1U1RbsHIbSMG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nYbQKcGC3WB4MQBxw5WzA9t7KPlwrUpVFggGs7ujYDORWKqtfg9AwcGBsw11AbE2cxCY5BfdZ4wx6QT4ZGg/ZciIed8Z2KpV0ZMZbrC1456ghH/Yl2Gpe72QMqfMAo6jRTmiaFzIGOXhj7uWF4k2esv+j+K6L97Ilfkn9BotRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0dH90VDs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Chnf4MW7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0dH90VDs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Chnf4MW7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 41DEF1D001C6;
	Fri, 20 Feb 2026 17:32:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 17:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771626770; x=1771713170; bh=piNXSVL9KS
	izXwKsn5/bNQiurcG6MtaNVes28B2r5kc=; b=0dH90VDsxNV04VyI+aG7qTWxxo
	eF01/mmGmCqFrRP0b+sxAm/4NnGNbZmL74j6oi4G/Fpg1M5pUzFwTlq5bjXGsqlO
	FhGc9+egLf/RHZcrCmEQ8A6ajl3Y4biK8TeLL6LQKwjSnbXb7zYCRqhRqiD6nx4/
	OtK6h6jDklOMgHsTtx0Uw0lR5KgJdn8jjNpZiz6yeT3Hzj1XNbKyfOW5eAcMQ6pE
	P0MyHGITa0Hl36vA9RQBpaGmhUsPXWkjSweQEH9jrLq1K/3hOm8PT4EVlhVuG7YX
	Ob4OaRWOMStKB18g1cBdkUubbwIpLrbMvEoNR0jUvsNtze4jAvE5zLJ9aotA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771626770; x=1771713170; bh=piNXSVL9KSizXwKsn5/bNQiurcG6MtaNVes
	28B2r5kc=; b=Chnf4MW74GtVjfTsexR++MkzzDQNjG/8KE1g8aPNrtioZ4M8sGP
	NWZj1WNMUbAH4efH72ymdxJk6o9Rgex2MdjsnFGZdmDMvxc7ExEdUuG3pj3vEhCF
	lNqS6ffli8INDhVl2izdpkf5rBShK18okhLEH8Gnn1dgGPAbJ7fdPVOQ1eLcg9U1
	Tzuild0vqYKhlqKGp0XLNb02hO6n0Rktq+4g7e+inK8X4dBbnamiMc5AklyTuKzf
	UCXup7wMOgEErTVm6ezpXwPH0V0lvuousW5iRaXtXl4sjqmQeavt8dLtdjVM/EfU
	fstArZ0Guu7VI6IzX/53+nZ6N4Birz3RftA==
X-ME-Sender: <xms:EuGYadqcp2J7P1zRui73MG585mTRlm8y6IWPlZ813DqBw7g8KOUCvQ>
    <xme:EuGYabcPc_q8RBU1nJrAny75GqDVVEmbQBbGTyUT3P5LWEpCIRmotDXjIhx6Y9J5Q
    dLvFhHm7AxWvTjwxlZk7fyqTaoddB-Blf52lPOt7WNcGRW1hw9zXQ>
X-ME-Received: <xmr:EuGYaVlUIfoSf7t4bT9ulPxEFRxUEAVEFmvrthD5Upp3S10isiYX282_qg3YpNvto6_z1UTjFoWe6_F7xxpiLVc18xX2USuGTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdelieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EuGYaSYds5Sb2BCF9B8v-x7Cf2fKRngtRgr5i30iRA3bBGFWmneeVQ>
    <xmx:EuGYaa4jBlamLn1Z2ybzcPiZVZYPRnJcmwiaE3OUyu3sTKryw1KUrA>
    <xmx:EuGYacBWEhhYxb0oKY70y4VBNAqWbaCwcKYfk491XlUSeDBLJ2G5HQ>
    <xmx:EuGYaY99WPyhw-wMDLjEKkQ1JBocSwiSSvlyuMD4w_wY_lnnzAwFFA>
    <xmx:EuGYafY-6VPg5N-7yS7nX2CeXlCfIxkMmHmKS1nJCVo8IgwzzAlDC0tJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 17:32:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>,  Lucas Seiki Oshiro
 <lucasseikioshiro@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v5 0/4] introduce new option `--auto-advance`
In-Reply-To: <cover.1771066252.git.abrahamadekunle50@gmail.com> (Abraham
	Samuel Adekunle's message of "Sat, 14 Feb 2026 12:01:28 +0100")
References: <cover.1771066252.git.abrahamadekunle50@gmail.com>
Date: Fri, 20 Feb 2026 14:32:48 -0800
Message-ID: <xmqqwm07uju7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> After after more reviews and deliberations, I have been able to
> rename the new option name to `--auto-advance`, where the
> --no-auto-advance implements the feature and does not auto advance
> while --auto-advance is the default and maintains the current
> behaviour.

Haven't seen any reviews on this latest round, and I think what we
have here may be good enough.  Shall we merge it down to 'next'?
Any comments?

Thanks.
