Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6751F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBFAC2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:02:28 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32934 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeBFACZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:02:25 -0500
Received: by mail-pg0-f68.google.com with SMTP id u1so137918pgr.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I9JDhUrgE1bUdtUOX8CDyah+CSGg+PmAwn+CDfIHlCA=;
        b=Hm9AdS2l8xUtKVcM7Q89XSIox0bEQ8dRHZlq+0ZrgJOWCf29o/sfGcp8FybPyWECvq
         uCcW7PN5YPuV9hJIDZth0hBWFhmQzCDv51uaKBqtuAK3m8lhpUPi3F2Ub3GIZZch90S2
         3D2Xsas7AxtMn3zMayltV3ZLP+Xx9FjgkPMcTHgubkJD/oYd2xqPw4aJ+BN7GmMwFvVS
         eBWLhK6tUlA/e7Hfi68mvJIbZg/LBCIfPLVE9bazbkixPboREHlVK1V7EYukMoh8mcHx
         JDKHYFcEV1Nh6tnZDDTol+dJWxQE1wQwXPDPsI194bglyoMDOtAKHXaTfEYqvwmclpLZ
         GawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I9JDhUrgE1bUdtUOX8CDyah+CSGg+PmAwn+CDfIHlCA=;
        b=RezZxVSDDCPTCe5iyBCyARvwR8Wafr/AU6ZhBe2WRfSW1lQSmHGADg6VN/OOkhs6QE
         dIjmkNevbzPrP6KMPRc9sm0gNV/ezqGLq7SpBLQGqeczzu5moVJTiAK6Fur1/D3DN3dr
         Il2k8eBLkSxQAK1ZR6o3NEsXzLjlS9/PztChy/Ydcpn2A2QP0cGywGZI025rykKwTH+0
         Y6Yii0Ddc2ol+1q+HKMWiRJPJ7YIdL+tmxXdh0b80hj1Ht1H90X4Ca1sMCVr7GWwZGf3
         VPjTIWj1ZSYOtpxWJ54jfVkIOZ4+BRBuJticDBGlvbwx3olx/fPu79U1b0i4TUAaf6zd
         pKkg==
X-Gm-Message-State: APf1xPCVQyntMzxmikb3ocOVvIUPchiTM7MSFn3ZiIDd7Ai7fEN/f/lj
        aODIis/f1ou2F29Zx7gAmAWn7SGxTJM=
X-Google-Smtp-Source: AH8x225M7fNNyI47Nw09+SofICcF5a0TElglP3CC85UYiY5jlr8k7gWAXE/hdBajD5E6rSxAnubzKg==
X-Received: by 10.101.75.68 with SMTP id k4mr397138pgt.335.1517875344029;
        Mon, 05 Feb 2018 16:02:24 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id c184sm18104792pfc.60.2018.02.05.16.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:02:23 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 042/194] object-store: move alternates API to new alternates.h
Date:   Mon,  5 Feb 2018 15:55:03 -0800
Message-Id: <20180205235735.216710-22-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

This should make these functions easier to find and object-store.h
less overwhelming to read.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 alternates.h                | 68 +++++++++++++++++++++++++++++++++++++++++++++
 builtin/clone.c             |  1 +
 builtin/count-objects.c     |  1 +
 builtin/fsck.c              |  3 +-
 builtin/grep.c              |  1 +
 builtin/submodule--helper.c |  1 +
 cache.h                     | 52 ----------------------------------
 object-store.h              | 16 +++++------
 packfile.c                  |  3 +-
 sha1_file.c                 | 23 +++++++--------
 sha1_name.c                 |  3 +-
 submodule.c                 |  1 +
 t/helper/test-ref-store.c   |  1 +
 tmp-objdir.c                |  1 +
 transport.c                 |  1 +
 15 files changed, 102 insertions(+), 74 deletions(-)
 create mode 100644 alternates.h

