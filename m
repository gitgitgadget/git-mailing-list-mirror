Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B577C2FC05
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 23:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347241AbjHPXup (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 19:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347205AbjHPXuU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 19:50:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7D210E9
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 16:50:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589bbefa960so61402187b3.2
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 16:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692229818; x=1692834618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7222NvHFblPaMdDeTXqnlyPL1gmZCiiVoGXyOZG5whU=;
        b=VIumFLHN0m4Hp72C5v8hXfhM1FqcX89qO85T/mEJ46CY//MrBsAT38LQGqXdO2/DXx
         jL9AuEmoJgJCOus2cLEKnlCwbJrP9okYr7FV6dP+KOmzjo/qWIjxCUkrN0MeAhGMQ5QG
         l/UrZgd6bUtqOuEQxlz0PqEmgcKU0N21hiIof32McH9bfLXnmeLmPQiqTfHlW1IIZ7Vb
         0+Bn0/EbSLD6K1Zdi4y5l5+vxpHVz3JqW0sTPJB8deCT9msLqyGhEqZXm0burpBlLUXz
         7jjjx+qnLb3aICPQv7M1D3XpfFi93EqfKe+4f6Qj1vU8/i6Khk42PU4fvOMZtyuBvk9B
         vlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692229818; x=1692834618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7222NvHFblPaMdDeTXqnlyPL1gmZCiiVoGXyOZG5whU=;
        b=IZ6HcwejsdZFEOdN4YZFH/dnUOHLd1KxY5c9wqVcZXmPsqhd+NnVpDhIE8pHPnhVDQ
         gq7cD1e3W4p2eobB9VDoNSgNpZwTbREGDVRJyjgpmH+gHdgko7dwblYYqYVXVF5BY5WN
         XAdBahkLPUrJtoH9Ak8Wb2SIK/00W0n+6plsPSVnFmR+ROfQSgEOwQQZ0IJzgH2T42AE
         dhBancvnZERtJOHCXY1cJS6MYwpgHGgZ7GVp5Gskcrqh2gnWvlJWZgZOJ45gFeB6niUY
         4MK9reB8Evu7Vt7YMMd34uU2YQQ6sYbfj6VRgzwzAl/zmn5v3b7GAvPPib7b3Ttpc2rs
         r9wQ==
X-Gm-Message-State: AOJu0YwsSR6vi4RvwLp+Tbib0bXGoPxefKPGpTAjIVlqD3IB87bzr+ui
        ac6lJcqLk4yIscFLsLeuynDn74JFn6rrNZ3jezDq9gCaS689f3fsjkx5sBwTB8WCVYtTFC+lFH+
        L2FFfe6E2vYEGiU3xUOsW3K/W1K2pdcK3zdZiUUyLN9GEFHKyJ9SGnqwTKApvjkk=
X-Google-Smtp-Source: AGHT+IGrTldYu9TXe+WiLpqbpxRuSD45/ZIpX5vjT1mzRLpXEQC1Oac05JR+UqZ/CnENZofOloso8xerDaw/Zg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:378f:b204:29bd:7043])
 (user=steadmon job=sendgmr) by 2002:a81:b649:0:b0:577:619e:d3c9 with SMTP id
 h9-20020a81b649000000b00577619ed3c9mr53128ywk.10.1692229818170; Wed, 16 Aug
 2023 16:50:18 -0700 (PDT)
Date:   Wed, 16 Aug 2023 16:50:07 -0700
In-Reply-To: <cover.1692229626.git.steadmon@google.com>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1692229626.git.steadmon@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <ea33518d00bed2cb3015ba37fe09b507eb986c2e.1692229626.git.steadmon@google.com>
Subject: [PATCH v6 3/3] ci: run unit tests in CI
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
2.41.0.694.ge786442a9b-goog

