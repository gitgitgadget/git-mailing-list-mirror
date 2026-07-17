Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17EC3BFAD5
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280748; cv=none; b=U/P6O1D4EAieiJ/Q38hHAZ5yybs96tEd2A6s7AVJdu3TjtOnFoo9hF6PjMrlx5w24IQNGNPReOskTjAjTvAffc/sTsmyuW4n0YVS2GbYUPFt/ZRCXMUEThPkakmmIGX1QYkxylVBrL5RV3AfzF1AQxmrkf8WH6N6IXyJMq2I2qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280748; c=relaxed/simple;
	bh=LCIP8tutkbzP9CoHjNP/KL8aocHUffsUvU42T4Nb3yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RcgAoWy7og8WJ9XyI3G2aIrIXYKFJr2XNq+i/sQxyxkgVLeq2JSwB1xV0jk5gmVA3ohpjZwC2UvdOcJ5NX2SjJ5Pqt4AEyMIwECZsF2dJ+SC2YGfmebIMERtN/anPNBmYvtZu8oe83XU+vldFn40Vmn3U76NLk5maRwgTW943m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dEAf8Ki2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a7JYJmar; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dEAf8Ki2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a7JYJmar"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 240EF7A00AC;
	Fri, 17 Jul 2026 05:32:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 17 Jul 2026 05:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784280745;
	 x=1784367145; bh=LiiBBfR4dWvFKR4Uq1Po9ys4h1n6gLVB2KfDe7Uiygk=; b=
	dEAf8Ki2mBTjmUQYWTlcghDZn/Ptiv1pHZJBTIKHAc2GYnhr5lDzryWUZ37ChnZP
	mai0ajpgpvVu346ibyhSdXxx8lbEfdfHoZsqO3A9H4D98gZtUlbm+cS8RdKs3kDx
	I26jkX0fVEZwkfS8GzDMigydDSNuatmaIMZD9QLkPG78naP0aj+n6ZZTSceJOHsx
	06PtAfb1wQ6uAjIuM2Z1VOZ/eX47xB7o6bjAHBR6BxpbfYX9AIMViHRj+k1wbNzB
	/Q5iH8pOAU7tx72ls8v1ynKhZ+eVugcplmQnP83zKApVaiC3d/5PaSws5iLjjuVK
	hX3qkfRc/kR/GVFLfi3vMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784280745; x=
	1784367145; bh=LiiBBfR4dWvFKR4Uq1Po9ys4h1n6gLVB2KfDe7Uiygk=; b=a
	7JYJmarzqjqfXCVjjwI17Ng5zjO37I3tQafCjXTLVtR8i3devz8RHAc1B1mMwyiF
	e7A0QUNj5k6zuNGWywO7TZQccKMPb5RJ5NUUQk0s4jodTC9IyasY/gA3fsaOMNPz
	9VlPNOzZ1QWdyt/zlTxqjh8IKHKYFypo84Pwu4bQCJuSC7mudD8nwUGl6i4jwhjP
	ek2TN5kff4/u8JBeAoLIOPOJVn0lK+Ka+qF5rxiq+pvWBAVL4G+8SqzcId559dAO
	te26tlIiW6WFCvdWARhHpFG9pMdbX0fMpoZnvGWM5aK/9CRyNOlAdiVOr7HIgVDf
	JaZLOFp4iOR/8k5/IgWRQ==
X-ME-Sender: <xms:qfZZaoIFWcDLR_t77yEA1sTjKXJ0x4ncOIVukAVlakBxmgR9QHmQJg>
    <xme:qfZZauLDRYlIb8r8Ml6249TqgKgJILPem3WwKPrRo7k08g0Ap02Ycp5LljUtF05zh
    w0tTp5YaFNFf7-fpHUJFfP3IQujrUY-vsL-sA-NSPt_SXzLNWJK>
X-ME-Received: <xmr:qfZZamVpUuV-72o9IUvecCbkL3wfnFZpzIzehh7IlXyElE_O_klib8tl2oICINQHO_1DBqNRu9FprkfKPYwv6hDAcOnuf9vKpeqSu8apDe8>
X-ME-Proxy-Cause: dmFkZTEPgWsCPQv+zxSWEft837Na6Ert1SlmN3P5ZmZ6YVgwDD0i8FWTKtTHRWTsiWlqAf
    Ee3/fhnAtu7H1tpfszCQ9TpTtYDRq9/Ej+1toGtU2M4Btlsq1pdMD6WQ1yGfoiLr4szbCI
    waU9J+ehUfgAu5Wanq56c7n6wqTMKgid98yVYjCsZ3lgk6w6eA2/c75Y8tf8tburLwkElo
    WIveSLuviSET+E2Li1iK4PFXEMXOIYmHGdAPQjQZ/ZM4k+MBe94Ic0rS1bAkMoxhgnze0d
    MvjikpHRu8nDYV0sOz9NDUBG04xBQks3AtbvI4iyZ3NLFDV9y0pp6sScxFsmkkVul8TkRR
    8iFnq8MvIgxEWd/uxSGF1e20eV7v6Jk7DQ++VwdwlMyYV0z+PQ+1gX6EmSspFj/LArfV2D
    3HauOwFLs5E4r8n0Aufkd29ugMxSmfMBIVNuyqCkiQyXjPSdWgxoEY6hJ5j7MlV7D7QVQg
    o1z2sJ/Sjer8siVmT7eYgQZJm9Gf8lvU8tGjk9wWHc24j2TJHD47YbFSA8KpMXNX8RPs1k
    6SdqaPNo/Lw+7AgpYut/dARrVleQE3Zse2e0+J+WFwlnDzCoZGk/6xL1RLG79cSFPDVx2H
    QgustHjCefdzJGOE3UZgiKmKfPqIfzuGpbqDcFwoocJB7YP+FaibvJnEps8A
