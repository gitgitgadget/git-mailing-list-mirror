Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30527C4332F
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 12:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhKTMNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 07:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhKTMNY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 07:13:24 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11B8C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:10:20 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i12so10852960wmq.4
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VoKFeXkbfaZBNVEBmDbbPchlZbLKw7iTpL5P9tJOyl0=;
        b=cnf0Zv4SnLubiX/4e/zOQvGSpwlKd5pUOl9XhAh741nQQh2Bu8W9BbgAn0KiLec+IH
         FImJobl3wCsifMl2oj3tIadCud6GY51lVm4vgfCEtMqtuZpXN37gX2AcIcnrCUfKD0s3
         kIfw9+IbwRL8FI3nzLnYCSp2LGo6PPOdYAq1G/hF1TEbDrpWr1kZt5LLA+90hDHooHjY
         CxAliJvBDAimaStaufXj9K48t1adcOOtYxgXydzgCNeEYAiYM13ijWnfmoSm/R4m3gbU
         C3nuApJbPAOydwlhvOGfFa7nScLYME4LWhbXjZ0eWOVqr1h8XASVPMFotUuG/uSm4/gx
         ujnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VoKFeXkbfaZBNVEBmDbbPchlZbLKw7iTpL5P9tJOyl0=;
        b=QQ+qI/LPVwpV/v0VSICgHJ/6T7WmnBjLoXxvYuR3bx/9akRifupT0Dy4Wq8610+rFu
         JxztanUp14UhCt+ODBrlelcRUQ6oVbHn4DMGhqgAky+TP1SC4RvCD3CxOardEboy20rW
         NG+7G2RsqB7ozA16uO2sMA6O0jf6Zh+gjdDXb1Tiy/RPKTCUckrSMJ99bnjW7jgsLo/e
         S238XPSEYNeb1YQmG9StUzKSh3wl4gEn0GEuzt4mo3DTDoN/RoSclbkboFxwQ2ui9w08
         bE2XYdyw8V8lUiAMCs3SGQYgvapIBmVvNck0rdgXD9M+DwjT49wouyktw5DKpYp835mu
         GOTA==
X-Gm-Message-State: AOAM533FSyAo/RF5r/py8pLZq19/IxrXiT9PYR1QKsMLvQkgKRm+E69o
        De1I+1gnF90J9u59YYEEdewyYWGtPYN4REBB
X-Google-Smtp-Source: ABdhPJyz0TzqImiCLBuLexOPjR8dvRDNBZ8sz6QzoJ1LOxMTMV/G8sxRLCzUPNHz7eQ9aePOQL+c1Q==
X-Received: by 2002:a05:600c:1e27:: with SMTP id ay39mr9672488wmb.84.1637410219092;
        Sat, 20 Nov 2021 04:10:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m36sm3128221wms.25.2021.11.20.04.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 04:10:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/5] CI: use shorter names that fit in UX tooltips
Date:   Sat, 20 Nov 2021 13:10:08 +0100
Message-Id: <patch-v3-2.5-b09cd076aeb-20211120T115414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.818.g0f23a581583
In-Reply-To: <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
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

Let's also use the existing "pool" field as before. It's occasionally
useful to know we're running on say ubuntu v.s. fedora. The "-latest"
suffix is useful to some[4], and since it's now at the end it doesn't
hurt readability in the short view compared to saying "ubuntu" or
"macos".

1. https://github.com/git/git/tree/master/
2. https://github.com/avar/git/tree/avar/ci-rm-travis-cleanup-ci-names-3
3. https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions
3. https://lore.kernel.org/git/d9b07ca5-b58d-a535-d25b-85d7f12e6295@github.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 10 +++++++++-
 README.md                  |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6ed6a9e8076..c7c10456572 100644
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
+    name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     strategy:
@@ -251,6 +257,7 @@ jobs:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   dockerized:
+    name: ${{matrix.vector.jobname}} (${{matrix.vector.image}})
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     strategy:
@@ -310,6 +317,7 @@ jobs:
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
2.34.0.818.g0f23a581583

