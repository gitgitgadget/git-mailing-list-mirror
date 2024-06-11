Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383617C7A2
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107128; cv=none; b=EdsyE7Ntx4PgghXffayQeyIYkoXnZWkIAKeqXhC7RHLU+IhMpLrTjYiuKHhvz6rNedksaWWO0NPQTL8JjPJSUWXCnpwFT+z3a4rmY5pnfr8VHBjPDLk2ZRmbl2GtRErvIHRpPoQjtpC3rJVcjW/4Wg/4y+h3hob9rT6ywdMEpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107128; c=relaxed/simple;
	bh=M989npf6UeL+gnkSnGxMWlZXkhQlQOKDVmOizU2AdpA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRTjBz+Ut0+5sUbW510doIvzejXyciH7K3wD0IsHyYE+E+FkrSSgjhRd6JIWi5HXGwiAiGztf6KfG41A1GoM+GRbRUYhPeqHPxVhE/gDXANJx0Mokz5b0/Qjb7WEFsdymqHQ9tSyIfvR7ppHZPtuwYKkRVayGZmzyUo1TNAAHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pLhsIBhS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bux4KBKz; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pLhsIBhS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bux4KBKz"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 351521C000AF
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 07:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107125; x=1718193525; bh=hHuV/DHRrH
	z0RoP/TeLu6yt82XT8EU5AtIbkNMnd6Ew=; b=pLhsIBhSXBVpRPYjC3xNbV9V5I
	vwGECmtjlZ3MYRrzEtEnJDqTIH+7HX2V+1nGUXFlWMJ5KxS6Ry80yvZi0OdpyxYU
	1JvP1ej3RGg8xWpda+U+w0zO4Wyq+SOPSNeyAvcgFrJTjawqHXFpTefK8ZulX03j
	0N7RBUOk1phLnsG6d0FtMLxkB3SJSjzFnH6e9obGdhDTreXDDjIwzbzoao2OjGFA
	9UJEK3aVAH/qGKt4q9qnpAxd4tqkOq1zfpl3eElzUNbBarBnAKueXgx405RcUI6v
	8STCvD1DogfnBwugJvEUGyxKIZOzcfyDT0smII76Jk5DArOnphAyUhPB8p6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107125; x=1718193525; bh=hHuV/DHRrHz0RoP/TeLu6yt82XT8
	EU5AtIbkNMnd6Ew=; b=bux4KBKz8hK5GDXHbn1YnbXV0fX5X3v/SvRcIGkLdpXM
	cIxzxRqGT/BZhvbxQl3VoneIR1GbkKJvMhKcA3C+A+jzg37wLiyi2WdLnVkCaMU7
	vuM5gP3KbT9bZE2x7Cotx69Lk6fkYZZrjdFg3vSGxZTiwwDVuRLcN7nLvqvSG945
	MsVyoPlvLS/Aqmj5t49Jp0Nc2dUxXmYWVSTq2y9/NNObhvmaW97LZkfhP4oPt3Pw
	AcxDlhceM0bPMclXMR/3wK0A3iI7vujBPCL8+WKrAhlDZt6OuiFSm0BtPdcfKzWW
	TjYDMUyUNTsQMyv0hOnvnN+Q2wCSApr6Iejc6tc02g==
X-ME-Sender: <xms:9TtoZsE77yXOSY96-ZF5YqSpZQzEvPTHU8uOv5hps4S7c_-1KruskA>
    <xme:9TtoZlXzbdJpkKdlktP5PcGcnVA6isEQOheC0s7vyNmC3fBRCDnID976n3fNUZyso
    9oeJ0_aSLj2F3bLBA>
