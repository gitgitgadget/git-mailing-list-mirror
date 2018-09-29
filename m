Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA0FB1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 19:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeI3BkT (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:40:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34027 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeI3BkS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:40:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id y10-v6so7253762lfj.1
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqMBW3fLRjKCNDA9feT57k7M9eB/UhBVATbbc2cHHj0=;
        b=q8YoY5V4IFukHEeEoJ2GPpAMWwrcDIapIbAvFOKUev+UisJFCJIb3vpBEwBPQVT+VH
         lfjq5YyjgkZixPFUt39zRmvF32IyXqkWf0PeMePTJT36Po57S0aAZBqVFdaSEfnssomF
         /W/d0xY47WXDQxY34eG0XvXVQR31FQBp5G/qXEIC/b18JOvQOHf8VzUgZfQQ/fP0+liS
         oDMcgjujw0sHafTeiUqO9wyJ6f1JEIJDv+16yfL6ILQICYN18KCDXyS+luo41V8SdYOe
         OzrYe87CV6FeN7GTNhaX5/tTWO4vvtVdM01HM1U+RDLz0sJ9Uh9P2xG5FIXLc3sEm4KW
         kunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqMBW3fLRjKCNDA9feT57k7M9eB/UhBVATbbc2cHHj0=;
        b=NaWqS3pLZCLZDGh3LdqgDucyqwN4OViDRL18iyMBpgq0gp2SPlsx3DpPfUcmqsi7cL
         AyH0wYlufKEuA0BSOxdUIB/MUhMbJN++2TlYuGyfFk+a6wjZXoS/LuW51bkaWZ2eiOZb
         VDElXaKcOyQk2UCkCBPduOYIUy7ytSoDIxlep+BqI+21E8NwA3L9jJ+l1z3zBe7AvUt3
         qBuVISreDbKCPpxxGTgVPYatJ9R7vU+6LoPYOYoRJP7mw5XYOCRDDCt4uQgIbqPJO91X
         +m+WyCWcpLolVKGR+AW5tvRBNZ8QZ4xZEfv1n/xXA6HYJ4JREYrAQ0FhbjnV2nx7VoBu
         YXJw==
X-Gm-Message-State: ABuFfog577lg6WIlT+dtjVNxEmDk16n6c+QX1kycyxpiKjJo73ms6CDl
        D0kBDEIGh5NQ9sth3jOMkqc=
X-Google-Smtp-Source: ACcGV60aYBzWRYvh/w4UM5d/byZe0og/Mr9Q8oRdJ0SwiFCXBlMsr0ZZ8hCXKVt973z3tw2UkvsHIw==
X-Received: by 2002:a19:1b14:: with SMTP id b20-v6mr1899942lfb.12.1538248241516;
        Sat, 29 Sep 2018 12:10:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1638494lfi.23.2018.09.29.12.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:10:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 0/8] fix per-worktree ref iteration in fsck/reflog expire
Date:   Sat, 29 Sep 2018 21:10:21 +0200
Message-Id: <20180929191029.13994-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180922180500.4689-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 changes

- more documentation
- main/ prefix is renamed to main-worktree/ to reduce ambiguation
  chances and make it clearer
- refs/local is renamed to refs/worktree
- bug fix in is_main_pseudoref_syntax() and
  is_other_pseudoref_syntax()

Interdiff

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index e2ee9fc21b..58415f9207 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -204,6 +204,35 @@ working trees, it can be used to identify worktrees. For example if
 you only have two working trees, at "/abc/def/ghi" and "/abc/def/ggg",
 then "ghi" or "def/ghi" is enough to point to the former working tree.
 
