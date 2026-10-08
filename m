Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087A3AAF5E
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479459; cv=none; b=aEoMoChKFgnQgTMzafyJZ74F/4rTEHPjYFMR4NOCQEUNCO1zURmY3gPuRDwp9P2fi+6zggpl1hovd2gvatT5DUPmbniYKtv6WBld9JyXObjeFSeqKHT34DMRIQWw+PoWI0cskLnGdqAbiGuxaUl9eRZ+tdYSggZ+MciFRkilO1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479459; c=relaxed/simple;
	bh=FyRUqMQo206IJfBuLUr/ELVHQyCxuCyoZtAzwOB+Uhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DG46tciNdZgYeiFcMNKmM7rh0iyHHNZZJvORTLRB/pdkQKvS6ZvyU4C9Pwd9uENY6UG++4DsvsxZXEKpN8rm11MQU+38d5RbmUj7+I7gSK/VgAMimK7mayEKwrFeCYFwjEu7vFfZ4rdCDwdhRUT3KIUs7VL/lxPelileCb1Sb9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dYOc6StB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TE9r+UE3; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dYOc6StB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TE9r+UE3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B27F07A00C5
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 13:10:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 08 Oct 2026 13:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791479456;
	 x=1791565856; bh=8K/qOkPJ63RFSggf2078zY9czdefV/8sxl2Mzs5SiFc=; b=
	dYOc6StB8Sj3J6YYaBEhBIZs/ogf6uEmSk56pZHzrvUgoPocrgRGpwrkvmxhEiO0
	UzspCPuudwx3YGmWMLyQSvPNYCrwz1daxOcVeww5IZUklGvpM7+5MJbkAGwQR828
	cbNbI0/PHR46RpW4yYVFETbZNXtdTZer8/5cOQIUcIaZdsuj3zXqCB57CWRdptoX
	SiVAgRBNcOayDaumprw+KxHe4RkTiPRfZrtmrhC9M2u1/TG/JqOqnYJpyHpG2pHd
	H9/QdxZVX/kcImzGAEdpo5AnDP+gTBR70i9LK/6Cl+UWtokwK64QudvDt+mVIELN
	hJyHQxwEcY2auMmZ+wkaIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791479456; x=
	1791565856; bh=8K/qOkPJ63RFSggf2078zY9czdefV/8sxl2Mzs5SiFc=; b=T
	E9r+UE3JSbXlfdkDJUbLno/z/p+A/n+HfGHq5vlP31EJEyQFvbFp8WasecUrMNeP
	UCAGyVUvtY9d09snXKJiXKX4nlE9RS1AHZqV0TfoJeEeaL1qQPSTw8CV7E8rpwqv
	tLP3nnenAdBaSFsK/bPUPeQWtq6uEkbJNWqrRMs3QUCoZfcRNtlmXqhLyeJRhuFs
	XnbbGOsY9tCjZktYl4TRlqaLvCzVDzoz+KIHxGBelEtHtiTti6CgkoTIG4nsTMAZ
	hyWF7xsPfZdNAOV883+z4McRDITlPdPbsXXzKo2e6tRFidWCB0cIAPlu/BPLi9lv
	D6cv2RMnzacYM8mDehIAQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791479456; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Wqu8tySnT9LJQee0lFP5PDxSp7Z+hDYLBPbOReiKCpNxxN1
	slvuV3H5ps8mdHczTAT5QJ3eUQalw9++UaQbA5LJSnnTX/cnWS62fvaba6l1+8+5
	YW6HdcYJVw60SNjmHYX6cJW2ctvpmxaXZbq0c1vgIbFYerunCnTZrmuxDe2I0OmX
	O4vbfGPCimAUIQ2CrEzpZ4OfRZc+f/bh3xQ88D4LOrXKVny9IQ24/D+ZnoB+4lOY
	fVj7ZX4HV2iyCmIGVYoIFhwPeKpfbB9QpTMmJIorrjPVClOEiY5CQXh/+jJFGpS5
	/akuUWSV3aiHxqIQOHQ/N54SitLFzcvXkDLkOmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:fq/vxY2CDmD9vUOOHWnXGrsXgEgk5paiMKLvUmM5tbQ=:FyRUqMQo206IJfBuLUr/ELVHQyCxuCyoZtAzwOB+Uhc=;
X-ME-Sender: <xms:oM7HakHXV-yO5OXKiC1Er9FLRMoiZHFLevT1VeS2LvDA314kN1kz1w>
    <xme:oM7HavkQhVkuj9LGH9mnfPJc6qTcah-BWWBApdsQP0F6H_kAMEzzXn8qZ2EwiaC4K
    7n-rslZOEGLT-6uruscelMXN7cyT3P5CoxU8hF3UZbCgS_21ewCYn3t>
