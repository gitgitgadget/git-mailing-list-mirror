Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1E33AC01
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685818; cv=none; b=qNVDu0oxPpDAGNAW4ez7Ez6yDJNudbbxAJUfijfKt6PtenvBprQTrBDVvIqj1lkqcLffLL/rCKF1JT4gesTR74P2z9hB24zX+whGfIpnUjVzuz0YDnDeiQVZ6exSUC7mh4eeAwVEY4y/o5rmlsXRFnxiBk2J1Iua4UdmysjR8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685818; c=relaxed/simple;
	bh=vCPLZGZVUq9NtYAVLiw8CFF2Gb4vR2n6I26sdo3VObw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Gil25/oZf8nRydWbqyTkWaqpyEY4dXaWgsHMcRsLwNUWJ8dSlz/Xs98072wZyu3c0suiHIJG4eJFx0iULjpFOaK8KolRgcTpHMALB+eP1Yr2bc+HrenLOFkFyxoD6EVbW4yTXOH+n0qsGhzFrffH8EfGWJPh7FmhKNpuPvI92w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyT7bJPh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyT7bJPh"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3416df43cabso1124995f8f.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711685812; x=1712290612; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URl86PB51eaeKUn1u88SCP00RIWSppVG/pRT5QDjYug=;
        b=EyT7bJPhGJsplhrH0clVgn1hqGLWaPtrVJM/E+VAc+NJAL7qoJPyvYbt0/hPBo8nf+
         uigDuj1zQVCHHOiGPHgdyYGnWLU14TQKJttJGbmkjTrSLKrP1tDa35K9y1lAfclex+/B
         PCqVCdjP12SNwOoxTn4lU3549Py8x5hUQbF3USXWO6EDgATb0mZknDmM9KFQT9C70zqa
         MzqFJTxVwaINwCedZOuSayt8b2HeZBn+ksYhz7WjSjnCljg6nnHM9F4ViDuS55CO8QTB
         tMNmjDo5sPhdfll+2tuFCh3CW8JKJKeZ+CWbJcFFuDE/fW6Zz7JYfITSI34A9VwlJ8b/
         gcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685812; x=1712290612;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URl86PB51eaeKUn1u88SCP00RIWSppVG/pRT5QDjYug=;
        b=c7AbYn51jA6Dc6+NgQ3/RmMFBOuGTrU72+hJt9CR5ziZujY7UwtXgNcB7lAnwXZjx1
         XLyZd8kquU5TF+Qq6ES3V/MgMdVyG2FVzdnADM/MhBRtx7vfBpe0vYQyxKK3M9WY6LX8
         C7t/QmJbk7f0/iSjtFGFgj/nk6OW6/Z+O8uXeST2zA8c797GMOliHPIScaSLt7wzIDJh
         gsAcJRrpoQgTbkFG2x2rraMxsaqfDWCFGJK2wQpkhT84UIvlGG0ZiqTGZ8TRoc3TDPT4
         mFw5gWQzGQZovAgcpBSBqkAZNE4rMnMRSaTjTjHmshj+r4KGCF9y0ctLzH/UnpEX2NWW
         Ao4Q==
X-Gm-Message-State: AOJu0Yy5WfNm0MApYtHcVQzUTnfvfK9nB7DFD14UvYHRAmVhorQlyhPD
	UojuTHWhOPGR1LkVcokIg4VVboEviJqn3aq/UmvfQO3bUhOrgQo2cmvjApRw
X-Google-Smtp-Source: AGHT+IF1EnlpCWBnRFUJJTFJW58oGqdzbm3yB44UOAgiPRxetG+rmlcbl8Yq2zR1pzgOFZVX0C2Sng==
X-Received: by 2002:a05:6000:d4e:b0:342:40b0:abf5 with SMTP id du14-20020a0560000d4e00b0034240b0abf5mr487019wrb.55.1711685812170;
        Thu, 28 Mar 2024 21:16:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14-20020adff90e000000b0033e745b8bcfsm3159226wrr.88.2024.03.28.21.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:16:51 -0700 (PDT)
Message-Id: <7e62c2286ae9c63368f1508f065b33422ca24bc8.1711685809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
References: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
	<pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 04:16:48 +0000
