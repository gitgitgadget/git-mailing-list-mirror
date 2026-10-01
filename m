Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E11B2EF2
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828525; cv=none; b=O5kSDSz1hmvl5xs81nA7LeBRf7MJa3KUA/BXAmP123BeXiw2ieMQbKKDOUYlvZeW1ZscE7Ab/pOPMrM78Q+WmXgjWPgSrfRuqbDVLsr3aFv3FOLEkk2lQJvNeGl74XiZl11ykCivepOlcGxGmInvBZukFcnhuHLo/617htBU/Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828525; c=relaxed/simple;
	bh=v7fvfiwe6MsX/b9ufy4iPy7RdYnpWT6A3QBc+wRLzo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7rHlvCFx82Bf6XMO9ApVV5mYb7gzb/N5RxCu8yLlJijboO9ayXWDygMALdYibr/B7U6tSbbg5k19oSwT8muND9MGvnWVvh8pAorIZeUDYwzrDmhuNyT3Uavq/CCeeDmIIu0nDsb6SkSAhucDVj5LDDTc+q0k5NAImmxl8f3L2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com; spf=pass smtp.mailfrom=kanamei.com; dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b=FoVW2U7r; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kanamei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b="FoVW2U7r"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so3633594a91.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kanamei-com.20251104.gappssmtp.com; s=20251104; t=1790828522; x=1791433322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4CWr5kBW70ipeB9x711gxu3GklUO0G1iG5FahCySmmA=;
        b=FoVW2U7r+0bcqImAGzxHnrcBfcubCQ+8Qz7zYFHaiGn/tkJ4aUhFxot5Y7MR4vWt1W
         d1ksyQxU6EI9ePNOKt3h3My5UH7pUSCsIhD+mQhHmhdVRHxm83OwtnAyefQle44bXm8l
         Kfw6jM9l3hdpeoV4wd6TSD/sb8NnKk1qSmzvKGPppF/ulGGP+mczbxDT5hGcXyAJU7IS
         vVOIuwUO9m2jCVgWK7hlCtu6Ji609bKU5jMBf0N1nDR/yMMViAKMbLvlKu+p7TSTcwe8
         jEPSMK+vIBjuIh6vLexc5dlPCLNLNJbp3hVoWniwHm0wS9VQpU+F68Uyqtp4v5e5CJvS
         BTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790828522; x=1791433322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4CWr5kBW70ipeB9x711gxu3GklUO0G1iG5FahCySmmA=;
        b=X/9i29099kKCLKOFXfyj6Q8m41sZ6dtIQst3aOLSHEWcViJGKM2O5Y43HZ5OGVfpBu
         2RRLHcO/MBg7YjoBh2wqNcNeIYEd57UD52JoENGNLzx6fJ/iUjucFsAp2dTjB0rTk3WV
         MtnQSnCzdwTQXeGzRG2HZYKo1/X4qDV3THiL+TRo5QmrPs9u9xFUJXcCTfW7e8p8CPv9
         OPO5oUmyqJHsiQAVPxolV90oUv4aC4Mi0JEuhyYjs+asPmRo0PZddqd79B6IlghnwjgS
         sSXIVTaOV5FTQQeonDaV1xwmc1fsqjbPeUXdm0WBi6ehm4Mfxb/3D7UJe5M1VTPDWI/C
         j98Q==
X-Gm-Message-State: AFq9FYIVuZHGH/LIfFRl850RYs3EDjAIMNBolOAggr23Lt9+5ofinAEl
	ceG/0RYV9CPSOqMcuuBqB4nljr0w9EbTI3iZjlGrtvbmWKq3Z3NB0T9OId0lWUF+pkU9pXwyCm6
	lmifIcIcsxw==
X-Gm-Gg: AYBFou13H+8QFUh5Wr2fkTy3F2ff0LKunX+81vQgLRReU9GyDBsHz0a/6GRlYEyQ+mb
	zCly9JmTzX+UtG08d690ot4pUScVr//vHAx82W2TO3ktNaHzgltth5tArza9JhdMacJgpharEeV
	CduOKVEP67VKaY4xPnJfGuqPe/lyzb0ZwkT22qvqpngxph43DXd67tXe2hcEb4Om4a05atJ7fyP
	8AQb36ZdySKR2BvOJnOVSKlWdNR3+qbplXWjJl3NnDuISoYbr6c6sZAZb5tw+lbIOaVXdcKjZM9
	hxgLCmZ9XnMoQDK17SX4Ok333CRgcqU1SHer1KU0g8gcmTZexK/+l1kyaztod52MlhlGDb864sW
	oqH90nZztuhVi2rXxrWnUolWkSumpgHEUtglyUEgDHG+XjUgwRZvYcOCupiPQQ9VkdQx4bGboPK
	PA0IEgoR8M2d74tNUDZ4Lq9kPIRykTf40KrFr8XxV4lU9p4vb3Lt0rphhSMiH0qc3AUM1UlM12X
	YcRwZ6Jgw+zOD/00PY4z1t8ld68IVyQa+HxPr67Mmc4MYyxNCPaebsbVh8=
