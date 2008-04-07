From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 1/4] graph API: Fixed coding style problems
Date: Mon,  7 Apr 2008 01:01:18 -0700
Message-ID: <1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 10:02:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JimIu-0007zd-Nf
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbYDGIBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 04:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbYDGIBa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:01:30 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:55238 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbYDGIB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 04:01:27 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id AF6EF1B4068;
	Mon,  7 Apr 2008 04:01:23 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 3639A1B4052;
	Mon,  7 Apr 2008 04:01:23 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 9558014100BE; Mon,  7 Apr 2008 01:01:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78957>

- Removed pre-declarations of structs from graph.h; all users are
  expected to include the necessary header files first.
- Replaced prefix increment and decrement operators with postfix
  operators

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 graph.c |   42 +++++++++++++++++++++---------------------
 graph.h |    5 -----
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/graph.c b/graph.c
index be4000f..6f99063 100644
--- a/graph.c
+++ b/graph.c
@@ -190,7 +190,7 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	 * If the commit is already in the new_columns list, we don't need to
 	 * add it.  Just update the mapping correctly.
 	 */
-	for (i = 0; i < graph->num_new_columns; ++i) {
+	for (i = 0; i < graph->num_new_columns; i++) {
 		if (graph->new_columns[i].commit == commit) {
 			graph->mapping[*mapping_index] = i;
 			*mapping_index += 2;
@@ -204,7 +204,7 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	graph->new_columns[graph->num_new_columns].commit = commit;
 	graph->mapping[*mapping_index] = graph->num_new_columns;
 	*mapping_index += 2;
-	++graph->num_new_columns;
+	graph->num_new_columns++;
 }
 
 static void graph_update_columns(struct git_graph *graph)
@@ -245,7 +245,7 @@ static void graph_update_columns(struct git_graph *graph)
 	 * Clear out graph->mapping
 	 */
 	graph->mapping_size = 2 * max_new_columns;
-	for (i = 0; i < graph->mapping_size; ++i)
+	for (i = 0; i < graph->mapping_size; i++)
 		graph->mapping[i] = -1;
 
 	/*
@@ -259,7 +259,7 @@ static void graph_update_columns(struct git_graph *graph)
 	 */
 	seen_this = 0;
 	mapping_idx = 0;
-	for (i = 0; i <= graph->num_columns; ++i) {
+	for (i = 0; i <= graph->num_columns; i++) {
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
 			if (seen_this)
@@ -289,7 +289,7 @@ static void graph_update_columns(struct git_graph *graph)
 	 */
 	while (graph->mapping_size > 1 &&
 	       graph->mapping[graph->mapping_size - 1] < 0)
-		--graph->mapping_size;
+		graph->mapping_size--;
 }
 
 void graph_update(struct git_graph *graph, struct commit *commit)
@@ -306,7 +306,7 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 */
 	graph->num_parents = 0;
 	for (parent = commit->parents; parent; parent = parent->next)
-		++(graph->num_parents);
+		graph->num_parents++;
 
 	/*
 	 * Call graph_update_columns() to update
@@ -348,7 +348,7 @@ static int graph_is_mapping_correct(struct git_graph *graph)
 	 * (If it is 1 greater than the target, '/' will be printed, so it
 	 * will look correct on the next row.)
 	 */
-	for (i = 0; i < graph->mapping_size; ++i) {
+	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->mapping[i];
 		if (target < 0)
 			continue;
@@ -377,7 +377,7 @@ static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb)
 	size_t extra;
 	size_t final_width = graph->num_columns + graph->num_parents;
 	if (graph->num_parents < 1)
-		++final_width;
+		final_width++;
 	final_width *= 2;
 
 	if (sb->len >= final_width)
@@ -405,7 +405,7 @@ static void graph_output_padding_line(struct git_graph *graph,
 	/*
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
-	for (i = 0; i < graph->num_new_columns; ++i) {
+	for (i = 0; i < graph->num_new_columns; i++) {
 		strbuf_addstr(sb, "| ");
 	}
 
@@ -454,7 +454,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 * Output the row
 	 */
 	seen_this = 0;
-	for (i = 0; i < graph->num_columns; ++i) {
+	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		if (col->commit == graph->commit) {
 			seen_this = 1;
@@ -472,7 +472,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 * Increment graph->expansion_row,
 	 * and move to state GRAPH_COMMIT if necessary
 	 */
-	++graph->expansion_row;
+	graph->expansion_row++;
 	if (graph->expansion_row >= num_expansion_rows)
 		graph->state = GRAPH_COMMIT;
 }
@@ -490,7 +490,7 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 	 * children that we have already processed.)
 	 */
 	seen_this = 0;
-	for (i = 0; i <= graph->num_columns; ++i) {
+	for (i = 0; i <= graph->num_columns; i++) {
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
 			if (seen_this)
@@ -514,7 +514,7 @@ void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			else {
 				int num_dashes =
 					((graph->num_parents - 2) * 2) - 1;
-				for (j = 0; j < num_dashes; ++j)
+				for (j = 0; j < num_dashes; j++)
 					strbuf_addch(sb, '-');
 				strbuf_addstr(sb, ". ");
 			}
@@ -546,7 +546,7 @@ void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
 	/*
 	 * Output the post-merge row
 	 */
-	for (i = 0; i <= graph->num_columns; ++i) {
+	for (i = 0; i <= graph->num_columns; i++) {
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
 			if (seen_this)
@@ -559,7 +559,7 @@ void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
 		if (col_commit == graph->commit) {
 			seen_this = 1;
 			strbuf_addch(sb, '|');
-			for (j = 0; j < graph->num_parents - 1; ++j)
+			for (j = 0; j < graph->num_parents - 1; j++)
 				strbuf_addstr(sb, "\\ ");
 			if (graph->num_parents == 2)
 				strbuf_addch(sb, ' ');
@@ -589,10 +589,10 @@ void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
 	/*
 	 * Clear out the new_mapping array
 	 */
-	for (i = 0; i < graph->mapping_size; ++i)
+	for (i = 0; i < graph->mapping_size; i++)
 		graph->new_mapping[i] = -1;
 
-	for (i = 0; i < graph->mapping_size; ++i) {
+	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->mapping[i];
 		if (target < 0)
 			continue;
@@ -653,12 +653,12 @@ void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
 	 * The new mapping may be 1 smaller than the old mapping
 	 */
 	if (graph->new_mapping[graph->mapping_size - 1] < 0)
-		--graph->mapping_size;
+		graph->mapping_size--;
 
 	/*
 	 * Output out a line based on the new mapping info
 	 */
-	for (i = 0; i < graph->mapping_size; ++i) {
+	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->new_mapping[i];
 		if (target < 0)
 			strbuf_addch(sb, ' ');
@@ -729,7 +729,7 @@ void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	 * columns.  (This happens when the current commit doesn't have any
 	 * children that we have already processed.)
 	 */
-	for (i = 0; i < graph->num_columns; ++i) {
+	for (i = 0; i < graph->num_columns; i++) {
 		struct commit *col_commit = graph->columns[i].commit;
 		if (col_commit == graph->commit) {
 			strbuf_addch(sb, '|');
@@ -738,7 +738,7 @@ void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 				strbuf_addch(sb, ' ');
 			else {
 				int num_spaces = ((graph->num_parents - 2) * 2);
-				for (j = 0; j < num_spaces; ++j)
+				for (j = 0; j < num_spaces; j++)
 					strbuf_addch(sb, ' ');
 			}
 		} else {
diff --git a/graph.h b/graph.h
index 817862e..c1f6892 100644
--- a/graph.h
+++ b/graph.h
@@ -4,11 +4,6 @@
 /* A graph is a pointer to this opaque structure */
 struct git_graph;
 
-/* Defined in commit.h */
-struct commit;
-/* Defined in strbuf.h */
-struct strbuf;
-
 /*
  * Create a new struct git_graph.
  * The graph should be freed with graph_release() when no longer needed.
-- 
1.5.3.6
