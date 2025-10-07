Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E32E8E09
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858691; cv=none; b=LalsXlVZR5Hw3KBV8642pNr3l9EzfSbXbv/DR6QblZ66opFv49Ande+O3TNiXqgb9vVeySYhRpTcjgyUDMEr425hAyQSvunnWSoVk1d2/lN+irC5it3vgKrUvEnwkHHp6C+qKFzpzIDCtkPCIW9frBV62SjAgDS6R76TnBO8eIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858691; c=relaxed/simple;
	bh=nW/mTFogtyCBzlvUAO2wcfeselmuKbBbwXhYcKRUkPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dBLzHFoSjX/SHie+tWRTI21fIlNJn6R86oyIpF6tRYb8Rb1J/FSIF8zCBZTxJPKJ0vuKngDVbWECL6ghf/WVn8Gci3iOIrVmJ1N81VWYA4SbXPlmH0O0F+cX90q1YD4WHmWIuAyAae+AA+CbmJK6/2Ra6l1koU9qC+heM7psYtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cLWU/GM3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JSxiiY5t; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cLWU/GM3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JSxiiY5t"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3FC137A0271;
	Tue,  7 Oct 2025 13:38:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Oct 2025 13:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759858688; x=1759945088; bh=Z9Eiujwm3h
	pDASWJ5q/6MitUMABKPluVgCm40X/ItcM=; b=cLWU/GM3iXad/SUjXcjdK8I4R5
	QfRZAFcXDW9XwXsBT06CFHoro5hjDzqtT0/ObOw4PvJ5mxzSi6LoJfRJS+5//x+t
	f/5hovQznj+9FRSxQp1xnqkRAuhkhzzGm6T7k9HLFvzzOmcn2PVcDf/nIIF4cnVi
	fwKgS6jthlEhRhKNFQdHfSJnTzZLpce8m0xsfhQn0Q1ZGhru22uiaEIGKrR3mLCq
	AxAkbaMaxjzUdfs+SqncshxDGdECNbUlfPWoqVQxGXZye8kVBEWXls6ZduJXf0Ub
	3TxwvrSGjaWH/mVILpJ0ke6ZmQBe3R5QTCIs5nXpPwta94XnJdiDHlKcR+WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759858688; x=1759945088; bh=Z9Eiujwm3hpDASWJ5q/6MitUMABKPluVgCm
	40X/ItcM=; b=JSxiiY5tJ+6VPkeSGOlBXXaNCI0bozRkOSSEvOeO/l5DUPVII50
	sqU4JqRNWCutOZ8sYWxj7B3utv25dIDXyMhtC9/FaEeJgXrq8VbBreCsjNE5e9oI
	Mdy5whADcni4fRnXKGHTD2EWfGmaEnHwDWouZcQS+J2J5gl6T4hRPO/WnjEU1tEs
	xUItCt8qM14OBA/1noM6YBur5LDkO/LeTwXao9AK1Q/PyWEGyrPi6AU9NZte4hbU
	XSaBLAQRahlUbZVCLrb27VdHcCUJ/E1yDS+6v9urubCxUThyQEYk+ngYl6+cg2yY
	HW2lJHs475kyDrqXEpCggiNPQmR4YWevWpA==
X-ME-Sender: <xms:_0_laICeIKsTQ5Ir6kUIaxmRd4hY-cvvm4mJwMRVNuMZRpSG4jYgxg>
    <xme:_0_laMyAGEhDDdWnS_mqvPNtUvSKLi8U2JDPUQASruOFNpzNwAk__KboIvnQ9zQEF
    HubFe-r9x1jyulJg9hXcYQ9a5rq05Jri5j6SH0hbV1oWYuDmuen>
X-ME-Received: <xmr:_0_laN36eUXQZm7FpFC-a8Q7j-zHgNtkwiphklLSu9yDB9goXoN-j2PfkfUKrBm-rQsaLhyO2brgnKrK2DWB1uBVHb-hI3iehPf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghrihgtshhunhhshhhinhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_0_laEzMvaRshPFVT6eQsqAf2WSou6gogDNZcxiDdxrs6XDgWcCprw>
    <xmx:_0_laMEYITDsVEiODc12NTGPINKtzdx7AigMQC490dD6-ol6RWVKEQ>
    <xmx:_0_laPZPjrxkmlyKqbr6oxZEgOLMIxI-2S110wIEvPysf-a_8LRkRg>
    <xmx:_0_laGBrEaOJsV8-Id3XKb2GHmqxfS1J8IOR-FKxtwU-hO5Tinw9iA>
    <xmx:AFDlaHACQZvy4L6jrB7dKdxoX4HXU60INDVeKMSDmdvWlBqCLys3ISx6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 13:38:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Ezekiel Newren
 <ezekielnewren@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
In-Reply-To: <CAPig+cQ7xJky+F=g=NMrN6BQfP+ZV2KF4RF2eLqtULKgMTR5_g@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 7 Oct 2025 13:13:18 -0400")
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
	<20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
	<CAPig+cQ7xJky+F=g=NMrN6BQfP+ZV2KF4RF2eLqtULKgMTR5_g@mail.gmail.com>
Date: Tue, 07 Oct 2025 10:38:06 -0700
Message-ID: <xmqqbjmik3y9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <ericsunshine@gmail.com> writes:

>     I bring this up because, although it hasn't been such a big deal
>     with the existing C code, assuming that developers run `rustfmt`
>     on the code before sending a patch series, then this may become an
>     issue if different developers have `rustfmt` configured to enforce
>     different maximum column width, especially since `rustfmt` is
>     likely to reformat the entire file rather than just the region
>     that has just been edited.  So, if this code gets checked in as-is
>     with these very wide lines, and then someone else, who has
>     `rustfmt` configured for 80-columns edits the file, then it
>     becomes a problem.
>
>     As such, can we also add a project-wide `rustfmt.toml` which, at
>     minimum, sets the maximum line width to 80? For instance:
>
>         max_width = 80
>
> Later in the same thread, I wrote[2]:
>
>     Project guidelines have long suggested 80 columns as a desirable
>     maximum not only for C code, but for pretty much all other
>     resources, including shell code, Perl code, and documentation
>     files. This suggested maximum works well for adherents of
>     80-columns and (presumably) hasn't been too onerous for developers
>     who use wider windows; at least we haven't heard people clamoring
>     to increase the suggested maximum column limit. As such, it does
>     not seem far-fetched to expect that the project guidelines
>     should/could/would also apply to Rust code.
>
> Unfortunately, what little discussion there was petered out quickly
> without resolution, but it seems that it would be a good idea to make
> some sort of decision earlier (while there is still very little Rust
> code committed to the project) rather than later.

I do not see a particular reason to lift the 80-column limit for a
specific language, whether it is Rust or AsciiDoc.  I myself use my
terminal set to slightly wider than 80 columns these days, but that
is primarily to accomodate the fact that code in a patch that are
quoted a few times in the discussion would grow from their original
line length, not to write pieces of code that are wider than 80
columns myself.

Will it inconvenience wider Rust ecosystem when we get big (meaning,
they have to work with our code) and we as the project norm use
different line-length setting from others, perhaps by looking too
different from everybody else, or something?

