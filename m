Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD88C33CB8
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1A9207E0
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW6w+qvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgAPQJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:09:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36217 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgAPQJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 11:09:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so4425340wma.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 08:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GifjSWWRlpFZpUFK+3j64IFt2acxdlcCjqeHrzQAx/w=;
        b=AW6w+qvjOSNQnMqwyIFsB35D1KNSK7luGAtVv7qUBubj8qjVSUbeSo54OLHIcBvT1A
         6F7uSbugix7FJXO5tR5gm2YkSvYxAuSQq03mp0B0IGeQhOQDenibPKcpiAth0UzXuvPb
         g00z4hKwq4mAmG4D5BEx7/HSjCq8Lcdq5NEjt3BcJXqWVMAThC1AyQodFzGIN/ons3s+
         ZHmEChtvuZ4ZzaGHx9+NWRDFBksIHgHhKoE71J7RFLjgcvIu0FRFcIW5Tr8k9DQQX/36
         aaItaa4H1U+bqcbHcK1BRJo1XWZ7QnN7lUyxUG32qBWKuETT/1YZ8Mda/tsKLne2+VdI
         S19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GifjSWWRlpFZpUFK+3j64IFt2acxdlcCjqeHrzQAx/w=;
        b=mvAHnkt0EhVlVIfdVNoFZKYqpIWjCB/MKovui5yMNg3GTY63H7+8o+LcARbEMJp8to
         ecE105R8rGzl5Hkf2gdGPqILprUhoBi2+nut98TQKBHm/f3SqOCdXjtSPqS8oTxjkFoH
         ZwpvwuGcgDHw92XklpIEtrIrUOMthWb4O94UCPwA9XQzsQVGlu0YiMbEgs+b60kubk8O
         DjaGIKrZjIWpKNJSNszTn4s0sWKNJQ6149+yLAMERvfr/kPg1Bg4xZnqm/IDsezvNCFU
         IRdVnDFxBOJgQ2iAtr8JyrltQyfhhH+wDOmMfIbulfHp1ajTsQ+v/GK+wDCbDKFIP2Tg
         I8Wg==
X-Gm-Message-State: APjAAAV/SNFDxL2TE08BNRF/9JaYoman0tbF4sUEhxXtzdyOtUKVdEwk
        kWr1tz27weZ/ZbRnAVV46Y5ECHqe
X-Google-Smtp-Source: APXvYqxbnj6cTuhrQ6QwHo1KuMGwMq/vdIwxINbEZSyd9N+S4H9ADRWwlpnwbzdm7h7WKhAwPcw4rg==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr146436wmg.16.1579190975385;
        Thu, 16 Jan 2020 08:09:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6sm31221123wrx.72.2020.01.16.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:09:34 -0800 (PST)
Message-Id: <721410233bbee49fa13773ae9c04b4c6ed076a1a.1579190965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.git.1579190965.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 16:09:25 +0000
Subject: [PATCH 8/8] stash push: support the --pathspec-from-file option
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
1) For now, `--pathspec-from-file` is declared incompatible with
   `--patch`, even when <file> is not `-`. Such use case is not
   really expected.
2) It is not allowed to pass pathspec in both args and file.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-stash.txt    |  16 +++++-
 builtin/stash.c                |  20 +++++++
 t/t3909-stash-pathspec-file.sh | 100 +++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100755 t/t3909-stash-pathspec-file.sh

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 576ad757d9..4e6a27c4fd 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git stash' branch <branchname> [<stash>]
 'git stash' [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
+	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]]
 'git stash' clear
 'git stash' create [<message>]
@@ -43,7 +44,7 @@ created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
 is also possible). Stashes may also be referenced by specifying just the
 stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 
-push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
+push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash entry' and roll them
 	back to HEAD (in the working tree and in the index).
@@ -185,6 +186,19 @@ OPTIONS
 The `--patch` option implies `--keep-index`.  You can use 
 `--no-keep-index` to override this.
 
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
 -q::
 --quiet::
 	Quiet, suppress feedback messages.
diff --git a/builtin/stash.c b/builtin/stash.c
index 7bc4c5d696..74d92595a2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -27,6 +27,7 @@ static const char * const git_stash_usage[] = {
 	N_("git stash clear"),
 	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
+	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
 	   "          [--] [<pathspec>...]]"),
 	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
@@ -1456,7 +1457,9 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	int patch_mode = 0;
 	int include_untracked = 0;
 	int quiet = 0;
+	int pathspec_file_nul = 0;
 	const char *stash_msg = NULL;
+	const char *pathspec_from_file = NULL;
 	struct pathspec ps;
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
@@ -1470,6 +1473,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			    N_("include ignore files"), 2),
 		OPT_STRING('m', "message", &stash_msg, N_("message"),
 			   N_("stash message")),
+		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		OPT_END()
 	};
 
@@ -1492,6 +1497,21 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 		       prefix, argv);
+
+	if (pathspec_from_file) {
+		if (patch_mode)
+			die(_("--pathspec-from-file is incompatible with --patch"));
+
+		if (ps.nr)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		parse_pathspec_file(&ps, 0,
+				    PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
+				    prefix, pathspec_from_file, pathspec_file_nul);
+	} else if (pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	}
+
 	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
 			     include_untracked);
 }
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
new file mode 100755
index 0000000000..55e050cfd4
--- /dev/null
+++ b/t/t3909-stash-pathspec-file.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+test_description='stash --pathspec-from-file'
+
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success setup '
+	>fileA.t &&
+	>fileB.t &&
+	>fileC.t &&
+	>fileD.t &&
+	git add fileA.t fileB.t fileC.t fileD.t &&
+	git commit -m "Files" &&
+
+	git tag checkpoint
+'
+
+restore_checkpoint () {
+	git reset --hard checkpoint
+}
+
+verify_expect () {
+	git stash show --name-status >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'simplest' '
+	restore_checkpoint &&
+
+	# More files are written to make sure that git didnt ignore
+	# --pathspec-from-file, stashing everything
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t &&
+
+	cat >expect <<-\EOF &&
+	M	fileA.t
+	EOF
+
+	echo fileA.t | git stash push --pathspec-from-file=- &&
+	verify_expect
+'
+
+test_expect_success '--pathspec-file-nul' '
+	restore_checkpoint &&
+
+	# More files are written to make sure that git didnt ignore
+	# --pathspec-from-file, stashing everything
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t &&
+
+	cat >expect <<-\EOF &&
+	M	fileA.t
+	M	fileB.t
+	EOF
+
+	printf "fileA.t\0fileB.t\0" | git stash push --pathspec-from-file=- --pathspec-file-nul &&
+	verify_expect
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	# More files are written to make sure that git didnt ignore
+	# --pathspec-from-file, stashing everything
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t &&
+
+	cat >expect <<-\EOF &&
+	M	fileB.t
+	M	fileC.t
+	EOF
+
+	printf "fileB.t\nfileC.t\n" | git stash push --pathspec-from-file=- &&
+	verify_expect
+'
+
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo A >fileA.t &&
+	echo fileA.t >list &&
+
+	test_must_fail git stash push --pathspec-from-file=list --patch 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+
+	test_must_fail git stash push --pathspec-from-file=list -- fileA.t 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git stash push --pathspec-file-nul 2>err &&
+	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
+'
+
+test_done
-- 
gitgitgadget
