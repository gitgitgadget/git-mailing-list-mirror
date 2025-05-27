Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76627AC45
	for <git@vger.kernel.org>; Tue, 27 May 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361901; cv=none; b=KEPsXwB+M44D6IfVyoZD3ROVMjbu7TAG1GyzkH/gpKUEODjGfbAAaUoJKLqgS52iJ3xMo+GlAKe5BLa4pvbx6jqFRyyRMCobYBMfWHaZ481cz68w5aZjNFRGZc83HP6X+tD4L1M5PSm67h/giHvYjotqGBcVdimFODmlCeAf3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361901; c=relaxed/simple;
	bh=SXpXA7BVv3A/X9BaJbIWDQrDwAwnzN4aTdkjjHGgCIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oj3g3Z10K7qHEViZn8K+cLARrGuo4x/ZFQMX0XDIguzPHbBJJyslBjvSqHPhmvKHhvGISkIKfD7sPQeFDsQpDmuBDN3r0FRJDDR09YHtfVGRPqMvOzRg8JFNJ1HKlbh2ik+KKw02V5flJ+U+7ofY3+IZlVJzZZ2XuBIVxpc5VEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AGfO71lR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fddZnLiK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AGfO71lR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fddZnLiK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CF832540106;
	Tue, 27 May 2025 12:04:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 12:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748361898; x=1748448298; bh=1NEKU4ZnJr
	HYpLORkVqfLY8ZtYC2bv8WsjCAi0L9/gs=; b=AGfO71lRbwiKVLKgPpq6+k8Lkd
	l9nCKMqzHkz57XICFQsDkd7OXDYPSxbqISkwZfBYXQu7Sc3Jo5YAVIohjpRcfhWu
	rggbY9BxBo3KXZLYlpkdfjGE5e2PLFUYlty5QcoVOEKBFeIhSxm3J6CIYxZPS7XY
	ji7Y+wkskc5cWNTZ7C63C2jty6G3iiufIIZhC7+XTs/2V2EJHfkXWQsd9yQemKeI
	viBUXVjodUsyKrFOhm/c99yd61hHGjtjt9y8L5uBrVSO1Dic2dojXNcEqAjBan6i
	UUbCoRbtBs9OVyZ4J/RTbkGRGg/vWTunuopwuG6MivQOtThM66i+r7OF0YHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748361898; x=1748448298; bh=1NEKU4ZnJrHYpLORkVqfLY8ZtYC2bv8WsjC
	Ai0L9/gs=; b=fddZnLiK7llq+LNCx51Ib42VvH5C/8Vm8FBWOMT6/1xDrnenADv
	l0JUSeeTmymRcyL5V5xBIzdegTfqpLhuh7I/7IMbUVnTscaqFGvY66gdua2r3T6r
	twJlaVM7wTCX1Y/Hqy0IIxwz8aoVLfiDAGtA4CNXNe3L+64P8f7KClpUvPOGLA1J
	dXevj0xRpnAWtcadJQHsXGbDPB7Xx1o3oac1xkT/PfYTzpXopYDGMmXj34XnQ4DP
	TsZK3t4Mb4yTh/ze4nETd0jmfPv0yUp6vVyeVFXNpSb9daTI/tQwTkyzo69wHIvR
	brcrJbPsjVP2I/jXf9zDFmheGD7ZJI3PdZQ==
X-ME-Sender: <xms:qeI1aJN0V0_NLD5GCUPenM1wpkoKkV2XeUGUNKFt8D-CXKVhJCyN2Q>
    <xme:qeI1aL_QcpSZcerCVG1vmCHwWR8Y03lSOTSCfu_AaRqn37p011YVwzx-317dK0UD5
    k9c0Af_uJwlBdWvjw>
X-ME-Received: <xmr:qeI1aITT4mVOAemnsGct5k7K5TRkOdU2ehX55nCkoIAdyIVN-Gdus34lJS6G7we5MsUX4_P_XisCaUnb3QJHFxsRXrc3P1KpdYB-42A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdekudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueej
    veefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinh
    epghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtoh
    ephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrg
    hmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:qeI1aFsTMObBWN1owbQklrCzQ3qXWXI-SvqFOIPneTkdA3BYOHo96w>
    <xmx:qeI1aBfEAzJPiYsY77QRF8so7DUPBzxZr3HYEcIIApCQqfgAGwh2mA>
    <xmx:qeI1aB3E4eU-2Rqz2L61oOzijcBAdfifqwlvwFVJDHkuUqAlqewQ_w>
    <xmx:qeI1aN8frBpxQe_4J1zWT-mj-k3Egjb4y-aR8wGu3HwmvPsAhuN1Sg>
    <xmx:quI1aIdKpjtT9AF6Vb9XKZ5a3ijWxLHcRM6-eYydahhqfp4mva5IdITf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 12:04:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eli Schwartz <eschwartz@gentoo.org>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
In-Reply-To: <aDRzy37ZbH9_Qo5B@pks.im> (Patrick Steinhardt's message of "Mon,
	26 May 2025 15:59:39 +0200")
References: <aC2xp4Cdb0j6OX-G@pks.im> <xmqqcyc2aqy7.fsf@gitster.g>
	<xmqqfrgx8xkw.fsf@gitster.g> <aDBH7G-oKKxAXWBp@pks.im>
	<aDCNqRAoGygwnAbq@pks.im> <xmqqo6vjz5cn.fsf@gitster.g>
	<57de5690-f683-4e8c-a05d-a91198b352ca@ramsayjones.plus.com>
	<xmqqwma7w29o.fsf@gitster.g> <aDRiLdUCEVQHq26z@pks.im>
	<4c06724e-f6dd-46b2-9955-57501f8a4e0c@gentoo.org>
	<aDRzy37ZbH9_Qo5B@pks.im>
Date: Tue, 27 May 2025 09:04:55 -0700
Message-ID: <xmqq34cqqbtk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > I don't think it's inherently a bad thing to fail on unexpected passes.
>> > After all, it shows that our assumption that the test fails is broken,
>> > and that we should have a look why that is. But I can see arguments both
>> > ways.
>> 
>> As Phillip noted, treating them as ordinary passes undermines the reason
>> for having them.
>
> Yup, and I tend to agree.

OK.  So perhaps Make-driven CI jobs also follow suit?  In the same
run that osx-meson job failed, osx-gcc job notices a passed TODO and
happily declares "All tests successful.".


https://github.com/git/git/actions/runs/15221271947/job/42817168362#step:4:1933




