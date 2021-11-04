Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B740C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A19560F02
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhKDXw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 19:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhKDXw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 19:52:29 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3772C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 16:49:50 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y13-20020a1709029b8d00b0013dc7c668e2so4206424plp.16
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 16:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SwOaVOY5z9LF3CpKcVitR0yjFpL2vCrfdlNA18x0pF0=;
        b=CzLIrqDWoXrjL9YnxlKtnC5tirPgVCk37pjH2b3jBfK5ZXRDhXeUKevpetgMzVQCsE
         hZZCltWJFdSzgOcK/m+sxm/GMfybsh+b32aULQ07cGiDtCzAiWkjUKVIvIamxwNcx29B
         zZKU26HxmWxipiqa9ri4KXkML077zIhOvfgJ2EZDWPJj9iftOdDHQqzNV4ZN4Q0Gbwea
         gnATw1ihUO8EhDCCLubHjYP6lvIOQ0uUYWzVl7/Saw+EqNSMQURPhNNmcdvwORN8xcLT
         oC/gGoMYWVZVNSQ624zhk6hBPS+UjiwfKV8DbhL5bx1pTMK7nme4ayj3vKaBkoRYkSpy
         M2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SwOaVOY5z9LF3CpKcVitR0yjFpL2vCrfdlNA18x0pF0=;
        b=sKXeqK+9Z2uHq6Hnj0HsdihZYHC8UVEjeWqHm8/VzOwetob4GMUJelW0GCBszNBgVL
         0KRy0TexJS0dB+S7BJ7SDwuclbizyEofxQxhPV/6NVPVx9vFt1T+0g6RD6khJgFNaghg
         BPqcXYc59rTOm4D6BmqY7tOFLIrLr9KbERYbdaWkM1ljP0XuOCb7JzeFZJc3Zc8XMcId
         DqX8X5eNa0gOcwnryPCU7PKVXcM0jazjQ1c5pNqzwew6hJ7X/3Vezpqk2ykmGNUj1UlJ
         17d/GCUdj9p/gVrXC+/tXovQ3X42M7xuDHV8SNni5kzsAVlTjpZNRSoCDJIsiyr+/O/B
         bKjg==
X-Gm-Message-State: AOAM532qZfvjRRvE1sv7/Rcxe3MHUVTDTessT+mKOb7sCgvGPsOSBUwm
        1iXLVmYw+X1uw6/txse0bOp5K98zQUcH6sR+N29rC91K/bmpSRAaEX2O+C8ZHPzydZDKVPBXvWo
        CXADUYeErf1lI988TcXePwZqBN8CPl3pP1MOhXx2uOJbip07uQr+xpdyP+qaEPCLn8H0NWWnfMw
        ==
X-Google-Smtp-Source: ABdhPJwrCRBKtM+smSuWZ0hjrH9jLuxFaf1GCrGs5+ZBeyi2kL38XmpFgNb+7essxtx7njFVSTtP7uLm7STOEm7lB8A=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:35a1:c171:b6f3:d46c])
 (user=emilyshaffer job=sendgmr) by 2002:a17:902:8605:b0:13f:7c1d:56d1 with
 SMTP id f5-20020a170902860500b0013f7c1d56d1mr47751598plo.57.1636069789989;
 Thu, 04 Nov 2021 16:49:49 -0700 (PDT)
Date:   Thu,  4 Nov 2021 16:49:40 -0700
In-Reply-To: <20211104234942.3473650-1-emilyshaffer@google.com>
Message-Id: <20211104234942.3473650-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211104234942.3473650-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v5 2/4] introduce submodule.superprojectGitDir record
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach submodules a reference to their superproject's gitdir. This allows
us to A) know that we're running from a submodule, and B) have a
shortcut to the superproject's vitals, for example, configs.

By using a relative path instead of an absolute path, we can move the
superproject directory around on the filesystem without breaking the
submodule's cache. And by using the path from gitdir to gitdir, we can
move the submodule within the superproject's tree structure without
breaking the submodule's cache, too. Finally, by pointing at
"get_git_common_dir()" instead of "get_git_dir()", we ensure the link
will refer to the parent repo, not to a specific worktree.

