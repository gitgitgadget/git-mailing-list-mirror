Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C81B80E
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265112; cv=none; b=gbZnyprs0dpAjd0h4TI3KRJgsVf1K2REgGjgYdFqTHUZqVgaFnhPWwI/JkjIIjWWLKBMRYRqGoCB7FszKwbThIUBssc5e2dj822JXcg4SICnRsewnx/ZHkq+alyiahN0tBlHycUT7uQ8NT4apMJi3psYiAEyhKOZSoCnK/XMFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265112; c=relaxed/simple;
	bh=9agBEGZ14TW/0p4Jn3XtRYZeYDyf/ycS72CW7kW/oTQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrK2DHq+dJYgp/YFQ0O5OiJFbwU0GrUslRTmaSGddKKempO6BQzbthRTA1Srmmsdv+WIXbGVkahDrksPyxwRduItZ4jogMhf5elJcVutDRDSBrnkdBtFyjogOG7DaarzpFgbxRfKXOpf2sfN87JDgLTd6wB+PwtRcWLwKUtCxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RH7O70b+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvY0l62h; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RH7O70b+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FvY0l62h"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 2AB795C010A
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 26 Jan 2024 05:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706265110; x=1706351510; bh=jvloKCGrbR
	9bszjIT6AOagvyaB1YMCFqsOlZidWApXM=; b=RH7O70b+0UkUxR/EUhWVG9cJ89
	luHlYL4sUMFKDpy85m9wEoznZHgYreDOD4nZmO9eGbITmd4zMPvrwb+sTmrZj8fP
	0FyBAXxdp+Nup6lf//LaNHSCl4nuYpbj4EnpZtBQRdxOeZDN8MQN4Mom08tWNwov
	Y1OMQXmktbHBwsF6PTk2lMymuSGtdmKgbCz+3RyHTIi8vjXj8reXlbkzP7Eq0frt
	bbPpVJRgS3QvluznA3pkQQVQ7u4enQMiX9D3t4Q7FZfLZ4CIPaGYfFcVQ3fZEXh8
	lgfwdhWaH3juB291iOl6pQ8/FDTLNTqGR9m0YXDVuMXfAnsboVdKJbc6uR5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706265110; x=1706351510; bh=jvloKCGrbR9bszjIT6AOagvyaB1Y
	MCFqsOlZidWApXM=; b=FvY0l62ho7Xg9GhS1+sVoyieucixD4hN57WdecsFOU4/
	qM6Nzi+IGfo9g1PfiaG4JJbAXFQkn0TEkmCJt8YZKST9kooepZxt5MFKp/gz8W/8
	wFfYYx+AbXfmTgs8M5sjUv+uuGN8KEse6B2PCr3Ut0p72CMQQ+GdHa/RhiyP16kJ
	HXI9GDQSgQ4HhdXiQYX0ysB9k0ja4zYyLavb7bClqu0XNA7xRn1x5kGKfciPwZlo
	lc4NyecTT2W0+Fw6cb2PeFqhvMzchc0+3+fFjhTJckA0isJAPwGZONdt82X4vJU+
	D2pqaERMatmYqeyqEMoBsD3azuFPyk1yfWfhUvcf+Q==
X-ME-Sender: <xms:FYqzZXDWDkDI4Gvm2JFdn6ArQgqkKaDHrGGpm9cq2r1hIDITyD46tw>
    <xme:FYqzZdgJMLKGjRWHjEem2jE4aiTh1faMl3x8HP2YXTiFtECk2wZgWE26uUtvL8tva
    KkYnLNHkLQFGwRCHA>
X-ME-Received: <xmr:FYqzZSmZzGFeWaNAqDgWpGzCfcFEoHPLWFaMdfRWkPkiYsf4yZuN7D4pYXpAdc7-b-NLNOFUEURZ80E4WWoSyNIiCq0Ek5LsCC7EpuDRCgMbBYNolA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FoqzZZx4Z3qb-V61VtTA8hTx2GrPTW7cBZ9ho7bzjBsanOe8U7cAYQ>
    <xmx:FoqzZcRGfsgfcynICXJYGAOFdBaXecwSH3j1b7e5BQxttgl52eJykQ>
    <xmx:FoqzZcbV7oaP0zZl8QqI4hLJZ3y5-KinEqvnFKfF2bxFiamNQH4Fhw>
    <xmx:FoqzZbOfStI0ymjWynvftPoGk8O_e9u1VDKoTwPE6mlQLVIEttbbIw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d5a041e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jan 2024 10:28:39 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:31:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/5] reftable/writer: fix writing multi-level indices
Message-ID: <9c6622c4095a00f91885a3f96863f81a7b342f84.1706263918.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="haAYjUqBHaFQpaSK"
Content-Disposition: inline
In-Reply-To: <cover.1706263918.git.ps@pks.im>


--haAYjUqBHaFQpaSK
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
index 2525f236b9..24fce5630a 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -419,15 +419,15 @@ static int writer_finish_section(struct reftable_writ=
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


--haAYjUqBHaFQpaSK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWzihIACgkQVbJhu7ck
PpTU6g//U3WZnxeW8zl/4mcpOrTGv6sFJGU3oCUx6DmVfUkNJbB0LEKDhksAvKrl
yTPcwy01KZ3DrmeqaTEiVsqm9HEkBftBIQihQRAIuShpvkddlO4+67belJXa3WD/
V64vjLmWadtcwZWLjgbzfUYw/7ajknLIHVyfsz2pEH1wrvcbgCsrkqCTiXk5KfqF
0lyeypjy9E6FMTMLyIAZQVEgoLi/vpX+S7QSasb/UFfp6DyxkakAL2r8U8W9LTc/
vsWJu+mYttGJFQnhOBYYbfaq2R3JwF4tOeErmyigVCe3d0T7C/jlcf29p33y0QRI
X4EhKuHEO5hNCUcdiVExmg9gcEZ/R8n+otm7kRHi680nLPFhNxAPSk6OUiUY4zix
6Vz9zXP1H6qJ+qSoHK6eU+XNVAmPJqLZJigBO5SS0BlUCU4sQEKPmsPVdEMox4kd
GRm6YE7Dzk4EpK5xiNPfuy93txLtXWIPXMyr4tqcoAuPZ6rxAFjMlbLFIa6H9AtX
Gr8MyxSSg4uapgdapjdsjPEDvfdCdCd7jx8wJMUo+Xqki1/MjDqzzz0AMfHhht1B
dYbeQ4IK4u7WIdjjUBP6YWABblpb3I6/52etw76zjfeJSfDp/PePlL2nA9Fbw7M7
7fqyCMR+bxeNCdGqzqRXKQLiYu2u1f7wj0WmdJ2Ja97r3UMQkYA=
=uj6Z
-----END PGP SIGNATURE-----

--haAYjUqBHaFQpaSK--
