Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B4C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719FA61357
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbhJDQ7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbhJDQ7k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:59:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4ADC061749
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 09:57:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p21so4255181wmq.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bRdReQSxU0phNxYyS0xHl7/Uw1JEvVeHEIF6saI/aGw=;
        b=cA058F1sRlTF2u+qyPDBv7/IDQh5wnnS3VBKQwuyzM1/wb/TWiQC3NErz1RDi+y5AX
         BHzJWw51yon/FYYmmQdIa9hrYc9s4vqLpuY60SJL8Sldqz8SSKQkXYnHAMdoU6jXpXyX
         7iKbWkRp0s48DSvQqabRiztn/VscRj9nZhQUsK7u8F+FkFUTeABg6uCtcZ+wrdFWybk6
         q+gZqWFlse6Sm9i5ZhCXaeSKCp71Z+d8BpYs/Q7D3w13PC5Z4aqi7IpZv/CvGQLlvN41
         COMQNHKhv8dOIvsFLUWbxQQ3NBUvwc0ix9GXNYyNfBRRKe2jM7HDYxiGw27zULML/3FY
         NKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bRdReQSxU0phNxYyS0xHl7/Uw1JEvVeHEIF6saI/aGw=;
        b=llGHb2Mra1RfzR/u6MVTfJhmq7d8DLETVtChlMv9fE3AhMUqz9Hh1JJBtoaEAmHjwq
         m4ZzT1w4yzjxCi8UKrUC+MzM5lpLHJYdSg2X8DQf5g0r6wfVNV7AromzpUB9dGI7jrMG
         KiHa7XomoORxn3irHxE4R6EJyUNJJCr4KZYMWDuU/v3fGOB2aIVizYYhgB/MLdPZ70np
         Ti8p51ykRlzmwLpXRqnnrC+Ktm/pysAM2JJgByn8KdA+DqGC29Dv2+yplQd5Azz6Igho
         yb89NTJRNARy3U6En/QJEB0m5ETDQF9m178K3iVEtFqx2tBJL60Iu2EfxYrM8hCEd8JD
         XTEg==
X-Gm-Message-State: AOAM533rzuE/1Feb34sNrBMTQl/qswW17BmB5Zn6ouIUydhlQx5vc7IH
        MAdfxdOV7caqz5tT2q2n+0YO0eWFWYE=
X-Google-Smtp-Source: ABdhPJyXjbH/bA73IvAVq/oBiBMcrzknhyIxnGD+5bRtRV8yN8c48o0rDrEAKpvyU1jIAUgKJHoX7g==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr20290350wmd.17.1633366670084;
        Mon, 04 Oct 2021 09:57:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 61sm14960771wrl.94.2021.10.04.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:57:49 -0700 (PDT)
Message-Id: <f03797fd80daf519f26b93eab06142fe9a0b2b94.1633366667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
        <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Oct 2021 16:57:39 +0000
Subject: [PATCH v8 1/9] tmp-objdir: new API for creating temporary writable
 databases
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
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The tmp_objdir API provides the ability to create temporary object
directories, but was designed with the goal of having subprocesses
access these object stores, followed by the main process migrating
objects from it to the main object store or just deleting it.  The
subprocesses would view it as their primary datastore and write to it.

Here we add the tmp_objdir_replace_primary_odb function that replaces
the current process's writable "main" object directory with the
specified one. The previous main object directory is restored in either
tmp_objdir_migrate or tmp_objdir_destroy.

For the --remerge-diff usecase, add a new `will_destroy` flag in `struct
object_database` to mark ephemeral object databases that do not require
fsync durability.

Add 'git prune' support for removing temporary object databases, and
make sure that they have a name starting with tmp_ and containing an
operation-specific name.

Based-on-patch-by: Elijah Newren <newren@gmail.com>

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/prune.c        | 22 +++++++++++++++++----
 builtin/receive-pack.c |  2 +-
 object-file.c          | 44 ++++++++++++++++++++++++++++++++++++++++--
 object-store.h         | 19 ++++++++++++++++++
 object.c               |  2 +-
 tmp-objdir.c           | 30 +++++++++++++++++++++++++---
 tmp-objdir.h           | 14 +++++++++++---
 7 files changed, 119 insertions(+), 14 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 02c6ab7cbaa..9c72ecf5a58 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -18,6 +18,7 @@ static int show_only;
 static int verbose;
 static timestamp_t expire;
 static int show_progress = -1;
