Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282A9C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF59D20780
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcMreo+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC3Abo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:31:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33424 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgC3Abo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 20:31:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so19345315wrd.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 17:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FQfXpkTVI6kPC3l2uN2S1GBJYi0tfK3nyp95t99f4tM=;
        b=gcMreo+oWBKBMC+eEXunALwViwHywA7Q9393bJRVbF+kgCmWbOksYwgU3Ph8PHWjPV
         nwUJGFzQzleodBlcJOYS+WQQvnNBaP55r+1i4igeorEneQ3SWiOAPr0QH2N4/bq4ZgPw
         TkEbB/7rxkGkw6zjSs2KFC1wreqmgdKqd/EbIYMukB/hUTxiGeJZqJ1HdUxWexyOGd8t
         V0jZbp9W8jfFZX3+3TgsswL6yghlN47njz9MovwEvJL9Kdv1VvDHMQXebO1wh212Nklf
         lhfrT4y3Z/qHpwmlRrFse6O+hei+N2R/RVvOxYbZoT4+ea4MycxIE3EfEy+dbZNAYB6E
         m5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FQfXpkTVI6kPC3l2uN2S1GBJYi0tfK3nyp95t99f4tM=;
        b=UOGUBvztqgK+DJ+K7ENQ0zBVrabVSiI1tCyAJZrd6iR2M0hSOWRSew8V31b1ibg2mw
         tP2tkdsCSR4ESPAd5kF46JxhANeSELEBqN1ZD66SMHtPsibridYJ/LcM9pQ4Ye+Ys/Wf
         NlwrAdTQHt9+v2zi3SYrtwvdfeq344vY4nBnJypUTMy6MOjP0fwkmiJYmtABhCwp9ZuA
         14JOBIhi4UPi7VGS1PGDNhd7MzEXUUqB2Jx0XehBQ1LnICETe+7dWEre/Tx6F9Tiv0dM
         w0saMH+tUoMLrDoiWXQZdUqgka9ShwxG22JA3tdboBbfB7sJKXxIu70hZtTy2EjEnNN/
         xqCw==
X-Gm-Message-State: ANhLgQ1MtzEZ2Rpe3B1MN+biNJE0hp/JqE/1F2knTjrmJhz8ogGSH/i2
        /iewT/9RZZqTqysE7W9zb8bxcl2W
X-Google-Smtp-Source: ADFU+vvdAKPvm3GVGrPLzPpdYmUVCOpB5g15cWYSreRwKk+a7JhxPdK7l/s/HUXAnq6+F9//qVOabg==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr11845625wre.257.1585528302105;
        Sun, 29 Mar 2020 17:31:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 195sm19021435wmb.8.2020.03.29.17.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 17:31:41 -0700 (PDT)
Message-Id: <c3ffd9820d50196793833d0faf35f9d5dd70ff6d.1585528298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
References: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Mar 2020 00:31:23 +0000
Subject: [PATCH v3 01/16] commit-graph: define and use MAX_NUM_CHUNKS
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

