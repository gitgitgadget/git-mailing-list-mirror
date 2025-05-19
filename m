Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B620C477
	for <git@vger.kernel.org>; Mon, 19 May 2025 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747695703; cv=none; b=KXPTW3UC6aILAIz3ZPDEfQDX/xhmEFxsZB6PPq4xRmH2khNx78PxsthAQVOAT19QWw4/sugVZXs4IDv+3fMqfjpD739ZXktZQFYTZlp2ZuLsKGvJCFwS7bvu95tlkHDjO0Pt9P0OwG+sn4AdBDGTgsWC+jyWGFYBcURWQ9EOkC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747695703; c=relaxed/simple;
	bh=HTftjrTidsxptsQH18R4EtVKvfkKLgySxrxsGd7gZns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SVRU3q90/7vPOocpwqne2yItaVJ3WBIt3TH5xj3UMlNFKpvc35Pml+C7FHAQW7q1RA/RqaCw8EWJs1FapcccR270Z1xzNMhTpfW8gclaRijCcPkuSB7hHf6ja7jfvGkdfu/8rDi/oeRXgbQxzdo2VE9BFZA0gJvkMgWk/KF184k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V9tdJ3K+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cWkoJF5O; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V9tdJ3K+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cWkoJF5O"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0438013803FA;
	Mon, 19 May 2025 19:01:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 19 May 2025 19:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747695699; x=1747782099; bh=TaPswSaY6g
	AvIqxiUCS8msLZ9EX3C2Z6t1FhyLd4HyI=; b=V9tdJ3K+cdfWfUvt/Vw8qe+Qpo
	p1jOcNXIeHlOZcFgIjrioavtTziFwtNga5F4pb9NkQmdGrItYNNvhj5lfgKcEh/E
	X2aJdXj+z2Ei1RbI2w7uqcHg+X5uV6d2DvQRYpDat9QQolFuEB7z+p4s8F8+3Vhr
	ntFTyu11wzZu/pFbk/gj7vkmpww/o5riXDAaPqtjWiu/9GClMp0ywrTof8EUgnIx
	OGMi5iBvbQjgXWmyKqxw0xcBRyd1h+HAFeIuYn+IjiMWqZa4kYj8nwec5MqbMTKa
	OJe17iolHPO75QkDf2P8Rl3D9uOYaWnFRZ0s/HcvWD3q7q30OJFSOrmukSgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747695699; x=1747782099; bh=TaPswSaY6gAvIqxiUCS8msLZ9EX3C2Z6t1F
	hyLd4HyI=; b=cWkoJF5OT20tPjitGam25vuRsJ8KkcKaUYOG1wRPXoljMXVVdSK
	+FaZme9E983UzLTyz5UMxsPzZYk1C80AQP5Q+ymjUASr0yHrOaMb0iUn2IXuq1R9
	IAu2mmNI7To/AhiZIgzYfyRa15Y+XuzQvgBHO5LcB9Ho74JwdqGxNYgQozdXm/q9
	WNUU4VbKvfkptGy6e/njesgdZAUYZUVOWwD5ipdpwxmTqgj4l0iukagLA8D4Ojz7
	JPkgnBs7ColOXZC72a2o5jEFD2rah38MwULLRvrFBkExyUaTyGzkwM0l5ExfmdeO
	nDbD1kCzhudt5UqmiupH9FFCudYQr8ABD8Q==
X-ME-Sender: <xms:UrgraDjWW4v7IASmbwl98VC0lN7o1LhQrOQ1kxznC-HuK7F9-A-2eQ>
    <xme:UrgraACiJiz1f9IWKZjqgfmuq5e4Y5GYfgj57e7uWHSKYiTP5pzOa4iQK-PWtYKsE
    z9_3TRlPcn9OvGCnQ>
X-ME-Received: <xmr:UrgraDFSX9HcinMEEslj1mBMrdFI0HkD3IR3FL4CwMMv1pcVmLzpxRAXtHc0Xy9TfmdVRaNbAS38ZUT6IYwkdZAYif0ik9B-XfXb6-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtohhnghgu
    rghnhhhqgiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:UrgraARxfVH_xTgg5BSLF8SvwPbmnybTnFFPb27DCQzDEirsu1kPRQ>
    <xmx:UrgraAx75km8HgTHCk34dAKOk4HsU1NefoqyApSz6oX4GdhwDJ65MQ>
    <xmx:UrgraG7IpeELBp05ql2LzxNjzIVksd80m-aWWzBkv5YKG3i-73EjJQ>
    <xmx:UrgraFy8rqH-Ddksnig31x6eKNy7ECXNuUXvwY5KBRfT-VpJBlmgZA>
    <xmx:UrgraNdI5vCXc7QUEXgvKsDqOFqWd0GByTPAjRD61md6V8ezf88Ku4wH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 19:01:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  GIT Mailing-list <git@vger.kernel.org>,
  Eli Schwartz <eschwartz@gentoo.org>,  =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?=
 =?utf-8?B?Zw==?= Danh
 <congdanhqx@gmail.com>
Subject: Re: [PATCH v4 0/5] miscellaneous build mods (part 2)
In-Reply-To: <b5d5953a-1b1d-4e0d-a908-07c569fa59d2@ramsayjones.plus.com>
	(Ramsay Jones's message of "Mon, 19 May 2025 23:42:24 +0100")
References: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
	<20250519162523.1001478-1-ramsay@ramsayjones.plus.com>
	<xmqqo6vomo7y.fsf@gitster.g> <aCuBtP8-NmB0lKo-@pks.im>
	<b5d5953a-1b1d-4e0d-a908-07c569fa59d2@ramsayjones.plus.com>
Date: Mon, 19 May 2025 16:01:36 -0700
Message-ID: <xmqqy0uskxwv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>> Will queue.  Are we done with this series by now?
>> 
>> Yup, the range diff looks as expected, so this is ready to go from my
>> point of view. Thanks!
>
> Yes, I think we're good to go.
>
> Also, the 'make test' on cygwin just finished and passed without issue! :)
>
> Thanks.

Thank you, all!

