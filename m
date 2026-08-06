Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CEE32695F
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046584; cv=none; b=eSIwpdZJkOkzahkMIFFDV0weNxp134L00LLTLMc8KzqUL+PyGR0y4wXThTvkUDdN8NH7a3Ic6v3ngvxd5GxttmnnnAP+T50xaFSNdJPyKiuND9JaJy1EWIwiKjSyCvGLP/XceQJxoUt7emXXjBqhgrqU9NSIErWtdI0QlPuXEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046584; c=relaxed/simple;
	bh=72+59YMKElNdzMruSTkMF5YW6jbMeuNkQd6QeNyljmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ae4rKoGgGAmB6JBL04mGPHdX30btwVnusZP5HtLt8TQADxGv4n1WdcuwBncUdQUIHcImlKV1dvGc+0jKbg23ys8ZEyl5jKSaSkC65Yrn60l5k23zu/dUA9wn6eDSN+iGLQ21vgZdluc3sRdfBMsVIKtkYg6wqzIk+LoNMreVwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q36qw5Jj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJ//J35z; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q36qw5Jj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJ//J35z"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AF561D000B5;
	Thu,  6 Aug 2026 16:02:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 06 Aug 2026 16:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786046579;
	 x=1786132979; bh=UgMI9modLZCLCRg+OB2Ts7dWv3Nn1WXDpfrpOnLw4AY=; b=
	q36qw5JjFCD2WWozwCl3UeRc8DSVruYzoa9gcECvG2OjKoIXBob/0TKI05g0foCg
	dEyk6Flnm//SY8Y6UHYAchrjosibcvmP7iJZQ0joDfautPKK6/2e0tREW4X8qmhe
	Xh28GOxqhObXC8SxOUx2gMh4WFQoLgJgfZ7+iccOpLKKabQ6FFlbXlcl2ATw8r8w
	wfijUXxutQVAxPgFbyaOhSR02b+Kwh6suDQs4ZA1LBAxFg6uHepIm0LnQJFMGX8+
	5ObgryoERMpjzqEkQS7cTX2Enagc8JemHgdpm+YuiGhOaW1+RFdz2TnEpfx0kgBa
	MqU74XkHRN3N3kX4XjWklA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786046579; x=
	1786132979; bh=UgMI9modLZCLCRg+OB2Ts7dWv3Nn1WXDpfrpOnLw4AY=; b=J
	J//J35zFy7JkwQNIvQsO104Y2EVosbwHpysE3ggjK4pp3Xpl1EKNXpSNNes/YUzl
	fDXrUjNyZPwpA3VDB8n8xFxR4U9Qi05uXLxw6hPieHkhfg7HKGjvC1xKjOoVN0Si
	vdtULJoJOZNwGAHE6Ro6tiOaFVDSGwTaXmv/9USaenMzkWKeT5JiOw3Y9sISFVti
	ZlxwIWXWZxsN/3yl4GKqv4V7JuV0J96VzLVZUQnp9nIZRHcCKmQVn60Bm0fIJtSU
	BezuCgBck9wZUukyM8GG6pEukEYzr1KQ8Tmhwhl8Vm5PjssbeaYyJo2ZX8iFUt75
	08A6rKfwdLFpVMvKz1kyg==
X-ME-Sender: <xms:cuh0asF1aY8jpBCjlsNsib0fF5pHtiaqvhq4c7dtVmxIoAYImimppA>
    <xme:cuh0an5pUu6MXZVWJU8kPE75s3ZIGX22GWPj92WLv0j_nMSYDvLLKlEjPJnz2iN_N
    nYzQRJfTur_XeEUwMVns9I1qlbHBuGlbS8hDIfgTEUDxnhUkxc_wQ>
