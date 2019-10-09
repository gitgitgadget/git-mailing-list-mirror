Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A8F1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 23:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbfJIXoi (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 19:44:38 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53073 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732453AbfJIXoh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 19:44:37 -0400
Received: by mail-pg1-f201.google.com with SMTP id e15so2853724pgh.19
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 16:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ReEftmItdZV8emeyllp25+fFy04kQopQJdOw0/ZIGCE=;
        b=NMY4gDNYnpFsDxON3fsyApT+8gJ6xbwbiocxHFTLq3Ry7f/Aji5krCp9DbE4SZQJlj
         PW0i62yjaSC/spCK0O5FztkLHxXGbZ+TwHMYgizMfrFQ/svceDx2r2qhu8L1QuvvMjZp
         UdZcz0tMW7RPg+/yxcpBq5KVPcoI24WuEjxs7+b+jwzBgrWxwkaWeFm8lSKLikYwx9tV
         EA/qUpkYNxZnx095ICNLfQxZof1nkP6QkyA3aS28gI55slcqLSXRl2iG29aBu16JGtj9
         n1wajC9Fds4ox+ppgZ6yAwZY+20M0+jHTJm8AZVPqPjAcEHt5QBub0WYdYz2up0hOxiW
         MOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ReEftmItdZV8emeyllp25+fFy04kQopQJdOw0/ZIGCE=;
        b=jLJUaKTY3u5Im+b/fFVaEZ4x/yJub69OR8lAhNo1NpvGIm6pNvozltrI/lhypk8Dqc
         jupVQr14nOeOAQm3PvpYRiQSFRxrgV3DmgalIGRPk1/t8u39KSmlVwPYnjHEG67EYuZy
         9nSPYf0R+LbTS2ZsUQuPka4GBFYGNrlOjWPkX2mXnxZ7PhFyr+apT7b9RK/z+yf/vzp6
         IGHmYl9z/W7MZscOiVAu97VhKCRWBA4Fi4GT7HKTkm1bM1pS9/JrLLSk/AUWUfdT8Mcr
         uT56dhul/+zsU3lIkbyAs3c1cyL3XF9S4TLDbt9mgqesq9ITzKPic+aryChbmCUw9q7y
         BBMg==
X-Gm-Message-State: APjAAAWcaQE+G7Li2z8Dz5tIVj803vM3GsNxsR0qfTZX3VFo+13V/77H
        2eF53muI5iE9xonsWILqnhjK89j1z9vNaPSX9A2fnXffGFSKHnskwcxCDWuGU/N1DJNJscbWEKU
        GYQiIpNNQPwtmjzvcHo9/oJd4PHEmGDFpaPOuPIQ+VPYRqOn9PdgaojobsHBXndTUGuakObmI3F
        qR
X-Google-Smtp-Source: APXvYqx5uC/btFz70MSoS0v6K3gzu9HesrtNiizH4bdtQEbCd7X8HYAOrLYS/5J7b+KOOJvDAfc/7ZgunJwfWhuxDoV+
X-Received: by 2002:a63:d457:: with SMTP id i23mr7107488pgj.276.1570664675374;
 Wed, 09 Oct 2019 16:44:35 -0700 (PDT)
Date:   Wed,  9 Oct 2019 16:44:19 -0700
In-Reply-To: <cover.1570663470.git.jonathantanmy@google.com>
Message-Id: <39740c6e58bd6cb6ea33e5abb4ab8542ff6eb7b7.1570663470.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 3/6] index-pack: remove redundant child field
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        mh@glandium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead, recompute ancestry if we ever need to reclaim memory.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 99f6e2957f..35f7f9e52b 100644
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
+	int nr = 0, alloc = 0;
+	int i;
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
+	}
+	for (i = nr - 1;
+	     i >= 0 && data->base_cache_used > delta_base_cache_limit;
+	     i--) {
+		if (ancestry[i]->data)
+			free_base_data(ancestry[i]);
 	}
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
2.23.0.581.g78d2f28ef7-goog

