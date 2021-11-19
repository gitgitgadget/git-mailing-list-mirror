Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFA2C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhKSXG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhKSXGx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:06:53 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A71C061757
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i12so9825157wmq.4
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YGW/Iv+hj4Jo4PNf8rajEZsMbDt9HNnlI+ygkUeyL4U=;
        b=DcJgXc3kFKlce8NbkZOilh6ilbmtAJKYpD3xU/7mYaul9vtEJXzOIqjyQXpzYy9Yts
         mMQ9oF+Rjlg5Gr87UhNA+OtiYg8TCpSOsCsgpHM9EzafBxhF4ZPhx+CPwOGCZjNbS8ME
         Pf2s2McLCwmUMxqhxDyyvFEzhYXksUewdSiH6iICpiUmOX/2hJElzdD2RWfXzYQUEl9J
         W29cUDcvys8fYUgyFTpqOJT+Cs4NyPqx8IhivQQtuVWeZQv4Dnx8Qg5p4LeFsDFoOGPN
         wIUjq0ewMCVQT3xMu11Yh98taYxqjVZJk1YU/s9m277d/Uz9GhUtTGYZP8FSwF+TwkxY
         v13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YGW/Iv+hj4Jo4PNf8rajEZsMbDt9HNnlI+ygkUeyL4U=;
        b=7GK0R/yifbZipN0kO3VMjNBPi2yhwP+eVyUy/w+VLI0Q9aI6dm/wY1Buovjfb9rpaS
         zrX9fdwE+92eOXJEi2E9foLdHhB8Fk2reDit58+SfW1RkOwybfOUMfqJ2otdJZMtQ/3r
         0/bzXyNrz1sLX+RBK7cSm+/jZpU8EMYJgriNUf3LdNXwkJVfOZUoTB+CHFa5hT/ojjkx
         D1BtrFhy94oKtmfWX+MMD5ZS6ccT1CuazLl4sjZun6j52mYDRv8XtGN4S8dlAUqnJurc
         q20SmVWE4T3QomYh+4qPjLOfYvsowZ1m1wTOhU9ETRf0M+eLWTE6YLrKevpPazTyQeMM
         G8eQ==
X-Gm-Message-State: AOAM5316ivYaKWNGF3c7Z/Q5cHeuTPcqnDYPMQQckn0TatU4kFC9gPBL
        mH0oh/fZ6NKUXpJPZ1sEggylvk7toYM=
X-Google-Smtp-Source: ABdhPJy+9J45ErbGMxa6Q4nUVh0XmrpKY/F0DNYxzna86jvIZBorVbX5ipb4LKL048anV+6Ek+dtLA==
X-Received: by 2002:a05:600c:1e8d:: with SMTP id be13mr4234931wmb.79.1637363029807;
        Fri, 19 Nov 2021 15:03:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm13905079wmc.47.2021.11.19.15.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:49 -0800 (PST)
Message-Id: <8e3542e43f7507282672dc8d0926ac1cc44b335a.1637363025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:33 +0000
Subject: [PATCH v8 06/17] ci: also run the `scalar` tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since Scalar depends on `libgit.a`, it makes sense to ensure in the CI
and the PR builds that it does not get broken in case of industrious
refactorings of the core Git code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 15 +++++++++++++++
 ci/run-build-and-tests.sh  |  1 +
 ci/run-test-slice.sh       |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6ed6a9e8076..6eda6be895d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -89,6 +89,13 @@ jobs:
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
@@ -157,6 +164,8 @@ jobs:
       run: compat\vcbuild\vcpkg_copy_dlls.bat release
     - name: generate Visual Studio solution
       shell: bash
+      env:
+        INCLUDE_SCALAR: YesPlease
       run: |
         cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
         -DNO_GETTEXT=YesPlease -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
@@ -170,6 +179,12 @@ jobs:
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
index cc62616d806..07cedd25ff1 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -49,6 +49,7 @@ linux-gcc-4.8|pedantic)
 	make test
 	;;
 esac
+make -C contrib/scalar test
 
 check_unignored_build_artifacts
 
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

