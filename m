Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0FE20281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969131AbdEXFQ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:28 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34394 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969121AbdEXFQW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id w10so31061794oif.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q342hET8WIWSq+3oou47s9w+XI71mBeRy1beJ4jqCW4=;
        b=QKw2Uo8vq9w1ntSExyvvI74hMCAjk1+7iO5jYxbvSNMgnF6wFkOIResusvref255PS
         WLxeA9vIxOTFqFW3iC+Zxc4h9aaxUk3OkKr2IcJO3YdZYkHt/MTXhZq4Tr8mGpONrctj
         EyXYJnzRO1eSeDQHtH4+S0FOy1wLGKJn/gbC8i5ZlRwxpsUm3D8xN4783gS4Yq8uLxYA
         61dkfHliTiXzxog+Ovv1zgah1rOeUBRYddyVGZU2rwJXek2UefAWqgwaAHqVNnGL0wq5
         giukvnKLqpYjSY8RPMn2jKauvevPzbxalI1qPuUJ2wPwo1r2j3UGiuUGEco64J0Ahdj8
         FbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q342hET8WIWSq+3oou47s9w+XI71mBeRy1beJ4jqCW4=;
        b=e5fti6y2Y54PJ2Zq2XjSHngmSB3kB2+1SY2m1lg+skBsPMDLupDjfy5rVO63ZXz5Ru
         VhfSjr3+wW7kFofzSmq0SGVGiQnBUy8nr9k1lYzZLrEhlKmTZaQwFj0JbD7vhata5fdg
         VW+D8bU7xCnuB3FUn4pkUYIvZsWAhPTtJRSxIf0OcH7QT0I5DVVDhsFSBrJusmL8ev7X
         ADeTdiSpEXxuKzmRfQ+3ORrqUoz/8tMOo+j9FGBiknMfION5M6yv+DKKP9Ld0SRAkmQF
         xwQSn1fDj4Zh+64Pkt/18ns4xbhUVuQgpMt8YlD6sdyhHJKB/a0Nm5Plf5loT0IhZjs1
         92lw==
X-Gm-Message-State: AODbwcAJquKPWKCVH+0hE711DqTYjvQv9CbningMLl05/yftEyl5mnFv
        DkC3bizOPVoQIw==
X-Received: by 10.157.10.108 with SMTP id 99mr3958220otg.100.1495602981225;
        Tue, 23 May 2017 22:16:21 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:20 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 04/29] blame: rename origin structure to blame_origin
Date:   Wed, 24 May 2017 00:15:12 -0500
Message-Id: <20170524051537.29978-5-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The origin structure is core to the blame interface.  Since origin will
become more exposed, rename it to blame_origin to clarify what it is a
part of.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 114 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 3529f01..3e8aaa4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -87,10 +87,10 @@ static unsigned blame_copy_score;
 /*
  * One blob in a commit that is being suspected
  */
