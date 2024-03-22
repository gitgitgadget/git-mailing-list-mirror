Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA9405DF
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110180; cv=none; b=XNjbuDYE822pBIaiCL6DjflC8BqeD/qwvhKj0FaPmDHsWcJvo3Ood3Ifrap6gL6zACJN6KSi08UjOXjc2NC0P1jFw49P54vHHyneBhAE9UkBo9jhs2euG+cezwwVALlXb3kuhZXZwtlUgk5z8vYKhI8vbIhgTjfxhQTN7AQWtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110180; c=relaxed/simple;
	bh=OuEX5uuBA4g6PW9rT9RCPgdHwen7vBOvN2wtbwB5nnc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShfU3uPDtSBthjdN6spBw/pLzIwDm4qZz6Z8qadTdDf2imTf9dHqbsNqKkmWOVsGiom1tA5TCaWYQj2N6rjOMhGNy/8yZNCso2VxuJ5IyMbkb2pcFbAHKhL7jjihtXQufl61IzVQkd1dy+yNWoVSikv6Cgh9f46ZNIz700sN1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bP6AeK8D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h+kr3DH8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bP6AeK8D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h+kr3DH8"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0DBE513800F7
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 22 Mar 2024 08:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711110178; x=1711196578; bh=CkLybLgvrV
	3KAxVbHMFiO58uv0nvmM4UwXESGs7FeMo=; b=bP6AeK8DwgUP72e1WUX5t8Dd2z
	yTdfa0sWEXn6EdPd1xevxxeMU3sHsAio/hNYj5lEyRupB0WMtorgr/vSytLnF65N
	i1lkklrEu/shM+XB56zrZsa2GvaIVYmVVgL9QwqiCNWeN5FrvV6GFIimyujq7sYa
	7S/6IYYFSu2RL/nBx1vfJs0/3vYg7aOop7CaYHRGGTkj5WuP3u25oWQ/myarHOjW
	DfltosVx12zo2fWrLwcGsZkOE2hfs4ewW5HZ8f/a93zV93L5MKJ0LH0btnNpgGcs
	yf/ywxNu0hB2VY4Pv4iuloM/zh8vUSp5ebld3p9kvp8W46Rs8I2sssp9CF0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711110178; x=1711196578; bh=CkLybLgvrV3KAxVbHMFiO58uv0nv
	mM4UwXESGs7FeMo=; b=h+kr3DH8fGA82zKF1LUxrPQfMphyLa64o1XhNT7npvKA
	STkWvj8CFUpzx0AED3Hg1xRjNyDkR8Vg3/C2rRILmJB35yyFOKWEJv7FL/DDBVIt
	np0OhK8LnIDaJL17N32W6tqZqms6UW+DK2h+zozDkPQjx/0B0quJe1VZx/zTmuqe
	LKdZVGOiiuJfRV39z1DQ6wCZq1e5jTr4GL8xUC9ktkisVSlsrkOtVEaIJ5iR2Qpz
	1amlrJOlo3tNibajgFoeDdaj8Eb6qQhtvw4UQp7+VakhY+YsrKg/m6ls8guLAPOi
	AaxeDcn2+mTKUejR+H15x/UWKMezM8NO/nVOcMWb9Q==
X-ME-Sender: <xms:IXj9Zbl7Kr5wp_90qNR9UeNF6uq52MFHNVQ3DL-f05pS0Pujt5YayA>
    <xme:IXj9Ze3_wOcYudUSSt8LLCkf0WbJcCAHWg4vwZhwOzAYYsE89jvMUIppBssWh_KEl
    4uHGfNY64Vhk5fF_Q>
X-ME-Received: <xmr:IXj9ZRo--H78qK7f97W5rG79OqhCvDS4r6TmcV80l9QE1pxUMWF554eo3d2opMZPGHOkm9R4FQDBy4lUi0MhKB6BUMs1LtfWjp3qbgGWzY29HYBwRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IXj9ZTk5WSimXAKXYCoc_DxL0XtJXG5iymuEypRG4RZVygjnvJ7RSg>
    <xmx:IXj9ZZ1XNsIKf7pENZQ46nMF2I4EKWm2e7nzS-gmsHX8x0Ahbhynyw>
    <xmx:IXj9ZSv4fO9vvgHppQEjOP1AYVRhbRCZvw8ZbXJo3zhvOSctsA980A>
    <xmx:IXj9ZdXdbcNShP1IfnLZU6TFauxnp6-yGEEPm33h1vqRSK6J__6X6A>
    <xmx:Inj9ZXDb57LxUJZG93hXS-5w30KT-gt84kHC_bvQYUVm4ZbFG7bYpA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27ef84ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 22 Mar 2024 12:22:52 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:22:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/7] reftable/block: avoid decoding keys when searching
 restart points
