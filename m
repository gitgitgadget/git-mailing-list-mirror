Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA132A3C8
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463270; cv=none; b=dcqocWe2fzl1GuDaveT+212b3sFoxPSZVGRA+1G8Wrbz1RAg36T4aUMW+v2FrpHGUk6Rz/bZJfsPgS/g+BCMrvfXC1HybMX2jxtAeYauxFgtuK1nwCjeTZXgqwkR6nLN29GMyQ0XBIso3nVedA07iQRqLeUgzU2BD6j/qiUeQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463270; c=relaxed/simple;
	bh=BHngurex3255qtYN2xwUEw6mVllhzjS+H7vzLJ2exSg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dDKVyISdj8FvuwNYH6zmRnp27skETMSn/Xas7wJdsMsnSXLprr8jVfz5toWDNmLdymFpp7t3kSI46mI7B30SENCRS1xXeA95y5v/ltveJU4jNayGSrnuodMG4qg1eHDRKPk7VUWM/yDTJ0mzCxGkdqqjTdiE93xMCyR5zbSFte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7PBzuDg; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7PBzuDg"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-897002b7576so69472986d6.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772463267; x=1773068067; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WoISCWPjwWZk96MAJShCSTksP5s+iI+JOn910khkEk=;
        b=G7PBzuDgpm63VzA/NA8aMQkV3ay567qAkBdELbL3prObqWzPfGbpdO3UgRume+jAOf
         aKuNbAsc6L2EPdWbZzW3JwUdiacmqfogzSHZDT8hoclb8SEwgsjeDGBUrdVvmzege1gO
         BZWydGjgNYak1W/voEpGkbjbw2q1lsN3pmXz2MolzHfXZDMnxK6cxrCaZa56Bn7K+cOJ
         zy8QbfCtdD/G98+VOE5HQVRaKm2GE2rgfJYI9pqDuFmgSrnJHLypuwUvf4NprE3JY/AK
         /bNXQu5t+GcbVcWl3qI+zHGsjRKaNG+OarlmCDt601q1aHWjCdWnnXKB5BAszN+h5usZ
         1HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772463267; x=1773068067;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WoISCWPjwWZk96MAJShCSTksP5s+iI+JOn910khkEk=;
        b=Rs7eSl9xryQUVjW9sKkngt4svwT3x853hmvNwT2OfyjCq0eeb9R+TM7Lo9xW+QFusM
         +/OOmfKoViz7pfwPqczFmvyOqPYhpNg3tIAbvGQ0RliINZVd4UhqHut4LJL2xhwdNNGL
         ZYLK74PdxVfJvYolLGIr44iEvLdbcVw52pN9LcO9wn4IO1cL5W1oo2QzmRPebKXZgDrn
         5HE0gITT80vvt65C17MWdt1ZLWkBExHdl2G3eIePopX+PtxZegAyue0gn5RN3Zzf9PXO
         aI/e7QcrA92yJF+Dm2UJ5WRqIGQccZ3o7T5R0nbq6OKSEziisPWI+OfLHDk2J3XkFacO
         FYfw==
X-Gm-Message-State: AOJu0YwFMuyVNByxre0E70KeaetuiPH07XF5VZcmhkE6Ewsa0VxNiZnX
	8+VSPfq8IMdkloh65KQPEhQ3LMfI0qnJk6PDCjdVHk/H4w8inBBG8pzTf4OTLg==
X-Gm-Gg: ATEYQzzcEiS/Zy0UZ692TUnYjvLmBBuZ45WJKeIr/H3T4sTcjlfL+LwTrC+jYeEd4In
	+xB2A3Q67JidGYD2wMljhnkZq4b4lBKS1oAHB7xqjfABfGkZOexxSKe9EwTz43RzO0GwuDBCp5j
	5MWFHsvBrcYyFmLOLY9gS+j8W/28h7nKI6pgGBqYTn7TI+8Ibv0cPVtZNyCaassrtq5Np0W3bn5
	wtSOjz66LpgtDpYT/gJ+4RkCFvgWSkTZmbbII1ahQVDfaon30nWGDO1FChaYL8qGRoYLpsTqmiB
	9pH2VwRmR2XAHDGbF7nnV4fOqjHsH85ngZGJBi6fvyViFx86WplF8ZONgVnA+Hm1IRudP77yo5p
	v475B0p5EDcQBNj5MIZtAqvDgtjnt6VGSQSVgtECSJZ8sj0FDR+CwrrZS1kmWCjwhhJSdQ7G9IV
	/efseKzXF2gD/2KAmph5TifQwODg==
