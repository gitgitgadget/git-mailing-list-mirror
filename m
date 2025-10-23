Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281362580D1
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761260767; cv=none; b=XExft+p6m1rdfwXu9OXWXLiNGcUQCIn9srUesgAyr8EfH7/L9qyCHMV1yiHD963kGp2qhv34netrvBWdJS3zz5lN2qAlNb2NW96DtIevvGw+94sXOtkHk+4tH3Lg4xtCWNH7zoq/9SK5f7HESKdL11/Gz2oMmhXvw1fPpD7m9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761260767; c=relaxed/simple;
	bh=U61g5oK+7K9hUHEJ5n9JLHEg8xoJOs/x3mwqDXY6iSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=df0n5/zlihDT4CSN8vB13HSgD/UDwPetfrYoJHzbi7HEKWJPnnMJaFqbOZJ8KuXNjScNebf2q+Ol+q7+tnOtp469haL6WupXWMELppGRKakpxn7kyj6hUsH9sUZ/y/hMzUsiRa+58rpZbgBujD43JxLIfwLJbvTSpvO2VChQ3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JTXKaOyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AoPrXuS/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JTXKaOyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AoPrXuS/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1480A7A0102;
	Thu, 23 Oct 2025 19:06:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 23 Oct 2025 19:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761260763; x=1761347163; bh=CIzUuhKWR6
	qxll8cAOPCU1KAiT/VI8q83e1+Rcle5xg=; b=JTXKaOyl7kTYQ4hv2H/VBAmRkS
	9mNUIvX0476J2RoZcYZPjGhk7AcM5EJUz95NyhvtFRhar73+wE6h1nKXyY8tqidc
	JoyeStEh4YbejFZNlbt6WH5U4rm2yibztn3+H/GgYITzm+ywQh3t67mQR8QzyZ8f
	32pQTo7wu25scl204RjLSCphcjFwMTptuiQSwbpgl7SNTwmCVN7lwai7ZY73/eIq
	kT0Rz2fI6rECgfe+c9GqmSzk2akICkiqcOuD07LZBysfnpfWXpYDIDo8nty/S3JG
	gT/X5sFbR0lOpGE490YuxC47dK5nXVUSzwzsOw4rASxSAbySKBJjnx5TlthA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761260763; x=1761347163; bh=CIzUuhKWR6qxll8cAOPCU1KAiT/VI8q83e1
	+Rcle5xg=; b=AoPrXuS/V199mE21tn8rYfIHpPdMqnR5bZpy85w9PLYr8T025Zv
	ruKWr6diSCpBvCPCQ2q2Am6u4OWHopn4OEOiILxfKP4gNI2HWfnV4NSRDA9zIE2n
	GKhVd4Y9gLM9ouPEEmKRgGllGiUo4DysvkWOZ6BnjxCnq77UlQscKwaOKg6yuASU
	cvlLaZu0KSklbhhIwf6bv1w6qCIKJMGeKN1sPi4+d1s0mG9KIjWNd4xY5XDdoaiN
	pIV+nPJvIcvUXSR3ULun6JgJossrAggviwLiVqSMIfe46a993HA0xt8RMZOZylWh
	CLsZ9CDWTqLd+7cSgzdEzCWq8S6r7RHa3HQ==
X-ME-Sender: <xms:27T6aEo2KfhP5FrpaK0U6UAXNsy2w6BuST5hKtLDd82xkj82ESbRDg>
    <xme:27T6aM6dWOc2Tjb55Ow9A-hOAY1rH30e51stOR7Qk8tTDT2xHb-LGeVEPXdkuxUla
    vQzurvXLp7dJMwZ6Y2siAIaiaVNPCFXLmNdHRE5gSlfIT__CWCxjQ>
X-ME-Received: <xmr:27T6aLcgriezkjfpzDh1vgzIOUWP5qSKVnRI21EXuPLVz8rEKiDYP_M0uaPi9W-DVhGi2XZIHtC4ssU1ov91W3DiihkcMrMzF9NV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:27T6aB7G679iH44_JNYmtDaW-v0rRjVpYlwCQnIlbCagRrtZ3UOZ3A>
    <xmx:27T6aCsjv3os9aNOlYQ5gErAfkGQn5H6XKS8qDHIKR4EmpN78DdTjw>
    <xmx:27T6aBj76wQs-7QdkODQ6D0Aq-BNsbx2Z_cZ2eXx15Q8vMTuHcB7pA>
    <xmx:27T6aNrUC9oynDaYPXmQnDDn78vqKBbqmusjGYJtlv6YwR2DA5YV4g>
    <xmx:27T6aBi387mFqwti8YLIGBEO8mpfcNQm0NJeymRn0DEzG8RZEAB9OFnT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 19:06:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v4 00/14] refs: improvements and fixes for peeling tags
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
	(Patrick Steinhardt's message of "Thu, 23 Oct 2025 09:16:09 +0200")
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
	<20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
Date: Thu, 23 Oct 2025 16:06:01 -0700
Message-ID: <xmqq3479rzfq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> originally, all I wanted to do was the last patch: a small performance
> optimization that stops parsing objects in git-for-each-ref(1) unless we
> really need to parse them. But that fix cause one specific test to fail,
> and only with the reftable backend. So this led me down the rabbit hole
> of tag peeling, ending up with this patch series.
>
> The series is structured like follows:
>
>   - Patches 1 to 8 refactor our codebase so that we don't have the
>     `peel_iterated_object()` hack anymore. I just found it hard to
>     follow and thought it shouldn't be too hard to get rid of it.
>
>   - Patches 9 and 10 remove infrastructure that we don't need anymore
>     after the first couple of patches.
>
>   - Patches 11 to 13 fix a couple of issues with peeled tags that I
>     found. The underlying issue is that tags store both the tagged
>     object and their type, but this information may not match. We never
>     verify the actual object type though when allocating the tagged
>     object, so this only blows up much later.
>
>   - Patch 14 was my original motivation, a small performance
>     optimization.
>
> I'm not particularly fond of the patches 11 to 13. It feels more like
> playing whack-a-mole, and I very much assume that there still are edge
> cases where we should properly verify the tagged object type. But
> changing it in `parse_tag_buffer()` itself causes a bunch of tests to
> fail where we intentionally create such corrupted tags. So I didn't
> really dare to touch that part, to be honest.
>
> If anybody has suggestions for an alternative approach I'd be very open
> to it.

Are you still ;-), or are we ready to declare victory for now and
mark the topic for 'next'?  It seems that another topic depends on
this and the topic itself is a good shape enough to advance.

Thanks.
