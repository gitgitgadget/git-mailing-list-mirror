Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B294CE1B
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209719; cv=none; b=s8G+DKDni/fUlz9E5EZzZMBbAkCISDEVqGAcUBHLxw1THq47ydQox0G2MmrV8Fbkyb/PKKrr0VYxtjwm2p2Jr2crfnuC/GJ39aM9v0RQhTqTQRz/uJw+m+BZx8cDKaL3lw+vHdQxgVzjlD5A+pdK9a+6GiJ8duXAfJttZtlvVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209719; c=relaxed/simple;
	bh=vO6PHnpDo6QIv4/et9J3hYZH9umrOstXMd0pzKb42yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dys0boZovRMoaYDAN+D9GUjKV4vIIrT0Q71bJkzixtQAfNzZRdd8hq8Nq+SnvWin7SarqPjbSbXyWM1RfsTyS/p1cbFXijUDgyS5Hol+GiRNy0FfVTX+vrPPPLkWd3Z5fQkEmlRHuZHG2+pHe803cy0F7x/T/lUosP7Bx6x6dg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nb4A+Vf2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bDs/mbC/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nb4A+Vf2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bDs/mbC/"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2F8A1114010A;
	Thu,  4 Apr 2024 01:48:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Apr 2024 01:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209717; x=1712296117; bh=x316v33e6U
	3ej5yuNCPG5F96q1u52bzfiSqEaBcVy2Y=; b=Nb4A+Vf2SWpYXXh0Yz64jfOsw2
	eVifetoErwA+tEkeAm1191V5iBCMg9KHCX7BJUuBNft95kNNmItUdXyJAFGT2m8q
	DDFnnkrxL9Z2BYXmonjHub/pwCw+GtRyTeEkZHA5gBc/lsDIXsSqP4LNqMbcygQn
	eDiH5vLBn1kCmIiXooJMEgWzb6hKhZghBZNXh+1Igaj6c4IZQW2KC3oUsRJkhsX6
	GHhsDUpy3EtdwN2MKPOiPIs7tZ62QQnP5eADLug6v8xbiAaAKl1vkb95xl4OB+X4
	KNrBXjzv025jm47car5yy9sTW65ZA4l4VLDFH+MxidNYYN/g5/wA28uVLVHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209717; x=1712296117; bh=x316v33e6U3ej5yuNCPG5F96q1u5
	2bzfiSqEaBcVy2Y=; b=bDs/mbC/tISywahUZKbaNUok22rF4rNbVDzxCwvHyuM4
	DLER9erYVWKoyM3ti52cbDpLHCQBtqftXZbTyJLcY65T/7mEgEVw0wMCbN7a2C8Z
	hKCea7UFWi9dHDMfxeo7ewc+bkmGG3hf7Vc+9c4CRp9nXr6tQdIrYtTZe48Q63kS
	00BArJaSBv6D/pBB2y7cVNUMLuXnKf88qTau1PXdVYN0WifJtQPAZWk/rnvN7SNW
	Unr9tdbZNl7anRVkRjx0IcVDKbXsrooZwgyKQKmUDAQo02TCkjf0WJaYOGc2j5xk
	eQpuEu5jY+Bt1BouYK8RzGPpV03vn3JQJIxSbiRRXw==
X-ME-Sender: <xms:ND8OZmN8IFCqEwTeyvkVtLoLf2WuxFZmCMmA94wlVbPhLUCVZjcW6w>
    <xme:ND8OZk8E0Bptg8MYJd8k6Rc6a1P_IITEygdQKdbYmqC6RufLhMlBCFxQ6zDw1UAqE
    vtyRypQg7laT9CVag>
X-ME-Received: <xmr:ND8OZtQnpcB16iLsNmOglhc065ka5zVWGgHuGb18jGHpShzuzxJtBbknrPRFTXj23lFS0G8GeCYEZ-KX9NiJviAJvybdNYLPEclUytrDh4tnUi1j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:NT8OZmvZbTyX5nrGSUJhIiqpArac0wFBpZjHK8-erD_HMG-PuXmtpQ>
    <xmx:NT8OZud4A-FVmOGZZHrM7RDNRj-WeuEUkp8oszOExTRKmtXgGynqPg>
    <xmx:NT8OZq2g9DTtcjciR4OYyNUK_n7hRLQ2dk8kq9VGsXLjoUkDQx6PGA>
    <xmx:NT8OZi9pneykqJNrXQpEM8QhUxoIBoVQfMRRFip6bf5PwssD4f2vFA>
    <xmx:NT8OZt5OW_6N_9qFIzH0wkpLtWZldhNH0FlU0Ki5_XCRksq9ai9ZOTRg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6d73a381 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:33 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 07/11] reftable/writer: refactorings for
 `writer_flush_nonempty_block()`
Message-ID: <8f1c5b416986f6d4934bbfefe18ad7ed55231671.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mQuXbUdAzWpkr8+d"
Content-Disposition: inline
In-Reply-To: <cover.1712209149.git.ps@pks.im>


--mQuXbUdAzWpkr8+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Large parts of the reftable library do not conform to Git's typical code
style. Refactor `writer_flush_nonempty_block()` such that it conforms
better to it and add some documentation that explains some of its more
intricate behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 72 +++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 0ad5eb8887..d347ec4cc6 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -659,58 +659,74 @@ static void writer_clear_index(struct reftable_writer=
 *w)
 	w->index_cap =3D 0;
 }
