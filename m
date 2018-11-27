Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756AA1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 19:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbeK1Gws (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 01:52:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33172 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeK1Gws (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 01:52:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so23255314qtp.0
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 11:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pe+wVuLRTQKygj30xc0OtIkNCxLUn1ZRwVG3TCoappM=;
        b=oB4WAbJQOtM8ppXmQivlNFs9ek93VMM489BPF9pTgMhc8/lriqWko+RM3X6/sOC+Fy
         jA9HKGc8IobePyAav3//kSLbvu4OOQivolgqGrYTwFmwE/dlaX7SF3vpHOLKCV8XwPB5
         Ttx/d4RL6ZmNvN/cHHRC8jt3TVtQbXu7zg1mqN9LhEBeIuUrSdCPnbkz9QZ5M6vSa9ex
         nvVC05jIobrx1UadSMuxEOdKpCKbtifOC7zw864A7zWkg2wHBgP4cA9h2dSfx351FUxS
         iOvsEAFGhLsvRk100RtP07M0vSmtxCI8Is2/cuAOp3l/rcydR7KvYEVE3STZUHa03jf7
         gV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pe+wVuLRTQKygj30xc0OtIkNCxLUn1ZRwVG3TCoappM=;
        b=a6ZCET52Dxnkdrj/Nf01UqiLAQIhsu8k0OKUurPcFKBojCcYPujvpNk9Mn1s1Pybqp
         J3PibMLsuu2Kb/XSaCiGPacfMiq3VL4NRMk+lZCFJ4569c/6ELzo61hiV/5wjhELs/Up
         iLqd2ho3s/r/STzq+cvG8l6k6xqPMgh1OsR3F05KnLd+0K29KprZeEhCiPDj+qQ0DCF0
         aXaSE8bSaNG6J9CoXmFzndzvgDDa1tWUf9/EhZTVOt8F1sHO4i+HHX2CrEtWidWB197m
         fSHf8Kq3JgFNeaeYX3KvFQfBYLWm4YfVhX8TSSka1E6Jq2gj2BEF9S5wN/d90Hgpywo0
         JnJg==
X-Gm-Message-State: AA+aEWZvthzz3elxOG27ONF5OJ27flQiLPKeznFU5b5mNiiH5h7KS4OH
        UFNQq7WVYEzsjPVpl63trtAciFMm
X-Google-Smtp-Source: AFSGD/W6BPZiF1taHv2+S3Wt54YpciFkSqpes9dXTj/v2fjlIU4QiBEXWm4QE2Fa+uzXoJaJRdCbhw==
X-Received: by 2002:a0c:872a:: with SMTP id 39mr32634141qvh.1.1543348427476;
        Tue, 27 Nov 2018 11:53:47 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id k132sm2087861qke.36.2018.11.27.11.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 11:53:46 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com
Subject: [PATCH v1] mem_pool: add GIT_TRACE_MEMPOOL support
Date:   Tue, 27 Nov 2018 14:53:37 -0500
Message-Id: <20181127195337.3264-1-peartben@gmail.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Add tracing around initializing and discarding mempools. In discard report
on the amount of memory unused in the current block to help tune setting
the initial_size.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: * git-trace-mempool
    Web-Diff: https://github.com/benpeart/git/commit/9ac84bbca2
    Checkout: git fetch https://github.com/benpeart/git git-trace-mempool-v1 && git checkout 9ac84bbca2

 mem-pool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mem-pool.c b/mem-pool.c
index a2841a4a9a..065389aaec 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -5,6 +5,7 @@
 #include "cache.h"
 #include "mem-pool.h"
 
+static struct trace_key trace_mem_pool = TRACE_KEY_INIT(MEMPOOL);
 #define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
 
 /*
@@ -48,12 +49,16 @@ void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
 		mem_pool_alloc_block(pool, initial_size, NULL);
 
 	*mem_pool = pool;
+	trace_printf_key(&trace_mem_pool, "mem_pool (%p): init (%"PRIuMAX") initial size\n",
+		pool, (uintmax_t)initial_size);
 }
 
 void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
 {
 	struct mp_block *block, *block_to_free;
 
+	trace_printf_key(&trace_mem_pool, "mem_pool (%p): discard (%"PRIuMAX") unused\n",
+		mem_pool, (uintmax_t)(mem_pool->mp_block->end - mem_pool->mp_block->next_free));
 	block = mem_pool->mp_block;
 	while (block)
 	{

base-commit: bb75be6cb916297f271c846f2f9caa3daaaec718
-- 
2.18.0.windows.1

