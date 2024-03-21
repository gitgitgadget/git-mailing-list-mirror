Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C799134C0
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711060829; cv=none; b=J60/fKBjTzvbLb0F4FsWVkVAoDvE4mCddm05OpSyREoyuO17smyvStNHiFoVQpoMEms83JvRSJqeLTMOQu+KtsDJ+OgYKvMIraq9rYf6al2IezVYLtI6dFP9V+ARRd1OIVEMDg4wynkFBdHU/nwILABWwXnKe78Ud1kV+6tCzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711060829; c=relaxed/simple;
	bh=qpTqU1Hp1PkeIjUGRpnKue/3L7esmU89eaandlvsGKo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=jFP/qsQhZaHTkR1a7M52biO27BRL8yGNwJPYLbwHknuRv83CRDYnmYeyvQcAbPfvJz6oweu6uAJwT85K8ALqUS9ZNBNEuezjXJk3zMjqZAaaDm3Lc/OFiB8oH9Nafqt9xYHavTKCM9rjkTvyZm872NnSvltfh2O+V/R187lWJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTi8T6x2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTi8T6x2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4146d750dcdso9214595e9.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711060824; x=1711665624; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V65djHJl5bhRNp/97ggFsmNTKzh7LeTx2bbsC78FEes=;
        b=HTi8T6x2mYaCFTpNZ7bcryOhhBoxCS5T7nI6NVXMG9fiP9aji68+2taU7RI8RVyfvO
         1DwEw01N1ef03vLEQy8++YppjAEcIaZ21txHfO9ooUv9mrgkqyY1HBfRERK6CK6CvlFo
         3/D/7EhZqMgp4k6OSV26WYh9jI76t5EaovHxutzGnWWtA7LCJK0QGyiefNsriggwXWW4
         zDF6JwzhCLrTcMWS90JZj6dDuZKnjnTSSzvnu0IPBKGf3dCoT6LsQq7/2wjBufhqptFU
         5BigfTIVN7BMfQPPqx75ywlgwnowaxLS4JoorEy0LJzilxjWR4+IZsA8xQDLuUUfvRZH
         uN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711060824; x=1711665624;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V65djHJl5bhRNp/97ggFsmNTKzh7LeTx2bbsC78FEes=;
        b=dJDNJ7tkSE0pXbrYmgH75xf5MUt0LANKkv97x68lmAF1I0WlSHz43CL5Is5MgJrHk3
         5GM6mMhh2bjUqTa1/7D9C2J+aFUt0uxXq8DEmPrAzHaiVjL3B2W2/Ej9CF+4D5hNeQzi
         JfW9s1OK1Nd1AFx7m8VfXD9Wm3UkXyj/xwBieZ50wySX7zGu7e0XZGl4PmFbCPzMOX0/
         nyHoZAen38JQxgzm2KfQiDnW1Hiw2mu6mCdGmdkmV+xRE7Dmhysr3ZQRIUoiDTQSU0GR
         /9iZVogyOPZZ7JR59RPP97ilBDrZ+zExFtqWHBQEIwCN6aSA6x6kClB7oxmqE8igxUx1
         nCAg==
X-Gm-Message-State: AOJu0YzAVn/vogSvKEvIuR47g2wzrMpz3P8RDF5rI+uwb6VxfJDUODpq
	ZJYysdGE6OX+PQVMg32Fg1XpBD3HwPI32YFmcPQmTz2qHKT5MkG9TQXTkXZI
X-Google-Smtp-Source: AGHT+IEKWPgntpsGpJjLBmGi/u16OYpybFa26h6XoJU8GmoM1nzydxfTKhK70xRBYmBr/6fknbSG+g==
X-Received: by 2002:a05:600c:4fc7:b0:412:b02d:71f9 with SMTP id o7-20020a05600c4fc700b00412b02d71f9mr266682wmq.2.1711060823730;
        Thu, 21 Mar 2024 15:40:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bf12-20020a0560001ccc00b0033e745b8bcfsm611895wrb.88.2024.03.21.15.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:40:22 -0700 (PDT)
Message-ID: <def7008452303f71c1fa469609bc199c629a19ec.1711060820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
	<pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Mar 2024 22:40:18 +0000
Subject: [PATCH v2 2/3] reftable/stack: use geometric table compaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Justin Tobler <jltobler@gmail.com>,
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

Instead, to avoid unbounded growth of the table list, the compaction
strategy is updated to ensure tables follow a geometric sequence after
each operation. This is done by walking the table list in reverse index
order to identify the compaction segment start and end. The compaction
segment end is found by identifying the first table which has a
preceding table size less than twice the current table. Next, the
compaction segment start is found iterating through the remaining tables
in the list checking if the previous table size is less than twice the
cumulative of tables from the segment end. This ensures the correct
segment start is found and that the newly compacted table does not
violate the geometric sequence.

When creating 10 thousand references, the new strategy has no
performance impact:

Benchmark 1: update-ref: create refs sequentially (revision = HEAD~)
  Time (mean ± σ):     26.516 s ±  0.047 s    [User: 17.864 s, System: 8.491 s]
  Range (min … max):   26.447 s … 26.569 s    10 runs

Benchmark 2: update-ref: create refs sequentially (revision = HEAD)
  Time (mean ± σ):     26.417 s ±  0.028 s    [User: 17.738 s, System: 8.500 s]
  Range (min … max):   26.366 s … 26.444 s    10 runs

