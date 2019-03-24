Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526B320248
	for <e@80x24.org>; Sun, 24 Mar 2019 23:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfCXXwQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 19:52:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38457 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfCXXwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 19:52:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so678268wro.5
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 16:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQbE37pRISI3LF4ePRkA0Go0lIK8EYgi5rJDQY1dhzg=;
        b=LKWnoKkzGrz2yvjJsu7XO/7nzOHunAQXV1/HXjf358cxnDK4SC8kYP77u6MZX8iLm8
         MGpMKsPnHLCOEy25viJ2AyV1eP0BmTDhtdzKkZF38ex6OFtuUY+4xxwRemIdbw0RZK1a
         7+zvyGipyThn0Ab2Re7rAHhV0gLjedMfvvtTZgGuK0LnvUzhBW4nLSBquTxCqASkGvfe
         bhF0qWsyJd/Yw+pNyhDaZgPt3o86241xZUTweDGRKFuXeXCcErX3FllrzXAlcLKkVcPI
         ScZTTxfjnlv+K8t1Pl/IjlefS/rCuR64yIIzae2K82xuWw+YLgrymS1k2R/fjf/92aPv
         9zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eQbE37pRISI3LF4ePRkA0Go0lIK8EYgi5rJDQY1dhzg=;
        b=en1nypMGpZZy+PIkrqW8GrGaDNi9HvsZCUQogLpcF37GXON3puXp1CAmDZBbgHj+KH
         13Iy/WIZ6UZknI1Utp2jSoCZYQJagBPRxxE2T5N+CfTQdxA9P5U1tjDUgrgSiCdwc/Wy
         X2/gV5pdLWMwqUu4psv2N3wf0dAAyV6BdLoQB/IAdHtCwtObn8Kza/OVKdpDuF6uFgRH
         IOKwYAFkE4kG8CuhD8nsmppsZzQAq9WNuveXUjXKg267Zwf/p0kGy1Kdsd9oF7PGlOFi
         ajd6JINRaK9IdxYP4HsnWWRN7/i5oQR0quRf+m3b1vBk7xNZ2+agvYGmNzxMTOEYuQyR
         uetg==
X-Gm-Message-State: APjAAAXNjYnarXNiIyaLrkOL5D7YBqQDh7X6OgvG8whBhp6rG7fvPdpq
        +PzmB2n4tVRTQrP0iIgpE5YDXZvouBg=
X-Google-Smtp-Source: APXvYqzUfSTJEDSNQJL3qPSzbMPd8oqQVAdySpjGvZAxC9iQ7YnlN/3oYbqc7MaM2gRK2r/rbS5YZQ==
X-Received: by 2002:adf:91c7:: with SMTP id 65mr14054455wri.191.1553471531927;
        Sun, 24 Mar 2019 16:52:11 -0700 (PDT)
Received: from localhost.localdomain (cpc91214-cmbg18-2-0-cust207.5-4.cable.virginm.net. [81.102.75.208])
        by smtp.gmail.com with ESMTPSA id x22sm14898317wmc.19.2019.03.24.16.52.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 24 Mar 2019 16:52:11 -0700 (PDT)
From:   michael@platin.gs
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Michael Platings <michael@platin.gs>
Subject: [RFC PATCH 1/1] Fuzzy blame
Date:   Sun, 24 Mar 2019 23:50:20 +0000
Message-Id: <20190324235020.49706-2-michael@platin.gs>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190324235020.49706-1-michael@platin.gs>
References: <20190324235020.49706-1-michael@platin.gs>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Platings <michael@platin.gs>

---
 blame.c                | 352 +++++++++++++++++++++++++++++++++++++++++++++++--
 blame.h                |   1 +
 builtin/blame.c        |   3 +
 t/t8020-blame-fuzzy.sh | 264 +++++++++++++++++++++++++++++++++++++
 4 files changed, 609 insertions(+), 11 deletions(-)
 create mode 100755 t/t8020-blame-fuzzy.sh

diff --git a/blame.c b/blame.c
index 5c07dec190..b5a40c8e9f 100644
--- a/blame.c
+++ b/blame.c
@@ -997,6 +997,326 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	return;
 }
 
