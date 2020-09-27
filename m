Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD07C47420
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA9923976
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiP0EFiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgI0NQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 09:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0NQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 09:16:12 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12CC0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:11 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u8so8028224lff.1
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkUeDnvS+/tJxB2K4Ll4oLteH5VSW+eTzWNY+jwhTJ8=;
        b=KiP0EFiNT3pEK9xtteBEXIEUgjhhnh0mIbgcrH/7MbhPAhU1AVoazOQknVuME5CYXS
         iQiPm2+9+qjy1WlpvLdDaqKSYJ23fToKVMrS9nCQtTU7CJkQ5UCaWX2rskWWpWA7R+t5
         UycDJt0sB9cEqF3hKZADL4QK+HKuMSXA6iNa1H50UV2ep753pLcIM6foNFxRejNEgzqJ
         BT78Tsgm12VR1NGXVxe0pF1S3siXR3p3OaMeMwUq1634hfeiXtq7ONIQKcnPRdIEW1Jg
         h14SWZBqKw1P56vjxfLxqRKo+I26pwLxtiNZtRdh4sqJ7ac6tRIr0J+BuEQTwjI9xqxT
         BpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkUeDnvS+/tJxB2K4Ll4oLteH5VSW+eTzWNY+jwhTJ8=;
        b=pG+zMFg6HpeSP0HgFxe4nC+rOcoCAU+/kFxi6KxEe1vBjbCN6M4TRf2ED60sTlj0uz
         f4jSKjm+85hxYTw///tMCSqLkGoT6VMZNYhBV3/d5X/jO5WjA4b+J1LL4XITnOax65pL
         IeqDONCFzRJBCQEqNG2bJZkFt4GWpBVZzFaSuT3NWeWofmYYsnX7NuLr7bLMLJ9oEgly
         GsQYUoCIr+rqXkdn1SS6cRvEo8BOCYbI7WRbmig/0NVHRsqMr2ej9/7FvQVbwijUGmDy
         1e1rnKmsfSCMizZaKJZeu8KLZgCDnHLmJdHl9jsHj8UFV7iXCH870ibYWCvSUN9N1PlL
         cxEg==
X-Gm-Message-State: AOAM530kP+wgYGfgFHGGzrnXzRDmS8ziDb1utLFXcP1q6mzPqVZzoKz6
        6AHQhoxhSUWZHvV9B6ejRaNHFue1ApY=
X-Google-Smtp-Source: ABdhPJyPG9KPUvgXDNTd5b6Cir48X3zQv7oNsQDw69ydeZF87+vE9LjXZXBK61a7cB/gym2uEA1bLQ==
X-Received: by 2002:ac2:5541:: with SMTP id l1mr2646812lfk.89.1601212570072;
        Sun, 27 Sep 2020 06:16:10 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o8sm2487616lfa.44.2020.09.27.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 06:16:09 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 3/7] wt-status: introduce wt_status_state_free_buffers()
Date:   Sun, 27 Sep 2020 15:15:43 +0200
Message-Id: <c08fed5a01dabcd02a0f0f5dfaf0f87ce3824ca1.1600281351.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1600281350.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com> <cover.1600281350.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we have a `struct wt_status_state`, we manually free its `branch`,
`onto` and `detached_from`, or sometimes just one or two of them.
Provide a function `wt_status_state_free_buffers()` which does the
freeing.

The callers are still aware of these fields, e.g., they check whether
`branch` was populated or not. But this way, they don't need to know
about *all* of them, and if `struct wt_status_state` gets more fields,
they will not need to learn to free them.

Users of `struct wt_status` (which contains a `wt_status_state`) already
have `wt_status_collect_free_buffers()` (corresponding to
`wt_status_collect()`) which we can also teach to use this new helper.

Finally, note that we're currently leaving dangling pointers behind.
Some callers work on a stack-allocated struct, where this is obviously
ok. But for the users of `run_status()` in builtin/commit.c, there are
ample opportunities for someone to mistakenly use those dangling
pointers. We seem to be ok for now, but it's a use-after-free waiting to
happen. Let's leave NULL-pointers behind instead.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 wt-status.h  |  7 +++++++
 ref-filter.c |  4 +---
 worktree.c   |  5 ++---
 wt-status.c  | 11 ++++++++---
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/wt-status.h b/wt-status.h
index f1fa0ec1a7..35b44c388e 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -151,7 +151,14 @@ void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct repository *r, struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
+/*
+ * Frees the buffers allocated by wt_status_collect.
+ */
 void wt_status_collect_free_buffers(struct wt_status *s);
+/*
+ * Frees the buffers of the wt_status_state.
+ */
+void wt_status_state_free_buffers(struct wt_status_state *s);
 void wt_status_get_state(struct repository *repo,
 			 struct wt_status_state *state,
 			 int get_detached_from);
diff --git a/ref-filter.c b/ref-filter.c
index 8447cb09be..3f63bb01de 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1502,9 +1502,7 @@ char *get_head_description(void)
 		strbuf_addstr(&desc, _("no branch"));
 	strbuf_addch(&desc, ')');
 
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
+	wt_status_state_free_buffers(&state);
 	return strbuf_detach(&desc, NULL);
 }
 
diff --git a/worktree.c b/worktree.c
index cba2e54598..23dd547e44 100644
--- a/worktree.c
+++ b/worktree.c
@@ -369,8 +369,7 @@ int is_worktree_being_rebased(const struct worktree *wt,
 		 state.branch &&
 		 starts_with(target, "refs/heads/") &&
 		 !strcmp(state.branch, target + strlen("refs/heads/")));
-	free(state.branch);
-	free(state.onto);
+	wt_status_state_free_buffers(&state);
 	return found_rebase;
 }
 
@@ -385,7 +384,7 @@ int is_worktree_being_bisected(const struct worktree *wt,
 		state.branch &&
 		starts_with(target, "refs/heads/") &&
 		!strcmp(state.branch, target + strlen("refs/heads/"));
-	free(state.branch);
+	wt_status_state_free_buffers(&state);
 	return found_rebase;
 }
 
diff --git a/wt-status.c b/wt-status.c
index 3e0b5d8017..5c4cc4805f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -782,9 +782,14 @@ void wt_status_collect(struct wt_status *s)
 
 void wt_status_collect_free_buffers(struct wt_status *s)
 {
-	free(s->state.branch);
-	free(s->state.onto);
-	free(s->state.detached_from);
+	wt_status_state_free_buffers(&s->state);
+}
+
+void wt_status_state_free_buffers(struct wt_status_state *state)
+{
+	FREE_AND_NULL(state->branch);
+	FREE_AND_NULL(state->onto);
+	FREE_AND_NULL(state->detached_from);
 }
 
 static void wt_longstatus_print_unmerged(struct wt_status *s)
-- 
2.28.0.277.g9b3c35fffd