X-Received: by 2002:a17:90b:1d0b:b0:3a0:2662:815a with SMTP id 98e67ed59e1d1-3a4d18c0f0emr2983669a91.43.1790828521994;
        Wed, 30 Sep 2026 21:22:01 -0700 (PDT)
Received: from m4-mbp16-shigedan.flets-east.jp ([2400:4050:3c1:f500:5d3d:b617:5e0:4606])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f44a5a29sm2222921a91.14.2026.09.30.21.22.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 21:22:01 -0700 (PDT)
From: Kazumasa Shigeta <kazumasa.shigeta@kanamei.com>
To: git@vger.kernel.org
Cc: Shabbir Bhojani <shabbir.r.bhojani@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Kazumasa Shigeta <kazumasa.shigeta@kanamei.com>
Subject: [PATCH v2] stash: expose untracked modes in create
Date: Thu,  1 Oct 2026 13:21:55 +0900
Message-ID: <20261001042155.33303-1-kazumasa.shigeta@kanamei.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
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
does not update refs/stash, reset the index, or clean the working tree.

Use parse_options() for the new options and stop parsing at the first
non-option message word. This keeps option-like tokens after the message
as message text, while leading option-like arguments now follow Git's
normal option parsing. In particular, unknown or malformed leading
options are rejected instead of silently becoming a message, short
options may be combined, and `--` can be used when a message itself
begins with a dash.

Keep create's existing no-change behavior: detect the usual no-change
case before do_create_stash() refreshes and writes the index, and return
success without printing an object name. If do_create_stash() still
reports its internal "nothing to create" result, map that to create's
public success status.

This follows the stash subcommand exit-status convention established by
786fc390465f (stash: reserve exit status 1 for conflicts, 2026-09-03):
subcommands return 0 on success, negative values on failure, and status 1
when applying a stash results in conflicts. cmd_stash() maps negative
subcommand failures to 128.

9ca6326dff29 (stash: refactor stash_create, 2017-02-19) added the
internal include-untracked path while intentionally leaving the user
interface for "git stash create" unchanged. Reuse that machinery and
the existing INCLUDE_ALL_FILES mode rather than adding a separate stash
creation path.

Add coverage for short and long aliases, combined short options, the
untracked/ignored boundary including an ignored-only worktree, option
parsing and dash-leading messages, no-change behavior, and preservation
of refs/stash, the index state, and the working tree.

Signed-off-by: Kazumasa Shigeta <kazumasa.shigeta@kanamei.com>
---
 Documentation/git-stash.adoc | 19 ++++++---
 builtin/stash.c              | 48 +++++++++++++++++----
 t/t3903-stash.sh             | 83 ++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index fc6a9a0..d343a75 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -21,7 +21,7 @@ git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | -
 git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
            [-u | --include-untracked] [-a | --all] [<message>]
 git stash clear
-git stash create [<message>]
+git stash create [-u | --include-untracked] [-a | --all] [--] [<message>]
 git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
 git stash export (--print | --to-ref <ref>) [<stash>...]
 git stash import <commit>
@@ -138,10 +138,13 @@ with no conflicts.
 `drop [-q | --quiet] [<stash>]`::
 	Remove a single stash entry from the list of stash entries.
 
-`create`::
+`create [-u | --include-untracked] [-a | --all] [--]`::
 	Create a stash entry (which is a regular commit object) and
 	return its object name, without storing it anywhere in the ref
-	namespace.
+	namespace.  The `--include-untracked` option includes untracked
+	files, while `--all` also includes ignored files, without modifying
+	the working tree.  If `<message>` begins with a dash, use `--` to
+	separate it from the options.
 	This is intended to be useful for scripts.  It is probably not
 	the command you want to use; see "push" above.
 
@@ -167,10 +170,11 @@ OPTIONS
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
@@ -179,6 +183,9 @@ up with `git clean`.
 	all untracked files are also stashed and then cleaned up with
 	`git clean`.
 +
+When used with the `create` command, untracked files are included in the
+stash entry without modifying the working tree.
++
 When used with the `show` command, show the untracked files in the stash
 entry as part of the diff.
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 7a98434..ec2b5e7 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -59,7 +59,7 @@
 	N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
 	   "          [-u | --include-untracked] [-a | --all] [<message>]")
 #define BUILTIN_STASH_CREATE_USAGE \
-	N_("git stash create [<message>]")
+	N_("git stash create [-u | --include-untracked] [-a | --all] [--] [<message>]")
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
@@ -1643,26 +1648,51 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
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
+	struct strbuf untracked_files = STRBUF_INIT;
 	struct stash_info info = STASH_INFO_INIT;
 	struct pathspec ps;
 
