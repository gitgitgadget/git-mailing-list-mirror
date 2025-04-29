Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFAA3C30
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967869; cv=none; b=sq66c9PM5drD2Ur8enpKu89gcL9FM+Z0JiXegnige/8FUp8uspg5ZdAu3gP9VuhcbnYApZb+Hxnkr7eL+2rNvCF0zBz6iayrKQTY/JtmoaWv7LPxAcE2ZB4qXwC5r6BafzfBFiZ0itfFZNwdPNHQBawH+3/WRmikdLXYQEdCIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967869; c=relaxed/simple;
	bh=A+SOkh0bbAA/nfoRMrC3uEXL09V+hkSYRxpw9C7rV0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gUGqEF7x6yp9JrvWKugwNx5MZGmJL7jwdZdFxC1ZchksDWUePJ64zdPYpxQ67uKM5qfKOXpXiBeZSAhCl56CLmCUx4xdKiI9kuAA5CQb3gGFXaFwXmUhg/goiyVgufDMeweY7/7+Pguz7dE99O+9usEx4whd+6dLD6gu8lAGNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hL0zfuqd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CkSMrcFz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hL0zfuqd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CkSMrcFz"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76A89114025E;
	Tue, 29 Apr 2025 19:04:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 29 Apr 2025 19:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745967865; x=1746054265; bh=bpRc7Ck3i9
	Lsh55oyouU2EQ0N7fegV8OydmsQ/bLy4U=; b=hL0zfuqd5WHofGRg/4xAP3gCRD
	p36TvQWet6R+3J9w+yKuEaeV9iCOsHknMBDQOH5ICN3B1qpv+ZZFQKzIQnR/sMma
	z8+qBclQik9RIxxyDYSXykG2nWChJpwJERum9MDFIvgLWpJ9Iz2oJGzbW1Jrx5Qg
	heqPVlcA6fvXU5Y570P+uFPH3MMZSc+jzhwLaBRTKu39pNKMHmDVAL2plLTtwOGA
	CQnDtof9ExYeLj3PMY8juKTEbx0+MOlvzUEovX+owyoriJ2F30DTnolfnlQslkSl
	rdFhIGUCM2SGPAyT37KwP9SJ7g3vslTpYqFvPYGGn9hoVHMooCLkZlGxYwBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745967865; x=1746054265; bh=bpRc7Ck3i9Lsh55oyouU2EQ0N7fegV8Oydm
	sQ/bLy4U=; b=CkSMrcFzc6Si2NEFecoq5Z8GAhVnDQogGH9gLbYjmwvI54QUbg3
	OcHzB8jomgSTte7awGKV5RNIK8LQ9RKW5VkEpJA3GMt5zmEpeYmwfFQIFFnE4BJ+
	sdNlbh4jzF+jtqMFJ/5hVBA5pGwmovSiFUSld7TT03xnN6iuMyrv8oRJ6O5GlT6J
	ZIwrpSrXUS1QUbLr5hy+lZ7UlD31cdSMLJhahjOAhYVWGgIIWINtCwfxUtLtlw7v
	ynoI7UFYXu0U+KjbWD1jUdOb3vBZU493EXnkQ1ZJQ9uWBXi/vpPLN8TLYHSdmmw0
	vqHtyiYs9dSnpWBkaScqpiBhzSrBWlrIlNQ==
X-ME-Sender: <xms:-FoRaGEuYNZ3ks263X4juuOTXwFjxt1uV78N0PjQv708umTfLM9uug>
    <xme:-FoRaHUBAdgGsDXi7_zXEVFDdnib0kytN5qnBKuhr0-p32Rq9a4gKV0ue3K2QOuOu
    UL8mOaUq9O83pGiHg>
X-ME-Received: <xmr:-FoRaAIV-aTQmfejV7cmYkYvy-BL3NMEhMKAeDFIwhJq6GiTylU5cy6gbGSVsNww3qdHj0qERpa8-JqyYf1PrXhkRKJrNBGDCB5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieehtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijh
    hileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-FoRaAEqqWWn8R0CcF-hJmjCFej1Go7SqSUS0m25z3DxfpeahG-qyw>
    <xmx:-FoRaMWM8xcnMg292oce2HuBu-JluETHvLaL4j5EwUmCCeewo8FJTQ>
    <xmx:-FoRaDOKrh9v5ICrqnY72C8H53tKFbbxPllmkABMeU9_WYgurAGISw>
    <xmx:-FoRaD07HGGMaiUa1y8UmsQ2esnGhLgcaReunziQWsOuWlCA0mHSsg>
    <xmx:-VoRaJdKalosfemGsSxKsFfp8nDVRuVyrEW-lVuURZ_sjlFn6Mbq1Qmt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 19:04:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 01/10] t/unit-tests: implement reftable test helper
 functions in unit-test.{c,h}
In-Reply-To: <20250429175302.23724-2-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Tue, 29 Apr 2025 18:52:53 +0100")
References: <20250429175302.23724-1-kuforiji98@gmail.com>
	<20250429175302.23724-2-kuforiji98@gmail.com>
Date: Tue, 29 Apr 2025 16:04:22 -0700
Message-ID: <xmqqbjse4ljd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> Helper functions defined in `t/unit-tests/lib-reftable.{c,h}` are
> required for the reftable-related test files to run efficeintly. In the

efficeintly?  effectively?  efficiently?  correctly?  Wouldn't it be
sufficient to say "... to run." without anything else?

> current implementation these functions are designed to conform with our
> homegrown unit-testing structure. So in other to convert the reftable
> test files, there is need for a clar specific implementation of these
> helper functions.

OK.

> type cast `for (size_t i = 0; i < (size_t)stats->ref_stats.blocks;
> i++)`, implement equivalent helper functions in unit-test.{c,h} to use
> clar.

I cannot quite parse this.

> These functions conform with the clar testing framework and become
> available for all reftable-related test files implemented using the clar
> testing framework, which requires them. This will be used by subsequent
> commits.

OK.

> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  t/unit-tests/unit-test.c | 93 ++++++++++++++++++++++++++++++++++++++++
>  t/unit-tests/unit-test.h | 16 +++++++
>  2 files changed, 109 insertions(+)

Hmph, this probably is a question better asked to Patrick, but it
somehow feels a bit unsatisfactory that we are duplicating instead
of replacing, as we cannot see "ah, this removed thing is now added
in a different shape to fit in the other framework" in the patch---
instead what we see in the patch is a bunch of "a completely new
thing that honors the convention we are familiar in existing clar
based tests is added here".

