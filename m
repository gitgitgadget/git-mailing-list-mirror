Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795A1207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 23:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032537AbdDZXNM (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 19:13:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32911 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032529AbdDZXNG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 19:13:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id y10so847654wmh.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 16:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mhQjNeGElXwMO6VZ1nFUNkyvN7XqohRkkKoT2Tl1Wk=;
        b=JloD+L5EoEiRWUG30sqQvdZjh6gkQaK/zjMzzEbpuRwTFlplDT3t5xWOilWSg33Ids
         l2wgiw/0aXAc3ZaCfof4DG+VZ2g8I4W6ttY4ihqsuyl6Hbkl0WIRCXpT04hvlKMh28vu
         t3vzYEaEKPuJlcgkb94HB9umCSj4VOWjstjNO55q1AIzdoNkBtIrQK7CiP3vQM5wZLRh
         bT0nBgP0gpCg7dJz2F41KC3tQrsco/Tc6anRzrtg1AfFfYNaJQSAADEfNfQm9atqBvPf
         0zoqR2W91wC0R2/o3iKrJtA381/AecBFU3yaYyJBJT1YNM6/srVAi9c0OIn3kO+CpfeG
         wKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mhQjNeGElXwMO6VZ1nFUNkyvN7XqohRkkKoT2Tl1Wk=;
        b=m1mJpni6hoi3LPiN6rpXdRgFy8bVrfIq3vD6ogyYWMVRMC4gyc/t0xvW2IPjzpAOXy
         vWX7U6xAW3/VgzI/9+09Bewxk2j1yMM45ucy2YIV2CE229QH4dbxPlZIJ2FDDiXjvAnV
         2CCuXXbUYYs+PXoWSILCzuLGhjhJ4eNs4vJwFVfAxiLJ0rZpV2d76Zyiu7+Sp7S/j0zt
         juiIlbSNAQpRL3bpf/TYdSA1Ixf0VgZgIAycGuwrCvwDgfW0LYmjB0htrfSdH83csQOb
         grrVkE62R0mh3Lf/+jZ+hGVE1vLVURvQ2HWS0rwqUSAfsLnDWRHAbbqog6uX+47PPj90
         0lSA==
X-Gm-Message-State: AN3rC/44VsC1anJHbMk7ove50tKH04FXon97wYYw/5SsTr9L2U20FYuZ
        doZXxpFD8EBM5w==
X-Received: by 10.28.131.208 with SMTP id f199mr141798wmd.81.1493248384727;
        Wed, 26 Apr 2017 16:13:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 133sm1053097wms.22.2017.04.26.16.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Apr 2017 16:13:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/5] clone: add a --no-tags-submodules to pass --no-tags to submodules
Date:   Wed, 26 Apr 2017 23:12:35 +0000
Message-Id: <20170426231236.27219-5-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170426231236.27219-1-avarab@gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brandon Williams <bmwill@google.com>

Add a --no-tags-submodules which does for --no-tags what the existing
--shallow-submodules does for --depth, i.e. doing:

    git clone --recurse-submodules --no-tags --no-tags-submodules <url>

Will clone the superproject and all submodules with --no-tags
semantics.

This change does not implement a submodule.*.tags config .gitmodules
configuration option corresponding to the existing submodule.*.shallow
facility, which would make --no-tags have full feature parity with
--shallow-submodules.

Signed-off-by: Brandon Williams <bmwill@google.com>
Code-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Commit-message-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Git-Completion-Code-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Docs-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Tests-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-clone.txt            | 11 +++++-
 builtin/clone.c                        |  6 +++
 builtin/submodule--helper.c            | 16 ++++++--
 contrib/completion/git-completion.bash |  1 +
 git-submodule.sh                       |  4 ++
 t/t5616-clone-submodules-tags.sh       | 72 ++++++++++++++++++++++++++++++++++
 6 files changed, 106 insertions(+), 4 deletions(-)
 create mode 100755 t/t5616-clone-submodules-tags.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 83c8e9b394..4a0e4aa4f4 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
-	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
+	  [--depth <depth>] [--[no-]single-branch]
+	  [--no-tags] [--no-tags-submodules]
 	  [--recurse-submodules] [--[no-]shallow-submodules]
 	  [--jobs <n>] [--] <repository> [<directory>]
 
@@ -226,6 +227,10 @@ Can be used in conjunction with `--single-branch` to clone and
 maintain a branch with no references other than a single cloned
 branch. This is useful e.g. to maintain minimal clones of the default
 branch of some repository for search indexing.
++
+
+If you want to clone submodules without tags provide the
+`--no-tags-submodules` option.
 
 --recurse-submodules[=<pathspec]::
 	After the clone is created, initialize and clone submodules
@@ -243,6 +248,10 @@ branch of some repository for search indexing.
 --[no-]shallow-submodules::
 	All submodules which are cloned will be shallow with a depth of 1.
 
+--no-tags-submodules::
+	All submodules which are cloned will be cloned with the
+	`--no-tags` option.
+
 --separate-git-dir=<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
diff --git a/builtin/clone.c b/builtin/clone.c
index 05f52d6f2b..5a945777a8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -42,6 +42,7 @@ static int option_no_checkout, option_bare, option_mirror, option_single_branch
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
 static int option_shallow_submodules;
+static int option_no_tags_submodules;
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
@@ -125,6 +126,8 @@ static struct option builtin_clone_options[] = {
 		 N_("don't clone any tags, and make later fetches not to follow them")),
 	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
 		    N_("any cloned submodules will be shallow")),
