Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE91C83F17
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjH3S34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343743AbjH3QoM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53CD1A2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c647150c254so1959491276.1
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413845; x=1694018645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mNswL+rz+pumA2VEb8BDNE4gOySTEWKOH0eUpEAy940=;
        b=cMNAd/JJJ5PHTQfXHlkRIbTCq8MsE1lLR1sHBEPg1ilkQC/we/ZHGd9jOJL5/SCi6l
         GNZ7OoXzKBZEDDEii2M1t4HgV0HxMrFTsRIFDHnMpj+nT9KmGXqfVco4oOkB964UsYhH
         E75/oyjQDYIweqxb/3mRuOf4VeeDRdxwFMx1zgnPOv8e0sY7yvjtvzF3TZrRuE4TTEl7
         tInMXzOq3WecT7ykmrb+af5JM0+S2AAq/z4KqbBy+aVvTrTLL8u+gFw+G4i2++MK9SSa
         ry1wvbA+rZYEchTXxFda9WsZFY+jydqSW/KEYM7G5f5CR3XzW9vQwI3GPpcCv8XJYRuI
         OdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413845; x=1694018645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNswL+rz+pumA2VEb8BDNE4gOySTEWKOH0eUpEAy940=;
        b=fl3qJEdQ6MTBYOdb8qSfGTrxF3UUTvWB1TXcK7iP2kiR9dXbvBZD4TBSS2jLptSkpf
         GY2iTOILM5sfuUylpZk72eWC/ILkTif1fs97J9n1cdPhXYl57yB25E2xSyuEjIyU31HD
         GKsfcAmXw2nJHXjm5Qpim7ojy5mWlDHLKrTfPuvmBwgz9HTSpPh/zp3kIX3ze9zXkzmJ
         yqgjdYxLmYUHmNAMQvooVoyaMoaXM7JEBiYscgcy/lYHEEk2+mdWSxdFfX9T/0E88ND7
         BXqrb7PdHz7f5nFRJ9dsXig7z4jH8UTU/savcd7nhBP6/E/wrzNcZ4KU8DFQ1QXZBnaa
         dfgA==
X-Gm-Message-State: AOJu0YwsfDX5y1Z1jn7gy3ys4tFlr94oegK0/OurTws6nRHXfwstwq98
        c25JdkUjQsQyGXVI6pLhkNS4E4VNN9IcNDLbABuQd2vO6lzsN4JabavqDQ9QD0wJaYCCZZA6FOy
        yqHETSizwqIs0RfpcvvRYX7tMltCTJ5JAqySXEB0S+RcGxmwpI1C9Z3g3qUPye8L4xvEjbwNsPe
        4b
X-Google-Smtp-Source: AGHT+IFOrzAyzRqkoETI1m5GkV9RWYT7vDXT5YcZyIOiU39h7cb5mwFkhT6o15UbIjcbslsA4rMzqt723EmwiPv4duD5
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d155:0:b0:ca3:3341:6315 with
 SMTP id i82-20020a25d155000000b00ca333416315mr10858ybg.0.1693413844971; Wed,
 30 Aug 2023 09:44:04 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:43 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <8405b845e5a8f56a03c98708185c3402e172d311.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 03/15] bloom.h: make `load_bloom_filter_from_graph()` public
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "SZEDER =?utf-8?B?R8OhYm9y?=" <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

Prepare for a future commit to use the load_bloom_filter_from_graph()
function directly to load specific Bloom filters out of the commit-graph
for manual inspection (to be used during tests).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bloom.c | 6 +++---
 bloom.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index aef6b5fea2..3e78cfe79d 100644
--- a/bloom.c
+++ b/bloom.c
@@ -29,9 +29,9 @@ static inline unsigned char get_bitmask(uint32_t pos)
 	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
 }
 
-static int load_bloom_filter_from_graph(struct commit_graph *g,
-					struct bloom_filter *filter,
-					uint32_t graph_pos)
+int load_bloom_filter_from_graph(struct commit_graph *g,
+				 struct bloom_filter *filter,
+				 uint32_t graph_pos)
 {
 	uint32_t lex_pos, start_index, end_index;
 
diff --git a/bloom.h b/bloom.h
index adde6dfe21..1e4f612d2c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -3,6 +3,7 @@
 
 struct commit;
 struct repository;
+struct commit_graph;
 
 struct bloom_filter_settings {
 	/*
@@ -68,6 +69,10 @@ struct bloom_key {
 	uint32_t *hashes;
 };
 
+int load_bloom_filter_from_graph(struct commit_graph *g,
+				 struct bloom_filter *filter,
+				 uint32_t graph_pos);
+
 /*
  * Calculate the murmur3 32-bit hash value for the given data
  * using the given seed.
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

