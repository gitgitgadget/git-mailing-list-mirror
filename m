Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440D31961E
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761940804; cv=none; b=hgliODvtATmYqbDPoWbMX9Wo/YIblaKuuWa6b9xt8E0fGSDDcNf3uT6JiBDe2KmAtk3jWKIY414iNdhsFsgMNMPQqCyQEyKV84hZs/K5wKDiOvOb9Mp3lwH2eeDq9LH4deillf9V0F6r3JAUtRRvQBqMF8/7A36ci/VFV/IwM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761940804; c=relaxed/simple;
	bh=W4i1/Mud+qDbhG/jRx2YWdz1QyD1xMNiuouHVdDMGFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t3j7WfeieiJYwRS6u4mImPiUbFxhZ80ZvVv9oF+3yG1wXtuMH56+Dbv3q6ZxGuAblN/aEovgUz4GBFxXf1Rpz88NwQJ/Zs/UKpRmVzEHAiPSCfSWua/8yn0vcS3ikjNg2B16GS9+MWPghKAsICr8dHQGsaI7T9DRi1O/YhvPCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JJDiHDoN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qIBnpByE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JJDiHDoN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qIBnpByE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D6FC14000F5;
	Fri, 31 Oct 2025 16:00:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 31 Oct 2025 16:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761940800; x=1762027200; bh=YusvCmhPG4
	5WcW5soK47GZjx7shluI4+Q8rTUrsILl4=; b=JJDiHDoN821U/Hh+DHNJft+Mme
	j8qLw8joY41uCmg086UlklCTUZ9nPG/Bp25RTYTt3WqUAUFICHwrhWVjqz0mgWOw
	ij9WKh81115rnEsPvnw/lUL2wUuRIQXpuH9mLxAvEsG5vXHNtbmeHSSdEegmBUdd
	5jxAv/HQP56pMtXg/6D6/EeFGSr2aq0hEGxhAwOSe8DtQ97++6GrO0i46QwW/4Dz
	os0g74hYgvKVqzspTPPuFpQ76cQzqvLG24P7Q2XeorO2U1DEUlSh74BGu7L5TQaW
	dvF24TrZc729Mhgh1JFfyumIoaW/wELpmRQzw2AyN/10eEHJjnS2kLWHOJWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761940800; x=1762027200; bh=YusvCmhPG45WcW5soK47GZjx7shluI4+Q8r
	TUrsILl4=; b=qIBnpByEA+NyL2PGswqVY7TXCHgnKNj2IvxpeWGOGvv/CxKThRX
	VspYwkXmY8rowA9budTpKQT0fH88MNAEnLXSg5+Han7AjlCJTKQs2hS5i9X2qnUs
	yG8DaNoT7t95J9irdKr890bHyk7Ux3i58taA/UltYIYR+sFwNxwqN21R++5AhB83
	ExTbezGlcH6/O5ZoN83QZdnvGfvyQHbRME4YfuiB1tNSeSZTReiTogwgDZ/erN1d
	2RmwA5O4iwvUMRVLrW3ESJBPYAFkVpl6mfzSxfEy2VksNV0r1QXUAw2VFw584oGX
	aRFtG294puwSHpPAd/Y2Q88HbEe55Ge6khw==
X-ME-Sender: <xms:PhUFadc8oRGLPA_-QBwb307zRs5fDOJ5Zyhj7vcKrwrYmXjySLVsSg>
    <xme:PhUFaVkmuW0Ex8bN472EFZ4_aw8n9TvPLgFJZbNn2KnLNDgGzffdWWq0xMQq7xr9q
    bVBFl4HAvZZPtegN5xz1PgMAj5xo7zAAE1WuXiZhAa-s_5da4oJ56o>
X-ME-Received: <xmr:PhUFacrpG0W_LqFOdBJ2VCKcSbhCnS1ZxOFAWEgT1NJ67g96NQJ-ZGImu4MCPVmEcT4OWsV0OohT22XJ9E2UhRENc9zaSGHuFTzM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrh
    hishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:PhUFaSErjU4BobIDD-yUTb49ug0jMGcNn7Hz5s33V3KcwA1tVrTzqA>
    <xmx:PhUFaSQIcjtQlQHNcch86ewgk4xswA_teTHlnKuUNMnmShEtsy_6zQ>
    <xmx:PhUFaYNCuK-qcxBVh9eM1kHO6mTegOTVVy7dIQa5Z6Vowqu3jygv3Q>
    <xmx:PhUFaflz3ahVXsGOfJxFyxINJw50qTfqpUSZ00CWXhjY1XDTvDkYEw>
    <xmx:QBUFabok5fh5-L9srgdYQKVLiJMTbi0EqxZa0Fesm5R9K77QrRuc4RIH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 15:59:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  phillip.wood123@gmail.com,
  phillip.wood@dunelm.org.uk,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v6 2/3] replay: make atomic ref updates the default
 behavior
In-Reply-To: <CABPp-BGmHegyqvN48vJO1Y9gWVDk5u2SO5_i9KMw2aoAtmNuyw@mail.gmail.com>
	(Elijah Newren's message of "Fri, 31 Oct 2025 11:49:31 -0700")
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
	<20251030191931.30837-1-siddharthasthana31@gmail.com>
	<20251030191931.30837-3-siddharthasthana31@gmail.com>
	<CABPp-BGmHegyqvN48vJO1Y9gWVDk5u2SO5_i9KMw2aoAtmNuyw@mail.gmail.com>
Date: Fri, 31 Oct 2025 12:59:56 -0700
Message-ID: <xmqqldkq266b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> I'm not sure the implementation details section above makes sense to
> include in the commit message; it feels like it's not providing much
> high level information nor much "why" information, but just presenting
> an alternative view of the information people will find in the patch.
> Perhaps leave it out?

Sounds like a good thing to do.

>> Test suite changes:
>>
>> All existing tests that expected command output now use
>> --ref-action=print to preserve their original behavior. This keeps
>> the tests valid while allowing them to verify that the pipeline workflow
>> still works correctly.
>>
>> New tests were added to verify:
>>   - Default atomic behavior (no output, refs updated directly)
>>   - Bare repository support (server-side use case)
>>   - Equivalence between traditional pipeline and atomic updates
>>   - Real atomicity using a lock file to verify all-or-nothing guarantee
>>   - Test isolation using test_when_finished to clean up state
>>
>> The bare repository tests were fixed to rebuild their expectations
>> independently rather than comparing to previous test output, improving
>> test reliability and isolation.
>
> The above paragraph sounds like you are comparing to an earlier
> series, which will confuse future readers who only compare to code
> that existed before your patches.

Yup, such an update relative to previous iterations belongs in the
cover letter and below the three-dash line.

> Otherwise, the patch looks good.  This is really close to being ready
> to merge; just a few minor fixups needed that I highlighted above.

Yup, I agree with all the comments I saw here.  Thanks for a great
review.


