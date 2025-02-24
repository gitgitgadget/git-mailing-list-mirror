Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F75206F18
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438879; cv=none; b=GTlryuKkCZuq/lqbsxUuglK6+ZngGA072+wJKLklSi3bD05SmE5fAEPNmA5rrhPT2n10GLaqu9JYiqKgiNAvDUvnn8WIvUvFRdj6q2+VXMJQ1imj1HUrwjPnTbcFAJDevO9o6JciUEkcIJyTly7JKhde/WZspytIivymZq85wzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438879; c=relaxed/simple;
	bh=3KiJGYTkTHRYRMToisOYcdMqI1OgX2f5lU+xKOuKy+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HlbkFdbBqVh4hXplWDOJWjnV8YlfnZ1wY5/BgfrWirwiQI5NgK+Yl2actaWEytg07Qhzcp/4MIp6E35iY+mv51U7YREqpXMmLomi4RE7qySBw5ylRux13cnl4jMYrru7eRqSB4bwVqYyc1Y5om4HeNuFvYYf0UAj+tjl8oMA9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YFUBroYT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lcFKEKHk; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YFUBroYT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lcFKEKHk"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 726F7254018F;
	Mon, 24 Feb 2025 18:14:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 24 Feb 2025 18:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740438876; x=1740525276; bh=3KiJGYTkTH
	RYRMToisOYcdMqI1OgX2f5lU+xKOuKy+4=; b=YFUBroYTZy6u/+kI/A8MSNXUHo
	w13OeipgrLbs09xBPm3/jP8BI8v8kYR5o1mVJZ5AKQeYVAx2EG/+8jCUjZlL1Yuq
	WOmTSncP+XZqyC5QQ9zBu221fmyIfRTvKzX6eEP4h4cA1vXHd+xkti34DKDAhylN
	QU9hkbeVa8i1K2kZ8QQ6XkiXhCqlAAhypouBxVTUnAxmLXjfuob+fXoPfShk3gPe
	IzmParOKqUJBT6JVjkVkVqU3lBdRjGkjU9UO77hDB/+oJPrYLJtUusI4bV1cHL60
	JTuFMourCCkP+qi4LQh+6/VqPTg1JMtwb+tZ1lSY1Hld6QirQtqgXPbntc/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740438876; x=1740525276; bh=3KiJGYTkTHRYRMToisOYcdMqI1OgX2f5lU+
	xKOuKy+4=; b=lcFKEKHkYRKDOVQ0QlOSa2LvrdUXPjbLLdrmlzcT1VkNYvqgXE7
	InEOr+hvWZF0uXBGr0DBtcTT+8BD982P5TX7aHDF+SmyZZs9yGCahCViG/LrXkQG
	WCXX7CeoDIxbaOqDmrUfGGQdWz8ixSCb5UMrnj8+WE5q6FhAhEDqtzsefG8wOHUa
	ZYwhOpaK6xoMLMpqFmL4OQGHlTz/dTlkJZJjTo2P0hMhkjeJ0aPCTGhLO+KE/CpJ
	7pQ1/AE0NBehJYZybvWVmgzMUSDM0gSTftNz7EWLhC2UKJo8HMiBDW6r4JtkkSO+
	/6dXNgD2mOYDzoNd+QyxTYPehbIorxDVvCQ==
X-ME-Sender: <xms:XP28ZwfeXAN_nr99Tah7jsm-Vag-5LVhb9ZCnbT_MZUKvqynzSFKsA>
    <xme:XP28ZyPvbua5qQ5LhefLTVg2aw7mpFvHnYpvCjTeTMA-ih226sH7yx7ovnjWvKTV2
    XpXq9L6Ime-xy94vg>
X-ME-Received: <xmr:XP28ZxicuY11gMoM-50evmSrEPQA4tzWU2cV3k36l2t90jMzMw1a6_18BTYR6eipm4iVoz9bwLcmXkf9XQbJmvTRAe8X8ARPxB3tpHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XP28Z19ySBWxctvSik2vvot1r7MoWfgk48CMixn804PspmOZY_xMaQ>
    <xmx:XP28Z8vQcTRvEtf-rMIe2nfYGIS5ZbU2fw3bK_nuh6C7r5wPZICNwQ>
    <xmx:XP28Z8HkFpz6SDDNxttgYcbBDd_FEnyTFvXCQy3PjnWqgu_rRif3-w>
    <xmx:XP28Z7NdzrkJp1mntPqVR4cLyRxFchfDkLfCM29v3eyo4vWdaCxX1g>
    <xmx:XP28ZwjT6XpVOArgMcxBdXKnhBs39IMf226NuTqMgDaXGvf5Akza2qcd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 18:14:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v2 11/16] rerere: let `rerere_path()` write paths into a
 caller-provided buffer
In-Reply-To: <20250224231024.GA729825@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 24 Feb 2025 18:10:24 -0500")
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
	<20250207-b4-pks-path-drop-the-repository-v2-11-13cad3c11b8a@pks.im>
	<20250222072048.GA3096947@coredump.intra.peff.net>
	<xmqqr03n7218.fsf@gitster.g>
	<20250224221914.GA193356@coredump.intra.peff.net>
	<xmqqh64j3qkn.fsf@gitster.g>
	<20250224231024.GA729825@coredump.intra.peff.net>
Date: Mon, 24 Feb 2025 15:14:34 -0800
Message-ID: <xmqqcyf73pgl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So the only question is how and when to convert from time_t to
> timestamp_t. I think our general strategy for when has been "as soon as
> possible" which makes sense to me (most of the code only has to deal
> with our one type). So I think doing it right after the stat() here
> makes sense.

OK.

> All of which is to say it might be a bit more than a #leftoverbits.

OK.

Thanks for a dose of sanity.
