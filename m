Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9E22D781
	for <git@vger.kernel.org>; Mon, 25 May 2026 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693450; cv=none; b=TiN4YC3fGDwNUd8fMvbfIb7d1FTNEb0+9fVgD9oUleXwsx5khiXUXvlmFX3Nj6ixQS6LGXwCIXCznBbIvhP9ghkffG2dZSxyocBzPzNyAjnGMzzJJN8l+JqakqJ2cQPxjHvNlfdchCC+pRta8Of6iYfr7psFxitwfD3aURuyhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693450; c=relaxed/simple;
	bh=HbhApqL1XzEmYbRp2wTHMzq/51+74Gh3yRX+AkahrwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TVUEBCSuQtRJqc26VZKOtxPwjZIAy9nkXArI7R20p2/D3n36hXYkemDRibO6RCY5mfiJzphWcsv7hD1mU0M6ZQ3ZPjebOeB225WmYAlFl0h/nohQ4np0+ct5TqPQNUv3cLd8jOo2G42NV9RWZu3bk41KARU/cvG0K7HGtbT2LcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A/JDSAQc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NsfucDXt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A/JDSAQc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NsfucDXt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 99730EC00D4;
	Mon, 25 May 2026 03:17:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 25 May 2026 03:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779693448; x=1779779848; bh=Jeu5/urzBP
	VqBDZfs3kDh9UlYc8drxN5SPw2ryD5dgw=; b=A/JDSAQcc9J8bmJUkCVGRZxI3u
	joo5DNiGqUrEg62Yg54JL3yItf+EWJZSXQtDFZXh1g1YHJyEoYkAuCQNw5S5evwe
	gUC1WRC1Gb21uww4CUObuA/R80DUI4OGIDR1b40xkq4auEDIVjeyNdf79jVIVsN3
	4ZxplAI1P35dolUQQFxFG0uxvTqZcz1doHqDcUxhynsJ+MUXR0ZKKYtNOsf277jK
	zOpQhfVJFjzPetVmywFwVEzLzJP196qrR9szXwASDDQudVXK8cPRIKCqjOQ09bTK
	kMVy6dCknbAVy6bkrc/J9M0cXx9N2NyFjBvuSfva65gw+WdgbO0tgNOitW8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779693448; x=1779779848; bh=Jeu5/urzBPVqBDZfs3kDh9UlYc8drxN5SPw
	2ryD5dgw=; b=NsfucDXtsdZMKRa0RKVu7bU9ERQEpO5zgQxzg3qmJMZTaWHuinj
	aCus+1+CCZYINQoShmKuN0MmeG/gRfV08M+9rPVF46XWXsARgo/nU2qi0xBM/Ra7
	tHGZh38eMIsU8dK1Yt91I9afz5rKobuZ0u72y2HrMo7OPRSTC2sv6oQcYoYS+6iL
	dS0LPY6fuKVxBeSpGRkTwcCeqJC1/D2nTm+rbGbOy3RMWP+5wnQGNvxEgzBEWTgi
	TwvrznM0WDd8jEwRxNXn219oVLQK0JMu3gAS+4ZZqcRRkBN9uVnEJHp4tFf33aq5
	t5yPqTniZToNQxkKPk+xXm0V9As7kpwPhwA==
X-ME-Sender: <xms:iPcTauRvUYADpPdzXpYwl5NwheEgZ1OuWHT5J7XxToORJFyIp_GawA>
    <xme:iPcTaqpikMYPS3o2jWWYWEu2fhERmMS8JF5YPuoJRfF0wHTnt2SAm84V7UZEnXsmB
    OODv0ofZOH5kpRuwchOUM7oEgXEjVo2f9NG96Y7Gxa_ODh6gQ1H>