-struct origin {
+struct blame_origin {
 	int refcnt;
 	/* Record preceding blame record for this blob */
-	struct origin *previous;
+	struct blame_origin *previous;
 	/* origins are put in a list linked via `next' hanging off the
 	 * corresponding commit's util field in order to make finding
 	 * them fast.  The presence in this chain does not count
@@ -108,7 +108,7 @@ struct origin {
 	 * us get tripped up by this case, it certainly does not seem
 	 * worth optimizing for.
 	 */
-	struct origin *next;
+	struct blame_origin *next;
 	struct commit *commit;
 	/* `suspects' contains blame entries that may be attributed to
 	 * this origin's commit or to parent commits.  When a commit
@@ -151,7 +151,7 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
  * diff machinery
  */
 static void fill_origin_blob(struct diff_options *opt,
-			     struct origin *o, mmfile_t *file)
+			     struct blame_origin *o, mmfile_t *file)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
@@ -180,17 +180,17 @@ static void fill_origin_blob(struct diff_options *opt,
  * Origin is refcounted and usually we keep the blob contents to be
  * reused.
  */
-static inline struct origin *origin_incref(struct origin *o)
+static inline struct blame_origin *origin_incref(struct blame_origin *o)
 {
 	if (o)
 		o->refcnt++;
 	return o;
 }
 
-static void origin_decref(struct origin *o)
+static void origin_decref(struct blame_origin *o)
 {
 	if (o && --o->refcnt <= 0) {
-		struct origin *p, *l = NULL;
+		struct blame_origin *p, *l = NULL;
 		if (o->previous)
 			origin_decref(o->previous);
 		free(o->file.ptr);
@@ -209,7 +209,7 @@ static void origin_decref(struct origin *o)
 	}
 }
 
-static void drop_origin_blob(struct origin *o)
+static void drop_origin_blob(struct blame_origin *o)
 {
 	if (o->file.ptr) {
 		free(o->file.ptr);
@@ -238,7 +238,7 @@ struct blame_entry {
 	int num_lines;
 
 	/* the commit that introduced this group into the final image */
-	struct origin *suspect;
+	struct blame_origin *suspect;
 
 	/* the line number of the first line of this group in the
 	 * suspect's file; internally all line numbers are 0 based.
@@ -410,13 +410,13 @@ static void coalesce(struct scoreboard *sb)
  * the commit priority queue of the score board.
  */
 
-static void queue_blames(struct scoreboard *sb, struct origin *porigin,
+static void queue_blames(struct scoreboard *sb, struct blame_origin *porigin,
 			 struct blame_entry *sorted)
 {
 	if (porigin->suspects)
 		porigin->suspects = blame_merge(porigin->suspects, sorted);
 	else {
-		struct origin *o;
+		struct blame_origin *o;
 		for (o = porigin->commit->util; o; o = o->next) {
 			if (o->suspects) {
 				porigin->suspects = sorted;
@@ -434,9 +434,9 @@ static void queue_blames(struct scoreboard *sb, struct origin *porigin,
  * get_origin() to obtain shared, refcounted copy instead of calling
  * this function directly.
  */
-static struct origin *make_origin(struct commit *commit, const char *path)
+static struct blame_origin *make_origin(struct commit *commit, const char *path)
 {
-	struct origin *o;
+	struct blame_origin *o;
 	FLEX_ALLOC_STR(o, path, path);
 	o->commit = commit;
 	o->refcnt = 1;
@@ -449,9 +449,9 @@ static struct origin *make_origin(struct commit *commit, const char *path)
  * Locate an existing origin or create a new one.
  * This moves the origin to front position in the commit util list.
  */
-static struct origin *get_origin(struct commit *commit, const char *path)
+static struct blame_origin *get_origin(struct commit *commit, const char *path)
 {
-	struct origin *o, *l;
+	struct blame_origin *o, *l;
 
 	for (o = commit->util, l = NULL; o; l = o, o = o->next) {
 		if (!strcmp(o->path, path)) {
@@ -476,7 +476,7 @@ static struct origin *get_origin(struct commit *commit, const char *path)
  *
  * This also fills origin->mode for corresponding tree path.
  */
-static int fill_blob_sha1_and_mode(struct origin *origin)
+static int fill_blob_sha1_and_mode(struct blame_origin *origin)
 {
 	if (!is_null_oid(&origin->blob_oid))
 		return 0;
@@ -497,10 +497,10 @@ static int fill_blob_sha1_and_mode(struct origin *origin)
  * We have an origin -- check if the same path exists in the
  * parent and return an origin structure to represent it.
  */
-static struct origin *find_origin(struct commit *parent,
-				  struct origin *origin)
+static struct blame_origin *find_origin(struct commit *parent,
+				  struct blame_origin *origin)
 {
-	struct origin *porigin;
+	struct blame_origin *porigin;
 	struct diff_options diff_opts;
 	const char *paths[2];
 
@@ -585,10 +585,10 @@ static struct origin *find_origin(struct commit *parent,
  * We have an origin -- find the path that corresponds to it in its
  * parent and return an origin structure to represent it.
  */
-static struct origin *find_rename(struct commit *parent,
-				  struct origin *origin)
+static struct blame_origin *find_rename(struct commit *parent,
+				  struct blame_origin *origin)
 {
-	struct origin *porigin = NULL;
+	struct blame_origin *porigin = NULL;
 	struct diff_options diff_opts;
 	int i;
 
@@ -680,7 +680,7 @@ static const char *nth_line_cb(void *data, long lno)
 static void split_overlap(struct blame_entry *split,
 			  struct blame_entry *e,
 			  int tlno, int plno, int same,
-			  struct origin *parent)
+			  struct blame_origin *parent)
 {
 	int chunk_end_lno;
 	memset(split, 0, sizeof(struct blame_entry [3]));
@@ -804,7 +804,7 @@ static struct blame_entry *reverse_blame(struct blame_entry *head,
  */
 static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			int tlno, int offset, int same,
-			struct origin *parent)
+			struct blame_origin *parent)
 {
 	struct blame_entry *e = **srcq;
 	struct blame_entry *samep = NULL, *diffp = NULL;
@@ -895,7 +895,7 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 }
 
 struct blame_chunk_cb_data {
-	struct origin *parent;
+	struct blame_origin *parent;
 	long offset;
 	struct blame_entry **dstq;
 	struct blame_entry **srcq;
@@ -920,8 +920,8 @@ static int blame_chunk_cb(long start_a, long count_a,
  * which lines came from parent and pass blame for them.
  */
 static void pass_blame_to_parent(struct scoreboard *sb,
-				 struct origin *target,
-				 struct origin *parent)
+				 struct blame_origin *target,
+				 struct blame_origin *parent)
 {
 	mmfile_t file_p, file_o;
 	struct blame_chunk_cb_data d;
@@ -1023,7 +1023,7 @@ static void copy_split_if_better(struct scoreboard *sb,
 static void handle_split(struct scoreboard *sb,
 			 struct blame_entry *ent,
 			 int tlno, int plno, int same,
-			 struct origin *parent,
+			 struct blame_origin *parent,
 			 struct blame_entry *split)
 {
 	if (ent->num_lines <= tlno)
@@ -1041,7 +1041,7 @@ static void handle_split(struct scoreboard *sb,
 struct handle_split_cb_data {
 	struct scoreboard *sb;
 	struct blame_entry *ent;
-	struct origin *parent;
+	struct blame_origin *parent;
 	struct blame_entry *split;
 	long plno;
 	long tlno;
@@ -1065,7 +1065,7 @@ static int handle_split_cb(long start_a, long count_a,
  */
 static void find_copy_in_blob(struct scoreboard *sb,
 			      struct blame_entry *ent,
-			      struct origin *parent,
+			      struct blame_origin *parent,
 			      struct blame_entry *split,
 			      mmfile_t *file_p)
 {
@@ -1129,8 +1129,8 @@ static struct blame_entry **filter_small(struct scoreboard *sb,
 static void find_move_in_parent(struct scoreboard *sb,
 				struct blame_entry ***blamed,
 				struct blame_entry **toosmall,
-				struct origin *target,
-				struct origin *parent)
+				struct blame_origin *target,
+				struct blame_origin *parent)
 {
 	struct blame_entry *e, split[3];
 	struct blame_entry *unblamed = target->suspects;
@@ -1205,9 +1205,9 @@ static struct blame_list *setup_blame_list(struct blame_entry *unblamed,
 static void find_copy_in_parent(struct scoreboard *sb,
 				struct blame_entry ***blamed,
 				struct blame_entry **toosmall,
-				struct origin *target,
+				struct blame_origin *target,
 				struct commit *parent,
-				struct origin *porigin,
+				struct blame_origin *porigin,
 				int opt)
 {
 	struct diff_options diff_opts;
@@ -1254,7 +1254,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 
 		for (i = 0; i < diff_queued_diff.nr; i++) {
 			struct diff_filepair *p = diff_queued_diff.queue[i];
-			struct origin *norigin;
+			struct blame_origin *norigin;
 			mmfile_t file_p;
 			struct blame_entry this[3];
 
@@ -1309,7 +1309,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
  * origin is suspected for can be blamed on the parent.
  */
 static void pass_whole_blame(struct scoreboard *sb,
-			     struct origin *origin, struct origin *porigin)
+			     struct blame_origin *origin, struct blame_origin *porigin)
 {
 	struct blame_entry *e, *suspects;
 
@@ -1361,7 +1361,7 @@ static void distribute_blame(struct scoreboard *sb, struct blame_entry *blamed)
 	blamed = blame_sort(blamed, compare_blame_suspect);
 	while (blamed)
 	{
-		struct origin *porigin = blamed->suspect;
+		struct blame_origin *porigin = blamed->suspect;
 		struct blame_entry *suspects = NULL;
 		do {
 			struct blame_entry *next = blamed->next;
@@ -1376,14 +1376,14 @@ static void distribute_blame(struct scoreboard *sb, struct blame_entry *blamed)
 
 #define MAXSG 16
 
-static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
+static void pass_blame(struct scoreboard *sb, struct blame_origin *origin, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	int i, pass, num_sg;
 	struct commit *commit = origin->commit;
 	struct commit_list *sg;
-	struct origin *sg_buf[MAXSG];
-	struct origin *porigin, **sg_origin = sg_buf;
+	struct blame_origin *sg_buf[MAXSG];
+	struct blame_origin *porigin, **sg_origin = sg_buf;
 	struct blame_entry *toosmall = NULL;
 	struct blame_entry *blames, **blametail = &blames;
 
@@ -1400,7 +1400,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * common cases, then we look for renames in the second pass.
 	 */
 	for (pass = 0; pass < 2 - no_whole_file_rename; pass++) {
-		struct origin *(*find)(struct commit *, struct origin *);
+		struct blame_origin *(*find)(struct commit *, struct blame_origin *);
 		find = pass ? find_rename : find_origin;
 
 		for (i = 0, sg = first_scapegoat(revs, commit);
@@ -1438,7 +1438,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	for (i = 0, sg = first_scapegoat(revs, commit);
 	     i < num_sg && sg;
 	     sg = sg->next, i++) {
-		struct origin *porigin = sg_origin[i];
+		struct blame_origin *porigin = sg_origin[i];
 		if (!porigin)
 			continue;
 		if (!origin->previous) {
@@ -1459,7 +1459,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 			for (i = 0, sg = first_scapegoat(revs, commit);
 			     i < num_sg && sg;
 			     sg = sg->next, i++) {
-				struct origin *porigin = sg_origin[i];
+				struct blame_origin *porigin = sg_origin[i];
 				if (!porigin)
 					continue;
 				find_move_in_parent(sb, &blametail, &toosmall, origin, porigin);
@@ -1486,7 +1486,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 		for (i = 0, sg = first_scapegoat(revs, commit);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
-			struct origin *porigin = sg_origin[i];
+			struct blame_origin *porigin = sg_origin[i];
 			find_copy_in_parent(sb, &blametail, &toosmall,
 					    origin, sg->item, porigin, opt);
 			if (!origin->suspects)
@@ -1665,10 +1665,10 @@ static void get_commit_info(struct commit *commit,
  * To allow LF and other nonportable characters in pathnames,
  * they are c-style quoted as needed.
  */
-static void write_filename_info(struct origin *suspect)
+static void write_filename_info(struct blame_origin *suspect)
 {
 	if (suspect->previous) {
-		struct origin *prev = suspect->previous;
+		struct blame_origin *prev = suspect->previous;
 		printf("previous %s ", oid_to_hex(&prev->commit->object.oid));
 		write_name_quoted(prev->path, stdout, '\n');
 	}
@@ -1682,7 +1682,7 @@ static void write_filename_info(struct origin *suspect)
  * the first time each commit appears in the output (unless the
  * user has specifically asked for us to repeat).
  */
-static int emit_one_suspect_detail(struct origin *suspect, int repeat)
+static int emit_one_suspect_detail(struct blame_origin *suspect, int repeat)
 {
 	struct commit_info ci;
 
@@ -1716,7 +1716,7 @@ static void found_guilty_entry(struct blame_entry *ent,
 			   struct progress_info *pi)
 {
 	if (incremental) {
-		struct origin *suspect = ent->suspect;
+		struct blame_origin *suspect = ent->suspect;
 
 		printf("%s %d %d %d\n",
 		       oid_to_hex(&suspect->commit->object.oid),
@@ -1745,7 +1745,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 
 	while (commit) {
 		struct blame_entry *ent;
-		struct origin *suspect = commit->util;
+		struct blame_origin *suspect = commit->util;
 
 		/* find one suspect to break down */
 		while (suspect && !suspect->suspects)
@@ -1842,7 +1842,7 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 #define OUTPUT_SHOW_EMAIL	0400
 #define OUTPUT_LINE_PORCELAIN 01000
 
-static void emit_porcelain_details(struct origin *suspect, int repeat)
+static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
 	if (emit_one_suspect_detail(suspect, repeat) ||
 	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
@@ -1855,7 +1855,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 	int repeat = opt & OUTPUT_LINE_PORCELAIN;
 	int cnt;
 	const char *cp;
-	struct origin *suspect = ent->suspect;
+	struct blame_origin *suspect = ent->suspect;
 	char hex[GIT_MAX_HEXSZ + 1];
 
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
@@ -1892,7 +1892,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 {
 	int cnt;
 	const char *cp;
-	struct origin *suspect = ent->suspect;
+	struct blame_origin *suspect = ent->suspect;
 	struct commit_info ci;
 	char hex[GIT_MAX_HEXSZ + 1];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
@@ -1974,7 +1974,7 @@ static void output(struct scoreboard *sb, int option)
 	if (option & OUTPUT_PORCELAIN) {
 		for (ent = sb->ent; ent; ent = ent->next) {
 			int count = 0;
-			struct origin *suspect;
+			struct blame_origin *suspect;
 			struct commit *commit = ent->suspect->commit;
 			if (commit->object.flags & MORE_THAN_ONE_PATH)
 				continue;
@@ -2052,7 +2052,7 @@ static int read_ancestry(const char *graft_file)
 	return 0;
 }
 
-static int update_auto_abbrev(int auto_abbrev, struct origin *suspect)
+static int update_auto_abbrev(int auto_abbrev, struct blame_origin *suspect)
 {
 	const char *uniq = find_unique_abbrev(suspect->commit->object.oid.hash,
 					      auto_abbrev);
@@ -2076,7 +2076,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
 	int auto_abbrev = DEFAULT_ABBREV;
 
 	for (e = sb->ent; e; e = e->next) {
-		struct origin *suspect = e->suspect;
+		struct blame_origin *suspect = e->suspect;
 		int num;
 
 		if (compute_auto_abbrev)
@@ -2268,7 +2268,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 					       const char *contents_from)
 {
 	struct commit *commit;
-	struct origin *origin;
+	struct blame_origin *origin;
 	struct commit_list **parent_tail, *parent;
 	struct object_id head_oid;
 	struct strbuf buf = STRBUF_INIT;
@@ -2523,7 +2523,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct rev_info revs;
 	const char *path;
 	struct scoreboard sb;
-	struct origin *o;
+	struct blame_origin *o;
 	struct blame_entry *ent = NULL;
 	long dashdash_pos, lno;
 	char *final_commit_name = NULL;
-- 
2.9.3

