Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743FAC433DF
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 18:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA762070E
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 18:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Es6tZ17P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgGPSKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgGPSKA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 14:10:00 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C941C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 11:10:00 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c2so5065793pfj.5
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=32cv3kivhNuCNNRuQVoSpVHUuIzTDPrPTN8oxVC37Bw=;
        b=Es6tZ17PErfRdVrruyLecw298tl6ZDHNYSioLmdCR62FFTl/9ds+0Hzp71m4PsRCjE
         SpL02D2vEXL/am8ErfFVYZBz1mBvLh2pkIHbw8X4NQd7hsReglNPy1lbOJQoQGmnp6C8
         mFMT3sO4AnWgqhR4YqfQsHtreG0uxXKJtbR9A1iNlIafGmlV/dGYaVRfIUtygnJKUGLc
         qylMvwedUYtMKwsiDdXjQ63ylrCMGtMNxr3IUk2oW1IAkAI78T16euA3b/vens2/w46a
         YId6jrJW0JuZUbBD6dPndLc+bdwWuh818aI5H2YWKafgCRbYdZgFwuEqkUH02FDMX9jB
         xhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=32cv3kivhNuCNNRuQVoSpVHUuIzTDPrPTN8oxVC37Bw=;
        b=Xg4RLEOV1iuEwHKF6G7cKXMYaft9CaQBDDoTB1sotSlTb/vdmn01pI6WSim+7+np6L
         /a+BnDGrSwqdf7ZTPA/MXGMy5aTO0sH8F/ktxgc3am14z4VkjaH3+jHF/ozdhO4PLtnt
         ldEHFgUQOZbp9DkrKF+ey/Qa9foIIku8P9TXAfT5IT6ADvUPnKyB+8Yoeda0jRthgM6q
         slK+yoN93yYGaYCNIXNIEz39kTxameB+hUICBB8QKwamnLFMIOA7l+6ItX5KqmdGLKAi
         fVPOb6ltIZ5lOta3pWL3K+CcoVYytFcuok9XwJkO2bo3bsmLItyGIoECQmZ/+fULBlkQ
         3dgA==
X-Gm-Message-State: AOAM530yloAcivbxeg6Qg8ViP2pJEGldDxcGjhmEK/odvf8RxuYvXU/d
        PLJ1cAP+chHByN3EVJ4BYb8kIvaxTqRjLn2P3fA4cmZ7UmiutEmPDShIkv8UEeCelIuqLJKiKXs
        Y4XQgNbDA5aZO8Y/gobjylDdp58RFNJRq/F4Go07Smd6nkovfT5iZFHkcCnxcFle4tf+4XLXoND
        ru
X-Google-Smtp-Source: ABdhPJx6vv5F8wVi98BQ6xJ3w4Kx4pxZzEE/SbRcpp4+GxD+7TQYls4Y0P5GM3xSxPnjBqtyGfmRKVO+TQB1EwTJoTJC
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr2027850pjz.1.1594922999298;
 Thu, 16 Jul 2020 11:09:59 -0700 (PDT)
Date:   Thu, 16 Jul 2020 11:09:50 -0700
In-Reply-To: <xmqqk0z3gy5y.fsf@gitster.c.googlers.com>
Message-Id: <20200716180950.2852753-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqk0z3gy5y.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH v2] upload-pack: do not lazy-fetch "have" objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When upload-pack receives a request containing "have" hashes, it (among
other things) checks if the served repository has the corresponding
objects. However, it does not do so with the
OBJECT_INFO_SKIP_FETCH_OBJECT flag, so if serving a partial clone, a
lazy fetch will be triggered first.

This was discovered at $DAYJOB when a user fetched from a partial clone
(into another partial clone - although this would also happen if the
repo to be fetched into is not a partial clone).

Therefore, whenever "have" hashes are checked for existence, pass the
OBJECT_INFO_SKIP_FETCH_OBJECT flag. Also add the OBJECT_INFO_QUICK flag
to improve performance, as it is typical that such objects do not exist
in the serving repo, and the consequences of a false negative are minor
(usually, a slightly larger pack sent).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Differences from v1: OBJECT_INFO_QUICK is also used wherever
OBJECT_INFO_SKIP_FETCH_OBJECT is added.

Using OBJECT_INFO_QUICK makes sense to me, so here's an updated patch.
---
 t/t5616-partial-clone.sh | 38 ++++++++++++++++++++++++++++++++++++++
 upload-pack.c            |  6 ++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8a27452a51..37de0afb02 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -422,6 +422,44 @@ test_expect_success 'single-branch tag following respects partial clone' '
 	test_must_fail git -C single rev-parse --verify refs/tags/C
 '
 
+test_expect_success 'fetch from a partial clone, protocol v0' '
+	rm -rf server client trace &&
+
+	# Pretend that the server is a partial clone
+	git init server &&
+	git -C server remote add a_remote "file://$(pwd)/" &&
+	test_config -C server core.repositoryformatversion 1 &&
+	test_config -C server extensions.partialclone a_remote &&
+	test_config -C server protocol.version 0 &&
+	test_commit -C server foo &&
+
+	# Fetch from the server
+	git init client &&
+	test_config -C client protocol.version 0 &&
+	test_commit -C client bar &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "file://$(pwd)/server" &&
+	! grep "version 2" trace
+'
+
+test_expect_success 'fetch from a partial clone, protocol v2' '
+	rm -rf server client trace &&
+
+	# Pretend that the server is a partial clone
+	git init server &&
+	git -C server remote add a_remote "file://$(pwd)/" &&
+	test_config -C server core.repositoryformatversion 1 &&
+	test_config -C server extensions.partialclone a_remote &&
+	test_config -C server protocol.version 2 &&
+	test_commit -C server foo &&
+
+	# Fetch from the server
+	git init client &&
+	test_config -C client protocol.version 2 &&
+	test_commit -C client bar &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "file://$(pwd)/server" &&
+	grep "version 2" trace
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/upload-pack.c b/upload-pack.c
index 951a2b23aa..8673741070 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -482,7 +482,8 @@ static int got_oid(struct upload_pack_data *data,
 {
 	if (get_oid_hex(hex, oid))
 		die("git upload-pack: expected SHA1 object, got '%s'", hex);
-	if (!has_object_file(oid))
+	if (!has_object_file_with_flags(oid,
+					OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT))
 		return -1;
 	return do_got_oid(data, oid);
 }
@@ -1423,7 +1424,8 @@ static int process_haves(struct upload_pack_data *data, struct oid_array *common
 	for (i = 0; i < data->haves.nr; i++) {
 		const struct object_id *oid = &data->haves.oid[i];
 
-		if (!has_object_file(oid))
+		if (!has_object_file_with_flags(oid,
+						OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT))
 			continue;
 
 		oid_array_append(common, oid);
-- 
2.27.0.389.gc38d7665816-goog

