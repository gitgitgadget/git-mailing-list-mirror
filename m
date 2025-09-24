Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5F1A76B1
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720020; cv=none; b=lGoFEVAkEhefKuHl+LNcphM9+a9AwbTjhgue305NQOzTSRK8fbBUM8eAaG8tqh8tEthNvYcEtreNflM/ZN/5FUtcoK9YmPv3CnmxB+p5vqP0Q/BxQgWQxWrbzMaak3yJJ5QDJ78PZ4bLKMH0xZJ1aEJgdouiJYZykkGTOaDSNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720020; c=relaxed/simple;
	bh=daoMcrzEiBXUjbdQnAvKmoOr0jysOxLlm2LdlHpnQz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NupURTcMy4ePKuO/VBVZ+7eEfI5+Bw6CpYzxLwN6QIbT6sKZJnxidP139exPK01jShffqEqi0ovcHe5JZ/b+WmbSidPCHXFP4mK6d7I/7HMWLj0vxXQ2LtCYpsr3O260D/HEdud312yzxiozcyLchVgvCAq9qTTkXh2fnFk+49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L+oeZl/o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VV+m51ig; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L+oeZl/o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VV+m51ig"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C73F1400139;
	Wed, 24 Sep 2025 09:20:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 24 Sep 2025 09:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758720015; x=1758806415; bh=daoMcrzEiB
	XUjbdQnAvKmoOr0jysOxLlm2LdlHpnQz0=; b=L+oeZl/oh54nv4A7hJL6I1aI0c
	4zqKvy0EvViDRpXy6vl515KiHBQaJqJw/MRTkzYOlDtLUnhlEON8ExwqgyG+14Wg
	/2XD6H3cge/BiHenI57fG4AJzvfg07/tttUj80286jGXWbHGPEHpG/9L5a0PCbSJ
	+7ApAZNcvguvF+1Z3e9coHci0eT1iGgvvCShwolV9XRad+B4oj+cqWjsmNvxPdOi
	JbdhfxMJXIkQ/VLuOQlPADREMdsJEyBg8CKd/dVmu/AWA0fq74IyLt9vmmE0xbO2
	SUEQ0vS2rNsnThvDUYv4ci/3QgwOHCqQgnQzqYhPS2lgixYB8jp0/iFpy7Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758720015; x=1758806415; bh=daoMcrzEiBXUjbdQnAvKmoOr0jysOxLlm2L
	dlHpnQz0=; b=VV+m51igY68v7fZ9rpn9t9ao3Afs0IToire2sr01sMKb8WGVi2q
	fxJWlSVzhpoQ36P0/TpuWQWFPfJPKcLuTXMS8FB7xuvdg/DxGBb7AVdPmf6wdrVg
	UMCIK/znv6MYvyLH+ljTmjb97+MMK33trHjolOa1E61i9H6OczVXxjICOsDCGELh
	zIsMb+oFGILqE8bPqfxcIwVVtMNaZW8aVieGJp6Zr19KOT80MM1EdCnEJ5lN8d12
	R29ZTC4XD04IbOeQU7rfs1bkFb6ijhseeomPHHVtSekROvcJiecmGTXtHR+DrUIN
	Jfoysz1IcRkyhyY78CpMgF/m4fnb88e+mng==
X-ME-Sender: <xms:DvDTaJ3eqWE8I-prYawVGwsf9bnRSvXKh_Ka-le7jDQs2QCQZQKt-Q>
    <xme:DvDTaDwYgokshPa8NxuyDzx1YvSHDtvsRYAKdN9Uxq1TtCin1hfFTsMaybJAMEX6R
    tld04GcefylOE0Uih6V24FakQoSsAtXQnrnqPWC0nO7gxeuqabCWw>
X-ME-Received: <xmr:DvDTaDuUPRabkiAUt8sk4wduMxgTP9BddUljWpZ9MXWF8ZBaTOZBE6uaUYI4SteAt9XYLWiHc6zdW6z8UOHXjfWnJ9wpYQG2ICUy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghl
    uhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DvDTaNyOtn-ARF82NzpjYJXlXnFjKAiGBBeTzwP7V0kqarc1Vi3qXQ>
    <xmx:DvDTaOBKWka2tMnkN0TyUCC9CuoQai9soEUHJaCFQ6Gpyx4eaU3nRg>
    <xmx:DvDTaDdAZ-lMwgDtPuDlKgYWCTDAPM0SLtRMVtKshqGt7-N5BnrD_Q>
    <xmx:DvDTaAk4ZBeHTxjPBcg8a-v814RCC0NyTzV0ypnXA8hc-uY-e7AhYQ>
    <xmx:D_DTaEkzNeCMPjNmKeZ0CUsmtD8rDM3XJXbllR0epgG5A4aTtB3i_a7a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 09:20:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  shejialuo <shejialuo@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding
 with "exact_match" parameter
In-Reply-To: <20250924053601.GC1173044@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 24 Sep 2025 01:36:01 -0400")
References: <aMp8yNFiXDyk2hP4@ArchLinux> <aMp9OtXLfRw7dEwA@ArchLinux>
	<CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
	<xmqq348dovi3.fsf@gitster.g>
	<20250924053601.GC1173044@coredump.intra.peff.net>
Date: Wed, 24 Sep 2025 06:20:13 -0700
Message-ID: <xmqqwm5om1gy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I agree that size_t is much more than one needs for counting most
> things. But the problem is that "int" is much too small, if you are
> worried about malicious input causing integer overflows that could cause
> memory access errors.

Well, a malicious input can cause overflow/wraparound size_t while
parsing, so I do not think that is really an argument.

The code need to be protected against such overflows either way.

