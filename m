Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365F1A08AF
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598184; cv=none; b=hjhWcQwC/eEL1RzSpWc/iMJYnDfmCLfH9wv2SxGli4VP2XxwRhqnCgZC+O017oojB2UEE1leSPBFvgFQn9RvLevdRY2IQnRL7Fd/PUi4fxtXWPyXKIaoHTTzXORgA0lrsYjmtEwiKwNrli4mZV7rYG8mwuU5xbO6Y5Kx+vSwpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598184; c=relaxed/simple;
	bh=w0SC3NONzq9tO1Rzar/IRMwD5CracEnE5iujxnuK+Z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a/GEu83wtCL2cxqLB71DZy+4q0DvmAkNtsypRM2n9ZRstBGnKAk4mpk4hsURPzeN2zCHx8FB1xCdIE0ULzve1QN3yWTyN091XdvULeA5D7GvZgQWEAvPNrin0cOdtw0mhK4+lJ6BxALA3Y1FBXYlcfdfX3EUqa9Tftnkc/9TBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SeDskzSM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oXGmzD0c; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SeDskzSM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oXGmzD0c"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C69FEC0090;
	Tue,  7 Apr 2026 17:43:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 07 Apr 2026 17:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775598182; x=1775684582; bh=gVbDJruWZE
	FFLzZi1t2hea2m/GfTTjQGn2HGGLRVd9g=; b=SeDskzSMMoyeOg1mhehOiXmgm7
	eXv1VMSqJzCfzovJyGsLs9schXvwi0zzQHNpKDkh09+BXpI2uOZeFsluMRJS/pJ7
	VOaSGj8wvLgKRGvm+g7S2PGNx849mxgMG/8HdH7q/TYgTJUnAsD10LXuXO6sP/cA
	FhR7GAStMfrQRVNaFQG8hySuZT7qihajLx4o20pO/TdJHVojzyotcx/4dRdXbTYQ
	Kn5RUzRlSTccYlNTmzxGxr2TGIji1SxOmbe8Z1S4EwdKLYO5kjQKGgRQXoCTeOOu
	iIOqwEcltMM10E3CbF1yS6ElOfCrs4NEk/4/HmP0iGTmSORXC1IVUiW1tcJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775598182; x=1775684582; bh=gVbDJruWZEFFLzZi1t2hea2m/GfTTjQGn2H
	GGLRVd9g=; b=oXGmzD0cms1YNRr4R6YRakQvuKQztbEu/AGxT4W6CEJ7OJKe24b
	+PSeSUWoNGZHJBPo7XiuSkSusF4rg2M+XRjUOpuVXSbVzdk8srRBLU8GhEoAkA9A
	unAaU3LtD5Gb6P7KBXo7xp/Wh9YJ4CdWVhqcVZMzS9LPT0nWK/nt4W0iW5+EnY9k
	JVr608NvVMKEUOqHIa+mx8VE3kMuoDNeRO5xkNY4CdXoc1BPYu0R9oqmjFyaVRyP
	JdTegSdV3QC3HZTBQMBqS9kHFpum6KQ0av/hR6EQY5LF+DxNPfkmSMeoSqQ7nDi1
	rUTQiu/IfKUMtpLRODvdHEwjWbUdQimsSaw==
X-ME-Sender: <xms:ZnrVaZWparJqDOv8f84z_KmfusT76VZiF1RJMFgkace2iaOdVqoDfQ>
    <xme:ZnrVadRTk06x0WeAtuqRaWNV0hufkhTBEZt6VQDRoMAn3mL5Px6e30Fxgx4FHSCVa
    FvnziqCTMf8f_tof7JMY04tsa3AIuAVcthY0k8EIc0DUPls2cI2_A>
X-ME-Received: <xmr:ZnrVafODPjrtk9vyyjU9RkYqjPVIHIl21sP--LsTKx6WuL9IlEmXYWQxjkqsjO6mPFStah6XKiYJpOCEXXegAO3xpBd3NkcezA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheplh
    hutggrrdhsthgvfhgrnhhirdhgvgdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZnrVaTTwGzlN3mRYNtxOFYzOqUbCrTTQ2HaoP_pzlhJoj1r7Tq9wEg>
    <xmx:ZnrVaVjNGVn5pg6tmwoc2ad8bdf2AwmfD7wm-oy0Vh4YciIdqvu2TA>
    <xmx:ZnrVaU-dyUokNlW1ujNLXcYOLCUIC9ENzOta2LfyH1ZMMQs-1ptFsA>
    <xmx:ZnrVaUFrCZAQfkswMBFzuBcCk7LW3Wyb5YPkQYzeBV8Aj5hYodSWbw>
    <xmx:ZnrVacESLwIaxqx2lWsq1QuYa0mxvVwdC7VP2DO_5WhmZaKa1sjuJJ_r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 17:43:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  luca.stefani.ge1@gmail.com
Subject: Re: [PATCH] object-file: avoid ODB transaction when not writing
 objects
In-Reply-To: <20260407212930.GA1315247@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 7 Apr 2026 17:29:30 -0400")
References: <20260407201730.2526914-1-jltobler@gmail.com>
	<xmqqo6ju31wx.fsf@gitster.g>
	<20260407212930.GA1315247@coredump.intra.peff.net>
Date: Tue, 07 Apr 2026 14:43:00 -0700
Message-ID: <xmqqjyui30rf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
>> index c824c1a25c..c1dbc6359a 100755
>> --- a/t/t1517-outside-repo.sh
>> +++ b/t/t1517-outside-repo.sh
>> @@ -93,6 +93,14 @@ test_expect_success 'diff outside repository' '
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_success 'diff files exceeding bigFileThreshold outside repository' '
>> +	cd non-repo &&
>> +	echo foo >foo &&
>> +	echo bar >bar &&
>> +	test_must_fail git -c core.bigFileThreshold=1 diff -- foo bar >actual &&
>> +	test_grep "diff --git a/foo b/bar" actual
>> +'
>
> This does a "cd" outside of a sub-shell, which affects all of the
> subsequent tests.
>
> We also are already using the "nongit" wrapper in this script, so it
> could be used here.

Yup, the non-repo being somehow outside any repository is also used
in the test immediately above this one, so I am inclined to say that
we can just enclose the whole thing inside a subshell.

> Thought it was found originally with diff, the bug can also be
> demonstrated with just hash-object, which does make the test a little
> simpler.

Yeah, that is true, too.
