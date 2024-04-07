Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD7DDBD
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712466648; cv=none; b=ix/JLgd6B64pZx4DvUXt5X9qgjxe4G5nYIr/cs8MXYgGfL1TgZV4e6mdrj/arCFJOsu8whPcDvdxMI9pFVLAgU5FYIaF6zoDKX8DuJCu3REgAyfRZbCpttTmablG73kpbz/zM4qGiyxBXkV45eo4zx8XlJywmE/klkSjeYl0O9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712466648; c=relaxed/simple;
	bh=BhMsPHWN4uT/H03U3vxrR1aSY65xIuUGWzJszHEIoYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+fYzt0jAtfU+g81ht8e0Ghwsf/xbzAoYzTR9BCJpZiefW28I5VkXd2Rjyp+sEVOwQgFbBz0Y6BqidwKlLE6/wGtbSufC/gs+/sAn8OTGdO4XvSVn/YEoDBpKaizIKXVofNbLDXZCIxGRqzN422uaQczasHeS5W3/TPikvY402U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwsCpBEJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwsCpBEJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dff837d674so30099195ad.3
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 22:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712466645; x=1713071445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH2eXpp8k7+f6+BOwLh+4qPwQB+wHymU0zzGp8XXPFY=;
        b=RwsCpBEJFODiQ7pK7sAcTeRkCSavF/eOK14R771UBUuUh1WjpWR/ofCjgKsbX0mjJX
         AFXrqOop4MgHwCvQ1GRuOBdvF+40GzQcVm0ALijNJji9Mu96O06Ca5BOsVwGmiSE6Qg1
         mjZ4i5f8cKo+QspamdJq1dZmsWGaAfmJRBFie8wZ4FGgfg5E2RGv2Vs8bCJGdREPgAJ7
         6EQ5LznhDUMB4ru32B7CGRZlKBs/J9hu+WrbElZdnH67oAkh/ltnHKiGB7DFb9XwCVOR
         nt1EOP5ADB0621jPWvkntpKCTo9sJ77oZIVzgAJJvEX0VXbV+yQpzouA3kOnKCEfS3Mc
         WOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712466645; x=1713071445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH2eXpp8k7+f6+BOwLh+4qPwQB+wHymU0zzGp8XXPFY=;
        b=CMvDqChbiNFsCTqt7LXP8klAKg9Tlot3Bz7iNBHeydvkHv01yjegMuFehGFRv1hNhF
         M4ZMRpHvpORCYSSfak+roIgq2ePJe9TZvf7fOFVK7jS0Pdyl0NlEQfcjC8gU0HCXG+AZ
         p547kLbhvY9eynoINw4EOxMN/TNxlb2abqnMg0Tt6wrNDKZWVEsh0BpyI1L2bpXxpyFO
         XgxXSNdit3Yke+qKd1sQmTwAK9+VV1qQ+8q//G5ZBmkvcDczot6JM7bXwxBR2JhCh0Ll
         WvM5riIWrW4p95JPiFUzgc12V2YoNbxXlBiks8bcpeU0NG90hnyHoWVIVgNOEQ1b+7q2
         lD9g==
X-Gm-Message-State: AOJu0YyUeTnYHxLjrVua4Abruk+Rgc6guNwNjRbtlxwBrWkPysQSj9dC
	0kiVRKQPgYZ4AZDXIcfkoLerhVBZIQmrwBzAGfKfa+MEp0CI1crucVtrUCzA888=
X-Google-Smtp-Source: AGHT+IFKZMLycIZXrmrBGCGsYIzSixn6e801dMKCSHUbRyZoTF1STtHFDubCvPP8ZysQMxQZIDv0sg==
X-Received: by 2002:a17:902:bc47:b0:1e0:4ce4:7e42 with SMTP id t7-20020a170902bc4700b001e04ce47e42mr5290332plz.17.1712466645452;
        Sat, 06 Apr 2024 22:10:45 -0700 (PDT)
