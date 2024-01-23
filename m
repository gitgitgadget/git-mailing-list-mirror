Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7858AA7
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998221; cv=none; b=kC9FvZuqIh310VtEiQMPZgt2lQmFJISkXJbhLLV5X99x9cjo/ouKdT/KztiXzD+oY4Dt64iANA46P1b1JV/7X2vaFvmr/ZW+Lk2ujeYXGZ3kAeTSRpLiQ5O9ib3KEwM5or2FLkmkiMizSIcuRHREgdeXj97053OdJA0RkUKhnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998221; c=relaxed/simple;
	bh=upVqoC/d2dl7e+SdWY7C5PzmmOYOdTAIpzX6Ygf1118=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbnB79MaDcALNL5+uFSD7ZmaS+4c0J6d+nGcrzbCwzjMRnacJhFDen/KuvABSAJsGhzAC74QeZIVhu5/0P/eu7leRS+2R/clNCcFCIgsz2UbY1s+xDHl1SjU2eWy/TTskrkNm0J7CJlNT/wS0HmyGL2trmoZqkK3pZ8BZNjJDWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=imp6Q2b4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aTeSiJh+; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="imp6Q2b4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aTeSiJh+"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 3C0BA32000EB;
	Tue, 23 Jan 2024 03:23:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 23 Jan 2024 03:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705998217; x=1706084617; bh=fnIU4NshRh
	vTK4QANk89ZvsJM2PnPy4DpqFmuEhERuw=; b=imp6Q2b4QUp3W3J55kLWNroTgL
	5k3NhU4ZKEF9CxLWIVmjSXjqQEh5eFq9alrs+g9hwMWyX3ZtTtBEgBEYNtKcrBdZ
	2wLB3XN1TW/GsBKTMuZN1vifFMYbdhaHI5xifW98XVJrosQiRWvFYhpjUofrrjUo
	VU8swHUem2fLkcYMdNPgMKTO3RQlrIJ8JtxvFWxhU8b9GOuPNDPBCmV9L4Kag9SO
	Ab5wMCS3P7kntQkhbuqr81z69RwXuaGPLXQHBjptxRsmw54G7Oe/HBwk0yBjFck7
	TKLm0A7fJdOCEocyiFYa3rp3mKFscaSb1sLz+twvW3Ty5GyYVASdZ3mY7PbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705998217; x=1706084617; bh=fnIU4NshRhvTK4QANk89ZvsJM2Pn
	Py4DpqFmuEhERuw=; b=aTeSiJh+G9gqszfd91yV1VysrlbZaZnqGCkyFRliQboo
	Lc2/5KvtNeSYOlEDMfzNIfzyGAmG7XcbiaVjEtIvQp3Z7jJFZGFtIA/4PdJ+baSz
	dwA7OF17rvLAcD/aPHU9FCpl1RxxnxsXwrvlYrzRDAL9o78oOsLQr5zigFYOxOo3
	1FQirneKI3jqCkulNbsh63N+cF3GQDrVf3aAyLq7EbEUpJSGtrJ736rb+x7FoXRD
	3gd8yN8HmavxzhEISS2l0Fa9+yqtXfoCvO6p0H7hepW1l+cjg3FEfGeRFeLiQcMA
	PCKeulj/NqOTG2uszzPU+QC2Laohvb1jDLrqo+JaFA==
X-ME-Sender: <xms:iXevZaPb62dV8ujdcomEhmcdrQsyuOt6YJWqwMMQOZemCCyZaay92w>
    <xme:iXevZY8S-0LBnVly0rvKBaNaHXS5NcLQGE4lFrDAPSx15JXbgPrHhwwmW8ZCb5Fbl
    fSeCIrrW9g8tVgj5g>
