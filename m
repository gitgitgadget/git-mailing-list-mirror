Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68B1EB39
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578629; cv=none; b=Vua8o001u0rk+xGhVF6KIm1Ss/xhnpDTNATFaGvD8fZenyUPbZOwg7EUH3ni9Avy6O0O7pz5Ey60nVX5MRFL7ngfVQsXUFTc67NCy9VTYX22WihlQpw45fT+EXDiI2SiqLTAJlpplqKpLBfnnY2ubD6ae13CyqYQGTYoQ4z/Qsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578629; c=relaxed/simple;
	bh=r2uKbPDbZBw6e13hvfMb2qXCcMsdh/ftFIkxDUrQUy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW9c2Y+I14QLWSFvgo7NDs7Lp9/NwaUGS/fS1PnIG+Wa8Ua8gSgDlSA6PoU+mPPy0y+EYGRl+IiF3uephIPf90gG1NdIdSy1/n9gI1vnwhDN5VrljUNhRD3csMGdMMSvy0/FZGeRRWEyIPoLx3CvNlU1oaKylpXlL2O1DoMeH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A0OKx6Hi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=njG0pJ4p; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A0OKx6Hi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="njG0pJ4p"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0B65F13800BC;
	Mon,  8 Apr 2024 08:16:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 08 Apr 2024 08:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712578618; x=1712665018; bh=/Q08PZGlQu
	Znk3wJICWdNzvnFyAcIJu196rXv+KL7F0=; b=A0OKx6Hi6RjqJE97vaKXK8NSaD
	isD8Yp2wf2pGhRV5ObBgkQBQ0mxdb8EpYfZuoGZRaglRWh1mCMWZDHNSx6dZp6fu
	kQI2NnDLxKNEe81Xnod1psOixq01LrBwVt2LrDDPu1L4KTbKZ4ZFz5tpopue+y2t
	MATmxpBtbLll6G6kXS/i8+WlAo8uDGC0vueW5Ec0L6yZ5TZfXfYqB2SXIs9N4fXI
	RGulZcDm1VRiwKBpd/MQT8gbHTj1sHxnbfY/bqCFPp77wWg3CrKI1zKFtyeH1671
	Ukat0rA6n2VApU7HoEiNkXVIp+JzWUsiXmCQ9Oq83a0zWYTs0/Ym5CB8OzJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712578618; x=1712665018; bh=/Q08PZGlQuZnk3wJICWdNzvnFyAc
	IJu196rXv+KL7F0=; b=njG0pJ4pt68nzhFCqPJtv7EjwZQb4j0H9CWMfekctVQb
	If5oyYNcwtFAYHhbP6Ofe5GjADSbKZ5PKLXseC6n+SrAzrnF9ak7NWBlqejFtvj+
	m8zKPvubTPs2DORmdQJaECwqBwL0ZW7Oh5qzczTLvL8p6epuZwIWFNeAOPQBMTv0
	dhpb/2dpDFmJXbxoPeLLH+Jo4FiltAQMzyuh7iJfGmw4K+oYvKZ5H8XEUVJ9Juex
	ZkubkjQLp/C5/KG8TKtuXWZqeuoqnj29ah0Q4k+1CuGMK1fleHaDujl+xa9YhveI
	Bjs+rLQicIj4KnQ69kyT94miokqnGTZL3z+H5ykQSw==
X-ME-Sender: <xms:OeATZv6_Cnk1TRGCb9GsmiP4FGGztticAhOw2z3nJWkVM952d3ptqw>
    <xme:OeATZk4PMLyFfxuGrafXUVxLth6ib5mG-gWJs7Pk2CPfyhdyrSZ_Xjy2z0QFdE7td
    ZuDby052-1ignLQwA>
