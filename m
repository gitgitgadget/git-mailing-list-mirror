Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68797C43215
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329DC20684
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2DPvFSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfLCOCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41717 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfLCOC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so3786190wrj.8
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=65y5REQOnztt7F0mA7wPZUa0Ym+EPup2v6lwxwt+TmU=;
        b=u2DPvFSzplWQQ5epmwyLhF2lgSd09Z5qgrG5/Yp8mPLgFPJW/kawggitfXBYtVJaT9
         SFbaedMqMsFK+KEVNkppjWJV/QU9gnKN4vo7ds/nJ6j4JTyCgWe4QQDb/OcBHWpfeDB5
         Q3WlS3O/phzuVERM+bcEd9dXoJ1gDsMacvTpy/F44QQ0CPjphRONrojGgdLTspIBwDYq
         Cs/RgMqYKiZoM8OoNw7nhVBQzN7CBsJt/8bvsZp7xqglnlFzvo8J+y1vi9/NuAfnzCGi
         zaaKQW/p+Y3csw9X0OBS+BnNsfY84C5xvtK4F097HI2a3bqUykS/GLGaVtIDw/L1/RWK
         BUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=65y5REQOnztt7F0mA7wPZUa0Ym+EPup2v6lwxwt+TmU=;
        b=MZPHZaj53BBZjZNu2sktkzr68HsLBZnOphXEhmwFQZySvtE5r7HCmmJCOB/MtM4HZ+
         UAqLqClLrAEkOPCWaG6aE9iQmIWRPKEz9NMDn6risCGzTrSh3tc7jaf21opdZHya+7LJ
         9qVFOOzme8+uaXpwlk3658bDtGolxtEmi75kkRHTWFb9TtF3zVqrJdZ1g8yjY/tnP7rc
         k78DW9sO4pPsSF8lc++o/xnaexh2X34je0Jw02hPvkE3Ji1x0UzmzT1R0YGQqdxQnR5A
         Nmc/aML79ambAb6HfEIxXThjObQsfEqkO0dZNSz7qYA6wIZP16CystggUC9QvIbQCavl
         mZnA==
X-Gm-Message-State: APjAAAU/Om3tO5oX7Xjq8vZhHzU5UUmguAFVQmNVxk2HBl1DMdphyPVQ
        0bPE+x8uyX03I3aZs5znLK5eYP1D
X-Google-Smtp-Source: APXvYqyRhRdjxZCKEGHqja+/2Tcwxy+EE5yieN3bwo0eaJZmhlJAGi5geQ1kll1u2JUNXdsUQYO9DQ==
X-Received: by 2002:a05:6000:1044:: with SMTP id c4mr5539236wrx.204.1575381746923;
        Tue, 03 Dec 2019 06:02:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u69sm3324018wmu.39.2019.12.03.06.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:26 -0800 (PST)
Message-Id: <9a62da3470b34b490717699ce40a7c73984d1cea.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:13 +0000
Subject: [PATCH v4 08/13] add: support the --pathspec-from-file option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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
 Documentation/git-add.txt    |  16 ++++-
 builtin/add.c                |  30 +++++++--
 t/t3704-add-pathspec-file.sh | 127 +++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 5 deletions(-)
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
index 4fabdc72e6..9f6b263aba 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -28,6 +28,8 @@ static const char * const builtin_add_usage[] = {
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
 static int add_renormalize;
+static int pathspec_file_nul;
+static const char *pathspec_from_file;
 
 struct update_callback_data {
 	int flags;
@@ -309,6 +311,8 @@ static struct option builtin_add_options[] = {
 		   N_("override the executable bit of the listed files")),
 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
 			N_("warn when adding an embedded repository")),
+	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 	OPT_END(),
 };
 
@@ -402,11 +406,17 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
 
@@ -439,13 +449,25 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
index 0000000000..3cfdb669b7
--- /dev/null
+++ b/t/t3704-add-pathspec-file.sh
@@ -0,0 +1,127 @@
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
+test_expect_success '--pathspec-from-file from stdin' '
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
+test_expect_success '--pathspec-from-file from file' '
+	restore_checkpoint &&
+
+	echo fileA.t >list &&
+	git add --pathspec-from-file=list &&
+
+	cat >expect <<-\EOF &&
+	A  fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'NUL delimiters' '
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
+test_expect_success 'LF delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\nfileB.t\n" | git add --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	A  fileA.t
+	A  fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'no trailing delimiter' '
+	restore_checkpoint &&
+
+	printf "fileA.t\nfileB.t" | git add --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	A  fileA.t
+	A  fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'CRLF delimiters' '
+	restore_checkpoint &&
+
+	printf "fileA.t\r\nfileB.t\r\n" | git add --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	A  fileA.t
+	A  fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'quotes' '
+	restore_checkpoint &&
+
+	printf "\"file\\101.t\"" | git add --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	A  fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'quotes not compatible with --pathspec-file-nul' '
+	restore_checkpoint &&
+
+	printf "\"file\\101.t\"" >list &&
+	test_must_fail git add --pathspec-from-file=list --pathspec-file-nul
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

