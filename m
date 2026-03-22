Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6C36A023
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774211895; cv=none; b=pVt+e0EVdRedagyD2KZ6U79vZhzWNtCuK2DiBH1CSshPGuToBY2CqoEYM/WyuGo6TlPy4yr+kQweB7Uh8LgoJUB7mVRuOSTSMInJQhS2Rw//KlFP0ceDIy/MeFw5VEjsCGgdDXi2ZmI8EzJI3/WZVvMh80jBLAuXYhxGcoAN4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774211895; c=relaxed/simple;
	bh=35STGNZzNVz/XilWaCfRS4SNiQuy88r+oFcxw64rPM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kykXZNLxS13KrxKR8+QzbykA//7fKQkmh3xXoGrPh+zpKXcIhlcEh4M0RQw5FagtKiBL0rlUFEpdVUPMvCKU64moXQaBBfUtLAtU33i7ozohtLUPAUyyRJm1F4UdSv2KXJORKbKeEAL93MbNvvZUdQ26QfdSNxlhDjEXZUCryU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5GttCOr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5GttCOr"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4327790c4e9so2457216f8f.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774211892; x=1774816692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8fXK599uNtxIEr4Q+8oEEqUivccPxBVYLy1SE3DJiM=;
        b=S5GttCOr3lzlS/7GYEGrW5PBboFylU52+v/clAufovMp/XY6KMxT4WIKvbti7NHQ6y
         t7hEjEVY+sEcOmqkx01eHt0TEWrTZ04MyderstVCIyF20FTLK/5BWYxCzTYqr6qZRQim
         8dXSXVpjGIdbtjIeoHiuMGHYljebvBc09zcy8amF3JzzNq0TDN2aJviEDt7u0dtwikIX
         TGb+GHoo5Z8ZcVkb91RCUk2Xtvx25JHZpOvLV3r1IVH+wjaayMJTPOY5xUolDi/dixfT
         hnl+f2dtqBzQM2Yzs06Yz1MAWAvORKdPxB0ytYNmnsSh8Y89kqMMHNiLIs7bCsoBqWgm
         Y81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774211892; x=1774816692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w8fXK599uNtxIEr4Q+8oEEqUivccPxBVYLy1SE3DJiM=;
        b=BZ2xIlk6V2z4TM/2D2xP+VxU9ber4s/B9AcLRLEn+jY2KXmXRX2ZCR/4EfeDmP6s3E
         Z72OO94u/x+ML/mCwaNmoH1bYjFxpCSjEdY6cAnAmi/bnvqvkIYBaRPde3XbVbUEiJdq
         pv03xQSAUY/qeIXPWAs+6azGQMUAFAUAsrDV5kQZIcYayxIefz9EsxcbzKw2znsemtMY
         ugnoJTVdG4y7tDCvPdKKw9U3qdvcgew8WX+TPa8XWEBDqmsTTOVrWDhBQf0RCRSiBj3q
         qlT5Y1QKQ6LLhfZb/bpYJJOUpVfqlO/n4X8FE3Bx3rNb0n9+BB6Fw9ayoIKmg6Kvp4Gn
         Y6wA==
X-Gm-Message-State: AOJu0Yw6iNWDNrdZl0qYsEBvpG9ZH2ayAAb1oXxoLoQNtl1yy39qesZ4
	QJfw5VP7TMAa4guKQAp1a+Iya7oo7QDbRqfxm46soD5UUrqRp27MUhv/8jgu++99tzvbaA==
X-Gm-Gg: ATEYQzyb4eNT9Q9oY29rCc400OVO2v3VT+/Ncp+qKIhiy38hsnpZtryFYW98hvB4aZT
	EcyF9z1c5XpvQ+/hHlJFVN4RCTbS8I97qOp7hE/r0oD1Y5aNrMKDCLuvWgH4MRM4DuPLeFmhB/j
	rOWUVyxxt2VMKd/vp75cu94QLGae0dHf3lKrVpD3RHv0fmBf0r7d0GnrEp8R1gwJEpt3TqGUSqt
	OaW62pH7IyTmJ21MZbf7LlfFMWOjGm8+5wzsixXCREWWMEA0dymiGyiazPAf60vgJpDKoQGHTT7
	qYTzSn/uE4svxyIRRqqcAqW/S3FHrXGtBnh6RlNcWtZFuhGehSSJnmNWVnIRk1M0RytOtpZNtwp
	Cv5C/E4UGtjgXwSB+dylHRYUUAB4vzjD/H4zJLvz6yfKu7KJPmMK0iB4K781MUy55xKH6UFAkT+
	gypgxjRmMzbSxGUQlrseB7pZh5NAxSc9mD47gxXLB3ZrH1csxzA5lIi5ftfOkbBUgUTP6kaWL1f
	aJVYjqpp7BxWpImv83Ywt/mnNrnNrfn5M7fyUlZqBTEk7VchbwaewfFukiR4wdaxA01iQ==
