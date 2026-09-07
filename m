Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6568D43D4E9
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769574; cv=none; b=enr7Dpn8deGMRBTyi4Vb2dDJcMnafJClX4k/qkisNhQqkKrfijONTBLbAT4BEZ2LziPkckjUX+3tqtcY2MWZE1sJJwsZzZkCouwPoGfVUxCGgcCEMjJJxUiPB/3ZwRNJlHMdnjhSa4tEmf4FPpHnmTqpROTUKvs7nX5qxVD5eFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769574; c=relaxed/simple;
	bh=qNp2qAHjsOQIUoy54CQjIKiwDO63eR3MJqpB4ZXllmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCVeYxIWg+GPC041P83FBIByEk2LGAQEnnT2Py/cWPJ37gLulyBOigh8/hg1WBRErLpSyXrzlPs1pzZjJzekLQ59Y52MXrDsOY0+m2F0XetWhVtAH0qh3jl4ZDqGw+AOm5ThwQn5kWhZw4ogVZJ3EJJOtDNzK3u/u4e9vVALS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FHf+fqZu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nw63bJ2f; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FHf+fqZu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nw63bJ2f"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 91D0AEC01C2;
	Mon,  7 Sep 2026 04:26:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 07 Sep 2026 04:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788769571;
	 x=1788855971; bh=VDhD8pZgCfsvXgGPCiW2OlYVdkgSUNa1LsAR5Ez47iw=; b=
	FHf+fqZuDrvPebA0JvGCWiGGVi2oyJfkstSqydio8+Hg2X92gB5ZLmCS5z4JNdcI
	jDGJd4TASBJLZGT+bX5To9sGG9ZV07xjfAnKcBhY/4z/p6EtMAybMLQBF8H5xmIx
	C58CCLddVMaiALOrO08AB0j7GMIqSxq4TRlTTfJZt3AZ/KpqPsjfefMZLjbcmE+M
	M5s44SzCey8CQe8dCp6193MV/sj5nm6AtvJdTDb4mbByGXDFZcn0r8LrGIEr1Nm+
	iF+fhQ/iK2cfiGny7pKW6O+ljtkmItH9NjmTd2ZYSArFcnnKndyKwkVHH7Wp55ul
	HtaguGvUDkUS8fl/DVkgiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788769571; x=
	1788855971; bh=VDhD8pZgCfsvXgGPCiW2OlYVdkgSUNa1LsAR5Ez47iw=; b=n
	w63bJ2fTj7YxsDVW6DuzELd5qAtYpavrqB303buRNyv5PxTECjc/zFrN3M5ZdrQa
	ABO1MnOFW2Zc+QQXbeaGER+PRWGKcEpI85xJvzxY87vclNueI00jBKb0cIHXx6oh
	+Z1oGpNSe/TMU934cQ/NTMutc9Xbb9h+MU8UqxXKYNjBPLUwL0P0lgekHxdPN7yy
	PfMAPUpZFGqiqHqmOQ/0uLOhhteRNaIsOVNAz+WzdIi+/PM3+5wlDPHjY1iakaks
	IrUP04IKsSONPGQ8gARdJR5FOeah21m5xz8coEt/Qnri32/JQTxwWl7SKz46Tq35
	bOP0/BBhYGqx9jDOFA+MA==
X-ME-Sender: <xms:I3WeavpF3mHP3ELqbt-270EgC7Nj3IkyH0fOUn16hS0ADpg_iSPgXQ>
    <xme:I3WeagooKRB4LID2lBqf6n71FxfpCGxPzk4RbDyazR3SunUd-ukxjCUhvoU50IQIN
    HAlJRisT4IrnYwjVoA77QJwRBXJtc7N75F6Me_wwEl3rR6uaJWktA>
X-ME-Received: <xmr:I3WeahMWod7luP-UBZJ2lN3ykb2wEo69R45UlLu_LEhQFwVntfL9Hg>
X-ME-Proxy-Cause: dmFkZTGmQ0giV54ivEgZMAUJexJjW3v8iGpyNGjyQzAKAzJ62ZDKRiRCGDjv57RyghZ/MH
    XGOdw2+RmT5Dzyfo5V1ATgM9RVEiF/Ii8EFt0lbviHwERqIrlAx6wBBve5jHa8tFnmWNe4
    Ah5IMKGcOdtZVpH4Qbd0RQhXXmcvhZx0S9MAGEN/Uad0GzVra6BorF0zEsFd/+T9iX5oRn
    S6WXFeCJabnVDY3fYiiNsqQoqpqli9R5qw3zoY//axIIo5IkWI8nh9oyBgVkbpJanPRi8h
    HkPnVGJ3Mro8ddPCXLEqL+GtM9raZCAAs8pPK+CmManDqIUD4eDxhQ0BSOyZr+09ZdIMnz
    KI8E3M1vG7pAW+vUwlZAoSAWLyVQ0T6tnu6QmUNqtLAXeYR5T8Y3siUB3ibyqrYh+/D+Ij
    95dIVs3JtBEARwhDxoTWlszOsGCMF98dba0FRW3X1oPUBEKLwZJ/BsVGV2DdCyGD0/QDxK
    32NPdhwK5RdgH7+ACd5ZjiH7m8Jv/p3n9hnI36jsQu75kaYDj+blGl8G5ZmHfqTdZFA3kd
    IwxLVod21WVoqgO/NeiF/XOkkxO7i9FpDv6ku3ZzKAF8D1yeUTiRBaGJPGeGXSca+BJEK5
    yyYufN1Re5dMmtnUYhMk2D5EMGUq2ecbzkx2MOj6qmAV8a+/DcUe6gQSiGHw
