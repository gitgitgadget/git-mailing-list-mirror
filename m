Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B70C4708E
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 14:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiLGOe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 09:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLGOeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 09:34:50 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63A56EC0
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 06:34:49 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v7so13773256wmn.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 06:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VusIkuWXUFZMceUmM6DwEIP4/HVRWm+3oK8twivGzrY=;
        b=Pzksq8ntOBy12+Kqq2YT4ZEVF/xoKVX/iHjKi3mqLCY37cLG4YnFqVVSqe1zWQ+sJr
         Mfx8OPozRnBU1YzRCMpjRibgJt4/HjoPBNNSozqg+FiBBtpkXVKAVFPuDlijyn5vRXrn
         54aUFkcMp9pvkbb4id/CnVKpvRQSu9uFLlE22wmf6Ao0SMPmUWtbcLsD3Qx5tq/2zAso
         aBFJQ7yxBoO/uxUkbmGnXVO0Fm5rX23CXxayIs7F5RdnVYh0HSu0nEFQfx8WEPC1fU/7
         3hxxIIwc+o6EGplb1O8UeqXfiJYISJcnQYKoJSwM0ZKIsPijzgQHs7KIfp1458RPhQq/
         NKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VusIkuWXUFZMceUmM6DwEIP4/HVRWm+3oK8twivGzrY=;
        b=r9e6bJ0REjCLEEHBCxDnDDhLVJosqYmbpA6idgThlygIX/FSYOc6XHNfKxQtzfX9kv
         giXag0ygU2281JwPBNeYBptrEjdYCB0/WDf/Fr+wN01ikn4RcTPdXhzMWLuNq5nLaIRn
         sJx9H8lvtOt1JV1L/fSg2TXASdhUu5VT1slNLK3AZyU1WyO2a4zbrYxMjXYWcr3xLtGC
         6zNA/4OKj3BjDc2AdpX5jKWf/OB6FT9J/ZEAG7VSkOW5aBBN3EDBeOilM2mkZKNJU+G/
         Jn+v7zvz2tsitruQwCl0PNIxo8MmIeiG8WHFzwhsDa9nVg4Fbwf9T+hvKs0kr1DQj+bf
         /aHw==
X-Gm-Message-State: ANoB5pkrQYgkbngzjx7LylagRaSIf3tPAW6NhnJOHgUFtkp66SbnzFzu
        T8fc+nOttyVPkicSdixfd/YwlGn5WI4=
X-Google-Smtp-Source: AA0mqf43GQ8HeddllSO9ffOzxUXo1etgrjiv9cDbTRKRxTELqiuXOi+3LnwTNd6nj3ixcHM6JiaKdg==
X-Received: by 2002:a05:600c:2241:b0:3cf:9ced:dce4 with SMTP id a1-20020a05600c224100b003cf9ceddce4mr65379060wmm.120.1670423687746;
        Wed, 07 Dec 2022 06:34:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020adfec86000000b002368a6deaf8sm19451826wrn.57.2022.12.07.06.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:34:46 -0800 (PST)
Message-Id: <c9e99b4f96fc4e513c62b1b028e45559f6410c57.1670423680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
References: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 14:34:39 +0000
Subject: [PATCH 3/4] ci: avoid using deprecated {up,down}load-artifacts Action
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

The deprecated versions of these Actions still use node.js 12 whereas
workflows will need to use node.js 16 to avoid problems going forward.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 1e95aa86b6c..5e82d8d2b1b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -94,7 +94,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v3
       with:
         name: windows-artifacts
         path: artifacts
@@ -108,7 +108,7 @@ jobs:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     steps:
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v2
+      uses: actions/download-artifact@v3
       with:
         name: windows-artifacts
         path: ${{github.workspace}}
@@ -125,7 +125,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v3
       with:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -177,7 +177,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v3
       with:
         name: vs-artifacts
         path: artifacts
@@ -192,7 +192,7 @@ jobs:
     steps:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v2
+      uses: actions/download-artifact@v3
       with:
         name: vs-artifacts
         path: ${{github.workspace}}
@@ -210,7 +210,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v3
       with:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -267,7 +267,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v3
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -302,7 +302,13 @@ jobs:
       shell: bash
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
-      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname != 'linux32'
+      uses: actions/upload-artifact@v3
+      with:
+        name: failed-tests-${{matrix.vector.jobname}}
+        path: ${{env.FAILED_TEST_ARTIFACTS}}
+    - name: Upload failed tests' directories
+      if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname == 'linux32'
       uses: actions/upload-artifact@v1
       with:
         name: failed-tests-${{matrix.vector.jobname}}
-- 
gitgitgadget

