Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8BCC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B77620882
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg3EzRSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIJTF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgIJTEG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:04:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E409FC061786
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w3so9605727ljo.5
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkUeDnvS+/tJxB2K4Ll4oLteH5VSW+eTzWNY+jwhTJ8=;
        b=jg3EzRSzZJV2uuAdDxLW+eOmbdVD00hT1TRNriSrEoRs2AVNsO+2f6bpzlxuXXRFfZ
         qu+6YOs4DtJzz8QVrZTnlnYDKvLz6wb+thrzJRqyUNYttcAWuqm1sHWYpKPcn+KU+KyM
         m4NJANmLd2v9AFJMM90KINiuhmCBC3EBJavhOUKVgjv8dsejeK2nSBkENRWIUSNgcJjw
         hbVmS0fJ9eO9bwaamvaqRaAOHJMYObC/+VuzRHgdAzNpqUVzYJOjtaw6snANobjEwjPT
         D1e0J4NvNSPWbdJdK46oW4eJPJMZ4PEBlxA/HVyouTuvYcfyr8Ibzf2X+mfutyyOFwGW
         731Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkUeDnvS+/tJxB2K4Ll4oLteH5VSW+eTzWNY+jwhTJ8=;
        b=WxKYPH5MwEP+/EjEdOHcTaR+NLPcJ/yk6ZA6ZI2YH2NiT/LL0lIvv0/Ut6n/O8LTT5
         xh6ZfWN6Yctva1YTUm9aHv/kBsQf1YhCwsuTRTmUMi6KCzGmjf1FdAX6AnKMuw2BNtGP
         geGdI9k2MKi4pBwt3wbYhp5YHOE1qBJO4w/VwbhLF+6y3mrz0uvVvzi+GFd9P9+LK8p2
         uepNZTuUiOsnubMehSAq4dKJxfRtItsazZs1BrmMIWOvnF5YV5JnIJY1VGQRsVPkyUfM
         S22XFUgHyABes2jOGQgBYEZjcEpUJOgnrX6ksDYYkVbtLh8FgLqdvxSf4eiDsGgI9xeS
         +aZw==
X-Gm-Message-State: AOAM530HQSLlrxFXRFhE6F+UrOsn6uBz1Yn6CmdfRQH5Nj6+z3V5Bw/S
        rSmj6/fo6zcfPNYv0Sc7dz1M8XJCsH8=
X-Google-Smtp-Source: ABdhPJw/9JWRSFAYXD+qUiT/U9rNAJKNVQUV8eZkhTUJEbtNz7LmGTwoCc3fbRyEjqXGgxzD2G1Y/w==
X-Received: by 2002:a05:651c:554:: with SMTP id q20mr5550382ljp.348.1599764644015;
        Thu, 10 Sep 2020 12:04:04 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id v11sm1549815lfg.39.2020.09.10.12.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:04:03 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/8] wt-status: introduce wt_status_state_free_buffers()
Date:   Thu, 10 Sep 2020 21:03:37 +0200
Message-Id: <c08fed5a01dabcd02a0f0f5dfaf0f87ce3824ca1.1599762679.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1599762679.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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