X-ME-Proxy: <xmx:I3WeahyGDzEU-sgQKJNbYBxpc_Eulqm1nYtgYsGbQU67mYCge9KYPw>
    <xmx:I3Weaqt3Km1qch5wpRkIGIVeDQQ4fixjiUthHvClaFJFreG2l6-Ytw>
    <xmx:I3Weaq7j0oyJ1aG2mDY0IMuNtgJPx2jpik4qqM-KykZ3AIplE6c4wg>
    <xmx:I3WeapRYrL6UUVzyJ1UH6rkKUZb33LukvqL-Ttbhbu-Blj05L09NBw>
    <xmx:I3WeaiOaGFmq1g4uQBNLwd086YIjG1Ijs5uMWVjJXOrUGGQEFGTX7RMi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:26:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ac9879d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:26:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 10:25:46 +0200
Subject: [PATCH v3 9/9] odb/source: remove the ability to write alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-pks-odb-write-alternates-at-creation-time-v3-9-735d0b5b3e00@pks.im>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

There are no users of `odb_source_write_alternates()` in our tree
anymore. Remove that function and its supporting infrastructure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 |  9 ---------
 odb.h                 |  7 -------
 odb/source-files.c    | 54 ---------------------------------------------------
 odb/source-inmemory.c |  7 -------
 odb/source-loose.c    |  7 -------
 odb/source-packed.c   |  7 -------
 odb/source.h          | 26 -------------------------
 7 files changed, 117 deletions(-)

diff --git a/odb.c b/odb.c
index 67d98d64fc..b531cf8fb3 100644
--- a/odb.c
+++ b/odb.c
@@ -239,15 +239,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	return alternate;
 }
 
