Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7D40DFD9
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774656684; cv=none; b=q+8/dMCI1vX6mcDb7OJaffbLq5EKFBz3y9nkbwU2SFIsBmSOkFHtoCr8RjS6QJRMncrc8Q261zGpRn27+4MBV0OYad/Amr+ntzOOgtAuciAvriWNlyI1pnSCoY0Kpnm3umpP16YNrBGFio5w2PWbWotzeYqyxGY0yZae+pe5f5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774656684; c=relaxed/simple;
	bh=XyX3n7uAfPa95ULcASfolBLmVsV0SUvWg8VRvZbKnAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrcejU39np0niyI3iU7vhEcStkOHuZ1DTO99tcdDS1SWeFxkICL1HjATPjfxrzpaQ4ivMNSCcSCrU+lfFm3bPjxdcxx4gI+cZufV2dpjUXFoQIHYmb2cf+ucPOGzRXiP1TcwNvlVmSaobox28I7ke47jyHdhRzRGA8ssWFySLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRMoNknN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRMoNknN"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4870206f73bso15637995e9.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774656681; x=1775261481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+ivgdAJhd+7/h/Tz3dW8ZuYKjlxS7hlBwgUZZDR3tY=;
        b=PRMoNknN59jHdfr++yXXWZsOoSrJKxLBr1S5Ec9RC0tbSx7NvVa+mkiUk8hJPnzamA
         dhlHi8WtSXwuKOtoGqn4mu+uSlJ/vvD97Qv2ioSv3UXviHglvKuZRMeeLmOuRvf6m4no
         A3SDDxDSNIEehFXZIzo91KOvU/5SkLqZbOsW4A8GzzgVmk6/SRWaj4jltOtosIzwgBjV
         4+y4bIxFZKHsqtmqRjXz5aiaawH/iOUv/YnQK6H8tjKeKyxIWfg41JiNMFz1gtmkcgK5
         utEsfiaysmxv8CsyyeZl2tm74yBTways0r2fTkrlIZmNWHF6xuV1C97gMsfJMM+UAmot
         3mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774656681; x=1775261481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+ivgdAJhd+7/h/Tz3dW8ZuYKjlxS7hlBwgUZZDR3tY=;
        b=Q+2zUiJSBwVoNWebknRKD2UOFPu9xkxHjmYuUyVi/UmHSXA5otjdXq3q2SphQ2NMf3
         g5o5u2enP/1+0hqWUuRzfVEYJ180iUhcCGFCcucRqN+08zHJsDG/nZcLFUizJ6YtUXle
         SMTRCRJ88UjpxpmppXjSRj4vdAD9CkXqng4tSfUSaADQrJcfWz4U0yoYjuIHf8F9qHxQ
         cljzdgL5NLxyDslFZHY9d+CYMgigV1ACJ1M9JoyxDVWkPhOWPxTEaLUffPKCd2jEfz07
         8ZPrzL8bOJugSNB44satIHK0pWaX2yJDvv3qV1HXCSEINiC0boRMkIXA+XRYaSH9+lm7
         CqRQ==
X-Gm-Message-State: AOJu0YwlH27kTiTTmyDQ00nf+grvvYZWF/9a8htsazd7hZSj8lViHWVJ
	iF6d/5JxpLe0O+4seIWBYLtNvaGg8WuZTAwpbCt/0/gNo2q/fFAmiAIC5U3xBL/Qwso=
X-Gm-Gg: ATEYQzwjfJB/hkbLp7+wx1ukakjudsJ/KOqCkY7ZUPXn5JwAp6r3ictUBP0azHivmTz
	K7iudSgtuSnBIjMuZDXC57NuBgfCnWA1aPjLqzoOcFhxi3zKQBGxxl4PnbwbPW10hFokptxzYeE
	vA8uhM6nxHUjTe8mfoUgnSNj6S2YWQKDm8WD1HcJrepZWY+TV+RTbMnz7w/HbsaDswcHeCH4T1J
	ZrQ+Jl/J7v+WkKh7JWTEmlW6sUwq8oICFo3Mp7oHxwmvGRvHUq+xaNl+6Uv4OCINCTThZIsnnQa
	OXgtctf9HIKE8hGSwPY6sxhX1aAb0f/HAmD8lebkX+ybI5rnXO1dqOA6v6s76I62DwinUEAIg2G
	CAvMsrTq9D09I9ITHEyCWKYWO6shk9Sxyx0FxVP+7nQdu2B8sGI/dlYw5Erys3/fd1ItqwHTbnp
	trklJDJTwR+zEAX/T/J2deHcle/Phdv6n6HIeZBETyMDkiFyX3qES+H5HJbj6ryccI9FDi92g1K
	zdxU2jeGLsY9fX1mYm9ZMgyrjUHZALqufIUy65Ds5VIAo7gUO2DX6240+8=