X-ME-Received: <xmr:OeATZmfwfgVdaDKjMK8jH9pQ5JOdXfipJwx0rx6f18vbZqkGdgKScI6X8Wq9dgDX35AthrZ1nCgTbZy65ZgcACgPGa0PBs8exCABAm5I0VXo0L2beQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:OeATZgJS4JgJ2Q5HtH1xcBHeTMVAf_SCIjxM1j_pkE82mW35RBlc1g>
    <xmx:OeATZjJ7TDO7eOyjgUYi4y4wsVvaOSMOFwCxavqZsiTrBmHSvE9GZA>
    <xmx:OeATZpz8Pf0vTl-7mYdld5L7TBYGC_DLPP_GY9ybzaORugdqT-vZ_Q>
    <xmx:OeATZvJHxh6An5vaH3M0VFaGtBk0gmUWHakPkwLV-xIVgjSr4Askaw>
    <xmx:OuATZgEjKifvrmgzXxoyik35lNL8pzV_3KiNA6D0YpFKj1GmjYJIYPx1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:16:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id faeb18ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:16:51 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:16:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 07/10] reftable/block: reuse uncompressed blocks
Message-ID: <a7906a3383841fbdc6f4b1ebd82ea1422f99ae85.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FJu6ndyDQBeIEHrp"
Content-Disposition: inline
In-Reply-To: <cover.1712578376.git.ps@pks.im>


--FJu6ndyDQBeIEHrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable backend stores reflog entries in a compressed format and
thus needs to uncompress blocks before one can read records from it.
For each reflog block we thus have to allocate an array that we can
decompress the block contents into. This block is being discarded
whenever the table iterator moves to the next block. Consequently, we
reallocate a new array on every block, which is quite wasteful.

Refactor the code to reuse the uncompressed block data when moving the
block reader to a new block. This significantly reduces the number of
allocations when iterating through many compressed blocks. The following
measurements are done with `git reflog list` when listing 100k reflogs.
Before:

  HEAP SUMMARY:
      in use at exit: 13,473 bytes in 122 blocks
    total heap usage: 45,755 allocs, 45,633 frees, 254,779,456 bytes alloca=
ted

After:

  HEAP SUMMARY:
      in use at exit: 13,473 bytes in 122 blocks
    total heap usage: 23,028 allocs, 22,906 frees, 162,813,547 bytes alloca=
ted

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  | 14 ++++++--------
 reftable/block.h  |  4 ++++
 reftable/reader.c | 27 ++++++++++++++++-----------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 0c4e71eae3..9460273290 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -186,7 +186,6 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
 	uint16_t restart_count =3D 0;
 	uint32_t restart_start =3D 0;
 	uint8_t *restart_bytes =3D NULL;
-	uint8_t *uncompressed =3D NULL;
=20
 	reftable_block_done(&br->block);
