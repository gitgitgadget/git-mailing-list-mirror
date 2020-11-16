Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29311C5519F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DB9206D5
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pl5Yrl95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgKPKXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgKPKXP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 05:23:15 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E7C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:15 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so18029146wrr.13
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hg2XSbyICPv99XPQxRCCxccouPyL3+plBczAYX6NiXM=;
        b=pl5Yrl95s+hV187ClSrf5FYFRPBlhpKDb09GNRTN6fpJ4cqKLJ/tB6aMF/uiBSsK7r
         6WhVYfQcEzeUYFm3NYUKUsStoHlArJlLDWrkyoQ9acIkBtY8lqUXLBPDOfVr0jeNSzq1
         16lD16uJVNZ3lOaCUJciWROdeUUIOZgLpe3BO5E2uoNTaOZI+aL+7eeh3KOsVFcJhhLP
         Lk2Iuj3o1b6NcTXH0DS/sUrizptaUWsoEqWW5OSXZclRzH63y1B6XUh4jB+RT1/VrAfx
         hCvovOCAq/FKQ2V1Bzl+XlW0ffJz+1XExRikAaf7ZyU+5T7Ylr17CnfqhtNMvPBS3vHK
         grGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hg2XSbyICPv99XPQxRCCxccouPyL3+plBczAYX6NiXM=;
        b=rjde8xYF2R8TzW/pGEIQ8ajGcUiMfWkj/pj3FPHb4tQIBSLbSnnMZRsjTR9bUnSDUO
         AjT0h0S5LEuihbqj0f/JoWbKCEaC01bQfkDUd5JxiH7Ob4akFRuceikCpBOvpmPQqMm2
         LKRta+AR2EqlxzE3W7tg30T2P6m01+jvdh7f016G17x76q738vNzsDIVvTYWWf6CBR4n
         R2GJUfKlKdweUmT7AGtROmMacT2Lo/WPPUOK80dYe22YMS3CKYaoImuC+p0lttnv1cuL
         Y5NQtxDDXu9kGBlFDK7fYG7WrZyYq43WEIj/C8n7YtDo5RCFcMvzUL0ptXrTXaio8yjC
         zWXA==
X-Gm-Message-State: AOAM530FHKCElrL+ta3kOkVze5I8dGFeAnvKYOeXJFf7JOit2MuFlI0p
        IZST2avSMO3HI8kN/9DsqB593EqPwWs=
X-Google-Smtp-Source: ABdhPJxNSsEv+fYc013P05XID9BVMGPksi8/RSzqIBJdh2R0EUYG7/qq44GigdNP4aEw2pVeACVLZg==
X-Received: by 2002:adf:f246:: with SMTP id b6mr17687040wrp.238.1605522193819;
        Mon, 16 Nov 2020 02:23:13 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id f5sm22884520wrg.32.2020.11.16.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:23:13 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 06/12] merge-resolve: rewrite in C
Date:   Mon, 16 Nov 2020 11:21:52 +0100
Message-Id: <20201116102158.8365-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116102158.8365-1-alban.gruin@gmail.com>
References: <20201113110428.21265-1-alban.gruin@gmail.com>
 <20201116102158.8365-1-alban.gruin@gmail.com>
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
   replaced by a call to the new merge_all_index() function.

