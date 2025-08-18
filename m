Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286A258ECA
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515608; cv=none; b=g0V8scWLA7fCsbT5p94q1QK62tx6xcUYJRTGEMAqRxuTdElp4kThWaUcbEDln5b3lQwvY6g37OIi4tlcD4cmYlcCmMMR49Y4DQZSM2zLacSYjrdRMTwyxXUBLxZkER4ZAV9v4o8nnf5cL6w6Ukf3hMpWmBlsHDYBJ6SwI8wPHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515608; c=relaxed/simple;
	bh=rUIt1ZAwDk3hAD5rkxDLYdTd7KY5fCAchRptYCOu3MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trUMDKxoxYleaR0oSVKjrGi9tmPTk/JjTQO2Kn+dRXoyToTLKifChKJ4ub3UQm3itUvwBIj6TSiyq+Opwbu6Rw1nWbwOEP6NNmqtMr2xS5IIilufycvF6N3N2kZXBpWgos93I2ELRmqYcxNXpQ+jA516BkOAT3jfuGK6rUVjuuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZyfBHb9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZyfBHb9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so2778979f8f.1
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755515604; x=1756120404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfAPY+1GFYiVmUlD0jwKiJCN1iq4S9tCh623tYQzQM0=;
        b=PZyfBHb9gNLb1BE8ew3vP1Zsrxn8R5jw6Up3VZ3d4VaJ980eM5IbKLzh2DZaKkqYZH
         iCv2hXkIGBpmc37COxq2pOG02aJfcA5Eg4pLb3+heqwSES6G7PW6Gh/KfhmPOvNWnJu7
         GHdB1+QKa049lKn0WQyOyfOmRc24XK8zOxp8c4rC7N7LvGdxOd6D/M5pVUx2dvldeMFT
         sPfezeFNyr2dbPy+kZbAaZAkemrac8hIdCqKQqmJgjCGcOGuEUBJQdeaFOL8cpqB1V5q
         dt+nWKxhtH9Ke4H2U7167BxJ2hkri2ODtS1PJMXwjRrJw41GelBD/IGd6YSCkFL4YNZt
         r6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755515604; x=1756120404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfAPY+1GFYiVmUlD0jwKiJCN1iq4S9tCh623tYQzQM0=;
        b=kmzePTgxFHjm9/+emOOCCMsb+BgAUxet7zJ/oEJxNAHtXUYqCgq5uxbtB6LLsOpebR
         7Ym3HIV3ze/ka/HKvcdBdaVhpvyxwwEw+LdanME3zleqUm8SKRRwVIzXDwyvGOUNQWfN
         ouusmE5tTdFSp3SE44YcUg/6yVFn5t1jAke3PWDQswLDdokC+A2pfWFxWcxDhVIQ6e8E
         unFuhVRb3aXa76+ZkPEtPeHP39vsFl9BfswpWTEutyEEvBIlmMm7hQYdm4qgzxyEZEn2
         rQWV4f+OqBaT36dSvTjn7gdmXXwa3YME9hM1m0Ns2D4+GJj9XMvdxN0Ls4IjVo0p6V6z
         mndw==
X-Gm-Message-State: AOJu0Yxr0g6Xl4Fcwh8iGReZ51Q2A/F2BpYPwz3kIz0qsMxMeKHzt56K
	39MkUvmQRYNU7qBuTYRyx3havNlRdW5gBMY9sgl+DTSV8JjTMnRsmrq1yUhp9g==
X-Gm-Gg: ASbGncuAbEVEucIO3dBTAo+tLMpZm2etCZmyuhvRB0JgLAz8debzAWq84+4eK4FllEP
	K0yMi2OkFqbHNTnKysElfjBWEETnnc7gn+m35kmLkk8aUzzpjc+rR1hEbzEb9CghAFwSWhODCPz
	o8QnJT1yHR+slnoJP6nRYb9QlOan1wbZOqX4d+MUeJLbWndLz8+Z+ucsTer1mvELJhVLAN0XihT
	OqIV6iLoZjbVWqCHnEYB2gMbdByfHHCp+va65rYq/MJh9KG4Po55eopA0Zxe4gD3UDdP/I1YdPD
	+mfSRPLJQfk3gN1uF8GoORo1FsTgd4NV+ZRiUQ0+EEOCqADDZPied21F0rPBOpXmGBx8bwqqDCo
	As9xJHiCK2QY16rzEA0HpOeqok3JjnT8UMjv/5m8tlMe3J/EzzEFMsejiWAgBBX8zIK60oHfe7C
	eADme7ZZvF8lKw