diff --git a/alternates.h b/alternates.h
new file mode 100644
index 0000000000..df5dc67e2e
--- /dev/null
+++ b/alternates.h
@@ -0,0 +1,68 @@
+#ifndef ALTERNATES_H
+#define ALTERNATES_H
+
+#include "strbuf.h"
+#include "sha1-array.h"
+
+struct alternates {
+	struct alternate_object_database *list;
+	struct alternate_object_database **tail;
+};
+#define ALTERNATES_INIT { NULL, NULL }
+
+struct alternate_object_database {
+	struct alternate_object_database *next;
+
+	/* see alt_scratch_buf() */
+	struct strbuf scratch;
+	size_t base_len;
+
+	/*
+	 * Used to store the results of readdir(3) calls when searching
+	 * for unique abbreviated hashes.  This cache is never
+	 * invalidated, thus it's racy and not necessarily accurate.
+	 * That's fine for its purpose; don't use it for tasks requiring
+	 * greater accuracy!
+	 */
+	char loose_objects_subdir_seen[256];
+	struct oid_array loose_objects_cache;
+
+	/*
+	 * Path to the alternate object database, relative to the
+	 * current working directory.
+	 */
+	char path[FLEX_ARRAY];
+};
+extern void prepare_alt_odb(struct repository *r);
+extern char *compute_alternate_path(const char *path, struct strbuf *err);
+typedef int alt_odb_fn(struct alternate_object_database *, void *);
+extern int foreach_alt_odb(struct repository *r, alt_odb_fn, void*);
+
+/*
+ * Allocate a "struct alternate_object_database" but do _not_ actually
+ * add it to the list of alternates.
+ */
+struct alternate_object_database *alloc_alt_odb(const char *dir);
+
+/*
+ * Add the directory to the on-disk alternates file; the new entry will also
+ * take effect in the current process.
+ */
+extern void add_to_alternates_file(const char *dir);
+
+/*
+ * Add the directory to the in-memory list of alternates (along with any
+ * recursive alternates it points to), but do not modify the on-disk alternates
+ * file.
+ */
+extern void add_to_alternates_memory(const char *dir);
+
+/*
+ * Returns a scratch strbuf pre-filled with the alternate object directory,
+ * including a trailing slash, which can be used to access paths in the
+ * alternate. Always use this over direct access to alt->scratch, as it
+ * cleans up any previous use of the scratch buffer.
+ */
+extern struct strbuf *alt_scratch_buf(struct alternate_object_database *alt);
+
+#endif /* ALTERNATES_H */
diff --git a/builtin/clone.c b/builtin/clone.c
index 2da71db107..27463c8fc5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -11,6 +11,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
+#include "alternates.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
 #include "refs.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index e340b3e3c3..805803fedd 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -8,6 +8,7 @@
 #include "config.h"
 #include "dir.h"
 #include "repository.h"
+#include "alternates.h"
 #include "object-store.h"
 #include "builtin.h"
 #include "parse-options.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0e78f4ba72..571aa51579 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
+#include "alternates.h"
 #include "object-store.h"
 #include "commit.h"
 #include "tree.h"
@@ -696,7 +697,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		fsck_object_dir(get_object_directory());
 
 		prepare_alt_odb(the_repository);
