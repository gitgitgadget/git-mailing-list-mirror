Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B53D6F
	for <git@vger.kernel.org>; Mon, 12 May 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054333; cv=none; b=gBWyXRtev96RpdmfFg9sKTlvCgy3ntQjFZ6IO2tjWTFvm6p9svLgc42JHt85iIhBDEhSzhTvmIUFF6G/1pbpB4y6wGvTHxIOXE8Sofq5YvuP5aIwKQaq3cQhcdFOuPamspT4VioAoWHr43Tpf1URBv0Mn41zrvAtRlndjMeEAZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054333; c=relaxed/simple;
	bh=/Ga+SyHCp5cmPTPTy66QBiuFivHwmFp5rdpg3ZVkxeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VbTHsWEG480WxDWGAH5Hi5eW+jKV1JLQ0zdwDoOZcFFD/M/Sssb7QMm7XKhSQIIH6SaEi+WvZ9X1UDf5aApJYAb20xwJYWBhfc8A90+wHTbvRn8Pmr6Uj+FC1nc68u1TrG7aZsvc2Jvuz2rltjGRKqFbmGwig8TMjN1S5MUj490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZeKiho2H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UHdlFKEX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZeKiho2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UHdlFKEX"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04F8825400E8;
	Mon, 12 May 2025 08:52:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 12 May 2025 08:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747054329; x=1747140729; bh=/Ga+SyHCp5
	cmPTPTy66QBiuFivHwmFp5rdpg3ZVkxeg=; b=ZeKiho2HcHxviCJEGbRfwqDS68
	6e6z1dRc5iGn8EE3uAigcxX2DUzIZRjrk2lIIXi8UBo+t//6FMiB+JhDNpovEF2u
	5wahHWyoOX02hFgu4z+EnNSac3tWR4bwLJcExVKrK+c2WsHgvGhUAIZAs++u/mmO
	WM3uq18V7oeVvfcH4LXotJWI7kGebPxshJ6xDZI1b5MAwkSRcX6ubxB7BN7x3wuT
	zNFsi1neIN2hvqTg3tq5KZz3gZ1LjzQPUgfZOwg2E01y7sKKnWTcgDRAtjBN0hkD
	u6df0F5zb+boM03L1xB6zUl6jbaQ6/5Rp2SmbEdetwwry1HXmpXAmeTBbz/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747054329; x=1747140729; bh=/Ga+SyHCp5cmPTPTy66QBiuFivHwmFp5rdp
	g3ZVkxeg=; b=UHdlFKEXDabavSnGoiHEVyvsYIR8YREeKCo6nyw89G9gRkupnWz
	7hWvTZ6BTnb9iExqvu3xEEjYGXi2T0sMav1d6X7psbFyKvp+HDRuHLGhC9KfUpy4
	GXwTEx260MqEYaPEv6UpDK7wFMXEv5qu0h2/ZElYMvCSCQpb8zgPfT0TDJbNdHnh
	J2Y4gX1GUjA0nG9h0lypVTbmArh/MznTAAauq4Dyb4FQCvc/CBG+q5qwx6h0z6XV
	EOxNaGZHrOHQ0soNgFyHaAAO27eLsFR490Qo5/SMJK7yT2+Cn6xxK6ezcEiJNyCn
	jCpvaSgjpcQiX8rXMKws15bEkJWh/aaYOnQ==
X-ME-Sender: <xms:-e4haFRcmvL24twGwbyIRPYhc1imFnhLwVxgZ9mnlknExm1Sd3c-Rw>
    <xme:-e4haOzjEjjm2stJ9A1RmqngxGxwIk7rETbTsdNOAqaIoqmaDsEloKjYmVZfoelne
    _nK-26W4mDegWBM_A>
X-ME-Received: <xmr:-e4haK1rwZXyJdwxTpG2Jncibm2Uit86XUzSDNiD4SIi3JIYlfh7ZJcay0BeAYHWWv4gb90ud3STc9rM4b9QTNe7dMDzIhWWPWqxUCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddufedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    eikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-e4haNCydxiT9NT19E-Vko0xcJcLoM4WD3Pu0StVuBb9vfhZT9y8JQ>
    <xmx:-e4haOjGoWniFJIK3yZ6dCEplTjtH6GMOKIXruqI_OzA5ATp9sfdZg>
    <xmx:-e4haBq9XGH-0_doHwejE96UrCF4OQtRrE_y6H6TzIRuW_GH921WYw>
    <xmx:-e4haJhx9xjzz_UAMVG-zVR_z2cFoR_oAY2mQNCKvK4rbp44n2oxbw>
    <xmx:-e4haKfufcVtr8qGPs9O_bNWESI5uX6llvHOGFatGqspgr0yX-U8JM3i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 08:52:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] make stash apply with --index by default
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Sat, 10 May 2025 14:33:35 -0400")
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
Date: Mon, 12 May 2025 05:52:08 -0700
Message-ID: <xmqqzffivvnr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> Since git-stash's inception, it has defaulted to stashing the index but not
> restoring it. This has caused some confusion: change the default as part of Git
> 3.0 to unstash the index, too.

I am very tempted to veto this, as I very much recall trying to see
how I liked it and used in my workflow (by using an alias to do the
"pop" always used with "--index"), got quite frustrated seeing that
a lot of times the command would have worked perfectly well if the
"--index" option weren't given, and gave up after a few weeks even
though I tried very hard to like it as the default.

As "--index" is a Boolean option, I can see that we probably already
have "--no-index" for free, so there is an escape hatch already, but
I do not think it would give a good end-user experience to force
them to keep saying "--no-index" (that is 3 keystrokes longer than
what those who want "--index" need to type).