The index is read in cmd_merge_resolve(), and is wrote back by
merge_strategies_resolve().

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
 builtin/merge-resolve.c | 73 +++++++++++++++++++++++++++++++
 git-merge-resolve.sh    | 54 -----------------------
 git.c                   |  1 +
 merge-strategies.c      | 95 +++++++++++++++++++++++++++++++++++++++++
 merge-strategies.h      |  5 +++
 7 files changed, 176 insertions(+), 55 deletions(-)
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
index 0000000000..dca31676b8
--- /dev/null
+++ b/builtin/merge-resolve.c
@@ -0,0 +1,73 @@
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
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#include "cache.h"
+#include "builtin.h"
+#include "merge-strategies.h"
+
+static const char builtin_merge_resolve_usage[] =
+	"git merge-resolve <bases>... -- <head> <remote>";
+
+int cmd_merge_resolve(int argc, const char **argv, const char *prefix)
+{
+	int i, sep_seen = 0;
+	const char *head = NULL;
+	struct commit_list *bases = NULL, *remote = NULL;
+	struct commit_list **next_base = &bases;
+
+	if (argc < 5)
+		usage(builtin_merge_resolve_usage);
+
+	setup_work_tree();
+	if (read_cache() < 0)
+		die("invalid index");
+
+	/*
+	 * The first parameters up to -- are merge bases; the rest are
+	 * heads.
+	 */
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--"))
+			sep_seen = 1;
+		else if (!strcmp(argv[i], "-h"))
+			usage(builtin_merge_resolve_usage);
+		else if (sep_seen && !head)
+			head = argv[i];
+		else {
+			struct object_id oid;
+			struct commit *commit;
+
+			if (get_oid(argv[i], &oid))
+				die("object %s not found.", argv[i]);
+
+			commit = lookup_commit_or_die(&oid, argv[i]);
+
+			if (sep_seen)
+				commit_list_insert(commit, &remote);
+			else
+				next_base = commit_list_append(commit, next_base);
+		}
+	}
+
+	/*
+	 * Give up if we are given two or more remotes.  Not handling
+	 * octopus.
+	 */
+	if (remote && remote->next)
+		return 2;
+
+	/* Give up if this is a baseless merge. */
+	if (!bases)
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
index 2ed3a8dd68..9fafee5954 100644
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
 
 static int checkout_from_index(struct index_state *istate, const char *path,
@@ -288,3 +291,95 @@ int merge_all_index(struct index_state *istate, int oneshot, int quiet,
 
 	return err;
 }
+
+static int fast_forward(struct repository *r, struct tree_desc *t,
+			int nr, int aggressive)
+{
+	struct unpack_trees_options opts;
+	struct lock_file lock = LOCK_INIT;
+
+	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
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
+static int add_tree(struct tree *tree, struct tree_desc *t)
+{
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
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct object_id head, oid;
+	struct commit_list *i;
+	int nr = 0;
+
+	if (head_arg)
+		get_oid(head_arg, &head);
+
+	puts(_("Trying simple merge."));
+
+	for (i = bases; i && i->item; i = i->next) {
+		if (add_tree(repo_get_commit_tree(r, i->item), t + (nr++)))
+			return 2;
+	}
+
+	if (head_arg) {
+		struct tree *tree = parse_tree_indirect(&head);
+		if (add_tree(tree, t + (nr++)))
+			return 2;
+	}
+
+	if (remote && add_tree(repo_get_commit_tree(r, remote->item), t + (nr++)))
+		return 2;
+
+	if (fast_forward(r, t, nr, 1))
+		return 2;
+
+	if (write_index_as_tree(&oid, r->index, r->index_file,
+				WRITE_TREE_SILENT, NULL)) {
+		int ret;
+		struct lock_file lock = LOCK_INIT;
+
+		puts(_("Simple merge failed, trying Automatic merge."));
+		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
+		ret = merge_all_index(r->index, 0, 0, merge_one_file_func, r);
+
+		write_locked_index(r->index, &lock, COMMIT_LOCK);
+		return !!ret;
+	}
+
+	return 0;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
index b69a12b390..4f996261b4 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -1,6 +1,7 @@
 #ifndef MERGE_STRATEGIES_H
 #define MERGE_STRATEGIES_H
 
+#include "commit.h"
 #include "object.h"
 
 int merge_three_way(struct repository *r,
@@ -32,4 +33,8 @@ int merge_index_path(struct index_state *istate, int oneshot, int quiet,
 int merge_all_index(struct index_state *istate, int oneshot, int quiet,
 		    merge_fn fn, void *data);
 
+int merge_strategies_resolve(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remote);
+
 #endif /* MERGE_STRATEGIES_H */
-- 
2.20.1

