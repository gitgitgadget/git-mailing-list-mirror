Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33DF1CEAC9
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882167; cv=none; b=NzxLLMkCzi4+ldyzLjV3ixhfnt9HWFqlxfqfEG+rd2nabPMaK7eR8FdSmY8HoWXeuGwzQ2bTuaXEbTyzYv3t16eVHk1SwK8PPGJ1IvtMy6PUUeyut0KS8DvtG6da28ZePcCB2WgiYAS0JoMtNVnXkIHcyhx2MrrCX3yIJJITxqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882167; c=relaxed/simple;
	bh=H/7va6rObaIn7CIk62tmZrrNWy15LmxpWM0I/a3Ex1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EcTXn79PiLEsQlj6wdR8caLgyp0nQTlhywfx1p+CNvH/Jg7L2nFPTXS/trDirAAbLvHZfOFFfdVokNEjUU8vBCkar7wzJjF3AvyXYvWcjPLegGCYdMR5/XN2zm3+K3AHfomwcGA1D8Va9qB0Fipamms8Xpgh+vhWtPpAQ7nkn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hCG6f0kV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I9cbSzma; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hCG6f0kV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I9cbSzma"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A2D4813803AA;
	Tue, 14 Jan 2025 14:16:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 14 Jan 2025 14:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736882164; x=1736968564; bh=kIJ0zAgCLB
	9Hiin9M/1VudIJ+/w9Mmkmn152tyfhywQ=; b=hCG6f0kVDlLDSNXWLvoasfxL8N
	Rbg+vVHdbUee26UP48TQjHjD75MlpHfmdqDosgiJxMkWxSW4nll4jNyDqThGH8fs
	KkVdB4sGsH4jitnNUZTmBVN/rjaH3vGyRrX584LMnMuLxviJT9BWN9cK3/wKq7ea
	+u2f4mDCQmo2ewbSZl2Ae1Igr+b4TOS2P2ixIJUsJgGiowjoYc7elUQIlpDITWGh
	ULHO+hnc+l389bmwV4Lr/9vddkuwt1MmF4/QBKxFQKLqtrlMeCs3lQ/00/tmC6d+
	qH6XzUJJ+IHx/elmi3VXKhwQ57+chXGKiu5/hZYVoKVH84MrTg/zOvCZMRaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736882164; x=1736968564; bh=kIJ0zAgCLB9Hiin9M/1VudIJ+/w9Mmkmn15
	2tyfhywQ=; b=I9cbSzmaSE3kBL3zy+8m4BJSaYY4oRM9oJTTlYwRLNum6YidXiQ
	NcR9SNXgYWrP7OVbxPqpahGcBnIh3cQMROocWVsRBwlbFhBub/wV0B39Kfhpwp5X
	gWAE+rIPncVkWphymXP3bmUx8fViGudsISv4BwjcyFu5zOYEaIAm2f2UymlEOK5C
	uucCsM+yJjKVAad0giSoCcLaB789rivA9MtcmxDrB79oJRLhdAYxrUOWBjKEHKTs
	gbkKKigZ5Vc7LsMA/6FRxRmi7/TK48FjNVOgdO9avLjG56byrCSPVxq/zC0WEHcq
	jTbBkCPenEDBPK96huwlRlGmKz8tEfVCUpA==
X-ME-Sender: <xms:9LeGZ1G4noy4za5O7AuLbSLe-f1-BSpBCnjmalQ33hB4U_XVR2GU4A>
    <xme:9LeGZ6Vcz-lKE-newLKMhT1t6P53TETM7sRiglGcDwwzFXNYkaqYaf4zN7Zqvnx5j
    NPr803NManDs7DBnw>
X-ME-Received: <xmr:9LeGZ3IIA1DWr5ISwOdMOCl6CynCFzcKAanriyc94E5Ybeux_4T5wbeZuUzHTzNqOA_2g86JVT_3zxJ7BZMcybPV11RMica5HpEG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghmsehgvghnth
    hoohdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvg
    hnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9LeGZ7Fw3LRgDSzyY52c2r1sOCf_8SeogT0BZXHYTlnK3ucvb2IK8w>
    <xmx:9LeGZ7XFiqxeTun_C7xMqEtnQpAGy_N-rGf2NbmLC232A7yn-efkXQ>
    <xmx:9LeGZ2Noed4fyHu0EGgvY4TL81WMc2uh9aNLx5mlK5URjm3geYDoew>
    <xmx:9LeGZ631W1VgZcxCpHrn99t4XYjE9WPKRqu0OuYiwO97l4VkHULQQg>
    <xmx:9LeGZxfTEBJc7gJx0pjtPRZCjZQarg2LA3Ymm6z6C557cMkX4sohBCFW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 14:16:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Sam James <sam@gentoo.org>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Eli Schwartz
 <eschwartz@gentoo.org>
Subject: Re: [PATCH v3] meson: fix missing deps for technical articles
In-Reply-To: <87a5btwhyk.fsf@gentoo.org> (Sam James's message of "Tue, 14 Jan
	2025 15:09:07 +0000")
References: <5114dc9a00377826a55f6bab007d2ad1a4de8bc5.1736866030.git.sam@gentoo.org>
	<Z4Z8Mg2IME0mveHJ@pks.im> <87a5btwhyk.fsf@gentoo.org>
Date: Tue, 14 Jan 2025 11:16:02 -0800
Message-ID: <xmqqr0552olp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sam James <sam@gentoo.org> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Tue, Jan 14, 2025 at 02:47:10PM +0000, Sam James wrote:
>>> We need an explicit `depends: documentation_deps` so that all of our
>>> Documentation targets know they require asciidoc.conf. This shows up
>>> as parallel build failures with it not yet being available.
>>> 
>>> Other targets look OK already.
>>> 
>>> Signed-off-by: Sam James <sam@gentoo.org>
>>> ---
>>> v3: Fixed commit message.
>>> v2: Drop incorrect dep I'd added for api-index.sh as pointed out by Patrick.
>>
>> Thanks, this version looks good to me.
>
> Thanks, and sorry for the (obvious) errors.

Thanks, both of you, to working well together and quickly.

Will queue.