X-Received: by 2002:a05:600c:528e:b0:485:3fc8:de9c with SMTP id 5b1f17b1804b1-486fedb2ef0mr132813145e9.12.1774211891517;
        Sun, 22 Mar 2026 13:38:11 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm23569157f8f.20.2026.03.22.13.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 13:38:11 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	j6t@kdbg.org,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH WIP RFC v3 2/3] graph: truncate graph visual output
Date: Sun, 22 Mar 2026 21:38:00 +0100
Message-ID: <20260322203801.637769-2-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322203801.637769-1-pabloosabaterr@gmail.com>
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260322203801.637769-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach graph statuses to stop rendering and add the truncation mark
'.' once they are writing over the lane limit, following
graph_needs_truncation().

Teach graph_output_commit_line to skip the POST_MERGE status when
neither the commit nor the parent is on a visible lane but keep it
when either commit or parent lives in a visible lane.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 17 deletions(-)

diff --git a/graph.c b/graph.c
index a95c0a9a73..ab0a008af5 100644
--- a/graph.c
+++ b/graph.c
@@ -702,6 +702,20 @@ static void graph_update_columns(struct git_graph *graph)
 		}
 	}
 
+	/*
+	 * If graph_max_lanes is set, cap the padding from the branches
+	 */
+	if (graph->revs->graph_max_lanes > 0) {
+		/*
+		 * Get the maximum width by multiplying the maximum number of
+		 * lanes by the size of the lane "| " and adds the truncation
+		 * mark ". "
+		 */
+		int max_columns_width = graph->revs->graph_max_lanes * 2 + 2;
+		if (graph->width > max_columns_width)
+			graph->width = max_columns_width;
+	}
+
 	/*
 	 * Shrink mapping_size to be the minimum necessary
 	 */
@@ -852,6 +866,10 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
+		if (graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, ". ");
+			break;
+		}
 		graph_line_write_column(line, &graph->new_columns[i], '|');
 		graph_line_addch(line, ' ');
 	}
@@ -909,6 +927,9 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			seen_this = 1;
 			graph_line_write_column(line, col, '|');
 			graph_line_addchars(line, ' ', graph->expansion_row);
+		} else if (seen_this && graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, ". ");
+			break;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -1019,6 +1040,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 	 * children that we have already processed.)
 	 */
 	seen_this = 0;
+
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
@@ -1034,8 +1056,17 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 			seen_this = 1;
 			graph_output_commit_char(graph, line);
 
+			if (graph_needs_truncation(graph, i)) {
+				graph_line_addch(line, ' ');
+				break;
+			}
+
 			if (graph->num_parents > 2)
 				graph_draw_octopus_merge(graph, line);
