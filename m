Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B6DC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiCCA6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiCCA6i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:38 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E044151D19
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:57:52 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t68-20020a635f47000000b003732348b971so1897004pgb.7
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HM/UFTvzycLuEtiSNLNKftDfScVvaGAHyX0/2+0MI0U=;
        b=ZAS4j6oJU6GQyERqDf9j+ivsdQexnQVTa+D4K2z6t9YjibCTy7I0uMILZGISYZsL6A
         aQ8S/xDuOgarr2OUApGcqFz6G4OWTUmDVOAProwenOEw8PJnLBzIn7+uoZPLSac2qozN
         CYFnL/SlXLUDikPWEjK8qDQUZZcMsIfnozOMyKB6V/a/CTx5UBCiyXfyTjf8j1ByPKB7
         JFAnoHfAPBd3vtcJSW5XTXQbCg55ebqtYo7NTGLAKQc/fMHC5+Thvgu4BIfEg2vtiRwK
         eXb5QJXzGRCHnCAxY+RWzqbRR9O+tGTOvWYfH24xp+xmV8gRFM7vU0AdB8hNtWv2khve
         SY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HM/UFTvzycLuEtiSNLNKftDfScVvaGAHyX0/2+0MI0U=;
        b=J3auJKDvv7thJGVMiSoNqItSfb/CxE2MpVwL/LbBtYzp3tDV1j04ksnUwlcrO+RDkz
         FA+KueRN1aLbpzMyw8DC+5IyPJ3HHpNsSYRdpbnLs0/fi3JtKi7oD1ff1mHVMm3pf7SH
         7DbBLKpV25UmV2DqIQiMmIGohRBQm7KB1zSqvdGI+luoyxIMABWEPtXbKlCbLlIjPUKw
         Th0AqkR+pDQTwYsMIlwtgItH8P5IIalsnaLqbWxIEHPdGCdq/i8EsEf2qeuTZuLhiEwz
         IKyadX34jY8N80yKYrOCziCp+mp5Msge1naSr2CUALGjOkXK+ipOKKnNzsafPHu0EEZI
         NSMg==
X-Gm-Message-State: AOAM533VGshsOKKxDTsRBsyjtKZ/M4kLAgI4+/JDhbtwQ3omwB+kSSLM
        1SoM/pmmTHxRb+3JaHy2mIWn7se1pJdyEhqUTlCBjzxi+7JMC41oAo4CzII+4tPovnGk1CZd/m0
        4WcjODmnZrh9RPQMdb3pnjBh+CchojpAJ2yrmV0RNBHMzfYpIRxYhQ79b3rqLQjk=
X-Google-Smtp-Source: ABdhPJxpZ1QskT39WaGrY3+7L5bSmLKM4JdvocbJrruXVJsmhG9a4Ta+rukDiy4RzVR3OkfIZ6d7ExUZAjJ0YA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4f43:b0:1bc:7e5c:e024 with SMTP
 id pj3-20020a17090b4f4300b001bc7e5ce024mr830864pjb.0.1646269071318; Wed, 02
 Mar 2022 16:57:51 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:19 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 05/13] submodule--helper: remove ensure-core-worktree
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
run-update-procedure. Since the ensure-core-worktree command is
obsolete, remove it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 12 ++----------
 git-submodule.sh            |  2 --
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 77ca4270f4..6b473fc0d2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2771,17 +2771,11 @@ static int push_check(int argc, const char **argv, const char *prefix)
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
 
@@ -2801,8 +2795,6 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
-
-	return 0;
 }
 
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
@@ -3029,6 +3021,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 /* NEEDSWORK: this is a temporary name until we delete update_submodule() */
 static int update_submodule2(struct update_data *update_data)
 {
+	ensure_core_worktree(update_data->sm_path);
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
 	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
@@ -3428,7 +3421,6 @@ static struct cmd_struct commands[] = {
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
-	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 32a09302ab..458ce73ac6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -402,8 +402,6 @@ cmd_update()
 	do
 		die_if_unmatched "$quickabort" "$sha1"
 
-		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
-
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
 		if test $just_cloned -eq 0
-- 
2.33.GIT

