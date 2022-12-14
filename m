Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0084DC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 19:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiLNTSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 14:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiLNTRy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 14:17:54 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AA12AE39
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:17:53 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id f6-20020a17090a700600b00219d2137efeso98334pjk.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M40pj/w/VBdqvFKprqZ8kklyqmT/n6XYXEGdrm77yCk=;
        b=sLd7pUaTVcgnOq+JsrlBVhsv3hwHpvnj/Gn6a9qiQNRkcdOtvhbgUX4wWYEN7wvx4J
         CGlOCVVXrregTqUJwk67qSc+FgdMqC8rHKMyoOhrep/ZwoHNlh6kEShT4+KzRYXoGHoM
         SowFJRu+S79/YeTMhIQm3HNBLiOJPTHZCXz/Zv+7/MQYUoYe5pv18//wR5bMv9EEsYn9
         LMocNJqcT8LikMh0KL3Evg3su6AwrqOla9PEtwHfOfsse++3Y20qQVCqnID7GTA+AX+6
         ZhtCbAQ3vIWa9nFUEou1gDXdADiz9IpaFA5gck6JKkUL97QUiZnoMAjUH03BgokhlowW
         qpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M40pj/w/VBdqvFKprqZ8kklyqmT/n6XYXEGdrm77yCk=;
        b=Pf5ViOOSkQn+agh5IUrXfKAL4oMbNOFo7w+0UwnspS0TZzeLYVQnn2lCrsy2D/hNXi
         E8qdrL+acUbVaIrb6lvp7xMNiq5aCFt/CMESgv/CiHUH9ZQQXoPfdE1+6yynsL+fcLMQ
         K/OyniEjfXKnq0iC3FqFdTlXruCdgazvbwaGqekBdl0hLTHE29fsA1uHzrIEvPX0oywS
         5iqIKlReZ3Qn0QLCWh/MPqIMvsI+x6JQJFX20zNM01xynmIq11z6XJ29fJrlcl9ThUwt
         oO9FpgdctrUsjJDJS1+ERseJ1fk1osngZj0iuaKQVInOShLHGOByyiHd3LiVXuyJqePE
         o/bQ==
X-Gm-Message-State: ANoB5pm29e/em/ryahaJ6aAdOvrTJwWEXgp5DdEJyk+mZecsMGeZhgSi
        KomufcNuxcuZbJP2erFNGkAPRGgim2lp5/dibeMtYbq0yLeJxdyBdcCJQu0NfEIrlVLWbHziobn
        uG7hrS6PyYpTV51RJT3Ceo1yXJqzwXAeyc7kJqucKCChDBdtYl6uw4Rzxu1rfuOkri9e5APGnQO
        u/
X-Google-Smtp-Source: AA0mqf7SsI8FSJg/V81IVXjY3WUYi4WNL2BZGXcJ0dsoqGHys9QMv9UQ7kfCTisZDMzEnSGnGR9IiOoFGBeIOPvgg0pW
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:28f:b0:189:8a36:1b70 with
 SMTP id j15-20020a170903028f00b001898a361b70mr54943418plr.12.1671045472799;
 Wed, 14 Dec 2022 11:17:52 -0800 (PST)
Date:   Wed, 14 Dec 2022 11:17:42 -0800
In-Reply-To: <cover.1671045259.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1671045259.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <811620909a9efff9de6cb5c3a1076da0f13e3875.1671045259.git.jonathantanmy@google.com>
Subject: [PATCH v6 3/4] object-file: emit corruption errors when detected
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

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c  | 55 +++++++++++++++++++++++++-------------------------
 object-store.h |  3 +++
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/object-file.c b/object-file.c
index 429e3a746d..e55697e378 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1422,7 +1422,9 @@ static int loose_object_info(struct repository *r,
 			     struct object_info *oi, int flags)
 {
 	int status = 0;
+	int fd;
 	unsigned long mapsize;
+	const char *path;
 	void *map;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
@@ -1443,7 +1445,6 @@ static int loose_object_info(struct repository *r,
 	 * object even exists.
 	 */
 	if (!oi->typep && !oi->type_name && !oi->sizep && !oi->contentp) {
-		const char *path;
 		struct stat st;
 		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
 			return quick_has_loose(r, oid) ? 0 : -1;
@@ -1454,7 +1455,13 @@ static int loose_object_info(struct repository *r,
 		return 0;
 	}
 
-	map = map_loose_object(r, oid, &mapsize);
+	fd = open_loose_object(r, oid, &path);
+	if (fd < 0) {
+		if (errno != ENOENT)
+			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
+		return -1;
+	}
+	map = map_fd(fd, path, &mapsize);
 	if (!map)
 		return -1;
 
@@ -1492,6 +1499,10 @@ static int loose_object_info(struct repository *r,
 		break;
 	}
 
+	if (status && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
+		die(_("loose object %s (stored in %s) is corrupt"),
+		    oid_to_hex(oid), path);
+
 	git_inflate_end(&stream);
 cleanup:
 	munmap(map, mapsize);
@@ -1601,6 +1612,15 @@ static int do_oid_object_info_extended(struct repository *r,
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
 
@@ -1653,7 +1673,8 @@ int oid_object_info(struct repository *r,
 
 static void *read_object(struct repository *r,
 			 const struct object_id *oid, enum object_type *type,
-			 unsigned long *size)
+			 unsigned long *size,
+			 int die_if_corrupt)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
@@ -1661,7 +1682,8 @@ static void *read_object(struct repository *r,
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (oid_object_info_extended(r, oid, &oi, 0) < 0)
+	if (oid_object_info_extended(r, oid, &oi, die_if_corrupt
+				     ? OBJECT_INFO_DIE_IF_CORRUPT : 0) < 0)
 		return NULL;
 	return content;
 }
@@ -1697,35 +1719,14 @@ void *read_object_file_extended(struct repository *r,
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
 
@@ -2268,7 +2269,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 
 	if (has_loose_object(oid))
 		return 0;
-	buf = read_object(the_repository, oid, &type, &len);
+	buf = read_object(the_repository, oid, &type, &len, 0);
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
diff --git a/object-store.h b/object-store.h
index b1ec0bde82..98c1d67946 100644
--- a/object-store.h
+++ b/object-store.h
@@ -445,6 +445,9 @@ struct object_info {
  */
 #define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
 
+/* Die if object corruption (not just an object being missing) was detected. */
+#define OBJECT_INFO_DIE_IF_CORRUPT 32
+
 int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
 			     struct object_info *, unsigned flags);
-- 
2.39.0.314.g84b9a713c41-goog

