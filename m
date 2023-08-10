Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9C3C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjHJUkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjHJUkB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:40:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB6790
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe426521adso2007318e87.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691699995; x=1692304795;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tzSvACcIG7N9HhDyVHvty0LHt2uJL59NrztVHNMDsI=;
        b=pZmPOPJoYOOdtldhcxoACK40LDLTxXkDdIqGHCgbKpZE9+p3uQ2/sxsB7DLbKATUkh
         D4xgcgEAUiv3vE3DnuDWJncBNOGqKAFcZWKI7X9u/Rp10xtR7TIMrxuI5aDvHKG4C3KJ
         GFvIXxqrlRFSZBKTsQL+7MLe6ZrziwrvvcFT362bXAQv2YURV9HdqcXaP6w87vZLmdmS
         kpBIh2oikspYcZS7Sz46CN7zSsZD4hzzTasGl8BIV524ONpVKHpXxiSNeYRro+4KCNTZ
         r5j/CiuKRN9yJvgMofhTW4T4U/F5K1uGyp76n1AXItFtu9gfVXoZM0QJTeBSACqkXAAI
         zoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699995; x=1692304795;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tzSvACcIG7N9HhDyVHvty0LHt2uJL59NrztVHNMDsI=;
        b=mD/mZM0R7CNkbey4h1j6jc7bW5S/76Y7C7tbAPS6UOaLVGJzQDe+SaQKL0nU50K6ap
         NH8KEez8JYXFr2zNsgy57e1tWXiC9trnkbscszeUhgbCkKQTIk0UaaiAL8ZlThxJgvOr
         iEwAoZ7M1PviqnZSXjsdnDl4liSWE3vzsn5xbNvDJwde9aQ7xAqeXqn1x+qYqTrsqy7a
         tX1LWblsFftPBgl1D7SiQQfNPuxXQLDY9YDnIpXJcuCD2PAFbo266B+Q/HuDPZc87I3+
         5NWfe3UE7pnY9mDOH/EmmtD72AwFCM+BXrbdJy+Dd4UIbU+Z5mqyypGI6nL+iezepH+J
         J0VA==
X-Gm-Message-State: AOJu0YykvzEqN3PBb3i6PJS3zWosFgqdlwN4YCFdVMD5H9AYWWsBkRHB
        qu0BTryMdy7PgifGf/j7rP1mZyzW8u0=
X-Google-Smtp-Source: AGHT+IFzklOYjDh6PL2TM9bj3xYZX4ShbbEwWLehMyFK2CJtS3bPNi3q90ousAWWuqCN8nixScfu2A==
X-Received: by 2002:a05:6512:31cf:b0:4fe:56d8:631d with SMTP id j15-20020a05651231cf00b004fe56d8631dmr3214250lfe.25.1691699994756;
        Thu, 10 Aug 2023 13:39:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24-20020aa7c498000000b00521953ce6e0sm1204035edq.93.2023.08.10.13.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:39:54 -0700 (PDT)
Message-ID: <f0c0f6eff883c62f6b07223b5f1da3fd8e462507.1691699987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 20:39:47 +0000
Subject: [PATCH v2 8/8] maintenance: update schedule before config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When running 'git maintenance start', the current pattern is to
configure global config settings to enable maintenance on the current
repository and set 'maintenance.auto' to false and _then_ to set up the
schedule with the system scheduler.

This has a problematic error condition: if the scheduler fails to
initialize, the repository still will not use automatic maintenance due
to the 'maintenance.auto' setting.

Fix this gap by swapping the order of operations. If Git fails to
initialize maintenance, then the config changes should never happen.

Reported-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c           |  5 ++++-
 t/t7900-maintenance.sh | 13 +++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6f8df366fbe..fe5f871c493 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2728,9 +2728,12 @@ static int maintenance_start(int argc, const char **argv, const char *prefix)
 	opts.scheduler = resolve_scheduler(opts.scheduler);
 	validate_scheduler(opts.scheduler);
 
+	if (update_background_schedule(&opts, 1))
+		die(_("failed to set up maintenance schedule"));
+
 	if (maintenance_register(ARRAY_SIZE(register_args)-1, register_args, NULL))
 		warning(_("failed to add repo to global config"));
-	return update_background_schedule(&opts, 1);
+	return 0;
 }
 
 static const char *const builtin_maintenance_stop_usage[] = {
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 9ffe76729e6..e56f5980dc4 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -849,4 +849,17 @@ test_expect_success 'register and unregister bare repo' '
 	)
 '
 
+test_expect_success 'failed schedule prevents config change' '
+	git init --bare failcase &&
+
+	for scheduler in crontab launchctl schtasks systemctl
+	do
+		GIT_TEST_MAINT_SCHEDULER="$scheduler:false" &&
+		export GIT_TEST_MAINT_SCHEDULER &&
+		test_must_fail \
+			git -C failcase maintenance start &&
+		test_must_fail git -C failcase config maintenance.auto || return 1
+	done
+'
+
 test_done
-- 
gitgitgadget
