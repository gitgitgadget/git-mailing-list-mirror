Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAABD199949
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768584; cv=none; b=UBvuRSjE/bzpJSRXJqaI0exXkg7roy93orR64v4zmkV9mdHmiioOhWFD3L+rkO7J3StbHxYBpZOd7DuFYeB3Cj1+H+1ueg4phJYVtq0X2jq4fnNghAuxm/PU8psRCWcEOjmn1jchM0dlS+P5y9JtOASS8O1BPk9g1WBpAa3Nvuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768584; c=relaxed/simple;
	bh=oiy5exVUvy6mLxGw3pUyau0GMBSCZIdkVC1AfFxmsAo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=W/C13qqGZ4gIiOOPmAGfuVTF/b8RP7wvFIRiZafqZ4IgQzVNF83UYurJzoiNt9P/kGRYzqnv2VXHyH8OAPe6ii1OX7kalwG1Ph24hZerojoscEJJb5EOzNClrNpQTogLKqwSVb10r4jxPoAvfx2aOyFaC41gq4RnWn5dBT/ZAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1y6UxQn; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1y6UxQn"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a049a767c3so2836786d6.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 00:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774768581; x=1775373381; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mYV/pY4rz2LnF/J/Jl11Pc/TmlkdtUMTvJZNI/C5gh4=;
        b=F1y6UxQn5m/GqONveaLi9B1sRnSVRnk1RqlqN2IjkNxidxwo3NSjc/tZw4bPQ8JjaX
         gmasXIrIPWQDRpeG6C3im42ELdrXOPZrnQDlgzB7Ez5qCWgR5yWwa0wk2sx385uZLDVH
         a8nxpGx2W74VCh06GCezEm6Xbl8za1ffxLYgIen6h54a+6oZQGs4MWL+0NLRgZ3NksRC
         JG5i6u6qnf6pxmDWI0KvJh8+L/dSf2lplP4PENADwBtS2xywMY+2QZjUQEcMbiZ7PohV
         yNNImW7aFFtccYFaJCWNXdkazQX7t5RH+wfo1oz0isarWs1UOqzW+PgC5UhojNk6Eqmm
         eVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774768581; x=1775373381;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYV/pY4rz2LnF/J/Jl11Pc/TmlkdtUMTvJZNI/C5gh4=;
        b=O1I6TeuADT/u73plBjfXdKfGl9euUNdF3bH7MfsA9blKZhnIAWKnhXzbmVJSntbzf4
         sWFCEfnt0svyu3wr9RfUhNTIOnfB+Gq8utM8H8vSRJM9JBv+B9HKJp0MUMdS2lG7eOSQ
         h/o33kUdLIXBKHGDYETOvPG19UOMufWBUN7oGop6rkcgr8dZ929HOxzyFLWoLhEYkN1h
         /9YhvMkdNAzC7JEwDYt8I4MvAC08vzVJNhDaGoug4FqgYTWJyaHo+ls67PIhS2yAgLUh
         UIbznPoPhDw4Brm6Ylp0n+Bgy7bZpnjQBG6eCPlTUBh1s1fu7HAD6b0PH5RS5dhvLC5A
         vbfg==
X-Gm-Message-State: AOJu0YxkF4Nt/js43y3OPsYOc3R84bMIjC+DGwKhoxI4o3C0Yr997hbX
	lvIQNjcUHSfLBdJvCuQM1tnyGVqtRLgWTtQiou3tgsEWqzexSpZfh1xRc+YCeQ==
