Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF2146A98
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590077; cv=none; b=arNWwpsUGdONWzuC8PHqHPR3ErMN/p/2q9ChERMUYvwv87VPT3COEUAZW7bvVGahmgdB5Som2OjICKFftW8UKUb5WRp6ycO7siPljg3tKiENwD/6MrftD228gUTbTkrVUoyi4uXFfmpYJPybjGaUHnoMLQZSBc+Qti2kJO5gCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590077; c=relaxed/simple;
	bh=kF4Pnx5zR/vtKIi7nIFh1h3dOXH22SN+24bh68IazCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn51JU50t8mIVdPXlcgy3FSNcYU1zU9RJKbdS0m83B8ppMaCZTgsywSbWfZts2o+5+asp+bxGqevAGjEuWZJgqeRpp6PyyEwRITPssg9z9q7D3Qr3yCi0B1T0iDidrGkjue63hQGN2l23zT3PT7Uvnf3eJef04ETRrOIIwPqMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tJPl5tid; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jzgYwkzP; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tJPl5tid";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jzgYwkzP"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 6AC871C000E3;
	Mon, 13 May 2024 04:47:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 13 May 2024 04:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590075; x=1715676475; bh=oDSx4O1DdP
	DnXTNU+VrbiULKCzP5hm9rw/H9XPM8sN0=; b=tJPl5tidVqiBKyESSdas/F0dif
	8zb1ZTYzAFLU6zhF3ySjKpxykDkMZxnN6Xh9GP7yhjRQMwsEL7Vyzqqz+puv0zYu
	cGgKZBrVZxUWU7CS3TGPURcIRmsPD8TQbHqQkEQfbPNeO94l+OManKTpcqUciFpV
	PdxsaYn3xb3blXe0Cipk4vm5DYyWBD9s13lV7MtSLSWyr1P37KBJ1DoKomTsIuQm
	0ajbB7qbvWN4tjM4dqehkpthKwTP9SESAfPcTX3zkCQ7/mOINdQlThwBCa48P8+U
	ZqFwAngDb75Tkr3DcTCUaRoECnphf8E4fcofkFoNzLv8wuULvOUm5zIEIG2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590075; x=1715676475; bh=oDSx4O1DdPDnXTNU+VrbiULKCzP5
	hm9rw/H9XPM8sN0=; b=jzgYwkzPXNTM4KYtW6WQ0BtPWQ5ChoLwfaPkBuYtMlvr
	JqC4t3FDbXTAHz6UmJbsowJnBAP1rQOv8mRf27vkdpPMsWO55teFyzYRKdAs04Ac
	qdUaqQFiO1R9v17t+4c4hiV/qUDu2F5e8Wwx4i6RFNoygChR1t3bZ1JuiMZSrjJy
	PeNElIiKo03geiJfzZQhFVlWajvsBkoI4bVTiDf0hvAgZtd3bkOWb7u1c+XNotXH
	6Hst0yajRDcWZRWNQHrVHkscch5ox+peaJ2+Md3UHYsyFWY0zbNuQicObkpCvtvv
	2C4hYerbxDwskBJrybaku/bNiCRy8gTkDJjRhbJkkA==
X-ME-Sender: <xms:utNBZpT4oO1e0qIo3JmIrFtIh-EgfllGthI8dyQ9BBxCChO_W6gGmw>
    <xme:utNBZizrRJXQE7QPXOytdVnT2MVhRayCV6ls_absqJQbi6j1AYqczHTwEAvzwJ1p9
    uDKdktTi7W2og2W9w>
X-ME-Received: <xmr:utNBZu0BkmXR6bOVPa_x-Zty9e6sKynz-sMv1m2N9SGPArlsaccGWTmMpDkutzN9i9ibjrX0xiQHzmMNDWCmtkA34J4YMB9h-1p1Iku0ZmZ9TZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvefhuefhudetfeeltedvheeufeejuddtueeiieeitdeffffhieevuedukeevteeg
    necuffhomhgrihhnpehosghjpghofhhfshgvthhsrdhishenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:utNBZhAsRf5KvyMmgf6Ho1gOzHIxIFnUxq7Kkod7yUb1vvjFd6n8jg>
    <xmx:utNBZijnDST0u69tn4_b04wZPoWcMA0XWUW3Kw5M3CnTzHaNJNsa8Q>
    <xmx:utNBZlr4XyGh4VR-0ygSHdxns_Wo0CuVJ_VTNZoVtK1Vot686Aa1kQ>
    <xmx:utNBZtgrk-CXI9KyYenkDlrASc9_SarOs2A9FzCfO186VvNrGa4Z0Q>
    <xmx:u9NBZjtPSZkzym5ZXIpqSEf7jnTE4do98hYZVtaP86jSS6CRU_aohAJa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:47:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 239f03fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:47:35 +0000 (UTC)
