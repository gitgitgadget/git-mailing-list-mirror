Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E060C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F92D207BC
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSgnKE5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIAK7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIAK6O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:58:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB09AC061246
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:58:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id e11so706976wme.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSj3uVpKPZPG/QuwYARwrA0Lq4Fsgdnn6Ppaf+VM6Jg=;
        b=NSgnKE5Dtpe6asFLJuIPG+Fb1olafNOdD6KdWEkmZvusGAzQwcH0pbPt8j5zDNh6Jp
         EmEhWpV1Ka+5SnNZ3R4SrDXhhylLSckWyJX2UUXdzv0sCQEoMtJXhO1QEl1LZuUs9QMx
         mqAO1+ArTRUODmR8lXawjdSPKYwYkDk1WVkuBLpnnketmM6YbIc8WXY8z67Pmrz+kegu
         KMX7VoZV5XCoJEOQQUfPhx3gSWkk1UImZDYb4zyZ3c/ws5w5/Fo6nSoSgTV2faIwRdSb
         Lpl/9Q9IKX7j0pJCWmw2UULb0KRGOoxsaqde4rZx+TtZLHBLJFfNIBZY7QaRGqS6A5q4
         vD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSj3uVpKPZPG/QuwYARwrA0Lq4Fsgdnn6Ppaf+VM6Jg=;
        b=GtH7DIzL25rPhU6dRyJ4bHgdCqhiK4tJBi0/hC8fPthDYHP5Yf5iba/fh3+O/yx9bb
         rQ9XkWVZny2u8n5v1SP6a2HzhW4YPWUITwnFjBF+AdJu6NXnFI9k04Egqd6PMzZKoJZ+
         Q7n4BhzLO6liOQs4S9r5xTejgYvOe/f/yKXzBpO2GoRjxrTVVJCtO9GY9wFYHR6eWR2R
         XdysonEFkw2x0BUVRjo7pVE1DhDK9WLTOymPE4J2Y6mypjksZ9VEyv0YVgDmnBosrh66
         ATBPDpDGJsltbKzcxqIu5Xu2Cs/s2U5kUSApHjWeSCYUqJ5wU+5aLY0T/X6bVK4d1fNt
         im7g==
X-Gm-Message-State: AOAM5320FtcEAPBDdHHxibctJfTP2M2dntK/giUGXvUKUtDC2RmdOn5M
        xREoKxDdgLn6keCqJmnn5Gy8r33W/SQ=
X-Google-Smtp-Source: ABdhPJw4EFJYCB7g3knXXaJppa1dCHu3hMjF/DhWtdhrQdW9JhmyUgXhaYMsrkcHNHGewvwljaUUgA==
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr1303056wmj.56.1598957890588;
        Tue, 01 Sep 2020 03:58:10 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.googlemail.com with ESMTPSA id x16sm1705875wrq.62.2020.09.01.03.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:58:10 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 02/11] merge-one-file: rewrite in C
Date:   Tue,  1 Sep 2020 12:56:56 +0200
Message-Id: <20200901105705.6059-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901105705.6059-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200901105705.6059-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites `git merge-one-file' from shell to C.  This port is not
completely straightforward: to save precious cycles by avoiding reading
and flushing the index repeatedly, write temporary files when an
operation can be performed in-memory, or allow other function to use the
rewrite without forking nor worrying about the index, the calls to
external processes are replaced by calls to functions in libgit.a:

 - calls to `update-index --add --cacheinfo' are replaced by calls to
   add_cache_entry();

 - calls to `update-index --remove' are replaced by calls to
   remove_file_from_cache();

 - calls to `checkout-index -u -f' are replaced by calls to
   checkout_entry();

 - calls to `unpack-file' and `merge-files' are replaced by calls to
   read_mmblob() and ll_merge(), respectively, to merge files
   in-memory;

 - calls to `checkout-index -f --stage=2' are replaced by calls to
   cache_file_exists();

 - calls to `update-index' are replaced by calls to add_file_to_cache().