X-Gm-Gg: ATEYQzx+WZu3gyDu5uIZSe4d7C9anrzDlrOs+5YOlUh8CHshKGmspodrkXWMtaKYnzF
	l2Hgc8kI+DAv3jxUptHQspqtsrhPh+Q1T+e8IhsSLtwtW3WenC7xFKlDSPhpshRii1IkKMA3v2O
	aUMFgBDtfPI6ZPPHZQGWFhd0X4JpscF4VwQx91t9gg0bDMhqKxnE6v+1zcmv6ikUnUQz8nfXWjJ
	TCItM7uAytqWbH9hRq/Ohs5Yb827mUWbkHYwoh33jlO4xK0GSSQ9erx1fZ/BsRSAkKAbk1cEBwJ
	8OMKby9R3JPfvunY3+NwIDs2rarAV3XgvQvYJHI/8tOPuG2iEACXFx8fDadg9g1QYbLJ7rOFElv
	aLbH1TMvFmLQyYaz6DJxhoQRivFFKzyUu5CYpFr144GY31G5PhZkrSPnZRyBfkF/zssr+1gLy+K
	rlw/u3xQ9XRMH08xndt06+x1cy
X-Received: by 2002:a05:6214:4e05:b0:89d:a018:d654 with SMTP id 6a1803df08f44-89da018edbdmr83388376d6.17.1774768581119;
        Sun, 29 Mar 2026 00:16:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.42.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecbda4d50sm32862076d6.15.2026.03.29.00.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:16:20 -0700 (PDT)
Message-Id: <pull.1892.git.1774768580147.gitgitgadget@gmail.com>
From: "Shabbir Bhojani via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Mar 2026 07:16:20 +0000
Subject: [PATCH/RFC] stash: add --include-untracked support to git stash
 create
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Shabbir Bhojani <shabbir.r.bhojani+git@gmail.com>,
    SBhojani <shabbir.r.bhojani+git@gmail.com>

From: SBhojani <shabbir.r.bhojani+git@gmail.com>

The `git stash create` command now supports the `--include-untracked` flag,
allowing users to include untracked files in the stash entry. This brings
parity with `git stash push`, which already supports this option.

Previously, `git stash create` would only stash tracked changes. With this
change, users can optionally include untracked files by specifying
`--include-untracked`. The implementation involves parsing the new option
in `create_stash` and passing it to `do_create_stash`, which handles the
creation of the stash entry.

The check for tracked changes is skipped when `--include-untracked` is
set, as `do_create_stash` performs its own check internally. Test cases
were added to `t3903-stash.sh` to ensure the correct behavior, and the
documentation was updated accordingly.

Signed-off-by: SBhojani <shabbir.r.bhojani+git@gmail.com>
---
    stash: add --include-untracked support to git stash create
    
    This is a single-commit pull request, and the commit message already
    describes the changes.
    
    I just want to add context for where I felt the need for this. While
    working on a logical single commit task, my working tree is often in a
    state where certain changes are staged and others are not. I use this
    staging strategy as a conceptual model of which changes I intend to
    mostly keep as they are and which I intend to change, rewrite, refactor,
    discard, or not commit. Some of the changes in the latter category might
    be new untracked files. Now, I often use (my git GUI tool's equivalent
    of) git stash --include-untracked followed by git stash apply to take a
    snapshot of these changes to be able to come back to the state if I mess
    things up too much from that point on. Doing that results in the working
    directory being cleaned momentarily and then being repopulated again. My
    development tools often detect this as the files having been changed and
    then prompt me to reload them or cause rebuilds and so on. git stash
    store $(git stash create) has the nice feature that it doesn't touch the
    working directory, but it was missing the ability to also stash
    untracked files. This change fixes that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1892%2FSBhojani%2Fstash-create-untracked-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1892/SBhojani/stash-create-untracked-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1892

 Documentation/git-stash.adoc |  9 +++++++--
 builtin/stash.c              | 25 +++++++++++++++++++------
 t/t3903-stash.sh             | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 235d57ddd8..c379062110 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -21,7 +21,7 @@ git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --
 git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
            [-u | --include-untracked] [-a | --all] [<message>]
 git stash clear
-git stash create [<message>]
+git stash create [-u | --include-untracked] [<message>]
 git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
 git stash export (--print | --to-ref <ref>) [<stash>...]
 git stash import <commit>
@@ -140,10 +140,12 @@ with no conflicts.
 `drop [-q | --quiet] [<stash>]`::
 	Remove a single stash entry from the list of stash entries.
 