X-ME-Received: <xmr:oM7HagbMtyl9YukwhVP5PPJiKj_dsu_5nqy_4J6kh7EnODnGB4pUZtm3KNhBFkVsQkh3pGikTbHt49Mqi8LmqydMsJWMb5AVxnHC>
X-ME-Proxy-Cause: dmFkZTGVwYRA8WJUKtYsTZd40i1J4DukYU6lUL+tEKHsAc4iUJ/SWeL9Ev4IpPcYZ/IRmw
    2NvDwvHGLCPlRmad/N96A8bjBXkFEkhXuV6XGI9klA2VhDgIjzFGLY7ZEnBtKyiI+jSjbw
    nKqRGgvfqS0T0ezjFVXssAlheaool1ZT6Mdnl1K4gIYYqOx1F4rm328Fj+PAPaSJkM1x7N
    TiUvFq0MjaYecYXmVWJJjf9TkYNGP6UAgmjsomPx3XCKdvxE5OQR16Lt0nlMPW0CKyfazT
    mT0WPzMXJ3u+va+LBVwaz/EmeGQ2ltBaoesSmOaoESQcncrYZej3qpC9NOWsDQshGDD4j3
    Si3jplUntRBATEUYF8/WzFV7b3pPl93ItyelLumJCc6mbq1dJ6wsmBFMEZsaepX+tW7/PZ
    +cjiF6sJFfnWnClTBNMahVN62/VC0BMynvrOVqrYeoIX8Sto3PMpTgGIpmd2pxMsKFDr9o
    YJGMFqG/a/+0O0KRAOL3fdj2l+CVQk1tANYQoIinADCLrOBKdutxzEV4GsbCUmD9652LfK
    N+8QZxgQF0yfkBuZFtiwMxI79Bm8lQH1B4kThtZbL5bvBvvpLbq8/P7gW+0zhWAYpq6bdv
    qmweIQS/afgMCIzWKa365DUJeep7AElCb8Gp+5adamG5nVqbGyfE5sIIXrqQ
X-ME-Proxy: <xmx:oM7HasGwxryg04NimuFfF6e0HyG7Cf0E8baQaveX1BU2Mkpb0ggYog>
    <xmx:oM7HapJ8B3tdBq5AaH9u_YRTRWyt8dU9y0GTXOFzxfUS99ED-m22AA>
    <xmx:oM7HavOVAOEhctOg3y4l3m1pwc6OehkXqL2fszsZBH8WkGKZg54Syw>
    <xmx:oM7HahmG1r24g8bg2SVEx-utZ37iKlsbGJbMUQLdRUFGsTNkiFLiXg>
    <xmx:oM7Hah1ixw-rhT1Mx2QFmAaEcDJ3mQX2oKPILLUTFkhiP1GwUpBa8Lin>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 13:10:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Sam Reis <sam@opencanopy.dev>,  Sebastian Thiel
 <sebastian.thiel@icloud.com>,  Scott Chacon <schacon@gmail.com>,  Scott
 Chacon <scott@gitbutler.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
In-Reply-To: <CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 8 Oct 2026 09:25:08 -0400")
References: <20260929112544.86511-1-scott@gitbutler.net>
	<xmqq5wzda0h6.fsf@gitster.g>
	<CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
	<79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com>
	<CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
	<CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>
Date: Thu, 08 Oct 2026 10:10:54 -0700
Message-ID: <xmqqece015k1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> but I didn't see a discussion of licensing at that time. Perhaps the
> idea is that we are clear that such code carries a different license
> from Git?

We are GPL-2 only, which means we can incorporate BSD-licensed
software as long as we satisfy its license and copyright notice
requirements.

The above is not an AI-bot-supplied answer, but what one learns when
talking to copyright lawyers or reading books on software licensing.

But sometimes asking LLM gives sufficiently useful answer.  I typed

"Is GPLv2 compatible with BSD?"

in the search bar of a browser, and here is the early part of what I
got, which is not too bad.

    * AI summary

    Yes, GPLv2 is generally compatible with modern BSD (2-clause and
    3-clause) licenses, though the direction of the combination
    matters.

    Compatibility Details

    • BSD inside GPLv2: You can include a 2-clause or 3-clause
      BSD-licensed library or code snippet inside a GPLv2-licensed
      project. The resulting combined work must be distributed under
      the terms of the GPLv2.

    • GPLv2 inside BSD: You cannot take GPLv2-licensed code and
      place it into a purely BSD-licensed project. Because the GPLv2
      is a strong copyleft license, it forces the entire combined
      work to be covered by the GPLv2.

