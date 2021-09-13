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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D34EC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C9F610E6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346909AbhIMSNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346906AbhIMSNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 14:13:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903F5C0613C1
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 11:12:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d93-20020a25a366000000b0059fff274d9aso14043642ybi.4
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vVdjOKAWGYvMY3JRSb+4vk8XBUdsLBzb2PcmmQ/ZyNk=;
        b=U5UJsZJkVmgGxMYcyA/NHQbAvc0/uxKheNYl1BJ4iIy/kzv+7+6b8u8KYbvsBRPdjq
         rBKjMGr0gBTxUAhNiyJo39/IaYyJSOXGweD63W/uRgeg0LfBmJOlv7oFvSKq6wKj9wnO
         gJx7+RI0HMM2NmWLnsfVuipmZvJefzCnSKpWvm3XFhdv3CQy8gTPh+xz4upOnLAiPVe3
         5BvUGRfSe5WJ8mgkRY/jUIeYbioFp8NFjfhX4wAFraFPpwTyNMSKwh1VPZ+XEqZFnu49
         d+tpZLm3wK0loB0cUiVqf0h8LvKZk9rxwNyit2k8F6hF2dwDS2FR9mF2n4JL9SoitzVV
         S2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vVdjOKAWGYvMY3JRSb+4vk8XBUdsLBzb2PcmmQ/ZyNk=;
        b=pX7+6/ljIyoC4lFZFOomfBUZdqieuw7T6WSXUjZXrRZXVLKWg+li3TkOyHXfcMQ6C1
         BAolFmUdoJy5xHA7p8/dfjcbARMPh7n7NvfO3ZBf7Ewo9L41qbO3Q4Q3ufX1eRYCXFFm
         7DHl079/LpgAmh7B//WAuFC0WFwSSAxeqGUf1o/rE1F9ZoQK0dZATcmsW449A/7Pujnu
         au2MTpJGEWSHY7XBUOz9jhxbQuxHu6E/WOZToTg/2wImLX2psEZzk9Yv8UzMnVRwEt2/
         fjxLOSmBiFp8lm+E01xNOU4KF6mxYXyG7GwJUyodGuD8A3B1mIZf/3gs/XjdeheI7RnS
         eAQg==
X-Gm-Message-State: AOAM532qNU9nkotf4Q1RtNwt2CT/EV8Yu4pw8s5STQZusIuOiPu4sjwH
        p0fuWnav2+BywkdWHKRs1jPv1c3FOrpEIUnkpMcuFxIhfhsWKZkk7BTSfJMn6nKEsbFaSrl6h8h
        vWwOPBNeJbyYPsSB6gJ7f1wt6JVGVIFgB4lGJ38knaXCAN+MreCe0RVerbcx/5ys=
X-Google-Smtp-Source: ABdhPJxDDeLXBL2L2UvXn0iGNApyn0siMgCBDWERYA9ELZbTllGIHrVYT82e0zZP1jLRJxrwQ1MylEe/U2RlPg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:c5c5:: with SMTP id
 v188mr18044257ybe.121.1631556748642; Mon, 13 Sep 2021 11:12:28 -0700 (PDT)
Date:   Mon, 13 Sep 2021 11:12:19 -0700
In-Reply-To: <20210913181221.42635-1-chooglen@google.com>
Message-Id: <20210913181221.42635-2-chooglen@google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 1/3] fsck: verify commit graph when implicitly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

the_repository->settings() is the preferred way to get certain
settings (such as "core.commitGraph") because it gets default values
from prepare_repo_settings(). However, cmd_fsck() reads the config
directly via git_config_get_bool(), which bypasses these default values.
This causes fsck to ignore the commit graph if "core.commitgraph" is not
explicitly set in the config, even though commit graph is enabled by
default.

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
 t/t5318-commit-graph.sh | 23 ++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

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
index af88f805aa..48c5096757 100755
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
@@ -683,6 +683,27 @@ test_expect_success 'git fsck (checks commit-graph)' '
 	test_must_fail git fsck
 '
 
+test_expect_success 'git fsck (ignores commit-graph when config set to false)' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git fsck &&
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum" &&
+	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
+	git -c core.commitGraph=false fsck
+'
+
+test_expect_success 'git fsck (checks commit-graph when config unset)' '
+	test_when_finished "git config core.commitGraph true" &&
+
+	cd "$TRASH_DIRECTORY/full" &&
+	git fsck &&
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum" &&
+        git config --unset core.commitGraph &&
+	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
+	test_must_fail git fsck
+'
+
 test_expect_success 'setup non-the_repository tests' '
 	rm -rf repo &&
 	git init repo &&
-- 
2.33.0.309.g3052b89438-goog

