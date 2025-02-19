Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BECEEA6
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983982; cv=none; b=HuiUqEvGKLoH9hB4Fy3HP16JCaWVUzyyNat9m1B9HFKihi7ugashEb0gFtkyAYJP2UIRQnuQJ/xbZpi8JE1gicmz2PoVaOjciwAbkUzzYrLwWF8QycQLGvmT/1nltXrQdXoQOVydLbACejK2r7AjPsYQrLfgAB0PczhHleAGLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983982; c=relaxed/simple;
	bh=EAL279M6Z2I6OQYaBy6LfW4ef4Q+kBQk7dU7MDLM6Hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n4PRpfb7GGeRjToIZQA/XXcQrfOABBEc0NBQtXKiqrPwslRnrs0VQ6MYkdkzzdmFmmdTYMWXij/yk9haBvGx73KBSVFdHiQlF3dAMHfM82iVuUbsmGX9QliCxzrHUJM2i6tagFsH1iAgcpvYAXydv9zC5vEF+xMlA4pXXX4YQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DrPt+Izl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=stb6zRDH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DrPt+Izl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="stb6zRDH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F2CDC1140126;
	Wed, 19 Feb 2025 11:52:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 19 Feb 2025 11:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739983978; x=1740070378; bh=TLzMPUEeZP
	oD+O8C09Z4JDKfkzwnWnlfS50LNf2F4SE=; b=DrPt+Izl4IzCX9dgF4as1fwSrd
	fYQA5/2zKAQfZz0Gxb77/AptS0mjUsOkxMENzMEo2pf17J6GIOnuHxeGKoqy1FSb
	pwb9ryo2HGDIurHORFbXvSbPhRCcNo1s3ttE0lzgcojN95yAJaouyAALaUd8wwV2
	3hsvu55BXuHpLOw6x7/l4BaTdUg412EMvCWH0hrqWcL+VkI9y6x3PLB1JdsCiEJ8
	Bx02eYJaF184va+dJQL4F3oj6o3QeTvg+wZapNipBrtUmqrAzAv51hx+K0SIDL+9
	7VF3iBKeDvMw10NxtzJ/87dRSbkr10HEabCVaIsLCsWVXoWD7EV0wVtVcP5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739983978; x=1740070378; bh=TLzMPUEeZPoD+O8C09Z4JDKfkzwnWnlfS50
	LNf2F4SE=; b=stb6zRDHm1onKOXk9x+GYuTVlsk3uWnbM4MpDZRomonwJpWJJw9
	oDnELzf4TUz41WD+dIAXjT8LwHP0i/GNWLmhxJui2CEedBM05n1j8kVuPlTX53wo
	gOdy077dJW9heAn7JcXtSE+pkfvmjI8Ilje8GerDuhZWryYTdASxGQpnM3FvhhE3
	Hlmo9CdvKpN+P9mLGeN+tkkr1BEcxkAUiCvJDduY2tObH27edyVXPa7ZtsI9/WR8
	KyPiC3FUJINZm0dnx8aw/+9Qt+NFa7NreFGyPA+Y4GRm/HKDGlOWVB5+3ld+r1rB
	6nLaHv729lP4j2YKyOhN5Qs4iL157WqAKeA==
X-ME-Sender: <xms:agy2Z-4pkzRakIeFfFrnWx1GN0IGzbOlSArnFC1KOhVYihSJXFlahg>
    <xme:agy2Z37Ksu2x1Y2OaakkeA9jzB0UXbGsRMhn2zr1trMmAaJ8jyuP2vB9DiFnBn4tz
    lqFbqohWqmJ8ODB9w>
X-ME-Received: <xmr:agy2Z9fDlb78ozZGaRboY1o9Brx1X2FJGA7B_GVrs4Ti8sOPZclxXOsnu14nHWnieq6E_IQnQnSntRvAX_t8UJSKOwFVkZoa-TF0WYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:agy2Z7L4zvTUivrIJuuasH2KT49dXG3tbeyvo2ayyfl0_zBdyYb0KQ>
    <xmx:agy2ZyKU6wvZeGTwEk4mZakKU_eD3rWTgfiKUhdQ5AUKOxpaFKPK7w>
    <xmx:agy2Z8w6o0Y9FiNM-M8vEw7M4LfMjXETAVQ5vWnk1NqK2gTseaAt9w>
    <xmx:agy2Z2LiAEn1CQdosMev82zaLX8jW1-OYee8Ko4JJlO9eqyFJzTPZA>
    <xmx:agy2Z3Gb0-DPSnsbXEFcPChcjqwIHCYJcADV2_UOcgSBj5V9iuNuvhbs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 11:52:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: Incorrect URL for Release Notes on git-scm
In-Reply-To: <CAP8UFD18tgq6f9N189tn2ZrV5cWU8u34EEpZhkwRosi8qUuhuw@mail.gmail.com>
	(Christian Couder's message of "Wed, 19 Feb 2025 09:28:48 +0100")
References: <CAEiLEbOZ7vGE6U69sf5nK+G86zaeAMRTrjaCr=rF2JU1H1p8ww@mail.gmail.com>
	<CAP8UFD18tgq6f9N189tn2ZrV5cWU8u34EEpZhkwRosi8qUuhuw@mail.gmail.com>
Date: Wed, 19 Feb 2025 08:52:57 -0800
Message-ID: <xmqq1pvtho5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Thanks for the details. We are transitioning from ".txt" to ".adoc"
> for the extension of many of our documentation files and this is
> perhaps triggering this issue.

Yup, that seems to be exactly what happened.  When we prepared the
transition, in https://lore.kernel.org/git/xmqqmsfl2gro.fsf@gitster.g/
I said:

    Perhaps it may be enough keep the topic cooking a lot longer in
    'next' than usual one calendar week.  This of course requires that
    those on the creator side echosystem are paying attention to 'next',
    are capable of writing necessary adjustment (in my case, I would
    tweak my tooling so that it uses "$filename.$suffix" instead of
    hardcoded "txt" in the rest of the script, checks the presence of
    Documention/git.adoc to tweak suffix from default "txt") for their
    tooling, and can arrange to test their tooling with 'next'.

but apparently three weeks was not long enough for folks who are
maintaining the git-scm.com documentation machinery (or they were
not paying attention at all and even one year wouldn't have been
long enough X-<).

In any case, as I said earlier, Documentation/RelNotes/*.txt files
are never written as AsciiDoc (practically I am the only one who is
writing them) and are never processed and never meant to be
processed by the AsciiDoc/asciidoctor toolchain (I am not surprised
at all if stray punctuation letters I intended in a text document as
literal punctuation to be mistaken as AsciiDoc markups).

So from that point of view, it could be argued that we did not have
to rename them to .adoc suffix.

But I do not think it is a good direction to go in the longer term.
It may sweep this particular issue with a single link that the site
has into Documentation/RelNotes/ hierarchy under the rug, but it
forces everybody, including git-scm.com, to remember that everything
else in Documentation/ is ".adoc" but Documentation/RelNotes/ uses
".txt" as an exception when linking to our material.  And because
there is no guarantee that we will never update our documentation
model so that the release notes are really done as proper AsciiDoc
marked-up text someday, such a move will force the downstream users
to transition to ".adoc" eventually.

Thanks.
