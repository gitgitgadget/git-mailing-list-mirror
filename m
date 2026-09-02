Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F424A8A00
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366592; cv=none; b=TzqMswU1cX7KAdcINfpGNBFKEootBpmPXtz9jKBj67mqfBA4XdX9NaurLifbv32UppXYAUWNikcUncRUaz3dVh6khLEPtXWAIxAThYR5GEfUtrtK1QjMjV+mfa6pWkCP2dhJCkVcxyURRu6mAv79tLkda3FKjbiai4vRFuyooAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366592; c=relaxed/simple;
	bh=XUKTQlS1VCiIHkMpLlZpK32lDEFTh5Et2XIpiGYCil0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WsOd/ZynODDQEAtaDrubsKjx2T22+g+8IqYgVGfKHPf0srvaDF5RcbGxoQU35N3H+M5MjyLUPOY334grVgnqJuksT3MVLYDM3IU0ccZ5G5W+YrDN19ZiAbRK9hv0tFzyPJ/vWDMDRP1PIJT3d1sy++62cuyrDupoPPBZFTFiWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WNZUIXNo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y3SkIKhs; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WNZUIXNo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y3SkIKhs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74ADB7A0082;
	Wed,  2 Sep 2026 12:29:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 02 Sep 2026 12:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788366590; x=1788452990; bh=Oxnn6BqWXS
	krm13d7nu3jOe/vGA8L9JZH3WxLiSbGok=; b=WNZUIXNo4DkSX2ZHsbvw4M129U
	wmTwjFUSXiSrGKIc4HvaINhmuXpIlPkYXLc/C+PMrB3rxoxDfXQnDe2yCDVfpSXF
	MM09G/rVihqHC9qUeBJWL/N05UE/2YUpK1PcAnVnIWYrgdSpRZqr2jwCgU8XEow9
	GgBLNn1v2nn3DkX7hfyIpKul8nmSe+tstvw0aVNn2I37bzeddznVMQtCKGi6u0Yw
	NREQi640jC+TAloYaEgOfqydbDAM22aOAF9bbCJsERG4/uWnwqUjcnreZJHswVD4
	1GJiRH3yCWhS3X/8Z2u8tNaP7lBVNb5waxp90cRAD69gwsZThI+Vt6zu0XUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788366590; x=1788452990; bh=Oxnn6BqWXSkrm13d7nu3jOe/vGA8L9JZH3W
	xLiSbGok=; b=Y3SkIKhsvPR6NlR94kJkEQ7PO0WozdY8581fxBufvisJSgKbUq8
	sldLtUvJfyrUFZb3SptKo1rU/Z834kEPM+LdIYaMkX5bXS590/ZW8mI4yXs7Kw9s
	NcVm0dr2TU33sYpT6pjcOD7te42gXZQcoqLFZrcAcUNlBhyLL+anylDzKC0IXne/
	8sN+2VKeqZ0RpBY0i4jwslU6iACkliibrr6C7DYwyxO5SnJ6nE581wfJNYIFO8Uz
	P7PcH4w3nxL7ke6bXHBQ0O48ZyczVdqjfHld4EV9OZEo3DOnv9XWLaHM2PfZ5lc6
	TVSMMjWFeUp+NWfJAmmf7c3c7p61sY5Qjfg==
X-ME-Sender: <xms:_k6Yak54jF4sgzczmJIOXfczCBFvrzDb1_w0XkD6y1tksHJGPpUS3g>
    <xme:_k6Yas4N_GQ_fYZT3xanxWttxir1Z07N7oh4WXk0LeICZ7sd3LOlp3YVfdRZxLdIz
    ZbDLgc--MeO3m9KDSHo6jaYMQSx64hlHgd4oOWuXylMir3R4Q379g>
X-ME-Received: <xmr:_k6YaocCiz-b4H1M8xG-qstrfG83WgvdNUJ_dIonU5-6_QXB9sMQ2YspqCQl_F3OH6Mh68VYemrUTazOIvkwzBn2jDpSKP_v3A>
X-ME-Proxy-Cause: dmFkZTGAeCrsWFfIf+scPIfI3cVVdUFOkhScfmXerIj392BwuDEXibCj3seTKCr+Zu3yuC
    sX7/vlXfLPASepzevPDc0PPXdAmDfvhALALrbGwSgTThGT4jLBj/Aq8akN+TPo0vfTJYWG
    eeyx2JqQEbT9qLYLxMUNvu7EYbpUPpScC+ZWkAEWYi2GZIupRUzVqLcnQ0jp4CdrpnwLXC
    esMo1nZ4hnSMCYBxRMwfw2j5zER4snZN9edprJQ9qp/0AuJONV0ZKrLnTpzn1mQLnonYtb
    bMpwy8Vw8EFOjMg3dFYTjZlFTyfHVFWq5hPOD7jtGmwgDNl9FR3/XX7pvWFOdYXDdWL6Ba
    xaCeSkLdX1AlzQ6Rb+InttaAD6s4zKVeeYgyTw6pUPpHxt/a6NTUWAAdVwja0DPLtBmns0
    cTM3srxYDmfXPsC3Sq62C7Dvnykhp8Dl+kwNNjLK2kJbdJ4QjsVypVD74LcMOGnSglEz+v
    +u+RllE1imM67i8JcxgaNU6qI226UkL6nKQzZ3gTl84ueOfqT1QKkbve0+myM7rOQAKx6J
    2xO/lRu75KZovyJbGga3aUaE4Wk5GOuJdkGuKVtldewd3GE60Bh34QPzEjIlxjUF8G2H4v
    pnmc9vMphXZU8uo5ozO+gBPrwSQfgq/TVBbGB0hTH/f0FFzMnsvwzpcQl1qQ
X-ME-Proxy: <xmx:_k6YaoBrCTK3fEtyVldI7SnghRJhHj7AmNTUABgsxrijTHmqB6Fo4g>
    <xmx:_k6Yaj_72ItTZpcHKWNtPm9X-LzTM1x9qftKObRvbWftf0nSBhl0GQ>
    <xmx:_k6YarLhxwsUaCx-IyXQU69jw2iq9FdDqYHFAoIhuGCpQMxXPenYCA>
    <xmx:_k6YakgY5IzyOz6ioOsjOY2rrJD6M8RM6o3_1_F3CmO_cDwUYpQ6ng>
    <xmx:_k6YajZOxFPjBGXB8hbHYMershnWpPmJZUmMp0EUqtt0KD3Q50ojoXvg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 12:29:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] repository: make repo_clear() idempotent
In-Reply-To: <apfoNaZL8dg9OpbL@pks.im> (Patrick Steinhardt's message of "Wed,
	2 Sep 2026 11:11:17 +0200")
References: <20260902055117.GA41587@coredump.intra.peff.net>
	<20260902055526.GA41747@coredump.intra.peff.net>
	<20260902062940.GA47676@coredump.intra.peff.net>
	<20260902064907.GB47676@coredump.intra.peff.net>
	<apfoNaZL8dg9OpbL@pks.im>
Date: Wed, 02 Sep 2026 09:29:48 -0700
Message-ID: <xmqqpkyvk45f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I was at one point wondering whether the parsed object pool should
> really be an implementation detail of the object database -- parsing
> objects should not have to depend on the repository, ...

We need to be a bit careful here, as the above directly contradicts
our earlier design choice to have things like hash algorithm as
properties of a repository instance.

> This would eventually ensure that our subsystems are more self-contained 
> and that they can be used more flexibly.

I do agree with this line of thinking, though.

Thanks.