X-ME-Received: <xmr:9TtoZmJRK2GDLJ6DbFn6MoywCRQE5mqj0Sj4WWZbDhqqrr2y-uaHQH2yn2LW-0Fn2oUUTkfQtA6sWPe18IbpFoUi1U_MkZ50TtX9Vv0SQP-grGzI2l3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:9TtoZuEey5GELAv_IIqhF9jTKCCHxkIyyJ12dVNlSqLqKCr-nnUf3A>
    <xmx:9TtoZiUQ6mIMi_b5COBMgjBrSJ7s4lAH05Q7dTUvwLmWjYuy33qm1w>
    <xmx:9TtoZhO6LOHrLzywq03C6xOnPQB5X23XckshS01ST3nG8Ap80XLSrA>
    <xmx:9TtoZp3dWYULLyhKR-Z8MkUuss2cDTluuuLgzG3746Jon0WxXRuS4w>
    <xmx:9TtoZlfFOEQnelfPngKBx7yr7NMwGbalQmtmjuOTnVgNGPqwXxXkKQKp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d1ca596f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:58:36 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:58:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/21] replace-object: use hash algorithm from passed-in
 repository
Message-ID: <ca5f4056fbdac83fb47ca4c51622e9e45ea2287d.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+LLs71o/YmFIDfX7"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--+LLs71o/YmFIDfX7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `register_replace_ref()`, we pass in a repository but then use
`get_oid_hex()` to parse passed-in object IDs, which implicitly uses
`the_repository`. Fix this by using the hash algorithm from the
passed-in repository instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replace-object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replace-object.c b/replace-object.c
index 73f5acbcd9..59252d565e 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -20,7 +20,7 @@ static int register_replace_ref(const char *refname,
 	const char *hash =3D slash ? slash + 1 : refname;
 	struct replace_object *repl_obj =3D xmalloc(sizeof(*repl_obj));
=20
-	if (get_oid_hex(hash, &repl_obj->original.oid)) {
+	if (get_oid_hex_algop(hash, &repl_obj->original.oid, r->hash_algo)) {
 		free(repl_obj);
 		warning(_("bad replace ref name: %s"), refname);
 		return 0;
--=20
2.45.2.436.gcd77e87115.dirty


--+LLs71o/YmFIDfX7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO/IACgkQVbJhu7ck
PpQ83g//SqBijAMO8eBmXfftuCM5T16Esf78dc4b6QhhItCEfLtLZJ0PUqIDao+D
aFgLbDEsRpJR8YOD5lJr3hha+a5FAbNu01Tl5EzsPr//c53YAc1sLAyoZLN4GPFn
h6vut44N6uvd2GvdGbm6YWKLhUVfYZAo9yVWTzSUYP3TxGbdZoW34XnnrTdN+Ku8
PStdo+j4mp+GAqjTcwuMmcb8YEs/XVcvNWRPZ7eAe5T1ZYbN5b3eZ09hOgiIriyr
NAiCuUmmZ4FtcFIX8dT6TAOl361zaB4c116c/z0J7bVaBkMDFR7TKRJ561T3PIbb
/jnlG4KcnFVKJmlFJO8Rm3BTEgdA8O4VEQFfnQY1JXbMPwsrxNiZGWXNkCJxrwwC
EeOm/kDT28BQIJZaKpuz8pGxrDDD1JFrCAg0lD3YK2NvoVEJnR0FyKFMhS1dO40O
1DmtSs+xbPs4s0YNgtU//slR/AUQn5yOhPKoRcNxlrHBHbK93LCSTCzaHVvRqzQU
eNKgmHpkMy7/rzcf5OblLzUIYE26d0GUBSp1Sw0YPtQjromQBZimSfJR7TIlCldT
SVCTvmNpvgnv+znvlrfS1QfD7/oFHEXXnZfffMBzYdzuhlWGHVWIvMdrQMAvPX1g
qVGCIc0dZRgzzIcLfjsAPwyIE8ziE+OG/U1BB5oHmoPLtWLdDzI=
=1ItW
-----END PGP SIGNATURE-----

--+LLs71o/YmFIDfX7--
