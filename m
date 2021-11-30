Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86468C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbhK3L6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbhK3L6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:58:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A254FC06174A
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso19301342wms.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hHq6ERyLqJt0pGG1xYZK5xj6JbiIVjBcTQKQ6BZvI6I=;
        b=pI/AZUSFmvnQqeY3KRyHkX9kE7i+4AHaNfqDw0XzIajfVGEuqLJODzxL25SrS08YBk
         c9MwS/p0jjc9mG+0CJB58gb3gzp4TgrozNqMw6jv15hdsfMCsiCT4/c3KuKgtbMc67Uy
         keN4GW0PKtcDPqas82KaY332OwIaVuMmGJ29g4t8j+yYkZWmucWirBNBg63bnI2HPbRJ
         Az3WbHjkKOXTPfx2emc17LlJee13lUIg/QMLVVqoZjkoKgQm9OrS87MP4gWsnawzZG+x
         Nv0GoYCb5b3URAKrThHQz1nd2rqB7/Es7oqSQMhELg/oIbdq33S7U+tnjo7Pe7ldp1AO
         cM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hHq6ERyLqJt0pGG1xYZK5xj6JbiIVjBcTQKQ6BZvI6I=;
        b=sKBzjhZfDUb4SdDvInD5qeTkdfluVVvR5uODQEJ2SUcZsfAHFWm1k6CdXRgLhZfZT5
         Z4451lUpQYTFZkCN1KteaT9KTCgC0HvJ0btJXdQOsMXfjzRyR7x/yJakjtNVH/vJcIIl
         rpWcvlW/eLHJEh2SfeuEV5WDKyKs2A4Sssk3kBcbA6nF8hWR4ruJUrt/1mdeSw4NMqHH
         CszrfCTcM5ebRigRTRjyrdkcC4hi6hZHBvs0YfPiqG9TXAW0cQvlF9i9VhgvLSsSMz5p
         pAWI6PzGz+pGl2unpHofZ2BiKykYIhved9bQ3Cq+ApOSX7rUZwDbAz2lxJuboWdObJdo
         +xwQ==
X-Gm-Message-State: AOAM53339TP9N098zgg2f0j8CZT9IH6aifB8MhWSiLRxRKOoVBrRTyri
        tssTkvXRdOjUcmkWS63HBYYhK8ahql4=
X-Google-Smtp-Source: ABdhPJyOYqpql2nbjPLx5pqUscUdAsgD8/xOMrshXY3dOb1aO1Xq2oze6bAwYr/61vBGFRPsXcXciw==
X-Received: by 2002:a05:600c:4e01:: with SMTP id b1mr4377464wmq.109.1638273295169;
        Tue, 30 Nov 2021 03:54:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm2642667wmp.26.2021.11.30.03.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:54:54 -0800 (PST)
Message-Id: <8c6762def30e676a26d23636e924229f10fa5d09.1638273289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 11:54:38 +0000
Subject: [PATCH v9 06/17] ci: also run the `scalar` tests
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
 ci/run-build-and-tests.sh  |  2 ++
 ci/run-test-slice.sh       |  5 +++++
 3 files changed, 22 insertions(+)

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
index cc62616d806..2ef9fbfdd38 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -52,4 +52,6 @@ esac
 
 check_unignored_build_artifacts
 
+make && make -C contrib/scalar test
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