+	OPT_BOOL(0, "no-tags-submodules", &option_no_tags_submodules,
+		     N_("any cloned submodules will have no tags")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
@@ -761,6 +764,9 @@ static int checkout(int submodule_progress)
 		if (option_shallow_submodules == 1)
 			argv_array_push(&args, "--depth=1");
 
+		if (option_no_tags_submodules)
+			argv_array_push(&args, "--no-tags");
+
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 36e4231821..caa4d252ee 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -489,7 +489,7 @@ static int module_name(int argc, const char **argv, const char *prefix)
 
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
-			   int quiet, int progress)
+			   int quiet, int progress, int no_tags)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
@@ -499,6 +499,8 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		argv_array_push(&cp.args, "--quiet");
 	if (progress)
 		argv_array_push(&cp.args, "--progress");
+	if (no_tags)
+		argv_array_push(&cp.args, "--no-tags");
 	if (depth && *depth)
 		argv_array_pushl(&cp.args, "--depth", depth, NULL);
 	if (reference->nr) {
@@ -623,6 +625,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	struct strbuf sb = STRBUF_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
 	char *sm_alternate = NULL, *error_strategy = NULL;
+	int no_tags = 0;
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -643,6 +646,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &depth,
 			   N_("string"),
 			   N_("depth for shallow clones")),
+		OPT_BOOL(0, "no-tags", &no_tags,
+			 N_("don't clone any tags, and make later fetches not to follow them")),
 		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
 		OPT_BOOL(0, "progress", &progress,
 			   N_("force cloning progress")),
@@ -680,7 +685,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		prepare_possible_alternates(name, &reference);
 
 		if (clone_submodule(path, sm_gitdir, url, depth, &reference,
-				    quiet, progress))
+				    quiet, progress, no_tags))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
@@ -745,11 +750,12 @@ struct submodule_update_clone {
 	/* failed clones to be retried again */
 	const struct cache_entry **failed_clones;
 	int failed_clones_nr, failed_clones_alloc;
+	int no_tags;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, \
 	NULL, NULL, NULL, \
-	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
+	STRING_LIST_INIT_DUP, 0, NULL, 0, 0, 0}
 
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
@@ -849,6 +855,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_pushl(&child->args, "--prefix", suc->prefix, NULL);
 	if (suc->recommend_shallow && sub->recommend_shallow == 1)
 		argv_array_push(&child->args, "--depth=1");
+	if (suc->no_tags)
+		argv_array_push(&child->args, "--no-tags");
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
 	argv_array_pushl(&child->args, "--url", sub->url, NULL);
@@ -988,6 +996,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			    N_("parallel jobs")),
 		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
 			    N_("whether the initial clone should follow the shallow recommendation")),
+		OPT_BOOL(0, "no-tags", &suc.no_tags,
+			 N_("don't clone any tags, and make later fetches not to follow them")),
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
 		OPT_BOOL(0, "progress", &suc.progress,
 			    N_("force cloning progress")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6da997cf42..08fb1319c3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1314,6 +1314,7 @@ _git_clone ()
 			--recurse-submodules
 			--no-single-branch
 			--shallow-submodules
+			--no-tags-submodules
 			"
 		return
 		;;
diff --git a/git-submodule.sh b/git-submodule.sh
index c0d0e9a4c6..3371775b0b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -565,6 +565,9 @@ cmd_update()
 		--depth=*)
 			depth=$1
 			;;
+		--no-tags)
+			no_tags=1
+			;;
 		-j|--jobs)
 			case "$2" in '') usage ;; esac
 			jobs="--jobs=$2"
@@ -601,6 +604,7 @@ cmd_update()
 		${reference:+"$reference"} \
 		${depth:+--depth "$depth"} \
 		${recommend_shallow:+"$recommend_shallow"} \
+		${no_tags:+--no-tags} \
 		${jobs:+$jobs} \
 		"$@" || echo "#unmatched" $?
 	} | {
diff --git a/t/t5616-clone-submodules-tags.sh b/t/t5616-clone-submodules-tags.sh
new file mode 100755
index 0000000000..3c88265352
--- /dev/null
+++ b/t/t5616-clone-submodules-tags.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='Test cloning of repos with submodules & the --[no-]tags option'
+
+. ./test-lib.sh
+
+pwd=$(pwd)
+
+test_expect_success 'setup' '
+	git checkout -b master &&
+	test_commit commit1 &&
+	test_commit commit2 &&
+	mkdir sub &&
+	(
+		cd sub &&
+		git init &&
+		test_commit subcommit1 &&
+		test_commit subcommit2 &&
+		test_commit subcommit3
+	) &&
+	git submodule add "file://$pwd/sub" sub &&
+	git commit -m "add submodule" &&
+	git tag addsubcommit1
+'
+
+test_expect_success 'tags clone implies tags submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules "file://$pwd/." super_clone &&
+	git -C super_clone for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 3 tags &&
+	git -C super_clone/sub for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 3 tags
+'
+
+test_expect_success 'no-tags clone with no-tags submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --no-tags --no-tags-submodules "file://$pwd/." super_clone &&
+	git -C super_clone for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 0 tags &&
+	git -C super_clone/sub for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 0 tags
+
+'
+
+test_expect_success 'no-tags clone does not imply no-tags submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --no-tags "file://$pwd/." super_clone &&
+	git -C super_clone for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 0 tags &&
+	git -C super_clone/sub for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 3 tags
+'
+
+test_expect_success 'no-tags clone with tags submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --no-tags --tags-submodules "file://$pwd/." super_clone &&
+	git -C super_clone for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 0 tags &&
+	git -C super_clone/sub for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 3 tags
+'
+
+test_expect_success 'tags clone with no-tags submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --tags --no-tags-submodules "file://$pwd/." super_clone &&
+	git -C super_clone for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 3 tags &&
+	git -C super_clone/sub for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 0 tags
+'
+
+test_done
-- 
2.11.0

