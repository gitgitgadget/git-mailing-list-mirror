Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914A6E61E
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578638; cv=none; b=rgDgCtf1vF/kehwB2LJWZAEwJaFgZ1hKXS/7v6GHQ2gC7xpejhyTeHQ+3vQmCbCH3vIfScxnHnoL81O9oeDBpz8Kv5npiaz9pItHvKV5ekPG3WvGtRAJmChbbC2XGUca1FjB2CHQUT4kZoBk/aNwQT+yDziE1EqMzmoVdN+uVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578638; c=relaxed/simple;
	bh=ImNBMPFLQf8y3OfW+NCLr717VJ2AFGbDeNQQpwFiSnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooTd1mNZ+5s8coOxcNmW6PgS7ZTicAQjIa1tdv6m9pUfH7s3XISpVxKZ68U+RXVSpiTMkWA/6ZCqmxF66gcPyTGJba0qLhXBsXeLp8PpeALmx+TKi5orcBoOnHWPP141v6zGCt+bjTsZe1Tggn2LUjo+54+Afrvj47ZKPJhDpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KNx5sHmf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rcvnEKRP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KNx5sHmf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rcvnEKRP"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id A692413800FB;
	Mon,  8 Apr 2024 08:17:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 08:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712578627; x=1712665027; bh=1Vi5Jga9Pn
	UJOTCViUQmQae+eorRDZowKA43a11mwhY=; b=KNx5sHmfz5qgERdehOpDd9bNG3
	Eq+e/Tq5K9EpRsQUQUynpPn8yQuINSXxuAQcBZmamLSplDddMZNJ0vCRf4GxfFlf
	lvcfXkzNimxWUt18Ni2nScg6UfkYmXJlEJuto8+aZ32AIvFrhENCW+snbzYZFRd9
	xqsJtDAbu4OskLcpqDbyFItv/eSAM9owmFDVNmIbYzpvSHizx0khXjPul5kcrRJ7
	Ov0VNZ0Hzaw2zLyLe64yUv94PYC8WDpBNHszhEFk3rxbBqkoLkjVl1fephtQWux2
	854x9pJcOR6xw1iqFmUrXe2wTCffvqZwpQbm7uL0dFAIRdhvNoc7ncq8bHbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712578627; x=1712665027; bh=1Vi5Jga9PnUJOTCViUQmQae+eorR
	DZowKA43a11mwhY=; b=rcvnEKRPRrErb7jriUr1WhuNndB1AzXELWWlAZ1/eEnn
	z6dccY/h1L0gwspc/gYfu7PT2bySOrffXLwi4OOeqRtyEX/G7KjFk+DhMs5JxXJ2
	1y5FPXOg2tpe2g1LESIeeJwKABtXOjlySP9hOyCF6jSPht09k4DA73QL0d029OPe
	26dqdgWnHitwWQkhF9yozXENs2P7GFCI4FSmOpA4LK/iTG89gL4fPduEzy9IV6xf
	X4mn3WOmDYg5iq/+zUipXJ6p23qOP4eE9iQS5RcNpWfWJx8SUPFmECCxajBcFS9I
	e4NeaPSj0tLmQFQzgITDv5sGMFBW/nIrb+lyRGu6yw==
X-ME-Sender: <xms:Q-ATZgPmzAT694Tg6FnejVYq_LcsAz6yb8DnKfxpO9N3avgSiAnfgA>
    <xme:Q-ATZm-9ng5OoC800sr0q0PrPoOmv_LUNdk4UtOiAG9CqEw4Q_p_jpT2I6BMmluot
    mRbKmjJSQoVTbQH-Q>
