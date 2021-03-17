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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9CDC43603
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BED164EED
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhCQU5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhCQU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FF4C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so2082580wmf.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=318wiqDmtx7mIX4Px42W9d6indxhMO2M0XeJ9BR+VrM=;
        b=CkCuRMSGIngCpPDJJgZXxP4BlbqgG+t4wfQDzu61ujWXZMpyO2QsSMRxi6G8u3t+pf
         Jgf0d1kuBZ1rfGfSuRC9W3F2+9nfpI6AwmfJxTjkhyWsSh1WEe906I+Gyb+X4/qvxsmv
         oJSQsNqMirXvTAONT7XQBaJmMV6vdtmMl1NMAvE00rXXfV2tsrxLjSDZXMsh9m8qWHV0
         WTbiCnjNS4swbL+38A5GFoApPFwzE1mibz/tinvDHa+NS4RSFPbpuJCFAEOGAjVGElqH
         cegg8/qDR/fry/+a0dYYOfKgszP8a9hTQxK94PVigDu2xz5INueKJ+wkUYoaCXdDBZHY
         x30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=318wiqDmtx7mIX4Px42W9d6indxhMO2M0XeJ9BR+VrM=;
        b=f1ftIb+3lvud1yhvLIefgA4eOhzKO3qMl10rWWmHs5KlZSChoUv2jMlQDb4F9Vo1ur
         xbFxxoeYrlcvIbEVPRQs92U3S1fcz56OBef5deH6jnzcVoNHpUo9ZGR9xjC6ezenWAg0
         L/GDuZaqcfXGmRSkC7hVUSZQ+7/OeIY9YzJQab0JGfumn8O0gUhXdjORUuJyw/DuGyYO
         rJmegog6pj3LEmV6iuBocA8V8IPpgcvDjcETs28hsvXvOeH8SviSYxZxiHexxW47STnG
         j0IHreMXjk0G0VeQkqAS+pR6q7/7vHNz6PBj+ntCWzxJb7RMUalpWtWsTDPpZDdPGcSD
         Bo8Q==
X-Gm-Message-State: AOAM533c/BcnqiHhNgGMyWBXTvYp8F6N1bgLLrXWp/GtC6Ol9xLmTo8o
        pYltIT+eZq3tuEI4eGXALOcHAlm45gI=
X-Google-Smtp-Source: ABdhPJzv9qLzGkvO8ihQ/RYyI6aIGKrHi7Ve2uB8EqGIEHocveGUArWuj1RjbwuwiLsuT5/k6JUTFg==
X-Received: by 2002:a1c:7704:: with SMTP id t4mr540094wmi.159.1616014610992;
        Wed, 17 Mar 2021 13:56:50 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:50 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 11/15] merge-octopus: rewrite in C
Date:   Wed, 17 Mar 2021 21:49:35 +0100
Message-Id: <20210317204939.17890-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites `git merge-octopus' from shell to C.  As for the two last
conversions, this port removes calls to external processes to avoid
reading and writing the index over and over again.

 - Calls to `read-tree -u -m (--aggressive)?' are replaced by calls to
   unpack_trees().

 - The call to `write-tree' is replaced by a call to
   write_index_as_tree().

 - The call to `diff-index ...' is replaced by a call to
   repo_index_has_changes().

 - The call to `merge-index', needed to invoke `git merge-one-file', is
   replaced by a call to merge_all_index().

The index is read in cmd_merge_octopus(), and is wrote back by
merge_strategies_octopus().

Here to, merge_strategies_octopus() takes two commit lists and a string
to reduce frictions when try_merge_strategies() will be modified to call
it directly.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 Makefile                |   2 +-
 builtin.h               |   1 +
 builtin/merge-octopus.c |  70 ++++++++++++++++
 git-merge-octopus.sh    | 112 -------------------------
 git.c                   |   1 +
 merge-strategies.c      | 175 ++++++++++++++++++++++++++++++++++++++++
 merge-strategies.h      |   3 +
 7 files changed, 251 insertions(+), 113 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 delete mode 100755 git-merge-octopus.sh

