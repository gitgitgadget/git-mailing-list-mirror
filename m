Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54735C19B
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711520; cv=none; b=Yd2ndBuiyc73zs/VUAZbsb7xCgA+DkrevCeQyvB7MDp4W4Q/9yE76SmrZq3zmw520Kadj/BRETYPOGrnRDhJUQil8nBJhhYls/ruoValCWv++BtdtfrQ9uTzWLVbsc8RdfJAMFhQtcB0XDmaM5FENU/EBGxw55Yg3jTLNGegBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711520; c=relaxed/simple;
	bh=LFnYHT0xIiZEJFjQzgnmPZ35UVQMUsx2NpRSyl9HmIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uJhmwYt1fXRETycLlmdrtAwpS82jiiUjJ8pxWw9Ycex6Lo9uCfEOEX98TFm/Eply65TsLIyomwFWayEvzJLY34sRf16OXU5po5XqkqPGviSNqgUJv8B69y22ksCFDbOeKLGNYv8TwsRjUikLnyoXsjbgaw8Fh8D9k37GHkC4VLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sQuJKeyX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QavEnfQK; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sQuJKeyX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QavEnfQK"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 561DF7A0609;
	Tue, 29 Sep 2026 15:51:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 29 Sep 2026 15:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790711518; x=1790797918; bh=IZhcUzMn2j
	lhvgovXR50AJyaufeHpZO5sd5i0u/cd64=; b=sQuJKeyXPUReE6kPj4AszPn9qp
	fROQGRo4Dd0kSt8gMdji6Ah7Z7OImPV4J4lMsxhgip0AhBKib5IEHAxtiOjfrAbS
	LUvM5FQNfC5KxLLFsDJ8cfOkNgQhHq6jtnX8tCdv8sXAXAFKfCuTLqG34VASzcen
	Qt7DlTvzwNUxNmsgmeek6M3su3fqkyZkES7RviEXVg4nKUK7lXb1p8S7PP2aAqvY
	N6C8ua5m+8x9FjkJ4GuMN23/TpTpa6MOLw/bzeNfS+wJttwPdyXL515vm0Z+Qgcj
	wsg+h+UwNAY7kW2dfPCop2BRVMZ1iOn4PP/w0RnzeTS8ykerGMdl/VJxdulQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790711518; x=1790797918; bh=IZhcUzMn2jlhvgovXR50AJyaufeHpZO5sd5
	i0u/cd64=; b=QavEnfQKVsHhiYtyvVba5c/6Na0xZ0SW/Wjfy9lLwfC+qgICC4N
	7JpQEPwpSRvkLqA93eVByXpMi6IjMCQzZQCsFyltnF7ciWQbtFoKkr6ge13iIv/a
	uevhbLaGM/GT9fBvtos3Rr7JED1MRcCa5fGHZS9TLTQ32up+2gkrIzckG+fGJdlL
	w3ZNoN/YBUb9jDxEoRNdJ/OzaDuywQdtblllclFHY3+5zkKHoyvzwRSKk3Ya9qrs
	0msuthVtHlLoY8oeLwTKK8UiI2JLnsPZLz8hzNATmX+l1bUIz8DnSODYPrhpOIvl
	Zfb/E3RRUeAVxbDHnT+p3KuCcOZSPIwFbow==
X-ME-Sender: <xms:3ha8annP_s0BDS2mbAHmTxyLMrWsSVcbTSwy2JE-mKXU31Q-tTX4_w>
    <xme:3ha8auhN4szUpMyhtrHa1Q1j-BshHb7aAxkUWZA8Lh5OxO_J9p2nfqfaohb3SjOkZ
    JrPkx7rT6ncytSePNwBwEkIuQ9fsS5kpQlc9SPfgPKM6JX6ndw8qqc>
