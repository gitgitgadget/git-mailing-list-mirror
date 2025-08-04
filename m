Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4617F1FDD
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267956; cv=none; b=bKgbjVjZQPWntWZSlaCzkCsQX3Dmd1q18DrBuW9w8unGmLF9du6WOu10QZ0Aknnj5CL7tOL0uUxQVUR9nEaZfYhScoxxmSuwevgECSUg5IxSsEylcSNIDrSMYOi/pVqoOLClrcZE2dOO7usN1MZOvzhY4iXwwra9JC613QjZ5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267956; c=relaxed/simple;
	bh=/Ss0pi8wIBab7hwFdyOgkqL84iqj2vIz/5B2TK+X2Tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WnM5Az3G8BGtdp86gATVaMb+NpKFNhnMQypM1s4cDicUnSHzmjojzS/QgCv9qaVZLuWzuWPhRxjWgdw2vxOR4xorI/Vqtsaf6XzPCV/BSDHg4cLy3shXpmasSlkyLXAeXPaBIBwnzGrCWjO2ukHnjPtgvFuWDYaTpfNMcI1qKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eRLP4PL2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C4NYiC0T; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eRLP4PL2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C4NYiC0T"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 144ED1D00093;
	Sun,  3 Aug 2025 20:39:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 03 Aug 2025 20:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754267952; x=1754354352; bh=HzE4r1UBaI
	CK+KrLmRytQBjEqXfYubZ/LPklmx4I8ts=; b=eRLP4PL2zKakI/DeELcnB1wKY5
	KOgH3hyBJSR8K52o/Nyvp6Z+iMh5z43Z4W4EIV3aIrH0Ru36O2e4Q/swr9OKRH9g
	dkjA7+HL0KImSKGlcnz8Xe/9GVfIT0y5kRvcI8RP5dGOX49NsImYcD+s4FVXMB6V
	GhlK+c6mJPa1C3Azrh2yMPzBZg2Jqt+/Xvpi2bkuGSY0eIHgdhh+GCOtkevZYuyf
	Yt3ikh2bU+k/YiQtaQeu3u6c6fgkr5ACj0hXvbQbhWb1mAf5y04kL4DRQa5DqcA0
	sDLmam8reNWPl2VCjUY1DlrJH3nbGBhGXfIlWSZhUTsPVAxfJa5fe/Fxqv5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754267952; x=1754354352; bh=HzE4r1UBaICK+KrLmRytQBjEqXfYubZ/LPk
	lmx4I8ts=; b=C4NYiC0Tn9USR8YinnyM0Z3c2Wf/8Li8XIdOeAylE6diGpDmte3
	aLXgGdwpPc5PqCAjeBaKrQFra6IXKruplgagcyN0v+Y1qJTwGn8ZVvPBYp+vlPad
	DcuEvVRS/cRUHK/vpAGw+k+qoDhgb4QMVsu5AvkbAPwjCZYC3SmF6qGcn04/XjUD
	DJBShQfNqXXWGx6gvs0sjGOSRin37JNwd/npWRPwysL5Z9wDJxKqYNuBoMa0hIlR
	graEsBCA5pFPz4gaguiDT2hdhr2hisI2W5KZYid3jb4wQbzaalwqWBy7tGyAALwi
	npH7X6R5HWQ/RBJKhq+5MNMP0bLlI0SAMJw==
X-ME-Sender: <xms:MAGQaPa2zLl3eVDfzkYXK2MODXJ8K_ANbVPgi_VBAXPDLtLoliNiXg>
    <xme:MAGQaG1FFlAlcCLVjnzp3IgOI8bsMpXfRNcHpslKJ04ixs1p2jnGOLRhIeiZh6it1
    CpO2iGGEVtr3Q5Z2Q>
X-ME-Received: <xmr:MAGQaCbtRIa1uk4XZuy8l64UgxAWKwZR28BSOdxcn4rLOIZz6trXzU9cNah2iXvef86mYjXdG6OlSEYuqgoBrm4kStgjcOywC10ZLwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihlhguhhho
    mhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhhisegrrhhnvghsrdhsphgrtggvpdhrtghpthht
    ohepmhhitghhrghlsehishgtrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MAGQaGLs5hEr9N41NbZ2kWzb9IyjxgCIZSnS4k07JIFv1M43CPepMg>
    <xmx:MAGQaJHQOo084XCEtqgdIIduioFLbZqhn8Fuj-5K9EBR5UOhaNlLGg>
    <xmx:MAGQaFuKIQtBE6cANVXCWgEiXY7UDWvB3KpYsW37RXACgdVhNnxS-g>
    <xmx:MAGQaAuvR1RjdddrEX5CXEnvMuBYa3CA_r0SYb_dsyKGxd5BEWvUJg>
    <xmx:MAGQaN9YWVfGTYy4xMGMjpHATHm1PFfHrvRBEf_WWyPxB-Mjg8NH15gf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 20:39:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  hi@arnes.space,  michal@isc.org,  peff@peff.net
Subject: Re: [PATCH v2] diff: ensure consistent diff behavior with -I<regex>
 across output formats
In-Reply-To: <20250803145155.57894-1-yldhome2d2@gmail.com> (Lidong Yan's
	message of "Sun, 3 Aug 2025 22:51:55 +0800")
References: <xmqqcy9io73j.fsf@gitster.g>
	<20250803145155.57894-1-yldhome2d2@gmail.com>
Date: Sun, 03 Aug 2025 17:39:10 -0700
Message-ID: <xmqqfre7ex8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> `git diff -I<regex>` option is inconsistently applied across various
> output formats. In some cases, files would appear in the `--name-only`
> output but not in the accompanying `--stat` or `-p` outputs, despite
> the user explicitly requesting to ignore certain changes using
> `-I<regex>`. Not only for `-I<regex>`, but this inconsistency also
> exists for other output formats that have `.diff_from_content` set
> (e.g. `-w`, `--ignore-space-at-eol` and `--ignore-space-change`).

Perhaps the above (and code, like the name of the helper functions
and possibly the name of the new file) should be updated to place
much stress on -I<regex>, as "ignore-regex" is not any more special
than other things that flips .diff_from_content bit in this new
iteration of the patch.

I do not quite get why ignore_match() has to know so much about how
the real code in diff.c that implements -I<regex> works, compared to
the illustration of "here is how to do it" Peff posted, though.  It
somehow feels too much duplicated code.

Thanks.
