Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D39C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C75261038
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345677AbhIXUNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348375AbhIXUNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:13:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E174C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d6so30675123wrc.11
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qaojmrOCfEqu729QPdI/H8/1KHs81q8gLQkfiU1S9D8=;
        b=kec9OKZ1P9bSBgBN12zaB+P4FoMMLpADKxCOhg0LYQQye3+qDWwEmCZlrjJA8cSteN
         /+BdeAMzj2cBgbOXepy0iIyujQYWefe6A6Ew24tbl3/UGoNn1WfOVazugeormhJ66PUD
         OBHE6AiQfgVD4T1rvnsTMyMHSIoI+7IzMm6Tjo3R7YMRDkoAQEhBgO8Iavmoe1PWPO6h
         VR9NBf7vhU0o+2ZYsUnkKXXTwB8gA5xCRaYQuj6JDcwP9EKTFE1Oi+VAv5RLmg6B73nE
         OlM5Wfkx9KIPOxSw+lDHdR4WcT5LRs2OXXAKVBtbTrNiqE80Ejtx0vkGns/MuTXLyiXn
         PeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qaojmrOCfEqu729QPdI/H8/1KHs81q8gLQkfiU1S9D8=;
        b=HoDdKGr2GceLwnM5f4eSK9cPu11TrH1N/Hx1Y7QWChGabalwaqzwfpoKQ+5e98vOKk
         eDDuJodZi192jtCdsnctzRcnycXhaN2PT2oMpwv+tZdsEU7kUyY8eo3u/S7VS4thlTMF
         durB4QNYajud9RquoCWNlQZIB2FyWGXJ3LkaatodwdtF2/T8qcOaLlKrUd25/k5wJQKv
         PHwBT9H6oYNCs7kGa/XiPOOb+QDEPDG8XQCsbihAdjzmdiFLXYFCtCawNAgGXcKKXbli
         QNZma0Bd76H6ii3cEHERd5JbD5sNyjvdKE0WqMXrtMiX6gAdKwWuysgpU5QWz5yFi61+
         zQVw==
X-Gm-Message-State: AOAM531QdN8ybjWy8x2l6oLKb6q8l1q/GhEkRc8pAPyWgF/jjf84k9z3
        Rz0qw7WNXcuL3RMTQJbqkSEZDluSkfc=
X-Google-Smtp-Source: ABdhPJzsXg0FF1zpNaMcv2TfU9KGg2oUskcpLagWANcZCQGaFCwhRW7cB9UG46jmwnHRIi9/Hh42Eg==
X-Received: by 2002:adf:fac7:: with SMTP id a7mr13531891wrs.341.1632514332962;
        Fri, 24 Sep 2021 13:12:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r27sm8042201wrr.70.2021.09.24.13.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:12:12 -0700 (PDT)
Message-Id: <95315f35a283feabe301b24d2d465a8ae141b139.1632514331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
References: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
        <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 20:12:05 +0000
Subject: [PATCH v5 1/7] object-file.c: do not rename in a temp odb
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

If a temporary ODB is active, as determined by GIT_QUARANTINE_PATH
being set, create object files with their final names. This avoids
an extra rename beyond what is needed to merge the temporary ODB in
tmp_objdir_migrate.

Creating an object file with the expected final name should be okay
since the git process writing to the temporary object store is the
only writer, and it only invokes write_loose_object/create_object_file
after checking that the object doesn't exist.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 environment.c  |  4 ++++
 object-file.c  | 51 ++++++++++++++++++++++++++++++++++----------------
 object-store.h |  6 ++++++
 repository.c   |  2 ++
 repository.h   |  1 +
 5 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/environment.c b/environment.c
index d6b22ede7ea..d9ba68402e9 100644
--- a/environment.c
+++ b/environment.c
@@ -177,6 +177,10 @@ void setup_git_env(const char *git_dir)
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
 	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
+	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
+		args.object_dir_is_temp = 1;
+	}
+
 	repo_set_gitdir(the_repository, git_dir, &args);
 	strvec_clear(&to_free);
 
