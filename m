Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FAA3101B2
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581346; cv=none; b=tcbl0yMnEnG72/hSCiligtvw/zYAPmTfl3NOcPt+ss5DSeVxA1+YC2DdNoCw07odGN1/MZCZFZ66eYqux7Ba49JPxvIIm0LqkJ2wTomvFK9Xu7aRT6qiL8p61Lv/rCxa9eMY3cmyM0EsJZo6SN2cLJgRUis+47TLDLPkn4OQFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581346; c=relaxed/simple;
	bh=0v5OUUj+3u3xQilHYRgIH0Rv8fisb84uoB4PA+jywg0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HRxm4yahkOEd3qUyIKg6zlx7RqLu1NjxQ3WLcrobNTFcC86Amn2fbrTSnUIOf+SKIC3QysSQazT+LQ839kTLOnoDftCPQVpmauYSvDSZ/7T24u52ztskQehMCGJMMH2zPUAfbLu3YhYjtOATpHiupu6eZQAfuFiBj7iz9LMH6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx/CfghZ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx/CfghZ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-929a7eeb0c5so193199185a.0
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581344; x=1783186144; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV377wC+eUXKt3q6ewxCadNMotT6HmzGtcUcpbdavHg=;
        b=Tx/CfghZN5OBIa896e8hmNPakPE+ceki2cdI6v0tuJLE3RVhvT72ksyRFaljCQwzOC
         ngbIFuYWluuiyt8jDASG3huGreQ9k9VSqeOznql8cqH/8JQHBfuRSn888dHV0/q8dKMg
         onLyFOWdR66C72oSBiqm2EIXJZnCYyZk9s/iYfIIs6V4NvsZi/9u8Ydgtbt05yRy+n8a
         b8eijaJYpGsDSmf5U2jjp5CCns1VBlzEHckCrVM49B1g8QXpymw3i9EDIU++mc27c/d8
         +Wuxkg4mhpuHxl30FDZWSAq2owt3CO4jA4IufavCW8zGP5WJt00CYGCPRRjR6otmKHuF
         79EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581344; x=1783186144;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eV377wC+eUXKt3q6ewxCadNMotT6HmzGtcUcpbdavHg=;
        b=pWBh61RFCXVKc7cxGKmrf3FGE7NNTvU6o6Pi8UMFT79PaRFIQvuPUud8EWfzqvjy7m
         t6n3eBDle4FAvdtUyuq1oheiYyeNYXwAxre6nfymIHuY2LZFDK0Os0TuMsjTzqQwoi/X
         cESwZrSXTCsxRny6kc9ELz6RjCExAHeT/uiscidkTYHExsek8bSy0zZFRLNyr6/4Jc/K
         Mv68i28UJIu6sKENj/kUBdvHdyD7Z4iVcEX5jnJoggtLuTfdt7H66wvdUA3GM+Ozl5yE
         TqCbrvIFldG01xRo/U7rRJu2EAoi5k6eX3Axp6upyA/Mqp1dkU42/wtEYf16dPpyPNYp
         DU7w==
X-Gm-Message-State: AOJu0YyXP7v5lSFuwR7U+Kxw5O/ONn2PwoHLrdWgLoqpnvKBTKv8RaCJ
	lYNMqbbaunTybSHUGx4bW6gyqx45xQPLOeZXKGO+oJb/ExKolOgl+/KVDmJjIg==
