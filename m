Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F081C28E
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313885; cv=none; b=fCsW/iZOBUvLQJI+SDTGmR9TgOSmKq/XFukg1F9asCH7qs/drAEeVEr0jnY+gedmSdVDU1RpSJ6QwfAUGtL2dApMTX2xKsbSDTZEt1YbK5byPUG5k76Td4sPTPBqvB5MUkLpSTDhJ2teGMgV+5Uhduw+SrJQN77Z+jhtyHwVKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313885; c=relaxed/simple;
	bh=X6XU9Fx8JEjaX3WHkxk5Pj+LMOd72En8Xiq5tC6+ATg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sAWF7E82Suhnp/HyN2M013WxyWd6QLuLxLn6LvSm81j7L2hMbsg1ViT6ppOA26UfMTQzrZDtfwbTradpB7y6abFYPmasfW/grSzgdbUxmjrmOhAeN/j7dccp+4QPL6OnSLvntLqXinRdtEd4PW3xJ1LBXsHANIlvz76QGCsUBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iWjVBu/g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L+jGldg9; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iWjVBu/g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L+jGldg9"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2BCB01140174;
	Thu, 15 May 2025 08:58:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 15 May 2025 08:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747313882; x=1747400282; bh=/8it4td77h
	Em29d7J5aiegSYi68O1tDbR3CQFF/e3bo=; b=iWjVBu/gkg9e62cWaRAz5s7jmc
	0i5XLAZg4YZhJwVNC3lqNtA8pGRVWdAlFlqBtPcLDodXyEjPtjrHWRT7WJtVH527
	VJ6bpK6arb2K62jbVek85XKf8jeQiqVoMgjOwY+YBMQy8HyVlOVEJzPFwq6f1vgh
	nA42g1rfEq0k4kH5QB4olxz/fx/9aya7zjRA/+/DxttL4B8R9vKKVkMCWauddoEo
	1JQ6yjYfWwn//mxJ5BuLM0tK1jhqWy57zVxwOX0fcGMfTVqccrdVnzQQVechkL7i
	fuTv0/YjhjpEs97OiIo5ojHTOMWdTRxopVuHlz4SgdN/xX8QVU5TTXmw5rxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747313882; x=1747400282; bh=/8it4td77hEm29d7J5aiegSYi68O1tDbR3C
	QFF/e3bo=; b=L+jGldg9+QoAIQmML4vtMMCGgcGTF8PoY23X313Rmpn7Cj3fs5h
	9aXca1JUBxMBrxikeL89I1pqAfX9H/9DgCO1PQu9V+g9A0aGjdkakgTxFFJP5kth
	O6lrH0R1RCZ/SGjbtomZmEFgaftuMnR1jPDGdUd0Jam1qhuPaJPNpOvdPD1UTrPw
	qnUiXZiD9PGYflu9Lr5bp7iKI/SvlxBVMEaSWoavULFQ8pRs2Rk/U4luTvXs7Hn3
	TdR8crrIoq7+ng/NViSqyNXRrjeH8NoNax7XqvwWYK00cPOSyiaUTR1tbxJLUurX
	FMHI/iAjlLaInRUn2tKnibKNYDLlv5Q8PcQ==
X-ME-Sender: <xms:2eQlaBtXQ3Oh_2tL-hUALoAPD0dEHqpLjWyPsSUEQ0Bo3RIhsCGlCA>
    <xme:2eQlaKd0yJKr15jhSjEtv7l44Y-n0VMw4tvu77es1Utu_kKRIFmAPx1-ZlEXMODyK
    y8QNcjNc8mseVTb4g>
X-ME-Received: <xmr:2eQlaEwNfOsk1vEmEyy7bWAwIH9qteFQQPmFUFDEXhZq3F2o5QXADz7MFPtXJIkZoF-14fg0yoB2d-UvK0ztM6pdJUQjklXyJqeNnoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2eQlaINdtyZKU5PUMwWneJqk5B6vrcRQldtKWkvwkbV4g6NZ7HKXaQ>
    <xmx:2eQlaB9HHkVKDhnENpVZtB6kCsE35zjOVJqsUzf1gw-QhGjo2rXcBA>
    <xmx:2eQlaIW-RJWurAlQlFJZUQcQDM0Ga-k7aZo5VRGz9k9xrDdZKaVPSg>
    <xmx:2eQlaCcuqrw3XOnE-Cia79jEg_cUAYvrc1Z5Ufus3iLpcv5TlJyJyA>
    <xmx:2uQlaGjxNuju9nIdV4cx7MV1V3GQ_Hn_O7mUPd3Y0G-ol1_-m-k1wmFn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 08:58:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v5 0/3] align the behavior when opening "packed-refs"
In-Reply-To: <aCS7O8tNekg_u9Wp@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 14 May 2025 23:48:11 +0800")
References: <aCMnrwkoJ2WyqGZT@ArchLinux> <aCS7O8tNekg_u9Wp@ArchLinux>
Date: Thu, 15 May 2025 05:57:59 -0700
Message-ID: <xmqqmsbe3uaw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> As discussed in [1], we need to use mmap mechanism to open large
> "packed_refs" file to save the memory usage. This patch mainly does the
> following things:
>
> 1: Fix an issue that we would report an error when the "packed-refs"
> file is empty, which does not align with the runtime behavior.
> 2-4: Extract some logic from the existing code and then use these
> created helper functions to let fsck code to use mmap necessarily
>
> [1] https://lore.kernel.org/git/20250503133158.GA4450@coredump.intra.peff.net
>
> Really thank Peff and Patrick to suggest me to do above change.

This round looks good to me.  Queued.  Thanks.
