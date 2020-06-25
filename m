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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4FBC433E2
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C59206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxlmPwiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404838AbgFYMtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404824AbgFYMtM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B741C061796
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so2716277wrw.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8GWl9cTGQrdzNrHSGCqWybQf/w9pKToCmVncpH0OCI=;
        b=pxlmPwiVFT/8b9Tpd+QSrzAzr2a5oC2ixf26iB8JdJCtr0PFBd7h0+SX46mhFaLmcp
         kj45W99RMJHlf4vq4ZPeLqHCAwQDe0YiK+hF3iLN4IGkUYi8WhXURGn180S9kyuZc0L8
         XpS758G21gZWwXmKWr4f5042yV95SwRBreeDzaKoEuH3SKq4XfkmWQY1aNMKvJAhvtCD
         /tS/LEpYF6gZq7v6cxX5se68avbQoYnE3nG5dh3FYoJINg4w1B8E259pO+qntgQ6HBYm
         wt1YB/2DWNz96YDswMkvfpLvwnLtNidAMId1HVnVuSYY/egZXpUnQ19o6yGsym1t/McD
         r9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8GWl9cTGQrdzNrHSGCqWybQf/w9pKToCmVncpH0OCI=;
        b=sHaiCefRFwkbTriZR+0fRNjueR60YZDBJQuJBtU1TOgWN5nVidbmh+p+c+tXeppkHL
         oMh+Oy803WDD9PsMLMvMyh70RxMjiGSBTXmyxDU72i1a2X0VrGrlkpilRU6tJtaFUcvI
         haXoo1/o2Jw04hsXnV1qiXt0fEvSxsfJYU+DfzqMUffAvWAmRm9OBenpc9JB6lXgT8g8
         XMepcy34ZYod9b6cvSBq30nS2U/Ms+bk5oloygXJumstXhNl2eWdmUOYm6kIjAJqJMhn
         jus0CfQzUAjkva/m93zOJDEbnhywdMGkHQSVzzy3UGhpQVD1iAq1MSdqhvjegfbsnXCM
         v1+Q==
X-Gm-Message-State: AOAM532/ozctt1P9wo2vRfN51XHqMd+jl43kr0Dcwj5w1r7lNFN06RGI
        nmaLPQrZGBqTPMLaSKsA2I7g2iS7
X-Google-Smtp-Source: ABdhPJwnctqzHMPCOuY8j3V0RELQWgTRXl3MlkBpMP/HWrwStUE6423EwPRlj+oMqrkx/b5kXfGP6g==
X-Received: by 2002:adf:f784:: with SMTP id q4mr11393126wrp.397.1593089350374;
        Thu, 25 Jun 2020 05:49:10 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:09 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 13/17] merge-octopus: libify merge_octopus()
Date:   Thu, 25 Jun 2020 14:19:49 +0200
Message-Id: <20200625121953.16991-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves merge_octopus() (and its helper functions) to
merge-strategies.c.  This will enable `git merge' and the sequencer to
directly call it instead of forking.

Once again, this is not a faithful copy-and-paste; the new
merge_octopus() (renamed merge_strategies_octopus()) takes a pointer to
the repository, instead of using `the_repository'.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---

