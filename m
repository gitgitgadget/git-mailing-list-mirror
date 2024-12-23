Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E02B9A5
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734926916; cv=none; b=VpeQmXN9i5vNlA4M5Os/F2O2M/Yil2fG4IOqX5eLoR8woK1MXZO3Xib3aRqVlb2qZEyG/v4Dse2unsgW42FPL/JU69gRqznvbROhNlWoR+C08U9i/OEasybO20ICwQXhuob8KkSvdiWEX9xJyOixtIYKcQnjctrIXkPMwb+r+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734926916; c=relaxed/simple;
	bh=ZC/7/BzpDkRDhfKO8dI4TyDDWWnI/9hvf/D2CuT0qvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fhCqs0tHKFfSYMBJkUaZvN6b/dg7cgZUcQOejpurlLjGkZeAukFoOPuge7+0JCdHCkN7xP1UPpqlGkxFT/AAl1M577MQmpU23dYnZpUfpihKyJEaDzTWJLhvANK3WxGVEBfPWS8sBkl1IpQWpZbhpFTd97MN2AOYskC2ImEWcEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BtUCzTRI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IfrlP7Kt; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BtUCzTRI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IfrlP7Kt"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04CC82540108;
	Sun, 22 Dec 2024 23:08:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 22 Dec 2024 23:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734926912; x=1735013312; bh=Ah0nCtdD7s
	Rr/Qcx3v8VaooNlAUiObnhiDkqFxK3504=; b=BtUCzTRIXFIbNxytdyJaojJpEk
	LdjeqksyAq5y8EzUzUvT6HM66Nk4T4hhw2R3K/QlZAY5aJh8/O/HR3mmYf0otf+P
	G+UMCTlKgv2ucBTAzENqg7kJCIQIlRjQPEOJX3fEDyH/uGzqePTflmqndbm4Y/d+
	/21QXntdOK3+OoWaBP2t3fgNhAd1pH49JdILpR9rmVyq4FdageLZpwqu+X6tHJDb
	cIMwgJytNPsqyD7RDYgTd925GuygAHJX5SKo1Ku3dvPktKOxgY8FgatuUeF9Skjt
	Tm2Us84WdcF80F8JyTEa3v7ydKLwU+m+NOQ96DkQCaQFw1fWskOOYv6RzOuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734926912; x=1735013312; bh=Ah0nCtdD7sRr/Qcx3v8VaooNlAUiObnhiDk
	qFxK3504=; b=IfrlP7KtNGaksjVvaiE4nymZa/4eFb3g6y5X1dwiR9SJzAkeAfx
	+aNDmCyNQkz1he8U7TGyfaX3fFnI1RU1bzx8cBQ+vuA2PnSIPkznnge54CobYOZB
	4vu7NM86+VBhodoY7Hy317x04PAhQ3nhuQHzlXTRphxIuDZlGbN5QO7xrAd2vqi7
	MtCrXF+4ZY5KgM4iHIx0SfB+EcBgMVvkf2Z2340T8XA0XiDJr8utaUoyRV+O+M7q
	emM/R8h1rkeLg1mTWQ66vAvUWwKayBc76G9PEyPX7WnORaU4d9pJx+Na3DVklp6x
	VL0wMIonLeDkwegtmu6qr0ZTk6z2lz0GRnQ==
X-ME-Sender: <xms:QOJoZ9bG9u2F7PdZTEoyahSFHb49cmtLLNVK2jV1bgPp2KD3IVJYBA>
    <xme:QOJoZ0YJ9TGs6XlRdxlNwkSga8GgzAZinFpi4djehf0UhHR5Q2UfJ4gjH1MJvs9eB
    0XhpcIRXytJo2XKpg>
X-ME-Received: <xmr:QOJoZ_8ukqPXzxdXUc0zYYgVUn5Bdf7rcdryN0v7jYUz4A3nFegu-Lr-I3BHIltq7lvaa2Jb-BeXy2KPngybLk5L2WmLp_wedA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrnhgurg
    hllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QOJoZ7qIbrUjlNm5tz4wMXtaRdqVM0fPjwIwB2LRSvn-Ti9eAdLH8A>
    <xmx:QOJoZ4oXoyLZlQg1pT2e0stwKBJM5NUPdnmoKw4KrarIbBZsGrEoIg>
    <xmx:QOJoZxSetSZspdPTgbeJrzw3ikM7ik4m3Wbea0Z8rUGG69JfU-ozbg>
    <xmx:QOJoZwrYZyxwdgmthnENStXjoymXeNMff_Qk4Xys975qScEkF7MOsA>
    <xmx:QOJoZ9C8hhsUTCN3dhvIjYFyWgpEIwD8hoXXVetrpMOqzCq-RxBmdo7U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 23:08:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: rsbecker@nexbridge.com,  git@vger.kernel.org,  "'Randall S. Becker'"
 <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 3/4] reftable/stack: fix zero-sized allocation when
 there are no readers
In-Reply-To: <Z2hb2CenfZ7bJ7Zj@pks.im> (Patrick Steinhardt's message of "Sun,
	22 Dec 2024 19:35:04 +0100")
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
	<20241221-b4-pks-reftable-oom-fix-without-readers-v1-3-12db83a3267c@pks.im>
	<xmqq34ihc4zt.fsf@gitster.g> <xmqqmsgoc42a.fsf@gitster.g>
	<01b201db53d3$0b5953d0$220bfb70$@nexbridge.com>
	<xmqqikrcc2i6.fsf@gitster.g>
	<028801db549d$bde37240$39aa56c0$@nexbridge.com>
	<Z2hb2CenfZ7bJ7Zj@pks.im>
Date: Sun, 22 Dec 2024 20:08:30 -0800
Message-ID: <xmqq7c7r2g8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> >FYI: 'seen' looks better now. I am having issues in t0211-trace2-perf.sh
>> with
>> >undefined SSL symbols (SSL_get0_group_name), but am able to use git init
>> again.
>> 
>> 'seen' looks good. Operator error on trace2-perf.sh - used the wrong version
>> of OpenSSL.
>
> Thanks for confirming!

Thanks, all.
