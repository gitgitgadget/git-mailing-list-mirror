Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7E51E4A4
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146990; cv=none; b=nxChJBpLpa7mxhoarQUJ3NpubfF8Zq5iwS+7RVlhtT4oHCIo/rku7EBWqCzfwrZr0RLQKq2FT8AXwkyS0zkqa0BJUT/Rt8xFPu7E4NZTy4bechinXRsRXGC5Vg4Aw8xPL65ouJgL9DlxE9/gLEK7KnbeoYEOt3MED3FHuGiMWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146990; c=relaxed/simple;
	bh=tllQEkU+wCzg91hvqDm3963wfz7QG2puUJDNuXqupEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FowUSsnyf9TAWDoSx1l0j3XiilolLpWxpCZnjv9b11j70ZEpFv1A5jl4dqLR0JQszTBQ5kFMVlu4FE8GCj5FaFrRHvgb80v4tmlD6C2/L66OZViMShop9+neeq43jke0dWHGd+fBV9nB54HeuKxl9Wnf/D/qOB6A4QaH6QlUA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rIF+Db73; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rIF+Db73"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 8DB1E1140120;
	Wed, 20 Nov 2024 18:56:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 18:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732146985; x=1732233385; bh=0hFgJIo3ocfDkgOriyhAKaX9qsvVSi3jB8o
	29YoX/Yw=; b=rIF+Db73ZlihEg81DiU2aU8zUggm1tAM0joVhAPUiacO0Zs+KJ8
	NruSN4CAjNdouLpCA225fWISGXbAvgP4R4bxdZvKt2Xj4y9MJf8PBJMAFBqOmP63
	0rYAiyzyNFCBRYsS9C6rVR9hXVOaZq4sN/l27jz5XSOOt0XbJ9q09pxu370H4Y9w
	Sw88CfFF5zI4NSvC1qSaf3gblJg1bRtFM+I02TUnGfFX90ahc4uKH1ua46wanqft
	KkG43qH2oAHnY+J/ZG09jTwQ1geGxsS5KJwUHt0SZCQrMff0ugJXGDEMUpS84oZ7
	aYJJnt6JBUyua0frCI6hIvRkoAzc9EpydRA==
X-ME-Sender: <xms:KXc-Z6-ojtKKaolb-0yVICeTzck9J5Ez0snzRNru_RWmtYBUUVOGDA>
    <xme:KXc-Z6solV0bnqL7cjsMUL5zoV8uKpp-isplqH8ifmD01ZbBMrm0qOkCQG-yL5qVr
    QhdMLoy_iONeW7UQQ>
X-ME-Received: <xmr:KXc-ZwBLEJqTsbXPJZw9LV73G8R2sd3E5RQUf90bqb6iGGIFj58d7Cr2MVq4EO4ZnW_bUy6SzfIR3JtF_8BWkMA2nvNPAZ9B44YZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KXc-ZydbNaXgn7yFUE9gBe8izpoeGxMUiaASfupvY98_MoaTgT0CaQ>
    <xmx:KXc-Z_Od1F2yiCzI8D0W3hu8rZj3ZReQmyeuXZAhEhk4HmeQogldgA>
    <xmx:KXc-Z8kuWtC58WHOX9HZek6bJ0-2PqHieiXMvDquxmM-DvaPRvKGEw>
    <xmx:KXc-ZxsTWJ4HJ0k_ZxH7bX41E6SGR4OvHM19pdewumGJqaxubibR-A>
    <xmx:KXc-Z6qTA2iUd3CJrK52M4QsY_p3e5ltz69VPvVybpYZczJnsmJSvFeX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 18:56:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>,  <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
  <karthik.188@gmail.com>,  "Taylor Blau" <me@ttaylorr.com>,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v13 5/9] remote set-head: better output for --auto
In-Reply-To: <D5R0ONTYT1EG.K1XD9FZQO6R6@ferdinandy.com> (Bence Ferdinandy's
	message of "Wed, 20 Nov 2024 13:49:53 +0100")
References: <20241023153736.257733-1-bence@ferdinandy.com>
	<20241118151755.756265-1-bence@ferdinandy.com>
	<20241118151755.756265-6-bence@ferdinandy.com>
	<xmqqldxgez4l.fsf@gitster.g>
	<D5Q32ODJM8P5.6VQ08LDQHPXS@ferdinandy.com>
	<xmqqiksjcx4e.fsf@gitster.g>
	<D5R0ONTYT1EG.K1XD9FZQO6R6@ferdinandy.com>
Date: Thu, 21 Nov 2024 08:56:23 +0900
Message-ID: <xmqqmshth32w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> Since this particular test just wants to test what happens if
> `refs_update_symref_extended` returns with 1 and not testing correct behaviour
> of backends and such, would it be acceptable if this particular test case would
> check for the backend and if it is reftables it will just pass without actually
> checking and do the manually locking thing above for the files backend?

I think we have some pre-made test prerequisite to skip tests unless
run with a particular ref backend, exactly for that.  Perhaps

    test_expect_success REFFILES 'block update to check error' '
	... manually block update and see how the operation
	... errors out
    '

or something?


