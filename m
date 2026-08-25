Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D35A481FC1
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667176; cv=none; b=dRwJr9n9Zr4Z5ggJLD3xFbgS8RAdygrOJtlU5BccgeNYgHemIIFP2Rxf5/w31fsOv7CL+6cNMTC12PrQWFfqr51bjsvHt+nAUpI9xA5zGuKDH+L1sdCGnQiZntyjobDgJhgzB36U+iANR4BmnqYH2YiXyEZDDdOhyKG2o36XiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667176; c=relaxed/simple;
	bh=uxgrFkpqV3Si1p/Jld29JSvMWXS0CaZ4K2pFQSBKqV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GjzODJdmkm3RXPG8xsVYi5LUl/HzWH3gqzgmWutXunv4884Q3aZFcTG8p+SlPanUqpObrqeubcIsvtEg5RIsFS3y4JbsCdOb0V2tiVefxcZ1FiaJSAPr1NhVAdBB90W9r01rNXDQAy0ZfpICCF5143oBPqeDojxzIb9FE4DnG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OAk3AiF+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M9rSsu1k; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OAk3AiF+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M9rSsu1k"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0A8EC1D00046
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 25 Aug 2026 10:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787667173;
	 x=1787753573; bh=YePWBQmhtL4SkoxNiWdyDGyb1IOQc5sqhhaPx92oWqE=; b=
	OAk3AiF+QNKqklIx7iMXtHu7Z+MzFA8x7/mS5eOo7O7G/UGkcBW7QL4Ad1V/j6VN
	HJj/IAKbBM/jv3tBOwi9Rs7ZQ911jx2+HxsB2ca6DNRMuKnD+0LSXBpD2rVH4xdm
	4LF3HEPizlwYNEup3knGXer27SeGFr5vF1mvdVoO6jKHbZRGsPDAHNNgwcgpiGHS
	Kpbpe/I3y0gDwNlp8/0FTz4NagXr3D+fLLhqbJMMc0w9g0HMzLJayh14z7QjicHY
	c0UAbysR9zhZUHOSarDwEacpv7p2AcCPBZv6OdWbzGBaslg/WZN0Xzn0Zgy3jizw
	aNdiEIUhFcLnNcAv/9mBvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787667173; x=
	1787753573; bh=YePWBQmhtL4SkoxNiWdyDGyb1IOQc5sqhhaPx92oWqE=; b=M
	9rSsu1krTPCQYHys1F+CdvXPoajaBlGtkZbUHJ5pzRJaaEYEran2o3yWKdtvSGjb
	RbsDTgT+Zb/9K0PHOKkA5sHNO28gMdlOS2D2A7p7XazjT4vanpp90uWcyedAryCD
	rI9S9lnISOJZgHiMB3nfqNTctIRpqJtphRpA9URar7W0xB0TebsQ+3vo6c/MKpup
	Zz47P05OhdFGnHpGAjyqW9R5SXqCE15fQSi6LCjKNxrNUm26YOUuborPvfJIsK9u
	gAZOEAyrfw8Wz4nljODTNxdY0ZcynD14lsSmjZoHoigUYY7b0GXYw/me5L0jZbd6
	7eqcaL2qSr4BQfLOnHgTA==
X-ME-Sender: <xms:5aKNakC7p7cAKzAMNWrYKdzTpYR7veyngz0trXHN1tqcdCVZ8_kHXQ>
    <xme:5aKNatdORqq-_UyTJkmFiuBuQ0eVtFIBShzAKRP0rwAxVc6SAWeU-1wVh2TwBbNHP
    IPJADvcefsmlLiY9IpVRJdSS0WaCX2DAhD9s_du-dPbnhgGjpdb>