X-Received: by 2002:a05:6214:21e8:b0:899:bd86:4ff9 with SMTP id 6a1803df08f44-899d1d56d0cmr184139016d6.5.1772463267310;
        Mon, 02 Mar 2026 06:54:27 -0800 (PST)
Received: from [127.0.0.1] ([64.236.140.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c73a320dsm108614376d6.52.2026.03.02.06.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:54:26 -0800 (PST)
Message-Id: <pull.2120.v2.git.git.1772463265865.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
From: "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 14:54:25 +0000
Subject: [PATCH v2] xdiff: re-diff shifted change groups when using histogram
 algorithm
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Yee Cheng Chin <ychin.git@gmail.com>,
    Yee Cheng Chin <ychin.git@gmail.com>

From: Yee Cheng Chin <ychin.git@gmail.com>

After a diff algorithm has been run, the compaction phase
(xdl_change_compact()) shifts and merges change groups to produce a
cleaner output. However, this shifting could create a new matched group
where both sides now have matching lines. This results in a
wrong-looking diff output which contains redundant lines that are the
same on both files.

Fix this by detecting this situation, and re-diff the texts on each side
to find similar lines, using the fall-back Myer's diff. Only do this for
histogram diff as it's the only algorithm where this is relevant. Below
contains an example, and more details.

For an example, consider two files below:

    file1:
        A

        A
        A
        A

        A
        A
        A

    file2:
        A

        A
        x
        A

        A
        A
        A

When using Myer's diff, the algorithm finds that only the "x" has been
changed, and produces a final diff result (these are line diffs, but
using word-diff syntax for ease of presentation):

        A A[-A-]{+x+}A AAA

When using histogram diff, the algorithm first discovers the LCS "A
AAA", which it uses as anchor, then produces an intermediate diff:

        {+A Ax+}A AAA[- AAA-].

This is a longer diff than Myer's, but it's still self-consistent.
However, the compaction phase attempts to shift the first file's diff
group upwards (note that this shift crosses the anchor that histogram
had used), leading to the final results for histogram diff:

        [-A AA-]{+A Ax+}A AAA

This is a technically correct patch but looks clearly redundant to a
human as the first 3 lines should not be in the diff.

The fix would detect that a shift has caused matching to a new group,
and re-diff the "A AA" and "A Ax" parts, which results in "A A"
correctly re-marked as unchanged. This creates the now correct histogram
diff:

        A A[-A-]{+x+}A AAA

This issue is not applicable to Myer's diff algorithm as it already
generates a minimal diff, which means a shift cannot result in a smaller
diff output (the default Myer's diff in xdiff is not guaranteed to be
minimal for performance reasons, but it typically does a good enough
job).

It's also not applicable to patience diff, because it uses only unique
lines as anchor for its splits, and falls back to Myer's diff within
each split. Shifting requires both ends having the same lines, and
therefore cannot cross the unique line boundaries established by the
patience algorithm. In contrast histogram diff uses non-unique lines as
anchors, and therefore shifting can cross over them.

This issue is rare in a normal repository. Below is a table of
repositories (`git log --no-merges -p --histogram -1000`), showing how
many times a re-diff was done and how many times it resulted in finding
matching lines (therefore addressing this issue) with the fix. In
general it is fewer than 1% of diff's that exhibit this offending
behavior:

| Repo (1k commits)  | Re-diff | Found matching lines |
|--------------------|---------|----------------------|
| llvm-project       |  45     | 11                   |
| vim                | 110     |  9                   |
| git                |  18     |  2                   |
| WebKit             | 168     |  1                   |
| ripgrep            |  22     |  1                   |
| cpython            |  32     |  0                   |
| vscode             |  13     |  0                   |

Signed-off-by: Yee Cheng Chin <ychin.git@gmail.com>
---
    xdiff: re-diff shifted change groups when using histogram algorithm
    
    Changes since v1:
    
     * Fix the entry condition to be easier to understand by checking for
       go.end!=go.start, which makes it clear that this is just a triviality
       test (if one side is empty there is no point in diff'ing anything)
     * Remove go_orig, which was redundant as it was tracking the same thing
       as g_orig.
     * Use assignment instead of memcpy()
     * Clean up comments
     * Per discussed, add test to show that we need to re-diff even if we
       entere the first condition "no shifting was possible".
    
    This is a somewhat rare issue when using histogram to diff files, as the
    algorithm will generate a diff output that looks redundant and wrong to
    a human. I provided a synthetic example in the commit message, but for
    one from the real world, do the following command in the Git repo:
    
    git show -U0 --diff-algorithm=histogram 2c8999027c -- po/ga.po
    
    
    Scroll to the line "@@ -7239,3 +5831,5 @@", and we can see the following
    diff hunk:
    
    -#: builtin/diff.c
    -msgid "Not a git repository"
    -msgstr "Ní stór git"
    +msgid "cannot come back to cwd"
    +msgstr "ní féidir teacht ar ais chuig cwd"
    +
    +msgid "Not a git repository"
    +msgstr "Ní stór git é"
    
    
    We can see that the "Not a git repository" line is identical on both
    sides, which means it should not have been in the diff results to begin
    with. Under other diff algorithms (or histogram diff with this fix),
    said line is not considered to be part of the diff.
    
    Also, when I was implementing this, an alternative I was considering was
    to add a bespoke linear-time algorithm to remove matching lines on both
    sides. Just calling the fall-back diff seems the easiest and cleanest
    and so I went with that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2120%2Fychin%2Fxdiff-fix-compact-remove-redundant-lines-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2120/ychin/xdiff-fix-compact-remove-redundant-lines-v2
Pull-Request: https://github.com/git/git/pull/2120

Range-diff vs v1:

 1:  34a370e59e ! 1:  bd63c6866b xdiff: re-diff shifted change groups when using histogram algorithm
     @@ Commit message
      
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
     -   't4070-diff-pairs.sh',
         't4071-diff-minimal.sh',
         't4072-diff-max-depth.sh',
     -+  't4073-diff-shifted-matched-group.sh',
     +   't4073-diff-stat-name-width.sh',
     ++  't4074-diff-shifted-matched-group.sh',
         't4100-apply-stat.sh',
         't4101-apply-nonl.sh',
         't4102-apply-rename.sh',
      
     - ## t/t4073-diff-shifted-matched-group.sh (new) ##
     + ## t/t4074-diff-shifted-matched-group.sh (new) ##
      @@
      +#!/bin/sh
      +
     @@ t/t4073-diff-shifted-matched-group.sh (new)
      +
      +. ./test-lib.sh
      +
     -+test_expect_success 'shifted diff group should re-diff to minimize patch' '
     ++test_expect_success 'shifted/merged diff group should re-diff to minimize patch' '
      +	test_write_lines A x A A A x A A A >file1 &&
      +	test_write_lines A x A Z A x A A A >file2 &&
      +
     @@ t/t4073-diff-shifted-matched-group.sh (new)
      +	test_cmp expect output
      +'
      +
     ++test_expect_success 'merged diff group with no shift' '
     ++	test_write_lines A Z B x >file1 &&
     ++	test_write_lines C D x Z E x >file2 &&
     ++
     ++	file1_h=$(git rev-parse --short $(git hash-object file1)) &&
     ++	file2_h=$(git rev-parse --short $(git hash-object file2)) &&
     ++
     ++	cat >expect <<-EOF &&
     ++	diff --git a/file1 b/file2
     ++	index $file1_h..$file2_h 100644
     ++	--- a/file1
     ++	+++ b/file2
     ++	@@ -1,4 +1,6 @@
     ++	-A
     ++	+C
     ++	+D
     ++	+x
     ++	 Z
     ++	-B
     ++	+E
     ++	 x
     ++	EOF
     ++
     ++	test_expect_code 1 git diff --no-index --histogram file1 file2 >output &&
     ++	test_cmp expect output
     ++'
     ++
      +test_expect_success 're-diff should preserve diff flags' '
      +	test_write_lines a b c a b c >file1 &&
      +	test_write_lines x " b" z a b c >file2 &&
     @@ xdiff/xdiffi.c: static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
        */
       int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
       	struct xdlgroup g, go;
     -+	struct xdlgroup g_orig, go_orig;
     ++	struct xdlgroup g_orig;
       	long earliest_end, end_matching_other;
       	long groupsize;
       
     @@ xdiff/xdiffi.c: int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags
       			goto next;
       
      +		g_orig = g;
     -+		go_orig = go;
      +
       		/*
       		 * Now shift the change up and then down as far as possible in
       		 * each direction. If it bumps into any other changes, merge
     +-		 * them.
     ++		 * them and restart the process.
     + 		 */
     + 		do {
     + 			groupsize = g.end - g.start;
     +@@ xdiff/xdiffi.c: int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
     + 			/*
     + 			 * Move the possibly merged group of changes back to
     + 			 * line up with the last group of changes from the
     +-			 * other file that it can align with.
     ++			 * other file that it can align with. This avoids breaking
     ++			 * a single change into a separate addition/deletion.
     + 			 */
     + 			while (go.end == go.start) {
     + 				if (group_slide_up(xdf, &g))
      @@ xdiff/xdiffi.c: int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
       			}
       		}
       
      +		/*
     -+		 * If this has a matching group from the other file, it could
     -+		 * either be the original match from the diff algorithm, or
     -+		 * arrived at by shifting and joining groups. When it's the
     -+		 * latter, it's possible for the two newly joined sides to have
     -+		 * matching lines. Re-diff the group to mark these matching
     -+		 * lines as unchanged and remove from the diff output.
     ++		 * If we merged change groups during shifting, the new
     ++		 * combined group could now have matching lines in both files,
     ++		 * even if the original separate groups did not. Re-diff the
     ++		 * new group to find these matching lines to mark them as
     ++		 * unchanged.
     ++		 *
     ++		 * Only do this if the corresponding group in the other file is
     ++		 * non-empty, as it's trivial otherwise.
      +		 *
     -+		 * Only do this for histogram diff as its LCS algorithm makes
     -+		 * this scenario possible. In contrast, patience diff finds LCS
     ++		 * Only do this for histogram diff as its LCS algorithm allows
     ++		 * for this scenario. In contrast, patience diff finds LCS
      +		 * of unique lines that groups cannot be shifted across.
      +		 * Myer's diff (standalone or used as fall-back in patience
      +		 * diff) already finds minimal edits so it is not possible for
     @@ xdiff/xdiffi.c: int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags
      +		 * XDF_NEED_MINIMAL, Myer's isn't technically guaranteed to be
      +		 * minimal, but it should be so most of the time)
      +		 */
     -+		if (end_matching_other != -1 &&
     ++		if (go.end != go.start &&
      +				XDF_DIFF_ALG(flags) == XDF_HISTOGRAM_DIFF &&
      +				(g.start != g_orig.start ||
     -+				 g.end != g_orig.end ||
     -+				 go.start != go_orig.start ||
     -+				 go.end != go_orig.end)) {
     ++				 g.end != g_orig.end)) {
      +			xpparam_t xpp;
      +			xdfenv_t xe;
      +
      +			memset(&xpp, 0, sizeof(xpp));
      +			xpp.flags = flags & ~XDF_DIFF_ALGORITHM_MASK;
      +
     -+			memcpy(&xe.xdf1, xdf, sizeof(xdfile_t));
     -+			memcpy(&xe.xdf2, xdfo, sizeof(xdfile_t));
     ++			xe.xdf1 = *xdf;
     ++			xe.xdf2 = *xdfo;
      +
      +			if (xdl_fall_back_diff(&xe, &xpp,
      +					       g.start + 1, g.end - g.start,


 t/meson.build                         |   1 +
 t/t4074-diff-shifted-matched-group.sh | 164 ++++++++++++++++++++++++++
 xdiff/xdiffi.c                        |  47 +++++++-
 3 files changed, 210 insertions(+), 2 deletions(-)
 create mode 100755 t/t4074-diff-shifted-matched-group.sh

diff --git a/t/meson.build b/t/meson.build
index 6d91470ebc..dfd0a5a7d9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -504,6 +504,7 @@ integration_tests = [
   't4071-diff-minimal.sh',
   't4072-diff-max-depth.sh',
   't4073-diff-stat-name-width.sh',
+  't4074-diff-shifted-matched-group.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4074-diff-shifted-matched-group.sh b/t/t4074-diff-shifted-matched-group.sh
new file mode 100755
index 0000000000..d77fa3b79d
--- /dev/null
+++ b/t/t4074-diff-shifted-matched-group.sh
@@ -0,0 +1,164 @@
+#!/bin/sh
+
+test_description='shifted diff groups re-diffing during histogram diff'
+
+. ./test-lib.sh
+
+test_expect_success 'shifted/merged diff group should re-diff to minimize patch' '
+	test_write_lines A x A A A x A A A >file1 &&
+	test_write_lines A x A Z A x A A A >file2 &&
+
+	file1_h=$(git rev-parse --short $(git hash-object file1)) &&
+	file2_h=$(git rev-parse --short $(git hash-object file2)) &&
+
+	cat >expect <<-EOF &&
+	diff --git a/file1 b/file2
+	index $file1_h..$file2_h 100644
+	--- a/file1
+	+++ b/file2
+	@@ -1,7 +1,7 @@
+	 A
+	 x
+	 A
+	-A
+	+Z
+	 A
+	 x
+	 A
+	EOF
+
+	test_expect_code 1 git diff --no-index --histogram file1 file2 >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'merged diff group with no shift' '
+	test_write_lines A Z B x >file1 &&
+	test_write_lines C D x Z E x >file2 &&
+
+	file1_h=$(git rev-parse --short $(git hash-object file1)) &&
+	file2_h=$(git rev-parse --short $(git hash-object file2)) &&
+
+	cat >expect <<-EOF &&
+	diff --git a/file1 b/file2
+	index $file1_h..$file2_h 100644
+	--- a/file1
+	+++ b/file2
+	@@ -1,4 +1,6 @@
+	-A
+	+C
+	+D
+	+x
+	 Z
+	-B
+	+E
+	 x
+	EOF
+
+	test_expect_code 1 git diff --no-index --histogram file1 file2 >output &&
+	test_cmp expect output
+'
+
+test_expect_success 're-diff should preserve diff flags' '
+	test_write_lines a b c a b c >file1 &&
+	test_write_lines x " b" z a b c >file2 &&
+
+	file1_h=$(git rev-parse --short $(git hash-object file1)) &&
+	file2_h=$(git rev-parse --short $(git hash-object file2)) &&
+
+	cat >expect <<-EOF &&
+	diff --git a/file1 b/file2
+	index $file1_h..$file2_h 100644
+	--- a/file1
+	+++ b/file2
+	@@ -1,6 +1,6 @@
+	-a
+	-b
+	-c
+	+x
+	+ b
+	+z
+	 a
+	 b
+	 c
+	EOF
+
+	test_expect_code 1 git diff --no-index --histogram file1 file2 >output &&
+	test_cmp expect output &&
+
+	cat >expect_iwhite <<-EOF &&
+	diff --git a/file1 b/file2
+	index $file1_h..$file2_h 100644
+	--- a/file1
+	+++ b/file2
+	@@ -1,6 +1,6 @@
+	-a
+	+x
+	  b
+	-c
+	+z
+	 a
+	 b
+	 c
+	EOF
+
+	test_expect_code 1 git diff --no-index --histogram --ignore-all-space file1 file2 >output_iwhite &&
+	test_cmp expect_iwhite output_iwhite
+'
+
+test_expect_success 'shifting on either side should trigger re-diff properly' '
+	test_write_lines a b c a b c a b c >file1 &&
+	test_write_lines a b c a1 a2 a3 b c1 a b c >file2 &&
+
+	file1_h=$(git rev-parse --short $(git hash-object file1)) &&
+	file2_h=$(git rev-parse --short $(git hash-object file2)) &&
+
+	cat >expect1 <<-EOF &&
+	diff --git a/file1 b/file2
+	index $file1_h..$file2_h 100644
+	--- a/file1
+	+++ b/file2
+	@@ -1,9 +1,11 @@
+	 a
+	 b
+	 c
+	-a
+	+a1
+	+a2
+	+a3
+	 b
+	-c
+	+c1
+	 a
+	 b
+	 c
+	EOF
+
+	test_expect_code 1 git diff --no-index --histogram file1 file2 >output1 &&
+	test_cmp expect1 output1 &&
+
+	cat >expect2 <<-EOF &&
+	diff --git a/file2 b/file1
+	index $file2_h..$file1_h 100644
+	--- a/file2
+	+++ b/file1
+	@@ -1,11 +1,9 @@
+	 a
+	 b
+	 c
+	-a1
+	-a2
+	-a3
+	+a
+	 b
+	-c1
+	+c
+	 a
+	 b
+	 c
+	EOF
+
+	test_expect_code 1 git diff --no-index --histogram file2 file1 >output2 &&
+	test_cmp expect2 output2
+'
+
+test_done
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 4376f943db..5455b4690d 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -792,6 +792,7 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
  */
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	struct xdlgroup g, go;
+	struct xdlgroup g_orig;
 	long earliest_end, end_matching_other;
 	long groupsize;
 
@@ -805,10 +806,12 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		if (g.end == g.start)
 			goto next;
 
+		g_orig = g;
+
 		/*
 		 * Now shift the change up and then down as far as possible in
 		 * each direction. If it bumps into any other changes, merge
-		 * them.
+		 * them and restart the process.
 		 */
 		do {
 			groupsize = g.end - g.start;
@@ -861,7 +864,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			/*
 			 * Move the possibly merged group of changes back to
 			 * line up with the last group of changes from the
-			 * other file that it can align with.
+			 * other file that it can align with. This avoids breaking
+			 * a single change into a separate addition/deletion.
 			 */
 			while (go.end == go.start) {
 				if (group_slide_up(xdf, &g))
@@ -914,6 +918,45 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			}
 		}
 
+		/*
+		 * If we merged change groups during shifting, the new
+		 * combined group could now have matching lines in both files,
+		 * even if the original separate groups did not. Re-diff the
+		 * new group to find these matching lines to mark them as
+		 * unchanged.
+		 *
+		 * Only do this if the corresponding group in the other file is
+		 * non-empty, as it's trivial otherwise.
+		 *
+		 * Only do this for histogram diff as its LCS algorithm allows
+		 * for this scenario. In contrast, patience diff finds LCS
+		 * of unique lines that groups cannot be shifted across.
+		 * Myer's diff (standalone or used as fall-back in patience
+		 * diff) already finds minimal edits so it is not possible for
+		 * shifted groups to result in a smaller diff. (Without
+		 * XDF_NEED_MINIMAL, Myer's isn't technically guaranteed to be
+		 * minimal, but it should be so most of the time)
+		 */
+		if (go.end != go.start &&
+				XDF_DIFF_ALG(flags) == XDF_HISTOGRAM_DIFF &&
+				(g.start != g_orig.start ||
+				 g.end != g_orig.end)) {
+			xpparam_t xpp;
+			xdfenv_t xe;
+
+			memset(&xpp, 0, sizeof(xpp));
+			xpp.flags = flags & ~XDF_DIFF_ALGORITHM_MASK;
+
+			xe.xdf1 = *xdf;
+			xe.xdf2 = *xdfo;
+
+			if (xdl_fall_back_diff(&xe, &xpp,
+					       g.start + 1, g.end - g.start,
+					       go.start + 1, go.end - go.start)) {
+				return -1;
+			}
+		}
+
 	next:
 		/* Move past the just-processed group: */
 		if (group_next(xdf, &g))

base-commit: 2cc71917514657b93014134350864f4849edfc83
-- 
gitgitgadget