X-Received: by 2002:a05:600c:6287:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-48727ef1782mr73574095e9.3.1774656680328;
        Fri, 27 Mar 2026 17:11:20 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d2366dsm116147635e9.10.2026.03.27.17.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:11:19 -0700 (PDT)
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
	szeder.dev@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v6 1/3] graph: limit the graph width to a hard-coded max
Date: Sat, 28 Mar 2026 01:11:11 +0100
Message-ID: <20260328001113.1275291-2-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328001113.1275291-1-pabloosabaterr@gmail.com>
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
 <20260328001113.1275291-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repositories that have many active branches at the same time
produce wide graphs. A lane consists of two columns, the edge and the
padding (or another edge), each branch takes a lane in the graph and
there is no way to limit how many can be shown.

Limit the graph engine to draw at most 15 lanes. Lanes over the limit are
not rendered.

On the commit line, if the commit lives on a visible lane, show the
normal commit mark and stop rendering. If the commit lives on the
first hidden lane, show the "*" commit mark so it is known that
this commit lives in the first hidden lane. Commits on deeper lanes
aren't rendered, but the commit subject will always remain.

For merges, the post-merge lane is only needed when the commit or
the first parent lives on a visible lane (to draw the connection
between them), when both are on hidden lanes, post-merge carries
no useful information, skip it and go to collapsing or padding state.

Also fix a pre-existing indentation issue.

The hard-coded limit will be replaced by a user-facing option
on a subsequent commit.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c | 161 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 136 insertions(+), 25 deletions(-)

diff --git a/graph.c b/graph.c
index 26f6fbf000..70458cf323 100644
--- a/graph.c
+++ b/graph.c
@@ -82,6 +82,8 @@ static void graph_show_line_prefix(const struct diff_options *diffopt)
 static const char **column_colors;
 static unsigned short column_colors_max;
 
+static unsigned int max_lanes = 15;
+
 static void parse_graph_colors_config(struct strvec *colors, const char *string)
 {
 	const char *end, *start;
@@ -317,6 +319,11 @@ struct git_graph {
 	struct strbuf prefix_buf;
 };
 
+static inline int graph_needs_truncation(int lane)
+{
+	return lane >= max_lanes;
+}
+
 static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
 {
 	struct git_graph *graph = data;
@@ -607,7 +614,7 @@ static void graph_update_columns(struct git_graph *graph)
 {
 	struct commit_list *parent;
 	int max_new_columns;
-	int i, seen_this, is_commit_in_columns;
+	int i, seen_this, is_commit_in_columns, max;
 
 	/*
 	 * Swap graph->columns with graph->new_columns
@@ -696,6 +703,14 @@ static void graph_update_columns(struct git_graph *graph)
 		}
 	}
 
+	/*
+	 * Cap to the hard-coded limit.
+	 * Allow commits from merges to align to the merged lane.
+	 */
+	max = max_lanes * 2 + 2;
+	if (graph->width > max)
+		graph->width = max;
+
 	/*
 	 * Shrink mapping_size to be the minimum necessary
 	 */
@@ -846,6 +861,8 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
+		if (graph_needs_truncation(i))
+			break;
 		graph_line_write_column(line, &graph->new_columns[i], '|');
 		graph_line_addch(line, ' ');
 	}
@@ -903,6 +920,8 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			seen_this = 1;
 			graph_line_write_column(line, col, '|');
 			graph_line_addchars(line, ' ', graph->expansion_row);
+		} else if (seen_this && graph_needs_truncation(i)) {
+			break;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -994,6 +1013,14 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
 		col = &graph->new_columns[j];
 
 		graph_line_write_column(line, col, '-');
+
+		/*
+		 * Commit is at commit_index, each iteration move one lane to
+		 * the right from the commit.
+		 */
+		if (graph_needs_truncation(graph->commit_index + 1 + i))
+			break;
+
 		graph_line_write_column(line, col, (i == dashed_parents - 1) ? '.' : '-');
 	}
 
@@ -1028,8 +1055,16 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 			seen_this = 1;
 			graph_output_commit_char(graph, line);
 
+			if (graph_needs_truncation(i)) {
+				graph_line_addch(line, ' ');
+				break;
+			}
+
 			if (graph->num_parents > 2)
 				graph_draw_octopus_merge(graph, line);
+		} else if (graph_needs_truncation(i)) {
+			seen_this = 1;
+			break;
 		} else if (seen_this && (graph->edges_added > 1)) {
 			graph_line_write_column(line, col, '\\');
 		} else if (seen_this && (graph->edges_added == 1)) {
@@ -1065,13 +1100,46 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 
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
+		if (!graph_needs_truncation(graph->commit_index)) {
+			graph_update_state(graph, GRAPH_POST_MERGE);
+		} else {
+			struct commit_list *p = first_interesting_parent(graph);
+			int lane;
+
+			/*
+			 * graph->num_parents are found using first_interesting_parent
+			 * and next_interesting_parent so it can't be a scenario
+			 * where num_parents > 1 and there are no interesting parents
+			 */
+			if (!p)
+				BUG("num_parents > 1 but no interesting parent");
+
+			lane = graph_find_new_column_by_commit(graph, p->item);
+
+			if (!graph_needs_truncation(lane))
+				graph_update_state(graph, GRAPH_POST_MERGE);
+			else if (graph_is_mapping_correct(graph))
+				graph_update_state(graph, GRAPH_PADDING);
+			else
+				graph_update_state(graph, GRAPH_COLLAPSING);
+		}
+	} else if (graph_is_mapping_correct(graph)) {
 		graph_update_state(graph, GRAPH_PADDING);
-	else
+	} else {
 		graph_update_state(graph, GRAPH_COLLAPSING);
+	}
 }
 
 static const char merge_chars[] = {'/', '|', '\\'};
