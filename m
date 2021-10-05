Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA17C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 353CF6137D
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhJEAVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 20:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhJEAVh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 20:21:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8248C061749
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 17:19:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q17-20020a25b591000000b005a07d27bbdaso25785268ybj.3
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 17:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kOyt5cJDCSNsk+B1ZqSGvIlZXsehDk2I7qS7YXJtVrc=;
        b=NHF4QLBvF4vzMTlAyLoXwhZT9TvSVxH5nfjr595N4OvpDKwEqaDvN9jtsHQMpnjA0r
         z238CrZm+tbJcdgcMzllgN8qp26kcMmXSJ9yaeF929Vhlj1cwVJ6a6RRVghQb2TvIBP0
         v8pPJ9KbgR9+PheNcsAFkEa2DX8oTGMEZJyxwU6mkiO5tbuUBYyjxzi9AVy+gMNUsMmy
         UoIfAgHMIZhvJdoIClGJJfo67K+qeF/XhQK/BM8uhS12TEbQdMqM4uv+uNNVbzixlTrM
         Qt4YXut2V5PkjMBX+kXG9RQBGHAwgpv/o1NTGAvOwFaH5DyNi2fEKNL+DvbjNEoBClC6
         xnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kOyt5cJDCSNsk+B1ZqSGvIlZXsehDk2I7qS7YXJtVrc=;
        b=GHxUroMBvTtE8Xv7EaggR9eF0klJkfETXPv4J917oobXLpx42qZWWWq61UIfdJmACr
         3MEJZBKJCqoQoyyGyZuV9lkRDgXPhSqFDc4wQoxxdXCCseLCE0bN/12VALx6fqkbMZSM
         BcyISN6v6bDhN50tiEpF75FR3uFTxvOMuBy89LJdgWL05n/kbgqix8GUEnuD5Qh3tIHK
         H05Jj3ghcEVECsQkZQjgRs5BHjnhLMJrJy6gIMI9Df8aqChUwlkvydqQmRZwIuGpJS+P
         EPR/2TSLIfU/jOEND4y0bqrDc+sGH3mys4sds8xgm1HE035cvJ61wPfAtsr/9mE9sgi9
         EtvQ==
X-Gm-Message-State: AOAM533mpL/mn+iFz66NQpEkDb/+jBaNB8dUi0rwNGWqjY9SN+hVhE7S
        WJ8S7BtFSV80W0ncPPjR8xnfeH8Rzztr4xaGSoPhVzQOvMiBKTwm9oXdjBVaqKmUQj3ND03ShWO
        6QqcvwxdTGS4AQ/SNuv0/HdHyhvzG2SEkIsLwbF4Q7qv6UFBeBOJtHKkADwLB9Oo=
X-Google-Smtp-Source: ABdhPJzHvyvDMLidA7WlzJkBrwBOX2z4A7zwtdL7fKnxxbn4Q04zWklGG2HA+Sg9aT737HYM8oxrR0Xvomn9cw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:4d41:: with SMTP id
 a62mr18575208ybb.394.1633393186886; Mon, 04 Oct 2021 17:19:46 -0700 (PDT)
Date:   Mon,  4 Oct 2021 17:19:29 -0700
In-Reply-To: <20211005001931.13932-1-chooglen@google.com>
Message-Id: <20211005001931.13932-2-chooglen@google.com>
Mime-Version: 1.0
References: <20210917225459.68086-1-chooglen@google.com> <20211005001931.13932-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v3 1/3] fsck: verify commit graph when implicitly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>
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
index af88f805aa..4fcfc2ebbc 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -674,12 +674,33 @@ test_expect_success 'detect incorrect chunk count' '
 		$GRAPH_CHUNK_LOOKUP_OFFSET
 '
 
-test_expect_success 'git fsck (checks commit-graph)' '
+test_expect_success 'git fsck (checks commit-graph when config set to true)' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
 		"incorrect checksum" &&
 	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
+	test_must_fail git -c core.commitGraph=true fsck
+'
+
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
+	cd "$TRASH_DIRECTORY/full" &&
+	test_when_finished "git config core.commitGraph true" &&
+
+	git fsck &&
+	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
+		"incorrect checksum" &&
+	test_unconfig core.commitGraph &&
+	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
 	test_must_fail git fsck
 '
 
-- 
2.33.0.800.g4c38ced690-goog

