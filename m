Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC5AE1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 20:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeLSUOM (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 15:14:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37701 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbeLSUOK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 15:14:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so9968740plr.4
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 12:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wWxyJ2KO0GxHUumOYVWM9UqgQYr4FM4pFsG0irmTBfM=;
        b=jPmSoM5VeLXYdVnBrNplg6JAd75blwvas4rh9LA7UZJRl+A80B42wq9gRpM/IL9c0X
         MZT06MmwYcLlbDIvUBpn6pTbIyL7iSPLkKazAhE6A5S10QM6bXzUOmtQgp7PcnX8avRl
         HSC2OxrAryZPnjPrgxHhH/oIjxwilH6oBPB2TjXA/48c7VO7F5h6wZAXllEvzonRxp2Y
         NhlzSaHGU3i/E3ZEtmjtTh7h6zaAGWe3c9FjdTpeAQxHukygaB70NT2wiVTnJ7jtSwU5
         m7Aerz3kDtqn0nvfbG4raZWEl4ogF+O/OLDWQrNy4jm+z2RpFkKX92H+Mm6ow+aa+nNI
         JIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wWxyJ2KO0GxHUumOYVWM9UqgQYr4FM4pFsG0irmTBfM=;
        b=jLBr3AMmqVPKzVNIKlH+D2Fg2M7cTfx25LbwQIrtBJBlQOy4vu7uL/aCBqiFNcbrYP
         0o1aINz/ipRwSa+WyQmADYtzlEZ0YRAlGnUm0QlfCa4TRH5nIeXC530KyKwvi6dlKKaq
         x3ALRYfgXyfSQPmc0MjePt/O6/eajhbrfQO1AI37UJhky5scoesPYdtQA9Ea1dIxV450
         9uFs/pFWlSp6VQb8UK5gcT3HMp9Hcju6ZZHM1JINP+ZAZ7PwNq1JgVvv12XIny+VgH3E
         Q1To2dr8Iur5ao2BdvTu5Gb7w0zpMSyrgB9q7pDrE0E42fXSDn86DB8cjn7+NhRSAIER
         RVbg==
X-Gm-Message-State: AA+aEWYbe8EbqH4hBuH2ihJ9QfR4YQLStoTvlHUJ1ntymKxBjulPifrB
        oCHBdGvkXAWSRwsWf6C01YtLmr2C
X-Google-Smtp-Source: AFSGD/XkSY+2nuyRzZj9y4higqTih98ZTQdFypL+fxTc0FP6h5cMaxNazjgz4hbaxUxPTVQeimKSFQ==
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr22116077pll.265.1545250448193;
        Wed, 19 Dec 2018 12:14:08 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id o8sm37121866pfa.42.2018.12.19.12.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 12:14:07 -0800 (PST)
Date:   Wed, 19 Dec 2018 12:14:07 -0800 (PST)
X-Google-Original-Date: Wed, 19 Dec 2018 20:14:02 GMT
Message-Id: <907a24d2c45acec17607971b577782798c4adcbc.1545250444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.102.git.gitgitgadget@gmail.com>
References: <pull.102.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] commit-graph: writing missing parents is a BUG
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When writing a commit-graph, we write GRAPH_MISSING_PARENT if the
parent's object id does not appear in the list of commits to be
written into the commit-graph. This was done as the initial design
allowed commits to have missing parents, but the final version
requires the commit-graph to be closed under reachability. Thus,
this GRAPH_MISSING_PARENT value should never be written.

However, there are reasons why it could be written! These range
from a bug in the reachable-closure code to a memory error causing
the binary search into the list of object ids to fail. In either
case, we should fail fast and avoid writing the commit-graph file
with bad data.

Remove the GRAPH_MISSING_PARENT constant in favor of the constant
GRAPH_EDGE_LAST_MASK, which has the same value.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..c14ada6918 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -34,7 +34,6 @@
 #define GRAPH_OID_LEN GRAPH_OID_LEN_SHA1
 
 #define GRAPH_OCTOPUS_EDGES_NEEDED 0x80000000
-#define GRAPH_PARENT_MISSING 0x7fffffff
 #define GRAPH_EDGE_LAST_MASK 0x7fffffff
 #define GRAPH_PARENT_NONE 0x70000000
 
@@ -496,7 +495,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 					      commit_to_sha1);
 
 			if (edge_value < 0)
-				edge_value = GRAPH_PARENT_MISSING;
+				BUG("missing parent %s for commit %s",
+				    oid_to_hex(&parent->item->object.oid),
+				    oid_to_hex(&(*list)->object.oid));
 		}
 
 		hashwrite_be32(f, edge_value);
@@ -514,7 +515,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 					      nr_commits,
 					      commit_to_sha1);
 			if (edge_value < 0)
-				edge_value = GRAPH_PARENT_MISSING;
+				BUG("missing parent %s for commit %s",
+				    oid_to_hex(&parent->item->object.oid),
+				    oid_to_hex(&(*list)->object.oid));
 		}
 
 		hashwrite_be32(f, edge_value);
@@ -567,7 +570,9 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
 						  commit_to_sha1);
 
 			if (edge_value < 0)
-				edge_value = GRAPH_PARENT_MISSING;
+				BUG("missing parent %s for commit %s",
+				    oid_to_hex(&parent->item->object.oid),
+				    oid_to_hex(&(*list)->object.oid));
 			else if (!parent->next)
 				edge_value |= GRAPH_LAST_EDGE;
 
@@ -864,7 +869,7 @@ void write_commit_graph(const char *obj_dir,
 			count_distinct++;
 	}
 
-	if (count_distinct >= GRAPH_PARENT_MISSING)
+	if (count_distinct >= GRAPH_EDGE_LAST_MASK)
 		die(_("the commit graph format cannot write %d commits"), count_distinct);
 
 	commits.nr = 0;
@@ -891,7 +896,7 @@ void write_commit_graph(const char *obj_dir,
 	}
 	num_chunks = num_extra_edges ? 4 : 3;
 
-	if (commits.nr >= GRAPH_PARENT_MISSING)
+	if (commits.nr >= GRAPH_EDGE_LAST_MASK)
 		die(_("too many commits to write graph"));
 
 	compute_generation_numbers(&commits, report_progress);
-- 
gitgitgadget