X-Gm-Gg: AfdE7cmCB+CyqsUWYZXFILH3I8mpWAu5R+bjuKeCIwLfpFE/Q82ERmzdenss8pe4s5/
	TkrkR9m8X1BgvB89CMD5bbkGCfUUg1vVQxlfjNjQxtjbY9RxvfIIOI1y2hMT+VJEK3cr2kaBwBH
	L/ExyXTR5Tk3ShxIgGq7TBh0wVU+t02/Vg707lFzhd9H/M7Z8kE21ogrQ05w8bXlQjDd4sXb4hm
	kAiPHiLwim91ujtTZ+LhWlA+A9ylZLcJcyRVrQz7JqrUhLNHmaCg2IXRdSfxJrrKPDdlwSa22KN
	ms/T89yb8XYgd7orGlrDSSNhz71YJlMTbFGq2w3IB9iJ0CiUUNI5mxIuhTSv0gGO/ntPZ+3t/zF
	C2gA7P6IpEz8po34h2JHonfDv5eUwEZveJbu8iOn0jEbTRglBy3+Ywl0OCIIAG1VZlqntG3DD8r
	IKVx9pUGIGCOsZuz0=
X-Received: by 2002:a05:620a:1709:b0:90f:786c:4a82 with SMTP id af79cd13be357-926032cb1f3mr2954498085a.39.1782581343712;
        Sat, 27 Jun 2026 10:29:03 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004ab49csm1518338585a.34.2026.06.27.10.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:29:03 -0700 (PDT)
Message-Id: <pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 17:28:54 +0000
Subject: [PATCH v2 0/7] line-log: scope stat, check, and -G to -L line ranges
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

This series extends git log -L so that more of its diff output and commit
selection honor the tracked line ranges: the diff stat formats and --check
report only the lines inside the tracked range, and the -G pickaxe is scoped
to the tracked range.

It builds on top of the mm/line-log-cleanup topic [1], which integrated -L
with the standard log output pipeline and taught it the non-patch formats
--raw, --name-only, --name-status, and --summary.

With these patches the following also honor the tracked range:

 * --stat, --numstat, --shortstat: counts cover only the lines inside the
   tracked range, not the whole file.

 * --check: whitespace errors are reported only for added lines inside the
   tracked range, with the correct file line numbers.

 * -G: a commit is selected only when the pattern appears on an
   added/removed line inside the tracked range, rather than anywhere in the
   file.

The --dirstat format is deliberately rejected. Its default mode reports each
directory's share of the total churn as a percentage, computed from
whole-file byte damage (via diffcore_count_changes(), outside the line-based
pipeline that -L scopes), so bare --dirstat cannot honor the tracked range.
The --dirstat=lines mode could: it aggregates the same per-file line counts
as --numstat, which -L already scopes. But supporting only that sub-mode
while bare --dirstat still errors is a confusing split, so the whole format
is left to a follow-up; --numstat already gives the exact per-file counts
within the tracked range.

-S is left matching the whole file. Unlike -G, it counts needle occurrences
per blob rather than grepping the diff, so scoping it to a range needs a
different approach; that is left to a follow-up. Patch 7, which scopes -G,
also updates the -L documentation to note the -S/-G distinction, so the
whole-file behavior of -S is not mistaken for the way -G is scoped to the
tracked range.

