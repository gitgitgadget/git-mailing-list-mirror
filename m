Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594527C08E
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520318; cv=none; b=p2FbEbBqrTtGLAE21RZ4obmzRpiRGSxHMuzW86783TgsCwJF5o3pdg8yv0peBnOtPjmBl0KPzgfwik67dMsmIb2w6JpuA7h1MuZhHFsRt/W5JO2vT9c0Ufg2uOes/1dUhGvot3/sn9x/Q8orYZ+jekVx1dc+Q5S2bcxNtTKEbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520318; c=relaxed/simple;
	bh=BomxAql219KiCcUf2UPYs0hdooTVxeLtzqX3+SWqnbE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5HinQIng6XBYF3RBYn7UjFe6x+IWbDbKZHndjURAl223VG21oFdkwP0g3mLBkZp1lXttHcQHyFGMDrQMFTVcqKAlX6nDIlDcXfrII3nsd6abHPA//fL6ONFAsBJ1cKYd+vsTPdvSh9RSVQ2Ik0ZljY0E8VrY2wVupYti5IfU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nhC5G2FR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bW5vjXww; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nhC5G2FR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bW5vjXww"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 70D2418000A7
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 19 Apr 2024 05:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713520315; x=1713606715; bh=6vpZf8ZGqW
	Koa+XaQL0ADDhbgXDCtyX06uA3fpwJzlg=; b=nhC5G2FRlxDOllkkVU9vWsU8wN
	Pxnw85NBzuEnVOFcqRPXi1vVMNL5wj2X31Obsk1B0SsLioC3zNFqPQxhc32RJBTc
	2fwrKA4OT3oWJCbSvQ2ZAeBf9bka/F4nyHtyVLzcQ/gUGOqW/6N5jp6EdroFq4f1
	+9/YL6e1fA+IX9pn9q5uQYzWDF8y6tXWGCcemHlE+9kxxps2NLgede55rOZ8kMDN
	4cqnLe8fnBP38AX58Rdh2o844QB5FhBk8TgduOoBVLIZZ8pTVVeNh86eh46ZUwtJ
	lOl3288wmvQDDErtA/flqinAHL2AySe/VL2SrvqPTPjj+u0HrQt0rFc/+mGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713520315; x=1713606715; bh=6vpZf8ZGqWKoa+XaQL0ADDhbgXDC
	tyX06uA3fpwJzlg=; b=bW5vjXwwDLIJeJ/uUqLRlY4E/EMSvJ9nw85CCAwcj5XV
	6Gc3oN/M70vKqj+x64D1KxcETeGlKv7FBCa9bD4FjPS9z9tACL+Xw58XdYphTIx7
	E52f0RI3ew0igpn8SroNa5gM8jVLAw8g6C1CncNSCnAFbaYhs4+box03CbnaPEWx
	UrYjMv9k2192YSR67Vh0VhSLrEPox8rr7JYO8okS7K+Vu14s3ESwbQGmmz3nNUQy
	9TWt0qE9FwnEm+L5o9O/Wvx9swcJ4azdfhcRovFHAX5O4515K9YnKyxhYH16xutc
	7oouio4shbk5o68Uq834NcaZsPIBULqYdxKXKLC/1g==
X-ME-Sender: <xms:uz4iZm2p6j94_UzX_BxZjxGOJ6SlMXRwZcIEW8OaIzSzO_sFxXmS0Q>
    <xme:uz4iZpEtlAkdq7kQ7A4x5aS4fR34stVvltA1LI2qdA_H-dck0YRIbFEHa0QC7yRNG
    a6ClOtiVs5LIiLLKQ>
