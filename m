Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B543B8D53
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765054294; cv=none; b=MkVX886+Joau3vKyvs921oUksNpEfKI5+DhkWcIfZO1F+Z1o3miEYM6gfPqyiWqBf2pylUMINShTuGXB6mX0FbUArNvg4/5lg+fXmRFbg8lfpELNUCqlrEGj0N4rWPEHDSRGVo0LkqSsdqGjLP5j8cXF0jrAlRUv04Sujmt5Et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765054294; c=relaxed/simple;
	bh=EchrOyCdDi67t3mhLHDi0t3qc8VwMdMWhSdTf6e3Uik=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=E/VArMiVp+577mNyAtwZqiy6oUHNDO8Fk085SQlTRVl3IhMjkyiqJ60q5R/hGGEPV3FafecbTs4lsKsoL3cNakyj0TGQmnlaVg3b3fPkMkOWHl7lmHRotv8MPN96+6ILr9hmHeS7MPONJhiw0X7c0VYW1IDfF4s6CCsXiugTjfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGKndY6P; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGKndY6P"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3e898ba2a03so2471955fac.0
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765054291; x=1765659091; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C3ttOxkXWHDvdNIrEGBl70MPuIFwwLQ0UOXjmk2p/T8=;
        b=LGKndY6PJJxIX/w7Go7Ptel3AC/Bz1mtn4EZdk7qxC3jVEFSnEbXsE16sQo2kNNeWd
         YRXFBv90nJn9iGBRO4DTlrG2yu2RKIvJxwSnZ0vvIlLBSouaIdD6ksipE6S1imrJ61Mt
         ZEyr8C5Lug5ceIly5WWGJ5l/m7/zslhLhE8afOHhT14SxfilxGR2bI3RWcaSQr5UPeDK
         4bmlwxXDYO6tPp28/DKZi8NiYUXdQoA9QQmK1YSlC2VNyoMapiI1m10khWSgKw03BjwZ
         noC7Drg1GDAhAs0o05ONUviVJoDEt7X3rdUINhNdnoK95ktlUjZkWt9Q+CeZl2HjfeZ9
         Xtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765054291; x=1765659091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3ttOxkXWHDvdNIrEGBl70MPuIFwwLQ0UOXjmk2p/T8=;
        b=id0kTH40au1Lunlk5lWPdEZVlXP+806MtzYB/9m1U1dVPm0aHjk9Yyw0rrDBL6w5Pi
         yEod8GdvpNqT+pDK2Es77UhKCAPVYXMEXJqGv2SvomkUy4BNk6a5/KOy0SfpIOee2YA5
         DRKkzF7EFbvvBpM9QWFtQnJY6aMIA64H/eN0Tltj4tA68on54arOcT9mR0HFpvnPsZcI
         X26VOp1v/dDKH79rDf+cxGFvwq1hHUtc3aGeg9bjTVRXh+YM1bJdjm9SUnSjMu6JaZg9
         w9gJkOsPXaIflCSO7QdYDPwOXB17xLOp6nj1/OL3xL79fn6w/FRf5VYF2t9XMIYLLKNO
         iPOw==
X-Gm-Message-State: AOJu0YwDkQAXGNXork/xkIuPIArW3tlyQJix2Ex91pNfWE5DvG/y4NCg
	2WWkZ3QhoXoiGCMcN7EDiijrLlUa0hsWL80UZ6Ilys4888JXncl8iTVCE4fjEQ==
X-Gm-Gg: ASbGncv511qavRkKXp2pGf0NEtKdWsJFsmUBKmmVnsLZZUjx9e0a4Z285brlecnWd9B
	EFsEMKu2bwGcQA0FIbtbBu/T83XZgS/l+7tiNxbKc/tQNHFz0GkCU7ZDcDPyD5gXmi4tLMYMkH1
	XqDXZ8KmPCJu2Eam4tELLA9qzpsE4vdCe3qBIsYxr6tpFSLZTWUReKQc5yG+AJyXKr6niAvUiXm
	8rVmCNenwc1KEiScUNTjK7R8eyA/x8g/KsXv8jLLJPEHibX7Sczrj8g+KKo3526QwNzDuVjpqyQ
	7R9FRKf+0acdPN9brdfhTG4mkdJLeLKU7uFeFb+Ct/HdxPi8o8uNc1AtjDYotmgBQAhpQEAzNxt
	UtHASjaMEtldt5qUOqJVOY0f57qo34bU2yg6bRKI2iFvXZNaCNPckqWdIv9Gt6TaMTeOdYsBE/K
	bcHiCB3zQ/rYc=
