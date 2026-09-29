Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6813B21FF23
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667753; cv=none; b=SvfbNErqJxCDhNQPlAKlBOxstFKUzVnOQfa2hXzJbaL5yeJSMCz0GvhDGMx2zCrqE2JFWBad9BvLNeRhzclt7VawAzJhjNOa9zEpjjEUM08SrXJVmQ2yeZBOlLgzqnUsmFJpNk+oKBQCPHrwmyLvj4PPEHh72vj37hMj5gIz7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667753; c=relaxed/simple;
	bh=J+cdYy2IL8SIeGBKzCRTTDRshBM9TQDIU1HqKUHlD18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InJzVUypIXnVVEFEAO6e+fbbmCv7k4S/xSNhb+vxNsZsa6C0s9M1tu/+jq5yyvVXVRMkQhNr2KEJalroSRYEassw6qb+lrawMX+WrS7/WUQSM1WvrENw9ffMXXOXca7nkw0TSOueMqy3bWTsMi8vlYkYrUtt7tEaK7wXohBtCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com; spf=pass smtp.mailfrom=kanamei.com; dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b=fJKGJaAp; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kanamei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b="fJKGJaAp"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso1940761a91.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kanamei-com.20251104.gappssmtp.com; s=20251104; t=1790667750; x=1791272550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fUhV40w+Et5wW7fiaD5RoCEKO7qyYUZfoSkI0uwyJQ=;
        b=fJKGJaApbLjvge6UKDRFBvS1KCLFEMliz3TpK3c0SZ2ZW5d7Jdjr09g9QygZ8U9Mpg
         q5KjPNPjr5Uuep85zyl18FvVVebOIn3ea3z4RE76ESGruR2Gb9ZjxcmTkMg/BKIKYSqK
         E9+dgacIRcEsZgivR+V9xEw9oVa3DhzKiit6kRh15AQeGb63NT8L8Fdh9ffin+Dume5N
         ev372nKhjgWNxO/hiPqvQ8y/GaoBr9lZlVmKVmYD7PhVSK4x+M17i/y0C/2BFJ9SNmEu
         UMr8RUDuIURuTiz4IWfmZYnRGW9GR5fEPbKJzNlmxWswM+ZIboJx95w2eY1FaUODRhOI
         hPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667750; x=1791272550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5fUhV40w+Et5wW7fiaD5RoCEKO7qyYUZfoSkI0uwyJQ=;
        b=zZk+jFuWS6K5EJTJZhbrR04p+Pa1Rr1X5iAUBnrcLnxxEy45Ptee7XRUyNibYRuR2w
         KR93Reegky4fgQi8ZbPt9/lKG0uoa+NuPlvDKkpUPeAumpl5GCzxsNXAj/yAOQZaiuns
         00vbPmwmYbLRHmVCn5oB6xj0xJ8YysUhkAr079Cg6ZKQKLVg20AuklAi0aw59Ic2+kya
         kdZoIgOvukcfanIm8l4EKZBjoZGdLFAOtjRZU16kWzKAQ7WRq+gmBIRVFWs6pZV2zysW
         qVDHTZPbtes44XawgQPK06/3QqIK2jcdM6+qCW75fNnlUTQNue5HvzMuFtXH35lOVnrB
         ZzYQ==
X-Gm-Message-State: AFq9FYJrRRiJ689jUI2DStLLUCzT7e+x/mxHLef8FIMX0OIBhYnl9IHC
	ydzFn4uC8aNJjZa6U8dHR1mUMBW9mdETiY6qHX3zNoMjH+twKkwgf1Ut67I7dEcgmL3hoKc89Ig
	I5GkHMjfUcw==
