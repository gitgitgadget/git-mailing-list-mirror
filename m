Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D2E1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeBEX4Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:16 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39025 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeBEXzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:53 -0500
Received: by mail-pl0-f65.google.com with SMTP id o13so84287pli.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GLMH5vYcahI0A+V+auoH6COeB/SnGD/Md9aD2ch6ZbU=;
        b=UOUtZdV+sN0vVjzl7D0DlTxql5BNV05pHnpdWRAvD33zSdzBu79BVIZ+prFi9Um01f
         CFCoz6WWkN44I0YkSjxoh0wtDuHyp9Bl0YvJzqwKjb9Bf1V+0FTC2nySklr2YrVl/9WX
         zqPFvFoqqdDFTYnm/1Vo/pxeXBUW5vhkTJWYnoxLv6rYpJR9w/GVe1HpWb+OvSUnafyU
         9R1woDhxvnOoPxL5UVU+ySg55bN4FW/MTXW6Gsjb92F+PKk7VbQL+brSw+I6ZocWbKvA
         uGhPvsYhBdBhMt/qE4RqAsjUU0TjxIylKIHwSG+DF5NKHALCog2yuQ9RxIydFZxwJGIR
         D+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GLMH5vYcahI0A+V+auoH6COeB/SnGD/Md9aD2ch6ZbU=;
        b=MBBauWrVNPr6ScVlABR4PMCYANw0YAvR8+dFIOAR/Mtw9sEyF308Pc41iym56QHRb7
         jxzzeaAv50kCNIg/r1idjuLZe2zX+DvrvDQP1R8dYccgtihGeH+ctuxy76IZoQaF+kcz
         e3lF7gJnEWU3rNuTp3oCVHwfTdty7O+/T3N/Ma7U3Gs2foUU/3RQTrmDWVzk9cjYTmj+
         2o+duLW+DfrMK6B5/gwIKUllm82q6NJRTet5HDnTdO6DuhUYQSKTWwfLJg+m6XpKvxTT
         6cZyRcNHh0rj0oXdxuLHeufmapAeuk5YVnhpGqAstMruynLpOIc/o3ZfKP/BYwnk/V1Z
         LPng==
X-Gm-Message-State: APf1xPB2LOUPYU/Fkew0McJ8JroM/HHGrqaLIJhuK34jGuN2YzRUljny
        3bQ0FtHMfi34C6XmXCstQos6qY+zEw8=
X-Google-Smtp-Source: AH8x22772kmrVW0Z9G0tbRaXfOks7GbXv1yHzFxtAYFweq4DG/JucOBBWPNM7VhSM7aastFUdeZ5NA==
X-Received: by 2002:a17:902:9897:: with SMTP id s23-v6mr490936plp.238.1517874951747;
        Mon, 05 Feb 2018 15:55:51 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id y131sm18979846pfg.69.2018.02.05.15.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:51 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 014/194] object-store: add repository argument to prepare_alt_odb
Date:   Mon,  5 Feb 2018 15:52:08 -0800
Message-Id: <20180205235508.216277-15-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow prepare_alt_odb callers to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

While at it, move the declaration to object-store.h, where it should
be easier to find.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fsck.c |  2 +-
 cache.h        |  1 -
 object-store.h |  3 +++
 packfile.c     |  2 +-
 sha1_file.c    | 13 +++++++------
 sha1_name.c    |  3 ++-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d4d249c2ed..00ec8eecf0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -695,7 +695,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	} else {
 		fsck_object_dir(get_object_directory());
 
-		prepare_alt_odb();
+		prepare_alt_odb(the_repository);
 		for (alt = the_repository->objects.alt_odb_list;
 				alt; alt = alt->next)
 			fsck_object_dir(alt->path);
diff --git a/cache.h b/cache.h
index 459fd01dbb..70518e24ce 100644
--- a/cache.h
+++ b/cache.h
@@ -1592,7 +1592,6 @@ struct alternate_object_database {
 
 	char path[FLEX_ARRAY];
 };
-extern void prepare_alt_odb(void);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/object-store.h b/object-store.h
index 99f77d10cd..e749c952d5 100644
--- a/object-store.h
+++ b/object-store.h
@@ -54,4 +54,7 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+#define prepare_alt_odb(r) prepare_alt_odb_##r()
+extern void prepare_alt_odb_the_repository(void);
+
 #endif /* OBJECT_STORE_H */
diff --git a/packfile.c b/packfile.c
index 31c4ea54ae..fbb2385bad 100644
--- a/packfile.c
+++ b/packfile.c
@@ -879,7 +879,7 @@ void prepare_packed_git(void)
 	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
diff --git a/sha1_file.c b/sha1_file.c
index 514f59c390..779bfd4079 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -23,6 +23,7 @@
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
 #include "repository.h"
+#include "object-store.h"
 #include "streaming.h"
 #include "dir.h"
 #include "mru.h"
@@ -585,7 +586,7 @@ void add_to_alternates_memory(const char *reference)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 
 	link_alt_odb_entries(the_repository, reference,
 			     '\n', NULL, 0);
@@ -671,7 +672,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	struct alternate_object_database *ent;
 	int r = 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
@@ -680,7 +681,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb(void)
+void prepare_alt_odb_the_repository(void)
 {
 	const char *alt;
 
@@ -729,7 +730,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
@@ -885,7 +886,7 @@ static int stat_sha1_file_the_repository(const unsigned char *sha1,
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	errno = ENOENT;
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
@@ -914,7 +915,7 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
diff --git a/sha1_name.c b/sha1_name.c
index 016c883b5c..3e490ee8f6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -11,6 +11,7 @@
 #include "sha1-array.h"
 #include "packfile.h"
 #include "repository.h"
+#include "object-store.h"
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
@@ -353,7 +354,7 @@ static int init_object_disambiguation(const char *name, int len,
 
 	ds->len = len;
 	ds->hex_pfx[len] = '\0';
-	prepare_alt_odb();
+	prepare_alt_odb(the_repository);
 	return 0;
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

