Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A610CD4F49
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 10:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjIVKm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 06:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjIVKmT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 06:42:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F5CA
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4053c6f1087so8490925e9.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695379328; x=1695984128; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsXsLnOykjLaX7g4y5ZYuiovm+9yawHO2eEXVHN+VtI=;
        b=Bkhm3gQB2QdE+00zIW/NNak8BpzFWMmgoLCGKmYH0Plt/Wt3PWoEUX+A8hXyLPhwMX
         3mtzt16b5Wq9VWqvfaJ9ykqiWwmysRqBHBWkycm0DckQiCWF3OyfBFdcvBCggX7OSc7U
         jbkIoWk8npHJb2njuWjlUayye9wqziyFqAsq7/qzEQxv7ZxWWDbythfL9tZY1CZmq3Ks
         7ZD9V0yBTwyz9q4P/giydgmm37vJltw2AFWIpSU25n4p9WwP8O54Sgb9krK+yE7kGw0/
         FYCbqmJA7El2AaGYVKMgs4POfebrntHz6umbJ9renLbuTvifqU6FbR04a3xXtypYZlCa
         Ztfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695379328; x=1695984128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsXsLnOykjLaX7g4y5ZYuiovm+9yawHO2eEXVHN+VtI=;
        b=JMb7xogczy6M6e2mrT8ALfHI+f1AcOK6BHqvRy0fdhnyLAU/WI87VdHL46AktcqA/b
         oRrQZMDZAT6CT1KWjWbwYV1S9VBH8BdMzcv5T7dfssslaer9YdRqdx9GzOcAnPzK8yhb
         HuX1yuArM81ASpcKgkoY//UZe4GphC6Z7fYShPWwS8TnkMUsVG0y5gujH4wOqUBi5PRD
         RJe3Uuly65FLQcwtQRsvmkKMGNmI89v1oqxX+0QpS0n9YL5AGWRWjHhRAksaZysxsywV
         ha2dqkd5ituGciQX6FTq0hggBUu/SvpaCfsPWWqO+Lh/3/gfZ1pXNW94mHIA9P/k6laL
         HEZg==
X-Gm-Message-State: AOJu0Yzve5ZKItSLMCED/Fe0HMBOE5RKDgfiRmFtlvA029V1E5ZH5s+d
        pLm0iPm9xk6HNSYVJVKjZsvmM4ekxDA=
X-Google-Smtp-Source: AGHT+IEjx37ovLyr/AYSTVLVLZrLPNZevANCqEZHkGToGsA6AozXtQL/VlryTzfLCPk4ilgRCGTIQQ==
X-Received: by 2002:a7b:cd12:0:b0:401:bdd7:499d with SMTP id f18-20020a7bcd12000000b00401bdd7499dmr7673263wmj.25.1695379328201;
        Fri, 22 Sep 2023 03:42:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10-20020a05600c21ca00b004051b994014sm7115425wmj.19.2023.09.22.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:42:08 -0700 (PDT)
Message-ID: <782cf2b440313fcad0492ee352fa66d1a3534ac4.1695379323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 10:42:02 +0000
Subject: [PATCH 5/6] coverity: allow running on macOS
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

For completeness' sake, let's add support for submitting macOS builds to
Coverity Scan.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index 70ba3f97c18..ca51048ed9d 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -42,7 +42,7 @@ jobs:
         if: contains(matrix.os, 'windows')
         uses: git-for-windows/setup-git-for-windows-sdk@v1
       - run: ci/install-dependencies.sh
-        if: contains(matrix.os, 'ubuntu')
+        if: contains(matrix.os, 'ubuntu') || contains(matrix.os, 'macos')
         env:
           runs_on_pool: ${{ matrix.os }}
 
@@ -55,10 +55,17 @@ jobs:
           *windows*)
             COVERITY_PLATFORM=win64
             COVERITY_TOOL_FILENAME=cov-analysis.zip
+            MAKEFLAGS=-j$(nproc)
+            ;;
+          *macos*)
+            COVERITY_PLATFORM=macOSX
+            COVERITY_TOOL_FILENAME=cov-analysis.dmg
+            MAKEFLAGS=-j$(sysctl -n hw.physicalcpu)
             ;;
           *ubuntu*)
             COVERITY_PLATFORM=linux64
             COVERITY_TOOL_FILENAME=cov-analysis.tgz
+            MAKEFLAGS=-j$(nproc)
             ;;
           *)
             echo '::error::unhandled OS ${{ matrix.os }}' >&2
@@ -67,6 +74,7 @@ jobs:
           esac
           echo "COVERITY_PLATFORM=$COVERITY_PLATFORM" >>$GITHUB_ENV
           echo "COVERITY_TOOL_FILENAME=$COVERITY_TOOL_FILENAME" >>$GITHUB_ENV
+          echo "MAKEFLAGS=$MAKEFLAGS" >>$GITHUB_ENV
           MD5=$(curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
                    --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT&md5=1")
           echo "hash=$MD5" >>$GITHUB_OUTPUT
@@ -94,6 +102,16 @@ jobs:
             mkdir $RUNNER_TEMP/cov-analysis &&
             tar -xzf $RUNNER_TEMP/$COVERITY_TOOL_FILENAME --strip 1 -C $RUNNER_TEMP/cov-analysis
             ;;
+          *.dmg)
+            cd $RUNNER_TEMP &&
+            attach="$(hdiutil attach $COVERITY_TOOL_FILENAME)" &&
+            volume="$(echo "$attach" | cut -f 3 | grep /Volumes/)" &&
+            mkdir cov-analysis &&
+            cd cov-analysis &&
+            sh "$volume"/cov-analysis-macosx-*.sh &&
+            ls -l &&
+            hdiutil detach "$volume"
+            ;;
           *.zip)
             cd $RUNNER_TEMP &&
             mkdir cov-analysis-tmp &&
@@ -115,7 +133,7 @@ jobs:
         run: |
           export PATH="$RUNNER_TEMP/cov-analysis/bin:$PATH" &&
           cov-configure --gcc &&
-          cov-build --dir cov-int make -j$(nproc)
+          cov-build --dir cov-int make
       - name: package the build
         run: tar -czvf cov-int.tgz cov-int
       - name: submit the build to Coverity Scan
-- 
gitgitgadget

