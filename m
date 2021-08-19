Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC6DC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AD0610CF
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhHSUKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhHSUKn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:10:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0220EC061757
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:10:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b127-20020a25e485000000b005943f1efa05so7670704ybh.15
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CN/DOpPuJ1P1FOpYJ/QGBoBm1MZNCH2SXA7GrbHEwnc=;
        b=J5SsIyQhQJpp4a+Az9djjKeA1hithCFJ9XRx/AtRXhM6b1K09QL4KM2VlLsV/uNHMm
         XGw0bjtQkmRMcpi58ZDSQsvuHugtFoJIUfRbRW3zAKOa5kOXNmfFvOBiDr5iIA2ffaP2
         S8FGHBfP91Z+JVAXjxUO+MVmhY7psa4QBl0TVAPlELvPHeF312Zv2r2BhIIdyP6ARN9m
         iVvJAM+4Gxt1qxVBss65qCwfpORrZrWxwNfte9VblIKPJsKPcvhJ1ydd5oePwMPE9JVM
         kQnlu97szt7Ob/dvew704vQZjFePnK+nlmUjSeHaffQoq7EjOovDeV62cWnPd6DqzL9A
         C6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CN/DOpPuJ1P1FOpYJ/QGBoBm1MZNCH2SXA7GrbHEwnc=;
        b=uMJPCvuwyI/GChJ+5mzm6ZNoNPgW4bUoZWXju9u1lHh4m7KtjJsSBXz5MXA6winK4I
         Fc2+Fs0UYjeEvOvDO41GrsBnVNSScm//5tstnn9tU5tGD7EYS0u3aD1MxMZQtqOtHIcN
         qeD/q/XIQCr9lBCHiqid7wFbEuQ3sYgYdJiCy4HT73SCUy7MbVaH3Vear52/67DHH681
         dLFEDxUGpcnKFOfo9AaKbZh2VQZBxQmyw6AKhXMSFoIBb+2oNG04ZDbWjs2EOaCeuYkV
         VRb7c4/rNi3U6ycnBIAoBbyr7iuMNBxBPEv/sFh+OvfxYiQ13GSqj6EX/M1PQaUtET4t
         sd/g==
X-Gm-Message-State: AOAM531XLUuSeGl4Hd+Y1c/EMmKxGBr10GrSQRgqNTJAVX9KLlBjtO3F
        z8EQq62JF1v18F4B+En/piwz5RGtYa3WpTodeiDq8664J99KJlTd1P2O0M8Hw+bvP78WkmOd+jB
        b5E/vOewV5bhh73sRmhR5ICdfL3UIlETQ4fTZbSX87DSLeeYJtWVX8XmdsaUL2VwHSzhrTSBC+g
        ==
X-Google-Smtp-Source: ABdhPJyyI+yM+umMPqXDxnh5jIvv4liSzj1H2mEBbNjn6Fi0CZ3xPVRQRPQVm7rAIIdPSijwbqhz56qhb6REquzzm2E=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
 (user=emilyshaffer job=sendgmr) by 2002:a25:818a:: with SMTP id
 p10mr20214870ybk.363.1629403806197; Thu, 19 Aug 2021 13:10:06 -0700 (PDT)
Date:   Thu, 19 Aug 2021 13:09:51 -0700
In-Reply-To: <20210819200953.2105230-1-emilyshaffer@google.com>
Message-Id: <20210819200953.2105230-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210819200953.2105230-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 2/4] introduce submodule.superprojectGitDir record
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
submodule's cache.

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
 Documentation/config/submodule.txt | 15 +++++++++++
 builtin/submodule--helper.c        |  4 +++
 t/t7400-submodule-basic.sh         | 40 ++++++++++++++++--------------
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index d7a63c8c12..23e0a01d90 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -90,3 +90,18 @@ submodule.alternateErrorStrategy::
 	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
 	or `info`, and if there is an error with the computed alternate, the
 	clone proceeds as if no alternate was specified.
+
+submodule.superprojectGitDir::
+	The relative path from the submodule's worktree to its superproject's
+	gitdir. When Git is run in a repository, it usually makes no difference
+	whether this repository is standalone or a submodule, but if this
+	configuration variable is present, additional behavior may be possible,
+	such as "git status" printing additional information about this
+	submodule's status with respect to its superproject. This config should
+	only be present in projects which are submodules, but is not guaranteed
+	to be present in every submodule, so only optional value-added behavior
+	should be linked to it. It is set automatically during
+	submodule creation.
++
+	Because of this configuration variable, it is forbidden to use the
+	same submodule worktree shared by multiple superprojects.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9..d60fcd2c7d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1910,6 +1910,10 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
 					   error_strategy);
 
+	git_config_set_in_file(p, "submodule.superprojectGitdir",
+			       relative_path(absolute_path(get_git_dir()),
+					     path, &sb));
+
 	free(sm_alternate);
 	free(error_strategy);
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 4bc6b6c886..e407329d81 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -108,14 +108,18 @@ test_expect_success 'setup - repository to add submodules to' '
 submodurl=$(pwd -P)
 
 inspect() {
-	dir=$1 &&
-
-	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
-	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
-	git -C "$dir" rev-parse HEAD >head-sha1 &&
-	git -C "$dir" update-index --refresh &&
-	git -C "$dir" diff-files --exit-code &&
-	git -C "$dir" clean -n -d -x >untracked
+	sub_dir=$1 &&
+	super_dir=$2 &&
+
+	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
+	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
+	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
+	git -C "$sub_dir" update-index --refresh &&
+	git -C "$sub_dir" diff-files --exit-code &&
+	cached_super_dir="$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" &&
+	[ "$(git -C "$super_dir" rev-parse --absolute-git-dir)" \
+		-ef "$sub_dir/$cached_super_dir" ] &&
+	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
 test_expect_success 'submodule add' '
@@ -138,7 +142,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod &&
+	inspect addtest/submod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -229,7 +233,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch &&
+	inspect addtest/submod-branch addtest &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -245,7 +249,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz &&
+	inspect addtest/dotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -261,7 +265,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz &&
+	inspect addtest/dotslashdotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -277,7 +281,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz &&
+	inspect addtest/slashslashsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -293,7 +297,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod &&
+	inspect addtest/realsubmod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -309,7 +313,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 &&
+	inspect addtest/realsubmod2 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -340,7 +344,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 &&
+	inspect addtest/realsubmod3 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -481,7 +485,7 @@ test_expect_success 'update should work when path is an empty dir' '
 	git submodule update -q >update.out &&
 	test_must_be_empty update.out &&
 
-	inspect init &&
+	inspect init . &&
 	test_cmp expect head-sha1
 '
 
@@ -540,7 +544,7 @@ test_expect_success 'update should checkout rev1' '
 	echo "$rev1" >expect &&
 
 	git submodule update init &&
-	inspect init &&
+	inspect init . &&
 
 	test_cmp expect head-sha1
 '
-- 
2.33.0.rc2.250.ged5fa647cd-goog

