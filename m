Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E629BDB9
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792725; cv=none; b=jmLYrA2Ux4J4vi3GcLcdpsUSIjMerLv4kxy4TafDyhEJYKgFM9IDcTYtpSpGDAHcmIyevkCQDnHkfPqm53lCjrpe7GCEFt6d5zBhKmQbJTcz1ELazbHByWt2nQY1P3+dMiBmh9gVdJhGW2M7GGWjSeKYwrwShtLRgHY/n+LlCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792725; c=relaxed/simple;
	bh=McILrBBroMSUTbkyKw/8MmkEPG51wqX9BEh+hB/0p6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C1tcnR/X0vYrQ69RcBt36Ds8CTEa/Qplc4Ob1Z8bwOepUhrHfTAqXbhYBPjSXEa+rYjykTOtXPuWFFrqvsB9rGuwdThKG0JDk/m4KQEGa1KckenoItxZTs+27QK+rR2OPcU6YyWoxaRv0uBVSjESrVKLYlaDKhFi7qrWuBBglxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GwpjBm9z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j16PiRLr; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GwpjBm9z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j16PiRLr"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F5247A00C3;
	Thu, 21 Aug 2025 12:12:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 21 Aug 2025 12:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755792722; x=1755879122; bh=UPYFbFxVGs
	yAPqWJZ3JkT5cJBhAWlm/2bg2CWPPE3V0=; b=GwpjBm9zpC08egtDkzI/fO78QP
	npGd2K/fZDowshXWerDE0/SwNl8mzMJKlAwn+8q4xkFQYecXSmUCt/U/I9zB9mQm
	zoBdFZDxXcGaTJKj1Un27vjjprhBRU3/xTUsB+D+I08NG7bNmaCrMtQAYsHLX0vj
	GCeIWeYSXXMzCLm/nn41B+y6tBnNTynsJFFjUMENcLzzDFmz9RnmLMxXAPGuM1k3
	Qjmozs2vUdaxSgyKRpuj4y6AD4wuOrLkyWOu2dnyXE24qpmX0sIoyP2Q0AuQ6Uzv
	b1q/uftrKzwJgAqXSbUt8I2oqM8VBDWkWh40TBXJyL4afVdTFWzfx5+v2oNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755792722; x=1755879122; bh=UPYFbFxVGsyAPqWJZ3JkT5cJBhAWlm/2bg2
	CWPPE3V0=; b=j16PiRLr50CRw3pTMq7WBgXqYmf675Z4i8zoiOb/IsmWVPU1kBd
	TR6JYiS7XgOYPF1M38xs5/Pln7QW06c2dGd2tCpguxtbMCCmWVbh+QhMrVb2WyTE
	rtaTyT7dYytWFCPvvIajpoSXtKqVgUeWWRpYNQDmH0uefKPzIO1+W6pa9+dvfNwN
	YfY2fO0EN92DMc3NQX6+FjNEduRmOiAVs56DkRlfKtr/YkEZGfJI50EQSRPSWhOh
	hoV9VLbnFieqnFEFwSygMplznZ0SgQCMUwkBtAMAU+5W1YAkPjUxaY8bJvqCOJnH
	gMLMcCiIFgvepTzb3lbU4khMz8qvb8BqZ7Q==
X-ME-Sender: <xms:UkWnaIvF1rEtGqflUt4oM-GzRh5IkAcsTCqEB2DB9pJW9W_SVMzsdQ>
    <xme:UkWnaA-RI_f1B6d9AMCaMcs4ExvmlSauOnscOpZqH8DkLVo_oW2xZQM90cMbsTlEg
    kiyJZr-mArusrkNSg>
X-ME-Received: <xmr:UkWnaKNn7W_AgJvm0r6q-PU9kk4HlhUsKmp2WGYtQi3jdJk7c_NImQcq52gqhnGmHjIjmNVxwP_kFqrqRA4ZezBdawJfjMj5NHhpTDU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UkWnaGFPiwwTYJMYPBdCkNPJqFyLA3UDw2JWwV1XQwbNBYnMqxkabQ>
    <xmx:UkWnaARMCtBs4yfOooHyCyJfnK3KPy1lrT0dVUYpqohcPVeDaHoCXA>
    <xmx:UkWnaLs9l7YW8rIBTKTlhB5wM_C5GLxqcFrMzb_OkvnwvIxC_T3XEw>
    <xmx:UkWnaAKMsKk5eN9fKxJ0XYg7mwjHmCFvWxfThM3h1BrwBsGacc2g7g>
    <xmx:UkWnaBc0Uc-cN0fTUpC0toduGVqnxZIiu_AQPKO2Vs3PScX8zSwMgmpO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 12:12:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  ps@pks.im
Subject: Re: [GSoC PATCH 0/2] repo: add -z and objects.format
In-Reply-To: <CAOLa=ZQkV6FXCocVFdBoxbR_0eioQeY3hkOGOke+XWciLeZ+PA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 21 Aug 2025 03:14:10 -0700")
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
	<CAOLa=ZQkV6FXCocVFdBoxbR_0eioQeY3hkOGOke+XWciLeZ+PA@mail.gmail.com>
Date: Thu, 21 Aug 2025 09:12:01 -0700
Message-ID: <xmqqo6s83b8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
>
>> Hi!
>>
>> This patchset adds two features to `git repo info`. They are unrelated,
>> but I preferred to send them together to avoid merge conflicts and
>> because they are small.
>>
>> - The first patch adds the `-z` as an alias for `--format=null`, as
>>   requested in [1]
>>
>> - The second patch adds `objects.format`, which retrieves the same value
>>   as `git rev-parse --show-object-format`
>>
>> Thanks!
>>
>
> Just a tip: It would be nice to mention which base branch this is based
> on top of and dependencies.

A very good suggestion.  As this builds on top of lo/repo-info,
which currently is at a81224d1 (repo: add the --format flag,
2025-08-16), I queued on top of a merge of that topic into Git 2.51

Thanks.
