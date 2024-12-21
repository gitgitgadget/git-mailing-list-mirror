Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9AA59
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734802619; cv=none; b=PLsToC8foZKeTyysZRctdaatXVB1Y3Hax5B8nkmO1xHFlGtwdkR8xmCm1ayyfYt2O1g5ln3eZlA9bWsrlJFvuZBX7GlmRB0SF95Ld4eq8688niOSjDT5HlFLriOIdzw3W9gZnGPzcTDAbkItZd9ka5hwHF0Sf+maeu3Jq6tj/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734802619; c=relaxed/simple;
	bh=gCvYVDKzaX9j/QMe24nrzfJxljCjupjb8tNuDo8gKu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mmmzn9N1g3lGxo/m24ROjfEs+TBVurs6LXklU/eB4PS3sNaae6T4bpupZu9qI6RCtIfEDxQTDbeOkRO4VESw7uOW620Mz47sQ6mg1vfTiMwwFtZfAJ9G2BiyfiTRjBRrd3X3KoacIGBpHBaXfsp5hHmfR8sxHSVb++otIqwS87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GvhzO9Al; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g+YrZzqK; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GvhzO9Al";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g+YrZzqK"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F02551140135;
	Sat, 21 Dec 2024 12:36:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 21 Dec 2024 12:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734802616; x=1734889016; bh=jsrOglXMV2
	9I5n4oWC6MNdF+1WkuYyRyIe9o2t27K2Y=; b=GvhzO9Alj0mfDXrRq2FI2bCrNI
	ZtX1oLXHHJ1UicPKfItNZ+FvA8C8wxFRSmYLAssGix5dw294qVYs9jYRjEmXuh1c
	jOmIgTZGIV/qIRSeos9ns86xu66cAeQYtM5Ri5Ym6Jh7tusMrDa29fsn/UKZTM+I
	+XemPo19yW2OwH4KQBcRrO1VjVbjpdKBceOrUZxBqa+NMpfaxgPQnZW9Yin6pLU+
	5mhUUtc/Jw+eLZk6c7K2IkaftdkMnCZP7FcXo7Syp3nBNfNXzlxsBRooziBebcoC
	jfTm2siNevllcVsWvgodKX5T8+VPmh8Yh2Fc9esoVEiRaKQZ8PxcjcRF/e/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734802616; x=1734889016; bh=jsrOglXMV29I5n4oWC6MNdF+1WkuYyRyIe9
	o2t27K2Y=; b=g+YrZzqKx2PLJAE+Pv28fTUV8ZbskXfA5tcpV6pbG60DvZLOAv3
	euCh1G/Dxs0UAmU/gj1BNIJQ0ccNVOEvGoaQJ5xTbm7xvP6wE9ydo61ninvREPAF
	JD95kFoEMZ+0CdCqFf4Cfx9K9CXaEV7Gl3opchJhVAeOVBFWt88w7G8j4AXStQ1H
	9GSdr12/jFwxAqu/p7yTqJL3elIJx4MsI8J1bdRIA8Xa9CWj6RKlY4JPHOqybGmG
	Af8NB7VzExrmFbpAXeCSXQ0IjjqOnJphPNZWR3/4gD6IHwBIC9sgNcfk7yDV/hT0
	zCbPHtxH/tyAtlsb8qT6vUm9+dANJj1QqNA==
X-ME-Sender: <xms:uPxmZ0X8okyARvEfwBqf6r5Chicnsraild1HYa4K0JezDkxN7oRPIg>
    <xme:uPxmZ4mDnb0-QnkGklSmOLRKzyOtvc5Ia9oOEjWiuQzv0bKsm1UHvp02TdyiwsOoQ
    SwvsgOEkH5iBts36Q>
X-ME-Received: <xmr:uPxmZ4Zv6ke4j8_HbC1aL8dX-u_0JTyLVvFmtYs9gFEDc55YMnlQg_ai2NMa-S317rf0Gn_OZEcPCmLyGVacccUR5uw3hrq7Qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uPxmZzVMb4dHiQ5aMVF0XpVv3o2ACb-7AkJJ5XWtbtHohSxRVzNvtw>
    <xmx:uPxmZ-nU-hufQMcIDCA_EBndRVF0uShOGCpB26qqxcJLC4c5VvVSbA>
    <xmx:uPxmZ4eZyBraVq3kNyVW5fHkEUdE06s4zBm0_PhOyBzUUGjIBxvTaw>
    <xmx:uPxmZwE6aq7YzqMxX_QBw3l7rRjtqjftSvKoLnjU4nhQKuaDA1dXlg>
    <xmx:uPxmZ_CnzstnIPdS4I6nsqOCR22lv62r7duLLvpPw-KslVEpgcHz7ekw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 12:36:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 3/4] reftable/stack: fix zero-sized allocation when
 there are no readers
In-Reply-To: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-3-12db83a3267c@pks.im>
	(Patrick Steinhardt's message of "Sat, 21 Dec 2024 12:50:09 +0100")
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
	<20241221-b4-pks-reftable-oom-fix-without-readers-v1-3-12db83a3267c@pks.im>
Date: Sat, 21 Dec 2024 09:36:54 -0800
Message-ID: <xmqq34ihc4zt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Similar as the preceding commit, we may try to do a zero-sized
> allocation when reloading a reftable stack that ain't got any tables.
> It is implementation-defined whether malloc(3p) returns a NULL pointer
> in that case or a zero-sized object. In case it does return a NULL
> pointer though it causes us to think we have run into an out-of-memory
> situation, and thus we return an error.
>
> Fix this by only allocating arrays when they have at least one entry.
> Refactor the code so that we don't try to access those arrays in case
> they are empty.
>
> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)

This somehow did not cleanly apply, so I whiggled it in manually.

I probably wouldn't mixed the "size_t i" changes into this fix if I
were doing it.  To avoid "while (*names)" loop, I would have made it
to "for (size_t j = 0; j < names_len; j++)" and kept the existing
use of "i" intact, instead.  And reintroducing for() scoped "i"
three times did not seem to make it easier to read the result.

I am not convinced we need to avoid "while (*names)", by the way.
If "names" were NULL, names_length() would already have segfaulted
anyway, and basics.c:parse_names(), when not returning NULL (which
would have been caught by the sole caller of reload_once() as an
error), makes sure it gives its caller a NULL-terminated array.

But other than that, this seems to make sure that we avoid
unnecessary work when cur_len or new_readers is zero and avoids
asking for 0-sized allocation as a side effect of doing so, which is
good.

Will queue.  Thanks.
