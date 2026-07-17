Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA23BE144
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280743; cv=none; b=kUZUMXjKZNn6zx5QlisR3pYfaa4flNFhDE/GIUHz38cE8Eu41HZglHnaZB06gaGJilq3UZ9ToRRi04H05XEEAGlYleiqMKIXe6prWSgw7Bizio6/2IHM/Il5Jm3Ko1KaQW1neiddOc8j1MLuhCYRTA7LOEN62vFZe411KeKyyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280743; c=relaxed/simple;
	bh=OfdzP9Z6/rkLTOsJw/4Z6unFgzkzSeC/wVvcodfnRvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iO3A/2GjbmISApEInB05885pWKxz+6KCpJUPo9mrnQN0H1NIZL+0R6r/YtifDB2F3UEmMCLQjYQ1aZFj6gsXVtI6+gyBP+JURYEnT3y6zuBj/SODfKRfu7XeDMLf97XUt/gddcPGkAejAKLaML22b7G0VJqvdavK8hJjwKGhJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ReA7bcyW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A4BJEhSJ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ReA7bcyW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A4BJEhSJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E6241D000D0;
	Fri, 17 Jul 2026 05:32:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 05:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784280740;
	 x=1784367140; bh=cWjm+0v+2yxH/AmHRV+Fv4XOjagL2oqO4MoZAFYAcfw=; b=
	ReA7bcyWX/bxTCSEOpimpLJ7acFx7luJ5igcpkmTeCHjH58ugUH+Fq85xFhcGwY2
	Ld0U+dntMm6whJ4ilW01lp7V7QGC6hIwkawxeZ1ImZkrd52r7lHdkH73jbe4S8L0
	BSx03ViV0dpxVPupbwpVUSpRbHc2mLInFFHIZme7u3/52wYGxlyfsV5kO59KXVxt
	FzTTPQcr4MUg8T8W5toUhP7PF+A3m30i3I5Hn4D1OVO7+6TDnj3nyR8n1fnKNhb+
	I2iHvMWMZ+CL/QzHfZrP0H6ZXzRJV0nlziBBRC5/RxTlG4VQFzU9859WylQzuL71
	PUPBNVoKVOZXyj/jNwsX8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784280740; x=
	1784367140; bh=cWjm+0v+2yxH/AmHRV+Fv4XOjagL2oqO4MoZAFYAcfw=; b=A
	4BJEhSJj64bda2CG1tKU3ghF/81YA42gS2xEYHNCMW9XNfOI79yQTZ65eYsma8j1
	iIhlrHSmAZx/z4QbKNDWwn+zU5QQRNmu/MtMr27SZJeSJ+N3S8JuluvatjIROS/B
	aMTq3F5AaAmhV7RtVFJrLBUBDNWMdK/fhA1d6K06TQ7DNx4bC0yJxuFFY84pxJDZ
	D89PE30mcp/3NTmfVx4niZX30IoB3+5ii229WWEQlYiFkCPVbhfDS+PkvJF92phW
	e0ZN2kiF+LkDFZxfA4zilrsfkVfBRaxb9autkwGddMdUpe8AdkwI3B2EUnqrWVrZ
	YJaJSYM04fm+DaiXUSUVw==
X-ME-Sender: <xms:pPZZanaq9mskBJ5A9qdBQhchGpghXXM4tv3mTwph7myHZWCGFQ3mRQ>
    <xme:pPZZasY3iOZXNt_M5JcJYbK2w_NGiCPzopk6YIuTQfwt16ziUKPWthhY_w2Y_MA2M
    _IelvpeqpbU53pIv9EaigIzHlGPZW6p-0biKaDAs70F6keIl1z9>
X-ME-Received: <xmr:pPZZanmZ7Nzmt9adiIPe1EZe431mkBYwKk81YZc5JPbmYJvWmpcKeGn_YnyT1jE-BGxFtl2rRE-qSu8q5ajfdp2CdPjjg7uA-jfxZRz2ldM>
X-ME-Proxy-Cause: dmFkZTEPgWsCPQv+zxSWEft837Na6Ert1SlmN3P5ZmZ6YVgwDD0i8FWTKtTHRWTsiWlqAf
    Ee3/fhnAtu7H1tpfszCQ9TpTtYDRq9/Ej+1toGtU2M4Btlsq1pdMD6WQ1yGfoiLr4szbCI
    waU9J+ehUfgAu5Wanq56c7n6wqTMKgid98yVYjCsZ3lgk6w6eA2/c75Y8tf8tburLwkElo
    WIveSLuviSET+E2Li1iK4PFXEMXOIYmHGdAPQjQZ/ZM4k+MBe94Ic0rS1bAkMoxhgnze0d
    MvjikpHRu8nDYV0sOz9NDUBG04xBQks3AtbvI4iyZ3NLFDV9y0pp6sScxFsmkkVul8Tkjr
    LiweA9kyQoVaScXfFxgHmNtLyulbSCHhISXi+0kpFaw6XoAnIGKRngbL1JfkKCbQK+W6yV
    FssF5BaQSEaKhcbU1w42LILxHddu2OTDh1lksPtiGCUKPanIb/78p4StltlDfv27dOIVBX
    Oie/Qlf9+fG1LPE/6BS8U18pO+rDUCKBQjiW30SHmft0Z68KHw+Zqfui8xckqhu4Ymj9W6
    pHgZ7QcWdm1v1FVimzB1gmTYQpIm9ziPzbPvpPnjQKzCtwm4KwIzozc/nVS7aYAgOZnvGu
    tdntSnB5BpWt0gioDEmaQ3jWiBGbglLpCUDYmKfOnlDjF0Tq8fkdfNmGBVSw
