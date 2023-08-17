Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B11C3DA58
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 18:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354491AbjHQSiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354477AbjHQShf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 14:37:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2FE2D7D
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 11:37:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c561f4ac3so1404547b3.2
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692297453; x=1692902253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzilSjRztWKVI46TSW7ThaXtJzeU1VGqyoMbhV1Tv2k=;
        b=UbQv1sen25upvSYvolAPRaZfs7EG76iG1VmPHOyKVSUpRtXMUitI0NylxgTMDHDPwN
         QFNC3TkuJ/wdi6R0RBRjhzPzVmODBtdFP3dqUZ5LIOEU+ApEitLzoQwUEU7Kw8A5qgHw
         xZTzjUik00K+Hb1/MhUz+kbrdCIKtHa5eZ6HqHmOj7vxVY3F5YF4vWURMZDIa5Nisxfd
         DzgNhcHE6gtH60N7wru/0xrZWL6X/vUYxrJYDMZzCEc3BwnOWGFMWWXM1IHNnID2+1i+
         lZZuExdnLXlEfHTQFsm5cUcTcmHAKQnp3LTRBATm9jj9/Aa3peI3M7NpbwneQtvFsTxL
         Xnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692297453; x=1692902253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzilSjRztWKVI46TSW7ThaXtJzeU1VGqyoMbhV1Tv2k=;
        b=SZb5463iYwol0G7ZH3fr1wTLhRoTy3uT5DQ7GLIv2rKHjBmBhqnZtiKtiFnJFDg1mI
         SMtGx2W+0L2tqdmlVLWyUmmrXA0oivl0aoNqob42lzum/5SxFcti2Dp1l+XIjpqGD5Ve
         VM/fUdLhUHT+RlbgbcIMqZExEjA3vsm7cbtYpGHQ90Mg1ZdJgEIeDR5V1cnfEKuRUnff
         xOOQurA1bkxsf2gjZGNR7fafXzboN2ZHS/WrergRI/wevvwMj3EXZnDVnZEJvYwfJwkE
         /5CtRPEfbMAZdVbz0BZaIXDCz7XyDY4u+OdRxtGjpvwhyVneeEexwcJ78eRombRt5HeB
         FLyQ==
X-Gm-Message-State: AOJu0YwaIPn0aIROBMMghthbLchvGWExulLZIXPJ0dFxbL60YIdDm+0j
        2S1EH35jQk4RkydvE1Kd4gdzHYsawSUVS6UbpFIX/gH58kJ+XOgnNr5Hpgydh+tMZYoZ/YLRqt5
        XHDcFTpziRoytUvZC2GcvhHH1ADdNLvIB9pEoG3uiDp/O7KQoEYWiYN7b3UD0E/w=
X-Google-Smtp-Source: AGHT+IETSV5tGCX7DvkpIvcBm30jt0W35HihMCgTZuTifIRbHfqNNJRVHqrzbBU74Lhmfj+HQTSahIVDkkI6+g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:e60a:f80e:4b7a:6509])
 (user=steadmon job=sendgmr) by 2002:a81:4305:0:b0:583:591d:3d6c with SMTP id
 q5-20020a814305000000b00583591d3d6cmr4391ywa.0.1692297453359; Thu, 17 Aug
 2023 11:37:33 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:37:23 -0700
In-Reply-To: <cover.1692297001.git.steadmon@google.com>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1692297001.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <abf4dc41ac73d6bd13e338e0031cc12e0eb3e271.1692297001.git.steadmon@google.com>
Subject: [PATCH v7 3/3] ci: run unit tests in CI
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     linusa@google.com, calvinwan@google.com, phillip.wood123@gmail.com,
        gitster@pobox.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Run unit tests in both Cirrus and GitHub CI. For sharded CI instances
(currently just Windows on GitHub), run only on the first shard. This is
OK while we have only a single unit test executable, but we may wish to
distribute tests more evenly when we add new unit tests in the future.

We may also want to add more status output in our unit test framework,
so that we can do similar post-processing as in
ci/lib.sh:handle_failed_tests().

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .cirrus.yml               | 2 +-
 ci/run-build-and-tests.sh | 2 ++
 ci/run-test-slice.sh      | 5 +++++
 t/Makefile                | 2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 4860bebd32..b6280692d2 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -19,4 +19,4 @@ freebsd_12_task:
   build_script:
     - su git -c gmake
   test_script:
-    - su git -c 'gmake test'
+    - su git -c 'gmake DEFAULT_UNIT_TEST_TARGET=unit-tests-prove test unit-tests'
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2528f25e31..7a1466b868 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -50,6 +50,8 @@ if test -n "$run_tests"
 then
 	group "Run tests" make test ||
 	handle_failed_tests
+	group "Run unit tests" \
+		make DEFAULT_UNIT_TEST_TARGET=unit-tests-prove unit-tests
 fi
 check_unignored_build_artifacts
 
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index a3c67956a8..ae8094382f 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -15,4 +15,9 @@ group "Run tests" make --quiet -C t T="$(cd t &&
 	tr '\n' ' ')" ||
 handle_failed_tests
 
+# We only have one unit test at the moment, so run it in the first slice
+if [ "$1" == "0" ] ; then
+	group "Run unit tests" make --quiet -C t unit-tests-prove
+fi
+
 check_unignored_build_artifacts
diff --git a/t/Makefile b/t/Makefile
index 2db8b3adb1..095334bfde 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -42,7 +42,7 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
-UNIT_TESTS = $(sort $(filter-out %.h %.c %.o unit-tests/t-basic%,$(wildcard unit-tests/*)))
+UNIT_TESTS = $(sort $(filter-out %.h %.c %.o unit-tests/t-basic%,$(wildcard unit-tests/t-*)))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
-- 
2.42.0.rc1.204.g551eb34607-goog

