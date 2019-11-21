Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E761C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BB02068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcSXf3DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUWE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:04:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45721 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUWE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:04:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id z10so6259113wrs.12
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zuxJvocOqPdij+qW4nZ8mgj+xzeMp+CZFQRyarg28SA=;
        b=OcSXf3DBLhZvURTAnYaUDwJStYzWcZ0xoGL2izUGVpv9wURMMoeRFTGL7aofbsL/ZB
         FXMCLlax3/siRWYWfGFR5bN8WhrLiMRyouRf9/OkiIisVIF6CdLM046+JQJK40vck7cw
         4O5FLoz+O7LL4uRQqr1d5AxLWO8Lydk32EpNVadgoWIua6650d5hSIHT6fEBF4toWlIj
         0PaY1KPVlRmcnBlrai7aF1mh6AAJzdlwr5v3uiHowGR5hTvAfL5wBnIVNdAzYlnesph7
         Taes0YMSpeEOGQA2/fr1bpd7/tbPZLcszVFFeqXIzk5xUReXJEoIksX1uoyn/O2Xscxk
         tRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zuxJvocOqPdij+qW4nZ8mgj+xzeMp+CZFQRyarg28SA=;
        b=T6ijRkVYQ3dJLFQwwv63ca1zLQuQiHO87WtxIYgMrI/t9v3RhftOwTj63FdU4SI2oS
         NR6pM60RDtXq6QyDi+315LfsARBu6VmalK6Ju7SOyMvP4bHBc3R2rPKBV33JwOQQk1dr
         uF+Yq5t/0N4Xd1nCTV+a/PatWCMtiO/YLrqKtADGHO8Or1hoTpfP4hM2aq5CCPoQyuxP
         jv4BxiGnFlb2vIi08TZiE5brydqtZ+evJZ0wCUKVhfZsoAJ2l5h4EXAvfA57H9oLcudy
         8UURu1LLVR8htXGOUGYwSj16yb5KbLDqcePzClo2CBnyek3Kyyat1/RYR2Fk1nV8IAs6
         TiHQ==
X-Gm-Message-State: APjAAAVDXgzmHgE83mimr+Tif5ukInfYwy4sZUj4/YjB1ba14MT0FZSv
        eHEe/D17NuTnRGPoIbZugUh6uk3z
X-Google-Smtp-Source: APXvYqxgbkNwA48p4rR7MqK43KEe8StOnTozUBDZyO72IrxfHkUm29hSA2qSGI76vrZ56gdZmMMQxw==
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr14445011wrr.105.1574373894902;
        Thu, 21 Nov 2019 14:04:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y78sm1111825wmd.32.2019.11.21.14.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:04:54 -0800 (PST)
Message-Id: <81a15260695f83cf46185ed5357dd4f0e5dae384.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:33 +0000
Subject: [PATCH v6 01/19] sparse-checkout: create builtin with 'list'
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse-checkout feature is mostly hidden to users, as its
only documentation is supplementary information in the docs for
'git read-tree'. In addition, users need to know how to edit the
.git/info/sparse-checkout file with the right patterns, then run
the appropriate 'git read-tree -mu HEAD' command. Keeping the
working directory in sync with the sparse-checkout file requires
care.

Begin an effort to make the sparse-checkout feature a porcelain
feature by creating a new 'git sparse-checkout' builtin. This
builtin will be the preferred mechanism for manipulating the
sparse-checkout file and syncing the working directory.

The documentation provided is adapted from the "git read-tree"
documentation with a few edits for clarity in the new context.
Extra sections are added to hint toward a future change to
a more restricted pattern set.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                            |  1 +
 Documentation/git-read-tree.txt       |  2 +-
 Documentation/git-sparse-checkout.txt | 89 +++++++++++++++++++++++++++
 Makefile                              |  1 +
 builtin.h                             |  1 +
 builtin/sparse-checkout.c             | 86 ++++++++++++++++++++++++++
 command-list.txt                      |  1 +
 git.c                                 |  1 +
 t/t1091-sparse-checkout-builtin.sh    | 45 ++++++++++++++
 9 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-sparse-checkout.txt
 create mode 100644 builtin/sparse-checkout.c
 create mode 100755 t/t1091-sparse-checkout-builtin.sh