+REFS
+----
+In multiple working trees, some refs may be shared between all working
+trees, some refs are local. One example is HEAD is different for all
+working trees. This section is about the sharing rules and how to access
+refs of one working tree from another.
+
+In general, all pseudo refs are per working tree and all refs starting
+with "refs/" are shared. Pseudo refs are ones like HEAD which are
+directly under GIT_DIR instead of inside GIT_DIR/refs. There are one
+exception to this: refs inside refs/bisect and refs/worktree is not
+shared.
+
+Refs that are per working tree can still be accessed from another
+working tree via two special paths main-worktree and worktrees. The
+former gives access to per-worktree refs of the main working tree,
+while the former to all linked working trees.
+
+For example, main-worktree/HEAD or main-worktree/refs/bisect/good
+resolve to the same value as the main working tree's HEAD and
+refs/bisect/good respectively. Similarly, worktrees/foo/HEAD or
+worktrees/bar/refs/bisect/bad are the same as
+GIT_COMMON_DIR/worktrees/foo/HEAD and
+GIT_COMMON_DIR/worktrees/bar/refs/bisect/bad.
+
+To access refs, it's best not to look inside GIT_DIR directly. Instead
+use commands such as linkgit:git-revparse[1] or linkgit:git-update-ref[1]
+which will handle refs correctly.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
@@ -228,7 +257,8 @@ linked working tree `git rev-parse --git-path HEAD` returns
 `/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
 rev-parse --git-path refs/heads/master` uses
 $GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
-since refs are shared across all working trees.
+since refs are shared across all working trees, except refs/bisect and
+refs/worktree.
 
 See linkgit:gitrepository-layout[5] for more information. The rule of
 thumb is do not make any assumption about whether a path belongs to
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index fad404ed7c..89b616e049 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -96,9 +96,9 @@ refs::
 	directory.  The 'git prune' command knows to preserve
 	objects reachable from refs found in this directory and
 	its subdirectories.
-	This directory is ignored (except refs/bisect and refs/local)
-	if $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/refs" will be
-	used instead.
+	This directory is ignored (except refs/bisect and
+	refs/worktree) if $GIT_COMMON_DIR is set and
+	"$GIT_COMMON_DIR/refs" will be used instead.
 
 refs/heads/`name`::
 	records tip-of-the-tree commit objects of branch `name`
diff --git a/path.c b/path.c
index 7eb61bf31b..bf4bb02a27 100644
--- a/path.c
+++ b/path.c
@@ -119,6 +119,7 @@ static struct common_dir common_list[] = {
 	{ 0, 1, 0, "objects" },
 	{ 0, 1, 0, "refs" },
 	{ 0, 1, 1, "refs/bisect" },
+	{ 0, 1, 1, "refs/worktree" },
 	{ 0, 1, 0, "remotes" },
 	{ 0, 1, 0, "worktrees" },
 	{ 0, 1, 0, "rr-cache" },
diff --git a/refs.c b/refs.c
index 90b73c7334..2378b2e7fc 100644
--- a/refs.c
+++ b/refs.c
@@ -624,7 +624,7 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 static int is_per_worktree_ref(const char *refname)
 {
 	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/local/") ||
+		starts_with(refname, "refs/worktree/") ||
 		starts_with(refname, "refs/bisect/") ||
 		starts_with(refname, "refs/rewritten/");
 }
@@ -643,7 +643,8 @@ static int is_pseudoref_syntax(const char *refname)
 
 static int is_main_pseudoref_syntax(const char *refname)
 {
-	return skip_prefix(refname, "main/", &refname) &&
+	return skip_prefix(refname, "main-worktree/", &refname) &&
+		*refname &&
 		is_pseudoref_syntax(refname);
 }
 
@@ -652,7 +653,7 @@ static int is_other_pseudoref_syntax(const char *refname)
 	if (!skip_prefix(refname, "worktrees/", &refname))
 		return 0;
 	refname = strchr(refname, '/');
-	if (!refname)
+	if (!refname || !refname[1])
 		return 0;
 	return is_pseudoref_syntax(refname + 1);
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bf9ed633b1..9ca2a3706c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -178,7 +178,7 @@ static void files_reflog_path(struct files_ref_store *refs,
 	case REF_TYPE_OTHER_PSEUDOREF:
 		return files_reflog_path_other_worktrees(refs, sb, refname);
 	case REF_TYPE_MAIN_PSEUDOREF:
-		if (!skip_prefix(refname, "main/", &refname))
+		if (!skip_prefix(refname, "main-worktree/", &refname))
 			BUG("ref %s is not a main pseudoref", refname);
 		/* passthru */
 	case REF_TYPE_NORMAL:
@@ -200,7 +200,7 @@ static void files_ref_path(struct files_ref_store *refs,
 		strbuf_addf(sb, "%s/%s", refs->gitdir, refname);
 		break;
 	case REF_TYPE_MAIN_PSEUDOREF:
-		if (!skip_prefix(refname, "main/", &refname))
+		if (!skip_prefix(refname, "main-worktree/", &refname))
 			BUG("ref %s is not a main pseudoref", refname);
 		/* passthru */
 	case REF_TYPE_OTHER_PSEUDOREF:
@@ -297,7 +297,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	closedir(d);
 
 	/*
-	 * Manually add refs/bisect and refs/local, which, being
+	 * Manually add refs/bisect and refs/worktree, which, being
 	 * per-worktree, might not appear in the directory listing for
 	 * refs/ in the main repo.
 	 */
@@ -310,11 +310,11 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 			add_entry_to_dir(dir, child_entry);
 		}
 
-		pos = search_ref_dir(dir, "refs/local/", 11);
+		pos = search_ref_dir(dir, "refs/worktree/", 11);
 
 		if (pos < 0) {
 			struct ref_entry *child_entry = create_dir_entry(
-					dir->cache, "refs/local/", 11, 1);
+					dir->cache, "refs/worktree/", 11, 1);
 			add_entry_to_dir(dir, child_entry);
 		}
 	}
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index 46ca7bfc19..8b701d07af 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -10,33 +10,38 @@ test_expect_success 'setup' '
 	test_commit wt2 &&
 	git worktree add wt1 wt1 &&
 	git worktree add wt2 wt2 &&
