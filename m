Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895D22AD12
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579792; cv=none; b=ODqvmquiPt6P62VnIs0L6OuGRUFcCSYhfDgbfNy5IvuiiIjFjBAgpX/fvOoyLcBE5OdDt7Kc8BMNMh1w5Y4m+FWpunih77J/Km7CaZPUvmbqkv6zutFdNvcKA6LTNP200b/E+RxJVupENHNjhUofMrBw7QuMpOh3yPpqByrR6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579792; c=relaxed/simple;
	bh=Ynr1iBEvtQj5oDkmBuPJHJZRwwEUyqMqGXyNVCCM4rY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EEwTKzJIA901tw9RDNMa3F1GQY2YiTDDeeKmr/IYNqJtakW9PE6gxti2MrYU3+byrjXGNCHo1tE154yWBFf0vuz1DQWLxB5QfCnNc05ynkTgI2Pgl+n/hoLdhoCAX5tzpWapK/PxZE3zrXYgObkkCY5lx83BcwTPQDxOuzZXAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OeoLhV+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VxMTt5av; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OeoLhV+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VxMTt5av"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B29B611401C3;
	Thu, 10 Oct 2024 13:03:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 10 Oct 2024 13:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728579789; x=1728666189; bh=sNoE5hoHzc
	jXhizUhljWH5acoX3zEUgqyT6BueRd2OA=; b=OeoLhV+ti/TqnLlpSiq3OMJODd
	uwCgxOEKGWxaWS1egMsvN10X6cm3q5l1ZuqC0Q1kJ1bOBrAp3P9pZ5v9cpN/dmfe
	gGnsum+/z55YhPLW6/Sxjv/pRYayK4usCR7b5YPjxap6OTbdREueYlwswdWTZDdG
	y1KMOOgODTh0Mb2EV2qLS9EyULQMjZwv4Ix0Wd7T1ObkY6wC1oiAOem35iLpgfPc
	bxCMr/OHfPtqaZR4I5VeIMzyO7bVLPKk6lWjyfz44ndcmq5JnsH4BXlEMMmTqsu9
	SKPjP+c1vBdS7fMpDgta8RdstkSTLltvAKy7j9d8MC2XrmxWHFVa6kOAa0Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728579789; x=1728666189; bh=sNoE5hoHzcjXhizUhljWH5acoX3z
	EUgqyT6BueRd2OA=; b=VxMTt5av0WM3GKuUJsrmxd4HtrSUD8UEMIEzD/cMlcmD
	xvq7uWl+kRzjsYG4Uk+zrQ95EYB3wdKCAYG6bVZrwf2VPSWMkhWRLA7OLt4Pt62A
	55/gGI50eaVFJk7Hv28DLmmvQc2MlQgfnnJV0B1UuEFVSqyySCH+OTTxIASZLZce
	vh6B8ibVFhlrTOPpsbD8Kppt4U9WokdvPCGkFnf/PDeK1os8iyJ26OuFcsIpduw/
	nSeo7If+jasDDeKhKZNOZJDAS/rsLVlYNTtyyI4JGrkhyUTVqDAlJuBX/hzv1UUx
	y/qh2sWqv0xipgSQgPpvYmIyOTclfUMmuOyRoOEvNg==
X-ME-Sender: <xms:zAgIZ7XlONcC_UTIzlglDnre6aP_idQsf_ucVnvHf-RqmYIaD3CvOg>
    <xme:zAgIZzmIbMLW0ahiF958jZekr2Ge1Ne-dzdkkBOclXkcLiSF6j3LUbnIAIUUh-MaB
    j-D47mb77rCypck7Q>
X-ME-Received: <xmr:zAgIZ3aOhUSfVN9vRPdFcK-WldWRXr725gyfhxpWW7xTGBke4F_ZWiTO0dt1xXsh4TL6coMWTbZctKxvjpuOUFzaFA4YGFi9dE3RFa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpefhvdeltdeuleffieegjeffveefhfehgeev
    keeugeffleegfedtjedvudehgfekteenucffohhmrghinhepohhuthhrvggrtghhhidroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehnvggvmhgrjhhojhhuleeisehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehushhmrghnrghkihhnhi
    gvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zAgIZ2UYhxhKHM5zj5_yA6gKiieoXktHDfEixOmb8hm2zqDGwu-jwg>
    <xmx:zAgIZ1nlzyDf7MZmJ2HjE3tSNdeBJwHBk_UrKuVgYbzU0z9kS_xHow>
    <xmx:zAgIZzc5hd2DstBPAWfN32dIjA0xY2bvyKYteCpFFTSEldamb6NWwA>
    <xmx:zAgIZ_FXcuaDu5ogrfG0eGf45wSzWlOCHAsBdDZmNhbzxLJSKNoi8A>
    <xmx:zQgIZzYir7hXAREqmtyiXJQh4v8m6aU1I3HyHzzXtNMJ4-uksbGxHRLe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 13:03:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Neema Joju <neemajoju96@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [OutReachy] Introduction and Contribution Phase
In-Reply-To: <ZwdpHNOPKpi12n3e@pks.im> (Patrick Steinhardt's message of "Thu,
	10 Oct 2024 07:41:54 +0200")
References: <CAEqABkKmkqJCqpG5nOgGnK_BKhN_rTgmioptTvCLYGWd4WV0ig@mail.gmail.com>
	<CAPSxiM_OssSLAGd1JC3UJ9Saorf4yxx9FtvnhpL4=hBrcoh8hw@mail.gmail.com>
	<ZwdpHNOPKpi12n3e@pks.im>
Date: Thu, 10 Oct 2024 10:03:07 -0700
Message-ID: <xmqqiktzlwl0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > ... As a part of outreachy
>> > contribution phase, making one contribution is mandatory. In the
>> > Project Contribution Information
>> > [
>> > https://www.outreachy.org/outreachy-dec-2024-internship-cohort/communities/git/
>> > ]
>> > section, an applicant has to complete a tutorial, microproject and
>> > then make a contribution.
> ...
> You are of course free to do additional changes after you have completed
> the microproject to get more familiar with how things work. After all,
> this is an open source project, so people are free to contribute at any
> point in time. But this is not a requirement.

There seems to be a bit of confusion between what Outreachy wants to
see and what we need to see before adopting somebody as an Outreachy
intern.

I doubt Outreachy considers a microproject contribution qualifies as
the "required" contribution.

Instead of being a theme for a full 3-months internship, a
microproject is designed to be a bite-sized project, with which a
potential participant can experience the end-to-end contribution
process of proposing a change, polishing it while working with
others, and seeing the evolution of the proposed change through to
completion, without requiring technical skills or project specific
knowledge.  It is primarily a "dip your toes in the water, learn how
things are done in the development community that may choose you as
an intern" practice session.

As Patrick said, it may still be a "contribution" from the Git
project's point of view, but it is not designed to be something that
qualifies as a "Contribution" they talk about when they say the
"Applicants are required to make a contribution" section in their
https://www.outreachy.org/docs/applicant/#make-contributions page.

