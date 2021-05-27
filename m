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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FB9C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1192D613CD
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhE0ALb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhE0ALG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD28C061760
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o12-20020a5b050c0000b02904f4a117bd74so3621205ybp.17
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uTnTkdDSTMFFNbnr5l+txoXk6PxqNXrGkNvjBeciYNk=;
        b=oIyKtJBrVWrjgTfU2P7B9IC3zoBo4adpHdVYMg4S8KhPEbrykGkKkfcFdV3qFJUqGH
         jzHAxV+yZPrYznocoxbKTSMjf+M/BZ2ko1HW5N9WVdunUKhM4VZeeDdHZ61TfTdeYppW
         n7B1DBniyqakfdjEJNQWKKFIBYPqEV0yHF6oPoE57EboBZvcJ2rf+FNrsimPP8dcoSLc
         xZTNqSilnE7sgkFv95jooO/8lKpgGqY4UQI07LylXfty2Sv0kOvAdiLzzU3FqdeXaYcA
         J9FabWLHcUGWFuZTIwvphAdmjDS7nwgpB4yg6O+YgXVsR4Ch5XUFtKlPDWTQD2ZB0Y8X
         F4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uTnTkdDSTMFFNbnr5l+txoXk6PxqNXrGkNvjBeciYNk=;
        b=hzoa+OFnv/VbFPldEWFpXHl+Ko0c+7uFbKK4MsYyjES+CBSrOe5ISBCmlvQQfYjNzk
         AXKwnN2O3w0ajac9y+Wr3qhUtseh13PQB6j9EkxLVHngLcRYs20g3XMGbivOGx+ofadr
         B48Au4s9swKIO16jhCuc+i0vaLt0R3z3WqBVaTQDHlPlfJAcODgwuhn05OxkP2lihwBr
         LALGAx54t8j3U3AjU/ACT337tT+Ue/ZebSg6qAg5npFoKT/uzVcpvyhnWPm7UuT6JMPn
         Q2OTy0eNitOhEs0fNEnuo8Quv+k0BTKsBG3BRiruICpR0MHMWAxQJDggxuwbrGla/+wI
         i/mQ==
X-Gm-Message-State: AOAM531QmBwn7vr1aC9d8MaKaKJOMDgxcziJk3e5vHK9iwxxap2kgSQ/
        JWksVHV27px7yt8SRDApwX+6vuDkU4E7Zebwu4Rj3te5XPkmaqx01VTCBos+C7pUUja+GN0atOm
        L0hiA/2rGnx8+hIP2CIRVA29nfJKRwrG9sIrKWfovNYcDbP9l3knBFXdb5t75A844EimWfkaTIQ
        ==
X-Google-Smtp-Source: ABdhPJwN+igzAO+v8OyWF00UPrfjtL+dWZkYAzWFRKJhjZHQMwXXdn5dsOU984CQ/Z81AvKpQYLUTeViARHHC6QBdMU=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a5b:7c8:: with SMTP id
 t8mr849376ybq.49.1622074172053; Wed, 26 May 2021 17:09:32 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:35 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-17-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 16/37] hooks: allow callers to capture output
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

 hook.c | 3 ++-
 hook.h | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index d48071bb1d..27da1fdb32 100644
--- a/hook.c
+++ b/hook.c
@@ -262,6 +262,7 @@ void run_hooks_opt_init_sync(struct run_hooks_opt *o)
 	o->dir = NULL;
 	o->feed_pipe = NULL;
 	o->feed_pipe_ctx = NULL;
+	o->consume_sideband = NULL;
 }
 
 void run_hooks_opt_init_async(struct run_hooks_opt *o)
@@ -437,7 +438,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
-				   NULL,
+				   options->consume_sideband,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/hook.h b/hook.h
index aba62d4112..f32189380a 100644
--- a/hook.h
+++ b/hook.h
@@ -78,6 +78,14 @@ struct run_hooks_opt
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
 
-- 
2.31.1.818.g46aad6cb9e-goog