X-ME-Proxy: <xmx:qfZZagjnvZV8fPucPa9FJSAhBVFxskF8muoA4dWoCJlsAkuDSjZftQ>
    <xmx:qfZZah8MkzTq9c3DGf8i_5B_lfcqEmQw2g4W-98RxdURpEf3a1vqyg>
    <xmx:qfZZaqDuqyvaB-uHUkC4mSIO6Mhlvh9GI2zqepXdbzYfx2NxkkvejA>
    <xmx:qfZZauIMrad1hfacEvAzut-YvdW-IDRsSp2xrysrLHKTQADQLI4T8g>
    <xmx:qfZZap4I9dch45B8cZSGll9fHC0_J15WjVz2LRtR4i9bXjunmSZJgc-2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 05:32:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31ed799d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 09:32:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jul 2026 11:32:11 +0200
Subject: [PATCH 3/9] odb: compute object hash in `odb_write_object_ext()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-pks-odb-move-loose-object-writing-v1-3-46446a3cb5b7@pks.im>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Same as in a preceding commit, compute the object hash in
`odb_write_object_ext()` so that we can unify this logic.

Besides unification, this change also allows us to lift the object
existence check out of the "loose" backend into the generic layer, which
will happen in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c                 | 35 ++++++++---------------------------
 object-file.h                 |  4 ----
 odb.c                         |  2 ++
 odb/source-files.c            |  2 +-
 odb/source-inmemory.c         |  6 +++---
 odb/source-loose.c            | 12 +++++++-----
 odb/source-packed.c           |  2 +-
 odb/source.h                  |  4 ++--
 t/unit-tests/u-odb-inmemory.c |  1 +
 9 files changed, 25 insertions(+), 43 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5283292f1e..9ca14f484d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -316,31 +316,6 @@ int parse_loose_header(const char *hdr, struct object_info *oi)
 	return 0;
 }
 
-static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
-			     const void *buf, size_t len,
-			     struct object_id *oid,
-			     char *hdr, size_t *hdrlen)
-{
-	git_hash_init(c, algo);
-	git_hash_update(c, hdr, *hdrlen);
-	git_hash_update(c, buf, len);
-	git_hash_final_oid(oid, c);
-}
-
-void write_object_file_prepare(const struct git_hash_algo *algo,
-			       const void *buf, size_t len,
-			       enum object_type type, struct object_id *oid,
-			       char *hdr, size_t *hdrlen)
-{
-	struct git_hash_ctx c;
-
-	/* Generate the header */
-	*hdrlen = format_object_header(hdr, *hdrlen, type, len);
-
-	/* Hash (function pointers) computation */
-	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
-}
-
 #define CHECK_COLLISION_DEST_VANISHED -2
 
 static int check_collision(const char *source, const char *dest)
@@ -476,10 +451,16 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		      size_t len, enum object_type type,
 		      struct object_id *oid)
 {
+	struct git_hash_ctx c;
 	char hdr[MAX_HEADER_LEN];
-	size_t hdrlen = sizeof(hdr);
+	int hdrlen;
+
+	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 
-	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
+	git_hash_init(&c, algo);
+	git_hash_update(&c, hdr, hdrlen);
+	git_hash_update(&c, buf, len);
+	git_hash_final_oid(oid, &c);
 }
 
 struct transaction_packfile {
diff --git a/object-file.h b/object-file.h
index d04ffa6493..08aafcda0d 100644
--- a/object-file.h
+++ b/object-file.h
@@ -134,10 +134,6 @@ int finalize_object_file_flags(struct repository *repo,
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		      size_t len, enum object_type type,
 		      struct object_id *oid);
-void write_object_file_prepare(const struct git_hash_algo *algo,
-			       const void *buf, size_t len,
-			       enum object_type type, struct object_id *oid,
-			       char *hdr, size_t *hdrlen);
 int write_loose_object(struct odb_source_loose *loose,
 		       const struct object_id *oid, char *hdr,
 		       int hdrlen, const void *buf, unsigned long len,
diff --git a/odb.c b/odb.c
index 1d6538163b..4adbdf8a64 100644
--- a/odb.c
+++ b/odb.c
@@ -995,6 +995,8 @@ int odb_write_object_ext(struct object_database *odb,
 	const struct git_hash_algo *compat = odb->repo->compat_hash_algo;
 	struct object_id compat_oid, *compat_oid_p = NULL;
 
+	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
+
 	if (compat) {
 		const struct git_hash_algo *algo = odb->repo->hash_algo;
 
diff --git a/odb/source-files.c b/odb/source-files.c
index 3d9f5eca32..06dfc8dd78 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -162,7 +162,7 @@ static int odb_source_files_freshen_object(struct odb_source *source,
 static int odb_source_files_write_object(struct odb_source *source,
 					 const void *buf, size_t len,
 					 enum object_type type,
-					 struct object_id *oid,
+					 const struct object_id *oid,
 					 const struct object_id *compat_oid,
 					 enum odb_write_object_flags flags)
 {
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index e727aba427..963d520317 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -230,15 +230,13 @@ static int odb_source_inmemory_count_objects(struct odb_source *source,
 static int odb_source_inmemory_write_object(struct odb_source *source,
 					    const void *buf, size_t len,
 					    enum object_type type,
-					    struct object_id *oid,
+					    const struct object_id *oid,
 					    const struct object_id *compat_oid UNUSED,
 					    enum odb_write_object_flags flags UNUSED)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
 	struct inmemory_object *object;
 
-	hash_object_file(source->odb->repo->hash_algo, buf, len, type, oid);
-
 	if (!inmemory->objects) {
 		CALLOC_ARRAY(inmemory->objects, 1);
 		oidtree_init(inmemory->objects);
@@ -285,6 +283,8 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 		goto out;
 	}
 
+	hash_object_file(source->odb->repo->hash_algo, data, total_read, OBJ_BLOB, oid);
+
 	ret = odb_source_inmemory_write_object(source, data, len, OBJ_BLOB, oid,
 					       NULL, 0);
 	if (ret < 0)
diff --git a/odb/source-loose.c b/odb/source-loose.c
index ca223109cd..d4715da6d1 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -584,19 +584,21 @@ static int odb_source_loose_freshen_object(struct odb_source *source,
 
 static int odb_source_loose_write_object(struct odb_source *source,
 					 const void *buf, size_t len,
-					 enum object_type type, struct object_id *oid,
+					 enum object_type type,
+					 const struct object_id *oid,
 					 const struct object_id *compat_oid,
 					 enum odb_write_object_flags flags)
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
-	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
 	char hdr[MAX_HEADER_LEN];
-	size_t hdrlen = sizeof(hdr);
+	int hdrlen;
+
+	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 
-	/* Normally if we have it in the pack then we do not bother writing
+	/*
+	 * Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 	if (odb_freshen_object(source->odb, oid))
 		return 0;
 	if (write_loose_object(loose, oid, hdr, hdrlen, buf, len, 0, flags))
diff --git a/odb/source-packed.c b/odb/source-packed.c
index af0d533375..f7f1706447 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -529,7 +529,7 @@ static int odb_source_packed_write_object(struct odb_source *source UNUSED,
 					  const void *buf UNUSED,
 					  size_t len UNUSED,
 					  enum object_type type UNUSED,
-					  struct object_id *oid UNUSED,
+					  const struct object_id *oid UNUSED,
 					  const struct object_id *compat_oid UNUSED,
 					  unsigned flags UNUSED)
 {
diff --git a/odb/source.h b/odb/source.h
index b3c1ca3a66..c4e94c9d0d 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -206,7 +206,7 @@ struct odb_source {
 	int (*write_object)(struct odb_source *source,
 			    const void *buf, size_t len,
 			    enum object_type type,
-			    struct object_id *oid,
+			    const struct object_id *oid,
 			    const struct object_id *compat_oid,
 			    enum odb_write_object_flags flags);
 
@@ -416,7 +416,7 @@ static inline int odb_source_freshen_object(struct odb_source *source,
 static inline int odb_source_write_object(struct odb_source *source,
 					  const void *buf, unsigned long len,
 					  enum object_type type,
-					  struct object_id *oid,
+					  const struct object_id *oid,
 					  const struct object_id *compat_oid,
 					  enum odb_write_object_flags flags)
 {
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 2dbc3ab1df..28a69fc244 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -43,6 +43,7 @@ static void cl_assert_write_object(struct odb_source_inmemory *source,
 				   struct object_id *oid)
 {
 	size_t content_len = strlen(content);
+	hash_object_file(repo.hash_algo, content, content_len, type, oid);
 	cl_must_pass(odb_source_write_object(&source->base, content, content_len,
 					     type, oid, NULL, 0));
 }

-- 
2.55.0.407.g700c83d4f3.dirty

