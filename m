Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BE9C432C3
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4227F20684
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5+By/TT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLCOCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41707 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfLCOC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so3785928wrj.8
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+buHZ51n44LNLRAp/5N82/ndSWJeE5B71CXkIfxwgzQ=;
        b=m5+By/TTlbI2ifcG4r2PIPA5GLbVUUYOpHO/t93BKJsG+aKf7VW6S2n5HPJRuNxXSL
         6hVW9IvE7Rc/Y+LrqO51wyfv53gvW1j0sx02ixwvkY640Aol/Y/xgWQO2fnxAABhFpQT
         ZTIk80035y9Ydq93xtr84OHRdzKpEOIBWrbELpEXWLA/a/9POLvNEeHyr4UhzC/+ve1n
         ViCPMdOp2Z/Do5OXP4sKdbKkU3Biz5YEB6JCapMoUc9k+rIu2PnBmnZkFSCu4Q6WsMbq
         7fg6kS4AxfbJXLComm8/pvzEHGjW75xlOl4ARBwh19D7cIuFlEh208BzUZRLCmfimldB
         VLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+buHZ51n44LNLRAp/5N82/ndSWJeE5B71CXkIfxwgzQ=;
        b=HthgKy4SHVX+2WvGsG3LIP0luGy0YRLAgnHhVWFyvmmjirnInmKsxPzQB53kYox+kV
         FJ792nlIbKF/8bUOXMf8I78XqCydv4BcwL68dNeXA9zOaQtqTHMwtfAz9piqQt2z8OQV
         GBw+51UuxGh4Vse4CpcH2J5NOkCyHJAUXY7apqMP/lpiIU9k/rQ1D8g8uUJ2sFFh3Y7z
         gUgnJQMhEJGZ0Z6xHCuWWKdjvwBnq3Lqk1D0fWd0Ty6QF9klCq74o8WXtqLxr3ZIPaxx
         +a581LtcW+7f3raJxroa2wvOd6pqdyMcqtISsJ5j95Kd/Ob96pUyorpsIAkvsDeX8zzr
         EKdQ==
X-Gm-Message-State: APjAAAU+mSf7M2llieaX/PmOBTFs+a3pn3d6/QVV5YGzOwmb4JgMriR+
        +vl4a6NMnHJvLDlsF3tTkVcJxVQ9
X-Google-Smtp-Source: APXvYqxNfujSpARpldejATBQRPaMqYhia098AD5ya3y5aBpD0bwqzk71ytuyxKCWNKH2sW1dHy1HLg==
X-Received: by 2002:adf:8150:: with SMTP id 74mr5629369wrm.114.1575381743708;
        Tue, 03 Dec 2019 06:02:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i127sm3261454wma.35.2019.12.03.06.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:23 -0800 (PST)
Message-Id: <cea470fc91bb3af9169cea9e1ec7a705ffb93e76.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:09 +0000
Subject: [PATCH v4 04/13] reset: support the `--pathspec-from-file` option
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
   `--patch`, even when <file> is not `stdin`. Such use case it not
   really expected. Also, it is harder to support in `git commit`, so
   I decided to make it incompatible in all places.
2) It is not allowed to pass pathspec in both args and file.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-reset.txt    |  21 ++++-
 builtin/reset.c                |  21 ++++-
 t/t7107-reset-pathspec-file.sh | 155 +++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+), 5 deletions(-)
 create mode 100755 t/t7107-reset-pathspec-file.sh

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index d517a43e73..932080c55d 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -9,18 +9,20 @@ SYNOPSIS
 --------
 [verse]
 'git reset' [-q] [<tree-ish>] [--] <pathspec>...
+'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
 'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
 'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
-In the first and second form, copy entries from `<tree-ish>` to the index.
-In the third form, set the current branch head (`HEAD`) to `<commit>`,
+In the first three forms, copy entries from `<tree-ish>` to the index.
+In the last form, set the current branch head (`HEAD`) to `<commit>`,
 optionally modifying index and working tree to match.
 The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
 
 'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