-	git checkout initial
+	git checkout initial &&
+	git update-ref refs/worktree/foo HEAD &&
+	git -C wt1 update-ref refs/worktree/foo HEAD &&
+	git -C wt2 update-ref refs/worktree/foo HEAD
 '
 
-test_expect_success 'add refs/local' '
-	git update-ref refs/local/foo HEAD &&
-	git -C wt1 update-ref refs/local/foo HEAD &&
-	git -C wt2 update-ref refs/local/foo HEAD
-'
-
-test_expect_success 'refs/local must not be packed' '
+test_expect_success 'refs/worktree must not be packed' '
 	git pack-refs --all &&
 	test_path_is_missing .git/refs/tags/wt1 &&
-	test_path_is_file .git/refs/local/foo &&
-	test_path_is_file .git/worktrees/wt1/refs/local/foo &&
-	test_path_is_file .git/worktrees/wt2/refs/local/foo
+	test_path_is_file .git/refs/worktree/foo &&
+	test_path_is_file .git/worktrees/wt1/refs/worktree/foo &&
+	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
 '
 
-test_expect_success 'refs/local are per-worktree' '
-	test_cmp_rev local/foo initial &&
-	( cd wt1 && test_cmp_rev local/foo wt1 ) &&
-	( cd wt2 && test_cmp_rev local/foo wt2 )
+test_expect_success 'refs/worktree are per-worktree' '
+	test_cmp_rev worktree/foo initial &&
+	( cd wt1 && test_cmp_rev worktree/foo wt1 ) &&
+	( cd wt2 && test_cmp_rev worktree/foo wt2 )
 '
 
-test_expect_success 'resolve main/HEAD' '
-	test_cmp_rev main/HEAD initial &&
-	( cd wt1 && test_cmp_rev main/HEAD initial ) &&
-	( cd wt2 && test_cmp_rev main/HEAD initial )
+test_expect_success 'resolve main-worktree/HEAD' '
+	test_cmp_rev main-worktree/HEAD initial &&
+	( cd wt1 && test_cmp_rev main-worktree/HEAD initial ) &&
+	( cd wt2 && test_cmp_rev main-worktree/HEAD initial )
+'
+
+test_expect_success 'ambiguous main-worktree/HEAD' '
+	mkdir -p .git/refs/heads/main-worktree &&
+	test_when_finished rm .git/refs/heads/main-worktree/HEAD &&
+	cp .git/HEAD .git/refs/heads/main-worktree/HEAD &&
+	git rev-parse main-worktree/HEAD 2>warn >/dev/null &&
+	grep "main-worktree/HEAD.*ambiguous" warn
 '
 
 test_expect_success 'resolve worktrees/xx/HEAD' '
@@ -45,11 +50,19 @@ test_expect_success 'resolve worktrees/xx/HEAD' '
 	( cd wt2 && test_cmp_rev worktrees/wt1/HEAD wt1 )
 '
 
