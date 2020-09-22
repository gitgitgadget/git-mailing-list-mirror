Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FCFC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F071F20BED
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="OkWVhJjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIVWvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIVWvc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:51:32 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1BCC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:32 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cr8so10413226qvb.10
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cOvQ52Ig5ZRc5vUR0VIpNJbijlT/WkZ8/uPa+mqYwwY=;
        b=OkWVhJjRaiuCGETZU4+Ng6hfKn4/mtBT/OZNP9N9a6iZQm72U/Nx2oZons1SgEChAX
         7jcRexLIbPDXXw+VGBF2vexMIrVT0c+/B9odYYSGiANVfY6k2gSv7hsD1uC11+/l3Ywx
         mVChbhuhsE7QNEpwxLW7xcwGuojHBsS7wiDn8FMSWWUEU03E04naphDFfSGLNm7hDU92
         bsYM8vr4iJ7wqBbSacdVJLZNJs2qi5IYG4hIJCX95D4DQX8Tcgd2YciPuolF4VaQrkHG
         wcLBu9KasWdMhVtS6Ogx7QzPPjsy16677U96Lwg1opMdoQhKedpsyixSDaP/bBrazWk7
         6k7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOvQ52Ig5ZRc5vUR0VIpNJbijlT/WkZ8/uPa+mqYwwY=;
        b=SpQSVdox72G5GNYw1ZZPg4naZI1cnX81z4Cm/NNw8NHRZlqiZLBGT1mpE79ZgfPlP5
         UrZ5X+18MeMboaH3fc7ny8M1r/RIk0krmRR1cQTPYPMx661YVtSNaqvBGSoXLaQFMaj1
         NXGTPmGqaBk0INnw47fED/Gy7J3rToo9PMoFRqHxDdvvHoXBiXA5h+sHh5HQX6mzTSAi
         NaqMQF7+Ogm+v+6APUzGQsA4NMi0TiqVTROe/Xsl1DZRIf4giKeuCYqgRVGBBV+XGLlm
         ps8y0ywnYvQYY0VWhcCercpw0SqFdt80PfQQkIxFmPGqEG6oVytqrHkNSPTdi9EWQfY6
         +gfA==
X-Gm-Message-State: AOAM5338FRkEWAm4TKKeYhrErIWScDNkPDc3Qyy5jH+skbwDdyKYKeL4
        +tjs5oUrt6mHDmaomCoYiZC6X6VdOhU+8w==
X-Google-Smtp-Source: ABdhPJxr29NkgJHdk9NRpzYB4z2QzxU5fxU/HuL8oHiKIsFC+8vORcyXuKmb1U6fVeWx5YEZMQBXTg==
X-Received: by 2002:a05:6214:1181:: with SMTP id t1mr8631711qvv.11.1600815091558;
        Tue, 22 Sep 2020 15:51:31 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:51:30 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 19/19] ci: run test round with parallel-checkout enabled
Date:   Tue, 22 Sep 2020 19:49:33 -0300
Message-Id: <b4cb5905d2240b5605ea6f9190ef02f49bf7042e.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have tests for the basic parallel-checkout operations. But
this code can also run in other commands, such as git-read-tree and
git-sparse-checkout, which are currently not tested with multiple
workers. To promote a wider test coverage without duplicating tests:

1. Add the GIT_TEST_CHECKOUT_WORKERS environment variable, to optionally
   force parallel-checkout execution during the whole test suite.

2. Include this variable in the second test round of the linux-gcc job
   of our ci scripts. This round runs `make test` again with some
   optional GIT_TEST_* variables enabled, so there is no additional
   overhead in exercising the parallel-checkout code here.

Note: the specific parallel-checkout tests t208* cannot be used in
combination with GIT_TEST_CHECKOUT_WORKERS as they need to set and check
the number of workers by themselves. So skip those tests when this flag
is set.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 ci/run-build-and-tests.sh               |  1 +
 parallel-checkout.c                     | 14 ++++++++++++++
 t/README                                |  4 ++++
 t/lib-parallel-checkout.sh              |  6 ++++++
 t/t2081-parallel-checkout-collisions.sh |  1 +
 5 files changed, 26 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6c27b886b8..aa32ddc361 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -22,6 +22,7 @@ linux-gcc)
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
+	export GIT_TEST_CHECKOUT_WORKERS=2
 	make test
 	;;
 linux-clang)
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 5156b14c53..94b44d2a48 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -32,6 +32,20 @@ enum pc_status parallel_checkout_status(void)
 
 void get_parallel_checkout_configs(int *num_workers, int *threshold)
 {
+	char *env_workers = getenv("GIT_TEST_CHECKOUT_WORKERS");
+
+	if (env_workers && *env_workers) {
+		if (strtol_i(env_workers, 10, num_workers)) {
+			die("invalid value for GIT_TEST_CHECKOUT_WORKERS: '%s'",
+			    env_workers);
+		}
+		if (*num_workers < 1)
+			*num_workers = online_cpus();
+
+		*threshold = 0;
+		return;
+	}
+
 	if (git_config_get_int("checkout.workers", num_workers))
 		*num_workers = 1;
 	else if (*num_workers < 1)
diff --git a/t/README b/t/README
index 2adaf7c2d2..cd1b15c55a 100644
--- a/t/README
+++ b/t/README
@@ -425,6 +425,10 @@ GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
 use in the test scripts. Recognized values for <hash-algo> are "sha1"
 and "sha256".
 
+GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
+to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
+execution of the parallel-checkout code.
+
 Naming Tests
 ------------
 
diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index c95ca27711..80bb0a0900 100644
--- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -1,5 +1,11 @@
 # Helpers for t208* tests
 
+if ! test -z "$GIT_TEST_CHECKOUT_WORKERS"
+then
+	skip_all="skipping test, GIT_TEST_CHECKOUT_WORKERS is set"
+	test_done
+fi
+
 # Runs `git -c checkout.workers=$1 -c checkout.thesholdForParallelism=$2 ${@:4}`
 # and checks that the number of workers spawned is equal to $3.
 git_pc()
diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-checkout-collisions.sh
index 3ce195b892..5dbff54bfb 100755
--- a/t/t2081-parallel-checkout-collisions.sh
+++ b/t/t2081-parallel-checkout-collisions.sh
@@ -3,6 +3,7 @@
 test_description='parallel-checkout collisions'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
 
 # When there are pathname collisions during a clone, Git should report a warning
 # listing all of the colliding entries. The sequential code detects a collision
-- 
2.28.0

