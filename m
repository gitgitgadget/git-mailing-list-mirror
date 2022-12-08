Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6057EC4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 20:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLHU5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 15:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLHU5X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 15:57:23 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1488E92FC8
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 12:57:20 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id t1-20020a170902b20100b001893ac9f0feso2374459plr.4
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 12:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8WVt/LOKumxWbnwx1o4ggrfJzmaBF2OnyEcUOoLQTM=;
        b=LX16Vab7KD/iEvfYSdqnaR7gzHGLZCmpghoqKVTYWmFOmKF9NG6F9HorB/HvfpGyjI
         8trxE7ON/evNC+3F/MxqHi8QCIwuEFF8Muafvzl2u4UeIl1ULRcFB2dtoHVc462eYlyk
         8UcylKSHmp5U3DibEOyajvhMyxWt5ZhHGRaKEV86Nhzij7ooHvYGMZYIm+OoWtvbzHNn
         jgAYCe+FioE+eAXXHof8RWRrPGsllCa2vQ25mOI068va/giCb1sKXSjo2gn9a3vMLiR5
         etYl9HJXMbrYZiXSObq1X7GtMyqqah85qv2v93Ve/LFPcHSC4DQk+vl8c8CS0N5LFx/q
         KKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8WVt/LOKumxWbnwx1o4ggrfJzmaBF2OnyEcUOoLQTM=;
        b=OqWh89gCsz0mQwLAUhv4wQOaGMEJIUFogjm+q/GLB/ITZH57HGDN8QwnrvjvMPzfsn
         Kr7XjCh4CW5VGiIgtva8RvdxafdH7jMuhh0sSAhNfijHmXRNDIFuQg0hb83xxgB/5nZZ
         4DmJbMAYqTXD+5ztY38QpjtqJl4HzdrJJBN9GkAFWxGYLqEqvIQNmjqynZ4fm7qccTcC
         V/aGNpZrhCEyepbtSUEsuRnEa8vSw21Yv4/4b0iatn5ZMy7jDOJ3wjIpsBJIamVD0lfK
         dS/UNZLMyEBYs8QRhltltH9J9ZEmMXETCmkVAgYxawGamSvtb2B/qZJMcYqFhOzsrcYQ
         v2+g==
X-Gm-Message-State: ANoB5pm7ITltvQyoEwwMAIHrP5VdFm9Trck6r+yBXs4qwBADj3md3E94
        awlGibis6oL+JstlHiX+uSV/sHvUWryl0MS9qZucWXBybD5/CThVKP6Px6SCNVEAidk6QFbN2gh
        uq+FwRM/QxsY4xl0MShAReHIxyGdEp7L20XF2ndOGfSKinQfCBCODvIL0Wwd/z8pJUroOpdPPlb
        Co
X-Google-Smtp-Source: AA0mqf7pmhJTMdgVuYGF4qiejfRcOnIVCna351vXOjXEriSGocxS+TKEy+exSneQ8Pk6cPcllDNtMb2xd2W56J3IwpT/
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:80c4:0:b0:574:8c08:595f with
 SMTP id a4-20020aa780c4000000b005748c08595fmr66006149pfn.38.1670533040262;
 Thu, 08 Dec 2022 12:57:20 -0800 (PST)
Date:   Thu,  8 Dec 2022 12:57:07 -0800
In-Reply-To: <cover.1670532905.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1670532905.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <7c9ed861e7431352df864c8d2c3bec7dee6e3905.1670532905.git.jonathantanmy@google.com>
Subject: [PATCH v3 3/4] object-file: emit corruption errors when detected
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        avarab@gmail.com, gitster@pobox.com
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
 object-file.c  | 48 ++++++++++++++++++++++--------------------------
 object-store.h |  3 +++
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/object-file.c b/object-file.c
index d99d05839f..f166065f32 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1433,6 +1433,7 @@ static int loose_object_info(struct repository *r,
 {
 	int status = 0;
 	unsigned long mapsize;
+	const char *path = NULL;
 	void *map;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
@@ -1464,7 +1465,7 @@ static int loose_object_info(struct repository *r,
 		return 0;
 	}
 
-	map = map_loose_object(r, oid, &mapsize);
+	map = map_loose_object_1(r, oid, &mapsize, &path);
 	if (!map)
 		return -1;
 
@@ -1502,6 +1503,10 @@ static int loose_object_info(struct repository *r,
 		break;
 	}
 
+	if (status && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
+		die(_("loose object %s (stored in %s) is corrupt"),
+		    oid_to_hex(oid), path);
+
 	git_inflate_end(&stream);
 cleanup:
 	munmap(map, mapsize);
@@ -1611,6 +1616,15 @@ static int do_oid_object_info_extended(struct repository *r,
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
 
@@ -1663,7 +1677,8 @@ int oid_object_info(struct repository *r,
 
 static void *read_object(struct repository *r,
 			 const struct object_id *oid, enum object_type *type,
-			 unsigned long *size)
+			 unsigned long *size,
+			 int die_if_corrupt)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
@@ -1671,7 +1686,9 @@ static void *read_object(struct repository *r,
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (oid_object_info_extended(r, oid, &oi, 0) < 0)
+	if (oid_object_info_extended(r, oid, &oi,
+				     die_if_corrupt ? OBJECT_INFO_DIE_IF_CORRUPT : 0)
+	    < 0)
 		return NULL;
 	return content;
 }
@@ -1707,35 +1724,14 @@ void *read_object_file_extended(struct repository *r,
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
 
@@ -2278,7 +2274,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 
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
2.39.0.rc1.256.g54fd8350bd-goog

