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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62956C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B1060F48
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhIQW4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhIQW4h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 18:56:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8D7C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:55:15 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e18-20020a656792000000b00268773b02d1so8853266pgr.13
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qyXDZecfTNf3blO9pXvt4Ou3sKtlt7J4dkf3/gJJXrs=;
        b=UzreurtWYvbnPVHHslbA6b95WtKrsxRHRoUaX5x/LLbt1cMq8tqVhhyDO36yzBEjZQ
         NqJun0TLqv15x0oFHjpBHqyHHtgDUPrfaVIcCVC/qh0eTr1mip7fCXfuYJbm3x+O5PEj
         DsbFYSKyrDT2meEczvxXHVWpzeauo5QoTYDMngTWfqgZRL5I1XzrjrfcXd3Qv8jJ/PIA
         lRAIpF/KtVXjmkqUqX+oCQSPpaDl1TYdp6eaAKgI7l19k03kGQvFOPkVMmGqUCgjKrCO
         2CM+ah3Lho01Zwd1r+P2auMn7Qge9wGHZguMynq8U3OWtVQGr0gwHb9lHWpZEZf4dKg2
         gp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qyXDZecfTNf3blO9pXvt4Ou3sKtlt7J4dkf3/gJJXrs=;
        b=sKSss37bBvObRXjeI5HYwoblpbixjGT94L8a3aUuUaIaxYFlj8X3JtSCeChJj6VF9p
         Xko2yGhr1vY5ahpVxNpk+jVRbqbf+nZrdazek9Uip7sqbZoKe895nA4hJ2XTBxwUQ6lV
         3dkAfTX7M3Rk+zdLNSdwy3k37nndBS/39Kjht1wffuqT6YfwEBGe5UxhZPB3euGkm0Zp
         4W9HqJW/R3SYqEdoKwjesriYNx1/c/9gf70bLa3hrObOI1GaFHPHLWvg7+zIGx8CdkuZ
         orHnPSdxbvrSWrT9cBeUB0OVRDejYuO/I1zvsiH7Tai60Y2zyhoM3aPI7VIThYjOR05b
         F2Gw==
X-Gm-Message-State: AOAM532rbmKpy1FNtqSVJ53wCGxpAKp+ZyRvSYZ/IaL+1YmYZlkDuMc2
        10NuwoUpa5VlmapodnXhBqlbQWKM52+ncjqkAbgttghmP1dmc5Ff7mvqHoEmjRx/rUcbP/L4mwi
        i/R7F3HTwMCHaaRyFVbcV/oBBBRUlTe0Ll16KwsTEp8KBYvDMwMX3vA4I+OLg9+E=
X-Google-Smtp-Source: ABdhPJz+SAucCbvd2et8lsxi5OxLkfiFX0htPvDEyDzWHwzSYGwxq4Jy/MNYLJv3lvYuvuLLFxFIUnHvCLZGGw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:a38b:b0:138:d329:27ac with SMTP
 id x11-20020a170902a38b00b00138d32927acmr11559924pla.7.1631919314355; Fri, 17
 Sep 2021 15:55:14 -0700 (PDT)
Date:   Fri, 17 Sep 2021 15:54:57 -0700
In-Reply-To: <20210917225459.68086-1-chooglen@google.com>
Message-Id: <20210917225459.68086-2-chooglen@google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210917225459.68086-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 1/3] fsck: verify commit graph when implicitly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

the_repository->settings is the preferred way to get certain
settings (such as "core.commitGraph") because it gets default values
from prepare_repo_settings(). However, cmd_fsck() reads the config
directly via git_config_get_bool(), which bypasses these default values.
This causes fsck to ignore the commit graph if "core.commitgraph" is not
explicitly set in the config. This worked fine until commit-graph was
enabled by default in 31b1de6a09 (commit-graph: turn on commit-graph by
default, 2019-08-13).

Replace git_config_get_bool("core.commitgraph") in fsck with the
equivalent call to the_repository->settings.core_commit_graph.

The expected behavior is that fsck respects the config value when it is
set, but uses the default value when it is unset. For example, for
core.commitGraph, there are three cases:

- Config value is set to true -> enabled
- Config value is set to false -> disabled
- Config value is unset -> enabled

As such, tests cover all three cases.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fsck.c          |  3 ++-
 t/t5318-commit-graph.sh | 24 +++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b42b6fe21f..1c4e485b66 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -803,6 +803,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		fsck_enable_object_names(&fsck_walk_options);
 
 	git_config(git_fsck_config, &fsck_obj_options);
+	prepare_repo_settings(the_repository);
 
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
@@ -908,7 +909,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
-	if (!git_config_get_bool("core.commitgraph", &i) && i) {
+	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 		const char *verify_argv[] = { "commit-graph", "verify", NULL, NULL, NULL };
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index af88f805aa..42e785cb6e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -674,7 +674,7 @@ test_expect_success 'detect incorrect chunk count' '
 		$GRAPH_CHUNK_LOOKUP_OFFSET
 '
 
-test_expect_success 'git fsck (checks commit-graph)' '
+test_expect_success 'git fsck (checks commit-graph when config set to true)' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
@@ -683,6 +683,28 @@ test_expect_success 'git fsck (checks commit-graph)' '
 	test_must_fail git fsck
 '
 
+test_expect_success 'git fsck (ignores commit-graph when config set to false)' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git fsck &&
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum" &&
+	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
+	test_config core.commitGraph false &&
+	git fsck
+'
+
+test_expect_success 'git fsck (checks commit-graph when config unset)' '
+	test_when_finished "git config core.commitGraph true" &&
+
+	cd "$TRASH_DIRECTORY/full" &&
+	git fsck &&
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum" &&
+	test_unconfig core.commitGraph &&
+	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
+	test_must_fail git fsck
+'
+
 test_expect_success 'setup non-the_repository tests' '
 	rm -rf repo &&
 	git init repo &&
-- 
2.33.0.464.g1972c5931b-goog

