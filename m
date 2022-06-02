Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF520C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 09:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiFBJFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 05:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiFBJFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 05:05:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857942A8918
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 02:05:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t13so5579996wrg.9
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 02:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yB4y6vPNUuDMMMyWsgXMTFEjx57O8d80DuhxJ6QQ9pg=;
        b=B0oFdT3gv3bTqVeD4fTcc5Dz+xfXKONUiAeXgi254h0UM33Vwtz5SEnglkv3Lowbh/
         VZz5J1Dp4QJVEC+akPJZ6XKuYp26ryxV003vpK8MCok9+oKmHxVr/kxQH9RnK6+lStCX
         xO/54gJdqPm62OhyDAnglGJWIgV8uqd60c8ByzHjcP/x4XC8YOIa0XuBIOh8p+dDMdOi
         UJUpm+Zl0j2cs3lKUiQPHM+GqEadW0aAqUf0mapvFGJRSLDOTowDP5sLBOH2gIjyGJdz
         k3pgc4GIoLKhDPZiOWvLHv3ndPvVdAaD+gFCH9X2CWaVI1Xksfwm950rlVzsN1JsslIG
         mgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yB4y6vPNUuDMMMyWsgXMTFEjx57O8d80DuhxJ6QQ9pg=;
        b=uAqXHI9gURAbsIgNJPkLFJ0ZrBQzNyC+5xKT+MSB4sjgoe5pWSGOOAzU093mWzLQ8K
         JUtbFuFJA4RIkyNKqA1Sigy3OxYd+IdgXedeqEWxPcjn69TxSAnl99LAJhrp2qkgW2If
         bsvv2g0MtM4wQXjuWOqs3/LFGzDNu9TaC9xsbesf/HWrexT1asBQ63JJT2QihtlFOr1F
         yyqJ6Qw/6Q6aSqmsh6xpkvLfX5DVrrRlTxUCSFDbm91Fm72TKif/XYMivV840XmD2jOg
         dN6nJO6mwD7iGzSK44YFQeQgcqScnPhLak7+majXFG8BNo247TZehs0xvtRiNBmzMtrh
         OkWA==
X-Gm-Message-State: AOAM533+pQZ6FtpNOoSUaddAo1AOh+7olU5Sy+gtdLjhADJHFQQVVsFC
        /FLI6OCl+RRitXg7ZQAAiJsjTP9iq8k=
X-Google-Smtp-Source: ABdhPJxrm17f6tK/gWjCzFF2Zi3RyeHP762aQJ1WNF4x2CGBsRGXh839sN3fF9rhTeTvNrNoOAAzpg==
X-Received: by 2002:adf:e24d:0:b0:211:9c1a:3f2 with SMTP id bl13-20020adfe24d000000b002119c1a03f2mr2732066wrb.431.1654160739795;
        Thu, 02 Jun 2022 02:05:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o22-20020a1c7516000000b003942a244ed1sm4348275wmc.22.2022.06.02.02.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 02:05:39 -0700 (PDT)
Message-Id: <6ad0d3d401da7787d0e7afb3f804b705731bf2dd.1654160735.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jun 2022 09:05:35 +0000
Subject: [PATCH 2/2] ci: also run the `scalar` tests
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

Since Scalar depends on `libgit.a`, it makes sense to ensure in the CI
and the PR builds that it does not get broken in case of industrious
refactorings of the core Git code (speaking from experience here).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 15 +++++++++++++++
 ci/run-build-and-tests.sh  |  2 ++
 ci/run-test-slice.sh       |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c35200defb9..785222aa7b3 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -91,6 +91,13 @@ jobs:
         HOME: ${{runner.workspace}}
         NO_PERL: 1
       run: . /etc/profile && ci/make-test-artifacts.sh artifacts
+    - name: build Scalar
+      shell: bash
+      run: |
+        make -C contrib/scalar &&
+        mkdir -p artifacts/bin-wrappers artifacts/contrib/scalar &&
+        cp contrib/scalar/scalar.exe artifacts/contrib/scalar/ &&
+        cp bin-wrappers/scalar artifacts/bin-wrappers/
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
@@ -161,6 +168,8 @@ jobs:
       run: compat\vcbuild\vcpkg_copy_dlls.bat release
     - name: generate Visual Studio solution
       shell: bash
+      env:
+        INCLUDE_SCALAR: YesPlease
       run: |
         cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
         -DNO_GETTEXT=YesPlease -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
@@ -174,6 +183,12 @@ jobs:
       run: |
         mkdir -p artifacts &&
         eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts NO_GETTEXT=YesPlease 2>&1 | grep ^tar)"
+    - name: copy Scalar
+      shell: bash
+      run: |
+        mkdir -p artifacts/bin-wrappers artifacts/contrib/scalar &&
+        cp contrib/scalar/scalar.exe artifacts/contrib/scalar/ &&
+        cp bin-wrappers/scalar artifacts/bin-wrappers/
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 280dda7d285..661edb85d1b 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -51,4 +51,6 @@ esac
 make $MAKE_TARGETS
 check_unignored_build_artifacts
 
+make -C contrib/scalar $MAKE_TARGETS
+
 save_good_tree
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index f8c2c3106a2..b741fd8f361 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -14,4 +14,9 @@ make --quiet -C t T="$(cd t &&
 	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
 	tr '\n' ' ')"
 
+if test 0 = "$1"
+then
+	make -C contrib/scalar test
+fi
+
 check_unignored_build_artifacts
-- 
gitgitgadget