@@ -1109,6 +1177,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			int par_column;
 			int idx = graph->merge_layout;
 			char c;
+			int truncated = 0;
 			seen_this = 1;
 
 			for (j = 0; j < graph->num_parents; j++) {
@@ -1117,23 +1186,53 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 
 				c = merge_chars[idx];
 				graph_line_write_column(line, &graph->new_columns[par_column], c);
+
+				/*
+				 * j counts parents, it needs to be halved to be
+				 * comparable with i. Don't truncate if there are
+				 * no more lanes to print (end of the lane)
+				 */
+				if (graph_needs_truncation(j / 2 + i) &&
+				    j / 2 + i <= graph->num_columns) {
+					if ((j + i * 2) % 2 != 0)
+						graph_line_addch(line, ' ');
+					truncated = 1;
+					break;
+				}
+
 				if (idx == 2) {
-					if (graph->edges_added > 0 || j < graph->num_parents - 1)
+					/*
+					 * Check if the next lane needs truncation
+					 * to avoid having the padding doubled
+					 */
+					if (graph_needs_truncation((j + 1) / 2 + i) &&
+					    j < graph->num_parents - 1) {
+						truncated = 1;
+						break;
+					} else if (graph->edges_added > 0 || j < graph->num_parents - 1)
 						graph_line_addch(line, ' ');
 				} else {
 					idx++;
 				}
 				parents = next_interesting_parent(graph, parents);
 			}
+			if (truncated)
+				break;
 			if (graph->edges_added == 0)
 				graph_line_addch(line, ' ');
-
+		} else if (graph_needs_truncation(i)) {
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
+			if (!graph_needs_truncation(i + 1))
+				graph_line_addch(line, ' ');
 		} else {
 			graph_line_write_column(line, col, '|');
 			if (graph->merge_layout != 0 || i != graph->commit_index - 1) {
@@ -1164,6 +1263,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	short used_horizontal = 0;
 	int horizontal_edge = -1;
 	int horizontal_edge_target = -1;
+	int truncated = 0;
 
 	/*
 	 * Swap the mapping and old_mapping arrays
@@ -1279,26 +1379,34 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	 */
 	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->mapping[i];
-		if (target < 0)
-			graph_line_addch(line, ' ');
-		else if (target * 2 == i)
-			graph_line_write_column(line, &graph->new_columns[target], '|');
-		else if (target == horizontal_edge_target &&
-			 i != horizontal_edge - 1) {
-				/*
-				 * Set the mappings for all but the
-				 * first segment to -1 so that they
-				 * won't continue into the next line.
-				 */
-				if (i != (target * 2)+3)
-					graph->mapping[i] = -1;
-				used_horizontal = 1;
-			graph_line_write_column(line, &graph->new_columns[target], '_');
+
+		if (!truncated && graph_needs_truncation(i / 2)) {
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
+			/*
+			 * Set the mappings for all but the
+			 * first segment to -1 so that they
+			 * won't continue into the next line.
+			 */
+			if (i != (target * 2)+3)
+				graph->mapping[i] = -1;
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
 
@@ -1372,6 +1480,9 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 
+		if (graph_needs_truncation(i))
+			break;
+
 		graph_line_write_column(&line, col, '|');
 
 		if (col->commit == graph->commit && graph->num_parents > 2) {
-- 
2.43.0