Received: from QuangPC.localdomain ([104.28.254.75])
        by smtp.gmail.com with ESMTPSA id kj8-20020a17090306c800b001dd69aca213sm4223103plb.270.2024.04.06.22.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 22:10:45 -0700 (PDT)
From: =?UTF-8?q?L=C3=AA=20Duy=20Quang?= <leduyquang753@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?L=C3=AA=20Duy=20Quang?= <leduyquang753@gmail.com>
Subject: [RFC PATCH 1/1] Add separator lines into `git log --graph`.
Date: Sun,  7 Apr 2024 12:10:31 +0700
Message-ID: <20240407051031.6018-2-leduyquang753@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240407051031.6018-1-leduyquang753@gmail.com>
References: <20240407051031.6018-1-leduyquang753@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to separate out connected regions of the resulting commit graph so as
to not have them confused as belonging to the same timeline.
---
 graph.c                                |  55 +++++++++++-
 t/t4218-log-graph-connected-regions.sh | 119 +++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 4 deletions(-)
 create mode 100755 t/t4218-log-graph-connected-regions.sh

diff --git a/graph.c b/graph.c
index 1ca34770ee..c0107c02fa 100644
--- a/graph.c
+++ b/graph.c
@@ -69,6 +69,12 @@ enum graph_state {
 	GRAPH_COLLAPSING
 };
 
+enum connected_region_state {
+	CONNECTED_REGION_FIRST_COMMIT,
+	CONNECTED_REGION_USE_CURRENT,
+	CONNECTED_REGION_NEW_REGION
+};
+
 static void graph_show_line_prefix(const struct diff_options *diffopt)
 {
 	if (!diffopt || !diffopt->line_prefix)
@@ -310,6 +316,12 @@ struct git_graph {
 	 * stored as an index into the array column_colors.
 	 */
 	unsigned short default_column_color;
+	/*
+	 * The state of which connected region the current commit belongs to.
+	 * This is used to output a clarifying separator line between
+	 * connected regions.
+	 */
+	enum connected_region_state connected_region_state;
 };
 
 static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void *data)
@@ -380,6 +392,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	 * This way we start at 0 for the first commit.
 	 */
 	graph->default_column_color = column_colors_max - 1;
+	graph->connected_region_state = CONNECTED_REGION_FIRST_COMMIT;
 
 	/*
 	 * Allocate a reasonably large default number of columns
@@ -729,9 +742,9 @@ static int graph_num_expansion_rows(struct git_graph *graph)
 
 static int graph_needs_pre_commit_line(struct git_graph *graph)
 {
-	return graph->num_parents >= 3 &&
+	return graph->connected_region_state == CONNECTED_REGION_NEW_REGION || (graph->num_parents >= 3 &&
 	       graph->commit_index < (graph->num_columns - 1) &&
-	       graph->expansion_row < graph_num_expansion_rows(graph);
+	       graph->expansion_row < graph_num_expansion_rows(graph));
 }
 
 void graph_update(struct git_graph *graph, struct commit *commit)
@@ -760,6 +773,12 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 * commit.
 	 */
 	graph->prev_commit_index = graph->commit_index;