X-ME-Received: <xmr:iPcTakJR6Uc9c1ho_4TZN1ThBWocX8bL-Th8cEBx06SQOkofqyVgWhnkAIjIXUWk3uJ5P6OMmixU3z9C31P4CiRaOO_vP_ONkZ3K>
X-ME-Proxy-Cause: dmFkZTEnr8Kx/U9t7vWSns8yEDB36OSFSghTRPkhqWqwVCdvsauvHap8Aj/9Cg8bt4ZPLG
    1mTmx29dDzUrdKRKqaYyPPVLDnLc3YCNh29YLFeUJs2WvNCm7xtN1ALilvr5l0ROybFdmt
    cevbfjgFAODxbFM4IOMJHJnuoXmSVJSzDKoWXaKoyVi0ouFiyZH38bictVfTowQLrVaOIn
    wIJEOGdu/Rrf/ox+MZpYnb5WNdzWR+VxWoq4HYkujlhlPD+WB16k80zMomGGiSSipBIsQn
    FlePtkk6w4nmdUN8BvrfvO4kFYJk5jb3K0XIs1xEq8cUA9LhslfWq2xGOVE4grl+uaJgmO
    c4duEV3PN93TASoOLN9IfjyDDyIbXfbgNzaTPV/Mz/3U/1ZZ47j/YJcMcjau40I0KD+vhF
    unqchepgNMdpw8KIjd8UxXGJh6BNeguQ9/mTePkLM6UOGOY0tLW++2B6C+I/y1pwW0/03D
    dxMHXVKOweReMRTSlT1RpE3aDgCkeITd6QrCIJDWXI/1bbwgZnsQtTiiFfkebNvDMjBQH9
    pVdMTTXjiI07tCXeAlScQoSHAjN2/NlBT1XmvwX6i6DoQJnC6LeO/jQz1HkYO/dzQYnpAb
    fP0hphva+ip0N4eMUY3FagxVtghNoW5/UQc0GTPwBNlhJIprMZRmGnG0O7PA
X-ME-Proxy: <xmx:iPcTaloP0udCzX0Zg7Gwn677dzGTQY5b6R71euTBsnN2HBBJf1PXNw>
    <xmx:iPcTakwiSdaOqFW_1J1pFwskaR8aZ-gkYHHYqLm0yKBF0JXtOSukhg>
    <xmx:iPcTahM8AHyRhsjxkkJ8kjyr2Qo_6tc6enonktC550viOF8xFuA1FQ>
    <xmx:iPcTah7uzzMoNzJKhth5di5eBK9EusuSvX2yAOYZdLLAZGP4bVHWEA>
    <xmx:iPcTavqI4Y0SfmwLMXJSgOOMEJ4LbhPE6sZ7wsjZEUJ7bsqtUtDj72W1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 03:17:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Derrick Stolee <stolee@gmail.com>,  Kristofer Karlsson via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] commit-reach: deduplicate queue entries in
 paint_down_to_common
In-Reply-To: <CAL71e4NxpbM8QZYhVA_SSC4vDmAFv-Kpe6qDcurefgPkSSdSnQ@mail.gmail.com>
	(Kristofer Karlsson's message of "Mon, 25 May 2026 08:50:11 +0200")
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
	<1d3751569ba3a5f0c353fb468578d6c5bcd0b738.1779644541.git.gitgitgadget@gmail.com>
	<xmqqpl2kgyvy.fsf@gitster.g>
	<ca39c8ca-ca4c-4954-a1ab-633bfa55f64b@gmail.com>
	<CAL71e4NxpbM8QZYhVA_SSC4vDmAFv-Kpe6qDcurefgPkSSdSnQ@mail.gmail.com>
Date: Mon, 25 May 2026 16:17:26 +0900
Message-ID: <xmqqse7gez5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> While doing the audit I noticed that reasoning about flag safety is
> currently entirely manual. Would there be interest in something more
> systematic (e.g. runtime registration/assertion, dynamic allocation or static
> analysis of flag usage)? I have some local work on that already, but I was
> not sure if this was something worth spending time on or not.

If there weren't existing code that are so tied to their current
uses of fixed flag bits and assumption that nobody else uses these
bits outside their intended use, I'd love to have any of these.
Uncolliding and unbounded number of usable bits per object that are
*fast* to access would be good (and commit-slab was an attempt to
introduce a framework that can be used as the basis for such a
system).  Independent of that, if we can statically analyze the uses
of these bits to prove that the same flag bits are never used at the
same time for colliding purposes, that would really be valuable.