X-ME-Received: <xmr:5aKNatMmG0cLOhrdLeQX_-NHuDSdCsSkQ05Igs0AgHkT2KHLAahwK38mq82woax6rJ0gzsbTdMvL2PVNPqT3BA0FsEHUapRPlBkGiyVL2w>
X-ME-Proxy-Cause: dmFkZTGeb4bxLdeGsZIHwBpNvHkBYVFqb0gPBRFQdjclKFZL9iepAsMrQPToqlL/TKVr+q
    N4zotQK8qWu/iZbZxMh9T+enbjab8RTI96+ANj5zdevsOZpx/k2kbDA/Ezij5R9InemX2I
    ieATfXIkvh0YiRX3YRriT1epVXzuvh+X9pcDU66Ymz3EVbvLlj2rZKEI0CELpv6/vw7ah2
    elZ11v6nTiFLLnUx3cpsB978r+ZIEPLEKCBDKbZEAm79gm+cy32vgIs/g1+gOLXs07WJ70
    65IHgmKSzOBkB+IYs7mYVzgUR2wQOS5+Tr0YSbucb929Tar/yOh4FpTSqzhx1xlgLk0GXS
    Tf0fwM/dxsOqGmifjfstJlRzonmnGaKGhzkownaBdt8EtleewkQ2Rp43MU1cMlwXJO7eEY
    6sZxNZVxujpKaN5SBV46XTW2Lcb9I0UkSOuKUrAKb0jAM1mwanDC2t7gLOsAwZOCrjRjFj
    1/9jvN9cMSjt9AlRebPdjT8aU9HI9rVtfVUqRdT/RQTz7XKSyx5a2oVJaHApX75DmzVbR/
    E7h+zIk3W4XWtnldb/WHZ9urqnreQxYmxXw+/zKI8tHTTFos0sgVJjWPVh2XDMejlz7M9V
    4FzOShRUYw1MK/VsMrahZAlcHy3S1qU9LsSUp7eor1cxmL3UivdN/R0DvWhQ
X-ME-Proxy: <xmx:5aKNav6aathScs9X1G_5Ft0MRj1Btvfde-XBAn5rReD2yT_p4A9t-g>
    <xmx:5aKNapIn8bM1mQh5JCVXmIYFLSDn-POK1sMdlKzV7NpUglXapv6zoA>
    <xmx:5aKNahfyfR8nTK8bwFZVzuoL-knGYz0ov6-zLzRiE_Et4ErC5fI-3w>
    <xmx:5aKNakfHU76urXKC2ZmjuA_SFdXfnpb-scvyAHv7levBaZ_OsNAzlg>
    <xmx:5aKNavClU6Wb2FbeHS7XduJRYJtsevAySFBdEnZqvrMenAlSKKjjDc68>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 069cff55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:12:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:11:57 +0200
Subject: [PATCH 8/8] odb/source: remove the ability to write alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-write-alternates-at-creation-time-v1-8-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

There are no users of `odb_source_write_alternates()` in our tree
anymore. Remove that function and its supporting infrastructure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 |  9 ---------
 odb.h                 |  7 -------
 odb/source-files.c    | 55 ---------------------------------------------------
 odb/source-inmemory.c |  7 -------
 odb/source-loose.c    |  7 -------
 odb/source-packed.c   |  7 -------
 odb/source.h          | 26 ------------------------
 7 files changed, 118 deletions(-)

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
index 5e77b21d9f..feef9e169a 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -4,7 +4,6 @@
 #include "chdir-notify.h"
 #include "config.h"
 #include "gettext.h"
-#include "lockfile.h"
 #include "object-file.h"
 #include "odb.h"
 #include "odb/source.h"
@@ -303,59 +302,6 @@ static int odb_source_files_read_alternates(struct odb_source *source,
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
@@ -839,7 +785,6 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
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
index 86b82fab3b..5ee769e839 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -287,19 +287,6 @@ struct odb_source {
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
@@ -519,19 +506,6 @@ static inline int odb_source_read_alternates(struct odb_source *source,
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
2.55.0.822.g20453c30eb.dirty

