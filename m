Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4E2367D3
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395934; cv=none; b=gxOu6CMk0bTffSUdqQ4bfH6p413Zwhd5NFU/GoaFbNVaw7mk+sJ3JQsW/mv5V0pP7j5A7stik3bQMhiYGe/EeCAqPEDfbjswsNDorhNR4Z86EkkgDPQrDCBYjNGpX3NoK1A+Q4q7nGed3KPcGOciTwZN4v9zW5CxTnvplbQNYuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395934; c=relaxed/simple;
	bh=QQ1e0qLfYV2uCDuChsm2ZMh9m1zGWPVFzJNrui/Lcb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VqMegXFHkTl/Rfska/Oo9BR4SlZqfFbDqIxx+afWMv9+pIiJNLNrtW5dIPThLBgzuyl18onBMOZWHcll5tMwUbbPTF9/c7ilX53FW6+/ha75e1XS4xZetPEB5qSQ8iat2OVYcHrsRQQl+ETjRWmgasvHdKMi1xN1sbl7iPXjKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2j0hXXsn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=evea+5YP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2j0hXXsn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="evea+5YP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B52AA7A0169;
	Thu, 28 Aug 2025 11:45:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 11:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756395931; x=1756482331; bh=6TusO3vTrR
	ENieeMvWcPo6iz2sSHEqWTmpdcaQM/+EA=; b=2j0hXXsn4pn1PV4Dz/MhdnLU0p
	xvgpM0i9r93jXlfw/H+2iIezKUj7soSlTSDDgQIQeK/yqajneYFyIeS/AAPyZifK
	iwupssPwrtCAfEH2yAF6x3XbNEQWXayfyqAUPBUSR7GILh4TqFYeHEWrIj6tSCL7
	6OkssuXKVr5LXSHTIO9xCzLJ++upXqGwzLVLI7a+/PPS5HQDTfPtRqHR6Q874L5N
	epKRW+eKHoOIcoY2Dz4PXAOcTL3kLHMxmHmXtmyKEk68XzQPl1IT5fvTm5L4MFQi
	Trq9pDp/1dt2uikPAuLjvyleAZwk9MTeXScaJiEiu/ngNGOJGaHQN7ohtUxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756395931; x=1756482331; bh=6TusO3vTrRENieeMvWcPo6iz2sSHEqWTmpd
	caQM/+EA=; b=evea+5YPX2/QD/HTr89+JQd9zfWsDQu0Pwj9owH9RSPvP7ztBDK
	7jL18bxNXhLEGiUyUpMC/ioXlKGhJkCX2NVVZ2mL1FSd4U6VxliYWHg4ONgyUaY+
	6NbtEKT0BVqnVoNF9/JyEpZBpQrpoqSSgPaG48EK6gIVMuSc9AzXpO3ZuHMK442w
	H8TLILWQdgosuM6ParkYvlEAHeFySeL0LWAndJvc7y1Lud5pwhrNxj7f5G5RiLu8
	MJ4ftQnackbiTV9mK6wLo7TCMpKd6UIAtvu4H0bC0Cn2oywMwnxmEleEMfxlKtqO
	Dp5nOrYdsBGX4yxg69Jx1ksvoLLkb9JHOAA==
X-ME-Sender: <xms:m3mwaAAko0injXqi0OlzIJcDu_ooL9Ixvjwq4Ant_3f5kn4lxZXXWA>
    <xme:m3mwaNFhuB3vxB7sr3-S63Gc41pss2Cww8b0O5NtdUL4xBfS0GM01hNsJ0FwK2MnO
    0-QK_6h3AUiZe0b4A>
X-ME-Received: <xmr:m3mwaAJ6L5M2purVWgHv2aY8tbPthOySRWZaLT__eJe5jisB9-3OgSxG3uK8KuYXnQaPTbd5TOInWWLDuzkphbLWf2qmWlpZ-YHEaPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedugedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:m3mwaJn07TVBmQEml0KUJl2xh3gTaxVO9WD8wJp2rHJE3NITCJPE_w>
    <xmx:m3mwaATptDnA0PoquC51qnUircwlgX2OzkXly7AtQ6awsE17Z63o1A>
    <xmx:m3mwaDLi--rxr8klaJiAuNBwH7nct0_gJ7dgW8lBzbg2F38aGWGgvQ>
    <xmx:m3mwaOAhvVfNFz9rFE7EHNykkPA53nfb7UzD_f2mcLxuFW98i5o-gA>
    <xmx:m3mwaEx-mI5DKj6UcZqqtsw2kLDkg2hJOD5EoHFJ0lgkFZySQfy8tCdl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 11:45:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/5] doc: git-checkout: clarify `git checkout <branch>`
In-Reply-To: <276630b8-ad98-4ada-aa85-9f136d653d7b@app.fastmail.com> (Julia
	Evans's message of "Thu, 28 Aug 2025 08:11:11 -0400")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<b8873c4529caeddc85879efd122e5a57278352f0.1756148933.git.gitgitgadget@gmail.com>
	<xmqqldn5ix0r.fsf@gitster.g>
	<276630b8-ad98-4ada-aa85-9f136d653d7b@app.fastmail.com>
Date: Thu, 28 Aug 2025 08:45:29 -0700
Message-ID: <xmqq349bxxeu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> Do we expect readers to truly understand what is to "switch to branch"
>> without explanation?  IOW, I am undecided if the lost "To prepare for
>> working on" is a good thing.
>
> I'm not sure what you mean here: "switch to <branch>" is as far as I can tell
> the most widely used term to refer to this operation, in other Git
> resources, in Git's own man pages, and in the error output of the 
> `git checkout` command itself:

My assumption was that you are making this a manual to teach what
"switch to branch" means to folks who do not know, hence my
question.

> ("Please commit your changes or stash them before you switch branches.")
> Which readers do you think would be confused by it?

Exactly those who are given that message and want to understand what
it means.
