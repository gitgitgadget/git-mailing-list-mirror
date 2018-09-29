Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7AA41F453
	for <e@80x24.org>; Sat, 29 Sep 2018 19:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeI3BkW (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:40:22 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:46945 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeI3BkV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:40:21 -0400
Received: by mail-lj1-f181.google.com with SMTP id 203-v6so8658754ljj.13
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5DHjMdBVzc0ftQDk1QrFBLgqscJh4z3WYoserVUP91A=;
        b=u046yJqFarRKKmYEMvCLLDS6EkC/d6WcTlFLMRqGgTolw1L7CnrHP5aGbFcHbTDCxt
         xyg5CLoh7hJmVq6eJFV2KLOnMFqNIIGOYpdC99wLSRD/s4tYsGi9IRmU7ag+4OnpJrYa
         PJHOxrUYhiu38s5w9BxKr++UTau7DYiZgNrlOmDFTKbTNQRi9g/71TICTP9eH2vxNlGW
         yG/5eZoIDhzeewhcTypuVvyEefczUienbJfFR2KI6c12k/DexfuEEHjnkNRutoFgmarO
         AHdK5cGUs91s3MRe0d2LbUp9DWoVUfwYI58MxkkZsqDP8LgUYjn3XWfvKZMXPAh11XQt
         5lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5DHjMdBVzc0ftQDk1QrFBLgqscJh4z3WYoserVUP91A=;
        b=eIETfKcO9QR6wxrXXbwtvMechAQiGWL/13cqSTLlax/L56rzBqh8IMOYIWy4FqUKTM
         qrW/XxJ27JgpSG1qc8PYCwsjNW6WA2foYYqRMnq0c7SPDI9OF53eNMcjOu+Y0kruqlwx
         5inm90D4BYlJ/KwFAWHB2KwZY6pdiHgTDrZ4cw4LcNW712DapD9UNEnCJB2bKucTVJFh
         eKUaseLrpOv1ozrSQZFk/Hhnu+iaQospz/aKlMrZEufhEq+LGKbWFD7tEzKqFxF2wi3i
         ejSa9q/1xdZOIbYFVZ1S0ATvr5+p0+flZ1YI2sWEm08K7YJg6BjKZeP0NgiNe9Y5GAIA
         +nvg==
X-Gm-Message-State: ABuFfohX8XpD0KdFzF8o/eq4HTqPchYcJX3+ZD5cxosEpOdPZMKFVdrw
        +Pv6mD00rcBUUCEMrYXz0BA=
X-Google-Smtp-Source: ACcGV63Jqc7A4ZtKk5taF3dUvnr9P5xuAB6rpB4APj/9++lIk0fZ2MQptRdcGyJ0YrRplt7SXslJzg==
X-Received: by 2002:a2e:97c8:: with SMTP id m8-v6mr2258728ljj.167.1538248244416;
        Sat, 29 Sep 2018 12:10:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1638494lfi.23.2018.09.29.12.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:10:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 2/8] Add a place for (not) sharing stuff between worktrees
Date:   Sat, 29 Sep 2018 21:10:23 +0200
Message-Id: <20180929191029.13994-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180929191029.13994-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
 <20180929191029.13994-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When multiple worktrees are used, we need rules to determine if
something belongs to one worktree or all of them. Instead of keeping
adding rules when new stuff comes (*), have a generic rule:

- Inside $GIT_DIR, which is per-worktree by default, add
  $GIT_DIR/common which is always shared. New features that want to
  share stuff should put stuff under this directory.

- Inside refs/, which is shared by default except refs/bisect, add
  refs/worktree/ which is per-worktree. We may eventually move
  refs/bisect to this new location and remove the exception in refs
  code.

(*) And it may also include stuff from external commands which will
    have no way to modify common/per-worktree rules.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt         | 19 ++++++++++++++-
 Documentation/gitrepository-layout.txt | 11 +++++++--
 path.c                                 |  2 ++
 refs.c                                 |  1 +
 refs/files-backend.c                   | 14 ++++++++---
 t/t0060-path-utils.sh                  |  2 ++
 t/t1415-worktree-refs.sh               | 33 ++++++++++++++++++++++++++
 7 files changed, 76 insertions(+), 6 deletions(-)
 create mode 100755 t/t1415-worktree-refs.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index e2ee9fc21b..a50fbf8094 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -204,6 +204,22 @@ working trees, it can be used to identify worktrees. For example if
 you only have two working trees, at "/abc/def/ghi" and "/abc/def/ggg",
 then "ghi" or "def/ghi" is enough to point to the former working tree.
 
+REFS
+----
+In multiple working trees, some refs may be shared between all working
+trees, some refs are local. One example is HEAD is different for all
+working trees. This section is about the sharing rules.
+
+In general, all pseudo refs are per working tree and all refs starting
+with "refs/" are shared. Pseudo refs are ones like HEAD which are
+directly under GIT_DIR instead of inside GIT_DIR/refs. There are one
+exception to this: refs inside refs/bisect and refs/worktree is not
+shared.
+
+To access refs, it's best not to look inside GIT_DIR directly. Instead
+use commands such as linkgit:git-revparse[1] or linkgit:git-update-ref[1]
+which will handle refs correctly.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
@@ -228,7 +244,8 @@ linked working tree `git rev-parse --git-path HEAD` returns
 `/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
 rev-parse --git-path refs/heads/master` uses
 $GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
