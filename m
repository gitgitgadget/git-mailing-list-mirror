Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC3C4363D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E079A2078D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npSo0L3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgJEM1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJEM1p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF226C0613A7
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:27:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y15so8588885wmi.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3rB3VNrc+86vIwdvgJqzkxd0B5WUYC0AkgCKiXyEq7o=;
        b=npSo0L3yd+HVCo8a6DFNhuEMkm8cojA+7TZeMgdZq/cQhbZXmqciUcRa4NvOcCC8Ku
         HwfS1Q2zgIfISkQsZ6vPxHsnaKKuCr8zLoo5QY9xk+X6gTQ4OCdI9/0S/XN671DZBsUm
         pW/yVY9S74LQcNwytW/fePwJzj3euvUBayQwtqgj6YpTs8uV6SkDElAciyme1q0eEuzz
         ipP7MGbDIbqDnPl6+MCt/fP7FQeedcVZOs8cTEYpPVrsuQ9820eT30/Dab2nD6kZcBqd
         5vqt2AFfcy4ovwcIuBxfplqPyXTrYhE78k43N8rhgYHElce+QjZQsUSx5wl7gKxqSrqR
         dJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3rB3VNrc+86vIwdvgJqzkxd0B5WUYC0AkgCKiXyEq7o=;
        b=Rm9mx5IlXWvYYebr1iTmaIbvehUvocks2keP483k/0WTKm1T55PhEDLh2ZD7SVw8lO
         X/rFU6QfAoOjSrujonSYIqBqrbBp8Sq0YNYR0J53efzD42UZWW2D57kPWJHeVDVubt1Z
         IBLLv7pzdjaMc9+mnCd48zvba6YH2YP2NL240fPkEfYfkx1Da0w88/w4b0+qeBY0RdPf
         TMe2sJKWo3sfbNVDxS5E8bN07FWA+1urKVwImfeNw9Ss0LUoH/Q7XKfYkwRGV14PI53h
         a4b5+ulcLuksSFwrMQdxr2KCu9g2sZKp3rQEWyuN9yNdqrRWKCabk5Wtbztwtw/pkafK
         BCXQ==
X-Gm-Message-State: AOAM532pKtpPHrN8aIfU5S4ZDTx6gYL+fyMIbOadSDOSpqHxOCSBgk2Y
        e4c6hbhpCy0jOKjokd5hXWf48kNzZwQ=
X-Google-Smtp-Source: ABdhPJxtAl/gPDpH0WHASMi7GvwL7bpIP4gqR1NJxS57mG2guXpcu4t3AWJVvSEL0xGDFnk4aoOtKw==
X-Received: by 2002:a7b:cc02:: with SMTP id f2mr16230351wmh.1.1601900862822;
        Mon, 05 Oct 2020 05:27:42 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-293-21.w86-199.abo.wanadoo.fr. [86.199.76.21])
        by smtp.googlemail.com with ESMTPSA id n2sm13270400wma.29.2020.10.05.05.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:42 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 05/11] merge-resolve: rewrite in C
Date:   Mon,  5 Oct 2020 14:26:40 +0200
Message-Id: <20201005122646.27994-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201005122646.27994-1-alban.gruin@gmail.com>
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites `git merge-resolve' from shell to C.  As for `git
merge-one-file', this port is not completely straightforward and removes
calls to external processes to avoid reading and writing the index over
and over again.

 - The call to `update-index -q --refresh' is replaced by a call to
   refresh_index().

 - The call to `read-tree' is replaced by a call to unpack_trees() (and
   all the setup needed).

 - The call to `write-tree' is replaced by a call to
   write_index_as_tree().

 - The call to `merge-index', needed to invoke `git merge-one-file', is
   replaced by a call to the new merge_all() function.  A callback
   function, merge_one_file_cb(), is added to allow it to call
   merge_one_file() without forking.

Here too, the index is read in cmd_merge_resolve(), but
merge_strategies_resolve() takes care of writing it back to the disk.

The parameters of merge_strategies_resolve() will be surprising at first
glance: why using a commit list for `bases' and `remote', where we could
use an oid array, and a pointer to an oid?  Because, in a later commit,
try_merge_strategy() will be able to call merge_strategies_resolve()
directly, and it already uses a commit list for `bases' (`common') and
`remote' (`remoteheads'), and a string for `head_arg'.  To reduce
frictions later, merge_strategies_resolve() takes the same types of
parameters.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 Makefile                |  2 +-
 builtin.h               |  1 +
 builtin/merge-resolve.c | 69 +++++++++++++++++++++++++++++++++
 git-merge-resolve.sh    | 54 --------------------------
 git.c                   |  1 +
 merge-strategies.c      | 85 +++++++++++++++++++++++++++++++++++++++++
 merge-strategies.h      |  5 +++
 7 files changed, 162 insertions(+), 55 deletions(-)
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-resolve.sh

diff --git a/Makefile b/Makefile
index 6dfdb33cb2..3cc6b192f1 100644
--- a/Makefile
+++ b/Makefile
@@ -601,7 +601,6 @@ SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
-SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-request-pull.sh
@@ -1097,6 +1096,7 @@ BUILTIN_OBJS += builtin/merge-index.o
 BUILTIN_OBJS += builtin/merge-one-file.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
+BUILTIN_OBJS += builtin/merge-resolve.o
 BUILTIN_OBJS += builtin/merge-tree.o
 BUILTIN_OBJS += builtin/merge.o
 BUILTIN_OBJS += builtin/mktag.o