diff --git a/.gitignore b/.gitignore
index 89b3b79c1a..aebe7c0908 100644
--- a/.gitignore
+++ b/.gitignore
@@ -158,6 +158,7 @@
 /git-show-branch
 /git-show-index
 /git-show-ref
+/git-sparse-checkout
 /git-stage
 /git-stash
 /git-status
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index d271842608..da33f84f33 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -436,7 +436,7 @@ support.
 SEE ALSO
 --------
 linkgit:git-write-tree[1]; linkgit:git-ls-files[1];
-linkgit:gitignore[5]
+linkgit:gitignore[5]; linkgit:git-sparse-checkout[1];
 
 GIT
 ---
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
new file mode 100644
index 0000000000..87ffcbbcb0
--- /dev/null
+++ b/Documentation/git-sparse-checkout.txt
@@ -0,0 +1,89 @@
+git-sparse-checkout(1)
+======================
+
+NAME
+----
+git-sparse-checkout - Initialize and modify the sparse-checkout
+configuration, which reduces the checkout to a set of paths
+given by a list of atterns.
+
+
+SYNOPSIS
+--------
+[verse]
+'git sparse-checkout <subcommand> [options]'
+
+
+DESCRIPTION
+-----------
+
+Initialize and modify the sparse-checkout configuration, which reduces
+the checkout to a set of paths given by a list of patterns.
+
+THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
+COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
+THE FUTURE.
+
+
+COMMANDS
+--------
+'list'::
+	Provide a list of the contents in the sparse-checkout file.
+
+
+SPARSE CHECKOUT
+---------------
+
+"Sparse checkout" allows populating the working directory sparsely.
+It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
+Git whether a file in the working directory is worth looking at. If
+the skip-worktree bit is set, then the file is ignored in the working
+directory. Git will not populate the contents of those files, which
+makes a sparse checkout helpful when working in a repository with many
+files, but only a few are important to the current user.
+
+The `$GIT_DIR/info/sparse-checkout` file is used to define the
+skip-worktree reference bitmap. When Git updates the working
+directory, it updates the skip-worktree bits in the index based
+on this file. The files matching the patterns in the file will
+appear in the working directory, and the rest will not.
+
+## FULL PATTERN SET
+
+By default, the sparse-checkout file uses the same syntax as `.gitignore`
+files.
+
+While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
+files are included, you can also specify what files are _not_ included,
+using negative patterns. For example, to remove the file `unwanted`:
+
+----------------
+/*
+!unwanted
+----------------
+
+Another tricky thing is fully repopulating the working directory when you
+no longer want sparse checkout. You cannot just disable "sparse
+checkout" because skip-worktree bits are still in the index and your working
+directory is still sparsely populated. You should re-populate the working
+directory with the `$GIT_DIR/info/sparse-checkout` file content as
+follows:
+
+----------------
+/*
+----------------
+
+Then you can disable sparse checkout. Sparse checkout support in 'git
+checkout' and similar commands is disabled by default. You need to
+set `core.sparseCheckout` to `true` in order to have sparse checkout
+support.
+
+SEE ALSO
+--------
+
+linkgit:git-read-tree[1]
+linkgit:gitignore[5]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index de60c8e7aa..adefc229fe 100644
--- a/Makefile
+++ b/Makefile
@@ -1125,6 +1125,7 @@ BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/sparse-checkout.o
 BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
diff --git a/builtin.h b/builtin.h
index 5cf5df69f7..2b25a80cde 100644
--- a/builtin.h
+++ b/builtin.h
@@ -225,6 +225,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix);
 int cmd_show(int argc, const char **argv, const char *prefix);
 int cmd_show_branch(int argc, const char **argv, const char *prefix);
 int cmd_show_index(int argc, const char **argv, const char *prefix);
+int cmd_sparse_checkout(int argc, const char **argv, const char *prefix);
 int cmd_status(int argc, const char **argv, const char *prefix);
 int cmd_stash(int argc, const char **argv, const char *prefix);
 int cmd_stripspace(int argc, const char **argv, const char *prefix);
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
new file mode 100644
index 0000000000..5717c9b2cb
--- /dev/null
+++ b/builtin/sparse-checkout.c
@@ -0,0 +1,86 @@
+#include "builtin.h"
+#include "config.h"
+#include "dir.h"
+#include "parse-options.h"
+#include "pathspec.h"
+#include "repository.h"
+#include "run-command.h"
+#include "strbuf.h"
+
+static char const * const builtin_sparse_checkout_usage[] = {
+	N_("git sparse-checkout list"),
+	NULL
+};
+
+static char *get_sparse_checkout_filename(void)
+{
+	return git_pathdup("info/sparse-checkout");
+}
+
+static void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
+{
+	int i;
+
+	for (i = 0; i < pl->nr; i++) {
+		struct path_pattern *p = pl->patterns[i];
+
+		if (p->flags & PATTERN_FLAG_NEGATIVE)
+			fprintf(fp, "!");
+
+		fprintf(fp, "%s", p->pattern);
+
+		if (p->flags & PATTERN_FLAG_MUSTBEDIR)
+			fprintf(fp, "/");
+
+		fprintf(fp, "\n");
+	}
+}
+
+static int sparse_checkout_list(int argc, const char **argv)
+{
+	struct pattern_list pl;
+	char *sparse_filename;
+	int res;
+
+	memset(&pl, 0, sizeof(pl));
+
+	sparse_filename = get_sparse_checkout_filename();
+	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
+	free(sparse_filename);
+
+	if (res < 0) {
+		warning(_("this worktree is not sparse (sparse-checkout file may not exist)"));
+		return 0;
+	}
+
+	write_patterns_to_file(stdout, &pl);
+	clear_pattern_list(&pl);
+
+	return 0;
+}
+
+int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_sparse_checkout_options[] = {
+		OPT_END(),
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_sparse_checkout_usage,
+				   builtin_sparse_checkout_options);
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_options,
+			     builtin_sparse_checkout_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	git_config(git_default_config, NULL);
+
+	if (argc > 0) {
+		if (!strcmp(argv[0], "list"))
+			return sparse_checkout_list(argc, argv);
+	}
+
+	usage_with_options(builtin_sparse_checkout_usage,
+			   builtin_sparse_checkout_options);
+}
diff --git a/command-list.txt b/command-list.txt
index a9ac72bef4..d3d28252b3 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -166,6 +166,7 @@ git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-i18n                             purehelpers
 git-sh-setup                            purehelpers
+git-sparse-checkout                     mainporcelain           worktree
 git-stash                               mainporcelain
 git-stage                                                               complete
 git-status                              mainporcelain           info
diff --git a/git.c b/git.c
index ce6ab0ece2..7be7ad34bd 100644
--- a/git.c
+++ b/git.c
@@ -572,6 +572,7 @@ static struct cmd_struct commands[] = {
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-index", cmd_show_index },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
+	{ "sparse-checkout", cmd_sparse_checkout, RUN_SETUP | NEED_WORK_TREE },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	/*
 	 * NEEDSWORK: Until the builtin stash is thoroughly robust and no
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
new file mode 100755
index 0000000000..9b73d44907
--- /dev/null
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='sparse checkout builtin tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git init repo &&
+	(
+		cd repo &&
+		echo "initial" >a &&
+		mkdir folder1 folder2 deep &&
+		mkdir deep/deeper1 deep/deeper2 &&
+		mkdir deep/deeper1/deepest &&
+		cp a folder1 &&
+		cp a folder2 &&
+		cp a deep &&
+		cp a deep/deeper1 &&
+		cp a deep/deeper2 &&
+		cp a deep/deeper1/deepest &&
+		git add . &&
+		git commit -m "initial commit"
+	)
+'
+
+test_expect_success 'git sparse-checkout list (empty)' '
+	git -C repo sparse-checkout list >list 2>err &&
+	test_must_be_empty list &&
+	test_i18ngrep "this worktree is not sparse (sparse-checkout file may not exist)" err
+'
+
+test_expect_success 'git sparse-checkout list (populated)' '
+	test_when_finished rm -f repo/.git/info/sparse-checkout &&
+	cat >repo/.git/info/sparse-checkout <<-EOF &&
+		/folder1/*
+		/deep/
+		**/a
+		!*bin*
+	EOF
+	cp repo/.git/info/sparse-checkout expect &&
+	git -C repo sparse-checkout list >list &&
+	test_cmp expect list
+'
+
+test_done
-- 
gitgitgadget

