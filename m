Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6631A7EA
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959185; cv=none; b=NivgyDX0foLsqq3j8ue9lwwPbIPGlGTnCCfoyLWowONNtVE5OLF2rjoiRAcmy+6pyU+gC8MkExAg2H3KZir7GngMk8EbXHvSwnASxbvmORVTAqkjynDXt0k4xyCoFtkFDGYqkvRiGRSuPltvC6aFf9EocH+cZu9IhT0MNXuq3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959185; c=relaxed/simple;
	bh=VxfUyJ19Rz9pylv1dUQDIi1qXhD2BiIyBRYK6793/VU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=usszPOhhdYQrMG87fuLX4dqa8fkdT4S/1Md2KiWRLzLLSWUaCVQX7XBWjS1wBNZOThwkaDXnHd+vInho0DeHb1CtnVZPFdavORDFawtXqRgVd9uq1Du/zXVTMC5uoR43WQBFfCfAVGovgkC/cjSOYYX6kQgwx7tZ/NuWF7j37VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Tf/gzAz+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QVgBh1sN; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Tf/gzAz+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QVgBh1sN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C20047A0141;
	Fri,  9 Jan 2026 06:46:18 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 09 Jan 2026 06:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767959178;
	 x=1768045578; bh=VxfUyJ19Rz9pylv1dUQDIi1qXhD2BiIyBRYK6793/VU=; b=
	Tf/gzAz+Ef61wuUYOvLsyK4C/fnMV4+kJ9WLh2tlBmvjlpWCO+obAkxZ8NzX4ecU
	qn48KBJBa41gsHyV/w1sZUE68mOTgBfUHSXLXzOpQnTCJcYVMC8UGMNeQhv6QdB7
	fru7LYUwIjdTEdwwYjZzWXXxiIOIpfpMAKkt8tsb6gxV8LeliRK02zVX4mqJC8L/
	2XF83DhFXdzhUxgB1wmgozu85Akmd1Z0+P05rwurdw3NJo5sFpy2om2oGWHalNoy
	4KrwtxxdLC5BVXVs9OajDI1YsOUlw77YyPYQ4CKnWdwtfkAuBteVHPcDksPJhgus
	XrOMWRdTmjGoa383aL38Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767959178; x=
	1768045578; bh=VxfUyJ19Rz9pylv1dUQDIi1qXhD2BiIyBRYK6793/VU=; b=Q
	VgBh1sN1N4ByA2B6Oy6nqnCV8MkBN7IdMip55oN6sYORplezZF+qJ/W6GsOW3tQC
	oAicC8vOU/MyBh1zpJKjOqSZj4cxCuam5jN2JZwMn7SVn//A7ZYEm+HMnegSTvyn
	hKy34wX+E8rz7uFFf/NLxcdtwE5LMwAXQjVhi9a9agNOTjCPBVMXkNLI+3ACqQ+X
	/Pf0j4gEknyf8SZduApVfPtDelE+Tc2+qgvUJHbgNwN5qmXbKKu4/A5t17+JQLBe
	4lDciWLJjsjhmHmXGuQg6PhXH0zUM6nkbvYVSVWKmi10I9z6cdQdSYPp+gMaQ58+
	UEdzQMo+hzW8aeFGm1N2A==
X-ME-Sender: <xms:iupgaeDB-d_m9und6RyjoA9rZyxaVU85xxNRFUhfJFbG_D7yPGdwGzY>
    <xme:iupgaTWglZcJ0J1hLdBqmIRcLBKf5T97UOw1uT3Qv9M_ofsMDGIowrPzYnXPUhHh_
    wnYTh-COh_6FpYE-22RKxwNY4tttnYdjISdZHsD-Z_le-KFinvi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iupgaQthuKYLdcSKOK1T9sxGYisoe4RXZ8bgKkKHPwRZo1LrzopR9w>
    <xmx:iupgabZ8r8u185BoKGd-huQI5HWyqWrI6xEEotkcK3LBq3Ymlr54BA>
    <xmx:iupgaTUbUhknE2yoAZTaPULvTUp5Zf6X5fj5i_XgCAmd5fX0z6Mabg>
    <xmx:iupgaf4e2zQOQiZUlJPFDn8zCEjVKUNgM4-mXVXJplmk9O2f0fhBJw>
    <xmx:iupgaQGzEZtpXn6e7H1_eYqwsmNrYIRU_y9CnZSNN7BOVuRrswl6mWUk>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 792B01EA0066; Fri,  9 Jan 2026 06:46:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJSL4X652oCo
Date: Fri, 09 Jan 2026 12:45:58 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <264242be-166e-4d24-a499-8c849b3c52aa@app.fastmail.com>
In-Reply-To: <aWDom0myZVrO9au6@pks.im>
References: <CV_doc_patch-id_3.1ab@msgid.xyz> <aWDom0myZVrO9au6@pks.im>
Subject: Re: [PATCH 0/6] doc: patch-id: six small improvements
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jan 9, 2026, at 12:38, Patrick Steinhardt wrote:
> On Thu, Jan 08, 2026 at 07:28:14AM +0100,
> kristofferhaugsbakk@fastmail.com wrote:
>>[snip]
> Except for the small nit that you yourself noticed on the last patch all
> of these patches look like obvious improvements to me. Thanks!

Thanks for taking a look! I should get around to making a second version
with that nit removed today. :)