X-Gm-Gg: AYBFou1F+1L+rrnl2E2S/vrn7ZVu5EsRz5Y5KSNHxMyq3OOgGbxJLr0StlOtj+Npzec
	RAlqNFIXUDUSsx36qxIw6/3RPxrqZqSMOowRcvJQaZTCU+NaQsuprAftYuyelf8994ZNOQip9z8
	z2mNaFX8NPyMuxI6qLpn8mn68wJ07bPm+8085OFN8aFGBgFFTPNIT0dJIC8JOgSDgLuIvXF0Mgp
	eEMvCqG3vGTS4Gfa1Y+k/zPPAN/MW/kdnJ0KpYHR8JMRU3EHhvyeDO1DnaAhrXvSDVbN7Wiz3pA
	ZEWn7pvXVlluXsXJJF4bC7dORoLCxg3XOlS66epKWnMFs48sQ1eG4bu8Sz6SVt5equ9LOP+LhPR
	GfMkIsV8R0rZxPsRZOwxNIslFMmfjQ0kpYoQFqaGVTjNHUV4Yet2yxU22QujVrWie37RZXcgpvF
	b9wi30O9i/ETNkymQCSMI0SjIf6SGvbZAjUsCk4bE5xtrz4D05IEmUzgRH5WT4V3hKzkADDXm6E
	o8ftY6N8H34l2UL/Ew5ksxJ67Oagk2O9lhirG2gokHdzgQzrnNdBs42PIPitWf5CZ2vy9Q5xOiR
	Mpdy
X-Received: by 2002:a17:90b:540b:b0:3a0:4384:adf6 with SMTP id 98e67ed59e1d1-3a09855cfa2mr11885606a91.0.1790667750469;
        Tue, 29 Sep 2026 00:42:30 -0700 (PDT)
