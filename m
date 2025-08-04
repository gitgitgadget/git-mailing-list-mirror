Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156D229B02
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317583; cv=none; b=EBZXMoMgspLSIXwoZ4NvEQhT69vxtFcpzZ1eWWSICfm07lBAJkTlnCs9BUXaS72JlmpKzbEyIwAwDtRC0JbEmpnKatMOv9VzyRUmbT6QkJbT/eFEyCCbSGKFeIGHrLMSzCL+R7ve6bM8RKPg0tu+QxDjlDx13q1a+8QRJptxhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317583; c=relaxed/simple;
	bh=hRm8L1brPaDRwoHf/VHPMzSwEAURXwsNduvZL6AJW4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gg5qwAfqOrhtQ8BTNvk0PJrQs+ntSMO4jkkfnEgtmD4NtcazTQ1sm1AtyQ15UwYe/GaCI9kTo3sh1T8RXArTf3ptvvw/eFmlg1WkREqC7TTRGry+s0/xrZzQq5ixBG/XJKh6PRwtw+Te+p6DZZkIUu5hox3Q4DsdRjRENfIQdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dEBqXWao; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jm0z1x3G; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dEBqXWao";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jm0z1x3G"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 29608EC018D;
	Mon,  4 Aug 2025 10:26:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 04 Aug 2025 10:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754317580; x=1754403980; bh=PvlsxtsYM0
	csmg6/Ska/YxpyyKy3aNZf4kuGq/XARP0=; b=dEBqXWaoVpx7fpW9cjgHe72sSz
	D8032P7wx4/DYDSnailmmbAXSbNcQ7r/IiUCAHtjCYLqSc7W3swTwA3nqcBtok7s
	07yXmVuXQKcoesWAKMkDI485mq9379pUqmgSrulXtYg78O7EkENj5EeXdTMXebmf
	B5dis+KYE2fVV5tR9+ZwkYVum6F3LOPbmT4GNw8H/rLyYpjXlWOfgHO1KNcbbtTt
	cGJ56G5r/r9XVD88V2AHFpYmONVnlBYZukPvSKstBVglsoRu3bcOfQ5SuMUp6nGn
	kUd4URwM94Axd6jjSrwfmpUDwNDToW7DEoc9nk/O1u43Fc/G5JWwLmULyWhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754317580; x=1754403980; bh=PvlsxtsYM0csmg6/Ska/YxpyyKy3aNZf4ku
	Gq/XARP0=; b=jm0z1x3GjgM/mukmb3/B9mTvuHCJtSMu+Ob0fXUpI1CJvt6j7aC
	NYPlTqH7crXNDOKZuM7ROhSz0trUQr2KX5fZ3UOFJNr1FDEYSng+Zjj4b+6UF8pU
	eYmx07EBuEHoAnUL3BzbrrcCdCSpOd6liF2AQIObgNkdELeH6yRr5q/Ods3QXr/3
	qqnujG2XIsF+u2dzro3U/X9UhHRwbz9Hsspu8BZ1pSme8luxWnku9dd7Jt6ngTw5
	YsjOKIVKcsj4kFVRzyxF0xCwrI2iX/JkwLzw6T1AKFdUISrsMy+GhENgivbcrabu
	+xuAdQLL21ZMSMRDPRm8tuc0M6Aa4+MMS/A==
X-ME-Sender: <xms:C8OQaA5TW83EhZ1-qdsAzvhcfY11QtxAuHwfYytRsWbonzuT19Am1Q>
    <xme:C8OQaMf-Up8SR7AXWohgszDVJQ3m54xYQO1KKKSUiPX0CuMc5f2tXJP66j6_Q3OeO
    P6X7gxuGc_TY9Ffsw>
X-ME-Received: <xmr:C8OQaMBS0bEIJNwBB9NOb56hrFNf3N14v8K2kOjbCHuYjSRHJpYq4F8VKDEraSvhrnmqHXoDrPkC8bXv9m05XT05risNcf8B-xyqALY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:C8OQaH_xuTxL1-rzeN8axFwGQYrwZohjPBAozl4nSsOxhu7NDkqxAQ>
    <xmx:C8OQaPI6zvtdUigh2nm6Z4P-3pwEWroK5_vAK5qNc0IaGMM5I8M6ZQ>
    <xmx:C8OQaIiYxzoQ4o28NREJPVtwmqCribW3BpGYswgXzPSzseJ6Q5xbyg>
    <xmx:C8OQaH4IkwIZ8FVQcfBfosZh-8PkH4pYuAUop0dIJMFQTFrMFgfx7w>
    <xmx:DMOQaOkQ8mbsvp2dIAUK9MhU6sSppO_JQ6RqNUlBMhqfufPJ8izdSeex>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 10:26:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] revert: initialize const value
In-Reply-To: <aJC3OiJoqJRnR_My@pks.im> (Patrick Steinhardt's message of "Mon,
	4 Aug 2025 15:35:54 +0200")
References: <20250804130011.GA93475@coredump.intra.peff.net>
	<20250804130141.GA95101@coredump.intra.peff.net>
	<aJC3OiJoqJRnR_My@pks.im>
Date: Mon, 04 Aug 2025 07:26:18 -0700
Message-ID: <xmqqy0rz88ol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Initializing the value feels like a pragmatic choice to me. There is no
> downside, and anyone who might be puzzled by the comment is likely to
> git-blame(1) to your commit anyway. So I think the current version is
> good enough.

I had to run "git blame" to find out who was being overly clever by
using a sentinel like this.  I am glad that it was not me ;-)

The fix looks good.  It may make it even better if we renamed the
variable to sentinel_address or something ;-).