=20
-static const int debug =3D 0;
-
 static int writer_flush_nonempty_block(struct reftable_writer *w)
 {
+	struct reftable_index_record index_record =3D {
+		.last_key =3D STRBUF_INIT,
+	};
 	uint8_t typ =3D block_writer_type(w->block_writer);
-	struct reftable_block_stats *bstats =3D
-		writer_reftable_block_stats(w, typ);
-	uint64_t block_typ_off =3D (bstats->blocks =3D=3D 0) ? w->next : 0;
-	int raw_bytes =3D block_writer_finish(w->block_writer);
-	int padding =3D 0;
-	int err =3D 0;
-	struct reftable_index_record ir =3D { .last_key =3D STRBUF_INIT };
+	struct reftable_block_stats *bstats;
+	int raw_bytes, padding =3D 0, err;
+	uint64_t block_typ_off;
+
+	/*
+	 * Finish the current block. This will cause the block writer to emit
+	 * restart points and potentially compress records in case we are
+	 * writing a log block.
+	 *
+	 * Note that this is still happening in memory.
+	 */
+	raw_bytes =3D block_writer_finish(w->block_writer);
 	if (raw_bytes < 0)
 		return raw_bytes;
=20
-	if (!w->opts.unpadded && typ !=3D BLOCK_TYPE_LOG) {
+	/*
+	 * By default, all records except for log records are padded to the
+	 * block size.
+	 */
+	if (!w->opts.unpadded && typ !=3D BLOCK_TYPE_LOG)
 		padding =3D w->opts.block_size - raw_bytes;
-	}
=20
-	if (block_typ_off > 0) {
+	bstats =3D writer_reftable_block_stats(w, typ);
+	block_typ_off =3D (bstats->blocks =3D=3D 0) ? w->next : 0;
+	if (block_typ_off > 0)
 		bstats->offset =3D block_typ_off;
-	}
-
 	bstats->entries +=3D w->block_writer->entries;
 	bstats->restarts +=3D w->block_writer->restart_len;
 	bstats->blocks++;
 	w->stats.blocks++;
=20
-	if (debug) {
-		fprintf(stderr, "block %c off %" PRIu64 " sz %d (%d)\n", typ,
-			w->next, raw_bytes,
-			get_be24(w->block + w->block_writer->header_off + 1));
-	}
-
-	if (w->next =3D=3D 0) {
+	/*
+	 * If this is the first block we're writing to the table then we need
+	 * to also write the reftable header.
+	 */
+	if (!w->next)
 		writer_write_header(w, w->block);
-	}
=20
 	err =3D padded_write(w, w->block, raw_bytes, padding);
 	if (err < 0)
 		return err;
=20
+	/*
+	 * Add an index record for every block that we're writing. If we end up
+	 * having more than a threshold of index records we will end up writing
+	 * an index section in `writer_finish_section()`. Each index record
+	 * contains the last record key of the block it is indexing as well as
+	 * the offset of that block.
+	 *
+	 * Note that this also applies when flushing index blocks, in which
+	 * case we will end up with a multi-level index.
+	 */
 	REFTABLE_ALLOC_GROW(w->index, w->index_len + 1, w->index_cap);
-
-	ir.offset =3D w->next;
-	strbuf_reset(&ir.last_key);
-	strbuf_addbuf(&ir.last_key, &w->block_writer->last_key);
-	w->index[w->index_len] =3D ir;
-
+	index_record.offset =3D w->next;
+	strbuf_reset(&index_record.last_key);
+	strbuf_addbuf(&index_record.last_key, &w->block_writer->last_key);
+	w->index[w->index_len] =3D index_record;
 	w->index_len++;
+
 	w->next +=3D padding + raw_bytes;
 	w->block_writer =3D NULL;
+
 	return 0;
 }
=20
--=20
2.44.GIT


--mQuXbUdAzWpkr8+d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPzEACgkQVbJhu7ck
PpSh0w/+PbjWIQm0hMi9Q6NERlNy/nXiM4nh9JxA4UsaBf/z/f4g5uGuninn9YAH
frsteYt5hWmTbDCzIWRSDX9BKcFbLz8EG76Y5IuNsXnRg1Ax4h4ovPE5vwW2X75t
KfuUPkT/Iwc/PfXcP4rVhanmjTZVLlwR0GVDbkXNFIHQD/wBAvwxVKCanaLIWDa8
Dr1V75yuNyew6eKKSk0BK2utiIjCJB9EdMueU960BS5R1tN8rFf7uVlfCAnrvBxZ
bGaFywJInGMLa1W1MjI8gl86UW+gD6WiA4tUPbXwVD3AoZTwXgE2ZTGfA6AFaDu6
3yg6e9dhGXteBEHueFMnOuFyIHogKTSAtNoFCci16BKrK5NmDlfV2JA+yiYGCY3y
cInhfemxa7pdGU9pHhGU+QOYbhE963DEi0s2DY/JVPDSdmY8EHVWWLHhqLqWNyo2
mM843pJES58z6vrFu6t7YPsyTv0+McInf3AEHZzBZ+ngvE9mmBkoKw97xjNhqOd3
9yh2xGgCGxM6aM5pH72fp8P1DBM4qV3z7EB6BzTJwzfJgytgR0/q497EgmRE7nDS
ZgMV/RyuhCuayZIye/WbCEuwHsGqQL56astnVl+vYtvs5v/CGw2Ow5ELo08d7O30
2eA6ZxfW94Usvqy0j4IPdR0KUv/lDhHHy9DIKF9Y0H4z+sWk5v4=
=Apgo
-----END PGP SIGNATURE-----

--mQuXbUdAzWpkr8+d--