diff --git a/Makefile b/Makefile
index 8fccc38006..fa8f1a2ddf 100644
--- a/Makefile
+++ b/Makefile
@@ -599,7 +599,6 @@ unexport CDPATH
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
-SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-request-pull.sh
@@ -1098,6 +1097,7 @@ BUILTIN_OBJS += builtin/mailsplit.o
 BUILTIN_OBJS += builtin/merge-base.o
 BUILTIN_OBJS += builtin/merge-file.o
 BUILTIN_OBJS += builtin/merge-index.o
+BUILTIN_OBJS += builtin/merge-octopus.o
 BUILTIN_OBJS += builtin/merge-one-file.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
diff --git a/builtin.h b/builtin.h
index c3029cef46..ef2b65c9d0 100644
--- a/builtin.h
+++ b/builtin.h
@@ -177,6 +177,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix);
 int cmd_merge(int argc, const char **argv, const char *prefix);
 int cmd_merge_base(int argc, const char **argv, const char *prefix);
 int cmd_merge_index(int argc, const char **argv, const char *prefix);
+int cmd_merge_octopus(int argc, const char **argv, const char *prefix);
 int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_one_file(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-octopus.c b/builtin/merge-octopus.c
new file mode 100644
index 0000000000..9b9939b6b2
--- /dev/null
+++ b/builtin/merge-octopus.c
@@ -0,0 +1,70 @@
+/*
+ * Builtin "git merge-octopus"
+ *
+ * Copyright (c) 2020 Alban Gruin
+ *
+ * Based on git-merge-octopus.sh, written by Junio C Hamano.
+ *
+ * Resolve two or more trees.
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "commit.h"
+#include "merge-strategies.h"
+
+static const char builtin_merge_octopus_usage[] =
+	"git merge-octopus [<bases>...] -- <head> <remote1> <remote2> [<remotes>...]";
+
+int cmd_merge_octopus(int argc, const char **argv, const char *prefix)
+{
+	int i, sep_seen = 0;
+	struct commit_list *bases = NULL, *remotes = NULL;
+	struct commit_list **next_base = &bases, **next_remote = &remotes;
+	const char *head_arg = NULL;
+	struct repository *r = the_repository;
+
+	if (argc < 5)
+		usage(builtin_merge_octopus_usage);
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
+		if (strcmp(argv[i], "--") == 0)
+			sep_seen = 1;
+		else if (strcmp(argv[i], "-h") == 0)
+			usage(builtin_merge_octopus_usage);
+		else if (sep_seen && !head_arg)
+			head_arg = argv[i];
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
+				next_remote = commit_list_append(commit, next_remote);
+			else
+				next_base = commit_list_append(commit, next_base);
+		}
+	}
+
+	/*
+	 * Reject if this is not an octopus -- resolve should be used
+	 * instead.
+	 */
+	if (commit_list_count(remotes) < 2)
+		return 2;
+
+	return merge_strategies_octopus(r, bases, head_arg, remotes);
+}
diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
deleted file mode 100755
index 2770891960..0000000000
--- a/git-merge-octopus.sh
+++ /dev/null
@@ -1,112 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano
-#
-# Resolve two or more trees.
-#
-
-. git-sh-setup
-
-LF='
-'
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
-# Reject if this is not an octopus -- resolve should be used instead.
-case "$remotes" in
-?*' '?*)
-	;;
-*)
-	exit 2 ;;
-esac
-
-# MRC is the current "merge reference commit"
-# MRT is the current "merge result tree"
-
-if ! git diff-index --quiet --cached HEAD --
-then
-    gettextln "Error: Your local changes to the following files would be overwritten by merge"
-    git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
-    exit 2
-fi
-MRC=$(git rev-parse --verify -q $head)
-MRT=$(git write-tree)
-NON_FF_MERGE=0
-OCTOPUS_FAILURE=0
-for SHA1 in $remotes
-do
-	case "$OCTOPUS_FAILURE" in
-	1)
-		# We allow only last one to have a hand-resolvable
-		# conflicts.  Last round failed and we still had
-		# a head to merge.
-		gettextln "Automated merge did not work."
-		gettextln "Should not be doing an octopus."
-		exit 2
-	esac
-
-	eval pretty_name=\${GITHEAD_$SHA1:-$SHA1}
-	if test "$SHA1" = "$pretty_name"
-	then
-		SHA1_UP="$(echo "$SHA1" | tr a-z A-Z)"
-		eval pretty_name=\${GITHEAD_$SHA1_UP:-$pretty_name}
-	fi
-	common=$(git merge-base --all $SHA1 $MRC) ||
-		die "$(eval_gettext "Unable to find common commit with \$pretty_name")"
-
-	case "$LF$common$LF" in
-	*"$LF$SHA1$LF"*)
-		eval_gettextln "Already up to date with \$pretty_name"
-		continue
-		;;
-	esac
-
-	if test "$common,$NON_FF_MERGE" = "$MRC,0"
-	then
-		# The first head being merged was a fast-forward.
-		# Advance MRC to the head being merged, and use that
-		# tree as the intermediate result of the merge.
-		# We still need to count this as part of the parent set.
-
-		eval_gettextln "Fast-forwarding to: \$pretty_name"
-		git read-tree -u -m $head $SHA1 || exit
-		MRC=$SHA1 MRT=$(git write-tree)
-		continue
-	fi
-
-	NON_FF_MERGE=1
-
-	eval_gettextln "Trying simple merge with \$pretty_name"
-	git read-tree -u -m --aggressive  $common $MRT $SHA1 || exit 2
-	next=$(git write-tree 2>/dev/null)
-	if test $? -ne 0
-	then
-		gettextln "Simple merge did not work, trying automatic merge."
-		git merge-index -o --use=merge-one-file -a ||
-		OCTOPUS_FAILURE=1
-		next=$(git write-tree 2>/dev/null)
-	fi
-
-	MRC="$MRC $SHA1"
-	MRT=$next
-done
-
-exit "$OCTOPUS_FAILURE"
diff --git a/git.c b/git.c
index ce1f237369..c47cc441a3 100644
--- a/git.c
+++ b/git.c
@@ -543,6 +543,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-octopus", cmd_merge_octopus, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-one-file", cmd_merge_one_file, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
diff --git a/merge-strategies.c b/merge-strategies.c
index a51700dae5..ebc0d0b1e2 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "cache-tree.h"
+#include "commit-reach.h"
 #include "dir.h"
 #include "lockfile.h"
 #include "merge-strategies.h"