-test_expect_success 'reflog of main/HEAD' '
-	git reflog HEAD | sed "s/HEAD/main\/HEAD/" >expected &&
-	git reflog main/HEAD >actual &&
+test_expect_success 'ambiguous worktrees/xx/HEAD' '
+	mkdir -p .git/refs/heads/worktrees/wt1 &&
+	test_when_finished rm .git/refs/heads/worktrees/wt1/HEAD &&
+	cp .git/HEAD .git/refs/heads/worktrees/wt1/HEAD &&
+	git rev-parse worktrees/wt1/HEAD 2>warn >/dev/null &&
+	grep "worktrees/wt1/HEAD.*ambiguous" warn
+'
+
+test_expect_success 'reflog of main-worktree/HEAD' '
+	git reflog HEAD | sed "s/HEAD/main-worktree\/HEAD/" >expected &&
+	git reflog main-worktree/HEAD >actual &&
 	test_cmp expected actual &&
-	git -C wt1 reflog main/HEAD >actual.wt1 &&
+	git -C wt1 reflog main-worktree/HEAD >actual.wt1 &&
 	test_cmp expected actual.wt1
 '
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 444e8c1ad9..e97e6a7c6d 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -106,19 +106,17 @@ test_expect_success 'HEAD link pointing at a funny object (from different wt)' '
 	test_when_finished "rm -rf .git/worktrees wt" &&
 	git worktree add wt &&
 	mv .git/HEAD .git/SAVED_HEAD &&
-	echo 0000000000000000000000000000000000000000 >.git/HEAD &&
+	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail git -C wt fsck 2>out &&
-	cat out &&
 	grep "main/HEAD: detached HEAD points" out
 '
 
 test_expect_success 'other worktree HEAD link pointing at a funny object' '
 	test_when_finished "rm -rf .git/worktrees other" &&
 	git worktree add other &&
-	echo 0000000000000000000000000000000000000000 >.git/worktrees/other/HEAD &&
+	echo $ZERO_OID >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
 	grep "worktrees/other/HEAD: detached HEAD points" out
 '
 
@@ -127,7 +125,6 @@ test_expect_success 'other worktree HEAD link pointing at missing object' '
 	git worktree add other &&
 	echo "Contents missing from repo" | git hash-object --stdin >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
 	grep "worktrees/other/HEAD: invalid sha1 pointer" out
 '
 
@@ -136,7 +133,6 @@ test_expect_success 'other worktree HEAD link pointing at a funny place' '
 	git worktree add other &&
 	echo "ref: refs/funny/place" >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
 	grep "worktrees/other/HEAD points to something strange" out
 '
 

Elijah Newren (1):
  fsck: Move fsck_head_link() to get_default_heads() to avoid some
    globals

Nguyễn Thái Ngọc Duy (7):
  refs.c: indent with tabs, not spaces
  Add a place for (not) sharing stuff between worktrees
  refs: new ref types to make per-worktree refs visible to all worktrees
  revision.c: correct a parameter name
  revision.c: better error reporting on ref from different worktrees
  fsck: check HEAD and reflog from other worktrees
  reflog expire: cover reflog from all worktrees

 Documentation/git-reflog.txt           |  7 ++-
 Documentation/git-worktree.txt         | 32 ++++++++++-
 Documentation/gitrepository-layout.txt | 11 +++-
 builtin/fsck.c                         | 68 +++++++++++++++-------
 builtin/reflog.c                       | 22 ++++++-
 path.c                                 |  2 +
 refs.c                                 | 24 +++++++-
 refs.h                                 |  8 ++-
 refs/files-backend.c                   | 42 +++++++++++++-
 revision.c                             | 22 ++++---
 t/t0060-path-utils.sh                  |  2 +
 t/t1415-worktree-refs.sh               | 79 ++++++++++++++++++++++++++
 t/t1450-fsck.sh                        | 35 ++++++++++++
 worktree.c                             | 32 ++++++++++-
 worktree.h                             | 14 +++++
 15 files changed, 354 insertions(+), 46 deletions(-)
 create mode 100755 t/t1415-worktree-refs.sh

-- 
2.19.0.341.g3acb95d729