+/* https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel */
+static int bitcount(uint32_t v) {
+	v = v - ((v >> 1) & 0x55555555u);
+	v = (v & 0x33333333u) + ((v >> 2) & 0x33333333u);
+	return ((v + (v >> 4) & 0xf0f0f0fu) * 0x1010101u) >> 24;
+}
+
+#define FINGERPRINT_LENGTH (8*256)
+/* This is just a bitset indicating which byte pairs are present.
+ e.g. the string "good goo" has pairs "go", "oo", "od", "d ", " g"
+ String similarity is calculated as a bitwise or and counting the set bits.
+ TODO for the string lengths we typically deal with, this would probably be
+ implemented more efficiently with a set data structure.
+ */
+struct fingerprint {
+	uint32_t bits[FINGERPRINT_LENGTH];
+};
+
+static void get_fingerprint(struct fingerprint *result,
+			    const char *line_begin, const char *line_end) {
+	memset(result, 0, sizeof(struct fingerprint));
+	for (const char *p = line_begin; p + 1 < line_end; ++p) {
+		unsigned c = tolower(*p) | (tolower(*(p + 1)) << 8);
+		result->bits[c >> 5] |= 1u << (c & 0x1f);
+	}
+}
+
+static int fingerprint_similarity(const struct fingerprint *a,
+				  const struct fingerprint *b) {
+	int intersection = 0;
+	for (int i = 0; i < FINGERPRINT_LENGTH; ++i) {
+		intersection += bitcount(a->bits[i] & b->bits[i]);
+	}
+	return intersection;
+}
+
+struct fuzzy_blame_parent_data {
+	struct blame_origin *parent;
+	long offset;
+	struct blame_entry **processed_entries;
+	struct blame_entry **target_entries;
+	const char *parent_content;
+	const char *target_content;
+	int *parent_line_starts;
+	int *target_line_starts;
+	int parent_line_count;
+	int target_line_count;
+};
+
+static void get_chunk_fingerprints(struct fingerprint *fingerprints,
+				   const char *content,
+				   const int *line_starts,
+				   long chunk_start,
+				   long chunk_length) {
+	line_starts += chunk_start;
+	for (int i = 0; i != chunk_length; ++i) {
+		const char* linestart = content + line_starts[i];
+		const char* lineend = content + line_starts[i + 1];
+		get_fingerprint(fingerprints + i, linestart, lineend);
+	}
+}
+
+/* This finds the line that we can match with the most confidence, and
+ uses it as a partition. It then calls itself on the lines on either side of
+ that partition. In this way we avoid lines appearing out of order, and retain
+ a sensible line ordering.
+ TODO: so much optimisation. Currently this does the same work repeatedly.
+ */
+static void fuzzy_find_matching_lines_recurse(
+		const char *content_a, const char *content_b,
+		const int *line_starts_a, const int *line_starts_b,
+		int start_a, int start_b,
+		int length_a, int length_b,
+		int *result,
+		struct fingerprint *fingerprints_a,
+		struct fingerprint *fingerprints_b) {
+
+	int most_certain_line = -1;
+	int most_certain_line_certainty = -1;
+
+	for (int i = 0; i < length_b; ++i) {
+		const struct fingerprint *fingerprint_b = fingerprints_b + i;
+
+		int closest_line_a = (i * 2 + 1) * length_a /
+		(length_b * 2);
+
+		/* Limit range of search to a reasonable number of lines.
+		 TODO consider scaling this up if length_a is greater than
+		 length_b. */
+		const int MAX_SEARCH_DISTANCE = 5;
+		int search_start = closest_line_a - (MAX_SEARCH_DISTANCE - 1);
+		int search_end = closest_line_a + MAX_SEARCH_DISTANCE;
+		if (search_start < 0) search_start = 0;
+		if (search_end > length_a) search_end = length_a;
+
+		/* Find both the best and 2nd best matches. The match certainty
+		 is the difference between these values. */
+		int best_similarity = 0, second_best_similarity = 0;
+		int best_similarity_index = 0;
+
+		for (int j = search_start; j < search_end; ++j) {
+			int similarity = fingerprint_similarity(
+								fingerprint_b,
+								fingerprints_a + j) *
+				(1000 - abs(j - closest_line_a));
+
+			if (similarity > best_similarity) {
+				second_best_similarity = best_similarity;
+				best_similarity = similarity;
+				best_similarity_index = j;
+			}
+			else if (similarity > second_best_similarity) {
+				second_best_similarity = similarity;
+			}
+		}
+
+		if (best_similarity == 0) {
+			result[i] = -1;
+			continue;
+		}
+
+		result[i] = start_a + best_similarity_index;
+
+		int certainty = best_similarity - second_best_similarity;
+		if (certainty > most_certain_line_certainty) {
+			most_certain_line_certainty = certainty;
+			most_certain_line = i;
+		}
+	}
+
+	if (most_certain_line == -1) {
+		return;
+	}
+
+	if (most_certain_line > 0) {
+		fuzzy_find_matching_lines_recurse(content_a, content_b, line_starts_a, line_starts_b, start_a, start_b, result[most_certain_line] + 1 - start_a, most_certain_line, result, fingerprints_a, fingerprints_b);
+	}
+	if (most_certain_line + 1 < length_b) {
+		int second_half_start_a = result[most_certain_line];
+		int second_half_start_b = start_b + most_certain_line + 1;
+		int second_half_length_a = length_a + start_a - second_half_start_a;
+		int second_half_length_b = length_b + start_b - second_half_start_b;
+		fuzzy_find_matching_lines_recurse(content_a, content_b, line_starts_a, line_starts_b, second_half_start_a, second_half_start_b, second_half_length_a, second_half_length_b, result + most_certain_line + 1, fingerprints_a + second_half_start_a - start_a, fingerprints_b + most_certain_line + 1);
+	}
+}
+
+/* Find line numbers in "a" that match with lines in "b"
+ Returns an array of either line indices or -1 where no match is found.
+ The returned array must be free()d after use.
+ */
+static int *fuzzy_find_matching_lines(
+	const char *content_a, const char *content_b,
+	const int *line_starts_a, const int *line_starts_b,
+	int start_a, int start_b,
+	int length_a, int length_b) {
+
+	int *result = malloc(sizeof(int) * length_b);
+
+	struct fingerprint *fingerprints_a =
+		malloc(sizeof(struct fingerprint) * length_a);
+	struct fingerprint *fingerprints_b =
+		malloc(sizeof(struct fingerprint) * length_b);
+
+	get_chunk_fingerprints(fingerprints_a, content_a,
+			       line_starts_a,
+			       start_a, length_a);
+	get_chunk_fingerprints(fingerprints_b, content_b,
+			       line_starts_b,
+			       start_b, length_b);
+
+	fuzzy_find_matching_lines_recurse(content_a, content_b,
+					    line_starts_a, line_starts_b,
+					    start_a, start_b,
+					    length_a, length_b,
+					    result,
+					    fingerprints_a,
+					    fingerprints_b);
+
+	free(fingerprints_a);
+	free(fingerprints_b);
+
+	return result;
+}
+
+static int blame_chunk_fuzzy(long parent_chunk_start,
+				  long parent_chunk_length,
+				  long target_chunk_start,
+				  long target_chunk_length,
+				  void *data)
+{
+	struct fuzzy_blame_parent_data *d = data;
+
+	if (parent_chunk_start - target_chunk_start != d->offset)
+		die("internal error in blame::blame_chunk_fuzzy");
+
+	int target_chunk_end = target_chunk_start + target_chunk_length;
+
+	struct blame_origin *parent = d->parent;
+	struct blame_entry *e = *d->target_entries;
+	struct blame_entry *parent_tail = NULL;
+	struct blame_entry *target_tail = NULL;
+
+	if (parent_chunk_length == 0) {
+		/* Don't try to blame parent for newly added lines */
+		while (e && e->s_lno < target_chunk_end) {
+			target_tail = e;
+			e = e->next;
+		}
+		d->target_entries = &target_tail->next;
+		goto finish;
+	}
+
+	int *matched_lines = fuzzy_find_matching_lines(
+		d->parent_content, d->target_content,
+		d->parent_line_starts, d->target_line_starts,
+		parent_chunk_start, target_chunk_start,
+		parent_chunk_length, target_chunk_length);
+
+	while (e && e->s_lno < target_chunk_end) {
+		struct blame_entry *next = e->next;
+
+		for (int i = 0; i < e->num_lines; ++i) {
+			struct blame_entry *n =
+				xcalloc(1, sizeof (struct blame_entry));
+			n->lno = e->lno + i;
+			n->num_lines = 1;
+			n->score = 0;
+
+			int matched_line = matched_lines[i + e->s_lno -
+				target_chunk_start];
+
+			if (matched_line != -1) {
+				n->suspect = blame_origin_incref(parent);
+				n->s_lno = matched_line;
+				n->next = parent_tail;
+				parent_tail = n;
+			} else {
+				n->suspect = blame_origin_incref(e->suspect);
+				n->s_lno = e->s_lno + i;
+				n->next = target_tail;
+				target_tail = n;
+			}
+		}
+
+		blame_origin_decref(e->suspect);
+		free(e);
+
+		e = next;
+	}
+
+	if (parent_tail) {
+		parent_tail = llist_mergesort(parent_tail, get_next_blame,
+					      set_next_blame,
+					      compare_blame_suspect);
+		*d->processed_entries = parent_tail;
+		while (parent_tail->next) parent_tail = parent_tail->next;
+		d->processed_entries = &parent_tail->next;
+	}
+
+	if (target_tail) {
+		target_tail = llist_mergesort(target_tail, get_next_blame,
+					      set_next_blame,
+					      compare_blame_suspect);
+		*d->target_entries = target_tail;
+		while (target_tail->next) target_tail = target_tail->next;
+		d->target_entries = &target_tail->next;
+	}
+
+	*d->target_entries = e;
+
+	free(matched_lines);
+
+finish:
+	d->offset = parent_chunk_start + parent_chunk_length -
+		(target_chunk_start + target_chunk_length);
+
+	return 0;
+}
+
+static int find_line_starts(int **line_starts, const char *buf, unsigned long len);
+
+static void pass_blame_to_parent_fuzzy(struct blame_scoreboard *sb,
+				       struct blame_origin *target,
+				       struct blame_origin *parent)
+{
+	mmfile_t file_p, file_o;
+	struct fuzzy_blame_parent_data d;
+	struct blame_entry *newdest = NULL;
+
+	if (!target->suspects)
+		return; /* nothing remains for this target */
+
+	d.parent = parent;
+	d.offset = 0;
+	d.processed_entries = &newdest;
+	d.target_entries = &target->suspects;
+
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
+	sb->num_get_patch++;
+
+	d.parent_content = file_p.ptr;
+	d.target_content = file_o.ptr;
+	d.parent_line_count = find_line_starts(&d.parent_line_starts, file_p.ptr, file_p.size);
+	d.target_line_count = find_line_starts(&d.target_line_starts, file_o.ptr, file_o.size);
+
+	if (diff_hunks(&file_p, &file_o, blame_chunk_fuzzy, &d, sb->xdl_opts))
+		die("unable to generate diff (%s -> %s)",
+			oid_to_hex(&parent->commit->object.oid),
+			oid_to_hex(&target->commit->object.oid));
+
+	*d.processed_entries = NULL;
+	queue_blames(sb, parent, newdest);
+
+	free(d.target_line_starts);
+	free(d.parent_line_starts);
+
+	return;
+}
+
 /*
  * The lines in blame_entry after splitting blames many times can become
  * very small and trivial, and at some point it becomes pointless to
@@ -1433,7 +1753,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	struct commit *commit = origin->commit;
 	struct commit_list *sg;
 	struct blame_origin *sg_buf[MAXSG];
-	struct blame_origin *porigin, **sg_origin = sg_buf;
+	struct blame_origin *porigin = NULL, **sg_origin = sg_buf;
 	struct blame_entry *toosmall = NULL;
 	struct blame_entry *blames, **blametail = &blames;
 
@@ -1560,6 +1880,11 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 		*tail = origin->suspects;
 		origin->suspects = toosmall;
 	}
+
+	if (sb->fuzzy && porigin) {
+		pass_blame_to_parent_fuzzy(sb, origin, porigin);
+	}
+
 	for (i = 0; i < num_sg; i++) {
 		if (sg_origin[i]) {
 			drop_origin_blob(sg_origin[i]);
@@ -1645,14 +1970,8 @@ static const char *get_next_line(const char *start, const char *end)
 	return nl ? nl + 1 : end;
 }
 
-/*
- * To allow quick access to the contents of nth line in the
- * final image, prepare an index in the scoreboard.
- */
-static int prepare_lines(struct blame_scoreboard *sb)
+static int find_line_starts(int **line_starts, const char *buf, unsigned long len)
 {
-	const char *buf = sb->final_buf;
-	unsigned long len = sb->final_buf_size;
 	const char *end = buf + len;
 	const char *p;
 	int *lineno;
@@ -1661,15 +1980,26 @@ static int prepare_lines(struct blame_scoreboard *sb)
 	for (p = buf; p < end; p = get_next_line(p, end))
 		num++;
 
-	ALLOC_ARRAY(sb->lineno, num + 1);
-	lineno = sb->lineno;
+	ALLOC_ARRAY(*line_starts, num + 1);
+	lineno = *line_starts;
 
 	for (p = buf; p < end; p = get_next_line(p, end))
 		*lineno++ = p - buf;
 
 	*lineno = len;
 
-	sb->num_lines = num;
+	return num;
+}
+
+/*
+ * To allow quick access to the contents of nth line in the
+ * final image, prepare an index in the scoreboard.
+ */
+static int prepare_lines(struct blame_scoreboard *sb)
+{
+	sb->num_lines = find_line_starts(&sb->lineno,
+									 sb->final_buf,
+									 sb->final_buf_size);
 	return sb->num_lines;
 }
 
