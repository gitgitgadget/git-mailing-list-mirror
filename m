Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4476A1FAF5
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbdBCCtl (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:41 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36383 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbdBCCtj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:39 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so1169202wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pLDt0qThe692oPsrmLzM5Gz9jj/f3HfXZ4AdkDzsF8=;
        b=q90GVKz8/QOJJkwjXYGMhlh2Lx92uq18s5TSJSz2N8b+ciVh3Vv3CW5EpTj/sGV2BO
         seFiN6phMpD0TMffv82dBcuZmyrSdWF9nP5AksK3j5T8JlgGunaDUCvOpPE8v+5OQM6t
         u1dK5Dy/cC5IDdlTFqAonOGKI9qD6uu/v9vqt3k+EbfutctpYT+ov4v5pzFBWODW5Do7
         BoqyxDrcaUSiGBjiU0hNPfvdpjpxxgvc9SGz90/uQBkk7Z45TrVG7JbsfNvat7dpclFS
         DEhka4EhNeK/N1wJKqzoJMYfaxg/D3VlmJ56szWLKLc4nKf3twLThsprMzM5kI6FBWws
         ks0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pLDt0qThe692oPsrmLzM5Gz9jj/f3HfXZ4AdkDzsF8=;
        b=avWf7EwqZCt+HXQEhRFAx/ZV1S0/xUh+gM54Jt6m6RVoq4ogyl4CIteYgYpMGBxoyw
         wkWASccnGPpBLDE1cgapnJVrvAylN47XkN6NxN09nE+c51oleX7ZLYEXnJ3Ii2aYeEkn
         W0aERAfKVlYmlY42W1ClZ8dho4xoxm0h32ex98yjTzZ8I1AkcilIjXgvt2wfs4tskmf2
         NT0c2zk8QCmwpy1u6SOxwZ0YnC+S8d39RFSUjuqBUMrzPOie/xFka/MCqEG5dVMk0HKF
         K9DtPs4BLhFSMoDv2yucIXHZQrOBxTy2yveJwIlXRw7w/uX1atbWUrMrpAffNZ+vIw9Y
         F64w==
X-Gm-Message-State: AIkVDXJRa0Dm3TMLkVaj5ryk92Vw21lSaICO2xSDGzyLyyy+Zl6ryFPhrxXt+OCq6y+yEQ==
X-Received: by 10.223.136.85 with SMTP id e21mr9947112wre.28.1486090167430;
        Thu, 02 Feb 2017 18:49:27 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:26 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 15/21] rev-parse: add '--absolute-git-dir' option
Date:   Fri,  3 Feb 2017 03:48:23 +0100
Message-Id: <20170203024829.8071-16-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The output of 'git rev-parse --git-dir' can be either a relative or an
absolute path, depending on whether the current working directory is
at the top of the worktree or the .git directory or not, or how the
path to the repository is specified via the '--git-dir=<path>' option
or the $GIT_DIR environment variable.  And if that output is a
relative path, then it is relative to the directory where any 'git
-C <path>' options might have led us.

This doesn't matter at all for regular scripts, because the git
wrapper automatically takes care of changing directories according to
the '-C <path>' options, and the scripts can then simply follow any
path returned by 'git rev-parse --git-dir', even if it's a relative
path.

Our Bash completion script, however, is unique in that it must run
directly in the user's interactive shell environment.  This means that
it's not executed through the git wrapper and would have to take care
of any '-C <path> options on its own, and it can't just change
directories as it pleases.  Consequently, adding support for taking
any '-C <path>' options on the command line into account during
completion turned out to be considerably more difficult, error prone
and required more subshells and git processes when it had to cope with
a relative path to the .git directory.

