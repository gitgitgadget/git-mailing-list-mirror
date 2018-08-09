Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75FE31F405
	for <e@80x24.org>; Thu,  9 Aug 2018 22:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeHJBMe (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 21:12:34 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:43891 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeHJBMe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 21:12:34 -0400
Received: by mail-it0-f74.google.com with SMTP id d9-v6so136655itf.8
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Toy6ksCxaToT0+gVtye5bDm5+lFeCi8aNIqODvLDWVU=;
        b=TQ1T9aDSY0Tt/Hner3KpRrIDPdZyxjDmIqrQ3y5MHV+7qxacELN9ouRzLOyzjWPUpk
         +zFzAtqA6/mjl+hyN2iekEgRy62WDKtqt0dNPERuh42405NgldABer/xP/lz7gu3vkzy
         o4lIghzoidTOdSYMRFDtdFfbEPedX0Zu/tQKKibBre+Ry5jR11DGVJ+Pf6VhUYN/EU7D
         cTyMuTS1o7brJAif1cL5k9U+Q0DFSCuLQMHzIFCG8ue5vtMav3JywiS7kbpRb5OcIDAl
         AkWYIXslwLKWhy4UYvl9aHAKcad/s6aCttKNsJn5Ir0lL6rnTMeSNq83CJA1grVXa/2r
         2J9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Toy6ksCxaToT0+gVtye5bDm5+lFeCi8aNIqODvLDWVU=;
        b=j7BfQh7PpcA+L1TCaxEDMW0ThBTzhuiZYDyUc1RMRErxjmF0D7rC1qMuLYA04IZfM6
         yx7H8ljOR54pGgoBoyEDBgK2LCOPvxeVik5+zpEEDL4OulBf6jZq4+UHD4F8A5woTA1Q
         UtlqXcCGqknB3kV94D8gaq8YBCs0Kgpg2b3aOeSAGJq8+Ievxy8YgFgZiT916RD8rGZj
         M4rAvmyn+0OLjvVg0HD0Z3sjsWPSknzWBXWS+iWZzdnihvk7VUMnYHoYV/FIkU/aMlV/
         J7XmUfG1FoB94CZZGFEYdYBATE5Gvz+pK4YK2pgQeE1SOxODSXIaLp6IYE3gs7L//UXM
         W0og==
X-Gm-Message-State: AOUpUlE3Iojo10xDmePH1zeBKtutO85njKWnOTfEuoYidXP/Kw7syIt2
        DeDSmPbjN1m9dSKsqHdQMBhwVXnkMitlLmZ/wK6yX2s7W7FMV7oJ355tCRc1ss/cyc2DmYXelQ6
        bLdxKZ+ZVQousA3vkGL3/qVPAUcnvrG1PhmsfZZdxJKCQXapmabUSBV8woPM=
X-Google-Smtp-Source: AA+uWPzjLAzVTgS4C3qSRgGLckdH4fxq/qo/ZIKl0QFUECGoA40qM4krv5C8WM+4qmRbJwThA6lU61odMJVf
X-Received: by 2002:a24:74cd:: with SMTP id o196-v6mr101758itc.46.1533854734020;
 Thu, 09 Aug 2018 15:45:34 -0700 (PDT)
Date:   Thu,  9 Aug 2018 15:45:00 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <87799036f82793b691e899bda4fb882a4b231c3a.1533854545.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 1/5] revision: invert meaning of the USER_GIVEN flag
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abandon the previous approach of mutating all new objects implicitly in
add_pending_object by inverting the meaning of the bit (it is now
NOT_USER_GIVEN) and only setting the flag when we need to.

