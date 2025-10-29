Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A102E6CC9
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779531; cv=none; b=uJk9mb0puybYthuCfyKRUOsBmiNYzD36p1D8WlECP694xEiLglQ/eNJYUj+lvUGNzZEAd9s6yvYcWa3YQdLAmaj3PD9HGbP0VyaQWRcjjpzBPZ4Eekn0bD6XcSV/p0QUMI3atT5ngVtGq2ZCrh6EUHPQx06f+in/OJchUxwq0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779531; c=relaxed/simple;
	bh=Gl3XAGj4GAWaoQYyFunXA8VzAc3TUhXfdgKOBVnIghc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=REtXszzK0SncrtILtz7cELnFWDKS9xTK1RDDeCM0SbNAhhyvq7C5H0AVjp41kDRRTzCtNqGBb54tINapKjiQwmKK6LF5+ztFvSCU6K7ePr99z22wGNt0DFV/sN+rj+w6h+OgsvyzWf39jUZx2mCTiLWdR6yyKoe1pK8yBfPFaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L1K+M1I8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TTCeP4W+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L1K+M1I8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TTCeP4W+"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C8797A00FE;
	Wed, 29 Oct 2025 19:12:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 29 Oct 2025 19:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761779527; x=1761865927; bh=5eYjd7cTnS
	cU/Net8gZsEqNilOU/5Oj6NGb2He9Xw9s=; b=L1K+M1I8oR2tL8okQcv5vKcYrK
	4pxhIEYP4Q/+fTvGNTmADj9JBYf47LyiJp5ZMlGT3ORxMFqrcrbZTvKGZBv1e/7B
	MVUO314OGJO1FYXSkL1bGg/xuH5ZNPq2yh737BMfxT17Zso3YbjRQQouyIeWo0J4
	s/ux3Sv9tnWouVHSCs0A3bGP1B/8djZHqBq2SJjXLaJI++fXdKWEJqAPTGDp1Io8
	oeOJawPnEhNFxMzg4eCWD5+4gvKkddm/p2kxV1V0g25WFKLWi15/d5759TYqbAOH
	0yaKpb5QOktWgIIcrEz+9kRAiLnUC3YmjEvKCneGX6XftWANBwIJooeh6kwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761779527; x=1761865927; bh=5eYjd7cTnScU/Net8gZsEqNilOU/5Oj6NGb
	2He9Xw9s=; b=TTCeP4W+ErWrd5MqLTLV0GhVaDAkLtHZmHbnpw9rsZR6MNIGqxg
	xrf1L6ZJdkrRr9Bx51XiKB40Y4z3whQluazcNt2KzTiXC1Rw3y4MQ97nAHplUSeZ
	KNA/yRVSi+cY2+H5HsCP4nGajyHwl8trIL53GK56tJLwVY7PiFGUpM0qTIzUPphm
	e7v9oblZQeSOt8klYgTBmFESMiKVVrhmR/3AaRpG7r/7Ougr4aIoKx3ZhSRIQcUp
	juCEpvFDhP7pPEQ3gME7DISEh/C2Jaiu/4zhRZarQk4xrh8ZX4E0V/IVJFo2KVDh
	+7GXzuf5+5o0E5js+TJaFVSv1tWze89lxQA==
X-ME-Sender: <xms:Rp8CaUUnmOR0ZxxYEq18myK5fd7PXRjIJH2LLamHsjuvIfOEma6klg>
    <xme:Rp8Cafec2SyTsgmgBpAOwCR_2LtA2n4XXtXU5aB2jvH0yUtkqVQ0NuW4Pc60Niish
    lzghss1Bzkq8HEWBlrqxVQ-axhat3nR1SbT_YkNQhzNFUjbVMjdiyQ>
X-ME-Received: <xmr:Rp8CaQtSdCT5XEVkA7xor_ui89L59lmSb9VAUt-jlLKowY7Q2zA_P008gCUDmkOVJmx7DR8oSmkIWrz6ri3zsqATjHtZaNRzdyvy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:Rp8Cae_6AbkaTKlTIyZiXw6VhQ_V7VtIxWccaxCJQDGNDg-8qn0rYA>
    <xmx:Rp8Cab1OtFjBPBb8pVKMotqGBqTeRvf1K5OmpAfrvze4CnvnrWOB5g>
    <xmx:Rp8CaTCuu0Mlw5GDJ5_9jBkg3YPlxu7vdOODsJ2FcZdmxbyUd1ZiIg>
    <xmx:Rp8CaXeS4f8E0xU0n0ooRh_NN2AnSme5raNIET3ydiqNOUMHBDBtaw>
    <xmx:R58Cacv9XYu-3QQmJawvxmEguNyih2NKqT1vts0sWTMyMyE2zFXif2Tg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 19:12:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 10/14] rust: add a build.rs script for tests
In-Reply-To: <CAH=ZcbBYRiceXQ-9FNq0aK0WzN4nDhqonaoafweStC37mx7JBA@mail.gmail.com>
	(Ezekiel Newren's message of "Wed, 29 Oct 2025 16:10:27 -0600")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-11-sandals@crustytoothpaste.net>
	<xmqqms59acak.fsf@gitster.g>
	<CAH=ZcbBYRiceXQ-9FNq0aK0WzN4nDhqonaoafweStC37mx7JBA@mail.gmail.com>
Date: Wed, 29 Oct 2025 16:12:05 -0700
Message-ID: <xmqqwm4d716i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

>> Hmm, I recall Ezekiel earlier arguing to roll reftable and xdiff
>> libraries into libgit.a as it is a lot more cumbersome to have to
>> link with multiple libraries (sorry, I may be misremembering and do
>> not have reference handy), but if the above is all it takes to link
>> with these, perhaps it is not such a huge deal?
>
> I think Brian might have written this before my series was merged in.
> ...
>> I am a bit confused.
>>
>> XDIFF_LIB and REFTABLE_LIB are gone from Makefile on 'master'
>> already.  Perhaps we should revert earlier series from him?
> ...
> I don't think we should revert my series.

The order of events does not really matter, does it?

If we can happily link with more than one libraries [*], it would
give us a much more pleasant developer experience than having to
roll everything into a single library archive, no?  Or are you
saying that the way this series links these multiple libraries
somehow does not work?

You somehow manged to confuse me even more ... X-<.

