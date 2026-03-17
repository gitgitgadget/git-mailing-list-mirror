Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D473612EA
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785413; cv=none; b=u73ZRdCinl/wNEyO1LyuJ4+gJRW74VdRSjzJ+jT3hAKdVqCpAzPH+6arW+N1Xv3Xbg7rT+IugWSK8Ce/V4bB9aiaBppEvZz1hlBXcdLavz3KqidVq8cMqpMAoiofgyqeOPEcnjmBGFxFzENJ3wcAtutG7rscK4LNqP5S1j39N5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785413; c=relaxed/simple;
	bh=6ckEe4T5TKOasNa10u/EI6c6BlVknOY3lYDMNHsobOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2ilVzZLLQb4/fdbepKhWfsnF+/s8SO5+9U6wY1qS2WtSB+1ZYeTFAwG2MO8uTq0JxMoYqxZp/3Rz05JszSaowdFvqkkxghma73SLWIsL7NqtzlRHDCLkTcQV/6Y/RecE9VDBcp2RQTFS+4u7rP6e65FZxARTpwRo1QqaQ2wpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJLc8CQW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJLc8CQW"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b9b190easo4509165f8f.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773785410; x=1774390210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amJC3ikFvf2kwdFi/dQ6lzHLTxarSi0rUHvYur5BjXw=;
        b=UJLc8CQWkcjV6YwaS+D6uEcbQU8HrE0dxPgzk2i3LV2Drfb3mPuiOEVU5Mu17upmlL
         sTBDReSnphcrfXkkLqlGeImB/RGd/ieR6eyXStzyxJJJLxu2/9X9C27GPHLTitkyL+EU
         1FOCnpDhT1Uyb9gkOFMPyJgpKXtwNErH24BJJJqf2o/imntqC3zaETBC0Ho/cHSA+WaK
         TiLmxwRs0SrTUscqV6LESWZ7RPCTHjX5Xx6tVr6Bb1zzwT1QUtNgRO0W2wNx0S1FCsYC
         WPPAMYf9ncX4Sjs2PUkIadttXsCsGNHZDlrjOXo1gU94YoOgXfbVrp01NSyW7MdbHaMl
         CJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773785410; x=1774390210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amJC3ikFvf2kwdFi/dQ6lzHLTxarSi0rUHvYur5BjXw=;
        b=mYmjFqkQPEmKPDR3bwqaiILQSxn+iVOuQY+LTbxU13QzTj5YzJmbJFFk0Yi73KOwky
         br9tqbYZ99xxg3QpG1o66+cmY94IuboST/javeXhmpOOYZNZApi2jtGH8ZR4JBMX5z9Y
         yAmyeRsk3MCqDWPsDOqG/So7sBzOp5cfSL2XdkSvVcoY1AYfK9GkQg/GkEnKxx8k2wWW
         sCGQjLFsBzn+xuT7kXVtgNiuYFAwWvEv+PvIHpRZekRi2EJiv01mAWtyxfrNErDsyQDo
         4eaHsdyLZyZE+cBv3BQFaTSTnFUrvRPZ30FBSJrsR4KK2tKFQ90Iwf2MRztYdONDVIO7
         ar+A==
X-Gm-Message-State: AOJu0YxYK8JptoRbJi8qzfpJhGZmEyEmKsL/85Gs606l2L+cS4E/EDY8
	+bewBON0RnCLalHPOKV4Xdu55joVDKhUXoFuV1tY4xDLl7FVcvfAsDGv81zDqtmeuHN/sg==
