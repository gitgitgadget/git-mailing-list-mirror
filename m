Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD05C4332F
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134AA61205
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJNAMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhJNAMw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:12:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD5C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:10:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o20so13883319wro.3
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jD4Ocyc10h1ilA1cwNzKE34YA31j5HKkDOvYC/HP9o=;
        b=e/2Hd1rRXQcvKm8YpWm4MC6U8qaRgroVlTBDX81D9ajCh+1uVPBCgtGeSgKRSGSxwn
         4X9maF+tTWHQO/c41UqGEa+LnmOEk+w7pA46EW+l2FNur6UgToWLr8M/OnOGY6ov8vm8
         A5FnKBeHEMffj3hlM0NpVZLtQMGVRrUdxM5aDCkL5FUwyUMAyQZyIQ13UxZRuUdRdb5x
         xmwVqZgeEU03QslsZMy2SpMf+gS0NHLZKvDflRzoJuMQPZKhzTXJa5qP8drTVy9PGpuO
         NNYTY7g8PAyKohEphPNHUU0gHxDSUSJi2DVdUxxmHo7PsAdomI+tbILjx47paOji3u8S
         2wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jD4Ocyc10h1ilA1cwNzKE34YA31j5HKkDOvYC/HP9o=;
        b=B0oZxhrazs5hX4J+VJwWiS2mkajmOA6C3Nbql0PqXHXmyfRWlX7/DsttBMt48CnW2Q
         kBm3aYB5Px0WTYDfaos3PipvntGeJWElqcd9YNTUXqFoPmHzkbaikwQf0cIn5rNUfPF9
         Dp4NgB+WKj4BCqV5zq2tLEVhxiVaXyPLurD1tFNZWUOsO5NNlFqlLvnG7mcPp5fw4zE5
         49awUTN79Duq3eXIEMv3If5KMVbxafTnXkkyehT8Da9+tPVXEUGI5kgtf2CCfeloMWTL
         y2SElwhK7cmLEzkiDUXnU3s9gFfPpYJHyFuXfoFolNZcgsHdedMEIGG6sZZxpBmZGosH
         fE/w==
X-Gm-Message-State: AOAM533RzN9NZf97ob8xvjHeKle9jRB4JCC5UKUnR6xEkZVSAznZLcEp
        C0zfCvwQ9lwRHllNwQe1tJnIYiNFipAvEg==
X-Google-Smtp-Source: ABdhPJxHc8rpDg7xlTdZlOMRradjt2vILTFxwXo3NQ15xY8IQb/Rb/Zs0tkfx4Sa5qpszV5RFXg5/w==
X-Received: by 2002:a05:600c:1c03:: with SMTP id j3mr15703064wms.171.1634170246880;
        Wed, 13 Oct 2021 17:10:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d1sm940350wrr.72.2021.10.13.17.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:10:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] checkout: fix "branch info" memory leaks
Date:   Thu, 14 Oct 2021 02:10:44 +0200
Message-Id: <patch-1.1-9b17170b794-20211014T000949Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "checkout" command is one of the main sources of leaks in the test
suite, let's fix the common ones by not leaking from the "struct
branch_info".

Doing this is rather straightforward, albeit verbose, we need to
xstrdup() constant strings going into the struct, and free() the ones
we clobber as we go along.

This also means that we can delete previous partial leak fixes in this
area, i.e. the "path_to_free" accounting added by 96ec7b1e708 (Convert
resolve_ref+xstrdup to new resolve_refdup function, 2011-12-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

As with other leak fixes I merged this to "seen" and tested it in
combination with in-flight topics under
GIT_TEST_PASSING_SANITIZE_LEAK=true.

 builtin/checkout.c                | 76 +++++++++++++++++++++----------
 t/t1005-read-tree-reset.sh        |  1 +
 t/t1406-submodule-ref-store.sh    |  1 +
 t/t2008-checkout-subdir.sh        |  1 +
 t/t2014-checkout-switch.sh        |  2 +
 t/t2026-checkout-pathspec-file.sh |  1 +
 t/t9102-git-svn-deep-rmdir.sh     |  2 +
 7 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8c69dcdf72a..a85eb66da16 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -103,6 +103,16 @@ struct branch_info {
 	char *checkout;
 };
 
+static void branch_info_release(struct branch_info *info)
+{
+	if (!info)
+		return;
+	free((char *)info->name);
+	free((char *)info->path);
+	free(info->refname);
+	free(info->checkout);
+}
+
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
@@ -686,8 +696,10 @@ static void setup_branch_path(struct branch_info *branch)
 		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
 
 	strbuf_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
-	if (strcmp(buf.buf, branch->name))
+	if (strcmp(buf.buf, branch->name)) {
+		free((char *)branch->name);
 		branch->name = xstrdup(buf.buf);
+	}
 	strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
 	branch->path = strbuf_detach(&buf, NULL);
 }
@@ -896,7 +908,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				      opts->new_branch_log,
 				      opts->quiet,
 				      opts->track);
-		new_branch_info->name = opts->new_branch;
+		free((char *)new_branch_info->name);
+		free(new_branch_info->refname);
+		new_branch_info->name = xstrdup(opts->new_branch);
 		setup_branch_path(new_branch_info);
 	}
 
