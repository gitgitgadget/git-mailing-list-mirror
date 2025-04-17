Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C652B1FBEA2
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744928472; cv=none; b=UKkkPsM22KjX5GmO1T0ivp74jcEoFNeLbeQvSWM50Mu6LklLsIFzvgrw4ZnTqlR2RGP7FYsMZRSKsF3kVvoQXfFPCVDidAYmSHKyb5WFHqptmgtuw6SaHHMf1B8t905xHoNKte0euguXYlwq4MfF6wpMqJ+3hSt3E0vkOBgnF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744928472; c=relaxed/simple;
	bh=zXuiEDMnQ5XtJQ8DBc8jT4NlvuCvAvvMTRsCtMSVjRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hk3sg+D5JLLfpAJP6TrXHVtLlVx0XPRQacFGkgc/6KujrlZoWeKeMH3WlIexwKQj5OsBaJZ/dq9sqKsPec38kE+Ct0u+WC6VSjmE5rP02c9FjjrAdczg9uaUE+PzuTevLPc1OQw82EW0iqhk03fYfm+WZqC4QrgjLLvyuk4RW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n3StdPXX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JR7kiL6R; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n3StdPXX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JR7kiL6R"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8FC4211400CD;
	Thu, 17 Apr 2025 18:21:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 17 Apr 2025 18:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744928469; x=1745014869; bh=WUYA0bf6OW
	aHaOeD9AMbLe/R3yeg54NP0Nd4mz5Ml4I=; b=n3StdPXXw8hboAONd1qqhcNFyf
	w27k4kdCtzj4CkmF+HAqwJCrsGvH6/hhd5FTJCEOHrPlInT8PjeoIoGgR1zGAUdg
	IKlfxHSPI2kN46AczScsaK9IS9v3ZrRP3L293IvsU28YE9tdm5ozUoXgZKACdQBw
	q6NJamn2BY3FqgMvZm9fHrvhTq/62cen0t/RYn9ggr/OBdUlcA3vY/Eb+03+gk4S
	tFA1CxKP6hNrOOir/hQQDQlHp+EArQc5VmtDUsrzjA5DdOZIXA5CCvjHcZudA5po
	m8L6go0W0qL72mswIu/+LwgRotgBtF4AwVtdXF8yy1/PUZ24jfpOs/7k66vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744928469; x=1745014869; bh=WUYA0bf6OWaHaOeD9AMbLe/R3yeg54NP0Nd
	4mz5Ml4I=; b=JR7kiL6RmyJSyIvDBxQVKF3XrXj4Rt/tpw1i2EwiJKBhQNRf4eh
	GgDUh+KmAbgkdYsQMmPqygLu9qveLYMeGtElRPWBYfdBmYk9E/noejam+ZCUAQ52
	kzJdmkGqce3oyBNeVC+vqJi+aYQW7LXNuvtThWJKR1cKVvVNyitE1HmiNNJd/iCY
	cE408Ii1qBUf0rRje6h1EpytznHQjnBN6b3GlXLgkZJe8+J9GZwU2fZHoTiunGuY
	uYXwKML/BujRCDRRCA18vpAs7FHgvGO/xorknEy1zMFUhXsu4BIVBO8jnh0C92yb
	ng4YjwZqDb5jC4TZQvbrvJgwzRY5Z6tOF7A==
X-ME-Sender: <xms:1X4BaHXEoXs0IVSmzFVckPblAxldTHaCohAyNBs87lheRI_6mg8MQg>
    <xme:1X4BaPnfM9TbWPVfOge4_J5S1kJ4058h82xJXjIRkPqudCUA0k_hzHV9tdqP-BKjk
    SMddMXPRF3lGQbZBg>
X-ME-Received: <xmr:1X4BaDZrPFQ57WhWUHpn0RCj-jYkkw6WEj4M-BjrWKAI5_4yWxAtzppm0ZHvY0780gQfr2s2YXUJ3dulC2-o9jMo89Ig45KuslLK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1X4BaCWWtxSWx6a7Nf2xSg3Xoo0z3BQkpW2-3n8-Uon1S8EISL-19g>
    <xmx:1X4BaBnwb3-JUnET8s3e9YOn07n21Qjtz3mx9BZPzrYPcAGAY-e3eQ>
    <xmx:1X4BaPdMUlrp4lTbkRoP1fi_d-TcwjVW_bMnJAjvoJT77x8_iJUoBQ>
    <xmx:1X4BaLFAgv6j4BoJfsUH7oVDJ7sJt-LDvNgxUrMGfMuv0QirYBoVEw>
    <xmx:1X4BaIqBqBrQjteloZDEQR-WvaX6I7e1rYVh_gTicHqcYhE4ohyv7UPJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 18:21:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 3/4] t/perf: avoid testing bitmaps without lookup table
In-Reply-To: <8cc5952e594b78ffb2ba4bcaabd62a8e5b8fe72a.1744924321.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 17 Apr 2025 17:12:20 -0400")
References: <cover.1744924321.git.me@ttaylorr.com>
	<8cc5952e594b78ffb2ba4bcaabd62a8e5b8fe72a.1744924321.git.me@ttaylorr.com>
Date: Thu, 17 Apr 2025 15:21:07 -0700
Message-ID: <xmqqcydae8fg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> In a previous commit, the setting which controls whether or not the
> pack- and MIDX-bitmap machinery writes a lookup table,
> 'pack.writeBitmapLookupTable' was enabled by default.
>
> As a result, we can clean up many of our bitmap-related performance
> tests. Many of the relevant performance tests look something like:
>
>     test_it () {
>       test_expect_success 'setup pack.writeBitmapLookupTable' '
>         git config pack.writeBitmapLookupTable '"$1"'
>       '
>
>       # ...
>     }
>
>     test_it true
>     test_it false
>
> , where the two invocations of 'test_it' run the tests with and without
> bitmap lookup tables enabled.
>
> But now that lookup tables are enabled by default and have proven to be
> a performance win, let's avoid benchmarking what is now an uncommon and
> non-default scenario.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---

Hmph, how costly are these tests to run and maintain?

I somehow have a feeling that removal of these "performance" tests
is less worrysome than removing correctness tests, but as long as we
claim to support both configurations (i.e. with and without lookup
tables), it feels a bit premature to remove tests for one of them.

