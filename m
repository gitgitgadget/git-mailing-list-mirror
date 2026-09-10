Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A774A2A4C
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052988; cv=none; b=ZZgDwOK63K1UWl7FShCv53zywDhUNqPik9Fd60xHkCDerj9oDMtEhDL3kG0pFQ6tNHC8oJRLPs8jb1ZFxCSqQaXrM+H1A/idEtI+aN37wCZBw3TNNP/NMQHQPpWhAw8jeiv176K38LUbTX6CJRqp38zbuhh8Cz/SYVzp8xMqB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052988; c=relaxed/simple;
	bh=MBAsZCYJkPZiI8hRKEe5W0Qp6JkBA0D7ob4oqQKrnfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbjBZk1GKHA5mbpnOKl7rPrtTA/a+1Ls8VYCkX8qJbDhuONGCTil7jbRCyW+A8Kod71ycM83SUlkgkhfSMcIUuPZH0RuMaFwk1vfUIfVWberD+0Sa7u0Nzn89RLdnSNTQQ/3k8zei6SqeXDvYDkU5kaM4a6PK61JXSmyASGxaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dhWROCHe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GXWAIoWx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dhWROCHe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GXWAIoWx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 600B314000B0;
	Thu, 10 Sep 2026 11:09:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 10 Sep 2026 11:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789052980;
	 x=1789139380; bh=CZi3HryGvPz4jaiM4nC07ZbyJaUZpB2ZF021mtCfnhc=; b=
	dhWROCHeZBitEh+iuxxdoOInctjRxcLTrLAA+kHT4ToTvu7sR46/sOYL9cRDIxVz
	ja23WC/1apVmcfTIlWJGM/xlb8NEM4pu7y+UsJd0ip5GYC91bFjl86B+3cKsm2FP
	T2XtogjsgfJ+fkDu0QN2FS/9S92g/zsJrBOj8dabwzxVVCwwE+dU5prB/VQ93w2i
	4n9x1qk5zpTjYBjY/+qtmq4WALJ+runvyvkRduzrs6Cu7mqxev4z4VGGtxoqaQWC
	Hh/jzYrCy8BFnNdCgmxmOVF5BDQiDbmIKXljPfwl4tQQhsC99PQoyRgqTaQuWRHI
	WHZeuxoAVv8GsyeGNgXdrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789052980; x=
	1789139380; bh=CZi3HryGvPz4jaiM4nC07ZbyJaUZpB2ZF021mtCfnhc=; b=G
	XWAIoWx3eURVwAgJa5v4pTJ9NcwAfPZlZtM2uku1abA21sj4IXizaw7L1ZbT+BT6
	bDlnwqRZJOT3o3N74ieXa6/HAwQeM7LwwsvExcyWlQj3Zwhu6n4OJIJqZ3sOHE9a
	0rF6Jwqj5QCpGgtwrgr2tPVENSCM0E2H9GnDkkeovR88GjEXeBSyD4XUYhs4C6/S
	o50yRl+3H28Fz/H/BLAjoxf4u+cRPVkIO9BbBCR3g0YMChziwj9xC7X7N96idbsm
	P/OxUPgtEhMPvnmT/1UTzG2Dym5Drt9dYCrGfrhZAgcXT4Kyr8wKiZllpW1944zT
	rSEulp52BLbqlAhlmi17w==
X-ME-Sender: <xms:NMiialkcoXX_hOH8fkqSTICYgwHpeOtGHCQ7JuDICSSar-0K7BCOSg>
    <xme:NMiianvuSUB6G3DAlsxr88VQioShIQIhqRjpAjer1YwmuBqTUvT4XaUHbA-ZjhCRs
    CiZSjv-P33zXwO9W6gXx_mmy_LnC0eG-s9zpt9rC-9JGWO-J6cmbKw>
X-ME-Received: <xmr:NMiiaj-fM_LN39QWp6mUrR1EZ_7i724hKzD3uC1svo9SzQOJ55KsQA>
X-ME-Proxy-Cause: dmFkZTF+5Wy56B+Wx3ySnb5Cx59QKPLOQu236q+2W/W769TPaDnZkuuZ6ySVZ9pJSqX60I
    4KnoBOIFigUDciwRh5/L/RnGKTaoNEewuq0njqzCEJrAVeBHtLobMSK78B+3FkPz/ggIMU
    xsdVnfs4PMJwMJ+arLr5XiQP6/sGsYur6cm7OCaOVgBA33g+KiJVV+ugxArXrsWGshcu/l
    x9zxt9yXxZkS12K7MVcatieR8K8p2/XFAPtZI8wbyrgYzrTVG29lrkrjg3Gx/XNfNTsgx5
    OxmR1v95cylk+grcUqYbD44VqN0IFxxmM0WSX9o2us26bpuTNI0rP+P/UYLTgPd4ZQ2FHL
    /SaL30F5DSX16l1hRLy+ReCRVGHZ0yhdbSXXkAnwA4gypXs3LWzU+gfkuHsEeFkCc0/N3C
    hCojGrJFJKB59SSFYjfPOI3YsA3K+7253wodlpv3tKEVnK6xzKWLSfbnVjwSrckAE+SRNq
    y1VoecKtGDbnI1lwv09HanNY1DTxRsS9HxDH2s/E/SQoTy58+KbJNwuk0sNBMBkxInmnAG
    UUsR5pPQjjdILwBEPKjbCkI0uUlm4bOppPC6hUd310HgdJv48jsyAbltp3OConMNODPzdl
    AjCYpx2DUBR285zHdAyFbTVQpS6XgFQKhT1yb7Q0Owoe2wdE42Uyl+H7G+jw
X-ME-Proxy: <xmx:NMiiahOSwnb1DvzxKoWz0do6qO3SvPKUqna9uw8GRdvL4qdEPNDnOA>
    <xmx:NMiiahEBr7h-u6C6IQ52etZUyXn92_TcT4iwNgtLNwn7gR4_zF7N9A>
    <xmx:NMiiavQTIZv5li-NYoFJeqZSrka2pBJMvqIzgduwwkS2Aimq1FH10A>
    <xmx:NMiiauv-KxhFdH0T4SEAxSXiNz7mWhkVZG56AFLw2hU8RVbEYpw4SA>
    <xmx:NMiiatZ5wmafFhc9pp9vMwgKsZfFB73apqRz7uwuXrfSOF5Z_DFmwq9c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 11:09:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23aa3e49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 15:09:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Sep 2026 17:09:19 +0200
Subject: [PATCH v5 9/9] odb/source: remove the ability to write alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-pks-odb-write-alternates-at-creation-time-v5-9-8d10c4238edc@pks.im>
References: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
In-Reply-To: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
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
2.55.0.1074.ge7621b4bad.dirty

