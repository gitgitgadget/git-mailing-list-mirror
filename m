Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7486E61B
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579066; cv=none; b=cr4sLwI5v8XKafKbl2L+Giaek5Gd0Nz2I+MYTQZFfpzuYA8tnZFnyXg85bbPVIEDbd9tr550Pa+pbZ742H3WMgrjsJuOoWaRJurXdb2GRaMN+nKlXG5n/HFmkteamaVoD7PDa0a4x7dvLwP3f9ZXx8X7TuRLqN0n5f+2+IpsIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579066; c=relaxed/simple;
	bh=uegcfR614/E+bVvj4mocBYU+y1tmIt+NxF/gibYhXBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oloIbm7HHlGJUUdCLvDnnnBnI9e9bTiUqYSK8POK+oMisoLwy6C/eFM0U6qEMZDnFcEZP+1wzyl4t4D9Gd/dw5cqkJ2itFtkAGXs/SxaISLh6X13qNBAwKBbhhe/zt5CGicFNlKpluWKPE4WgknQAIS9TeKpKphaCZZNfvbFWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sop9FdP5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OesvhYR6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sop9FdP5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OesvhYR6"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D4F3A1140121;
	Mon,  8 Apr 2024 08:24:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 08 Apr 2024 08:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579063; x=1712665463; bh=pUUn7C4MOC
	YYeERrdAVCms0J6BU7raCL+zMX9QM+5jA=; b=Sop9FdP5wNIpnxwK8DH/Tzy0s0
	DujKHLqne7pGI2xvtlc6psNiPEM1lxcce+T1oT7ef4pUcmeLNKqkAgz4YTT+XYLm
	rOWS6+VWi6EDnZl8GsdftKEyPTBU5hlC6Ui1FEwqltTa6Un2oBwNKK1LeCr9NRYz
	jUsG3kuqhOLY2kwU0MSJXW+c3RiByyWyTx59HX6KsAzdG11KXi5O59X408vcuynd
	hVN4Rz+9AQbQ4wznnW3laT65RAbJwiRY/Vql/YoUGGZW4XQs/RkjZPRWSpPwzv4w
	i51RvuJaXE1VDyOmLJgHc86mR6Exar0/0wGEZu/JZJlPrVbSNuLn/xoVaTYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579063; x=1712665463; bh=pUUn7C4MOCYYeERrdAVCms0J6BU7
	raCL+zMX9QM+5jA=; b=OesvhYR6j7PNIf5sMj08Du5UKzscopC2lluLJ6Aomh0t
	S1B+I52SfrJTNAhC70k5UuV5esFxQbkjhkfo6ioRb+j3yYdbPDDG8HAPocnApdOb
	VBo3Lu6+yNo6alE1hszWHTIjceq9WKFqCBKYiRqjHUEZF1XkmPWseXBWunoKNAj0
	9AW+/6pMAJi8ta3TitGuLyXd64iRJoGlCI0l2j8DoxmPhLZUooIwFQT+HnVrB060
	svtCfp+TTjefBux12tiEJWvWTXixEwJexKmeYWSo38TwlJs6St1LlD/hCcDXEwSk
	H0UNWIbYhJ6cwfpD2dNgRVXvLvw1XMkRo5Koo/YFPg==
X-ME-Sender: <xms:9-ETZpKz2c2wSGkfcZgS78pb9qHD_Kwz0mf6mkBknvaAfA7fr_lXUw>
    <xme:9-ETZlK9lKuFCPjX_AVE6NdvkiURmzvTVXU1lNwYqUjufWD3VY_A-_ppF8slSd8KO
    DG_wEBlrK9OZt4O1A>
X-ME-Received: <xmr:9-ETZhugZEtp5WbS9X9Ar0-RhNygqMMVLsW2VqS0fJPMb249Z-SBLxXIIRWSe3JT9PhmCf9G_rs57I04GGQ0vKkggj8ij1VxN6YZhXt_1qon-zAHJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:9-ETZqbZd8m5uwGF3_FRp_0um0I2-T2V61GcVUn3P-bU4SmErP_KgA>
    <xmx:9-ETZgaU3krmm_FAhiuMFrf2gAMC2G-_AZIRg9aJ6WB229NJdmDQdQ>
    <xmx:9-ETZuAGMQT7B5TWbFuqWmSApyRV7qkFe6tNQKZ-O9PMtUL_L99u8g>
    <xmx:9-ETZua-Kt7kk0vm5GB4I25I7rK0yOi32o1FD7GxvofLsCZwpGXiiQ>
    <xmx:9-ETZoFonwHAH1ZnId3kp9Ci3nicA2ybi2FZgdAKin4QlbfMrypS16xr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:24:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6f892efb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:24:17 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:24:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 07/11] reftable/writer: refactorings for
 `writer_flush_nonempty_block()`
Message-ID: <d47ad49d49916d02b8e62ee34404c025fa030845.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LZNCkYZbgVPF7E5t"
Content-Disposition: inline
In-Reply-To: <cover.1712578837.git.ps@pks.im>


--LZNCkYZbgVPF7E5t
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


--LZNCkYZbgVPF7E5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4fMACgkQVbJhu7ck
PpQv8w/+NKeYiqKOd4Fe9L8DbML2/v7PBKy1XnlNwe7h+ZyVm9Kt+xTxtOQDyTPU
mekqjBdH0dGSiFl0CJ2wMeFaq1W3AzwZp9sLnbgcWmBbMjDHI1Uw3YLVhWZAsMPc
EbRBy9xmQjQkI0zy5j867n+VQVFJK239S4fv9nvoIV4SKdSJuOvRI0Y0Gprwjl8U
gE7jF2vLMDDxqkUE0QywMDLsDr79NhMxmTO9JPbXfPk1eIwYe817d0y297mECWS7
ex/2TNeZvAJwRPomroduoNdJX2br4oILm5zlWOphKkfW6Iz07yIOcN7ccXaOaTtP
HsyW2E5oMP6Ta9G63cCvcBwJ36v2+ozSoBjQVztNgtxpgZrhq6wMst6K4ASjEZXG
4u3VfELj5hLxbnQcyhEbUH9vmWvSyYXxwiUXpXeSyDLwHSmX4GOoXIdB3FvwA6Cw
59IFEqSqaqH8SW9vOPFZthGwEGb7zhx0aVQ9nru05N0I7cGG9QSeh1gSSE7y5klk
Smsibo7ReqxpovgI7h2Q8T6AmDvStQtKAOIQVx594hTTpXIPRlSCy61uZr+A2+Gg
WiCWeabVk9Sz6iU4cn7BfYrJLTblEkMdTd82ZzACxE4xbQbFekOtTJug/ijR3xY+
Mxrh+B5Ys9pjAVDSeO5HJOOVPfByOzFL5vHL5hpV9vHjZRh/GNM=
=d3cp
-----END PGP SIGNATURE-----

--LZNCkYZbgVPF7E5t--
