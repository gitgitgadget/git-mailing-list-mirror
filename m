Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4518C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BCD61222
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbhDVPTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbhDVPS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 11:18:58 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E0FC06138B
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:23 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id bs7so21671498qvb.12
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/TaqGOy5FFgW09kpy4dpdt/P4d0VaTPgGmFRT+BnrbM=;
        b=pKKUpVI28X9EiB2Nhji3tj+j4ttP86rsnsVO6gUz+ov7Ts5ag/yVzVzXmMBxW7pjFo
         HV7xbuJUz+RgMvl9UHFA3LpwSHMY6+TE7XKiIe9x4LlSuMk/LzXNpTX9EXhI7/BPvC7X
         FRl9SYx8fmRY1ajfaWnddwdX69BILn5+IBZMRfFfd0eDo+s5E2Y3AP5UZPd4YG3sxSRR
         DbTUi/9vTF9fb8UI+FgFZ56/j6uBDCkrV/ZErNBt9DQjGGnb3PhsQEvtDVsmyQc5ctz+
         BNmO14arbgQdvgfZ8xxqCv+xBO4wJkuxpvjL6s7Emz9oY/BsIj1NI37GvqiklDX7VVLN
         spsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TaqGOy5FFgW09kpy4dpdt/P4d0VaTPgGmFRT+BnrbM=;
        b=torPLrWUnmca1lWpTczzwgSBV8FatEtEvqi6It5TGtGxCVr3nGeAOpPSVP6LKBpWxP
         8jI1utliv0zGJKj1dJuyP1rYGTRP5lxJ52nXhYvwf1H64QJ1UcqfsHzdgaFB0tVscbaD
         +eFxFdsp45f8nFUhOpK3ub9soJbLoEWF351FWIvOVcCfQsY2EbQPCcAuwD8uQJEK1XvR
         V7tLXTYGkEwjXuW/rk4Hj2GLogwe/G86AZuAA/AxHGE3faOGRlBNmFDwI3lPbhUILPzD
         SC/3tCUS2ui3A8KehSUJ0ZEYYoU6RfFvO4+HP8d4bGh0Th7lPOk4Qyxj5LKMTDhohSuT
         0adw==
X-Gm-Message-State: AOAM533wYfquqRhf/gaZn1KEzAi9RkAg2SysU/MTFSnGRuzxm0931Bul
        7Xc7HmhAC7XTpPyFVGrPnrN08jIlWRgFAg==
X-Google-Smtp-Source: ABdhPJzcx+K7y7nTF2J7t7ctk9qHmMThVAkvjyO3GIgGQgfcG1DvOwWXZZJCKwI4d/tX1gzMxUy9ew==
X-Received: by 2002:a0c:f744:: with SMTP id e4mr4171371qvo.5.1619104701942;
        Thu, 22 Apr 2021 08:18:21 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id l16sm2348909qkg.91.2021.04.22.08.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 08:18:21 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com
Subject: [PATCH 7/7] ci: run test round with parallel-checkout enabled
Date:   Thu, 22 Apr 2021 12:17:53 -0300
Message-Id: <f7c20e0b5bd7857b2303aab762f24c503e50030d.1619104091.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619104091.git.matheus.bernardino@usp.br>
References: <cover.1619104091.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have tests for the basic parallel-checkout operations. But
this code can also run be executed by other commands, such as
git-read-tree and git-sparse-checkout, which are currently not tested
with multiple workers. To promote a wider test coverage without
duplicating tests:

1. Add the GIT_TEST_CHECKOUT_WORKERS environment variable, to optionally
   force parallel-checkout execution during the whole test suite.

2. Set this variable (with a value of 2) in the second test round of our
   linux-gcc CI job. This round runs `make test` again with some
   optional GIT_TEST_* variables enabled, so there is no additional
   overhead in exercising the parallel-checkout code here.

Note that tests checking out less than two parallel-eligible entries
will fall back to the sequential mode. Nevertheless, it's still a good
exercise for the parallel-checkout framework as the fallback codepath
also writes the queued entries using the parallel-checkout functions
(only without spawning any worker).

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 ci/run-build-and-tests.sh  |  1 +
 parallel-checkout.c        | 14 ++++++++++++++
 t/README                   |  4 ++++
 t/lib-parallel-checkout.sh |  3 +++
 4 files changed, 22 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index a66b5e8c75..23b28e7391 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -25,6 +25,7 @@ linux-gcc)
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
+	export GIT_TEST_CHECKOUT_WORKERS=2
 	make test
 	;;
 linux-clang)
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 6fb3f1e6c9..6b1af32bb3 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -35,6 +35,20 @@ static const int DEFAULT_NUM_WORKERS = 1;
 
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
 		*num_workers = DEFAULT_NUM_WORKERS;
 	else if (*num_workers < 1)
diff --git a/t/README b/t/README
index fd9375b146..a194488f27 100644
--- a/t/README
+++ b/t/README
@@ -436,6 +436,10 @@ and "sha256".
 GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
 'pack.writeReverseIndex' setting.
 
+GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
+to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
+execution of the parallel-checkout code.
+
 Naming Tests
 ------------
 
diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index 16ee18389b..0921a32b96 100644
--- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -1,5 +1,8 @@
 # Helpers for t208* tests
 
+# Parallel checkout tests need full control of the number of workers
+unset GIT_TEST_CHECKOUT_WORKERS
+
 set_checkout_config () {
 	if test $# -ne 2
 	then
-- 
2.30.1

