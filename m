Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9801C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8A860EE2
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbhJOUSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 16:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242941AbhJOUSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 16:18:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98165C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:16:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y18-20020a25a092000000b005bddb39f160so10962935ybh.10
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AWuPO+FVFJmGP5qoN/nPTJvrJHzGFTibBhJ7m0xywW4=;
        b=B8e0uts0NPPNufJRRCBptgWSjJnQaVw080edJTnQRC0FdbxX5C1YxSCu9UtdjLHYsj
         RCNqwRswiRiCQo87C4ZEAN0/odq+cYf5GfS6bj6KFyA7wCmFdJlt9YzmaCvNIZTqcwu+
         RJNUOV9cWzxLo+dASh8D7LT+eJAiLlH/ZXwc3i/qJxTAEQ55agw8x20iztNZngAwOtLZ
         tGntTwQGZNsxG9iKrCxfQ2LMaMT5KLmKz0W3+uZUXAst4m7E2GDXgZTadIu4fAmU53kY
         yGwq45pNRjtE2+HZaMXxzk/MJ0nhTC8PydfAhz1Lmb+7J7M7yU+RJw0OJ+dScAtV6iR4
         ke4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AWuPO+FVFJmGP5qoN/nPTJvrJHzGFTibBhJ7m0xywW4=;
        b=e32BTjdhY9eSLuPU10nIgFzBdk2MVy4usWcNnRyrlnvU/qNVmvKTyAWUoQN4Bs1D+A
         G1i3YIonwPN4NNqLrGhZCi7z31O7FG7l3dbTWaIpHgOV4iOhkPQ7plEJD1nre9CFXV1E
         hXJxQOcIo0rTS/vlobNdxPYbZWFf61LTcV0aIFgH7hEyUkp52UK01893EiYKAQIcMnA/
         1o74LlrpRW1zylHK9HJcXcC7meXVOuscY07InlXkGECVyYOAxRKxdcjPuZhldqLoK/k8
         8u9SkZLvCjIsKOtUcL2PdkzBo2EIjpw8yJCXsrOsggraGfuokDLPzg4YPL6dg9QR9hgC
         CR7Q==
X-Gm-Message-State: AOAM533V2wnJUGRWqxqRJtzUMDtBrNnlhQ46AJ2CUgHPlTYbXqYDzKWP
        ML5xYkCrHaQ3N0Qzava/vaak+Mm+xaITeGvBwB+ol3L8RPkZ9Qc03LyzVks8vbeMnS1JK3sL/FU
        SQZloVBzsVCgK9dxQ+aM2aZd5vBhj6MSFsE8A4zBwKwUibsvADWSSJ3TeyzZAvm8=
X-Google-Smtp-Source: ABdhPJzGIJsfKk0H2f12/xnzkBeqULc5izIiyJaKkHFBBwcxvyuGQJqL9SmyMqJU7WwqBfY4pdFXgCnFDKRmig==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:dac5:: with SMTP id
 n188mr15253066ybf.85.1634329001786; Fri, 15 Oct 2021 13:16:41 -0700 (PDT)
Date:   Fri, 15 Oct 2021 13:16:31 -0700
In-Reply-To: <20211015201631.91524-1-chooglen@google.com>
Message-Id: <20211015201631.91524-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211012174208.95161-1-chooglen@google.com> <20211015201631.91524-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 3/3] gc: perform incremental repack when implictly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
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
index 6b3de3dd51..2670931160 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1049,12 +1049,11 @@ static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
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
index 9b9f11a8e7..74aa638475 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -336,15 +336,15 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
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
@@ -353,7 +353,7 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 		-c maintenance.incremental-repack.auto=2 \
 		maintenance run --auto --task=incremental-repack 2>/dev/null &&
 	test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
-	test_commit B &&
+	test_commit C &&
 	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
 	HEAD
 	^HEAD~1
@@ -362,6 +362,26 @@ test_expect_success 'maintenance.incremental-repack.auto' '
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
2.33.0.1079.g6e70778dc9-goog

