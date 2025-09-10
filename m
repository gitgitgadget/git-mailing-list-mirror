Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01FE248F68
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538965; cv=none; b=gIEpYtohcU38ziOKVu7EY5iut1r8gd2lx3xBNkyg88yiiYB6DnffeAW3ldSpDggThw1hnzODLbbuifCylpA/Athn8Zg9VS03euk50i9AXFl2/HU/cWyb68jQsmPRL8BPY44o/0K+Z1aawTHGPqlsnoPzcwNyPPi+C9HddIPQJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538965; c=relaxed/simple;
	bh=WBoeN1A4eFT4FUfpaxbTLTJXnY4CF0zCyS1r/olBrqM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qcgPrmnnnh8D1/JW9aP8cNeka80iQz4Kh8rmZ01OycxssQem9uuAo0MrQFg3CY1vf/D1qQaYXrMJgl3ZgTqZIgAjpIbsBBn2k0yo392PNj0UwyOK+aAlVZUWZwjPS/k88nfzunKIJhHSlQhkqRl1aIMHuoMs7EXxPH2rkjT5sIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devjj.com; spf=pass smtp.mailfrom=devjj.com; dkim=pass (2048-bit key) header.d=devjj.com header.i=@devjj.com header.b=haXhTdvs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0xSIZt7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devjj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devjj.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devjj.com header.i=@devjj.com header.b="haXhTdvs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0xSIZt7"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFF5C1400082;
	Wed, 10 Sep 2025 17:16:01 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-07.internal (MEProxy); Wed, 10 Sep 2025 17:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devjj.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1757538961;
	 x=1757625361; bh=WBoeN1A4eFT4FUfpaxbTLTJXnY4CF0zCyS1r/olBrqM=; b=
	haXhTdvsAkqtDCIFn5ptC9nvofPFTNWS/Y57mdDwdDEv1Gp8vWSeRFyvrCulRZ83
	VWyPrcII4XwEQzt9Tbshf0rC809TIGXAAS602vjqtzfkbJv0Z7gSMpE3NZLaanFa
	TMWaaNpuoZgcOdILKvD21fIU5hnB+2988NYbCeoW/p41rHtgNO/DsOJsloNyZ0Gd
	5YjHPFQJ4Vtw1EM5UEKEd+sa8Kec3urnl2Fhf5sVbtdZvgZ8btP7035VechJKxP0
	6KWxNw382LPP6tvZolHRZb2S7rk/jEM3Sh08xFPzjdhZDgE+m+FxOqgEaiJFfFuE
	NGLeuRrpeArhY/qknKE8iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757538961; x=1757625361; bh=W
	BoeN1A4eFT4FUfpaxbTLTJXnY4CF0zCyS1r/olBrqM=; b=H0xSIZt7TcdUcY7BK
	Z2qkt/PHUmc5nsvtbdX/TAx0Fvkqserga9u67HWlu7yJgCMnL9ZQHvb3O2Bnki5P
	OHVu/MEnG0o3Z3AAIAUqjlWJpkGRUviFj0sXo0T0NhBQ3HygSU/FT6TDBaIBYQ3w
	PpGDKfLyfwN+0/AXU9p1ewQx0g++Q1LlvnutqUIjdFkwPdDGz/acy06K3n2oVuaD
	1eUxOrnfKMC+mZBt+St1/GQOTVJFg0jrdHcUYNz9kGChUdT667CKF2Szge0TgPB3
	XYJ+lKX+Lp83c8Xs4T/ntz6bifBWdJf+a681YtDvhtI+nWgG6oiETTPgukI0nUAJ
	hupTg==
X-ME-Sender: <xms:kerBaDO7YxoPPwjxk8t5u89ZL4uLxa5qOb3e82m3An58AHNFYqRIiw>
    <xme:kerBaN-ioOt_bvZ6k5kC13iAIMDznR4ht8Toaye22KD-mTRL7h1Vqd95Et-AM26aK
    71Is5FA6WAj8kDIFLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhoshgvucfl
    rghrrghmihhllhhofdcuoehjohhsvghphhesuggvvhhjjhdrtghomheqnecuggftrfgrth
    htvghrnhepfffgtdethfelueeutdefjeffueethefgjeegvdfhfeeuleeltdekudeujeeu
    jeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhsvghphhesuggvvhhjjhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kerBaDRTUhm3U2sgMfv18ssQbtCFWv1n681JZqZpGvTYF8PHqm2k4Q>
    <xmx:kerBaNuihHSBjjUSgXO5_INsE289uwEoMpc3d-v_Jx59wFqJHLyFLQ>
    <xmx:kerBaKwERnDEJjTuSNDu0Vn1nqWwreTNoknlr2tQA-CPlj3eT65a6g>
    <xmx:kerBaP43JwgwTxA57MEI4NQlIrAcBeoTiV4IbQaVeG6MugLmY3fH5g>
    <xmx:kerBaLQN2v75NRIi_JAmHUxJPuOsyoh3q0qJx0UNpS1oK5iHS1Hlk7W->
Feedback-ID: i22a946f8:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A400C1EA006C; Wed, 10 Sep 2025 17:16:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9KBbkz9ByTc
Date: Wed, 10 Sep 2025 14:15:39 -0700
From: "Jose Jaramillo" <joseph@devjj.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Message-Id: <25f1da6b-75af-4255-8367-3fb6a4f778e6@app.fastmail.com>
In-Reply-To: <acc2d65c-a050-4792-be3c-83a00810f105@app.fastmail.com>
References: <2d12d261-ae8d-4cff-8c46-b81172fe6c77@app.fastmail.com>
 <acc2d65c-a050-4792-be3c-83a00810f105@app.fastmail.com>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

That's super helpful, thank you!

On Wed, Sep 10, 2025, at 2:03 PM, Kristoffer Haugsbakk wrote:
> Hi
>=20
> On Wed, Sep 10, 2025, at 22:49, Jose Jaramillo wrote:
> > I still use this! ~J
>=20
> You can replace it with `git log`:
>=20
> =E2=80=A2 Given: `git whatchanged <opts>`
> =E2=80=A2 Replace with: `git log <opts> --no-merges --raw`
>=20
> And get basically the same output.
>=20
> Or you can use some more modern options to git-log(1) that are more
> likely to be suitable for your needs:
>=20
> https://lore.kernel.org/git/xmqq8qimrrxo.fsf@gitster.g/T/#md4350a5c8cd=
15dc5515f140f8a4d65cd86843584
>=20
> --=20
> Kristoffer Haugsbakk
>=20
