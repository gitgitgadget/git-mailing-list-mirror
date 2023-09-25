Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3292DCE7A95
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjIYLvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIYLvP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:51:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75319B
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so60915685e9.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695642667; x=1696247467; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyNh0zRTxdTKtNkjtPjN/XLMG5sIRaX5/80rLtGGo1Q=;
        b=bJAWI7OhkYoWTMq/+SZ6neU2QyZik8UUCvbqM9TF4bOVlBwnbORu07a12DO7tcXxGN
         tfzM1WMRJYfTjXqxXxTVrW00yEory6ExmM4KvtBfL56dhjkFjWMS9AB52Lw+sv9NFPef
         zNtMA3L/3eJpKbfiGLOm5mbWqACAv9LIEtyQ4EOKZglfTqRTNjgcNDgOwJ1K/5bVJx7h
         7yHx+hq7O3zJh30mRV45f1ZHYpUvhOKWMAqkbLqxBet9UOXlDxxSGtcDvO+SWaHe87Em
         SCdMAHa4ggKvoZPBpgusVkEA8glh5UgIfFmFrID/BltBvvptx0RAtOoJtfhSVsmgIfYH
         TsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642667; x=1696247467;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyNh0zRTxdTKtNkjtPjN/XLMG5sIRaX5/80rLtGGo1Q=;
        b=ckFwHz1eT6fp/gU3Ps96+aDsuidfSYqiOCiwMbGz1EXCzWvKpxccPr4SRXs66W04Dn
         T3LKrbC+eT8xBNptpXz+8J+XonWrRo5oRYpWKEe1fQdKDwfVM5Asx1SbWSz+3aurKEQw
         aPmeBEQzipoxbYKg+4nPUNyYrCp3h0IJjgejvQpFFLZWjrQtYThKdnRQKf4R0Waa4Np1
         FOUSViHGp2XbbOKgMEkiN5AnVVICmlIFPFgbKPYkKO/Opalzsn8LEIoO3NDCRoepqh2P
         difEcofRWdZNUVUlMsLKmCLQWIf51/h+C4O1Fn92Kuw9UMF9Dykzx3rG511WqjgPjyXc
         MZ2Q==
X-Gm-Message-State: AOJu0YwZ48q0R87IMj8zUhkUJBjtx5pyxiqmsa7JELspheYeqMUVnFu8
        8QeF1t1+R0ytemiQFsYAo2zR32M4ibo=
X-Google-Smtp-Source: AGHT+IHzSBnPTCOrliBVuuYLbJV0VvAEOd6b43vki3MJGcqXJOvXLkudx6NHBu3ibKcz5dwfvvTGyQ==
X-Received: by 2002:a7b:c3d2:0:b0:405:3252:fe2 with SMTP id t18-20020a7bc3d2000000b0040532520fe2mr5411779wmj.14.1695642666386;
        Mon, 25 Sep 2023 04:51:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d4d81000000b003215c6e30cbsm11537507wru.104.2023.09.25.04.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:51:06 -0700 (PDT)
Message-ID: <84e1c3eede822cda4fc839080c9d9929df104ee3.1695642662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
        <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:51:00 +0000
Subject: [PATCH v2 4/6] coverity: support building on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By adding the repository variable `ENABLE_COVERITY_SCAN_ON_OS` with a
value, say, `["windows-latest"]`, this GitHub workflow now runs on
Windows, allowing to analyze Windows-specific issues.

This allows, say, the Git for Windows fork to submit Windows builds to
Coverity Scan instead of Linux builds.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 57 ++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index 55a3a8f5acf..ca364c3d692 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -12,31 +12,62 @@ name: Coverity
 # email to which the Coverity reports should be sent and the latter can be
 # obtained from the Project Settings tab of the Coverity project).
 #
+# The workflow runs on `ubuntu-latest` by default. This can be overridden by setting
+# the repository variable `ENABLE_COVERITY_SCAN_ON_OS` to a JSON string array specifying
+# the operating systems, e.g. `["ubuntu-latest", "windows-latest"]`.
+#
 # By default, the builds are submitted to the Coverity project `git`. To override this,
 # set the repository variable `COVERITY_PROJECT`.
 
 on:
   push:
 
