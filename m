Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC1EC3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 00:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLGAlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLGAlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 19:41:04 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EF4DE6
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 16:41:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3c2837e751fso171229307b3.15
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 16:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MtNcRg9gx15fQkZGQVfxHG9FA62oUPWiJii0hdPqRls=;
        b=Nf2kZ5IoV83+lfFhghyJf+ABaxJCLJ4oj4BQ0EOFOOrsTDAMlNQdbXr6GwCdOi6t31
         htqZQKp3OanApCZhoYGS4HTZVqIWH/WTrk2Jk+TxAtuKQuhoLwFPPQY7B15QZ6/Y65u2
         PBIsBRZXRAz7kpv3le8nzVWNj7rkfCGHUJyPF4m2u70wCcHneHEWbVNwg10MTGH2YRVF
         9sy17R52dIUL/eTYZCeuOuZMDfI7voBDMcAxhfF+t6wwjdWldV6tmOvUDNpp+yXCeuta
         8v2yKrMFiyLNyd2jDY40WjWBvddMtNo97hWb0nv7YNVZQUCyse3iaWA7lbKLJ6IgfQGb
         6Gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtNcRg9gx15fQkZGQVfxHG9FA62oUPWiJii0hdPqRls=;
        b=ztIiKHu4Wr2qvHrlj7HSv9UwC07EoenjuT+VJyky0YW8kr7bjKdK5qzFdJw+84naUb
         weh8DLJAzhXOrduhM5fFIf/kaIyCspuASCW2DpNB/mwZujMKvamt2yy4e8J/KBQfvvT+
         F6uK1GFqzzsi3OYmu2KbiRdzB7Fy5RD7KamNaYZZZF770z//4DKirh8FsvsYwXhHSf52
         bfdbYAws8jbbd1hxQY8JXsFi7O0nmBd6ElpSWuTaU0mMBp7AgUL7G75aZ7+B8+hZLKn/
         tjEWspHM5IOXFgHs4oRt8nJzU0UWZrmOd9FLuorU3EDWR1K2/2fMLCKypMY6WALyV9yI
         PyzA==
X-Gm-Message-State: ANoB5plp75uaBtw6EnNm/cxTOX6WURaY2RvNaUJLSXMWkrp0VfyfDmQ2
        3Awr/pYZS/TBME7T+z8TGIR4AcAerHFvWmd99RvqmSvg3B6Cn5v2ayfu8QEI+bocNsmBZZxPIBQ
        lo7o4vZNBLBt3O+H/ZpEvxdLzQFK8p2p/b2PH41yGUvewPKISR8gsTAZ91N3EZgA1eTwdM4htND
        C1
X-Google-Smtp-Source: AA0mqf76B/rsMhSQDToU4QvR9oMCyeTrUqrn58E4L12GdG5y/QQ4XYDOr0H2/5+QTwWXQUku+90zxPpXxVruRGhNJL+P
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:c17:b0:3dc:3cb6:992f with
 SMTP id cl23-20020a05690c0c1700b003dc3cb6992fmr24056686ywb.116.1670373662665;
 Tue, 06 Dec 2022 16:41:02 -0800 (PST)
Date:   Tue,  6 Dec 2022 16:40:52 -0800
In-Reply-To: <cover.1670373420.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670373420.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <9ddfff3585c293c9801570e395b514505796a43f.1670373420.git.jonathantanmy@google.com>
Subject: [PATCH v2 2/3] object-file: emit corruption errors when detected
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of relying on errno being preserved across function calls, teach
do_oid_object_info_extended() to itself report object corruption when
it first detects it. There are 3 types of corruption being detected:
 - when a replacement object is missing
 - when a loose object is corrupt
 - when a packed object is corrupt and the object cannot be read
   in another way

Note that in the RHS of this patch's diff, a check for ENOENT that was
introduced in 3ba7a06552 (A loose object is not corrupt if it cannot
be read due to EMFILE, 2010-10-28) is also removed. The purpose of this
check is to avoid a false report of corruption if the errno contains
something like EMFILE (or anything that is not ENOENT), in which case
a more generic report is presented. Because, as of this patch, we no
longer rely on such a heuristic to determine corruption, but surface
the error message at the point when we read something that we did not
expect, this check is no longer necessary.

Besides being more resilient, this also prepares for a future patch in
which an indirect caller of do_oid_object_info_extended() will need
such functionality.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c  | 63 ++++++++++++++++++++++++++------------------------
 object-store.h |  3 +++
 2 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/object-file.c b/object-file.c
