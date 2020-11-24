Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ADBC56201
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4295F2076E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRD4yYuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbgKXLzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733119AbgKXLzK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:55:10 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8084EC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:08 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 64so8609603wra.11
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikZXfrmfTzYcLmP2P095agoVzwC0uSqYt1/9DpK+8Y8=;
        b=JRD4yYuYFBzpyCUqdCFGHLnD4PK6imqrm58nOSfTONyljwgCcyYNKbvJZyfcPlaVg2
         YHEQ2A+3CEURM8MIPUS68m+u3ezqlU6/WHtLejFnqxvLcnm+UmlXEod+n09PTEbyghQc
         QGsU3UgudxpaVvx9p3O4Tf2hF9Ii2mbfuTz9yjBT+cu61pIz9EtMTLKSdyyerDymoBmm
         lQ9X2UCXReW/Fz/A1A4PwYQ046+n+7SQ1nNwnLFNAArJKrF1nuR72XqTeilD8ORIWgXL
         L2FjBeu+1G+zycEWJC2AwogLcsp0vBhpV0YOaLNt96LXOk0ENvxi0Krv9W75EvU6uUuC
         VdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikZXfrmfTzYcLmP2P095agoVzwC0uSqYt1/9DpK+8Y8=;
        b=o/aZohKTKv+n4i/AkKjesjWhNVM80wONvIj77wL72EA7VISPV2pSIzkvL295H3ZD5q
         3nndyaPXk0yOpHnWvTl8MuHgicMsrMzbUzG8V/7ioE8IvTrJtw4+rVaVBJ6v48FE+ats
         qGvcfw+UwP3S4gmB7jIyJkCi3y0tFX/dhl/dkIoIjg71OiXAqTH2RELvvpUB9LxaQYjF
         uWyRE53OU+Tlca+aTjyl543qwzWr7G1Ms/GgtSCry1pFCqZlIU+sXZPI/jlj4YIG9PcM
         9Pa3xsIriCrWMvTIasvzGlSTEuodp7U6DHauS/Gi0erPq0mwpzY15hiUWR0/AvsqDQDe
         f5wg==
X-Gm-Message-State: AOAM530qvc2yykUVwtkHDS0ZFnjjM35J9M68Ew7f9RGYGR85M/ANfMmh
        i/h6N7Ruz+8vvz4UH5Vcskq3TM8e00M=
X-Google-Smtp-Source: ABdhPJwIqCI38iyJaCypd7g01sFtjUR2MJSHntXdPm6IH7RryEKhCm+m/DC8TqFZs93OPnUbKBZPtA==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr4767324wru.309.1606218906685;
        Tue, 24 Nov 2020 03:55:06 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:55:06 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 09/13] merge-octopus: rewrite in C
Date:   Tue, 24 Nov 2020 12:53:11 +0100
Message-Id: <20201124115315.13311-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
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
 builtin/merge-octopus.c |  69 ++++++++++++++++
 git-merge-octopus.sh    | 112 -------------------------
 git.c                   |   1 +
 merge-strategies.c      | 177 ++++++++++++++++++++++++++++++++++++++++
 merge-strategies.h      |   3 +
 7 files changed, 252 insertions(+), 113 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 delete mode 100755 git-merge-octopus.sh

diff --git a/Makefile b/Makefile
index 3cc6b192f1..2b2bdffafe 100644
--- a/Makefile
+++ b/Makefile
@@ -600,7 +600,6 @@ unexport CDPATH
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
-SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-request-pull.sh
@@ -1093,6 +1092,7 @@ BUILTIN_OBJS += builtin/mailsplit.o
 BUILTIN_OBJS += builtin/merge-base.o
 BUILTIN_OBJS += builtin/merge-file.o
 BUILTIN_OBJS += builtin/merge-index.o
+BUILTIN_OBJS += builtin/merge-octopus.o
 BUILTIN_OBJS += builtin/merge-one-file.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
diff --git a/builtin.h b/builtin.h
index 35e91c16d0..50225404a0 100644
--- a/builtin.h
+++ b/builtin.h
@@ -176,6 +176,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix);
 int cmd_merge(int argc, const char **argv, const char *prefix);
 int cmd_merge_base(int argc, const char **argv, const char *prefix);
 int cmd_merge_index(int argc, const char **argv, const char *prefix);
