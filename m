Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05E3093D3
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381986; cv=none; b=YNVAK7s/hehLzPuHjmVYXkXHWvk86wu8PHdlkTze4d9202D0WQF587GUtBmpe6dUKWQgUDba34WGr8e7FC+ZmMo7v0z6ePsiCNtml9m0nnBdZcIdzFv5jIgsllGckI877w91NuQNpJEnKVjJdLb7w7c5d5VTG7F1tiVrqzU/lgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381986; c=relaxed/simple;
	bh=XJlTbqAfMmdzUpdLm1NNrE5lNvTOxQbbbekRq92ytLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PIdhdlhSCe4Exx/YsQc1sIV1L85VZmBT0fe4gNuvq1tB4lKkLvlDoW7Q4l+1xIE1lUsUOvm1ZUP+eFKvSiR1p0w4InN+jHA4h3j6x0vAFgjwwu5THF6IHIQFJbXPKdfQKevUdIwgqjMciRt5qbQKMv+mLEj8ce+NZ73oBcb16Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BlQQSiTb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gb1BJFhE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BlQQSiTb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gb1BJFhE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E798E1400109;
	Tue, 24 Mar 2026 15:53:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 24 Mar 2026 15:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774381984; x=1774468384; bh=8Z3gU7Abx9
	r2UxdUO/lsU61tYkIWMcDVhoxX+6icoW8=; b=BlQQSiTbH43doIacKQL64WEO29
	sTC6swqXi4fx/ijIdy5fKoh9kqOJif1mWikXRrK7+5rC9Hqd0bnOBtFQMYooQK1D
	tH3LHUI7o8/0vVIZgmxzeyEgCfnb4oo497eDJO7vdazdPy2CaCbR+UCkA8wIuP20
	MGBdVJAuKfZ7UBwtoNxAzKw6xManb03fAZ2aJ8GPRVjRgQLli7liReA/3JSKyxXK
	OC/i6zpL9wL73HTEMXhDZG56h730GkpSB9lUYEn6ObqrTxtlcZUa0z1R2tkuy7Lp
	InJ7+75a5zXEJYKUTkXT9/0pTAqpadBHP1LePM95eEoepsWAUa7GhvTuydGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774381984; x=1774468384; bh=8Z3gU7Abx9r2UxdUO/lsU61tYkIWMcDVhox
	X+6icoW8=; b=gb1BJFhEKj5wBwnJLi+pGSDwBUbBo4aXxUJKgItTZLIxUBkE9NH
	nmaIyjEsynIx4ENja3PrXJ2S0CedqnJ+9W3HmxScpnMjs7seDRKWrhze7sThEm5k
	BEut9KQWpFyyqDvDcRGQK3ao0ehMkgZ0tv6oB89fXDzzPdnC17zgjyJu1VwgdpD0
	svg/UwVjBseHqiEpbfnJnlhGtGP8JHE8duivhVGWqJEC/wWlyXPvoHoGLzpA5ak0
	1CBI9FcYLozJdiZ7gtnfd2rxRHOQYWuC0uIOOCi7ezzrTGq2EixJ5QAAtZnm3RE8
	ru5/WrV3OK1iw5rWRX1Gkh2FL4ZaDMJpi+g==
X-ME-Sender: <xms:oOvCaZQcQO79GSe-7OB2oDup9NJK0Acwf_i2TdMyOGYGoyr79Sgngw>
    <xme:oOvCaaMaO22cdM7A7VRhshbMt-5_iKr8lTpRcqOAxM1huCsWgF0H6GpiVP2toOyNK
    SLYDt4kyO_ezBkEp0HL2mGXu6P9ae3KiwwlC9exF7SaG0H3QXZ29A>
X-ME-Received: <xmr:oOvCacPR2ritNXoUjqBWRR3vJZOC4mnVAQQfqaqHXOFMMyPt5yugCk2DKRDgdnv4wM30UXOMxcERSQ2j_5HSpTPeOlYKTeYkzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oOvCaasFL7Ae1s-rWPUPu9OYIOJhNyS2kPvqwhNWfhHO0zZJjybGlQ>
    <xmx:oOvCaWWHIjHJZAH0xhgAhGT01a77Jsn9ndabIGAiCYuh3dxj7e8VFA>
    <xmx:oOvCaSvlBWNq5QeGWUTYyYM9ANkMyJS3r0doxrBbhnt9Mw-u0uRSEg>
    <xmx:oOvCaSU_3nAaME46RFpbpLCSwTvnFWnzyqkdPbZjVarw5rHBp8g2mw>
    <xmx:oOvCaY2E3ZHidy9hFGQeFrphcWkvc1G6WcWvJav7TTDAMwl2e8OwKNiS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 15:53:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] replay: support replaying down from root commit
In-Reply-To: <20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
	(Toon Claes's message of "Tue, 24 Mar 2026 20:35:41 +0100")
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
	<20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
Date: Tue, 24 Mar 2026 12:53:03 -0700
Message-ID: <xmqqtsu5xaw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> git-replay(1) doesn't allow replaying commits all the way down to the
> root commit. Fix that.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
> These changes might conflict Siddharth's series[1] to add '--revert' to
> git-replay(1), although resolving that should be trivial.

True.  This round looks great to me.  Will queue.

Shall we mark the topic for 'next' now?

Thanks.
