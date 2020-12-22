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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A784C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138FA22AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgLVAE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgLVAE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:04:26 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF751C0619D2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:57 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y5so5922001plr.19
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S/Y46cKYes4W6B2lDw3dstWxrxCcTY2+4b0qG4ApfCM=;
        b=G64uK3cEGA0iD3aw4dRzK/eAVAKXcJUZDhhmF6/1e/jNKVbYYX4hjGC14G5jcmf0pm
         sB/U92UDE9RTUNFIfbYclyg3BHcyPaom94j5tZJ+AKTMNbdt/emTCBeb+yPTMye8u0iN
         SPoaLMhye6z/BDAmAeNEue3wyjDxkqFQ9gD34JpbVrACGj6hxNiULyoOSCyuckTEErx9
         /nct2i3GSUi9wg0RZFNRkcFwFy5Uxb26dun9tgRmkbW5YJEZlePQmgtB7NI/rj8GnCMa
         yBvAoXRO/Ry8Gj5AmRTHyZeg+9SXSZZL5pTnTmLNlOQ+iielDhBN63/uB9CuO9CO7xPd
         Tydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S/Y46cKYes4W6B2lDw3dstWxrxCcTY2+4b0qG4ApfCM=;
        b=JSlwDFYXJRqV+ibzkb7ihgD4LcjA7V/+U0k2K15R+SB5JGU4lhK9AIvbByoeaO4lG0
         HtPYXYqY6mg/2V2kekpyZ/HuaMwJ8GI6Tu92adJ8OfHD1ImEURCMu+BrBhHBAEZKj39u
         GEstnW427X0jLpIIe/z/114oEujQjJjlZJb464TtLsqWMe3Cyynv2jgzxDhMGJYPo4MH
         TEjygr5fIdfFldmG/K06fFMrbPXjeXsRoFlNTgy0Kv2lZ+eRBYvURsRas3TsvUY5ZELc
         Dwtv8YQd5CVBBAIYERP+iOEC5T8o34v0fBvTfO/kKgwVFz/jINV4iiX0gBtv7tezTQGM
         oqJw==
X-Gm-Message-State: AOAM533CtQvsHSy8s2xOxx8SoXK60NJrfMlsgVQ3VDwZa611ElBhGaQ+
        u32xSbbH2N7MZuQ1VJDaueBtOc5qRCMEOCE1+oXT/D+qzchDv5MiPs/oA4BQWzp6cBmbgY5zey/
        a0PtsfcXo8btAPQi6+KUcB+veh0HIap7TWostkcCzHZwvpLWg7sxNn1eduDOa4QM4akuBO7cMGQ
        ==
X-Google-Smtp-Source: ABdhPJzncXfS5ZIBv+mHiYZn1z2Gn5FINzXIH+DEh7YnoTLNzAW0Wbl3+kYnWBHii/cSfsPjtnSybMrwD9EHcZbx5KE=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:90b:128f:: with SMTP id
 fw15mr19389373pjb.91.1608595377251; Mon, 21 Dec 2020 16:02:57 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:20 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-18-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 17/17] hooks: allow callers to capture output
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some server-side hooks will require capturing output to send over
sideband instead of printing directly to stderr. Expose that capability.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    You can see this in practice in the conversions for some of the push hooks,
    like 'receive-pack'.

 hook.c |  2 +-
 hook.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 1439322a29..dc241f7ec5 100644
--- a/hook.c
+++ b/hook.c
@@ -406,7 +406,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
-				   NULL,
+				   options->consume_sideband,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/hook.h b/hook.h
index 0ac83fa7ca..1e92379bb8 100644
--- a/hook.h
+++ b/hook.h
@@ -76,6 +76,14 @@ struct run_hooks_opt
 	feed_pipe_fn feed_pipe;
 	void *feed_pipe_ctx;
 
+	/*
+	 * Populate this to capture output and prevent it from being printed to
+	 * stderr. This will be passed directly through to
+	 * run_command:run_parallel_processes(). See t/helper/test-run-command.c
+	 * for an example.
+	 */
+	consume_sideband_fn consume_sideband;
+
 	/* Number of threads to parallelize across */
 	int jobs;
 
@@ -103,6 +111,7 @@ struct hook_cb_data {
 	.str_stdin = STRING_LIST_INIT_DUP,	\
 	.feed_pipe = NULL,			\
 	.feed_pipe_ctx = NULL,			\
+	.consume_sideband = NULL,		\
 	.run_hookdir = configured_hookdir_opt()	\
 }
 
@@ -115,6 +124,7 @@ struct hook_cb_data {
 	.str_stdin = STRING_LIST_INIT_DUP,	\
 	.feed_pipe = NULL,			\
 	.feed_pipe_ctx = NULL,			\
+	.consume_sideband = NULL,		\
 	.run_hookdir = configured_hookdir_opt()	\
 }
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

