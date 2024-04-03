Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5F36C
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103645; cv=none; b=KhpUHcpHOyN6MlLl5wPJ13NXj8kr3XA7eYk8LW1DJF/Qqx7PPJpJ/+voQITdYeGOAFq8KHghb2ZNDQUj5chyzGXSf6EAJTDCeE9D5Fc3tE+VsR5ba4cn0/RGvrxOB84PayEQcrpPQJjBf8tXaSk0w2AZoBXYKRN59yGUZPsMQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103645; c=relaxed/simple;
	bh=YIqOkKw4+NJKHwhll1UN9nrDAPUO4XVeXcum8EOQhns=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=eZUPCEY3Tjg5wCOmUubbJaQWX3vKLe6LVaSW7XpKCJkFAOoGKB4oPYeASQ/1zCknlvyTJHtgzAQH8xfo09QgHti0xiS6upLsRh/luz+0EIDPVYudHC7CPNEyfBy6ejhDDNO16ru2y6CyDZBsPjXelMFjh+dGQiBoDAB66VJlYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldTTiKIn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldTTiKIn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4161d6b2582so6870565e9.3
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 17:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712103641; x=1712708441; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDHKRdYdl5GwDu0L85VzomhdJuiv8rdoacZMcUF9z4Q=;
        b=ldTTiKIn8vvqGGa6k5OIt2njy2xQUGB+glmY1doC5/tGVqHm4+rcfeef+gMxs0j3mM
         O3MJ/xM0GqFPIbxPEm/nvdB/i3NnrtvCsh53C6QH8ufYF/YjS+oP26NVVKlkHtcrzWzc
         7KV+1s+r0/eNsPT3/06PJgGaC4abgZRlN/1vxi2hr73fqtvaCXetyjNuLyiTBTa6paHZ
         JhwPWOKDK2fXSPq8lqxF5hQ55kHGI4uMxp2j1PGlGGxcOtL2U05ZnG52YCsthqmyzAaq
         CThnvd6uqM2ZVs54igFLQLeSEpG3inyxZIyIt0hv6Bws93TncpBJsKGXBuDTICQSc8KV
         9wSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712103641; x=1712708441;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDHKRdYdl5GwDu0L85VzomhdJuiv8rdoacZMcUF9z4Q=;
        b=jkO0naIOk7++cYcaQYdL2s/DRSu/AplEp9xXR6+AXYhJyTdP5EyZcMIsPikNSx22ko
         yHaacK0nPvJmGhDkdP/U+y4eq10UbFvY+b4fjbdgEdi7/8FddmMQkD24EBVAQlB+bgAV
         7dIFeKn4dEBEQzt6M9XOoPPk9LcTYjQmoK3UXnwh5WQX450by3a+AzzhAgNg+BM2zLcm
         6UO7o1He5/eghc1dzbvB1L4ue5VjBeMwLyDvlI2ooFJuhXpkjTx0HsIm/gP6MR0iKKjA
         fSdGc2ZawxAuDOy8hdJgGx5uq9DuiAun9S7CvFXiZG2IHArxmPxA/CYNq2LS0SOSERC0
         GTPA==
X-Gm-Message-State: AOJu0YyOiw519g4ImnXgCuFHmh/cJPwKpkQv+i05qY5q2WJOpJt71Auo
	6o/p7Ua+LlGrvkngS2t7uQJalPE/BJPLbav2j+8e5XvNSasY/IdJxMRURMub
X-Google-Smtp-Source: AGHT+IEXdS/eUykeoWsJj1qnhfqIQm44lO6yq30jF84hprPq/p96RykSYdWe/rZVRCb7PoUIKnak8g==
X-Received: by 2002:a05:600c:5843:b0:414:22e:1761 with SMTP id ka3-20020a05600c584300b00414022e1761mr832987wmb.16.1712103640894;
        Tue, 02 Apr 2024 17:20:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b00414906f1ea1sm19462316wmf.17.2024.04.02.17.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 17:20:39 -0700 (PDT)