Help this rather special use case and teach 'git rev-parse' a new
'--absolute-git-dir' option which always outputs a canonicalized
absolute path to the .git directory, regardless of whether the path is
discovered automatically or is specified via $GIT_DIR or 'git
--git-dir=<path>'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git-rev-parse.txt |  4 ++++
 builtin/rev-parse.c             | 26 ++++++++++++++++++--------
 t/t1500-rev-parse.sh            | 17 +++++++++--------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 7241e9689..91c02b8c8 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -217,6 +217,10 @@ If `$GIT_DIR` is not defined and the current directory
 is not detected to lie in a Git repository or work tree
 print a message to stderr and exit with nonzero status.
 
+--absolute-git-dir::
+	Like `--git-dir`, but its output is always the canonicalized
+	absolute path.
+
 --git-common-dir::
 	Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ff13e59e1..1967bafba 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -802,17 +802,27 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				putchar('\n');
 				continue;
 			}
-			if (!strcmp(arg, "--git-dir")) {
+			if (!strcmp(arg, "--git-dir") ||
+			    !strcmp(arg, "--absolute-git-dir")) {
 				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 				char *cwd;
 				int len;
-				if (gitdir) {
-					puts(gitdir);
-					continue;
-				}
-				if (!prefix) {
-					puts(".git");
-					continue;
+				if (arg[2] == 'g') {	/* --git-dir */
+					if (gitdir) {
+						puts(gitdir);
+						continue;
+					}
+					if (!prefix) {
+						puts(".git");
+						continue;
+					}
+				} else {		/* --absolute-git-dir */
+					if (!gitdir && !prefix)
+						gitdir = ".git";
+					if (gitdir) {
+						puts(real_path(gitdir));
+						continue;
+					}
 				}
 				cwd = xgetcwd();
 				len = strlen(cwd);
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 038e24c40..8b62ed85b 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -3,7 +3,7 @@
 test_description='test git rev-parse'
 . ./test-lib.sh
 
-# usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir
+# usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir absolute-git-dir
 test_rev_parse () {
 	d=
 	bare=
@@ -29,7 +29,8 @@ test_rev_parse () {
 		 --is-inside-git-dir \
 		 --is-inside-work-tree \
 		 --show-prefix \
-		 --git-dir
+		 --git-dir \
+		 --absolute-git-dir
 	do
 		test $# -eq 0 && break
 		expect="$1"
@@ -62,26 +63,26 @@ test_expect_success 'setup' '
 	cp -R .git repo.git
 '
 
-test_rev_parse toplevel false false true '' .git
+test_rev_parse toplevel false false true '' .git "$ROOT/.git"
 
-test_rev_parse -C .git .git/ false true false '' .
-test_rev_parse -C .git/objects .git/objects/ false true false '' "$ROOT/.git"
+test_rev_parse -C .git .git/ false true false '' . "$ROOT/.git"
+test_rev_parse -C .git/objects .git/objects/ false true false '' "$ROOT/.git" "$ROOT/.git"
 
-test_rev_parse -C sub/dir subdirectory false false true sub/dir/ "$ROOT/.git"
+test_rev_parse -C sub/dir subdirectory false false true sub/dir/ "$ROOT/.git" "$ROOT/.git"
 
 test_rev_parse -b t 'core.bare = true' true false false
 
 test_rev_parse -b u 'core.bare undefined' false false true
 
 
-test_rev_parse -C work -g ../.git -b f 'GIT_DIR=../.git, core.bare = false' false false true ''
+test_rev_parse -C work -g ../.git -b f 'GIT_DIR=../.git, core.bare = false' false false true '' "../.git" "$ROOT/.git"
 
 test_rev_parse -C work -g ../.git -b t 'GIT_DIR=../.git, core.bare = true' true false false ''
 
 test_rev_parse -C work -g ../.git -b u 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
 
-test_rev_parse -C work -g ../repo.git -b f 'GIT_DIR=../repo.git, core.bare = false' false false true ''
+test_rev_parse -C work -g ../repo.git -b f 'GIT_DIR=../repo.git, core.bare = false' false false true '' "../repo.git" "$ROOT/repo.git"
 
 test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=../repo.git, core.bare = true' true false false ''
 
-- 
2.11.0.555.g967c1bcb3

