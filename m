Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29A7C5CFC2
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3549613C7
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhGORre (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbhGORre (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:47:34 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970E1C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:44:39 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 4-20020a17090a1a44b029016e8392f557so6234609pjl.5
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Llrwjl/YjfNYx64hihaRAfQdrjc37dL1gHOoGUqRu7w=;
        b=jP8SDVZn4yDiLl2g66KJHl+wDwvSIf4XvOidLWhPmJhoWng0TkMH/ioFFWauvTmU02
         KVc1IiLt6k/ezpa2EaVY/qLD9rt5YIRRawuwjdpZVWRmY2MIVPAXM43tkpRv700dhHyn
         9F3BHIHrbDfbhVE+ZKHsHKcFniMiVqZwNjGs9cqAFLI8zY/BpC5vsiO5KBzumRuZlO86
         /lZEAqY9gXo+ipeqcNrppvHtfmOLgzTcMYscGU89W/Y0R/hhsWHidwKcIpcZ9wqTOfAd
         DFV3jVIWUVufqQIRvkiYiCHg+sftFLqiVqPab8jF1J0xLa85jexsXf6sxeBLijax+a4m
         fMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Llrwjl/YjfNYx64hihaRAfQdrjc37dL1gHOoGUqRu7w=;
        b=EUEluNeIl+l1JhqekgPlbyto8QqdWZntuDOYk43WcdGk/xBdyv1JwrX8F2vFLhBEcx
         8pyImHfSJ55MwH4+lU6pFsev1c+B9iQEz8tUUTJ429VjKFEAC/tAgq25mQ6LPFQBhfdQ
         PoFFAkkFqobfJ/W8ADNOzyeNLnt6ABscXvEloIaW4tPjjezWPpeQkWPvlK+WMA4fV4cf
         yLZEuWcgKwHNSbgLTLMU7YbIhTzsESntagh633+m6gu+xcJjEk+C0OroJdTTyaVropvX
         l8Oeyj0d/pygPZ77g2L1hoSLeJIZ1/lP9Gu4G2Zh+MUzpyaMPpUZCCwOZgJhUq+uBUma
         0RfA==
X-Gm-Message-State: AOAM532YdRpmIPPAKPjVc36XtYLrH3Ca8Bv7eLLcwDMkcqMPHHy2s5q+
        0+OqW6kjW0QUka+XvF4ctZsOZtbYLk7TNJnKSJbZangW8eC0Jnc2iAYHT/CyR0FRi4dPWlghCX7
        60tNlIl8wcT7khtwygHsMP0iOM2mZRoDm12Mq1JbRy7HWOfpwCYD9C5GvvCor9WeLDwtIynD8v7
        R0
X-Google-Smtp-Source: ABdhPJztZs072OEYuRMWRMBtaQ78vWtK42AUBE4zSkYRpuKvLOe/8eJNEV2S71F85BUNJKkBx1awy/nejDw7hzpd1R8U
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a65:5186:: with SMTP id
 h6mr5717644pgq.62.1626371079037; Thu, 15 Jul 2021 10:44:39 -0700 (PDT)
Date:   Thu, 15 Jul 2021 10:44:30 -0700
In-Reply-To: <cover.1626370766.git.jonathantanmy@google.com>
Message-Id: <af40bee611d4dbbd9bb5f1466bec0be118b74165.1626370766.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1624486920.git.jonathantanmy@google.com> <cover.1626370766.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v2 1/3] send-pack: fix push.negotiate with remote helper
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        emilyshaffer@google.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 477673d6f3 ("send-pack: support push negotiation", 2021-05-05)
introduced the push.negotiate config variable and included a test. The
test only covered pushing without a remote helper, so the fact that
pushing with a remote helper doesn't work went unnoticed.

This is ultimately caused by the "url" field not being set in the args
struct. This field being unset probably went unnoticed because besides
push negotiation, this field is only used to generate a "pushee" line in
a push cert (and if not given, no such line is generated). Therefore,
set this field.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/send-pack.c        |  1 +
 t/t5549-fetch-push-http.sh | 71 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100755 t/t5549-fetch-push-http.sh

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index a7e01667b0..729dea1d25 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -230,6 +230,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	args.atomic = atomic;
 	args.stateless_rpc = stateless_rpc;
 	args.push_options = push_options.nr ? &push_options : NULL;
+	args.url = dest;
 
 	if (from_stdin) {
 		if (args.stateless_rpc) {
diff --git a/t/t5549-fetch-push-http.sh b/t/t5549-fetch-push-http.sh
new file mode 100755
index 0000000000..f50d584881
--- /dev/null
+++ b/t/t5549-fetch-push-http.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+
+test_description='fetch/push functionality using the HTTP protocol'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server"
+URI="$HTTPD_URL/smart/server"
+
+grep_wrote () {
+	object_count=$1
+	file_name=$2
+	grep 'write_pack_file/wrote.*"value":"'$1'"' $2
+}
+
+setup_client_and_server () {
+	git init client &&
+	test_when_finished 'rm -rf client' &&
+	test_commit -C client first_commit &&
+	test_commit -C client second_commit &&
+
+	git init "$SERVER" &&
+	test_when_finished 'rm -rf "$SERVER"' &&
+	test_config -C "$SERVER" http.receivepack true &&
+	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
+	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit
+}
+
+test_expect_success 'push without negotiation (for comparing object counts with the next test)' '
+	setup_client_and_server &&
+
+	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 \
+		push "$URI" refs/heads/main:refs/remotes/origin/main &&
+	test_when_finished "rm -f event" &&
+	grep_wrote 6 event # 2 commits, 2 trees, 2 blobs
+'
+
+test_expect_success 'push with negotiation' '
+	setup_client_and_server &&
+
+	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 -c push.negotiate=1 \
+		push "$URI" refs/heads/main:refs/remotes/origin/main &&
+	test_when_finished "rm -f event" &&
+	grep_wrote 3 event # 1 commit, 1 tree, 1 blob
+'
+
+test_expect_success 'push with negotiation proceeds anyway even if negotiation fails' '
+	setup_client_and_server &&
+
+	# Use protocol v0 to make negotiation fail (because protocol v0 does
+	# not support the "wait-for-done" capability, which is required for
+	# push negotiation)
+	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c push.negotiate=1 \
+		push "$URI" refs/heads/main:refs/remotes/origin/main 2>err &&
+	test_when_finished "rm -f event" &&
+	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
+
+	cat >warning-expect <<-EOF &&
+	warning: --negotiate-only requires protocol v2
+	warning: push negotiation failed; proceeding anyway with push
+EOF
+	grep warning: err >warning-actual &&
+	test_cmp warning-expect warning-actual
+'
+
+test_done
-- 
2.32.0.93.g670b81a890-goog