-	/* Starting with argv[1], since argv[0] is "create" */
-	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_create_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	if (!check_changes_tracked_files(&ps))
-		return 0;
+	/*
+	 * Preserve "stash create"'s successful no-change behavior before
+	 * do_create_stash() refreshes and writes the index.
+	 */
+	if (!check_changes(&ps, include_untracked, &untracked_files))
+		goto done;
 
-	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
-			      NULL, 0);
+	ret = do_create_stash(&ps, &stash_msg_buf, include_untracked, 0, NULL,
+			      0, &info, NULL, 0);
+	/*
+	 * Status 1 is reserved for conflicts when applying a stash.
+	 * do_create_stash() uses it internally for "nothing to create", so
+	 * translate that sentinel to create's public success status.
+	 */
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
+	else if (ret == 1)
+		ret = 0;
 
+done:
+	strbuf_release(&untracked_files);
 	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
 	return ret;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7211586..1f660ca 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1179,6 +1179,89 @@ test_expect_success 'create with multiple arguments for the message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create with untracked options' '
+	test_when_finished "rm -rf create-options" &&
+	git init create-options &&
+	test_commit -C create-options base tracked base &&
+	test_commit -C create-options ignore .gitignore ignored &&
+
+	git -C create-options stash create -u >actual &&
+	test_must_be_empty actual &&
+	git -C create-options stash create -a >actual &&
+	test_must_be_empty actual &&
+
+	echo untracked >create-options/untracked &&
+	echo ignored >create-options/ignored &&
+	git -C create-options diff >before-worktree &&
+	git -C create-options diff --cached >before-index &&
+	git -C create-options status --porcelain=v1 --ignored >before-status &&
+
+	short=$(git -C create-options stash create -u "create options") &&
+	long=$(git -C create-options stash create --include-untracked "create options") &&
+	test "$(git -C create-options rev-parse "$short^3^{tree}")" = "$(git -C create-options rev-parse "$long^3^{tree}")" &&
+	echo untracked >expect &&
+	git -C create-options show "$short^3:untracked" >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C create-options cat-file -e "$short^3:ignored" &&
+
+	short=$(git -C create-options stash create -a "create options") &&
+	long=$(git -C create-options stash create --all "create options") &&
+	cluster=$(git -C create-options stash create -ua "create options") &&
+	test "$(git -C create-options rev-parse "$short^3^{tree}")" = "$(git -C create-options rev-parse "$long^3^{tree}")" &&
+	test "$(git -C create-options rev-parse "$short^3^{tree}")" = "$(git -C create-options rev-parse "$cluster^3^{tree}")" &&
+	echo ignored >expect &&
+	git -C create-options show "$short^3:ignored" >actual &&
+	test_cmp expect actual &&
+
+	git -C create-options diff >after-worktree &&
+	git -C create-options diff --cached >after-index &&
+	git -C create-options status --porcelain=v1 --ignored >after-status &&
+	test_cmp before-worktree after-worktree &&
+	test_cmp before-index after-index &&
+	test_cmp before-status after-status &&
+	test_must_fail git -C create-options rev-parse --verify refs/stash >/dev/null 2>&1
+'
+
+test_expect_success 'create untracked modes with only ignored files' '
+	test_when_finished "rm -rf create-ignored-only" &&
+	git init create-ignored-only &&
+	test_commit -C create-ignored-only base tracked base &&
+	test_commit -C create-ignored-only ignore .gitignore ignored &&
+	echo ignored >create-ignored-only/ignored &&
+
+	git -C create-ignored-only stash create -u >actual &&
+	test_must_be_empty actual &&
+	stash=$(git -C create-ignored-only stash create -a) &&
+	test -n "$stash" &&
+	echo ignored >expect &&
+	git -C create-ignored-only show "$stash^3:ignored" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create option parsing and dash-leading messages' '
+	test_when_finished "rm -rf create-message-options" &&
+	git init create-message-options &&
+	test_commit -C create-message-options base tracked base &&
+	echo modified >>create-message-options/tracked &&
+	echo untracked >create-message-options/untracked &&
+
+	stash=$(git -C create-message-options stash create handle new -u flag) &&
+	echo "On main: handle new -u flag" >expect &&
+	git -C create-message-options show --pretty=%s -s "$stash" >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C create-message-options cat-file -e "$stash^3^{commit}" &&
+
+	test_must_fail git -C create-message-options stash create -f >out 2>err &&
+	test_grep "unknown switch" err &&
+	stash=$(git -C create-message-options stash create -- -f) &&
+	echo "On main: -f" >expect &&
+	git -C create-message-options show --pretty=%s -s "$stash" >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git -C create-message-options stash create \
+		--include-untracked=yes >out 2>err
+'
+
 test_expect_success 'create in a detached state' '
 	test_when_finished "git checkout main" &&
 	git checkout HEAD~1 &&
-- 
2.47.3

