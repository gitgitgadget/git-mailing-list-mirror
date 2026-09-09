Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A953A3E7E
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932962; cv=none; b=Y6a4EW3lyArEOVZ2/6cej4ydTW7nxB7tvKR6sn6lR9BbzBYzFIJOQGzrxlsyrzUzYTbiga0hy2Z51aeJS6MNH+jNKtjPAvkuwKRX3qq0LixHdsL9u3g9pesFd9vJ3Sz8jkwUsoL1xfMIpwfya3SwaCMZFmc4wUGEHjQ2NtAPzS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932962; c=relaxed/simple;
	bh=MBAsZCYJkPZiI8hRKEe5W0Qp6JkBA0D7ob4oqQKrnfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPwriDibMPULEDZ+9iEWKLxYqGlGEPVdo04ux9uvp+Hltcq57RqVZkBGLooO7J4Tv9NMbzfXXj0SKvUnKcH9V3aAUvHi6o5xsX9py7InBA/5ekCygEaYBjKtN/OOx+4mAmt5Cziha/LCyHp/sDLiYf3HAlFQ5ZjnIEUfPU1gklg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iOoRpmDw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EhWXEKeL; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iOoRpmDw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EhWXEKeL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7CE5F7A00B5;
	Wed,  9 Sep 2026 01:49:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 09 Sep 2026 01:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788932959;
	 x=1789019359; bh=CZi3HryGvPz4jaiM4nC07ZbyJaUZpB2ZF021mtCfnhc=; b=
	iOoRpmDwvaabd+xyTSEvsAXZrbH2X33CPNm3UklcdAid+zNa+aa6BOwhkNnb719o
	hbI0cOkDu4jmM7UCcPXakfKWBOWixUi/9+ap1anmLlNBksW4XQj26j6tDvwEXl/x
	ejSqupAkJwPGlzUbIblWfwuBzWMn7pSUjmoujB7ezxq2Gas6OrYKyu/qWs3wfpx6
	r4YfkdClHvWhidV8Js1tmW4Z4Nc2QOlOiM+rXzrXc+4M9xO6xs4o1bD3MNUO+wvg
	oac42GTAwZNMLxKf3QMeB4wuZFzKIUb24ICk2qIGcpHzcwXPe+WXvYfAfPK1D8zX
	X8dqn5rd/F5I9I/wXMp2lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788932959; x=
	1789019359; bh=CZi3HryGvPz4jaiM4nC07ZbyJaUZpB2ZF021mtCfnhc=; b=E
	hWXEKeL0UkqWF5GeYFm6o86aXvTIq2w5r8IrZRyzHFoCkyURrhKSBSxz3onOBceT
	kvmDLsOTLxh20ITvxkRentFVw4AnFwIjatL3yL4pV+YWK/ier4XQU14zS42cO4CE
	Q01Aa6RkJDvCnp8b2v1zyZw6yCfgb+NYBqkd/eBPwyi9YhY3cxn3IHewcW6yRVcM
	Ayn0aY1vasSgYs9NJIr2zd7XxkxwwirOXhzUZAldTGmmtePyWo5jGC82pRfGEKfd
	LlOLqzGmn0eXIgp/eR64oRqnUISKJ6HnuK8L+Utf5mpDZLVXTFXKCB7+pcq/2/rI
	hDI+nDVDgVsDMm/AHOssA==
X-ME-Sender: <xms:X_OgahD9bTMWM_kWDtQduRUXfrYEEuht_2T7w4b82KKu6dixzNv9pg>
    <xme:X_OgamjgH0UbJ8AR7aWkasgn1Jg0f2WCpJ3X5XM_GpI8E1yI7X0_3YyZ5yECAffVO
    gM8xXH4Qi0gKlVe-2KfR4I78WWWmIr9-jW2oCuAswuUDmS5BObG5Xg>
X-ME-Received: <xmr:X_OgahkK-o-Skth3Is8cr9kUqYV5YVHxvNobi1so6tyx6LQNB1S_tpueZm6epGVeF1O2fg>
X-ME-Proxy-Cause: dmFkZTGYFWrD1gwiGrmi9uWEHxBq01dDv+yaEyYwcbtBPxQJMXWlHc+/G+EN0yrglJs2B2
    3XNfYoiEQOA+O21Fjde//viCzE2+Cqt0sVZNSnssBYvNHYMfIFF67hHmwljAeERsvKuBJq
    hqR92y8j6qjWIrI0GPACq3JpxZgyZ68UvJWHqstNNmI7d6CJ+cMNOogjC+RKkgyHVUQxFE
    n9dhpkl1ONfrCiqd+jL5C/+MJhY0zdlw56peUWz9aySGde9VivKtLEOa+Vff0PfSHh/ZDP
    cON5FfcJY0dynh6ItF5Pk8UA8R+6MyP6Ed2vgYYHByTNKoa/bXS3/XcFJO7rcBBxMLkqiS
    gEakdnq5agTRX7HT3u6vRQG3vmbnpWasaabwU56qvr+0JYBVR/csA7POAoaCPSa2m6Yj+I
    nJx5JhRjYxgFK74a5tFB1XSOQUho3Qt2BB7HJSIaI6dHsoypgGP3l1V4ssq4dvZUREw2cS
    gFVlbFshFOjZ4IDvlXwnzy9FCAbH9uMifBt2WN95S5hGILCZdhUhlBh59monqdwN+jGEvr
    8u/a1j3CD60sinCy9v3OLmnXbKL9rLekUECfLV5XrwTKh9kuEXaUPXWtRMRGByjpOARBbI
    EaypKJmdZrrXAWVyo+Iazr0D+pkwzGw8f5UPEKCahWOYtMN09P5qi14658zg
X-ME-Proxy: <xmx:X_OgaqrQtMjFpyg3fECcf0BdpkC-mss4HfUlbtmEpRG3lZXFXWUfWA>
    <xmx:X_OgaiHKbl42BlQaIYrgKKRwKGF9llxFbIg0tuNaGD14p5ACbjhz1A>
    <xmx:X_OgauwDyAExl_u-YAOBuWGitFA0rHIMo0aHy2P5k0d1nsbaFk8jqg>
    <xmx:X_OgavrGKkNkS-0vW4tm5fJRmTlCMPjnX5hK0JorHSz5S2USMVFgdQ>
    <xmx:X_OgasnaLag7WDO-zMn8RQ06mx5w_EQpQIPHukx9qU2NtzCpQn3cU11x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:49:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4af12257 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:49:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 07:48:51 +0200
Subject: [PATCH v4 9/9] odb/source: remove the ability to write alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pks-odb-write-alternates-at-creation-time-v4-9-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
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
2.55.0.1074.ge7621b4bad.dirty