+		} else if (graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, ". ");
+			seen_this = 1;
+			break;
 		} else if (seen_this && (graph->edges_added > 1)) {
 			graph_line_write_column(line, col, '\\');
 		} else if (seen_this && (graph->edges_added == 1)) {
@@ -1071,10 +1102,32 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 
 	/*
 	 * Update graph->state
-	 */
-	if (graph->num_parents > 1)
-		graph_update_state(graph, GRAPH_POST_MERGE);
-	else if (graph_is_mapping_correct(graph))
+	 *
+	 * If the commit is a merge and the first parent is in a visible lane,
+	 * then the GRAPH_POST_MERGE is needed to draw the merge lane.
+	 * 
+	 * If the commit is over the truncation limit, but the first parent is on
+	 * a visible lane, then we still need the merge lane but truncated.
+	 * 
+	 * If both commit and first parent are over the truncation limit, then
+	 * there's no need to draw the merge lane because it would work as a
+	 * padding lane.
+	 */
+	if (graph->num_parents > 1) {
+		if (!graph_needs_truncation(graph, graph->commit_index)) {
+			graph_update_state(graph, GRAPH_POST_MERGE);
+		} else {
+			struct commit_list *first_parent = first_interesting_parent(graph);
+			int first_parent_col = graph_find_new_column_by_commit(graph, first_parent->item);
+			
+			if (!graph_needs_truncation(graph, first_parent_col))
+				graph_update_state(graph, GRAPH_POST_MERGE);
+			else if (graph_is_mapping_correct(graph))
+				graph_update_state(graph, GRAPH_PADDING);
+			else
+				graph_update_state(graph, GRAPH_COLLAPSING);
+		}
+	} else if (graph_is_mapping_correct(graph))
 		graph_update_state(graph, GRAPH_PADDING);
 	else
 		graph_update_state(graph, GRAPH_COLLAPSING);
@@ -1115,14 +1168,28 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			int par_column;
 			int idx = graph->merge_layout;
 			char c;
+			int truncated = 0;
 			seen_this = 1;
 
 			for (j = 0; j < graph->num_parents; j++) {
+				unsigned int truncation_max = i + (j > 1 ? j - 1 : 0);
 				par_column = graph_find_new_column_by_commit(graph, parents->item);
 				assert(par_column >= 0);
 
 				c = merge_chars[idx];
 				graph_line_write_column(line, &graph->new_columns[par_column], c);
+
+				if (j >= 2)
+					truncation_max -= 1;
+
+				if (graph_needs_truncation(graph, truncation_max)) {
+					if (j > 0 && !(graph->edges_added > 0))
+						graph_line_addch(line, ' ');
+					graph_line_addstr(line, ". ");
+					truncated = 1;
+					break;
+				}
+
 				if (idx == 2) {
 					if (graph->edges_added > 0 || j < graph->num_parents - 1)
 						graph_line_addch(line, ' ');
@@ -1131,15 +1198,24 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 				}
 				parents = next_interesting_parent(graph, parents);
 			}
+			if (truncated)
+				break;
 			if (graph->edges_added == 0)
 				graph_line_addch(line, ' ');
-
+		} else if (graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, ". ");
+			break;
 		} else if (seen_this) {
 			if (graph->edges_added > 0)
 				graph_line_write_column(line, col, '\\');
 			else
 				graph_line_write_column(line, col, '|');
-			graph_line_addch(line, ' ');
+			/*
+			 * If it's between two lanes and next would be truncated,
+			 * don't add space padding.
+			 */
+			if (!graph_needs_truncation(graph, i + 1)) 
+				graph_line_addch(line, ' ');
 		} else {
 			graph_line_write_column(line, col, '|');
 			if (graph->merge_layout != 0 || i != graph->commit_index - 1) {
@@ -1170,6 +1246,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	short used_horizontal = 0;
 	int horizontal_edge = -1;
 	int horizontal_edge_target = -1;
+	int truncated = 0;
 
 	/*
 	 * Swap the mapping and old_mapping arrays
@@ -1285,12 +1362,20 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	 */
 	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->mapping[i];
-		if (target < 0)
-			graph_line_addch(line, ' ');
-		else if (target * 2 == i)
-			graph_line_write_column(line, &graph->new_columns[target], '|');
-		else if (target == horizontal_edge_target &&
-			 i != horizontal_edge - 1) {
+
+		if (!truncated && graph_needs_truncation(graph, i / 2)) {
+			graph_line_addstr(line, ". ");
+			truncated = 1;
+		}
+
+		if (target < 0) {
+			if (!truncated)
+				graph_line_addch(line, ' ');
+		} else if (target * 2 == i) {
+			if (!truncated)
+				graph_line_write_column(line, &graph->new_columns[target], '|');
+		} else if (target == horizontal_edge_target &&
+			   i != horizontal_edge - 1) {
 				/*
 				 * Set the mappings for all but the
 				 * first segment to -1 so that they
@@ -1298,13 +1383,14 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 				 */
 				if (i != (target * 2)+3)
 					graph->mapping[i] = -1;
-				used_horizontal = 1;
-			graph_line_write_column(line, &graph->new_columns[target], '_');
+			used_horizontal = 1;
+			if (!truncated)
+				graph_line_write_column(line, &graph->new_columns[target], '_');
 		} else {
 			if (used_horizontal && i < horizontal_edge)
 				graph->mapping[i] = -1;
-			graph_line_write_column(line, &graph->new_columns[target], '/');
-
+			if (!truncated)
+				graph_line_write_column(line, &graph->new_columns[target], '/');
 		}
 	}
 
@@ -1353,7 +1439,6 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 		graph_output_collapsing_line(graph, &line);
 		break;
 	}
-
 	graph_pad_horizontally(graph, &line);
 	return shown_commit_line;
 }
@@ -1378,6 +1463,11 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 
+		if (graph_needs_truncation(graph, i)) {
+			graph_line_addch(&line, '.');
+			break;
+		}
+
 		graph_line_write_column(&line, col, '|');
 
 		if (col->commit == graph->commit && graph->num_parents > 2) {
-- 
2.43.0