X-ME-Received: <xmr:3ha8anf2_NhjPwKTRQfrOT_nFo2UyEYCdvuNjSnOXZo1PYKT4W-oXmb2-QJAbWK48N-fL_3Sn9XHAKHCyN0X_YvJk84IaQGbBzBl>
X-ME-Proxy-Cause: dmFkZTFDQBa+Nz/TYL6peVodogrD8bUMZyG3zWWblMlKZZYbMgHlIOo/RWQxSUI8/GkzUi
    s51r1JKCgeMXOWMOWsiIGoXSImKeXL3pWf466DEpeFv1aQbMjWXAHmDRf6l5BCZEsNcvB8
    jWUqNXE7XEFjEfPaigP71h4NvykjlzCEzvQZk8AswNYM0fMeURvge9/uiaUAA+nb0Klwgn
    GiMDMK3Yi++yxPki5nGc5aAU1ZF2Pn/ewcuYZYpqafYe3YJSlfXiKoCIRevKPEdZ03WwaH
    FY8EjcJ25qQDCde1exPZm2cwDHaBAmz2b8Z6kKq3FGQ24BcNUex4MwVIJWTtYp7NMEMBSl
    C6qH8pKlBbp3Tqt6WVDioWnjeVwswqpQ3/zBUcXjc7F0ktkfaEq2ZQWhwznDv5nr6Kj13V
    mP/oM1iJMIHpXMzznX9RfmqvEQQXNNXPvCFtQI0THqM9i8wJQg3RVGEmHcgmHUAeCNspkk
    /2bhWqa+TFPBL03Ze4z1HjNcCOt8m0mgQn3nKZMRgPUSUdiGlR6OYU8q1cSGGTHt7y8nhE
    3iJjyEez0rrMZr8ONp2XXCClk2/l3vQJhi3eVHmjUjVEoGnKjEA6wAoLeHeb4dHgIaesqt
    A+vB5MtQEi82J2PbexnTNDD4ZhgD4f7tdvgOTUdcEgWie14AtxeG8NyDzZVA
X-ME-Proxy: <xmx:3ha8amhKxfS8cK8-0fCaksYKzZiDEG8-PY09Jl6pnQwFh5xEjJzAyQ>
    <xmx:3ha8anztL6de1aIOiS0DW3O78e9xXCfuG_ke3aqZftHWopQje6aI7g>
    <xmx:3ha8aqOkRUTx5pNZahOvu9QrK005FPcbHdmPxSE34iOcRlIwkltATA>
    <xmx:3ha8agUC3tF3XXQZY5enViyLBBii8nl7e9fDgOrJ1FOlTOTiRZiDbQ>
    <xmx:3ha8aqLEHmtHQCZANf_kGUXghGfTDYPHT-R3oCHKE59Hx9wcWwjFsKtb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 15:51:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH] [doc] Use `man git` to teach users how to navigate the
 docs
In-Reply-To: <064ec9c5-d539-4d21-96a7-6ad0ead5a061@app.fastmail.com> (Julia
	Evans's message of "Tue, 29 Sep 2026 07:29:24 -0400")
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
	<CCB1855E-759F-4741-BE49-23FC6DD402A6@gmail.com>
	<xmqqo6dgkead.fsf@gitster.g>
	<064ec9c5-d539-4d21-96a7-6ad0ead5a061@app.fastmail.com>
Date: Tue, 29 Sep 2026 12:51:56 -0700
Message-ID: <xmqqfqyrg7j7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> Perhaps we could mention `git help` like this:
>
>> `git push --help` or `git help push` for the full documentation
>
> and then advertise the superior features of `git help` like this
> (in the last sentence of the DESCRIPTION).

Amusingly

$ git help tutorial

begins with "man git-log" and "git help log".  The first one is so
old fashioned ;-)  Perhaps a more modern version should be given at
the very first part of the description section of

$ git help git

>> You can view an HTML version of the Git documentation at
>> https://git-scm.com/docs, or on your computer with `git help`,
>> for example `git help push --web`.

Please write it as "git help --web push".

The command line parser may be lenient at times, but we do not
guarantee it.  Please stick to published "git help cli" style in
your insturction materials.
