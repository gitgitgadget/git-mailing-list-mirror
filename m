Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3363DC352A5
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAAB20873
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSBmB7Vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgBJOp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45999 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgBJOpw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id g3so6988400wrs.12
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XFwDqRnins5HIgtcAe3TVwlFuiBIyZkRkJf3MxYVNsc=;
        b=OSBmB7VcNq/8C3dgjuFioEzXN7TmnNVRy7CdEh/Jyb1wOSC5tg7oEEp9YXkd1LSZjt
         zV6KY2FmdzhtuAMBJPlZMvgrJiTdJ/6AgOZD0JWgLirCXPxpLOpkpCVRoaN6xGt3BY42
         fQ1YEtltQtCfuBvf1fQ9ec37ATr/2jEWj2rVDoxlQrqb+FaYsRttLL3WPGA1e7wI+QF9
         KSFJl0Iz1ZXxASudIMpVKasCjNgWIjfv/cZGgI/DnwXLot+NKOGvE+XdJ9CX9U3NKpE8
         6ihWpasyVyxHRMcxlm2HYRlKSqN6pa/JyBhkzimmv1GuNavQWfGf5sB8BIJmLpaVxn7v
         Ng7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XFwDqRnins5HIgtcAe3TVwlFuiBIyZkRkJf3MxYVNsc=;
        b=H20gwpnsE3atZQt3ck1n0eL37kZtrLf6AyWl+RzmGyobxrLjnYKL/jpL226/riXLRi
         UCrsR3bVOdA5tEZybf4SwislGCFvra95Omsv7dKUDdkVkozQxxygodU536UboqN4drTN
         5oybTmybiUN9g13VkZ7bpCSno/aYw3w/4drtNuRA9lN3DNaPxxUapLaiNhU2k1ReaWpJ
         V7KI6DpY2q7mBbcmUuuqRlccD159OwAW5jDoA3H/MzuRqYBpN58lKrZYWeslnXxe2+eF
         67gh4f2pErP9F4dhYghmZlyfQmciKByAl7L+2KuOZZJDWoLfXZFHhWW0YW1pY4TWEr0U
         quvw==
X-Gm-Message-State: APjAAAXnreutIucHXTBqjmGxJ+OWvNAApu7n85eIsmckIREKRalWR3hE
        fY2dA/F3eKGT7oaHFppKaZ2okNBp
X-Google-Smtp-Source: APXvYqyX3YD8HcGVZYWpGu2cVhcPzCuhLBJgKEOIb0xnqEHQ6BlmkC4fWyBfibKw5LOp1klDJs+yRA==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr2267269wrm.278.1581345950934;
        Mon, 10 Feb 2020 06:45:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm837771wrs.10.2020.02.10.06.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:50 -0800 (PST)
Message-Id: <7ccbab52e51423a9ba74c0cab77448ceabb9dcdc.1581345948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:45:41 +0000
Subject: [PATCH v2 2/8] rm: support the --pathspec-from-file option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Decisions taken for simplicity:
1) It is not allowed to pass pathspec in both args and file.

`if (!argc)` block was adapted to work with --pathspec-from-file. For
that, I also had to parse pathspec earlier. Now it happens before
`read_cache()` / `hold_locked_index()` / `setup_work_tree()`, which
sounds fine to me.

In case of empty pathspec, there is now a clear error message instead
of showing usage. As a consequence, exit code has also changed. Judging
from [1] it doesn't seem that showing usage in this case was important
(according to commit message, it was to avoid segfault), and it doesn't
fit into how other commands react to empty pathspec. Finally, the new
error message is easier to understand.

