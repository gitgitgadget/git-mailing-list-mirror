Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D5261B96
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766547452; cv=none; b=TVJH+zZkVnxG1ZxyP30ZxfbBrQO/CsrkLxo+GYJMAgfHrNm1QhIs8bOS/BOe9PQQ23vr+BTvpQp0LyL6E4NIPFiYfutE6aLy9AlV/XLl+q+8yh+KiTvHOw7MTJ/P2SDzM/XM+g6B5rxqwphDWkSt8yYKTdsq1tzxQBTv+4qoVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766547452; c=relaxed/simple;
	bh=81nUqH2JYJv4WbP4nrUJPK2iwmm4HiKXwrDIZDRKbqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fZAV3nyBbFTIPTeACEf3L+xiRQI9oqtK4xt9YnZ3RddVyOVcfjq0172YouNFFAr6BXESEWG/7MdDwVwCBqITc/ft9Kv0qAeppJrOX73CCon0YOWt08/VG8pSwpHaPBaMtbpkO2MC74gznOdq3/we8yUmVItWGqa4CzWPSkhfgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YTyiSn/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m8fKlWnP; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YTyiSn/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m8fKlWnP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C1ED1D000BB;
	Tue, 23 Dec 2025 22:37:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 23 Dec 2025 22:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766547448; x=1766633848; bh=2JQGi4y8Is
	Is4YtVh37OrgYiWTPHVMmhRJoRBb72YO0=; b=YTyiSn/HBGDRSnOtQYRqPTYtey
	hoGCpIVgXf6LDF0eRlWRHIgJFsMZPFkfnKSxMNiGpfMtxQ4VuTBakCUAYaMqZxUb
	3iH89MPhy4rdny/tRdje8Iewa+FTPuY/g4Adniqjqsh4qUm9DwO7W/V3dQbGZNzk
	d2trnfLm1bY7kJzQabIMlYUSn62BQThGrkgooyR0PS0weaXCOSqexWo/PD19v6Eb
	CZwqs9ER/7xYxrcMGtkNRzEHLTWj4XbilLio47IkPE54EKAHsLz/ZgGKZIqRqYoP
	K3Sl37+tUcVmNqLf4pmGJy8HOJ+OWNlHY370SOImTX5rFxlDLnYX/bleLH9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766547448; x=1766633848; bh=2JQGi4y8IsIs4YtVh37OrgYiWTPHVMmhRJo
	RBb72YO0=; b=m8fKlWnPezDicFakCsApx62yM6NJhnOEvxoeLCLO60V9tODjR6X
	KOyll3hNy5LyQ+7QHN6Yis642tIxxF4OsOrdlFg3P/hqiSjUbpRTBx/Fv5X8iWpy
	AXt+9TPuV469mefOXGQ/8LoMVPT9a0u/y7NxAWcOuUvUtFGCV24YTstAWN7f+fop
	kWFUGhBwSzh5PoPoTpGCxpu4vofLjW4AsdN68tbMfW5qLFY5v47OnxSSeeOwmEjH
	4aq7HvZB6e2npVC1dCF5PfsKeNrSTwuelQLd1XuKROPmoLnLdSB3m9wvWwjbZJSD
	kbuLTHFfJ5hZsj21NLA1m9VCkfV9LtXKNAQ==
X-ME-Sender: <xms:-F9LaYzk455F9NFY_xxuTTL4HKaAE8vJdMmcZSP-zBpK4OyYl480wA>
    <xme:-F9Laf9Y33YNG5zo7R1LXVLXK1_sS3WGwmEzyJnuAZis7BPqfi0eUZrpVeeXdIfwf
    Mneq3WFLu6g27v756JUgSzuH-cH_Nd05TNQ4wFBknC8pmBjsUtG>
X-ME-Received: <xmr:-F9LaUJZ5byr3XcbBJP2v3GdAo-Jbp7Nq66qi9jv5x9SyZHyTQZzl2R-Bp0Y0RCj0iRpIus918nMgb1yq6ALPhUsEQJ89RQ_zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:-F9Lade8neSLjxm7HAvKiwY43OBeXI8kcvs-8NHZkgWZttsbuwBrmg>
    <xmx:-F9Lab9gfP0N7P5sVvxD32lumS-No6KT5KKEUzxXZuB_pFxTGPotfg>
    <xmx:-F9LaSrqJA6zTYLqa4aP0EUY8oH5hlNMLjbww0wROh7iS4L6BGMQhQ>
    <xmx:-F9LaYDm2YhpHFxul7eRIYy5RFdIQ86briE1Ku6sqlKH2dLcBP6z9Q>
    <xmx:-F9LacjKJsLnPj8GPPz-HTJEnx3LXMieX4ZHVCps4U0m-wOe5EpR4Oa8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 22:37:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: Possible regression: lost diagnostic message when pushing
 non-commit objects to refs/heads/*
In-Reply-To: <CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com>
	(Elijah Newren's message of "Tue, 23 Dec 2025 19:32:28 -0800")
References: <CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com>
Date: Wed, 24 Dec 2025 12:37:26 +0900
Message-ID: <xmqqikdwo8i1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Bisecting shows that this
> started with commit 9d2962a7c44 ("receive-pack: use batched reference
> updates", 2025-05-19).  That commit message to me suggests that while
> error handling was necessarily changed, that dropping the errors was
> not intentional:
>
> ```
> As using batched updates requires the error handling to be moved to the
> end of the flow, create and use a 'struct strset' to track the failed
> refs and attribute the correct errors to them.
> ```
>
> But it's possible I'm reading it wrong.  Was it intentional, or is
> this a regression?

The topic bisect found was supposed to be purely performance
optimization, and we should take any changes in behaviour as
regressions.

Thanks.
