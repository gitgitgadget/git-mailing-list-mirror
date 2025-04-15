Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0260417BBF
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736533; cv=none; b=VS5fHiqYPFSJO2mtT4ytN0d3CqUsTa8gEYHCdkWa29LNmrHA8zcLg8tUSobN3O9kkggBcLENypa5YUK1t5bTk6BntsPb4dT9RS88AXqMaTPR0T4HpEV+aTd/p+TqdghT4UbRH560lLt5MSeUWStS/rodA4a/rfkcfEeB4U6yzoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736533; c=relaxed/simple;
	bh=KgS5AAXO8XkN4p63MyPvF56R6neQKBpWj6dkhrWEEOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dhuSVRcxydiJeYo/DOcywVQsaC7t3Eb1C1Q1k5XhcI//pUOyAhmPqBeb9RaFLickuAIxQ7HPdBQU+Hc3CMnZa3/f0ysPEgLdu6OX8xqjdx+NMIwbOLFPCHphJ5s7FnLKACTQa/LE1hSsLV3WlSfBmxXwXv+a/g3vesBmyyTh8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WWXqBeQy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SssitIiv; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WWXqBeQy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SssitIiv"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C9ADE2540192;
	Tue, 15 Apr 2025 13:02:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 15 Apr 2025 13:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744736530; x=1744822930; bh=KgS5AAXO8X
	kN4p63MyPvF56R6neQKBpWj6dkhrWEEOs=; b=WWXqBeQyVmC+OACAslCaWoYa6c
	TbrKG4YxX6Azi9w041gonvgX8tRngEvR/yoEdxIfCsVYnrk9/KDrLvBcWuPjirU/
	PRv4x6gd4cDjzGFFeGOfQwf4/CmQJkadBRNV9YNi8t3JRGexWUbgriAqI826j8jg
	hRH+ADNi7MaJzfi4QDJlmJcFr3NaL185G4j+rt18VQ0Ss+hsyuYkPZI6wSvCa3wp
	I5SCl5VlQ3MNvYl+JBe1rhJPK+MwYc6IBomBPzFvGz0eMMc4qh85op8ne+zfFFaT
	kJ30DR0zf1AYh+qONM+A2BdKGHPeCDtJnAlRfpQBb6zk4ZwU66C3DyABVCow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744736530; x=1744822930; bh=KgS5AAXO8XkN4p63MyPvF56R6neQKBpWj6d
	khrWEEOs=; b=SssitIivcxq3LUVkeZV1+Zeu1CP+CVS8SlSqSY1flPv6xfLONUa
	DtQ4q/EYmTNaR0iKRbNX5b8ODKXoTYKQkaOO+fPJa8VRamuoJT+bJTMJfbMNFrJG
	yq9vwpu3cXn6r+Nms0t8kch2sB9sjHOuJ3PiUdZrbPsF57jzppM6HIhF1MnDIHvF
	nOH55gA/wGW+rPZKrd7VcvCwyIp7YUl7YXNMQrU3jnwOHcLf4vkwv5j14ywzQkPW
	j2a5SwIPTouIjn/NT/LSpLhIsuVGNfdQJyUB728jps7aYFkiHprWOK9RIiWhgIYD
	IyEXqVgE4gKaYm10PbVjdPSeL8rayZgoB7A==
X-ME-Sender: <xms:EpH-ZzvubC1T6dMEU8MD7L-jfevn-qO1v8Be4h_M083ttHKoJMIXMQ>
    <xme:EpH-Z0eNxEUSjynd4AENTgkyTon6Ko4jJC16SjcW1LF11egjqd2x1xYWzBvPKMKtj
    U7Pb3jjBcbJUgveqg>
X-ME-Received: <xmr:EpH-Z2xJchLw3no1slsdCcRtFrxUN0yEAhySStu_3f6wbHGfY1_IvdKp1LRyBWv4uwXQ7YOuXl7S7mg49FS738Q109wEvRBnUOdP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpth
    htohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdgu
    vgdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtth
    hopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EpH-ZyO3EyW7NF6Dd3iz434_mDwGzVynFTf57TnJqXAxecE4p7HN5Q>
    <xmx:EpH-Zz8wduoz6tzhuFbeyLloDyZG49ZfDBqxP1SunX0CQIFDqXrv3Q>
    <xmx:EpH-ZyXBpaANSBk_lm1BCPkGcSm0LWUrkbP8n5Hqlbqva93-erlyqg>
    <xmx:EpH-Z0cM1OhWQsWslA9tXUeAlRVikorhkVsnfwlmGRAdkCX4WZ27HQ>
    <xmx:EpH-ZwTTp8GzVw2q3d-b-OiXewjMfoZPq6CUpztN3geUL2vGcHFlvDqP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 13:02:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Todd Zullinger <tmz@pobox.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Derrick
 Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] parse-options: detect mismatches in integer
 signedness
In-Reply-To: <20250415-b4-pks-parse-options-integers-v2-5-ce07441a1f01@pks.im>
	(Patrick Steinhardt's message of "Tue, 15 Apr 2025 14:14:09 +0200")
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
	<20250415-b4-pks-parse-options-integers-v2-5-ce07441a1f01@pks.im>
Date: Tue, 15 Apr 2025 10:02:08 -0700
Message-ID: <xmqqa58hmk8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Address the systemic issue by introducing two new build asserts
> `BARF_UNLESS_SIGNED()` and `BARF_UNLESS_UNSIGNED()`. As the names
> already hint at, those macros will cause a compiler error when passed a
> value that is not signed or unsigned, respectively.
>
> Adapt `OPT_INTEGER()`, `OPT_UNSIGNED()` as well as `OPT_MAGNITUDE()` to
> use those asserts. This uncovers a small set of sites where we indeed
> have the same bug as in git-backfill(1). Adapt all of them to use the
> correct option.

Nicely described and implemented.

Thanks.
