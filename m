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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69528C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41318613B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhEDVRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 17:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhEDVRI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 17:17:08 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C681C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 14:16:12 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t12-20020a170902dcccb02900ed4648d0f9so4916262pll.2
        for <git@vger.kernel.org>; Tue, 04 May 2021 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eZxVnx+U11TuQpl7BsNPTcMEzYXOnZs4l4crToHx/nc=;
        b=YIcuVIIgSiR3Abq1KphECOqXPZTB0GMQXmEiLTtEPU3Mj19FfG2D2YjRM58GG/QCge
         9Rb+w3vK+Q9nKLvA1llh4B/NaSZCSC//wPE1ir6ZqTWJ79eu4DYO+tVCpRACvU+C9wCw
         N2oV01mnV9wcptXZ0vCS+yygwNGpVS1dbvXfisFSlQceJ7vuYa8ygfvLFB3/7zcOIOOA
         bAy9nHgtacl26cFa0LM82gCfQIQW2ssisPNMugdbj4P+p4eNIGCn5b/hVGJUuXqiHBA1
         SQqt2a2/sMisxNHdTgqkQX2VKM2c8RxwU/i3Ji3rgGAKwF7SzEptFPbQ/hkIrBTtJtHs
         aYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eZxVnx+U11TuQpl7BsNPTcMEzYXOnZs4l4crToHx/nc=;
        b=RAD3pugUlXDODihd8og3IzZluD9E1+8rIrwjx+QQoo+L6HCdFezfCb4wdtWABNb6YS
         0/Jcv9ttgilM552CONW/LiXSlNR4iKINBg0okAjEoAQHuwJfYCNJwL3s1V5EL04nEFG1
         v11r/pbfIQE4/ERCKiaRbt2P04B18KViQbnLZT+iTvfPUvA2Sk0YyWpqQebcUfSzHC5o
         V27YZFRUCPPbxsgUFHvpHIN+IUFOZ7M1QyfzKTtk40vu+d7vp4rwUK+UjCYf/z1wU4bI
         pkCMAI/kl9drZLgN/E5SPMYawWmGif23coAQREUSiR/5su610N88epoauHigcBF3ooOA
         mIIQ==
X-Gm-Message-State: AOAM533iVu7mqTl1MYyHlo7vh2+qBWbsR2jjiClEEw69s9wpUiUg1IPr
        jSd4g/clfXJ+GCpUGFvJ7J7DXJuJ4zEXmEJZ+8fLI/aOhEQoa/KNpZGxC6Eccb7YHkpqXzAmZGO
        30XKvJavzBEmiRx8E7b+83fVUzag9FRRgsSc1iATC2GyYjKcRBGz/ZLJA6/OypIsJ0VgxZlyZLT
        98
X-Google-Smtp-Source: ABdhPJzoafrF0ckzeTWrVGfvJS1TAWIgbphR1jwOzISPJF21/80l1llg64MAOPDIcXX8+3ZwEhTVs4CUpD006UMPDWbF
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:909:: with SMTP id
 bo9mr7393327pjb.142.1620162972120; Tue, 04 May 2021 14:16:12 -0700 (PDT)
Date:   Tue,  4 May 2021 14:15:59 -0700
In-Reply-To: <cover.1620162764.git.jonathantanmy@google.com>
Message-Id: <57c3451b2e36d003aa7fc398c644ce71ab668b5e.1620162764.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1617929278.git.jonathantanmy@google.com> <cover.1620162764.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 2/5] fetch-pack: refactor add_haves()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will need part, but not all, of the functionality in
add_haves(), so move some of its functionality to its sole caller
send_fetch_request().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.31.1.527.g47e6f16901-goog