+static struct strbuf remove_dir_buf = STRBUF_INIT;
 
 static int prune_tmp_file(const char *fullpath)
 {
@@ -26,10 +27,19 @@ static int prune_tmp_file(const char *fullpath)
 		return error("Could not stat '%s'", fullpath);
 	if (st.st_mtime > expire)
 		return 0;
-	if (show_only || verbose)
-		printf("Removing stale temporary file %s\n", fullpath);
-	if (!show_only)
-		unlink_or_warn(fullpath);
+	if (S_ISDIR(st.st_mode)) {
+		if (show_only || verbose)
+			printf("Removing stale temporary directory %s\n", fullpath);
+		if (!show_only) {
+			strbuf_addstr(&remove_dir_buf, fullpath);
+			remove_dir_recursively(&remove_dir_buf, 0);
+		}
+	} else {
+		if (show_only || verbose)
+			printf("Removing stale temporary file %s\n", fullpath);
+		if (!show_only)
+			unlink_or_warn(fullpath);
+	}
 	return 0;
 }
 
@@ -97,6 +107,9 @@ static int prune_cruft(const char *basename, const char *path, void *data)
 
 static int prune_subdir(unsigned int nr, const char *path, void *data)
 {
+	if (verbose)
+		printf("Removing directory %s\n", path);
+
 	if (!show_only)
 		rmdir(path);
 	return 0;
@@ -185,5 +198,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		prune_shallow(show_only ? PRUNE_SHOW_ONLY : 0);
 	}
 
+	strbuf_release(&remove_dir_buf);
 	return 0;
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 48960a9575b..418a42ca069 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2208,7 +2208,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		strvec_push(&child.args, alt_shallow_file);
 	}
 
-	tmp_objdir = tmp_objdir_create();
+	tmp_objdir = tmp_objdir_create("incoming");
 	if (!tmp_objdir) {
 		if (err_fd > 0)
 			close(err_fd);
diff --git a/object-file.c b/object-file.c
index be4f94ecf3b..990381abee5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -751,6 +751,43 @@ void add_to_alternates_memory(const char *reference)
 			     '\n', NULL, 0);
 }
 
+struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy)
+{
+	struct object_directory *new_odb;
+
+	/*
+	 * Make sure alternates are initialized, or else our entry may be
+	 * overwritten when they are.
+	 */
+	prepare_alt_odb(the_repository);
+
+	/*
+	 * Make a new primary odb and link the old primary ODB in as an
+	 * alternate
+	 */
+	new_odb = xcalloc(1, sizeof(*new_odb));
+	new_odb->path = xstrdup(dir);
+	new_odb->will_destroy = will_destroy;
+	new_odb->next = the_repository->objects->odb;
+	the_repository->objects->odb = new_odb;
+	return new_odb->next;
+}
+
+void restore_primary_odb(struct object_directory *restore_odb, const char *old_path)
+{
+	struct object_directory *cur_odb = the_repository->objects->odb;
+
+	if (strcmp(old_path, cur_odb->path))
+		BUG("expected %s as primary object store; found %s",
+		    old_path, cur_odb->path);
+
+	if (cur_odb->next != restore_odb)
+		BUG("we expect the old primary object store to be the first alternate");
+
+	the_repository->objects->odb = restore_odb;
+	free_object_directory(cur_odb);
+}
+
 /*
  * Compute the exact path an alternate is at and returns it. In case of
  * error NULL is returned and the human readable error is added to `err`
@@ -1888,8 +1925,11 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(int fd)
 {
-	if (fsync_object_files)
-		fsync_or_die(fd, "loose object file");
+	if (!the_repository->objects->odb->will_destroy) {
+		if (fsync_object_files)
+			fsync_or_die(fd, "loose object file");
+	}
+
 	if (close(fd) != 0)
 		die_errno(_("error when closing loose object file"));
 }
diff --git a/object-store.h b/object-store.h
index c5130d8baea..74b1b5872a6 100644
--- a/object-store.h
+++ b/object-store.h
@@ -27,6 +27,11 @@ struct object_directory {
 	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
 	struct oidtree *loose_objects_cache;
 
+	/*
+	 * This object store is ephemeral, so there is no need to fsync.
+	 */
+	int will_destroy;
+
 	/*
 	 * Path to the alternative object store. If this is a relative path,
 	 * it is relative to the current working directory.
@@ -58,6 +63,17 @@ void add_to_alternates_file(const char *dir);
  */
 void add_to_alternates_memory(const char *dir);
 
+/*
+ * Replace the current writable object directory with the specified temporary
+ * object directory; returns the former primary object directory.
+ */
+struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
+
+/*
+ * Restore a previous ODB replaced by set_temporary_main_odb.
+ */
+void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -68,6 +84,9 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 /* Empty the loose object cache for the specified object directory. */
 void odb_clear_loose_cache(struct object_directory *odb);
 
