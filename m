Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0AF207D6
	for <e@80x24.org>; Fri,  5 May 2017 05:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbdEEF1m (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 01:27:42 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33352 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdEEF1l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 01:27:41 -0400
Received: by mail-io0-f195.google.com with SMTP id l196so8640592ioe.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 22:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q5njyQyJu0DZesbDxRp+MdIc6W9smLSiusrR9QJHcPo=;
        b=DUNrWWhpZblfkjQxSHnTEB+qk2MI3ctUQc8EEYxWyWWq3q0rlFU76+z3LmJMNV8I4i
         0akwio5ZfhrWik9y07A1q6S/OK5qQqkz0macEf4p5qkpclFROPFKi3bFavjtlY6Jp8bI
         tCC6KoaMZkWElngtnDgAkAVS3J7tTvMFS38X1O4xOX237ZQuyR17ZNt/5Z4SGQ4OoKiN
         /2rkKkheJdEKx+b7PORjaVH3mC6JDI2dub7sMBu55C08U8e2aDa2xarJH/VFKFyAR1vQ
         RXRHCKXvqoZI3MQWvDyCLtll9Bm5QNm60xXwoTipoujFPS4XVM2UL/YwZDW9qxX8wnhU
         oxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q5njyQyJu0DZesbDxRp+MdIc6W9smLSiusrR9QJHcPo=;
        b=pa2nUyGaCm/SINdcJXqz9sUtfMVQFZ2YbzaCF2nM0zXgEYXDcSzDdT5PkjBVbTbWnG
         xOu8UOiHTeE1aBtkqhPCagvzzEl5JMt6WzoxY2NjjWb87N0lQvILUeJwca3zhI5gAdoI
         1891DvD9MvurfB1kPyGTt9g3ouHVF25ktWC84No9edjq0ThJwPMSu+rCAbCoBmg+vvFB
         PNoJgJHX5gYOd+PkKpbhiPnPuBnIDao8sjNVkcBQXVCdYOKjrUjyesmOkc9ugMpb1w03
         HUkrC8l6fFzl65T89YP4fzZsOtzrPd8UDwvXv/SBUXlO8f5j/l3Nbu4nkfImN9ph8mmA
         i9IA==
X-Gm-Message-State: AN3rC/5+pCVpCzofAyushdRSvgc9vX1KWkG2iidqfst/1eqpNLtXlF2I
        XRQRat9WFiqjhA==
X-Received: by 10.202.170.12 with SMTP id t12mr3968029oie.44.1493962060088;
        Thu, 04 May 2017 22:27:40 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 2sm2179586ota.46.2017.05.04.22.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 22:27:39 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH 05/10] Split blame origin into its own file
Date:   Fri,  5 May 2017 00:27:24 -0500
Message-Id: <20170505052729.7576-6-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170505052729.7576-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 Makefile        |   1 +
 builtin/blame.c | 151 +-------------------------------------------------------
 origin.c        |  62 +++++++++++++++++++++++
 origin.h        | 101 +++++++++++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+), 150 deletions(-)
 create mode 100644 origin.c
 create mode 100644 origin.h

diff --git a/Makefile b/Makefile
index e35542e..8cbb56c 100644
--- a/Makefile
+++ b/Makefile
@@ -791,6 +791,7 @@ LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
 LIB_OBJS += oidset.o
+LIB_OBJS += origin.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-check.o
diff --git a/builtin/blame.c b/builtin/blame.c
index cc46f56..7ee84c1 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -28,6 +28,7 @@
 #include "line-log.h"
 #include "dir.h"
 #include "progress.h"
+#include "origin.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
@@ -84,50 +85,6 @@ static unsigned blame_copy_score;
 #define METAINFO_SHOWN		(1u<<12)
 #define MORE_THAN_ONE_PATH	(1u<<13)
 