Patches 1-3 are independent of the new formats: they fix two bugs in the
existing -L patch output (a leaked deletion and an off-by-one hunk header),
bring its hunk headers in line with git diff's format, and clarify the
line-range filter mm/line-log-cleanup added, whose names obscured its model
(cryptic lno_ cursors conflating the pre/post-image and 0/1-based axes, a
flat hunk-state struct, and a one-letter state pointer (s)). The two bugs
may be a hint that the model could use clarification, so patch 1 renames and
groups the filter state and patch 2 documents the model, before the fixes
that read against it. Patches 4-7 then build the new formats on top:

 * Patch 1: rename and group the filter for clarity. Spell the cryptic names
   out to the file's own forms: the line-number cursors to
   lno_in_preimage/lno_in_postimage (as in struct emit_callback) and the
   range index to idx_in_postimage, while the hunk geometry stays old/new
   (the xdiff_emit_hunk_fn convention) and moves into a sub-struct. Name the
   filter pointer (filter) and rename the struct to line_range_filter and
   the flush helper to flush_range_hunk. No behavior change.

 * Patch 2: simplify the filter by classifying removals as they arrive,
   dropping the pending_rm buffer and a latent flush_range_hunk() bug that
   leaked deletions just past the range. Make the buffered lines the hunk's
   single source of truth: flush_range_hunk() derives the counts from them
   rather than tracking them per line, dropping three more fields. Document
   the model with a block comment and worked example, and add
   begin_range_hunk() as the counterpart to flush_range_hunk(). (This
   simplification was submitted by itself previously [2] but did not
   advance, so it is re-included here.)

 * Patch 3: stop hand-rolling the synthetic hunk header and emit it through
   xdiff's own formatter via a new xdiff_emit_hunk_header() helper. The
   hand-rolled code put a count-0 side's begin one too high (the convention
   is the line before the change); routing through xdl_emit_hunk_hdr() fixes
   that by construction and, as a side effect, makes -L headers match git
   diff exactly, including its omission of a count of 1. Regenerate the two
   affected fixtures.

 * Patch 4: extract a line_range_filter_diff() helper that folds the
   filter's two preconditions into one place: inflate ctxlen to the largest
   range span so every change within a range lands in a single xdiff hunk,
   and clear XDL_EMIT_NO_HUNK_HDR so the hunk headers the filter reads are
   always emitted (its position tracking relies on both). It then runs an
   initialized filter through xdiff, flushes the final range hunk, and
   releases it; use it in builtin_diff(). The stat, check, and -G patches
   that reuse it inherit both.

 * Patch 5: reuse the filter in builtin_diffstat() for the stat formats,
   extend the -L output-format allowlist, and reject --dirstat.

 * Patch 6: reuse the filter in builtin_checkdiff() and extend the allowlist
   for --check. The separate blank-at-eof pass scans the whole file, so
   scope its report to the tracked ranges too.

 * Patch 7: scope -G to the tracked range. Expose the filter as
   diff_emit_line_ranges() and grep only the tracked range's lines,
   threading the filepair's line_ranges through the pickaxe callback. -S is
   left whole-file, and the -L documentation is updated to note that -G is
   scoped to the tracked range while -S still matches the whole file.

Changes since v1:

 * Replace the term "range-scoped" with explicit descriptions that refer to
   "tracked line ranges" instead.

[1]
https://lore.kernel.org/git/pull.2094.v3.git.1780001267.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.2099.git.1777230630020.gitgitgadget@gmail.com/

Michael Montalbo (7):
  diff: rename and group the line-range filter for clarity
  diff: simplify the line-range filter by classifying removals
    immediately
  diff: emit -L hunk headers via xdiff's formatter
  diff: extract a line-range diff helper for reuse
  line-log: support diff stat formats with -L
  diff: support --check with -L line ranges
  diffcore-pickaxe: scope -G to the -L tracked range

 Documentation/line-range-options.adoc    |  17 +-
 diff.c                                   | 491 ++++++++++++++---------
 diffcore-pickaxe.c                       |  37 +-
 revision.c                               |   6 +-
 t/t4211-line-log.sh                      | 439 +++++++++++++++++++-
 t/t4211/sha1/expect.no-assertion-error   |   2 +-
 t/t4211/sha1/expect.vanishes-early       |   6 +-
 t/t4211/sha256/expect.no-assertion-error |   2 +-
 t/t4211/sha256/expect.vanishes-early     |   6 +-
 xdiff-interface.c                        |  19 +
 xdiff-interface.h                        |  28 ++
 11 files changed, 826 insertions(+), 227 deletions(-)


base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2152%2Fmmontalbo%2Fmm%2Fline-log-stat-formats-followup-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2152/mmontalbo/mm/line-log-stat-formats-followup-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2152

