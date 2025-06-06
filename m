Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424642A8D0
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749225128; cv=none; b=DHFVJNjCqq27KmUTkkl6jOmAp5Z0f8rx9DJgDG6QgC3PBKD5y39zYhkb+t3jSo646cRXPo/NxsUqe4C5EH47alK3jm6aM/Kc3ev9EMrYmhcsIGs/9QsJawvlW7MOhgatZli27sHcIQZWHiSmuiUuqQ4FD8pYR87e2ziGKCh2VLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749225128; c=relaxed/simple;
	bh=faFfBoKPP1y3sAvyuOmzB0vvt1RfeBK+SpUkztsvIH0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fwqj/NKzP2OesjnHshI2XHIatGMXav60CpeAkeukM0NrwLl6jIck7gfxNV7FidYAFgBSt+PHmzoOYgLUY5ZIi9ynlXMBYmLaF6OpSe2ej/Y4WIANrpCdTEL9i0shETLx0Tdd97P/UGcwrm+I+ecX/lpEykh2t948cZGCYob607A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BT6L/64y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ayfiadjD; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BT6L/64y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ayfiadjD"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 47146114008E;
	Fri,  6 Jun 2025 11:52:05 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 06 Jun 2025 11:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749225125;
	 x=1749311525; bh=hawy4ZVDEGmQxyrIR02NPaI47AUdAj1v0RZumcc7wF8=; b=
	BT6L/64y2/duoTPhUwKGnIRheEL/XFbWpxUuiAcFOAfp5342CkOAP0SaRQznd98k
	hc/2JlxfRkyWZmiapUsDxI+DFCcPYZbafOMBLnsI6dWmrct3lBi+stDDp8EvVcqR
	soYUlk/dfak7fTBNxayMsxDe6B8ESA1E9T1DTDUEsj3zFywa3+ceTnS7vxlZTV30
	iXAh+qMOhjkO3VwvPgg4Ggwfu23nDUUvdmX9fUyFaedKBF2vvtJ8szqOQe6/+gER
	So2cYuj1LzNCc4h1Z8RYKC+wRuy6DuvRSUFmXcKqFjQKRhh5d5g+Wzq9Zpxud27V
	WP4a1CbsWNaBVbCVDY93zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749225125; x=
	1749311525; bh=hawy4ZVDEGmQxyrIR02NPaI47AUdAj1v0RZumcc7wF8=; b=a
	yfiadjDLF6jOBytF7v6OW5kc1gC3C6PfUZG3fUUWKlXo02wAbpjzAuo/jqSYYKnx
	/nxhwI9gcsq95woRkFdPjivNNyZ+CG5qGpO7zspv8aD+BLZGWQ+4L7XqNtnM/AcF
	5Nu1i8LVoVIggDbpGrchjSpwbJmu0QaCsZcuuT/HpJ7dKNT5hC0ZdqEs6W9EJB34
	yBf5tv2FhxXSUcRbK3Z8LTsRe3AahsQB+ovjrVYI6eg2e/c8yBAbaoJ2WFaNFQN0
	Vo4o4cPKJSz4k/X3na4g5OEeHV0DP3xiJYIlH/BIDrJtbzn8h/pTzuDtu61bXnBx
	hVNkVmF1QKhMwLr/oILdw==
X-ME-Sender: <xms:pA5DaKj7rRNFSMEF4hc10La8rJWpJtckoyJ5ydeAYVacOw-wn7b1DiM>
    <xme:pA5DaLAyA6gSG1dDdjNo2iDmrm7QeRHLYdwEl24-n-E4SfTYNZvwEFBZ5CS5oqB4u
    hbwgjIYdewn-20DNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdrrghgrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pA5DaCENh7p-Bk44uAgKx4bdjQGInt2V0bgKTEcluMJxO_S_jhIlVg>
    <xmx:pA5DaDSpm77d96F9Cj4ME8k0DQZHDzwVGC_-sd8xUcmndQXpONiVIA>
    <xmx:pA5DaHyHf1JOMmF8Xdnd9B8Oh22i7gmihwEWffBUkfOEQ4D7ZExUrg>
    <xmx:pA5DaB60PKNEChHyZSBAllXzHr0M164LbDsygIC_1VFyqDd8NBNz2Q>
    <xmx:pQ5DaF1DRaO6wfmjqZdFLYrheyY_8vuTaGVGxqVxF0ibkNoJdWrHjrjY>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C017E1EA0060; Fri,  6 Jun 2025 11:52:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3e5cd85e357bf448
Date: Fri, 06 Jun 2025 17:51:44 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Jeff King" <peff@peff.net>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <ad3fccf5-be36-417c-b2a2-f2289444ac40@app.fastmail.com>
In-Reply-To: 
 <CAN0heSqJfrLYbVmKh9-mS0fHkBSDR2dxphSaF7Q_qfyzONs2Eg@mail.gmail.com>
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
 <pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
 <bf919293-562f-4572-bc0a-aad7f22d1013@app.fastmail.com>
 <CAN0heSqJfrLYbVmKh9-mS0fHkBSDR2dxphSaF7Q_qfyzONs2Eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] curl: pass long values where expected
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025, at 17:43, Martin =C3=85gren wrote:
>> Maybe I don=E2=80=99t understand range-diffs enough but it looked lik=
e this was
>> using `0l` instead of `0L`.[1]  However the patches do use `<num>L` i=
nstead
>> of `<num>l` throughout.  Which I like
>>
>> =E2=80=A0 1: Or rather I don=E2=80=99t understand that this is showin=
g `0l`
>
> You can read "--" as "we no longer remove this" and "-+" as "we no
> longer add this". In fact, this whole section begins with "-" (in the
> outer diff) and we can read this as "we no longer touch this at all."
>
> Where, crucially, it's "we no longer touch this *in this patch*". Patch
> 1/4 in this v2 does change this from "0" to "0L" and this updated patch
> 4/4 then leaves this spot as is. Unlike in v1, when this was a much bi=
gger
> patch that touched this spot and many others.

Aha, thanks!

--=20
Kristoffer Haugsbakk

