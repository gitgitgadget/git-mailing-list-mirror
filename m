Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC0FC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3533D6115B
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhJDBN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhJDBNx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:13:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CDFC061781
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:12:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v17so27595556wrv.9
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1O9Rp+V8gQl7f7mgK/Le+vmEfRBjxOigDmK638lnMk=;
        b=eZpOn19dAKkzWKzWKRbLObDoQiY1Ga/ydhr470NgeLytHm4E+qWb/1n+yInnL/G1yQ
         XVgn7y0hY2vGwe+cRnviArzl72u4w0oTZg2hg3DcrWirQB+BM1juf3NJmYajpARnJ/fd
         P/tvlUAxb9iJBOUr96lJkzF7yCLvgV9Z4XXR1s/1d8f6pMLJdYnrcDFK8QSaB+yYsdnK
         NpkJKbFI4ob9l6TTVVtu5c5Tj8jiSvmSa8e3/KCMMaCk5YQrJt4rxArxiTpkjt6hQgYA
         X30EqtBaCeVzwJm+0gRjcjpQVz4JCBqI9fVabFJcVFJS7p8ojweM1rHSXWpSz7ECTeHn
         N6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1O9Rp+V8gQl7f7mgK/Le+vmEfRBjxOigDmK638lnMk=;
        b=WfkJOCv2/B1Mbr3BxexoojvBHrL5FiAh79RSEInBSpsE8tT9engdmLtEvZJyCMQcUl
         IZQ6ZHCEXdx//uxdYksquf2vb+bOsIT3KbmwpKvf8gq9SoFAEKElOoLLOge0f9VJXRFP
         fdQCdGYUFzihW23qh2iZxGi65AHb703UY/dYl6c08BMugxXKUfuQ0xcBpRHQziNZZYLQ
         /F2JIRVfRxzx1Y7l3YEVMIB2dDVd5dDwGRwWcKHApJSQJcgh+y81eF/d2r7Yz6SuylRg
         FM+Xw/B7wU1iXt6O2yzEy2IqZ+6IDtSIrPJUdy8iMpqkLeAtqopZ3soN8MPtqSzUWzc9
         qkrQ==
X-Gm-Message-State: AOAM532+K0dbdsyJvfiVWKH/xxa6hauCfCLfYESEL2C4haGYfV5YanB6
        r3Q1+3R+tG4inT4khiXKLZ73KuRqcaAAGw==
X-Google-Smtp-Source: ABdhPJyKpt7+Oa/PpA/3AsMMfo0KHCfjcmNTZE6vW7QnL87yxBzDRofwkA8pWb0KYSXCKithcI0+2A==
X-Received: by 2002:adf:b350:: with SMTP id k16mr11036330wrd.368.1633309923571;
        Sun, 03 Oct 2021 18:12:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3sm12384317wmc.25.2021.10.03.18.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:12:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 02/10] read-tree, merge-recursive: overwrite ignored files by default
Date:   Mon,  4 Oct 2021 03:11:51 +0200
Message-Id: <RFC-patch-v4-02.10-8e5f4006604-20211004T004902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This fixes a long-standing patchwork of ignored files handling in
read-tree and merge-recursive, called out and suggested by Junio long
ago.  Quoting from commit dcf0c16ef1 ("core.excludesfile clean-up"
2007-11-16):

    git-read-tree takes --exclude-per-directory=<gitignore>,
    not because the flexibility was needed.  Again, this was
    because the option predates the standardization of the ignore
    files.

    ...

    On the other hand, I think it makes perfect sense to fix
    git-read-tree, git-merge-recursive and git-clean to follow the
    same rule as other commands.  I do not think of a valid use case
    to give an exclude-per-directory that is nonstandard to
    read-tree command, outside a "negative" test in the t1004 test
    script.

    This patch is the first step to untangle this mess.

    The next step would be to teach read-tree, merge-recursive and
    clean (in C) to use setup_standard_excludes().

History shows each of these were partially or fully fixed:

  * clean was taught the new trick in 1617adc7a0 ("Teach git clean to
    use setup_standard_excludes()", 2007-11-14).

  * read-tree was primarily used by checkout & merge scripts.  checkout
    and merge later became builtins and were both fixed to use the new
    setup_standard_excludes() handling in fc001b526c ("checkout,merge:
    loosen overwriting untracked file check based on info/exclude",
    2011-11-27).  So the primary users were fixed, though read-tree
    itself was not.

  * merge-recursive has now been replaced as the default merge backend
    by merge-ort.  merge-ort fixed this by using
    setup_standard_excludes() starting early in its implementation; see
    commit 6681ce5cf6 ("merge-ort: add implementation of checkout()",
    2020-12-13), largely due to its design depending on checkout() and
    thus being influenced by the checkout code.  However,
    merge-recursive itself was not fixed here, in part because its
    design meant it had difficulty differentiating between untracked
    files, ignored files, leftover tracked files that haven't been
    removed yet due to order of processing files, and files written by
    itself due to collisions).

