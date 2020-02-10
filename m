Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E956C352A5
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DB62082F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxwCrRDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgBJOqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:46:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35250 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgBJOp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id w12so8094197wrt.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=41+0xiuPVBdRZf87IYlNRSAfTvcJMHEiw9Z8e0OIhVE=;
        b=PxwCrRDwBDfAOU1Jmt9sfV6m58mZc5ITX9H39Tb/8aB2FTvyoJbtceyFWZaIn5lusL
         S6U3wVlZsJqF3JKWPGZsSEpIJQsySODQMlAQQfsDpsVe7/00RkPKLxFKIVqao8BZ7UHA
         KVmr1XAvhT4u7m/+RpljEzh3jLC1GofZ5osbvIgyChrG+Yv1fiAIjqV+BXxOLtPJj5cE
         e2BQKzrdStlNG/ckd7+vYGsgEphjCp+VTLxm9NWsozoTJVuyuV1tM7pkLYXHT8npz9Cq
         53xa5ZeDFvzaww6ar61kth22d8f507E6i2nQG9kmKlYD5QubQP5cvvNbwFxGUTChK5+4
         V4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=41+0xiuPVBdRZf87IYlNRSAfTvcJMHEiw9Z8e0OIhVE=;
        b=QFkLib4+/kNj29dwTu4Sxk1W27bki+DkENS0ckoO1OBW+lmkX4bvtYjGZbbPmxdZ3a
         4Xj0AuFxW8l4oNzIc6V0Qp2S115jbHXJ/DJKTsb6TvdOE5us61FQMrbPmduMTBC7kSn6
         wVIZ7ApW3T/2028j1m/u1xa0z6Mqsc90hWGjIOYuzUBSHI8tR2JmUh4dGaTFQMylaBOP
         1bmK3ENjHLYMbB2xxerQc25Vz78JAZkwTzdYd6SQj0B+7AnxGJxWy8oyFR6jRyKDZ/FI
         blYGKI+4/YsnKsRxE+BpKowua//woSMdRmpHFDWhkf93Sn50SAOR8SNWFbtdA7W4OnU3
         /MNw==
X-Gm-Message-State: APjAAAXe836uV0pxUp0RILX0NFiHya+hpoP+jO2yA4hWOtla2G/eDH9H
        w5Yr2PDj2imeZxPWtmGzGsTfkUSM
X-Google-Smtp-Source: APXvYqwbgkSUZemhVgwsFHRsyQogr3kvpAuGR2hGxhRKWuI1M3H90sIEB+QCWnh8jiwq+OWIy7wnlw==
X-Received: by 2002:adf:ea85:: with SMTP id s5mr2325855wrm.75.1581345956232;
        Mon, 10 Feb 2020 06:45:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm823169wrp.58.2020.02.10.06.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:55 -0800 (PST)
Message-Id: <0c6f28dc68d4ca9190f57d8b9cb56e0592ee27ff.1581345948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:45:47 +0000
Subject: [PATCH v2 8/8] stash push: support the --pathspec-from-file option
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
 Documentation/git-stash.txt    |  20 ++++++-
 builtin/stash.c                |  20 +++++++
 t/t3909-stash-pathspec-file.sh | 100 +++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100755 t/t3909-stash-pathspec-file.sh

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 52e64985bd..79949f8617 100644
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
@@ -46,7 +47,7 @@ stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 COMMANDS
 --------
 
-push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
+push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash entry' and roll them
 	back to HEAD (in the working tree and in the index).
@@ -194,6 +195,23 @@ to learn how to operate the `--patch` mode.
 The `--patch` option implies `--keep-index`.  You can use 
 `--no-keep-index` to override this.
 
+--pathspec-from-file=<file>::
+	This option is only valid for `push` command.
++
+Pathspec is passed in `<file>` instead of commandline args. If
+`<file>` is exactly `-` then standard input is used. Pathspec
+elements are separated by LF or CR/LF. Pathspec elements can be
+quoted as explained for the configuration variable `core.quotePath`
+(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
+global `--literal-pathspecs`.
+
+--pathspec-file-nul::
+	This option is only valid for `push` command.
++
+Only meaningful with `--pathspec-from-file`. Pathspec elements are
+separated with NUL character and all other characters are taken
+literally (including newlines and quotes).
+
 -q::
 --quiet::
 	This option is only valid for `apply`, `drop`, `pop`, `push`,
diff --git a/builtin/stash.c b/builtin/stash.c
index ed84ff2e16..78af6ce564 100644
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
@@ -1459,7 +1460,9 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	int patch_mode = 0;
 	int include_untracked = 0;
 	int quiet = 0;
+	int pathspec_file_nul = 0;
 	const char *stash_msg = NULL;
+	const char *pathspec_from_file = NULL;
 	struct pathspec ps;
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
@@ -1473,6 +1476,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			    N_("include ignore files"), 2),
 		OPT_STRING('m', "message", &stash_msg, N_("message"),
 			   N_("stash message")),
+		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		OPT_END()
 	};
 
@@ -1495,6 +1500,21 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 
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
