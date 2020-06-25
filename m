Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE49C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FAE206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6vyiCS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404819AbgFYMtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404764AbgFYMtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DB2C061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so5411836wme.5
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uWs8OBZ7TKTQ9bYiyxTNF1gqLcJ/CRc+feKkElRyM0=;
        b=a6vyiCS8efjVJRm8n9Rop9/F8XzMf7atBUkSkrNp4X851E2kb1i+l08WkB725VIZJo
         LW4JBSnR8rI77BwPVJW8+IyfOB5j1I+BjdPehUqs2glkKOyyaiQgFWpNWBX35xaOWAen
         PevAUTl9inE5rTCj11WrybwG8mnR73IyoY7/W/CUYuTzcuSpLfljJYfhb01ePpD4proV
         7KhPb4AVpY2NoDeI5CzfEOZapzrnFkvSp5Ii4+omDX94UopV97u9ilb7uVEetpc24RDX
         c2ljz+bAUmrSpIODN/TNqSpKxhJy1i7R4l1mO4cX5qQugN+PZjr9JuXCe6UBVP6GCO6M
         3nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uWs8OBZ7TKTQ9bYiyxTNF1gqLcJ/CRc+feKkElRyM0=;
        b=cDK7StQLzHYagS2izQTdTkj112YxKWLkPX6PqlJx/hJjqyUcV1QdnzFU94/CoIbLLE
         Hj+Ck7QRfpIonnKqzBzJ4N9VbsEPO/lImzHKoVirAxvqMmw2VODHYOhdRY9N3xLi4nMy
         KYL3EIhaOWcpdI6M2yWDl1qUo3WYgXyswo0v6mdSzJU6NsMlX69m7+zPwyqk8PLGDIAn
         O+OH+Z/ky54+P/vpntgBjTkhICJPOvemkbcfKNGO9jWcRxN2zuwGnnhCQzhYPFwFqJG/
         E0dUzrcc4f7XG8Gq7Vou5ho7aX6vtX8ah7fwpDWWxbOl4XA9UCDD4f71xauzeN0+H9zF
         R0DQ==
X-Gm-Message-State: AOAM533aeFeKr0NjK/z9n+oIeNRlN6TC39+vE+xSH9uefZX61ApHAxlQ
        nBO7VufXuBAl3viIWZtqhV+5/zzI
X-Google-Smtp-Source: ABdhPJzQcFG24dCLy8kaWR+TP27zDIVP4cM1KQqDqA99ySADCoKigmsH2WupbbHZxvKbU3atGBKATg==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr3224625wmh.130.1593089345012;
        Thu, 25 Jun 2020 05:49:05 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:04 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 09/17] merge-resolve: libify merge_resolve()
Date:   Thu, 25 Jun 2020 14:19:45 +0200
Message-Id: <20200625121953.16991-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves merge_resolve() (and its helper functions) to
merge-strategies.c.  This will enable `git merge' and the sequencer to
directly call it instead of forking.

Here too, this is not a faithful copy-and-paste; the new
merge_resolve() (renamed merge_strategies_resolve()) takes a pointer to
the repository, instead of using `the_repository'.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---