The bulk of the rewrite is done in a new file in libgit.a,
merge-strategies.c.  This will enable the resolve and octopus strategies
to directly call it instead of forking.

This also fixes a bug present in the original script: instead of
checking if a _regular_ file exists when a file exists in the branch to
merge, but not in our branch, the rewritten version checks if a file of
any kind (ie. a directory, ...) exists.  This fixes the tests t6035.14,
where the branch to merge had a new file, `a/b', but our branch had a
directory there; it should have failed because a directory exists, but
it did not because there was no regular file called `a/b'.  This test is
now marked as successful.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 Makefile                        |   3 +-
 builtin.h                       |   1 +
 builtin/merge-one-file.c        |  85 ++++++++++++++
 git-merge-one-file.sh           | 167 ---------------------------
 git.c                           |   1 +
 merge-strategies.c              | 199 ++++++++++++++++++++++++++++++++
 merge-strategies.h              |  13 +++
 t/t6415-merge-dir-to-symlink.sh |   2 +-
 8 files changed, 302 insertions(+), 169 deletions(-)
 create mode 100644 builtin/merge-one-file.c
 delete mode 100755 git-merge-one-file.sh
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

diff --git a/Makefile b/Makefile
index 65f8cfb236..8849d54063 100644
--- a/Makefile
+++ b/Makefile
@@ -596,7 +596,6 @@ SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
-SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
@@ -911,6 +910,7 @@ LIB_OBJS += match-trees.o
 LIB_OBJS += mem-pool.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
+LIB_OBJS += merge-strategies.o
 LIB_OBJS += merge.o
 LIB_OBJS += mergesort.o
 LIB_OBJS += midx.o
@@ -1089,6 +1089,7 @@ BUILTIN_OBJS += builtin/mailsplit.o
 BUILTIN_OBJS += builtin/merge-base.o
 BUILTIN_OBJS += builtin/merge-file.o
 BUILTIN_OBJS += builtin/merge-index.o
+BUILTIN_OBJS += builtin/merge-one-file.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
 BUILTIN_OBJS += builtin/merge-tree.o
diff --git a/builtin.h b/builtin.h
index a5ae15bfe5..9205d5ecdc 100644
--- a/builtin.h
+++ b/builtin.h
@@ -172,6 +172,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix);
 int cmd_merge_index(int argc, const char **argv, const char *prefix);
 int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 int cmd_merge_file(int argc, const char **argv, const char *prefix);
