Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542BD12D1FD
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669032; cv=none; b=Atbgr2FIXjP6qDWHWELgvXM1YutvMuQQK4V4sVatxfcBT0ST/PK3JitEArP3k5Y4/Uuqy7julIyf2RTVE4YfGA5Pi7ekUewXPl2P01TfPXlSLLERAFS36NwP7oy94xDxyTHNbppm/Q/DM1KBzBPGOIietVbfyywCGp3lW87lDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669032; c=relaxed/simple;
	bh=PmiReAIMaIclIoZh4/04UotfgwQG3ykiFhrNgD2tbLU=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=KXEJmtqVYZShTnSxE/UfwJGi8V55GxqvfgEdyh4SpKBZ1n0Q2DlZ6i4RUanFKx8gLTj+KMyo+l/AGLOstQBfeUzXE6jJFfPNgt/j7+P4SPWYP3sttBWAn1T1/rj9J9gOZP4GKc7u0VtELiHnbFZDTu+QZFhwh1fIOpCz2IKWiHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVSAnptc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVSAnptc"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513173e8191so7653577e87.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 12:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709669028; x=1710273828; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NjdDKmM0somKyJ05ADlrCO1GJw8fQhL87bH2HfsHHH4=;
        b=WVSAnptcWPNJYlf+7cjIGsWefJgRZqhHEZxWkPQCa2qpsu+awPJmJBiE3I0/AnSBF3
         fmtWWT5IO09jwGoebSQoB/0gBopm1TFnVPP5LXeTXEbdGv47LFuDPSZZz85bXhBHwjRD
         sbFveWzdzd78Jyq+pszDQpEIVVNqPFtfDlAMbddJ214F0PSdYg1wf0Ixe/b2hG8idEm5
         zktbMJAxJJc1FTwXbzDUqMV8ewpbTiHix1oikn0wH5KL9/9ckVPWfrF7leeX9R8Q5ztF
         jrJveZVF5qJA/4qyMTx1BBYOD5xr1p1KCS6XkbiMsF1pu6e+CY5oZ2/IXxznfntXQ0WY
         /nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669028; x=1710273828;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjdDKmM0somKyJ05ADlrCO1GJw8fQhL87bH2HfsHHH4=;
        b=av1Auvil/orWzHfkTL7WS0PsCwipnrOF6OUTad8nGQ2ZEQWBhgX8NotrZXpDW0V6Sa
         gOFRIwkjFhj1kkiTXfcZx3M6afgG6tCnGI9LoCEdvjBH4RSnCHlRFpl8U+V0Pz6hSRQM
         zaGgOkhT0a7z3Ufg2GCsslv11+TKQMxbrXgzduc8NoZIzqPkuov8Fl+I3sWPwLY9XbXG
         Oc8j+YXagH7bq1CdlD2Rqp/s29zBxM3AVw8RA78oseJyLDOVMglmrv39x4rPXc2V7PDf
         i/QYquISsh4rODuLZLBHUEPwJ1q5JqNRY+soKI4O93B3Hiju6vxTXhrnkZRmAuTlf2oX
         4WvQ==
X-Gm-Message-State: AOJu0YwMmTl2ArWlZrxmh6hm9+slA2enGxolV46Lavy5UqdOs/34phF3
	9gDIc6SsANRZC5Zo7tFbvQlJ8PQ00akHBFW9n3TytPSrf/pbM2uTQ+viKRpZ
X-Google-Smtp-Source: AGHT+IGwCdiTc6vbtsI2nc0Vnkoh9E+t9abmlxU2hHzghH0/yfDI08hImbVicCJQvDoWr695w7mi/A==
X-Received: by 2002:a05:6512:3a83:b0:513:2137:a231 with SMTP id q3-20020a0565123a8300b005132137a231mr2344530lfu.67.1709669027289;
        Tue, 05 Mar 2024 12:03:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b00412eff2eb5bsm1607545wmn.13.2024.03.05.12.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 12:03:46 -0800 (PST)
Message-ID: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Mar 2024 20:03:45 +0000
Subject: [PATCH] reftable/stack: use geometric table compaction
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

To reduce the number of on-disk reftables, compaction is performed.
Contiguous tables with the same binary log value of size are grouped
into segments. The segment that has both the lowest binary log value and
contains more than one table is set as the starting point when
identifying the compaction segment.