X-ME-Received: <xmr:Q-ATZnS6fLNwK_SbYrDrTCn0RWs-pMKCfSHS7KN5lHwb5cdTI9d9pJBjfKFXFSACMiwIwmhL9-RwJ6jTUBM20YLnHlZn6pk_mFwpf6Lb3wX8moQtFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Q-ATZosHczskaQzNaK6-Tr4KTUQLggVL8GtOrOsQpoLCggJxpifnzw>
    <xmx:Q-ATZofcKGNMntABfJRj5AFIpieyqFrmQPxYs_jG1I2u3M5olor5OQ>
    <xmx:Q-ATZs3L4c3cIwaX5FEzFZARWAzK1Y4RNxc18kRqHSwcjM5naC_e_g>
    <xmx:Q-ATZs-F15-HVyhFqNw7R1Y49PejAV6_WE-zPsfh8fnVNaxYWCGZaw>
    <xmx:Q-ATZn5fwLPCIUX3rRaCrhrj0vf5PSexuCCEXcu0grznNzHkqwKSCY4M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:17:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 790c45c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:17:00 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:17:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 09/10] reftable/block: reuse `zstream` state on inflation
Message-ID: <587b5601c0c51a8f041258a27e693a2590468eed.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H+LM8Y8YHth/A9ul"
Content-Disposition: inline
In-Reply-To: <cover.1712578376.git.ps@pks.im>


--H+LM8Y8YHth/A9ul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `inflateInit()` and `inflate()`, the zlib library will
allocate several data structures for the underlying `zstream` to keep
track of various information. Thus, when inflating repeatedly, it is
possible to optimize memory allocation patterns by reusing the `zstream`
and then calling `inflateReset()` on it to prepare it for the next chunk
of data to inflate.

This is exactly what the reftable code is doing: when iterating through
reflogs we need to potentially inflate many log blocks, but we discard
the `zstream` every single time. Instead, as we reuse the `block_reader`
for each of the blocks anyway, we can initialize the `zstream` once and
then reuse it for subsequent inflations.

Refactor the code to do so, which leads to a significant reduction in
the number of allocations. The following measurements were done when
iterating through 1 million reflog entries. Before:

  HEAP SUMMARY:
      in use at exit: 13,473 bytes in 122 blocks
    total heap usage: 23,028 allocs, 22,906 frees, 162,813,552 bytes alloca=
ted

After:

  HEAP SUMMARY:
      in use at exit: 13,473 bytes in 122 blocks
    total heap usage: 302 allocs, 180 frees, 88,352 bytes allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  | 25 +++++++++++++++----------
 reftable/block.h  |  3 +++
 reftable/reader.c |  1 +
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 435922b569..c6c4a68ea1 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -198,7 +198,6 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
 		uint32_t block_header_skip =3D 4 + header_off;
 		uLong dst_len =3D sz - block_header_skip;
 		uLong src_len =3D block->len - block_header_skip;