+/* Clear and free the specified object directory */
+void free_object_directory(struct object_directory *odb);
+
 struct packed_git {
 	struct hashmap_entry packmap_ent;
 	struct packed_git *next;
diff --git a/object.c b/object.c
index 4e85955a941..98635bc4043 100644
--- a/object.c
+++ b/object.c
@@ -513,7 +513,7 @@ struct raw_object_store *raw_object_store_new(void)
 	return o;
 }
 
-static void free_object_directory(struct object_directory *odb)
+void free_object_directory(struct object_directory *odb)
 {
 	free(odb->path);
 	odb_clear_loose_cache(odb);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index b8d880e3626..45d42a7bcf0 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -11,6 +11,7 @@
 struct tmp_objdir {
 	struct strbuf path;
 	struct strvec env;
+	struct object_directory *prev_odb;
 };
 
 /*
@@ -38,6 +39,9 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 	if (t == the_tmp_objdir)
 		the_tmp_objdir = NULL;
 
+	if (!on_signal && t->prev_odb)
+		restore_primary_odb(t->prev_odb, t->path.buf);
+
 	/*
 	 * This may use malloc via strbuf_grow(), but we should
 	 * have pre-grown t->path sufficiently so that this
@@ -52,6 +56,7 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 	 */
 	if (!on_signal)
 		tmp_objdir_free(t);
+
 	return err;
 }
 
@@ -121,7 +126,7 @@ static int setup_tmp_objdir(const char *root)
 	return ret;
 }
 
-struct tmp_objdir *tmp_objdir_create(void)
+struct tmp_objdir *tmp_objdir_create(const char *prefix)
 {
 	static int installed_handlers;
 	struct tmp_objdir *t;
@@ -129,11 +134,16 @@ struct tmp_objdir *tmp_objdir_create(void)
 	if (the_tmp_objdir)
 		BUG("only one tmp_objdir can be used at a time");
 
-	t = xmalloc(sizeof(*t));
+	t = xcalloc(1, sizeof(*t));
 	strbuf_init(&t->path, 0);
 	strvec_init(&t->env);
 
-	strbuf_addf(&t->path, "%s/incoming-XXXXXX", get_object_directory());
+	/*
+	 * Use a string starting with tmp_ so that the builtin/prune.c code
+	 * can recognize any stale objdirs left behind by a crash and delete
+	 * them.
+	 */
+	strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX", get_object_directory(), prefix);
 
 	/*
 	 * Grow the strbuf beyond any filename we expect to be placed in it.
@@ -269,6 +279,13 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (!t)
 		return 0;
 
+	if (t->prev_odb) {
+		if (the_repository->objects->odb->will_destroy)
+			BUG("migrating an ODB that was marked for destruction");
+		restore_primary_odb(t->prev_odb, t->path.buf);
+		t->prev_odb = NULL;
+	}
+
 	strbuf_addbuf(&src, &t->path);
 	strbuf_addstr(&dst, get_object_directory());
 
@@ -292,3 +309,10 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
 {
 	add_to_alternates_memory(t->path.buf);
 }
+
+void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
+{
+	if (t->prev_odb)
+		BUG("the primary object database is already replaced");
+	t->prev_odb = set_temporary_primary_odb(t->path.buf, will_destroy);
+}
diff --git a/tmp-objdir.h b/tmp-objdir.h
index b1e45b4c75d..75754cbfba6 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -10,7 +10,7 @@
  *
  * Example:
  *
- *	struct tmp_objdir *t = tmp_objdir_create();
+ *	struct tmp_objdir *t = tmp_objdir_create("incoming");
  *	if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
  *	    !tmp_objdir_migrate(t))
  *		printf("success!\n");
@@ -22,9 +22,10 @@
 struct tmp_objdir;
 
 /*
- * Create a new temporary object directory; returns NULL on failure.
+ * Create a new temporary object directory with the specified prefix;
+ * returns NULL on failure.
  */
-struct tmp_objdir *tmp_objdir_create(void);
+struct tmp_objdir *tmp_objdir_create(const char *prefix);
 
 /*
  * Return a list of environment strings, suitable for use with
@@ -51,4 +52,11 @@ int tmp_objdir_destroy(struct tmp_objdir *);
  */
 void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
 
+/*
+ * Replaces the main object store in the current process with the temporary
+ * object directory and makes the former main object store an alternate.
+ * If will_destroy is nonzero, the object directory may not be migrated.
+ */
+void tmp_objdir_replace_primary_odb(struct tmp_objdir *, int will_destroy);
+
 #endif /* TMP_OBJDIR_H */
-- 
gitgitgadget

