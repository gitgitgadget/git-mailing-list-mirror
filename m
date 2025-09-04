Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4DB1940A1
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959008; cv=none; b=jrbRnNRCLtaskV7UUUdg50oiNR0584Xfvbb2uP9UeYMVSncFzoNGQZL1rY0YQHX2OlNhEJgEnvl+VLj7osXIDKU0vvHyF+XM1w66xVrahYYr2DCWnMDHYbHC8JkyZX7pkCV+UG5PYl06Jf8twglT1C2VvDB7gOOYwljj+nhaqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959008; c=relaxed/simple;
	bh=mk7MNdHr11GvJhtDnpFCf3us0wXELL/XF4VEJRrAXSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VSEOYnE43afnyyDeF/0fgmstDVt4c5izq15Ts8wUWCpKtpb7GU2gTBPOvmgFHp6Bz7Qbrc0qCNtpLJLxEFlO8+nmRMV0Km1baAshaAjMn6worjonhIiPD5kr8mG1w8LE4WRBBQyYyBoBXUcVXASIrp/PL4dZ85h9CBWJydynoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U9ehRmv4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FLxKn/pw; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U9ehRmv4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLxKn/pw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 00739EC01FC;
	Thu,  4 Sep 2025 00:10:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 00:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756959003; x=1757045403; bh=Q4hk54Y+UY
	WjW4JAAljAVyIedFQl43+MB/CSglgKmCk=; b=U9ehRmv4O/VJgOuGQWSO2IpVM/
	VOthlcAS+gIMh5w2gU6QOb1H5ptGXrwCOqXjD1cryZTrZtHFns6BSpZI7OGk37mo
	p7+64hcYisZFQH5ynPcbyL+ix2Yi0NneGUokuaWwOy86qhT+WzQ5VwaRik7KV3/Z
	czhp6SeN4bbBvUp6jvBv3l5rLO/y7r4liMEmcwikg1zefaBfTenp4uoWUJEQyz7L
	T0Zb9Ls4KBfajIc/y3+AUn+NJkdEJOWIfjdIgRoZSAFCtcDf5QthJjGk75E9caZ9
	nMQV2lIwzIuqgR5xY0PPACaTEotGWuIRVohJEbURQev7P1cmrOYGiCIlGfEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756959003; x=1757045403; bh=Q4hk54Y+UYWjW4JAAljAVyIedFQl43+MB/C
	SglgKmCk=; b=FLxKn/pwZ+g7Bpakj32BWzTErrUg0HkcvgLqfyJAdEZyuFFVCXD
	JilQbJaEBlC/6nutlLevMkzFI3S/yVSEdzr9FCEIbRVdQmGZOgKqB3jLL0GTfzzO
	H77MsXAFNhAkJi/QD+nTNp6tfkjn17odhjKN108hImVmFVwLqS2njzthSCoG7y0N
	owJi2vblW9j/pJn9U+AgdU/YR5TtRjBcTMQWw/Sxix2pDQGvbRmWB3T/1tlihMTc
	5ZunJA1snQbv1trp91j8qnGprjEKw6wLWNJv2+XFBpbsMQ615vVsrVbWqUhQJn7Z
	Q3DTpxKQJgA5mAqfa4i0Oo5G+pV6HZeJHAA==
X-ME-Sender: <xms:GxG5aD1p2Ic_IE8R89x3MJfIDv_QbhDoqmMBTfl7EyhlpeGD7wz1KQ>
    <xme:GxG5aNkvANPejv8mCAMHR5QBcLfRhxYEW8sAmnGxa1fKT0GM31vuFcqcNlPjBuJec
    Hub3W3KsbBEvfLNEQ>
X-ME-Received: <xmr:GxG5aKV_vtEA7byMdbW47u8f149sP7M1mvryZXtf4CXU1ymSMPHijz8yzU1JCJojVNdVHouiwaSy9H9r0DS5PJaawELNygBlF6h7z3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GxG5aDtU_Gt5w26aAmG8zEXhYrnXMLc-C40zEHmHqdxCPjJ3ekUh9Q>
    <xmx:GxG5aNY4fYKtsxvaXeWDrStJN7xq5DUC9_IA2d9cZ7kOeae_6nqtbA>
    <xmx:GxG5aCW_4l8fJjysVthMZWxQeLkWJ83DTCMx5Mg4hAn0aIV5HsdTRw>
    <xmx:GxG5aCTi087zHfI45HtdndvuS0s-qKy_xq-H45zt8P3QQHuBjHIcjw>
    <xmx:GxG5aNHaNqHpMwnK5uU4nrZwAI3lZW0dkP68V5mQBNFnqODH8NUqe7zU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 00:10:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] t5530: modernize tests
In-Reply-To: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-1-4e019af4dddc@pks.im>
	(Patrick Steinhardt's message of "Wed, 03 Sep 2025 06:54:10 +0200")
References: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
	<20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-1-4e019af4dddc@pks.im>
Date: Wed, 03 Sep 2025 21:10:00 -0700
Message-ID: <xmqqzfbac0yv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> -D=$(pwd)
> -
> @@ -21,11 +19,7 @@ test_expect_success 'setup and corrupt repository' '
>  	test_tick &&
>  	echo changed >file &&
>  	git commit -a -m changed &&
> -	corrupt_repo HEAD:file
> -
> -'
> -
> -test_expect_success 'fsck fails' '
> +	corrupt_repo HEAD:file &&
>  	test_must_fail git fsck
>  '
>  
> @@ -40,17 +34,12 @@ test_expect_success 'upload-pack fails due to error in pack-objects packing' '
>  '
>  
>  test_expect_success 'corrupt repo differently' '
> -
>  	git hash-object -w file &&
> -	corrupt_repo HEAD^^{tree}
> -
> -'
> -
> -test_expect_success 'fsck fails' '
> +	corrupt_repo HEAD^^{tree} &&
>  	test_must_fail git fsck
>  '

Both changes make sense.

> -test_expect_success 'create empty repository' '
> -
> -	mkdir foo &&
> -	cd foo &&
> -	git init
> -
> -'
> -
>  test_expect_success 'fetch fails' '
> -
> -	test_must_fail git fetch .. main
> -
> +	git init foo &&
> +	test_must_fail git -C foo fetch .. main
>  '

Nice.
