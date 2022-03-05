Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE5C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiCEAQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiCEAQM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:16:12 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CD27D10B
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:15:13 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id t12-20020a17090a448c00b001b9cbac9c43so5544343pjg.2
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nTv75O1QKj0WxuZ+P8y/vCHMWsMU3KY2RDJ5GuiS2jM=;
        b=ncSWkA3SUveHUKpEwW9PuTaXz8XgXFSmLh4pQ8BSKTEwzEGZFhJ+uQCq1qMDcLnUOy
         bDrSwi0wThTT8bRZxqa2CxOU8jUHD6nn4/SZQmlq3U4fV/B6u67lAW5eBtRDTMrRMmVe
         NHxTXFOXzIaWuNvKNKZ0ZtJIZmTvqD5k8qYQ31lmqx4CjNfJcSOt11s9EhHnQKHq3ZJV
         HkjXIt8D7oFmrB22rknmOXStxZSMCtiw7/H8llR8mJDb9cz87sq2dlvxVh4bCSUZFRL0
         HEzrtfmXI7xRKDtC992FdYxWEIkmBO/3eOJSDYxdTdg4Uohiw6pgEna3I1p2EB+U2BJg
         2T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nTv75O1QKj0WxuZ+P8y/vCHMWsMU3KY2RDJ5GuiS2jM=;
        b=ENieZLm5eP7K6hP1vCknKc8F0jSN/kRzxnkD0t9X+GEsA78H5GRiOCcj/uqT2Mw5MX
         XsWeyhkKQND7W/Bt/Lotw9v3E2TblphaUGFoleSQUobDBHdIxKJYDbhNe1ToF9QVcCzh
         gyKqPCSSVEUXxB7hZu4+eemmfW4IPBffvNuhKV7bCOi+Tzuxk0UWkm479L8bPahltyef
         Vl7K4du460mOoYYlPvPfMU7DgAkGAjC8eT4N0JUGGu/UYgo7Y/2BhZn0iyz1/aWQg54B
         tsOHlokXVT/wQs3e9pk9R4MgvFD6fam4FCtOqjvmBB5EEKC/PjCb/eHeiM+8D8Xd+kSw
         aZYw==
X-Gm-Message-State: AOAM5314PzQvnbfRavhHDfpOAzLVOyhfhq3djPf9/20ciWhUgamtVsax
        VxuO5F5ISrN1SVTrx8KFWfgVxTi3TV8ngCxwdEhG2869E1ds2kjO517t6At6E9fq1R5z/VaszZQ
        diJDGCr0Ptkam3ZkPe3hiLiJNF+wRNO34gyOtLCVFdEv8nIkGancIa8SnNUcyK4I=
X-Google-Smtp-Source: ABdhPJwvwY1OWCGVP+iA+buwyHiupw+Af+5Ppp2GT4041pLYjrHoAmvGIoNmeoMJhBT2AhJjwaOSGf881KhRRQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:83c5:0:b0:4f6:3575:140 with SMTP id
 j5-20020aa783c5000000b004f635750140mr985961pfn.57.1646439313291; Fri, 04 Mar
 2022 16:15:13 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:59 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-12-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 11/13] submodule--helper: remove ensure-core-worktree
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the logic of "git submodule--helper ensure-core-worktree" into
run-update-procedure, and since this makes the ensure-core-worktree
command obsolete, remove it.

As a result, the order of two operations in git-submodule.sh is
reversed: 'set the value of core.worktree' now happens after the call to
"git submodule--helper relative-path". This is safe - "relative-path"
does not depend on the value of core.worktree.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 12 ++----------
 git-submodule.sh            |  2 --
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 17dabf3d12..296ab80bf2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2783,17 +2783,11 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
+static void ensure_core_worktree(const char *path)
 {
-	const char *path;
 	const char *cw;
 	struct repository subrepo;
 
-	if (argc != 2)
-		BUG("submodule--helper ensure-core-worktree <path>");
-
-	path = argv[1];
-
 	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
 		die(_("could not get a repository handle for submodule '%s'"), path);
 
@@ -2813,8 +2807,6 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
-
-	return 0;
 }
 
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
@@ -3041,6 +3033,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 /* NEEDSWORK: this is a temporary name until we delete update_submodule() */
 static int update_submodule2(struct update_data *update_data)
 {
+	ensure_core_worktree(update_data->sm_path);
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
 	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
@@ -3459,7 +3452,6 @@ static struct cmd_struct commands[] = {
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
-	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 16dea0ca59..51be7c7f7e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -385,8 +385,6 @@ cmd_update()
 	do
 		die_if_unmatched "$quickabort" "$sha1"
 
-		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
-
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
 		if test $just_cloned -eq 0
-- 
2.33.GIT

