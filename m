Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6FE3A1E66
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 04:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765945898; cv=none; b=h5Zb4xa0rjlhwEcc+y0NMlxgJgS7iqhxptwISjYysttEEAP3gZeIzz4Nsrc9kcP0wakxFBHKrF8E+qHLUnpBKWgrsIZN+S6KwyVABWiKLeOREhoI1qyliQwr0PxFAZyLQr0Rq3N/wK3FEc58e7uIWnpj87AHik/35RnM/Q/HzoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765945898; c=relaxed/simple;
	bh=xUz46hAIvIjuZSbmITKuvbh+s64HL9AS6fkVCwrTTjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D35Zz3JRIfHcQVB7ffAXSRQlsyz5JfDesfVZZ+kllhRDIZ5p5mbnBZCXCSOrjvowAQWoS7N0bQeuVWKsBrOPFJA8pBn0+0hANGzFmdLwFI7XI+GdLBcGm2njGwnXqBXw4HVvZps0a+xWoDtc2o/iDzFpr8KZqWtQ7yA3xdpQuco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ca8xnk2o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A8vtFYF6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ca8xnk2o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8vtFYF6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EBA49EC0077;
	Tue, 16 Dec 2025 23:31:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 16 Dec 2025 23:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765945894; x=1766032294; bh=/tcfTnHfLV
	rRLdA3oSqrCQ5lVtrh7Rnu5LtWgpl+XjA=; b=Ca8xnk2odAuAe0jQuI6pFX7Goe
	K/hQIvnynVSeFaUXIEXiXSF7mzCS31EdxjSaQ0se2XrduH5kb/+juEShHDpfMzwc
	YkZiz6m0p84ma2gLjSuH0TA45XKvzRgiUowJtdFDSX/HiGchGMI7oJnrxKO9pcES
	VjHN1BKBOIiwx13R/aCYuFM33D4AHtSe/bnHfwpSin7M5CGdwuF28OuSNNfr9XKt
	W1s8NDBmyZpw873g3RqfSpy82vM1eDlQhXfShBWntWLyMYWwR32I33q3UC1tRcbm
	zQhbgjucXOjAFz04VL8I0HR28iwuK589KSe5jOliCAB5maSsuDtcvx4qehRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765945894; x=1766032294; bh=/tcfTnHfLVrRLdA3oSqrCQ5lVtrh7Rnu5Lt
	Wgpl+XjA=; b=A8vtFYF6cp/TltRe4NPurw7KBNMX9E2lKiZB+ENhA8aRwXveM1b
	oeZxH8b2zsfnzeghlu8FzWifoTHfsWR3tr1/6k1PL+cHKZHbHLmW5F630qIg3/na
	oq6YIjL7HUN6fWmglPCNz1mN0Czj6+w7q/u2qVSeNlqsr3obVios/L9YIZvSi3BK
	g35ndov4zEQCZMddrQ90wpxA5QwAWOqCIDyC+35+sNPar36TIopIUomu2bsTEKvm
	Td82PkpFUkBysXL6cCHY9UQshWAh8cSkkTd6XpJoBEptNcfxQF3EOHNZzVYAr2jG
	K++cGI495svyX1rC5SW3hX6KAgga9BYxuUQ==
X-ME-Sender: <xms:JjJCaWGyqSwoj22lGVzTBrKHWjUs9KrDPePLbzSiouPwTBt8Fde7Kg>
    <xme:JjJCabBaYQEW4xfEJ2fvw_tVKlm_uBuMcb95Rq47-mCDJmKt6WUq88MSHF8268Ayz
    ui1Zlr2dcrN0GbQuPn4HerlJ50Q8KzjGNtk4tpdepiHlEVVDC3vde4>
X-ME-Received: <xmr:JjJCaZ8X8ZBokj5eIe8T8dAajhJmmgi2O-P6X-ThOCa7aeKW7fE8SqSc-zeRPuWFrNoCVuhmhmJkVJZg2LPbNCtol9vWT9CWWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JjJCaXBYYd7SONJ36Qet2JQPo80mRUgCtKjN8LUVnQjgAA_NBf6Pog>
    <xmx:JjJCaeQWnTKYDb4nGaS8oNu2cMBrIEx_fcCE-tUD7pGCUYLIYOxDTg>
    <xmx:JjJCaeu10xCelakt36k_rwx9yOrHfIJNy_icZh77sjlGTFXRb7el4A>
    <xmx:JjJCaa0NQux_N2DBKbn9cfGQKEjlKP79EtBjb16ffPDhCw9xpNXhBg>
    <xmx:JjJCaTYpqR_gj1VPXrfxY2YPPDRGBB7d_qRxuwA0Uk43TKq6z3j6PP4Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 23:31:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 00/10] Prepare Git's test suite for symbolic link
 support on Windows
In-Reply-To: <af386607-127c-9acd-6d08-89380c1df570@gmx.de> (Johannes
	Schindelin's message of "Tue, 16 Dec 2025 20:35:05 +0100 (CET)")
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<xmqq345a46b1.fsf@gitster.g>
	<af386607-127c-9acd-6d08-89380c1df570@gmx.de>
Date: Wed, 17 Dec 2025 13:31:32 +0900
Message-ID: <xmqqms3h3f17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> by looking at the range-diff below (i.e., no content changes, just
>> removal of bunch of lines from the proposed log message and credit
>> for Patrick),
>
> ... which suggests that I simply made a rebasing mistake and accidentally
> dropped the credit, and did not notice it in the range-diff because I had
> been staring at the diffs for too long. That's exactly what happened,
> please reuse the version from v2.

OK.  If I am reading you correctly, fetching from the v3 pull
request tag would not solve the breakage in [06/10], right?

re there similar "oops, I meant to change this and that but the
resulting tree did not get any of them" for steps [07-10/10], which
did not see any changes in the messages on the list?  Presumably, it
would not help these steps if I fetching from the v3 pull request
tag, either, right?

Thanks.