+int cmd_merge_one_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
 int cmd_merge_tree(int argc, const char **argv, const char *prefix);
 int cmd_mktag(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
new file mode 100644
index 0000000000..306a86c2f0
--- /dev/null
+++ b/builtin/merge-one-file.c
@@ -0,0 +1,85 @@
+/*
+ * Builtin "git merge-one-file"
+ *
+ * Copyright (c) 2020 Alban Gruin
+ *
+ * Based on git-merge-one-file.sh, written by Linus Torvalds.
+ *
+ * This is the git per-file merge utility, called with
+ *
+ *   argv[1] - original file SHA1 (or empty)
+ *   argv[2] - file in branch1 SHA1 (or empty)
+ *   argv[3] - file in branch2 SHA1 (or empty)
+ *   argv[4] - pathname in repository
+ *   argv[5] - original file mode (or empty)
+ *   argv[6] - file in branch1 mode (or empty)
+ *   argv[7] - file in branch2 mode (or empty)
+ *
+ * Handle some trivial cases. The _really_ trivial cases have been
+ * handled already by git read-tree, but that one doesn't do any merges
+ * that might change the tree layout.
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "lockfile.h"
+#include "merge-strategies.h"
+
+static const char builtin_merge_one_file_usage[] =
+	"git merge-one-file <orig blob> <our blob> <their blob> <path> "
+	"<orig mode> <our mode> <their mode>\n\n"
+	"Blob ids and modes should be empty for missing files.";
+
+int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
+{
+	struct object_id orig_blob, our_blob, their_blob,
+		*p_orig_blob = NULL, *p_our_blob = NULL, *p_their_blob = NULL;
+	unsigned int orig_mode = 0, our_mode = 0, their_mode = 0, ret = 0;
+	struct lock_file lock = LOCK_INIT;
+
+	if (argc != 8)
+		usage(builtin_merge_one_file_usage);
+
+	if (repo_read_index(the_repository) < 0)
+		die("invalid index");
+
+	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+
+	if (!get_oid(argv[1], &orig_blob)) {
+		p_orig_blob = &orig_blob;
+		orig_mode = strtol(argv[5], NULL, 8);
+
+		if (!(S_ISREG(orig_mode) || S_ISDIR(orig_mode) || S_ISLNK(orig_mode)))
+			ret |= error(_("invalid 'orig' mode: %o"), orig_mode);
+	}
+
+	if (!get_oid(argv[2], &our_blob)) {
+		p_our_blob = &our_blob;
+		our_mode = strtol(argv[6], NULL, 8);
+
+		if (!(S_ISREG(our_mode) || S_ISDIR(our_mode) || S_ISLNK(our_mode)))
+			ret |= error(_("invalid 'our' mode: %o"), our_mode);
+	}
+
+	if (!get_oid(argv[3], &their_blob)) {
+		p_their_blob = &their_blob;
+		their_mode = strtol(argv[7], NULL, 8);
+
+		if (!(S_ISREG(their_mode) || S_ISDIR(their_mode) || S_ISLNK(their_mode)))
+			ret = error(_("invalid 'their' mode: %o"), their_mode);
+	}
+
+	if (ret)
+		return ret;
+
+	ret = merge_strategies_one_file(the_repository,
+					p_orig_blob, p_our_blob, p_their_blob, argv[4],
+					orig_mode, our_mode, their_mode);
+
+	if (ret) {
+		rollback_lock_file(&lock);
+		return ret;
+	}
+
+	return write_locked_index(the_repository->index, &lock, COMMIT_LOCK);
+}
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
deleted file mode 100755
index f6d9852d2f..0000000000
--- a/git-merge-one-file.sh
+++ /dev/null
@@ -1,167 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) Linus Torvalds, 2005
-#
-# This is the git per-file merge script, called with
-#
-#   $1 - original file SHA1 (or empty)
-#   $2 - file in branch1 SHA1 (or empty)
-#   $3 - file in branch2 SHA1 (or empty)
-#   $4 - pathname in repository
-#   $5 - original file mode (or empty)
-#   $6 - file in branch1 mode (or empty)
-#   $7 - file in branch2 mode (or empty)
-#
-# Handle some trivial cases.. The _really_ trivial cases have
-# been handled already by git read-tree, but that one doesn't
-# do any merges that might change the tree layout.
-
-USAGE='<orig blob> <our blob> <their blob> <path>'
-USAGE="$USAGE <orig mode> <our mode> <their mode>"
-LONG_USAGE="usage: git merge-one-file $USAGE
-
-Blob ids and modes should be empty for missing files."
-
-SUBDIRECTORY_OK=Yes
-. git-sh-setup
-cd_to_toplevel
-require_work_tree
-
-if test $# != 7
-then
-	echo "$LONG_USAGE"
-	exit 1
-fi
-
-case "${1:-.}${2:-.}${3:-.}" in
-#
-# Deleted in both or deleted in one and unchanged in the other
-#
-"$1.." | "$1.$1" | "$1$1.")
-	if { test -z "$6" && test "$5" != "$7"; } ||
-	   { test -z "$7" && test "$5" != "$6"; }
-	then
-		echo "ERROR: File $4 deleted on one branch but had its" >&2
-		echo "ERROR: permissions changed on the other." >&2
-		exit 1
-	fi
-
-	if test -n "$2"
-	then
-		echo "Removing $4"
-	else
-		# read-tree checked that index matches HEAD already,
-		# so we know we do not have this path tracked.
-		# there may be an unrelated working tree file here,
-		# which we should just leave unmolested.  Make sure
-		# we do not have it in the index, though.
-		exec git update-index --remove -- "$4"
-	fi
-	if test -f "$4"
-	then
-		rm -f -- "$4" &&
-		rmdir -p "$(expr "z$4" : 'z\(.*\)/')" 2>/dev/null || :
-	fi &&
-		exec git update-index --remove -- "$4"
-	;;
-
-#
-# Added in one.
-#
-".$2.")
-	# the other side did not add and we added so there is nothing
-	# to be done, except making the path merged.
-	exec git update-index --add --cacheinfo "$6" "$2" "$4"
-	;;
-"..$3")
-	echo "Adding $4"
-	if test -f "$4"
-	then
-		echo "ERROR: untracked $4 is overwritten by the merge." >&2
-		exit 1
-	fi
-	git update-index --add --cacheinfo "$7" "$3" "$4" &&
-		exec git checkout-index -u -f -- "$4"
-	;;
-
-#
-# Added in both, identically (check for same permissions).
-#
-".$3$2")
-	if test "$6" != "$7"
-	then
-		echo "ERROR: File $4 added identically in both branches," >&2
-		echo "ERROR: but permissions conflict $6->$7." >&2
-		exit 1
-	fi
-	echo "Adding $4"
-	git update-index --add --cacheinfo "$6" "$2" "$4" &&
-		exec git checkout-index -u -f -- "$4"
-	;;
-
-#
-# Modified in both, but differently.
-#
-"$1$2$3" | ".$2$3")
-
-	case ",$6,$7," in
-	*,120000,*)
-		echo "ERROR: $4: Not merging symbolic link changes." >&2
-		exit 1
-		;;
-	*,160000,*)
-		echo "ERROR: $4: Not merging conflicting submodule changes." >&2
-		exit 1
-		;;
-	esac
-
-	src1=$(git unpack-file $2)
-	src2=$(git unpack-file $3)
-	case "$1" in
-	'')
-		echo "Added $4 in both, but differently."
-		orig=$(git unpack-file $(git hash-object /dev/null))
-		;;
-	*)
-		echo "Auto-merging $4"
-		orig=$(git unpack-file $1)
-		;;
-	esac
-
-	git merge-file "$src1" "$orig" "$src2"
-	ret=$?
-	msg=
-	if test $ret != 0 || test -z "$1"
-	then
-		msg='content conflict'
-		ret=1
-	fi
-
-	# Create the working tree file, using "our tree" version from the
-	# index, and then store the result of the merge.
-	git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4" || exit 1
-	rm -f -- "$orig" "$src1" "$src2"
-
-	if test "$6" != "$7"
-	then
-		if test -n "$msg"
-		then
-			msg="$msg, "
-		fi
-		msg="${msg}permissions conflict: $5->$6,$7"
-		ret=1
-	fi
-
-	if test $ret != 0
-	then
-		echo "ERROR: $msg in $4" >&2
-		exit 1
-	fi
-	exec git update-index -- "$4"
-	;;
-
-*)
-	echo "ERROR: $4: Not handling case $1 -> $2 -> $3" >&2
-	;;
-esac
-exit 1
diff --git a/git.c b/git.c
index 8bd1d7551d..c97fea36c1 100644
--- a/git.c
+++ b/git.c
@@ -534,6 +534,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-one-file", cmd_merge_one_file, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
diff --git a/merge-strategies.c b/merge-strategies.c
new file mode 100644
index 0000000000..f2af4a894d
--- /dev/null
+++ b/merge-strategies.c
@@ -0,0 +1,199 @@
+#include "cache.h"
+#include "dir.h"
+#include "ll-merge.h"
+#include "merge-strategies.h"
+#include "xdiff-interface.h"
+
+static int add_to_index_cacheinfo(struct index_state *istate,
+				  unsigned int mode,
+				  const struct object_id *oid, const char *path)
+{
+	struct cache_entry *ce;
+	int len, option;
+
+	if (!verify_path(path, mode))
+		return error(_("Invalid path '%s'"), path);
+
+	len = strlen(path);
+	ce = make_empty_cache_entry(istate, len);
+
+	oidcpy(&ce->oid, oid);
+	memcpy(ce->name, path, len);
+	ce->ce_flags = create_ce_flags(0);
+	ce->ce_namelen = len;
+	ce->ce_mode = create_ce_mode(mode);
+	if (assume_unchanged)
+		ce->ce_flags |= CE_VALID;
+	option = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
+	if (add_index_entry(istate, ce, option))
+		return error(_("%s: cannot add to the index"), path);
+
+	return 0;
+}
+
+static int checkout_from_index(struct index_state *istate, const char *path)
+{
+	struct checkout state = CHECKOUT_INIT;
+	struct cache_entry *ce;
+
+	state.istate = istate;
+	state.force = 1;
+	state.base_dir = "";
+	state.base_dir_len = 0;
+
+	ce = index_file_exists(istate, path, strlen(path), 0);
+	if (checkout_entry(ce, &state, NULL, NULL) < 0)
+		return error(_("%s: cannot checkout file"), path);
+	return 0;
+}
+
+static int merge_one_file_deleted(struct index_state *istate,
+				  const struct object_id *orig_blob,
+				  const struct object_id *our_blob,
+				  const struct object_id *their_blob, const char *path,
+				  unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
+{
+	if ((our_blob && orig_mode != our_mode) ||
+	    (their_blob && orig_mode != their_mode))
+		return error(_("File %s deleted on one branch but had its "
+			       "permissions changed on the other."), path);
+
+	if (our_blob) {
+		printf(_("Removing %s\n"), path);
+
+		if (file_exists(path))
+			remove_path(path);
+	}
+
+	if (remove_file_from_index(istate, path))
+		return error("%s: cannot remove from the index", path);
+	return 0;
+}
+
+static int do_merge_one_file(struct index_state *istate,
+			     const struct object_id *orig_blob,
+			     const struct object_id *our_blob,
+			     const struct object_id *their_blob, const char *path,
+			     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
+{
+	int ret, i, dest;
+	mmbuffer_t result = {NULL, 0};
+	mmfile_t mmfs[3];
+	struct ll_merge_options merge_opts = {0};
+	struct cache_entry *ce;
+
+	if (our_mode == S_IFLNK || their_mode == S_IFLNK)
+		return error(_("%s: Not merging symbolic link changes."), path);
+	else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK)
+		return error(_("%s: Not merging conflicting submodule changes."), path);
+
+	read_mmblob(mmfs + 1, our_blob);
+	read_mmblob(mmfs + 2, their_blob);
+
+	if (orig_blob) {
+		printf(_("Auto-merging %s\n"), path);
+		read_mmblob(mmfs + 0, orig_blob);
+	} else {
+		printf(_("Added %s in both, but differently.\n"), path);
+		read_mmblob(mmfs + 0, &null_oid);
+	}
+
+	merge_opts.xdl_opts = XDL_MERGE_ZEALOUS_ALNUM;
+	ret = ll_merge(&result, path,
+		       mmfs + 0, "orig",
+		       mmfs + 1, "our",
+		       mmfs + 2, "their",
+		       istate, &merge_opts);
+
+	for (i = 0; i < 3; i++)
+		free(mmfs[i].ptr);
+
+	if (ret > 127 || !orig_blob)
+		ret = error(_("content conflict in %s"), path);
+
+	/* Create the working tree file, using "our tree" version from
+	   the index, and then store the result of the merge. */
+	ce = index_file_exists(istate, path, strlen(path), 0);
+	if (!ce)
+		BUG("file is not present in the cache?");
+
+	unlink(path);
+	dest = open(path, O_WRONLY | O_CREAT, ce->ce_mode);
+	write_in_full(dest, result.ptr, result.size);
+	close(dest);
+
+	free(result.ptr);
+
+	if (ret && our_mode != their_mode)
+		return error(_("permission conflict: %o->%o,%o in %s"),
+			     orig_mode, our_mode, their_mode, path);
+	if (ret)
+		return 1;
+
+	return add_file_to_index(istate, path, 0);
+}
+
+int merge_strategies_one_file(struct repository *r,
+			      const struct object_id *orig_blob,
+			      const struct object_id *our_blob,
+			      const struct object_id *their_blob, const char *path,
+			      unsigned int orig_mode, unsigned int our_mode,
+			      unsigned int their_mode)
+{
+	if (orig_blob &&
+	    ((!their_blob && our_blob && oideq(orig_blob, our_blob)) ||
+	     (!our_blob && their_blob && oideq(orig_blob, their_blob))))
+		/* Deleted in both or deleted in one and unchanged in
+		   the other */
+		return merge_one_file_deleted(r->index,
+					      orig_blob, our_blob, their_blob, path,
+					      orig_mode, our_mode, their_mode);
+	else if (!orig_blob && our_blob && !their_blob) {
+		/* Added in one.  The other side did not add and we
+		   added so there is nothing to be done, except making
+		   the path merged. */
+		return add_to_index_cacheinfo(r->index, our_mode, our_blob, path);
+	} else if (!orig_blob && !our_blob && their_blob) {
+		printf(_("Adding %s\n"), path);
+
+		if (file_exists(path))
+			return error(_("untracked %s is overwritten by the merge."), path);
+
+		if (add_to_index_cacheinfo(r->index, their_mode, their_blob, path))
+			return 1;
+		return checkout_from_index(r->index, path);
+	} else if (!orig_blob && our_blob && their_blob &&
+		   oideq(our_blob, their_blob)) {
+		/* Added in both, identically (check for same
+		   permissions). */
+		if (our_mode != their_mode)
+			return error(_("File %s added identically in both branches, "
+				       "but permissions conflict %o->%o."),
+				     path, our_mode, their_mode);
+
+		printf(_("Adding %s\n"), path);
+
+		if (add_to_index_cacheinfo(r->index, our_mode, our_blob, path))
+			return 1;
+		return checkout_from_index(r->index, path);
+	} else if (our_blob && their_blob)
+		/* Modified in both, but differently. */
+		return do_merge_one_file(r->index,
+					 orig_blob, our_blob, their_blob, path,
+					 orig_mode, our_mode, their_mode);
+	else {
+		char *orig_hex = "", *our_hex = "", *their_hex = "";
+
+		if (orig_blob)
+			orig_hex = oid_to_hex(orig_blob);
+		if (our_blob)
+			our_hex = oid_to_hex(our_blob);
+		if (their_blob)
+			their_hex = oid_to_hex(their_blob);
+
+		return error(_("%s: Not handling case %s -> %s -> %s"),
+			     path, orig_hex, our_hex, their_hex);
+	}
+
+	return 0;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
new file mode 100644
index 0000000000..b527d145c7
--- /dev/null
+++ b/merge-strategies.h
@@ -0,0 +1,13 @@
+#ifndef MERGE_STRATEGIES_H
+#define MERGE_STRATEGIES_H
+
+#include "object.h"
+
+int merge_strategies_one_file(struct repository *r,
+			      const struct object_id *orig_blob,
+			      const struct object_id *our_blob,
+			      const struct object_id *their_blob, const char *path,
+			      unsigned int orig_mode, unsigned int our_mode,
+			      unsigned int their_mode);
+
+#endif /* MERGE_STRATEGIES_H */
diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
index 2eddcc7664..5fb74e39a0 100755
--- a/t/t6415-merge-dir-to-symlink.sh
+++ b/t/t6415-merge-dir-to-symlink.sh
@@ -94,7 +94,7 @@ test_expect_success SYMLINKS 'a/b was resolved as symlink' '
 	test -h a/b
 '
 
-test_expect_failure 'do not lose untracked in merge (resolve)' '
+test_expect_success 'do not lose untracked in merge (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	>a/b/c/e &&
-- 
2.28.0.370.g2c2dc3cc62

