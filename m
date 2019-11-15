Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E19D1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfKOOQI (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:16:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42099 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfKOOQH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:16:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so11136412wrf.9
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5afrFYSZvARCzze+Y+Vs4B6LG5LOEcJhymnQvlI5uWU=;
        b=JLfFGDr3JF7hxzON5xiYBofwuDxn72XUg0c+spDMHDTkygcWrCdzMZte4FvRQmiEPt
         AEFdQX5hIdV4grv1Ki6ktw361tWZhmDUgsOROYM0fXJ4j9avXB8QKlVwVNrRfo1UJOc2
         I3WLy3RYJONg3uxZxpJ4S5STyhvmBH54x+NmzKBY/1c4xApSRAiopK6YUvNrpC3gUalR
         qB4cFGKXaiEYjXUB9vlMKFw5SoGrMtAvX5FZGPUln/uQed6eQKCrKO3zzYQUHS9dIsSQ
         tdxPF9LY//eftk5GZkTrIF9DWWLlK+PDtqr0glgPrRtYVdLFSjCKX4bAlW1OLQGjTluk
         W7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5afrFYSZvARCzze+Y+Vs4B6LG5LOEcJhymnQvlI5uWU=;
        b=uZiBYYC0H0l/sMZ+ci1WDFlU8qXp+wBAVBnIet0C9PvydXOg509B8dU4fYkteCQ3oq
         ybeqLGGtOXpf87Phk4T0wYCYO/8iNSz4nWFs+HuL2JkiN8iwfS+/pGE7H9KdfGR4D2Uh
         FFDOHPFttbow0U1gCYZfN557FNv85V0le3euqCGPLRB9+ZMV+7Bl68ZDoWkWVmMbcIop
         t5fiLj/OQDnXhBFzYgvPlCuHRfp4MaCoOMlagSMosR2VHsDptq/15Qfef0AcXsch2Psz
         0zUOBkCF3eywp/mUnchLIzXwefnF4Z+O+ANpJYx5bJjBE38SmaEp30aHcgMyUc7jt4dN
         6Smg==
X-Gm-Message-State: APjAAAVt1KiuQZAQ5AdkcNV1deKPqyM9pqoOKq3QqJGnI+yZPFtKBnoG
        2Iz+Xdj0f5yYoXVY0imCwrNFZfIK
X-Google-Smtp-Source: APXvYqyUNObYBbVwhZCXvVFRcdzNt5qfNFCiTwlpW6XcFeLP2vUJV+s9WRHIVA2rum9PVzjEwynj/A==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr16806176wrj.84.1573827363555;
        Fri, 15 Nov 2019 06:16:03 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:1050:ac52:b4cd:f6a2:ba59:f1d4])
        by smtp.gmail.com with ESMTPSA id a2sm7907874wrt.79.2019.11.15.06.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:16:02 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 4/9] pack-bitmap: don't rely on bitmap_git->reuse_objects
Date:   Fri, 15 Nov 2019 15:15:36 +0100
Message-Id: <20191115141541.11149-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0-rc1
In-Reply-To: <20191115141541.11149-1-chriscool@tuxfamily.org>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We will no longer compute bitmap_git->reuse_objects in a
following commit, so we cannot rely on it anymore to
terminate the loop early; we have to iterate to the end.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pack-bitmap.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e07c798879..016d0319fc 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -622,7 +622,7 @@ static void show_objects_for_type(
 	enum object_type object_type,
 	show_reachable_fn show_reach)
 {
-	size_t pos = 0, i = 0;
+	size_t i = 0;
 	uint32_t offset;
 
 	struct ewah_iterator it;
@@ -630,13 +630,15 @@ static void show_objects_for_type(
 
 	struct bitmap *objects = bitmap_git->result;
 
-	if (bitmap_git->reuse_objects == bitmap_git->pack->num_objects)
-		return;
-
 	ewah_iterator_init(&it, type_filter);
 
-	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
+	for (i = 0; i < objects->word_alloc &&
+			ewah_iterator_next(&filter, &it); i++) {
 		eword_t word = objects->words[i] & filter;
+		size_t pos = (i * BITS_IN_EWORD);
+
+		if (!word)
+			continue;
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
 			struct object_id oid;
@@ -648,9 +650,6 @@ static void show_objects_for_type(
 
 			offset += ewah_bit_ctz64(word >> offset);
 
-			if (pos + offset < bitmap_git->reuse_objects)
-				continue;
-
 			entry = &bitmap_git->pack->revindex[pos + offset];
 			nth_packed_object_oid(&oid, bitmap_git->pack, entry->nr);
 
@@ -659,9 +658,6 @@ static void show_objects_for_type(
 
 			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, entry->offset);
 		}
-
-		pos += BITS_IN_EWORD;
-		i++;
 	}
 }
 
-- 
2.24.0-rc1

