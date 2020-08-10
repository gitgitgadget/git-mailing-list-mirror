Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B5DC433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBAC20734
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="uA+0mJC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHJVfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJVfF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFF4C061787
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id h7so9866073qkk.7
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgRCzcq3hK6Os5aV3Xq9Kffc33HyktM7Rm9FPSc61pw=;
        b=uA+0mJC8++PmIHbn1FOSecAexeEtwfO2zKIpGjaDNyX+3x8QmGLQ4P2v4HYp60v9zv
         03kC9dNO9L/oajapTj4BumJ0Ow7yn9DihgpGYb0TRWwEE3VjXPHW57AoYxGMRUwRFKTH
         aes8kTfTAPuDuTaV3pK0qm0fwRL06Yo7FKF8pmv4+xa/bO/yiCsBaWFJfBtJYvUpno0u
         PEdI54+ZnnHmnz+SP/ji+gBICFBfI3k1zOFCnIrwmt4FFaDeb5DX40ppkdZYkf2hVuJQ
         XQB1u9u0X1oP8jFmMbFWPO6/E/ZvNjvkAfEEO9P/PsI33jeIhU4U5N0gihO1bJerE26L
         nDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgRCzcq3hK6Os5aV3Xq9Kffc33HyktM7Rm9FPSc61pw=;
        b=EkAKvm5DRlkEOhUsPZXeBrAh/i5D7MgXDcL9WzXH9ZXvoLfsSqRUlp7MsEQ9Q/5jRx
         VdUJdOBQ5kmFLu7I/6IM+O+jK9EcpJ62N+i5h5HoV/qiIVov5TCBPd0h12JJR+kYbrAF
         9CxVRddVHpurYjDmH8eMRZ0iCr/mBYKi+i0stNahlKoWR81Xt4L8FqQOfT6tZt1egi5O
         45DeA+V7Pa0O2j9E1u9bbah9xPHSS5Ve9GQoyHFQJIe48D/bPGzWQtltrYjT9/WkAxCA
         k0A5PEvUF8lphU8WaO5eb3whhh5NU+PgSMLbdZBJfVCIfb1bxXCeuxjZ20/H5p4YGpAO
         NN0A==
X-Gm-Message-State: AOAM530W1IsK9GtfZMryFjaJiK5WCBxWlmM5PJuDT3JSI6J75q5LMI2E
        IlVi2E/DlbtcIOF/N6IvLBthPPN+XEo=
X-Google-Smtp-Source: ABdhPJwLHx6j11BlAFO2taM9tUMgFwEsEiQ7SOGARaqi4q4UMkLjPHaTqmK3pX4MnmBaWCg8LS6GJA==
X-Received: by 2002:a37:4144:: with SMTP id o65mr28736020qka.32.1597095304039;
        Mon, 10 Aug 2020 14:35:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:03 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [RFC PATCH 09/21] entry: add checkout_entry_ca() which takes preloaded conv_attrs
Date:   Mon, 10 Aug 2020 18:33:17 -0300
Message-Id: <6ff36c853294f2449f781cfa1baaa63e691fa3d9.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parallel checkout machinery will call checkout_entry() for entries
that could not be written in parallel due to path collisions. At this
point, we will already be holding the conversion attributes for each
entry, and it would be wasteful to let checkout_entry() load these
again. Instead, let's add the checkout_entry_ca() variant, which
optionally takes a preloaded conv_attrs struct.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 23 ++++++++++++-----------
 entry.h | 13 +++++++++++--
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/entry.c b/entry.c
index 59d5335ff1..f9835afba3 100644
--- a/entry.c
+++ b/entry.c
@@ -440,12 +440,13 @@ static void mark_colliding_entries(const struct checkout *state,
 	}
 }
 
-int checkout_entry(struct cache_entry *ce, const struct checkout *state,
-		   char *topath, int *nr_checkouts)
+int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
+		      const struct checkout *state, char *topath,
+		      int *nr_checkouts)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
-	struct conv_attrs ca;
+	struct conv_attrs ca_buf;
 
 	if (ce->ce_flags & CE_WT_REMOVE) {
 		if (topath)
@@ -459,11 +460,11 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 	}
 
 	if (topath) {
-		if (S_ISREG(ce->ce_mode)) {
-			convert_attrs(state->istate, &ca, ce->name);
-			return write_entry(ce, topath, &ca, state, 1);
+		if (S_ISREG(ce->ce_mode) && !ca) {
+			convert_attrs(state->istate, &ca_buf, ce->name);
+			ca = &ca_buf;
 		}
-		return write_entry(ce, topath, NULL, state, 1);
+		return write_entry(ce, topath, ca, state, 1);
 	}
 
 	strbuf_reset(&path);
@@ -532,12 +533,12 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 	if (nr_checkouts)
 		(*nr_checkouts)++;
 
-	if (S_ISREG(ce->ce_mode)) {
-		convert_attrs(state->istate, &ca, ce->name);
-		return write_entry(ce, path.buf, &ca, state, 0);
+	if (S_ISREG(ce->ce_mode) && !ca) {
+		convert_attrs(state->istate, &ca_buf, ce->name);
+		ca = &ca_buf;
 	}
 
-	return write_entry(ce, path.buf, NULL, state, 0);
+	return write_entry(ce, path.buf, ca, state, 0);
 }
 
 void unlink_entry(const struct cache_entry *ce)
diff --git a/entry.h b/entry.h
index 664aed1576..2081fbbbab 100644
--- a/entry.h
+++ b/entry.h
@@ -27,9 +27,18 @@ struct checkout {
  * file named by ce, a temporary file is created by this function and
  * its name is returned in topath[], which must be able to hold at
  * least TEMPORARY_FILENAME_LENGTH bytes long.
+ *
+ * With checkout_entry_ca(), callers can optionally pass a preloaded
+ * conv_attrs struct (to avoid reloading it), when ce refers to a
+ * regular file. If ca is NULL, the attributes will be loaded
+ * internally when (and if) needed.
  */
-int checkout_entry(struct cache_entry *ce, const struct checkout *state,
-		   char *topath, int *nr_checkouts);
+#define checkout_entry(ce, state, topath, nr_checkouts) \
+		checkout_entry_ca(ce, NULL, state, topath, nr_checkouts)
+int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
+		      const struct checkout *state, char *topath,
+		      int *nr_checkouts);
+
 void enable_delayed_checkout(struct checkout *state);
 int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
 /*
-- 
2.27.0

