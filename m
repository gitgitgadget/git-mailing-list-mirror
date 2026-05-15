Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C278F2E
	for <git@vger.kernel.org>; Fri, 15 May 2026 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808508; cv=none; b=u/u6vo0U1z65X/0qjyoROOfW2C1aCT1L9zcKRUVCI5SF0SoxMltQ2qMkUezY9ZAeyLwh+YVbSqzWrceFX1X5kGYxzVi/zw3YeAh1feU9xWOfqx9iZ5Y8ZI7AIyShHt53fN5ko7KKeji9/CiIBMaz1HsO3NsgUrvenV91QOoQwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808508; c=relaxed/simple;
	bh=LWAYQVpckHQBXzx+QUzGUATnbyNS7oW0u3Lz/UdpXng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uGVSTSVnIK0QpzBghXAJhD/3tZyJY8RFveESm9hJcceaRwaky+inJGjd9jW5+wSC0w9/Cb+K5wQouY2V8Mgbb+m4ZpBkNWj+v4GjB0qMJ+6GCVQpF8ddVDMCG2dV2HWRELn+c176XMLKlYY4z/Kg9hrd3q1IrPL+TnKntGrPLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GLV4umYF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPQrhLlP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GLV4umYF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPQrhLlP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 892921400013;
	Thu, 14 May 2026 21:28:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 14 May 2026 21:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778808506; x=1778894906; bh=IzO/AsfGHe
	3k+437XtUC5Lol8Hx929GLx5fFhlLamcs=; b=GLV4umYF01en9j8Me5IIeX7wfS
	tyCvSVDuKwTo8cdqaKlmCpMUNBDdgx2vdrBVctUEgHzI+btRAIDbIIYhyu2dyBYJ
	eZ282zMdIYxHKoclW5BBtxvvQ8VfvKaYRuOUaOkiIvm8kp6g1Xd3RVgo01nSrzch
	C9akxeylbgoxaosdUcOv6rKino4FBnSYSWSQwQI4JZLDSzHrKV8+aGAJrDLd2OQp
	j47ARHslFieXSsp4x1yKvnok/AN/2on1knDEx0o9hXC5lmwwDDFiwqicxtRL/Hcx
	DUaz+y3gROrN/8rtK4cc/l33byGnS6bGvwaFuNJMUP1htvdVf3X62HHxUtww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778808506; x=1778894906; bh=IzO/AsfGHe3k+437XtUC5Lol8Hx929GLx5f
	FhlLamcs=; b=lPQrhLlP9Ie5zbaSRgJMSRFMD+MQDnmsArWQifg37e66ErtvMpr
	nNla4i6c6HNbH8DSvxDu1dUk8d5QTN7HrjXc9g21p8xyB5xeT3EV2+++H6zJKEW+
	fbqDuzaDt2f6oCRb0J2vdnxgAMmtKg57wFI3ag7CceQLTEa9qf3GHWrFDHCBr576
	tT0vIh9k4/ovt0cnA/7VOvOnlnJWI/1Taa7gJDyCOkCDwgd1aSllm5geMcjQaxXD
	CiQEFjdnx3BP3XO9WlqZKiC3zPnTcjJlsqfROdVvKy/V5kHRwYc0s/Qd7es9TOG6
	2nuDv2txypl9PfyBj5pUodOlLlT2qjHYhjA==
X-ME-Sender: <xms:unYGakoxiObIxjdj3bKmsP572uqBuRxgG0EOCT2iiFTb0pt77hmW3A>
    <xme:unYGaho5rIOQ7BjGu8ukFTtHhcEP2bnlhOqM3iAMk5aK5RggZeE6Sv3tjAxNmfUiS
    FK3KpRSka-Apk-85DirylYEdKCCbRfQUggcY4UKcZ3DbphdXss_eA>
X-ME-Received: <xmr:unYGauO5g2mPpF07dvEXR5P3ezbpM2uSmHdk3XDmevj1N7I2GRlshZQj7d1Zn3uyqbRPKKaYz_MpK0j1otWD8JnP5iqrm9XY7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:unYGaqwlfFaN0os2hQ9Y2u4wv_Pb29VKvFYmgWp8jOrlP6VcnCHFcw>
    <xmx:unYGavvHhewbG8py7qyy1Okf6kkyonA8LJKGyq9lVHWCUZEWXMioGA>
    <xmx:unYGar71mzoJIqbEID776Kw0_5F34DmDafct74PxYrvtfXwO5L1ICQ>
    <xmx:unYGamRpQ-qvsnUzhYWsvF3g0TnVqNRo5UNQilAZDNa6_ogWt3hDWg>
    <xmx:unYGatv5mZozRRA07Mtb_gk1HiyPrWxHJK0RpnjBOqJdSkxkwDot1PXW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 21:28:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH] fetch: add fetch.pruneLocalBranches config
In-Reply-To: <20260514221602.9918-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Fri, 15 May 2026 00:16:02 +0200")
References: <xmqqqzndel8c.fsf@gitster.g>
	<20260514221602.9918-1-haraldnordgren@gmail.com>
Date: Fri, 15 May 2026 10:28:24 +0900
Message-ID: <xmqqecjdea13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> I also wonder if, given that "=" in anywhere other than three-level
>> names, is invalid, we should just start accept
>> 
>> 	git config foo.bar=baz
>> 	git config set foo.bar=baz
>> 
>> and interpret them as
>> 
>> 	git config set foo.bar baz
>
> That sounds good too! Probably even better.
>
>
> Harald

Why do I get the above, which apparently is a response to my review
for

    [PATCH] config: suggest the correct form when key contains "="

under this thread?  Am I dealing with some sort of mechanical slop?
