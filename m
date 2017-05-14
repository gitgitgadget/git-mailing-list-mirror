Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D6A20188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758454AbdENDQP (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:15 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33450 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758302AbdENDQN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id h4so14343960oib.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XMl0gUqo+Yw/JSxC5rrIKiboO1jxI4M7RRDt53U6h6k=;
        b=tp4twZe44sd0RgDDx5AQT+erxidO1IjbzQw3Zkh5Xb22gwTj0w/JQvioG9irhgdVPc
         w1oLlWGen9uhkEdGlnXTeJasy73JR1Tb90uMwSkXEyoJvqyKaKwANiCVccDQKX3uhiQu
         l5YsGhgHQPz70qy8/EMRgSUBkIjFYKAdnygj8o9l5ZOvfV+Icy5ZiAsWo8JCSSXVABmb
         lE8yJJ6NsxQ2xe5XxXHDt1DvqAeBpbod4TE3QqMfIHWveD1Ndsi2NUPzJgCFXs6iEbjx
         GCsqIVrB6ugRMQO/0v1o6jHCfdoQw7pK9ZQ6jMk6uBJukTgBnRhr9Z76hv+PtzP2p5is
         kDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XMl0gUqo+Yw/JSxC5rrIKiboO1jxI4M7RRDt53U6h6k=;
        b=WO5CVdSzgY4EovUiOKITDx9QxUXWRpiUl8GiqQmCSkHS2ytAtncnhvfD/33QsC4t5H
         asrNOZsnOY0Ifv9wNBhcH4dIr/iNBwCm3Wbwzdzes8GxDbtJeuqYarJ0J8t8GNkg9c32
         6+uYFqqngCwKgEL+rSKQNr3HuT4HCXffzfKXEq+jaAoMIXpoUxlWalhMOtDdVUPN9Ujm
         6jQQ5QtZHrmZbVoKpw9jrU2zybIboRcd9jkO8YLMWJvMd4liQuC8zJYDHVjv9SURzUAb
         sXVpGY+Ur/M6VUyGqXtNRECe6MBs+88cyzn44aYM7gznrTeL8kKgspjfb2B6sYxJ+qn4
         nK7w==
X-Gm-Message-State: AODbwcBE+88g1/v0fQ+y2zl64WJ7n+H9ed1WouHD/53DhO76RC7NHfs3
        SMuK2DyCRU+8Pw==
X-Received: by 10.202.185.68 with SMTP id j65mr5678858oif.93.1494731772248;
        Sat, 13 May 2017 20:16:12 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:11 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 05/22] blame: move scoreboard structure to header
Date:   Sat, 13 May 2017 22:14:56 -0500
Message-Id: <20170514031513.9042-6-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The scoreboard structure is core to the blame interface. Since
scoreboard will be more exposed, rename it to blame_scoreboard to
clarify what it is a part of.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         | 29 ++++++++++++++++++++
 builtin/blame.c | 83 +++++++++++++++++++--------------------------------------
 2 files changed, 57 insertions(+), 55 deletions(-)

diff --git a/blame.h b/blame.h
index f52d0fc..8d6a6fd 100644
--- a/blame.h
+++ b/blame.h
@@ -4,6 +4,8 @@
 #include "cache.h"
 #include "commit.h"
 #include "xdiff-interface.h"
+#include "revision.h"
+#include "prio-queue.h"
 
 /*
  * One blob in a commit that is being suspected
@@ -83,4 +85,31 @@ struct blame_entry {
 	unsigned score;
 };
 
+/*
+ * The current state of the blame assignment.
+ */
+struct blame_scoreboard {
+	/* the final commit (i.e. where we started digging from) */
+	struct commit *final;
+	/* Priority queue for commits with unassigned blame records */
+	struct prio_queue commits;
+	struct rev_info *revs;
+	const char *path;
+
+	/*
+	 * The contents in the final image.
+	 * Used by many functions to obtain contents of the nth line,
+	 * indexed with scoreboard.lineno[blame_entry.lno].
+	 */
+	const char *final_buf;
+	unsigned long final_buf_size;
+
+	/* linked list of blames */
+	struct blame_entry *ent;
+
+	/* look-up a line in the final buffer */
+	int num_lines;
+	int *lineno;
+};
+
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index caa5ee0..4a1da53 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -273,41 +273,14 @@ static int compare_commits_by_reverse_commit_date(const void *a,
 	return -compare_commits_by_commit_date(a, b, c);
 }
 