X-Google-Smtp-Source: AGHT+IFAei3wsF0UbLyyNFanZ4xfSVoecMF9NK0vJ6R9q2sGqmVvATPe8v3t10IH3XXAO5hezOZtAQ==
X-Received: by 2002:a05:6820:6af0:b0:659:9a49:9072 with SMTP id 006d021491bc7-6599a97bf31mr1427796eaf.61.1765054290849;
        Sat, 06 Dec 2025 12:51:30 -0800 (PST)
Received: from [127.0.0.1] ([52.154.20.48])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6597ec25edcsm4172433eaf.2.2025.12.06.12.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:51:29 -0800 (PST)
Message-Id: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
From: "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Dec 2025 20:51:27 +0000
Subject: [PATCH] xdiff: re-diff shifted change groups when using histogram
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2120%2Fychin%2Fxdiff-fix-compact-remove-redundant-lines-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2120/ychin/xdiff-fix-compact-remove-redundant-lines-v1
Pull-Request: https://github.com/git/git/pull/2120

 t/meson.build                         |   1 +
 t/t4073-diff-shifted-matched-group.sh | 137 ++++++++++++++++++++++++++
 xdiff/xdiffi.c                        |  43 ++++++++
 3 files changed, 181 insertions(+)
 create mode 100755 t/t4073-diff-shifted-matched-group.sh

diff --git a/t/meson.build b/t/meson.build
index 7c994d4643..ee233e80da 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -497,6 +497,7 @@ integration_tests = [
   't4070-diff-pairs.sh',
   't4071-diff-minimal.sh',
   't4072-diff-max-depth.sh',
+  't4073-diff-shifted-matched-group.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4073-diff-shifted-matched-group.sh b/t/t4073-diff-shifted-matched-group.sh
new file mode 100755
index 0000000000..0e915b78a6
--- /dev/null
+++ b/t/t4073-diff-shifted-matched-group.sh
@@ -0,0 +1,137 @@
+#!/bin/sh
+
+test_description='shifted diff groups re-diffing during histogram diff'
+
+. ./test-lib.sh
+
+test_expect_success 'shifted diff group should re-diff to minimize patch' '
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
index 6f3998ee54..5d9c7b5434 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -793,6 +793,7 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
  */
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	struct xdlgroup g, go;
+	struct xdlgroup g_orig, go_orig;
 	long earliest_end, end_matching_other;
 	long groupsize;
 
@@ -806,6 +807,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		if (g.end == g.start)
 			goto next;
 
+		g_orig = g;
+		go_orig = go;
+
 		/*
 		 * Now shift the change up and then down as far as possible in
 		 * each direction. If it bumps into any other changes, merge
@@ -915,6 +919,45 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			}
 		}
 
+		/*
+		 * If this has a matching group from the other file, it could
+		 * either be the original match from the diff algorithm, or
+		 * arrived at by shifting and joining groups. When it's the
+		 * latter, it's possible for the two newly joined sides to have
+		 * matching lines. Re-diff the group to mark these matching
+		 * lines as unchanged and remove from the diff output.
+		 *
+		 * Only do this for histogram diff as its LCS algorithm makes
+		 * this scenario possible. In contrast, patience diff finds LCS
+		 * of unique lines that groups cannot be shifted across.
+		 * Myer's diff (standalone or used as fall-back in patience
+		 * diff) already finds minimal edits so it is not possible for
+		 * shifted groups to result in a smaller diff. (Without
+		 * XDF_NEED_MINIMAL, Myer's isn't technically guaranteed to be
+		 * minimal, but it should be so most of the time)
+		 */
+		if (end_matching_other != -1 &&
+				XDF_DIFF_ALG(flags) == XDF_HISTOGRAM_DIFF &&
+				(g.start != g_orig.start ||
+				 g.end != g_orig.end ||
+				 go.start != go_orig.start ||
+				 go.end != go_orig.end)) {
+			xpparam_t xpp;
+			xdfenv_t xe;
+
+			memset(&xpp, 0, sizeof(xpp));
+			xpp.flags = flags & ~XDF_DIFF_ALGORITHM_MASK;
+
+			memcpy(&xe.xdf1, xdf, sizeof(xdfile_t));
+			memcpy(&xe.xdf2, xdfo, sizeof(xdfile_t));
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

base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
-- 
gitgitgadget
