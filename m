Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D11A01BF
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538258; cv=none; b=eyZOs4wdyZlUYWDwB/YLle3KBDoMrRet+KXzgb+LRIuHsmI/v5mChQpFoCpjJdiXXm+GuPJgU5QJhI+f2lSNQXcJ/hH2e6dvrNbkGUCYS/9/OVC7Nw2kKpDy9bwpWezXwECYUSoLsuUmXIiZIXOYNgjlLPvxtHVu/TM8lyX/pTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538258; c=relaxed/simple;
	bh=ssRz9aIuDO3gyvQvbKLpXkedh1qXcHsmSy8PcOqZO8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nR7OgYqX5qGcyYIzLCL6GzLLP2Y5apsIcAZklj0jPu7HVWaZKvygekdmVMBz7qyTrA+LKf4y0/Yd6uViByDmwiRu0zdXvQ542gtWTPxUuwmEpLe+pXQ+IgbPENvm479sMgLzzRx9O6G0B5zi/KmkBtaj63Zb1v+8THBlvVa1OUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iryZK+FD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YetJv5K0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iryZK+FD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YetJv5K0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 09FC41400303;
	Wed, 10 Sep 2025 17:04:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 10 Sep 2025 17:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757538254; x=1757624654; bh=7YOF7cATrP
	JgA8qsMlkE/tNAM7IE1m2ZUbRHysSBpPs=; b=iryZK+FDStAPUSThurL+K14xgA
	HCeOkVqqp94tkHHTSuErTZu96QMaW2KENOm+IsYTX9+1iAzEsKiAGaWc2QYF0kL4
	1Q+2J/DT4htRYzkOyILEefETfkWhEtx9nS8KrZBe/RQgTmSEFY2oCoAWTB5Bi5m2
	d6JLGNiuIp63YDAbou5JOpfnCiXR3jrqy3OUv8id+EQauBU2hUl8yw0eaA1QGKzG
	Uhlp1FG+3REjGviuBRM7soHnvb6e/78xFQ/7EsreoR7lKXiZzQ4JEUfoPYBKmahK
	poyxRIXYiXVKiYtOZzbqvPFMufjYRkPJo+FAvKDzm32HbB+wE+rQDx42oYvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757538254; x=1757624654; bh=7YOF7cATrPJgA8qsMlkE/tNAM7IE1m2ZUbR
	HysSBpPs=; b=YetJv5K06XKG5K2Cg/v05MmJTOqLzm6vaqXvdbFTmYEAvmX4ncv
	Gu5GAL0HIrPmcNpxkA2UYyhcTVcpdyxmNXJb3asCzDtIoAa2QxyVzjDBZlhsPUyb
	1jdZyzXO1QJbuj7QyX/q+sb8fT4oKGhRiCi8yQU2MBEnzY11bbbY18mgKeve1uBe
	Sl36DAZPml22JANHy1obQGZGLkwmt+hmBpXECkG5HJIiYR1CZcF2PcUN+DvDxljs
	fYyjqo9H1HMn17zj43er3c/pj9/YHuSnSNcs74gmmU+8ZP395kq6N6X6GdjKmyfT
	bFAYnwfiEyeO4T2S0uZtRTykmXb6z526Ydw==
X-ME-Sender: <xms:zefBaE0R8KsmfHN7IuHYO1TXROMz-iz2EYtWRqEbPK9X8LaBsVRxUQ>
    <xme:zefBaPv7of4S814je2pa0yoVgtoswVDBBsTjKDztvGjaPdIsOo9N5L9KH2q9Y4vy_
    Za_NHx8ZvcBmBOQ7w>
X-ME-Received: <xmr:zefBaICbUT8dZR2B9j4Izw-MQdoGBRNfBy6Mrm7PrF5RF3R-8npr24A5pu-m_jjEwC0oT7Fw6AR5y9A9No9lf0LR6rRHInD3CJiKvUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghk
    thhivhhishdrmhgvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhllh
    hinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zefBaCZAH7yuCPFbYmgngF8JVoRVueZ2LPDmxlPrwiBSn_AEYOpn2g>
    <xmx:zefBaK_Tq_e8tlY2QkYJP0D9AKNJkeembmpWxJi6ImjiGTaOAyxwiQ>
    <xmx:zefBaGjj_c8UGagpbDl4ac3QFzIVK58kn0rsBa_ScwNbMMQCbikwLQ>
    <xmx:zefBaFiBz1wY_8w1-jzuXZxMyJQMTYtxx5OQblLUazh5cH1CZ9xKkg>
    <xmx:zufBaBnEs8xfRztx_PLyg7cFpcKmnFwsuAekjl4YDdEUDOdws87Rru1x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 17:04:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 5/9] varint: use explicit width for integers
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-5-4a63fc69278d@pks.im>
	(Patrick Steinhardt's message of "Wed, 10 Sep 2025 17:35:51 +0200")
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
	<20250910-b4-pks-rust-breaking-change-v4-5-4a63fc69278d@pks.im>
Date: Wed, 10 Sep 2025 14:04:11 -0700
Message-ID: <xmqqv7lqqat0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The varint subsystem currently uses implcit widths for integers. On the
> one hand we use `uintmax_t` for the actual value. On the other hand, we
> use `int` for the length of the encoded varint.
>
> Both of these have known maximum vaules, as we only support at most 16
> bytes when encoding varints. Thus, we know that we won't ever exceed
> `uint64_t` for the actual value and `uint8_t` for the prefix length.
>
> Refactor the code to use explicit widths. Besides making the logic
> platform-independent, it also makes our life a bit easier in the next
> commit, where we reimplement "varint.c" in Rust.
>
> Suggested-by: Ezekiel Newren <ezekielnewren@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  dir.c        | 18 ++++++++++--------
>  read-cache.c |  6 ++++--
>  varint.c     |  6 +++---
>  varint.h     |  4 ++--
>  4 files changed, 19 insertions(+), 15 deletions(-)
...
> -int encode_varint(uintmax_t, unsigned char *);
> -uintmax_t decode_varint(const unsigned char **);
> +uint8_t encode_varint(uint64_t, unsigned char *);
> +uint64_t decode_varint(const unsigned char **);

OK.  I do not think there is a reason why we MUST use u8, even
though in practice 255 bytes is plenty for any "integer" that varint
would want to express, so I'll let it go.

I have no objection to uint64_t side of the equation.  We would not
be using 128-bit integer to express sizes of object representation
in the packfiles anyway.

When this series meets Ezekiel's series, I would imagine that there
will be "which one between uint64_t and u64 should we use"
discussion.  I'd prefer uint64_t as that is what is used in the part
of the code that are not yet told about the other parts moving to
Rust.  Consistency throughout the codebase is good.