Make the conversion more complete by now handling read-tree and
handling at least the unpack_trees() portion of merge-recursive.  While
merge-recursive is on its way out, fixing the unpack_trees() portion is
easy and facilitates some of the later changes in this series.  Note
that fixing read-tree makes the --exclude-per-directory option to
read-tree useless, so we remove it from the documentation (though we
continue to accept it if passed).

The read-tree changes happen to fix a bug in t1013.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-read-tree.txt | 18 +-----------------
 builtin/read-tree.c             | 21 +++++++++------------
 merge-recursive.c               |  5 ++++-
 t/t1013-read-tree-submodule.sh  |  1 -
 4 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 5fa8bab64c2..0222a27c5af 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -10,8 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
-		[-u [--exclude-per-directory=<gitignore>] | -i]]
-		[--index-output=<file>] [--no-sparse-checkout]
+		[-u | -i]] [--index-output=<file>] [--no-sparse-checkout]
 		(--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
 
 
@@ -88,21 +87,6 @@ OPTIONS
 	The command will refuse to overwrite entries that already
 	existed in the original index file.
 
---exclude-per-directory=<gitignore>::
-	When running the command with `-u` and `-m` options, the
-	merge result may need to overwrite paths that are not
-	tracked in the current branch.  The command usually
-	refuses to proceed with the merge to avoid losing such a
-	path.  However this safety valve sometimes gets in the
-	way.  For example, it often happens that the other
-	branch added a file that used to be a generated file in
-	your branch, and the safety valve triggers when you try
-	to switch to that branch after you ran `make` but before
-	running `make clean` to remove the generated file.  This
-	option tells the command to read per-directory exclude
-	file (usually '.gitignore') and allows such an untracked
-	but explicitly ignored file to be overwritten.
-
 --index-output=<file>::
 	Instead of writing the results out to `$GIT_INDEX_FILE`,
 	write the resulting index in the named file.  While the
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 8f1b8a7e74c..d0f88bbf3e3 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -38,7 +38,7 @@ static int list_tree(struct object_id *oid)
 }
 
 static const char * const read_tree_usage[] = {
-	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>) [-u [--exclude-per-directory=<gitignore>] | -i]] [--no-sparse-checkout] [--index-output=<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
+	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>) [-u | -i]] [--no-sparse-checkout] [--index-output=<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
 	NULL
 };
 
@@ -59,15 +59,10 @@ static int exclude_per_directory_cb(const struct option *opt, const char *arg,
 
 	opts = (struct unpack_trees_options *)opt->value;
 
-	if (opts->dir.exclude_per_dir)
-		die("more than one --exclude-per-directory given.");
-
-	opts->dir.flags |= DIR_SHOW_IGNORED;
-	opts->dir.exclude_per_dir = arg;
-	/* We do not need to nor want to do read-directory
-	 * here; we are merely interested in reusing the
-	 * per directory ignore stack mechanism.
-	 */
+	if (!opts->update)
+		die("--exclude-per-directory is meaningless unless -u");
+	if (strcmp(arg, ".gitignore"))
+		die("--exclude-per-directory argument must be .gitignore");
 	return 0;
 }
 
@@ -206,8 +201,10 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if ((opts.update || opts.index_only) && !opts.merge)
 		die("%s is meaningless without -m, --reset, or --prefix",
 		    opts.update ? "-u" : "-i");
-	if ((opts.dir.exclude_per_dir && !opts.update))
-		die("--exclude-per-directory is meaningless unless -u");
+	if (opts.update && !opts.reset) {
+		opts.dir.flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(&opts.dir);
+	}
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 316cb2ca907..a4131b8837b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -408,8 +408,11 @@ static int unpack_trees_start(struct merge_options *opt,
 	unpack_trees_options_init(&opt->priv->unpack_opts);
 	if (opt->priv->call_depth)
 		opt->priv->unpack_opts.index_only = 1;
-	else
+	else {
 		opt->priv->unpack_opts.update = 1;
+		opt->priv->unpack_opts.dir.flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(&opt->priv->unpack_opts.dir);
+	}
 	opt->priv->unpack_opts.merge = 1;
 	opt->priv->unpack_opts.head_idx = 2;
 	opt->priv->unpack_opts.fn = threeway_merge;
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index b6df7444c05..bfc90d4cf27 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -6,7 +6,6 @@ test_description='read-tree can handle submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
-KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
 test_submodule_switch_recursing_with_args "read-tree -u -m"
 
-- 
2.33.0.1404.g83021034c5d