X-Google-Smtp-Source: AGHT+IGzck9uafD41GRpCyZPC1xR0sVzff2eLDL3PmkmanlVoYl3w/c4ujxVJWm1JcwBtKaHoFx7bA==
X-Received: by 2002:a05:6000:4202:b0:3b8:d7c7:71bb with SMTP id ffacd0b85a97d-3bb66e16fa3mr8393500f8f.21.1755515603995;
        Mon, 18 Aug 2025 04:13:23 -0700 (PDT)
Received: from localhost (2A0011100205B3242CE2DE6CDE8A6370.mobile.pool.telekom.hu. [2a00:1110:205:b324:2ce2:de6c:de8a:6370])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a2231a67asm126226165e9.11.2025.08.18.04.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 04:13:23 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Evgeni Chasnovski <evgeni.chasnovski@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] line-log: fix assertion error
Date: Mon, 18 Aug 2025 13:13:09 +0200
Message-ID: <20250818111310.1283932-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2.346.g6515629ae9
In-Reply-To: <20250818111310.1283932-1-szeder.dev@gmail.com>
References: <20250818111310.1283932-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When line-level log is invoked with more than one disjoint line range
in the same file, and one of the commits happens to change that file
such that:

  - the last line of a line range R(n) immediately preceeds the first line
    modified or added by a hunk H, and
  - subtracting the number of lines added by hunk H from the start and
    end of the subsequent line range R(n+1) would result in a range
    overlapping with line range R(n),

