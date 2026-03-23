Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9D3815D6
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303189; cv=none; b=td/FQexHa3neiHgxJwDnagX28VzhaWJ+2ReorIADpEgbIb/T4eXHpxg5PfgYhGmyHoA8jVJoelRp1yLBBEE2w+A+1qPNZD5D5gOHIoturNyqTxeBd4Vg30CYdRXFHLOMfW+CQRb4uBj8/1+UopfDV85X0rraTYuWDB4k+i/g1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303189; c=relaxed/simple;
	bh=K6nYz9Ms9YDaCA6/wqqJxrAYTOz8BzQ29tGRvF/TVjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmhG6dSl9Kzw9gYSwGZ3aPNYgzmDagdNAVRxYnB9MO/otOvcTRR+snyedNjCh0So6JEkdE9PGbkR26TCpWCth5fu0bN9Erv9NYH3/EpbRCJ8iwKVO7D2cMTGGdWJrfU85S1P73YL0xkwoHlvji5J44Dp/Q9poHTBtgcL4IPj1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8s4W30s; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8s4W30s"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso38578265e9.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774303184; x=1774907984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUEuNpc10xSyoN2WSk8y2TDbhIyqhpO+YFmitHR+/Gs=;
        b=k8s4W30sXE3o/RfERE3YotuMrI86rxGsd36vTHrg3142i4QzFE4huj2WkT0iwfy48g
         6ZvehncTin6gr/BoCZvVsTN42NriitB+NRPSf+IPA2f1a7ixC2iR90G4v+AVz6Q6rGFa
         EK2kpU2iRq/mEdQEYg8ZuDBSWoYoppw77fvyUVmEtJHu/UvWVkr3vOE/8XnoQTvBrTHC
         3qR9r9N/rR8h46HyzIJ6K7v2FIPyVgkWKx1usaVzkZD5fWEhGBg3mK11FsmVc77+10Vx
         XURfPwKBZEdXhVYuphWIIs2l4VYjKfeWgXR4nDXQrzqB0lE9Cr1X4SEA0eL0bi2Kbavk
         QGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303184; x=1774907984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUEuNpc10xSyoN2WSk8y2TDbhIyqhpO+YFmitHR+/Gs=;
        b=lWUdznx/GB1eG1rs54NstMUnhVcE6r1qF1OuCU6GfZWVAkSMlRL+MAA6nG5xKcb9dQ
         tEa/S8ErNJ91jx7DrCGd8Sm0SQzyZVuJJquLzGsVRyjISSISLV7kipIN9jEPplwSpNb9
         2ApshY2cygIpKaC1J2Mf4+uZ/QepvF49gbknpx9vBaZzSmF31FloTg5YDpQFnrO2rPcA
         WKchM50Fn18lDh64+2xTBE8Ff7XiC++QgcHoreBZy3lEWHLN+so8DQGyUpbX/LwB+f6y
         qAY33wz76GV1PIP/+8OlOUB9E8OzXuNzX2ejdGKvFyr2radFHsVieIVk2z7qhuzcpCMX
         8YZQ==
X-Gm-Message-State: AOJu0YzF2y1ySLsbi44LTUUm1FbWuBYLMeKEMS81gkl7P84B6mDSnsBK
	GOX+Hn5KFLC5TR/u1x+H4Lx1HkPUy/FfB6qEPcr70a+BNoMfXoU5BZ7g6CRHSnCQvheh4w==