Since segments containing a single table are not initially considered
for compaction, if the table appended to the list does not match the
previous table log value, no compaction occurs for the new table. It is
therefore possible for unbounded growth of the table list. This can be
demonstrated by repeating the following sequence:

git branch -f foo
git branch -d foo

Each operation results in a new table being written with no compaction
occurring until a separate operation produces a table matching the
previous table log value.

To avoid unbounded growth of the table list, walk through each table and
evaluate if it needs to be included in the compaction segment to restore
a geometric sequence.

Some tests in `t0610-reftable-basics.sh` assert the on-disk state of
tables and are therefore updated to specify the correct new table count.
Since compaction is more aggressive in ensuring tables maintain a
geometric sequence, the expected table count is reduced in these tests.
In `reftable/stack_test.c` tests related to `sizes_to_segments()` are
removed because the function is no longer needed. Also, the
`test_suggest_compaction_segment()` test is updated to better showcase
and reflect the new geometric compaction behavior.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
    reftable/stack: use geometric table compaction

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1683%2Fjltobler%2Fjt%2Freftable-geometric-compaction-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1683/jltobler/jt/reftable-geometric-compaction-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1683

 reftable/stack.c           | 106 +++++++++++++++----------------------
 reftable/stack.h           |   3 --
 reftable/stack_test.c      |  66 +++++------------------
 t/t0610-reftable-basics.sh |  24 ++++-----
 4 files changed, 70 insertions(+), 129 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index b64e55648aa..e4ea8753977 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1214,75 +1214,57 @@ static int segment_size(struct segment *s)
 	return s->end - s->start;
 }
 
-int fastlog2(uint64_t sz)
-{
-	int l = 0;
-	if (sz == 0)
-		return 0;
-	for (; sz; sz /= 2) {
-		l++;
-	}
-	return l - 1;
-}
-
-struct segment *sizes_to_segments(size_t *seglen, uint64_t *sizes, size_t n)
-{
-	struct segment *segs = reftable_calloc(n, sizeof(*segs));
-	struct segment cur = { 0 };
-	size_t next = 0, i;
-
-	if (n == 0) {
-		*seglen = 0;
-		return segs;
-	}
-	for (i = 0; i < n; i++) {
-		int log = fastlog2(sizes[i]);
-		if (cur.log != log && cur.bytes > 0) {
-			struct segment fresh = {
-				.start = i,
-			};
-
-			segs[next++] = cur;
-			cur = fresh;
-		}
-
-		cur.log = log;
-		cur.end = i + 1;
-		cur.bytes += sizes[i];
-	}
-	segs[next++] = cur;
-	*seglen = next;
-	return segs;
-}
-
 struct segment suggest_compaction_segment(uint64_t *sizes, size_t n)
 {
-	struct segment min_seg = {
-		.log = 64,
-	};
-	struct segment *segs;
-	size_t seglen = 0, i;
-
-	segs = sizes_to_segments(&seglen, sizes, n);
-	for (i = 0; i < seglen; i++) {
-		if (segment_size(&segs[i]) == 1)
-			continue;
+	struct segment seg = { 0 };
+	uint64_t bytes;
+	size_t i;
 
-		if (segs[i].log < min_seg.log)
-			min_seg = segs[i];
-	}
+	/*
+	 * If there are no tables or only a single one then we don't have to
+	 * compact anything. The sequence is geometric by definition already.
+	 */
+	if (n <= 1)
+		return seg;
 
-	while (min_seg.start > 0) {
-		size_t prev = min_seg.start - 1;
-		if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev]))
+	/*
+	 * Find the ending table of the compaction segment needed to restore the
+	 * geometric sequence.
+	 *
+	 * To do so, we iterate backwards starting from the most recent table
+	 * until a valid segment end is found. If the preceding table is smaller
+	 * than the current table multiplied by the geometric factor (2), the
+	 * current table is set as the compaction segment end.
+	 */
+	for (i = n - 1; i > 0; i--) {
+		if (sizes[i - 1] < sizes[i] * 2) {
+			seg.end = i;
+			bytes = sizes[i];
 			break;
+		}
+	}
+
+	/*
+	 * Find the starting table of the compaction segment by iterating
+	 * through the remaing tables and keeping track of the accumulated size
+	 * of all tables seen from the segment end table.
+	 *
+	 * Note that we keep iterating even after we have found the first
+	 * first starting point. This is because there may be tables in the
+	 * stack preceding that first starting point which violate the geometric
+	 * sequence.
+	 */
+	for (; i > 0; i--) {
+		uint64_t curr = bytes;
+		bytes += sizes[i - 1];
 
-		min_seg.start = prev;
-		min_seg.bytes += sizes[prev];
+		if (sizes[i - 1] < curr * 2) {
+			seg.start = i - 1;
+			seg.bytes = bytes;
+		}
 	}
 