-	This form resets the index entries for all paths that match the
+'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]::
+	These forms reset the index entries for all paths that match the
 	`<pathspec>` to their state at `<tree-ish>`.  (It does not affect
 	the working tree or the current branch.)
 +
@@ -101,6 +103,19 @@ OPTIONS
 	`reset.quiet` config option. `--quiet` and `--no-quiet` will
 	override the default behavior.
 
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
 	Do not interpret any more arguments as options.
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 9291c0fd72..246bf9d737 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -31,6 +31,7 @@
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
 	N_("git reset [-q] [<tree-ish>] [--] <pathspec>..."),
+	N_("git reset [-q] [--pathspec-from-file [--pathspec-file-nul]] [<tree-ish>]"),
 	N_("git reset --patch [<tree-ish>] [--] [<pathspec>...]"),
 	NULL
 };
@@ -284,8 +285,8 @@ static int git_reset_config(const char *var, const char *value, void *cb)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int patch_mode = 0, unborn;
-	const char *rev;
+	int patch_mode = 0, pathspec_file_nul = 0, unborn;
+	const char *rev, *pathspec_from_file = NULL;
 	struct object_id oid;
 	struct pathspec pathspec;
 	int intent_to_add = 0;
@@ -306,6 +307,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
+		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		OPT_END()
 	};
 
@@ -316,6 +319,20 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
+	if (pathspec_from_file) {
+		if (patch_mode)
+			die(_("--pathspec-from-file is incompatible with --patch"));
+
+		if (pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		parse_pathspec_file(&pathspec, 0,
+				    PATHSPEC_PREFER_FULL,
+				    prefix, pathspec_from_file, pathspec_file_nul);
+	} else if (pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	}
+
 	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
new file mode 100755
index 0000000000..6b1a731fff
--- /dev/null
+++ b/t/t7107-reset-pathspec-file.sh
@@ -0,0 +1,155 @@
+#!/bin/sh
+
+test_description='reset --pathspec-from-file'
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
+	git add . &&
+	git commit --include . -m "Commit" &&
+	git tag checkpoint
+'
+
+restore_checkpoint () {
+	git reset --hard checkpoint
+}
+
+verify_expect () {
+	git status --porcelain -- fileA.t fileB.t fileC.t fileD.t >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success '--pathspec-from-file from stdin' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	echo fileA.t | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success '--pathspec-from-file from file' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	echo fileA.t >list &&
+	git reset --pathspec-from-file=list &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'NUL delimiters' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t &&
+	printf "fileA.t\0fileB.t\0" | git reset --pathspec-from-file=- --pathspec-file-nul &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	 D fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'LF delimiters' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t &&
+	printf "fileA.t\nfileB.t\n" | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	 D fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'no trailing delimiter' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t &&
+	printf "fileA.t\nfileB.t" | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	 D fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'CRLF delimiters' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t &&
+	printf "fileA.t\r\nfileB.t\r\n" | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	 D fileB.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'quotes' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	printf "\"file\\101.t\"" | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	EOF
+	verify_expect
+'
+
+test_expect_success 'quotes not compatible with --pathspec-file-nul' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	printf "\"file\\101.t\"" >list &&
+	# Note: "git reset" has not yet learned to fail on wrong pathspecs
+	git reset --pathspec-from-file=list --pathspec-file-nul &&
+
+	cat >expect <<-\EOF &&
+	 D fileA.t
+	EOF
+	test_must_fail verify_expect
+'
+
+test_expect_success '--pathspec-from-file is not compatible with --soft or --hard' '
+	restore_checkpoint &&
+
+	git rm fileA.t &&
+	echo fileA.t >list &&
+	test_must_fail git reset --soft --pathspec-from-file=list &&
+	test_must_fail git reset --hard --pathspec-from-file=list
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	git rm fileA.t fileB.t fileC.t fileD.t &&
+	printf "fileB.t\nfileC.t\n" | git reset --pathspec-from-file=- &&
+
+	cat >expect <<-\EOF &&
+	D  fileA.t
+	 D fileB.t
+	 D fileC.t
+	D  fileD.t
+	EOF
+	verify_expect
+'
+
+test_done
-- 
gitgitgadget