Received: from m4-mbp16-shigedan.flets-east.jp ([2400:4050:3c1:f500:3003:4562:d18:f28b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497e90180sm4240233a91.2.2026.09.29.00.42.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 00:42:29 -0700 (PDT)
From: Kazumasa Shigeta <kazumasa.shigeta@kanamei.com>
To: git@vger.kernel.org
Cc: Shabbir Bhojani <shabbir.r.bhojani@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] stash: expose untracked modes in create
Date: Tue, 29 Sep 2026 16:42:22 +0900
Message-ID: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git stash create` always passes zero for the include_untracked parameter
of do_create_stash(), even though that helper already supports untracked
and ignored files and stash push/save expose those modes as
-u/--include-untracked and -a/--all.

Teach create to accept the same options and pass the existing mode
through. Unlike push/save, create continues to only create objects: it
does not update refs/stash or modify the index or working tree.

When the selected mode finds no changes, do_create_stash() returns 1.
Translate that to success so create keeps its existing no-object, empty
output behavior.

Use normal parse-options semantics, so options may appear after message
arguments. A message that begins with a dash can be disambiguated with
--.

9ca6326dff29 (stash: refactor stash_create, 2017-02-19) added the
internal include-untracked path while intentionally leaving the user
interface for "git stash create" unchanged. Reuse that machinery and
the existing INCLUDE_ALL_FILES mode rather than adding a separate stash
creation path.

Add coverage for both short and long aliases, the untracked/ignored
boundary, option/message parsing, no-change behavior, and preservation
of refs/stash, the index, and the working tree.

Signed-off-by: Kazumasa Shigeta <kazumasa.shigeta@kanamei.com>
---
Related work:

I proposed adding both --include-untracked and --all to
"git stash create" in 2014:
  <1403856479-37421-1-git-send-email-shigeta@kanamei.co.jp>

I should also apologize for dropping that thread after receiving review.
I did not follow up on the comments at the time.  Thanks to those who
reviewed it then.

Separately, in 2017, Thomas Gummerer added an internal -u path while
refactoring stash_create in 9ca6326dff29 (stash: refactor stash_create).
That change explicitly kept the user interface of "git stash create"
unchanged.

When "stash create" was later converted to the builtin C implementation
in d4788af875cc (stash: convert create to builtin), the untracked-file
handling was carried into the new implementation and remains there today.

More recently, Shabbir Bhojani proposed exposing --include-untracked:
  <pull.1892.git.1774768580147.gitgitgadget@gmail.com>

This patch exposes both existing untracked modes, --include-untracked and
--all, to "git stash create".

 Documentation/git-stash.adoc | 18 ++++++----
 builtin/stash.c              | 36 ++++++++++++++-----
 t/t3903-stash.sh             | 70 ++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index fc6a9a0..32f0fd5 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -21,7 +21,7 @@ git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | -
 git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
            [-u | --include-untracked] [-a | --all] [<message>]
 git stash clear
-git stash create [<message>]
+git stash create [-u | --include-untracked] [-a | --all] [<message>]
 git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
 git stash export (--print | --to-ref <ref>) [<stash>...]
 git stash import <commit>
@@ -138,10 +138,12 @@ with no conflicts.
 `drop [-q | --quiet] [<stash>]`::
 	Remove a single stash entry from the list of stash entries.
 
-`create`::
+`create [-u | --include-untracked] [-a | --all]`::
 	Create a stash entry (which is a regular commit object) and
 	return its object name, without storing it anywhere in the ref
-	namespace.
+	namespace.  The `--include-untracked` option includes untracked
+	files, while `--all` also includes ignored files, without modifying
+	the working tree.
 	This is intended to be useful for scripts.  It is probably not
 	the command you want to use; see "push" above.
 
@@ -167,10 +169,11 @@ OPTIONS
 -------
 `-a`::
 `--all`::
-	This option is only valid for `push` and `save` commands.
+	When used with the `push` and `save` commands, all ignored and
+	untracked files are also stashed and then cleaned up with `git clean`.
 +
-All ignored and untracked files are also stashed and then cleaned
-up with `git clean`.
+When used with the `create` command, ignored and untracked files are included
+in the stash entry without modifying the working tree.
 
 `-u`::
 `--include-untracked`::
@@ -179,6 +182,9 @@ up with `git clean`.
 	all untracked files are also stashed and then cleaned up with
 	`git clean`.
 +
+When used with the `create` command, untracked files are included in the
+stash entry without modifying the working tree.
++
 When used with the `show` command, show the untracked files in the stash
 entry as part of the diff.
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 7a98434..57a4750 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -59,7 +59,7 @@
 	N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
 	   "          [-u | --include-untracked] [-a | --all] [<message>]")
 #define BUILTIN_STASH_CREATE_USAGE \
-	N_("git stash create [<message>]")
+	N_("git stash create [-u | --include-untracked] [-a | --all] [<message>]")
 #define BUILTIN_STASH_EXPORT_USAGE \
 	N_("git stash export (--print | --to-ref <ref>) [<stash>...]")
 #define BUILTIN_STASH_IMPORT_USAGE \
@@ -119,6 +119,11 @@ static const char * const git_stash_clear_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_create_usage[] = {
+	BUILTIN_STASH_CREATE_USAGE,
+	NULL
+};
+
 static const char * const git_stash_store_usage[] = {
 	BUILTIN_STASH_STORE_USAGE,
 	NULL
@@ -1643,26 +1648,39 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	return ret;
 }
 
-static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
+static int create_stash(int argc, const char **argv, const char *prefix,
 			struct repository *repo UNUSED)
 {
-	int ret;
+	int ret = 0;
+	int include_untracked = 0;
+	struct option options[] = {
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			 N_("include untracked files in stash")),
+		OPT_SET_INT('a', "all", &include_untracked,
+			    N_("include ignored files in stash"),
+			    INCLUDE_ALL_FILES),
+		OPT_END()
+	};
 	struct strbuf stash_msg_buf = STRBUF_INIT;
 	struct stash_info info = STASH_INFO_INIT;
 	struct pathspec ps;
 
-	/* Starting with argv[1], since argv[0] is "create" */
-	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_create_usage, 0);
+	strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	if (!check_changes_tracked_files(&ps))
-		return 0;
+	if (!include_untracked && !check_changes_tracked_files(&ps))
+		goto done;
 
-	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
-			      NULL, 0);
+	ret = do_create_stash(&ps, &stash_msg_buf, include_untracked, 0, NULL,
+			      0, &info, NULL, 0);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
+	else if (ret == 1)
+		ret = 0;
 
+done:
 	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
 	return ret;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7211586..fe34879 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -640,6 +640,76 @@ test_expect_success 'stash create - no changes' '
 	test_must_be_empty actual
 '
 
+# --all observes every untracked and ignored path in the worktree.  Use one
+# isolated repository for these checks so unrelated test state is not captured.
+test_expect_success 'stash create with untracked options' '
+	test_when_finished "rm -rf stash-create-options" &&
+	test_create_repo stash-create-options &&
+	(
+		cd stash-create-options &&
+		test_commit base tracked base &&
+		echo create-ignored >.gitignore &&
+		git add .gitignore &&
+		git commit -m ignore &&
+
+		git stash create -u >.git/actual &&
+		test_must_be_empty .git/actual &&
+		git stash create -a >.git/actual &&
+		test_must_be_empty .git/actual &&
+
+		echo untracked >create-untracked &&
+		git stash create "without untracked" >.git/actual &&
+		test_must_be_empty .git/actual &&
+		short=$(git stash create "create untracked" -u) &&
+		long=$(git stash create --include-untracked "create untracked") &&
+		test_cmp_rev "$short^3^{tree}" "$long^3^{tree}" &&
+		echo untracked >.git/expect &&
+		git show "$short^3:create-untracked" >.git/actual &&
+		test_cmp .git/expect .git/actual &&
+		branch=$(git symbolic-ref --short HEAD) &&
+		echo "On $branch: create untracked" >.git/expect &&
+		git show --pretty=%s -s "$short" >.git/actual &&
+		test_cmp .git/expect .git/actual &&
+		test_path_is_file create-untracked &&
+
+		echo ignored >create-ignored &&
+		with_untracked=$(git stash create -u "create options") &&
+		test_must_fail git cat-file -e "$with_untracked^3:create-ignored" &&
+		short=$(git stash create "create options" -a) &&
+		long=$(git stash create --all "create options") &&
+		test_cmp_rev "$short^3^{tree}" "$long^3^{tree}" &&
+		echo ignored >.git/expect &&
+		git show "$short^3:create-ignored" >.git/actual &&
+		test_cmp .git/expect .git/actual &&
+		test_path_is_file create-untracked &&
+		test_path_is_file create-ignored &&
+
+		echo staged >staged &&
+		git add staged &&
+		echo modified >>tracked &&
+		git diff >.git/before-worktree &&
+		git diff --cached >.git/before-index &&
+		git status --porcelain=v1 --ignored >.git/before-status &&
+		test_must_fail git rev-parse --verify refs/stash >/dev/null 2>&1 &&
+		STASH_ID=$(git stash create -a -- -create-message) &&
+		git diff >.git/after-worktree &&
+		git diff --cached >.git/after-index &&
+		git status --porcelain=v1 --ignored >.git/after-status &&
+		test_cmp .git/before-worktree .git/after-worktree &&
+		test_cmp .git/before-index .git/after-index &&
+		test_cmp .git/before-status .git/after-status &&
+		test_must_fail git rev-parse --verify refs/stash >/dev/null 2>&1 &&
+		echo "On $branch: -create-message" >.git/expect &&
+		git show --pretty=%s -s "$STASH_ID" >.git/actual &&
+		test_cmp .git/expect .git/actual
+	)
+'
+
+test_expect_success 'stash create rejects unknown options' '
+	test_expect_code 129 git stash create --unknown-option 2>err &&
+	test_grep "unknown option" err
+'
+
 test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
-- 
2.47.3

