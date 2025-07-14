Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4E845945
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512482; cv=none; b=dNF+w5bQe/EHDeSk6fpuDXcRlc2sS+2cS4v402NLO/D293iInnjUiOlV3ecOIU8QusHZ0s7HVFFUGFnBHIFf0AoXw2UdC6ABfZ2RUpw6/GV+Y8mxJIXYbOK+3bVttcz2Pp2itda6nRLnl8F+P/zU5mksuLT0yTHr3E1EVWJAoDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512482; c=relaxed/simple;
	bh=juy74xCceq1qL8d/pTXHHk4cXlBx4zOBI94DAeXjetc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GwsKkaQjcPt1IjDmPO3kdZybk/oI/lw+Sd4Zd5LzOg9QaNMMekon5toKBnxETjf/mgGY1J04iDKpMId0Co8B+2P+M66Vph85JLm+bTyvLEz6bvzuX9SLudqXtp/h4pd+z1scNNhQahT+VY0l6f1kmhk/QdwkHvXbFcDJNqXNxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CtIZQbNk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lf2YEuRO; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CtIZQbNk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lf2YEuRO"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F06151400191;
	Mon, 14 Jul 2025 13:01:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 14 Jul 2025 13:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752512478; x=1752598878; bh=/mboUPNHmM
	8+xFoutzi/CdWLLj+GQutMCMgBJVoW1G4=; b=CtIZQbNk2lvpPaJgcQF0GufhDE
	/ujSezBOYEOqICr93qWJ2xwJ+mmTm/+T2ksvxiG0psNPQylotbVsqh819j95/PSx
	Zkbzn1k7ifQ3dpBa5ZQTzmwCcKMJEn7uh2c6lDZv93RrdHCcmlDsY9tajuY8y+ch
	pbYC3jaSIJORYgDVHDSRba9fD+lDrtt0nAc4v20Dj94QVXgKAGGodLElSI5ArQTF
	Dh48g5gFFPtHMG1Q5QnT1kXYndf/0Aa8EnBHvG2SnNtRJasROgU+ETQndp8njKUo
	KK1I9PkDPWXTumPT0mDDk2YFC6agbrx9OsibCK6y2jpL0tDx3nm+G9+IsI9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752512478; x=1752598878; bh=/mboUPNHmM8+xFoutzi/CdWLLj+GQutMCMg
	BJVoW1G4=; b=Lf2YEuROGhdqP1jjXi65z4rfWkS8MDg2pYslfSn8nPmaFzB1aK6
	P3z5qXJSOZ8q7wA0BwX4Xlz6ac7DTtyqv6kk/3YH5f5dAMlY++vX61E5TYWjzP0l
	gb9eAU58u6gZBeWjv+s+EQQsvIziGexa4sxUJxY/cmeG5Ruidb6oNV3Zn5ziKMY4
	mynXQvzqr68dwwr0Q+ODOoQsh2Ua2+Z3O+bIsqkoGmLe/SWuSieYSYXF2ZchhtTd
	iB6UH12aOSEL6tCIrrgkHTFmElvfyhdw9QSxuCnJAf6la3A2Yu226Y+OMvFr1f11
	LKnXLt708Ou4i9AzBYBJOJoceOdJEUOsPwQ==
X-ME-Sender: <xms:3Td1aCKXvmOeWhnC2-0zt3FBJpUXLNZ_q7QKufBxSs0MPVsfoszShA>
    <xme:3Td1aIEtgNl7eT-0IQZK8Via8jvtvjs7I78etNYW8jQxrg9iWMb-iJ4JfvMSBsGyI
    27bUIv8QYyr8U_KJg>
X-ME-Received: <xmr:3Td1aFCH0oyTsPo0TtNck3BmjS5M8LKjYAzWethtO_YuXmeZBvW15eyziJPSLuYoApObi4GcsjLueDItwmhb_ay-X56jqhJn1iqdLPY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephedtvddtvdegfeeftddtheeise
    hsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:3jd1aL_XuIGPeTHo9R9GGQvtteSGV09G5_ryzh_suE9FUQfqkWBeIA>
    <xmx:3jd1aBDmircjHCOZqa7yNoX-aLhGTQnw-6KW-jdGoQb4SKdlD1tX0Q>
    <xmx:3jd1aAQkDE4kaI-62zbfSOjN7sUU3BrjMg0HD2i2gblDFjRcfoaGdw>
    <xmx:3jd1aIsMZ15E4C19Vwl3a_r8_Y3JKgK03KP8_7mEbloiHV8b9lGWQw>
    <xmx:3jd1aC6BZDpAMLn_sFaTCER5wviDKVXJ9exU09MbwZm9H8hTQttaTbts>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 13:01:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  git@vger.kernel.org,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v6 5/5] bloom: optimize multiple pathspec items in revision
In-Reply-To: <30afce8c-c932-4c51-9a27-e63385608514@gmail.com> (Derrick
	Stolee's message of "Mon, 14 Jul 2025 12:51:56 -0400")
References: <A25E64EE-CABB-498D-8B34-27588B349FAC@gmail.com>
	<20250712095129.24642-1-yldhome2d2@gmail.com>
	<30afce8c-c932-4c51-9a27-e63385608514@gmail.com>
Date: Mon, 14 Jul 2025 10:01:16 -0700
Message-ID: <xmqqbjpmu2oz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 7/12/2025 5:51 AM, Lidong Yan wrote:
>> To enable optimize multiple pathspec items in revision traversal,
>> return 0 if all pathspec item is literal in forbid_bloom_filters().
>> Add for loops to initialize and check each pathspec item's bloom_keyvec
>> when optimization is possible.
>
> The patch itself is good.
>
>> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>
> Here, I'll just point out that your sign-off should follow mine
> because you were the last to touch the patch. In this way, the
> sign-off gives a kind of timestamp to who made the most-recent
> changes (and that those changes have that person's sign-off,
> and may not have been vetted by previous signers).

Thanks for pointing it out.  Also perhaps a single-liner attribution
to clarify who did what, e.g.

	Signed-off-by: Derrick
	[ly: did this and that to derrick's code to adjust]
	Signed-off-by: Lidong

would be more helpful.

