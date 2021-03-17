Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C78C4321A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05CD664F69
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhCQU5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhCQU4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D0CC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g8so2266557wmd.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QgrykSMd/yxJx5HVc4cnQmaELetEjPMz7WCXGNfVJtM=;
        b=XTH7hiE+Sn0C7y0xh7Xvs0Hd2d9cOBQaTH4TCkzKG1N8cR948D5rYzxoDvTbEKHUoT
         T9SDZl+1MshsgllxTKVYXdo/I2Qvzmmc8AhpHpyAQCFEaYWQLjqyRPEqAGEaXZSrlthz
         pk/dnVbUn3vL7gGE7wN2OmIQmDJquBykiC10IKquh5UiaN4QGQiIBgIl7W/SNLX4F8VJ
         igHZYiIcIKYvSwyz+y6IT0Dg4lZoPB9YVxrjx2ZC6Xem+jnkWH3SQlu5vKF65iPzIcDS
         LsA4xd2gKto/rGpk9s4feMSZh2/IZKG74sgubZhJHhwgoZDekfOqDvfjpPZRtZsE+4q5
         8HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgrykSMd/yxJx5HVc4cnQmaELetEjPMz7WCXGNfVJtM=;
        b=Hj2wkfZ0G/3nEskDQYm+MPwUS8RrgNA1Xg9auDiY6i7dDofj9MQaakIFiTgYtsDkMv
         rkhGcnXlfBLsaLDGxpog7BzaR8Y64nyeYesrwZgoHmXk4yDtU+7LO1FlD7NvNFy4Ai/z
         GsSeRF5TUx3azwif1/SCDt15z/s25yXhPtdd9cf0v2m3MnllkzzWnfQHpvPcacMfWmSz
         rNG/y/4yyxe6nsvdL5MYhSpeQOso8KhVb8sWiICAhN3PJ3XYRuuvGGtNS0bjJDFLfzKG
         l00vY4HNFp3CVPvMDjVP23v0rdMINZw8btnGX4fkyY0Ut/Fw8jCw8UJJRtLt+Q+nr2Eh
         U44A==
X-Gm-Message-State: AOAM530BGA6ogpfPqsMhMvZI2809HpI2W98IYQ3P9HRIPIIi0sVgDEqy
        yZg5cid9ogojze+gEs4qcC6eDlEkNlY=
X-Google-Smtp-Source: ABdhPJzG31jt1ebAEOFAoDykcscZY9ygbilc6XPLUgrL36g9734qcrBG3oYDgjY6rM+AiHZXzmwMJg==
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr98813wmr.25.1616014608091;
        Wed, 17 Mar 2021 13:56:48 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:47 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 09/15] merge-resolve: rewrite in C
Date:   Wed, 17 Mar 2021 21:49:33 +0100
Message-Id: <20210317204939.17890-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
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
 builtin/merge-resolve.c | 74 ++++++++++++++++++++++++++++++++
 git-merge-resolve.sh    | 54 -----------------------
 git.c                   |  1 +
 merge-strategies.c      | 95 +++++++++++++++++++++++++++++++++++++++++
 merge-strategies.h      |  5 +++
 7 files changed, 177 insertions(+), 55 deletions(-)
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-resolve.sh

diff --git a/Makefile b/Makefile
index e2e4389f76..8fccc38006 100644
--- a/Makefile
+++ b/Makefile
@@ -600,7 +600,6 @@ SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
-SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-request-pull.sh
@@ -1102,6 +1101,7 @@ BUILTIN_OBJS += builtin/merge-index.o
 BUILTIN_OBJS += builtin/merge-one-file.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
+BUILTIN_OBJS += builtin/merge-resolve.o
 BUILTIN_OBJS += builtin/merge-tree.o
 BUILTIN_OBJS += builtin/merge.o
 BUILTIN_OBJS += builtin/mktag.o
diff --git a/builtin.h b/builtin.h
index 227c133036..c3029cef46 100644
--- a/builtin.h
+++ b/builtin.h
@@ -181,6 +181,7 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_one_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+int cmd_merge_resolve(int argc, const char **argv, const char *prefix);
 int cmd_merge_tree(int argc, const char **argv, const char *prefix);
 int cmd_mktag(int argc, const char **argv, const char *prefix);
 int cmd_mktree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-resolve.c b/builtin/merge-resolve.c
new file mode 100644
index 0000000000..0f2e487c4d
--- /dev/null
+++ b/builtin/merge-resolve.c
@@ -0,0 +1,74 @@
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
+	int i, sep_seen = 0;
+	const char *head = NULL;
+	struct commit_list *bases = NULL, *remote = NULL;
+	struct commit_list **next_base = &bases;
+	struct repository *r = the_repository;
+
+	if (argc < 5)
+		usage(builtin_merge_resolve_usage);
+
+	setup_work_tree();
+	if (repo_read_index(r) < 0)
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
+			commit = oideq(&oid, r->hash_algo->empty_tree) ?
+				NULL : lookup_commit_or_die(&oid, argv[i]);
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
+	return merge_strategies_resolve(r, bases, head, remote);
+}
diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
deleted file mode 100755
index 0b4fc88b61..0000000000
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
-	if git merge-index -o --use=merge-one-file -a
-	then
-		exit 0
-	else
-		exit 1
-	fi
-fi
diff --git a/git.c b/git.c
index 95eb74efe1..ce1f237369 100644
--- a/git.c
+++ b/git.c
@@ -548,6 +548,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-resolve", cmd_merge_resolve, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
diff --git a/merge-strategies.c b/merge-strategies.c
index 2717af51fd..a51700dae5 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -1,6 +1,9 @@
 #include "cache.h"
+#include "cache-tree.h"
 #include "dir.h"
+#include "lockfile.h"
 #include "merge-strategies.h"
+#include "unpack-trees.h"
 #include "xdiff-interface.h"
 
 static int add_merge_result_to_index(struct index_state *istate, unsigned int mode,
@@ -272,3 +275,95 @@ int merge_all_index(struct index_state *istate, int oneshot, int quiet,
 
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
+		ret = merge_all_index(r->index, 1, 0, merge_one_file_func, NULL);
+
+		write_locked_index(r->index, &lock, COMMIT_LOCK);
+		return !!ret;
+	}
+
+	return 0;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
index 8705a550ca..bba4bf999c 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -1,6 +1,7 @@
 #ifndef MERGE_STRATEGIES_H
 #define MERGE_STRATEGIES_H
 
+#include "commit.h"
 #include "object.h"
 
 int merge_three_way(struct index_state *istate,
@@ -28,4 +29,8 @@ int merge_index_path(struct index_state *istate, int oneshot, int quiet,
 int merge_all_index(struct index_state *istate, int oneshot, int quiet,
 		    merge_fn fn, void *data);
 
+int merge_strategies_resolve(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remote);
+
 #endif /* MERGE_STRATEGIES_H */
-- 
2.31.0