Subject: [PATCH v3 2/3] reftable/stack: use geometric table compaction
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
 reftable/stack.c           | 120 ++++++++++++++++++-------------------
 reftable/stack.h           |   3 -
 reftable/stack_test.c      |  67 +++++----------------
 t/t0610-reftable-basics.sh |  45 +++++++++-----
 4 files changed, 103 insertions(+), 132 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 07262beaaf7..e7b9a1de5a4 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1202,75 +1202,73 @@ static int segment_size(struct segment *s)
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
+	 *
+	 * Example table size sequence requiring no compaction:
+	 * 	64, 32, 16, 8, 4, 2, 1
+	 *
+	 * Example compaction segment end set to table with size 3:
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
index 7336757cf53..21541742fe5 100644
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
@@ -880,6 +834,17 @@ static void test_empty_add(void)
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
@@ -1068,7 +1033,6 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 int stack_test_main(int argc, const char *argv[])
 {
 	RUN_TEST(test_empty_add);
-	RUN_TEST(test_log2);
 	RUN_TEST(test_names_equal);
 	RUN_TEST(test_parse_names);
 	RUN_TEST(test_read_file);
@@ -1088,9 +1052,6 @@ int stack_test_main(int argc, const char *argv[])
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
index 434044078ed..b95626549e7 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -293,7 +293,7 @@ test_expect_success 'ref transaction: writes cause auto-compaction' '
 	test_line_count = 1 repo/.git/reftable/tables.list &&
 
 	test_commit -C repo --no-tag A &&
-	test_line_count = 2 repo/.git/reftable/tables.list &&
+	test_line_count = 1 repo/.git/reftable/tables.list &&
 
 	test_commit -C repo --no-tag B &&
 	test_line_count = 1 repo/.git/reftable/tables.list
@@ -308,12 +308,24 @@ test_expect_success 'ref transaction: environment variable disables auto-compact
 	do
 		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo update-ref branch-$i HEAD || return 1
 	done &&
-	test_line_count = 23 repo/.git/reftable/tables.list &&
+	test_line_count = 22 repo/.git/reftable/tables.list &&
 
 	git -C repo update-ref foo HEAD &&
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
@@ -339,7 +351,7 @@ test_expect_success 'ref transaction: writes are synced' '
 		git -C repo -c core.fsync=reference \
 		-c core.fsyncMethod=fsync update-ref refs/heads/branch HEAD &&
 	check_fsync_events trace2.txt <<-EOF
-	"name":"hardware-flush","count":2
+	"name":"hardware-flush","count":4
 	EOF
 '
 
@@ -361,8 +373,8 @@ test_expect_success 'pack-refs: compacts tables' '
 
 	test_commit -C repo A &&
 	ls -1 repo/.git/reftable >table-files &&
-	test_line_count = 4 table-files &&
-	test_line_count = 3 repo/.git/reftable/tables.list &&
+	test_line_count = 3 table-files &&
+	test_line_count = 2 repo/.git/reftable/tables.list &&
 
 	git -C repo pack-refs &&
 	ls -1 repo/.git/reftable >table-files &&
@@ -394,7 +406,7 @@ do
 			umask $umask &&
 			git init --shared=true repo &&
 			test_commit -C repo A &&
-			test_line_count = 3 repo/.git/reftable/tables.list
+			test_line_count = 2 repo/.git/reftable/tables.list
 		) &&
 		git -C repo pack-refs &&
 		test_expect_perms "-rw-rw-r--" repo/.git/reftable/tables.list &&
@@ -762,12 +774,13 @@ test_expect_success 'worktree: pack-refs in main repo packs main refs' '
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
 
@@ -775,19 +788,21 @@ test_expect_success 'worktree: pack-refs in worktree packs worktree refs' '
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
@@ -795,7 +810,7 @@ test_expect_success 'worktree: creating shared ref updates main stack' '
 	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
 	test_line_count = 1 repo/.git/reftable/tables.list &&
 
-	git -C worktree update-ref refs/heads/shared HEAD &&
+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C worktree update-ref refs/heads/shared HEAD &&
 	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
 	test_line_count = 2 repo/.git/reftable/tables.list
 '
-- 
gitgitgadget