-		z_stream stream =3D {0};
=20
 		/* Log blocks specify the *uncompressed* size in their header. */
 		REFTABLE_ALLOC_GROW(br->uncompressed_data, sz,
@@ -207,16 +206,21 @@ int block_reader_init(struct block_reader *br, struct=
 reftable_block *block,
 		/* Copy over the block header verbatim. It's not compressed. */
 		memcpy(br->uncompressed_data, block->data, block_header_skip);
=20
-		err =3D inflateInit(&stream);
+		if (!br->zstream) {
+			REFTABLE_CALLOC_ARRAY(br->zstream, 1);
+			err =3D inflateInit(br->zstream);
+		} else {
+			err =3D inflateReset(br->zstream);
+		}
 		if (err !=3D Z_OK) {
 			err =3D REFTABLE_ZLIB_ERROR;
 			goto done;
 		}
=20
-		stream.next_in =3D block->data + block_header_skip;
-		stream.avail_in =3D src_len;
-		stream.next_out =3D br->uncompressed_data + block_header_skip;
-		stream.avail_out =3D dst_len;
+		br->zstream->next_in =3D block->data + block_header_skip;
+		br->zstream->avail_in =3D src_len;
+		br->zstream->next_out =3D br->uncompressed_data + block_header_skip;
+		br->zstream->avail_out =3D dst_len;
=20
 		/*
 		 * We know both input as well as output size, and we know that
@@ -225,15 +229,14 @@ int block_reader_init(struct block_reader *br, struct=
 reftable_block *block,
 		 * here to instruct zlib to inflate the data in one go, which
 		 * is more efficient than using `Z_NO_FLUSH`.
 		 */
-		err =3D inflate(&stream, Z_FINISH);
-		inflateEnd(&stream);
+		err =3D inflate(br->zstream, Z_FINISH);
 		if (err !=3D Z_STREAM_END) {
 			err =3D REFTABLE_ZLIB_ERROR;
 			goto done;
 		}
 		err =3D 0;
=20
-		if (stream.total_out + block_header_skip !=3D sz) {
+		if (br->zstream->total_out + block_header_skip !=3D sz) {
 			err =3D REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
@@ -242,7 +245,7 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
 		reftable_block_done(block);
 		block->data =3D br->uncompressed_data;
 		block->len =3D sz;
-		full_block_size =3D src_len + block_header_skip - stream.avail_in;
+		full_block_size =3D src_len + block_header_skip - br->zstream->avail_in;
 	} else if (full_block_size =3D=3D 0) {
 		full_block_size =3D sz;
 	} else if (sz < full_block_size && sz < block->len &&
@@ -275,6 +278,8 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
=20
 void block_reader_release(struct block_reader *br)
 {
+	inflateEnd(br->zstream);
+	reftable_free(br->zstream);
 	reftable_free(br->uncompressed_data);
 	reftable_block_done(&br->block);
 }
diff --git a/reftable/block.h b/reftable/block.h
index 12414eb642..c1bd1892cb 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -56,6 +56,8 @@ int block_writer_finish(struct block_writer *w);
 /* clears out internally allocated block_writer members. */
 void block_writer_release(struct block_writer *bw);
=20
+struct z_stream;
+
 /* Read a block. */
 struct block_reader {
 	/* offset of the block header; nonzero for the first block in a
@@ -67,6 +69,7 @@ struct block_reader {
 	int hash_size;
=20
 	/* Uncompressed data for log entries. */
+	z_stream *zstream;
 	unsigned char *uncompressed_data;
 	size_t uncompressed_cap;
=20
diff --git a/reftable/reader.c b/reftable/reader.c
index aacd5f1337..481dff10d4 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -459,6 +459,7 @@ static int reader_seek_linear(struct table_iter *ti,
 		 * we would not do a linear search there anymore.
 		 */
 		memset(&next.br.block, 0, sizeof(next.br.block));
+		next.br.zstream =3D NULL;
 		next.br.uncompressed_data =3D NULL;
 		next.br.uncompressed_cap =3D 0;
=20
--=20
2.44.GIT


--H+LM8Y8YHth/A9ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4D8ACgkQVbJhu7ck
PpQUTQ/9HS6HWPUtqF7khuk8Ytecc/EcaW4wA+HrkXa/Ju35LuHAbgTMuWu4Undd
PaE+SvM8Lt3VL0DRPHY0l5miHcEwHyZG0gBCUAAXUYEa/QJvAnmZpYIqbhoOOY2R
A0bshI7i/UbmyOI5lmlGxDFw56VCnpDc4tkpC6UE4VMjjSSIPA1wmPGgxGq1Scjm
C7yfw1HSaJ8FXyN+FnHn1IiUTdBBUV/9Jvqo+MbTu9S/IBF3Ck+4usKFBTAZwmlW
8D0f2dN+cqOsmSTkCuho4CEaovC/k8QUJ5ht7v1f1oO1Jb+LbqodEyoSqDEn+aZ2
t2ziGJoeISuZHKKsbhm0ztv6QX4UWeiY5VsSwF7W6DQ0Qk/XpHDDYsQ4RaLewpX/
EcDaqWmpwR8RDyiPIS10nPb42Xq7zZwBOUbymc99nwqoOtQa3cGCH6j/chyYWgN1
HhqO30zXcCLKsjSzGPWlnt7DYhUnsNvA+Wt2nJFuwUPQmkvR4x2Nw6rX+R0x5C6n
hOsdMK7F+Oe7UbrYhQbMTxxIdmQYXnIJlTxUKe5krmHOYE9a3Iv5nZoD+jpdPceU
nkLb94qJfijk/Yc9RBPxQFOpIbuwkzgTnnplal/OW7VUNsFXDf5WW/aNV7CiK3MR
/85LZFJopT4i98bFiCW+bo7008c3O7Egf4ehB65V8PMuMVmNMW0=
=x4yX
-----END PGP SIGNATURE-----

--H+LM8Y8YHth/A9ul--