This more accurately tracks if a tree was provided directly by the user.
Without this patch, the root tree of all commits were erroneously
considered to be USER_GIVEN, which meant they cannot be filtered. This
distinction is important in the next patch.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects.c | 31 ++++++++++++++++++-------------
 revision.c     |  1 -
 revision.h     | 10 +++++++---
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index c99c47ac1..482044bda 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -48,7 +48,7 @@ static void process_blob(struct rev_info *revs,
 
 	pathlen = path->len;
 	strbuf_addstr(path, name);
-	if (!(obj->flags & USER_GIVEN) && filter_fn)
+	if ((obj->flags & NOT_USER_GIVEN) && filter_fn)
 		r = filter_fn(LOFS_BLOB, obj,
 			      path->buf, &path->buf[pathlen],
 			      filter_data);
@@ -133,7 +133,7 @@ static void process_tree(struct rev_info *revs,
 	}
 
 	strbuf_addstr(base, name);
-	if (!(obj->flags & USER_GIVEN) && filter_fn)
+	if ((obj->flags & NOT_USER_GIVEN) && filter_fn)
 		r = filter_fn(LOFS_BEGIN_TREE, obj,
 			      base->buf, &base->buf[baselen],
 			      filter_data);
@@ -156,23 +156,25 @@ static void process_tree(struct rev_info *revs,
 				continue;
 		}
 
-		if (S_ISDIR(entry.mode))
-			process_tree(revs,
-				     lookup_tree(the_repository, entry.oid),
-				     show, base, entry.path,
+		if (S_ISDIR(entry.mode)) {
+			struct tree *t = lookup_tree(the_repository, entry.oid);
+			t->object.flags |= NOT_USER_GIVEN;
+			process_tree(revs, t, show, base, entry.path,
 				     cb_data, filter_fn, filter_data);
+		}
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.oid->hash,
 					show, base, entry.path,
 					cb_data);
-		else
-			process_blob(revs,
-				     lookup_blob(the_repository, entry.oid),
-				     show, base, entry.path,
+		else {
+			struct blob *b = lookup_blob(the_repository, entry.oid);
+			b->object.flags |= NOT_USER_GIVEN;
+			process_blob(revs, b, show, base, entry.path,
 				     cb_data, filter_fn, filter_data);
+		}
 	}
 
-	if (!(obj->flags & USER_GIVEN) && filter_fn) {
+	if ((obj->flags & NOT_USER_GIVEN) && filter_fn) {
 		r = filter_fn(LOFS_END_TREE, obj,
 			      base->buf, &base->buf[baselen],
 			      filter_data);
@@ -301,8 +303,11 @@ static void do_traverse(struct rev_info *revs,
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
 		 */
-		if (get_commit_tree(commit))
-			add_pending_tree(revs, get_commit_tree(commit));
+		if (get_commit_tree(commit)) {
+			struct tree *tree = get_commit_tree(commit);
+			tree->object.flags |= NOT_USER_GIVEN;
+			add_pending_tree(revs, tree);
+		}
 		show_commit(commit, show_data);
 
 		if (revs->tree_blobs_in_commit_order)
diff --git a/revision.c b/revision.c
index 062749437..6d355b43c 100644
--- a/revision.c
+++ b/revision.c
@@ -175,7 +175,6 @@ static void add_pending_object_with_path(struct rev_info *revs,
 		strbuf_release(&buf);
 		return; /* do not add the commit itself */
 	}
-	obj->flags |= USER_GIVEN;
 	add_object_array_with_path(obj, name, &revs->pending, mode, path);
 }
 
diff --git a/revision.h b/revision.h
index c599c34da..cd6b62313 100644
--- a/revision.h
+++ b/revision.h
@@ -8,7 +8,11 @@
 #include "diff.h"
 #include "commit-slab-decl.h"
 
-/* Remember to update object flag allocation in object.h */
+/* Remember to update object flag allocation in object.h
+ * NEEDSWORK: NOT_USER_GIVEN doesn't apply to commits because we only support
+ * filtering trees and blobs, but it may be useful to support filtering commits
+ * in the future.
+ */
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
 #define TREESAME	(1u<<2)
@@ -20,9 +24,9 @@
 #define SYMMETRIC_LEFT	(1u<<8)
 #define PATCHSAME	(1u<<9)
 #define BOTTOM		(1u<<10)
-#define USER_GIVEN	(1u<<25) /* given directly by the user */
+#define NOT_USER_GIVEN	(1u<<25) /* tree or blob not given directly by user */
 #define TRACK_LINEAR	(1u<<26)
-#define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
+#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
-- 
2.18.0.597.ga71716f1ad-goog

