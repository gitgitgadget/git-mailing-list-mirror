Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B84E20951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbdCNVqw (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:46:52 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34480 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdCNVqv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:46:51 -0400
Received: by mail-pf0-f178.google.com with SMTP id v190so75882881pfb.1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4rlk9j76voyo8t+8rS0ccsSgRr5RKV6vh6tbTG+5W+I=;
        b=jiCsfMGxBZNM0ItvH7N+2oWRMQ+4KHxJIM4zCfAJRmbB8+LYPoKwKe55NZtq/XW0PW
         UaGKJFlLMNS0DnSMVnOKi0vCzMbX6Ihe95jIQ0zhWCsI+9JpWLqtx5OsP513ar8PWgY/
         ULuBEUjWuHnf48cWcfJBLa4FbOxwSo0qo/3EPnQcrqj7BPN63Yv+KVCeKZDJOv0nQkef
         DbW+GIi2VKWdYtvLSAC5Q8d9wtGW9M2VGXM9hH2j/iEh0g9pIid/Lb3Mo0k5XvPx0R0O
         JNOZEGQ4cCrGVHvpPvFTOiYF8SRHX7q0Maw3OD8QYOCUUM0c6+utj4pI2eLTPiXhQu+M
         oCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4rlk9j76voyo8t+8rS0ccsSgRr5RKV6vh6tbTG+5W+I=;
        b=a91iuCFa/kbwk9ILlJBRdvPuy/s9M04MrdvsnkjbgMCkj37oUhZHRqJ4bhpbSWiH5r
         1Y+GXavxTTz5fnqcIgH9vC1oHt8FaSMhPchuI73tr318bmvvQ24qD30oPwlkX3ClPrlM
         7Xre1CNykBopAvYgVKYd2yzvVp7NxtivjANPZZFNY8vat8wcVWWHwVW2OEdjKRMtnfUH
         E+g0qZUiFagQwrt7ixNmAXMCNdXJjL39jt6Mb27YIgBqYJJK5J7CPrUQIhx/wg1xNdZ7
         XdJnVu7ySbAWrfq5wqDs0Uqr6XV4lqqRiP6nTAdEBappVZvFPgzq+zElD0Xi6yZgW6jv
         2Qww==
X-Gm-Message-State: AMke39m12aSqe+NUMCL5jakilzLGpxwas5nj7Ug4aXwmhT8RMRkDU3rctorDcu3Wthus7iUf
X-Received: by 10.99.241.83 with SMTP id o19mr45446092pgk.81.1489528009512;
        Tue, 14 Mar 2017 14:46:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id m20sm40548215pgd.67.2017.03.14.14.46.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:46:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCHv9 00/19] Checkout aware of Submodules!
Date:   Tue, 14 Mar 2017 14:46:23 -0700
Message-Id: <20170314214642.7701-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

previous work:
https://public-inbox.org/git/20170309221543.15897-1-sbeller@google.com/

v9:
 * inderdiff to current origin/sb/checkout-recurse-submodules below
 * fixed a '\' that was violating the style guide.
 * reordered the patches, such that
   -> the first two patches are Valerys series and could go on its own as
      a cleanup  
   -> added a new patch "submodule.c: get_super_prefix_or_empty" to
      have cleaner code.
 * split up the error conditions in the test lib for readability

v1..v8: see description in link to previous work above.

Thanks,
Stefan

diff --git a/submodule.c b/submodule.c
index bc5fecf8c5..929fc7bf04 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1239,6 +1239,14 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	return ret;
 }
 
+static const char *get_super_prefix_or_empty()
+{
+	const char *s = get_super_prefix();
+	if (!s)
+		s = "";
+	return s;
+}
+
 static int submodule_has_dirty_index(const struct submodule *sub)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1246,8 +1254,8 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
 
 	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "diff-index", "--quiet", \
-					"--cached", "HEAD", NULL);
+	argv_array_pushl(&cp.args, "diff-index", "--quiet",
+				   "--cached", "HEAD", NULL);
 	cp.no_stdin = 1;
 	cp.no_stdout = 1;
 	cp.dir = sub->path;
@@ -1266,7 +1274,8 @@ static void submodule_reset_index(const char *path)
 	cp.no_stdin = 1;
 	cp.dir = path;
 
-	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
+	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
+				   get_super_prefix_or_empty(), path);
 	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
 
 	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