X-ME-Received: <xmr:uz4iZu4EFOx0KAL6NFmKrDmXrfPowjm39afkZNrL_QpB3bInXrzMBjp7kyMor2Ded6dEtV4dxb2aOOQEkS7kW-k6FkGgwncAuKLVe0BSn0oFI1MU7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:uz4iZn1ZP7V9-hIz1LVA4Rm7YXw0ArnKT9ypd_q-sqhmbFENlF-amg>
    <xmx:uz4iZpEs3zfJFu3gzhFpvcQMUN6oFaMrUaEMUHGYU55YIgIhDtkwXg>
    <xmx:uz4iZg_coqC8f3ndFmuXMX4yqOQ3n1-Ue_sTWxSUTjPZF5XDC41Fuw>
    <xmx:uz4iZum9fgnEC_hMuKusRiQFIXBntJ3UNQb_XwYpX2EjcjTV4p8asA>
    <xmx:uz4iZnM3J2N2xTK1zWIJyUwMRM_JTjWSubHbjECee9QhGfFw87V2qzCs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 124f7516 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:51:28 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/11] builtin/shortlog: don't set up revisions without repo
Message-ID: <508e28ed1e21e9c646cec8473a65137d33f1df23.1713519789.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bCIRHhOal3+A/18e"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--bCIRHhOal3+A/18e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is possible to run git-shortlog(1) outside of a repository by passing
it output from git-log(1) via standard input. Obviously, as there is no
repository in that context, it is thus unsupported to pass any revisions
as arguments.

Reghardless of that we still end up calling `setup_revisions()`. While
that works alright, it is somewhat strange. Furthermore, this is about
to cause problems when we unset the default object hash.

Refactor the code to only call `setup_revisions()` when we have a
repository. This is safe to do as we already verify that there are no
arguments when running outside of a repository anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/shortlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3c7cd2d6ef..d4daf31e22 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -435,7 +435,7 @@ int cmd_shortlog(int argc, const char **argv, const cha=
r *prefix)
 		usage_with_options(shortlog_usage, options);
 	}
=20
-	if (setup_revisions(argc, argv, &rev, NULL) !=3D 1) {
+	if (!nongit && setup_revisions(argc, argv, &rev, NULL) !=3D 1) {
 		error(_("unrecognized argument: %s"), argv[1]);
 		usage_with_options(shortlog_usage, options);
 	}
--=20
2.44.GIT


--bCIRHhOal3+A/18e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPrgACgkQVbJhu7ck
PpSUEQ//XZcaMW9OC9KM9GtpL9tnJy520YvIPaUW07Ps7n8Dv1/J/TZOFdhF4k1i
CTx2ZU+yrbpCPyMTEKJXsUOSH0tDgmTtJlkmUKPcxPX1PBYGYLl77NVflqkDe0Rm
h1yhtJfxD+XEI/fCjcNBKgv6nqXokt7Ip9PCYAa/jW9M13bnIOgQWVqeW46yNCzc
nES/DO8z1v02f/HlT+KNUOLKceKyvkE93gqIMA9X0WrZdX2h4Trjy4Kq/FSSrVFY
13EclfLfsLZutEipe8GVWsYC2SJ3wckBlW64X96Y7gQMuZvejMayWdO1vkfRfDih
DbfcNlirxer7S6vIOzqH5n0G+PStp8ANY8g2e8Idzdt4eW63C6CQcXGxwpNBypnI
md5dNG4UIDY5hHKuY6jH8U53+3cukMsMTkQpXTga6vTxOvaSFsBPptLGWgAPvxpb
eD8rwfx8Y/EXC4/Kr0Uvhv6dpLhK2MRiEmRfJiWmtonZRpebxTZOp0pCIPNVcFjo
pseeTJy2VUy9jyGDZn7tcgdV3xx3OdfIoqTCh9s6vjopjSeEz9rxprQKBHAtzXbz
/rgRbEagOpkCfjXM0S74r6RsXdxKUTqXtUI+/oBb5IjaPpj0IToBkGdBijnQSwdL
xRGZ2Uybs0FTIwS7Wuu6kqkJbJqu11t7D+kdqilU6nExPp/LRkI=
=D/Ck
-----END PGP SIGNATURE-----

--bCIRHhOal3+A/18e--
