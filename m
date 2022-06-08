Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88662C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 10:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiFHKng (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 06:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbiFHKnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 06:43:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A599842ED8
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 03:43:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k16so27802805wrg.7
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=DqD+dTZzhQGaYwKnI3hgziwFk290Xj5nE66D3I81A9Y=;
        b=FRTAguuxtIW6UoFrEd7c1SIc6s85SW7EkH9ZbHXdnhYgUwP4s9u05Zm47tM/OjTYW1
         ECA8CQZ8KEAKeNDKNewwE9ZD0LrTGdXEzVGAMDb+pnz4xrv9HCY+pGgUnFZoXVdbrLzx
         hBatUx/WSVxkwgezZoLfzXKGBgaPNN1aRRfxqfKrfflksDI4/APICc9ThYP17RkJMF+r
         AWQwG+417ghftArVjmrYqsBQ3i+FBWqhzZsyztJACJfjgRHGCSWX040UvWeez3iwKPE5
         22ZNrOTRvArssBea3UOo9K9frtA1oi2JKbrYziY17h0PmCsJLLTDyySXiHcCog+SUYNq
         4F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DqD+dTZzhQGaYwKnI3hgziwFk290Xj5nE66D3I81A9Y=;
        b=tOWrfWSX9XZMjbtC+5efHjBXbJsgSK9rcuZj3nZ6tPFjoaz7IetKv5oLeu8cR6H6gT
         l00OR938eywseQpkkm1v9iASYUhdYWQyN8Fw9Vx6Y4B2zUAFVUoPlPxqIXHQ+WfyICvD
         GN89+6squG9MAcvMWST4Xt2xBL8k3bN/yqS1ix8EhQqwICv3mLzetrgBxbh7qhVTEhuH
         qAjdPb+rqrxgbQN13XIXiHN/K+F1/D+fm9IAG7MfLT+oFSc2SYvmXBHJ1TImuBKWMsHR
         5DapGXTAzsl0JkC9u9d8xPsyfp+HiKfvSw+HUsF20ZdVQujO0IhJg5w+DjbtLLjpLI75
         yOXA==
X-Gm-Message-State: AOAM533TSI6FasxYIMp8Tn+ulXMx8AQdvMxAbasNQXOijhc2oIPrg1zO
        j+QExcc1+6asmIg96HqXOaQhh2in7dSlPggp
X-Google-Smtp-Source: ABdhPJwd+jhLrxjtnhnNLYy69e5qi6LuZi1U1WYn44syl+xISU/e/AX1F7udShsPaLMOYvjrWEd5NA==
X-Received: by 2002:a5d:620b:0:b0:210:11d9:770 with SMTP id y11-20020a5d620b000000b0021011d90770mr32638441wru.11.1654685000563;
        Wed, 08 Jun 2022 03:43:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16-20020adffc50000000b0020fdc90aeabsm20749811wrs.82.2022.06.08.03.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 03:43:19 -0700 (PDT)
Message-Id: <pull.1252.git.1654684998599.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jun 2022 10:43:18 +0000
Subject: [PATCH] ci(github): bring back the 'print test failures' step
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

Git now shows better information in the GitHub workflow runs when a test
case failed. However, when a test case was implemented incorrectly and
therefore does not even run, nothing is shown.

Let's bring back the step that prints the full logs of the failed tests,
and to improve the user experience, print out an informational message
for readers so that they do not have to know/remember where to see the
full logs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci(GitHub workflow): bring back the 'print test failures' step
    
    When an incorrectly-implemented test let a CI build fail
    [https://github.com/git/git/runs/6703333447?check_suite_focus=true#step:4:1750]
    without any failing test cases, the output was not helpful for readers
    who wished to investigate the problem:
    
    [...]
     751 ⏵Run tests
    1746 === Failed test: t3105-ls-tree-output ===
    1747 The full logs are in the artifacts attached to this run.
    1748 Error: Process completed with exit code 1.
    
    
    While this is still an improvement from before (where no output was
    shown in the test step at all, apart from the very high-level prove
    output), we can do better than point users to downloading the artifacts
    (which is a bit cumbersome).
    
    With this patch, the print test failures step is reintroduced. To make
    sure that readers know to look at it, we now print an explicit message
    [https://github.com/dscho/git/runs/6790035528?check_suite_focus=true#step:4:1741]:
    
    [...]
     749 ⏵Run tests
    1737 === Failed test: t3105-ls-tree-output ===
    1738 The full logs are in the 'print test failures' step below.
    1739 See also the 'failed-tests-*' artifacts attached to this run.
    1740 Error: Process completed with exit code 1.
    
    
    The "print test failures" step is still not expanded by default, but at
    least the output is now so nicely uncluttered that it is really easy to
    spot it: it is right below the above-quoted error message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1252%2Fdscho%2Fci-print-failures-again-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1252/dscho/ci-print-failures-again-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1252

 .github/workflows/main.yml | 16 ++++++++++++++++
 ci/lib.sh                  |  3 ++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 3fa88b78b6d..cd1f52692a5 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -119,6 +119,10 @@ jobs:
     - name: test
       shell: bash
       run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+    - name: print test failures
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      shell: bash
+      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -200,6 +204,10 @@ jobs:
       env:
         NO_SVN_TESTS: 1
       run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+    - name: print test failures
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      shell: bash
+      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -253,6 +261,10 @@ jobs:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
+    - name: print test failures
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      shell: bash
+      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -282,6 +294,10 @@ jobs:
     - uses: actions/checkout@v1
     - run: ci/install-docker-dependencies.sh
     - run: ci/run-build-and-tests.sh
+    - name: print test failures
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      shell: bash
+      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v1
diff --git a/ci/lib.sh b/ci/lib.sh
index 2f6d9d26e40..b142d254ec1 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -177,7 +177,8 @@ then
 			test_name="${test_exit%.exit}"
 			test_name="${test_name##*/}"
 			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
-			echo "The full logs are in the artifacts attached to this run."
+			echo "The full logs are in the 'print test failures' step below."
+			echo "See also the 'failed-tests-*' artifacts attached to this run."
 			cat "t/test-results/$test_name.markup"
 
 			trash_dir="t/trash directory.$test_name"

base-commit: 3069f2a6f4c38e7e599067d2e4a8e31b4f53e2d3
-- 
gitgitgadget