+int cmd_merge_octopus(int argc, const char **argv, const char *prefix);
 int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_one_file(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-octopus.c b/builtin/merge-octopus.c
new file mode 100644
index 0000000000..ca8f9f345d
--- /dev/null
+++ b/builtin/merge-octopus.c
@@ -0,0 +1,69 @@
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
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
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
+
+	if (argc < 5)
+		usage(builtin_merge_octopus_usage);
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
+			commit = lookup_commit_or_die(&oid, argv[i]);
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
+	return merge_strategies_octopus(the_repository, bases, head_arg, remotes);
+}
diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
deleted file mode 100755
index 7d19d37951..0000000000
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
-		git merge-index -o git-merge-one-file -a ||
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
index 64a1a1de41..d51fb5d2bf 100644
--- a/git.c
+++ b/git.c
@@ -539,6 +539,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-octopus", cmd_merge_octopus, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-one-file", cmd_merge_one_file, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
diff --git a/merge-strategies.c b/merge-strategies.c
index 9aa07e91b5..4d9dd55296 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "cache-tree.h"
+#include "commit-reach.h"
 #include "dir.h"
 #include "lockfile.h"
 #include "merge-strategies.h"
@@ -392,3 +393,179 @@ int merge_strategies_resolve(struct repository *r,
 
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
+	struct commit_list *j;
+	int nr = 0, ret = 0;
+
+	printf(_("Trying simple merge with %s\n"), branch_name);
+
+	for (j = common; j; j = j->next) {
+		struct tree *tree = repo_get_commit_tree(r, j->item);
+		if (add_tree(tree, t + (nr++)))
+			return -1;
+	}
+
+	if (add_tree(*reference_tree, t + (nr++)))
+		return -1;
+	if (add_tree(current_tree, t + (nr++)))
+		return -1;
+	if (fast_forward(r, t, nr, 1))
+		return -1;
+
+	if (write_tree(r, reference_tree)) {
+		struct lock_file lock = LOCK_INIT;
+
+		puts(_("Simple merge did not work, trying automatic merge."));
+		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
+		ret = merge_all_index(r, 1, 0, merge_one_file_func, NULL);
+		write_locked_index(r->index, &lock, COMMIT_LOCK);
+
+		write_tree(r, reference_tree);
+	}
+
+	return ret ? -2 : 0;
+}
+
+int merge_strategies_octopus(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remotes)
+{
+	int ff_merge = 1, ret = 0, references = 1;
+	struct commit **reference_commit, *head_commit;
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
+	reference_commit = xcalloc(commit_list_count(remotes) + 1,
+				   sizeof(struct commit *));
+	reference_commit[0] = head_commit;
+	reference_tree = head_tree;
+
+	for (i = remotes; i && i->item; i = i->next) {
+		struct commit *c = i->item;
+		struct object_id *oid = &c->object.oid;
+		struct tree *current_tree = repo_get_commit_tree(r, c);
+		struct commit_list *common, *j;
+		char *branch_name;
+		int k = 0, up_to_date = 0;
+
+		if (ret) {
+			/*
+			 * We allow only last one to have a
+			 * hand-resolvable conflicts.  Last round failed
+			 * and we still had a head to merge.
+			 */
+			puts(_("Automated merge did not work."));
+			puts(_("Should not be doing an octopus."));
+
+			free(reference_commit);
+			return 2;
+		}
+
+		branch_name = merge_get_better_branch_name(oid_to_hex(oid));
+		common = get_merge_bases_many(c, references, reference_commit);
+
+		if (!common) {
+			error(_("Unable to find common commit with %s"), branch_name);
+
+			free(branch_name);
+			free_commit_list(common);
+			free(reference_commit);
+
+			return 2;
+		}
+
+		for (j = common; j && !(up_to_date || !ff_merge); j = j->next) {
+			up_to_date |= oideq(&j->item->object.oid, oid);
+
+			if (k < references)
+				ff_merge &= oideq(&j->item->object.oid, &reference_commit[k++]->object.oid);
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
+			references = 0;
+		} else {
+			ret = octopus_do_merge(r, branch_name, common,
+					       current_tree, &reference_tree);
+		}
+
+		free(branch_name);
+		free_commit_list(common);
+
+		if (ret == -1)
+			break;
+
+		reference_commit[references++] = c;
+	}
+
+	free(reference_commit);
+	return ret;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
index 47dcd71ad5..05c50159ec 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -39,5 +39,8 @@ int merge_all_index(struct repository *r, int oneshot, int quiet,
 int merge_strategies_resolve(struct repository *r,
 			     struct commit_list *bases, const char *head_arg,
 			     struct commit_list *remote);
+int merge_strategies_octopus(struct repository *r,
+			     struct commit_list *bases, const char *head_arg,
+			     struct commit_list *remote);
 
 #endif /* MERGE_STRATEGIES_H */
-- 
2.29.2.260.ge31aba42fb

