Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118C6C433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F134060EE2
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhI0Qfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbhI0Qfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A49C061765
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r83-20020a1c4456000000b0030cfc00ca5fso1121092wma.2
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aviX4T1h7rX20CLNtcvp9q28vNsQYDozXgXCTyqxX5c=;
        b=J0LZ0/rtxzSe1Z06JGAVr3h/8uV8vvK7gqPm335Uul4xWm+d0Q8NJ1VUzeGUIbmO6O
         qJiyTpq9EDYWAjKSya6pwnyG6ZAfLobBixqCkhJWTJumN1dm6n8mqIEN5Oxjq/5ks+sv
         mgo/fmwFnk1qk3gVvr0e3MykXvfIItGFIDjUwHXkzOKVtLlVep6KmV014+DR/ik0JkE3
         KFlUqI6sK8ISAnhhQQ6BFRBrUjI5OIaRpC0c4DeGC5BRcRUwLPiiuxmUpXxuYtwoyBCz
         zoU14yF3s42FU98I5opxUCMWSgzom7PewrtQpe6XRDUgvUJut8qxUi8yxrl22MCIzWLA
         aA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aviX4T1h7rX20CLNtcvp9q28vNsQYDozXgXCTyqxX5c=;
        b=hegDdqSY4/7r0/T7u7m62vQOW75tSGhd2ndaPd3LNFbasx+stFP6fAlit0Os/oBtks
         2D+QGPwWbYpYrY5J1AiqSWV/g7GJccvrcPWZj7Q1C4L/dBaSSOdpQJ5DxxAENZQ3yu1y
         ClFjySFggdj+pOJhQU590kCkU6F4/uTarLdYyPtgZ4fB2xIC5ZR738UszighvpHenXmY
         emka5j9ygPZjvmg7nsO29vwP5u0dIx9ADXQOBueEyY/QxXvumLI4ttFF/m/izu8+Q/au
         Sg7ezcedPYq3LkAhhhZ2YuD+sOf4/JQRcrKbzxAgMY+JUcU4Av3AsgrVq2tAEwR8ALPy
         /jyg==
X-Gm-Message-State: AOAM530s93pxPKgTpfZDXxNURYniEd++QGfIn3i5cTNj/Dc8zG/fZWtf
        rYNCWUcLOhWZCPlBT1gSisGz4TBfvW8=
X-Google-Smtp-Source: ABdhPJzYq3NKU62VgynmL6D71kJgNMqapK8lLbsPzzip7dJqVhBR5TXfDbGnBL8sYuCu+GTNUuJMyw==
X-Received: by 2002:a05:600c:3b87:: with SMTP id n7mr842179wms.93.1632760431223;
        Mon, 27 Sep 2021 09:33:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm13860780wrs.25.2021.09.27.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:50 -0700 (PDT)
Message-Id: <2501a0c552ad5147f61a96b9ebe45c5199e1dbfd.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:40 +0000
Subject: [PATCH v3 03/11] read-tree, merge-recursive: overwrite ignored files
 by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
---
 Documentation/git-read-tree.txt | 18 +-----------------
 builtin/read-tree.c             | 25 ++++++++++---------------
 merge-recursive.c               | 11 ++++++++++-
 t/t1013-read-tree-submodule.sh  |  1 -
 4 files changed, 21 insertions(+), 34 deletions(-)

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
index 96102c222bf..73cb957a69b 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -38,7 +38,7 @@ static int list_tree(struct object_id *oid)
 }
 
 static const char * const read_tree_usage[] = {
-	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>) [-u [--exclude-per-directory=<gitignore>] | -i]] [--no-sparse-checkout] [--index-output=<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
+	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>) [-u | -i]] [--no-sparse-checkout] [--index-output=<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
 	NULL
 };
 
@@ -53,24 +53,16 @@ static int index_output_cb(const struct option *opt, const char *arg,
 static int exclude_per_directory_cb(const struct option *opt, const char *arg,
 				    int unset)
 {
-	struct dir_struct *dir;
 	struct unpack_trees_options *opts;
 
 	BUG_ON_OPT_NEG(unset);
 
 	opts = (struct unpack_trees_options *)opt->value;
 
-	if (opts->dir)
-		die("more than one --exclude-per-directory given.");
-
-	dir = xcalloc(1, sizeof(*opts->dir));
-	dir->flags |= DIR_SHOW_IGNORED;
-	dir->exclude_per_dir = arg;
-	opts->dir = dir;
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
 
@@ -209,8 +201,11 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if ((opts.update || opts.index_only) && !opts.merge)
 		die("%s is meaningless without -m, --reset, or --prefix",
 		    opts.update ? "-u" : "-i");
-	if ((opts.dir && !opts.update))
-		die("--exclude-per-directory is meaningless unless -u");
+	if (opts.update && !opts.reset) {
+		CALLOC_ARRAY(opts.dir, 1);
+		opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(opts.dir);
+	}
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
 
diff --git a/merge-recursive.c b/merge-recursive.c
index e594d4c3fa1..233d9f686ad 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -408,8 +408,13 @@ static int unpack_trees_start(struct merge_options *opt,
 	memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts));
 	if (opt->priv->call_depth)
 		opt->priv->unpack_opts.index_only = 1;
-	else
+	else {
 		opt->priv->unpack_opts.update = 1;
+		/* FIXME: should only do this if !overwrite_ignore */
+		CALLOC_ARRAY(opt->priv->unpack_opts.dir, 1);
+		opt->priv->unpack_opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(opt->priv->unpack_opts.dir);
+	}
 	opt->priv->unpack_opts.merge = 1;
 	opt->priv->unpack_opts.head_idx = 2;
 	opt->priv->unpack_opts.fn = threeway_merge;
@@ -423,6 +428,10 @@ static int unpack_trees_start(struct merge_options *opt,
 	init_tree_desc_from_tree(t+2, merge);
 
 	rc = unpack_trees(3, t, &opt->priv->unpack_opts);
+	if (opt->priv->unpack_opts.dir) {
+		dir_clear(opt->priv->unpack_opts.dir);
+		FREE_AND_NULL(opt->priv->unpack_opts.dir);
+	}
 	cache_tree_free(&opt->repo->index->cache_tree);
 
 	/*
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
gitgitgadget