@@ -1064,8 +1078,7 @@ static int switch_branches(const struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
 	int ret = 0;
-	struct branch_info old_branch_info;
-	void *path_to_free;
+	struct branch_info old_branch_info = { 0 };
 	struct object_id rev;
 	int flag, writeout_error = 0;
 	int do_merge = 1;
@@ -1073,25 +1086,32 @@ static int switch_branches(const struct checkout_opts *opts,
 	trace2_cmd_mode("branch");
 
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
-	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
+	old_branch_info.path = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old_branch_info.path)
 		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
-	if (!(flag & REF_ISSYMREF))
+	if (!(flag & REF_ISSYMREF)) {
+		free((char *)old_branch_info.path);
 		old_branch_info.path = NULL;
+	}
 
-	if (old_branch_info.path)
-		skip_prefix(old_branch_info.path, "refs/heads/", &old_branch_info.name);
+	if (old_branch_info.path) {
+		const char *p;
+		if (skip_prefix(old_branch_info.path, "refs/heads/", &p))
+			old_branch_info.name = xstrdup(p);
+		else
+			BUG("Should be able to skip with %s!", old_branch_info.path);
+	}
 
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
 		if (new_branch_info->name)
 			BUG("'switch --orphan' should never accept a commit as starting point");
 		new_branch_info->commit = NULL;
-		new_branch_info->name = "(empty)";
+		new_branch_info->name = xstrdup("(empty)");
 		do_merge = 1;
 	}
 
 	if (!new_branch_info->name) {
-		new_branch_info->name = "HEAD";
+		new_branch_info->name = xstrdup("HEAD");
 		new_branch_info->commit = old_branch_info.commit;
 		if (!new_branch_info->commit)
 			die(_("You are on a branch yet to be born"));
@@ -1104,7 +1124,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	if (do_merge) {
 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
 		if (ret) {
-			free(path_to_free);
+			branch_info_release(&old_branch_info);
 			return ret;
 		}
 	}
@@ -1115,7 +1135,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
 	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
-	free(path_to_free);
+	branch_info_release(&old_branch_info);
+
 	return ret || writeout_error;
 }
 
@@ -1147,7 +1168,7 @@ static void setup_new_branch_info_and_source_tree(
 	struct tree **source_tree = &opts->source_tree;
 	struct object_id branch_rev;
 
-	new_branch_info->name = arg;
+	new_branch_info->name = xstrdup(arg);
 	setup_branch_path(new_branch_info);
 
 	if (!check_refname_format(new_branch_info->path, 0) &&
@@ -1576,12 +1597,11 @@ static char cb_option = 'b';
 
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
-			 const char * const usagestr[])
+			 const char * const usagestr[],
+			 struct branch_info *new_branch_info)
 {
-	struct branch_info new_branch_info;
 	int parseopt_flags = 0;
 
-	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
 	opts->show_progress = -1;
@@ -1690,7 +1710,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-					     &new_branch_info, opts, &rev);
+					     new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
@@ -1699,7 +1719,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		if (get_oid_mb(opts->from_treeish, &rev))
 			die(_("could not resolve %s"), opts->from_treeish);
 
-		setup_new_branch_info_and_source_tree(&new_branch_info,
+		setup_new_branch_info_and_source_tree(new_branch_info,
 						      opts, &rev,
 						      opts->from_treeish);
 
@@ -1719,7 +1739,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		 * Try to give more helpful suggestion.
 		 * new_branch && argc > 1 will be caught later.
 		 */
-		if (opts->new_branch && argc == 1 && !new_branch_info.commit)
+		if (opts->new_branch && argc == 1 && !new_branch_info->commit)
 			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
 				argv[0], opts->new_branch);
 
@@ -1768,11 +1788,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		strbuf_release(&buf);
 	}
 
-	UNLEAK(opts);
 	if (opts->patch_mode || opts->pathspec.nr)
-		return checkout_paths(opts, &new_branch_info);
+		return checkout_paths(opts, new_branch_info);
 	else
-		return checkout_branch(opts, &new_branch_info);
+		return checkout_branch(opts, new_branch_info);
 }
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
@@ -1791,6 +1810,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int ret;
+	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1821,7 +1841,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, checkout_usage);
+			    options, checkout_usage, &new_branch_info);
+	branch_info_release(&new_branch_info);
+	clear_pathspec(&opts.pathspec);
 	FREE_AND_NULL(options);
 	return ret;
 }
@@ -1842,6 +1864,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int ret;
+	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1861,7 +1884,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	cb_option = 'c';
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, switch_branch_usage);
+			    options, switch_branch_usage, &new_branch_info);
+	branch_info_release(&new_branch_info);
 	FREE_AND_NULL(options);
 	return ret;
 }
@@ -1883,6 +1907,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int ret;
+	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.accept_ref = 0;
@@ -1898,7 +1923,8 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, restore_usage);
+			    options, restore_usage, &new_branch_info);
+	branch_info_release(&new_branch_info);
 	FREE_AND_NULL(options);
 	return ret;
 }
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 83b09e13106..12e30d77d09 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -2,6 +2,7 @@
 
 test_description='read-tree -u --reset'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 0a87058971e..3c19edcf30b 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -5,6 +5,7 @@ test_description='test submodule ref store api'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 RUN="test-tool ref-store submodule:sub"
diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
index eadb9434ae7..8a518a44ea2 100755
--- a/t/t2008-checkout-subdir.sh
+++ b/t/t2008-checkout-subdir.sh
@@ -4,6 +4,7 @@
 
 test_description='git checkout from subdirectories'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2014-checkout-switch.sh b/t/t2014-checkout-switch.sh
index ccfb1471135..c138bdde4fe 100755
--- a/t/t2014-checkout-switch.sh
+++ b/t/t2014-checkout-switch.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='Peter MacMillan'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index 43d31d79485..9db11f86dd6 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -2,6 +2,7 @@
 
 test_description='checkout --pathspec-from-file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 66cd51102c8..7b2049caa0c 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -1,5 +1,7 @@
 #!/bin/sh
 test_description='git svn rmdir'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
-- 
2.33.1.1346.g48288c3c089