Message-ID: <f716400686ab9f04f5dee48ce2b90cfc5f07124e.1711109214.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8E/0xrv/EjZz1bZm"
Content-Disposition: inline
In-Reply-To: <cover.1711109214.git.ps@pks.im>


--8E/0xrv/EjZz1bZm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When searching over restart points in a block we decode the key of each
of the records, which results in a memory allocation. This is quite
pointless though given that records it restart points will never use
prefix compression and thus store their keys verbatim in the block.

Refactor the code so that we can avoid decoding the keys, which saves us
some allocations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index ca80a05e21..8bb4e43cec 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -287,23 +287,32 @@ static int restart_needle_less(size_t idx, void *_arg=
s)
 		.buf =3D args->reader->block.data + off,
 		.len =3D args->reader->block_len - off,
 	};
-	struct strbuf kth_restart_key =3D STRBUF_INIT;
-	uint8_t unused_extra;
-	int result, n;
+	uint64_t prefix_len, suffix_len;
+	uint8_t extra;
+	int n;
=20
 	/*
-	 * TODO: The restart key is verbatim in the block, so we can in theory
-	 * avoid decoding the key and thus save some allocations.
+	 * Records at restart points are stored without prefix compression, so
+	 * there is no need to fully decode the record key here. This removes
+	 * the need for allocating memory.
 	 */
-	n =3D reftable_decode_key(&kth_restart_key, &unused_extra, in);
-	if (n < 0) {
+	n =3D reftable_decode_keylen(in, &prefix_len, &suffix_len, &extra);
+	if (n < 0 || prefix_len) {
 		args->error =3D 1;
 		return -1;
 	}
=20
-	result =3D strbuf_cmp(&args->needle, &kth_restart_key);
-	strbuf_release(&kth_restart_key);
-	return result < 0;
+	string_view_consume(&in, n);
+	if (suffix_len > in.len) {
+		args->error =3D 1;
+		return -1;
+	}
+
+	n =3D memcmp(args->needle.buf, in.buf,
+		   args->needle.len < suffix_len ? args->needle.len : suffix_len);
+	if (n)
+		return n < 0;
+	return args->needle.len < suffix_len;
 }
=20
 void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
--=20
2.44.0


--8E/0xrv/EjZz1bZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX9eB4ACgkQVbJhu7ck
PpQpNQ/9HXJpV39qbr0wr8MFssMdG1KJ5mKH4APSzpK42QWcXgeu21f0e4+vM2rA
KYxJ6AETwFNm4edh0cjY1SKITM1enaCHtALnGJuQSfXYvNsTAumAqbi5p5+pXXav
+TnfjrZ/lpcyM1by85w04DANku3sL7PEyVG6MEmmCDW7RXm++z6hwpQoksrJ4oPF
GEw0tS8PtJZiXZ5LVEsql5qPRcpEJ10/4dJ59bZyfc1lks4fF+tDiRNL5264HE+R
bXohu/N6oD4VvlY/k1vSOAR4lH0EqOcpbK7Hs+kw9MYhj6arvuEcPUzBmAcsWrBV
07TKDfILJWicNora1cymN1VjuKjg7vc36qdClHM2t8Y/Q5rbUp0PRCqmaOpbrfRR
Nmb0LPJmHI4RgUI/i5jUoj4Rdo41TLWihuCuU/JqFCYMNvpxu7Br/n/JVk0oPEo8
IzmIINPZB1KsxOv/5W1gyO4fbLSZEzDsQ23SU6psOFrQPAquBBIr7GLuMX2QRKhy
a2zo2qJ/USRtKiS+9SmPXl9ugbY8ibvMbZ730hzimBBhy7ok/Sh44EuTGyfAX5if
6Z25ZTMbbla09s6KVJihshYEzVQhN/J3cOmkoV6KR0qY9uygMe/ExC470suwRf3x
QwwBYBQUMKPc+KNiYtpLOd1T6bOniO/vgsFyXT602TjScA9qALc=
=pAMf
-----END PGP SIGNATURE-----

--8E/0xrv/EjZz1bZm--
