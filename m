Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99807C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B4520578
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="k8mFjTI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHXTRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgHXTRD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:17:03 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994A1C061575
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:17:03 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id l8so2013596pgt.23
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ttAYxXS88OVIa94j2Dxamw89DG/60toazSpMa866OW0=;
        b=k8mFjTI0PQowID4EE2IuoxNpJD864QdsLBnPQTp3Ug5qVA9yuebLP9Z1tkN3VfGIUS
         2yskFuagc/k3Ll7nCM57BacTRqlwoeLG0UEqCadRf2TmIH1HKGHlsNcnxslqUU8pOKrj
         vn3l8kEOSkAbKbYmLPrNkbdXHx5UzDppTJZ9ZMqCdTbEdm62U4kZr4U4ZILP0RtYmvzb
         Khwacap0MdQeXICUKgStaHZ7UKKx1+Xjb6A5UEYXkGC4HXQBtypm7lRUW4YD/gWwUg8l
         bXCKt3gLBRYRJoL0fm0kQ6ux2Mx4qlBFKPTyciVIPBiKu3cJ8M5zwz5hl5I06fnW0l45
         jMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ttAYxXS88OVIa94j2Dxamw89DG/60toazSpMa866OW0=;
        b=SQt0TB6UwSW7UU0p6F5f/1EQ+/NB2zV7ffRFVeUXzfTieait6r9j1OsiveSMpXf58g
         kUn9RNG0/57u6BxYDuRnYFEBbf3drPdpvFjT8SW+aBBl5rNu73OVsQdfbDFpLuM0TUMv
         3Ab2ucsZcIAIxjzzn7oBW6EqjJe8TWeS71z6n4DwgUYUQS4B6aaglGcFQcx/6jNedX6V
         FBK0MN6ef+wl/p1WFctVNv9a3nE34QMcCPlHmULmp2oQwKapZdKZ4DKEl9DgRoez3YWo
         ieDiIiwV7VR/GBk1P9kLSpKlmPp6Ykvu0CX3ERhSXTV9ymwgkz/D+jV0eReVYKftlFVZ
         cflg==
X-Gm-Message-State: AOAM531Ka6QFsBQ8OPllnZ69y9MblMoDL6eaZi/Mq1WhkeHCJDVkkQUQ
        iGRQ+WpD8nVVpTh4e+qXm/xCsxrmxmCYRBtCd3rbYEpryP8V9QrkSGl8D9Pn2vDxXpOGO/axZFV
        2Ndvjk+KbDS268/4D5XfbHKzg0r6Z6Yk4mdrLsBS/3R2qSQOIchaJX9yTDuAvjFvHTrGonlte8S
        31
X-Google-Smtp-Source: ABdhPJx4JcVI3I2p+RnhqVF2tMj2s3nBR2GhByIlv5QY1EzJYJ3e/Tv8n+yY8rGSadd79W7o91Nyh+vFLe1XIkAhoJb2
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:ce85:: with SMTP id
 g5mr553857pju.113.1598296622565; Mon, 24 Aug 2020 12:17:02 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:16:35 -0700
In-Reply-To: <cover.1598296530.git.jonathantanmy@google.com>
Message-Id: <6fe6ede5ff2dabed0d7633bc2a385d9047b13cb3.1598296530.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 4/7] index-pack: remove redundant child field
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is refactoring 1 of 2 to simplify struct base_data.

In index-pack, each thread maintains a doubly-linked list of the delta
chain that it is currently processing (the "base" and "child" pointers
in struct base_data). When a thread exceeds the delta base cache limit
and needs to reclaim memory, it uses the "child" pointers to traverse
the lineage, reclaiming the memory of the eldest delta bases first.

A subsequent patch will perform memory reclaiming in a different way and
will thus no longer need the "child" pointer. Because the "child"
pointer is redundant even now, remove it so that the aforementioned
subsequent patch will be clearer. In the meantime, reclaim memory in the
reverse order of the "base" pointers.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 357e03b5aa..032716553c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -34,7 +34,6 @@ struct object_stat {
 
 struct base_data {
 	struct base_data *base;
-	struct base_data *child;
 	struct object_entry *obj;
 	void *data;
 	unsigned long size;
@@ -44,7 +43,6 @@ struct base_data {
 
 struct thread_local {
 	pthread_t thread;
-	struct base_data *base_cache;
 	size_t base_cache_used;
 	int pack_fd;
 };
@@ -380,27 +378,37 @@ static void free_base_data(struct base_data *c)
 	}
 }
 
-static void prune_base_data(struct base_data *retain)
+static void prune_base_data(struct base_data *youngest_child)
 {
 	struct base_data *b;
 	struct thread_local *data = get_thread_data();
-	for (b = data->base_cache;
-	     data->base_cache_used > delta_base_cache_limit && b;
-	     b = b->child) {
-		if (b->data && b != retain)
-			free_base_data(b);
+	struct base_data **ancestry = NULL;
+	size_t nr = 0, alloc = 0;
+	ssize_t i;
+
+	if (data->base_cache_used <= delta_base_cache_limit)
+		return;
+
+	/*
+	 * Free all ancestors of youngest_child until we have enough space,
+	 * starting with the oldest. (We cannot free youngest_child itself.)
+	 */
+	for (b = youngest_child->base; b != NULL; b = b->base) {
+		ALLOC_GROW(ancestry, nr + 1, alloc);
+		ancestry[nr++] = b;
 	}
+	for (i = nr - 1;
+	     i >= 0 && data->base_cache_used > delta_base_cache_limit;
+	     i--) {
+		if (ancestry[i]->data)
+			free_base_data(ancestry[i]);
+	}
+	free(ancestry);
 }
 
 static void link_base_data(struct base_data *base, struct base_data *c)
 {
-	if (base)
-		base->child = c;
-	else
-		get_thread_data()->base_cache = c;
-
 	c->base = base;
-	c->child = NULL;
 	if (c->data)
 		get_thread_data()->base_cache_used += c->size;
 	prune_base_data(c);
@@ -408,11 +416,6 @@ static void link_base_data(struct base_data *base, struct base_data *c)
 
 static void unlink_base_data(struct base_data *c)
 {
-	struct base_data *base = c->base;
-	if (base)
-		base->child = NULL;
-	else
-		get_thread_data()->base_cache = NULL;
 	free_base_data(c);
 }
 
-- 
2.28.0.297.g1956fa8f8d-goog

