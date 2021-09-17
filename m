Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD12C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A9860F48
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbhIQW4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhIQW4n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 18:56:43 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B11C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:55:21 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bk33-20020a05620a1a2100b00432fff50d40so1478313qkb.22
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OBonV8wJNHgVAJhZ+ZBR/kwADT7nTt5n9XSFmZNj6rw=;
        b=dTHHELJT9eYhEWsXgYt2oEsZItdtGBo+P56yOtIP6WEIDPMbLCodcvdbrHw9BDjD87
         Eodx5xvk8EmY7T463ZerryPobeKAkGlpWO4f+KhHR3y9oZYNyvsXfSfK4YnPciNG6OLq
         RDtkJaRZx/Qna81bUR5AFIaGkSgK6LL/iedN4G521o0cwRsb0tkpfZw0ckOcOjvTE39K
         UjovcGiouYHWmEXBdazh7YYL6tzRUb0t1gTli5cnXa31GQ/rvCVUtiAjwJ2OibUYiUQt
         iviAR679wUafsqNpEudKofmEhQV2NOBz8D/7RrCdhVrOiugJKHaZcb76DFf+C6RRkvmq
         xbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OBonV8wJNHgVAJhZ+ZBR/kwADT7nTt5n9XSFmZNj6rw=;
        b=a9UT+JX2fvpp9J9AR4SESnF4aMtsNushqPMZdc4cB9ATV5b4+uZiMoJqvqyvNeD/GA
         IWAx9cp/R1r3T6/0HDTNAZoUzVKpG8+qY1eXCGU+x7xafKbgS+2Gkbio+8L5s7UuVIoZ
         Mbg91Dfkxw+s87MFH01N3O4mfNmePgvRZPU/d0hA/jxNnTQGqJAt5nzkCEc2Ix/JM5nx
         8zJfPOup/3Uj4Q9jNlkdaBzQ1DDNyFNIyX5kOsy6ViTbJcd0pan6ETVCZYFgNFZk1V3y
         EcQ9SrmC6OAcpPs5zdOHFk/jOoQqmOTFsY332zV3qN9OJt+5EeOtqnrUUINGkMjvNpMq
         XiZg==
X-Gm-Message-State: AOAM533fakTy/wMY9Dapc7ObrEYLhOtSdHqpzwUcjGFM6i8gSztL6Jx3
        97mAYlAvmPuonEbZ1IWe6wOs416zjizLCUA//PrNuwGZAnmlm1k3euj2ldYbAQKzQ5iL2cS/owL
        /xhZUM9WrAm8LYm8dnF9U0zHEbgrfeiVPdQPr1iVMHZwK5ypfYJnrsOxSuuXyeh4=
X-Google-Smtp-Source: ABdhPJxXHVSFtPhIpIJug4CiynSm4wpw0sCAT0nRi0B7u/1h9qHy08Y7CotjGuA49kJRy9K7OMhutuCFzWUu/g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:ad4:5508:: with SMTP id
 az8mr14103862qvb.10.1631919320532; Fri, 17 Sep 2021 15:55:20 -0700 (PDT)
Date:   Fri, 17 Sep 2021 15:54:59 -0700
In-Reply-To: <20210917225459.68086-1-chooglen@google.com>
Message-Id: <20210917225459.68086-4-chooglen@google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210917225459.68086-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 3/3] gc: perform incremental repack when implictly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
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
just always just use the_repository->settings.

Standardize on using the_repository->settings.core_multi_pack_index to
check if multi-pack-index is enabled.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/gc.c           |  5 +--
 t/t7900-maintenance.sh | 88 ++++++++++++++++++++++++++++++------------
 2 files changed, 65 insertions(+), 28 deletions(-)

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
index 58f46c77e6..2c77ddded1 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -322,31 +322,69 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
 '
 
 test_expect_success 'maintenance.incremental-repack.auto' '
-	git repack -adk &&
-	git config core.multiPackIndex true &&
-	git multi-pack-index write &&
-	GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
-		-c maintenance.incremental-repack.auto=1 \
-		maintenance run --auto --task=incremental-repack 2>/dev/null &&
-	test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
-	test_commit A &&
-	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
-	HEAD
-	^HEAD~1
-	EOF
-	GIT_TRACE2_EVENT=$(pwd)/trace-A git \
-		-c maintenance.incremental-repack.auto=2 \
-		maintenance run --auto --task=incremental-repack 2>/dev/null &&
-	test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
-	test_commit B &&
-	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
-	HEAD
-	^HEAD~1
-	EOF
-	GIT_TRACE2_EVENT=$(pwd)/trace-B git \
-		-c maintenance.incremental-repack.auto=2 \
-		maintenance run --auto --task=incremental-repack 2>/dev/null &&
-	test_subcommand git multi-pack-index write --no-progress <trace-B
+	(
+		git init incremental-repack-true &&
+		cd incremental-repack-true &&
+		git config core.multiPackIndex true &&
+		test_commit A &&
+		git repack -adk &&
+		git multi-pack-index write &&
+		GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
+			-c maintenance.incremental-repack.auto=1 \
+			maintenance run --auto --task=incremental-repack 2>/dev/null &&
+		test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
+		test_commit B &&
+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+		HEAD
+		^HEAD~1
+		EOF
+		GIT_TRACE2_EVENT=$(pwd)/trace-A git \
+			-c maintenance.incremental-repack.auto=2 \
+			maintenance run --auto --task=incremental-repack 2>/dev/null &&
+		test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
+		test_commit C &&
+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+		HEAD
+		^HEAD~1
+		EOF
+		GIT_TRACE2_EVENT=$(pwd)/trace-B git \
+			-c maintenance.incremental-repack.auto=2 \
+			maintenance run --auto --task=incremental-repack 2>/dev/null &&
+		test_subcommand git multi-pack-index write --no-progress <trace-B
+	)
+'
+
+test_expect_success 'maintenance.incremental-repack.auto (when config is unset)' '
+	(
+		git init incremental-repack-unset &&
+		cd incremental-repack-unset &&
+		test_unconfig core.multiPackIndex &&
+		test_commit A &&
+		git repack -adk &&
+		git multi-pack-index write &&
+		GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
+			-c maintenance.incremental-repack.auto=1 \
+			maintenance run --auto --task=incremental-repack 2>/dev/null &&
+		test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
+		test_commit B &&
+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+		HEAD
+		^HEAD~1
+		EOF
+		GIT_TRACE2_EVENT=$(pwd)/trace-A git \
+			-c maintenance.incremental-repack.auto=2 \
+			maintenance run --auto --task=incremental-repack 2>/dev/null &&
+		test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
+		test_commit C &&
+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+		HEAD
+		^HEAD~1
+		EOF
+		GIT_TRACE2_EVENT=$(pwd)/trace-B git \
+			-c maintenance.incremental-repack.auto=2 \
+			maintenance run --auto --task=incremental-repack 2>/dev/null &&
+		test_subcommand git multi-pack-index write --no-progress <trace-B
+	)
 '
 
 test_expect_success 'pack-refs task' '
-- 
2.33.0.464.g1972c5931b-goog