then git aborts with an assertion error, because those overlapping
line ranges violate the invariants:

  $ git log --oneline -p
  73e4e2f (HEAD -> master) Add lines 6 7 8 9 10
  diff --git a/file b/file
  index 572d5d9..00935f1 100644
  --- a/file
  +++ b/file
  @@ -3,3 +3,8 @@ Line 2
   Line 3
   Line 4
   Line 5
  +Line 6
  +Line 7
  +Line 8
  +Line 9
  +Line 10
  66e3561 Add lines 1 2 3 4 5
  diff --git a/file b/file
  new file mode 100644
  index 0000000..572d5d9
  --- /dev/null
  +++ b/file
  @@ -0,0 +1,5 @@
  +Line 1
  +Line 2
  +Line 3
  +Line 4
  +Line 5
  $ git log --oneline -L3,5:file -L7,8:file
  git: line-log.c:73: range_set_append: Assertion `rs->nr == 0 || rs->ranges[rs->nr-1].end <= a' failed.
  Aborted (core dumped)

The line-log machinery encodes line and diff ranges internally as
[start, end) pairs, i.e. include 'start' but exclude 'end', and line
numbering starts at 0 (as opposed to the -LX,Y option, where it starts
at 1, IOW the parameter -L3,5 is represented internally as { start =
2, end = 5 }).

The reason for this assertion error and some related issues is that
there are a couple of places where 'end' is mistakenly considered to
be part of the range:

  - When a commit modifies an interesting path, the line-log machinery
    first checks which diff range (i.e. hunk) modify any line ranges.
    This is done in diff_ranges_filter_touched(), where the outer loop
    iterates over the diff ranges, and in each iteration the inner
    loop advances the line ranges supposedly until the current line
    range ends at or after the current diff range starts, and then the
    current diff and line ranges are checked for overlap.

    For HEAD in the above example the first line range [2, 5) ends
    just before the diff range [5, 10) starts, so the inner loop
    should advance, and then the second line range [6, 8) and the diff
    range should be checked for overlap.

    Unfortunately, the condition of the inner loop mistakenly
    considers 'end' as part of the line range, and, seeing the diff
    range starting at 5 and the line range ending at 5, it doesn't
    skip the first range.  Consequently, the diff range and the first
    line range are checked for overlap, and after that the outer loop
    runs out of diff ranges, and then the processing goes on in the
    false belief that this commit didn't touch any of the interesting
    line ranges.

    The line-log machinery later shifts the line ranges to account for
    any added/removed lines in the diff ranges preceeding each line
    range.  This leaves the first line range intact, but attempts to
    shift the second line range [6, 8) by 5 lines towards the
    beginning of the file, resulting in [1, 3), triggering the
    assertion error, because the two overlapping line ranges violate
    the invariants.

    Fix that loop condition in diff_ranges_filter_touched() to not
    treat 'end' as part of the line range.

  - With the above fix the assertion error is gone... but, alas, we
    now get stuck in an endless loop!

    This happens in range_set_difference(), where a couple of nested
    loops iterate over the line and diff ranges, and a condition is
    supposed to break the middle loop when the current line range ends
    before the current diff range, so processing could continue with
    the next line range.

    For HEAD in the above example the first line range [2, 5) ends
    just before the diff range [5, 10) starts, so this condition
    should trigger and break the middle loop.

    Unfortunately, just like in the case of the assertion error, this
    conditions mistakenly considers 'end' as part of the line range,
    and, seeing the line range ending at 5 and the diff range starting
    at 5, it doesn't break the loop, which will then go on and on.

    Fix this condition in range_set_difference() to not treat 'end' as
    part of the line range.

  - With the above fix the endless loop is gone... but, alas, the
    output is now wrong, as it shows both line ranges for HEAD, even
    though the first line range is not modified by that commit:

      $ git log --oneline -L3,5:file -L7,8:file
      73e4e2f (HEAD -> master) Add lines 6 7 8 9 10

      diff --git a/file b/file
      --- a/file
      +++ b/file
      @@ -3,3 +3,3 @@
       Line 3
       Line 4
       Line 5
      @@ -6,0 +7,2 @@
      +Line 7
      +Line 8
      66e3561 Add lines 1 2 3 4 5

      diff --git a/file b/file
      --- /dev/null
      +++ b/file
      @@ -0,0 +3,3 @@
      +Line 3
      +Line 4
      +Line 5

    In dump_diff_hacky_one() a couple of nested loops are responsible
    for finding and printing the modified line ranges: the big outer
    loop iterates over all line ranges, and the first inner loop skips
    over the diff ranges that end before the start of the current line
    range.  This is followed by a condition checking whether the
    current diff range starts after the end of the current line range,
    which, when fulfilled, continues and advances the outer loop to
    the next line range.

    For HEAD in the above example the first line range [2, 5) ends
    just before the diff range [5, 10), so this condition should
    trigger, and the outer loop should advance to the second line
    range.

    Unfortunately, just like in the previous cases, this condition
    mistakenly considers 'end' as part of the line range, and, seeing
    the first line range ending at 5 and the diff range starting at 5,
    it doesn't continue to advance the outher loop, but goes on to
    show the (unmodified) first line range.

    Fix this condition to not treat 'end' as part of the line range,
    just like in the previous cases.

After all this the command in the above example finally finishes and
produces the right output:

  $ git log --oneline -L3,5:file -L7,8:file
  73e4e2f (HEAD -> master) Add lines 6 7 8 9 10

  diff --git a/file b/file
  --- a/file
  +++ b/file
  @@ -6,0 +7,2 @@
  +Line 7
  +Line 8
  66e3561 Add lines 1 2 3 4 5

  diff --git a/file b/file
  --- /dev/null
  +++ b/file
  @@ -0,0 +3,3 @@
  +Line 3
  +Line 4
  +Line 5

Add a canned test similar to the above example, with the line ranges
adjusted to the test repository's history.

Reported-by: Evgeni Chasnovski <evgeni.chasnovski@gmail.com>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 line-log.c                               |  6 +-
 t/t4211-line-log.sh                      |  2 +
 t/t4211/sha1/expect.no-assertion-error   | 90 ++++++++++++++++++++++++
 t/t4211/sha256/expect.no-assertion-error | 90 ++++++++++++++++++++++++
 4 files changed, 185 insertions(+), 3 deletions(-)
 create mode 100644 t/t4211/sha1/expect.no-assertion-error
 create mode 100644 t/t4211/sha256/expect.no-assertion-error

diff --git a/line-log.c b/line-log.c
index 628e3fe3ae..9cb8ea1484 100644
--- a/line-log.c
+++ b/line-log.c
@@ -201,7 +201,7 @@ static void range_set_difference(struct range_set *out,
 				 * b: ------|
 				 */
 				j++;
-			if (j >= b->nr || end < b->ranges[j].start) {
+			if (j >= b->nr || end <= b->ranges[j].start) {
 				/*
 				 * b exhausted, or
 				 * a:  ----|
@@ -408,7 +408,7 @@ static void diff_ranges_filter_touched(struct diff_ranges *out,
 	assert(out->target.nr == 0);
 
 	for (i = 0; i < diff->target.nr; i++) {
-		while (diff->target.ranges[i].start > rs->ranges[j].end) {
+		while (diff->target.ranges[i].start >= rs->ranges[j].end) {
 			j++;
 			if (j == rs->nr)
 				return;
@@ -941,7 +941,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 
 		while (j < diff->target.nr && diff->target.ranges[j].end < t_start)
 			j++;
-		if (j == diff->target.nr || diff->target.ranges[j].start > t_end)
+		if (j == diff->target.nr || diff->target.ranges[j].start >= t_end)
 			continue;
 
 		/* Scan ahead to determine the last diff that falls in this range */
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 950451cf6a..0a7c3ca42f 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -78,6 +78,8 @@ canned_test "-L :main:a.c -L 4,18:a.c simple" multiple-overlapping
 canned_test "-L 4:a.c -L 8,12:a.c simple" multiple-superset
 canned_test "-L 8,12:a.c -L 4:a.c simple" multiple-superset
 
+canned_test "-L 10,16:b.c -L 18,26:b.c main" no-assertion-error
+
 test_bad_opts "-L" "switch.*requires a value"
 test_bad_opts "-L b.c" "argument not .start,end:file"
 test_bad_opts "-L 1:" "argument not .start,end:file"
diff --git a/t/t4211/sha1/expect.no-assertion-error b/t/t4211/sha1/expect.no-assertion-error
new file mode 100644
index 0000000000..994c37db1e
--- /dev/null
+++ b/t/t4211/sha1/expect.no-assertion-error
@@ -0,0 +1,90 @@
+commit 0d8dcfc6b968e06a27d5215bad1fdde3de9d6235
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:50:24 2013 +0100
+
+    move within the file
+
+diff --git a/b.c b/b.c
+--- a/b.c
++++ b/b.c
+@@ -25,0 +18,9 @@
++long f(long x)
++{
++	int s = 0;
++	while (x) {
++		x /= 2;
++		s++;
++	}
++	return s;
++}
+
+commit 4659538844daa2849b1a9e7d6fadb96fcd26fc83
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,7 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 100b61a6f2f720f812620a9d10afb3a960ccb73c
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -17,5 +17,5 @@
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +16,5 @@
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/sha256/expect.no-assertion-error b/t/t4211/sha256/expect.no-assertion-error
new file mode 100644
index 0000000000..36ed12aa9c
--- /dev/null
+++ b/t/t4211/sha256/expect.no-assertion-error
@@ -0,0 +1,90 @@
+commit eb871b8aa9aff323e484723039c9a92ab0266e060bc0ef2afb08fadda25c5ace
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:50:24 2013 +0100
+
+    move within the file
+
+diff --git a/b.c b/b.c
+--- a/b.c
++++ b/b.c
+@@ -25,0 +18,9 @@
++long f(long x)
++{
++	int s = 0;
++	while (x) {
++		x /= 2;
++		s++;
++	}
++	return s;
++}
+
+commit 5526ed05c2476b56af8b7be499e8f78bd50f490740733a9ca7e1f55878fa90a9
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,7 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 29f32ac3141c48b22803e5c4127b719917b67d0f8ca8c5248bebfa2a19f7da10
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -17,5 +17,5 @@
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +16,5 @@
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
-- 
2.51.0.rc2.346.g6515629ae9

