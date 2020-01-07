Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283F6C33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31152187F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIH+gUwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgAGOzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:55:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40209 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgAGOzv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 09:55:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so54268625wrn.7
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 06:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TX2WULO/FthESnbKKi18uQqpxW5DI+unYHoQPoi9E3I=;
        b=LIH+gUwC11nRXxgM6R7c1owUHGz9b1u+jMXxkT1U/8cF7rwfUFn3gyWYywYtzRAcKU
         fkvwmq7af6mnyQ3XOVEkjiNhsZFww1tNaECtYMO+blQjCSX2u1LsSmOPnPiOaBYII8rR
         Wy9xoaqFAp5rCrhYAu7et92rATBZbJIMByg81p79ludjvf96OWCEp6SupSnBBuO7+ALR
         QBQjIqEACmVYyWs8VAkVWwBmQSLzcClprTQ5SQ8frQ36HMntM6EuxhkuRXzQDSH0bSNB
         QXCAGcpmWB/i7P4TuhoKzdhGEfUVZKh02vFPzqnqNjVQwMNHzh7tksiDLh11BIyWnnvo
         P6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TX2WULO/FthESnbKKi18uQqpxW5DI+unYHoQPoi9E3I=;
        b=lshq20di0Pt2P6tBWCPA4F8FGcyYOptl8cm5BFwr/AXKCJSiDFycDJ33IIelZsvLlJ
         bq58F4nx5WKY4oC3kIXTm1/pDwwx0w/NCkmTb4Q6UuZMWIpvlynGiC8362uvUzgdWnr/
         rHQIyfvkrO1F2Rkj1ZwTbk88v5obhD/frEzuQ8bE8wNNRH+M4uuqeYlxBRTBH76jr/1J
         oGJXt0GAH7UVIL1nhYf9mElytm6UYrQNBqjgPPFTttTSNJFmrE4s7LavEjRJ4ozVcw7N
         KzEpxHucOjpU/g+HG+cacELFzp3thjCH73OtOEbLSb7H9hi8/JsJiZnjH+D3o9GXTZKe
         EdHQ==
X-Gm-Message-State: APjAAAU1H+uFF5hv4abCGy9C/uKLMw/vl5bVZzbaQYaTeH6ghMXDTTwF
        51DfmDcW+twSM7G8LPhnnm0c00ac
X-Google-Smtp-Source: APXvYqx1Ce07Rqksi3vJTqyzENenkPUHNvV+sfPJni+AOXJ673Ck8boaYBrfPxW+sRGQG4FJ4mJfUw==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5mr109204625wrw.271.1578408949635;
        Tue, 07 Jan 2020 06:55:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm26837894wmg.46.2020.01.07.06.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:55:49 -0800 (PST)
Message-Id: <5dd305d2f0de43a70b46336c8f1a62437e0511e1.1578408947.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.517.git.1578408947.gitgitgadget@gmail.com>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 14:55:46 +0000
Subject: [PATCH 2/3] graph: replace assert() with graph_assert() macro
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, brad@brad-smith.co.uk, sunshine@sunshineco.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The assert() macro is sometimes compiled out. Instead, switch these into
BUG() statements using our own custom macro.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 graph.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/graph.c b/graph.c
index aaf97069bd..ac78bdf96c 100644
--- a/graph.c
+++ b/graph.c
@@ -6,6 +6,8 @@
 #include "revision.h"
 #include "argv-array.h"
 
+#define graph_assert(exp) if (!(exp)) { BUG("assert failed: "#exp""); }
+
 /* Internal API */
 
 /*
@@ -316,7 +318,7 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 	struct git_graph *graph = data;
 	static struct strbuf msgbuf = STRBUF_INIT;
 
-	assert(opt);
+	graph_assert(opt);
 
 	strbuf_reset(&msgbuf);
 	if (opt->line_prefix)
@@ -865,13 +867,13 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 *
 	 * We need 2 extra rows for every parent over 2.
 	 */
-	assert(graph->num_parents >= 3);
+	graph_assert(graph->num_parents >= 3);
 
 	/*
 	 * graph->expansion_row tracks the current expansion row we are on.
 	 * It should be in the range [0, num_expansion_rows - 1]
 	 */
-	assert(0 <= graph->expansion_row &&
+	graph_assert(0 <= graph->expansion_row &&
 	       graph->expansion_row < graph_num_expansion_rows(graph));
 
 	/*
@@ -923,13 +925,13 @@ static void graph_output_commit_char(struct git_graph *graph, struct graph_line
 	 * (We should only see boundary commits when revs->boundary is set.)
 	 */
 	if (graph->commit->object.flags & BOUNDARY) {
-		assert(graph->revs->boundary);
+		graph_assert(graph->revs->boundary);
 		graph_line_addch(line, 'o');
 		return;
 	}
 
 	/*
-	 * get_revision_mark() handles all other cases without assert()
+	 * get_revision_mark() handles all other cases without graph_assert()
 	 */
 	graph_line_addstr(line, get_revision_mark(graph->revs, graph->commit));
 }
@@ -1094,7 +1096,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 
 			for (j = 0; j < graph->num_parents; j++) {
 				par_column = graph_find_new_column_by_commit(graph, parents->item);
-				assert(par_column >= 0);
+				graph_assert(par_column >= 0);
 
 				c = merge_chars[idx];
 				graph_line_write_column(line, &graph->new_columns[par_column], c);
@@ -1172,14 +1174,14 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 		 * the graph much more legible, since whenever branches
 		 * cross, only one is moving directions.
 		 */
-		assert(target * 2 <= i);
+		graph_assert(target * 2 <= i);
 
 		if (target * 2 == i) {
 			/*
 			 * This column is already in the
 			 * correct place
 			 */
-			assert(graph->mapping[i] == -1);
+			graph_assert(graph->mapping[i] == -1);
 			graph->mapping[i] = target;
 		} else if (graph->mapping[i - 1] < 0) {
 			/*
@@ -1225,8 +1227,8 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 			 * The space just to the left of this
 			 * branch should always be empty.
 			 */
-			assert(graph->mapping[i - 1] > target);
-			assert(graph->mapping[i - 2] < 0);
+			graph_assert(graph->mapping[i - 1] > target);
+			graph_assert(graph->mapping[i - 2] < 0);
 			graph->mapping[i - 2] = target;
 			/*
 			 * Mark this branch as the horizontal edge to
-- 
gitgitgadget

