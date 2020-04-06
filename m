Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D50C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD12320780
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tS9F81Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgDFRAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33340 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgDFRAA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id z65so420402ede.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FQfXpkTVI6kPC3l2uN2S1GBJYi0tfK3nyp95t99f4tM=;
        b=tS9F81MzUFnPOi1P2Dz+MrEygk36YoBE7VJCvwd1YP39xmFRwdI9pk3tj9TlowCZmD
         B90k/FMFIt/H0VY8Az8bxT8KqXR6GONNVxlL4Pn/HZRBeoPvKT92+S5XO1E1fifAV1Ky
         SGlqOOHesC7RQAeeXI9HTh6nHdqo4o+r1EdwMk0MPcl1ianHBpk9PQHgKe3jRIty+4Q1
         0aGvbl15tJQomImtDorPcWUxLGYLmeDqx0EuQ3OPpKSNV1gw7CECWGJt3ZEhzoeJ+1KB
         CforvqjY3B+TzLx7E6eHMyLdVVMwtt4z3AdBn+Ft/0bl1KA3f61WUz3le7Gfevk+5YXD
         YRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FQfXpkTVI6kPC3l2uN2S1GBJYi0tfK3nyp95t99f4tM=;
        b=o4WKefCTo/u7cQ+OasK8wREqVAA6mEVbFlfqCw8FWThjoe2PepcYzLIYY8AS2wTWnQ
         TYyg8Pe2JCJXEJorWdaYxwztjJ6X7VlLgFwabqlYMEcc5MI3UdxFYuCw7pP5viLrKNLP
         Xxbqlb1+obb4KVtd5whbaYz2msGXZVysfT73/8Y1ZuRKPeQEWVS2mi/A88LuP/Kqowgs
         yaZB6y59nxBrxC7+1qgYKUHMwRog32RSq8dTNuavRCkfzhHvduPVYQtjoNoPdTqdwaad
         nIIA5/Dy7Q1fsUFCJtwK3BLLKrzRMH9nD2iPPUwa3/QajOUFUOboMSuKKYUor6ZdSOhW
         NeDA==
X-Gm-Message-State: AGi0Puai4ECxl6nr19+nViZzOBoJZaxY/+ssN7bU3kdqoETvUQycYBiQ
        PUjSIUTSTf6d8zifdFUGM4JpbzGk
X-Google-Smtp-Source: APiQypJXmWHpXjqfPYEWmFm9V8vWs18PbrwgVRq8M8lmG7EdhttG13aYm4Yy4Um0+tBMHfeE710+/A==
X-Received: by 2002:a05:6402:44e:: with SMTP id p14mr20507181edw.356.1586192397437;
        Mon, 06 Apr 2020 09:59:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm3007564ejt.1.2020.04.06.09.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:59:57 -0700 (PDT)
Message-Id: <c3ffd9820d50196793833d0faf35f9d5dd70ff6d.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:41 +0000
Subject: [PATCH v4 01/15] commit-graph: define and use MAX_NUM_CHUNKS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

This is a minor cleanup to make it easier to change
the number of chunks being written to the commit
graph.

Reviewed-by: Jakub Narębski <jnareb@gmail.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 commit-graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f013a84e294..e4f1a5b2f1a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -23,6 +23,7 @@
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
+#define MAX_NUM_CHUNKS 5
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -1350,8 +1351,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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

