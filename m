Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D618730F555
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686166; cv=none; b=XGEA7t1ZFESRdWR6fyVUabLvIu6mFaiERZXkeBzsfHKTP7QBcmH4xeVEro3JRBYLmKy8E1atD41amE1BbhxPXVNP9GTITjK+4TWBBSy5PX33KhWWuSvSRk1G+nGDAYWY1Jlacg3ZeJMFQrL8YxUfWnUHcUuFcfWk8xSdNSlRl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686166; c=relaxed/simple;
	bh=kSWM78nPaji5w9ggpidIV30zs17zkXOMc3AZ+3HLdyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hv+2xBlBgVr0Kix6PatOYYjybij9rFP6BUHlugfeL7IClEL3CJ51yt7SZp/rWSvbs0rOiPPWk/e/72fG0qso5SlJFUzRN8ClvRImlaGHH7AXMjLFgcHPVqyvcBvM6VSv/I9l9NqRVtF3QWDxiSHivjnI8L64m2f0Cs1yBztXsAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UmPuAvJP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uv9BlSro; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UmPuAvJP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uv9BlSro"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F4531D00349;
	Fri, 12 Sep 2025 10:09:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 12 Sep 2025 10:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757686162; x=1757772562; bh=HY+BWBWaUd
	L1+GhaLJlBNh2q4zh2Pc0TDg4KhivS1a0=; b=UmPuAvJPN6nqOtdZIvJGtXuExf
	YT6rDW3OLCARDDhlVkZ2Zq/OQrDrW+UufTijEZf36HkIUy22xoLc7txtVH+pdQRi
	kWAO7KoYOVryMmzkI4JDwj0VGZxzG9rARVZjwEos+6TYrAKcZLyRB+uck5eoinQs
	3n6PrVLXHhyHz+qhA9V53hjQejxRI0VM3568irDs6pSrFMBdE+hDZN+naLCkAHpQ
	O29bzIPXMY8UM/AfF/aBgdcZJpQdy04wPUKgT8T1dybiD5FYIRcncSVEUqiI1JnA
	7ANvydJOaTBMC0oVRcrnYAcSBTvLrNkQiAgryF+oIG0N23eH5Duk0qHtgr3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757686162; x=1757772562; bh=HY+BWBWaUdL1+GhaLJlBNh2q4zh2Pc0TDg4
	KhivS1a0=; b=Uv9BlSroMLMfz5LfvO7BRrmamAudnQaag51u07y3RNMg0WNB8LM
	2Zrq05m3lK8D2OrVSVMxbJcDomWSjOEn/tjYq7MBiQ9WDT56+r6WJCbRQVAfyFGv
	33TSpoGzcQ/PVpTKVoZ+O/RpXRdWO8VSJGeyImPTk15rcM8CfEKBeB4JqswdBS7r
	qIybnr8DjdHJgn4iM7+KPBpfng8YivXGGbr1k15c+V/yfJd/EAytNE6Tto8t7Li+
	GbtdgfXkCeR+wKws7OX6N+4IpQPMy9dPH+aCTvKUZXsbQo5VDnhrbQNyEtzQdlnh
	5OSoYVmjl5uIdtsDEKhFLEcu+0KY3mf9Mbw==
X-ME-Sender: <xms:kSnEaLMev2pBqrifE4u_hKhz6EiGJTC3mbT_OQwDnLa-t8Hdx3jicQ>
    <xme:kSnEaC25FjdsAvwnHh7_u_b96N1kIVHCQ0NMWfhaZufnO57LN1h_sSIzvBpKmwD_w
    E7QEDF1yzka4hhu1w>
X-ME-Received: <xmr:kSnEaKD7E6hzO_6y4n4QqE_k1DFV_vPIelt9-GQjcHF-wDX58T3Hs2bFj5HL-dYEIeRAGLlv99uU98kAy5tmm-W5GQAripGeqH-V_jk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvledvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kSnEaPISlL0xfuSYLsofmSS-7PPz4YXAfVWFL79lFIuTwUd7xPobcg>
    <xmx:kSnEaDkzyyUhArT-olkIz33a1wbKIonFVcrBD1CW3vQRdHQ-ZIulUg>
    <xmx:kSnEaIYBHReiaAlnuiFu3JlAK0z-fcJRwg5Niyccj-vcCMrM3fHSRQ>
    <xmx:kSnEaP_wC_ohYKvk82X4DzROZHr-TT1RIL00o7h_9G03gJYRQVudqg>
    <xmx:kinEaD7hlSwzk6xt1W0g52fxNtSZAtx-ENF67NOLBQTnYigPSgpUMRno>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 10:09:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
In-Reply-To: <CAP8UFD39y8Xde6CD=dDyYy3MY1NOaZGVuwk4zPcreA5KbKR1dA@mail.gmail.com>
	(Christian Couder's message of "Fri, 12 Sep 2025 15:41:20 +0200")
References: <20250910080839.2142651-1-christian.couder@gmail.com>
	<20250910080839.2142651-3-christian.couder@gmail.com>
	<xmqqms72rwx4.fsf@gitster.g>
	<CAP8UFD39y8Xde6CD=dDyYy3MY1NOaZGVuwk4zPcreA5KbKR1dA@mail.gmail.com>
Date: Fri, 12 Sep 2025 07:09:19 -0700
Message-ID: <xmqqfrcroj8w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> In V2, I have changed that paragraph in the commit message to:
>
>    "In a following commit, we are going to add a similar option to `git
>    fast-import`, which will be simpler, easier and cleaner if we can reuse
>    the 'enum sign_mode' defintion and parsing code."
>
> And in the cover letter I added the following:
>
> "In the future I also plan to add a similar `--signed-tags=<mode>` so
> that the import of tags can also be controlled. But I prefer to
> validate the general design of a single new option first."

I understood the intentions.

I am not sure if omitting signed-tags and doing only signed-commits
is a sensible choice, as it does not seem to reduce the patch load
any meaningful way.  Besides, because historically signed tags are
more heavily used than signed commits, if it made sense to do only
one of two, I would have somehow expected that tags would be done
first.

But anyway, I understood why this was done only half of the scope as
a first step.

Thanks.