-		for (alt = the_repository->objects.alt_odb_list;
+		for (alt = the_repository->objects.alt_odb.list;
 				alt; alt = alt->next)
 			fsck_object_dir(alt->path);
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 3ca4ac80d8..1c71dff341 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
+#include "alternates.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8005adbf3d..10024c2fa2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2,6 +2,7 @@
 #include "repository.h"
 #include "cache.h"
 #include "config.h"
+#include "alternates.h"
 #include "parse-options.h"
 #include "quote.h"
 #include "pathspec.h"
diff --git a/cache.h b/cache.h
index 3410a93737..b002c9a96d 100644
--- a/cache.h
+++ b/cache.h
@@ -1564,58 +1564,6 @@ extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
 
-struct alternate_object_database {
-	struct alternate_object_database *next;
-
-	/* see alt_scratch_buf() */
-	struct strbuf scratch;
-	size_t base_len;
-
-	/*
-	 * Used to store the results of readdir(3) calls when searching
-	 * for unique abbreviated hashes.  This cache is never
-	 * invalidated, thus it's racy and not necessarily accurate.
-	 * That's fine for its purpose; don't use it for tasks requiring
-	 * greater accuracy!
-	 */
-	char loose_objects_subdir_seen[256];
-	struct oid_array loose_objects_cache;
-
-	/*
-	 * Path to the alternate object database, relative to the
-	 * current working directory.
-	 */
-	char path[FLEX_ARRAY];
-};
-extern char *compute_alternate_path(const char *path, struct strbuf *err);
-
-/*
- * Allocate a "struct alternate_object_database" but do _not_ actually
- * add it to the list of alternates.
- */
-struct alternate_object_database *alloc_alt_odb(const char *dir);
-
-/*
- * Add the directory to the on-disk alternates file; the new entry will also
- * take effect in the current process.
- */
-extern void add_to_alternates_file(const char *dir);
-
-/*
- * Add the directory to the in-memory list of alternates (along with any
- * recursive alternates it points to), but do not modify the on-disk alternates
- * file.
- */
-extern void add_to_alternates_memory(const char *dir);
-
-/*
- * Returns a scratch strbuf pre-filled with the alternate object directory,
- * including a trailing slash, which can be used to access paths in the
- * alternate. Always use this over direct access to alt->scratch, as it
- * cleans up any previous use of the scratch buffer.
- */
-extern struct strbuf *alt_scratch_buf(struct alternate_object_database *alt);
-
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
diff --git a/object-store.h b/object-store.h
index 298e34e978..967dd8af26 100644
--- a/object-store.h
+++ b/object-store.h
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "mru.h"
 #include "replace-object.h"
+#include "alternates.h"
 
 struct object_store {
 	struct packed_git *packed_git;
@@ -14,8 +15,11 @@ struct object_store {
 	 */
 	struct mru packed_git_mru;
 
-	struct alternate_object_database *alt_odb_list;
-	struct alternate_object_database **alt_odb_tail;
+	/*
+	 * Additional object databases to fall back on when an object does not
+	 * exist in the current one (see --reference in git-clone(1)).
+	 */
+	struct alternates alt_odb;
 
 	/*
 	 * Objects that should be substituted by other objects
@@ -37,7 +41,8 @@ struct object_store {
 	 */
 	unsigned packed_git_initialized : 1;
 };
-#define OBJECT_STORE_INIT { NULL, MRU_INIT, NULL, NULL, REPLACE_OBJECTS_INIT, 0, 0, 0 }
+#define OBJECT_STORE_INIT \
+	{ NULL, MRU_INIT, ALTERNATES_INIT, REPLACE_OBJECTS_INIT, 0, 0, 0 }
 
 struct packed_git {
 	struct packed_git *next;
@@ -70,9 +75,4 @@ struct packed_git {
 extern const char *sha1_file_name(struct repository *r, const unsigned char *sha1);
 extern void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
-extern void prepare_alt_odb(struct repository *r);
-
-typedef int alt_odb_fn(struct alternate_object_database *, void *);
-extern int foreach_alt_odb(struct repository *r, alt_odb_fn, void*);
-
 #endif /* OBJECT_STORE_H */
diff --git a/packfile.c b/packfile.c
index 0ca13a4ed7..a7504debe5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2,6 +2,7 @@
 #include "mru.h"
 #include "pack.h"
 #include "repository.h"
+#include "alternates.h"
 #include "dir.h"
 #include "mergesort.h"
 #include "packfile.h"
@@ -880,7 +881,7 @@ void prepare_packed_git(struct repository *r)
 		return;
 	prepare_packed_git_one(r, r->objectdir, 1);
 	prepare_alt_odb(r);
-	for (alt = r->objects.alt_odb_list; alt; alt = alt->next)
+	for (alt = r->objects.alt_odb.list; alt; alt = alt->next)
 		prepare_packed_git_one(r, alt->path, 0);
 	rearrange_packed_git(r);
 	prepare_packed_git_mru(r);
diff --git a/sha1_file.c b/sha1_file.c
index a5dcb76d96..84501d66e9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "string-list.h"
 #include "lockfile.h"
+#include "alternates.h"
 #include "delta.h"
 #include "pack.h"
 #include "blob.h"
@@ -371,7 +372,7 @@ static int alt_odb_usable(struct repository *r, struct strbuf *path,
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects.alt_odb.list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -384,7 +385,7 @@ static int alt_odb_usable(struct repository *r, struct strbuf *path,
 /*
  * Prepare alternate object database registry.
  *
- * The variable alt_odb_list points at the list of struct
+ * The variable objects.alt_odb.list points at the list of struct
  * alternate_object_database.  The elements on this list come from
  * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
  * environment variable, and $GIT_OBJECT_DIRECTORY/info/alternates,
@@ -433,8 +434,8 @@ static int link_alt_odb_entry(struct repository *r, const char *entry,
 	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
-	*r->objects.alt_odb_tail = ent;
-	r->objects.alt_odb_tail = &(ent->next);
+	*r->objects.alt_odb.tail = ent;
+	r->objects.alt_odb.tail = &(ent->next);
 	ent->next = NULL;
 
 	/* recursively add alternates */
@@ -571,7 +572,7 @@ void add_to_alternates_file(const char *reference)
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
-		if (the_repository->objects.alt_odb_tail)
+		if (the_repository->objects.alt_odb.tail)
 			link_alt_odb_entries(the_repository, reference,
 					     '\n', NULL, 0);
 	}
@@ -671,7 +672,7 @@ int foreach_alt_odb(struct repository *r, alt_odb_fn fn, void *cb)
 	int ret = 0;
 
 	prepare_alt_odb(r);
-	for (ent = r->objects.alt_odb_list; ent; ent = ent->next) {
+	for (ent = r->objects.alt_odb.list; ent; ent = ent->next) {
 		ret = fn(ent, cb);
 		if (ret)
 			break;
@@ -681,10 +682,10 @@ int foreach_alt_odb(struct repository *r, alt_odb_fn fn, void *cb)
 
 void prepare_alt_odb(struct repository *r)
 {
-	if (r->objects.alt_odb_tail)
+	if (r->objects.alt_odb.tail)
 		return;
 
-	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
+	r->objects.alt_odb.tail = &r->objects.alt_odb.list;
 
 	if (!r->ignore_env) {
 		const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT);
@@ -737,7 +738,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
 	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects.alt_odb.list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
 			return 1;
@@ -893,7 +894,7 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
 
 	prepare_alt_odb(r);
 	errno = ENOENT;
-	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects.alt_odb.list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
@@ -920,7 +921,7 @@ static int open_sha1_file(struct repository *r,
 	most_interesting_errno = errno;
 
 	prepare_alt_odb(r);
-	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects.alt_odb.list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
diff --git a/sha1_name.c b/sha1_name.c
index d3769713ea..363f7e1d4d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "alternates.h"
 #include "tag.h"
 #include "commit.h"
 #include "tree.h"
@@ -106,7 +107,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		 */
 		fakeent = alloc_alt_odb(get_object_directory());
 	}
-	fakeent->next = the_repository->objects.alt_odb_list;
+	fakeent->next = the_repository->objects.alt_odb.list;
 
 	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
 		int pos;
diff --git a/submodule.c b/submodule.c
index 2967704317..f7736ec4b5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "submodule-config.h"
 #include "submodule.h"
+#include "alternates.h"
 #include "dir.h"
 #include "diff.h"
 #include "commit.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 7120634b04..4b96dfe12f 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alternates.h"
 #include "refs.h"
 #include "worktree.h"
 
diff --git a/tmp-objdir.c b/tmp-objdir.c
index b2d9280f10..bf34315adf 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tmp-objdir.h"
+#include "alternates.h"
 #include "dir.h"
 #include "sigchain.h"
 #include "string-list.h"
diff --git a/transport.c b/transport.c
index 3f97fbe7c5..00f90d7b20 100644
--- a/transport.c
+++ b/transport.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "transport.h"
 #include "repository.h"
+#include "alternates.h"
 #include "run-command.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
-- 
2.15.1.433.g936d1b9894.dirty

