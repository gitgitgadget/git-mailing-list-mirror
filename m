Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B625D1E9
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460735; cv=none; b=bdn4A4vz2JBZPZcUX87BcDUcZwOtIrZSWCqS99hpvxrqzPtk6yls4t49jwTmIFem4cEW4tZ2K2n/yoiYWyeWirqDPwdLywPRsxBLHdz9k9a2QEBX6z8I7T4xYRNSY5Uf8IaE1hF0V8F2AwsmVG+B+0ke0kCTFuCcZ1bk45ojE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460735; c=relaxed/simple;
	bh=e5fdTQNoeDSAXf4YaZ3fa/Az0eIWuIi3Ngk5rJx0EQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e9FHDJevvGXpkdGFzawn0jLg2iYJhtGl54kdO2f4p31cJl3s/9fTji+sF1J75q+nWsI4yMsbt4jM4X+bM866rMQKc42J86UWKqc8RM8s/uwYy9zH0/RBkeV+TBgVB5+Ogpbci8gIDLE+Z8NkbaGtN4DojE/V9XfBeLKeS+oPzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ak/B13ke; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXmLJ4Mk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ak/B13ke";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXmLJ4Mk"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 445E47A00FC;
	Tue, 14 Oct 2025 12:52:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 14 Oct 2025 12:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760460731; x=1760547131; bh=vI0ut+4asi
	0tmOpohCS14NdlfI+1H+R/jYms+/Uxafw=; b=Ak/B13kehK2RGljXvnFAco9eZ1
	xJmUqBfwvPkXDLMBY7RfXZcv1ZDMpb0IzPCdb4wM3HMzzn622EQdQfpDq7nPsX8R
	QUhFrxq49iJ10S/aB8XbvmhnWJ+Bg3OY7lip3V5imoDHzuSbn9aZWR762CVJQIGP
	vl/tZ5oMUe7ba42gX12cpFX5K6asuEU+b6uVE2jVG54QwBWc+n1kLXMUMoSajRYz
	JmlMqDLw86iv/RIK/wb0UEyLPwoEXG6Egi5CP7MHojyZNyFTwFOX/ruDApgH2LQE
	51Ug6M1JXz8uo7GpWl/Uf8t0QWoPEkCdPPXDuGTHO2JqvkeK8+Q1X6dukUdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760460731; x=1760547131; bh=vI0ut+4asi0tmOpohCS14NdlfI+1H+R/jYm
	s+/Uxafw=; b=SXmLJ4MkMmfqBh6IVUNvxsdDFPGtPHPRS+TcQTcqtIC4WJdgDvq
	pUVpGH+7auhrWbdVmWKz24rDz3a+XvIOZh9ccQ5xBufIMpvThy/YDqQkoEOcJUeU
	CaOULIiXkNQBahvW3YQvCfQQsBZEfl8Ir6+ne/S/vjEaj8i/egm4DBWvlWwXJt5Y
	UJD15CkWSzC3HhjQTETyGdpTLOQqEUI/oyoXxEsDeSUPmVqsOLaKSF+XG9Cwnv8P
	bDSXNAk7jn7wsfJn7puuGik2jRs7Y46uXs5nDe2aopUNeLl/KilyZWUF5QlKQci4
	OEwi+nwnBK62ozgo8gDZuH3Pc79K/fo0S8g==
X-ME-Sender: <xms:un_uaNB-iBGpP6tPItXwSMGV0vm2imQ4oiLZjkkSQNDGKQ4wslLlpw>
    <xme:un_uaKnZNe9S6fLHiRlDAY7pHDH1A8FMlCn-0z7NVWG0Pd5plrhghkKMOLxM6Pick
    NzvUJJnDaB2SDwo6rc16Ll9rSMqoSP0CH_BEbGROp5l_xxlNK-8>
X-ME-Received: <xmr:un_uaOxA1AQEtCgTvzoICEjxfEwV6yrGVij4aOHGraJdqAJNCDYSm0EpnA1vXSyMwdpVUncw02yI-eKkwVXR0aHipGc1md3GAxXp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddutdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:un_uaETKLLeiZvOVQcful3zSnESoLlWXw7EahOTLBz35Kucc9mYZ4A>
    <xmx:un_uaG_FudKK25TZEk077F_HJ3V-Xx6PR8nuNPBtL0KNpSLTxMXgjg>
    <xmx:un_uaCvIhsWRkSCll9nSQM7XONBqhP9tG2mrGVT4H0oaxHJpB1Df2A>
    <xmx:un_uaOMsoYabn5xAiwdSH2ZbVzDksDtElohFFbT91GerbjS6wv0wvw>
    <xmx:u3_uaCEDWIqdD5oaacWDg3Z7necADCRVeCLCR7kM3eN5xQjujQPQPNlw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 12:52:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
In-Reply-To: <aO3uSz-idPWahgw7@pks.im> (Patrick Steinhardt's message of "Tue,
	14 Oct 2025 08:31:39 +0200")
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
	<20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
	<20251009053825.GB1614343@coredump.intra.peff.net>
	<aOdRsR-k77uTWJRb@pks.im>
	<20251009063956.GA1622884@coredump.intra.peff.net>
	<aOdjM8F6WvTEBIo_@pks.im>
	<20251010051242.GC1897715@coredump.intra.peff.net>
	<aOiYFPTNLL1Fgz5V@pks.im> <xmqq8qhibwrn.fsf@gitster.g>
	<aO3uSz-idPWahgw7@pks.im>
Date: Tue, 14 Oct 2025 09:52:09 -0700
Message-ID: <xmqqy0pdxw7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think that `struct ref` and `struct reference` serve quite distinct
> use cases. `struct ref` is all around references in the context of a
> remote: they are only in our code that interacts with them like for
> example "transport.c", "walker.c", "fetch-pack.c" and so on. As such,
> this structure naturally contains a ton of fields that are relevant in
> this context:
>
>   - It's a linked list that identifies all refs part of such a push.
>
>   - It contains new_old object IDs.
>
>   - It contains information whether or not such a reference should be
>     force-updated.
>
>   - It contains information whether the remote side has such a ref in
>     the first place.
>
>   - It encodes the FETCH_HEAD status.
>
> There's much more, and nothing of this has anything to do with a plain
> reference. As such, this type would be a very bad fit for use in the
> "refs.c" subsystem, as the basic concepts are mismatching.

OK.  The plain reference structure then would not be involved in
local ref update transactions, for example.  It is just "here are
the refs we have", "this ref is of this type, at this path, with
this value", etc.  Makes sense.

> So what I'm proposing here is to introduce a `struct reference` that
> really only cares about the specific concept of a plain reference. That
> struct would thus only carry information that can be yielded by the ref
> backends standalone.

OK.  Makes sense.  Thanks.
