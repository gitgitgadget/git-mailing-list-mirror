Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF57C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 10:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiLEKBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 05:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiLEKBT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 05:01:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84CE0C8
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 02:01:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so9534017wmi.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 02:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yZ+kjQSKgj7x5cKaavtdmbk9UIwFXqm7fAUJduol9k=;
        b=OSDIW89NlGa6Atc5qApmJcGdtULMEUtEbfLNTH7lmIZ9BtXriHTpFhzRp5ObKnh54i
         vhCGOGXdTU1wkZ0QMssyNy3z9dYY3UtBspjPeczif5sKaAgO+mQp/eO5cW2iDIy5uo7v
         eOrvr/tJjHarGPeLkvCRfiuyAcRgwgW8H/XZ5v83BJAoHJvLclyuqVpSWGkxfSVHKCq2
         1dtSkt38Sqir5IIa7GS2VNce8OEpsGq3ebUIkvINnuJ3Yst8qWKmrI5wl42wXK3g+Td7
         OgvSENbyJzMPWCAsIAYsBrraTeiYY8l4DGLlkMiSrSJXo1YlBfkSi6LwNn/jVS3yvY79
         4aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yZ+kjQSKgj7x5cKaavtdmbk9UIwFXqm7fAUJduol9k=;
        b=f7kK3jfq7g4xTN+pZjj/cm0zfMR8dxRLC/eUfcSip94ZdTSlcdc9bNBSFIM6bA7smF
         m84b8qZTHg7N6gKeyyQ7necWyniOGcWMwGgxyUu9FoW4LLMLYqazAhZiNpL7Dd4qLbR9
         XOuG+sbFKFUiNifpd88RnEqW0EsqA1Tac/MF2XPumtsGJmhujla4WUwtXFW0hZry/M3S
         0kdTKrSAs1tXM2m5dpMZT3Qz/sl66Vt+NV1AOHBZUvHIqzMnu2KMMVUuQOC/V5w04qK3
         UHjJPBSO17oLrz4TsPR0FPD4iO+XdfSICKcexmfxhC/LJe99yG86AFeUbKi0zy8NZcNi
         G1mw==
X-Gm-Message-State: ANoB5pl6GiioEuT8P+1fhwCv1Qksn1PUsozBvhKiE8Ep87hJh83gNFuj
        0DEXZnoAn/WKRHQDmazqt6CLA1xeJhs=
X-Google-Smtp-Source: AA0mqf493GVqyHrwFO/uKod8IsX6YxnKlmdoCkQV3cK+K1pTSjCCrNdmPB4w4oPW+oGOFxZxpyy4GQ==
X-Received: by 2002:a05:600c:3d16:b0:3c6:de4a:d768 with SMTP id bh22-20020a05600c3d1600b003c6de4ad768mr45883305wmb.61.1670234475967;
        Mon, 05 Dec 2022 02:01:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h40-20020a05600c49a800b003b3365b38f9sm16255539wmp.10.2022.12.05.02.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 02:01:15 -0800 (PST)
Message-Id: <pull.1354.v2.git.git.1670234474721.gitgitgadget@gmail.com>
In-Reply-To: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
From:   "Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 10:01:14 +0000
Subject: [PATCH v2] ci(main): upgrade actions/checkout to v3
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

To be up to date with actions/checkout opens the door to use the latest
features if necessary and get the latest security patches.

This also avoids a couple of deprecation warnings in the CI runs.

Note: The `actions/checkout` Action has been known to be broken in i686
containers as of v2, therefore we keep forcing it to v1 there. See
actions/runner#2115 for more details.

Signed-off-by: Oscar Dominguez <dominguez.celada@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci(main): upgrade actions/checkout to v3
    
    
    Description
    ===========
    
    Upgrades actions/checkout to v3 in .github/workflows/main.yml

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1354%2Foscard0m%2Fpatch-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1354/oscard0m/patch-1-v2
Pull-Request: https://github.com/git/git/pull/1354

Range-diff vs v1:

 1:  2dbb779f7fd ! 1:  26fad15f97a ci(main): upgrade actions/checkout to v3
     @@ Metadata
       ## Commit message ##
          ci(main): upgrade actions/checkout to v3
      
     -    to be up to date with actions/checkout opens the door to use the latest
     +    To be up to date with actions/checkout opens the door to use the latest
          features if necessary and get the latest security patches.
      
     -    Signed-off-by: Oscar Dominguez Celada <dominguez.celada@gmail.com>
     +    This also avoids a couple of deprecation warnings in the CI runs.
     +
     +    Note: The `actions/checkout` Action has been known to be broken in i686
     +    containers as of v2, therefore we keep forcing it to v1 there. See
     +    actions/runner#2115 for more details.
     +
     +    Signed-off-by: Oscar Dominguez <dominguez.celada@gmail.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## .github/workflows/main.yml ##
      @@ .github/workflows/main.yml: jobs:
     @@ .github/workflows/main.yml: jobs:
           runs-on: ubuntu-latest
           container: ${{matrix.vector.image}}
           steps:
     --    - uses: actions/checkout@v1
      +    - uses: actions/checkout@v3
     ++      if: matrix.vector.jobname != 'linux32'
     +     - uses: actions/checkout@v1
     ++      if: matrix.vector.jobname == 'linux32'
           - run: ci/install-docker-dependencies.sh
           - run: ci/run-build-and-tests.sh
           - name: print test failures
 2:  4ee163b9a2c < -:  ----------- ci(main): linux32 uses actions/checkout@v2


 .github/workflows/main.yml | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 831f4df56c5..5262823eb1c 100644
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
@@ -291,7 +291,10 @@ jobs:
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
+    - uses: actions/checkout@v3
+      if: matrix.vector.jobname != 'linux32'
     - uses: actions/checkout@v1
+      if: matrix.vector.jobname == 'linux32'
     - run: ci/install-docker-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
@@ -311,7 +314,7 @@ jobs:
       jobname: StaticAnalysis
     runs-on: ubuntu-22.04
     steps:
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
     - run: ci/check-directional-formatting.bash
@@ -331,7 +334,7 @@ jobs:
         artifact: sparse-20.04
     - name: Install the current `sparse` package
       run: sudo dpkg -i sparse-20.04/sparse_*.deb
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
     - name: Install other dependencies
       run: ci/install-dependencies.sh
     - run: make sparse
@@ -343,6 +346,6 @@ jobs:
       jobname: Documentation
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
     - run: ci/install-dependencies.sh
     - run: ci/test-documentation.sh

base-commit: bcd6bc478adc4951d57ec597c44b12ee74bc88fb
-- 
gitgitgadget
