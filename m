Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DD44E65F
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493420; cv=none; b=SeKGYQCVlSLSQeCdld6FtU0MC9Z4XPe8RVgktYkWOqDpM2nenapcublGvPWycLVB6U6+gs46PCy8dsII3ZlIvqnugYmmHuxhihsBLSj5SkRVSn5gRe2QneCR6m/z9j++Vc2FEuTpisw/xJguX7CLgDWpgNuFupREK+jmWhdZqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493420; c=relaxed/simple;
	bh=3NDpvq/Z3fJe9jCBU5CUJHWUC+rMrzczrOC314Cmdpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gBKaSbOS53d5E75YyzxQNOEKHaFLwnj8JI+JNWhfQMB3HnXvlPeOLIxiRQ84mbfuOsCxWDSOGB0KTipwNfmjhODyI088836ub5qqbFgKlMluVeb7NXf0xV9epcsi72zLpxQGwkJ17MXrTNPIWecozp87Oib0COXfl6ArfvsIc0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EiZuY2Vl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w3Tyo/w6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EiZuY2Vl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w3Tyo/w6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B3281D0006D
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 17:03:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 08 Oct 2026 17:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791493414; x=1791579814; bh=2N7/xLA1QS
	AEhF3nd6EMOi09JKh4UM9HzPR51DsIH1A=; b=EiZuY2VlgqjQPLrHfLGBFjmf22
	RYYJCDqeV08JQEYvok4dyR/LlUopDoamee7WheZxA/0TRLVsk/CICHg2W4ih+qqy
	G5qpXgCkBhZAZezaGygzJquzbJPIjvAhD2Z/YPRtq5O8S2KgVtGsAmw7dPrAGDsz
	CJHLUOV+VbF6B49oPkqLnxGvTHshwX28OscjWxj2xlTkiNIE2x4sRIynwrB7FxR+
	A2dWqcRE739UUo/uh26JJHedsdraGrHzXW12GzLKnOMq2dQaIliQsCkZVu6PfhCr
	UhqRbBN+V0Nn1swZSXvVBUrTm60bNA4C+7zWwPxRjoI3PVV5eWYLD7Ivcd6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791493414; x=1791579814; bh=2N7/xLA1QSAEhF3nd6EMOi09JKh4UM9HzPR
	51DsIH1A=; b=w3Tyo/w6q1L09QRjwsjxkV4gbsEno3lngJiCwqf83hzn84NiG6n
	el300GreucUsC/QylCmK2o9mMGZTuaSyzY6ErTrr3IknRnlqay6Ph2x6119nR2O0
	2xeyl33Wv3mS+v2JdFCZEz+WiQXbnuRC1Rw/dOtfe3RAZt1CK6K29sZxtwlXQbLa
	d1QEQEo0mCg15tdXyEwr9Yhx96YvZbByVsXWuo/SWlVtk5QURNSMWd/VkIOXu2X0
	1tUFqoFxX8Lzw62jm3cdceCYqAsBnyNH3JnaqMWC69MQx5NNGI0U/cNJYNbAYCQp
	sDRzQdvfOHsfQEDVhgE94Sjr2nFlYH0bokw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791493414; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DqoUv9/XalKJ88MiOJi8gCjLllYD6dD/mNv09oJuUxfGIga
	fClVy2aJkKe+ZrhylzXPrNhVGcqDpEcwer7/9tnzs2/rw/J7luQKexKcrY8xkKqh
	Ikf3JMn0eoTpEF6+yYh/iNGNifiyAlAfmrInkmX6obhFru0WWQNG823dd61BHQAz
	/IIwy7k1gNu5XJhT0frf6asAI3Fe+QLN/B0ann1PolOtN5C8U+XxU/IaoPMGWspr
	JN1rL92Wc6Lm9gSRuUU6XaP4/p1+ZHoaJ5FtwFfwQJkEXu3Lt8blXEQbzxrWgk/E
	loSN+X0aZXjQyQrXv+ANhqplJoItR8mU1AiKNhw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5hVubUgTM3/wmla46VWeUjq0kX68/EVyrDxuZmfjUxI=:3NDpvq/Z3fJe9jCBU5CUJHWUC+rMrzczrOC314Cmdpc=;
