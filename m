Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5F30F929
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671113; cv=none; b=brntq114voDDZnh/6VWw1u7ODqkKWaEppEvGG0rKwC1Y02QENCIyVTopzWkiq5Vt63kDf9y/knklSY3J3nzb70zzdUQwoutsOMR9aES95Quu5ok2xiYKhw4QwON4iboQPu5+zNBhTBxhGuCWEGcWjeYsXML/lPZ+7j3sNsvWzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671113; c=relaxed/simple;
	bh=2aagkxVQdntCJw0pbLRjKttVFM0QmYoEvJi6N2ZMwPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nrUqNeIhdGnObxfYSn6k+Do/GbjfL/XP7+OFeI+gCCI4O0PGS8SA9+C1mgXOwkEDbnUk7hACxF364/+8UO6YRdqiRzt9ONYE7K23b0cFnWTWo7IzJDsmFesMLXaxt/sHifdYQ29JlER0PrYp/K1f/ojJFf3weAHKi1z/xYRYY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l0G74lU2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vmRrHRUE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l0G74lU2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vmRrHRUE"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A0870EC0541;
	Tue,  2 Dec 2025 05:25:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 02 Dec 2025 05:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764671109; x=1764757509; bh=czzYtMZhu7
	3JeNpm7ht74XWKqK2GYQgBwyW4qEqleFs=; b=l0G74lU2G/HdxyjDsD4o4L4DRD
	olkcJD7RB4Q7eIhLHBeDgp+Klii+XeFzvfjs1h60+7V1e+A/E0ZVomeFoUJ7WL/x
	m4wbkrAADRUQsw9U3spsW5PDKPzwuhBZ1pvxG2Up4l+UoTZDqtoThao0OM4rdvN0
	KaR84FsuShI5g1YZVkszzxediDXIiqjNbbRZW9/zA0bmMmQE98OLZ2+JhcsdEtoJ
	XQ+S427Lh04uGK+RAJV4BVCV2IXLkXURFQruc91xrsLzmRiLBhtx9dTZEeOf6lXu
	qcqSwLqKYVMwBapBf8o2R1uD9TCr4TyOg34sBHSMvhZet1xYe20ni1B3fyFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764671109; x=1764757509; bh=czzYtMZhu73JeNpm7ht74XWKqK2GYQgBwyW
	4qEqleFs=; b=vmRrHRUEXJWx4O1hvMXNvPeCmAA84MKXF9TjN8I04AWxXW873xA
	hS0p9OZmok+BG6VUyCOiHLj9VAB1JEGdnYT142/nVxLcFMGkSgKfGMEULDD1WLNt
	H9fTq+aUttcZCPfAJ+GMiT6ahJ6DA9OnDsaMv8fQMeI8G4Yhuaa3D1nevf3da1wd
	EBeHgibu0zpi30s+9djq9Re528LGWKKcAyIYnTRuj1vvKyDO7olmgW4gwzkxVop5
	wGrYZgQZW0kaBMJo9xdjlUickhlf0aLyGQZxrbxgDL9/6BkD9ULnDdkh+mo4w8rB
	GZW2k32SyytMmH/Jsht9dJDGBnqj3Dp4yzA==
X-ME-Sender: <xms:hb4uafDcSjNmOA_eRAcucp6QbItj7Ldt0FH4A4R2lT6Hh9wo5pyvuw>
    <xme:hb4uachyzklc8XQBHLFHZisCOx3PEPKjLAR_cg3r7QPeXtROpxpI_z9UFLihdh_y0
    vM0bJFesOUl3G8PJ98dkmQEo15zSGtN_psDulavo8YS58rrvG-1mg>
X-ME-Received: <xmr:hb4uafmcUJYYQANdVA_MGR6iHAmAfOftcV9ZUEgHnUIbE7khhCEYeUFlpwfAQsZF-3uJSabSvG6nVmvQjHpiAcv7EVYFanAYgy3J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hb4uaQqaBuptCTs8kW_YrCi6MiERzYVqCqgfWJ-kUzitbh2hc_3sqw>
    <xmx:hb4uaQHIre3ffcUFtzuxwJtmYwh_C-IcfJOd06qztuNNt6rYihyprA>
    <xmx:hb4uaUxcMeIMFYjG--3zDrrP3KP4ewqwMW8KEUyXz79VdJ2EqxprFw>
    <xmx:hb4uadqn6y0rnC9e6MBnyOMeZvJUecyqmAkWl8Iwde8ruAvSkZDCNw>
    <xmx:hb4uaXFUY7aCtICQXV2Lg4aJs9uev3twm0JIwC-xEsJ4Kvmhdw_Kz9G9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 05:25:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] refs: allow setting the reference directory
In-Reply-To: <aS2V4TKeS4V_oxAb@pks.im> (Patrick Steinhardt's message of "Mon,
	1 Dec 2025 14:19:29 +0100")
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
	<xmqq34651ie5.fsf@gitster.g> <aS2V4TKeS4V_oxAb@pks.im>
Date: Tue, 02 Dec 2025 02:25:07 -0800
Message-ID: <xmqq7bv589ks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> For the reference storage I think we should be moving into a similar
> direction. Sure, for the current formats that we know its sufficient to
> only specify their directory. But I think we should treat the directory
> as an opaque string and then let the reference backend handle it, same
> as with the proposed format for object databases:
>
>     # A schema-only variable will be treated as if we specified the
>     # common directory.
>     [extension]
>     refStorage = reftable
>
>     # It's also possible to explicitly specify a different location for
>     # the backend.
>     [extension]
>     refStorage = reftable:///foo/bar
>
>     # And same as above, we can also specify non-locations.
>     [extension]
>     refStorage = postgres://127.0.0.1:5432?database=myrepo

Cute.  I kinda like it ;-)


