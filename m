Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2D288B6
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521430; cv=none; b=aGmb/k+kxmohjBtjDqCzXrg8CDjaOxgBZ2WEpjfhQwLgQBz5MR/ITMEwi55cBYpekdgd8QbvyMOmEmsTB7HY/be5o1gUp6c7ALkmJW2PL/wp7zytFcf2NFdvmFbldtSOTO4hSbI7EP5IcXvGPMTwPZizQ0q7mHXevpshkKdZpL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521430; c=relaxed/simple;
	bh=4oJzdkCCwMSSsJh8zL5tqPUD62+RdOGRY3BLi2qU+R0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmW641+uS0Yt0ZKco39ZArXQM7QOA6EGL/udNFXDHAMMJAOtl+vEcvc5MRLOkEj3NcNZo+YlJ+1x7xBoKjikS6+JLZtZMDxtVr/wFW8SGsIMK8ATgh2Yfioei/ZXgI4A+Favu0S2q4YCt0oVnuDck4ROR+wc5eyweJZ0IZkJ0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AP4qY/6S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FWXCKMM9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AP4qY/6S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWXCKMM9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id A221313800DC
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 02:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711521427; x=1711607827; bh=KkMm/8huKQ
	+SCBaZ8oThq/ZCCZbxPZ5CodN7D6K1ds8=; b=AP4qY/6SiEKLGKlRZ5FkZQVaaH
	sc1m+jZuCBpAJaT9qchljEke9WKyqIhS5rVilmFj+e4qJdQo+DVd1M4oa4uTbZ5X
	FBiOszy0T8WjXbPe0kIdYdIW3VpVmVsqWdiNlydD05+7dWEwkfwZAh9vNdiASAr+
	aBH9xsm5PZWnI9H0PwXTDCAPo5/gAUtU+e/kYV4SAMqscmAiMA32PT9vAT1Hf/Rg
	PqrM2MRwTVMNlxqH+Tekgbbdav9X2AMuddKKkpf2JT3XvugUBzwJ+cVcT6ph9iJ3
	2OSW7OCqdAEgX6Vx7OcYM66njq24tuPlT63Xo/oigRHGk7+x0T+kGlftTBkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711521427; x=1711607827; bh=KkMm/8huKQ+SCBaZ8oThq/ZCCZbx
	PZ5CodN7D6K1ds8=; b=FWXCKMM9gmFytSz8n8AcKvoFaRlN1WpgmilAiURgnlu0
	T5yPSjOJQE1MxnApppj9CmFCuWQZMVlqVggQkG8NHRYcZi4UKyuxoGocfRrT/Vtv
	Ms7dWPdQaVSwKHYj7acqFaHcFcj/plh6HVz6qGFZC87x2BogOFk5VW4tAD3vkUR8
	MHHMxobRKFPAQ3FyQdxR8G5kkMGSxCHTZ8g/kYuCExqPvlENUovwrMW7yxKawsYj
	HA+cqI1FiB/k9W7cBBeVHTZuKun+0M8ijNZ7zDJRoxQ4edlo5dlIIWM8PfEFpEuL
	dWYqjBG6c7RYrDBr5eo4YKfD1cuN2XKXc9z5qkQb/g==
X-ME-Sender: <xms:k74DZro_Ft5suyYkyI15oB1Nc0hFZIRoL9_-CmcSqj3b7DHq2KRKRw>
    <xme:k74DZlpaKOBgp3OJ9xK2_Py0ZHQx4APTQJv_DnSAk5Xn3ROJGRH8ZQNGQfrk2NnOV
    5HU5c73BNNpTWffiA>
X-ME-Received: <xmr:k74DZoOsswBxUrWUANWpM-4MT6fKbUIXmApeK7WFPruVrdPo82WBtA7EOtY4sMxO8_Qr19W4teo3BQgs-lCb2k7xtBGYcewgIzuyY7x0dW_Qtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:k74DZu6RJaH0hf9nyzkdgvOyyKvAOFri3mAenhW9E0-lrUIY7E-LVw>
    <xmx:k74DZq66xoXC3o81-0QBpGL2DSsohgSmbbCZbw1KJhCUT1Ht4xNeRw>
    <xmx:k74DZmhspP4DqXaByvHh-ERVlaGNZPe3iovXin6frkiHmm5nz9B8jg>
    <xmx:k74DZs4p5bfx-1ftkJyPTYy5Fyx1k26R0_cF6UVwOrtTAFphNnGn8g>
    <xmx:k74DZqEvgXb6wBvLkEmeU2l7BAsDN9-vviz6gj9Sjw9dmwM2RHujIg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b0e9cd14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 27 Mar 2024 06:36:53 +0000 (UTC)
Date: Wed, 27 Mar 2024 07:37:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/9] reftable/block: better grouping of functions
Message-ID: <88a705b3e26a12805f13f6e315aa2b815045cbb7.1711519925.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E4P8nr9ddwkBZq6w"
Content-Disposition: inline
In-Reply-To: <cover.1711519925.git.ps@pks.im>


--E4P8nr9ddwkBZq6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Function definitions and declaration of `struct block_reader` and
`struct block_iter` are somewhat mixed up, making it hard to see which
functions belong together. Rearrange them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 50 ++++++++++++++++++++++++------------------------
 reftable/block.h | 22 ++++++++++-----------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 3f182c5d1f..6b78dd3424 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -175,11 +175,6 @@ int block_writer_finish(struct block_writer *w)
 	return w->next;
 }
