Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF02E7161
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943633; cv=none; b=DMqIUOSlGM9xouBt3h2V3V6GJ3VA0Q0sgGeJqR8nobhw2YcN1gFmy4BWYLNn71jiWKBTwLPXP/aqkoSDwzUQO9tD5eWV225mOYcpoz8pwDDySuBO9oGbz/z3WQXb4xlfdp2zyIZSaaIRyhhWKRcysTtrB7x7HKM0Jh/SgQI0ATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943633; c=relaxed/simple;
	bh=eH2R8vG2swThE3Mr2RmLmn4iKfoOV9t1EKotqsA6zQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BgkkVFF1YdHcUMh4CDqAmtoxl9Er/tg0+k0hjnGzdaRS7MpH2SXdzAAKNVAMVd2bnVtPyI8qU0QE1RHIdDdgK3orPCP1xUMDj8DiIPvWM9hdjV5oZL5m7bjiVRcGm0YS2EjOV0Gp/2sFB5NvgrzFzDwIYyLroDNn50X6sX5t5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HTjFg83N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2HTUXprR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HTjFg83N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2HTUXprR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 770457A0064;
	Thu, 19 Mar 2026 14:07:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 19 Mar 2026 14:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773943631; x=1774030031; bh=PJqHDYSO3N
	MI95KWTTPiakguR/UYETv6vyaNR2glE68=; b=HTjFg83Nm1nTuORE71i02iEx9E
	OsoWT3h3tvxBISqGLsXzBGTlDY2aIYqaUL6yexAak+YipMAJPZtQq6uwcm2glJrU
	KAR9oqTxSbhmmoAvhVzAGFfY3VyPgJfvj3fla8c2/jsDtAah/kQECwx0ableUV61
	+XYpaD70O9qyxunev+bSUngHaaOMFK/Sd2Ls0URQvv8w7JntvBsbjiw8VLIDyGPF
	zJjm5QrIPoCszsAyjmQ9CNOOQlBZ/8ftHWTYNGZElvMKfQpETOyFWzRu6/YLPKGl
	NKVWW9OtIkTwtu+4mWR0907gqvftQmmRA9eEkTJyXjhr1afnIXdqM69Yd3mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773943631; x=1774030031; bh=PJqHDYSO3NMI95KWTTPiakguR/UYETv6vya
	NR2glE68=; b=2HTUXprRcOeaxtdqPwF8ep4RhEnqjHhJLcPMqTgVBPDrKSF2YQb
	oy6YRQWALY+QLuX05P97Eo3lj6AZvwIEy1hajNo8e8j1CF4Fw+2qZK1bgP5L7iJt
	V1C9VTeaMsjMEUxbDFPgnZ7wb4JFCaUJG07Oyajj2QWKRRXhGYrY+y2idUVPCdag
	WnuSc2OQFnhUSwG8qOhKT2YKlFcKIVSN2JKz3OGjHPpe8QVQexbu1b9wVOR5Udkb
	MuSwqJYdCcZhLxUcbjDyDYqhquSW/0fjD9vGeQmiA6WzrAuNuhrQO86ZABKeQn0q
	9dkCA93sACXTB3zWjEfzten0LP3Lc8+EzKQ==
X-ME-Sender: <xms:Tzu8aUufzA_tsDOpG2IVoaTPxeDmYvPqKT9pOBhLsv5mckCPvNj7KQ>
    <xme:Tzu8aY4sMyaqVyYLNq8SI-KVbOkMyrPvWxQNyN0aLnGBcyx0wmCvwH0qH3GBGovTF
    ot8L2oe3iffewauGQ8m_tZxQu35n5jgk2LlCGVBMMvX81p_Fi9uF8o>
X-ME-Received: <xmr:Tzu8adKUN6lgXrNwS1wExDD7cvzmKOn85R2TZze2209itlY9rve6ty6hgDEfaCNAqgNCbN9xMmVV8jJknMielBXh33Wkmq0jdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtsehm
    rghlohhnrdguvghvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Tzu8aQ6NwTLR0tWqPoq6ermJQ42lXc4IVFg0YPLdw6CHt2-nN3NH8w>
    <xmx:Tzu8aYwebRhLg5mvRlkAonsT-JRxXmtr_wxEHklsTB7hI-COtbPg0g>
    <xmx:Tzu8acZKiQulCmVN3KxC4mSjjHkSIWpsoiN9dNJlB2SWTBtDlMsNPA>
    <xmx:Tzu8aSTE_VLn-kuD2DW2JMHNiCLYZ9pu4HDa2SVqYF5JpzP2CbJSWQ>
    <xmx:Tzu8admurW1WmvF5CauuenPrCvf4wq_3s2demfXO2OGnFQW-pa3X8E_A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 14:07:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: Git <git@vger.kernel.org>
Subject: Re: [Question] check_repository_format_gently() is not
 side-effect-free
In-Reply-To: <c0bb931a-3ee6-416b-8ceb-9fab013a621e@malon.dev> (Tian Yuchen's
	message of "Fri, 20 Mar 2026 01:45:25 +0800")
References: <c0bb931a-3ee6-416b-8ceb-9fab013a621e@malon.dev>
Date: Thu, 19 Mar 2026 11:07:09 -0700
Message-ID: <xmqqfr5vlmlu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

The verb "check" does not imply side-effect-free.  By checking, each
of these functions tries to achieve something, and the way the
result of their work is conveyed back to the caller may not
necessarily be only by their return values.

The adverb "gently" in this codebase typically means "the variant
without gently signals problems by dying.  Instead of dying, return
to the caller with error code, so that the caller can decide to
die".
