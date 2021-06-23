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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D683AC48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BACB360FEB
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFWWdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFWWdT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:33:19 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E44FC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:31:00 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id es19-20020a0562141933b029023930e98a57so4549202qvb.18
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V+0pjxo01cwKnQ9gXZB0sGUdTeKvEaqiE9cXSVCYjcQ=;
        b=etUl8AFPSM/nY6y9u0g5DfHzJKnoZin18MqpZMLpXxfMK/Vq+Dvr3VHUvCxnYHoPUx
         B41uBKa/sZmV8JwlKMFj0oGfvKo7vahuFuqjqICAF4y9aO8PvUtdx3hxcwdi7RZ6Ysmg
         zrx4svuBlqO4T4R95M4h94d+NIe/BuTy1wvsR2ogfAR79o+elwA7mEJDWMOHCFIyBDCi
         kDADK0LfFyPupG4b/CLlbOfF5lL95ymLPoYoCjsdtAG9WCal0uCNepuy1+zgmJFQle9h
         TL43Je85rxdWnkitSOykpdia2JGYAV2o3/7t8Xgjf9Ct1Gu3YmjtkX9Ts1FWiQ6QDxlh
         O58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V+0pjxo01cwKnQ9gXZB0sGUdTeKvEaqiE9cXSVCYjcQ=;
        b=Kf//q20eIU+SRJ5lewDvVnM1vGxZHDV6qfbSR0JdneaQ3+fk8a9QgSoappy+38Jmap
         A6EwyjVxw1lyZaWA2j54axxH5IUd0mxp4PT/+qu8ozVDjrDtJyKfBzByM+MNMiWciuK0
         Pu+I06BtQSbQc4KGM8jM+thYlBd4/bB0Il6sWfi5mYsEqwh5IkV7aDwUgXJA+V1jIyWK
         SHfWw/kR4MMX2cuD6l9p8bpZjFhaGp5Y6rGnaK+ZEuewWxDOYjTz10Dxyvcyjs7Ew356
         OIewyXj6tnYNMjZ3aEbXqmsKwzjpsQxWGQlaxH+/q3zgl2HuWqiF2QPAmoUWpVnxeuqv
         Fblw==
X-Gm-Message-State: AOAM533rcgSBq3ybQP23cy71ko2EBV7a7iFcYRyTr8Bpto3r4yaRjF02
        MWbtWIE17GK4N4i8Nt7LY7tj/UylY9tlWMxU0KFjfMjcqY42kSRoymY7iOqS46Na7TXC7aFrBgK
        P2FS6XzwZoyL68qQ09OHdPO+8m/i6nD07VHjjHhWInkDCgXict8erJUDLsalUdxtHsMMEMoD4z7
        qu
X-Google-Smtp-Source: ABdhPJw3KVRmmm7laW4JJuVxBR40ZVDn6867e7frdjZRvs49McQBLQmBPb3PtrpTbiq+E10kn6/B824qH4zRnvg0KLtd
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:c507:: with SMTP id
 x7mr2198673qvi.10.1624487458766; Wed, 23 Jun 2021 15:30:58 -0700 (PDT)
Date:   Wed, 23 Jun 2021 15:30:51 -0700
In-Reply-To: <cover.1624486920.git.jonathantanmy@google.com>
Message-Id: <042612733181ef348a67edc736637c7cd13c7a6d.1624486920.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1624486920.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 1/3] send-pack: fix push.negotiate with remote helper
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
---
 builtin/send-pack.c   |  1 +
 t/t5516-fetch-push.sh | 49 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

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
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 0916f76302..5ce32e531a 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1768,4 +1768,53 @@ test_expect_success 'denyCurrentBranch and worktrees' '
 	test_must_fail git -C cloned push --delete origin new-wt
 '
 
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'http push with negotiation' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	URI="$HTTPD_URL/smart/server" &&
+
+	rm -rf client &&
+	git init client &&
+	test_commit -C client first_commit &&
+	test_commit -C client second_commit &&
+
+	# Without negotiation
+	test_create_repo "$SERVER" &&
+	test_config -C "$SERVER" http.receivepack true &&
+	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
+	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
+	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 \
+		push "$URI" refs/heads/main:refs/remotes/origin/main &&
+	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
+
+	# Same commands, but with negotiation
+	rm event &&
+	rm -rf "$SERVER" &&
+	test_create_repo "$SERVER" &&
+	test_config -C "$SERVER" http.receivepack true &&
+	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
+	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
+	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 -c push.negotiate=1 \
+		push "$URI" refs/heads/main:refs/remotes/origin/main &&
+	grep_wrote 3 event # 1 commit, 1 tree, 1 blob
+'
+
+test_expect_success 'http push with negotiation proceeds anyway even if negotiation fails' '
+	rm event &&
+	rm -rf "$SERVER" &&
+	test_create_repo "$SERVER" &&
+	test_config -C "$SERVER" http.receivepack true &&
+	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
+	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
+	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c push.negotiate=1 \
+		push "$URI" refs/heads/main:refs/remotes/origin/main 2>err &&
+	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
+	test_i18ngrep "push negotiation failed" err
+'
+
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
 test_done
-- 
2.32.0.288.g62a8d224e6-goog

