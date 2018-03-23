Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D64F1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeCWRVy (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:21:54 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33777 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeCWRVp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:45 -0400
Received: by mail-lf0-f67.google.com with SMTP id x205-v6so19396304lfa.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OT/8WrHFHVPmDIurag+GDFvYV4FmhpNrXftp433virs=;
        b=qmT+qaHMIwMsfq0smdhn11FbdTW7F8yn+tjc4pDTbQiFwGzATmgR/IIrmwDfRAzLnv
         wnWVXP7WnXkB3QKiXhEPfhG1I2z8poYoWIO27VfgVoh1wTBxwt54l4dbpffPA6Ot3Ihe
         7HiherdLWz7AudWvsogM2z3IJS7clW0VJVJ8k11v/dCfM10iSp5YXqJPSDjTa6Dx79vn
         PhXAkMKgTRi40SViy6rA+KCmng7enI/Hvapatu38r1NNfSCZmiFbZaU3mBxYFMPX90ZI
         UEqto0OatzpOZH/PDr5jsNAuiNJTpyQnHZmtUJPRcHetX0vjD+BALLJ+z3RBZW3yk8be
         gG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OT/8WrHFHVPmDIurag+GDFvYV4FmhpNrXftp433virs=;
        b=hGofS1OMNyC/Q+fBT6Z1Y+13YXiE+QZwGaxf8pqD6uABNexA3SUe3syoeey7MNUu8M
         tSpWsIwQGbsrAWp50Q59teMwZEOaF1jlHOIkY8Bw38wC4dMrLJWGd97gFAYSQ+5KZLWG
         ampH1rgN9On7LB71TTL9Ig2aHtxDLoXrAs7WIFL6NAYNpribg6hRvuGtTKt8acAMKQJv
         cnHum2YmyH0CLYwa78kRSsNqke6u84lqI/L3cumeQS6NIV6MMzjy4MYLuUFNxDTDiMBY
         pw94XdwBgcK5hb2zVLaP5RYXDSBc7FDZNb9ujnnL5xDaIqrl6qxZY3GHGj2s+iKnb3ou
         G2VA==
X-Gm-Message-State: AElRT7GDUSRsjbU5zqcGBRIWPj3BVXV1JgKqUVFzc8Q1rFNwzx/viOl8
        N9tpxeo6prT5bJADJbqT/j7GZw==
X-Google-Smtp-Source: AG47ELtMVLSAyHQl71wOaI6CvSv8QpU9FxwhLjj2W0sXnKdAZaipCA69d0yb7L0HSCmQKBZD8ckH6g==
X-Received: by 10.46.60.23 with SMTP id j23mr19512758lja.18.1521825704203;
        Fri, 23 Mar 2018 10:21:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/27] object-store: move alt_odb_list and alt_odb_tail to object store
Date:   Fri, 23 Mar 2018 18:20:57 +0100
Message-Id: <20180323172121.17725-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

In a process with multiple repositories open, alternates should be
associated to a single repository and not shared globally. Move
alt_odb_list and alt_odb_tail into the_repository and adjust callers
to reflect this.

Now that the alternative object data base is per repository, we're
leaking its memory upon freeing a repository. The next patch plugs
this hole.

No functional change intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fsck.c |  4 ++++
 object-store.h |  7 +++++--
 packfile.c     |  3 ++-
 sha1_file.c    | 25 ++++++++++++-------------
 sha1_name.c    |  3 ++-
 5 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b0eba4c3c9..c736a10a11 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "commit.h"
 #include "tree.h"
@@ -714,9 +715,12 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
 	} else {
+		struct alternate_object_database *alt_odb_list;
+
 		fsck_object_dir(get_object_directory());
 
 		prepare_alt_odb();
+		alt_odb_list = the_repository->objects->alt_odb_list;
 		for (alt = alt_odb_list; alt; alt = alt->next)
 			fsck_object_dir(alt->path);
 
diff --git a/object-store.h b/object-store.h
index 5002e373cd..0b4db5867d 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,7 +1,7 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
-extern struct alternate_object_database {
+struct alternate_object_database {
 	struct alternate_object_database *next;
 
 	/* see alt_scratch_buf() */
@@ -19,7 +19,7 @@ extern struct alternate_object_database {
 	struct oid_array loose_objects_cache;
 
 	char path[FLEX_ARRAY];
-} *alt_odb_list;
+};
 void prepare_alt_odb(void);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
@@ -61,6 +61,9 @@ struct raw_object_store {
 
 	/* Path to extra alternate object database if not NULL */
 	char *alternate_db;
+
+	struct alternate_object_database *alt_odb_list;
+	struct alternate_object_database **alt_odb_tail;
 };
 
 struct raw_object_store *raw_object_store_new(void);
diff --git a/packfile.c b/packfile.c
index c6651682a7..fdbf240f81 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "list.h"
 #include "pack.h"
+#include "repository.h"
 #include "dir.h"
 #include "mergesort.h"
 #include "packfile.h"
@@ -892,7 +893,7 @@ void prepare_packed_git(void)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next)
+	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
diff --git a/sha1_file.c b/sha1_file.c
index af5aa83db5..84b361c125 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -22,6 +22,7 @@
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
+#include "repository.h"
 #include "streaming.h"
 #include "dir.h"
 #include "list.h"
@@ -343,9 +344,6 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 	return buf->buf;
 }
 
-struct alternate_object_database *alt_odb_list;
-static struct alternate_object_database **alt_odb_tail;
-
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
@@ -365,7 +363,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -425,8 +423,8 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
-	*alt_odb_tail = ent;
-	alt_odb_tail = &(ent->next);
+	*the_repository->objects->alt_odb_tail = ent;
+	the_repository->objects->alt_odb_tail = &(ent->next);
 	ent->next = NULL;
 
 	/* recursively add alternates */
@@ -560,7 +558,7 @@ void add_to_alternates_file(const char *reference)
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
-		if (alt_odb_tail)
+		if (the_repository->objects->alt_odb_tail)
 			link_alt_odb_entries(reference, '\n', NULL, 0);
 	}
 	free(alts);
@@ -658,7 +656,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	int r = 0;
 
 	prepare_alt_odb();
-	for (ent = alt_odb_list; ent; ent = ent->next) {
+	for (ent = the_repository->objects->alt_odb_list; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
 			break;
@@ -668,10 +666,11 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 
 void prepare_alt_odb(void)
 {
-	if (alt_odb_tail)
+	if (the_repository->objects->alt_odb_tail)
 		return;
 
-	alt_odb_tail = &alt_odb_list;
+	the_repository->objects->alt_odb_tail =
+			&the_repository->objects->alt_odb_list;
 	link_alt_odb_entries(the_repository->objects->alternate_db,
 			     PATH_SEP, NULL, 0);
 
@@ -716,7 +715,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
 		const char *path = alt_sha1_path(alt, sha1);
 		if (check_and_freshen_file(path, freshen))
 			return 1;
@@ -876,7 +875,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 
 	prepare_alt_odb();
 	errno = ENOENT;
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
@@ -906,7 +905,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	most_interesting_errno = errno;
 
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
+	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
diff --git a/sha1_name.c b/sha1_name.c
index 434025bf03..a22a29cda0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -11,6 +11,7 @@
 #include "sha1-array.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "repository.h"
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
@@ -105,7 +106,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		 */
 		fakeent = alloc_alt_odb(get_object_directory());
 	}
-	fakeent->next = alt_odb_list;
+	fakeent->next = the_repository->objects->alt_odb_list;
 
 	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
 		int pos;
-- 
2.17.0.rc0.348.gd5a49e0b6f