-since refs are shared across all working trees.
+since refs are shared across all working trees, except refs/bisect and
+refs/worktree.
 
 See linkgit:gitrepository-layout[5] for more information. The rule of
 thumb is do not make any assumption about whether a path belongs to
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index e85148f05e..89b616e049 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -95,8 +95,10 @@ refs::
 	References are stored in subdirectories of this
 	directory.  The 'git prune' command knows to preserve
 	objects reachable from refs found in this directory and
-	its subdirectories. This directory is ignored if $GIT_COMMON_DIR
-	is set and "$GIT_COMMON_DIR/refs" will be used instead.
+	its subdirectories.
+	This directory is ignored (except refs/bisect and
+	refs/worktree) if $GIT_COMMON_DIR is set and
+	"$GIT_COMMON_DIR/refs" will be used instead.
 
 refs/heads/`name`::
 	records tip-of-the-tree commit objects of branch `name`
@@ -165,6 +167,11 @@ hooks::
 	each hook. This directory is ignored if $GIT_COMMON_DIR is set
 	and "$GIT_COMMON_DIR/hooks" will be used instead.
 
+common::
+	When multiple working trees are used, most of files in
+	$GIT_DIR are per-worktree with a few known exceptions. All
+	files under 'common' however will be shared between all
+	working trees.
 
 index::
 	The current index file for the repository.  It is
diff --git a/path.c b/path.c
index 34f0f98349..bf4bb02a27 100644
--- a/path.c
+++ b/path.c
@@ -108,6 +108,7 @@ struct common_dir {
 
 static struct common_dir common_list[] = {
 	{ 0, 1, 0, "branches" },
+	{ 0, 1, 0, "common" },
 	{ 0, 1, 0, "hooks" },
 	{ 0, 1, 0, "info" },
 	{ 0, 0, 1, "info/sparse-checkout" },
@@ -118,6 +119,7 @@ static struct common_dir common_list[] = {
 	{ 0, 1, 0, "objects" },
 	{ 0, 1, 0, "refs" },
 	{ 0, 1, 1, "refs/bisect" },
+	{ 0, 1, 1, "refs/worktree" },
 	{ 0, 1, 0, "remotes" },
 	{ 0, 1, 0, "worktrees" },
 	{ 0, 1, 0, "rr-cache" },
diff --git a/refs.c b/refs.c
index 9f7268d5fe..1bc4ed301b 100644
--- a/refs.c
+++ b/refs.c
@@ -624,6 +624,7 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 static int is_per_worktree_ref(const char *refname)
 {
 	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "refs/worktree/") ||
 		starts_with(refname, "refs/bisect/") ||
 		starts_with(refname, "refs/rewritten/");
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 16ef9325e0..2dd77f9485 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -269,9 +269,9 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	closedir(d);
 
 	/*
-	 * Manually add refs/bisect, which, being per-worktree, might
-	 * not appear in the directory listing for refs/ in the main
-	 * repo.
+	 * Manually add refs/bisect and refs/worktree, which, being
+	 * per-worktree, might not appear in the directory listing for
+	 * refs/ in the main repo.
 	 */
 	if (!strcmp(dirname, "refs/")) {
 		int pos = search_ref_dir(dir, "refs/bisect/", 12);
@@ -281,6 +281,14 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 					dir->cache, "refs/bisect/", 12, 1);
 			add_entry_to_dir(dir, child_entry);
 		}
+
+		pos = search_ref_dir(dir, "refs/worktree/", 11);
+
+		if (pos < 0) {
+			struct ref_entry *child_entry = create_dir_entry(
+					dir->cache, "refs/worktree/", 11, 1);
+			add_entry_to_dir(dir, child_entry);
+		}
 	}
 }
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index cd74c0a471..c7b53e494b 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -306,6 +306,8 @@ test_git_path GIT_COMMON_DIR=bar hooks/me                 bar/hooks/me
 test_git_path GIT_COMMON_DIR=bar config                   bar/config
 test_git_path GIT_COMMON_DIR=bar packed-refs              bar/packed-refs
 test_git_path GIT_COMMON_DIR=bar shallow                  bar/shallow
+test_git_path GIT_COMMON_DIR=bar common                   bar/common
+test_git_path GIT_COMMON_DIR=bar common/file              bar/common/file
 
 # In the tests below, $(pwd) must be used because it is a native path on
 # Windows and avoids MSYS's path mangling (which simplifies "foo/../bar" and
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
new file mode 100755
index 0000000000..16c91bef57
--- /dev/null
+++ b/t/t1415-worktree-refs.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='per-worktree refs'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial &&
+	test_commit wt1 &&
+	test_commit wt2 &&
+	git worktree add wt1 wt1 &&
+	git worktree add wt2 wt2 &&
+	git checkout initial &&
+	git update-ref refs/worktree/foo HEAD &&
+	git -C wt1 update-ref refs/worktree/foo HEAD &&
+	git -C wt2 update-ref refs/worktree/foo HEAD
+'
+
+test_expect_success 'refs/worktree must not be packed' '
+	git pack-refs --all &&
+	test_path_is_missing .git/refs/tags/wt1 &&
+	test_path_is_file .git/refs/worktree/foo &&
+	test_path_is_file .git/worktrees/wt1/refs/worktree/foo &&
+	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
+'
+
+test_expect_success 'refs/worktree are per-worktree' '
+	test_cmp_rev worktree/foo initial &&
+	( cd wt1 && test_cmp_rev worktree/foo wt1 ) &&
+	( cd wt2 && test_cmp_rev worktree/foo wt2 )
+'
+
+test_done
-- 
2.19.0.341.g3acb95d729

