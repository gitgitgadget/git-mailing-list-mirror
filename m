Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2F524F
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757111959; cv=none; b=SCm06cVd5qlewTEdl0Tfq0idRd/hJWwrssl2/3ldqL/wrTnuHYHDwcK9m4/Mo52zdASDItpvGeQ6MSIjsJ37LH9koau2x3roAgF2KO/QpFtYws6AJjW8n+aCfjFCJRQm4F9pBwNFCBF+l1rBSulNBv3xL1DD57oktyJjO1z5EDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757111959; c=relaxed/simple;
	bh=8XjLyjuY6gtMsEmMX+KlqBo88NGHkb/Kig6kNGGIvok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hpW01SLKS9eHvQ809m9Gu8WqP67CaiTuUXRR3rw3IjTNzZ5mZWlqMozpV8V6Csg6v2Ur6brv7ATSw7ukXe5QqPq/Rjl/hJITEFzzTSkDDwWftEvII0yMBiaRpRzQ2kwRERlah3LIvDYlKMHx8HLZgahliuDbHhAUU9GjQ04sV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wI1eMxlN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m8w7qRlJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wI1eMxlN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m8w7qRlJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B193414002D6;
	Fri,  5 Sep 2025 18:39:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 05 Sep 2025 18:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757111955; x=1757198355; bh=ZvpdsiJSgc
	YeH2GjHpd6XZFYglU9cyJyGxFSexV3tDg=; b=wI1eMxlNPI4pCNzkMbtxBr+Jly
	+S/R8pghHDDuHy41azdzeVzgiRN+0Jm5gZ1+7QYCuEpi7vXYHU4kMBdyexsdfdQa
	LtZv0jdMnl9tGPsKMTLT1IIIY/G9Uv4M/kHceDgnuc5tLyLWrWQdQItB+qiJGgRN
	VyY6/e0MNE1l94jP7X7KIpqFB5XMtijHvZSB9k2X7jBBrjweSQkqV59gzzPW2ERa
	AR6O1mpL0YC7qHRBxhdt2xSU1k/mTsWsEyZXoOtlmzZoSPeKeabgJEiqhQbE5J7M
	GRRggs+mFxZuyKH6gsbuSdXNo/iSNVuGOGDr2WSB056Yx4kIPtYEitFN9djw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757111955; x=1757198355; bh=ZvpdsiJSgcYeH2GjHpd6XZFYglU9cyJyGxF
	SexV3tDg=; b=m8w7qRlJfyzD28iRzaXAOtwWhX5tpeIeghLn6sSTW032UVvUdPX
	iMeKOEagdUrwzGNxxQDn1qy6kZvs8JpUb98EdB5gAYYEzh9veDSkjpLT19Zeb8BH
	A8xQ08IIuA3EKPZyp5YBtt2pGthWZN+zrtliGGD8IjoV7dECCRGuX/Z+JRP2D4IV
	R73EBL4qfuok82iaJaaPYNyU2rxcNSSiCwWxSdMpw7L/8LHnWwJCWOzkHP+SCOUi
	PB473zyTn1snZVB/p0U3TlWTCA0qE7vytUJpuH2uIZ+5UP9SmgICajQ38DYB5y0G
	kN0PJBH1UZDYtLt1oPR+QNgyLfGesrKyLmw==
X-ME-Sender: <xms:kma7aAZ4ibDGxhC4bMcHJ6ibP4fYFoiTF83wk8baM2NS8DoM9trRBA>
    <xme:kma7aMDuyOZwt7TQlxl8WyVlmW0k1TNCkkrbnWRZCD8BTJB8QwwvFfNjjUxGWcynr
    kzgGbkM8RBpuSDHsQ>
X-ME-Received: <xmr:kma7aGH3n7mDxcy6P8PgBxdIgK9uqMZ5LfFyj5I7RafL9NzFvGt8jMh6MNQ75P8wyCfOc7kdmqd5wmPypbEv1QU0Dj0yYBFvh0KPVVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdduudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:kma7aPOEdAe3EuoEAHrT3kG8Sh_OW3modyLxHhAbIsuwL62p-N_ttg>
    <xmx:kma7aPhMxtke-0BHYFt9Q2vueNO5xpVpcvZbyHPZl7hpMnOn4SRZIg>
    <xmx:kma7aH0dh_uLAP6US-n6gQu5Ql8IKp5FaHqKHOb6FUIPTzW20VjmCQ>
    <xmx:kma7aEkayPHFAGSEuBg4tedoTkySvo1KRanfDy2hWXZQQbSuO7Z_Cw>
    <xmx:k2a7aEKUr1CLwW5ETL2BuWNdi3zvyJ-L7askyXjeJfRq8lJv50LRqOk2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 18:39:14 -0400 (EDT)
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
Subject: Re: [PATCH RFC v2 4/7] rust: implement a test balloon via the
 "varint" subsystem
In-Reply-To: <xmqqy0qs1sk5.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	05 Sep 2025 14:46:18 -0700")
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
	<20250905-b4-pks-rust-breaking-change-v2-4-6939cbf4a0b8@pks.im>
	<xmqqy0qs1sk5.fsf@gitster.g>
Date: Fri, 05 Sep 2025 15:39:12 -0700
Message-ID: <xmqqqzwk1q3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> ...  Interestingly, disassembly I saw looked a lot more
> optimized than the C variant compiled with clang-19 -O2.

That was a false alarm.  With right compilation option passed, C
version of decode_varint() compiled to identical assembly as what
rustc/llvm produced.

