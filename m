Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A864620281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969174AbdEXFRD (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:03 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34566 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969166AbdEXFQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id w10so31063240oif.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QxJEeYXHJ1g/7c8y8sHjgauQtuJiUmH+sVJODmdRaJk=;
        b=jmHQUu07FsloyLA89exFRGan+e0HabYbCom7HJ3fb9nXmfRpgRi0L22qc+SkRNyz37
         ihTbdW+p4tKCb8lnTce6jJUkS/Q95PeY4LzxVWpV0Veo4SboQaaOQEXFwJD+K5qkc2jb
         iyrxTfnEAvrPDiuDpJ6xOqamo64fBc42U2+aTp46YR3j/1So+3pUVqmYlGBHdhlm/9tu
         J2NPDKBlFElDslob90KMOyqz3nbgkg/WznOtucVxmlcXvWgibYKPTzp7qd3kbH0mBP91
         Cjvm7p1Rqm3pdY5gs8dVjJK3YtF4fYwGtmwC+sv9th0pJNYJoIzc1Tgp8oybCCYZ54Q0
         JX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QxJEeYXHJ1g/7c8y8sHjgauQtuJiUmH+sVJODmdRaJk=;
        b=RQTsw9Lz4dYnpB7A74QTy/Tx7tH4K+qu/Z7dUMRAqpKaX/S02dLMPnRHBaukPeE5T8
         8MM/GicOeBJOTVZC/waXces6bWZ8QlgYm9uFuKr2RvWB+kSUsrvZRCq6FU7oLNR6J1la
         UNvj1Fx8So0tMsEj3QaYVjZwMPYuli2BVUSpwLi5C2f/nGTslANo+2TvGbx0X64ZjKSH
         +Ys6yUTxC9WU4gGZs9lqn1Rga/LisZwSINCFHOFCl7Lbtkru6sPkE/5KgiCkPX+krAvJ
         Bx3yDhEcvcDu5QkPhZodGAEDYOtBxTbJPJbvWwf8/tQQ5wEYVA6tET+o3vqWIThJanjU
         Steg==
X-Gm-Message-State: AODbwcBlnb6SyRxFLiM3n1g9B3jKyvHtRvp7bOBcxZSSOjSbUHNewckS
        ZJcC2SxlY7r80A==
X-Received: by 10.202.79.197 with SMTP id d188mr16709337oib.137.1495603012356;
        Tue, 23 May 2017 22:16:52 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:51 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 24/29] blame: move core structures to header
Date:   Wed, 24 May 2017 00:15:32 -0500
Message-Id: <20170524051537.29978-25-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The origin, entry, and scoreboard structures are core to the blame
interface and need to be exposed for blame functionality.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin/blame.c | 134 +---------------------------------------------------
 2 files changed, 144 insertions(+), 133 deletions(-)
 create mode 100644 blame.h

diff --git a/blame.h b/blame.h
new file mode 100644
index 0000000..c064d92
--- /dev/null
+++ b/blame.h
@@ -0,0 +1,143 @@
+#ifndef BLAME_H
+#define BLAME_H
+
+#include "cache.h"
+#include "commit.h"
+#include "xdiff-interface.h"
+#include "revision.h"
+#include "prio-queue.h"
+
+/*
+ * One blob in a commit that is being suspected
+ */
+struct blame_origin {
+	int refcnt;
+	/* Record preceding blame record for this blob */
+	struct blame_origin *previous;
+	/* origins are put in a list linked via `next' hanging off the
+	 * corresponding commit's util field in order to make finding
+	 * them fast.  The presence in this chain does not count
+	 * towards the origin's reference count.  It is tempting to
+	 * let it count as long as the commit is pending examination,
+	 * but even under circumstances where the commit will be
+	 * present multiple times in the priority queue of unexamined
+	 * commits, processing the first instance will not leave any
+	 * work requiring the origin data for the second instance.  An
+	 * interspersed commit changing that would have to be
+	 * preexisting with a different ancestry and with the same
+	 * commit date in order to wedge itself between two instances
+	 * of the same commit in the priority queue _and_ produce
+	 * blame entries relevant for it.  While we don't want to let
+	 * us get tripped up by this case, it certainly does not seem
+	 * worth optimizing for.
+	 */
+	struct blame_origin *next;
+	struct commit *commit;
+	/* `suspects' contains blame entries that may be attributed to
+	 * this origin's commit or to parent commits.  When a commit
+	 * is being processed, all suspects will be moved, either by
+	 * assigning them to an origin in a different commit, or by
+	 * shipping them to the scoreboard's ent list because they
+	 * cannot be attributed to a different commit.
+	 */
+	struct blame_entry *suspects;
+	mmfile_t file;
+	struct object_id blob_oid;
+	unsigned mode;
+	/* guilty gets set when shipping any suspects to the final
+	 * blame list instead of other commits
+	 */
+	char guilty;
+	char path[FLEX_ARRAY];
+};
+
+/*
+ * Each group of lines is described by a blame_entry; it can be split
+ * as we pass blame to the parents.  They are arranged in linked lists
+ * kept as `suspects' of some unprocessed origin, or entered (when the
+ * blame origin has been finalized) into the scoreboard structure.
+ * While the scoreboard structure is only sorted at the end of
+ * processing (according to final image line number), the lists
+ * attached to an origin are sorted by the target line number.
+ */
+struct blame_entry {
+	struct blame_entry *next;
+
+	/* the first line of this group in the final image;
+	 * internally all line numbers are 0 based.
+	 */
+	int lno;
+
+	/* how many lines this group has */
+	int num_lines;
+
+	/* the commit that introduced this group into the final image */
+	struct blame_origin *suspect;
+
+	/* the line number of the first line of this group in the
+	 * suspect's file; internally all line numbers are 0 based.
+	 */
+	int s_lno;
+
+	/* how significant this entry is -- cached to avoid
+	 * scanning the lines over and over.
+	 */
+	unsigned score;
+};
+
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
+
+	/* stats */
+	int num_read_blob;
+	int num_get_patch;
+	int num_commits;
+
+	/*
+	 * blame for a blame_entry with score lower than these thresholds
+	 * is not passed to the parent using move/copy logic.
+	 */
+	unsigned move_score;
+	unsigned copy_score;
+
+	/* use this file's contents as the final image */
+	const char *contents_from;
+
+	/* flags */
+	int reverse;
+	int show_root;
+	int xdl_opts;
+	int no_whole_file_rename;
+	int debug;
+
+	/* callbacks */
+	void(*on_sanity_fail)(struct blame_scoreboard *, int);
+	void(*found_guilty_entry)(struct blame_entry *, void *);
+
+	void *found_guilty_entry_data;
+};
+
+#endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 29771b7..07b1a76 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -28,6 +28,7 @@
 #include "line-log.h"
 #include "dir.h"
 #include "progress.h"