X-ME-Proxy: <xmx:pPZZaoxXBjTw7Y_9s2HPmccZnx7D6XtG2Fx2mAwsUEY2wNcdxNxlIg>
    <xmx:pPZZalOMMeCj5cZxcRja2c6aYGpTnYaD40ay8gRtwpGZ2ZTDkpzrHA>
    <xmx:pPZZasQ8R-0vPm7XpQZ3E1wZPuOn7Pqite85deSrWM81eKBtpFWhnw>
    <xmx:pPZZajaqMeCNBQiOMKrunzp59_wUreCwCzwLOD62hVkbj7myegntdw>
    <xmx:pPZZatLcwA_xvD6UUvYVbCqnCCtEizn4cZ574gQHtiJL5RSfjoqIr8-_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 05:32:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53d2678a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 09:32:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jul 2026 11:32:09 +0200
Subject: [PATCH 1/9] odb: compute compat object ID in
 `odb_write_object_ext()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-pks-odb-move-loose-object-writing-v1-1-46446a3cb5b7@pks.im>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Repositories can have a compatibility hash configured, which means that
such a repository is expected to maintain a mapping between canonical
and compatibility object hashes. Maintaining this mapping is the
responsibility of the object database sources, where we either store
them as part of the loose objects map or in packfile indices v3 (once we
gain support for this feature).

But besides storing these compatibility hashes, the sources are also
responsible for generating the compatibility hash in the first place.
This is somewhat unnecessary though, as the compatibility hash should be
computed the same no matter which source is being used. The consequence
is that we need to duplicate this functionality across the different
backends, which does not make a lot of sense.

Refactor the code so that we instead compute the compatibility hash in
`odb_write_object_ext()` and then pass the computed value to the
sources. No callers need adjustment as there are none that write objects
via the source interfaces directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 | 26 ++++++++++++++++++++++++--
 odb.h                 | 10 ++++++----
 odb/source-files.c    |  2 +-
 odb/source-inmemory.c |  2 +-
 odb/source-loose.c    | 24 +++---------------------
 odb/source-packed.c   |  2 +-
 odb/source.h          |  4 ++--
 7 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/odb.c b/odb.c
index cf6e7938c0..1d6538163b 100644
--- a/odb.c
+++ b/odb.c
@@ -989,11 +989,33 @@ int odb_write_object_ext(struct object_database *odb,
 			 const void *buf, unsigned long len,
 			 enum object_type type,
 			 struct object_id *oid,
-			 struct object_id *compat_oid,
+			 const struct object_id *compat_oid_in,
 			 enum odb_write_object_flags flags)
 {
+	const struct git_hash_algo *compat = odb->repo->compat_hash_algo;
+	struct object_id compat_oid, *compat_oid_p = NULL;
+
+	if (compat) {
+		const struct git_hash_algo *algo = odb->repo->hash_algo;
+
+		if (compat_oid_in) {
+			oidcpy(&compat_oid, compat_oid_in);
+		} else if (type == OBJ_BLOB) {
+			hash_object_file(compat, buf, len, type, &compat_oid);
+		} else {
+			struct strbuf converted = STRBUF_INIT;
+			convert_object_file(odb->repo, &converted, algo, compat,
+					    buf, len, type, 0);
+			hash_object_file(compat, converted.buf, converted.len,
+					 type, &compat_oid);
+			strbuf_release(&converted);
+		}
+
+		compat_oid_p = &compat_oid;
+	}
+
 	return odb_source_write_object(odb->sources, buf, len, type,
-				       oid, compat_oid, flags);
+				       oid, compat_oid_p, flags);
 }
 
 int odb_write_object_stream(struct object_database *odb,
diff --git a/odb.h b/odb.h
index 94754643d2..066560113e 100644
--- a/odb.h
+++ b/odb.h
@@ -585,9 +585,11 @@ enum odb_write_object_flags {
 
 /*
  * Write an object into the object database. The object is being written into
- * the local alternate of the repository. If provided, the converted object ID
- * as well as the compatibility object ID are written to the respective
- * pointers.
+ * the local alternate of the repository. If provided, the object ID of the
+ * final object is written into `oid`.
+ *
+ * If the caller provides a `compat_oid`, then this compatibility object hash
+ * will be stored instead of computing the compatibility hash ad-hoc.
  *
  * Returns 0 on success, a negative error code otherwise.
  */
@@ -595,7 +597,7 @@ int odb_write_object_ext(struct object_database *odb,
 			 const void *buf, unsigned long len,
 			 enum object_type type,
 			 struct object_id *oid,
-			 struct object_id *compat_oid,
+			 const struct object_id *compat_oid,
 			 enum odb_write_object_flags flags);
 
 static inline int odb_write_object(struct object_database *odb,
diff --git a/odb/source-files.c b/odb/source-files.c
index 4138758511..3d9f5eca32 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -163,7 +163,7 @@ static int odb_source_files_write_object(struct odb_source *source,
 					 const void *buf, size_t len,
 					 enum object_type type,
 					 struct object_id *oid,
-					 struct object_id *compat_oid,
+					 const struct object_id *compat_oid,
 					 enum odb_write_object_flags flags)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index e47bfd8fcc..e727aba427 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -231,7 +231,7 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
 					    const void *buf, size_t len,
 					    enum object_type type,
 					    struct object_id *oid,
-					    struct object_id *compat_oid UNUSED,
+					    const struct object_id *compat_oid UNUSED,
 					    enum odb_write_object_flags flags UNUSED)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 3f7d04a56e..ca223109cd 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -585,32 +585,14 @@ static int odb_source_loose_freshen_object(struct odb_source *source,
 static int odb_source_loose_write_object(struct odb_source *source,
 					 const void *buf, size_t len,
 					 enum object_type type, struct object_id *oid,
-					 struct object_id *compat_oid_in,
+					 const struct object_id *compat_oid,
 					 enum odb_write_object_flags flags)
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
 	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
-	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
-	struct object_id compat_oid;
 	char hdr[MAX_HEADER_LEN];
 	size_t hdrlen = sizeof(hdr);
 
-	/* Generate compat_oid */
-	if (compat) {
-		if (compat_oid_in)
-			oidcpy(&compat_oid, compat_oid_in);
-		else if (type == OBJ_BLOB)
-			hash_object_file(compat, buf, len, type, &compat_oid);
-		else {
-			struct strbuf converted = STRBUF_INIT;
-			convert_object_file(source->odb->repo, &converted, algo, compat,
-					    buf, len, type, 0);
-			hash_object_file(compat, converted.buf, converted.len,
-					 type, &compat_oid);
-			strbuf_release(&converted);
-		}
-	}
-
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
@@ -619,8 +601,8 @@ static int odb_source_loose_write_object(struct odb_source *source,
 		return 0;
 	if (write_loose_object(loose, oid, hdr, hdrlen, buf, len, 0, flags))
 		return -1;
-	if (compat)
-		return repo_add_loose_object_map(loose, oid, &compat_oid);
+	if (compat_oid)
+		return repo_add_loose_object_map(loose, oid, compat_oid);
 	return 0;
 }
 
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 8d9ce197cc..af0d533375 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -530,7 +530,7 @@ static int odb_source_packed_write_object(struct odb_source *source UNUSED,
 					  size_t len UNUSED,
 					  enum object_type type UNUSED,
 					  struct object_id *oid UNUSED,
-					  struct object_id *compat_oid UNUSED,
+					  const struct object_id *compat_oid UNUSED,
 					  unsigned flags UNUSED)
 {
 	return error("packed backend cannot write objects");
diff --git a/odb/source.h b/odb/source.h
index cd63dba91f..b3c1ca3a66 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -207,7 +207,7 @@ struct odb_source {
 			    const void *buf, size_t len,
 			    enum object_type type,
 			    struct object_id *oid,
-			    struct object_id *compat_oid,
+			    const struct object_id *compat_oid,
 			    enum odb_write_object_flags flags);
 
 	/*
@@ -417,7 +417,7 @@ static inline int odb_source_write_object(struct odb_source *source,
 					  const void *buf, unsigned long len,
 					  enum object_type type,
 					  struct object_id *oid,
-					  struct object_id *compat_oid,
+					  const struct object_id *compat_oid,
 					  enum odb_write_object_flags flags)
 {
 	return source->write_object(source, buf, len, type, oid,

-- 
2.55.0.407.g700c83d4f3.dirty