-	reftable_free(segs);
-	return min_seg;
+	return seg;
 }
 
 static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
@@ -1305,7 +1287,7 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
 		suggest_compaction_segment(sizes, st->merged->stack_len);
 	reftable_free(sizes);
 	if (segment_size(&seg) > 0)
-		return stack_compact_range_stats(st, seg.start, seg.end - 1,
+		return stack_compact_range_stats(st, seg.start, seg.end,
 						 NULL);
 
 	return 0;
diff --git a/reftable/stack.h b/reftable/stack.h
index d919455669e..656f896cc28 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -33,12 +33,9 @@ int read_lines(const char *filename, char ***lines);
 
 struct segment {
 	size_t start, end;
-	int log;
 	uint64_t bytes;
 };
 
-int fastlog2(uint64_t sz);
-struct segment *sizes_to_segments(size_t *seglen, uint64_t *sizes, size_t n);
 struct segment suggest_compaction_segment(uint64_t *sizes, size_t n);
 
 #endif
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 509f4866236..85600a9573e 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -720,59 +720,14 @@ static void test_reftable_stack_hash_id(void)
 	clear_dir(dir);
 }
 
-static void test_log2(void)
-{
-	EXPECT(1 == fastlog2(3));
-	EXPECT(2 == fastlog2(4));
-	EXPECT(2 == fastlog2(5));
-}
-
-static void test_sizes_to_segments(void)
-{
-	uint64_t sizes[] = { 2, 3, 4, 5, 7, 9 };
-	/* .................0  1  2  3  4  5 */
-
-	size_t seglen = 0;
-	struct segment *segs =
-		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
-	EXPECT(segs[2].log == 3);
-	EXPECT(segs[2].start == 5);
-	EXPECT(segs[2].end == 6);
-
-	EXPECT(segs[1].log == 2);
-	EXPECT(segs[1].start == 2);
-	EXPECT(segs[1].end == 5);
-	reftable_free(segs);
-}
-
-static void test_sizes_to_segments_empty(void)
-{
-	size_t seglen = 0;
-	struct segment *segs = sizes_to_segments(&seglen, NULL, 0);
-	EXPECT(seglen == 0);
-	reftable_free(segs);
-}
-
-static void test_sizes_to_segments_all_equal(void)
-{
-	uint64_t sizes[] = { 5, 5 };
-	size_t seglen = 0;
-	struct segment *segs =
-		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
-	EXPECT(seglen == 1);
-	EXPECT(segs[0].start == 0);
-	EXPECT(segs[0].end == 2);
-	reftable_free(segs);
-}
-
 static void test_suggest_compaction_segment(void)
 {
-	uint64_t sizes[] = { 128, 64, 17, 16, 9, 9, 9, 16, 16 };
+	uint64_t sizes[] = { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
 	/* .................0    1    2  3   4  5  6 */
 	struct segment min =
 		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
-	EXPECT(min.start == 2);
-	EXPECT(min.end == 7);
+	EXPECT(min.start == 1);
+	EXPECT(min.end == 9);
 }
 
 static void test_suggest_compaction_segment_nothing(void)
@@ -884,6 +839,17 @@ static void test_empty_add(void)
 	reftable_stack_destroy(st2);
 }
 
