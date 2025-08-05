Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070813FE5F
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413976; cv=none; b=IenXAgBwr2YOQL+oet9vouTGiG56JbreME0k4Nb1H1esbhB1EUYlY6H8EMqtyKduFIZJOYs0HAJRXwrvHYYpxl3LxdVz8skABiO4VqpTEPfGsH+6GJKw9C9/F9kTyd3uScd4msCJNgFVoqZxG/VXdKpeCDebXJ7UuCBvwyyJNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413976; c=relaxed/simple;
	bh=+uRKYA5U7rg/ralxgJ5dYhd9Vi9SlkEEnLxSXIKpa2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W3ihmEzUDoWUxgpxfWYI6DHYF7+yTRRolUMa9E9xeKj+UTqSFzEELOXfQnsGlqPYhXkwc9sw7oH9WqwQIMMYF5+5lswJ3jjxlnwZdiFgFuhM8xWcl//wixVI3CDIJ0rkezCvZBW1FnC6ptkN302Bb0mdI4bIjbgPTLLPCFlA77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HZJ7+h0/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=joQh7cIY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HZJ7+h0/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="joQh7cIY"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 116B87A0167;
	Tue,  5 Aug 2025 13:12:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 05 Aug 2025 13:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754413973; x=1754500373; bh=oyxa742GfK
	xSqrXT+9ev+tAGIJ+10JR4/f3WtARWaRw=; b=HZJ7+h0/lQhdWz2usepBIgQDc2
	RfaYVz32pssKgiwexxsTGoHZn62gqVg7UaLbtLuLi33I0x+ngMSIKXsJ2oJ8VjnT
	bPUcUwLW5LNvss0D4UNzSE2Si0FpQOcTDXEGd4DG4BUHwCICMk0r46EcoT/APfXe
	jJ1wNt4SUFlQicEMiQaRrUyXoZHrWzd0PkC8Dbaa9deuQfddG3kswReOPqzlaGaR
	jHpK+1leY96pyKY+TchGe/z+7fS1xBZ/2q2VKEB8OJO4ydFsLnEPY7QAlmN3gw7U
	GsP/BOBtJ8cVLT/aCmRwfY0pkvbRtSwsMFVe1A5AyUBcHNBJFpMGwK/2XjqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754413973; x=1754500373; bh=oyxa742GfKxSqrXT+9ev+tAGIJ+10JR4/f3
	WtARWaRw=; b=joQh7cIY2dxThmjFcNm83aKIEdwhdDsHR78YZJg/4Tqr8t0BsVs
	sa30u19QuYYY+A+CgSTxGP0Wzfi1z664WK3MfM+SjTwNVYVDZw83epr534k0SuvJ
	F63pK6bu900hncZitPBTnnRyN6mxlBSkDbhz/KnBBZ4dt1WUE2AoiNgk7HyPGs1s
	WYEH4KzWFvqc+Bb2bpa3RxCYbehxtCvsYd/PKlzKJrsBjlBOtKHnmiKp+S102YrG
	MFh37Q7f8UHrHQxJ/YuPPWYJZzdbObunptBnLd4XkdZBe7JnwdyWtMkpyDSmZfZm
	56IXdLw8OQvDVkoDjlbJ+0cwVEBvIVSviLw==
X-ME-Sender: <xms:lTuSaJogU1tvv0ZBIL3Cd_1mycopRM2qGrzjw-lc97CoyHai8h-pgg>
    <xme:lTuSaGNLkZnjZqM83wewIknHRJ-2ttOVx7SPR_FA8zG9EHgO3ckCWIrObiU-HNNHh
    AqHnIRhB9E7cuqIEA>
X-ME-Received: <xmr:lTuSaCwZ_B41Hl04yS7uVT1PGmAgtSo_BxLJ8lkAnyEH05j8jIhyOUPNVIVinBwnLCHuQcXN6J0rfk-B4B20RcrtCRBpQxU9VESj_fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehlihhurd
    guvghnthhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lTuSaHt1xbmzPXelgQrV0hAPOJA0K6rwnnCNUnZmA2PlWkqS7ShdAw>
    <xmx:lTuSaD7VmcYoTXcRg_Wcw8mx7NAQTp9BOLxlkyYPf3rAlrdZ-vx0JQ>
    <xmx:lTuSaOSSKKbcucH6ZQqmVBKbE3fhu-oSmiJpbhKDvVJoI0nZVG5sWQ>
    <xmx:lTuSaKpJnHACd0J8kCGai0cd8DzyDudKNKR7Ssf_AY4kpohomZj1YQ>
    <xmx:lTuSaPb1Se9YTzWZk4s3XCu_bB4rGs7qZcbGhqzS3xDBf_sBpoOWbzbN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 13:12:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Denton Liu <liu.denton@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] t5516: introduce 'push ref expression with
 non-existent oid src'
In-Reply-To: <aJIG4lZURgqvSup1@pks.im> (Patrick Steinhardt's message of "Tue,
	5 Aug 2025 15:28:02 +0200")
References: <cover.1754300389.git.liu.denton@gmail.com>
	<cover.1754375026.git.liu.denton@gmail.com>
	<d26f355c19c59eae30143900e218533bfeabec2a.1754375026.git.liu.denton@gmail.com>
	<aJIG4lZURgqvSup1@pks.im>
Date: Tue, 05 Aug 2025 10:12:52 -0700
Message-ID: <xmqqqzxpzo8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Aug 04, 2025 at 11:24:37PM -0700, Denton Liu wrote:
>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>> index 4e9c27b0f2..c2fcfeca92 100755
>> --- a/t/t5516-fetch-push.sh
>> +++ b/t/t5516-fetch-push.sh
>> @@ -509,6 +509,13 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
>>  
>>  '
>>  
>> +test_expect_failure 'push ref expression with non-existent oid src' '
>> +
>> +	mk_test testrepo &&
>> +	test_must_fail git push testrepo $(test_oid 001):branch
>> +
>> +'
>> +
>>  for head in HEAD @
>>  do
>
> Nit: I don't think it's necessary to implement the test in a separate
> commit. Folks who want to check that your fix really does something can
> trivially revert the code changes while retaining the test. I used to do
> the same in the past, but received the same feedback.

A very good suggestion.

> Also, I think we can drop the empty surrounding lines in the test body.
> Other tests in this file do the same, but that is not a good reason to
> not do better for newly added tests.

Yup.  The style was from a decade ago when the test suite was being
developed, and is very out of style these days.

Thanks.
