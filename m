Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17499C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 07:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiJJHu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 03:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiJJHuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 03:50:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15AA183B1
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 00:49:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n12so15713221wrp.10
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 00:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMozPbVI6pGMvFxtjWQv+CCuLz2UmWTGgT6i6hH1Ld8=;
        b=nyCpO5+PnMwWL5RHbycOtVe5hwcl2ApwQ/RX1VR+Z1u+hwuF35K4KhBTPaDsRhUgvo
         +m3qHzn448u1tU33Dgjfs9fklM4/FbXMPU7NpY7T4K9lVKk9i1x52a1MS5ShJHlToEB4
         fT4CJZkKWQYQITmpNHr3vOGEm8ALdUh6GBLylR3pfRBwvULfuD2U+h2uW6AIA8TtskKC
         YXOVplPUd1fb4TyyAwANIBSYzdRhCS+tQXZti+QIi/DTW+xK1w9Ws0G00eA/ASbxPYAP
         g6nAZ3GG7QQKY547+nnUeb/EVgVUzNrMYrUzA0Tw5gXZOrNYnquvo6pQ61H9jVIZWdQM
         esEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMozPbVI6pGMvFxtjWQv+CCuLz2UmWTGgT6i6hH1Ld8=;
        b=G02rUJoLBoOP+e2smwJBE/ex++SeKo34PrULO4xOvZtEqspBboja3BvVOAFkMelyxJ
         a382rqvWBc5rxl6L2XCBvUavMwYONmCXAIYSZfMUL/EhdWFE23wraN8nzGuUUi8RZZSi
         gD43FB4xCea5JgesBGkoosMfyvsqMIPIv7rkcB3+lJ9iW3/a9TWsMgCm57O596BxZYvU
         t6gV9KlXw2ozjyqBta31qbTtmSCd18M+BCuCgVe6jJeSxcBzcnrBZLVpjSTfC4mCA+wO
         XQTa6SZhdMQlSNekORaFmVogBmpVBg6BltALQUqLQYdQOBPyULMkLlnHjuLVAeotAcNs
         yYNQ==
X-Gm-Message-State: ACrzQf25ea1PBvIAwUdnTT3oHdyYLKG3wbgb3Lzp1FzjedTMNZrNQsD6
        CJhGkpNWYCfeA3tG8i8cWbhXd7VUxWc=
X-Google-Smtp-Source: AMsMyM5jeS7k2kKjek5zWAYwP3Aa4c6pzEJs3Oa+GRB6jalcP/O7QGXKTGsoxa4H2gee9tCfyQK5hA==
X-Received: by 2002:a5d:4581:0:b0:228:a8e5:253c with SMTP id p1-20020a5d4581000000b00228a8e5253cmr9949633wrq.506.1665388139137;
        Mon, 10 Oct 2022 00:48:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j39-20020a05600c48a700b003a5537bb2besm9188208wmp.25.2022.10.10.00.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 00:48:58 -0700 (PDT)
Message-Id: <2dbb779f7fde175a8acd8e9de7c81db32fdf3e81.1665388136.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
From:   "Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 07:48:55 +0000
Subject: [PATCH 1/2] ci(main): upgrade actions/checkout to v3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Oscar Dominguez <dominguez.celada@gmail.com>,
        Oscar Dominguez <dominguez.celada@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Oscar Dominguez <dominguez.celada@gmail.com>

to be up to date with actions/checkout opens the door to use the latest
features if necessary and get the latest security patches.

Signed-off-by: Oscar Dominguez Celada <dominguez.celada@gmail.com>
---
 .github/workflows/main.yml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 831f4df56c5..8dc9d938159 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -83,7 +83,7 @@ jobs:
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
     steps:
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: build
       shell: bash
@@ -138,10 +138,10 @@ jobs:
       GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
     runs-on: windows-latest
     steps:
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: initialize vcpkg
-      uses: actions/checkout@v2
+      uses: actions/checkout@v3
       with:
         repository: 'microsoft/vcpkg'
         path: 'compat/vcbuild/vcpkg'
@@ -258,7 +258,7 @@ jobs:
       runs_on_pool: ${{matrix.vector.pool}}
     runs-on: ${{matrix.vector.pool}}
     steps:
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
@@ -291,7 +291,7 @@ jobs:
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v3
     - run: ci/install-docker-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
@@ -311,7 +311,7 @@ jobs:
       jobname: StaticAnalysis
     runs-on: ubuntu-22.04
     steps:
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
     - run: ci/check-directional-formatting.bash
@@ -331,7 +331,7 @@ jobs:
         artifact: sparse-20.04
     - name: Install the current `sparse` package
       run: sudo dpkg -i sparse-20.04/sparse_*.deb
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
     - name: Install other dependencies
       run: ci/install-dependencies.sh
     - run: make sparse
@@ -343,6 +343,6 @@ jobs:
       jobname: Documentation
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
     - run: ci/install-dependencies.sh
     - run: ci/test-documentation.sh
-- 
gitgitgadget

