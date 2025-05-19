Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8866284B33
	for <git@vger.kernel.org>; Mon, 19 May 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667731; cv=none; b=DtNucFDcFeBVWM4zqpVau7NI54AckKLqqdkPfEMQf5UJGBL5B/ikF5R3fltoKuB2FvPZ/yeNKrbAsyervW3uzzBksa7idFG/ixnJN+iUcBdwf9YOOIphTHQT8u7u0sVqMr9bRQl3KhpI2ZQ5buhQQ4zZ7b+f4S9XvEeXhzEzwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667731; c=relaxed/simple;
	bh=lb2rhauB3B5cGT21iNr4dHZPsSQ3hx4IS01DDevEEFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IBDyzmfw2E32v8lac365aHMyyW4egUuki+JDApvWXAv9kqcD4prQnPPvgm+1W5qwqJv16MJ/vKSfttNBrC0gpAJ9whucY3b/eEnDGCFSkE3IjEUojd7WIEl+PJaBW8gsLozhWmu0/MkLC9iOQWu4Lr8kw7Q1JRH6wseRvnDvZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IvuSy5GQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbdyYz2s; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IvuSy5GQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jbdyYz2s"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90B8E2540140;
	Mon, 19 May 2025 11:15:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 19 May 2025 11:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747667728; x=1747754128; bh=9Kzbtf8ksH
	0hvCmjrZYh/RazpmlWZXDTn+jO48swJzU=; b=IvuSy5GQkPN4iJTtS1rUDEK0vU
	DWd4d2FpqWtyDRSNdWVJ6dnu5pxOmOUI7RCV+Wmi9pZrp9Ei50zQdAxQfnyb6ZG6
	OpqirdhFpYtPq8nz7BbWFy/xkAIN96jLi2uxSLzqukK6OTf3CqKADZ4Hgxf2HwB5
	Q2VrkVAy3mCY6KSQDoBl8/Cda4uRYt/LVRWET6KmMYolt27CMowazfhtHPmG6koL
	ssdxfvvqNZ5u8s2Gl10YCazpc1Yuz/v+X9V+bMem3GA3wUw0AgN6pyrvxEhS211a
	SM4dQgzu0gQ/7E3fm401lV1BC2Bam4nVQcA3AJkVxdTx1/hkbT+BQ5aPQ/Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747667728; x=1747754128; bh=9Kzbtf8ksH0hvCmjrZYh/RazpmlWZXDTn+j
	O48swJzU=; b=jbdyYz2slcpKKCVZX6Cj58OMeyNbUhlJFQPynTtVVBQCT5PQoFC
	uLksu8BRs4rGlJ0G0D82xoyeOeMtmdoXXrwCqe/GG9BRnU2/FTfmkq5F5PWcISLX
	BwGae+b2hih2+e3cbCy37kfKrTkJxCEU+ZvlPP8WxpXv+E5uXfJuc1iSK8zl013J
	II+rpcfxNFkl5oOWI0fRjiaYZ/Ad2F7uN6irZvZGPoGqpRzZkLcnHJ8kT24gAomx
	cgvsRdd8G3aBUrdqqpE0ss3Hax6Acs7cD6NxKDnplvH/p4vF5Kqr6zF4jEBEbskJ
	gBkfJ6Q3jKUANDPHzheERRLci3fN9Nqdt4w==
X-ME-Sender: <xms:EEsraC8E0b3vM2poc07A6gb8gb2Cehfy7PAzpm3FufLqE0AA-kWndA>
    <xme:EEsraCseC4FwgQYgo2Q-PM_hDG9GsqjBKCSP2mHgSYYVPfDtyGJgZtWFVGKEKGEc9
    7Kfskjc0aEhBBJ9Ig>
X-ME-Received: <xmr:EEsraIDS2v_JLrM48uXTiSuFrqbnVXaoVtSiq7o0S6Y7gQFvYhMPu6ZcVp4KqyiMm4U73mEgLoqsT89f2-fSzk63j176mTfZfpaYDhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddujedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:EEsraKcMLtyoEv51qbZshMhor8Ha5PJFZJQTlGRNhkBSg67ZGootDw>
    <xmx:EEsraHMxMddZkbJ5jWJfB1mdHtEm7_ambiizpBbosv2s9-SAeHPFXw>
    <xmx:EEsraEn8SaPwXXB8dMsiW1wQH8ylJflc-p5xWcWBO2LcyHJ404rsgg>
    <xmx:EEsraJuSE1Odsk0pRO1w8jq0U_7XtBMMxrf-wz0ySeKxWKV-HuXtIg>
    <xmx:EEsraPJqR50Et1dLYeq2xQVBhN9cA56Iq4KNsqQC3aNMpXTInU0Vn3D_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 11:15:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/13] hash-object: stop allowing unknown types
In-Reply-To: <20250516045005.GJ22242@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 16 May 2025 00:50:05 -0400")
References: <20250516044916.GA21985@coredump.intra.peff.net>
	<20250516045005.GJ22242@coredump.intra.peff.net>
Date: Mon, 19 May 2025 08:15:26 -0700
Message-ID: <xmqqcyc4pr75.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We will retain the --literally flag, as it also instructs hash-object
> not to worry about other format issues (e.g., type-specific things that
> fsck would complain about). The documentation does not need to be
> updated, as it was always vague about which checks we're loosening (it
> uses only the phrase "any garbage").

;-)

> +test_expect_success '--literally complains about non-standard types' '
> +	test_must_fail git hash-object -t bogus --literally --stdin
>  '

Yup, we obviously want to fail this now.