=20
-uint8_t block_reader_type(struct block_reader *r)
-{
-	return r->block.data[r->header_off];
-}
-
 int block_reader_init(struct block_reader *br, struct reftable_block *bloc=
k,
 		      uint32_t header_off, uint32_t table_block_size,
 		      int hash_size)
@@ -261,6 +256,31 @@ int block_reader_init(struct block_reader *br, struct =
reftable_block *block,
 	return err;
 }
=20
+uint8_t block_reader_type(struct block_reader *r)
+{
+	return r->block.data[r->header_off];
+}
+
+int block_reader_first_key(struct block_reader *br, struct strbuf *key)
+{
+	int off =3D br->header_off + 4, n;
+	struct string_view in =3D {
+		.buf =3D br->block.data + off,
+		.len =3D br->block_len - off,
+	};
+	uint8_t extra =3D 0;
+
+	strbuf_reset(key);
+
+	n =3D reftable_decode_key(key, &extra, in);
+	if (n < 0)
+		return n;
+	if (!key->len)
+		return REFTABLE_FORMAT_ERROR;
+
+	return 0;
+}
+
 static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
 {
 	return get_be24(br->restart_bytes + 3 * i);
@@ -342,26 +362,6 @@ int block_iter_next(struct block_iter *it, struct reft=
able_record *rec)
 	return 0;
 }
=20
-int block_reader_first_key(struct block_reader *br, struct strbuf *key)
-{
-	int off =3D br->header_off + 4, n;
-	struct string_view in =3D {
-		.buf =3D br->block.data + off,
-		.len =3D br->block_len - off,
-	};
-	uint8_t extra =3D 0;
-
-	strbuf_reset(key);
-
-	n =3D reftable_decode_key(key, &extra, in);
-	if (n < 0)
-		return n;
-	if (!key->len)
-		return REFTABLE_FORMAT_ERROR;
-
-	return 0;
-}
-
 void block_iter_close(struct block_iter *it)
 {
 	strbuf_release(&it->last_key);
diff --git a/reftable/block.h b/reftable/block.h
index 1734bee917..d73ed73549 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -76,6 +76,17 @@ struct block_reader {
 	uint32_t full_block_size;
 };
=20
+/* initializes a block reader. */
+int block_reader_init(struct block_reader *br, struct reftable_block *bl,
+		      uint32_t header_off, uint32_t table_block_size,
+		      int hash_size);
+
+/* Returns the block type (eg. 'r' for refs) */
+uint8_t block_reader_type(struct block_reader *r);
+
+/* Decodes the first key in the block */
+int block_reader_first_key(struct block_reader *br, struct strbuf *key);
+
 /* Iterate over entries in a block */
 struct block_iter {
 	/* offset within the block of the next entry to read. */
@@ -92,11 +103,6 @@ struct block_iter {
 	.scratch =3D STRBUF_INIT, \
 }
=20
-/* initializes a block reader. */
-int block_reader_init(struct block_reader *br, struct reftable_block *bl,
-		      uint32_t header_off, uint32_t table_block_size,
-		      int hash_size);
-
 /* Position `it` at start of the block */
 void block_iter_seek_start(struct block_iter *it, struct block_reader *br);
=20
@@ -104,12 +110,6 @@ void block_iter_seek_start(struct block_iter *it, stru=
ct block_reader *br);
 int block_iter_seek_key(struct block_iter *it, struct block_reader *br,
 			struct strbuf *want);
=20
-/* Returns the block type (eg. 'r' for refs) */
-uint8_t block_reader_type(struct block_reader *r);
-
-/* Decodes the first key in the block */
-int block_reader_first_key(struct block_reader *br, struct strbuf *key);
-
 void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
=20
 /* return < 0 for error, 0 for OK, > 0 for EOF. */
--=20
2.44.GIT


--E4P8nr9ddwkBZq6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDvpAACgkQVbJhu7ck
PpTPjBAArLsnpRkdTxAISOX3/rHIpsz4PyL9lppSyw9WO77OWBnX9A5+T4rOAuSe
bLAx4twUQVXeY1S13fh/4kMh2YbzT8Lv5xpc3SfuhyjoFw+B9Adoc8pvAToPimw3
EYWF5463SdqAFQyqH3e1BUwla8VptD1f2ZFmNOoIT+DJBuQVgSmw0PUT4NerKzYl
33r7kSqzsucHgm9xC8VMOrs9magwqbXPqdWWJVzgNYv8RVO/XAFy8ph3nyKirpt+
cIbBgxr6FmyXiuTRrcDri3eV67jimAGt1U9a2ZRWCLSztAjuUA+17Y/9pr/uSN4z
6FtkZRNVwSSvhGvB9VysbimfDrA6RGNATHdFendOuGYj3sOUOF/2lrgRmnAy5Sgo
mzTLm97Ze3fdO33WAe5JzuUWSkdXlQE+7m1ygiILQwfQPVLSQrxBZauZTwmXN49U
p5svTEgkyl02+oWwARP+Zm5nPQDqH9X+rAMZavcbtcMrNIU/c8l9d+HVlwzU4suI
4+shIsYCsKHlOLjW3MuoGEzqSyV0ujmVqatbe8YuX3Pv5uIk7YEWSAhINpnTlzXH
OZ78OcpogOpoy7u/qJNla7VMaxkZ67OqlSWu+XP0ucsOeN4F8U/Iqgj7gNt2Itbo
FZa9o42wdsWz2pZapyUmoQsf4fvmB/kuMZbzyYuLYGtxnuCf7zw=
=vCPV
-----END PGP SIGNATURE-----

--E4P8nr9ddwkBZq6w--
