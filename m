Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF0C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 03:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLGDP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 22:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGDP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 22:15:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E714853ECC
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 19:15:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e13so23065547edj.7
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 19:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRvfKmu7Ous3O7upG1VAlWZ7mXHBq0YcXJHCOv8p9RQ=;
        b=nBNq9xIAdgnVs2kcsTqnvD0uoV90TsSOptfogwymTqbkDTaD49aFQa8yn1tHDJSPYk
         alldxcZNpC0wG8npa4+b/kMCEx1B1cSPrtAZ0g3xIwqbvElj8KEPfMiDN+dcgfoI+CKp
         4V76MzW2WL9GHb0CMa5ZCpUQL035H4n8DAE7DLlYnfuZ3q8A9b9EyQc11AC6EoUvUWh8
         97A0hrJbqDVysk6tEzi0i3weIwOmkjibbRgVu7UxNLYo31gJdAAVcGolXw5ZKYZq9qJ7
         AxV6SX3kBorc6SxeyrWjQD9s55udSG4h78VJ5ezOG9WX3rDXJEFPEYJe5KF72ZXKuPyb
         5tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRvfKmu7Ous3O7upG1VAlWZ7mXHBq0YcXJHCOv8p9RQ=;
        b=FOX+9PNDrVFoVwDMhQyyMp0vmzZ8sn+JaTag19nnn6/h7FAIhVjrO17XxzPd3F6bzc
         lP3CKU9NdN1CpeFePNxsLI8cHNDB6LYdEHWdCRwx2akLi6L8f1r4Mrr6BCTP7VdsNZAe
         yiP3ymopT6vM8bQe5DXqJ6GX2SvJyhQj0RW53on2P7cWOFj5SsADAbnpCfgGrCILlxkS
         KqUDWHL411mw1lnW1dRUL3T5la+gB+N2+fTUSXjaTqvWXVnQJIgkVHnhTulff1kCGCnf
         hBUxYq9igzdKwYUnGgOcPncD4WcMKt4hYHrf5eeZGCS8nclmG67w/JqiTbcq+3Y9Ndip
         ArZA==
X-Gm-Message-State: ANoB5pmnVu+KDaEEBfWeVDXobBTPFz5IXQ21TGu0fR6VNuIU7dU4qrXD
        v0m81xoGvu3Ef2xLWOiVlnWFNhMOTZeKeQ==
X-Google-Smtp-Source: AA0mqf4UowcOT2piJloF9LKLOxFTAWBIOeuDg0zRXZGe/6xeJIBDPTdJZy5RGa6pX+W5LGlimemadg==
X-Received: by 2002:a05:6402:2992:b0:460:12ef:cc45 with SMTP id eq18-20020a056402299200b0046012efcc45mr22990118edb.249.1670382925071;
        Tue, 06 Dec 2022 19:15:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id op4-20020a170906bce400b0078df3b4464fsm8165332ejb.19.2022.12.06.19.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 19:15:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] CI: don't explicitly pick "bash" shell outside of Windows, fix regression
Date:   Wed,  7 Dec 2022 04:15:19 +0100
Message-Id: <patch-1.1-08dc682926a-20221207T031459Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1019.gce04d262ea9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "js/ci-github-workflow-markup" topic was originally merged in
[1] it included a change to get rid of the "ci/print-test-failures.sh"
step[2]. This was then brought back in [3] as part of a fix-up patches
on top[4].

The problem was that [3] was not a revert of the relevant parts of
[2], but rather copy/pasted the "ci/print-test-failures.sh" step that
was present for the Windows job to all "ci/print-test-failures.sh"
steps. The Windows steps specified "shell: bash", but the non-Windows
ones did not.

This broke the "ci/print/test-failures.sh" step for the "linux-musl"
job, where we don't have a "bash" shell, just a "/bin/sh" (a
"dash"). This breakage was reported at the time[5], but hadn't been
fixed.

It would be sufficient to change this only for "linux-musl", but let's
change this for both "regular" and "dockerized" to omit the "shell"
line entirely, as we did before [2].

Let's also change undo the "name" change that [3] made while
copy/pasting the "print test failures" step for the Windows job. These
steps are now the same as they were before [2], except that the "if"
includes the "env.FAILED_TEST_ARTIFACTS" test.

1. fc5a070f591 (Merge branch 'js/ci-github-workflow-markup', 2022-06-07)
2. 08dccc8fc1f (ci: make it easier to find failed tests' logs in the
   GitHub workflow, 2022-05-21)
3. 5aeb145780f (ci(github): bring back the 'print test failures' step,
   2022-06-08)
4. d0d96b8280f (Merge branch 'js/ci-github-workflow-markup', 2022-06-17)
5. https://lore.kernel.org/git/220725.86sfmpneqp.gmgdl@evledraar.gmail.com/
---
 .github/workflows/main.yml | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9afacfa0b33..1a86f6a8ce1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -265,10 +265,8 @@ jobs:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
-    - name: print test failures
+    - run: ci/print-test-failures.sh
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      shell: bash
-      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -297,10 +295,8 @@ jobs:
     - uses: actions/checkout@v1
     - run: ci/install-docker-dependencies.sh
     - run: ci/run-build-and-tests.sh
-    - name: print test failures
+    - run: ci/print-test-failures.sh
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      shell: bash
-      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v1
-- 
2.39.0.rc2.1019.gce04d262ea9