Message-Id: <e0f4d0dbcc1157b2d04fd4b88eea0eeb7c4d3351.1712103636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
References: <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
	<pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Apr 2024 00:20:36 +0000
Subject: [PATCH v4 2/2] reftable/stack: use geometric table compaction
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
    Karthik Nayak <karthik.188@gmail.com>,
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
each operation by individually evaluating each table in reverse index
order. This strategy results in a much simpler and more robust algorithm
compared to the previous one while also maintaining a minimal ordered
set of tables on-disk.

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
 reftable/stack.c           | 123 +++++++++++++++++++------------------
 reftable/stack.h           |   3 -
 reftable/stack_test.c      |  66 ++++----------------
 t/t0610-reftable-basics.sh |  44 +++++++++----
 4 files changed, 108 insertions(+), 128 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 4c373fb0ee2..5f087cbd4bc 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1203,75 +1203,76 @@ static int segment_size(struct segment *s)
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
+	 * geometric sequence. Note that the segment end is exclusive.
+	 *
+	 * To do so, we iterate backwards starting from the most recent table
+	 * until a valid segment end is found. If the preceding table is smaller
+	 * than the current table multiplied by the geometric factor (2), the
+	 * compaction segment end has been identified.
+	 *
+	 * Tables after the ending point are not added to the byte count because
+	 * they are already valid members of the geometric sequence. Due to the
+	 * properties of a geometric sequence, it is not possible for the sum of
+	 * these tables to exceed the value of the ending point table.
+	 *
+	 * Example table size sequence requiring no compaction:
+	 * 	64, 32, 16, 8, 4, 2, 1
+	 *
+	 * Example table size sequence where compaction segment end is set to
+	 * the last table. Since the segment end is exclusive, the last table is
+	 * excluded during subsequent compaction and the table with size 3 is
+	 * the final table included:
+	 * 	64, 32, 16, 8, 4, 3, 1
+	 */
+	for (i = n - 1; i > 0; i--) {
+		if (sizes[i - 1] < sizes[i] * 2) {
+			seg.end = i + 1;
+			bytes = sizes[i];
 			break;
+		}
+	}
 
-		min_seg.start = prev;
-		min_seg.bytes += sizes[prev];
+	/*
+	 * Find the starting table of the compaction segment by iterating
+	 * through the remaining tables and keeping track of the accumulated
+	 * size of all tables seen from the segment end table. The previous
+	 * table is compared to the accumulated size because the tables from the
+	 * segment end are merged backwards recursively.
+	 *
+	 * Note that we keep iterating even after we have found the first
+	 * starting point. This is because there may be tables in the stack
+	 * preceding that first starting point which violate the geometric
+	 * sequence.
+	 *
+	 * Example compaction segment start set to table with size 32:
+	 * 	128, 32, 16, 8, 4, 3, 1
+	 */
+	for (; i > 0; i--) {
+		uint64_t curr = bytes;
+		bytes += sizes[i - 1];
+
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
index 7336757cf53..a23cee22f4d 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -717,59 +717,13 @@ static void test_reftable_stack_hash_id(void)
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
-	/* .................0    1    2  3   4  5  6 */
+	uint64_t sizes[] = { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
 	struct segment min =
 		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
-	EXPECT(min.start == 2);
-	EXPECT(min.end == 7);
+	EXPECT(min.start == 1);
+	EXPECT(min.end == 10);
 }
 
 static void test_suggest_compaction_segment_nothing(void)
@@ -880,6 +834,16 @@ static void test_empty_add(void)
 	reftable_stack_destroy(st2);
 }
 