Since this hint value is only introduced during new submodule creation
via `git submodule add`, though, there is more work to do to allow the
record to be created at other times.

If the new config is present, we can do some optional value-added
behavior, like letting "git status" print additional info about the
submodule's status in relation to its superproject, or like letting the
superproject and submodule share an additional config file separate from
either one's local config.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/submodule.txt | 12 +++++++++++
 builtin/submodule--helper.c        |  4 ++++
 t/t7400-submodule-basic.sh         | 32 ++++++++++++++++++++----------
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index ee454f8126..8cc57fe1c1 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -91,3 +91,15 @@ submodule.alternateErrorStrategy::
 	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
 	or `info`, and if there is an error with the computed alternate, the
 	clone proceeds as if no alternate was specified.
+
+submodule.superprojectGitDir::
+	The relative path from the submodule's gitdir to its superproject's
+	common dir. When Git is run in a repository, it usually makes no
+	difference whether this repository is standalone or a submodule, but if
+	this configuration variable is present, additional behavior may be
+	possible, such as "git status" printing additional information about
+	this submodule's status with respect to its superproject. This config
+	should only be present in projects which are submodules, but is not
+	guaranteed to be present in every submodule, so only optional
+	value-added behavior should be linked to it. It is set automatically
+	during submodule creation.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6298cbdd4e..f803812225 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1838,6 +1838,10 @@ static int clone_submodule(struct module_clone_data *clone_data)
 		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
 				       error_strategy);
 
+	git_config_set_in_file(p, "submodule.superprojectGitdir",
+			       relative_path(absolute_path(get_git_common_dir()),
+					     sm_gitdir, &sb));
+
 	free(sm_alternate);
 	free(error_strategy);
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d69a5c0032..3c20d42fbe 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -109,12 +109,24 @@ submodurl=$(pwd -P)
 
 inspect() {
 	sub_dir=$1 &&
+	super_dir=$2 &&
 
 	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
 	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
 	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
 	git -C "$sub_dir" update-index --refresh &&
 	git -C "$sub_dir" diff-files --exit-code &&
+
+	# Ensure that submodule.superprojectGitDir contains the path from the
+	# submodule's gitdir to the superproject's gitdir.
+
+	super_abs_gitdir=$(git -C "$super_dir" rev-parse --path-format=absolute --git-common-dir) &&
+	sub_abs_gitdir=$(git -C "$sub_dir" rev-parse --path-format=absolute --git-common-dir) &&
+
+	[ "$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" = \
+	  "$(test-tool path-utils relative_path "$super_abs_gitdir" \
+						"$sub_abs_gitdir")" ] &&
+
 	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
@@ -138,7 +150,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod &&
+	inspect addtest/submod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -240,7 +252,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch &&
+	inspect addtest/submod-branch addtest &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -256,7 +268,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz &&
+	inspect addtest/dotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -272,7 +284,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz &&
+	inspect addtest/dotslashdotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -288,7 +300,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz &&
+	inspect addtest/slashslashsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -304,7 +316,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod &&
+	inspect addtest/realsubmod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -320,7 +332,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 &&
+	inspect addtest/realsubmod2 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -351,7 +363,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 &&
+	inspect addtest/realsubmod3 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -492,7 +504,7 @@ test_expect_success 'update should work when path is an empty dir' '
 	git submodule update -q >update.out &&
 	test_must_be_empty update.out &&
 
-	inspect init &&
+	inspect init . &&
 	test_cmp expect head-sha1
 '
 
@@ -551,7 +563,7 @@ test_expect_success 'update should checkout rev1' '
 	echo "$rev1" >expect &&
 
 	git submodule update init &&
-	inspect init &&
+	inspect init . &&
 
 	test_cmp expect head-sha1
 '
-- 
2.34.0.rc0.344.g81b53c2807-goog

