Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C42DF130
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412332; cv=none; b=YgnDCBzbgalcCZUZfqqb87w32F3yZZ10R471CkG40y4zAZdkzHdiIioCbImrcinO24li2+5kaYJyjE8KECYgmcZklZhlKIp+BSIgHYq9NJGhvox0rhbp0Q/w/aG9gLTgOfYHzmX8BmhHQMTXcF55GPz+KklSha0Ij3yC2nCibgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412332; c=relaxed/simple;
	bh=K4mpcinSJAaRbLpR/bNeED6YTFhXwCRXfJRaKsQaUxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oKDstc7HDSDGtJ7t+trsxzWAtELNHYBSS9BygfecK8G+GiddEcbTeAY5bh+Y1zlQG90cG4vymR/pLZAhMYq7hYRjirGZwb8sBukKDHJtyvRleK/EZPO1gvxbdv7hyfsTH5zpL6RjO/mT/lE5Ux53qqYYzOV362EtFkEURHdYMz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eb50q0M5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=miGbNfS+; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eb50q0M5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="miGbNfS+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C7577A01DB;
	Wed, 14 Jan 2026 12:38:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 14 Jan 2026 12:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768412330; x=1768498730; bh=K4mpcinSJA
	aRbLpR/bNeED6YTFhXwCRXfJRaKsQaUxw=; b=eb50q0M5whmfED4rEB+XvZG0c5
	M2YwwOhok1xJ+2mPnj8QiD2GgO/0Xogf1Uwh7W9dToFPwjXzRkth6hwHFhCZ80xQ
	GGFe9tw8cQbMR6TK1qLPcsKRQksZkEXQU5sjcszG1dYTBXt0jfGP237aeQfpsyBe
	Wv9fowHgZ3Fqe7gmmVMWDp0n/iYozVM75SQaZVFVeSClhIBVcmWdpJ7ztWupgzBe
	G0OmhJV1Mvs16bUG4Hhc3iPqH7wmLN9iic4PARN6DFqka73TnCh86p7GT24RONNC
	2YaVSNUbrd4PwkYZbXzJz/JTvGo0GoR1i/uCgO1bT1lLrq0z+hJ0uR0vUr4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768412330; x=1768498730; bh=K4mpcinSJAaRbLpR/bNeED6YTFhXwCRXfJR
	aKsQaUxw=; b=miGbNfS+FJE/OpbLZAkchedZ9ZUzYBCV5M/8vhQJ80VxoKROWL6
	jh8mOyY5K4R6ivUjFCVQi1gkhUgmAuIXBY1ZG760z4RwkHZnQ92MUaOIjR+Rd8vh
	cAnOVkns9yJv1hkxwoaUae7oxP/5stMyfyAIuVxhJhhh8+tv2Kvdkqj4TKQ8SaOA
	5YrNszbDIoHNAcjbPrQCP3MnVOrDaerTLQ6gtjPMHbHjP+yg5Gj+mUPeJU9GtOwO
	H4QOrzR/zNY4kcParJQg4cN3yXHOmOceRvGRhUArIX6Bjp8pb+mCVv83eDDRVuZe
	l5WtTlo7J9yaFASDHbUxZYDpNez+26RxT/Q==
X-ME-Sender: <xms:qtRnaWXj1jxFtA0b0xeOT1sZsoY_0UWUUsKh3kWYR9JNgwstJmiM3A>
    <xme:qtRnaZlQFpLabo78eTusTngMXpPAnWjc6ax_C6piRyChwvSlGF3CS49frOZ8vVkbG
    tOPpJ8ENR4vlhDDCaGsNI7RkEON1eY9334V6HieXxqFHiKTBc69_Q>
X-ME-Received: <xmr:qtRnafbU36gu6Y_9Y11mnnK0Y-0qBk4fFYXDzU5Tq6P5Qgpx2QZb_-6mxcpH9oJbm_fGasWyVilZNGMQHQr9nVm0_Ak1ihIdeXViddI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehrrghjihhvrdhtihhlrghkrhgrjhdrshhhrghrmhgrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qtRnacO-ioAc64VvYR-8zS5fhqkGxdQe6MPDoRaPDug8-QS07cEgLQ>
    <xmx:qtRnacagewXK5vKrycPFJK3YD2bPUuBpsNi3JOQLwPywrQ-1KxNAnQ>
    <xmx:qtRnaS2mM6FdCWCX-gQAQqxWNsUBuyM6-Hx2LUWNXPv6wdesHTSgbg>
    <xmx:qtRnaadCscnvzYQ0KWMNWz59PhYmq0lAO4w8Y86Gs1FpB52AyVB1xQ>
    <xmx:qtRnaa6KDM-MiEEf6xEukD3LTW-D7X0zI_N4yItgyHSGEqLFHSAyclCr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 12:38:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Rajiv Sharma <rajiv.tilakraj.sharma@gmail.com>,  git@vger.kernel.org
Subject: Re: [BUG] Git push sends too much data unnecessarily
In-Reply-To: <CAOLa=ZT4fQdHqG+1AeviYuLUR5VG33voJk_DU1y0MzhUKBQvvw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 14 Jan 2026 17:27:21 +0100")
References: <CAGe2LO0nxXuNNRYS0fk0JuPBDa3UCT8EDJ6G1u4GNW1d9rzRgA@mail.gmail.com>
	<CAOLa=ZT4fQdHqG+1AeviYuLUR5VG33voJk_DU1y0MzhUKBQvvw@mail.gmail.com>
Date: Wed, 14 Jan 2026 09:38:49 -0800
Message-ID: <xmqqh5sof61i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> So it sends all objects required to create the reference, in our case 4
> objects, in your case GBs of data.

"push.negotiate"?
