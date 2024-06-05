Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0EF8C07
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717565269; cv=none; b=J+szCGvr3t5UZj29YHULvnrEBimgULdWHN/ZaYk6id1XY5QSffNByxlEKu9T+CWEQi4+jXMHFCgog9mmOaoZrbqIqHnZpHkq4RTcmdEv4IdEV84xeBdHUlVkQTy4EsVPEKswPU/F7110RSum+hcTzS8LFtPxh84tcYNMMDXquOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717565269; c=relaxed/simple;
	bh=m2tHahlygi9eRrf/+r5T3NetYiV1euQfJDMHBakYagk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc+KoMlQiCq2Xm/eF57R8vgtoT0IJMYy2nIoBdgHHwmCFG5i8o+Y3Z6ldP8E3Qio2eStBJV3LFcBqzsrKSpOey1TQrZYYdvddrZvFOlNYjIEQZDrPzB744ZM9UZqokPxpkrwPv7Nx8z3F+2+wVuLm+9K9IH898xQYLNnNxevqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dit1IxC3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+to2jbg; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dit1IxC3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+to2jbg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 014D11C0010F;
	Wed,  5 Jun 2024 01:27:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jun 2024 01:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717565266; x=1717651666; bh=bnxH9ouN94
	tBlraHvuHDbQGvnBuV63hmKVVOVQl0Z1k=; b=dit1IxC3QcRSZMIwvLgPAyxVsw
	aY+Ftz5Fzs6PO+NgRkHlH46KgMyWRa0OYf1DxRR8n02ZAykTQ7xycRKVQzEutG7O
	gzbD91+ma4M7AxKnuj+CoL8LycjP/rKZxOxgTtivO/ROUh8IX44oIObjSXmmFw6A
	y40zjOqGfiZRuAgq27pW+yGqOfYYzi7GNBr7+sQiAXQ1wmbDGn9tlaAIfZFeQrSP
	HZ0/Jy7TyelNdzFudYRHPcw4LRdMhY/rO6DSwNLWQx+4mRSNP3JBfZjtSVnmUnoa
	7breC/uzB9iqr9fMUn6OmoQxjeyP79/FMnW1vvmqZbp/cjfQLKS0Vy0tr8sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717565266; x=1717651666; bh=bnxH9ouN94tBlraHvuHDbQGvnBuV
	63hmKVVOVQl0Z1k=; b=C+to2jbgSHxMgTbFAnIx9vKLWIL+D7qhbCm+JpioRyS+
	ubwblFe1BMLzKpIWdyOifXn+fHThqkJ5YFX+PnaHokmnqxeXJ4jHwIvI7mGNAn6l
	pDi5rwDuSBTr9pmhIRSqe5qk9cUAHAotS5LrKUmHav4j3nQlS99nV9ZNMkJLEakc
	ET4JkY0CRwVcy1bBNXAGW1Uo75Fu5lVhrbkf1k/SWSJRQdJsL+MkOqHssi0uC3LC
	zntVL6yQE3nFgd+dyOqHR1wDCyXHKpOde9ireweamLlUXBxl5Yt9pYPydHnwphO/
	t42ZL62QJXYeoNXhpe7YE1Yro3m/J8X0eKft96QAnw==
X-ME-Sender: <xms:UvdfZpdpRKSoxHvMnMx3AYzXhCMpcTsiFW-RfS5TwboTDPqfNDlWyw>
    <xme:UvdfZnO7KPk8zwH7c3jgvpMgcrNOoU2Ho-sIaDM6s3FvfWmRMG1SzWVLznvyvbyu8
    fH8s-oSmwqV79XdhQ>
X-ME-Received: <xmr:UvdfZih6JS7Mi1O2ql2HsXZwkOCxUrAv9E7tmoQV2YOu6Pr1t8rrGLOmSlWLm1d86YAHqDYhEXx0tOD3f57sanZfD9zcIx3akQJxp--wd978fJCpPHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:UvdfZi9feONFwDr1nRzHhluc1l4MQT9zDXEFGZ-DMjQonxJA-N-IIg>
    <xmx:UvdfZluFXL103KtWlZCqvsJDiUMwboNjjp5Dgv8sUXlSh-wgeVQ9gw>
    <xmx:UvdfZhEm_xqw8m21xNpAbpA-XVIIdY7M-x7W7yXIPNN4iX_R2m2b6A>
    <xmx:UvdfZsMMIANaSAVBiA1z3TJ40_RZHU17R5AJmqSWEpDqMxRICVetQA>
    <xmx:UvdfZu7CsmdPu_p82rR9TB3r1fLv0ieqrdOU45yQKHOGqc8Dbm7EGAAf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 01:27:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 417444c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Jun 2024 05:27:15 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:27:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] Makefile: extract script to lint missing/extraneous
 manpages
Message-ID: <Zl_3TQrUHdb5osDA@tanuki>
References: <cover.1717564310.git.ps@pks.im>
 <b06088a2ff65a3455f0f5db2a9b752901f2af14b.1717564310.git.ps@pks.im>
 <xmqqzfs0x8w9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bXiuNIlbNXCsKgPF"
Content-Disposition: inline
In-Reply-To: <xmqqzfs0x8w9.fsf@gitster.g>


--bXiuNIlbNXCsKgPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 10:20:54PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +++ b/Documentation/lint-manpages.sh
> > @@ -0,0 +1,82 @@
> > +#!/usr/bin/env bash
>=20
> I do not see much bash-ism here.  Unless absolutely needed, please
> use "#!/bin/sh" instead.

Ah, true. I initially did have some bash-isms, but got rid of them. Will
adapt.

Patrick

--bXiuNIlbNXCsKgPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZf90wACgkQVbJhu7ck
PpR/nhAAgs+823pHZcB3lnZzmXWYG0+mbdrY4kyalucPgPp2pCx8weEoWXsvyXBO
sO6c6ue1Fu/y+hYMNAKLzLqY6zs6k8fKxTJRpBUGILyD6zVwHBF/AIKeJDqvQuyl
gSmKexuLtOV3VNTN+5Lxp3S2zSHTAD3bTvmxSBKF+6UCaMHjb6eBlNMVPUkuMtK7
nyWswmEEoufQfXYfKUqDj6HGP/69kaDSFpcon7Pja2bf35NbV+K/emO6W7v6S3FD
YivHB/F/3o8SMvJhDFeMGzDbXQ/jfAJbS92IG4hlog3xBpm/+j/8enwBvQvXRWC8
8Qbxvb7JoxiFMYC1ExIMRF8tbUWWyWQwo23Qz6PQajwehePfXjYD3gOWesA1+UUu
9VXqj2c1ey2I3+Pa6oUxK/I8faWGwASs0ssAE/SqTqgjRZe1LenVxz78ljJYBA82
XC218PVv9HvFxlO5F+pAKXearsVrpy2BKWePcCrDWOisp4/njXLkVn0zBovbObmr
6FA1Esdt6snYAR5HljjR4Tkbr9Tb7JfZ6Lqli2IOi5qd3T2DDgysckI8e75F4CrW
qhiviyAbHZDFmFQWTlmD84Xop+y8ebN2GmVnHWfjaxwVq0jNZ4NtQiVy5Ess20sQ
l4KU+qSPWYg1Wtpy1VaXMR9HLZN1P1gJgJUtNlQAtoSDYIWvnfk=
=sqXG
-----END PGP SIGNATURE-----

--bXiuNIlbNXCsKgPF--