+defaults:
+  run:
+    shell: bash
+
 jobs:
   coverity:
     if: contains(fromJSON(vars.ENABLE_COVERITY_SCAN_FOR_BRANCHES || '[""]'), github.ref_name)
-    runs-on: ubuntu-latest
+    strategy:
+      matrix:
+        os: ${{ fromJSON(vars.ENABLE_COVERITY_SCAN_ON_OS || '["ubuntu-latest"]') }}
+    runs-on: ${{ matrix.os }}
     env:
       COVERITY_PROJECT: ${{ vars.COVERITY_PROJECT || 'git' }}
       COVERITY_LANGUAGE: cxx
-      COVERITY_PLATFORM: linux64
+      COVERITY_PLATFORM: overridden-below
     steps:
       - uses: actions/checkout@v3
+      - name: install minimal Git for Windows SDK
+        if: contains(matrix.os, 'windows')
+        uses: git-for-windows/setup-git-for-windows-sdk@v1
       - run: ci/install-dependencies.sh
+        if: contains(matrix.os, 'ubuntu')
         env:
-          runs_on_pool: ubuntu-latest
+          runs_on_pool: ${{ matrix.os }}
 
       # The Coverity site says the tool is usually updated twice yearly, so the
       # MD5 of download can be used to determine whether there's been an update.
       - name: get the Coverity Build Tool hash
         id: lookup
         run: |
+          case "${{ matrix.os }}" in
+          *windows*)
+            COVERITY_PLATFORM=win64
+            COVERITY_TOOL_FILENAME=cov-analysis.zip
+            ;;
+          *ubuntu*)
+            COVERITY_PLATFORM=linux64
+            COVERITY_TOOL_FILENAME=cov-analysis.tgz
+            ;;
+          *)
+            echo '::error::unhandled OS ${{ matrix.os }}' >&2
+            exit 1
+            ;;
+          esac
+          echo "COVERITY_PLATFORM=$COVERITY_PLATFORM" >>$GITHUB_ENV
+          echo "COVERITY_TOOL_FILENAME=$COVERITY_TOOL_FILENAME" >>$GITHUB_ENV
           MD5=$(curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
                    --fail \
                    --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
@@ -57,14 +88,28 @@ jobs:
         run: |
           curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
             --fail --no-progress-meter \
-            --output $RUNNER_TEMP/cov-analysis.tgz \
+            --output $RUNNER_TEMP/$COVERITY_TOOL_FILENAME \
             --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
             --form project="$COVERITY_PROJECT"
       - name: extract the Coverity Build Tool
         if: steps.cache.outputs.cache-hit != 'true'
         run: |
-          mkdir $RUNNER_TEMP/cov-analysis &&
-          tar -xzf $RUNNER_TEMP/cov-analysis.tgz --strip 1 -C $RUNNER_TEMP/cov-analysis
+          case "$COVERITY_TOOL_FILENAME" in
+          *.tgz)
+            mkdir $RUNNER_TEMP/cov-analysis &&
+            tar -xzf $RUNNER_TEMP/$COVERITY_TOOL_FILENAME --strip 1 -C $RUNNER_TEMP/cov-analysis
+            ;;
+          *.zip)
+            cd $RUNNER_TEMP &&
+            mkdir cov-analysis-tmp &&
+            unzip -d cov-analysis-tmp $COVERITY_TOOL_FILENAME &&
+            mv cov-analysis-tmp/* cov-analysis
+            ;;
+          *)
+            echo "::error::unhandled archive type: $COVERITY_TOOL_FILENAME" >&2
+            exit 1
+            ;;
+          esac
       - name: cache the Coverity Build Tool
         if: steps.cache.outputs.cache-hit != 'true'
         uses: actions/cache/save@v3
-- 
gitgitgadget

