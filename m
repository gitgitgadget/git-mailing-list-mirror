Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B8135CEA2
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609717; cv=none; b=oWre0QB1T6dFyEVQyQbL9C0RgwG7uZP/dMraD+/XLPDaJkg3pIivie7UYNy6zjeFgCwIJbALr0yYNL7Vk4P3zPw7tMMFifqTkSupNMNLIcziTmnbPNGTyZdrraBw1falmX804gLrK+dQlEVBNv2kQnkRg7dKgxfLSipRS7iILvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609717; c=relaxed/simple;
	bh=b4oUPcmqeQzgoFXPUVD29Ihsn7Xh1lfHqkAdfYcUtOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hABWcSS7ex4+yn6lJEt2gtk1vvVh8xcs+FHDT4p2Roh6n9ShnVVAJzLIkySvJi5i2rmvbwKsBE3wFouCn5hfF0bYGomBalp6xVDEtak49+7pOsCu2Hxz6rrjgsYMnNkxY4BBu8jZZ/Qm/NUuG0rmZMDB9iOp4RCU1jjeoS6trm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ep1mrUnn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bjphqYY7; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ep1mrUnn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjphqYY7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D57DC1D00414;
	Thu, 11 Sep 2025 12:55:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 11 Sep 2025 12:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757609714; x=1757696114; bh=3qQzPXgvj8
	OQA7X4YAH9c1p+X5X+HVkmgJ2ppeUmhkM=; b=Ep1mrUnnHCqkakuN5yVBDiR2/2
	VEQnhwu0Xhts8Is4aRESe81BWQ1iXZMBEC3d8nsA1JoY+mSTQrisdtwtr7xdQq3q
	zLIlMKUYvqO4CVOukRLy+zcWkwCuwcDNovL+N4sneoJ7qTmuZ/miGsIC7B2iHSwU
	xmDd0iORhSkxc1gc6ijtXh9XhK4Khhm6LwBWqfoYkynGEWJJCnQT9aXmy0vXYEyO
	rGzTMXflciofYeIbMarAp0/+febSWvpPrqmAhFl80Td3uxsZtUwg92nTQLcCejbG
	ckaYK8y9pTSsGQpqjXy3TNihnztx6urfb7inZ+BZ1GWuJghqxhoZLNIqESTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757609714; x=1757696114; bh=3qQzPXgvj8OQA7X4YAH9c1p+X5X+HVkmgJ2
	ppeUmhkM=; b=bjphqYY7W1CF/QfJWw7ofYlsUwHrg8FW+Grk5N7VfqdprH4Edlo
	SXSjbfQcJzNzM4+0QoQpN0Fuza8uRghVQzuP9g0Dv0G9Ahw5WCUaz/L0vLfTBRRM
	xJrMb8mf/Y1+BMIq+jSMg5UNGHl1ah6TMtQToqIRPfPcpc2mFMqnRFHkd1xoJRFL
	RalKucls0m3bg2+NivMwI8b+6Dow/hVvJYYORPWhJoJNSY+1BxpmR5NvvYeBcHg1
	WLRUU7xNnrDGtu86ud4jH51VGLjURil4+my+mYf19djsiCkJI6POJzytCeYh8Otk
	9696sXIqpcqr7dvpA5APcOO6gOWGO5B2UNQ==
X-ME-Sender: <xms:8v7CaErxUyHsp4d88M47HDrHXWuceVSsPJh_3Q3bO6pMDzlLMq9P8A>
    <xme:8v7CaHgN3L6NddgG8zhokUCJd2SQbvJCSlpAMWqYwk7BCP2q-mO8E-3NOWYc2ARl9
    PHp7w6fQV6moSof5w>
X-ME-Received: <xmr:8v7CaI9B-H8ufPepIxuzGbHEEkT3sHMlovKQffJ0FHdzZst__MRS3Cck1FLrSSpp1tlREwIJ7PH4oyGQCuoTx87KLimjzaSBeBJx23k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8v7CaLWT7noOQVwLKvu1iWkRgyRkXT2g8I28PrqvGF-FHx9FeWYWIA>
    <xmx:8v7CaEA4x-KL8IneudWCIlwPxmPsx25gF7PJudGFPR8QYoymtEwiWg>
    <xmx:8v7CaIFvY68lxgugxbckxfZ953Pzw-cBG4qO5NzEOdAyn-LO0wlCZg>
    <xmx:8v7CaN5GPCTpRQtMeTH5SGNaSHZbgBu4Nah0R62FuSWPOtEGSI9uoQ>
    <xmx:8v7CaIm7T7tqybwJdNeYHezxTQPtj2LNm_FLf5VQ2tvNbbt-VbIoGPX2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 12:55:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
In-Reply-To: <aMJm8rSOeQsO_qTG@pks.im> (Patrick Steinhardt's message of "Thu,
	11 Sep 2025 08:06:42 +0200")
References: <20250910080839.2142651-1-christian.couder@gmail.com>
	<20250910080839.2142651-3-christian.couder@gmail.com>
	<aMJm8rSOeQsO_qTG@pks.im>
Date: Thu, 11 Sep 2025 09:55:12 -0700
Message-ID: <xmqq4it9ornz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +/* Process signatures (up to 2: one "sha1" and one "sha256") */
>
> Hm. Does "up to 2" indicate that the commit may have two signatures at
> once? If so...
>
>> +static void import_signature(struct signature_data *sig_sha1,
>> +			     struct signature_data *sig_sha256,
>> +			     const char *v)
>> +{
>> +	struct signature_data sig = { NULL, NULL, STRBUF_INIT };
>> +
>> +	parse_one_signature(&sig, v);
>> +
>> +	if (!strcmp(sig.hash_algo, "sha1"))
>> +		store_signature(sig_sha1, &sig, "SHA-1");
>> +	else if (!strcmp(sig.hash_algo, "sha256"))
>> +		store_signature(sig_sha256, &sig, "SHA-256");
>
> ... then the code here seems to indicate otherwise as you only parse
> either the "sha1" signature or the "sha256" signature, but never both.

Correct and not quite.  The caller can call you twice in its loop.
But if the input was malformed and had two "sha1" (and no "sha256"),
this will not barf (as the original, so it is not a new bug).

In any case, I also found that "up to 2" comment somewhat strange.
It was more understandable back when it was near the loop, but not
here.

>> +	else
>> +		BUG("parse_one_signature() returned unknown hash algo");
>
> I think we should not label this a bug. It is feasible that we introduce
> a third hash algorithm in the future that we don't know to handle yet,
> but that would not be a programming bug but a normal error. So we should
> probably `die()` instead.

Good thinking.
