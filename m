Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B3C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E85E206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9g9pr4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404858AbgFYMtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404764AbgFYMtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB55C061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so5422503wmi.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h6LNQR8TLUF5w20Nq3bDxlRZqG2adjZzp/V+fgGaBDs=;
        b=j9g9pr4GDE2qk2U9RmoOTvEIBa2hAIL10HsrlRF2z8rG+XcpWe5cPJFvb7cdzRsw26
         jc+I1FGyt8cwDMrcMwi7mKvIU07bhKHR5JXL+RXUiP62dG8Y7sMMQxizBT81npf04/AW
         iUImvy3RvyTV84QL6hIChA0ecvnTUsdUiYFYthwKxWouKhqqyHiuToThnZICYosO171e
         +uaObi8AuD8LcqRiG9mVAYFvWZlXK5VkGP1PYPft/aboRrzq6JcliY0lpuSWl3JT4JHf
         I9RSoPzL6daPw/9ThKVBu/k6CiuD2+BCPicAoEdAaL9ivQYLY/w/5Urdxum1IydRVYpD
         BO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h6LNQR8TLUF5w20Nq3bDxlRZqG2adjZzp/V+fgGaBDs=;
        b=hskLi6wXcX9iwW6zeFkMWY3BSvKix/W1cNHNmHrZCF80mapcmln5kn/ShCwheneXPT
         gQBufhN9+Ux46IyFrWbxW6fQPF/UdySACajEb0JlF+jU+E9s0IYmFgvwgNReVnZulSnu
         4E7npS9KPhKkIRV3HfGTCVV13mj6QhuPt/ezU9wZHqNNWFj1uwuUWYUv8DMl9COhRYIV
         CTTvTZ+AaijevWxxBDmO2CBuTXj6JxQRl/795E3qmcbYwR9xvA8vW1nGLdI0OdKfrZ2V
         WKpta2c5n2cLNApRtdrQxGXulHk9MAjmfzl3AtfS62Ax6l48VihbVeCgvAWnxgYAl5Nc
         rBWA==
X-Gm-Message-State: AOAM531gqFJJKRYLm5wSq2QYThux9KQt6QmH5NTWIopNpbI61e3rOHId
        xZi8Z8lq8HXK4IBPTwqQee4lMnLB
X-Google-Smtp-Source: ABdhPJyMh/4t32+VlzZWhVMRmN7nq9KVQQa/kTvE7h+AVYyHGPMXWLoCVMVX7cfCIn30Xfji4Bb7KA==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr3301090wmd.111.1593089347627;
        Thu, 25 Jun 2020 05:49:07 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:07 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 11/17] merge-octopus: rewrite in C
Date:   Thu, 25 Jun 2020 14:19:47 +0200
Message-Id: <20200625121953.16991-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites `git merge-octopus' from shell to C.  As for the two last
conversions, this port keeps using external processes for operations on
the index, or to call `git merge-one-file'.  This will be addressed in
the next two commits.

Here to, merge_octopus() takes two commit lists and a string to reduce
frictions when try_merge_strategies() will be modified to call it
directly.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 Makefile                |   2 +-
 builtin.h               |   1 +
 builtin/merge-octopus.c | 241 ++++++++++++++++++++++++++++++++++++++++
 git-merge-octopus.sh    | 112 -------------------
 git.c                   |   1 +
 5 files changed, 244 insertions(+), 113 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 delete mode 100755 git-merge-octopus.sh

diff --git a/Makefile b/Makefile
index ccea651ac8..8f45a3ec03 100644
--- a/Makefile
+++ b/Makefile
@@ -595,7 +595,6 @@ unexport CDPATH
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
-SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-request-pull.sh
@@ -1088,6 +1087,7 @@ BUILTIN_OBJS += builtin/mailsplit.o
 BUILTIN_OBJS += builtin/merge-base.o
 BUILTIN_OBJS += builtin/merge-file.o
 BUILTIN_OBJS += builtin/merge-index.o
+BUILTIN_OBJS += builtin/merge-octopus.o
 BUILTIN_OBJS += builtin/merge-one-file.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
diff --git a/builtin.h b/builtin.h
index 6ea207c9fd..5a587ab70c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -170,6 +170,7 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix);
 int cmd_merge(int argc, const char **argv, const char *prefix);
 int cmd_merge_base(int argc, const char **argv, const char *prefix);
 int cmd_merge_index(int argc, const char **argv, const char *prefix);