=20
@@ -202,14 +201,15 @@ int block_reader_init(struct block_reader *br, struct=
 reftable_block *block,
 		uLongf src_len =3D block->len - block_header_skip;
=20
 		/* Log blocks specify the *uncompressed* size in their header. */
-		REFTABLE_ALLOC_ARRAY(uncompressed, sz);
+		REFTABLE_ALLOC_GROW(br->uncompressed_data, sz,
+				    br->uncompressed_cap);
=20
 		/* Copy over the block header verbatim. It's not compressed. */
-		memcpy(uncompressed, block->data, block_header_skip);
+		memcpy(br->uncompressed_data, block->data, block_header_skip);
=20
 		/* Uncompress */
 		if (Z_OK !=3D
-		    uncompress2(uncompressed + block_header_skip, &dst_len,
+		    uncompress2(br->uncompressed_data + block_header_skip, &dst_len,
 				block->data + block_header_skip, &src_len)) {
 			err =3D REFTABLE_ZLIB_ERROR;
 			goto done;
@@ -222,10 +222,8 @@ int block_reader_init(struct block_reader *br, struct =
reftable_block *block,
=20
 		/* We're done with the input data. */
 		reftable_block_done(block);
-		block->data =3D uncompressed;
-		uncompressed =3D NULL;
+		block->data =3D br->uncompressed_data;
 		block->len =3D sz;
-		block->source =3D malloc_block_source();
 		full_block_size =3D src_len + block_header_skip;
 	} else if (full_block_size =3D=3D 0) {
 		full_block_size =3D sz;
@@ -254,12 +252,12 @@ int block_reader_init(struct block_reader *br, struct=
 reftable_block *block,
 	br->restart_bytes =3D restart_bytes;
=20
 done:
-	reftable_free(uncompressed);
 	return err;
 }
=20
 void block_reader_release(struct block_reader *br)
 {
+	reftable_free(br->uncompressed_data);
 	reftable_block_done(&br->block);
 }
=20
diff --git a/reftable/block.h b/reftable/block.h
index d733d45ee0..12414eb642 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -66,6 +66,10 @@ struct block_reader {
 	struct reftable_block block;
 	int hash_size;
=20
+	/* Uncompressed data for log entries. */
+	unsigned char *uncompressed_data;
+	size_t uncompressed_cap;
+
 	/* size of the data, excluding restart data. */
 	uint32_t block_len;
 	uint8_t *restart_bytes;
diff --git a/reftable/reader.c b/reftable/reader.c
index dd4de294a1..aacd5f1337 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -459,6 +459,8 @@ static int reader_seek_linear(struct table_iter *ti,
 		 * we would not do a linear search there anymore.
 		 */
 		memset(&next.br.block, 0, sizeof(next.br.block));
+		next.br.uncompressed_data =3D NULL;
+		next.br.uncompressed_cap =3D 0;
=20
 		err =3D table_iter_next_block(&next);
 		if (err < 0)
@@ -599,25 +601,28 @@ static int reader_seek_internal(struct reftable_reade=
r *r,
 	struct reftable_reader_offsets *offs =3D
 		reader_offsets_for(r, reftable_record_type(rec));
 	uint64_t idx =3D offs->index_offset;
-	struct table_iter ti =3D TABLE_ITER_INIT;
-	int err =3D 0;
+	struct table_iter ti =3D TABLE_ITER_INIT, *p;
+	int err;
+
 	if (idx > 0)
 		return reader_seek_indexed(r, it, rec);
=20
 	err =3D reader_start(r, &ti, reftable_record_type(rec), 0);
 	if (err < 0)
-		return err;
+		goto out;
+
 	err =3D reader_seek_linear(&ti, rec);
 	if (err < 0)
-		return err;
-	else {
-		struct table_iter *p =3D
-			reftable_malloc(sizeof(struct table_iter));
-		*p =3D ti;
-		iterator_from_table_iter(it, p);
-	}
+		goto out;
=20
-	return 0;
+	REFTABLE_ALLOC_ARRAY(p, 1);
+	*p =3D ti;
+	iterator_from_table_iter(it, p);
+
+out:
+	if (err)
+		table_iter_close(&ti);
+	return err;
 }
=20
 static int reader_seek(struct reftable_reader *r, struct reftable_iterator=
 *it,
--=20
2.44.GIT


--FJu6ndyDQBeIEHrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4DUACgkQVbJhu7ck
PpSzDQ//dKi3FInLdyvNXKm+yGynjn7okLfOc7hkfP6U+oKI4p3O67Z5uG34rORy
n9BTO5nVPXz7gjpVlSAeN63WGo/dhd/hsaLK+u+WgNfR3Kf50MfoWgl1fnkQbEMR
cVI75Qsm7x/TZmYpROEcvY9etqJDtIu1n1gske5FEIvx6CkdbOmlHrIcccQ1wOQv
O5OuZZ308wKfpIJ/CNXFoHNrHCi1uDDr0GlMZ5R30bS1S0yjAnDKZMqvT8fANMGT
D00E/ndUWI2SfQcAsoD4payjF5Hnb0XnCsLXK1aOqi+x4IMe7KyuBIOC1HGW6oLE
ASXpzOjG+RA1P58r6WX1NE1Fut03BhWYlEpvRG6yfVSCP7u1Y0fuzY1VPuDDKkkh
M5+LB9+3v1uHT95uvdjfmC0bWLTU1TXRaVfv8vYYOiN+eq2OpCs4yRWNlsbOl4Wq
goz7XXl1UdXFEVi6uIl2/4f7tkvQxJD3ugx2PiGIMNboobrJQj1KRA7EqUyqHB5b
4ea5K0CuOedPXJtN0WxuSFBCatXRlo8U7JWLVqxVjtn21M6uZahutPMlCnU8uDd6
Nwlw3H4lcTvWrt3oGKcPs+ujaqWH1BeqHm582vJOPD7vDzN2OeJJqh+BeCdrazLm
ZJoN+GwZpDpO2xEi9teEicRt6SEQSKtRCrQWnbUJf7dNMPge5Fg=
=vJZo
-----END PGP SIGNATURE-----

--FJu6ndyDQBeIEHrp--
