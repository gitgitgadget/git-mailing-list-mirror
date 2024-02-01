Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78E1586FE
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773935; cv=none; b=fTNKgwRBBb8Pi5WuJbe+71PV7/HNKnqHVahReHeb5Chl8xiX9NHk/lyMJTR7uIB7/UNw8Dbi9e9POdAPFa7Af+xYebo9Yhgl5vekt3N2H3KdEBShs3PO7wHLyVLu6Oh97mq3Ii84oXoGcA5YXQovMCa7+qtE3RFyH0eYt069nUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773935; c=relaxed/simple;
	bh=G6dNrwF5mEshdodv/fJBoobjOrseFZx+tuddoan9Hp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIrc56pKtB1cfEJcwt5amQUxFukdDsJBQQr2QVaVvzTMhb/tVXuJQ0gHJggbVSiyu3vUX8uaTjYy7qM0amy40WRZMYXJ+GbgkvUbuvyxax/oNgIXUVUc0sU4bGmr4boiIgM0j1lO1HO6nmqvoClFghveDak3cjbsGLpcDlaWXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bA3wslVp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRX6koWS; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bA3wslVp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRX6koWS"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 8F5B61C00069;
	Thu,  1 Feb 2024 02:52:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 02:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706773932; x=1706860332; bh=jnc3Elxjgu
	sL3k70dddV7Y1JLBzFgjWEkiJaZ2W9+D0=; b=bA3wslVp196y0HoPyM7AwANrMM
	/4KFrX8HNyPQEn4VoTtdsQYF9r1STOix/dOdLvpvjKpGXZPILcX9abzDbPX51XbG
	kdrOtvyyT2nz4xDO231mSf74BUCCEMTkVIWYemq3XrJKeNvC9Ot3X0En/k7sT3MQ
	eI39Bo+1RnMcDku2jbEfhHatZeCdwLydcR1FNF15dyOiRw3wEcdOD8dc2VsqXvmE
	vGsS4/2+prYzc6+ZqJXmVBdj8K74UddEtyCh9xryE2vQnugtIQfWhRx3oQdeU5K+
	AYUMwmdCrM7iCFxGj2vhZ8TTir0XumI9pbw7f1Levfyt7MWfosQk5/0Y6kQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706773932; x=1706860332; bh=jnc3ElxjgusL3k70dddV7Y1JLBzF
	gjWEkiJaZ2W9+D0=; b=PRX6koWSH9CtKKOlZs58d6EXvL/E9q0hBGzKofCDxj2r
	8iZ4TS67MbDqdx6sB1ujM4s5HzFR+ipILbY09igdCaxMBjjmw5KjWQH9nebXZRmV
	h2nXO7G1hLmvGEvbYsEpu6i0xd+RGcZWI0syxuSChTrGSZOn1nYgY1Kj2GFhkApU
	+LSxei10ZN1Db2fruWdvm7TU33sSc7TNkx2G3dpX/zRTcN3XDttyedmriLQsGJTH
	5tpKa+Iq64ZYXEh+mSq3o+GnZXetgBgIcSYNBIRMLdJ3DhLHLKUQpe8t7ujwNaFM
	AIUU1NAVjfk5Eqv74CTVeUD1X3UoknMVss9aojCzdw==
X-ME-Sender: <xms:q027ZeYi7Uumstj6b_NNUOb7aLC__UiKHTEMsn1hgoozRyu9oj-FTg>
    <xme:q027ZRacUElmVZ-l3NjTZ-EAkmB2kViHkqYoJW5E5S96kXBXkEf8Kw6Tla94-shUh
    V507xSDXPLYeLpZKg>
X-ME-Received: <xmr:q027ZY-RNpMXYiULHnONvku3csWJKnmDt2NftsUbrA4XIDghrQZK9vgmX_zhGPix5g8zzPlLUZst3P_3w-tOLw72HFlQ8HiYW5rPlWLx_s5cZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:q027ZQrguSscxBcOeqQWFYkV_aYcsD_jGlYXRdKlcGB8EvqJg4ne_A>
    <xmx:q027ZZok6Q5I1ohpUiUZ94AUX852sCemT7czRWBv53RZjP5yMLC60A>
    <xmx:q027ZeSNBZtIMskyJIBdn09rTljjNa5UrJrZJFP6ejhV8OcE0B3e-A>
    <xmx:rE27Zal7AHv3MZOcPTuPYNR0MNngIDXdV6LeuhaDjo1RhdvV64f1xDnumA4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:52:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8fdbf104 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:48:48 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:52:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 4/5] reftable/writer: fix writing multi-level indices
Message-ID: <89a88cf83eeb50542d3878c5c6e56e46f2bc3e73.1706773842.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
 <cover.1706773842.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MV57dzLTvkpJQPk6"
Content-Disposition: inline
In-Reply-To: <cover.1706773842.git.ps@pks.im>


--MV57dzLTvkpJQPk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When finishing a section we will potentially write an index that makes
it more efficient to look up relevant blocks. The index records written
will encode, for each block of the indexed section, what the offset of
that block is as well as the last key of that block. Thus, the reader
would iterate through the index records to find the first key larger or
equal to the wanted key and then use the encoded offset to look up the
desired block.

When there are a lot of blocks to index though we may end up writing
multiple index blocks, too. To not require a linear search across all
index blocks we instead end up writing a multi-level index. Instead of
referring to the block we are after, an index record may point to
another index block. The reader will then access the highest-level index
and follow down the chain of index blocks until it hits the sought-after
block.

It has been observed though that it is impossible to seek ref records of
the last ref block when using a multi-level index. While the multi-level
index exists and looks fine for most of the part, the highest-level
index was missing an index record pointing to the last block of the next
index. Thus, every additional level made more refs become unseekable at
the end of the ref section.

