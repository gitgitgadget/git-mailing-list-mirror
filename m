Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C03B9D97
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323030; cv=none; b=k8ntXBiQUQHohBRgFBvO455PfXICV22ogrs20EEr1E/Za6a/X3wO8O+xwJYQd6Vk5uFXunqpp4ngKbHallBkSwtO2EAiVmkLHAzNhK7/oAQDnx13/oHkBLzOxoJk1tqHv2Kg8myVOLeSotNu/dQxfhMoHHwaOxN5emwEG7oXbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323030; c=relaxed/simple;
	bh=4S0a9QYpDImDCsALJFSrgKcobIuht+a2oFyDK9VCkcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c9v0Iu64+fcIwQYOHbObg+w/B5P11qxHgKue25OWYC+0fhENZUoS/UcLnFC8HPeL+sNEJyViQMba09rD9MI4JAQcDxBiUvSWY2I47pTeSGPXeQ5MQPRV1H47qdcHLRe8uK61Iy62kpPFCrAsF72+BkIQK9JoiEat+/gEHaaQdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UqAePy5W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V5MkTRy+; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UqAePy5W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V5MkTRy+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D82247A00E6;
	Thu, 12 Mar 2026 09:43:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 09:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773323027; x=1773409427; bh=sTB3jKzkLm
	zrbVC6PU/QmmCJ2n8yOic8RoYFUiaeRLg=; b=UqAePy5W8/f4nZj6B05XAZwW9L
	JOJBQaGtAPc/fN6ikD9g+KQZSsiV8ZnXfZfzMXag6BZxBXQsd34cTSgOhqsIc/yW
	zxtXoh+LV09dvURTfOYuFrBTiATPGIT0dgqUtX65MCE0hCl13JFLdjpOhi1Z+q0Z
	KhjQy+ayxhnBL8T9QB1RFTKeM1HIU/G+aFTMVXEo0sSt+zdH9GEaMIPl/pYoaggV
	KgoOGcehQMi2weSul3kGcTzZU3E4C0iG85vkon3+OZkgcaLNuu3A+oRlE2rZgBOr
	ee0Npqk0wU731taliSUMwQgTCGNQPPOK8SWpUYpGKOaTRiRFgv26G3GwE6cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773323027; x=1773409427; bh=sTB3jKzkLmzrbVC6PU/QmmCJ2n8yOic8RoY
	FUiaeRLg=; b=V5MkTRy+u9mvY/FH6kdb2cw30yGRo05trOH8po/rbICF3g4ddtR
	SDZc9Ln8zUTYE+5HGXvZ0IOyCvxrIhI+FF+GuK29cCTKAg187sCi8EgCAohDFziI
	BL+QdvQoxKElhWHNzCiKxvZiHzpmAVvfsdUeWN3d5zpa3U64h4NG6PbzOoPPD/wO
	8Yl4IHuH8oUbs+GOOoJJUnNN0wixcFwcvCIwzO/IEANoREspRJZMiVuFb+xqIrvv
	6z3/n7KTJYhgGBd6jM1c2dwi9e4AQToYE5hyVvCpn/9NDq8jxC3r3TDJ0QxNTZ0O
	rRLCgu/NllDZNX6xMUZmcUhdQu/b4VaVPZA==
X-ME-Sender: <xms:E8OyaXl_Hun_b7BEx-XoQG88adsiVMKg3YAAjVRbfJ93Pv-Tbw_8vQ>
    <xme:E8Oyaeg9gBGMM2Jk4a2OH_XbFeqxDGsxjRq0ido-CN2jccaB-vCB7n5havECWmzsz
    WXz-xRya8Rc6S_nYriftKFnHrwcKOyqkjk0YZQDnWEVZwsdW0Opew>
X-ME-Received: <xmr:E8OyaXcm3DV6Od1WqFFGhsvWM8a68inlkq-Z21spu7qWIkGeT55k49x01-PW-5iqgS5rdH0ioMFxZbgYXCAY4vJIzZTQcd6_lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeileefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:E8OyaWi67ETZQ3eCDrxc1q4u312x0uldY3BbqhfuJPeA80aEXTe2Jg>
    <xmx:E8OyaXydmnbBHGRkUScMXOfi5yDSomIxdw4FSbP2ZShUbSxyT2fafg>
    <xmx:E8OyaaOU0q4_V4lHc-KWFI-OtVkmohlcrI1PNHz6Zoo_scL2aPoaqA>
    <xmx:E8OyaQUygA-wQDwm7OoLLjsFF8S0DVo1uZCKRNAYC2cT7eOv8OAk6Q>
    <xmx:E8OyaSvJFFn99BJA4iE3-vT-Uotow447bVMuVWpmE4wP2j9E7ywU0pRq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 09:43:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] t: allow use of "sed -E"
In-Reply-To: <abKG1U3fVuNV1w_9@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 12 Mar 2026 09:26:45 +0000")
References: <xmqq5x72m4lu.fsf@gitster.g> <xmqq3425lvtq.fsf@gitster.g>
	<abKG1U3fVuNV1w_9@fruit.crustytoothpaste.net>
Date: Thu, 12 Mar 2026 06:43:45 -0700
Message-ID: <xmqqtsuli2ni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Yes, I think if nobody has complained about it in three years, we should
> be fine.

This actually started when I noticed a recent rewrite of a test that
turned "grep -E ... | sed -e ..." into "sed -E -e ..." was flagged
by the test-lint.

It is not a huge deal to rewrite the resulting sed script again to
use BRE instead of ERE and it may not be a bad idea doing so anyway
(and rewrite the existing t6030).  That can be done independently.