+int cmd_merge_octopus(int argc, const char **argv, const char *prefix);
 int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_one_file(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-octopus.c b/builtin/merge-octopus.c
new file mode 100644
index 0000000000..6216beaa2b
--- /dev/null
+++ b/builtin/merge-octopus.c
@@ -0,0 +1,241 @@
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
+#include "commit-reach.h"
+#include "lockfile.h"
+#include "run-command.h"
+#include "unpack-trees.h"
+
+static int write_tree(struct tree **reference_tree)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf read_tree = STRBUF_INIT, err = STRBUF_INIT;
+	struct object_id oid;
+	int ret;
+
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "write-tree");
+	ret = pipe_command(&cp, NULL, 0, &read_tree, 0, &err, 0);
+	if (err.len > 0)
+		fputs(err.buf, stderr);
+
+	strbuf_trim_trailing_newline(&read_tree);
+	get_oid(read_tree.buf, &oid);
+
+	*reference_tree = lookup_tree(the_repository, &oid);
+
+	strbuf_release(&read_tree);
+	strbuf_release(&err);
+	child_process_clear(&cp);
+
+	return ret;
+}
+
+static int merge_octopus(struct commit_list *bases, const char *head_arg,
+			 struct commit_list *remotes)
+{
+	int non_ff_merge = 0, ret = 0, references = 1;
+	struct commit **reference_commit;
+	struct tree *reference_tree;
+	struct commit_list *j;
+	struct object_id head;
+
+	get_oid(head_arg, &head);
+	reference_commit = xcalloc(commit_list_count(remotes) + 1, sizeof(struct commit *));
+	reference_commit[0] = lookup_commit_reference(the_repository, &head);
+	reference_tree = get_commit_tree(reference_commit[0]);
+
+	for (j = remotes; j; j = j->next) {
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
+			struct child_process cp = CHILD_PROCESS_INIT;
+
+			printf(_("Fast-forwarding to: %s\n"), branch_name);
+
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "read-tree", "-u", "-m", NULL);
+			argv_array_push(&cp.args, oid_to_hex(&head));
+			argv_array_push(&cp.args, oid_to_hex(oid));
+
+			ret = run_command(&cp);
+			if (ret) {
+				free(branch_name);
+				free_commit_list(common);
+				goto out;
+			}
+
+			child_process_clear(&cp);
+			references = 0;
+			write_tree(&reference_tree);
+		} else {
+			struct commit_list *l;
+			struct tree *next = NULL;
+			struct child_process cp = CHILD_PROCESS_INIT;
+
+			non_ff_merge = 1;
+			printf(_("Trying simple merge with %s\n"), branch_name);
+
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "read-tree", "-u", "-m", "--aggressive", NULL);
+
+			for (l = common; l; l = l->next)
+				argv_array_push(&cp.args, oid_to_hex(&l->item->object.oid));
+
+			argv_array_push(&cp.args, oid_to_hex(&reference_tree->object.oid));
+			argv_array_push(&cp.args, oid_to_hex(oid));
+
+			if (run_command(&cp)) {
+				ret = 2;
+
+				free(branch_name);
+				free_commit_list(common);
+
+				goto out;
+			}
+
+			child_process_clear(&cp);
+
+			if (write_tree(&next)) {
+				struct child_process cp = CHILD_PROCESS_INIT;
+				puts(_("Simple merge did not work, trying automatic merge."));
+
+				cp.git_cmd = 1;
+				argv_array_pushl(&cp.args, "merge-index", "-o",
+						 "git-merge-one-file", "-a", NULL);
+				if (run_command(&cp))
+					ret = 1;
+
+				child_process_clear(&cp);
+				write_tree(&next);
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
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf files = STRBUF_INIT;
+
+	if (argc < 5)
+		usage(builtin_merge_octopus_usage);
+
+	/* The first parameters up to -- are merge bases; the rest are
+	 * heads. */
+	for (i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "--") == 0)
+			sep_seen = 1;
+		else if (strcmp(argv[i], "-h") == 0)
+			usage(builtin_merge_octopus_usage);
+		else if (sep_seen && !head_arg)
+			head_arg = argv[i];
+		else {
+			struct object_id oid;
+
+			get_oid(argv[i], &oid);
+
+			if (!oideq(&oid, the_hash_algo->empty_tree)) {
+				struct commit *commit;
+				commit = lookup_commit_or_die(&oid, argv[i]);
+
+				if (sep_seen)
+					next_remote = commit_list_append(commit, next_remote);
+				else
+					next_base = commit_list_append(commit, next_base);
+			}
+		}
+	}
+
+	/* Reject if this is not an octopus -- resolve should be used
+	 * instead. */
+	if (commit_list_count(remotes) < 2)
+		return 2;
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "diff-index", "--cached",
+			 "--name-only", "HEAD", "--", NULL);
+	pipe_command(&cp, NULL, 0, &files, 0, NULL, 0);
+	child_process_clear(&cp);
+
+	if (files.len > 0) {
+		struct strbuf **s, **b;
+
+		s = strbuf_split(&files, '\n');
+
+		fprintf(stderr, _("Error: Your local changes to the following "
+				  "files would be overwritten by merge\n"));
+
+		for (b = s; *b; b++)
+			fprintf(stderr, "    %.*s", (int)(*b)->len, (*b)->buf);
+
+		strbuf_list_free(s);
+		strbuf_release(&files);
+		return 2;
+	}
+
+	return merge_octopus(bases, head_arg, remotes);
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
index 2e92019493..28634cf61f 100644
--- a/git.c
+++ b/git.c
@@ -531,6 +531,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-octopus", cmd_merge_octopus, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-one-file", cmd_merge_one_file, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-- 
2.27.0.139.gc9c318d6bf