The root cause is that we are not flushing the last block of the current
level once done writing the level. Consequently, it wasn't recorded in
the blocks that need to be indexed by the next-higher level and thus we
forgot about it.

Fix this bug by flushing blocks after we have written all index records.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/readwrite_test.c | 56 +++++++++++++++++++++++++++++++++++++++
 reftable/writer.c         |  8 +++---
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 6b99daeaf2..853923397e 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -866,6 +866,61 @@ static void test_write_multiple_indices(void)
 	strbuf_release(&buf);
 }
=20
+static void test_write_multi_level_index(void)
+{
+	struct reftable_write_options opts =3D {
+		.block_size =3D 100,
+	};
+	struct strbuf writer_buf =3D STRBUF_INIT, buf =3D STRBUF_INIT;
+	struct reftable_block_source source =3D { 0 };
+	struct reftable_iterator it =3D { 0 };
+	const struct reftable_stats *stats;
+	struct reftable_writer *writer;
+	struct reftable_reader *reader;
+	int err;
+
+	writer =3D reftable_new_writer(&strbuf_add_void, &noop_flush, &writer_buf=
, &opts);
+	reftable_writer_set_limits(writer, 1, 1);
+	for (size_t i =3D 0; i < 200; i++) {
+		struct reftable_ref_record ref =3D {
+			.update_index =3D 1,
+			.value_type =3D REFTABLE_REF_VAL1,
+			.value.val1 =3D {i},
+		};
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/heads/%03" PRIuMAX, (uintmax_t)i);
+		ref.refname =3D buf.buf,
+
+		err =3D reftable_writer_add_ref(writer, &ref);
+		EXPECT_ERR(err);
+	}
+	reftable_writer_close(writer);
+
+	/*
+	 * The written refs should be sufficiently large to result in a
+	 * multi-level index.
+	 */
+	stats =3D reftable_writer_stats(writer);
+	EXPECT(stats->ref_stats.max_index_level =3D=3D 2);
+
+	block_source_from_strbuf(&source, &writer_buf);
+	err =3D reftable_new_reader(&reader, &source, "filename");
+	EXPECT_ERR(err);
+
+	/*
+	 * Seeking the last ref should work as expected.
+	 */
+	err =3D reftable_reader_seek_ref(reader, &it, "refs/heads/199");
+	EXPECT_ERR(err);
+
+	reftable_iterator_destroy(&it);
+	reftable_writer_free(writer);
+	reftable_reader_free(reader);
+	strbuf_release(&writer_buf);
+	strbuf_release(&buf);
+}
+
 static void test_corrupt_table_empty(void)
 {
 	struct strbuf buf =3D STRBUF_INIT;
@@ -916,5 +971,6 @@ int readwrite_test_main(int argc, const char *argv[])
 	RUN_TEST(test_write_object_id_length);
 	RUN_TEST(test_write_object_id_min_length);
 	RUN_TEST(test_write_multiple_indices);
+	RUN_TEST(test_write_multi_level_index);
 	return 0;
 }
diff --git a/reftable/writer.c b/reftable/writer.c
index b5bcce0292..0349094d29 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -418,15 +418,15 @@ static int writer_finish_section(struct reftable_writ=
er *w)
 				return err;
 		}
=20
+		err =3D writer_flush_block(w);
+		if (err < 0)
+			return err;
+
 		for (i =3D 0; i < idx_len; i++)
 			strbuf_release(&idx[i].last_key);
 		reftable_free(idx);
 	}
=20
-	err =3D writer_flush_block(w);
-	if (err < 0)
-		return err;
-
 	writer_clear_index(w);
=20
 	bstats =3D writer_reftable_block_stats(w, typ);
--=20
2.43.GIT


--MV57dzLTvkpJQPk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7TagACgkQVbJhu7ck
PpSpHg//fgy2Py/upDJry7a4wOpDLEfJm5afwtKVm53t9awiRWYwGj4Z7Dd7cejf
5I/Yscs9MVISdELSozufQqpP6izAzaAd1MsXyUnOSKVa0OTOlpNHc1yz1pqR7Yta
pt4td9klJUE2ZEvPDdY71JfV/TDCqwSH+jSoXdtUVcwrTjPIpTEaNaytofXqOTwL
58u2dAzAIB9uyobqTKEkGpnWXo6kMxSAeQx3zEAdRmlay11NKpGdn/e1ITzfWdSe
B68TDb5pCJfOrqCQxgkgPADRqKVddl+gAwLbB8pMbbeJ46P1jIgdHzSpkkp2mfpv
Ovse4+MR6O4BQ461LCcVMgz7xmdrd0Wx32wxWMgqfUX5VCAcxOqSehg2dxGAZOvr
kgQ6geV8lmniW1CL1nIDZtAeI0tCS0+nRGn9paJBigcDAWOHt//1zR/ne5GkB2DQ
KCsZH4SIpRhGcBkMTE5fF0a5q0GI7OaLEd7/1q8Khe4hDkLK6a/ai7Qm2O30aNup
HtrhS3SlRCOkDx2fbsJF9mua1cD1R/7cjcG5ok7+qcGSeQrtuL+vGEBoX1jO+vFu
xYFE73STOLabPUwVHydxqt/PpWJMdO90PHIqGGnmWiyPJFCe9XHUMAJa05Y7zmCF
Sh8iPCzrX58n+gPiYQNSWlAzWJFVs4n3NL8xyB5W0jt3zgbpqe8=
=XeLP
-----END PGP SIGNATURE-----

--MV57dzLTvkpJQPk6--
