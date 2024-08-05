Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A713A271
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850927; cv=none; b=ioaD/L39NnMohMNa/Et2MmJ3MkYRyNEGOIBIYJ0LWecXSdThqVFDJ2O4fX8icGnMps6UNlKTXaUfgxa/PXFOozv61qr5BEZ41W1AOG3M2kPMi1EZsYc5Ic3T7jkfMrndfYFYDx0F40pEIFgHZ/Dc1EvZ7DAzxrk+kbx3AKuNanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850927; c=relaxed/simple;
	bh=YvWhNZ6BVwzHZDzrtQPEwi489UIuW9S07zOMjKxXDj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLjI88tVzvHvlm1Hyz3rt8eUGnnBkSkIbYFPasWO2E3BUlATv9t1cpJ6aIaW844WMxgZtW+2gV8/sC2FZdwAUQROPEu6EfbfBXmFS6unRyWxyBLAOaP6WSFrYrZlvOJoq9aK/xHHetcJOmtHVvwLG8clLXMY5+u04cVpUrhfRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lY6C9gfK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sZYzOSPr; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lY6C9gfK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sZYzOSPr"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id EB61A138FD99;
	Mon,  5 Aug 2024 05:42:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 05:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722850924; x=1722937324; bh=YvWhNZ6BVw
	zHZDzrtQPEwi489UIuW9S07zOMjKxXDj4=; b=lY6C9gfKHZ9jOXXUCHJkBqtuI+
	N8edgW2rGRlik42M4zKRKTJ562BV+BI+L7De/L78HP4rQTPPjs3Mie0Bd4ORq4tf
	PsfMNyOSLeMZAIASz78KKJ99KgQmDNWKaOHEQnnovMiDUnx1Y/62easvbvZcdM7n
	OsQtQQqXtmFuvJBQuKS5L0Uj838Ucj+pwT6y52AgMBcTrJmUpg9WCuhtX1yNwbwR
	S5PrmNFt2qWgn/eijufHCE+KDH4wXtd4M7fcOaXvaB0YY/IpAp8SgtAmfbbAtfg5
	L2wQJGlHB/ANTKM/ed8zwgpXKJcx3qZx4vfpLVkfBiYBhUQkwYQvpRpe0nUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722850924; x=1722937324; bh=YvWhNZ6BVwzHZDzrtQPEwi489UIu
	W9S07zOMjKxXDj4=; b=sZYzOSPrdtuAoSioRgRYw/iIzzNadEe6S0+dyMlkW1zK
	BiJ2HbegBwQrlTMbXJf5lwPo7wxJQlIXFv+NSB9p6DT88XeaPbqEMsdSIpYaOj2+
	nKvrSaomIurEV4d1gthbK5N8zzoDYiopA57iV/hGJ7PmaBS5oRGQ19jSyPiA/aP/
	ro4jshsGpPD2yeVqnZNJfaNt12gtu/+Kxsl258hv6eCjTAXxtOxPKE/+cHrHFlom
	vizAwv/35EbM9Bm8gNGrF17ALd5gdPqFakK1izqMfpNE5Tv8fMB2bOXaACPU6T6C
	vd6WF12m49VLlNKFFKvBRpDwiZaYFYO/NIuVy6oEmw==
X-ME-Sender: <xms:bJ6wZqQAtNjHqRW3B5_zZFHkA47DfmB4NyL2NRmp9cxA4w7fYSMm7Q>
    <xme:bJ6wZvy5XRQwWjrnvEt9wgQs5gxqGeUQmTq1FKHSOycHIXHBcuTXtxghRa0i8u9Zp
    dg_Iz8qFLpVwB3iSQ>
X-ME-Received: <xmr:bJ6wZn3wsNT1C09sBd9JtvwpMukKR8ScfeT0IMXBYk7B2yRQqp4NQQV4y6PLQ9QxYeoSPexTsIXGQrIyVgCb_KGQhztLY9MPFJdu_aoVcRpSaC3uPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:bJ6wZmAfhuWzPuuIKgFGhg_y0hdV2gzJf7lb_Sl6Z08ngx9yql6fGQ>
    <xmx:bJ6wZjhgD6MdsWFVnj_I6xuPdQN_vRGG1kqpglSZ4FWEMNLNiegJjw>
    <xmx:bJ6wZirkhAJXJD8WcoxqGogqiuyYgTaIEqi5dcuVg_wIRHzF4C748w>
    <xmx:bJ6wZmhz6Kxs86AhoSGnW0RJSawFyLijKgCCoxGDj3i5N8JEbCELow>
    <xmx:bJ6wZms8of4CvUCxTbHvMS6MWv-p-lAIZXDl-q4higOJGdUoqskrSW13>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 05:42:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d1ad02fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 09:42:03 +0000 (UTC)
Date: Mon, 5 Aug 2024 11:42:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] [Newcomer] t7004-tag: here-doc modernization
Message-ID: <ZrCeaU4VKxPYTPiJ@tanuki>
References: <20240804071137.30326-1-abdobngad@gmail.com>
 <20240804071137.30326-6-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m7uwQeSJuEe+F2sS"
Content-Disposition: inline
In-Reply-To: <20240804071137.30326-6-abdobngad@gmail.com>


--m7uwQeSJuEe+F2sS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2024 at 10:11:36AM +0300, AbdAlRahman Gad wrote:
> use <<-\EOF to indent here-doc

Instead of what? It would help to mention that the change converts from
<<\EOF to <<\-EOF, where the latter allows us to indent the body.

I'd also suggest a commit title like "t7004: use indented here docs", as
"here doc modernizations" doesn't quite give you a hint what the
modernization looks like.

Patrick

--m7uwQeSJuEe+F2sS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawnmgACgkQVbJhu7ck
PpQrJhAAm8yKXwDjYI4kT83A/s8Py1zJDSDAOH/ur8ApEqKtT4kgXJiHf1eQ4x3c
HF7OyvCa5V6bCFZ8ENJ7rRXKgQN0RJaXpEOmFsEd+olP51j45e22BMfgBI49U3Zh
XdQFr62P+wFJHgEgvGW3S6xGHo7nKmjXvuLCzUfHd0lFrpVlt9GlR/PI/d7WbC55
Uh3PW8rXfWrk7sC4o5o6c40b5jD1yP4eK1fuFOPuoaAG19sg9zFyqM+PSFfpRHyd
uMwkwhfZXsuuclrDLwZD9KJeO0/AteBGIwn1paJSmPnvEw24arZCEXnXKoUv7KIg
K0TY2bsvW/Gew3R446yjfcTDEMfUVh0jHy6PvgFTt9RDinipQD47R/3u3OwUJHXl
ZpUvAAbCrBWdZXhfAwBxuYHM7i//qJ5UpWgxvrs95u+SZgsIPg153XHLoH3jtwl4
TTc0nEJ/QeNb2x2cY388yauobfeat7rTGVTtKL58Wb+vIGr3u/aHI+mdC6kfx9/l
bFpqziYZ7uOtHfqKXk1PPOpnkT6mHi/f09L3YTZyva7Y4TLqBrQ5OUJUErUu4D45
414hn35jd1xF3v8EKapKmrXTPnKtL+XnLJIsnBA4XxmlCXZkKlc3/1XwE0TWo/6b
Erpl5NP9GBtKOv8SOrQ1PhrPMpr4mYcr+JtZZjPdOePyse1inrI=
=eGRZ
-----END PGP SIGNATURE-----

--m7uwQeSJuEe+F2sS--
