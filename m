Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43040C433FE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6C1610CC
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhJLRot (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhJLRop (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 13:44:45 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC54C061753
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 10:42:43 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id ge16-20020a17090b0e1000b001a06598a6e2so154306pjb.0
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XT7UuvjvDNjhu3lzzVi+jQFb4RArdnvsMeEnZPjndI4=;
        b=j79N1MoB9XMbAukSjbMO3W+59vdIJ9mM+cq0a48qe//m6so/qFd8YYweF4he1+hdxd
         wNLcvX8SX5/YYnaKnAHLCcKuDep9wMBsqh6Y6RJQU1tE4gD76yO6zwx++BcVKl3zaBpW
         ZuzCqk7HiZMU0l0w4CPH/f/3NL1qljXtRscwR+ITTQKB0gLyBYRSd+tHdcOIazvMX+/U
         QJw71l7aBECEPy6IIpR+BDE8UUlxmdyCYT9UbRSsKJJecJZhiKWe88tmLams0txWUTnO
         f7TcNCpRRuveFVRn3aqQz7eVjj9t8ErUZ9kr4go7OgpV0MMdJtzGU4Ia9gPZ/Q6ggCQq
         /xrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XT7UuvjvDNjhu3lzzVi+jQFb4RArdnvsMeEnZPjndI4=;
        b=b1swu6aD/kHQ/rsNh6EKjg7vYbqMjlxXGgh77zLmZn1vqo2OettMq8qKTkoM2BmNR8
         SsPI77CkElbdfSM+RGX32gQsuekwuc+mAkQaNO2QL57D5SC9zlliOKB60hx28s+AO1c4
         lS/1aCKgRIRxq6EeMhVph3ejHMjqBO3hpQYgSOsyBTVLiZeyXg5dKizh/bSs/097IBTv
         9APqxv4sw4cRWSNHCpO5c4rFGYn5FL7EDCeI8EnA3ZocW5aCsH1qL3zZMnLi9l+zS4xe
         G/2XqQuj6Pib202wtZ11pb7rVYXbrxbJfEkdu9FOG2DU5andBYagRJhfGfV0Oi+nUBAe
         24UA==
X-Gm-Message-State: AOAM532Xto7VT/d3fH8w0kH9oAV0YnQc1jBkhKLWjJGBdh5KfQzCZFjX
        Xdq5jQQsSUdttszoKmOGtO23VBH4Mh/2UCYv+9jLPk8gDJkVINx/U5llL7IVhDImOLwY74F2/CD
        JV8/JE8y4+5+9VeKpEAjvIBWXEfc0E/RQxFm6sIJC8d2Lz63gSR4niLvyXCd1PpQ=
X-Google-Smtp-Source: ABdhPJw3wTOoW5gMSGuENjQUuTvdihlvWEn+ULEXxVeiE6EEaEjyU1+aj6U9N/Y/PtOP+jymn574vs94Ra+0sQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:3d4c:: with SMTP id
 k73mr23987299pga.44.1634060563071; Tue, 12 Oct 2021 10:42:43 -0700 (PDT)
Date:   Tue, 12 Oct 2021 10:42:08 -0700
In-Reply-To: <20211012174208.95161-1-chooglen@google.com>
Message-Id: <20211012174208.95161-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211005001931.13932-1-chooglen@google.com> <20211012174208.95161-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 3/3] gc: perform incremental repack when implictly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
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
2.33.0.882.g93a45727a2-goog