X-Gm-Gg: ATEYQzwtxI5t2RakqnBeYstsEtnTP/vX4v8jdynaal5fkWMNbnv6XPQOSq95HoMJMCm
	+T0Ru3WGqXZyP1dv7JPMMKZyk3xHrlYORXwzjSvi/sMnz4aRi7Qb48b8WjC9yZmZMwF4O+fCCvW
	qCTmcWbpkqKgw+0SGPHPqHmIn/fyODzL8gdQ4Gx8ZtLZ9t+mIryQa+svw777pSHdlI/f8F9AT9o
	mCgk15Ok762fyo8PWjlww9hcg1DAPzMpsSfZdLERLoBoXDJ42gmPq/kpw9gbvp0nsdehIDTxwRw
	e4pfMe37BgTVeXVIqw0F+d6JppIHTlV5QEbHbMMLNp71y2JbBiLCzhUlr2XZNzSs6z261/nH+jT
	CT6xdw4Q5H+hD8bEdNRPChSRdN4/60JVTqYM40GXIZRV59V5aBhbtYJjHG+QjDyqRzaXcWoXWJ4
	EpP+ahbVOk2V6Rb6B5ezHCYk5KkqFXtf/e4Lxkc0MlkdceD3s0vDrwuR4OWP6A8IkRhLsKrppyi
	B3XEiL21o3GfZajAtJgnSG5xbXIZH5/5dujPog/ATJlx8iXSZfBsgAeduVmHfFMmOWfNQ==
X-Received: by 2002:a05:6000:40de:b0:439:b539:787 with SMTP id ffacd0b85a97d-43b527cb618mr1385364f8f.53.1773785409556;
        Tue, 17 Mar 2026 15:10:09 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852a64sm2197045f8f.14.2026.03.17.15.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:10:09 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC RFC PATCH v2] graph: add --max-columns option to limit displayed columns
Date: Tue, 17 Mar 2026 23:09:29 +0100
Message-ID: <20260317220929.120746-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316133426.117684-1-pabloosabaterr@gmail.com>
References: <20260316133426.117684-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repositories that have many active branches produce very wide
outputs with 'git log --graph --all', makes it difficult to read.

Add '--max-columns=<n>' to limit the columns shown. Columns over
the limit are replaced with a '.' truncation indicator. This only
affects the visual rendering.

The commit mark '*' is only shown in two cases:
- The commit is in a branch inside the limit.
- The commit is in the first hidden branch, in this case '.'
  is replaced by '*'.

Commits on deeper hidden branches do not show '*' but the commit
subject is still shown, so no information is lost.

The original idea to limit columns was noted as a TODO in
c12172d2ea (Add history graph API, 2008-05-04), which mentions
gitk's behavior. This does not implement gitk-style column
rearrangement; it only truncates the visual output.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---

> I'll wait for the decision about whether this TODO from 2008 is worth
> doing before a v2.

I believe that it is better to send an improved version instead of waiting
to show more clearly what I want to do, sorry for the confusion.

> It's been 16 years but I believe that is still a good thing to add, even if
> a lot of graph viewing happens with third parties, adding this makes
> Git a bit more self sufficient. This is even more useful in a case where the
> third party is not an option.

> That said, if this still doesn't seem useful I would remove the TODO
> to avoid further confusion in the future.

I revert what I've said here. This doesn't actually reflects gitk behaviour, 
it only truncates the visual output and prettifies it. To actually fullfill the
TODO, it should rearrange the columns what would mean to change the whole
rendering algorithm of --graph. This prob why it has been a TODO for so long.

I don't think the TODO should be removed with what I bring here. Therefore, I
wont't remove it.

The actual TODO seems still a good project and a good improvement.

example:

git log --oneline --graph --all

*   b81d099 (M_1) 7_M1
|\
| | *   2d96ba0 (M_3) 7_M2
| | |\
| | | * 993fbcd (7_4) 7_H
| | | | *   d5b56db (M_5) 7_M3
| | | | |\
| | | | | * b45d68d (7_6) 7_J
| | | | * | 3f9ab79 (7_5) 7_I
| | | | | | *   f89bbdc (HEAD -> M_7) 7_M4
| |_|_|_|_|/|\
|/| | | | |/ /
| | |_|_|/| /
| |/| | | |/
| | | |_|/|
| | |/| | |
| | * | | | f5cbb18 (7_3) 7_G
| | | |_|/
| | |/| |
| | * | | 6ee728a 7_F
| * | | | d0c5a67 (7_2) 7_E
| | |/ /
| |/| |
| * | | c3bffce 7_D
| | |/
| |/|
* | | df1a24f (7_1) 7_C
| |/
|/|
* | 5d3f777 7_B
|/
* d309d64 7_A

