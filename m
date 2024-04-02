Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8ED14AD3D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079017; cv=none; b=CyU9pduVi3kXu3y59cl2xpP0X+1A8h13zardabOz4KdGb4BzEnlcZ5145dmAgEIuRtHxjD5aKX8/ddZ2tBmNW+b1CTEEsJ+f9Qsx5d0ovmyzW9ETOYBe7JVAApusDpDA+Pn3IHGlNWaBy6yI8ctBNfYHxwN5czBxXtwMO0JyzWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079017; c=relaxed/simple;
	bh=GNwcJcQm0DLl3n1S8zRvZd2xXpW57WzlT4fS2cP2qbc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYM0BQ5UUez1jT7fbSIheU8ypn62uvtQe2SuEjWSQDJfu812ubplGA/huJpXfrINDtFrdK59tUQYGkXz73PHxVM23KwbpkRkBkErVGW8SvuXTnFmNpBYBpbxct3Uxau8lc/BOpL0dCBGRGqmLRyvYqt91rx5fa81IHwfptrrCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nyzo2NiS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gj7qUjwO; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nyzo2NiS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gj7qUjwO"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 230FF18000E7
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:30:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 02 Apr 2024 13:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712079014; x=1712165414; bh=2J58llVxMk
	uuH8Gu6gxiN+AQbFMSF7qv3Y5Qy7IDYKM=; b=Nyzo2NiSN0ri56WWNLlknb8LXv
	D/As3Bkp7556F9ZBrpu8FN1eT5rKiKgMAthMlmEGmHlXUx3nitzKZQ3QZDU54U4z
	Q5vfofsKYiJJIxhGpu/QjCvSo+mEVQv54dg+idgm3YP6l6zz90o3fu9hs0Bg/MFB
	VlmWcLpgO7mrTQteRm+o909aVmDmbNrcWiU+WHOZOx2OM3YY2qzD8SD0jw5D29s/
	QKx4QKWAHFhW+a4VF0WwwxvZ87hVkyczfn3GJM2hPszKvHjQ5jh8IY4lA1XLSOAY
	6uVzwVKgpDDNUCmLZe5X9IxLouECG73UBR9G4VpzJ6pQkauYtzN8WbMoyF3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712079014; x=1712165414; bh=2J58llVxMkuuH8Gu6gxiN+AQbFMS
	F7qv3Y5Qy7IDYKM=; b=gj7qUjwOkj+h7U4sLGNCpvIq6lTbmeUTzCzbrBjx4I0u
	4om5NDZ0Qtec9iSXdVZ5XafWpQuCnqdfjzPycLUTZ9uvSD6VHoa5hp0l0pHjYv6S
	JFW+rrAv3r3UsbSRLXjlOZ0ia1xGRM8mxPUO+aSS89njn03kPX7qSzVmyk3aKifW
	ckicIRmhrOEIEzty11Z1KSP9ivtiTxuryGdRuxrBbQhRqRV5CnKxqxg+1arOl1nb
	lDu8U3mTTXlGKua6RLwTW4bZLUaTE0GC1lWL7IQg6V2K0qF6XcNjo2TCtoUJD+DR
	E7jN2VSOz7muJlrBv+GHY0bew+PgEIB7C8OnJfioFQ==
X-ME-Sender: <xms:pkAMZq1oOAOKlRMR6R-BF9Wr8wbiikBYhW5HwysFPSUAVNvVzMMsRw>
    <xme:pkAMZtEbgtq1hZt8l4A8FtpExJwUgzHF--sXKg4T0u8-7LC6nifOKQeEqlwYF4tuU
    prKWODc-IidKZwV4Q>
X-ME-Received: <xmr:pkAMZi72b8iNJqlyMeMxfl1ajaoqJtTsPProjJjcHkWtZzblhuhJAGgKLJGPCkhFinTgtvrrMx73YzJpeXbjTrvhH1LHOsWecwCvJxW9fpmjQVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:pkAMZr2RJAr-Q4KmUkl1yZkyRqrgQFT0H2JuE0bqIMRTWiukWbTygA>
    <xmx:pkAMZtGfAalr-ypKcCmGeTIS2AZ2VLyExYkEckQmDmfoYGL2RkBtqA>
    <xmx:pkAMZk9u2X43NQU1Ft5z3hEuKYhpTq6ZgZ6tolY4qGasKmXwwq7OHA>
    <xmx:pkAMZimDIAH5tp75iqJyo1h8NZ8D_ko2mt45hx4IRUefAxDaBUBoBQ>
    <xmx:pkAMZiR2eHCTMjqn37D-U0zOz_p8pTvijKMWLUFPd3WexGHHvrSWTMDZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:30:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 14af5c5a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:30:05 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:30:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/9] reftable/writer: refactorings for
 `writer_flush_nonempty_block()`
Message-ID: <1f903afdda229ae3e6b73c5612d77f4647079690.1712078736.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BcpAhaifYeTvPR9V"
Content-Disposition: inline
In-Reply-To: <cover.1712078736.git.ps@pks.im>


--BcpAhaifYeTvPR9V
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


--BcpAhaifYeTvPR9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMQKMACgkQVbJhu7ck
PpS/AQ//YOvSxYMCdhGuG6iSb4fUT3/qs/y7N6WEpAqMnFc2J3z5renn4AxrxKod
7ZJ+Q+t6tEqs2/RqirP6UnKr4cj9O9VKgW0VpV19+ceg+bfhyLfQNQDM7O7nNKG9
GpwBtQolNAKJZEX2E+j2gXbSd4c7NrcwYj5uxurhrRVpWXVligheDEjJ6QgbzO/4
FNM3MtMFYUvPZQzFtClzQReLXNYiY2srZmgSKKSB6cFWvuOTipYTq5/uvt18rvuz
OogCBLBz70yohwrlpWSwhX8o0z4WkyqVevZzLMjEtkRSPohKNBdH5NMbHkNkoiND
vqflxgiHextv0B2SHW5kapIorbZArNShYkXwQR7I1nEloP6tgY8sBuyRkhYl4xIS
vfu/ssszow+RDsSUGz4lVjbj0+wQemt7RZJUv+AHbymXRoM+8q4PVW7E3gsKKLcB
hBg1qpT3oTnv009jly1lEbAXRnILGTy9szvfeMJhecbeduLNLWEF2unrZe3oR/yD
+pel0jCc5ixisXXEv8m7afh9Msb5SvCsdlgLyrbnffoJ3+jIaJuxJokctD3eHjmZ
OvGpM8AnCRqRCK9PKW1zXNeHgJCxVMNbA9CtntwTWlhlN/8LwgHo1B4YI0xpN1iV
ZLpXwBdD5DmX3J951uQEHJsGre8mSNxj91nWX0Gi1/QQDzoraVY=
=n/RB
-----END PGP SIGNATURE-----

--BcpAhaifYeTvPR9V--
