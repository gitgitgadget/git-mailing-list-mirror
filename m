Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E915CD7A
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467534; cv=none; b=G9StzS2++bW+0U4ynaPHChsKdDJNuCahub9qJBN4YBAaV56tRXc0tkMpXIFMO7l4tlpSxaYsxi84fY7UHcfbYpszk+7CM6yYi/9Meh1m00pWtnoDraM7Ed0KSdC6nPm018Uvd2UB/F0uEUCbEHx6HVL1H6ECA7L6PQTHV32Wisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467534; c=relaxed/simple;
	bh=Ik+eFreaiD9I9gg6Dcwm+msNtH18Lb/7bpzxES8ZwrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TF5E3lrjzxJydGlTgftCcgqjZelkHTXeRIV6tKtksoBNiy6L2fUjq+guJegIN2DTgLRrUzZkEqJxWSAmmAcxnNHV9Ds53fiq+koMSR9/pz2PqnnHB7GN+pSbtIe0NCcMR+KyJ6rWoVoGYEJj2Hj9ukDgEFFw+7ZvaaQfVTvue8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VrgwTvgq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoXqrn5E; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VrgwTvgq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoXqrn5E"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4202114010A;
	Fri, 27 Sep 2024 16:05:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 27 Sep 2024 16:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727467530; x=1727553930; bh=g5YMEHGlmZ
	uM7kaiexwZAGnGl+ME9A0LymV1YW2AOnk=; b=VrgwTvgqNVvLuDl4QODXY8n/Po
	33b6oeID4pkAi9FOn4LnxXZpekj5Z1ADhb/JQ4qhyest46BwRoPqbhMlpmsr+uCb
	QF5+reyIIloS0mfu83ku7oiLtwl8LFr6eRjR7Bn0IwRW1jR/NNWANa72sIvA+KHK
	oZWCql3yX+/Rik+ciz9UL0LRMIq/B+hkuHF33pHrx3ckbV3vvTS7WdqjEVj/94d2
	PPTMCEY7ufSwQF7eOOBosxSym3xETDr5JMSsFXxe5HkYe1BBs1u2BpOm+AgNHovn
	3DZvfBBZzoJddvByUSa70ou8Ia1kiSMp3nxavBw2ZitsqL8kNZobmKH4owvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727467530; x=1727553930; bh=g5YMEHGlmZuM7kaiexwZAGnGl+ME
	9A0LymV1YW2AOnk=; b=HoXqrn5EUWj5NCzcN6sjGQF5dZZtu/E7q8gKSk9d6EEI
	1mUNMWGiPHAxibmD3pdUch0aOZKasTgkxaXxVVvfnxCISwuY9pikfhij5sVkqJTc
	bOSJIlJFjba3l6RlxA2kIJyb7jl127FI9a3eBkJ8yy6Oq/99I39ImvYVwyZCdd+c
	KuxRREYmNMIEB/ZXszPuxYIkh7v5qMF51DHach6fexKxZ9R4IiYX+wF6PCqlcWxn
	3Yok2ONKq1gevEYd1LqW1itfDB1qHYuyvSWAozVT94D/ofXlHeaEdAOJOl1s16Ag
	xeHAR3n4yPjNgeCNzQgfeSgJwq0gcHYVHbj9yZKiKA==
X-ME-Sender: <xms:ChD3ZncXhaSs32FHkFuxLD6FuRNkEvKyk7VIJYjCf9Pk6LagtbYQCQ>
    <xme:ChD3ZtMDaruUgg-Ecyzw999m6JTKKswF58bgK62WS6h8yLchBTTcg7PtsD7AUA_8O
    FlOFsvTAelSVgrnBg>
X-ME-Received: <xmr:ChD3ZgiLd4NTbvbpq1BTUBn7yrmJR0ZYG7H2abkEdhi36nYUhZVPpvMNNc4t2mPLmpUb7Wj-j0kHS3GDU4BKM622F7XWO6u6kUQV-lc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehtohhonhesihho
    thgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ChD3Zo_OEsG1Vf8YJMcAFefGXPgcnUUJh9sJhw6XoW_HwF4VNlXfQw>
    <xmx:ChD3ZjsxrsQVmJP8mS2P9o46pqow4CxWRxdjG6wCRK6v9S15ap-CUg>
    <xmx:ChD3ZnGUsEvd_9sW78kOzlq_w6ctaBv8_SguXPvHKzYgWAnrSZBJuw>
    <xmx:ChD3ZqNLViiuW_8LFu8EbU0K_rhwAoCxX4KAUAnfsogDBSJ5fPs4Tg>
    <xmx:ChD3ZtKLmkyJZqv_Oi1MfpMPOEz81co14mkAm6BjZBHQEITqdy8zuWBT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 16:05:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH] builtin/clone: teach git-clone(1) the --ref= argument
In-Reply-To: <ZvcHpd26te8TPacz@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 27 Sep 2024 19:29:41 +0000")
References: <20240927085438.1010431-1-toon@iotcl.com>
	<xmqqikuggaz5.fsf@gitster.g>
	<ZvcHpd26te8TPacz@tapette.crustytoothpaste.net>
Date: Fri, 27 Sep 2024 13:05:28 -0700
Message-ID: <xmqq8qvcg8vr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I can't speak for what Toon intended here, but GitHub uses some
> references under `refs/pull` that are used for tracking pull requests.

Ah, that is an excellent example that can be used to strengthen the
motivation part of this commit.

    A user may want to clone only "refs/pull/$n/head" to take a
    peek, but unlike refs/heads/ and refs/tags/, for which the
    "--branch" option can be used, there is no good simple way to do
    so with "git clone".

would make a good intro paragraph for a proposed log message.

> So I think this is a generally useful feature, although I agree
> that perhaps the commit message might explain the benefits in a
> more concrete way for those who don't already understand the
> utility of the feature (such as our illustrious maintainer).

Yes, not seeing refs/pull/ without being told was slight lack of
imagination on my part, but it is a good idea to spell out the
motivation in concrete terms when we can.

Thanks.