Notes:
    This patch is best viewed with `--color-moved'.

 builtin/merge-octopus.c | 197 +---------------------------------------
 merge-strategies.c      | 191 ++++++++++++++++++++++++++++++++++++++
 merge-strategies.h      |   3 +
 3 files changed, 196 insertions(+), 195 deletions(-)

diff --git a/builtin/merge-octopus.c b/builtin/merge-octopus.c
index 14310a4eb1..37bbdf11cc 100644
--- a/builtin/merge-octopus.c
+++ b/builtin/merge-octopus.c
@@ -9,202 +9,9 @@
  */
 
 #include "cache.h"
-#include "cache-tree.h"
 #include "builtin.h"
-#include "commit-reach.h"
-#include "lockfile.h"
+#include "commit.h"
 #include "merge-strategies.h"
-#include "unpack-trees.h"
-
-static int fast_forward(const struct object_id *oids, int nr, int aggressive)
-{
-	int i;
-	struct tree_desc t[MAX_UNPACK_TREES];
-	struct unpack_trees_options opts;
-	struct lock_file lock = LOCK_INIT;
-
-	repo_read_index_preload(the_repository, NULL, 0);
-	if (refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL))
-		return -1;
-
-	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
-
-	memset(&opts, 0, sizeof(opts));
-	opts.head_idx = 1;
-	opts.src_index = the_repository->index;
-	opts.dst_index = the_repository->index;
-	opts.merge = 1;
-	opts.update = 1;
-	opts.aggressive = aggressive;
-
-	for (i = 0; i < nr; i++) {
-		struct tree *tree;
-		tree = parse_tree_indirect(oids + i);
-		if (parse_tree(tree))
-			return -1;
-		init_tree_desc(t + i, tree->buffer, tree->size);
-	}
-
-	if (nr == 1)
-		opts.fn = oneway_merge;
-	else if (nr == 2) {
-		opts.fn = twoway_merge;
-		opts.initial_checkout = is_index_unborn(the_repository->index);
-	} else if (nr >= 3) {
-		opts.fn = threeway_merge;
-		opts.head_idx = nr - 1;
-	}
-
-	if (unpack_trees(nr, t, &opts))
-		return -1;
-
-	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK))
-		return error(_("unable to write new index file"));
-
-	return 0;
-}
-
-static int write_tree(struct tree **reference_tree)
-{
-	struct object_id oid;
-	int ret;
-
-	ret = write_index_as_tree(&oid, the_repository->index,
-				  the_repository->index_file, 0, NULL);
-	if (!ret)
-		*reference_tree = lookup_tree(the_repository, &oid);
-
-	return ret;
-}
-
-static int merge_octopus(struct commit_list *bases, const char *head_arg,
-			 struct commit_list *remotes)
-{
-	int non_ff_merge = 0, ret = 0, references = 1;
-	struct commit **reference_commit;
-	struct tree *reference_tree;
-	struct commit_list *j;
-	struct object_id head;
-	struct strbuf sb = STRBUF_INIT;
-
-	get_oid(head_arg, &head);
-
-	reference_commit = xcalloc(commit_list_count(remotes) + 1, sizeof(struct commit *));
-	reference_commit[0] = lookup_commit_reference(the_repository, &head);
-	reference_tree = get_commit_tree(reference_commit[0]);
-
-	if (repo_index_has_changes(the_repository, reference_tree, &sb)) {
-		error(_("Your local changes to the following files "
-			"would be overwritten by merge:\n  %s"),
-		      sb.buf);
-		strbuf_release(&sb);
-		ret = 2;
-		goto out;
-	}
-
-	for (j = remotes; j; j = j->next) {
-		struct commit *c = j->item;
-		struct object_id *oid = &c->object.oid;
-		struct commit_list *common, *k;
-		char *branch_name;
-		int can_ff = 1;
-
-		if (ret) {
-			puts(_("Automated merge did not work."));
-			puts(_("Should not be doing an octopus."));
-
-			ret = 2;
-			goto out;
-		}
-
-		branch_name = merge_get_better_branch_name(oid_to_hex(oid));
-		common = get_merge_bases_many(c, references, reference_commit);
-
-		if (!common)
-			die(_("Unable to find common commit with %s"), branch_name);
-
-		for (k = common; k && !oideq(&k->item->object.oid, oid); k = k->next);
-
-		if (k) {
-			printf(_("Already up to date with %s\n"), branch_name);
-			free(branch_name);
-			free_commit_list(common);
-			continue;
-		}
-
-		if (!non_ff_merge) {
-			int i;
-
-			for (i = 0, k = common; k && i < references && can_ff; k = k->next, i++) {
-				can_ff = oideq(&k->item->object.oid,
-					       &reference_commit[i]->object.oid);
-			}
-		}
-
-		if (!non_ff_merge && can_ff) {
-			struct object_id oids[2];
-			printf(_("Fast-forwarding to: %s\n"), branch_name);
-
-			oidcpy(oids, &head);
-			oidcpy(oids + 1, oid);
-
-			ret = fast_forward(oids, 2, 0);
-			if (ret) {
-				free(branch_name);
-				free_commit_list(common);
-				goto out;
-			}
-
-			references = 0;
-			write_tree(&reference_tree);
-		} else {
-			int i = 0;
-			struct tree *next = NULL;
-			struct object_id oids[MAX_UNPACK_TREES];
-
-			non_ff_merge = 1;
-			printf(_("Trying simple merge with %s\n"), branch_name);
-
-			for (k = common; k; k = k->next)
-				oidcpy(oids + (i++), &k->item->object.oid);
-
-			oidcpy(oids + (i++), &reference_tree->object.oid);
-			oidcpy(oids + (i++), oid);
-
-			if (fast_forward(oids, i, 1)) {
-				ret = 2;
-
-				free(branch_name);
-				free_commit_list(common);
-
-				goto out;
-			}
-
-			if (write_tree(&next)) {
-				struct lock_file lock = LOCK_INIT;
-
-				puts(_("Simple merge did not work, trying automatic merge."));
-				repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
-				ret = !!merge_all(the_repository->index, 0, 0,
-						  merge_one_file_cb, the_repository);
-				write_locked_index(the_repository->index, &lock, COMMIT_LOCK);
-
-				write_tree(&next);
-			}
-
-			reference_tree = next;
-		}
-
-		reference_commit[references++] = c;
-
-		free(branch_name);
-		free_commit_list(common);
-	}
-
-out:
-	free(reference_commit);
-	return ret;
-}
 
 static const char builtin_merge_octopus_usage[] =
 	"git merge-octopus [<bases>...] -- <head> <remote1> <remote2> [<remotes>...]";
@@ -254,5 +61,5 @@ int cmd_merge_octopus(int argc, const char **argv, const char *prefix)
 	if (commit_list_count(remotes) < 2)
 		return 2;
 
-	return merge_octopus(bases, head_arg, remotes);
+	return merge_strategies_octopus(the_repository, bases, head_arg, remotes);
 }
diff --git a/merge-strategies.c b/merge-strategies.c
index a12c575590..8395c4c787 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "cache-tree.h"
+#include "commit-reach.h"
 #include "dir.h"
 #include "lockfile.h"
 #include "merge-strategies.h"
@@ -384,3 +385,193 @@ int merge_strategies_resolve(struct repository *r,
 	rollback_lock_file(&lock);
 	return 2;
 }
+
+static int fast_forward(struct repository *r, const struct object_id *oids,
+			int nr, int aggressive)
+{
+	int i;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct unpack_trees_options opts;
+	struct lock_file lock = LOCK_INIT;
+
+	repo_read_index_preload(r, NULL, 0);
+	if (refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL))
+		return -1;
+
+	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = r->index;
+	opts.dst_index = r->index;
+	opts.merge = 1;
+	opts.update = 1;
+	opts.aggressive = aggressive;
+
+	for (i = 0; i < nr; i++) {
+		struct tree *tree;
+		tree = parse_tree_indirect(oids + i);
+		if (parse_tree(tree))
+			return -1;
+		init_tree_desc(t + i, tree->buffer, tree->size);
+	}
+
+	if (nr == 1)
+		opts.fn = oneway_merge;
+	else if (nr == 2) {
+		opts.fn = twoway_merge;
+		opts.initial_checkout = is_index_unborn(r->index);
+	} else if (nr >= 3) {
+		opts.fn = threeway_merge;
+		opts.head_idx = nr - 1;
+	}
+
+	if (unpack_trees(nr, t, &opts))
+		return -1;
+
+	if (write_locked_index(r->index, &lock, COMMIT_LOCK))
+		return error(_("unable to write new index file"));
+
+	return 0;
+}
+
+static int write_tree(struct repository *r, struct tree **reference_tree)
+{
+	struct object_id oid;
+	int ret;
+
+	ret = write_index_as_tree(&oid, r->index, r->index_file, 0, NULL);
+	if (!ret)
+		*reference_tree = lookup_tree(r, &oid);
+
+	return ret;
+}
+
+int merge_strategies_octopus(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remotes)
+{
+	int non_ff_merge = 0, ret = 0, references = 1;
+	struct commit **reference_commit;
+	struct tree *reference_tree;
+	struct commit_list *j;
+	struct object_id head;
+	struct strbuf sb = STRBUF_INIT;
+
+	get_oid(head_arg, &head);
+
+	reference_commit = xcalloc(commit_list_count(remotes) + 1, sizeof(struct commit *));
+	reference_commit[0] = lookup_commit_reference(r, &head);
+	reference_tree = repo_get_commit_tree(r, reference_commit[0]);
+
+	if (repo_index_has_changes(r, reference_tree, &sb)) {
+		error(_("Your local changes to the following files "
+			"would be overwritten by merge:\n  %s"),
+		      sb.buf);
+		strbuf_release(&sb);
+		ret = 2;
+		goto out;
+	}
+
+	for (j = remotes; j && j->item; j = j->next) {
+		struct commit *c = j->item;
+		struct object_id *oid = &c->object.oid;
+		struct commit_list *common, *k;
+		char *branch_name;
+		int can_ff = 1;
+
+		if (ret) {
+			puts(_("Automated merge did not work."));
+			puts(_("Should not be doing an octopus."));
+
+			ret = 2;
+			goto out;
+		}
+
+		branch_name = merge_get_better_branch_name(oid_to_hex(oid));
+		common = get_merge_bases_many(c, references, reference_commit);
+
+		if (!common)
+			die(_("Unable to find common commit with %s"), branch_name);
+
+		for (k = common; k && !oideq(&k->item->object.oid, oid); k = k->next);
+
+		if (k) {
+			printf(_("Already up to date with %s\n"), branch_name);
+			free(branch_name);
+			free_commit_list(common);
+			continue;
+		}
+
+		if (!non_ff_merge) {
+			int i;
+
+			for (i = 0, k = common; k && i < references && can_ff; k = k->next, i++) {
+				can_ff = oideq(&k->item->object.oid,
+					       &reference_commit[i]->object.oid);
+			}
+		}
+
+		if (!non_ff_merge && can_ff) {
+			struct object_id oids[2];
+			printf(_("Fast-forwarding to: %s\n"), branch_name);
+
+			oidcpy(oids, &head);
+			oidcpy(oids + 1, oid);
+
+			ret = fast_forward(r, oids, 2, 0);
+			if (ret) {
+				free(branch_name);
+				free_commit_list(common);
+				goto out;
+			}
+
+			references = 0;
+			write_tree(r, &reference_tree);
+		} else {
+			int i = 0;
+			struct tree *next = NULL;
+			struct object_id oids[MAX_UNPACK_TREES];
+
+			non_ff_merge = 1;
+			printf(_("Trying simple merge with %s\n"), branch_name);
+
+			for (k = common; k; k = k->next)
+				oidcpy(oids + (i++), &k->item->object.oid);
+
+			oidcpy(oids + (i++), &reference_tree->object.oid);
+			oidcpy(oids + (i++), oid);
+
+			if (fast_forward(r, oids, i, 1)) {
+				ret = 2;
+
+				free(branch_name);
+				free_commit_list(common);
+
+				goto out;
+			}
+
+			if (write_tree(r, &next)) {
+				struct lock_file lock = LOCK_INIT;
+
+				puts(_("Simple merge did not work, trying automatic merge."));
+				repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
+				ret = !!merge_all(r->index, 0, 0, merge_one_file_cb, r);
+				write_locked_index(r->index, &lock, COMMIT_LOCK);
+
+				write_tree(r, &next);
+			}
+
+			reference_tree = next;
+		}
+
+		reference_commit[references++] = c;
+
+		free(branch_name);
+		free_commit_list(common);
+	}
+
+out:
+	free(reference_commit);
+	return ret;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
index 778f8ce9d6..938411a04e 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -37,5 +37,8 @@ int merge_all(struct index_state *istate, int oneshot, int quiet,
 int merge_strategies_resolve(struct repository *r,
 			     struct commit_list *bases, const char *head_arg,
 			     struct commit_list *remote);
+int merge_strategies_octopus(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remote);
 
 #endif /* MERGE_STRATEGIES_H */
-- 
2.27.0.139.gc9c318d6bf