diff --git a/builtin.h b/builtin.h
index 4d2cd78856..35e91c16d0 100644
--- a/builtin.h
+++ b/builtin.h
@@ -180,6 +180,7 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_one_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+int cmd_merge_resolve(int argc, const char **argv, const char *prefix);
 int cmd_merge_tree(int argc, const char **argv, const char *prefix);
 int cmd_mktag(int argc, const char **argv, const char *prefix);
 int cmd_mktree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-resolve.c b/builtin/merge-resolve.c
new file mode 100644
index 0000000000..59f734473b
--- /dev/null
+++ b/builtin/merge-resolve.c
@@ -0,0 +1,69 @@
+/*
+ * Builtin "git merge-resolve"
+ *
+ * Copyright (c) 2020 Alban Gruin
+ *
+ * Based on git-merge-resolve.sh, written by Linus Torvalds and Junio C
+ * Hamano.
+ *
+ * Resolve two trees, using enhanced multi-base read-tree.
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "merge-strategies.h"
+
+static const char builtin_merge_resolve_usage[] =
+	"git merge-resolve <bases>... -- <head> <remote>";
+
+int cmd_merge_resolve(int argc, const char **argv, const char *prefix)
+{
+	int i, is_baseless = 1, sep_seen = 0;
+	const char *head = NULL;
+	struct commit_list *bases = NULL, *remote = NULL;
+	struct commit_list **next_base = &bases;
+
+	if (argc < 5)
+		usage(builtin_merge_resolve_usage);
+
+	setup_work_tree();
+	if (repo_read_index(the_repository) < 0)
+		die("invalid index");
+
+	/* The first parameters up to -- are merge bases; the rest are
+	 * heads. */
+	for (i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "--") == 0)
+			sep_seen = 1;
+		else if (strcmp(argv[i], "-h") == 0)
+			usage(builtin_merge_resolve_usage);
+		else if (sep_seen && !head)
+			head = argv[i];
+		else if (remote) {
+			/* Give up if we are given two or more remotes.
+			 * Not handling octopus. */
+			return 2;
+		} else {
+			struct object_id oid;
+
+			get_oid(argv[i], &oid);
+			is_baseless &= sep_seen;
+
+			if (!oideq(&oid, the_hash_algo->empty_tree)) {
+				struct commit *commit;
+				commit = lookup_commit_or_die(&oid, argv[i]);
+
+				if (sep_seen)
+					commit_list_append(commit, &remote);
+				else
+					next_base = commit_list_append(commit, next_base);
+			}
+		}
+	}
+
+	/* Give up if this is a baseless merge. */
+	if (is_baseless)
+		return 2;
+
+	return merge_strategies_resolve(the_repository, bases, head, remote);
+}
diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
deleted file mode 100755
index 343fe7bccd..0000000000
--- a/git-merge-resolve.sh
+++ /dev/null
@@ -1,54 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Linus Torvalds
-# Copyright (c) 2005 Junio C Hamano
-#
-# Resolve two trees, using enhanced multi-base read-tree.
-
-# The first parameters up to -- are merge bases; the rest are heads.
-bases= head= remotes= sep_seen=
-for arg
-do
-	case ",$sep_seen,$head,$arg," in
-	*,--,)
-		sep_seen=yes
-		;;
-	,yes,,*)
-		head=$arg
-		;;
-	,yes,*)
-		remotes="$remotes$arg "
-		;;
-	*)
-		bases="$bases$arg "
-		;;
-	esac
-done
-
-# Give up if we are given two or more remotes -- not handling octopus.
-case "$remotes" in
-?*' '?*)
-	exit 2 ;;
-esac
-
-# Give up if this is a baseless merge.
-if test '' = "$bases"
-then
-	exit 2
-fi
-
-git update-index -q --refresh
-git read-tree -u -m --aggressive $bases $head $remotes || exit 2
-echo "Trying simple merge."
-if result_tree=$(git write-tree 2>/dev/null)
-then
-	exit 0
-else
-	echo "Simple merge failed, trying Automatic merge."
-	if git merge-index -o git-merge-one-file -a
-	then
-		exit 0
-	else
-		exit 1
-	fi
-fi
diff --git a/git.c b/git.c
index a4d3f98094..64a1a1de41 100644
--- a/git.c
+++ b/git.c
@@ -544,6 +544,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-resolve", cmd_merge_resolve, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
diff --git a/merge-strategies.c b/merge-strategies.c
index c022ba9748..6b4b3d03a6 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -1,8 +1,11 @@
 #include "cache.h"
+#include "cache-tree.h"
 #include "dir.h"
 #include "ll-merge.h"
+#include "lockfile.h"
 #include "merge-strategies.h"
 #include "run-command.h"
+#include "unpack-trees.h"
 #include "xdiff-interface.h"
 
 static int add_to_index_cacheinfo(struct index_state *istate,
@@ -322,3 +325,85 @@ int merge_all(struct index_state *istate, int oneshot, int quiet,
 
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
+	puts(_("Trying simple merge."));
+	write_locked_index(r->index, &lock, COMMIT_LOCK);
+
+	if (write_index_as_tree(&oid, r->index, r->index_file,
+				WRITE_TREE_SILENT, NULL)) {
+		int ret;
+
+		puts(_("Simple merge failed, trying Automatic merge."));
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
2.28.0.662.ge304723957

