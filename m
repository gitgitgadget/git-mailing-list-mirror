Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBDE29CB4D
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682865; cv=none; b=mo/bnij5D2RRgWh+uY7NBNVU4eT4VqNbXmi91kOPLft94NHpkLhD+q9GjfZHjuQ7rtEwlKPWIn4ytqqWExoLNk1NY+EgKnJlKP9X1Go79hj1xvBJzucm2miNe4vrRVvcrg4bINNRvN3u86QOl67KGiziPpOML+NjhP5zB4uIEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682865; c=relaxed/simple;
	bh=8OSJwCjqwSsyKXHKgekY9dHB07gsFf+nsHMMRzHzn7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P/5rcqiMqk/3Xqb9dVilkxaQVvalmmTgPksZAPKAtQVdN0+RYGM0vQqU+9lRVvkeu3a9S3fiHwGNr5kTPgfxJ8UBxRdTwUpALktqE4jAvo5GA4R4ONIws9Jsj8h+xfxJwWov0oDoOrkabATO1w7m71PccwoIWJ/iU9w+WAf3E90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZgFvfA/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OCmIp1YE; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZgFvfA/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OCmIp1YE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D7311D00118;
	Tue, 28 Oct 2025 16:21:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 16:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761682860; x=1761769260; bh=aUQPgXqRqM
	vr7dH90SiI4jHoXGw8CuHH8Ji9IxOVIng=; b=ZgFvfA/NzWv3vbxwjjnWwEnSHl
	aM6fmRHGxakq8bBQhiJnrv0i8W7xcTBgCuxO9y8Dgk0GATjpzhg83XDe+5UGL9OM
	BI3wvm+OjZQV160VR7KSapnRhwRD5OMHLvfwpkpNPdBrmZxeO8YcMAmcut1jB6ca
	r0UFQ8uADS4hCxcG5l/zc5Ae3ngu3pCFXNVUduWTwHQh49PWZmSmFQD+bXZrXTKZ
	N4D9ZfgKQDSnhwM3Os4V6/pjTCbiY2vKqkv+y1ZgqQOXdR7D+6WbHL/InMMDVcUC
	Go0TqOiEXL01XJ11WA57NH/ETiuGU+kgoOlD6+ZHregGiwpwGlr/dUDwuBRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761682860; x=1761769260; bh=aUQPgXqRqMvr7dH90SiI4jHoXGw8CuHH8Ji
	9IxOVIng=; b=OCmIp1YEfh8FWezJi19+LhSrrvk+do/uMAsXBrSIpigOEwkj5LR
	xvst/ZgLoPKwGOPbTNykxKK5v4iZw2UDQ+7EbkgmAwP+9zafPvc2QNTgrcqdMNia
	ucNhpygjPK50KMY6/nIqQTlYFvkFiONCpSn5LIzEOi1ewR5uEhWi7BUcrlKa14Dc
	Qp1aIZQ72OVXQzuUtZ0W5mAOqhdIFUVOzYgN3Dnc3FCPw5+p0k4p5TENJHrzXtBk
	niPl6NXn4zrX+sG8XrxBzQlOX70f8NSQBVrHi/E/hSdFQ93pGiROJJc3EM54DiAN
	MQwAnXqeFMO4w75mdj1aCxpxFL9KUGHobrQ==
X-ME-Sender: <xms:rCUBaYfZpU9kK9phmVjPBjbsTBKjnGfo5w9_FM2V9Ukc7CVWoU1f0A>
    <xme:rCUBaRHPraDp18BACI9_XVyG5tQDJqGeKy16Fhqhpb2iGLfZOndoRmE3l900T1fw0
    Z7XvhxgThmkLvLBIhyYn-89wVZPSP0ObV2V9DmE56UDGXGTAthe-Q>
X-ME-Received: <xmr:rCUBaR0DydZvySyI-HF4qcBzAGkAhqZrZfJJseKLVTgc63VLPI1KS0sSy25avLTYmjdj3rWfgdgqIQ1tkHWZePGQihzsczinPjPM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurghlshes
    tghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:rCUBaZmLv5YrxG2bgELnKU7NYAz7H841YNwGquo6sJJKeFqIjslZKA>
    <xmx:rCUBaR-jG9tSDJOJMxxqFaC6Hq7n1d1SX7zViLPQbIJWvBeptdsomA>
    <xmx:rCUBaeqn4mUJIe6yN08aUS2EmvfSKprzGlW4La5DeHqO-YkZdAhJ7Q>
    <xmx:rCUBaakCTxLfbh5JVoUIv2-YDCC6TwYU7yrnGvfYXEMZsTrfYZI0Ag>
    <xmx:rCUBaaWNEFo14LErSTz-MqDx2tOZ5dH9ruBEBvg79h07JEACInwtwBEr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 16:20:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 03/14] hash: use uint32_t for object_id algorithm
In-Reply-To: <CAH=ZcbDEo2xcqpRrF400zHe=w-kK+rfnp85YhcE5kQ6jjS+8Hw@mail.gmail.com>
	(Ezekiel Newren's message of "Tue, 28 Oct 2025 13:58:21 -0600")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-4-sandals@crustytoothpaste.net>
	<aQCKCfuaEKBArD-g@pks.im> <xmqqh5viddo3.fsf@gitster.g>
	<CAH=ZcbDEo2xcqpRrF400zHe=w-kK+rfnp85YhcE5kQ6jjS+8Hw@mail.gmail.com>
Date: Tue, 28 Oct 2025 13:20:58 -0700
Message-ID: <xmqqsef2bwwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

>> I suspect that it would be much more palatable if these functions
>> and struct members are to use a distinct type that is used only by
>> hash algorithm number (your "enum" is fine), that is typedef'ed to
>> be the 32-bit unsigned integer, e.g,
>>
>>     +typedef uint32_t hash_algo_type;
>>     -int hash_algo_by_name(const char *name)
>>     +hash_algo_type hash_algo_by_name(const char *name)
>>
>> Yeah, I know that C does not give us type safety against mixing two
>> different things, both of which are typedef'ed to the same uint32_t,
>> but doing something like the above would still add documentation
>> value.
>
> I'm against passing Rust enum types over the FFI boundary since Rust
> is free to add extra bytes to distinguish between types (and it's
> documented by Rust as not being ABI stable).

It's OK for you to be against it.

My mention of "enum" was enum on the purely C-side and I didn't have
Rust's enum in mind at all.  As Brian defined ObjectID on the Rust
side, the type tag was done as u32, IIUC, not Rust's enum.
