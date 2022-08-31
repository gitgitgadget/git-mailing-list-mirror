Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8811AECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiHaQDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiHaQCx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:02:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7B3B1B9C
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b5so18878172wrr.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=mbou4husCoj4ysZil9oV2bMlRkeKF7YupR72z0aR9cw=;
        b=JOdauR93UxdcVc0qw+9rSxtKMMSLEc+QgYZID1I/pn9qYPauZL8cnsX7ImGI36pD0g
         rr2cwcbdgzIU2g9nZHBg20ftFosYEfGnduq1ocKiS+1eQgFHCNTAsVl1NoeWepiPD9fo
         pa4ABlW541y8l4wzG5qlZEqZxh21kZWyfNU/AwvzyVqPrc8l4ENxOFUT8BoShxIGb5G8
         ys3cJ4CTLGT0n6NjMnHHZJ9/CQYpuzJ0KeoOQm9crsi474TYHqIB3gcLnKuHJaX56UYa
         oQlObX/gL6rT3AdI04YucEsFRiz9odhdH3rkVk4NfVkwO4m56dmjCJ9i2WcYFDkD439l
         3lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=mbou4husCoj4ysZil9oV2bMlRkeKF7YupR72z0aR9cw=;
        b=0xeVA5wlXETIV9SEdru/Ql7jH9noc/95d6TgQSkoJPPqwyE8XmV065h0TQKbUYRXl9
         q+DPA5jmQGqaQuzsOuIIyGrAot6g2uKtdiAIkaBUwJTFjvkclp8JL+Uwep8HGsM49NHM
         srFhWkzTFR7xqxUVrRmZecFaODQSYem8HBFb8EYYCLAkG4WFFARM8lo46ba4hLzB1pN6
         nje3n/8g8yP/6WmJHMk/gc88aISrUMWyrKsgckbqwpw0nRF3JYxjySuyBM1N2EuYEu5e
         egJRdszJdu6kgwtYgCjtJUN5WMdjiZApzMHnea9y7HIkwZ2s2AD78FrxtPmEmJxNezTj
         dejQ==
X-Gm-Message-State: ACgBeo28XhTKISeuQFHoJvM2SMr1NFiUJBYpn0fuhF+LRBKhCh5rh+Xg
        ey3JLWewCCPHDSj5MCDITkaKlEPotI4=
X-Google-Smtp-Source: AA6agR6cbbCBPOhfLNziROqVKYD7/cjHbTVWS06oQ8U8sJpFrla60a0YnQVs3RqmliLbLhCYl9hlPQ==
X-Received: by 2002:adf:e8cd:0:b0:226:cfa3:82ca with SMTP id k13-20020adfe8cd000000b00226cfa382camr12131598wrn.525.1661961770617;
        Wed, 31 Aug 2022 09:02:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b003a5c999cd1asm3064945wmq.14.2022.08.31.09.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:02:49 -0700 (PDT)
Message-Id: <96e08a95265ea66839b439ce8abc50b34395aaa3.1661961746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:02:24 +0000
Subject: [PATCH 7/8] t/perf: add 'GIT_PERF_USE_SCALAR' run option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a 'GIT_PERF_USE_SCALAR' environment variable (and corresponding perf
config 'useScalar') to register a repository created with any of:

* test_perf_fresh_repo
* test_perf_default_repo
* test_perf_large_repo

as a Scalar enlistment. This is intended to allow a developer to test the
impact of Scalar on already-defined performance scenarios.

Suggested-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/README      |  4 ++++
 t/perf/perf-lib.sh | 13 ++++++++++++-
 t/perf/run         |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/perf/README b/t/perf/README
index fb9127a66f7..8f217d7be7d 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -95,6 +95,10 @@ You can set the following variables (also in your config.mak):
 	Git (e.g., performance of index-pack as the number of threads
 	changes). These can be enabled with GIT_PERF_EXTRA.
 
+    GIT_PERF_USE_SCALAR
+	Boolean indicating whether to register test repo(s) with Scalar
+	before executing tests.
+
 You can also pass the options taken by ordinary git tests; the most
 useful one is:
 
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 27c28017921..b960b0f6301 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -49,6 +49,9 @@ export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_TEST_CMP
 MODERN_GIT=$GIT_BUILD_DIR/bin-wrappers/git
 export MODERN_GIT
 
+MODERN_SCALAR=$GIT_BUILD_DIR/bin-wrappers/scalar
+export MODERN_SCALAR
+
 perf_results_dir=$TEST_RESULTS_DIR
 test -n "$GIT_PERF_SUBSECTION" && perf_results_dir="$perf_results_dir/$GIT_PERF_SUBSECTION"
 mkdir -p "$perf_results_dir"
@@ -120,6 +123,10 @@ test_perf_create_repo_from () {
 			# status" due to a locked index. Since we have
 			# a copy it's fine to remove the lock.
 			rm .git/index.lock
+		fi &&
+		if test_bool_env "$GIT_PERF_USE_SCALAR" false
+		then
+			"$MODERN_SCALAR" register
 		fi
 	) || error "failed to copy repository '$source' to '$repo'"
 }
@@ -130,7 +137,11 @@ test_perf_fresh_repo () {
 	"$MODERN_GIT" init -q "$repo" &&
 	(
 		cd "$repo" &&
-		test_perf_do_repo_symlink_config_
+		test_perf_do_repo_symlink_config_ &&
+		if test_bool_env "$GIT_PERF_USE_SCALAR" false
+		then
+			"$MODERN_SCALAR" register
+		fi
 	)
 }
 
diff --git a/t/perf/run b/t/perf/run
index 55219aa4056..33da4d2aba2 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -171,6 +171,9 @@ run_subsection () {
 	get_var_from_env_or_config "GIT_PERF_MAKE_COMMAND" "perf" "makeCommand"
 	get_var_from_env_or_config "GIT_PERF_MAKE_OPTS" "perf" "makeOpts"
 
+	get_var_from_env_or_config "GIT_PERF_USE_SCALAR" "perf" "useScalar" "--bool"
+	export GIT_PERF_USE_SCALAR
+
 	get_var_from_env_or_config "GIT_PERF_REPO_NAME" "perf" "repoName"
 	export GIT_PERF_REPO_NAME
 
-- 
gitgitgadget

