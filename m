Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0F33F8D2
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966280; cv=none; b=iXjUzO1FhNuToJlY4a6Sa1b8T2Evss2Gb2kfsyIJd2T+L8LL50uFx/u+yKwZqtw35BaUJy9XvQLN72hhh6PLUncoNU668P6cV6Kv4bTefpp2Rc+c7lSCPstAG51P3pRZb3ZrayAaVAg18HXZ5vvFx4ty3S9mQ3MGKaMXiezqni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966280; c=relaxed/simple;
	bh=pbpzH8NSGIwflE8bCKctYnHBEvVBzON9ZA4zJVuqzss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YBnKfKua2u7HMS0q/u9RNKTlK4bw8XIg8wc0W+lN1n4q8Pds6ijkstWf0b9V8xcruOA7u2SdNZTG9S0hfwCz/TREAeutFZwfcCvlB4CPCKDT1f6NSkd5Omd8aplw/wa6o8FHJiFeJSUNC5cjbsSSAb9YQ+IWIz07pNF/UxBSDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UlJoNQ2B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L+OB3x1D; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UlJoNQ2B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L+OB3x1D"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B5771D000F7;
	Wed, 12 Nov 2025 11:51:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 12 Nov 2025 11:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762966277; x=1763052677; bh=pbpzH8NSGI
	wflE8bCKctYnHBEvVBzON9ZA4zJVuqzss=; b=UlJoNQ2BKvHKs69Og/YcgQj6KT
	nOY3ed81M29VFfowYj2t0XdKmaGJe90u6CpER5g6wyt4q8nw/vVkFcH4F1YF5Z4/
	trxAcKU+L4ZzQOETJv3Jgmf9b1NP+wPO0Td9iPmlJKY/61/ZtK4qRny0c0+gm1Rs
	BxN5k+sp7hEfpCQbwVPu2W47x/tM73NRMMoYlZDJaexR49JUsO45jyS/S5LyCyjY
	hDpI15IyjWA/yR8cvNBuNInGMBwALHhq+PV3hYAQydrW/apHjNLFoROhgvpus931
	1RR94Yq1ntz6PMXQbEwztIBpKHmi3NU/sp8deEVbeZXyVpXYz3V6QXO5hebA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762966277; x=1763052677; bh=pbpzH8NSGIwflE8bCKctYnHBEvVBzON9ZA4
	zJVuqzss=; b=L+OB3x1D3InBg8RzSH4e1nJPoysFJ30rGHJVfvlpMAkLHX/nYdh
	3vTTNSpT0sJX1xn6bt+Snbvxx91d4ceAesnLjg/z5tkDd439yU7ev8inh91AfqhP
	mDP9Lk6ZJ+tt1xyLnvQbZk070yWk6JnyWRcH77hVbpz+nwi5m6d+Q7QzqkFzijky
	xHTw7m7HG5afnZROm/LoSCHiKNRB8taB8xwOtd7uN94kCgBmCzxMFyXLLGT64yeH
	32veQWdv9XG/EDDpKi1Map9xlDKxyXOcSvvztSxF/sYOcWNRwp10vsA/GfpDf20m
	BL2VlRySS05+VEpXAndQ4pU+Wrh2K5Rh3/g==
X-ME-Sender: <xms:BLsUaeAPoU1jEtjn5p-wbgBRIIpBP1_sXj7n4pTLekRSAUd-wTX60g>
    <xme:BLsUaXn9vzIjQ5YtPuHCg8CmR5vmI1dB2PXye0YoWS0hEHuJ-q5UOK7Hd0AwVUp_q
    QrspckwdyLmJtPxgCPaeDcLwcuT9AKmRU3M9mFSbtyw1UN2UdzIuD0>
X-ME-Received: <xmr:BLsUaXxgkkYqhLAAB2JqrsJ1fRXaeV80RMp8UUkX0KE6bQm8eh9Uk6zrjEoYTVQjfJLRwMMcX0mUV7JSzPXrldn4gZh2ZLxmCBlr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BLsUaZSaO35vnf2w-N5aCXjXFuyT9nGY269ZXGay3ygDVrjJ-o4fqw>
    <xmx:BLsUaX9X8EwctxpwhzhPb7OI2pAIgxGCq3SWPUZXzDrYCEhLPB2lng>
    <xmx:BLsUaftYvVyscHVgQjlQg38GuX3MryGBmAhRBcBxOGlT99PWLnTP5Q>
    <xmx:BLsUaXO1t85SRDISK0r1D2ZKC9ok3rlNQt-kHwOisyelHA2Ggpbl7Q>
    <xmx:BbsUaVCAwDaTLsOEb1h3b7WKSspw_4rceL8lpViCDdcM73h6OtgScRUX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 11:51:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] fast-import: add 'strip-if-invalid' mode to
 --signed-commits=<mode>
In-Reply-To: <CAP8UFD1YqadtkYriePJKUBjzhXAyYjNEk-9rj55ZxbGLRAOd2g@mail.gmail.com>
	(Christian Couder's message of "Wed, 12 Nov 2025 08:19:49 +0100")
References: <20251105061918.3688870-1-christian.couder@gmail.com>
	<xmqqjz04mtji.fsf@gitster.g>
	<CAP8UFD1YqadtkYriePJKUBjzhXAyYjNEk-9rj55ZxbGLRAOd2g@mail.gmail.com>
Date: Wed, 12 Nov 2025 08:51:15 -0800
Message-ID: <xmqqqzu3ry7w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> Even if you are not changing a single bit in the import,
>> some of your early commits' signatures do not "validate" and may
>> need to be stripped, and after that happens, wouldn't signatures of
>> all later commits become unusable (i.e, you may be able to verify
>> that the signature on the original commit object may still be valid,
>> but because the commit has to become a child of a rewritten commit,
>> in the resulting history the signature would no longer match)?
>
> Yes, I agree it could be an optimization to consider all the
> subsequent signatures invalid after one of them is invalid, but it
> would require making sure that the commit history that `git
> fast-import` receives is completely linear or that we properly track
> commit history when it's not not linear. I think it's better to start
> with a relatively simpler implementation like this one though.

Note that I wasn't suggesting any optimization.

I was saying that the cascading effect would mean strip-if-invalid
may have to strip all the later commits of their signatures anyway,
which makes us question the usefulness of the feature.

The other message from Elijah made it clear what the piece this
series implements fits in a bigger picture, so I actually am OK as
long as the overall use case fits what he described in that message.

Thanks.

