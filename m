Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D094315E
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183669; cv=none; b=dXMYfAApXi746dBXIEyo0Zm9VncLLU4ERLPo/iqjLFn2zGTo2Q44pXEsIfBbnc86KQ6Ct9L9hjIB+Fks3dZ5hgZi5eYToNQmTaMVQi+R7UPH6EvuJu/CygpqYLOs9t6ripldykBkdALqqzvLe2Hq+7R1kKkitVAjGiI7g3yk6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183669; c=relaxed/simple;
	bh=NpxhaSQHntnC8D5glLc4Ty+Jm3UeoIt/bRIExncYU1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GE93ZAZLRiaD2enNiwNU+wvgIzV7jgclym7NwLSdvcBCfR5h8mDL2zpvpMBrjBWjdTyuQqi4ntLeZxhoW1LCGGRo0hK7twsZ3q5Yq+Zze0Cvn/d30zWh4B/5/suTmSbWcGUTvqV6f7y8bHYVDhasOO27n8E3wFX7OhgvSQ3rv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=feND7qqe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C1YMtA3H; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="feND7qqe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1YMtA3H"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D23E3EC01A5;
	Thu, 14 Aug 2025 11:01:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 14 Aug 2025 11:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755183663; x=1755270063; bh=y5tA0RKMbH
	tp4meQ337TeaWoUG6vg+kdbP8QLIqthAU=; b=feND7qqe3KUs0RZLry9umI7Xka
	5kJIqJ1YgXGZQhes5rVbd8VRk6kFV/ZgXAYt2WqVmH3MyWkX8gqhMrQ5m4GDelUE
	Bf/k7xB41wlavy1zKpRkdrv4LFMcsUkfCBRcx/x7YjBpYEFYV33Fcd0TYbEXaZwV
	kdkQMiFkIPfgIkBnXs34pMMzzpHWnkmcmdeoilLwjCGCc0E4dA0/47jXSzmF2Z0M
	Fs1fm/TwmpN403b4YpwEejBHqwmRebQbgwuxqSZKPwWrusK2LJ9Q21kA0+JeNB1e
	rvvJ75dywwS3Ez4coBKGWofKc4Rfi0p4Vh08YZhjCM8dn51z0mVI60XNgcLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755183663; x=1755270063; bh=y5tA0RKMbHtp4meQ337TeaWoUG6vg+kdbP8
	QLIqthAU=; b=C1YMtA3HmYah3IKj/0vkrty8l+5AmdRb/mlaHy1ISrF8oGuIpFP
	Yyfr21Dk3Yg09uFQa6nteJZcvM61CLyKmXUyPzhfTpy4DHrfVwcGBNaJtvQE2OHx
	ktoMkKtCg1KPWV9qNhEupwcsDt6U10BYRjrm2IssGXUHQCXboB0mVGWZCtEcIoN1
	U/0jkrUsc5bwI0KH/xPShcFdszaIvPclsEKbUopgJM5rfy9YasFbNYvFLX/5Gx6C
	FpPTQRDkaVtctZzelmHo41JEemD9Bvz42wDABQud8QID0RDRrB3hWvqJkgwwMLMl
	ygYwyQaqm8c07zxXtAhHRz2ZasEV8BSqsew==
X-ME-Sender: <xms:LvqdaKsRRVuGEGenUnWxgsGP4Lsft4TnwyQqLZ6vqp6_A_0WjMBRWg>
    <xme:LvqdaI5dLSupmTCZmiUwqq3CdoWe5Ybtf5m3SE66iHVLRL4RpKPoYzZ5V1dEXSk0e
    x8ii_0ylq-UKw5yaQ>
X-ME-Received: <xmr:LvqdaFW33NWrheT8NuekJBFnuQLb7N25osjOf6FhqTPT46pg_6mJ2JHHfi40ETivA0AjXmwPLYDbqUObh8bLasWSQAKyuOYcSbXiLt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghmohhnrghkohhvsehishhprhgrshdrrhhupdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LvqdaK-A95uGbRvAMeZw1hPwkPrRozgFMiJv8mtvp4YLdnj1o2js7A>
    <xmx:LvqdaBnrf0QupVRJTgxNQ8ro2DVlubSvxqU07fYL-h_sAqqtM-74Jg>
    <xmx:LvqdaIUiziMxz2f-w3OB85LYn5bx-Lor8PDW5a7dl-Mt49IaoI7Z8Q>
    <xmx:LvqdaOFaBSB2UhJQl9J9w6NAKWXAzOzobgGqNpELSSD4WLrNO-u1Wg>
    <xmx:L_qdaOZr8HUtkTy9OO9PRGGIWsHcYOkhWJc5y2V9teHsezKqefQDOjCi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 11:01:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] optimize string hashing in xdiff
In-Reply-To: <43459416-ced2-d551-40e3-6db594ca4520@ispras.ru> (Alexander
	Monakov's message of "Mon, 28 Jul 2025 23:25:07 +0300 (MSK)")
References: <20250728190520.10962-1-amonakov@ispras.ru>
	<xmqqa54oun5w.fsf@gitster.g>
	<43459416-ced2-d551-40e3-6db594ca4520@ispras.ru>
Date: Thu, 14 Aug 2025 08:01:00 -0700
Message-ID: <xmqqqzxe6j83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Monakov <amonakov@ispras.ru> writes:

>> Using xxhash() was merely a sample code path for technology
>> demonstration, so the Rust adoption topic may want to pick a
>> different code path to do its thing.
>
> My interest here is just speeding up xdiff in C, is that a welcome topic?

I missed this question.  It is very much welcome.

It is not like Rust-minded folks licked this corner of the system
and others cannot touch it ;-)

>> What is the licensing terms for that code you are proposing us to
>> borrow?  If it is anything recent in GNU, I'd expect that it would
>> be GPLv3, which would be incompatible with our code base?
> ...
> I have participated in review of Noah's patches and he kindly listed me as
> a co-author in the final revision of his patchset. So while I'm aware of how
> his code is structured, I had to write a new implementation in order to meet
> the contract of xdl_hash_record_verbatim. Therefore I think I can contribute
> this code on GPLv2 terms with my sign-off.

Thanks for a wonderfully clear description.

I obviously misread the log message of [2/2] and misunderstood that
this was a borrowed code.

