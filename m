Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA60C43381
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 15:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A676B23B3E
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 15:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbhANPvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbhANPvF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 10:51:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22597C0613CF
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 07:50:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w5so6259018wrm.11
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 07:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VctaxhDHJw+muFcGxVAjs4DJ5YK0b+adEJzLldZPcvY=;
        b=O5dQa0Mgh9A1Uhm6XF9Lu8CusC32eEr2NnAngoMkwIEGpyj8BgiJqUDhv2/qFAcRvv
         cj70Ngg3YLiNixriY1RmAlkFhLrzvj3KxDj4LurHSmJ5PkowgPHV6UvywpqYLLoVu3EH
         hVoU4bZyWNynEf24m7es5BhrhLLqJPtTbay38Dfsn3lTlEzGaWU0oTXUi4RRi6lut+Qt
         lkfQeo2L70kqE4Ycqi7Ir6Z9FTw5smj3JPl7kpOzpH1Uvc53Njl5dLYrTP1rCW3h0L0K
         C7CzDkPNtSB/wAiPwHK961CBP6UrywbNR3J+xq602UbNUG9MU4KwiXhMlaQ4qmuPN1SZ
         bbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VctaxhDHJw+muFcGxVAjs4DJ5YK0b+adEJzLldZPcvY=;
        b=YTfD7ZpmTEPatM3QB2nIQ2kz2XHmWDfQG+aEOoIl6J+6XOgHdDGLGSiDIy06FVu02o
         AzuBMuzQ3/+fnXX19IphR8bG23Alox8u3KSO+XtHlcMITpb2ZSNXRw+1wNoJpTT6K8xt
         TQjdRStHzY2bH/LbqpRBkHKIfpRd64vUfZZ+AIR1cvTalEp+/z+fIWdGrmW4axqL+xbQ
         BbrwTfEGz2eVfJMo9OVs1rB2sTDw8mh9gs+BN+Fc1XyUJJ5pB5uf4Oo1yT0+4zbGZyG0
         c/0FKYVEIoRopdgTD405O15huMzw7/VvoQVTXxf7+2J+fZlnPgx96dYD6QYWZeeblYHQ
         AEng==
X-Gm-Message-State: AOAM531OpI+AovtDt1e3SBoQ9rwz316Lcv5yZ2DMFb7V2b+87YOmRoE5
        xkmUc94N7C68UaU4SLgAFVPdhQizjyZPWA==
X-Google-Smtp-Source: ABdhPJx+VXvMRoDToFhmPD4KqmUsx2xt8zfr0eaG9+jnoQBoqf01xtHupAWT7zyEVYqemCsWwc7bvw==
X-Received: by 2002:adf:fdd1:: with SMTP id i17mr8467994wrs.173.1610639423665;
        Thu, 14 Jan 2021 07:50:23 -0800 (PST)
Received: from localhost.localdomain ([185.228.231.221])
        by smtp.gmail.com with ESMTPSA id q7sm10170489wrx.62.2021.01.14.07.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:50:23 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/3] fetch-pack: rename helper to create_promisor_file()
Date:   Thu, 14 Jan 2021 16:50:14 +0100
Message-Id: <20210114155016.3005932-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.30.0.83.g36fd80b35a.dirty
In-Reply-To: <20210114155016.3005932-1-chriscool@tuxfamily.org>
References: <20210114155016.3005932-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we are going to refactor the code that actually writes
the promisor file into a separate function in a following
commit, let's rename the current write_promisor_file()
function to create_promisor_file().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 fetch-pack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 876f90c759..c5fa4992a6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -772,8 +772,8 @@ static int sideband_demux(int in, int out, void *data)
 	return ret;
 }
 
-static void write_promisor_file(const char *keep_name,
-				struct ref **sought, int nr_sought)
+static void create_promisor_file(const char *keep_name,
+				 struct ref **sought, int nr_sought)
 {
 	struct strbuf promisor_name = STRBUF_INIT;
 	int suffix_stripped;
@@ -875,7 +875,7 @@ static int get_pack(struct fetch_pack_args *args,
 
 		if (args->from_promisor)
 			/*
-			 * write_promisor_file() may be called afterwards but
+			 * create_promisor_file() may be called afterwards but
 			 * we still need index-pack to know that this is a
 			 * promisor pack. For example, if transfer.fsckobjects
 			 * is true, index-pack needs to know that .gitmodules
@@ -943,7 +943,7 @@ static int get_pack(struct fetch_pack_args *args,
 	 * obtained .keep filename if necessary
 	 */
 	if (do_keep && pack_lockfiles && pack_lockfiles->nr && args->from_promisor)
-		write_promisor_file(pack_lockfiles->items[0].string, sought, nr_sought);
+		create_promisor_file(pack_lockfiles->items[0].string, sought, nr_sought);
 
 	return 0;
 }
-- 
2.30.0.83.g36fd80b35a.dirty

