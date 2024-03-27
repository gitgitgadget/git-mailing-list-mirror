Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E7250F8
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521446; cv=none; b=ck/b7kOVsIBTH3x4DI7AZ9e1E6/i8R0KLbx4Thp1sUloF84xPLY12NVD3QUqCxRYFjKTo0yWUNgJpQjkuwDyiBuSiRZEQJlveHhhxitOIQlaJe4wRzNAXqG1Cz4sIOsnoCYk4F0RmwfLnqBaU/Cm2asK+GP8ZEzYB0cCSGUNkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521446; c=relaxed/simple;
	bh=X/1OSAXOeQnNV/wy1DfuipmrJtc4Gy+YZB9Q9AY9yUk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjbeU4Hc7eu9OYKza/8qTVDwqD8yYRpdooCVtO2xe7elajv++8CUOGp3urfMUXHMZWoH3V8Fn/PvCf7FjrHD2BXCg1c8dOACfauUC5LZZOkxibParaIhQX+cniCysUO3zmSpK9TpfJPSvFde/RbIgA3jkjYoDWPd8Jj38Gncp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TBF2CPmX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IL6a3rn2; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TBF2CPmX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IL6a3rn2"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0901B1140172
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 02:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711521444; x=1711607844; bh=RCTVIIYGUU
	Q8zQVTrRwj73o+IAWx8OrMDEJcS0/VMXA=; b=TBF2CPmXCBdN2NTXkOePqUzc7V
	1BwBZMwCDA/mKXmEBV9mAX3FT7Vp4Q2aFx1n/FnabWqvM8GAgMvhIvquAe7PSV9Y
	IYy0aaOjWuv4VRhDcuEAN/jSK1hwcG8Xn29TKj3LloPJG6sD20WLOiasYQF4kUgs
	helTFgnbJKGwufD5tp6kx6HTb3eo52d8D9o0tIvvFh0rgG34xBkQHgImemttVSiA
	5zqq4DrA8j7tnWWsIAxkqByMCa98YXgIKq70jXhmpHnOlNuP0cWyNwdcPT0dPJZG
	tsdDUBI/gQu/jIfVx0ERhfKyHKV1KgAAJTxVeLDtHj1rJceRL1IvfRGqWG3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711521444; x=1711607844; bh=RCTVIIYGUUQ8zQVTrRwj73o+IAWx
	8OrMDEJcS0/VMXA=; b=IL6a3rn2cw5W4Ab8GGdN2iWknI7D3V2Zl86InlPLXRHV
	hgO/FStmv8Fl23tKe1gWjVYQMcvXI15oZkY6G1IpNc69NI0FHD9ND5Ix9Mk/uXrw
	AMbSjH12iMpm0Y/GjZtilbe/XXaH1lfxg9V+pUxlgOFCXiDTbbAuYlYNW5JiBhrk
	gxU+w5aVwUXNgfg096V7ETwb+9FCYsnp+5744/JUOXefIzwR2icr1ZxdgcC2a8bL
	dRGZ4Edcnbn0Q5xS/1YaSuKaMlDYNxZ8d9GYELlUiO04sVjl4ZeydwnEFpPYf0TJ
	QNNcaHkaN7P3LRVnTOu2aDm4OHrt7CrGKht6eSoUDw==
X-ME-Sender: <xms:o74DZvYEEpzDZQBiwW2tHEh19TI97HQX3a9Dlq-ez_wFtPFUFKglpg>
    <xme:o74DZuY839K-HDkt9bjTQ2jK8DXTUMJqrFHXzxaPemHECZPukXItYdg01XIIFM-Cq
    w1J-Jyo6tvdy0cYbA>
X-ME-Received: <xmr:o74DZh_qK-nLoh_PkbmKt9hQk9tuB5FvZYaKVX-sYZT1KXo5RUWJTLBWvTqIII81VtlJ3186WfqQn0xu0pdC-7QpSXRnlv-q3f983modkmdorA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:o74DZlr1gbdC0cHju1VaPHP1CB5pU4vyvPE1DiDCTSJDpxeVUd45vA>
    <xmx:o74DZqoXAFyyrgKO3YpPMvf1gJBKPyjHgpHn-sVq0zy_QqgZpaWMbw>
    <xmx:o74DZrRr6_438mBAX5dM7UM30D5XJC0ddkNHFTQnYqrYuAlSWQCLig>
    <xmx:o74DZioljuEXashE_YHZhGtqz31Zj6R-q4tPeQVn8GgTa2ikN_vDLQ>
    <xmx:pL4DZh2wEqmhYfKlE6jZPyGkxaUfBPUW6GO3hSgf-TxNip8vUbCRpA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf16485e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 27 Mar 2024 06:37:10 +0000 (UTC)
Date: Wed, 27 Mar 2024 07:37:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/9] reftable/block: reuse uncompressed blocks
Message-ID: <1e4eba7e9b6b706b30eb5748156ce991ecb4ae37.1711519925.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="slYgi1aNeXiyOTtZ"
Content-Disposition: inline
In-Reply-To: <cover.1711519925.git.ps@pks.im>


--slYgi1aNeXiyOTtZ
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
index 471ebd8580..31af075c1d 100644
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
index b41efa5042..79275d67f1 100644
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


--slYgi1aNeXiyOTtZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDvqAACgkQVbJhu7ck
PpTHKhAAgvjcQQeefsscX1az52WV5axvaX0nDVgIX/mRjRefyyv9W5FSs/86hmaM
qC6/KwusFTUGxfeSt3WmCU/gUyoToncOQJROnsN5zs13h1r7J5v567+VYZox0rLA
KiJl3Aw3aND150BtbMZv7d+iKveFYisg7YIKA8q6bSo3s0vg9VORfqqQnLC15WwJ
5d8UjqtS48f9+6t7vsukBR0sayevV9JdUjSF+HhOc86r5ov1ci5OekjPvzpQb3oz
XgpRSmwN7eyh18IAICYrSHCCQwkG4Wc2PJtM44JgtH7bCKwDyE6KkmZY4eOygbP/
t+5v0nwGKQ5njdR9/Ph6b7cnVev6s3wY/RT9JcPKSmjOPbiq9/AVLjrdaQYwaaSd
magEwNEV3uVqlJaJAQH9Z2BQ20lYwLPLA3AFmOAdMNHTOOXxGQZX77NI16oY19du
Bg4uuLs6eJQjL3rmZbivXm436moMrwSUb3C6pnOkw9AGv6r4Ap7rRHnpP0SKJtDj
5aIu3f4VlRqK9H9vYTb6jdYoULhOU7toxDSpzoM7o3ozb7ynqWvFKsnm4U3AAoSF
I1EPlJCDvgD+5SsmEExM5bULKo/myLfNvVyJ+5gYFOfZGo8OUCO27ky9Nw97jVom
RoVK1PPXksK4VKz3VqB4oCnhsW6N2fiBDduKFoU5cWo3m432ItM=
=JXYX
-----END PGP SIGNATURE-----

--slYgi1aNeXiyOTtZ--