-`create`::
+`create [-u | --include-untracked]`::
 	Create a stash entry (which is a regular commit object) and
 	return its object name, without storing it anywhere in the ref
 	namespace.
+	If the `--include-untracked` option is used, all untracked files are
+	also included in the stash entry.
 	This is intended to be useful for scripts.  It is probably not
 	the command you want to use; see "push" above.
 
@@ -181,6 +183,9 @@ up with `git clean`.
 	all untracked files are also stashed and then cleaned up with
 	`git clean`.
 +
+When used with the `create` command, all untracked files are also included
+in the stash entry.
++
 When used with the `show` command, show the untracked files in the stash
 entry as part of the diff.
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 95c5005b0b..419f70ea39 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -58,7 +58,7 @@
 	N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
 	   "          [-u | --include-untracked] [-a | --all] [<message>]")
 #define BUILTIN_STASH_CREATE_USAGE \
-	N_("git stash create [<message>]")
+	N_("git stash create [-u | --include-untracked] [<message>]")
 #define BUILTIN_STASH_EXPORT_USAGE \
 	N_("git stash export (--print | --to-ref <ref>) [<stash>...]")
 #define BUILTIN_STASH_IMPORT_USAGE \
@@ -118,6 +118,11 @@ static const char * const git_stash_clear_usage[] = {
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
@@ -1570,22 +1575,30 @@ done:
 	return ret;
 }
 
-static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
+static int create_stash(int argc, const char **argv, const char *prefix,
 			struct repository *repo UNUSED)
 {
 	int ret;
+	int include_untracked = 0;
+	struct option options[] = {
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			N_("include untracked files")),
+		OPT_END()
+	};
+
 	struct strbuf stash_msg_buf = STRBUF_INIT;
 	struct stash_info info = STASH_INFO_INIT;
 	struct pathspec ps;
 
-	/* Starting with argv[1], since argv[0] is "create" */
-	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
+	argc = parse_options(argc, argv, prefix, options, git_stash_create_usage, 0);
+
+	strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	if (!check_changes_tracked_files(&ps))
+	if (!include_untracked && !check_changes_tracked_files(&ps))
 		return 0;
 
-	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
+	ret = do_create_stash(&ps, &stash_msg_buf, include_untracked, 0, NULL, 0, &info,
 			      NULL, 0);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..4e0243e315 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -639,6 +639,39 @@ test_expect_success 'stash create - no changes' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'stash create with --include-untracked' '
+	test_when_finished "git reset --hard && git clean -fd" &&
+	test_commit stash-create-untracked-1 file1 committed &&
+	echo staged >file2 &&
+	git add file2 &&
+	echo unstaged >file3 &&
+	echo untracked >untracked_file &&
+	STASH_ID=$(git stash create --include-untracked "test message") &&
+	git cat-file -p $STASH_ID >stash_commit &&
+	grep "test message" stash_commit &&
+	grep parent stash_commit >parents &&
+	test_line_count = 3 parents &&
+	UNTRACKED_TREE=$(git rev-parse $STASH_ID^3^{tree}) &&
+	git ls-tree $UNTRACKED_TREE >files &&
+	grep untracked_file files &&
+	test_path_is_file untracked_file
+'
+
+test_expect_success 'stash create without --include-untracked does not include untracked files' '
+	test_when_finished "git reset --hard && git clean -fd" &&
+	test_commit stash-create-no-untracked-1 file4 committed &&
+	echo staged >file5 &&
+	git add file5 &&
+	echo unstaged >file6 &&
+	echo untracked >untracked_file2 &&
+	STASH_ID=$(git stash create "test message") &&
+	git cat-file -p $STASH_ID >stash_commit &&
+	grep "test message" stash_commit &&
+	grep parent stash_commit >parents &&
+	test_line_count = 2 parents &&
+	test_path_is_file untracked_file2
+'
+
 test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
gitgitgadget
