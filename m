Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98EA30FC1D
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508319; cv=none; b=MC/aZ0CTd/w7tuil3hnKoh3H3nT2rM77q8VuL3ssrY4LFkfySEAFPsylXx/k3zkm0Dc4WM0RS+JafLH2ZdzeZ8DPVvkRIl8a8024XkO2/skXJKRgbSjQTyzzz8aaxelz3RC9hLR0v5f912aFDre2+dzOYAIRDkqlOyVk6YPSbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508319; c=relaxed/simple;
	bh=EEXR8jj1gJI1oSaQnbw1OznRrmSFaAY6SxzLPFIwhY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t2ANjTQdVsE8fuLgbz/4gBTFFfvj+Lx4KWBQuE2EMKzVYumiKij95sFdNavPKEf6Iaes+LCKeYOlNHwxA2pqcuw+2NKBGGHnDXvNBS+9JXvvYy2nK4SRMROWpimeBrS1wlFm5nd4+Zz8ONA8rydyexoocPYN2gHmfOvslwqH6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n7d/7Z97; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5EvUi6N; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n7d/7Z97";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5EvUi6N"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E2CF1400133;
	Mon,  6 Apr 2026 16:45:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 06 Apr 2026 16:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775508317; x=1775594717; bh=Nynx+HhkiO
	c8O5wIbxbKQs1MBog6xGF1Az+faoD+m3g=; b=n7d/7Z97D/5T0hQntpeBKFTB4e
	4ctzmHqCSndQ3j4hnNuat8AbOKvzpBdmAbCS36tD9p+dwodAhValZF2Alm3v7aa7
	mlcgZwU0atBAkQyoZL0ZPfMWIyt9OeqO/FHBe6kd2Stql1shnAS+Rm8eX61wuRGl
	bdhw7ld30cYJuPRd7XU8ngC8MNJPubhI4bXOF7jd3x9dOA/ihoujFXtJpJNpS6I5
	p3jNIG8zWZAL/xuegnR1eUjw30JLRcKYfWwVvfV3GdouMAbTgTIPculvxFZrXx1M
	o97xn+xIrtP4JZbo3JtA1xVQ0VgGIj30AO87pidzCL6nchLLmzIeOzWdybzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775508317; x=1775594717; bh=Nynx+HhkiOc8O5wIbxbKQs1MBog6xGF1Az+
	faoD+m3g=; b=Y5EvUi6NKACmetVx/p/bf34bjHmeJwbq5niD9U/3WFo2Tu1H9QF
	6sWuJK1bjxWYLx+yTRPq/KzN9nTOMLOCD9lpqH3pf6Vh1qRxqSVBXYdMMAfj8fwa
	3RTgUtfjdlFrgyNay2uEVCd9iIJ4mTc894pFWw0zr0qGt5vXZ2JV6zdmrJSNqdcI
	iYai0QXaRWlsVdeJo6jh7gk15oAgeX9SuP8vBEsq9Z0z+Wr41BOABlN/v+JKpYa7
	XOT66XZcuNjYzyKrTExpjoFCZUatzBgvTQTcjkrfZ72ZHeAM59jZqyKU0JWupLOs
	hgH2McDtVBu6Yn03F+HiouL8iclG/rqafqg==
X-ME-Sender: <xms:XBvUacQ1CMdMY1k__FsT3V-RO5aWQrkBB7pgktC9ph9p4UVaISli-g>
    <xme:XBvUadc97p5gtxq0nIIykPtHv-r_otxdW3JWK3MnK4vfkjmovkdURmKmo0ofc4tUJ
    DQPtdxU-kQzCnu1Ryxh7Jh6lYvDtLiiwxiDw6a_pQGs6cd066lqgA>
X-ME-Received: <xmr:XBvUaTrZ9nPvnbdm95X1gpDzuCSXeso-8dXKbiAst1pyc1ztEPECbMJT2aaq1uDtFBQEnG3N3XxQSDtlGoIQKI3-H77bPHKu5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptggrthesmhgrlhhonhdr
    uggvvhdprhgtphhtthhopehluhgtrgdrshhtvghfrghnihdrghgvudesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XBvUaW8JqpjtWKU9-1nI-pju4KxVyx9hWx1krIxFhrcWnqvg8Raycw>
    <xmx:XBvUaXeNqR9CCG-mdQyviYSBVDvW_SXSbO8N24axvFbeSM6HztVF7Q>
    <xmx:XBvUaYJELvswUTwWy4TUmDHryuXuvsms7VX4e7Hzt02KokurCNFV_g>
    <xmx:XBvUafhtIHZyXU2JRoR2yHt42Kr88jEK5uPegdykpJ1smdio8Iq3tA>
    <xmx:XRvUaSgFwTnBa78G-XQeukJE4E7N3kTmmO54iGKu9e_PXaWA3rkrsMva>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 16:45:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Jeff King <peff@peff.net>,  Tian Yuchen <cat@malon.dev>,  Luca Stefani
 <luca.stefani.ge1@gmail.com>,  git@vger.kernel.org
Subject: Re: [BUG] git diff --no-index segfaults on large files (NULL object
 database)
In-Reply-To: <adPjXKGIT5O7SK6E@denethor> (Justin Tobler's message of "Mon, 6
	Apr 2026 12:57:07 -0500")
References: <CAO0HQ0X_pQmew5tJReOL=u+CMxCjAQynx8JfjykoYAUE59YNzw@mail.gmail.com>
	<d6c63949-1998-4cde-8cb0-902fd7db988c@malon.dev>
	<CAO0HQ0VEJsG6MYrp_bSTuU09PDsypGPrM0XazvM8er0kB32Gqg@mail.gmail.com>
	<4be492cf-347b-4fa5-9bdd-83e7ea8abd92@malon.dev>
	<20260404230939.GA1360412@coredump.intra.peff.net>
	<adPjXKGIT5O7SK6E@denethor>
Date: Mon, 06 Apr 2026 13:45:15 -0700
Message-ID: <xmqqjyujakdg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> IMO it is already questionable as to why we would want to start an ODB
> transaction if it is already known that the object won't be written.
> IOW, if we are only interested in streaming the object to get its hash
> we shouldn't have to start a transaction.

Very well.

> The other option would be as Peff suggested and to make
> `odb_transaction_begin()` just return early with NULL or some type of
> no-op transaction if there is no ODB set up. I do think the former
> approach would be preferable though as I'm not sure there is really a
> good use case for supporting ODB transactions when there isn't an ODB
> set up.

Let's not go there.  I agree that odb transactions without odb does
not make any sense.