X-ME-Received: <xmr:cuh0apzzI4-9MeKK8ZUnnpW56s1FT8FWQQL9aqy8BpUx7g7MDnj7QIkM-05vRdVNE5bs27qRhfx2h2m3oFJo_vylmEAjUyf3CQ>
X-ME-Proxy-Cause: dmFkZTFDFE2z8y7LV3UVKDd+Vt2ys76oUStOHlZPKEHdFycjOAhs6pCO0Get2Nr6duJ7RI
    fGBYKbHoJuzYUfhPcJgXtGhQlWbYnDqB60ZUYiKeuSKsIsHATlM6P5n6Wc5TYqUA1nhTzm
    9OFPeJCFxqQNcDiLhOvpDM0rBIG+mUnYpSzmP8gqIRTFlw/G9EOjT7wYznJA5NU2C+IOuL
    y7RbvioSMzeGwpRNqr/Uh9inzmmjDqQGfwIWux5XcpvvhfXQihpnQax9td7FAvA1ZqyoRP
    z07urC0N9vU0XNLhcncKStwazInu8TSWl0XCXarbLsPwqtYX5iX7US4w9bWrMVqJ9aeftK
    6EHSeupAb+kUz/PMOteo3Xw/ppjVr4cNr6G+gdRs7/YJXbgRMEuS3kyj/KsEOhU/SncqKr
    nwcQoMCi0CEsy+xC3+4i7JpCIAODbEeebrbvOfOpru01OjAaSHUnNEqgW1UF9eYYgaf4G1
    2qHsUHCqwxIb1lBpwO5rWeJouvHb8sOGrC3o8IgKZVS+U+YCbhBgnNPqUzb9R+xo7wMb87
    L60pHHObEc0GlKhCmo1kbfs0OLldcaZYV9kNjI4ZwFOI4C6xBqwHeVIK0Mi7ZfhecIrQDT
    2rNxBfEonlY8Wfrm23C0oFjwOGvxpvmzTwf4WySYx527DUc8B9SkoOZ7yV5w
X-ME-Proxy: <xmx:cuh0auOWiSi0BNiPOfNG5GhVm1u064xw42YEBLyWN1_33xTK231tyA>
    <xmx:cuh0anlg6VSWKBrHxuzaxbXCFuZlecmj4QFwGBEe4k6THgIx4xn6OA>
    <xmx:cuh0arR_OMOBQYXK1rCQRU_oYHFPVq9yZaMk9bzHsDg9v9S0zKMFWw>
    <xmx:cuh0auUTwXy7vdNoqr5p2hct2ssRxTQFB5EO-OwevtcbZscmqNKLZw>
    <xmx:c-h0ajwpBglS4H1TC2QzRQ6LHuUhtgC2SLy6tK1IXZhFIzozzX95dn2j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 16:02:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  christian.couder@gmail.com,
  jackmanb@google.com,  Linus Arver <linus@ucla.edu>,  Matt Hunter
 <m@lfurio.us>
Subject: Re: [PATCH v4 00/11] doc: interpret-trailers: explain key format
In-Reply-To: <CALnO6CAmM4r2uiuBFJcciR_94KPRSJoCOsuNKeqTQ0Bt=Puvyw@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 6 Aug 2026 07:55:38 -0400")
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
	<V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
	<CALnO6CAmM4r2uiuBFJcciR_94KPRSJoCOsuNKeqTQ0Bt=Puvyw@mail.gmail.com>
Date: Thu, 06 Aug 2026 13:02:57 -0700
Message-ID: <xmqqldajhv9q.fsf@gitster.g>
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

> One small comment on patch 4
> ...
> A few places we use an inline list syntax ("… (i) stuff … (ii) more
> stuff …"). In the added example about ASCII trailers it is useful
> because we make reference to (ii); in the initial part of the manual,
> I don't see any references to the delimited items, so I'm not sure if
> it's worth numbering them.
>
> Not a strong statement, though, so I'm happy either way. Everything
> else (that I looked at, see above) looks good to me.

I guess we are gettng very close to the finish line.  Kristoffer,
how would we want to proceed?

Thanks, both.
