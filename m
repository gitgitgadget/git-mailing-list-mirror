Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62C284B58
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768725918; cv=none; b=mIQTZIP6tNjkvTzKLdRMXfjH/y2pHoHpEaTgwg5pgD25b1vw7AxzU+lRfiMo6rRnFGUIGOzDUgWoc7mUKYSCCuBSniXNiAMr7OPrEDHxbK6JvHbkDA+Pxw3YIt/OH2GyYqBLoo8rICKTpwnNX/MJdpHYtonLFUKbckGa43X2074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768725918; c=relaxed/simple;
	bh=AvQhzJ0pN9shbVKIYFA2OKRR+Z9VHzYTGNnanaOH5r0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A3ppYOXDlyadlDDIoal+HheCmQwEbwiFFW0xOAgCqzoO/MNV32M6rCy1LOaqpKJs23sBaJdpwIKN5bu3Np9bX9hkmLt4vgcf5dO8XDBulJbSobcaiNoMKACiCREagGuhw+VTAkGnTLjzhJJgAiEtPqxkN4kmH8dCWzQNbFL0AAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RwUBzfvi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MdYA9hF9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RwUBzfvi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MdYA9hF9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6D5B1400336;
	Sun, 18 Jan 2026 03:45:14 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 18 Jan 2026 03:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768725914;
	 x=1768812314; bh=AvQhzJ0pN9shbVKIYFA2OKRR+Z9VHzYTGNnanaOH5r0=; b=
	RwUBzfvi7s8T0CAgkLYfOUhcPbtJdE0hecb80s3nwGIDMjdW8m1xccKmdLN/bE96
	83eZPJJNJObwUqwUkpUikV+EXisSuO3+meSy7ZJkbQxBXglaVFT007eCUsLTFfKk
	tyg4vWVTky0Rer4iIsF7rN6+3sfOLKsFQMQNloLb1mgOTcpjbmbHS7ZHZdQuPQe9
	ldK2UDTvTqvreH/dkMXSFwUVZPSYOW+7n55y071u3elk/e9l3UyAwqPWhi3u+ELd
	+6Ga5Ni18q+2GVq/wrfghZZyzfKP1/Ny4G/ORxXBpNpZsABXTTsW+4AGoVCDzhsz
	vapPimclL+cp51HE9f8NQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768725914; x=
	1768812314; bh=AvQhzJ0pN9shbVKIYFA2OKRR+Z9VHzYTGNnanaOH5r0=; b=M
	dYA9hF9RtWwFsfT2QSgby9jGD9xrz44FK/ljQC1P98DBsiXzj6kU4d/ttj/ohFD6
	OCv/m9/6bXBMIUpXoZnE9QVeTum6Lz1vvMHVR6fjtLXFLzihfK+1+HgR1KCQzlXE
	tviZVsbBeV9R4I2mxGknObG1LSOMFbIz/KpY3Mfn3s0LqhL9ZUTTTt+rvk3pQhTp
	AbEVNkNxua0EneA9zLrOLqhyVHRpfEKli5NKuwFCFhiPbtUa/H0xQn9C/ArkaoNV
	QbBojp3OTz0ETBSqBIJj+xJnEGLTwYYZ2MgcHV3ZLzJuWiU2W28EUqTT2jE1pdct
	FbvoPKkLIHx/sUYeJp6Ug==
X-ME-Sender: <xms:mp1saQ7-W7ysZmkXh_w_729TM5ZbrqSqxIDQ5WqEbqYEC2xOkENGl20>
    <xme:mp1sacuT4g3qkPUtdRJ6rVgQ9GW0w6edO01_4_Nc-seJHnXpgVFFvzuH3rk0qal_X
    A8p2t21HgR3MlUMtW58wUqPaWkjWogUMZkq5iefzGEknzjlhlst7UY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeegvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsugesrghprggthhgvrdhorhhg
    pdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpd
    hrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mp1saez0HbGVqINgjWAhu-MXr028FgbnqwY4imIjNQT4jKbPRQzykw>
    <xmx:mp1saa--DFQH3VPgrlhn_S7rIwaiyB6xMYHgtE8L8IpZLgJKj5bbXg>
    <xmx:mp1saeg-xw_Vbgx2bUIBpy6osMhESnK2vcU8OwlzCoLdCCnq_n-1Qg>
    <xmx:mp1saZGYhzqrFWKhxp6ukfxGafFpLZ7kxta5-e_X3OpfM8K52tu1hg>
    <xmx:mp1saYdD8bmQBzPbUguClBjbwoHtqGU2_q0ih6LIFEfmKSuGRzpraxjg>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 65E641EA006B; Sun, 18 Jan 2026 03:45:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AL6oX_Nd9T9o
Date: Sun, 18 Jan 2026 09:44:53 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Emily Shaffer" <emilyshaffer@google.com>, "Jeff King" <peff@peff.net>,
 "Chris Darroch" <chrisd@apache.org>
Message-Id: <a2408c8c-db6e-4632-8fd8-7ac888bd3fa2@app.fastmail.com>
In-Reply-To: <20260114185731.2381550-3-adrian.ratiu@collabora.com>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260114185731.2381550-1-adrian.ratiu@collabora.com>
 <20260114185731.2381550-3-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v3 2/2] hook: make ungroup opt-out instead of opt-in
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026, at 19:57, Adrian Ratiu wrote:
> In 857f047e40 (hook: allow overriding the ungroup option, 2025-12-26),
> I accidentally made the ungroup option opt-in instead of opt-out and
> despite my best efforts to set it for all API users, I missed a case
> which requires it to be set: the pre-push hook which regressed.
>
> The only thing I needed in that commit was a way to change the default,
> to convert the remaining receive-pack hooks which require ungroup =3D=3D=
 0
> for sideband output, so it doesn't matter if it's on or off by default.
>
> Bring back the original behavior by setting it for all hooks in the
> struct run_hooks_opt initializer, which nicely allows changing the
> default value only where needed, in receive-pack.c.
>
> While at it add a few hook tests which exercise receive-pack sideband
> output since they are the only ungroup=3D0 exceptions and there are no
> other tests exercising this functionality.

This description looks okay given that the regression was never
released. Only those who go out of their way build on top of `master`
(for some reason) could have observed it. However if this was a bug in
some release then the description is very technical and play-by-play. As
a Git user reading this isolation, I see nothing that links these
concrete code discussions back to something that might have been weird
in my hook scripts.

This would be especially relevant given that this bug is so weird. It=E2=
=80=99s
not a crash with some error text that can be googled; everything works
(eventually) the same as before, only that *if* you read from standard
input you=E2=80=99ll have to wait a minute or so for something to time o=
ut and
unstuck the whole process.

Again. I think this is okay since it was never a bug in any release.

>
> Fixes: 857f047e40f7 ("hook: allow overriding the ungroup option")
> Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>[snip]