Notes:
    This patch is best viewed with `--color-moved'.

 builtin/merge-resolve.c | 86 +----------------------------------------
 merge-strategies.c      | 85 ++++++++++++++++++++++++++++++++++++++++
 merge-strategies.h      |  5 +++
 3 files changed, 91 insertions(+), 85 deletions(-)

diff --git a/builtin/merge-resolve.c b/builtin/merge-resolve.c
index 2c364fcdb0..59f734473b 100644
--- a/builtin/merge-resolve.c
+++ b/builtin/merge-resolve.c
@@ -10,92 +10,8 @@
  */
 
 #include "cache.h"
-#include "cache-tree.h"
 #include "builtin.h"
-#include "lockfile.h"
 #include "merge-strategies.h"
-#include "unpack-trees.h"
-
-static int add_tree(const struct object_id *oid, struct tree_desc *t)
-{
-	struct tree *tree;
-
-	tree = parse_tree_indirect(oid);
-	if (parse_tree(tree))
-		return -1;
-
-	init_tree_desc(t, tree->buffer, tree->size);
-	return 0;
-}
-
-static int merge_resolve(struct commit_list *bases, const char *head_arg,
-			 struct commit_list *remote)
-{
-	int i = 0;
-	struct lock_file lock = LOCK_INIT;
-	struct tree_desc t[MAX_UNPACK_TREES];
-	struct unpack_trees_options opts;
-	struct object_id head, oid;
-	struct commit_list *j;
-
-	if (head_arg)
-		get_oid(head_arg, &head);
-
-	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
-	refresh_index(the_repository->index, 0, NULL, NULL, NULL);
-
-	memset(&opts, 0, sizeof(opts));
-	opts.head_idx = 1;
-	opts.src_index = the_repository->index;
-	opts.dst_index = the_repository->index;
-	opts.update = 1;
-	opts.merge = 1;
-	opts.aggressive = 1;
-
-	for (j = bases; j; j = j->next) {
-		if (add_tree(&j->item->object.oid, t + (i++)))
-			goto out;
-	}
-
-	if (head_arg && add_tree(&head, t + (i++)))
-		goto out;
-	if (remote && add_tree(&remote->item->object.oid, t + (i++)))
-		goto out;
-
-	if (i == 1)
-		opts.fn = oneway_merge;
-	else if (i == 2) {
-		opts.fn = twoway_merge;
-		opts.initial_checkout = is_index_unborn(the_repository->index);
-	} else if (i >= 3) {
-		opts.fn = threeway_merge;
-		opts.head_idx = i - 1;
-	}
-
-	if (unpack_trees(i, t, &opts))
-		goto out;
-
-	puts("Trying simple merge.");
-	write_locked_index(the_repository->index, &lock, COMMIT_LOCK);
-
-	if (write_index_as_tree(&oid, the_repository->index,
-				the_repository->index_file, 0, NULL)) {
-		int ret;
-
-		repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
-		ret = merge_all(the_repository->index, 0, 0,
-				merge_one_file_cb, the_repository);
-
-		write_locked_index(the_repository->index, &lock, COMMIT_LOCK);
-		return !!ret;
-	}
-
-	return 0;
-
- out:
-	rollback_lock_file(&lock);
-	return 2;
-}
 
 static const char builtin_merge_resolve_usage[] =
 	"git merge-resolve <bases>... -- <head> <remote>";
@@ -149,5 +65,5 @@ int cmd_merge_resolve(int argc, const char **argv, const char *prefix)
 	if (is_baseless)
 		return 2;
 
-	return merge_resolve(bases, head, remote);
+	return merge_strategies_resolve(the_repository, bases, head, remote);
 }
diff --git a/merge-strategies.c b/merge-strategies.c
index 39bfa1af7b..a12c575590 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -1,7 +1,10 @@
 #include "cache.h"
+#include "cache-tree.h"
 #include "dir.h"
+#include "lockfile.h"
 #include "merge-strategies.h"
 #include "run-command.h"
+#include "unpack-trees.h"
 #include "xdiff-interface.h"
 
 static int add_to_index_cacheinfo(struct index_state *istate,
@@ -299,3 +302,85 @@ int merge_all(struct index_state *istate, int oneshot, int quiet,
 
 	return err;
 }
+
+static int add_tree(const struct object_id *oid, struct tree_desc *t)
+{
+	struct tree *tree;
+
+	tree = parse_tree_indirect(oid);
+	if (parse_tree(tree))
+		return -1;
+
+	init_tree_desc(t, tree->buffer, tree->size);
+	return 0;
+}
+
+int merge_strategies_resolve(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remote)
+{
+	int i = 0;
+	struct lock_file lock = LOCK_INIT;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct unpack_trees_options opts;
+	struct object_id head, oid;
+	struct commit_list *j;
+
+	if (head_arg)
+		get_oid(head_arg, &head);
+
+	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
+	refresh_index(r->index, 0, NULL, NULL, NULL);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = r->index;
+	opts.dst_index = r->index;
+	opts.update = 1;
+	opts.merge = 1;
+	opts.aggressive = 1;
+
+	for (j = bases; j && j->item; j = j->next) {
+		if (add_tree(&j->item->object.oid, t + (i++)))
+			goto out;
+	}
+
+	if (head_arg && add_tree(&head, t + (i++)))
+		goto out;
+	if (remote && add_tree(&remote->item->object.oid, t + (i++)))
+		goto out;
+
+	if (i == 1)
+		opts.fn = oneway_merge;
+	else if (i == 2) {
+		opts.fn = twoway_merge;
+		opts.initial_checkout = is_index_unborn(r->index);
+	} else if (i >= 3) {
+		opts.fn = threeway_merge;
+		opts.head_idx = i - 1;
+	}
+
+	if (unpack_trees(i, t, &opts))
+		goto out;
+
+	puts("Trying simple merge.");
+	write_locked_index(r->index, &lock, COMMIT_LOCK);
+
+	if (write_index_as_tree(&oid, r->index, r->index_file,
+				WRITE_TREE_SILENT, NULL)) {
+		int ret;
+
+		puts("Simple merge failed, trying Automatic merge.");
+		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
+		ret = merge_all(r->index, 0, 0, merge_one_file_cb, r);
+
+		write_locked_index(r->index, &lock, COMMIT_LOCK);
+		return !!ret;
+	}
+
+	return 0;
+
+ out:
+	rollback_lock_file(&lock);
+	return 2;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
index 40e175ca39..778f8ce9d6 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -1,6 +1,7 @@
 #ifndef MERGE_STRATEGIES_H
 #define MERGE_STRATEGIES_H
 
+#include "commit.h"
 #include "object.h"
 
 int merge_strategies_one_file(struct repository *r,
@@ -33,4 +34,8 @@ int merge_one_path(struct index_state *istate, int oneshot, int quiet,
 int merge_all(struct index_state *istate, int oneshot, int quiet,
 	      merge_cb cb, void *data);
 
+int merge_strategies_resolve(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remote);
+
 #endif /* MERGE_STRATEGIES_H */
-- 
2.27.0.139.gc9c318d6bf

