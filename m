Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397EF42ABC
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166270; cv=none; b=Sbea/MvTz+JKTk6TXyl/z9UDL2leX/3v2SVsyNhhXve8FV12BqcaDEyY91912U/Bp+EhnhmQgyFb4ZqnTqzqU01+8mvaHRjeRTSOCpFaISuoJVKRGAHiijI9hJIjixgUBZ7v8oZuaMj4mbUpDmKue3O84g1//amVRjxrBqCYvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166270; c=relaxed/simple;
	bh=m4ATRuO9WcDfdW1khLM6f0uy8FgeqRJlzxiajFUXC/E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOGnCwwvCtEY4KzO9USoPAF+wEd9S8YXSMoeXkKs14rkDvk9NQgP5S0vcYlnZNVnGO0E2V0R+y5ujQJBYXDIbsmwi6fuqyxoguLbomP/KxUrCLzD9+OrAHz0EcJmnTc8g3NJJIAiWt9p9+SJsMfwD0QobtwygOIqITqG7vEaulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MseoFQDM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFC7mKDo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MseoFQDM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFC7mKDo"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5CC0C1380FDE
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:04:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 May 2024 07:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166268; x=1715252668; bh=RdG7crNCWQ
	EEeLNOiewXH2LsJuj5QXqV+suySLxzCtY=; b=MseoFQDMw4ZhEsWTQ72vd3FoLl
	uvmNIgaY5Lbr3RJLXdLs7RT7kYkS6wFvdcaYzBXyYXKFP2T4wmHmal1nUNpcScE/
	GUx4Jg9Ev7kD3HJk+/ziWu3JxLG0uMM86kH8QLIQYeh4ZcMHOMaIbwhaMoyTdL+D
	hwQ0hflHvdeufSJDUjfZCIvK9CDcnCPzsb3dqXidLjgR2zpNBP9Tt9EDWR8q/hw6
	dr46/ZRzQdFayf5/hONHcq8ukSPCeCtP9sTDQM0vbcEHAUnDXK3ZoJTvI1GFqkgR
	V4Bdt0kMk9QC68PY/cAwGCFb6w3toV0ZGF+ddqlfO52f2kAy3+aeQ9KCAcgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166268; x=1715252668; bh=RdG7crNCWQEEeLNOiewXH2LsJuj5
	QXqV+suySLxzCtY=; b=IFC7mKDo86uqgT1CXhmLPHqA1bKg4fm7wu9EoIgDZN6E
	daZpQvBnk1q8TKYfjZO8vOI4z5U0chNwWF3IhKSjzzsEPiEUnG6F1geSAGmz1wnu
	2hU9nqqxgxl0lB7s36Zo2lUTJLLtdXFzvmrZYSYVbsGohJKKJkKrdl6NjkkFzDYg
	+RwIdXSDNOxwRa+EykVVG+w546LekoqSGWxgFl1lZu1AU7fblMHe8YMy04Cx4S2J
	kJEwLIjq3GzBNybhJJxl328XJqb/OrxZBUeKgYVXcv3J2+3l8XmaU0l5akW3Xdar
	9F0uXbfeKcrpYTmWy35oXjx705xVvb+Ekyst/mA9gw==
X-ME-Sender: <xms:PFw7ZmQ1BM0cPiOFjBoAuJUVLUHMDCAw8zVWuo07_Z0FPrs8ItURhg>
    <xme:PFw7Zryv6Eo9RkfejE0TQFthHz4EkNijFdmr0fWLR_nQXB-KNokyVVfR5-qijCrFt
    HFgIXiWJ8uKIvh6zg>
X-ME-Received: <xmr:PFw7Zj0TpvMrFxKFZYzwsnZQgvVe1JClq_58qg69F-cK-Oe0iB1qtuvaQjTzjfr5sC9Vd1DvaSYFZa9qyABUi3lVfoaDb1-pnn-QTSrY_RXMvGMYcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfeelleettdetvdeggeefhfefheeitdejhf
    ejveffudeludettdefgeeiieetgeehnecuffhomhgrihhnpehosghjpghofhhfshgvthhs
    rdhishenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hpshesphhkshdrihhm
X-ME-Proxy: <xmx:PFw7ZiBrHtpL-lQLnDzqgqkEH2kMjRsDbf6i_cnLqf6Z4ufwnwuy8A>
    <xmx:PFw7Zvgg9vC6kMCORWzij1k2D7XAkKj5NIcqwbVbxh2GOrAT07iWkQ>
    <xmx:PFw7Zup18a865c6oH063lr-Q0f38BDDPltqTsmuGKQxpLkdoTnZKAQ>
    <xmx:PFw7ZigCFewahJ3Q34xpODBjydXyf7Drc9mk5Kv-LIabWkRxlEE4Cg>
    <xmx:PFw7Zna6a3lf2MRCt4x13meW-I99AZV5Q0fMd6HhfoPd54tuKbGib8i4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:04:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c86a2cc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:04:17 +0000 (UTC)
Date: Wed, 8 May 2024 13:04:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/13] reftable/reader: adapt interface to allow reuse of
 iterators
Message-ID: <f688f8f59a05b667b4f4118b7f8c7504bd33329a.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WNLuOB/cH8miQSjv"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--WNLuOB/cH8miQSjv
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
index 4a4bc2fdf8..35b9fb66e4 100644
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
+/* Initialize a reftable iterator for reading refs. */
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
2.45.0


--WNLuOB/cH8miQSjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XDgACgkQVbJhu7ck
PpQx1w//QRRkgXxnw3NDQxko9Wpxh3f8+ddsU1SrkLxLQGnE0VbNpGraiSC+NMUe
PfT3tdm3wE2b3AdCrJfV50/P3qfpLA+pwI29xBCJ8VmwmvfqPg65qQyNmc05vgFP
ZtMgJHrfxpUeAI/mio+K1ThQypOlVTj+lCbk05KdasDxrL0KYRoMW8hK2tDIbQzq
u00qpqSc5SdLf29kpJyapOUF7u7hRdOkDwwbZxe79c6k0s+FxV7GRHPC5AdFFsvP
X+iXaMH5O6onWk0BaNRLa3i5NIIpjDCjt4ACxllxZaEvXgGWxdabvAetvWU7ZHZV
0NPvToF2+ITm60RbMPELQjFOtqBFRNv5gxSKEIBnrUaJaOWpikMc9nURq2Xpfltu
xMaGEtQRVBofhU0MHCONcQhh7JGHrB3ktGpVQkSHRidRlOkunl+Fpgms+7ueqft5
rLxns12sQeO6c5wIyXXHwo+M9r3GZJwqx7FrG49AXhrhIZY7c/rzi5W/EA8JHwNd
ByTt6BMa+njtsQxtH/fA8bRfIgzavsc61CCIWlwabo+1QTp74pS8Tpzqf0KDrhkv
vDe+hlPfim3vtLklNjo/hIGICNeF2HllP99xR03nbkE9+3pT+hc22ZrJLscv0iil
Fu29yOaPMiV7y9CyOuWWCEP8fnOE72SsyA92ktegyBP5RgQBsvE=
=01uh
-----END PGP SIGNATURE-----

--WNLuOB/cH8miQSjv--
