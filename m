Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00698C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351003AbiBHIkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350645AbiBHIka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:30 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24753C0401F6
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:30 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id n4-20020a17090ade8400b001b8bb511c3bso4418014pjv.7
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IQ/TmO04ivwY6jOcn7+5hzTvbedJJB/armLAxZ1CAiA=;
        b=WfuWMgyVsHynIQZUQpPGtoYqshWoA21B0C7YuqzxZ9gBl+PVr1xBQSWPoorOgeJDV2
         0ozoNRR6VfDPagTgeQbH30fjbKD5TsmSlHanp82McqtWrSZbd2HGu58BwC7sG7g3osCO
         rWsZBtbSSjwlFVPeL6yMx/n7Uo6Lh1VloyJ0ZU11RTVW7/cx/4rGXQBFQM/LEtM6eOGR
         YN6QRUQH6vKDPY6prDfeTTyxLkTDhAWRjqSbxKAB0Iiz1SR1QFGe4aCq1EHOKxPL67Lr
         9JZaGIa5gxYfUm7PFcekI1OTJ31/yx0bHHDmiq4PJUyBz3mF1SrAvrUBSbHB5fxJgw3X
         v9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IQ/TmO04ivwY6jOcn7+5hzTvbedJJB/armLAxZ1CAiA=;
        b=orVLITRk/mW3WxJphygtjy4dBio+gLlrlf6O35vk6ZIU5ZiIFJNXZChc3TgPb1uD85
         YpxfEXq7iEa4i1Vr7rl7YmIEs3ioSGKCWVEJ05YXAbijo/DYmZjWtjkkpHaRR8Gp4rQU
         0i1XwT4pa9bJ0S8QyZIq9lR99u0MTLnxU6S/Ih9h38ZtIWnVZPn6NUwd2PAwywDFZy3p
         1PxJ9aHfMLUpHTfyUzp30/lkz+c6UvsWFNRh5JRZ9vgwdz7d/JljDeYEXgtWar9bn10u
         tU+I8nQb577IqTta0MENx5s5hnl4swTGSdEEjLuk9jjK9AXvUzLlR2G3vXgiQ62LXV8L
         Wz7g==
X-Gm-Message-State: AOAM530UM92GqEyd0EzMcQhpkUvdofHsCmuR+eeLqw+S9q4/zGxV4Rct
        PMi4a7mxzuQAYilWUQELAn3ZzpES7UeDV9WKkGVUiV6/qrCcNy6SHySD8nx8uyZna5R3tR1q/ZT
        gZEqwGhq/Sd/ZkLNdBuSN+MXa5qj+BP5krCJw9yLvnFTungS98QnlPp+lFEij4cQ=
X-Google-Smtp-Source: ABdhPJxBdmTfpwZEZeLh3nBI4cRHCUtPpoUb/Q0qgwIT1NAaMynJ1vNNOnZej3qgzYFdFMouwB9PZc5H5s/YbQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:da85:: with SMTP id
 j5mr3345905plx.81.1644309629248; Tue, 08 Feb 2022 00:40:29 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:49 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-14-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 13/16] submodule--helper: remove ensure-core-worktree
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the logic of "git submodule--helper ensure-core-worktree" into
run-update-procedure. Since the ensure-core-worktree command is
obsolete, remove it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 13 +++----------
 git-submodule.sh            |  2 --
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 15ae986692..a05aea5cd6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2746,17 +2746,11 @@ static int push_check(int argc, const char **argv, const char *prefix)
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
 
@@ -2776,8 +2770,6 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
-
-	return 0;
 }
 
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
@@ -2967,6 +2959,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 /* NEEDSWORK: this is a temporary name until we delete update_submodule() */
 static int update_submodule2(struct update_data *update_data)
 {
+	ensure_core_worktree(update_data->sm_path);
+
 	/* NEEDSWORK: fix the style issues e.g. braces */
 	if (update_data->just_cloned) {
 		oidcpy(&update_data->suboid, null_oid());
@@ -3390,7 +3384,6 @@ static struct cmd_struct commands[] = {
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
-	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 29fd69250d..aa9c898e1c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -373,8 +373,6 @@ cmd_update()
 	do
 		die_if_unmatched "$quickabort" "$sha1"
 
-		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
-
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
 		if test $just_cloned -eq 0
-- 
2.33.GIT