Summary
  update-ref: create refs sequentially (revision = HEAD) ran
    1.00 ± 0.00 times faster than update-ref: create refs sequentially (revision = HEAD~)

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
 reftable/stack.c           | 109 ++++++++++++++++---------------------
 reftable/stack.h           |   3 -
 reftable/stack_test.c      |  66 +++++-----------------
 t/t0610-reftable-basics.sh |  43 ++++++++++-----
 4 files changed, 91 insertions(+), 130 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 2370d93d13b..ef55dc75cde 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1214,75 +1214,62 @@ static int segment_size(struct segment *s)
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
+	 *
+	 * Tables after the ending point are not added to the byte count because
+	 * they are already valid members of the geometric sequence. Due to the
+	 * properties of a geometric sequence, it is not possible for the sum of
+	 * these tables to exceed the value of the ending point table.
+	 */
+	for (i = n - 1; i > 0; i--) {
+		if (sizes[i - 1] < sizes[i] * 2) {
+			seg.end = i + 1;
+			bytes = sizes[i];
 			break;
+		}
+	}
+
+	/*
+	 * Find the starting table of the compaction segment by iterating
+	 * through the remaining tables and keeping track of the accumulated
+	 * size of all tables seen from the segment end table.
+	 *
+	 * Note that we keep iterating even after we have found the first
+	 * starting point. This is because there may be tables in the stack
+	 * preceding that first starting point which violate the geometric
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
index 509f4866236..e5f6ff5c9e4 100644
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
+	EXPECT(min.end == 10);
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
index 686781192eb..e6c3f94d874 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -293,12 +293,24 @@ test_expect_success 'ref transaction: writes cause auto-compaction' '
 	test_line_count = 1 repo/.git/reftable/tables.list &&
 
 	test_commit -C repo --no-tag A &&
-	test_line_count = 2 repo/.git/reftable/tables.list &&
+	test_line_count = 1 repo/.git/reftable/tables.list &&
 
 	test_commit -C repo --no-tag B &&
 	test_line_count = 1 repo/.git/reftable/tables.list
 '
 
+test_expect_success 'ref transaction: alternating table sizes are compacted' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo A &&
+	for i in $(test_seq 20)
+	do
+		git -C repo branch -f foo &&
+		git -C repo branch -d foo || return 1
+	done &&
+	test_line_count = 2 repo/.git/reftable/tables.list
+'
+
 check_fsync_events () {
 	local trace="$1" &&
 	shift &&
@@ -324,7 +336,7 @@ test_expect_success 'ref transaction: writes are synced' '
 		git -C repo -c core.fsync=reference \
 		-c core.fsyncMethod=fsync update-ref refs/heads/branch HEAD &&
 	check_fsync_events trace2.txt <<-EOF
-	"name":"hardware-flush","count":2
+	"name":"hardware-flush","count":4
 	EOF
 '
 
@@ -346,8 +358,8 @@ test_expect_success 'pack-refs: compacts tables' '
 
 	test_commit -C repo A &&
 	ls -1 repo/.git/reftable >table-files &&
-	test_line_count = 4 table-files &&
-	test_line_count = 3 repo/.git/reftable/tables.list &&
+	test_line_count = 3 table-files &&
+	test_line_count = 2 repo/.git/reftable/tables.list &&
 
 	git -C repo pack-refs &&
 	ls -1 repo/.git/reftable >table-files &&
@@ -379,7 +391,7 @@ do
 			umask $umask &&
 			git init --shared=true repo &&
 			test_commit -C repo A &&
-			test_line_count = 3 repo/.git/reftable/tables.list
+			test_line_count = 2 repo/.git/reftable/tables.list
 		) &&
 		git -C repo pack-refs &&
 		test_expect_perms "-rw-rw-r--" repo/.git/reftable/tables.list &&
@@ -747,12 +759,13 @@ test_expect_success 'worktree: pack-refs in main repo packs main refs' '
 	test_when_finished "rm -rf repo worktree" &&
 	git init repo &&
 	test_commit -C repo A &&
-	git -C repo worktree add ../worktree &&
+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo worktree add ../worktree &&
+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C worktree update-ref refs/worktree/per-worktree HEAD &&
 
-	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
-	test_line_count = 4 repo/.git/reftable/tables.list &&
+	test_line_count = 4 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count = 3 repo/.git/reftable/tables.list &&
 	git -C repo pack-refs &&
-	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count = 4 repo/.git/worktrees/worktree/reftable/tables.list &&
 	test_line_count = 1 repo/.git/reftable/tables.list
 '
 
@@ -760,19 +773,21 @@ test_expect_success 'worktree: pack-refs in worktree packs worktree refs' '
 	test_when_finished "rm -rf repo worktree" &&
 	git init repo &&
 	test_commit -C repo A &&
-	git -C repo worktree add ../worktree &&
+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo worktree add ../worktree &&
+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C worktree update-ref refs/worktree/per-worktree HEAD &&
 
-	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
-	test_line_count = 4 repo/.git/reftable/tables.list &&
+	test_line_count = 4 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count = 3 repo/.git/reftable/tables.list &&
 	git -C worktree pack-refs &&
 	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
-	test_line_count = 4 repo/.git/reftable/tables.list
+	test_line_count = 3 repo/.git/reftable/tables.list
 '
 
 test_expect_success 'worktree: creating shared ref updates main stack' '
 	test_when_finished "rm -rf repo worktree" &&
 	git init repo &&
 	test_commit -C repo A &&
+	test_commit -C repo B &&
 
 	git -C repo worktree add ../worktree &&
 	git -C repo pack-refs &&
@@ -780,7 +795,7 @@ test_expect_success 'worktree: creating shared ref updates main stack' '
 	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
 	test_line_count = 1 repo/.git/reftable/tables.list &&
 
-	git -C worktree update-ref refs/heads/shared HEAD &&
+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C worktree update-ref refs/heads/shared HEAD &&
 	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
 	test_line_count = 2 repo/.git/reftable/tables.list
 '
-- 
gitgitgadget