Range-diff vs v1:

 1:  6cfaccab92 = 1:  6cfaccab92 diff: rename and group the line-range filter for clarity
 2:  5602b7976a = 2:  5602b7976a diff: simplify the line-range filter by classifying removals immediately
 3:  d211c82e40 = 3:  d211c82e40 diff: emit -L hunk headers via xdiff's formatter
 4:  b82a997359 = 4:  b82a997359 diff: extract a line-range diff helper for reuse
 5:  a70d861d27 ! 5:  3d0091b549 line-log: support diff stat formats with -L
     @@ Metadata
       ## Commit message ##
          line-log: support diff stat formats with -L
      
     -    Reuse the line_range_filter in builtin_diffstat() to produce
     -    range-scoped statistics.  When a filepair carries line_ranges, the
     -    filter wraps diffstat_consume() as its output callback, forwarding only
     -    in-range lines for counting.  flush_range_hunk() replays buffered
     -    content through diffstat_consume(), which ignores synthetic @@ headers
     -    since it only counts '+' and '-' lines.
     +    Reuse the line_range_filter in builtin_diffstat() so the stat formats
     +    count only the lines within the tracked range.  When a filepair carries
     +    line_ranges, the filter wraps diffstat_consume() as its output callback,
     +    forwarding only the lines inside the range for counting.
     +    flush_range_hunk() replays buffered content through diffstat_consume(),
     +    which ignores synthetic @@ headers since it only counts '+' and '-'
     +    lines.
      
          Expand the output format allowlist in setup_revisions() to accept
          --stat, --numstat, and --shortstat with -L.
     @@ Commit message
          per-file line counts as --numstat, which -L already scopes.  But
          accepting only that sub-mode while bare --dirstat keeps erroring is a
          confusing split, so the whole format is deferred to a follow-up;
     -    --numstat already reports the exact range-scoped per-file counts.
     +    --numstat already reports the exact per-file counts within the tracked
     +    range.
      
          Also drop "yet" from the generic -L rejection message ("does not
          yet support the requested diff format").  Some rejected formats do
     @@ Documentation/line-range-options.adoc
      +	The following non-patch diff formats are supported: `--raw`,
      +	`--name-only`, `--name-status`, `--summary`,
      +	`--stat`, `--numstat`, and `--shortstat`.
     -+	The stat formats show range-scoped counts: only lines within
     -+	the tracked range are counted.  `--dirstat` is not supported
     ++	The stat formats count only lines within the tracked range.
     ++	`--dirstat` is not supported
      +	with `-L`: it summarizes change as each directory's share of
      +	the total churn, not as counts for the tracked lines.  Use
      +	`--numstat` for exact per-file counts within the range.
     @@ t/t4211-line-log.sh: test_expect_success '-L --oneline has no extra blank line b
      +	git commit -m "Add func1() and func2()" &&
      +
      +	# Modify both functions in a single commit so that
     -+	# whole-file stats differ from range-scoped stats.
     ++	# whole-file stats differ from the counts for the tracked range.
      +	sed -e "s/F1/F1 + 1/" -e "s/F2/F2 + 2/" file.c >tmp &&
      +	mv tmp file.c &&
      +	git commit -a -m "Modify both functions"
     @@ t/t4211-line-log.sh: test_expect_success '-L --oneline has no extra blank line b
      +test_expect_success '--numstat counts only lines in tracked range' '
      +	# "Modify both functions" changes one line in func1 and one in
      +	# func2.  Whole-file numstat would show 2 added, 2 deleted.
     -+	# Range-scoped numstat for func2 should show only 1 and 1.
     ++	# numstat for func2 within the tracked range should show only 1 and 1.
      +	git log -L:func2:file.c --numstat --format=%s -1 >actual &&
      +	test_grep "Modify both functions" actual &&
      +	test_grep "^1	1	file.c$" actual &&
     @@ t/t4211-line-log.sh: test_expect_success '-L --oneline has no extra blank line b
      +
      +test_expect_success '--numstat counts only additions for root commit' '
      +	# Root commit creates both func1 (4 lines) and func2 (4 lines).
     -+	# Whole-file numstat would show 9 lines added.  Range-scoped
     -+	# numstat for func2 should show only 4.
     ++	# Whole-file numstat would show 9 lines added.  numstat for func2
     ++	# within the tracked range should show only 4.
      +	git log -L:func2:file.c --numstat --format=%s >actual &&
      +	test_grep "Add func1() and func2()" actual &&
      +	test_grep "^4	0	file.c$" actual &&
     @@ t/t4211-line-log.sh: test_expect_success '-L --oneline has no extra blank line b
      +
      +test_expect_success '--shortstat counts only lines in tracked range' '
      +	# --shortstat prints only the summary line: no per-file "file.c |"
     -+	# line.  Counts are range-scoped as for --numstat above.
     ++	# line.  Counts cover only the tracked range, as for --numstat above.
      +	git log -L:func2:file.c --shortstat --format=%s -1 >actual &&
      +	test_grep "Modify both functions" actual &&
      +	test_grep "1 insertion" actual &&
     @@ t/t4211-line-log.sh: test_expect_success '-L --oneline has no extra blank line b
      +test_expect_success '--numstat across renames and multiple commits' '
      +	# parallel-change carries the tracked function f across an a.c -> b.c
      +	# rename and a merge of two parallel histories.  With -M, --numstat
     -+	# follows the rename and reports range-scoped (not whole-file)
     -+	# added/removed counts for f per commit; the file column flips from
     ++	# follows the rename and reports added/removed counts for f within
     ++	# the tracked range (not whole-file) per commit; the file column flips from
      +	# b.c to a.c at the rename as the walk goes back in time.  Commits
      +	# that do not change the range of f emit no row (the merge and the
      +	# pure file-move produce nothing), so there are fewer rows than
 6:  be0679a5a7 ! 6:  36ed52d831 diff: support --check with -L line ranges
     @@ Documentation/line-range-options.adoc
      -	`--name-only`, `--name-status`, `--summary`,
      +	`--name-only`, `--name-status`, `--summary`, `--check`,
       	`--stat`, `--numstat`, and `--shortstat`.
     - 	The stat formats show range-scoped counts: only lines within
     - 	the tracked range are counted.  `--dirstat` is not supported
     + 	The stat formats count only lines within the tracked range.
     + 	`--dirstat` is not supported
      
       ## diff.c ##
      @@ diff.c: struct emit_callback {
 7:  f69ccfbc8c ! 7:  df83e6275b diffcore-pickaxe: scope -G to the -L tracked range
     @@ Commit message
          Teach -G to honor the range.  diff_grep() already runs an xdiff pass
          and greps the +/- lines; route that pass through the line-range filter
          so only the tracked range's lines are grepped.  Expose the filter as
     -    diff_emit_line_ranges(), a line-range-scoped xdi_diff_outf(), thread
     -    the filepair's line_ranges through the pickaxe callback, and pass it
     -    from pickaxe_match().  Skip scoping under textconv, whose output is not
     -    in the original file's line coordinates.
     +    diff_emit_line_ranges(), an xdi_diff_outf() that emits only the tracked
     +    range's lines, thread the filepair's line_ranges through the pickaxe
     +    callback, and pass it from pickaxe_match().  Skip scoping under
     +    textconv, whose output is not in the original file's line coordinates.
      
          -G needs only a hit/no-hit answer, so the line-number concerns the
          filter handles for patch and check output do not apply here.
     @@ Commit message
          approach, left to a follow-up.  has_changes() takes the range parameter
          but ignores it for now.
      
     -    Document the resulting -L pickaxe scoping: -G is range-scoped, while -S
     -    still matches the whole file.
     +    Document the resulting -L pickaxe scoping: -G is scoped to the tracked
     +    range, while -S still matches the whole file.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      

-- 
gitgitgadget
