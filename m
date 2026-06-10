Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72249213E9C
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122416; cv=none; b=D/SmFJjHk62mumg250e6ODM5U8SNYZ2V6ccomO522dtYLaySUEw2wLcZhujPVypC6acjSGfgE1yoq+hRsGKKsFG6xhudR/jlQM6GBNijvwqU8wGsJTPPdnsuL2baCDrW8sRr6hnvd3QSoSMQcgMrf4U/vw3dM3h5xATEGpmb5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122416; c=relaxed/simple;
	bh=9bluI4fUrqEP7/GnqBqwQsfkyKFsDQnAy6XBNLut/RQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SWA4XpqB9n2sspiBEAHbC74Ak+042fr5u91gMRdD+77/s8nnONvSbZHjbAuGTXPhKANCne4b9chD9Ay8a5mboJQ5Yuic3S2cQoa5ehY3UrOnjD+P928kToxZTahKrKqdV46bnR3FLsDRH7fG+FQCBJTRp0RnnY8XbygBg4BZ+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MhbRRcue; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GEaeQbC9; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MhbRRcue";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GEaeQbC9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F7537A015D;
	Wed, 10 Jun 2026 16:13:29 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 16:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781122409;
	 x=1781208809; bh=JTbPbsagPuHUZJB0AQk/NAD/eGRklAiu8oXTVUWVvKQ=; b=
	MhbRRcuecgEsKypKfPNkUiwAFJyBdh2jOOf96We/q6RoyDQ+o4NFI45BRyYtKcm3
	OIuM8DHWTb6TwK3khpiRKfMmq5TRpiyXbn6ETiQEp1L9m19gBAKddj1M2cLDaatX
	GBSYz9dBqDLiRAqrSd1taXxqELjol66eIMdKlAZev59BheaLKK/r+8tfqWQNii8A
	7lX3x/Bb6GBAcG4KH2/tgnGYoVQkqqPq4c8dw9q2L+vM6Qs6OOSLvrn8Df7513gz
	Y3dlUwbI9qDL/7VrtBZJSsZ+BCZ+8b/zZOsnL0I+Wb5WiRPLV+0V1/maG7wCv2TP
	wOV7BFeeaWthWC53WBNjSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781122409; x=1781208809; bh=J
	TbPbsagPuHUZJB0AQk/NAD/eGRklAiu8oXTVUWVvKQ=; b=GEaeQbC9WyG0F2RoA
	mhbg6T+fAotUS+XGT0hqisdIAlaZxmNQXNp9kkRo8ZAEKlkTyg8TMJzSQcq13YF2
	BjszJLik4mOjWGZmAX9QHuY5F5jjiDZ6xnglMJe28bZPpVMOFLZ/CWPJGbjrNNgs
	IPeIFz431VfZyTd2Soxtp4+8MZxlfbs8tveOWTWumdv7hNrhQKFMsxazyPNwJ7Va
	xGOE9BKrpmtLteBipxuILiEChzgdj3ArMErP+PoV8/9u0j8iCm4L0NQ3xjuAsmMb
	o6QXwCh5E9FtOBAYlTewI6OI+gGaX4Gm4iuG6G6Vs6I/B+2WDDv17j3T9xevgDup
	nWcBg==
X-ME-Sender: <xms:acUpap22vsbja2MmoJKRvXE2a2G5kSPZziO8muHOhFTlYv2yarHH5vo>
    <xme:acUpaq6ij1GaLYYKqSdk_MStEu9ZKKM3SWqqu3G2Y9Uz0X2FXiaGfBQY6_mwTFWz1
    8s1ATeDyOf4UPXKGR9PbKpCJxBEtlNgqQNBfrEtLK7KyDoSSHQZsg>
X-ME-Proxy-Cause: dmFkZTGJ+3h300yBEl44x3amAsc9l2CivwegKDP0xffu7ed9ed5Q524VZWkLllUnoFgYan
    d55mCcaNhtRSsjqmqF003IlRXOKsdCyEPRpsx2fXmzIO4Tt78FmnRsg/eP3rBcAlXriGfQ
    XcIeU9C+zkeSsboXV/T7sgrY/Xj1QTMon8/XPjFlTKV47nWPLkRocL5Rx0P+Oqpw5BJFco
    Zr4RG6iFf4PCVpBnpnGCrA51Dl0ejvnW+vYugypAMoH1mnjMZxhHzOxs1k0MWMWZyvSzzr
    BMDK3v3ipAWz6bRDjtp0bNr1wqXTJR+hvgsF03VohmZvl085duIaQdYwNCIv9PLoTqwmRG
    txn0LINZnCAp3GaXbb/57Npl+pDypV0woSE4qo13q5hKi1OkwrT3fYlURazGpHrdhnCQwV
    ltTYl2We1J2CxjUACGGYM6rVuJ+PSQIW7TxIVDnMGWibxCw9N6OQCNp1MtbzEwuIgTOWwv
    Bj16MykS4+XwQBt7YsWKY00IqLtinI1du+8Dq2qy+dGL3qnpTC42tERlsz7JrDLbVJbLL9
    sw/OaYLOC8SIgEP3ualSIzaNGxdSY/FsYn3wQbhp28N6tyu18XHuSTKn7eSSLEJ3KlvrDj
    wXWJYi6DJ3VwDIeu2bvQ09ZmC0bu7p937iNHkusDdMCRxTP/3akLGxyQp0ow
X-ME-Proxy: <xmx:acUpam8PA3d31nVnlbkeuzsWDC97oIQRGUExjDwRULf8H5-TuxqEkw>
    <xmx:acUpavrJRdLrzRwz-DYJLqH7_ODacRFFaEjI_L2Db7fkBVGI_VwUnQ>
    <xmx:acUpat-GPdePkUrt3a5opczAaJxqRMJIZqIeUpaEm1R-2j5fjtZTsQ>
    <xmx:acUparV5h3-QSGLjZL8-d0eZKan_-QanI_VM64YrAZ9EUBiNHHtDzQ>
    <xmx:acUpangUVk9_z7mgl-xRY3jbyH506G_x5YBtL4VZWh-prJG0y5kKkoYB>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2C2C530201A7; Wed, 10 Jun 2026 16:13:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Adt-cs7GleO-
Date: Wed, 10 Jun 2026 22:13:08 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Tuomas Ahola" <taahol@utu.fi>, git@vger.kernel.org
Message-Id: <0ddf1907-66fa-4cc4-84b5-b873e0e60939@app.fastmail.com>
In-Reply-To: <20260610185148.23920-3-taahol@utu.fi>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260610185148.23920-3-taahol@utu.fi>
Subject: Re: [PATCH 2/3] doc: config/sideband: fix typo in adoc markup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> doc: config/sideband: fix typo in adoc markup

You might be able to be more precise while using the same amount of
words or less. Like:

   _: fix description list delimiter

On Wed, Jun 10, 2026, at 20:51, Tuomas Ahola wrote:
> Fix a simple typo in AsciiDoc markup.

The subject of the commit might be enough here.

>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  Documentation/config/sideband.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>[snip]
> @@ -9,7 +9,7 @@ sideband.allowControlCharacters::
>  	`color`::
>  		Allow ANSI color sequences, line feeds and horizontal tabs,
>  		but mask all other control characters. This is the default.
> -	`cursor:`:
> +	`cursor`::

Nice find!

>  		Allow control sequences that move the cursor. This is
>  		disabled by default.
>  	`erase`::
> --
> 2.30.2
