Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE134C130
	for <git@vger.kernel.org>; Tue, 26 May 2026 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831948; cv=none; b=qKKsVLY9FASDtPAiQVEaCv5Z4BoxcGY5UNrQtjM+uSGCvhIR0c+xGXveAGbj6xh9iBxjSJgG8TeXc/w0/XC+83cftbHNDbZKB2WuoVijiFVjWezjhhP0nDWM9bQ9Kl7G8qfGXFHPwDnbE9JyBAnSFDCq4k/G3Jam5YOg+QXGDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831948; c=relaxed/simple;
	bh=zvqTBkhs+OrZ5xKZciUEUhfrdCnftD5tLju/vgcEy8A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kZ1Mri1BrE2iq9fXhtt9U0jxijQxPIc7Fp1+FPDwb7UxpQ5kicv22uTAyHnTcTKbatwkdG4pUWIlEyohoZztayqw1fyYkCtzvkMh2N/NP8j/TH4dgUrigWcd1OtSg1IRPiyoWZsIjI8Z083rqBdstbJ4xyors+2KbWzTnLOHZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=L04ubr1N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ONZCKf0Z; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="L04ubr1N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONZCKf0Z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C9290140014B;
	Tue, 26 May 2026 17:45:46 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 17:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779831946;
	 x=1779918346; bh=zvqTBkhs+OrZ5xKZciUEUhfrdCnftD5tLju/vgcEy8A=; b=
	L04ubr1Nnf+4bj/rSwDuDD+hNbFDh7/O2bXSpzfm5453DAbJHcP48tJ4dr1Kl9Qd
	VM+Ep4Vk3CsT7i5J0F8huXEBq6Iou84UKLIDQpEl6Isv0rk7Ym4pAlHacWwQ9Jwi
	UHgC8R7F17HaSLP8ysn2EpzyMur+z3o3z1YmiAJ7hbszOFezIDULd9YSTy8bhw3+
	brirvcgXOcW5aZ+c9XfpkRpIAS87UrCw+XHU4EOwju5Ed0l4V/g4mQrYDc4TlKYP
	5pZrd0p4x/a2xZLQsIgOo8yzTHi+Kws9ApxBS+enTvHVUVbs0kQVrBux35+qDGT4
	mgbisNijK8tROqBVwqPEbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779831946; x=
	1779918346; bh=zvqTBkhs+OrZ5xKZciUEUhfrdCnftD5tLju/vgcEy8A=; b=O
	NZCKf0ZCysdvH+4nROXwwgEKktdtFS+E1rsc/4b6yR/tuc9iKNRDKBZc7Mojq5i6
	mYA3RLI/JW/Rl4EdC9JtyhD3eVgwrIHs93O4Gy4IAPc44+RIaTvD3kaumoA/q+zN
	V3h/v9B065/EP3V9u9z4QuXotTgByphWJdRsg4rzzWoHkW1CEnVCMhfCaS6wlzyN
	IdKLDi2PWkmgFWUpq0FipbfwbKcV0yauMlfNUtuHy50o+bIDx/0dO0xhUMNAJPVd
	j+shQDJ6WCTbFdSWm9MwGbPWgfzi5mBB2X1VaFB6tbA1uv9kycPYDzs9zsoeNQeP
	YdyKI4cKHXaTDUrQCjl6Q==
X-ME-Sender: <xms:ihQWaiSpyxrv5hmIBPPCSIb4ejv68s4co9A8p5b-9zD36hGgRse64So>
    <xme:ihQWaikwbGNHq6dx4aQYnb30dXp8HwiNGu9bUJIkgzIxAFY5IvQ0W7Ab-yVccoWsY
    -cPlQ4zpDAd5V2QVpxDxECOPOOvkChFEEtLvtGd0XsbU4CQEFm2sg>
X-ME-Proxy-Cause: dmFkZTF1JtkzqsEMVVbete7obBVOtjOw8IqPfzLYuHTUSYyU5Wku+Cldj+4V7DvcJyGb61
    Ab+ZcmlXv0w/cZwRH3nz19uCkC5Q/tRkUDf/LiYXJmVcRYajCDUbEQHpgcmaWeNfV9Z/M3
    uw3MIQIstfaFpkhpTDLrsInrtr6YbngqkQlPy8t7jk/45tTJFKj3/EJTxAXYCC8EWYF04Y
    s+RpJkfRWVrKIg1llWaIIKVIUTiZAbIThJlwmK0B9JS9H000NkYx3Z+cQ9uNYcYiJqfu/h
    mELBNw8u1Y8zqA/nqehpw3mJIWTvirzLYlspJ8mPANdOhhhkjSf9txqZSTx0K9xGM/AMo6
    MszISoDTjogj5GA6PIqa6L7bVYxF/udUnXvEhHfUiU9j5jDeYIj8+R6uoQHlA1zl8YcNSw
    EgCY4ZuFXoBKTiTG5VjjlRF5ujMnWfwgTy+ArspivYkE82XICjVkowqrWMlf71rDTbXi4N
    3zOHA6dTaUB7pUkpkfkw/j7dgar9Dh8CrnN52lrI+aqwm0yAJgp31EcqbysmWyRiQErkKy
    lVbrFeLPMlJf6hQamX1nxSrstTdcN86+5uautDZOwM2AQ+iI+emUz01zIldSdP1sBG9whH
    CC/c7gE0O8F0AS6ROkUVgcwXb2hf81UECDE3em93DWkE2de5wjIsFkF2Dwug
X-ME-Proxy: <xmx:ihQWal9wx1FKzxtVfCjEmkRh-rx3XlYIOOD5zHG8R7pJBz7x4BYiQQ>
    <xmx:ihQWajCiYd5FaTeh4H8PNwYd2jXy5XlAdDX8KvJc8FVSoaKW4PonKA>
    <xmx:ihQWaqT9_vE5ASJHI3Cgn3jSy-S6nytzgsR77AIXVZnihWdYSdX8Sw>
    <xmx:ihQWaqt107svFeVfgx1BdTcWMTvNbO5YGa4x00vMbgisgo0KVNJ0Yw>
    <xmx:ihQWapi3aFUtjSBvSP5R9pQ4baOKfcOIW16uP3dBXoeBZFsMb8O28T4Y>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 91C063020073; Tue, 26 May 2026 17:45:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Tue, 26 May 2026 23:45:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
 "Christian Couder" <christian.couder@gmail.com>, jackmanb@google.com,
 "Linus Arver" <linus@ucla.edu>
Message-Id: <5508ee49-2f78-4c3a-accf-a2350666bfb8@app.fastmail.com>
In-Reply-To: <0faba437-31cf-4004-adaf-2dfcd2274a5b@app.fastmail.com>
References: <fc1f8149-98c2-48e5-9725-08cc21696cb2@app.fastmail.com>
 <4DD440D4-145A-4A9E-ACBA-8E6ACFA231D1@gmail.com>
 <0faba437-31cf-4004-adaf-2dfcd2274a5b@app.fastmail.com>
Subject: Re: [PATCH v2 0/9] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026, at 23:42, Kristoffer Haugsbakk wrote:
>>[snip]
>>
>> I=E2=80=99ve read through the below a few times, and I don=E2=80=99t =
really have much
>> to add for now :) I think that=E2=80=99s a fine improvement.
>>
>> Whether you roll that into this patch series or wait until the dust
>> settles is up to you.
>
> Many thanks!

Sorry. I forgot to add: the plan right now is to weave it into this seri=
es.