Date: Mon, 13 May 2024 10:47:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 11/13] reftable/reader: adapt interface to allow reuse of
 iterators
Message-ID: <07459516508c6982ad185c5f9409be523878bc50.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KLY5ZiH7nRMAd3iP"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--KLY5ZiH7nRMAd3iP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor the interfaces exposed by `struct reftable_reader` and `struct
table_iterator` such that they support iterator reuse. This is done by
separating initialization of the iterator and seeking on it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c          | 31 ++++----------------------
 reftable/readwrite_test.c  | 35 +++++++++++++++++++----------
 reftable/reftable-reader.h | 45 ++++++--------------------------------
 3 files changed, 35 insertions(+), 76 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index a5a13cb0b9..bbdb4bdafa 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -621,39 +621,16 @@ static void reader_init_iter(struct reftable_reader *=
r,
 	}
 }
=20
-int reftable_reader_seek_ref(struct reftable_reader *r,
-			     struct reftable_iterator *it, const char *name)
+void reftable_reader_init_ref_iterator(struct reftable_reader *r,
+				       struct reftable_iterator *it)
 {
-	struct reftable_record rec =3D {
-		.type =3D BLOCK_TYPE_REF,
-		.u.ref =3D {
-			.refname =3D (char *)name,
-		},
-	};
 	reader_init_iter(r, it, BLOCK_TYPE_REF);
-	return iterator_seek(it, &rec);
 }
=20
-int reftable_reader_seek_log_at(struct reftable_reader *r,
-				struct reftable_iterator *it, const char *name,
-				uint64_t update_index)
+void reftable_reader_init_log_iterator(struct reftable_reader *r,
+				       struct reftable_iterator *it)
 {
-	struct reftable_record rec =3D {
-		.type =3D BLOCK_TYPE_LOG,
-		.u.log =3D {
-			.refname =3D (char *)name,
-			.update_index =3D update_index,
-		},
-	};
 	reader_init_iter(r, it, BLOCK_TYPE_LOG);
-	return iterator_seek(it, &rec);
-}
-
-int reftable_reader_seek_log(struct reftable_reader *r,
-			     struct reftable_iterator *it, const char *name)
-{
-	uint64_t max =3D ~((uint64_t)0);
-	return reftable_reader_seek_log_at(r, it, name, max);
 }
=20
 void reader_close(struct reftable_reader *r)
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index a6dbd214c5..d99543bbd6 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -239,7 +239,9 @@ static void test_log_write_read(void)
 	err =3D init_reader(&rd, &source, "file.log");
 	EXPECT_ERR(err);
=20
-	err =3D reftable_reader_seek_ref(&rd, &it, names[N - 1]);
+	reftable_reader_init_ref_iterator(&rd, &it);
+
+	err =3D reftable_iterator_seek_ref(&it, names[N - 1]);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_iterator_next_ref(&it, &ref);
@@ -252,7 +254,9 @@ static void test_log_write_read(void)
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
=20
-	err =3D reftable_reader_seek_log(&rd, &it, "");
+	reftable_reader_init_log_iterator(&rd, &it);
+
+	err =3D reftable_iterator_seek_log(&it, "");
 	EXPECT_ERR(err);
=20
 	i =3D 0;
@@ -330,7 +334,8 @@ static void test_log_zlib_corruption(void)
 	err =3D init_reader(&rd, &source, "file.log");
 	EXPECT_ERR(err);
=20
-	err =3D reftable_reader_seek_log(&rd, &it, "refname");
+	reftable_reader_init_log_iterator(&rd, &it);
+	err =3D reftable_iterator_seek_log(&it, "refname");
 	EXPECT(err =3D=3D REFTABLE_ZLIB_ERROR);
=20
 	reftable_iterator_destroy(&it);
@@ -358,7 +363,8 @@ static void test_table_read_write_sequential(void)
 	err =3D init_reader(&rd, &source, "file.ref");
 	EXPECT_ERR(err);
=20
-	err =3D reftable_reader_seek_ref(&rd, &it, "");
+	reftable_reader_init_ref_iterator(&rd, &it);
+	err =3D reftable_iterator_seek_ref(&it, "");
 	EXPECT_ERR(err);
=20
 	while (1) {
@@ -412,7 +418,8 @@ static void test_table_read_api(void)
 	err =3D init_reader(&rd, &source, "file.ref");
 	EXPECT_ERR(err);
=20
-	err =3D reftable_reader_seek_ref(&rd, &it, names[0]);
+	reftable_reader_init_ref_iterator(&rd, &it);
+	err =3D reftable_iterator_seek_ref(&it, names[0]);
 	EXPECT_ERR(err);
=20
 	err =3D reftable_iterator_next_log(&it, &log);
@@ -457,7 +464,8 @@ static void test_table_read_write_seek(int index, int h=
ash_id)
 	}
=20
 	for (i =3D 1; i < N; i++) {
-		int err =3D reftable_reader_seek_ref(&rd, &it, names[i]);
+		reftable_reader_init_ref_iterator(&rd, &it);
+		err =3D reftable_iterator_seek_ref(&it, names[i]);
 		EXPECT_ERR(err);
 		err =3D reftable_iterator_next_ref(&it, &ref);
 		EXPECT_ERR(err);
@@ -472,7 +480,8 @@ static void test_table_read_write_seek(int index, int h=
ash_id)
 	strbuf_addstr(&pastLast, names[N - 1]);
 	strbuf_addstr(&pastLast, "/");
=20
-	err =3D reftable_reader_seek_ref(&rd, &it, pastLast.buf);
+	reftable_reader_init_ref_iterator(&rd, &it);
+	err =3D reftable_iterator_seek_ref(&it, pastLast.buf);
 	if (err =3D=3D 0) {
 		struct reftable_ref_record ref =3D { NULL };
 		int err =3D reftable_iterator_next_ref(&it, &ref);
@@ -576,7 +585,8 @@ static void test_table_refs_for(int indexed)
 		rd.obj_offsets.is_present =3D 0;
 	}
=20
-	err =3D reftable_reader_seek_ref(&rd, &it, "");
+	reftable_reader_init_ref_iterator(&rd, &it);
+	err =3D reftable_iterator_seek_ref(&it, "");
 	EXPECT_ERR(err);
 	reftable_iterator_destroy(&it);
=20
@@ -639,7 +649,8 @@ static void test_write_empty_table(void)
 	err =3D reftable_new_reader(&rd, &source, "filename");
 	EXPECT_ERR(err);
=20
-	err =3D reftable_reader_seek_ref(rd, &it, "");
+	reftable_reader_init_ref_iterator(rd, &it);
+	err =3D reftable_iterator_seek_ref(&it, "");
 	EXPECT_ERR(err);
=20
 	err =3D reftable_iterator_next_ref(&it, &rec);
@@ -846,7 +857,8 @@ static void test_write_multiple_indices(void)
 	 * Seeking the log uses the log index now. In case there is any
 	 * confusion regarding indices we would notice here.
 	 */
-	err =3D reftable_reader_seek_log(reader, &it, "");
+	reftable_reader_init_log_iterator(reader, &it);
+	err =3D reftable_iterator_seek_log(&it, "");
 	EXPECT_ERR(err);
=20
 	reftable_iterator_destroy(&it);
@@ -901,7 +913,8 @@ static void test_write_multi_level_index(void)
 	/*
 	 * Seeking the last ref should work as expected.
 	 */
-	err =3D reftable_reader_seek_ref(reader, &it, "refs/heads/199");
+	reftable_reader_init_ref_iterator(reader, &it);
+	err =3D reftable_iterator_seek_ref(&it, "refs/heads/199");
 	EXPECT_ERR(err);
=20
 	reftable_iterator_destroy(&it);
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index 4a4bc2fdf8..52e4942b7b 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -36,48 +36,17 @@ struct reftable_table;
 int reftable_new_reader(struct reftable_reader **pp,
 			struct reftable_block_source *src, const char *name);
=20
-/* reftable_reader_seek_ref returns an iterator where 'name' would be inse=
rted
-   in the table.  To seek to the start of the table, use name =3D "".
-
-   example:
-
-   struct reftable_reader *r =3D NULL;
-   int err =3D reftable_new_reader(&r, &src, "filename");
-   if (err < 0) { ... }
-   struct reftable_iterator it  =3D {0};
-   err =3D reftable_reader_seek_ref(r, &it, "refs/heads/master");
-   if (err < 0) { ... }
-   struct reftable_ref_record ref  =3D {0};
-   while (1) {
-   err =3D reftable_iterator_next_ref(&it, &ref);
-   if (err > 0) {
-   break;
-   }
-   if (err < 0) {
-   ..error handling..
-   }
-   ..found..
-   }
-   reftable_iterator_destroy(&it);
-   reftable_ref_record_release(&ref);
-*/
-int reftable_reader_seek_ref(struct reftable_reader *r,
-			     struct reftable_iterator *it, const char *name);
+/* Initialize a reftable iterator for reading refs. */
+void reftable_reader_init_ref_iterator(struct reftable_reader *r,
+				       struct reftable_iterator *it);
+
+/* Initialize a reftable iterator for reading logs. */
+void reftable_reader_init_log_iterator(struct reftable_reader *r,
+				       struct reftable_iterator *it);
=20
 /* returns the hash ID used in this table. */
 uint32_t reftable_reader_hash_id(struct reftable_reader *r);
=20
-/* seek to logs for the given name, older than update_index. To seek to the
-   start of the table, use name =3D "".
-*/
-int reftable_reader_seek_log_at(struct reftable_reader *r,
-				struct reftable_iterator *it, const char *name,
-				uint64_t update_index);
-
-/* seek to newest log entry for given name. */
-int reftable_reader_seek_log(struct reftable_reader *r,
-			     struct reftable_iterator *it, const char *name);
-
 /* closes and deallocates a reader. */
 void reftable_reader_free(struct reftable_reader *);
=20
--=20
2.45.GIT


--KLY5ZiH7nRMAd3iP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB07cACgkQVbJhu7ck
PpRgeBAApDWLnejTXY2bdiQot7NkA9sSiK7QSE+Eaj4PuJPfe/M43cS3N+UOOJzu
ddI76c55nCmGIH+VdmfYBLyf0iEzwpL9hxNnW5p8ImFh/bhPfBCq5xErtQlCpoPT
CNVH+wIDQ5yck4f5b0s+1lvuAnVoYKiZg6qtnUQE1bGhOVTJ0Zw8pTTQWl2sKXsB
nX5Z3PBWG0O6dT5HxGO/Lgo0+FFdihvG+9+ADmyu9tPfbRlNucTeTqMIebBrgac8
jNtfmHuhqPGIynrY8cMLXuDmGWXbZ1PWU7QgeZdEx0TiAPIWH6qL/iEqVDcq6PX5
Pp2RD9WyAL+2w5JJUkmmciNZXAQVW2GHPp32Zbr8z2EALDLAkNs3AZRq1tPWEvYI
mrvF+Rz1f2A6QtZxQjZmjhJg9lY9tFZg6I7Ausj2HoazKJAl/JySlFTfs05TOaAE
6pcoAPH4sIWavPEXfLPlYnEopv5iUlJTbbqaklroj/G3pQlpbF9IYX4C7I47dKFO
hPiiP9WiZHnbYRIU4rqnmzaWM9FVRpO/dHgjOVqLZ3Y0H2T/fM5ryB8uEdacRiLj
mwVp4XsnsqcjgOCmPlrffgU8AfFXHJ9+FGsI46WMJdNMTtBv/NTRumLMTWvLJ99n
W2zSqeaeF4P69Q0BVcELfOBmn5Lwio5Sim6HE+XN5qjzpTNWkzI=
=Yyrd
-----END PGP SIGNATURE-----

--KLY5ZiH7nRMAd3iP--
