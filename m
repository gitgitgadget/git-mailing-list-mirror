Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4B51F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGPN1q (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:46 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:34489 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbeGPN1q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:46 -0400
Received: by mail-pl0-f44.google.com with SMTP id f6-v6so1305545plo.1
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g+atoe3IMwAm0GUIThsbdQmhF0GiadMMtZvodwVJBRY=;
        b=IspDeFToDjPWSU5bcJEEzmSzfwnXgutC98IfBB9eFLZIsIbDS1P3VCHibA/alXBVib
         kG6Zw83FQLE+B74LVdhwMP4G2ybG3AKOfmw+R0Kecrzj4PqdGJf8WX99AGOCJGplMjEp
         9wkug830sv4tdPbmCnyL7102eQfAYz8TkhqppL+LU4PU02iJxf2H8ijUzhP8Utnm5yKa
         tXAOd8HXBl69aK3eXJXf6ChonPdqvx2GePbRaUOxKVF+bh8ppHJzq+MrlsN8wWOhxJ13
         o3BWHblofdz5VDHYcZDUe6mbK9FImfomafl4sNHA6eHWktFNEAKyaoi/+iSOtciMNU0t
         kF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g+atoe3IMwAm0GUIThsbdQmhF0GiadMMtZvodwVJBRY=;
        b=gSexGZCA5nEOFDzJ86IFHXKNurvjW8+qVqzNCDApOaXcNm/cLSIIMo9qQKDu1q0/Is
         NgEIGm4142CjtNQmHEJ47jFd/5LUd3i0Dzc00x7nsvwyq80gY57d9HixeqBhdhWCryU7
         gUtcoBISr7WxiwXIlecmbjiLeNiDvUlyI1JqPkw5KJueh5ZOz4+i8AYCFD0oZ/f1I5W8
         5FYQAd1PZtWXyi3cSX/k1Rza+oOz6l8+4o/Q69qiEl9sOsPWCVF8qsjiFiYKs7XtjxTW
         0mI+rsJNWLRPvQMEPXiQT1wl6iq2TiZ7ogX6fKwGeE0Ssv9MFr7WwbfCDR/viT12L97i
         wwlg==
X-Gm-Message-State: AOUpUlEckXPBc53FcrwnGDmbElyDY3mRBA9LvfzDOGdsq6vEnfSPaMZY
        klzNK9ezj/v6f/bfie6LrgZvEg==
X-Google-Smtp-Source: AAOMgpe0HeY7OOBCpPYKgRtd6gwIlfk8j1C8G7dZmMggzGr/eIcubHA2LhMMFCUvbYa9aO52ZNv3Og==
X-Received: by 2002:a17:902:5381:: with SMTP id c1-v6mr16393222pli.137.1531746024903;
        Mon, 16 Jul 2018 06:00:24 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id p11-v6sm69392494pfj.72.2018.07.16.06.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:23 -0700 (PDT)
Message-Id: <cf4559e08c47adcaf4c938a325acf829a5759285.1531746011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Jul 2018 16:52:23 -0400
Subject: [PATCH 07/16] commit-reach: move can_all_from_reach_with_flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h | 13 ++++++++++
 upload-pack.c  | 69 +-------------------------------------------------
 3 files changed, 76 insertions(+), 68 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9e56f90ea..e07ff993f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -9,6 +9,7 @@
 #include "commit-reach.h"
 
 /* Remember to update object flag allocation in object.h */
+#define REACHABLE       (1u<<15)
 #define PARENT1		(1u<<16)
 #define PARENT2		(1u<<17)
 #define STALE		(1u<<18)
@@ -531,3 +532,64 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
 	return is_descendant_of(commit, list);
 }
