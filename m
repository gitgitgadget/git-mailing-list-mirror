Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C605DC64EC4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 13:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCCNrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 08:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjCCNrC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 08:47:02 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EBF5B5D9
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 05:47:01 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id kb15so2572060pjb.1
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W03RoJhsOmVMS8ruNuS10GF6aIF7BhfATmyrZaGW82s=;
        b=RhTJB/jqLgu0mOWe4JfJ+56EP8XyMQq2/ZVgw9h0e3S869LI8/kCzwWiNunVNa9tVw
         Iqmr6t6lxutBip6Bg6gQPZ9WUKkioqGnbWhQv3yLCazH2HOI24Pu4u9AjT+rdD2TN5s9
         18eMF++B8MRdJgMdj6H+yYNXPVzwOuNUKgXdeCne32BIWtEUz5z5iGKjQJzeoIoEgbSL
         UKTati236T5FiHcOo1QRqPue9k4l/9wMswGKc/Bzud40mi+XI4JVxFPx2+n6UIrbyJwF
         HBCY0bi44SmFLNO6J2243cigm/ehoUueZ0ltZfje3tw4DimecO6k7R1zuV2t15axpFvK
         8l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W03RoJhsOmVMS8ruNuS10GF6aIF7BhfATmyrZaGW82s=;
        b=r2RS7zS5y42MG8qe4lc3mvrUjNpcoss+69zR4lvAgdiKLC/NbRKV4c/8d1lWP0DSSI
         tDH4edAJPBciaHc5kPKRdZjnsUkAm0eIS+erSu/d2EeiWCvXjVm8bNhhgSdAikO5FbNl
         hAsJpnVrBFJ6/dH0AhviRLgAzSVo3RT8W9FQPbxLZs4UR43FM9tjltzRVFNTQTw3gtjG
         7hcatpShsBII1sszl5emibg303VA2vyb0Hl4yNx5beh9YhguaQlCiHN69sfODsg7R6FV
         lBdheLgFaXfblk7cUPItO9Mr1DQd1C1YePUjoXYNP8XWmkSLRdAkqiHbveEHqgqwZnOT
         PCGQ==
X-Gm-Message-State: AO0yUKXkP+SbugE10YFVRcSQEI1nEb/syI8ewrcoxp/uXUqkju/bABrD
        WtgPKTfqxGDCTrfVgdHJKFLP2BDjFpQ=
X-Google-Smtp-Source: AK7set+yhR/4MU3SH77O9aYSbPNi9mgYKf1ofVLQLrgm7dTptnwUy+ajzQjOk3qYsKKHH8wo5aRc/w==
X-Received: by 2002:a17:90b:4b41:b0:234:86a5:f800 with SMTP id mi1-20020a17090b4b4100b0023486a5f800mr1688013pjb.34.1677851221084;
        Fri, 03 Mar 2023 05:47:01 -0800 (PST)
Received: from localhost.localdomain ([113.172.118.59])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090aab1500b00234465cd2a7sm1536138pjq.56.2023.03.03.05.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:47:00 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 4/4] ci: add arm64 CI environment via CircleCI
Date:   Fri,  3 Mar 2023 20:46:06 +0700
Message-Id: <db5c58fb3ee114b56f110dcd20f938e77d8b476f.1677850518.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.2.gd15644fe02
In-Reply-To: <cover.1677850517.git.congdanhqx@gmail.com>
References: <cover.1677850517.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .circleci/config.yml | 17 +++++++++++++++++
 ci/lib.sh            | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 .circleci/config.yml

diff --git a/.circleci/config.yml b/.circleci/config.yml
new file mode 100644
index 0000000000..2f5e0966b7
--- /dev/null
+++ b/.circleci/config.yml
@@ -0,0 +1,17 @@
+# .circleci/config.yml
+jobs:
+  build:
+    machine:
+      image: ubuntu-2004:2022.04.1
+    resource_class: arm.medium
+    environment:
+      jobname: linux-gcc
+      runs_on_pool: ubuntu-arm64
+    steps:
+    - checkout
+    - run: ci/install-dependencies.sh
+    - run:
+        name: Build and Tests
+        command: ci/run-build-and-tests.sh
+    - store_test_results:
+        path: t/out
diff --git a/ci/lib.sh b/ci/lib.sh
index 3c19267a56..8b0c727950 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -201,6 +201,25 @@ then
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test windows != "$CI_OS_NAME" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+elif test "$CIRCLECI" = true
+then
+	CI_TYPE=circleci
+	CI_BRANCH="$CIRCLE_BRANCH"
+	CI_COMMIT="$CIRCLE_SHA1"
+	CI_JOB_ID="$CIRCLE_WORKFLOW_JOB_ID"
+	CI_JOB_NUMBER="$CIRCLE_BUILD_NUM"
+	CI_OS_NAME="$(echo "$AGENT_OS" | tr A-Z a-z)"
+	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
+	CI_REPO_SLUG="$(expr "$CIRCLE_REPOSITORY_URL" : '.*:\([^/]*/[^/]*\)\.git$')"
+	CC="${CC:-gcc}"
+
+	# use a subdirectory of the cache dir (because the file share is shared
+	# among *all* phases)
+	cache_dir="$HOME/none"
+
+	export GIT_PROVE_OPTS="--timer --jobs 10"
+	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
+	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 else
 	echo "Could not identify CI type" >&2
 	env >&2
-- 
2.40.0.rc1.2.gd15644fe02

