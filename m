Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB69CE7A81
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIYLvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjIYLvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:51:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBFDCF
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4053cf48670so49176995e9.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695642667; x=1696247467; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8izrTrOYmaFplwkN4Q1TaOq60ja4Yn5W1h0K1WMd7Qo=;
        b=GiKugahWZj1Rpkp0GfyDKfUaAJCHovS6CUIWwI5Q31AZC9JvlmDjBlOhCecOwpbqE5
         VdcL75TkYbIdts/ojYWw60vG2M3a+RCnP4588uRysOCwJHuxpHNGlE7XKwHnFMtyCXZQ
         dSN4sSWaEPR3hb38Hr/t36FDG9Mk2ioDpV3KN6aQETil3WY/JFAol7O7MtLe+S4iz2Tu
         5wN+UbHu8DbmSC6E855Q7NiI6OyXNgO0DU3mJv/6LqrB4B7wPC8UMtxMsKpSUIizg1nA
         HdNrhHCGp5zabjc7NSQkENP/7IQTXSCFjY9djWunhqJs1l71oMck5jr1yZLd7WSwBde8
         T35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642667; x=1696247467;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8izrTrOYmaFplwkN4Q1TaOq60ja4Yn5W1h0K1WMd7Qo=;
        b=glZ0DQ8ciJtLXcHPGdfzg+QJgUKY18eFql9sJZp/Rt6i2KIJTGLynEmFD3dDoV0bc4
         OeWYdXloG8IVO1u4ddmlkZ8CQA8u72yAEQSNcIkqLLm44UENSUOtnnHdxp2y5thNvXj2
         yGKy+oOtoyui2oZG4iz8PVxA97PiX/RZF1q8vQtun3H53aiH235zestMmzd2zn5y0Wj1
         qdkXxib9UoN3+DHW4WzzDCh26jKHA84rASZg++FqxgQ6q9Xb3k6RNkpBKOasm/caeHJy
         MfQa+bZWuzJuWAxcjbrvgfIdY69709OuUvFwcmHpUGUBJWcBMzaobF+63BkhICIu6fwW
         wZRw==
X-Gm-Message-State: AOJu0Yzb6v/et6aGYhmn5Eno0LG2bQ3Tufi3svKbQz1hH6Wl4m5nrHSn
        4tA592yHlfPDjx1R9oRMFwsCDKElXqQ=
X-Google-Smtp-Source: AGHT+IEHCq9irKVT9d2pXDsQlQLV7UY6yGGxpQJ3TKaXt0J5qUf6h1glKOhw3SIbfSk8PnevxD0WgA==
X-Received: by 2002:a7b:c4d1:0:b0:405:36d7:4581 with SMTP id g17-20020a7bc4d1000000b0040536d74581mr6158025wmk.9.1695642666989;
        Mon, 25 Sep 2023 04:51:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10-20020adffc8a000000b003176c6e87b1sm11713552wrr.81.2023.09.25.04.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:51:06 -0700 (PDT)
Message-ID: <3d24b6f3b22f0c3b283f1c7a853c7784342588ad.1695642662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
        <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:51:01 +0000
Subject: [PATCH v2 5/6] coverity: allow running on macOS
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

For completeness' sake, let's add support for submitting macOS builds to
Coverity Scan.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index ca364c3d692..53f9ee6a418 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -43,7 +43,7 @@ jobs:
         if: contains(matrix.os, 'windows')
         uses: git-for-windows/setup-git-for-windows-sdk@v1
       - run: ci/install-dependencies.sh
-        if: contains(matrix.os, 'ubuntu')
+        if: contains(matrix.os, 'ubuntu') || contains(matrix.os, 'macos')
         env:
           runs_on_pool: ${{ matrix.os }}
 
@@ -56,10 +56,17 @@ jobs:
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
@@ -68,6 +75,7 @@ jobs:
           esac
           echo "COVERITY_PLATFORM=$COVERITY_PLATFORM" >>$GITHUB_ENV
           echo "COVERITY_TOOL_FILENAME=$COVERITY_TOOL_FILENAME" >>$GITHUB_ENV
+          echo "MAKEFLAGS=$MAKEFLAGS" >>$GITHUB_ENV
           MD5=$(curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
                    --fail \
                    --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
@@ -99,6 +107,16 @@ jobs:
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
@@ -120,7 +138,7 @@ jobs:
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