+static int fastlog2(uint64_t sz)
+{
+	int l = 0;
+	if (sz == 0)
+		return 0;
+	for (; sz; sz /= 2) {
+		l++;
+	}
+	return l - 1;
+}
+
 static void test_reftable_stack_auto_compaction(void)
 {
 	struct reftable_write_options cfg = { 0 };
@@ -1072,7 +1038,6 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 int stack_test_main(int argc, const char *argv[])
 {
 	RUN_TEST(test_empty_add);
-	RUN_TEST(test_log2);
 	RUN_TEST(test_names_equal);
 	RUN_TEST(test_parse_names);
 	RUN_TEST(test_read_file);
@@ -1092,9 +1057,6 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_update_index_check);
 	RUN_TEST(test_reftable_stack_uptodate);
 	RUN_TEST(test_reftable_stack_validate_refname);
-	RUN_TEST(test_sizes_to_segments);
-	RUN_TEST(test_sizes_to_segments_all_equal);
-	RUN_TEST(test_sizes_to_segments_empty);
 	RUN_TEST(test_suggest_compaction_segment);
 	RUN_TEST(test_suggest_compaction_segment_nothing);
 	return 0;
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 6a131e40b81..a3b1a04123e 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -293,7 +293,7 @@ test_expect_success 'ref transaction: writes cause auto-compaction' '
 	test_line_count = 1 repo/.git/reftable/tables.list &&
 
 	test_commit -C repo --no-tag A &&
-	test_line_count = 2 repo/.git/reftable/tables.list &&
+	test_line_count = 1 repo/.git/reftable/tables.list &&
 
 	test_commit -C repo --no-tag B &&
 	test_line_count = 1 repo/.git/reftable/tables.list
@@ -324,7 +324,7 @@ test_expect_success 'ref transaction: writes are synced' '
 		git -C repo -c core.fsync=reference \
 		-c core.fsyncMethod=fsync update-ref refs/heads/branch HEAD &&
 	check_fsync_events trace2.txt <<-EOF
-	"name":"hardware-flush","count":2
+	"name":"hardware-flush","count":4
 	EOF
 '
 
@@ -334,8 +334,8 @@ test_expect_success 'pack-refs: compacts tables' '
 
 	test_commit -C repo A &&
 	ls -1 repo/.git/reftable >table-files &&
-	test_line_count = 4 table-files &&
-	test_line_count = 3 repo/.git/reftable/tables.list &&
+	test_line_count = 3 table-files &&
+	test_line_count = 2 repo/.git/reftable/tables.list &&
 
 	git -C repo pack-refs &&
 	ls -1 repo/.git/reftable >table-files &&
@@ -367,7 +367,7 @@ do
 			umask $umask &&
 			git init --shared=true repo &&
 			test_commit -C repo A &&
-			test_line_count = 3 repo/.git/reftable/tables.list
+			test_line_count = 2 repo/.git/reftable/tables.list
 		) &&
 		git -C repo pack-refs &&
 		test_expect_perms "-rw-rw-r--" repo/.git/reftable/tables.list &&
@@ -737,10 +737,10 @@ test_expect_success 'worktree: pack-refs in main repo packs main refs' '
 	test_commit -C repo A &&
 	git -C repo worktree add ../worktree &&
 
-	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
-	test_line_count = 4 repo/.git/reftable/tables.list &&
+	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count = 1 repo/.git/reftable/tables.list &&
 	git -C repo pack-refs &&
-	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
 	test_line_count = 1 repo/.git/reftable/tables.list
 '
 
@@ -750,11 +750,11 @@ test_expect_success 'worktree: pack-refs in worktree packs worktree refs' '
 	test_commit -C repo A &&
 	git -C repo worktree add ../worktree &&
 
-	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
-	test_line_count = 4 repo/.git/reftable/tables.list &&
+	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count = 1 repo/.git/reftable/tables.list &&
 	git -C worktree pack-refs &&
 	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
-	test_line_count = 4 repo/.git/reftable/tables.list
+	test_line_count = 1 repo/.git/reftable/tables.list
 '
 
 test_expect_success 'worktree: creating shared ref updates main stack' '
@@ -770,7 +770,7 @@ test_expect_success 'worktree: creating shared ref updates main stack' '
 
 	git -C worktree update-ref refs/heads/shared HEAD &&
 	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
-	test_line_count = 2 repo/.git/reftable/tables.list
+	test_line_count = 1 repo/.git/reftable/tables.list
 '
 
 test_expect_success 'worktree: creating per-worktree ref updates worktree stack' '

base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
-- 
gitgitgadget
