Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493DEC433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3473761247
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhJEAVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 20:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhJEAVq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 20:21:46 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB44C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 17:19:56 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id t4-20020a62ea04000000b0044b333f5d1bso9979197pfh.20
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gCcN3OjOStawLoGGgqtCJg0NEtHKqK3MkfEr5Vuqtk4=;
        b=lZAuRJI5Ikzw/9XR2ksM5q88V9nk19IFcfJfDGbdsPA3Ddj31Gf60jPIYraE2zgcjf
         KsKdOExi5UNkQIU/jHr8Mr7+iXRVLEiz/EYLgjae2SHDCgCW2JGQ5kDt/NeqzIGbokHk
         GMfTKXnGJP6HqfRabSQupz0iytJeaFudV21lf4ytje2mp0Wm17+iqDj1tW76ICxPQiY4
         QEObKz0/fyHAylJLG/oL4cuysxLw+BMJ55QaZxqacdl3h0sI1hOC6klUudKBxcJ52KZQ
         vV9bhPGc4MIC694sRxVHdxvVCpSV6vV2XhNKPyhj20NIv8Qw3dMvLlCDTnsH1Q7e02KZ
         mM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gCcN3OjOStawLoGGgqtCJg0NEtHKqK3MkfEr5Vuqtk4=;
        b=PYIkffzHiJer7tdkSwvEr6tW+eyykvhm4/2eQXsPFk/mWeg5x4khmHtMQbCg3fiWcl
         vTQtmv5xafLiQ+qqiUbTBMJdjLIYh6rR35YoUv6xURNmeSBmWpFaw37pWP/koWZYl6QA
         ax3O1PTR4YZ1k1bpmVl6ebFvvgoxPc6WstG8VDt9/i6fbDWa7x2p81FiC6g2flR8bY+k
         cCqZhyIi8VYlQMRZlVfKGHqkRORpoglXuPckdb673bdjxV/QL81lxVjUou7OMGCvnwFR
         Bi8TWLG/UPhALfx91G+LOqGl6X7w6Yr+MNll2MpT5hRzICjxoatB3ONPrOWVrkog7M7z
         ms1Q==
X-Gm-Message-State: AOAM530iM+yYCpLITtchaw9xiPNcdxdO8bua/3q0BNfPZI3cRiatCstB
        H1aOfYmczK4p+pY3MErLAxAkkEUKQg1scTgCMFpEK+Roh0Eb4vOm7VRnhX6Z9lYLsxLMqWmPuUp
        y27PsIdCHaUEgTkfxnXg3EPqlC5Qu6AOuOs81GET+1u6ulyL5p9Xlm9KV6YaTzGg=
X-Google-Smtp-Source: ABdhPJw0RJFyrFkK7ng+jsERmBVKHI5PtMqMrFdnDl16zcZCtjsaoeUX5oPL6ml0D3aDgc7WYiiU2zkeJ9IQ3w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:9882:b0:13e:1749:daae with SMTP
 id s2-20020a170902988200b0013e1749daaemr2343207plp.60.1633393195354; Mon, 04
 Oct 2021 17:19:55 -0700 (PDT)
Date:   Mon,  4 Oct 2021 17:19:31 -0700
In-Reply-To: <20211005001931.13932-1-chooglen@google.com>
Message-Id: <20211005001931.13932-4-chooglen@google.com>
Mime-Version: 1.0
References: <20210917225459.68086-1-chooglen@google.com> <20211005001931.13932-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v3 3/3] gc: perform incremental repack when implictly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/gc.c has two ways of checking if multi-pack-index is enabled:
- git_config_get_bool() in incremental_repack_auto_condition()
- the_repository->settings.core_multi_pack_index in
  maintenance_task_incremental_repack()

The two implementations have existed since the incremental-repack task
was introduced in e841a79a13 (maintenance: add incremental-repack auto
condition, 2020-09-25). These two values can diverge because
prepare_repo_settings() enables the feature in the_repository->settings
by default.

In the case where core.multiPackIndex is not set in the config, the auto
condition would fail, causing the incremental-repack task to not be
run. Because we always want to consider the default values, we should
always use the_repository->settings.

Standardize on using the_repository->settings.core_multi_pack_index to
check if multi-pack-index is enabled.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/gc.c           |  5 ++---
 t/t7900-maintenance.sh | 28 ++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index f05d2f0a1a..070b7dccb1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1051,12 +1051,11 @@ static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
 static int incremental_repack_auto_condition(void)
 {
 	struct packed_git *p;
-	int enabled;
 	int incremental_repack_auto_limit = 10;
 	int count = 0;
 
-	if (git_config_get_bool("core.multiPackIndex", &enabled) ||
-	    !enabled)
+	prepare_repo_settings(the_repository);
+	if (!the_repository->settings.core_multi_pack_index)
 		return 0;
 
 	git_config_get_int("maintenance.incremental-repack.auto",
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 58f46c77e6..7b1b2581af 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -321,15 +321,15 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
 		 --no-progress --batch-size=2147483647 <run-2g.txt
 '
 
-test_expect_success 'maintenance.incremental-repack.auto' '
+run_incremental_repack_and_verify () {
+	test_commit A &&
 	git repack -adk &&
-	git config core.multiPackIndex true &&
 	git multi-pack-index write &&
 	GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
 		-c maintenance.incremental-repack.auto=1 \
 		maintenance run --auto --task=incremental-repack 2>/dev/null &&
 	test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
-	test_commit A &&
+	test_commit B &&
 	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
 	HEAD
 	^HEAD~1
@@ -338,7 +338,7 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 		-c maintenance.incremental-repack.auto=2 \
 		maintenance run --auto --task=incremental-repack 2>/dev/null &&
 	test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
-	test_commit B &&
+	test_commit C &&
 	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
 	HEAD
 	^HEAD~1
@@ -347,6 +347,26 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 		-c maintenance.incremental-repack.auto=2 \
 		maintenance run --auto --task=incremental-repack 2>/dev/null &&
 	test_subcommand git multi-pack-index write --no-progress <trace-B
+}
+
+test_expect_success 'maintenance.incremental-repack.auto' '
+	rm -rf incremental-repack-true &&
+	git init incremental-repack-true &&
+	(
+		cd incremental-repack-true &&
+		git config core.multiPackIndex true &&
+		run_incremental_repack_and_verify
+	)
+'
+
+test_expect_success 'maintenance.incremental-repack.auto (when config is unset)' '
+	rm -rf incremental-repack-unset &&
+	git init incremental-repack-unset &&
+	(
+		cd incremental-repack-unset &&
+		test_unconfig core.multiPackIndex &&
+		run_incremental_repack_and_verify
+	)
 '
 
 test_expect_success 'pack-refs task' '
-- 
2.33.0.800.g4c38ced690-goog

