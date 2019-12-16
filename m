Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D3C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A48720725
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faas1IkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfLPPsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53762 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfLPPsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id m24so5872960wmc.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BbmTKXfYbxk0jVu3XfFKXCJJJhcswMTc8YPxtcV/Yzw=;
        b=faas1IkWcSN6pT3z4XJ0+q7fgP0wKOTubwFCkHnP1bs75SxVgU9y5mUvyUsCjbOkTb
         a0ak9OILyNkjcbY9icCsLdcF8zKc5gdrIFWqTnVfR9SHZiSK2nOGLmNasmnma0pb4rvT
         BP9r92sAm6u1O/DDw92LASlelsq9C2iCkD3eHsLYJu1ReXf/H3LUrXT3i9ak6nhOXm3m
         IAQihIiScZfhY0z586DhYgn4BvO6vJptjrA81iu8xnXWYwMqgUiNrjU7o9comB3KsQTH
         vAa8XO1nR5ZGOdKd8cwG0yHxaIPs7hJ0eINp76vWT+RiXroYSTP/rOWlguwoHfsWg22B
         b0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BbmTKXfYbxk0jVu3XfFKXCJJJhcswMTc8YPxtcV/Yzw=;
        b=AuZjnOhlug53EiNAEUMnCFVvhnFRXVELmj/sbA9X6jAW6fTsSKETAcAiQWYLxfTC2B
         Ea/zFmXgK607pIvmmUsKEkcZQTYhcJDQyNF4czNK2uEvW45C7SZhb4lVr/YJV5UKZyT4
         NaMRj9nhwnOa5ZSXIL9SP2y9pjhLpRd6HF+7utuIUQyfhLq4u1VTIPP7jdI1R/fxu0uj
         lLTfyWVZf4DGuxLjfP/k+bNhMIX3v5XwJzDs4NiHVoLi9ScgoFfrz7tDY7qGm8ngAMdZ
         7wat/ibxyzENabkMKFHGfi7Ht1mx28pfOsCeMiJz6zahhHTub1GfPP958dT/hDJ3i1rm
         +CWg==
X-Gm-Message-State: APjAAAXRVNTWAsKV2xfr5ea60cd5kzJrwUuzKnnxvzNf53rQ93r0vU/w
        a5O52myj7E/05rYN1Msg+fVnPYJw
X-Google-Smtp-Source: APXvYqyyFV73ZZRAHLtZcUxy51jAq22s66rHMzodk4690doFD3x6L5895CyMsb1uK3wLAEgqO4i8WQ==
X-Received: by 2002:a1c:486:: with SMTP id 128mr32015905wme.163.1576511292347;
        Mon, 16 Dec 2019 07:48:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s16sm22113852wrn.78.2019.12.16.07.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:11 -0800 (PST)
Message-Id: <1ea5f1784774e19987a08a6b5214000681b34ae1.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:54 +0000
Subject: [PATCH v2 06/18] add: support the --pathspec-from-file option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
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
 Documentation/git-add.txt    | 16 ++++++-
 builtin/add.c                | 30 +++++++++++--
 t/t3704-add-pathspec-file.sh | 86 ++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 5 deletions(-)
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
index 0000000000..d3a8947dc1
--- /dev/null
+++ b/t/t3704-add-pathspec-file.sh
@@ -0,0 +1,86 @@
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
+test_expect_success '--pathspec-file-nul' '
+	restore_checkpoint &&
+
+	printf "fileA.t\0fileB.t\0" | git add --pathspec-from-file=- --pathspec-file-nul &&
+
+	cat >expect <<-\EOF &&
+	A  fileA.t
+	A  fileB.t
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
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+	>empty_list &&
+
+	test_must_fail git add --pathspec-from-file=- --interactive <list 2>err &&
+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
+
+	test_must_fail git add --pathspec-from-file=- --patch <list 2>err &&
+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
+
+	test_must_fail git add --pathspec-from-file=- --edit <list 2>err &&
+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-edit" err &&
+
+	test_must_fail git add --pathspec-from-file=- -- fileA.t <list 2>err &&
+	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git add --pathspec-file-nul 2>err &&
+	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err &&
+	
+	# This case succeeds, but still prints to stderr
+	git add --pathspec-from-file=- <empty_list 2>err &&
+	test_i18ngrep "Nothing specified, nothing added." err
+'
+
+test_done
-- 
gitgitgadget

