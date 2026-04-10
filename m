Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0213A7595
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855627; cv=none; b=qcelRhiX9Esm8kGErAAdSdIjLdvX0fQ+xz+wzvfWZe2QakUs4laSQSP0wuc1AQRhZH8W5tqyVp0+45RM29Lp8MZbZCzD+jLfeVXOBlfQOvPznPOuLVl8TJAfoTPdj4To8wQKt2FkHjQXQiNOwNzQlU3jlccjYaaQi5QimLbo85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855627; c=relaxed/simple;
	bh=jOAiIdXbL2mmlGlrO6bJiJwuqHfRAqBhuLaZDLzisTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tICM7L8vchN2ldTU9naMANa6zduHxJC81uvFVILN9Z0Re717utzMc7tbM/sIcBbOonw7JeMhAMV6/WWFSNl3NGDN9MY95GcKTiJbLJoTo+tdrejkYhdlD9I8Wys7TDeLdew+AsGiz6u0rWR4+dIqUVqd/0wrfvv8vNOj/YiSNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YE5soCvf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ShqiTAIm; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YE5soCvf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ShqiTAIm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C05F07A0174;
	Fri, 10 Apr 2026 17:13:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 17:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775855624; x=1775942024; bh=Z8ncmmWoPV
	zlbQriqxh2lpiGfdTg7OmqCYvFpmpWjyc=; b=YE5soCvfa/KW6rFE9EbXE9Gm62
	oGahp6/qASvXIwPFeFkVVrmTVTWYqvIsqiK89c8jy8HkUAhCwatFjOM/PpAdWt5t
	qnb2Y9IJdaL/3dlDB5V5Wf3nClN6jejJsy0R4H5aprgOmf1nWLPGangfoNZL5eoE
	ejWfSedYHJV2EvfncDIQbu+2d2F5n3FxNb2iEd34PBBGbz1S5mCvVZVkdI7yepGx
	0WzXRZrR6H0jm/2d7aNoyv6wRWKKKO9NbV1iZl2NQvRA5MAQCnSrUZt8cGkheASl
	FY/4dj8fS4dnUxOTncoMqcuYkXviMM8veSqHujfLCXSObkpESdfjIQbpfCnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775855624; x=1775942024; bh=Z8ncmmWoPVzlbQriqxh2lpiGfdTg7OmqCYv
	FpmpWjyc=; b=ShqiTAImE6La4r8RggJ+jJV/RKCxShCDgKa6f95ErTtaDQKOVAY
	AI+4W6OmuBwEmiHzub8pjJh8ME0UouE8CJ3wZuqNwQaCmSd4qLZCOU/L+14uxzW9
	i69pUMeVJ2Ru9LxGjMY47GYNG670XXIzS0n6GGrtt4LICicw37kDsNbtug4Vpsdl
	FdjwYID4OrQ4k0qx+dGegydGIiV9ft/glKKCnnJ59vhd7gGcoUs/1Qtu/3NdXUGk
	vRYsot/Qv9GaLSejqkNctHkfLHkFlz5NKwV0QmYA4CusEjuMkKKbemnME9RZ4JVv
	glfuEpGnXcbBb3PCzuqdMwYeHqJJuO/GMmg==
X-ME-Sender: <xms:CGjZaTpI2dhvCltMaoZEKcwev2NuuZxv9Ct7mctsik2BuVCOlopL3Q>
    <xme:CGjZaRUeUWSQnnJLsA2NYugcp2LybhFtLgAz5byOHlmUe3oY7ud_bMe-M4eFSj9eo
    h2lKAG6D_5_AgdCqGc9egT_82VR2ZqNwGJON386L6UaINoibxKJjQ>
X-ME-Received: <xmr:CGjZaaAHsNFK38GEDGFdR9vGY0SvzqIGOk3UN5xnK4jAfbllJzqSbPQizgsPnINM8dLS3rYsmdA-GdPyn9vU8o969DyRJpvdxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CGjZad1uOhrZPKNB0Mu0YFy_LS_fxo1ANA3jymT2fBqq-xSm7Sld_A>
    <xmx:CGjZaU2Rreqyqr6cBICYSQu5k3nfS_KSwE35HRtZ6LFOcnNvPVLihA>
    <xmx:CGjZaaAqniQpdfPJaLe_0TAuLnjGJS3vina9TTh-cofWtOuki5oOdQ>
    <xmx:CGjZab5cLMutPfumt99TDkka1ytkYYaO8cKuSCEk_Dm9kKNkYEOQnQ>
    <xmx:CGjZad1F50wDY2NgUWY0vGXaUdV5lzIRPSApKm5ztXmHGmXDJ6O0F1rZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 17:13:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 0/4] Enable Rust by default
In-Reply-To: <adlXscAv57Xd7p01@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 10 Apr 2026 20:04:01 +0000")
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
	<4efc4133-3726-4b9d-8f06-03c07d48af99@gmail.com>
	<adlXscAv57Xd7p01@fruit.crustytoothpaste.net>
Date: Fri, 10 Apr 2026 14:13:42 -0700
Message-ID: <xmqq4ilio6wp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This was actually sent out just before rc0, but Patrick requested some
> changes in v1.  (I forgot to thread it to the previous version,
> unfortunately.)

Proudly saying "It was sent before rc0", as if that gave community
plenty of time to adjust, is not something I was expecting to hear.

"This is expected to be a big impact change, so I am sending it
before -rc0 of this cycle, so that it can be in the first batch that
graduates to 'master' for the next cycle" would have been a lot more
understandable, though.

This, and other small things like writev() topic, reminds me what
I've been wondering for some time about our development process.

We have been operating this way:

 - There are 6 to 8 weeks of period, during which at any time
   anybody can send in any random changes, and as soon as a rough
   consensus is reached that it is a good idea, a topic is merged to
   'next' and after spending a week there merged down to 'master'.

 - There is a "cut-off" time at -rc1.  After that we go into
   "regression fix only" prerelease freeze.  We typically do an -rc2
   and the final after that, and this process typically takes 2.5
   weeks.

This forces topics that are apparently (even though in retrospect it
only was superficially) good topic that came late to spend too little
time to make the cut-off time.

I wonder if we should do this a bit differently.

We may want to have a mechanism to sift topics (as they come in)
into "architecturally important high impact" changes and the rest by
community concensus.  We require that the former be kept in 'next'
until the final release, unless they mature before '-rc0'.

Essentially, '-rc0'would become the new cut-off time for these high
impact topics, while '-rc1' will be the cut-off for the rest.

And we move '-rc0' way before '-rc1'.  Perhaps to week 3 or 4 of the
cycle, from the current week 6 to 8.  Currently "rc0" is no more
than "we happen to have accumulated these random topics during this
cycle and this is a preview", which is boring, but we can reframe it
as "there may be more smaller topics coming, but all architecturally
important high impact changes in the upcoming release are in here
and no more will be added until the final release." preview.  If you
are not in the mainstream (you are on a minority platform, or your
workflow is pecurilar, or you depend on some third-party tools on
top of Git, etc., etc.), this is the version to test and report
breakages in, to make sure that the next release won't hurt you.

Would that improve the process and allow us to experiment with
larger changes early in the cycle, with plenty time to correct
course, allowing us scramble less at the last minute during the
prerelease freeze period?

I dunno.
