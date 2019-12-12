Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F1FC2D0CA
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AFE22527
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ4xsYvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfLLOgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34203 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbfLLOgc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so3014581wrr.1
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GsrgKioLwyFbLSgFpkqBy1X71IrR7SM9rusEKBeB90E=;
        b=iQ4xsYvOCXMETRiJoaBeK8XuVtxEaKg9SiBknkdgjkS8SCeK+P1iOnE98WWiA8rMcK
         VMh4b+s4tl7zw7W9larrZzpZp7PBAjHtAcyrrfOuGxzeKSqBovWqRm01BbTnfI2+AYZO
         bQp6EKlFW1+ZPddnoAOiUA5Uhh0SrBiwhIxu9RVkcFL1p+m1rz5ym6A5AEiko1BSxyZm
         de08kGnzR+ODmoSSGmszdiCu5hrhsRRA5D8Ay6rAq2wnsJnA2zN7KnkIS7W8AuH3jABl
         uoh6wz6fthL52JAniMvQY0RNCkwJTJP+LEyKX92RGF71XuOkET1GeQ5cwMPUEh5fVjpw
         W0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GsrgKioLwyFbLSgFpkqBy1X71IrR7SM9rusEKBeB90E=;
        b=MzCzbZVrqTXM2xlORr82A7xXVS3u9ylblnaeywMQhH6eAgDupUw5cKQSqA+5WJkGH3
         05SQzA0NHMuch5AUerFdDGVqFAT4LQKSmsurTy6nPfW1/CcQOa87r2s3MIwctp3t8YuS
         3iqi1pWVOO3mLcokwDRBtqbD/cogo6zZM5mV9EE2X2xV79j/ZJa2V0PAtKjBOua4sqQE
         1EorrgFUpeDA6Qo/TWTAAzD+xEe4Yto/b+/5kwjLddi/aluw4v+tF1JzI6UQla1zpH5I
         JHTJ0K2oUU/ROI6g0UwjA7IyHqu2NjxxtWRA4PHc/N5IeOUrqWLCSdUd113UypElemMy
         hJhA==
X-Gm-Message-State: APjAAAWTFELpbFHQBdcZ232a1fiXfYlVTwWkxCt0TLXxajOFZvrw+6mu
        jTTHm890ZwFi00QPchd33RPrI289
X-Google-Smtp-Source: APXvYqzaDqe/SWJh9qj7LOVsOXVVv7YWAgC3karKvfriJo4zdDsb4ztVSQeFZpV7o1LStRm9mqp7rA==
X-Received: by 2002:a05:6000:118e:: with SMTP id g14mr6639672wrx.39.1576161389269;
        Thu, 12 Dec 2019 06:36:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm6326516wmc.23.2019.12.12.06.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:28 -0800 (PST)
Message-Id: <0328fdafbb6c70ec3f3ead84183af94cd060ae0e.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:13 +0000
Subject: [PATCH 04/16] add: support the --pathspec-from-file option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Decisions taken for simplicity:
1) For now, `--pathspec-from-file` is declared incompatible with
   `--interactive/--patch/--edit`, even when <file> is not `stdin`.
   Such use case it not really expected. Also, it would require changes
   to `interactive_add()` and `edit_patch()`.
2) It is not allowed to pass pathspec in both args and file.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-add.txt    | 16 +++++++++++-
 builtin/add.c                | 30 +++++++++++++++++++---
 t/t3704-add-pathspec-file.sh | 49 ++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 5 deletions(-)
 create mode 100755 t/t3704-add-pathspec-file.sh

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 8b0e4c7fa8..be5e3ac54b 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
 	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
-	  [--chmod=(+|-)x] [--] [<pathspec>...]
+	  [--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+	  [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -187,6 +188,19 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	bit is only changed in the index, the files on disk are left
 	unchanged.
 
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
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
diff --git a/builtin/add.c b/builtin/add.c
index 3d1791dd82..7c21ad492b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -29,6 +29,8 @@ static const char * const builtin_add_usage[] = {
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
 static int add_renormalize;
+static int pathspec_file_nul;
+static const char *pathspec_from_file;
 
 struct update_callback_data {
 	int flags;
@@ -320,6 +322,8 @@ static struct option builtin_add_options[] = {
 		   N_("override the executable bit of the listed files")),
 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
 			N_("warn when adding an embedded repository")),
+	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 	OPT_END(),
 };
 
@@ -414,11 +418,17 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
 	if (patch_interactive)
 		add_interactive = 1;
-	if (add_interactive)
+	if (add_interactive) {
+		if (pathspec_from_file)
+			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
 		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive));
+	}
 
-	if (edit_interactive)
+	if (edit_interactive) {
+		if (pathspec_from_file)
+			die(_("--pathspec-from-file is incompatible with --edit"));
 		return(edit_patch(argc, argv, prefix));
+	}
 	argc--;
 	argv++;
 
@@ -451,13 +461,25 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		       PATHSPEC_SYMLINK_LEADING_PATH,
 		       prefix, argv);
 
-	if (require_pathspec && argc == 0) {
+	if (pathspec_from_file) {
+		if (pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		parse_pathspec_file(&pathspec, PATHSPEC_ATTR,
+				    PATHSPEC_PREFER_FULL |
+				    PATHSPEC_SYMLINK_LEADING_PATH,
+				    prefix, pathspec_from_file, pathspec_file_nul);
+	} else if (pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	}
+
+	if (require_pathspec && pathspec.nr == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
 
-	if (!take_worktree_changes && addremove_explicit < 0 && argc)
+	if (!take_worktree_changes && addremove_explicit < 0 && pathspec.nr)
 		/* Turn "git add pathspec..." to "git add -A pathspec..." */
 		addremove = 1;
 
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
new file mode 100755
index 0000000000..b7f3fedcb8
--- /dev/null
+++ b/t/t3704-add-pathspec-file.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='add --pathspec-from-file'
+
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success setup '
+	test_commit file0 &&
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t
+'
+
+restore_checkpoint () {
+	git reset
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
+	echo fileA.t | git add --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	A  fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	printf "fileB.t\nfileC.t\n" | git add --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	A  fileB.t
+	A  fileC.t
+	EOF
+	verify_expect
+'
+
+test_done
-- 
gitgitgadget