vs 

git log --graph --all --oneline --max-columns=2

*   b81d099 (M_1) 7_M1
|\
| | * 2d96ba0 (M_3) 7_M2
| | .
| | . 993fbcd (7_4) 7_H
| | . d5b56db (M_5) 7_M3
| | .
| | . b45d68d (7_6) 7_J
| | . 3f9ab79 (7_5) 7_I
| | . f89bbdc (HEAD -> M_7) 7_M4
| |_.
|/| .
| | .
| |/.
| |/.
| |/.
| | .
| | * f5cbb18 (7_3) 7_G
| | .
| | .
| | .
| | * 6ee728a 7_F
| * . d0c5a67 (7_2) 7_E
| | .
| |/.
| * . c3bffce 7_D
| | .
| |/.
* | . df1a24f (7_1) 7_C
| |/
|/|
* | 5d3f777 7_B
|/
* d309d64 7_A

Changes since v1:
- Renamed option from --graph-max to --max-columns
- Require --graph for --max-columns, die without it
- Fixed padding so commit text aligns correctly after truncation
- Added pre-commit truncation so lines before the commit column
  are also truncated when they exceed the limit
- Fixed post-merge line spacing inconsistency
- Used parse_long_opt/parse_count for input validation, matching
  existing revision.c patterns
- Reject negative and zero values with clear error messages
- Renamed graph_is_truncated to graph_needs_truncation

RFC :
- I think --max-columns is a good name, but it does not have --graph
  prefix, bcs it can only be on --graph I think it's clear enough.
  I added checks in setup_revisions().
- Is '.' fine as delimiter ? other options could be "~" or "-".

 graph.c                      | 57 +++++++++++++++++++++++++++++++++++-
 graph.h                      |  2 ++
 revision.c                   | 11 +++++++
 revision.h                   |  1 +
 t/t4215-log-skewed-merges.sh | 56 +++++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index 26f6fbf000..6227c4f22f 100644
--- a/graph.c
+++ b/graph.c
@@ -317,6 +317,12 @@ struct git_graph {
 	struct strbuf prefix_buf;
 };
 
+static int graph_needs_truncation(struct git_graph *graph, int col)
+{
+	int max = graph->revs->graph_max_columns;
+	return max > 0 && col >= max;
+}
+
 static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
 {
 	struct git_graph *graph = data;
@@ -696,6 +702,15 @@ static void graph_update_columns(struct git_graph *graph)
 		}
 	}
 
+	/*
+	 * If graph_max_columns is set, cap the padding from the branches
+	 */
+	if (graph->revs->graph_max_columns > 0) {
+		int truncation = graph->revs->graph_max_columns * 2 + 2;
+		if (graph->width > truncation)
+			graph->width = truncation;
+	}
+
 	/*
 	 * Shrink mapping_size to be the minimum necessary
 	 */
@@ -846,6 +861,10 @@ static void graph_output_padding_line(struct git_graph *graph,
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
@@ -903,6 +922,9 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			seen_this = 1;
 			graph_line_write_column(line, col, '|');
 			graph_line_addchars(line, ' ', graph->expansion_row);
+		} else if (seen_this && graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, ". ");
+			break;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -1013,6 +1035,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 	 * children that we have already processed.)
 	 */
 	seen_this = 0;
+
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
@@ -1028,8 +1051,17 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
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
@@ -1109,9 +1141,17 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			int par_column;
 			int idx = graph->merge_layout;
 			char c;