@@ -1323,7 +1332,8 @@ int submodule_move_head(const char *path,
 	cp.no_stdin = 1;
 	cp.dir = path;
 
-	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
+	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
+			get_super_prefix_or_empty(), path);
 	argv_array_pushl(&cp.args, "read-tree", NULL);
 
 	if (flags & SUBMODULE_MOVE_HEAD_DRY_RUN)
@@ -1573,11 +1583,8 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 		die(_("could not create directory '%s'"), new_git_dir);
 	real_new_git_dir = real_pathdup(new_git_dir);
 
-	if (!prefix)
-		prefix = get_super_prefix();
-
 	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s'\n"),
-		prefix ? prefix : "", path,
+		get_super_prefix_or_empty(), path,
 		real_old_git_dir, real_new_git_dir);
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
@@ -1648,8 +1655,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		if (flags & ~ABSORB_GITDIR_RECURSE_SUBMODULES)
 			die("BUG: we don't know how to pass the flags down?");
 
-		if (get_super_prefix())
-			strbuf_addstr(&sb, get_super_prefix());
+		strbuf_addstr(&sb, get_super_prefix_or_empty());
 		strbuf_addstr(&sb, path);
 		strbuf_addch(&sb, '/');
 
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index e195b590a1..fb4f7b014e 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -782,15 +782,20 @@ test_submodule_forced_switch () {
 
 test_submodule_switch_recursing () {
 	command="$1"
-	RESULT=success
+	RESULTDS=success
 	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
 	then
-		RESULT=failure
+		RESULTDS=failure
+	fi
+	RESULTR=success
+	if test "$KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED" = 1
+	then
+		RESULTR=failure
 	fi
-	RESULT1=success
+	RESULTOI=success
 	if test "$KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED" = 1
 	then
-		RESULT1=failure
+		RESULTOI=failure
 	fi
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear checks it out ...
@@ -832,7 +837,7 @@ test_submodule_switch_recursing () {
 		)
 	'
 	# ... but an ignored file is fine.
-	test_expect_$RESULT1 "$command: added submodule removes an untracked ignored file" '
+	test_expect_$RESULTOI "$command: added submodule removes an untracked ignored file" '
 		test_when_finished "rm submodule_update/.git/info/exclude" &&
 		prolog &&
 		reset_work_tree_to_interested no_submodule &&
@@ -901,7 +906,7 @@ test_submodule_switch_recursing () {
 	'
 	# Replacing a submodule with files in a directory must succeeds
 	# when the submodule is clean
-	test_expect_$RESULT "$command: replace submodule with a directory" '
+	test_expect_$RESULTDS "$command: replace submodule with a directory" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -913,7 +918,7 @@ test_submodule_switch_recursing () {
 		)
 	'
 	# ... absorbing a .git directory.
-	test_expect_$RESULT "$command: replace submodule containing a .git directory with a directory must absorb the git dir" '
+	test_expect_$RESULTDS "$command: replace submodule containing a .git directory with a directory must absorb the git dir" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -941,7 +946,7 @@ test_submodule_switch_recursing () {
 	'
 
 	# ... must check its local work tree for untracked files
-	test_expect_$RESULT "$command: replace submodule with a file must fail with untracked files" '
+	test_expect_$RESULTDS "$command: replace submodule with a file must fail with untracked files" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -998,7 +1003,7 @@ test_submodule_switch_recursing () {
 	'
 
 	# recursing deeper than one level doesn't work yet.
-	test_expect_failure "$command: modified submodule updates submodule recursively" '
+	test_expect_$RESULTR "$command: modified submodule updates submodule recursively" '
 		prolog &&
 		reset_work_tree_to_interested add_nested_sub &&
 		(
@@ -1116,13 +1121,13 @@ test_submodule_forced_switch_recursing () {
 		)
 	'
 	# Replacing a submodule with files in a directory ...
-	test_expect_$RESULT "$command: replace submodule with a directory" '
+	test_expect_success "$command: replace submodule with a directory" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
-			test_must_fail $command replace_sub1_with_directory &&
+			$command replace_sub1_with_directory &&
 			test_superproject_content origin/replace_sub1_with_directory
 		)
 	'
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index 7019d0a04f..de1ba02dc5 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -5,6 +5,7 @@ test_description='read-tree can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
+KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index aa35223369..e8f70b806f 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -64,6 +64,7 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 '
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
+KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 test_submodule_switch_recursing "git checkout --recurse-submodules"
 
 test_submodule_forced_switch_recursing "git checkout -f --recurse-submodules"
