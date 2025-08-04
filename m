Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950C15B54A
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754282171; cv=none; b=Ss/xkyl32jkkZJmR54Z3UW8kA7CoHO+ScqLIVWb7xx6t+S/QSuqkJ6g/G51k+e5cRLm4gEYXTvYKwVbFnHM9Unv8iCamnnI+O8vsTmxw1ENlFKbsFO9MF5vquI5Jc7clZQDFHXiw+llGvOEHh+aDiG7U+ZmvnSY7WvzWm7AbVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754282171; c=relaxed/simple;
	bh=QbUz6ZLR/UrgDdnjcxvUFLuYts70r6zRLT71NiCD5Iw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kOYzfrFSZcABfBScHWPcAPkpwma+e+JCIfl9VLXNJ8xErqRG4WWkUeT/0j8itp0WWOaz+o10uovze1GaYGTFwPj7DWYGxPig0UrzZAsuF8Ukcx3XJ1ce75S56XqFu8i00mVMDF/Vf5DO1H31Vtm17xBADbil9znIxNPgPJFfQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WBM8S8Cf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hl5Hc7Z2; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WBM8S8Cf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hl5Hc7Z2"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 60BB91D000B3;
	Mon,  4 Aug 2025 00:36:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 04 Aug 2025 00:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754282164; x=1754368564; bh=xC76Ckcl8K
	nKqRNUrxQLJQmR0hOsjDQBz2Y6aACBfYs=; b=WBM8S8Cfgdj0++ilrFwqlv82Pd
	0OevSVYWc8Y/CMQIan4WJMiMXxHbzoDm4lfBEYg42fDYvhrF4tQS2UBm8RFMXuTf
	iiiWlarmTduTwib4YHEP/Bpw3mNXkNqEw2wJUiGeaLpLxdk0DSfs0052Cy5NKvdD
	mCVGZV8pum5Kjsin2XJvRokbUu1QJBufs6eirxcc7LOpPXDDIf8dmY1728tc4eNx
	EhZkNCGf2mbJSBadXSrLPE8U20QAzyCW6i1Yg3c+LJsiMyYg+M92MoM5/W0yZtP9
	BufQIKnwXUtsV3G17sOjObxe4wvElyPijaK58IDPyeQubitp616C6T3wrwGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754282164; x=1754368564; bh=xC76Ckcl8KnKqRNUrxQLJQmR0hOsjDQBz2Y
	6aACBfYs=; b=Hl5Hc7Z2wvxjpToVX2kmxbYp/MNgP5sEwnRHE4fVmLhPfrU19nl
	LxUtI5W4H4nrDT8pwRo128vHAfVrROT1uF96mgGWM9c2yi3LVz8nP8p1698Na5JA
	s/TDFOTpgJ7UTEc7ybVXfWtsdQ9ujCw1cmpxaEZruRq023z/CwZRvPytO440b/zr
	O+qKsB4RXr525fl/+1jTvud61+xbd1hAtNUwBs9/cU9e6SosuNuvgVZXgQCDFAba
	F/zno1vrcyhVeDcPKuN03CEtqpkn3mtxtpWzRGvfu79YM7cUu3Y6O9Or+R+RZmzJ
	MZCDZGh1uazl7/hdoFb3wR+Ob6pdQoQokZA==
X-ME-Sender: <xms:sziQaN4Bo_CsJOZ1aGpN5rXq8ezpIWEEctuevKsl7WRcGM2ukx__dg>
    <xme:sziQaDWagG7Dmt56cQ_b0t0MT0xHffN8V5O-6eqCeXwg9kukLUcvJQaNxu66qvRLT
    CvhpeTzdGduvdi-nA>
X-ME-Received: <xmr:sziQaE62FpqaF7UYsjX3xIfr-0BfoFNmgDfM_-HG3voD_bo2dsPcR6sCSZQg1mR_w7xW2sc7-xliM_k0FBUAIGFRY5ejnePYXUlqDEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddufeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:sziQaGqC0x3-dRd5noQ1dwkkSvXoTCU_DrwSRPeP9IpqXfGmjfTFXg>
    <xmx:sziQaPnhIW_rkWRjkQGA6ozOSu5VAuQbvcn17X2xknD4P1GhICpmvQ>
    <xmx:sziQaKNjBxBnE1D0rEY3Myu_gv2JyAOTSS7QGQpANMLSd8loZaoe3Q>
    <xmx:sziQaLPiu6nx7GP8Sor63gYc2YVWghSvKFeyUhtoOCX9TOy4oeHQPA>
    <xmx:tDiQaAfYdxZWvYDPFGaIUypIjrIwIzUnrey8Sp1y36dZ7ix1oZ8HJ1Kj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 00:36:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  hi@arnes.space,  michal@isc.org,  peff@peff.net
Subject: Re: [PATCH v2] diff: ensure consistent diff behavior with -I<regex>
 across output formats
In-Reply-To: <B1F1EBB7-1824-4776-B8B0-B557114546DB@gmail.com> (Lidong Yan's
	message of "Mon, 4 Aug 2025 09:56:22 +0800")
References: <xmqqcy9io73j.fsf@gitster.g>
	<20250803145155.57894-1-yldhome2d2@gmail.com>
	<xmqqfre7ex8x.fsf@gitster.g>
	<B1F1EBB7-1824-4776-B8B0-B557114546DB@gmail.com>
Date: Sun, 03 Aug 2025 21:36:02 -0700
Message-ID: <xmqqzfcfd7pp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

>> I do not quite get why ignore_match() has to know so much about how
>> the real code in diff.c that implements -I<regex> works, compared to
>> the illustration of "here is how to do it" Peff posted, though.  It
>> somehow feels too much duplicated code.
>
> I did copy some code from diffcore-pickaxe.c. I will use Peff's code in the
> next patch and try to refactor diff_flush() to make the code simpler. Though
> the reason I match the regular expression in ignore_match() is that I want to
> return early as soon as an unmatched change is found. And indeed, it's not
> worth writing the duplicated code for this unknown performance benefit.

In the production code, it would be truly worth doing the
optimization; we want to avoid running diff twice if we can.

But I think the refactoring of diff_flush() codepath would may
involve some new mode (perhaps DIFF_FORMAT_DRYRUN or something) that

 (1) does not produce any output, like DIFF_FORMAT_NO_OUTPUT, so
     that we do not need to play with /dev/null like Peff's
     illustration.

 (2) knows that the caller is only interested in each path having
     any change worth reporting, so that it can short-circuit once a
     change is found for each path.

So, just before you want to decide showing name or name-status,
you'd do this extra diff_flush() that is run only to learn if each
path has changes (with various "ignore" criteria) in the dry-run
mode, and it can do as much short-cut as it needs to.

Hmm?