+#include "blame.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
@@ -75,50 +76,6 @@ static unsigned blame_copy_score;
 #define METAINFO_SHOWN		(1u<<12)
 #define MORE_THAN_ONE_PATH	(1u<<13)
 
-/*
- * One blob in a commit that is being suspected
- */
-struct blame_origin {
-	int refcnt;
-	/* Record preceding blame record for this blob */
-	struct blame_origin *previous;
-	/* origins are put in a list linked via `next' hanging off the
-	 * corresponding commit's util field in order to make finding
-	 * them fast.  The presence in this chain does not count
-	 * towards the origin's reference count.  It is tempting to
-	 * let it count as long as the commit is pending examination,
-	 * but even under circumstances where the commit will be
-	 * present multiple times in the priority queue of unexamined
-	 * commits, processing the first instance will not leave any
-	 * work requiring the origin data for the second instance.  An
-	 * interspersed commit changing that would have to be
-	 * preexisting with a different ancestry and with the same
-	 * commit date in order to wedge itself between two instances
-	 * of the same commit in the priority queue _and_ produce
-	 * blame entries relevant for it.  While we don't want to let
-	 * us get tripped up by this case, it certainly does not seem
-	 * worth optimizing for.
-	 */
-	struct blame_origin *next;
-	struct commit *commit;
-	/* `suspects' contains blame entries that may be attributed to
-	 * this origin's commit or to parent commits.  When a commit
-	 * is being processed, all suspects will be moved, either by
-	 * assigning them to an origin in a different commit, or by
-	 * shipping them to the scoreboard's ent list because they
-	 * cannot be attributed to a different commit.
-	 */
-	struct blame_entry *suspects;
-	mmfile_t file;
-	struct object_id blob_oid;
-	unsigned mode;
-	/* guilty gets set when shipping any suspects to the final
-	 * blame list instead of other commits
-	 */
-	char guilty;
-	char path[FLEX_ARRAY];
-};
-
 struct progress_info {
 	struct progress *progress;
 	int blamed_lines;
@@ -209,40 +166,6 @@ static void drop_origin_blob(struct blame_origin *o)
 }
 
 /*
- * Each group of lines is described by a blame_entry; it can be split
- * as we pass blame to the parents.  They are arranged in linked lists
- * kept as `suspects' of some unprocessed origin, or entered (when the
- * blame origin has been finalized) into the scoreboard structure.
- * While the scoreboard structure is only sorted at the end of
- * processing (according to final image line number), the lists
- * attached to an origin are sorted by the target line number.
- */
-struct blame_entry {
-	struct blame_entry *next;
-
-	/* the first line of this group in the final image;
-	 * internally all line numbers are 0 based.
-	 */
-	int lno;
-
-	/* how many lines this group has */
-	int num_lines;
-
-	/* the commit that introduced this group into the final image */
-	struct blame_origin *suspect;
-
-	/* the line number of the first line of this group in the
-	 * suspect's file; internally all line numbers are 0 based.
-	 */
-	int s_lno;
-
-	/* how significant this entry is -- cached to avoid
-	 * scanning the lines over and over.
-	 */
-	unsigned score;
-};
-
-/*
  * Any merge of blames happens on lists of blames that arrived via
  * different parents in a single suspect.  In this case, we want to
  * sort according to the suspect line numbers as opposed to the final
@@ -335,61 +258,6 @@ static int compare_commits_by_reverse_commit_date(const void *a,
 	return -compare_commits_by_commit_date(a, b, c);
 }
 
-/*
- * The current state of the blame assignment.
- */
-struct blame_scoreboard {
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
-
-	/* stats */
-	int num_read_blob;
-	int num_get_patch;
-	int num_commits;
-
-	/*
-	 * blame for a blame_entry with score lower than these thresholds
-	 * is not passed to the parent using move/copy logic.
-	 */
-	unsigned move_score;
-	unsigned copy_score;
-
-	/* use this file's contents as the final image */
-	const char *contents_from;
-
-	/* flags */
-	int reverse;
-	int show_root;
-	int xdl_opts;
-	int no_whole_file_rename;
-	int debug;
-
-	/* callbacks */
-	void(*on_sanity_fail)(struct blame_scoreboard *, int);
-	void(*found_guilty_entry)(struct blame_entry *, void *);
-
-	void *found_guilty_entry_data;
-};
-
 static void blame_sort_final(struct blame_scoreboard *sb)
 {
 	sb->ent = llist_mergesort(sb->ent, get_next_blame, set_next_blame,
-- 
2.9.3