+static int fastlog2(uint64_t sz)
+{
+	int l = 0;
+	if (sz == 0)
+		return 0;
+	for (; sz; sz /= 2)
+		l++;
+	return l - 1;
+}
+
 static void test_reftable_stack_auto_compaction(void)
 {
 	struct reftable_write_options cfg = { 0 };
@@ -1068,7 +1032,6 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 int stack_test_main(int argc, const char *argv[])
 {
 	RUN_TEST(test_empty_add);
-	RUN_TEST(test_log2);
 	RUN_TEST(test_names_equal);
 	RUN_TEST(test_parse_names);
 	RUN_TEST(test_read_file);
@@ -1088,9 +1051,6 @@ int stack_test_main(int argc, const char *argv[])
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
index 444f7497907..853f0a051d8 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -293,7 +293,7 @@ test_expect_success 'ref transaction: writes cause auto-compaction' '
 	test_line_count = 1 repo/.git/reftable/tables.list &&
 
 	test_commit -C repo --no-tag A &&
-	test_line_count = 2 repo/.git/reftable/tables.list &&
+	test_line_count = 1 repo/.git/reftable/tables.list &&
 
 	test_commit -C repo --no-tag B &&
 	test_line_count = 1 repo/.git/reftable/tables.list
@@ -320,6 +320,19 @@ test_expect_success 'ref transaction: env var disables compaction' '
 	test_line_count -lt $expected repo/.git/reftable/tables.list
 '
 
+test_expect_success 'ref transaction: alternating table sizes are compacted' '
+	test_when_finished "rm -rf repo" &&
+
+	git init repo &&
+	test_commit -C repo A &&
+	for i in $(test_seq 5)
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
@@ -345,7 +358,7 @@ test_expect_success 'ref transaction: writes are synced' '
 		git -C repo -c core.fsync=reference \
 		-c core.fsyncMethod=fsync update-ref refs/heads/branch HEAD &&
 	check_fsync_events trace2.txt <<-EOF
-	"name":"hardware-flush","count":2
+	"name":"hardware-flush","count":4
 	EOF
 '
 
@@ -367,8 +380,8 @@ test_expect_success 'pack-refs: compacts tables' '
 
 	test_commit -C repo A &&
 	ls -1 repo/.git/reftable >table-files &&
-	test_line_count = 4 table-files &&
-	test_line_count = 3 repo/.git/reftable/tables.list &&
+	test_line_count = 3 table-files &&
+	test_line_count = 2 repo/.git/reftable/tables.list &&
 
 	git -C repo pack-refs &&
 	ls -1 repo/.git/reftable >table-files &&
@@ -400,7 +413,7 @@ do
 			umask $umask &&
 			git init --shared=true repo &&
 			test_commit -C repo A &&
-			test_line_count = 3 repo/.git/reftable/tables.list
+			test_line_count = 2 repo/.git/reftable/tables.list
 		) &&
 		git -C repo pack-refs &&
 		test_expect_perms "-rw-rw-r--" repo/.git/reftable/tables.list &&
@@ -768,12 +781,16 @@ test_expect_success 'worktree: pack-refs in main repo packs main refs' '
 	test_when_finished "rm -rf repo worktree" &&
 	git init repo &&
 	test_commit -C repo A &&
+
+	GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
 	git -C repo worktree add ../worktree &&
+	GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
+	git -C worktree update-ref refs/worktree/per-worktree HEAD &&
 
-	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
-	test_line_count = 4 repo/.git/reftable/tables.list &&
+	test_line_count = 4 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count = 3 repo/.git/reftable/tables.list &&
 	git -C repo pack-refs &&
-	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
+	test_line_count = 4 repo/.git/worktrees/worktree/reftable/tables.list &&
 	test_line_count = 1 repo/.git/reftable/tables.list
 '
 
@@ -781,13 +798,17 @@ test_expect_success 'worktree: pack-refs in worktree packs worktree refs' '
 	test_when_finished "rm -rf repo worktree" &&
 	git init repo &&
 	test_commit -C repo A &&
+
+	GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
 	git -C repo worktree add ../worktree &&
+	GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
+	git -C worktree update-ref refs/worktree/per-worktree HEAD &&
 
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
@@ -801,6 +822,7 @@ test_expect_success 'worktree: creating shared ref updates main stack' '
 	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
 	test_line_count = 1 repo/.git/reftable/tables.list &&
 
+	GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
 	git -C worktree update-ref refs/heads/shared HEAD &&
 	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
 	test_line_count = 2 repo/.git/reftable/tables.list
-- 
gitgitgadget