-/*
- * One blob in a commit that is being suspected
- */
-struct origin {
-	int refcnt;
-	/* Record preceding blame record for this blob */
-	struct origin *previous;
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
-	struct origin *next;
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
@@ -176,39 +133,6 @@ static void fill_origin_blob(struct diff_options *opt,
 		*file = o->file;
 }
 
-/*
- * Origin is refcounted and usually we keep the blob contents to be
- * reused.
- */
-static inline struct origin *origin_incref(struct origin *o)
-{
-	if (o)
-		o->refcnt++;
-	return o;
-}
-
-static void origin_decref(struct origin *o)
-{
-	if (o && --o->refcnt <= 0) {
-		struct origin *p, *l = NULL;
-		if (o->previous)
-			origin_decref(o->previous);
-		free(o->file.ptr);
-		/* Should be present exactly once in commit chain */
-		for (p = o->commit->util; p; l = p, p = p->next) {
-			if (p == o) {
-				if (l)
-					l->next = p->next;
-				else
-					o->commit->util = p->next;
-				free(o);
-				return;
-			}
-		}
-		die("internal error in blame::origin_decref");
-	}
-}
-
 static void drop_origin_blob(struct origin *o)
 {
 	if (o->file.ptr) {
@@ -218,40 +142,6 @@ static void drop_origin_blob(struct origin *o)
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
-	struct origin *suspect;
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
@@ -429,45 +319,6 @@ static void queue_blames(struct scoreboard *sb, struct origin *porigin,
 }
 
 /*
- * Given a commit and a path in it, create a new origin structure.
- * The callers that add blame to the scoreboard should use
- * get_origin() to obtain shared, refcounted copy instead of calling
- * this function directly.
- */
-static struct origin *make_origin(struct commit *commit, const char *path)
-{
-	struct origin *o;
-	FLEX_ALLOC_STR(o, path, path);
-	o->commit = commit;
-	o->refcnt = 1;
-	o->next = commit->util;
-	commit->util = o;
-	return o;
-}
-
-/*
- * Locate an existing origin or create a new one.
- * This moves the origin to front position in the commit util list.
- */
-static struct origin *get_origin(struct commit *commit, const char *path)
-{
-	struct origin *o, *l;
-
-	for (o = commit->util, l = NULL; o; l = o, o = o->next) {
-		if (!strcmp(o->path, path)) {
-			/* bump to front */
-			if (l) {
-				l->next = o->next;
-				o->next = commit->util;
-				commit->util = o;
-			}
-			return origin_incref(o);
-		}
-	}
-	return make_origin(commit, path);
-}
-
-/*
  * Fill the blob_sha1 field of an origin if it hasn't, so that later
  * call to fill_origin_blob() can use it to locate the data.  blob_sha1
  * for an origin is also used to pass the blame for the entire file to
diff --git a/origin.c b/origin.c
new file mode 100644
index 0000000..2ec25c7
--- /dev/null
+++ b/origin.c
@@ -0,0 +1,62 @@
+#include "origin.h"
+
+void origin_decref(struct origin *o)
+{
+	if (o && --o->refcnt <= 0) {
+		struct origin *p, *l = NULL;
+		if (o->previous)
+			origin_decref(o->previous);
+		free(o->file.ptr);
+		/* Should be present exactly once in commit chain */
+		for (p = o->commit->util; p; l = p, p = p->next) {
+			if (p == o) {
+				if (l)
+					l->next = p->next;
+				else
+					o->commit->util = p->next;
+				free(o);
+				return;
+			}
+		}
+		die("internal error in blame::origin_decref");
+	}
+}
+
+/*
+ * Given a commit and a path in it, create a new origin structure.
+ * The callers that add blame to the scoreboard should use
+ * get_origin() to obtain shared, refcounted copy instead of calling
+ * this function directly.
+ */
+struct origin *make_origin(struct commit *commit, const char *path)
+{
+	struct origin *o;
+	FLEX_ALLOC_STR(o, path, path);
+	o->commit = commit;
+	o->refcnt = 1;
+	o->next = commit->util;
+	commit->util = o;
+	return o;
+}
+
+/*
+ * Locate an existing origin or create a new one.
+ * This moves the origin to front position in the commit util list.
+ */
+struct origin *get_origin(struct commit *commit, const char *path)
+{
+	struct origin *o, *l;
+
+	for (o = commit->util, l = NULL; o; l = o, o = o->next) {
+		if (!strcmp(o->path, path)) {
+			/* bump to front */
+			if (l) {
+				l->next = o->next;
+				o->next = commit->util;
+				commit->util = o;
+			}
+			return origin_incref(o);
+		}
+	}
+	return make_origin(commit, path);
+}
diff --git a/origin.h b/origin.h
new file mode 100644
index 0000000..a189b78
--- /dev/null
+++ b/origin.h
@@ -0,0 +1,101 @@
+#ifndef ORIGIN_H
+#define ORIGIN_H
+
+#include "cache.h"
+#include "commit.h"
+#include "xdiff-interface.h"
+
+/*
+ * One blob in a commit that is being suspected
+ */
+struct origin {
+	int refcnt;
+	/* Record preceding blame record for this blob */
+	struct origin *previous;
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
+	struct origin *next;
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
+	struct origin *suspect;
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
+ * Origin is refcounted and usually we keep the blob contents to be
+ * reused.
+ */
+static inline struct origin *origin_incref(struct origin *o)
+{
+	if (o)
+		o->refcnt++;
+	return o;
+}
+void origin_decref(struct origin *o);
+
+struct origin *make_origin(struct commit *commit, const char *path);
+struct origin *get_origin(struct commit *commit, const char *path);
+
+#endif /* ORIGIN_H */
-- 
2.9.3