X-Gm-Gg: ATEYQzzTksRPJwQX3gkbZZQi31v+rX8NOELE3WFNRYAlilis0ozKwYPYh5xj3NT97nU
	UKEjk8M3YV4Neu35Y/LEpgVtSq7A6K/TYW/WvojztqQmiSjyqhnZTsd7b0mEfzS2cPY3qD/pSnI
	AXDa/ey0JtH+4wtvjTEVmgqPY0TVBeAppMqGdpSO1QgusJ6truGbQEPdboB1py95cTjxWFpsA7D
	fSFIZ1sKTFvihRA4/S/UxsISg6pheUESb2pCDMUHclj/zPyTbBsQR0ynawjOL+0en5dLvw8XR6L
	sHHjeB7OBZ96gH65wnTie3aHyDJa1WlCML6iox+WW81Kod842LQtVEpBFdwGZBFZXFnSrfROqru
	updC6AiypEClcXagx2NkLBXJjcwW931BgdxcNuiGs57Tb5QzYgH+jEfEoz4wLZwy3QZOe97RK9I
	Y0o9u+cFEFrNQPGho6NDq8NQdvlsOabusnIvWk45AvLSES9Iz8JUTLHwCfN9GAiIuiMJTNudDQe
	q3aHvFIuaOSWMqosEuKqT5h7wMQUMlzwFxxNMeAOdwUBrfHfXn4VGfuVdc=
X-Received: by 2002:a05:600c:3b23:b0:486:fdc6:1c0d with SMTP id 5b1f17b1804b1-486ff02da9emr203641855e9.22.1774303183512;
        Mon, 23 Mar 2026 14:59:43 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711693a08sm2734015e9.2.2026.03.23.14.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:59:43 -0700 (PDT)
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
Subject: [GSoC PATCH v4 2/3] graph: truncate graph visual output
Date: Mon, 23 Mar 2026 22:59:34 +0100
Message-ID: <20260323215935.74486-3-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323215935.74486-1-pabloosabaterr@gmail.com>
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When '--graph-lane-limit' is set, lanes over the limit should
not be drawn. Teach each graph state to stop rendering at the
lane limit and print a '.' truncation mark, so users know that
there are hidden lanes.

On the commit line, if the commit lives on a visible lane, show
the normal commit mark and truncate after it, if the commit lives
on the first hidden lane (the truncation mark lane) show the "*"
instead of the truncation mark so it is known that this commit sits
on the first hidden lane. Commits on deeper lanes don't leave
a mark.

For merges, the post-merge lane is only needed when the commit or
the first parent lives on a visible lane (to draw the connection
between them), when both are on hidden lanes, post-merge carries no
useful information, skip it and go to collapsing or padding state.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 106 insertions(+), 16 deletions(-)

diff --git a/graph.c b/graph.c
index e7c1151ac0..886ef7cede 100644
--- a/graph.c
+++ b/graph.c
@@ -705,6 +705,20 @@ static void graph_update_columns(struct git_graph *graph)
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
@@ -855,6 +869,10 @@ static void graph_output_padding_line(struct git_graph *graph,
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
@@ -912,6 +930,9 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			seen_this = 1;
 			graph_line_write_column(line, col, '|');
 			graph_line_addchars(line, ' ', graph->expansion_row);
+		} else if (seen_this && graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, ". ");
+			break;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -1022,6 +1043,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 	 * children that we have already processed.)
 	 */
 	seen_this = 0;
+
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
@@ -1037,8 +1059,17 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
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
@@ -1074,10 +1105,32 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 
 	/*
 	 * Update graph->state
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
 	 */
-	if (graph->num_parents > 1)
-		graph_update_state(graph, GRAPH_POST_MERGE);
-	else if (graph_is_mapping_correct(graph))
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
@@ -1118,14 +1171,28 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
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
@@ -1134,15 +1201,24 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
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
@@ -1173,6 +1249,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	short used_horizontal = 0;
 	int horizontal_edge = -1;
 	int horizontal_edge_target = -1;
+	int truncated = 0;
 
 	/*
 	 * Swap the mapping and old_mapping arrays
@@ -1288,12 +1365,20 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
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
@@ -1301,13 +1386,14 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
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
 
@@ -1356,7 +1442,6 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 		graph_output_collapsing_line(graph, &line);
 		break;
 	}
-
 	graph_pad_horizontally(graph, &line);
 	return shown_commit_line;
 }
@@ -1381,6 +1466,11 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
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