@@ -367,3 +368,177 @@ int merge_strategies_resolve(struct repository *r,
 
 	return 0;
 }
+
+static int write_tree(struct repository *r, struct tree **reference_tree)
+{
+	struct object_id oid;
+	int ret;
+
+	if (!(ret = write_index_as_tree(&oid, r->index, r->index_file,
+					WRITE_TREE_SILENT, NULL)))
+		*reference_tree = lookup_tree(r, &oid);
+
+	return ret;
+}
+
+static int octopus_fast_forward(struct repository *r, const char *branch_name,
+				struct tree *tree_head, struct tree *current_tree,
+				struct tree **reference_tree)
+{
+	/*
+	 * The first head being merged was a fast-forward.  Advance the
+	 * reference commit to the head being merged, and use that tree
+	 * as the intermediate result of the merge.  We still need to
+	 * count this as part of the parent set.
+	 */
+	struct tree_desc t[2];
+
+	printf(_("Fast-forwarding to: %s\n"), branch_name);
+
+	init_tree_desc(t, tree_head->buffer, tree_head->size);
+	if (add_tree(current_tree, t + 1))
+		return -1;
+	if (fast_forward(r, t, 2, 0))
+		return -1;
+	if (write_tree(r, reference_tree))
+		return -1;
+
+	return 0;
+}
+
+static int octopus_do_merge(struct repository *r, const char *branch_name,
+			    struct commit_list *common, struct tree *current_tree,
+			    struct tree **reference_tree)
+{
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct commit_list *i;
+	int nr = 0, ret = 0;
+
+	printf(_("Trying simple merge with %s\n"), branch_name);
+
+	for (i = common; i; i = i->next) {
+		struct tree *tree = repo_get_commit_tree(r, i->item);
+		if (add_tree(tree, t + (nr++)))
+			return -1;
+	}
+
+	if (add_tree(*reference_tree, t + (nr++)))
+		return -1;
+	if (add_tree(current_tree, t + (nr++)))
+		return -1;
+	if (fast_forward(r, t, nr, 1))
+		return 2;
+
+	if (write_tree(r, reference_tree)) {
+		struct lock_file lock = LOCK_INIT;
+
+		puts(_("Simple merge did not work, trying automatic merge."));
+		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
+		ret = !!merge_all_index(r->index, 0, 0, merge_one_file_func, NULL);
+		write_locked_index(r->index, &lock, COMMIT_LOCK);
+
+		write_tree(r, reference_tree);
+	}
+
+	return ret;
+}
+
+int merge_strategies_octopus(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remotes)
+{
+	int ff_merge = 1, ret = 0, nr_references = 1;
+	struct commit **reference_commits, *head_commit;
+	struct tree *reference_tree, *head_tree;
+	struct commit_list *i;
+	struct object_id head;
+	struct strbuf sb = STRBUF_INIT;
+
+	get_oid(head_arg, &head);
+	head_commit = lookup_commit_reference(r, &head);
+	head_tree = repo_get_commit_tree(r, head_commit);
+
+	if (parse_tree(head_tree))
+		return 2;
+
+	if (repo_index_has_changes(r, head_tree, &sb)) {
+		error(_("Your local changes to the following files "
+			"would be overwritten by merge:\n  %s"),
+		      sb.buf);
+		strbuf_release(&sb);
+		return 2;
+	}
+
+	CALLOC_ARRAY(reference_commits, commit_list_count(remotes) + 1);
+	reference_commits[0] = head_commit;
+	reference_tree = head_tree;
+
+	for (i = remotes; i && i->item; i = i->next) {
+		struct commit *c = i->item;
+		struct object_id *oid = &c->object.oid;
+		struct tree *current_tree = repo_get_commit_tree(r, c);
+		struct commit_list *common, *j;
+		char *branch_name = merge_get_better_branch_name(oid_to_hex(oid));
+		int up_to_date = 0;
+
+		common = repo_get_merge_bases_many(r, c, nr_references, reference_commits);
+		if (!common) {
+			error(_("Unable to find common commit with %s"), branch_name);
+
+			free(branch_name);
+			free_commit_list(common);
+			free(reference_commits);
+
+			return 2;
+		}
+
+		for (j = common; j && !up_to_date && ff_merge; j = j->next) {
+			up_to_date |= oideq(&j->item->object.oid, oid);
+
+			if (!j->next &&
+			    !oideq(&j->item->object.oid,
+				   &reference_commits[nr_references - 1]->object.oid))
+				ff_merge = 0;
+		}
+
+		if (up_to_date) {
+			printf(_("Already up to date with %s\n"), branch_name);
+
+			free(branch_name);
+			free_commit_list(common);
+			continue;
+		}
+
+		if (ff_merge) {
+			ret = octopus_fast_forward(r, branch_name, head_tree,
+						   current_tree, &reference_tree);
+			nr_references = 0;
+		} else {
+			ret = octopus_do_merge(r, branch_name, common,
+					       current_tree, &reference_tree);
+		}
+
+		free(branch_name);
+		free_commit_list(common);
+
+		if (ret == -1 || ret == 2)
+			break;
+		else if (ret && i->next) {
+			/*
+			 * We allow only last one to have a
+			 * hand-resolvable conflicts.  Last round failed
+			 * and we still had a head to merge.
+			 */
+			puts(_("Automated merge did not work."));
+			puts(_("Should not be doing an octopus."));
+
+			free(reference_commits);
+			return 2;
+		}
+
+		reference_commits[nr_references++] = c;
+	}
+
+	free(reference_commits);
+	return ret;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
index bba4bf999c..8de2249ee6 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -32,5 +32,8 @@ int merge_all_index(struct index_state *istate, int oneshot, int quiet,
 int merge_strategies_resolve(struct repository *r,
 			     struct commit_list *bases, const char *head_arg,
 			     struct commit_list *remote);
+int merge_strategies_octopus(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remote);
 
 #endif /* MERGE_STRATEGIES_H */
-- 
2.31.0