+	
+	/*
+	 * Determine whether this commit belongs to a new connected region.
+	 */
+	graph->connected_region_state = (graph->connected_region_state != CONNECTED_REGION_FIRST_COMMIT &&
+		graph->num_new_columns == 0) ? CONNECTED_REGION_NEW_REGION : CONNECTED_REGION_USE_CURRENT;
 
 	/*
 	 * Call graph_update_columns() to update
@@ -865,8 +884,28 @@ static void graph_output_skip_line(struct git_graph *graph, struct graph_line *l
 		graph_update_state(graph, GRAPH_COMMIT);
 }
 
-static void graph_output_pre_commit_line(struct git_graph *graph,
-					 struct graph_line *line)
+static void graph_output_separator_line(struct git_graph *graph, struct graph_line *line)
+{
+	/*
+	 * This function adds a row that separates two disconnected graphs,
+	 * as the appearance of multiple separate commits on top of each other
+	 * may cause a misunderstanding that they belong to a timeline.
+	 */
+	assert(graph->connected_region_state == CONNECTED_REGION_NEW_REGION);
+
+	/*
+	 * Output the row.
+	 */
+	graph_line_addstr(line, "---");
+
+	/*
+	 * Immediately move to GRAPH_COMMIT state as there for sure aren't going to be
+	 * any more pre-commit lines.
+	 */
+	graph_update_state(graph, GRAPH_COMMIT);
+}
+
+static void graph_output_parent_expansion_line(struct git_graph *graph, struct graph_line *line)
 {
 	int i, seen_this;
 
@@ -928,6 +967,14 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		graph_update_state(graph, GRAPH_COMMIT);
 }
 
+static void graph_output_pre_commit_line(struct git_graph *graph, struct graph_line *line)
+{
+	if (graph->connected_region_state == CONNECTED_REGION_NEW_REGION)
+		graph_output_separator_line(graph, line);
+	else
+		graph_output_parent_expansion_line(graph, line);
+}
+
 static void graph_output_commit_char(struct git_graph *graph, struct graph_line *line)
 {
 	/*
diff --git a/t/t4218-log-graph-connected-regions.sh b/t/t4218-log-graph-connected-regions.sh
new file mode 100755
index 0000000000..4efe17827e
--- /dev/null
+++ b/t/t4218-log-graph-connected-regions.sh
@@ -0,0 +1,119 @@
+#!/bin/sh
+
+test_description="git log --graph connected regions"
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-terminal.sh"
+. "$TEST_DIRECTORY/lib-log-graph.sh"
+
+test_cmp_graph () {
+	lib_test_cmp_graph --format=%s "$@"
+}
+
+add_commit () {
+	touch $1 &&
+	git add $1 &&
+	git commit -m $1
+	git tag "$1-commit"
+}
+
+test_expect_success setup '
+	git checkout -b a &&
+	add_commit root &&
+	
+	add_commit a1 &&
+	add_commit a2 &&
+	add_commit a3 &&
+	
+	git checkout -b b root-commit &&
+	add_commit b1 &&
+	add_commit b2 &&
+	git checkout -b c &&
+	add_commit c3 &&
+	git checkout b &&
+	add_commit b3 &&
+	git merge c -m b4 &&
+	
+	git checkout -b d root-commit &&
+	add_commit d1 &&
+	add_commit d2 &&
+	git checkout -b e &&
+	add_commit e3 &&
+	git checkout d &&
+	add_commit d3 &&
+	add_commit d4
+'
+
+cat > expect <<\EOF
+* a3
+* a2
+* a1
+| *   b4
+| |\
+| | * c3
+| * | b3
+| |/
+| * b2
+| * b1
+|/
+| * d4
+| * d3
+| | * e3
+| |/
+| * d2
+| * d1
+|/
+* root
+EOF
+
+test_expect_success 'all commits' '
+	test_cmp_graph a b c d e
+'
+
+cat > expect <<\EOF
+* a3
+* a2
+* a1
+---
+*   b4
+|\
+| * c3
+* | b3
+|/
+* b2
+* b1
+---
+* d4
+* d3
+| * e3
+|/
+* d2
+* d1
+EOF
+
+test_expect_success 'without root commit' '
+	test_cmp_graph a b c d e ^root-commit
+'
+
+cat > expect <<\EOF
+* a3
+---
+*   b4
+|\
+| * c3
+* b3
+---
+* d4
+* d3
+---
+* e3
+EOF
+
+test_expect_success "branches' tips" '
+	test_cmp_graph a b c d e ^a2-commit ^b2-commit ^d2-commit
+'
+
+test_done
-- 
2.44.0