X-ME-Sender: <xms:JgXIanaInuDZn8J26ucBwMk9uosiCzppZQUgPJ46ZvHOaV0RgGOKMA>
    <xme:JgXIaooisDHPrWYdvbkK6G_yjjM80JLLeCUjuCzu4d7D50jktgkOHpNrzlOHeUjCS
    QVGhkXHyt8TkYAY10onmxaVVzSs25syq45W3SujYJthzY_sKlrD0Q>
X-ME-Received: <xmr:JgXIasOMgtU2OC5wZ4Ow9DEpbipiJCabej3M9S0iNoApTh41QlJbr4tp64TKCC5SGSAzn9DDdXzhhTq36lbiL7NjI4-kaEUwHnBY>
X-ME-Proxy-Cause: dmFkZTFvsbFoa0fNlqQv3lOOrGCC3HP35elCD9OJEBFV/9CA70quw7EyUi3HwpzAw115KA
    XzXWKl4JJkP9Uz8zeXZa+GjKhs0aU0dtMPXSLzSoNQpFN84KnseUGevi5nftOvYP2BB+/W
    pA1oq8UDthkdcqScUGQaebD04yNThViW5pP6m4ihuFsYqaUyjeMNZbe5+o0eajot515FGm
    1wLxrCNGBghFuT2clvKu1aLOSzIm6dy5BDognNuyNPZimkcwJwYnCW/FO+EoZHrXF2RDVN
    qdO4oOCzDbRVZwqhpCo8IsYa7r3zVRrAzGFui7ZG9sjdc8XFnN0zUsw70Ij9ftlev7DwJs
    DTup/5m3CVcyfjcjT7OYRcPl70P9QQNNR+1F3PV8G3Ua5+Q6s/5yYNsJuTpLjAt0R2Tzh4
    3Hxi9u8RtpRHZwww4XP5CEIPFi+GQZjWHCsfwP/tmf2bqoSWZmb2dlYNfI5oalK1JJrjZr
    5j1D4wvEW0lDP2KornFx3SB/AgCKbkIo5Tws086l1uzOuf2tZC5/h469i0jVQJp4/nYyYe
    ZHFOsmzBuVCHh59T3mYzoB/WrCJ6UsBfpb6AjH7F7abjevmPlRRBEFnP3vWPB3vt81t6Tf
    XknC6A+ekZDFvgXfBj63F1S9fJhfwfM2WwIm5aFTO31W5u5lq9U4uA3DejSQ
X-ME-Proxy: <xmx:JgXIajqPgJ-v0ajT_r3hA6rhDgVh06de1XS0R7PYBqNOBKvokMB-Xw>
    <xmx:JgXIahfslwdkz0kYPgZ9Cg3Uo6Az9V4DcxDV8qC3bT51TUgYisTxow>
    <xmx:JgXIapSPTaMLryy5YRSgZ9YjYHg5cqayn0X-cx-7Np_hWZGmK-Qefg>
    <xmx:JgXIaqZ1T18oAdZjhmD8pcO55g3yZouMyPcAKZkSfHT9QJ_eW8jR5Q>
    <xmx:JgXIauYsBAMsv4U7_qHqc1QNB7aMvRk7Ly-J6QZ8VpatKqk0zwV6WUAl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 17:03:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Sam Reis <sam@opencanopy.dev>,  Sebastian Thiel
 <sebastian.thiel@icloud.com>,  Scott Chacon <schacon@gmail.com>,  Scott
 Chacon <scott@gitbutler.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
In-Reply-To: <CALnO6CDNm2cRNqBU6GKNK4axn2ij5uDgKnAm_itj36oFECfPQw@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 8 Oct 2026 13:46:24 -0400")
References: <20260929112544.86511-1-scott@gitbutler.net>
	<xmqq5wzda0h6.fsf@gitster.g>
	<CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
	<79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com>
	<CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
	<CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>
	<xmqqece015k1.fsf@gitster.g>
	<CALnO6CDNm2cRNqBU6GKNK4axn2ij5uDgKnAm_itj36oFECfPQw@mail.gmail.com>
Date: Thu, 08 Oct 2026 14:03:32 -0700
Message-ID: <xmqq7bjrykez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> We are GPL-2 only, which means we can incorporate BSD-licensed
>> software as long as we satisfy its license and copyright notice
>> requirements.
>>
>> The above is not an AI-bot-supplied answer, but what one learns when
>> talking to copyright lawyers or reading books on software licensing.
>
> Thanks, that's good to know---but in this case I thought we were
> talking about the MIT license?

Yup, the story is the same.  Also BSD and MIT also fully compatible
in either direction.