+
+int reachable(struct commit *from, int with_flag, int assign_flag,
+	      time_t min_commit_date)
+{
+	struct prio_queue work = { compare_commits_by_commit_date };
+
+	prio_queue_put(&work, from);
+	while (work.nr) {
+		struct commit_list *list;
+		struct commit *commit = prio_queue_get(&work);
+
+		if (commit->object.flags & with_flag) {
+			from->object.flags |= assign_flag;
+			break;
+		}
+		if (!commit->object.parsed)
+			parse_object(the_repository, &commit->object.oid);
+		if (commit->object.flags & REACHABLE)
+			continue;
+		commit->object.flags |= REACHABLE;
+		if (commit->date < min_commit_date)
+			continue;
+		for (list = commit->parents; list; list = list->next) {
+			struct commit *parent = list->item;
+			if (!(parent->object.flags & REACHABLE))
+				prio_queue_put(&work, parent);
+		}
+	}
+	from->object.flags |= REACHABLE;
+	clear_commit_marks(from, REACHABLE);
+	clear_prio_queue(&work);
+	return (from->object.flags & assign_flag);
+}
+
+int can_all_from_reach_with_flag(struct object_array *from,
+				 int with_flag, int assign_flag,
+				 time_t min_commit_date)
+{
+	int i;
+
+	for (i = 0; i < from->nr; i++) {
+		struct object *from_one = from->objects[i].item;
+
+		if (from_one->flags & assign_flag)
+			continue;
+		from_one = deref_tag(the_repository, from_one, "a from object", 0);
+		if (!from_one || from_one->type != OBJ_COMMIT) {
+			/* no way to tell if this is reachable by
+			 * looking at the ancestry chain alone, so
+			 * leave a note to ourselves not to worry about
+			 * this object anymore.
+			 */
+			from->objects[i].item->flags |= assign_flag;
+			continue;
+		}
+		if (!reachable((struct commit *)from_one, with_flag, assign_flag,
+			       min_commit_date))
+			return 0;
+	}
+	return 1;
+}
diff --git a/commit-reach.h b/commit-reach.h
index 925cb05d7..ce3b963e6 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -56,4 +56,17 @@ define_commit_slab(contains_cache, enum contains_result);
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache);
 
+int reachable(struct commit *from, int with_flag, int assign_flag,
+	      time_t min_commit_date);
+
+/*
+ * Determine if every commit in 'from' can reach at least one commit
+ * that is marked with 'with_flag'. As we traverse, use 'assign_flag'
+ * as a marker for commits that are already visited. Do not walk
+ * commits with date below 'min_commit_date'.
+ */
+int can_all_from_reach_with_flag(struct object_array *from,
+				 int with_flag, int assign_flag,
+				 time_t min_commit_date);
+
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index 96298e50e..11c426685 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -24,13 +24,13 @@
 #include "quote.h"
 #include "upload-pack.h"
 #include "serve.h"
+#include "commit-reach.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
 #define OUR_REF		(1u << 12)
 #define WANTED		(1u << 13)
 #define COMMON_KNOWN	(1u << 14)
-#define REACHABLE	(1u << 15)
 
 #define SHALLOW		(1u << 16)
 #define NOT_SHALLOW	(1u << 17)
@@ -336,73 +336,6 @@ static int got_oid(const char *hex, struct object_id *oid)
 	return 0;
 }
 
-static int reachable(struct commit *from, int with_flag, int assign_flag,
-		     time_t min_commit_date)
-{
-	struct prio_queue work = { compare_commits_by_commit_date };
-
-	prio_queue_put(&work, from);
-	while (work.nr) {
-		struct commit_list *list;
-		struct commit *commit = prio_queue_get(&work);
-
-		if (commit->object.flags & with_flag) {
-			from->object.flags |= assign_flag;
-			break;
-		}
-		if (!commit->object.parsed)
-			parse_object(the_repository, &commit->object.oid);
-		if (commit->object.flags & REACHABLE)
-			continue;
-		commit->object.flags |= REACHABLE;
-		if (commit->date < min_commit_date)
-			continue;
-		for (list = commit->parents; list; list = list->next) {
-			struct commit *parent = list->item;
-			if (!(parent->object.flags & REACHABLE))
-				prio_queue_put(&work, parent);
-		}
-	}
-	from->object.flags |= REACHABLE;
-	clear_commit_marks(from, REACHABLE);
-	clear_prio_queue(&work);
-	return (from->object.flags & assign_flag);
-}
-
-/*
- * Determine if every commit in 'from' can reach at least one commit
- * that is marked with 'with_flag'. As we traverse, use 'assign_flag'
- * as a marker for commits that are already visited. Do not walk
- * commits with date below 'min_commit_date'.
- */
-static int can_all_from_reach_with_flag(struct object_array *from,
-					int with_flag, int assign_flag,
-					time_t min_commit_date)
-{
-	int i;
-
-	for (i = 0; i < from->nr; i++) {
-		struct object *from_one = from->objects[i].item;
-
-		if (from_one->flags & assign_flag)
-			continue;
-		from_one = deref_tag(the_repository, from_one, "a from object", 0);
-		if (!from_one || from_one->type != OBJ_COMMIT) {
-			/* no way to tell if this is reachable by
-			 * looking at the ancestry chain alone, so
-			 * leave a note to ourselves not to worry about
-			 * this object anymore.
-			 */
-			from->objects[i].item->flags |= assign_flag;
-			continue;
-		}
-		if (!reachable((struct commit *)from_one, with_flag, assign_flag,
-			       min_commit_date))
-			return 0;
-	}
-	return 1;
-}
-
 static int ok_to_give_up(void)
 {
 	if (!have_obj.nr)
-- 
gitgitgadget