index 596dd049fd..c7a513d123 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1215,7 +1215,8 @@ static int quick_has_loose(struct repository *r,
  * searching for a loose object named "oid".
  */
 static void *map_loose_object_1(struct repository *r, const char *path,
-			     const struct object_id *oid, unsigned long *size)
+				const struct object_id *oid, unsigned long *size,
+				char **mapped_path)
 {
 	void *map;
 	int fd;
@@ -1224,6 +1225,9 @@ static void *map_loose_object_1(struct repository *r, const char *path,
 		fd = git_open(path);
 	else
 		fd = open_loose_object(r, oid, &path);
+	if (mapped_path)
+		*mapped_path = xstrdup(path);
+
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
@@ -1247,7 +1251,7 @@ void *map_loose_object(struct repository *r,
 		       const struct object_id *oid,
 		       unsigned long *size)
 {
-	return map_loose_object_1(r, NULL, oid, size);
+	return map_loose_object_1(r, NULL, oid, size, NULL);
 }
 
 enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
@@ -1428,6 +1432,7 @@ static int loose_object_info(struct repository *r,
 {
 	int status = 0;
 	unsigned long mapsize;
+	char *mapped_path = NULL;
 	void *map;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
@@ -1459,9 +1464,11 @@ static int loose_object_info(struct repository *r,
 		return 0;
 	}
 
-	map = map_loose_object(r, oid, &mapsize);
-	if (!map)
+	map = map_loose_object_1(r, NULL, oid, &mapsize, &mapped_path);
+	if (!map) {
+		free(mapped_path);
 		return -1;
+	}
 
 	if (!oi->sizep)
 		oi->sizep = &size_scratch;
@@ -1497,8 +1504,13 @@ static int loose_object_info(struct repository *r,
 		break;
 	}
 
+	if (status && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
+		die(_("loose object %s (stored in %s) is corrupt"),
+		    oid_to_hex(oid), mapped_path);
+
 	git_inflate_end(&stream);
 cleanup:
+	free(mapped_path);
 	munmap(map, mapsize);
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
@@ -1608,6 +1620,15 @@ static int do_oid_object_info_extended(struct repository *r,
 			continue;
 		}
 
+		if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
+			const struct packed_git *p;
+			if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
+				die(_("replacement %s not found for %s"),
+				    oid_to_hex(real), oid_to_hex(oid));
+			if ((p = has_packed_and_bad(r, real)))
+				die(_("packed object %s (stored in %s) is corrupt"),
+				    oid_to_hex(real), p->pack_name);
+		}
 		return -1;
 	}
 
@@ -1660,7 +1681,8 @@ int oid_object_info(struct repository *r,
 
 static void *read_object(struct repository *r,
 			 const struct object_id *oid, enum object_type *type,
-			 unsigned long *size)
+			 unsigned long *size,
+			 int die_if_corrupt)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
@@ -1668,7 +1690,9 @@ static void *read_object(struct repository *r,
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (oid_object_info_extended(r, oid, &oi, 0) < 0)
+	if (oid_object_info_extended(r, oid, &oi,
+				     die_if_corrupt ? OBJECT_INFO_DIE_IF_CORRUPT : 0)
+	    < 0)
 		return NULL;
 	return content;
 }
@@ -1704,35 +1728,14 @@ void *read_object_file_extended(struct repository *r,
 				int lookup_replace)
 {
 	void *data;
-	const struct packed_git *p;
-	const char *path;
-	struct stat st;
 	const struct object_id *repl = lookup_replace ?
 		lookup_replace_object(r, oid) : oid;
 
 	errno = 0;
-	data = read_object(r, repl, type, size);
+	data = read_object(r, repl, type, size, 1);
 	if (data)
 		return data;
 
-	obj_read_lock();
-	if (errno && errno != ENOENT)
-		die_errno(_("failed to read object %s"), oid_to_hex(oid));
-
-	/* die if we replaced an object with one that does not exist */
-	if (repl != oid)
-		die(_("replacement %s not found for %s"),
-		    oid_to_hex(repl), oid_to_hex(oid));
-
-	if (!stat_loose_object(r, repl, &st, &path))
-		die(_("loose object %s (stored in %s) is corrupt"),
-		    oid_to_hex(repl), path);
-
-	if ((p = has_packed_and_bad(r, repl)))
-		die(_("packed object %s (stored in %s) is corrupt"),
-		    oid_to_hex(repl), p->pack_name);
-	obj_read_unlock();
-
 	return NULL;
 }
 
@@ -2275,7 +2278,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 
 	if (has_loose_object(oid))
 		return 0;
-	buf = read_object(the_repository, oid, &type, &len);
+	buf = read_object(the_repository, oid, &type, &len, 0);
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
@@ -2797,7 +2800,7 @@ int read_loose_object(const char *path,
 	char hdr[MAX_HEADER_LEN];
 	unsigned long *size = oi->sizep;
 
-	map = map_loose_object_1(the_repository, path, NULL, &mapsize);
+	map = map_loose_object_1(the_repository, path, NULL, &mapsize, NULL);
 	if (!map) {
 		error_errno(_("unable to mmap %s"), path);
 		goto out;
diff --git a/object-store.h b/object-store.h
index 1be57abaf1..01134ab5ec 100644
--- a/object-store.h
+++ b/object-store.h
@@ -447,6 +447,9 @@ struct object_info {
  */
 #define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
 
+/* Die if object corruption (not just an object being missing) was detected. */
+#define OBJECT_INFO_DIE_IF_CORRUPT 64
+
 int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
 			     struct object_info *, unsigned flags);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