+			int truncated = 0;
 			seen_this = 1;
 
 			for (j = 0; j < graph->num_parents; j++) {
+				if (graph_needs_truncation(graph, i + j)) {
+					if (j > 0)
+						graph_line_addch(line, ' ');
+					graph_line_addstr(line, ". ");
+					truncated = 1;
+					break;
+				}
 				par_column = graph_find_new_column_by_commit(graph, parents->item);
 				assert(par_column >= 0);
 
@@ -1125,9 +1165,13 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
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
@@ -1279,6 +1323,12 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	 */
 	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->mapping[i];
+
+		if (graph_needs_truncation(graph, i / 2)) {
+			graph_line_addstr(line, ". ");
+			break;
+		}
+
 		if (target < 0)
 			graph_line_addch(line, ' ');
 		else if (target * 2 == i)
@@ -1372,6 +1422,11 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 
+		if (graph_needs_truncation(graph, i)) {
+			graph_line_addch(&line, '.');
+			break;
+		}
+
 		graph_line_write_column(&line, col, '|');
 
 		if (col->commit == graph->commit && graph->num_parents > 2) {
diff --git a/graph.h b/graph.h
index 3fd1dcb2e9..9a4551dd29 100644
--- a/graph.h
+++ b/graph.h
@@ -262,4 +262,6 @@ void graph_show_commit_msg(struct git_graph *graph,
 			   FILE *file,
 			   struct strbuf const *sb);
 
+#define MINIMUM_GRAPH_COLUMNS 1
+
 #endif /* GRAPH_H */
diff --git a/revision.c b/revision.c
index 31808e3df0..e8d38cb2a1 100644
--- a/revision.c
+++ b/revision.c
@@ -2605,6 +2605,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--no-graph")) {
 		graph_clear(revs->graph);
 		revs->graph = NULL;
+	} else if ((argcount = parse_long_opt("max-columns", argv, &optarg))) {
+		int val = parse_count(optarg);
+		if (val < MINIMUM_GRAPH_COLUMNS)
+			die(_("minimum columns is %d, cannot be set to %d"),
+			    MINIMUM_GRAPH_COLUMNS, val);
+		revs->graph_max_columns = val;
+		return argcount;
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
@@ -3172,6 +3179,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	if (revs->no_walk && revs->graph)
 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
+
+	if (revs->graph_max_columns > 0 && !revs->graph)
+		die(_("option '%s' requires '%s'"), "--max-columns", "--graph");
+
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
diff --git a/revision.h b/revision.h
index 69242ecb18..f15b390289 100644
--- a/revision.h
+++ b/revision.h
@@ -304,6 +304,7 @@ struct rev_info {
 
 	/* Display history graph */
 	struct git_graph *graph;
+	unsigned int graph_max_columns;
 
 	/* special limits */
 	int skip_count;
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 28d0779a8c..ca2b224cc4 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -370,4 +370,60 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '
 
+test_expect_success 'log --graph --max-columns=2 only two columns' '
+	check_graph --max-columns=2 M_7 <<-\EOF
+	*-.   7_M4
+	|\  .
+	| | * 7_G
+	| | * 7_F
+	| * . 7_E
+	| * . 7_D
+	* | . 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --max-columns=3 only three columns' '
+	check_graph --max-columns=3 M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | | .
+	| | | * 7_H
+	| | | . 7_M3
+	| | | .
+	| | | . 7_J
+	| | | . 7_I
+	| | | . 7_M4
+	| |_|_.
+	|/| | .
+	| | |_.
+	| |/|_.
+	| |/|_.
+	| |/| .
+	| | |/.
+	| | * . 7_G
+	| | | .
+	| | |/.
+	| | |/.
+	| | * . 7_F
+	| * | . 7_E
+	| | |/.
+	| |/| .
+	| * | . 7_D
+	| | |/
+	| |/|
+	* | | 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
 test_done
-- 
2.43.0

