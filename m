Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556FCCD4F49
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 10:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjIVKmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjIVKmR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 06:42:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FA6C2
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3214d4ecd39so1797102f8f.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695379328; x=1695984128; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bA5cfszGtYv0OuO2RVRJESFemcwfQHB3A1NAIX4e30w=;
        b=TbDB/s4T3ZhyiIYgM4kCAUyCC5ReFa6DID6Oe+aZ+fJ4eOz/23HX/M3d1G6hb/FrZG
         eTiD3GOSsEjM16S0ORkcyP720KY5p610yRO4KEG5FFF57IPPQxDeZd5c+lSzYFMoHKkl
         kv2F2so+j33vb00m/mIZOzYps84KUxHfzLuFAjo/aRMdtHo6+8BTUnSn37cKdRZZUtJ3
         x0XUl9IVG7/t8nE1Ha3zmZpPgsKDgWhw3j0RrCYqfO2dS+LcPrjpfGIYOLnQi6cdT3AX
         0P6ANBtFTN4dnZuia6MGZ6UyAxVfFC6+1L+k3GMi8XsDGx8zinfEPSF7EWcwWUnP5PJi
         Zy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695379328; x=1695984128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bA5cfszGtYv0OuO2RVRJESFemcwfQHB3A1NAIX4e30w=;
        b=ip8Dlk20Kh7c8b3UYJR+NbEmOB+DBqqvwnJJzmDX3QfKKUoNAMmbb9qwF1kKvU6CE4
         x7I5aaQprc69YtEfxNMxVCaAvs1JZD0RcCA4nYG+rTITylWoPuWX5BuP4xVRdGPw6aBt
         Uo9eLcBIWuI3g9utvFu90C3B8hOAg5aXICktlxDbpC9IJx+QK1XBaNNyuQZkrR4Fb9UP
         rgDFoLUtIT3U8eZQiCG80PwrwZJ2kZQvIiOVBBKV+n+m+Z138yu0i69Fvoa9cXs7NqZt
         3UU3dKyXYsxXPNeYFpg7iLdDkcsQIXQA3efxBW+UL/UdK84Iio4ObUmKl6/zE3BbhNPe
         o3Rw==
X-Gm-Message-State: AOJu0YxsBPg4L/dKoPCqDEYlBXRCQPPT7FWLbfO993HdDhnMfPF8ztCl
        FVlOVwgRNknWVpgWx9ujjNADvm8AJWY=
X-Google-Smtp-Source: AGHT+IHsD2jMYiyMFPjFUjFFpT5SBYFBb8Eh+jbA+32CUdJ7NQUlO/CwxqR0UKx4ltYIP+pcqu00CQ==
X-Received: by 2002:adf:f091:0:b0:320:67:5580 with SMTP id n17-20020adff091000000b0032000675580mr7325008wro.5.1695379327696;
        Fri, 22 Sep 2023 03:42:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14-20020adfe60e000000b003197b85bad2sm4140882wrm.79.2023.09.22.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:42:07 -0700 (PDT)
Message-ID: <14cdefff08244f9b5e2ee1fa2a78cfd3e58c14d2.1695379323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 10:42:01 +0000
Subject: [PATCH 4/6] coverity: support building on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By adding the repository variable `ENABLE_COVERITY_SCAN_ON_OS` with a
value, say, `["windows-latest"]`, this GitHub workflow now runs on
Windows, allowing to analyze Windows-specific issues.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 56 ++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index 8aac00bb20f..70ba3f97c18 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -12,31 +12,61 @@ name: Coverity
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
                    --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT&md5=1")
           echo "hash=$MD5" >>$GITHUB_OUTPUT
@@ -54,13 +84,27 @@ jobs:
         run: |
           curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
             --no-progress-meter \
-            --output $RUNNER_TEMP/cov-analysis.tgz \
+            --output $RUNNER_TEMP/$COVERITY_TOOL_FILENAME \
             --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT"
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

