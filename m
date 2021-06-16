Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED3C49361
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C58161369
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhFPAr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhFPArZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 20:47:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBA4C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:45:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g9-20020a25ae490000b029052f9e5b7d3fso570593ybe.4
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i6zQVxJDwkeyVQCay7H3LISlaFW4Ee0RtDXk4aJYJ/o=;
        b=qiCx599tVkV2C/hwzcKhraD5EnPlxd4XsB/z1Z6jLzsMKwXb1qwFPmv2kDm/aUALn4
         JdiobQ1AfXhdTA6tqC6xsIYB8zDHl6oUCNSpe/BjdTWcxAibbFsINMAAnpBRk2TPZYXl
         AAMYIY/lYJx5EgYA23dvVo5FowkBZAlifWFiv2NzlK3J0XCW3D3gd/nmJOSzlEVRMJmG
         zSZ02DtWzHVchXFfLxf4NutjAqQbfp7MCDA1cj0+HlX+4GkRfWolWUo7bPSqU7I2kqBC
         wdI2cyg5lwVyNjc/l3vg0egnN/rG7QVnenUvhXRF0IdW+ma1y5/fkbOAb+RXbW2YPs8W
         5Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i6zQVxJDwkeyVQCay7H3LISlaFW4Ee0RtDXk4aJYJ/o=;
        b=CYx7Cgr5+7fgF0BQxFhNV2uCpJzqKsfg4bKPvM5gFmBRtwPJT+2IV7qufETrrIM+kP
         PydpVDgHPuDP9VwGnUq/ZW/n2HoTAYd4y54aVSv3sIEWZW2EMSzauxg0U71W1MhOIVNw
         PHPUCVBTYjC+3VrAEd0HSdiBnLGMjCYlZeNzCxELveKO9IDcWHJ9txxq/LVJGOGc2ece
         7XC0ivykvmIGexDAlINCgidxNF0/jrDtaYRqvB2B3nY+m5CW4AcaikBni5xd+T5fDuzf
         aFgqhZGhJiwCOwwiCtURgYdjuonL7KAbuvI9R9u2FPsyya8Q5WR0EegjKoY+I24NujW3
         RfIQ==
X-Gm-Message-State: AOAM530wEcHoCum8wFLw27ZdBvVzxKlGwCXvpRIzK/Uetb2QHtofDHiQ
        R/OIhLaijzaAliFiABLbrEfojNwVOxLdpteDpwnYZfD3vtpRgjbiZC8tuM5PtZrSHIi1Nb99Q0T
        JNf2JolB/sriTKtZNxAN8pg1uYx2mfQA+GFhtwvPB15UwjjicgSKjJdftdcAMejP+YrU7YhA1Jw
        ==
X-Google-Smtp-Source: ABdhPJxezdHT3T+dPbjELlPJWGsoXcaOhVKLeU5ufqAGdfoZhRiqZLynuAZgRhabM7mEX35qx9IDadL72QwSzDX5lY8=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:d4cc:f4a9:b043:ff6e])
 (user=emilyshaffer job=sendgmr) by 2002:a25:db93:: with SMTP id
 g141mr2824972ybf.141.1623804319784; Tue, 15 Jun 2021 17:45:19 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:45:06 -0700
In-Reply-To: <20210616004508.87186-1-emilyshaffer@google.com>
Message-Id: <20210616004508.87186-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210616004508.87186-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2 2/4] introduce submodule.superprojectGitDir cache
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
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

Since this cached value is only introduced during new submodule creation
via `git submodule add`, though, there is more work to do to allow the
cache to be created at other times.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/config/submodule.txt | 12 +++++++++
 builtin/submodule--helper.c        |  4 +++
 t/t7400-submodule-basic.sh         | 40 ++++++++++++++++--------------
 3 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index d7a63c8c12..7c459cc19e 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -90,3 +90,15 @@ submodule.alternateErrorStrategy::
 	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
 	or `info`, and if there is an error with the computed alternate, the
 	clone proceeds as if no alternate was specified.
+
+submodule.superprojectGitDir::
+	The relative path from the submodule's worktree  to the superproject's
+	gitdir. This config should only be present in projects which are
+	submodules, but is not guaranteed to be present in every submodule. It
+	is set automatically during submodule creation.
++
+	In situations where more than one superproject references the same
+	submodule worktree, the value of this config and the behavior of
+	operations which use it are undefined. To reference a single project
+	from multiple superprojects, it is better to create a worktree of the
+	submodule for each superproject.
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
index f5dc051a6e..e45f42588f 100755
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
 
 
@@ -139,7 +143,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod &&
+	inspect addtest/submod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -230,7 +234,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch &&
+	inspect addtest/submod-branch addtest &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -246,7 +250,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz &&
+	inspect addtest/dotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -262,7 +266,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz &&
+	inspect addtest/dotslashdotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -278,7 +282,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz &&
+	inspect addtest/slashslashsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -294,7 +298,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod &&
+	inspect addtest/realsubmod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -310,7 +314,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 &&
+	inspect addtest/realsubmod2 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -341,7 +345,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 &&
+	inspect addtest/realsubmod3 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -482,7 +486,7 @@ test_expect_success 'update should work when path is an empty dir' '
 	git submodule update -q >update.out &&
 	test_must_be_empty update.out &&
 
-	inspect init &&
+	inspect init . &&
 	test_cmp expect head-sha1
 '
 
@@ -541,7 +545,7 @@ test_expect_success 'update should checkout rev1' '
 	echo "$rev1" >expect &&
 
 	git submodule update init &&
-	inspect init &&
+	inspect init . &&
 
 	test_cmp expect head-sha1
 '
-- 
2.32.0.272.g935e593368-goog