diff --git a/object-file.c b/object-file.c
index a8be8994814..ab593515cec 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1800,12 +1800,17 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
 }
 
 /*
- * Move the just written object into its final resting place.
+ * Move the just written object into its final resting place,
+ * unless it is already there, as indicated by an empty string for
+ * tmpfile.
  */
 int finalize_object_file(const char *tmpfile, const char *filename)
 {
 	int ret = 0;
 
+	if (!*tmpfile)
+		goto out;
+
 	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
 		goto try_rename;
 	else if (link(tmpfile, filename))
@@ -1878,21 +1883,37 @@ static inline int directory_size(const char *filename)
 }
 
 /*
- * This creates a temporary file in the same directory as the final
- * 'filename'
+ * This creates a loose object file for the specified object id.
+ * If we're working in a temporary object directory, the file is
+ * created with its final filename, otherwise it is created with
+ * a temporary name and renamed by finalize_object_file.
+ * If no rename is required, an empty string is returned in tmp.
  *
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(struct strbuf *tmp, const char *filename)
+static int create_objfile(const struct object_id *oid, struct strbuf *tmp,
+			  struct strbuf *filename)
 {
-	int fd, dirlen = directory_size(filename);
+	int fd, dirlen, is_retrying = 0;
+	const char *object_name;
+	static const int object_mode = 0444;
 
+	loose_object_path(the_repository, filename, oid);
+	dirlen = directory_size(filename->buf);
+
+retry_create:
 	strbuf_reset(tmp);
-	strbuf_add(tmp, filename, dirlen);
-	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
-	fd = git_mkstemp_mode(tmp->buf, 0444);
-	if (fd < 0 && dirlen && errno == ENOENT) {
+	if (!the_repository->objects->odb->is_temp) {
+		strbuf_add(tmp, filename->buf, dirlen);
+		object_name = "tmp_obj_XXXXXX";
+		strbuf_addstr(tmp, object_name);
+		fd = git_mkstemp_mode(tmp->buf, object_mode);
+	} else {
+		fd = open(filename->buf, O_CREAT | O_EXCL | O_RDWR, object_mode);
+	}
+
+	if (fd < 0 && dirlen && errno == ENOENT && !is_retrying) {
 		/*
 		 * Make sure the directory exists; note that the contents
 		 * of the buffer are undefined after mkstemp returns an
@@ -1900,15 +1921,15 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 		 * scratch.
 		 */
 		strbuf_reset(tmp);
-		strbuf_add(tmp, filename, dirlen - 1);
+		strbuf_add(tmp, filename->buf, dirlen - 1);
 		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
 			return -1;
 		if (adjust_shared_perm(tmp->buf))
 			return -1;
 
 		/* Try again */
-		strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
-		fd = git_mkstemp_mode(tmp->buf, 0444);
+		is_retrying = 1;
+		goto retry_create;
 	}
 	return fd;
 }
@@ -1925,14 +1946,12 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
 
-	loose_object_path(the_repository, &filename, oid);
-
-	fd = create_tmpfile(&tmp_file, filename.buf);
+	fd = create_objfile(oid, &tmp_file, &filename);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
 		else
-			return error_errno(_("unable to create temporary file"));
+			return error_errno(_("unable to create object file"));
 	}
 
 	/* Set it up */
diff --git a/object-store.h b/object-store.h
index b4dc6668aa2..f8c883a5730 100644
--- a/object-store.h
+++ b/object-store.h
@@ -26,6 +26,12 @@ struct object_directory {
 	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
 	struct oidtree *loose_objects_cache;
 
+	/*
+	 * This is a temporary object store, so there is no need to
+	 * create new objects via rename.
+	 */
+	int is_temp;
+
 	/*
 	 * Path to the alternative object store. If this is a relative path,
 	 * it is relative to the current working directory.
diff --git a/repository.c b/repository.c
index b2bf44c6faf..a16de04dfa8 100644
--- a/repository.c
+++ b/repository.c
@@ -80,6 +80,8 @@ void repo_set_gitdir(struct repository *repo,
 	expand_base_dir(&repo->objects->odb->path, o->object_dir,
 			repo->commondir, "objects");
 
+	repo->objects->odb->is_temp = o->object_dir_is_temp;
+
 	free(repo->objects->alternate_db);
 	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
diff --git a/repository.h b/repository.h
index 3740c93bc0f..d3711367a6f 100644
--- a/repository.h
+++ b/repository.h
@@ -162,6 +162,7 @@ struct set_gitdir_args {
 	const char *graft_file;
 	const char *index_file;
 	const char *alternate_db;
+	int object_dir_is_temp;
 };
 
 void repo_set_gitdir(struct repository *repo, const char *root,
-- 
gitgitgadget

