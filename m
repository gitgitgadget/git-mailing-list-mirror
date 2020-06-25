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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220E8C433E1
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE6F206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkjQb9EJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404829AbgFYMtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404801AbgFYMtE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A889C061795
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t194so5794020wmt.4
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1E+2npJRgqglnF1txGs5ji9IXN0R4z5sFf/stpPXp7k=;
        b=MkjQb9EJiW2LsUa4uD45+OgeIUULZuJHYEgLxDJ+gzV23UdRBjTGC2XKw8YncUpE7c
         qJH9Lr3k22pXWMSLG/4HqGMTeLBleoIF2QR+mhynXE78KUWYV++4RZXpyHNI45iabzxM
         sksulbejOpHwpeC2b5J4LN+dTyJn5+UhTPp1jsQ0Qvc/gD8kaCzq6TLhrddabTTK9LNf
         hXEfMRFO2/+kPVM2wmS/2AsDeaaVPbG6PTLwaF6LHmSa1PXIeFv76iL6giOo41FU9n/m
         1qX5Q1GpeT/jU94ew7oRTg7lGsTqd728QCp4lUy6GMjSOlkfu/tqHe8CT5scLzSO/FM8
         g6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1E+2npJRgqglnF1txGs5ji9IXN0R4z5sFf/stpPXp7k=;
        b=uedWtilX/NUWeVmsqvS0t9tdDgW4ximFjzmpJ7UAWYnuLx60ekcgSNvtPitvngLFSV
         WmVSKEcS/vNaqCxeEAAsNP87e1w8IaWUT/C9XPTjoIkhikK1QcFvjQWjc1MKTuaOgGAQ
         1muWX2KRBwq74YeARxUZkH4wHz5LuE/iswUS96bw0I24811cL6fc9igf5xhD1yaEDYsy
         P8GswW8+vaXmY9wMQV14/KIHpymcEHD0ZuskE8WanTMdCcIMbpbhDSDusaDoZ3Ic8TUQ
         FiSJj4XP0lex2uWq3FfQ7bxa81jHlenS1qHqxLq5xn43Gav1Oxi5Md4W+Ihi4EVC8QJX
         Anyg==
X-Gm-Message-State: AOAM531t1PXQLnYuje39Ao4U3mDo0FzNyDOQsqTcRdqC6zYzY/CC6H9i
        oYjcvibH6ya9gZtwTH0K/clxLS4r
X-Google-Smtp-Source: ABdhPJz/k63D815JnJSkycoDvyEMl57iXiK9S/AJ73vEKMCd5uHI1Znj+Ak7TaGWjtTTTDAoxV8OcQ==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr3291091wmi.85.1593089342647;
        Thu, 25 Jun 2020 05:49:02 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:02 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 07/17] merge-resolve: rewrite in C
Date:   Thu, 25 Jun 2020 14:19:43 +0200
Message-Id: <20200625121953.16991-8-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites `git merge-resolve' from shell to C.  As for `git
merge-one-file', this port keeps using external processes for operations
on the index, or to call `git merge-one-file'.  This will be addressed
in the next two commits.

The parameters of merge_resolve() will be surprising at first glance:
why using a commit list for `bases' and `remote', where we could use an
oid array, and a pointer to an oid?  Because, in a later commit,
try_merge_strategy() will be able to call merge_resolve() directly, and
it already uses a commit list for `bases' (`common') and
`remote' (`remoteheads'), and a string for `head_arg'.  To reduce
frictions later, merge_resolve() takes the same types of parameters.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 Makefile                |   2 +-
 builtin.h               |   1 +
 builtin/merge-resolve.c | 112 ++++++++++++++++++++++++++++++++++++++++
 git-merge-resolve.sh    |  54 -------------------
 git.c                   |   1 +
 5 files changed, 115 insertions(+), 55 deletions(-)
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-resolve.sh

diff --git a/Makefile b/Makefile
index 1ab4d160cb..ccea651ac8 100644
--- a/Makefile
+++ b/Makefile
@@ -596,7 +596,6 @@ SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
-SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-request-pull.sh
@@ -1092,6 +1091,7 @@ BUILTIN_OBJS += builtin/merge-index.o
 BUILTIN_OBJS += builtin/merge-one-file.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
+BUILTIN_OBJS += builtin/merge-resolve.o
 BUILTIN_OBJS += builtin/merge-tree.o
 BUILTIN_OBJS += builtin/merge.o
 BUILTIN_OBJS += builtin/mktag.o
diff --git a/builtin.h b/builtin.h
index 9205d5ecdc..6ea207c9fd 100644
--- a/builtin.h
+++ b/builtin.h
@@ -174,6 +174,7 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_one_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+int cmd_merge_resolve(int argc, const char **argv, const char *prefix);
 int cmd_merge_tree(int argc, const char **argv, const char *prefix);
 int cmd_mktag(int argc, const char **argv, const char *prefix);
 int cmd_mktree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-resolve.c b/builtin/merge-resolve.c
new file mode 100644
index 0000000000..c66fef7b7f
--- /dev/null
+++ b/builtin/merge-resolve.c
@@ -0,0 +1,112 @@
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
+#include "run-command.h"
+
+static int merge_resolve(struct commit_list *bases, const char *head_arg,
+			 struct commit_list *remote)
+{
+	struct commit_list *j;
+	struct child_process cp_update = CHILD_PROCESS_INIT,
+		cp_read = CHILD_PROCESS_INIT,
+		cp_write = CHILD_PROCESS_INIT;
+
+	cp_update.git_cmd = 1;
+	argv_array_pushl(&cp_update.args, "update-index", "-q", "--refresh", NULL);
+	run_command(&cp_update);
+
+	cp_read.git_cmd = 1;
+	argv_array_pushl(&cp_read.args, "read-tree", "-u", "-m", "--aggressive", NULL);
+
+	for (j = bases; j && j->item; j = j->next)
+		argv_array_push(&cp_read.args, oid_to_hex(&j->item->object.oid));
+
+	if (head_arg)
+		argv_array_push(&cp_read.args, head_arg);
+	if (remote && remote->item)
+		argv_array_push(&cp_read.args, oid_to_hex(&remote->item->object.oid));
+
+	if (run_command(&cp_read))
+		return 2;
+
+	puts("Trying simple merge.");
+
+	cp_write.git_cmd = 1;
+	cp_write.no_stdout = 1;
+	cp_write.no_stderr = 1;
+	argv_array_push(&cp_write.args, "write-tree");
+	if (run_command(&cp_write)) {
+		struct child_process cp_merge = CHILD_PROCESS_INIT;
+
+		puts("Simple merge failed, trying Automatic merge.");
+
+		cp_merge.git_cmd = 1;
+		argv_array_pushl(&cp_merge.args, "merge-index", "-o",
+				 "git-merge-one-file", "-a", NULL);
+		if (run_command(&cp_merge))
+			return 1;
+	}
+
+	return 0;
+}
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
+	return merge_resolve(bases, head, remote);
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
index 058d91a2a5..2e92019493 100644
--- a/git.c
+++ b/git.c
@@ -536,6 +536,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-resolve", cmd_merge_resolve, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
-- 
2.27.0.139.gc9c318d6bf

