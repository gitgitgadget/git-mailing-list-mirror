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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CCDC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B5B610A7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 01:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhDIBK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 21:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIBK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 21:10:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0DC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 18:10:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n13so3739266ybp.14
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 18:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=22FfvI2Ld4mCHPq5rjNg63Mu3JTg5FX2CkL3tUrVSbo=;
        b=nhIGN5Z7CXBMnmeSvPZp+Km3wVv7K6TEOzaoyrL3t1pySgq0HlQiGYdKO0ued5EGQG
         NRf98a3imqNkQYlc/Ks8KxZ5a/2ZyfWIMn8vLA2vpfQbPO62hyqzosfYXJdH6Dopu0HA
         cK2MHRtkfeU8W1I9b27p3TrVKQG4fDnMms0xRRiGmjqZ8PG+pv9UMLib9RzLPZ3LgA1O
         YcY+dhdf59kfoOdZkNkz6DzEQ+SsR8nf0Iqfqx2s5Sx0pQLWwTRbvL1uZroUmwtWrIX2
         Yf/vEbSSz0l7npHgYS+2a2xUUwGlE2WYKDRNdpy86JLKCsO1Hk5VSVITKJhHgCwdY+4K
         C/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=22FfvI2Ld4mCHPq5rjNg63Mu3JTg5FX2CkL3tUrVSbo=;
        b=KnRhuqKs6Ihcj/XxNeEhmijG4JAFoB+QqYr/HBJiMrCRYA3m9bjvfkEhCjRUXdrTuS
         LW06uyHKH2e4X1Mjd79HDlKy4bk3CRXNfhQ662QGQs3lPV+Gr7npFR8pYLdVCH3fH2O6
         CAmpc1LUAHo5F32PCDQX8YWhaA8j2KhZLRTzk4pxD+OzP6ehBtV+NjcqSfMcBT7rhPr0
         +GFiAI5T/AaV15WzMII6XK74vMi5gF8k0DN8NrHnJSUsI8Z6jVzNeYQYvrLuasS1PHl0
         3gnTkJG3yHDdlwa3z8B5ZjIL85CRqgFPBnzEoN2SNLtNpyFim8X6BWTLRYvgsu9z7JMK
         GEcg==
X-Gm-Message-State: AOAM532+wBRNtuYWt/TJSoZSjabqlG6nnYv7J3biNYfx4LY+2YA1SR01
        dQWfSl6YjhZnA52y6YOdNC7z9LCF4i4KQzCr1P4z4b/GLZbqqZbvwWzg+KmegYwoOWTkmiaEBNU
        q3KY0GbNASYrzj6OKzPr2SLAXN9ObHPUlS73KfQNcn+7+PDeTfEd4gRt+RzCD4hU8QlPzt/yOfp
        EM
X-Google-Smtp-Source: ABdhPJz2l9OCWwLWmt6Lh8nEVLpH/Zolg5ArB+i2eO91kZZ8RBUqpBGp61w/cDNIjlgsw1a5yBLYpcTBwCQZxUhE2F/m
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:9108:: with SMTP id
 v8mr14839292ybl.460.1617930613225; Thu, 08 Apr 2021 18:10:13 -0700 (PDT)
Date:   Thu,  8 Apr 2021 18:10:00 -0700
In-Reply-To: <cover.1617929278.git.jonathantanmy@google.com>
Message-Id: <b07e52ec18f46fb85d49ba0e1e6e8ad22845af9e.1617929278.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1617929278.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 3/6] fetch-pack: refactor add_haves()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will need part, but not all, of the functionality in
add_haves(), so move some of its functionality to its sole caller
send_fetch_request().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 9f3901cdba..128ad47d2a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1195,11 +1195,9 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
 }
 
 static int add_haves(struct fetch_negotiator *negotiator,
-		     int seen_ack,
 		     struct strbuf *req_buf,
-		     int *haves_to_send, int *in_vain)
+		     int *haves_to_send)
 {
-	int ret = 0;
 	int haves_added = 0;
 	const struct object_id *oid;
 
@@ -1209,17 +1207,10 @@ static int add_haves(struct fetch_negotiator *negotiator,
 			break;
 	}
 
-	*in_vain += haves_added;
-	if (!haves_added || (seen_ack && *in_vain >= MAX_IN_VAIN)) {
-		/* Send Done */
-		packet_buf_write(req_buf, "done\n");
-		ret = 1;
-	}
-
 	/* Increase haves to send on next round */
 	*haves_to_send = next_flush(1, *haves_to_send);
 
-	return ret;
+	return haves_added;
 }
 
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
@@ -1228,7 +1219,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      int *haves_to_send, int *in_vain,
 			      int sideband_all, int seen_ack)
 {
-	int ret = 0;
+	int haves_added;
+	int done_sent = 0;
 	const char *hash_name;
 	struct strbuf req_buf = STRBUF_INIT;
 
@@ -1312,9 +1304,13 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	/* Add all of the common commits we've found in previous rounds */
 	add_common(&req_buf, common);
 
-	/* Add initial haves */
-	ret = add_haves(negotiator, seen_ack, &req_buf,
-			haves_to_send, in_vain);
+	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
+	*in_vain += haves_added;
+	if (!haves_added || (seen_ack && *in_vain >= MAX_IN_VAIN)) {
+		/* Send Done */
+		packet_buf_write(&req_buf, "done\n");
+		done_sent = 1;
+	}
 
 	/* Send request */
 	packet_buf_flush(&req_buf);
@@ -1322,7 +1318,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		die_errno(_("unable to write request to remote"));
 
 	strbuf_release(&req_buf);
-	return ret;
+	return done_sent;
 }
 
 /*
-- 
2.31.1.295.g9ea45b61b8-goog

