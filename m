Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5143DD50B
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840350; cv=none; b=bBvlzfzdeIBrUD8PU8XydsBoz3SFIHtTylbAzvRAn9lwbNwxqAesxmo0Vr2hYxSMS3zHUH7HoMrBXmwdWsHV7LtTezv4E9IrSB0R6xgjL068Vv6vJK667SeVh5HSG5h0mzig+8UUSoE5YIXCXFZ9MtH4NRrtlzDlaKZbzYbIM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840350; c=relaxed/simple;
	bh=nxO/maoJsEK3Tig+hc6HZrvbwUH3hs3ZHsUIoMs58C4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VjC+SQ50L8F0ifbM1YNRagvnx95IiXGPr8fYHCTmThLSvtwZ4/+9QtjiMIawnS1pQnCjZgcJ961V78WeeFX/WNWMiMQD30U455i7uypfpGhDr0fyQyqdp/9pO6v26aYj/cSnthJ19+O8sJuNX6/Il8ZtERcTcxO2cByB0IiwWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MfsXswcb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gw0uZi9r; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MfsXswcb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gw0uZi9r"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A3A27A00A3;
	Tue, 30 Jun 2026 13:25:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 30 Jun 2026 13:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782840347; x=1782926747; bh=Mvz6OKnTg7
	2k+ECX/bXPyNx379mQJyhQdsX1drG+93k=; b=MfsXswcbhSAMPJC/New2l68vR6
	93kh9eg9rY7rI1Yf0+XCdu7e0H1dBSk57MA0aiH/9qrgi6tdBXYB0A0A/Lo7352N
	h5sue9h2A0/bRqm51TxN73JNTjy0gOIRbbTmu/fBG+ZY5ci1tcQD3cBlhUJxjyW0
	ucrFfhUCaw8K7okdQT1nS0eYiwxY8VKXE6d6KLemf4y7v1tXo3N6NoRfIooK7uFL
	RJxcmY9LN2z4JEVkmMYW2OltOdHwRUQKaSu+ML7/0Puow+KEHboWcdW2B8n9icjy
	dtO/myaEH4glbN6c9pBQqlBI9ZWqtdhgguD1nU2w6+XP6FOK7Bab/aSzrM8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782840347; x=1782926747; bh=Mvz6OKnTg72k+ECX/bXPyNx379mQJyhQdsX
	1drG+93k=; b=gw0uZi9rcJ/61uVw51uTiAeXK1/J2AwXNujUP53lyEfRRxnEGqv
	akPSTYbwil6jKvw8eGAXV3RZJNRTzSTNeo2OSl2UOKKdimyVJRquirTpsDeAD50L
	2/4o+31XiLscquldby4ODy3dh+itymrg8dctqRsUTQCKRHToG1YIk+KYwVOmQYpo
	uCv9n4G0e16Kbnu63ikoPmx7y1Z1IZ36eNCJmitL/sChPziK1uK5W4k+CEcAO4fI
	KbGJSmT+qLl9MGebfw9ur9BjvnqYhgo5jC5hs+PLFrobkX8z+xsbctSTn+rfNHOO
	CefAWQRCIczqLS0h5TdeAAIw8BRkJvNo9/w==
X-ME-Sender: <xms:GvxDapQRs0Q20dnCag2Jv4AnHUnXpIfhsQS4KnjuvfxgoO1O601kbw>
    <xme:GvxDappapsmHoPlXc8vM8XucNQ8J-MccbNoHKwfIgrB3dneZabrG9Sn0SvqKdIjS_
    lxE962XBZ2hNj7LSqMrCmV9lzaSaz69B49OL2sXNqnFCRj5inwW6Q>
X-ME-Received: <xmr:GvxDanKCRQa9GR_3DI3uv3XYFLRHi6eU2FemXY9vZdmXW1_TWAwmHE5Rn7En-fVLL62v5ki6mV24fB_vCim_CscNncs2iDnflGbG36k>
X-ME-Proxy-Cause: dmFkZTFv/xCjuYbGSlb3rEVwgL1hlge1sZVvy/RgWhVNJhDlE9cC8WlsSItF0G/pPWCkzN
    D/UrU5dxHHp1GKDC8R6747D1K86gmAiPwfAV1jLec6YC8TnA0N/KHfLamrAg727BrS/tLx
    0d1dd2cCqaZH+x69/pBcuDaUsMvi44uiXF0wOZLhe2I3TU5+hTivOJ71RbnF4/NsGFGA6W
    dVxrON5KYZFEyk25Klf1XGxao6cQCcqFxWT+u2VDiMzy/+wuiOUIvJWcKZ+Mc9pVIBpLJS
    1ujwITxJGaVMeNC0h6SxL0D6bfbQWAMwFuo6gKp0Mv8CIg9Fsi3PtwteFyeHKVAbxMlwJ3
    j9FfojBPTf4JdSuKelZMObiSPROuxQ9hVxKoGdRQH0Qmj6khM5sF9Uj2BVwTOqST03J+Ai
    vvOxGj1DUzSYr/Voaw37YmvMcer5DSnXVYBvCJgpTZwdgQ22D7OMQaI0s4jlQ83G22HXHd
    hxmOofFrdF11JjMZwnAbpKP3t//UDwCez7ADo+GIrfEoFpQ1OVVF1DylA2eVIqA36yS+KS
    uB4/iqsPXzVqcImdcnD11M3NhSxUKurfltaIH0ZHmjmopYo1yrIUyfj4FuhbWeufvX+Laj
    gFfoLA6hLkuZHkzx1IRRMXXXT8k2G8wT6F8rGDjTjpt7Uv9juqveBN4OJnuw
X-ME-Proxy: <xmx:GvxDasoghMHAJDq4lR3RENzFV9UXACl9yCUIBIrhwDDdSQXuwU1LiA>
    <xmx:GvxDavwuBbaYPvN5afB5quf7lE0THBzrWDiVXjIKdbNwtlNXQ8WgsA>
    <xmx:GvxDagPDtwTCFCb5UPHXkrGtL6vTl6Jp7oUOj3tCECNsmQrN2R8eow>
    <xmx:GvxDak4CcNJXaQHulQgmOiI4rowOfsLupB6rkfQ1Bow6sytqg1vsYA>
    <xmx:G_xDauvocEbWrQvuLvDPPPbOk9O-6K0mlIhu2wVtj-JuNvZeATpbJhLE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 13:25:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  oxsignal <awo@kakao.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 05/12] t/unit-tests: introduce test helper to write
 reftable blocks
In-Reply-To: <20260629-pks-reftable-hardening-v2-5-b0228e7d908d@pks.im>
	(Patrick Steinhardt's message of "Mon, 29 Jun 2026 11:02:18 +0200")
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
	<20260629-pks-reftable-hardening-v2-5-b0228e7d908d@pks.im>
Date: Tue, 30 Jun 2026 10:25:44 -0700
Message-ID: <xmqqqzlorld3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Introduce a new test helper that allows us to write reftable blocks.
> This helper will be used by subsequent commits.
>
> Suggested-by: Christian Couder <christian.couder@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/unit-tests/u-reftable-block.c | 47 ++++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 19 deletions(-)

Nicely reduces boilerplate/setup code.  Thanks, both.