[1] Commit 7612a1ef ("git-rm: honor -n flag" 2006-06-09)

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-rm.txt    | 17 +++++++-
 builtin/rm.c                | 28 ++++++++++---
 t/t3601-rm-pathspec-file.sh | 79 +++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 7 deletions(-)
 create mode 100755 t/t3601-rm-pathspec-file.sh

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index e02a08e5ef..ab750367fd 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -8,7 +8,9 @@ git-rm - Remove files from the working tree and from the index
 SYNOPSIS
 --------
 [verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <pathspec>...
+'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]
+	  [--quiet] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+	  [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -73,6 +75,19 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 	`git rm` normally outputs one line (in the form of an `rm` command)
 	for each file removed. This option suppresses that output.
 
+--pathspec-from-file=<file>::
+	Pathspec is passed in `<file>` instead of commandline args. If
+	`<file>` is exactly `-` then standard input is used. Pathspec
+	elements are separated by LF or CR/LF. Pathspec elements can be
+	quoted as explained for the configuration variable `core.quotePath`
+	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
+	global `--literal-pathspecs`.
+
+--pathspec-file-nul::
+	Only meaningful with `--pathspec-from-file`. Pathspec elements are
+	separated with NUL character and all other characters are taken
+	literally (including newlines and quotes).
+
 
 REMOVING FILES THAT HAVE DISAPPEARED FROM THE FILESYSTEM
 --------------------------------------------------------
diff --git a/builtin/rm.c b/builtin/rm.c
index 19ce95a901..4858631e0f 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -235,7 +235,8 @@ static int check_local_mod(struct object_id *head, int index_only)
 }
 
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
-static int ignore_unmatch = 0;
+static int ignore_unmatch = 0, pathspec_file_nul;
+static char *pathspec_from_file;
 
 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
@@ -245,6 +246,8 @@ static struct option builtin_rm_options[] = {
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
+	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 	OPT_END(),
 };
 
@@ -259,8 +262,24 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
 			     builtin_rm_usage, 0);
-	if (!argc)
-		usage_with_options(builtin_rm_usage, builtin_rm_options);
+
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD,
+		       prefix, argv);
+
+	if (pathspec_from_file) {
+		if (pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		parse_pathspec_file(&pathspec, 0,
+				    PATHSPEC_PREFER_CWD,
+				    prefix, pathspec_from_file, pathspec_file_nul);
+	} else if (pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	}
+
+	if (!pathspec.nr)
+		die(_("No pathspec was given. Which files should I remove?"));
 
 	if (!index_only)
 		setup_work_tree();
@@ -270,9 +289,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_CWD,
-		       prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &pathspec, NULL, NULL);
 
 	seen = xcalloc(pathspec.nr, 1);
diff --git a/t/t3601-rm-pathspec-file.sh b/t/t3601-rm-pathspec-file.sh
new file mode 100755
index 0000000000..4542a0f02f
--- /dev/null
+++ b/t/t3601-rm-pathspec-file.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='rm --pathspec-from-file'
+
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success setup '
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t &&
+	git add fileA.t fileB.t fileC.t fileD.t &&
+	git commit -m "files" &&
+	
+	git tag checkpoint
+'
+
+restore_checkpoint () {
+	git reset --hard checkpoint
+}
+
+verify_expect () {
+	git status --porcelain --untracked-files=no -- fileA.t fileB.t fileC.t fileD.t >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'simplest' '
+	restore_checkpoint &&
+
+	cat >expect <<-\EOF &&
+	D  fileA.t
+	EOF
+
+	echo fileA.t | git rm --pathspec-from-file=- &&
+	verify_expect
+'
+
+test_expect_success '--pathspec-file-nul' '
+	restore_checkpoint &&
+
+	cat >expect <<-\EOF &&
+	D  fileA.t
+	D  fileB.t
+	EOF
+
+	printf "fileA.t\0fileB.t\0" | git rm --pathspec-from-file=- --pathspec-file-nul &&
+	verify_expect
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	cat >expect <<-\EOF &&
+	D  fileB.t
+	D  fileC.t
+	EOF
+
+	printf "fileB.t\nfileC.t\n" | git rm --pathspec-from-file=- &&
+	verify_expect
+'
+
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+
+	test_must_fail git rm --pathspec-from-file=list -- fileA.t 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git rm --pathspec-file-nul 2>err &&
+	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+	
+	>empty_list &&
+	test_must_fail git rm --pathspec-from-file=empty_list 2>err &&
+	test_i18ngrep -e "No pathspec was given. Which files should I remove?" err
+'
+
+test_done
-- 
gitgitgadget

