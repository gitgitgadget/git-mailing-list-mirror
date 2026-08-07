Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF5471252
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119423; cv=none; b=nhUpbJ5bMnOIpNWMZ0Adx+ABsfu44EWNE0DD0mwUIwX34UeDG9nEEE1AR0PuH6Oui3CubDGXI0RvJPW0ws7RiqbB7Md/awe1K1pfTLCm0Gy3Fg38sdndfqX+yBQJibFLmoUtYZrKFi5mkWrmiIivo3/h2+MRUFPCwubpbEYO1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119423; c=relaxed/simple;
	bh=ouibquiODxEuYuA0d9OnrqQ9YD5nWE1M7u6xa4apwPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qoa1Hr7UHAulpbyO9yp2xw76wf2J98+OuTcGlO4J2Ovax15IFLg7QabemQC2YrbNuz7OwMGM/oeG6rJ6Z8Q9Ax0I69kLz6PFOnU1PiFVsbcSNxZpesRIw0y+G4qE4A4Iy0Fo2OdcyAHEM2kZTxy7E/yrI5M3LAKiqwMkL7ZAVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fxw9Gd/j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AqLreMs2; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fxw9Gd/j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AqLreMs2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 32A4A7A0137;
	Fri,  7 Aug 2026 12:16:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 07 Aug 2026 12:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786119411; x=1786205811; bh=GKYG2e7H98
	5bHkbw8s1UtD8VXsffDGeRfDNdn5w5ui8=; b=Fxw9Gd/jbIYEAxmzNOMHG0TABo
	bo+Mpyg6RJ5WwkWNgrxGdIKou4wVkUIvfo9RBV3y//A2UvDia2Oe4wRpGc6m0UY9
	qy0bOWKGBY+P7fH/Ke/A1Nk0QHA5V0gvi1XCOKnn9MdDQT7+IrdYJb6LjLhn/FNp
	PODD6I7nFbBo9cHWcgK8AxAxMnK5nbe4zTsjl5pFlCm+uZuq+ILeROUdEVEIbon8
	+9ix0NLnM95mUFOxnLLJz6eVLj6U7LeHWFDG75cEq1FIQYZ4kjqnKjvvar+5syn2
	NlDz2KHbgRSCM6M8lyrOo9gBXxxrkjXlAJciTJG2ysPT7wYwUFn2hGJZc/Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786119411; x=1786205811; bh=GKYG2e7H985bHkbw8s1UtD8VXsffDGeRfDN
	dn5w5ui8=; b=AqLreMs2oycLVjpqFu6dN31uRdmRPf/uVACQmHNhWPwR4p457Gs
	3nmowBDcKoralkbupoV7cfCR5P+GP1v6oxeWQwUdzKstUpKmFPrFeXRt0AMQt5yv
	JGlwcoo0m9ijWtLnbS95gpTimYIasg3iAkHEQ5F6J+5mTpgiHlzNL9rhpYGObjxa
	EbUiyrm7JZMMpIFf4niPyqug7WXBdLC0uHRFxtsgLEzbH08Lss9Lr1IulciELVFD
	3IYSeD1hj6MalUE249sV3Q5TtnTUrbsJr+yQL2qCb9iuXCICJatRXvclC+noJRGY
	3UV1LZ5hSOlY/WeHqVHq+sQAjVsYAAG7wkQ==
X-ME-Sender: <xms:8gR2andiDixgZvXALJFJ0nErRAfEpy4PVF40cpfoxKnxxivQthte2A>
    <xme:8gR2avfaGKUkYvO8T_ZPgcMUJbJz0B4-6SJ6L357VB6e4rqLOQQGs2LA1jvkX9zD6
    zGfR7-_dcgvtPlhkaEg843J9hk-LY6EDXYDWdDLqCCfs7Pqm8Tan-Q>
