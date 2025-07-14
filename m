Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0EB18E3F
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512525; cv=none; b=Y4tmNtl576Rrs7aamA2eNoPKJUBDRMGhbc7pDzJCo0y1g1uMjlAQMCrmwhQurXSlFqwc4NS93kcF9sr6iPQ9nhojUwfpYICNlPD1i8zaxI8VVwwoOotwa0CgBTWLEDX9yHe9AjuGFx79RUqS9Pvh3FuZoQuX4HYUtmoA9Sg7aIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512525; c=relaxed/simple;
	bh=RDLW6UKm1zN5OHXifkKWiJCR+MGxO5yspdfQkSeQY8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=itNNRPRfqflYxRih3inxdFAykGKcCQse5jBw04ckZA3C5NW1v+SRieV/aFqAfd7lKwCm6q/gdoKzPIXzoxvJWiu2F0wsHgp3mwrxbZ5ocXKBq4XgXvXNv2dVcBsti7zlWKgYx0pUf2++mDmWAaPPQV8d99wC9KZ/k+l44O5QbyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bjqOJa7+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OgNUyavM; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bjqOJa7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OgNUyavM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7ABA6140038F;
	Mon, 14 Jul 2025 13:02:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 14 Jul 2025 13:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752512523; x=1752598923; bh=9WLUkmTWUO
	iRMiH7q1MK09QSBxdBKL4JECwmAKVbQzo=; b=bjqOJa7+swo8AbMLyA33YAt7J8
	kR0/KJavEX8oAidcwQxJFk/Q1u5Mfr/GCJ0q0W3pFrVFNmzX0A+jJYlAQI1v6nuC
	nmjHNGh7Yhp0GM1S4w47Z6xD1pjIA2c29wo/5k7Rhda3JlIhhTISAPcuqDoGkInc
	5Q8Lhq7CWEYnvMuJAvPmP8AxLAgcm5EwnS45XxJ53BGaRZOX5MI4Dl2hCBPXXKeq
	z0Le8nXXpTE4hYHFt7pGDvqhQPn0y6S3XkFK6ERMMFTYFS2oPqcW1hXnvg5OvpPu
	+rqPEl5zG4bwVpbRZ3t+mqajNDkkn3R5owLi/OrDVdFFutSf5oO8sZDZRqKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752512523; x=1752598923; bh=9WLUkmTWUOiRMiH7q1MK09QSBxdBKL4JECw
	mAKVbQzo=; b=OgNUyavMyhrnZPUBJSk+CkZWNddoqcxG0UOt/IjdG4nKZ0hMW/V
	3EEYGqXEQf2grbeB0BXiSWLGSoYdxh0XVAflM8ROzrJ4yzPrpxuBKA9bLn6Excfb
	0gLf+W8EPomaFnMprHOGRDRCKQQAJm1in0CuJ1dqizFzrPWf7A7lIc2awXIFc4I1
	plDs57mQ3JYDvOsuMW+1CuM8ewJURPOGOoc6VmiW1px6BG2u2qJPuAz2lQHLy8Tn
	Y5183iJv9IQ1k0p2doQHK4RKIYILiyuowd6USrbMAzZJgwM8y7ESH02aFMz6L1ee
	sN+zcM5BFqbhQK9urSJw9X2LzAU5gYT8WIg==
X-ME-Sender: <xms:Cjh1aL8DTop8Xc6FIge8Wu4QHkYoSFmT0ZLlhsmk9W7uHpakXyuUNQ>
    <xme:Cjh1aPGosR6no-Y4Y6sXn2bXgw5z2W2JZ0dSho51QDSalePlVx-O0alb0e_JsdEyd
    33dObh-fzLCcH_I-A>
X-ME-Received: <xmr:Cjh1aOl4Z2qEWkHZgN4dmt2vtDx4yXmMrJRO1I_K_sPY1eXmdYcpWUvoWjWK0MKtvLFCjPeYfhlt9_O4utDxPiR8WGv8rRH86HcYR_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopeehtddvtddv
    geeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Cjh1aDatv7QOfamOQY7p824lrMk1K9J-wrBrnRieiNVTQufpX5vNzQ>
    <xmx:Cjh1aDGysjvgoGi1d4mMaRaejx6zzG_av6nKyE7uv1rKBNChAUarjg>
    <xmx:Cjh1aEK5DgL4HaabesY7HLb16GTDK_ylWKzkaZDY46lEi2SyjSwWGQ>
    <xmx:Cjh1aOOM23EP-_PwCEYOPUZc9ourix0WXEuF9dSWkas9XOo5oFdRXA>
    <xmx:Czh1aA7AqgnA1eb0jn8YgQbbhfLWIswTUSLu_n9M33n1v164saY3jnuo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 13:02:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  502024330056@smail.nju.edu.cn,
  git@vger.kernel.org,  toon@iotcl.com
Subject: Re: [PATCH v6 0/5] bloom: enable bloom filter optimization for
 multiple pathspec elements in revision traversal
In-Reply-To: <0969e176-b9c7-464d-8e97-cf5cd4a06347@gmail.com> (Derrick
	Stolee's message of "Mon, 14 Jul 2025 12:53:35 -0400")
References: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
	<20250712093517.17907-1-yldhome2d2@gmail.com>
	<0969e176-b9c7-464d-8e97-cf5cd4a06347@gmail.com>
Date: Mon, 14 Jul 2025 10:02:01 -0700
Message-ID: <xmqq7c0au2nq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 7/12/2025 5:35 AM, Lidong Yan wrote:
>
>> The difference from v5 is:
>>   - extract convert pathspec item to bloom_keyvec logic to
>>     a separate function, which simplifies the prepare_to_use_bloom_filter()
>>     function.
>>   - fix few bugs in v5.
>
> Thanks for making these changes. Including your fixed patch 5, this
> version looks ready to me.
>
> I wouldn't say "fix a few bugs" but instead "fix some compile-time
> linting complaints when using DEVELOPER=1" to be clear that the
> functionality hasn't changed but the code is cleaner.

Thanks both, for polishing and reviewing.

