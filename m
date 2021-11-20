Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63CBC433FE
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 03:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhKTDbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbhKTDbt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 22:31:49 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11FDC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d27so21406345wrb.6
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkSt5fDWpyPpy4ZVKcpUFpJIpKVNh6k956qQ/bO6pXY=;
        b=KceXpm/wFdLd0FuiS/OiOSkZW4xks9R78tN0W4jGVznY+evFTxGz9SgC63a6e2pxLU
         Zo//9XHOl13JcfKDQXanY52XmYqTh6ZFZnQqlCm46mmLDoMqiLmVWRidndnxRAgiXwre
         ONDX0oivTkNcDlONled3lpdT1No1gO9PX71MmY7XMyOnIGere6msv1hAFacJXB4YgZv4
         cK6t4J5Ytqp44nrDYiVmo3OYk+SM/0eThXiLq1/0fypMPk3vk1Ba7hC/yZHU6/HjmTTT
         wg2Ljphandsl4lOdmE+j37bUzJRqEFfMBF24rPl8RQlk59CAh/kkXHyB5yp7v+GQr2zb
         p3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkSt5fDWpyPpy4ZVKcpUFpJIpKVNh6k956qQ/bO6pXY=;
        b=4hGlY8/oducOY9tZpHEVYhioWOMLOS+xHSb+23cHLwVTN7Wceab1gZlUWww5PqAjUf
         fACKW6AlVRNxQc/EKhDQXLYmxwLQmQjU2cJbpvEQW0jwCTnc8eiVRhdTg8JFDNuuRB0o
         kI8EB6vkxP72LFqPC97ynihJjeOOs+uSN/Mr+IE1TbREDwrJL815LDPIrn4VqugDBWIL
         IMoXARBLsMJbdkoK7OeIGeGlc383CiX9D6ys2ZumtV9RfhCKlDFt9S+5toT8lpt0SAET
         HN4SSTQUinwuA/7QJjhWki/ZZjcyA/zYrN8jldz+zNoGDiBLxMtx2c4CJaio+eIQhmCO
         DbNw==
X-Gm-Message-State: AOAM5328KV1yZJwKS0FCJKxjI+Rexf2utCf7uhpjd1a2aUf01fAXZgCz
        5hAD1SGS2ji8QsnK18ksnU5a2wYixRw//g==
X-Google-Smtp-Source: ABdhPJyJhj93Qr91f8onjBJGau6c0ON5UJqimCzyq4WjiwlrC0KbHvG17U3onhM6h47tj6BdaVLNCA==
X-Received: by 2002:a05:6000:2a4:: with SMTP id l4mr14311216wry.238.1637378924234;
        Fri, 19 Nov 2021 19:28:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12sm1560623wmq.12.2021.11.19.19.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 19:28:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] CI: use shorter names that fit in UX tooltips
Date:   Sat, 20 Nov 2021 04:28:32 +0100
Message-Id: <patch-v2-2.6-73981cedee8-20211120T030848Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the names used for the GitHub CI workflows to be short enough
to (mostly) fit in the pop-up tool-tips that GitHub shows in the
commit view. I.e. when mouse-clicking on the passing or failing
check-mark next to the commit subject.

These names are seemingly truncated to 17-20 characters followed by
three dots ("..."). Since a "CI/PR / " prefix is added to them the job
names looked like this before (windows-test and vs-test jobs omitted):

    CI/PR / ci-config (p...
    CI/PR / windows-buil...
    CI/PR / vs-build (pu...
    CI/PR / regular (lin...
    CI/PR / regular (lin...
    CI/PR / regular (os...
    CI/PR / regular (os...
    CI/PR / regular (lin...
    CI/PR / regular (lin...
    CI/PR / dockerized (...
    CI/PR / dockerized (...
    CI/PR / dockerized (...
    CI/PR / static-anal...
    CI/PR / sparse (pu...
    CI/PR / documenta...

By omitting the "/PR" from the top-level name, and pushing the
$jobname to the front we'll now instead get:

    CI / config (push)
    CI / win build (push...
    CI / win+VS build (...
    CI / linux-clang (ub...
    CI / linux-gcc (ubun...
    CI / osx-clang (osx)...
    CI / osx-gcc (osx) (...
    CI / linux-gcc-defau...
    CI / linux-leaks (ub...
    CI / linux-musl (alp...
    CI / Linux32 (daald/...
    CI / pedantic (fedor...
    CI / static-analysis...
    CI / sparse (push)...
    CI / documentation

We then have no truncation in the expanded view. See [1] for how it
looked before, [2] for a currently visible CI run using this commit,
and [3] for the GitHub workflow syntax involved being changed here.

Let's also add a field for the "os" and use it where appropriate, it's
occasionally useful to know we're running on say ubuntu
v.s. fedora (but the "-latest" suffix isn't very useful, that applies
to almost all the jobs.

1. https://github.com/git/git/tree/master/
2. https://github.com/avar/git/tree/avar/ci-rm-travis-cleanup-ci-names-2
3. https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 16 +++++++++++++++-
 README.md                  |  2 +-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6ed6a9e8076..612b475fd0b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -1,4 +1,4 @@
-name: CI/PR
+name: CI
 
 on: [push, pull_request]
 
@@ -7,6 +7,7 @@ env:
 
 jobs:
   ci-config:
+    name: config
     runs-on: ubuntu-latest
     outputs:
       enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
@@ -77,6 +78,7 @@ jobs:
             }
 
   windows-build:
+    name: win build
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
@@ -97,6 +99,7 @@ jobs:
         name: windows-artifacts
         path: artifacts
   windows-test:
+    name: win test
     runs-on: windows-latest
     needs: [windows-build]
     strategy:
@@ -127,6 +130,7 @@ jobs:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   vs-build:
+    name: win+VS build
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
@@ -178,6 +182,7 @@ jobs:
         name: vs-artifacts
         path: artifacts
   vs-test:
+    name: win+VS test
     runs-on: windows-latest
     needs: vs-build
     strategy:
@@ -210,6 +215,7 @@ jobs:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   regular:
+    name: ${{matrix.vector.jobname}} (${{matrix.vector.os}})
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     strategy:
@@ -218,21 +224,27 @@ jobs:
         vector:
           - jobname: linux-clang
             cc: clang
+            os: ubuntu
             pool: ubuntu-latest
           - jobname: linux-gcc
             cc: gcc
+            os: ubuntu
             pool: ubuntu-latest
           - jobname: osx-clang
             cc: clang
+            os: osx
             pool: macos-latest
           - jobname: osx-gcc
             cc: gcc
+            os: osx
             pool: macos-latest
           - jobname: linux-gcc-default
             cc: gcc
+            os: ubuntu
             pool: ubuntu-latest
           - jobname: linux-leaks
             cc: gcc
+            os: ubuntu
             pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
@@ -251,6 +263,7 @@ jobs:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   dockerized:
+    name: ${{matrix.vector.jobname}} (${{matrix.vector.image}})
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     strategy:
@@ -310,6 +323,7 @@ jobs:
       run: ci/install-dependencies.sh
     - run: make sparse
   documentation:
+    name: documentation
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
diff --git a/README.md b/README.md
index eb8115e6b04..f6f43e78deb 100644
--- a/README.md
+++ b/README.md
@@ -1,4 +1,4 @@
-[![Build status](https://github.com/git/git/workflows/CI/PR/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
+[![Build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
 
 Git - fast, scalable, distributed revision control system
 =========================================================
-- 
2.34.0.823.gcc3243ae16c

