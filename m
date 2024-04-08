Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B426F06F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578609; cv=none; b=gk+ywFA1AIIitNwuIvrKSYdNUTmJOiU4JfVrRuZOX0PC2FfxZe4ZGxQkhzrHAf/YPqpd+Rrdtbl7YUQFHPFZVIUM0Vsq+zOJLdHzMPIcLpbhekmjPZtILhhVhTDRhpdvAaiem1wpTJW4DF1wTdS0hIwzZf608quMKcl4ws6SEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578609; c=relaxed/simple;
	bh=OWzlA5T/ToejWvSLsC9ULIRA8ZeqqrMQzUuJbyP4Rlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsRvQXKAQYfdQFdJoiA3QJJ+eq6/55zOTR0yVL+0fBYWG4eLDxPEttFLTsSTBcLpXXUgzBhdwM/ojLC0tc5pHuNgvs8zhuu4GWlk5FvLHCswyoOcyj+QrVqC6iXpQd7pNS4Vx8qx33oIQzbnTrG7HrS0ls09wPxHem/8w+JaiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m5T+QlEx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rjaz6Bja; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m5T+QlEx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rjaz6Bja"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EFB3411400FA;
	Mon,  8 Apr 2024 08:16:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 08 Apr 2024 08:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712578599; x=1712664999; bh=J6tQzUs5Ts
	7q0/HAs/mPjLVTDGd9EKAfWFLz9em0AQY=; b=m5T+QlExpYZylArJfDuWheu0RP
	DM3M332HqX00fqVjwAu8wgTor0v3UO9TxBQXn9wgWkav8Aqx9V8wDHgt30U5mxRQ
	bETg3b+BfoQAdawXom5oLFmOTYmPZzY54oGFGledAVqiUS3uTGeNqkereOvplkvK
	n2vhGIysKZBAKZMgiYDs39BoOQsQVYc+/EXGraqVeONxXXqKwrpE41KDkkGGI4Oz
	zrWbTxE2I4itVVdw7pGfBmvb1Eg+XJJ7t/WVlcXezJu8LLTXZfcvBS8ZNOksDpyY
	uqLm0IPEiw2e+R8OSdBg5RHd/k+KMs+Sx09ivDVVBHt2KXzqlXpzrr08RvAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712578599; x=1712664999; bh=J6tQzUs5Ts7q0/HAs/mPjLVTDGd9
	EKAfWFLz9em0AQY=; b=rjaz6Bjad0L/tfXanUZ2G+x5ocpkH8HGNr/rc40vCUFF
	acAVjsXXX/6ERpxt3S1DHIqMckfiUqsYvHnp1MQf8Cwuynx+x+8h0a7K2+n3bgiC
	eTENehu/r/S4l0u9vQL6JPf44OB0pXqOiwYRp9WRFQVhSP/IuZg5FeDdwxeOub8x
	+gE5WTHb0kDW1LxkWordyDIiRp4cDgpiT4kjBkUfkMARsNCrDLPvZd1Nhi9sk0Sw
	ORkZWNw2ZEv9TAlVvDKOGylaP/fKPdj/Ne2Ocdtmj5F44T73WTqsgwJ801B0E5f+
	y/D5HdHrQtBVCENtXDPNa4v+FRuFgmBxD1zuaEvOPQ==
X-ME-Sender: <xms:J-ATZs_BaCQ6dpGOljqfyPyHq-JP4-VyeHgWLmz5aAqRJnaA3gWb1A>
    <xme:J-ATZkubhBPfBxv0DVrs7j-sNO9R5QMpUqR8vvklYlv0wrVTlOD2NYe2rvKRet5LW
    0Qe4_asc1x6ef0XyA>
X-ME-Received: <xmr:J-ATZiDZf533WT7Oybv8TMj1cI1B299IkBnPqze05x_E0flOxfM_cdhtZHOA1iX20SRQPQ2-e7_H_K5jVM-ErEWnUZg0PVK4n-tmHDKm6oC6AKNS0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:J-ATZsee5Rr63QzYXVwIoq9zO-TpbzSCFHmcuf8nKKvh-6grzpTu2w>
    <xmx:J-ATZhMpI-5teqrlFk2VP_vuXUIja4qGE1kkvkXLaqoxo1MXz6K2Ig>
    <xmx:J-ATZmkrStR2Pr1X70xSPxEUjlpce7IQBP0UB-iaG9VifaLlYXchWQ>
    <xmx:J-ATZjtj_otDiiaU6HrkkGmjkjcyR3xFRStkUTemTSex5dka_MaQbA>
    <xmx:J-ATZmr-5FzB3CK-0hnbJG7x2MWdgGytnky89k_c5NffVCLLwcYSLhS->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:16:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a2ee439a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:16:32 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:16:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 03/10] reftable/block: better grouping of functions
Message-ID: <c3f928d1e97375974f14fd3e96e0c4edffde9af9.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LOZbFUjqx/tns6yQ"
Content-Disposition: inline
In-Reply-To: <cover.1712578376.git.ps@pks.im>


--LOZbFUjqx/tns6yQ
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
index 1015f9c04c..e65453e11b 100644
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
@@ -353,26 +373,6 @@ int block_iter_next(struct block_iter *it, struct reft=
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


--LOZbFUjqx/tns6yQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4CMACgkQVbJhu7ck
PpSH6g//VDfNCNlfrWlxPTlVFMxtHaYlhAUlrIprtPSkHN70SSOhB/zbmA8a/VW4
85MUKWmGbZ1oS2tXxMJuZBPWje4BGmWyIPmRpd0mT504g8wCGk9Htcd3pqLRBnv3
BnVbhjb0Q1KpIZwJsI7p2kZLY6aQkFhsgiHUVYhEeRfIwfWOZkSXyaieiKcFK3ea
gkPhOWpDS+yGAK0gkmA/Z2FcAxlZQtnzfez3RMAw4Ql33C7xBXZelamlTMaj+v43
K3+RIA3Jy7XJrdm+gP/HZs8EWxT4Znv7eLEyyOKMocqMspbiLj8EVyvbPxMmQyKg
14G25KhOq3CFEF1/2OXUaPY/1TrhVjme7ZLF4RUodkFvvol1TBho+xM3jlFpwPWZ
f4UHyTWNvNXZlC6/niqVHU2wHDVxN/5qqhH3khn/OflPXhTnvnZZPUKWHzyEV1HU
PdcsZ+hgYBlcmGa1PY7o0R+piQ2lG0ZZktfqIM1B0fpnZpdtszz+JmEZBnDYejgD
uLF08GPAZuj06gvBrx6gqcw1rNB49yaWxGQb5mvBHp2XMdXFsxleSE8jgfiLOst1
BqdNKXaJDiHanJWJvjb2asp+lKJswjty4hTQx626b1n8c8oVEzjgmgZ2XprDEDUb
QtABowKbrPQR5KQ0Ri9+5nWxkc+bXGNkdmjlGjQ6/kc2zTTGLyA=
=hvnP
-----END PGP SIGNATURE-----

--LOZbFUjqx/tns6yQ--
