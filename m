Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F2F1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeHKBiz (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:38:55 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:58554 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeHKBiz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:38:55 -0400
Received: by mail-it0-f74.google.com with SMTP id y13-v6so3243209ita.8
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 16:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Mp+11DhHajmw8rIsX9jcO3yisP3tMy8dJZLIZhEYXow=;
        b=pIEWkwK+DxncE58Wo4nTg70vGzrnc3SZNsc5V/p2g+aTmt6V+XfqwIuNCAAxGz/WpT
         zcUfOXclk/C9gQ34AADl2bbzR1jVGUOK8q3opJ6Be2Zu6tg+afWff10hGlWURcsMZYs5
         x0cday0Dd+KIyczrmh/ZDZFXLWjEn9nj6V7d6xWVd5AvJw2dZrUnoZQyXTqCzjScoGVL
         kTtTakCK/seKIUVfZht3rLWfHAWlWQYk0gAyrVcvvyHRSfn7vx0QbJK7zc4V9PtzRtOv
         Y2JeekjaB6FyfOtJN3VIqRJ336GHaYz6ZX9jYTVdb9TbWspST0pD1y5dmYXEgKhVETZ8
         PNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mp+11DhHajmw8rIsX9jcO3yisP3tMy8dJZLIZhEYXow=;
        b=g7llyhVbBDXEuT1mUCyxd7OPVqVwPNovMNkmMNhwVOXN0/+6T5Vh6xWLwvRlFnwSf2
         IZAFH68CiMIt0I12U07CDUmQ1iWJWyqw24zj4mUPAF4Pdnk8sWscdZhOfoyH7KbAIjPX
         MW9jolMAQaCV2HaLfF6AUpZiJATjyjuIBtQM3BjSAExX+oUYuprgeTdNHac/ikPGSqAo
         CFPcg7smWWlDqaNNaekQ/TbewN0CPUs5BHil2D57Aal3c/Q2XDxMb0dalNdXWOE/NG0a
         KY3BCkZ+BktGVctnXAur0374nN4OOlwMs1Ks9NdoZAUNyeL0xSmtqW+IhgrMkit4sLZg
         O1RQ==
X-Gm-Message-State: AOUpUlEPTB8EnTUnzor0QAPR7brgnvspn7nxWcXy+ybxn3zP6Duan39V
        juhzOPrkKeeRgb/xXbTDG0zQgc+n/HdyM385qqVsziVoGBvV49+h0omMJA6ujcBUg1FNTm0XpG9
        gKZ7g/AKVHX0iVWyEvgXA7lEu8Wwin0vwBvmURyttY5WPaxKS0nxrkIrya0w=
X-Google-Smtp-Source: AA+uWPzyZkc65NGNaMpQKGqsxPqFqoaX/gpsSX7b9ZCWGarW/7ZnhupnyL/HLQrZTOSOSs/gOeYUYYaW+Bh6
X-Received: by 2002:a6b:99d3:: with SMTP id b202-v6mr1432304ioe.54.1533942418394;
 Fri, 10 Aug 2018 16:06:58 -0700 (PDT)
Date:   Fri, 10 Aug 2018 16:06:28 -0700
In-Reply-To: <cover.1533941986.git.matvore@google.com>
Message-Id: <448e2dc86aa009c1a0872739fa550c3f97d7bed1.1533941986.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533941986.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v2 4/5] revision: mark non-user-given objects instead
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, list-objects.c incorrectly treats all root trees of commits
as USER_GIVEN. Also, it would be easier to mark objects that are
non-user-given instead of user-given, since the places in the code
where we access an object through a reference are more obvious than
the places where we access an object that was given by the user.

Resolve these two problems by introducing a flag NOT_USER_GIVEN that
marks blobs and trees that are non-user-given, replacing USER_GIVEN.
(Only blobs and trees are marked because this mark is only used when
filtering objects, and filtering of other types of objects is not
supported yet.)

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects.c | 31 ++++++++++++++++++-------------
 revision.c     |  1 -
 revision.h     | 10 +++++++---
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index aedcd0228..fd522a59a 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -53,7 +53,7 @@ static void process_blob(struct traversal_context *ctx,
 
 	pathlen = path->len;
 	strbuf_addstr(path, name);
-	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn)
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
 		r = ctx->filter_fn(LOFS_BLOB, obj,
 				   path->buf, &path->buf[pathlen],
 				   ctx->filter_data);
@@ -120,17 +120,19 @@ static void process_tree_contents(struct traversal_context *ctx,
 				continue;
 		}
 
-		if (S_ISDIR(entry.mode))
-			process_tree(ctx,
-				     lookup_tree(the_repository, entry.oid),
-				     base, entry.path);
+		if (S_ISDIR(entry.mode)) {
+			struct tree *t = lookup_tree(the_repository, entry.oid);
+			t->object.flags |= NOT_USER_GIVEN;
+			process_tree(ctx, t, base, entry.path);
+		}
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(ctx, entry.oid->hash,
 					base, entry.path);
-		else
-			process_blob(ctx,
-				     lookup_blob(the_repository, entry.oid),
-				     base, entry.path);
+		else {
+			struct blob *b = lookup_blob(the_repository, entry.oid);
+			b->object.flags |= NOT_USER_GIVEN;
+			process_blob(ctx, b, base, entry.path);
+		}
 	}
 }
 
@@ -169,7 +171,7 @@ static void process_tree(struct traversal_context *ctx,
 	}
 
 	strbuf_addstr(base, name);
-	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn)
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
 		r = ctx->filter_fn(LOFS_BEGIN_TREE, obj,
 				   base->buf, &base->buf[baselen],
 				   ctx->filter_data);
@@ -183,7 +185,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (parsed)
 		process_tree_contents(ctx, tree, base);
 
-	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn) {
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
 		r = ctx->filter_fn(LOFS_END_TREE, obj,
 				   base->buf, &base->buf[baselen],
 				   ctx->filter_data);
@@ -299,8 +301,11 @@ static void do_traverse(struct traversal_context *ctx)
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
 		 */
-		if (get_commit_tree(commit))
-			add_pending_tree(ctx->revs, get_commit_tree(commit));
+		if (get_commit_tree(commit)) {
+			struct tree *tree = get_commit_tree(commit);
+			tree->object.flags |= NOT_USER_GIVEN;
+			add_pending_tree(ctx->revs, tree);
+		}
 		ctx->show_commit(commit, ctx->show_data);
 
 		if (ctx->revs->tree_blobs_in_commit_order)
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