-/*
- * The current state of the blame assignment.
- */
-struct scoreboard {
-	/* the final commit (i.e. where we started digging from) */
-	struct commit *final;
-	/* Priority queue for commits with unassigned blame records */
-	struct prio_queue commits;
-	struct rev_info *revs;
-	const char *path;
-
-	/*
-	 * The contents in the final image.
-	 * Used by many functions to obtain contents of the nth line,
-	 * indexed with scoreboard.lineno[blame_entry.lno].
-	 */
-	const char *final_buf;
-	unsigned long final_buf_size;
-
-	/* linked list of blames */
-	struct blame_entry *ent;
-
-	/* look-up a line in the final buffer */
-	int num_lines;
-	int *lineno;
-};
-
-static void sanity_check_refcnt(struct scoreboard *);
+static void sanity_check_refcnt(struct blame_scoreboard *);
 
 /*
  * If two blame entries that are next to each other came from
  * contiguous lines in the same origin (i.e. <commit, path> pair),
  * merge them together.
  */
-static void coalesce(struct scoreboard *sb)
+static void coalesce(struct blame_scoreboard *sb)
 {
 	struct blame_entry *ent, *next;
 
@@ -333,7 +306,7 @@ static void coalesce(struct scoreboard *sb)
  * the commit priority queue of the score board.
  */
 
-static void queue_blames(struct scoreboard *sb, struct blame_origin *porigin,
+static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porigin,
 			 struct blame_entry *sorted)
 {
 	if (porigin->suspects)
@@ -576,14 +549,14 @@ static void dup_entry(struct blame_entry ***queue,
 	*queue = &dst->next;
 }
 
-static const char *nth_line(struct scoreboard *sb, long lno)
+static const char *nth_line(struct blame_scoreboard *sb, long lno)
 {
 	return sb->final_buf + sb->lineno[lno];
 }
 
 static const char *nth_line_cb(void *data, long lno)
 {
-	return nth_line((struct scoreboard *)data, lno);
+	return nth_line((struct blame_scoreboard *)data, lno);
 }
 
 /*
@@ -842,7 +815,7 @@ static int blame_chunk_cb(long start_a, long count_a,
  * for the lines it is suspected to its parent.  Run diff to find
  * which lines came from parent and pass blame for them.
  */
-static void pass_blame_to_parent(struct scoreboard *sb,
+static void pass_blame_to_parent(struct blame_scoreboard *sb,
 				 struct blame_origin *target,
 				 struct blame_origin *parent)
 {
@@ -882,7 +855,7 @@ static void pass_blame_to_parent(struct scoreboard *sb,
  *
  * Compute how trivial the lines in the blame_entry are.
  */
-static unsigned ent_score(struct scoreboard *sb, struct blame_entry *e)
+static unsigned ent_score(struct blame_scoreboard *sb, struct blame_entry *e)
 {
 	unsigned score;
 	const char *cp, *ep;
@@ -909,7 +882,7 @@ static unsigned ent_score(struct scoreboard *sb, struct blame_entry *e)
  * so far, by comparing this and best_so_far and copying this into
  * bst_so_far as needed.
  */
-static void copy_split_if_better(struct scoreboard *sb,
+static void copy_split_if_better(struct blame_scoreboard *sb,
 				 struct blame_entry *best_so_far,
 				 struct blame_entry *this)
 {
@@ -943,7 +916,7 @@ static void copy_split_if_better(struct scoreboard *sb,
  *
  * All line numbers are 0-based.
  */
-static void handle_split(struct scoreboard *sb,
+static void handle_split(struct blame_scoreboard *sb,
 			 struct blame_entry *ent,
 			 int tlno, int plno, int same,
 			 struct blame_origin *parent,
@@ -962,7 +935,7 @@ static void handle_split(struct scoreboard *sb,
 }
 
 struct handle_split_cb_data {
-	struct scoreboard *sb;
+	struct blame_scoreboard *sb;
 	struct blame_entry *ent;
 	struct blame_origin *parent;
 	struct blame_entry *split;
@@ -986,7 +959,7 @@ static int handle_split_cb(long start_a, long count_a,
  * we can pass blames to it.  file_p has the blob contents for
  * the parent.
  */
-static void find_copy_in_blob(struct scoreboard *sb,
+static void find_copy_in_blob(struct blame_scoreboard *sb,
 			      struct blame_entry *ent,
 			      struct blame_origin *parent,
 			      struct blame_entry *split,
@@ -1022,7 +995,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
  * Returns a pointer to the link pointing to the old head of the small list.
  */
 
-static struct blame_entry **filter_small(struct scoreboard *sb,
+static struct blame_entry **filter_small(struct blame_scoreboard *sb,
 					 struct blame_entry **small,
 					 struct blame_entry **source,
 					 unsigned score_min)
@@ -1049,7 +1022,7 @@ static struct blame_entry **filter_small(struct scoreboard *sb,
  * See if lines currently target is suspected for can be attributed to
  * parent.
  */
-static void find_move_in_parent(struct scoreboard *sb,
+static void find_move_in_parent(struct blame_scoreboard *sb,
 				struct blame_entry ***blamed,
 				struct blame_entry **toosmall,
 				struct blame_origin *target,
@@ -1125,7 +1098,7 @@ static struct blame_list *setup_blame_list(struct blame_entry *unblamed,
  * across file boundary from the parent commit.  porigin is the path
  * in the parent we already tried.
  */
-static void find_copy_in_parent(struct scoreboard *sb,
+static void find_copy_in_parent(struct blame_scoreboard *sb,
 				struct blame_entry ***blamed,
 				struct blame_entry **toosmall,
 				struct blame_origin *target,
@@ -1231,7 +1204,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
  * The blobs of origin and porigin exactly match, so everything
  * origin is suspected for can be blamed on the parent.
  */
-static void pass_whole_blame(struct scoreboard *sb,
+static void pass_whole_blame(struct blame_scoreboard *sb,
 			     struct blame_origin *origin, struct blame_origin *porigin)
 {
 	struct blame_entry *e, *suspects;
@@ -1279,7 +1252,7 @@ static int num_scapegoats(struct rev_info *revs, struct commit *commit)
 /* Distribute collected unsorted blames to the respected sorted lists
  * in the various origins.
  */
-static void distribute_blame(struct scoreboard *sb, struct blame_entry *blamed)
+static void distribute_blame(struct blame_scoreboard *sb, struct blame_entry *blamed)
 {
 	blamed = blame_sort(blamed, compare_blame_suspect);
 	while (blamed)
@@ -1299,7 +1272,7 @@ static void distribute_blame(struct scoreboard *sb, struct blame_entry *blamed)
 
 #define MAXSG 16
 
-static void pass_blame(struct scoreboard *sb, struct blame_origin *origin, int opt)
+static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	int i, pass, num_sg;
@@ -1656,7 +1629,7 @@ static void found_guilty_entry(struct blame_entry *ent,
  * The main loop -- while we have blobs with lines whose true origin
  * is still unknown, pick one blob, and allow its lines to pass blames
  * to its parents. */
-static void assign_blame(struct scoreboard *sb, int opt)
+static void assign_blame(struct blame_scoreboard *sb, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	struct commit *commit = prio_queue_get(&sb->commits);
@@ -1772,7 +1745,7 @@ static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 		write_filename_info(suspect);
 }
 
-static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
+static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 			   int opt)
 {
 	int repeat = opt & OUTPUT_LINE_PORCELAIN;
@@ -1811,7 +1784,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 		putchar('\n');
 }
 
-static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
+static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
 {
 	int cnt;
 	const char *cp;
@@ -1890,7 +1863,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	commit_info_destroy(&ci);
 }
 
-static void output(struct scoreboard *sb, int option)
+static void output(struct blame_scoreboard *sb, int option)
 {
 	struct blame_entry *ent;
 
@@ -1929,7 +1902,7 @@ static const char *get_next_line(const char *start, const char *end)
  * To allow quick access to the contents of nth line in the
  * final image, prepare an index in the scoreboard.
  */
-static int prepare_lines(struct scoreboard *sb)
+static int prepare_lines(struct blame_scoreboard *sb)
 {
 	const char *buf = sb->final_buf;
 	unsigned long len = sb->final_buf_size;
@@ -1989,7 +1962,7 @@ static int update_auto_abbrev(int auto_abbrev, struct blame_origin *suspect)
  * How many columns do we need to show line numbers, authors,
  * and filenames?
  */
-static void find_alignment(struct scoreboard *sb, int *option)
+static void find_alignment(struct blame_scoreboard *sb, int *option)
 {
 	int longest_src_lines = 0;
 	int longest_dst_lines = 0;
@@ -2043,7 +2016,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
  * For debugging -- origin is refcounted, and this asserts that
  * we do not underflow.
  */
-static void sanity_check_refcnt(struct scoreboard *sb)
+static void sanity_check_refcnt(struct blame_scoreboard *sb)
 {
 	int baa = 0;
 	struct blame_entry *ent;
@@ -2334,14 +2307,14 @@ static struct commit *find_single_final(struct rev_info *revs,
 	return found;
 }
 
-static char *prepare_final(struct scoreboard *sb)
+static char *prepare_final(struct blame_scoreboard *sb)
 {
 	const char *name;
 	sb->final = find_single_final(sb->revs, &name);
 	return xstrdup_or_null(name);
 }
 
-static const char *dwim_reverse_initial(struct scoreboard *sb)
+static const char *dwim_reverse_initial(struct blame_scoreboard *sb)
 {
 	/*
 	 * DWIM "git blame --reverse ONE -- PATH" as
@@ -2376,7 +2349,7 @@ static const char *dwim_reverse_initial(struct scoreboard *sb)
 	return sb->revs->pending.objects[0].name;
 }
 
-static char *prepare_initial(struct scoreboard *sb)
+static char *prepare_initial(struct blame_scoreboard *sb)
 {
 	int i;
 	const char *final_commit_name = NULL;
@@ -2445,7 +2418,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	const char *path;
-	struct scoreboard sb;
+	struct blame_scoreboard sb;
 	struct blame_origin *o;
 	struct blame_entry *ent = NULL;
 	long dashdash_pos, lno;
-- 
2.9.3

