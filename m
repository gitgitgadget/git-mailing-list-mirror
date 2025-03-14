Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD11096F
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741915259; cv=none; b=TdCF8w3jbGQb60o8NbwjfbCLgFkY2ZvQUVFklmfLr66JfZC1G874pKR3C7iJtl+O2ajpqjK6Yp0MPE8xvHm25AWfJhj+SxNwhXKQaIjdcWNl0lOUv68DydztgVuKisomXpdTNM4pVMT2C+6fE1ivNiOOglRWdaEtafwD39hLom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741915259; c=relaxed/simple;
	bh=oDYvd6vWSD3amkWkcMMFJHg/6vBRff3giglf/b70a3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Io8bUzZUO5vVF6ScGQG+qMGb06K+VPkhghpxvYdzvI4tYhibbW/s36jVNEAVeoePQnZrwvZqjfVimOLHApfm2MCl8LyNhaZFlu91UMeMWUQjCeZ4hojNElMcIfhXEYOAHOy9IYnzzDNU6wBcPXnD1morOVAPvmwZFOGD8Ga5eYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hpWO8Vef; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pLnn2mco; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hpWO8Vef";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLnn2mco"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 522FB1140122;
	Thu, 13 Mar 2025 21:20:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 13 Mar 2025 21:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741915256; x=1742001656; bh=Dr9DXzyzFI
	L6NeM1ERRsvOtFSlxraV7ay5F35JfPHMI=; b=hpWO8VefSWLVl64xTeXkuLuxas
	z8YXnX/yZf5B/DkiNegUVxOHHtKlyzMVOFcg00q/Ude0Z+qgSo+RXxD4l8mtO6a6
	sZSqT4SimAztXCCr28SsDsO2QzjHVnz3ncrAVciSixpMPQcjm5qeFNDDyzxkNY3e
	eKhg70bXC4i+XAQdF6yqf6HBpRqd23+ZXOBI1uJWBelYL2k3Jd9mtjuxgZJSydsi
	o4hCmDn6yP3EDI8l6t7W8y5YcRk8sUc3wppzQqNz18Mck/suGcz4MxlCzDvDRPbb
	7BKawxHeqFEAHIiJzic/AKIT9u2tTPnNx4ferTrpiyXdYxufjqjXtVIUbpcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741915256; x=1742001656; bh=Dr9DXzyzFIL6NeM1ERRsvOtFSlxraV7ay5F
	35JfPHMI=; b=pLnn2mcozr5YG4qe4/uMoh+o6Q5mBG7lbDA733ymY1Vj/kQwr0n
	LV6s35hPlpu3boMsUh0/eF7U4FU7QmXFo+1oPjUrCF60lC+mWD81LNcmThyknceN
	gdILBM/+DeO62cFBt7cFvUcGJiHvCPcetTbDcvD0QkenXFklXbUjfjY7VNho5CNz
	UJKnduv2izMHjpNrtG4qcEIruvGp955y/wm0zaQZWhu/w+4gBw0B1H5WTtul++N/
	xxQhOqVOY0aXktH/cl7RkXgVrkrMOlJyvSE2ifzkl67jWpwNGD5ThMvBfQR6lDWc
	QTHC4EvKIme5hHztDocAFWmI/SW42MDk9Zw==
X-ME-Sender: <xms:eITTZyUR682fn2FOx439jGeFvgyJvo9kzTKKOvB6x_oJT9cjPBELYA>
    <xme:eITTZ-mmjwrDxbkp4PafA2KCCfkKgKRRO2bF1fIiUEO33ZXBamQW_RXeDaVnSQh6M
    4wQY8pMBO7yLcclOg>
X-ME-Received: <xmr:eITTZ2a_S3PLfy71HFwILpyumE-1Be7jq1whtNB7kcpvSC1Tto9xUXFXn9yUVcrThNgqEnlZ6bqDEDulbx8a5dMbCEiCXkzobzRyBh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdelgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eITTZ5WOIVCWL6zNAXk9YrRIVI35JJeGUYDngqyfzMeAKJqZcgPaqg>
    <xmx:eITTZ8lXAygSAxqeTcjahXd5ZK79uHF4UMXgZbh1F2TE5by9BVkQ7g>
    <xmx:eITTZ-eSfcbIEqWS5bQBE4HJmvebE2ti6ZGIQsx5IRq1lNpxGZhXXw>
    <xmx:eITTZ-GnBIevCW4dUq1RIWN8tPOjNp72GiuVdl9_8W07XVg7GEC79g>
    <xmx:eITTZ7vLdFxsw3QcVQZjdEuOJGhRD4rRkW6yF4Fn3BQNPYorL8AGewGL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 21:20:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] ci: add build checking for side-effects in assert()
 calls
In-Reply-To: <Z9OD8ihB-tiCdBmp@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 14 Mar 2025 01:18:42 +0000")
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
	<80dcc2ba3aa0ef72abe18f8525d571ea39ac6382.1741911652.git.gitgitgadget@gmail.com>
	<xmqqy0x8l8tu.fsf@gitster.g>
	<Z9OD8ihB-tiCdBmp@tapette.crustytoothpaste.net>
Date: Thu, 13 Mar 2025 18:20:54 -0700
Message-ID: <xmqqtt7wl85l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> Is this something we can use in our project?  I am just double
>> checking.
>
> I believe it's valid in C99.  Certainly some compiler might be bad at
> optimizing, or a user may have compiled with -O0, but this is run in CI,
> where we have known good compilers and can control the optimization
> flags.  I doubt GCC, Clang, or MSVC will have problems here, and since
> this is not on by default, users using something less capable (the Tiny
> C Compiler, maybe?) or a vendor compiler won't even see it.
>
> Was there some other case that you were concerned about?

Licensing, mostly, as clever things we see are not necessarily home
grown.  I know the patch came with DCO sign-off, but it does not
hurt to double check.
