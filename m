Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD412FF69
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575821; cv=none; b=MXzLvg+wWY8ZSdN1HTvHpdfG+ZJtmuAz2hrhxcd8hkHq3WyxQ+wJFrkURU0iQOcjPzOGNUyvDjneAVe6dNkfc/B2/L2cB0A13nmSafZHld/4t0PAhsKVTLlJHTea8BOZunKXxc5fbVoV7Icc4+MxqbmyuNFfptUVtvaQoYmqjV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575821; c=relaxed/simple;
	bh=/WwAPDXFOnR81n7j+EaBebdTgg9DtXrFRHmGLUM/OkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S/K3mGUrKR82YDGoZRvlSFmaLHJTL4OSFafPqHymdCwtyf2wY73fNIlI+qWGBK5gy1vhbZin+I8K8KguYX80UE7cyrKCYNAdNaDvGL8gaxcSOp6mofw6Lh8czhDBuxPJaZOWgbQXbexJ+a8xxYeiTee+6FPZk9Ru4B1qxoP7m2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2kv+m6VU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AdD+N+FV; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2kv+m6VU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AdD+N+FV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0CDF37A0288;
	Mon, 22 Sep 2025 17:16:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 22 Sep 2025 17:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758575818; x=1758662218; bh=QPgdgcfzpn
	jUSPXxmNhekUMFW8vJ+aYlzM6m51DJ1Yc=; b=2kv+m6VUnVnYzqEAm9qwNKf9Gs
	HAL3pfQ8rh0LdemZ/8Nv0aDgAes4nFXNnjxj1/YWqlqtxPMUH35Mzmdj02IyCHTs
	YjVhgPRPSKBQZaSNIhFCgx2TX4Zt+r3t6IDe3tBONMlGPEQE+sKUD+jCvMIbTkjW
	gWK8vzE+mNXB8UTVeu+3a1GS8lFKp1mKiuODS9cQIGq+UIC24zoFNFGbGTVDtvpW
	HKpRnUpperAi4TtD5PYM+qOF/ujE2EbqwUkE6KnNAy/RxyaOaUk1FZyz3RhgoHvp
	f2oMEOE+sideSJFZw6n17C3tsQLJamFqAY1d7vbCBz3lzz8skhs/c/gi6Hnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758575818; x=1758662218; bh=QPgdgcfzpnjUSPXxmNhekUMFW8vJ+aYlzM6
	m51DJ1Yc=; b=AdD+N+FVxlEc0W7l2DUrn6VlYj6TCHTbMUZIvt7RXU+lucgPh/V
	sWTNXMqKDiIGwc0SZSByNSQ7epHZNob4X9Mu+iqvGQCyi/tsQtUz6aUNHeA34/G9
	yRM2ddwBdyMaTlYupzxfFxu70aWKDEmQI/wVkR1d1HiZTZH7FBeZAizzcU4El56p
	OSm+W6FShk3eG6qDhBi4Pkpnj4MeM/Xv2E/aHCwevQgJVSwXaNlgOaCz1M9+GxF6
	BTgRqxygyFWc/3NAUmC6mh22uWaUYjiGCCqXMLe80ZuOfi8+wpq2wpkFg7XIXzdt
	A7UQsIhMBM+bBTS8Lce0Pr1uYQWwbpDJx8w==
X-ME-Sender: <xms:yrzRaH7ZipS5Q8II3H8puaVzBAZoq69_7wQ6liqkqvUS4fMHxk0jLg>
    <xme:yrzRaD6P3CU0DbxXKdnZ8L7z7yo-3ARU1skgMpZC5DQ1eOoaYcft4QRQHe5J9y9ei
    v-HUjTGLYIWMWIMflyLM71vrZl_Gmu1A5N0KDZSerdd6KDip-lQTw>
X-ME-Received: <xmr:yrzRaDe_rIZlXSH6cK2Yr_Q8v3e-I59K-Wy9XhTXtIMQUyhjy5c6byWs2Aj8oA4khKxGvDjYuB_c3Gln5MlKWjNQDkhLOcdo3crX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehvvghlohgtihhfhigvrhesvhgvlhhotghifhihvg
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yrzRaHDiLF3G95KTVrxKIej7Xn2gB6-hKJb6y0CGVS1a8ObZoZhX3A>
    <xmx:yrzRaG8_Dow_rV9uohrjIL_q6op0z8_zzTY_gGSohoho1rntnFK1Ng>
    <xmx:yrzRaCIK-XnoJfMYao9Il5IzHMm6X9nwQRJngQ_Nafl70HQTv51J1g>
    <xmx:yrzRaPjvZgka3EwIflhhWkC67HUTjW3W-zDapAPRdeNpDEhu10q-KQ>
    <xmx:yrzRaFxqa8OoqFTHHwTcq4cqSjoGPYS1qFe1hKoEF2Rb7Vc1-3WMvl7p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 17:16:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>,  git@vger.kernel.org
Subject: Re: How do i get news of git releases
In-Reply-To: <20250922203815.GA2264272@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 22 Sep 2025 16:38:15 -0400")
References: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
	<20250922201403.GD2205919@coredump.intra.peff.net>
	<1ff96277-c9e7-483e-ac98-b109b9603475@velocifyer.com>
	<20250922203815.GA2264272@coredump.intra.peff.net>
Date: Mon, 22 Sep 2025 14:16:57 -0700
Message-ID: <xmqqtt0urxva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Yes, they're already annotated tags. But they contain only the version
> number and signature. I suppose they could include the whole set of
> release notes (and it looks like we used to do that in some very old
> tags),

Eh, which one?  I do not recall ever doing so, but I may be
mistaken.

"git show v0.99.1" gives both tag object contents *and* the output
from "git show v0.99.1^0" for the commit, so it is possible that I
never did so, but those who ask "git show" may get such an
impression?

> but there may be some possible downsides:
>
>   1. I'm not sure if anybody depends on the current format for
>      scripting.
>
>   2. They can't be revised if we later fix up the Release Notes (e.g.,
>      typo fixes, but also they were recently all retroactively brushed
>      up to be renderable as asciidoc).
>
>   3. The resulting objects would be much larger (the v2.51.0 tag is 974
>      bytes, but Documentation/RelNotes/2.51.0 is 14K, and some are even
>      larger). Git may open them frequently to peel the tags, which may
>      make some operations slower. Though it might be OK; we try to cache
>      peeled values in packed-refs, and possibly the peeling code could
>      learn to parse more progressively (e.g., grab the first 1K to see
>      if we hit the end-of-header there).
>
> Those aren't necessarily show-stoppers, but just some top-of-the-head
> thoughts. Junio (the maintainer, who actually makes the tags) might have
> more thoughts on why we used to do that sometimes and don't now.

I think #3 is a show-stopper.

We will keep the RelNotes file updated with every batch that updates
the 'master' front, so the contents of that imaginary tag that has
the copy of the release notes would become identical to the in-tree
blob at the point of a release.  There has to be a very good reason
why it is beneficial to _duplicate_ the information, not the other
way around to ask why we do not duplicate the information in
different places, I think.