X-ME-Received: <xmr:8gR2aiwBR5mIrXFsk89GVnIg_ATzv6MnsNdqYqrBULwAXroR2fV76H9SQ6spBc6FaOI9vZEjgdHsMkeiO_QzxUqlFuq8ihhcgw>
X-ME-Proxy-Cause: dmFkZTES59/UKpC8m/3wNu539QKohs41yXELenzXIhI8pB1ml6zpXMsRiWSWAkz3oR+HQv
    RmErxxQh5tooYNo53c0xozeRgWlSYfFLNohvxCvxEhPNdQE7Qh6+B9rLtWBtVkrzQMRWDh
    Y6HYdq5c0uwqtD7JrNDpuQB1NmPC2nbPwbgEndI9+Mo/JMRYdoUHhcUFIi20CUoY5ca1DG
    DB5/xgJc1bUa7gF9nQS71vH+tV32teY5nYBHSWykZYvzPe4aQpKV00WuaeSvYC8wEwuuNj
    b406WBqc03DFT1wSDrp9CIkr3F2d+x7yaKYsKQLmOKLWeWuwJLdwXjbFGzjLRPvgQV6Zj7
    eflXwNv97ZdfJy3KymtobCkdQEoVW+mqxAKeRwoT+Ks9n85t7nQTEYJQ787MXqyi5x6Qz7
    cYIQWlsut2r0stleI1A2b/M6XerKQU3OkLaHbUuBLx01I+kSvm4xW9NWAY9RSZVjmwr5To
    9qggYhpSYatqaXp+MfX33Awk2Dyhm2ksN6Im2MiLciAMqsQi+pMJqqSOUPeQG6YVAXdofx
    s3FbWAqUcMOoIbtzDC91YGOMrRzWagqQBNpaSeS4NPNqz+6LCB9mnmw64QiEq5P+HsJLWg
    eDi2w5AlnSwgGmmxAhN24by+HISVFaR+4U5fYcRxkQPYsSsiMB9+mdnSjlEg
X-ME-Proxy: <xmx:8gR2au91iNnOWM4-q4dS2oa8YqA8ZW6wnAN4XVfmNpfbjxKpmu2DXg>
    <xmx:8gR2aijFF3ufgQTmmRwxke9rtPgfYJoXnMlUHkFG2WlpcD8pd9g1Sg>
    <xmx:8gR2atFBboc-7mcxtgTYgP2sDNdPTHMToC33YDPv9RtAiNuwdQzU3g>
    <xmx:8gR2ap8nmheFPkt27IdLD1xHw36hwbaasU1TcfXfmRJjQqq9G1AGkQ>
    <xmx:8wR2arDO_S7EizEzbE_yz0SQR8f3XNh3tuDBGoW0z1lEByLwcpi6k1aB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 12:16:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  tnyman@openai.com,
  Taylor Blau <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] ci: bump ubuntu image version for static-analysis job
In-Reply-To: <anWyV9Q4Cmsa5AoT@pks.im> (Patrick Steinhardt's message of "Fri,
	7 Aug 2026 12:24:23 +0200")
References: <20260726083254.GA3528497@coredump.intra.peff.net>
	<20260726083905.GB3529069@coredump.intra.peff.net>
	<anWyV9Q4Cmsa5AoT@pks.im>
Date: Fri, 07 Aug 2026 09:16:49 -0700
Message-ID: <xmqq8q6hgb2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> They'd of course require a bit of a deeper look, but that could be
> another way to speed up Coccinelle for us. Even though I cannot say for
> sure by how much, I didn't give it a test.

Another benefit is that it would reduce the programmer's burden, as
it is not immediately apparent which rules are still relevant.

I wonder if we can easily define the exit criteria when we introduce
a new rule and document them, immediately next to the rules.

You said "refs, object_id, the_repository, ... all look like we have
long done with the migrations"; in retrospect, would it have been
easily doable for those who introduced these rules to describe how
we would declare "now migration is done"?  If so, perhaps a good
step forward may be to update tools/coccinelle/README to add such a
rule.

    ... goes and looks ...

The readme file clearly states that transformations needed for
migrations are *not* regularly run.  Is it possible that we have
these rules you mentioned misclassified?
