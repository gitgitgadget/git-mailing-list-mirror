Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9739C001B5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbiIBQLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbiIBQLA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:11:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51496140F6
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 09:04:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso3584056wmh.5
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=DlLRAX/66uC6N+i/79O4L262ADYw9aS5EPDC0QOrTfk=;
        b=gSYi0H3WEGhVd1H4n178N9yKWm4bMP118qjYCg932vl7Pu0P8IU5KEOzzezKeCOLBn
         uvCYCzjIOu7WmV31Q6KGLckfF0HMZpuJYvYvAjrZRav+7R9WqI1zy8r/mbqPnqewqnHh
         Sn/Z0bWrpI4uol2If+sPPigVIDQwJrVyXmMFrfnXJzqrMJKF9imPdG85eBi3wBytNvX3
         tWPKWKLz43+Yoq2cZ53Kae7hfH5ny9BUpOyMHSS8K7mTvIz1SQld+ADmNARZ6dDsG21E
         R9Ugb8TkGGq+aMB+qaFtB218Z1tdR8KEI2J2yFxNK3+zGAiP3KmKivOfFtyPSWiBSDk3
         EQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DlLRAX/66uC6N+i/79O4L262ADYw9aS5EPDC0QOrTfk=;
        b=mC1ZIAd4/blpWU9qSufJwQ+SWLwsD3v0RIxaCF2CUDSbwWUz66WWvxLYSvIwyuelFc
         +spRfHfnOczVcZl1CBTkXTe7TqNvw/gdB0HNO1i4XwWZWK3IokmDu0TfvmyvtYT2DWGz
         H5tWZJTkfe7Qv3suNVSHCL6Gx72KBtookdWReTv6ftH15XIR98yDaAPhfTrE/KnJQlG/
         OcfW+kzetRfNP/UKZ/xQFqR6L9oNAdUM5VMGfOMSN4ERoqee7PCjByRWKu6qIDpMmpRZ
         DBD4753Pyg5oG8t9+Q3KnWNs36dzdedbu2+zL8vVmjwwCxFeMUi81wSm7LNPfSzzVj1w
         sg1g==
X-Gm-Message-State: ACgBeo1Hp6q7WYzaMXr4dSUyCR6Hz8PxHbrK+CT0TgXrq6gYI3JrgeBG
        rvGelGyCXhblCF/EW29t7gPlpk9uq9I=
X-Google-Smtp-Source: AA6agR5ST0Kr5f7R+Z3lm68EjDiJVYIRRSDzlrlR96DHj8OBtFVZdhQMQC0e1xEq13pIiUmbiZhZIA==
X-Received: by 2002:a05:600c:5028:b0:3a8:4349:153c with SMTP id n40-20020a05600c502800b003a84349153cmr3334686wmr.130.1662134220664;
        Fri, 02 Sep 2022 08:57:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k36-20020a05600c1ca400b003a5f3de6fddsm10345124wms.25.2022.09.02.08.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:57:00 -0700 (PDT)
Message-Id: <2e6dd03beba221e68f1af71aabf17e63541401db.1662134210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
        <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 15:56:49 +0000
Subject: [PATCH v2 8/9] t/perf: add 'GIT_PERF_USE_SCALAR' run option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
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
index 27c28017921..e7786775a90 100644
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
+		if test_bool_env GIT_PERF_USE_SCALAR false
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
+		if test_bool_env GIT_PERF_USE_SCALAR false
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

