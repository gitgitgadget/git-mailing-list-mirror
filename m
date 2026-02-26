Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22F3290AC
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127575; cv=none; b=Lje5Z9zounACCJ/sDVO7cPAmGbl93hMfYUB+gIPTyaszGwCe4xPJCz3oerMYpirLoyljM1rkbLNdsgzA0SyZQpnFMqOJx5GjxFGFFBLXtFHPTbY1fVvPKY5K4hXWHps3Lf204T3oMvH2606eUx+C9lrFpkrrT+g6GkOkL5GozQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127575; c=relaxed/simple;
	bh=R8HSIXcHTrbraiQn0Cs5RipcpK1Q74n8AT3MrKwiidQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JySRizfdcwX/e01pAbm9PTFgced5Fliz7h9W0TykreV0a+KyGFpHqZh2699uboqj2Pp9hfXIPAVWE90ylURl8MptG4dnjRV/NLA+BXKcYNEPBmjfIIOjh0jfLmAqB411GJEDXSWweuLTe/8Mrou1XQ6Yr/O0hb2f0T/0J8nBGYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tc4u8XF8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dAchXP0P; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tc4u8XF8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dAchXP0P"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8DDC7140019F;
	Thu, 26 Feb 2026 12:39:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 26 Feb 2026 12:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772127573; x=1772213973; bh=/Dn2h4CF+M
	GlR2XY1k/qmWDyymD4xhrfdXwQfei7iZ0=; b=tc4u8XF8GuHDkKswHW5tfwdbpG
	VWC2r8OgBBZGykgskGh7ImFx8V96xoQzOjIMCLX4KcWMxEYliHPJ94xWsCs7GGur
	LruDdAEBAsvPCIuHEJuKMmltweZYCUMSqQbVW1t0ksBnAk663oRxWKOFc+/CWYh0
	BWHmywmlcEDfm2j9OEH77r89BpYVs3nHPWPve1dZCWAOV02ZWy5KvKn5mJvLYeSH
	k1leL+dMc2feM+U/kDIXq7bNZZNUGNoShkTbjDjfD8XvONCjilPqiUC2wYsIFdec
	2CTAvxvUpRzeBFG6lXES+8mzonGXXBzUx7x1OBHszmvZk6GiSt+kSII6wAhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772127573; x=1772213973; bh=/Dn2h4CF+MGlR2XY1k/qmWDyymD4xhrfdXw
	Qfei7iZ0=; b=dAchXP0P3d44XWW3gBEubOMeKRLwnnS/mLZmNR0LnZXnfK97NL0
	CoBzNYSwIzkbcc78JEkXk/My9qM1J4KWyQMTTqK+/ufz5WUmc3x9OtTahSCuChry
	0Hme++6T4a0RrXFMdwsbhxz3awuwlTrPTCx608kW0Sk1PCBW8a1ENbG4c+i6EQVm
	mz2icj8/Y92nXwXMHFxGFqsX2D/siMyVMS2ZdCvrDto1pGpu5kcMmW3iVuQoK71S
	EjOpycP7AX3lEUI9lHv4bjWHYKu6ntF08YMf8gkkKhzmyGsQ8rdSXi5LtgHkVn5t
	zHfq/+Qd6edxPQzRiGoSlsl5ZQnVUO9rosg==
X-ME-Sender: <xms:VYWgaYsZmnxSchoJigQZaUytajSdmB3FXrbj2XMFaLrcOVgdRds2WA>
    <xme:VYWgacWo4LEW6M60V0QkFsWY1zMarmhd9-c7rLN4IvpMi1_S-0F44kWgdUyuq5m7w
    7a3t-I215jkYSse8sHbOPLmy7VfJJU8HlsQ3R9nz0-CZzfOAQ_PnLo>
X-ME-Received: <xmr:VYWgacFs96JzuhS_QxbmKqhvMbdLTWGbeMZQ4jXcJ1yQuvjAoRkaxFihLl2BeoigC-thLnAvAVPx41RlNu4LMtruDObPqEHmXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeejgeegfeekteffgfehudeugefgffevfeevvddtudevhfeiheekgfegteff
    kedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VYWgaW3em9QqlVIw6unc4tvKSSXoY39gPpE7BvJ28G-XrOwu66VDgQ>
    <xmx:VYWgaWNfxVePeus8F5QRmKfhvaThg77Fpr8c9xvmU6QZrEjUt3xVGA>
    <xmx:VYWgad7o_H_SZZwMOnayDBIFEHJnA8VzN2czOtoH9epyQ40mznDbCg>
    <xmx:VYWgaY3ixz6nSeKgaO-0MAuCmDR7Y0H8v7CfPQYjttAmSrRHgUzudQ>
    <xmx:VYWgaeGqSlngUtnhX-Gv922yBcy_pr3qOWD6oZgyypqZmhasKaHf8A63>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 12:39:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v4 0/4] Fix misuse of `refs_for_each_ref_in()`
In-Reply-To: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
	(Patrick Steinhardt's message of "Thu, 19 Feb 2026 08:57:48 +0100")
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
	<20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 26 Feb 2026 09:39:32 -0800
Message-ID: <xmqqv7fj2yln.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v4:
>   - Fix a typo in the documentation.
>   - Link to v3: https://lore.kernel.org/r/20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im
>
> Changes in v3:
>   - Switch the approach to perform ref hierarchy matches instead, which
>     is in line with the changes in 10e8a9352b (refs.c: stop matching
>     non-directory prefixes in exclude patterns, 2025-03-06).
>   - Link to v2: https://lore.kernel.org/r/20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im

This round saw no activities, but I just re-read all four patches
and found them quite nice.  Let's mark it for 'next'.

Thanks.