diff --git a/blame.h b/blame.h
index be3a895043..eb528f9f80 100644
--- a/blame.h
+++ b/blame.h
@@ -142,6 +142,7 @@ struct blame_scoreboard {
 	int xdl_opts;
 	int no_whole_file_rename;
 	int debug;
+	int fuzzy;
 
 	/* callbacks */
 	void(*on_sanity_fail)(struct blame_scoreboard *, int);
diff --git a/builtin/blame.c b/builtin/blame.c
index 177c1022a0..d0a0dfff79 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -57,6 +57,7 @@ static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
 
 static struct string_list mailmap = STRING_LIST_INIT_NODUP;
+static int fuzzy;
 
 #ifndef DEBUG
 #define DEBUG 0
@@ -808,6 +809,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
+		OPT_BOOL('F', "fuzzy", &fuzzy, N_("Try to assign blame to similar lines in the parent")),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
@@ -996,6 +998,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	init_scoreboard(&sb);
 	sb.revs = &revs;
+	sb.fuzzy = fuzzy;
 	sb.contents_from = contents_from;
 	sb.reverse = reverse;
 	sb.repo = the_repository;
diff --git a/t/t8020-blame-fuzzy.sh b/t/t8020-blame-fuzzy.sh
new file mode 100755
index 0000000000..d26c945722
--- /dev/null
+++ b/t/t8020-blame-fuzzy.sh
@@ -0,0 +1,264 @@
+#!/bin/sh
+
+test_description='git blame ignore a specific revision'
+. ./test-lib.sh
+
+pick_author='s/^[0-9a-f^]* *(\([^ ]*\) .*/\1/'
+
+file_count=8
+
+# Each test is composed of 4 variables:
+# titleN - the test name
+# aN - the initial content
+# bN - the final content
+# expectedN - the line numbers from aN that we expect git blame
+#             on bN to identify, or "Final" if bN itself should
+#             be identified as the origin of that line.
+
+title1="Expand lines"
+cat <<EOF >a1
+aaa
+bbb
+ccc
+ddd
+eee
+EOF
+cat <<EOF >b1
+aaa
+bbbx
+bbbx
+ccc
+dddx
+dddx
+eee
+EOF
+cat <<EOF >expected1
+1
+2
+2
+3
+4
+4
+5
+EOF
+
+title2="Combine 3 lines into 2"
+cat <<EOF >a2
+if ((maxgrow==0) ||
+    ( single_line_field && (field->dcols < maxgrow)) ||
+    (!single_line_field && (field->drows < maxgrow)))
+EOF
+cat <<EOF >b2
+if ((maxgrow == 0) || (single_line_field && (field->dcols < maxgrow)) ||
+    (!single_line_field && (field->drows < maxgrow))) {
+EOF
+cat <<EOF >expected2
+2
+3
+EOF
+
+title3="Add curly brackets"
+cat <<EOF >a3
+    if (rows) *rows = field->rows;
+    if (cols) *cols = field->cols;
+    if (frow) *frow = field->frow;
+    if (fcol) *fcol = field->fcol;
+EOF
+cat <<EOF >b3
+    if (rows) {
+      *rows = field->rows;
+    }
+    if (cols) {
+      *cols = field->cols;
+    }
+    if (frow) {
+      *frow = field->frow;
+    }
+    if (fcol) {
+      *fcol = field->fcol;
+    }
+EOF
+cat <<EOF >expected3
+1
+1
+Final
+2
+2
+Final
+3
+3
+Final
+4
+4
+Final
+EOF
+
+
+title4="Combine many lines and change case"
+cat <<EOF >a4
+for(row=0,pBuffer=field->buf;
+    row<height;
+    row++,pBuffer+=width )
+  {
+    if ((len = (int)( After_End_Of_Data( pBuffer, width ) - pBuffer )) > 0)
+      {
+        wmove( win, row, 0 );
+        waddnstr( win, pBuffer, len );
+EOF
+cat <<EOF >b4
+for (Row = 0, PBuffer = field->buf; Row < Height; Row++, PBuffer += Width) {
+  if ((Len = (int)(afterEndOfData(PBuffer, Width) - PBuffer)) > 0) {
+    wmove(win, Row, 0);
+    waddnstr(win, PBuffer, Len);
+EOF
+cat <<EOF >expected4
+1
+5
+7
+8
+EOF
+
+title5="Rename and combine lines"
+cat <<EOF >a5
+bool need_visual_update = ((form != (FORM *)0)      &&
+                           (form->status & _POSTED) &&
+                           (form->current==field));
+
+if (need_visual_update)
+  Synchronize_Buffer(form);
+
+if (single_line_field)
+  {
+    growth = field->cols * amount;
+    if (field->maxgrow)
+      growth = Minimum(field->maxgrow - field->dcols,growth);
+    field->dcols += growth;
+    if (field->dcols == field->maxgrow)
+EOF
+cat <<EOF >b5
+bool NeedVisualUpdate = ((Form != (FORM *)0) && (Form->status & _POSTED) &&
+                         (Form->current == field));
+
+if (NeedVisualUpdate) {
+  synchronizeBuffer(Form);
+}
+
+if (SingleLineField) {
+  Growth = field->cols * amount;
+  if (field->maxgrow) {
+    Growth = Minimum(field->maxgrow - field->dcols, Growth);
+  }
+  field->dcols += Growth;
+  if (field->dcols == field->maxgrow) {
+EOF
+cat <<EOF >expected5
+1
+3
+4
+5
+6
+Final
+7
+8
+10
+11
+12
+Final
+13
+14
+EOF
+
+# Both lines match identically so position must be used to tie-break.
+title6="Same line twice"
+cat <<EOF >a6
+abc
+abc
+EOF
+cat <<EOF >b6
+abcd
+abcd
+EOF
+cat <<EOF >expected6
+1
+2
+EOF
+
+title7="Enforce line order"
+cat <<EOF >a7
+abcdef
+ghijkl
+ab
+EOF
+cat <<EOF >b7
+ghijk
+abcd
+EOF
+cat <<EOF >expected7
+2
+3
+EOF
+
+title8="Expand lines and rename variables"
+cat <<EOF >a8
+int myFunction(int ArgumentOne, Thing *ArgTwo, Blah XuglyBug) {
+  Squiggle FabulousResult = squargle(ArgumentOne, *ArgTwo,
+    XuglyBug) + EwwwGlobalWithAReallyLongNameYepTooLong;
+  return FabulousResult * 42;
+}
+EOF
+cat <<EOF >b8
+int myFunction(int argument_one, Thing *arg_asdfgh,
+    Blah xugly_bug) {
+  Squiggle fabulous_result = squargle(argument_one,
+    *arg_asdfgh, xugly_bug)
+    + g_ewww_global_with_a_really_long_name_yep_too_long;
+  return fabulous_result * 42;
+}
+EOF
+cat <<EOF >expected8
+1
+1
+2
+3
+3
+4
+5
+EOF
+
+test_expect_success setup '
+	{ for ((i=1;i<=$file_count;i++))
+	do
+		# Append each line in a separate commit to make it easy to
+		# check which original line the blame output relates to.
+
+		line_count=0 &&
+		{ while read line
+		do
+			line_count=$((line_count+1)) &&
+			echo $line >>"$i" &&
+			git add "$i" &&
+			test_tick &&
+			GIT_AUTHOR_NAME="$line_count" git commit -m "$line_count"
+		done } <"a$i"
+	done } &&
+
+	{ for ((i=1;i<=$file_count;i++))
+	do
+		# Overwrite the files with the final content.
+		cp b$i $i &&
+		git add $i &&
+		test_tick
+	done } &&
+
+	# Commit the final content all at once so it can all be
+	# referred to with the same commit ID.
+	GIT_AUTHOR_NAME=Final git commit -m Final
+'
+
+for ((i=1;i<=$file_count;i++)); do
+	title="title$i"
+	test_expect_success "${!title}" \
+	"git blame --fuzzy -- $i | sed -e \"$pick_author\" >actual && test_cmp expected$i actual"
+done
+
+test_done
-- 
2.14.3 (Apple Git-98)

