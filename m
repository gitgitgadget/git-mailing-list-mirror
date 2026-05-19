Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F72980A8
	for <git@vger.kernel.org>; Tue, 19 May 2026 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152241; cv=none; b=D6tyZeE+5gkD+85IztckKEjk6tqcEYlZBHzfvw6ICQU9kRxFjqC2ufROy0Gkolmesxaw9GQZvrMrejAldEbhUjxpr7SjIpCYrWNPcSybTGBPGpmGYqcfEHgRyq1sIKht4utgvDtkFLUUvALY1KXmpAvXkZN5ztoh3trOdDH7rfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152241; c=relaxed/simple;
	bh=v+rDyEqtsacO//Eh9kjxB9WTADE+FmPbXnjFsU8ko20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y7xsOriveBi3taqE47j0TAL50H5r6ZbCm/nqsqo6mGnG91r8WVir4nc7kZHiTQQI8Uxe2msLkqJgzwwYXdYLKgtHJNezir8MVRPPV8jJpuEztJ3gNErwMb9DOxWQDWFnYB2KfOy//jPAM2C7pTSoyV4XTNLPJiQD/t18++CTG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DBP7dpnR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b+9zBXH2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DBP7dpnR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b+9zBXH2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D4966EC0242;
	Mon, 18 May 2026 20:57:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 18 May 2026 20:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779152238;
	 x=1779238638; bh=dSuH4ToU+ML7j3Q9e+/YGiLXzrs+kjNCiBYKYHLVpKk=; b=
	DBP7dpnRtQCWgdxg6kfM8PW/sAiWxn53rh/45BWlGJjoCMc2nONn2Mcgm1k1PC/i
	tlu1P/LjPlaDOjL5X+lOJUK/IRf3FDWSWiNZ3lL3sKJMOjCR8FWhc8lcw7+kvsyh
	hBsrGrnUgtW0sS1OmicW/63rq+cJbTQXEs9ly4P+yYtK/TSOdMVudi4UPm8fQi8O
	6jcLXAKBqHezmCFmVk2nmx7h8Jtgz7emFk0XRoN77lb6OjbRV+RQo/gT01qLz++I
	jSzQokYWQtwF1jqu0FTz33umQxfyIOIui7783tZWcQV+RAq5muYWHeP6oHjSWjLd
	ggREir7/g8h3fNuCsVWHcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779152238; x=
	1779238638; bh=dSuH4ToU+ML7j3Q9e+/YGiLXzrs+kjNCiBYKYHLVpKk=; b=b
	+9zBXH2tR6TIa0zinmXj0yvbg/5AWy9wQ/QFGuWYMOUf2CPI4ENi+WztaAT5e6hD
	TJ/FLt00GkPKLkIG54GdGvVI+XRNqgRXUXcJK9/3f2aEVVvZ+N2I3e+hHTFJCjGS
	uTSQaxT/EVTDaLofKaT7LcDfqQBj06OvSf6qarA0TbMyEd9XmlxlbpglGS3klxDj
	QjYHJ5TMqe+t3jzEa19upy+1LBCBw6bx6hA3BYoLRLKImbWWG06HdmPsRHwauyIY
	55VlJ1Xh3+MZ8buFAlMUytAt1jufZ6V0/Ay9f056QpOV4aH8YMf5IvCS8hTBPzu9
	SUapKfLftzjSZTYUr/04g==
X-ME-Sender: <xms:brULatsXwFY7Z-Ur8vRiYdNwnSmvEPltx95_aTdj2BAYesm9ncx6LQ>
    <xme:brULateqS9AzR-zoIVu6oD2H2q7gypsnd3hOE-GyTEhqi6Bhpn3IquBcI1ziA12hJ
    wa9fyW1hHbwfzfh2UFYpxLhn7rz7gxwBJRXrvSh8-A9XRN6bDxV>
X-ME-Received: <xmr:brULalz10glEZMcfxQkMxoTGZrYODaBgHnmeyVFr8SUKioCDPeyuzQ9eMwIdra7PxDwl4F6eKvgINN6HMP8pUfrnCGjrMstC5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedtfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:brULajEuM4nTtRwGox29MGrQby3DQB5fINCCKsdPw905pyM5dCBxVw>
    <xmx:brULapzmtyY6qbj8-3LqMvOg4kSEeMfud7Wo5bdU0eU1txU85uDy9A>
    <xmx:brULakum4-OjTmRMXZ01KiNVjyQmFGz508OhFLxoRzHbWu0A5V3QDg>
    <xmx:brULam1DZG7LVjdAbdu5yiFcLFi1Dx63DHV_noGnr0RXIyU0guyIOA>
    <xmx:brULaktJJdU9WVz8v7qoLWd_-pvQXf71Q6Ps5s_PvGYtFL-5YNf_6T1Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 20:57:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] use __builtin_add_overflow() in st_add() with Clang
In-Reply-To: <20260518202502.25682-1-l.s.r@web.de> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message
	of "Mon, 18 May 2026 22:25:00 +0200")
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
	<20260518202502.25682-1-l.s.r@web.de>
Date: Tue, 19 May 2026 09:57:17 +0900
Message-ID: <xmqq4ik4b4ia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Changes since v2:
> - Pass variable instead of st_add3() expression to ALLOC_GROW.
> - Add the helper st_add_overflow() that mimics __builtin_add_overflow()
>   for size_t to avoid duplicating most of the definition of st_add().
>
>   strbuf: use st_add3() in strbuf_grow()
>   use __builtin_add_overflow() in st_add() with Clang

Nice simplification without becoming overly ambitious.  Very well
done.

Let me mark it for 'next'.

Thanks.
