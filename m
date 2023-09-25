Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA3ACE7A95
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjIYLvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjIYLvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:51:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F1E100
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40572aeb673so29080655e9.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695642665; x=1696247465; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqRPI1cr69T5BQVFCiu5MdAHf2PZervoXEK4p0iX26k=;
        b=PJHoHXZJsFvrKn6hjE9g3JELPZUxXzLgWovk46rVn9TqFNydP615XQoySylM1oY4TL
         hT12Tt+qFL/05b4wbjDinZwrXPQP7xK+MkqMGtsP3yBUGad2mNh67D8GEQ1iead5VUit
         xWxrCLzbC/zIddj3rIy2pI73Y80J5nnAi2pBFpMhak9hTT+RPCvmSOggqS7J4pUamOgi
         FOzcEAVIiTSSA40xlFQLJz2ufSmc/lp1KkEAfkCyfIC4Gfe6Pm2Id9/5v1pVEB6SsiNG
         mo1tHX0JlbB1vnNda+MhHdYUYSPx3w37fmfw4JGqgTU3pSHykF5j0lToGImIg8jcX1h6
         eUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642665; x=1696247465;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqRPI1cr69T5BQVFCiu5MdAHf2PZervoXEK4p0iX26k=;
        b=os/mOWLV+NpiJ34O+RiXuwob9xg5vEv0yo5epZwvRLNk1D7S0a8fQ2H4hMHoowx8df
         fGfU05cKy2yUyK/CvwDiiT5ouT2T9RiugUsd4IjnYvQ22tCdha06Js6Tl5TD5Dh5f1D1
         dHA1zpC7RCQmhboV2wc24R4nJ0h7tMJQSQfOhQk3Pft9lKWCvCd2p+6nVDF9hgdcPDI6
         Ql4fGN89Lj6xM3dXpiekfg8dU0nMw/UAiwPzTKtSQUwXjtCFxrG2gyfDV2WUv+AWQ1B5
         VlVu4/FrjFo2jjC3CWUV60psvqVw2dCct6e7XRPpTn24jdAxUhba2VbIhW9/p4rkCorC
         9x7A==
X-Gm-Message-State: AOJu0Yy0wu75yhvk95YiknRkIMgnqzkqX1kpENdOXS+bqdjUmd2j6mKl
        fTciAqGBL+/FlQ5xVJ8fLwnce9qKDWw=
X-Google-Smtp-Source: AGHT+IGgohioVdpquw3B5DxoqhT8BsEwuPSzMKvNalE2aUDCGmgSFS4/xTNX1qvrphucvG6zu/DeAQ==
X-Received: by 2002:adf:f205:0:b0:31f:8a6d:e527 with SMTP id p5-20020adff205000000b0031f8a6de527mr5634898wro.45.1695642664907;
        Mon, 25 Sep 2023 04:51:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7-20020adff9c7000000b0031912c0ffebsm11622823wrr.23.2023.09.25.04.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:51:04 -0700 (PDT)
Message-ID: <e26545b1ed9202f37e72366659644cef58942e2f.1695642662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
        <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:50:58 +0000
Subject: [PATCH v2 2/6] coverity: cache the Coverity Build Tool
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

It would add a 1GB+ download for every run, better cache it.

This is inspired by the GitHub Action `vapier/coverity-scan-action`,
however, it uses the finer-grained `restore`/`save` method to be able to
cache the Coverity Build Tool even if an unrelated step in the GitHub
workflow fails later on.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index d8d1e328578..4bc1572f040 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -29,7 +29,28 @@ jobs:
         env:
           runs_on_pool: ubuntu-latest
 
+      # The Coverity site says the tool is usually updated twice yearly, so the
+      # MD5 of download can be used to determine whether there's been an update.
+      - name: get the Coverity Build Tool hash
+        id: lookup
+        run: |
+          MD5=$(curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
+                   --fail \
+                   --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
+                   --form project="$COVERITY_PROJECT" \
+                   --form md5=1) &&
+          echo "hash=$MD5" >>$GITHUB_OUTPUT
+
+      # Try to cache the tool to avoid downloading 1GB+ on every run.
+      # A cache miss will add ~30s to create, but a cache hit will save minutes.
+      - name: restore the Coverity Build Tool
+        id: cache
+        uses: actions/cache/restore@v3
+        with:
+          path: ${{ runner.temp }}/cov-analysis
+          key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
       - name: download the Coverity Build Tool (${{ env.COVERITY_LANGUAGE }} / ${{ env.COVERITY_PLATFORM}})
+        if: steps.cache.outputs.cache-hit != 'true'
         run: |
           curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
             --fail --no-progress-meter \
@@ -37,9 +58,16 @@ jobs:
             --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
             --form project="$COVERITY_PROJECT"
       - name: extract the Coverity Build Tool
+        if: steps.cache.outputs.cache-hit != 'true'
         run: |
           mkdir $RUNNER_TEMP/cov-analysis &&
           tar -xzf $RUNNER_TEMP/cov-analysis.tgz --strip 1 -C $RUNNER_TEMP/cov-analysis
+      - name: cache the Coverity Build Tool
+        if: steps.cache.outputs.cache-hit != 'true'
+        uses: actions/cache/save@v3
+        with:
+          path: ${{ runner.temp }}/cov-analysis
+          key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
       - name: build with cov-build
         run: |
           export PATH="$RUNNER_TEMP/cov-analysis/bin:$PATH" &&
-- 
gitgitgadget

