Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF990C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D78F214AF
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kboFgiTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBEW4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56081 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBEW4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so4239557wmj.5
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7l79wEiwfoWct700d50KuG7l0EXouz0EU/AMQ3FG8pE=;
        b=kboFgiTpmRgjgLn5DZwXxeL0elMVwGKmq2NsIjX3PFtFr0ClIPKqVIvfu6PH71MeXk
         QJVkutl5BK/U/9T65zOJmog8jrFtlX4MH8HjkwHUotwTPe5WfIkIsy4g4WVzhCLUkmfu
         MVSU8sKb+RCiqpbHIPIhZa9utJOqyv0/7hDn8JSHA5K7zXJt4DfJpHj8RTaT2hynptQo
         fYsSX1SOV8cdMpWi8KPOzi8py7JQlFYr+jX9NPWkutDR4xWnm+SRQXcGXFGMQwjoRg7O
         RqFM7dxugDj1wY0QaznixPZeX2cGlcOYLj6TvyRQLPpMw7QfUIDNn7UlW3r0TCCW1R95
         k5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7l79wEiwfoWct700d50KuG7l0EXouz0EU/AMQ3FG8pE=;
        b=JHW+CbtYpJoHGCI11jYpS1AQWEcPPRd2TvaEB9fbaY2NIw9Tt7w7Qk2X8AU8QMeWqR
         Z+kmX0BNhVgeKQi0mcEFV/19CQz8+OyRcYnyVd9GoktwH9rvylhlz4IcNHE9QBTIKOlO
         Non41tZfi0TBjAD9N6rMtStsXBrOiJCoXEIY2dabSK9UfG4QOIJzN7+/AfcfdkLm/EUf
         yMVSjKm/1hF5UbQYW6PVHanswW0HNzF+HZyou88lY1WUlQc6iCnXUFqGUr6eh2LVRLSA
         hTrVZRjJokk88tc2sZES72Izn5JKfHJ/jIYe5nesLF9zh8sf8cpJ4AeYkF5nYugCVpmZ
         Ox/w==
X-Gm-Message-State: APjAAAXvieJwURh1FnTEyXAX682hkmuqpujtTEe9wdy2fJ5rVCOm1kGg
        q6cY4TEkFPmWwqKIvFXvlmTWsNU/
X-Google-Smtp-Source: APXvYqxhK1qBAAgnS1qTuEzhYGw8iGuVGox5BHwAzon9Nvdh0Osh0pVsKYc/YJyDUzza1rygtaN4HA==
X-Received: by 2002:a1c:7dd4:: with SMTP id y203mr8250726wmc.67.1580943392541;
        Wed, 05 Feb 2020 14:56:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5sm1622904wrv.86.2020.02.05.14.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:32 -0800 (PST)
Message-Id: <bf6b93878af5be81148614087aee6b4435ef0396.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:20 +0000
Subject: [PATCH v2 01/11] commit-graph: use MAX_NUM_CHUNKS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        garimasigit@gmail.com, jnareb@gmail.com,
        christian.couder@gmail.com, emilyshaffer@gmail.com,
        gitster@pobox.com, Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

This is a minor cleanup to make it easier to change the
number of chunks being written to the commit-graph in the future.

Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 commit-graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b205e65ed1..3c4d411326 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -23,6 +23,7 @@
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
+#define MAX_NUM_CHUNKS 5
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -1356,8 +1357,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	int fd;
 	struct hashfile *f;
 	struct lock_file lk = LOCK_INIT;
-	uint32_t chunk_ids[6];
-	uint64_t chunk_offsets[6];
+	uint32_t chunk_ids[MAX_NUM_CHUNKS + 1];
+	uint64_t chunk_offsets[MAX_NUM_CHUNKS + 1];
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
-- 
gitgitgadget