X-ME-Received: <xmr:iXevZRS5xywEMFUhjLrArqHkLp4EHrXgs6Hhhw4wiHC-nQuOyBSVcTgVlMPqaqa2QijBy994K6_LeREX1wJDmOyXbHniHp4nrNDCszkR0cNRwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptdeiteevvedukeekheeiueevtdeigf
    fgtefhkeelgeevtdejueelleffteeuieeunecuffhomhgrihhnpehpkhhsrdhimhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:iXevZasxpbyRso5Ez32MF8NATqpR9poqyfGEJVdMzKoiPiKOm4Tz7Q>
    <xmx:iXevZSeM3QzN7L3-Q9Hg2xKqyXoibj_y8eWWzJD8If15l02mn57BLQ>
    <xmx:iXevZe1SGg36y1R2KgC09IM_Lyrpu8e704meKKLNv6-mkdunKCMqiQ>
    <xmx:iXevZalk4yVk1Szt9Bcb7_HVZEJJWT1LC7TALMviz-uWV0LPF_IERA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 03:23:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4aa90259 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Jan 2024 08:20:30 +0000 (UTC)
Date: Tue, 23 Jan 2024 09:23:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: ps/reftable-optimize-io (was: What's cooking in git.git (Jan
 2024, #06; Fri, 19))
Message-ID: <Za93haRpKqksqktG@tanuki>
References: <xmqqbk9ghio5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t1wUqPCczPvNJlJG"
Content-Disposition: inline
In-Reply-To: <xmqqbk9ghio5.fsf@gitster.g>


--t1wUqPCczPvNJlJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 05:56:10PM -0800, Junio C Hamano wrote:
> * ps/reftable-optimize-io (2024-01-18) 7 commits
>  - reftable/stack: fix race in up-to-date check
>  - reftable/stack: unconditionally reload stack after commit
>   (merged to 'next' on 2024-01-12 at 4096e880e0)
>  + reftable/blocksource: use mmap to read tables
>  + reftable/blocksource: refactor code to match our coding style
>  + reftable/stack: use stat info to avoid re-reading stack list
>  + reftable/stack: refactor reloading to use file descriptor
>  + reftable/stack: refactor stack reloading to have common exit path
>=20
>  Low-level I/O optimization for reftable.
>=20
>  The two commits at the tip are new.
>  Will merge to 'next' and then to 'master'?
>  source: <cover.1704966670.git.ps@pks.im>
>  source: <cover.1705585037.git.ps@pks.im>

Yeah, this topic is good to go from my point of view.

Patrick

--t1wUqPCczPvNJlJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWvd4AACgkQVbJhu7ck
PpQ5qQ/+KPEXz+gejhJY0vsTZMVpclLZuUvqO0v8QCQFXJHHeKv9Ymvah6t/IJuJ
Otm03N7mZeQmfdgV05Zf6P2DEKYprmR5hPXNLJjhVLE5hI+Kb06LQgoGkt7ikyRA
N9DhUxmGXumI9PmzgoIIhoKiOkl17THokUEbNxF93pEbL0WRNP9rl3IZkFiqMPUF
uxVj16PojrqUO2djI1shik0xg+6DOLe/cqH4KLgQp6w869AgaiaTLBcqTy0ajYSd
bkZwZYZ5KdC2cUSAw/hQxWUhw9u62RvHI2dfjXw/dtUFyiC1UC3Cx7taB20KKShg
CP0sWu29kLC3fCWiOKH8m7sQx+9HfqstGRGwy4bffdK8AgNwYIvOdECD7zO4T+G/
zrfs+5//McWAA2OfMInpZsqtvFRYPkcuTPMUKw+WICvixXAQ6bhYR2itkQlIuLto
9BswAA1RJlnJO9Dfbvixw8TikuEOaxRnIwiInImeNlP422IxsrknQy8myT5pVUvd
InIN60X26UXkvSb0Z8aFoN+t3oBCJjqzmhUDtx+TIR/YF033TAQdV2XyvDnNQ+5J
p41XeEcJdqXDhpudRo3Sj8G6Xy5xhYwZOjZC5KiK94sG+2EzMOyiS+1+zu81Wri9
vqis21eP/EIgsjN+tSqcqv/XFGfVWv0SnkauhawgAQr3qHeqUks=
=wC4m
-----END PGP SIGNATURE-----

--t1wUqPCczPvNJlJG--