-void odb_add_to_alternates_file(struct object_database *odb,
-				const char *dir)
-{
-	int ret = odb_source_write_alternate(odb->sources, dir);
-	if (ret < 0)
-		die(NULL);
-	odb_add_alternate_recursively(odb, dir, 0);
-}
-
 struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 						const char *dir)
 {
diff --git a/odb.h b/odb.h
index b9e0db56ec..2d002461f8 100644
--- a/odb.h
+++ b/odb.h
@@ -270,13 +270,6 @@ int odb_mkstemp(struct object_database *odb,
  */
 int odb_has_alternates(struct object_database *odb);
 
-/*
- * Add the directory to the on-disk alternates file; the new entry will also
- * take effect in the current process.
- */
-void odb_add_to_alternates_file(struct object_database *odb,
-				const char *dir);
-
 /*
  * Add the directory to the in-memory list of alternate sources (along with any
  * recursive alternates it points to), but do not modify the on-disk alternates
diff --git a/odb/source-files.c b/odb/source-files.c
index 8fe65d91f8..b3f340dff8 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -306,59 +306,6 @@ static int odb_source_files_read_alternates(struct odb_source *source,
 	return 0;
 }
 
-static int odb_source_files_write_alternate(struct odb_source *source,
-					    const char *alternate)
-{
-	struct lock_file lock = LOCK_INIT;
-	char *path = xstrfmt("%s/%s", source->path, "info/alternates");
-	FILE *in, *out;
-	int found = 0;
-	int ret;
-
-	repo_hold_lock_file_for_update(source->odb->repo, &lock, path,
-				       LOCK_DIE_ON_ERROR);
-	out = fdopen_lock_file(&lock, "w");
-	if (!out) {
-		ret = error_errno(_("unable to fdopen alternates lockfile"));
-		goto out;
-	}
-
-	in = fopen(path, "r");
-	if (in) {
-		struct strbuf line = STRBUF_INIT;
-
-		while (strbuf_getline(&line, in) != EOF) {
-			if (!strcmp(alternate, line.buf)) {
-				found = 1;
-				break;
-			}
-			fprintf_or_die(out, "%s\n", line.buf);
-		}
-
-		strbuf_release(&line);
-		fclose(in);
-	} else if (errno != ENOENT) {
-		ret = error_errno(_("unable to read alternates file"));
-		goto out;
-	}
-
-	if (found) {
-		rollback_lock_file(&lock);
-	} else {
-		fprintf_or_die(out, "%s\n", alternate);
-		if (commit_lock_file(&lock)) {
-			ret = error_errno(_("unable to move new alternates file into place"));
-			goto out;
-		}
-	}
-
-	ret = 0;
-
-out:
-	free(path);
-	return ret;
-}
-
 static int too_many_loose_objects(struct odb_source_files *files, int limit)
 {
 	unsigned long loose_count;
@@ -842,7 +789,6 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.write_object_stream = odb_source_files_write_object_stream;
 	files->base.begin_transaction = odb_source_files_begin_transaction;
 	files->base.read_alternates = odb_source_files_read_alternates;
-	files->base.write_alternate = odb_source_files_write_alternate;
 	files->base.optimize = odb_source_files_optimize;
 	files->base.optimize_required = odb_source_files_optimize_required;
 
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 795672adf2..b00248dfb2 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -326,12 +326,6 @@ static int odb_source_inmemory_read_alternates(struct odb_source *source UNUSED,
 	return 0;
 }
 
-static int odb_source_inmemory_write_alternate(struct odb_source *source UNUSED,
-					       const char *alternate UNUSED)
-{
-	return error("in-memory source does not support alternates");
-}
-
 static void odb_source_inmemory_close(struct odb_source *source UNUSED)
 {
 }
@@ -388,7 +382,6 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.freshen_object = odb_source_inmemory_freshen_object;
 	source->base.begin_transaction = odb_source_inmemory_begin_transaction;
 	source->base.read_alternates = odb_source_inmemory_read_alternates;
-	source->base.write_alternate = odb_source_inmemory_write_alternate;
 
 	return source;
 }
diff --git a/odb/source-loose.c b/odb/source-loose.c
index bb3455dfbd..0f9b30bac1 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -982,12 +982,6 @@ static int odb_source_loose_read_alternates(struct odb_source *source UNUSED,
 	return 0;
 }
 
-static int odb_source_loose_write_alternate(struct odb_source *source UNUSED,
-					    const char *alternate UNUSED)
-{
-	return error("loose source does not support alternates");
-}
-
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -1053,7 +1047,6 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 	loose->base.write_object_stream = odb_source_loose_write_object_stream;
 	loose->base.begin_transaction = odb_source_loose_begin_transaction;
 	loose->base.read_alternates = odb_source_loose_read_alternates;
-	loose->base.write_alternate = odb_source_loose_write_alternate;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 630d955585..c2d253759c 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -628,12 +628,6 @@ static int odb_source_packed_read_alternates(struct odb_source *source UNUSED,
 	return 0;
 }
 
-static int odb_source_packed_write_alternate(struct odb_source *source UNUSED,
-					     const char *alternate UNUSED)
-{
-	return error("packed backend cannot write alternates");
-}
-
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -849,7 +843,6 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 	packed->base.write_object_stream = odb_source_packed_write_object_stream;
 	packed->base.begin_transaction = odb_source_packed_begin_transaction;
 	packed->base.read_alternates = odb_source_packed_read_alternates;
-	packed->base.write_alternate = odb_source_packed_write_alternate;
 
 	if (!is_absolute_path(path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/odb/source.h b/odb/source.h
index 63f1c0c531..693a9fc604 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -286,19 +286,6 @@ struct odb_source {
 	int (*read_alternates)(struct odb_source *source,
 			       struct strvec *out);
 
-	/*
-	 * This callback is expected to persist the singular alternate passed
-	 * to it into its list of alternates. Any pre-existing alternates are
-	 * expected to remain active. Subsequent calls to `read_alternates` are
-	 * thus expected to yield the pre-existing list of alternates plus the
-	 * newly added alternate appended to its end.
-	 *
-	 * The callback is expected to return 0 on success, a negative error
-	 * code otherwise.
-	 */
-	int (*write_alternate)(struct odb_source *source,
-			       const char *alternate);
-
 	/*
 	 * This callback is expected to optimize the object database source.
 	 * Returns 0 on success, a negative error code otherwise.
@@ -518,19 +505,6 @@ static inline int odb_source_read_alternates(struct odb_source *source,
 	return source->read_alternates(source, out);
 }
 
-/*
- * Write and persist a new alternate object database source for the given
- * source. Any preexisting alternates are expected to stay valid, and the new
- * alternate shall be appended to the end of the list.
- *
- * Returns 0 on success, a negative error code otherwise.
- */
-static inline int odb_source_write_alternate(struct odb_source *source,
-					      const char *alternate)
-{
-	return source->write_alternate(source, alternate);
-}
-
 /*
  * Create a new transaction that can be used to write objects into a temporary
  * staging area. The objects will only be persisted when the transaction is

-- 
2.55.0.1007.g17ff1f9808.dirty

