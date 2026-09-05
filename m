Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1322733DEF7
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788589816; cv=none; b=YFKW940ptzIKZ602SPIlgRbI3x7GtfZi3OTFjGr4mrAJTBJGUxaJtKOsGN0ImLzw7jFp+QZR0t4Qa/HHnpeXAssvewzD/Pkn45j2r+zgNcCCm/fyovyYb+nmQPyPt51kgJUnlYLKhamUotQigye4nVVxtl+pwbg563FZPSiYB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788589816; c=relaxed/simple;
	bh=7XVSqUlGtx6m1xW1+ZGbD/81Zu7Gl7XKzN6H9IyIahQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cb8gfjwaaFUehJexB22LYVMWuvV3m+1xYOkzYnIOf8C4PhIyZ8CqZiWJxzxM/ABa9OwKq4EMR7Ab7gu9PDNi9LTDjqCrtn3YNQ0WAf5w7gbotYk88d9s151pozaUjJWjUua5I8iu7iKdHyAH7S6A1n5saNXDybgLAL5POImla10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=o8XA8O5W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uC08FxXs; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="o8XA8O5W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uC08FxXs"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36587140017C;
	Sat,  5 Sep 2026 02:30:11 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 05 Sep 2026 02:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788589810;
	 x=1788676210; bh=naL6z2O7aMEAdM5LvC4JHzlgf0AZokcbFCr1Yb60Rbg=; b=
	o8XA8O5W83V5AIJy6Bmr20hE1thdl5fY2/DcFpxThu+a4zyJJKEM9Kh6/Mb4cXlO
	1bQIq9CWb2tVvYGn5BcE6ifBsy3Py7STuDAbdxiFaWyYGQDzYg/DjRjgo8ioS3g7
	dHjDWdZ7jd8rrhr5vm/wi9vc/2xYKNhXIOtIukmvqcz0LAilcsMrHtRLMCtI9N0i
	IlXjKsfU9AMxPeXaDe5sssngdQgTPhviUhAELG7QLJrxdLPN+Z9rcsff91OCs05r
	FqzxpIZCuIc62yQCbsKwxolLGpceiSTvircM5pxUxipKmF/pq8GcGKFgD+674GIi
	TTFTpxwHT7f0bROdgXnPEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788589810; x=1788676210; bh=n
	aL6z2O7aMEAdM5LvC4JHzlgf0AZokcbFCr1Yb60Rbg=; b=uC08FxXsOK0jbbVnW
	oqtbFcPL3G6hiC1ppez/VPs7QncQ6TsoLbUE+MqVbvee/wL6qdNhV/3Zf1ca4aMD
	TDU/tRfGX+aiLjcaur4w+i1x4oEhM6gGDq+5IcMHktNFQKIS1tFyJC0yh7QPfyYi
	GeE9+QuMRAU0T8/44BdNv//UM7lC3w5QEmRhwZcMXuLc+E37CHl1FX9qRpT8cZUR
	67lNkUv8CpyBkUOvmbZuIPe1Czg4SDHDeYTHOTNyJXHOPP6ONpp8kptf4+Ud/d2r
	MSRVFwjblc9F2EdAzqTcOnFfU0XN8qw52e5b6GKLXEVEAxCYQgR9Z4pNAuAfOKnK
	GhDFQ==
X-ME-Sender: <xms:8LabajMyO9OBbzoVJ7khD6fB197i1XsKezOJGrrsnR4RA6hDYHdjqbg>
    <xme:8LabaowF4XuOGwmVsd0mFKwMyS8bE57QT42e82eWUEMJpEeDJ56VrM7DDoVuS92xy
    X8jQdyhhkpi67-zvetJ36G-2oVfUfePEQ7NFtkb4lfDrYVKywlNzw4>
X-ME-Proxy-Cause: dmFkZTEwUhQ4JTWaqUifUBP3ZWnMVGxUurcjLlAxnm89YiDixeXyw02tIFm2kK2r5B0PNa
    MSw0fbLan0hUTPHeui/oqJj3IYgEthxCOnKukcXivJmCvZ7nU9QRRsdN6a4edL70MClpUv
    KmkxSudPLSb+Q/gJJ7axgoiWwCFjk/JjRN0thWtbu/8fa34FA+R/DdOEEcxqO9TKYeNZBR
    5JgH9uarHAFc3FYqVp0dF5b6FKOp+DE+RqwJ/4wvUVClJtfUP+sZ4Yay1zetKC0NPjAFUC
    FrZcmH/ZX0scsLT/Yw4hs0i3xffPvKfZeKhH2SBh9IfaTTWXt8Gykhopy7hPjVc5poFVjp
    SEIDlppQkExtQlS7ZxIsMDaYQKFMWsvdRJEhcT3bLYwsgHyuRav8TO2XQ81a2SAAEcpH4x
    Iqj8uauEaiemyVIcBIKxnR+sD/JzIj0CnTrSjap2IXQM65mphvKx1Rantq5wPSDP50zH5a
    yn702dwyJdhjlq+Q09+DWOCfaLsa6nzrN4sP8U8/BrXstRrHTYJm70fcSOUXKDJDE2/MPv
    R35JjnIzZXwO2ypiMzHsDIQWcx1WN2/yad5OvNw4zaxrJI7O+4wbRryBWMTtgXrpPa2CPq
    cI1tJU6ibxEV3DP1X6r+e0tMlGqPnH+MnzV1iA4xM1sjYb9DbmSgDAS3XIAw
X-ME-Proxy: <xmx:8babah6M0vIDRj8Vs1vuwNBGCRqgHyqjtSuLqTI2qUO0QUT7MmAEVA>
    <xmx:8babas3lCuVvLyqxJs8FM-4Tk0AQzPZiOmo5fSvh1Qt5_hjfw0o__Q>
    <xmx:8babagCE3NhR6AlENbN4GJRbz4BXDhf1EoXnqThVFn7r0qQwk15Y2g>
    <xmx:8babam0fFMJUV6HPp4GWhhTXOI7-pLi9gHzViyz7UWozmv6Bs4GlaA>
    <xmx:8rabaiiotYCmu48a45F7Jf5QSpiWuNY_cajYh2XZaqPIw8GvkhFyl5yl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id AD55022C007F; Sat,  5 Sep 2026 02:30:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 05 Sep 2026 08:29:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <9461175c-b6cc-415e-9344-fa19c194876d@app.fastmail.com>
In-Reply-To: <xmqq7bl03723.fsf@gitster.g>
References: <xmqq7bl03723.fsf@gitster.g>
Subject: kh/doc-datamodel
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026, at 01:55, Junio C Hamano wrote:
> * kh/doc-datamodel (2026-08-23) 4 commits
>  - doc: datamodel: link to the glossary
>  - doc: glossary: link four of the terms to gitdatamodel(7)
>  - doc: git: link to the gitdatamodel(7) tutorial
>  - doc: git: list gitdatamodel(7) as a concept guide
>
>  The gitdatamodel documentation page has been linked from a handful
>  of key documentaiton pages.
>
>  Will merge to 'next'?
>  cf. <apUrC_ROf9lyiuAm@pks.im>
>  cf. <954865cf-5984-4e0d-9e8c-7c874896a1f2@app.fastmail.com>
>  source: <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>

Please don=E2=80=99t merge to `next`. I will make a new version to addre=
ss
Julia Evan=E2=80=99s review. Thank you.
