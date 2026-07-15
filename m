Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D839353A9D
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149332; cv=none; b=rIPXptHHUMqDaycOSM/ucNK+aR7a3GdBfZblrMtT9UdgaoSAR1X50R6QeEW3oqIKiRstriDrPOPmW4sbTFie4lj0fmdwyVgsppYqJNkUIglOPg6FRjoxTCJzelU/Z3/g7PwUQK0CHoK/7F6XywIOa8SgblyEprmGDtdYXNkrip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149332; c=relaxed/simple;
	bh=m/OUxEoMHAKOabZWcBy5EEliJHf5rVuhiVtWvVzMeCI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KoxeODjdsRFXqWOOFOvyrFESnIg+EzKGIDzgTkwvVGTGhdFkLndVaupMyfAStMHbh/HRDrktNFUp3PFPRtSzFrzd99Aa+e1KRZ8XAYbhHyf5+MtikAC3r9NLHzHj7l3+1vgp3m8PpihNjE/GDzWbzEPWfMLx1fI5Z5bDTyLrCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7MWvmlX; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7MWvmlX"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8efcef23d21so57074196d6.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149327; x=1784754127; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=76A3IcnO4k6j1XKmlnQmVly4m4LcBp3Lt9XC46Spk4I=;
        b=k7MWvmlXXpuB1zDstbgb9D/X4wDYssTD71emdqHykpAt88RGUt/kL6aoc8SB+H5S3L
         1+HW7GRKHldJr7uH/tBSuM+vw8UKGG8Mznj8WwEdFKIzBsR6XVBZnsu/jruBuLJz49Qh
         4mcNl72zD4/fbObSCQcMcs/yFcd3nAhBoRivmaeYEffl+CQYnesJ3Ik1may1yEP7jA4H
         XvNbKHpqlUPvjPnsW+eCjIvH3pPbKYHLOQmm89f17Sz+NP3SKYxaMyi+1AeZzAY0SIyr
         1bpMOYdos/2QyXDOozAMFfUP8lFtvsSayzCQ7TX6/tDC/515Avg93P8F8JiPk3iEzDTo
         ROIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149327; x=1784754127;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76A3IcnO4k6j1XKmlnQmVly4m4LcBp3Lt9XC46Spk4I=;
        b=d84/h+wByWQhxXVOQh9+03C+HKLyUhcDvY5Tt4+lGhA4Pcd5eWWHdo0qmNhhT74p2J
         6ghnfV8/rpBR5SoMT3E7VeqgpNKEbeoqD03xvvyHFL4gGqFPPjIBDCCaOPzZBRQFjYqJ
         MiKwi9omhMHpncbdrlnQbu02RcPDlAxcPd8aNcpf4AGl9J9/s44qZxoT8XJSkWuuDYWV
         AAOQgOwuSQa6cCgnh2+AqlQxktYfcCKunk4pffK0SOx49M4wBGG6mknjk3N7SGlhWF2t
         wdmXzZ27Bk31DAfA3EPptkB8vwQK7EG+QCYRgVS8prpzTCUlmneHLx2J3u4Y9aUED8Wi
         C9Uw==
X-Gm-Message-State: AOJu0Yw/QTuTkrBcexhCAJ9MY7sMqkOwBF1fEmf1KNQA77bOgampxiWp
	eZXgbK+myzPjSGAWgYUr0hFK8mXrCGyfnWhG1ImvfOGIef9sca8M5yDfCK5Ckw==
X-Gm-Gg: AfdE7cmLWuc2dxZfGkxljQw/jdQ3kcQeM9YXs/zjFTOxLKcSRx6F8gZTuRZERYhmU2M
	MslVdiAyc0h2fve4ZMC97eSHLFXyJ9t4e+Vu248EzpGQN4nqL6rrz4BqWRJ52IzuSGiC2tX8FzK
	cJgeX6OG19ejnJUs11/vTEypOSkcKxaWHRMJtKUx0bKFbY9T0njRoEpzdo8St7u7LCymPXCeSPz
	b217fWq8a1XbF1ZIvCjKvOHPAFTfmn8pqm+39BcnSzC5ZuOt3+7frXmqwH5VEMjrqGgTeyi7eOa
	2IPDZNXaM553IqBwUb+7qfcFOIbmSf3TsMrSx3ssixxhqt23HPDThGi5EjAkaYOqOc1qZZARzSq
	zwblti91F/zx5dzGW0gBGXdTEUxDymWSj2Aa2znunuY17eyV4ZouIUaTvGohfhLDMyOmowqyvPo
	GzsT9Rlw==
X-Received: by 2002:a05:6214:20e6:b0:906:7fea:354 with SMTP id 6a1803df08f44-9074c73b8a8mr89918276d6.18.1784149325466;
        Wed, 15 Jul 2026 14:02:05 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.193.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9063df4319asm100546786d6.38.2026.07.15.14.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:02:04 -0700 (PDT)
Message-Id: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 21:01:53 +0000
Subject: [PATCH v5 0/9] [RFC] diff: add diff.<driver>.process for external hunk providers
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>

Language-aware diff tools (e.g., Difftastic) and format-specific analyzers
can produce better line matching than Git's builtin diff algorithm, but
diff.<driver>.command replaces Git's diff output with the program's own
output, so display features like word diff, function context, and color
cannot operate on it; and because the program is consulted only for that
patch output, blame, --stat, and git log -L fall back to Git's builtin line
matching and cannot benefit from the tool at all.

This series adds diff.<driver>.process, a long-running subprocess protocol
that lets an external tool control which lines Git considers changed while
Git handles all output formatting. The protocol follows
filter.<driver>.process: pkt-line over stdin/stdout, capability negotiation,
one process per Git invocation.

The tool receives both file versions and returns changed regions (line
ranges in the old and new file). Git validates and feeds them into the xdiff
pipeline in place of the builtin diff algorithm. When the tool returns no
hunks, Git treats the files as having no changes, which propagates through
patch output, the --stat summary, blame, and git log -L. The request also
carries the two blobs' object names (old-oid/new-oid) so a tool can cache
its analysis keyed on the pair.

 * Patch 1: document how an external diff driver (diff.<driver>.command)
   relates to the rest of Git's diff features, so the contrast with the new
   process driver is clear.
 * Patch 2: xdiff plumbing for externally supplied hunks.
 * Patch 3: diff.<driver>.process config key.
 * Patch 4: refactor subprocess API to separate process lifecycle from
   hashmap management, since the diff process stores its subprocess on the
   userdiff driver rather than in a hashmap.
 * Patch 5: the main feature, including the old-oid/new-oid request metadata
   for blob-pair caching.
 * Patch 6: bypass knobs (--no-ext-diff, format-patch).
 * Patch 7: blame integration so the tool can declare commits as having no
   changes; introduces the shared xdi_diff_process() consult-then-diff
   helper that blame and git log -L both use.
 * Patch 8: --stat/--numstat/--shortstat consult the tool, so the summary
   agrees with the patch output.
 * Patch 9: git log -L range tracking consults the tool, so a reformat-only
   commit is dropped from the log rather than shown with an empty diff.

A "Which features consult the diff process" section in gitattributes(5) lays
out, per feature, why each does or does not consult the process (patch
output, blame, summary formats, and the -L line-range view do; pickaxe -G,
patch-id, merge, range-diff, --check, and --raw do not, with reasons).
Combined diffs (--cc) remain on the builtin algorithm and are noted as
future work.

Changes since v4:

 * New preparatory doc patch (patch 1): document how an external diff driver
   (diff.<driver>.command) relates to the rest of Git's diff features, so
   the contrast with the process driver added later in the series is
   explicit.

 * New: --stat/--numstat/--shortstat now consult the process (patch 8). A
   file the tool reports as equivalent contributes no stat line, matching
   the empty patch git diff produces for it. Summary formats do not apply
   textconv, so the tool is fed raw content there, as the builtin --stat
   already counts raw lines.

 * New: git log -L range tracking now consults the process (patch 9).
   Previously the tracking pass used the builtin diff while the displayed
   diff used the tool, so a reformat-only commit could be selected by
   tracking and then rendered with an empty diff. Tracking now agrees with
   the display and the commit is dropped.

 * New: the request carries the old and new blob object names
   (old-oid/new-oid), so a tool can cache its line matching keyed on the
   blob pair. A side's oid is sent only when the tool receives that raw
   blob; it is omitted under textconv (which rewrites the bytes) and for a
   working-tree side with no stored object. This is where the process
   differs from diff.<name>.command, which never composes with textconv and
   so always feeds the raw blob its oid names.

 * Refactor: blame and git log -L now consult the process through a single
   xdi_diff_process() helper instead of open-coding the consult-then-diff
   dance; builtin_diff() keeps its own path so it can short-circuit
   equivalent files before its funcname/word-diff setup. The whitespace
   bypass keys off the effective diff parameters (xpp), which removes
   blame's separate -w guard, and blame's diff_hunks() sheds an intermediate
   variant it no longer needs.

 * Correctness: external-hunk validation now checks per-gap alignment, not
   just the total unchanged-line count. xdl_build_script() walks the two
   files in lockstep over unchanged lines, so a hunk set whose totals
   balance but whose per-gap line counts do not (e.g. hunk 1 1 3 1)
   previously passed validation and produced a corrupt diff, --stat, and
   blame attribution. Such responses are now rejected and Git falls back to
   the builtin diff.

 * Robustness: hunk accumulation is bounded by the two files' combined line
   count, so a misbehaving tool that floods hunk lines cannot grow memory
   without bound before validation.

 * Forward-compat: the hunk-line parser now ignores unknown trailing fields
   after the four counts, so a future protocol version can append a field
   without older clients rejecting it.

 * Feature interactions: the whitespace-ignoring options (-w,
   --ignore-space-change, --ignore-blank-lines, ...), -I, and --anchored
   bypass the process (the tool is never told about them and could not honor
   them), and git blame -w does the same. A change that only adds or removes
   the trailing newline cannot be expressed as line hunks, so it also falls
   back to the builtin diff (preserving the "\ No newline at end of file"
   marker).

 * Documentation: added the per-feature "Which features consult the diff
   process" section; documented that the process trusts the tool's notion of
   "unchanged" (it is not byte-validated, so like git diff -w such a patch
   may not apply against the old blob), that --exit-code/--quiet report
   success for tool- equivalent files, and that diff.<name>.command takes
   precedence when both it and .process are configured.

 * Tests: t4080 grew coverage for the per-gap check, the hunk- flood cap,
   the whitespace/-w bypasses, the trailing-newline and added/deleted-file
   fallbacks, multi-hunk output through patch and --stat, --stat
   --exit-code, a mode-only change, and a mixed equivalent/changed
   multi-file diffstat.

Michael Montalbo (9):
  gitattributes: document how external diff drivers relate to diff
    features
  xdiff: support external hunks via xpparam_t
  userdiff: add diff.<driver>.process config
  sub-process: separate process lifecycle from hashmap management
  diff: add long-running diff process via diff.<driver>.process
  diff: bypass diff process with --no-ext-diff and in format-patch
  blame: consult diff process for no-hunk detection
  diff: consult diff process for --stat counts
  line-log: consult diff process for range tracking

 Documentation/config/diff.adoc           |   5 +
 Documentation/diff-algorithm-option.adoc |   3 +
 Documentation/diff-options.adoc          |   4 +-
 Documentation/gitattributes.adoc         | 274 +++++++
 Makefile                                 |   2 +
 blame.c                                  |  24 +-
 builtin/log.c                            |   7 +
 diff-process.c                           | 529 +++++++++++++
 diff-process.h                           |  75 ++
 diff.c                                   |  57 +-
 diff.h                                   |   6 +
 line-log.c                               |  33 +-
 meson.build                              |   1 +
 sub-process.c                            |  28 +-
 sub-process.h                            |   9 +-
 t/helper/meson.build                     |   1 +
 t/helper/test-diff-process-backend.c     | 381 +++++++++
 t/helper/test-tool.c                     |   1 +
 t/helper/test-tool.h                     |   1 +
 t/meson.build                            |   1 +
 t/t4080-diff-process.sh                  | 950 +++++++++++++++++++++++
 userdiff.c                               |   7 +
 userdiff.h                               |   5 +
 xdiff-interface.c                        |   7 +-
 xdiff/xdiff.h                            |  16 +
 xdiff/xdiffi.c                           |  84 +-
 xdiff/xprepare.c                         |  10 +
 xdiff/xprepare.h                         |   1 +
 28 files changed, 2504 insertions(+), 18 deletions(-)
 create mode 100644 diff-process.c
 create mode 100644 diff-process.h
 create mode 100644 t/helper/test-diff-process-backend.c
 create mode 100755 t/t4080-diff-process.sh


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2120%2Fmmontalbo%2Fmm%2Fstructural-diff-backend-clean-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2120/mmontalbo/mm/structural-diff-backend-clean-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2120

Range-diff vs v4:

  -:  ---------- >  1:  0fd994a3d3 gitattributes: document how external diff drivers relate to diff features
  1:  03f261dfe2 !  2:  2004502549 xdiff: support external hunks via xpparam_t
     @@ Commit message
          the diff algorithm, then continues through compaction and emission
          as usual.
      
     -    Validate supplied hunks before use: reject out-of-bounds line
     -    numbers, overlapping or out-of-order hunks, negative counts, and
     -    violations of the synchronization invariant (unchanged line counts
     -    must match between files).  On validation failure, fall back to
     -    the builtin diff algorithm; this re-runs xdl_prepare_env() since
     -    the first call may have dirtied the changed[] arrays.
     +    Validate supplied hunks before use.  Out-of-bounds line numbers,
     +    overlapping or out-of-order hunks, and misaligned unchanged runs are
     +    treated as a malformed tool response: xdl_populate_hunks_from_external()
     +    warns, returns -1, and xdl_diff() falls back to the builtin diff
     +    algorithm for that file.  The run of unchanged lines between two hunks
     +    (and before the first and after the last) must be the same length on
     +    both sides; xdl_build_script() walks the two files in lockstep over
     +    unchanged lines, so a balanced total is not enough.  Non-negative
     +    counts and 1-based starts are instead caller preconditions, checked
     +    with BUG(), since the caller normalizes hunks before this point.
     +
     +    On rejection xdl_diff() frees the environment it prepared and falls
     +    through to xdl_do_diff(), which prepares a fresh one for the builtin
     +    pass.
      
          Skip trim_common_tail() in xdi_diff() when external hunks are
          present, since external hunks reference line numbers in the
     @@ xdiff/xdiff.h: typedef struct s_mmbuffer {
       } mmbuffer_t;
       
      +/*
     -+ * Hunk descriptor for externally computed diffs.
     -+ * Line numbers are 1-based; a start of 0 is accepted when
     -+ * count is 0 (empty file side, matching git diff output).
     ++ * Hunk descriptor for externally computed diffs, in xdiff's own
     ++ * coordinates: line numbers are 1-based and a hunk's start is the
     ++ * first line it covers.  A caller translates any external "empty side"
     ++ * idiom (such as git diff's start-0/count-0) to a 1-based start before
     ++ * handing hunks over.
      + */
      +struct xdl_hunk {
      +	long old_start, old_count;
     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdf
       
      +/*
      + * Populate the changed[] arrays from externally supplied hunks,
     -+ * bypassing the diff algorithm.  Validates that hunks are in order,
     -+ * non-overlapping, and within bounds.
     ++ * bypassing the diff algorithm.  The caller normalizes and validates
     ++ * the hunks first (order, overlap, and lockstep alignment), so this
     ++ * only marks lines changed after asserting the memory-safety
     ++ * preconditions it depends on: non-negative counts and 1-based starts
     ++ * (checked with BUG()), and an in-bounds range (a silent -1 so the
     ++ * caller can fall back to the builtin diff rather than index changed[]
     ++ * out of range).  Keeping this diagnostic-free leaves user-facing
     ++ * messages to the git layer.
      + *
     -+ * Returns 0 on success, -1 on validation failure.
     ++ * Returns 0 on success, -1 if a hunk is out of range.
      + */
      +static int xdl_populate_hunks_from_external(xdfenv_t *xe,
      +					    struct xdl_hunk *hunks,
      +					    size_t nr_hunks)
      +{
      +	size_t i;
     -+	long j, prev_old_end = 0, prev_new_end = 0;
     -+	long changed_old = 0, changed_new = 0;
     ++	long j;
      +
      +	/*
      +	 * xdl_prepare_env() may dirty changed[] via xdl_cleanup_records().
     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdf
      +	for (i = 0; i < nr_hunks; i++) {
      +		struct xdl_hunk *h = &hunks[i];
      +
     -+		if (h->old_count < 0 || h->new_count < 0) {
     -+			warning("diff process hunk %"PRIuMAX": "
     ++		/*
     ++		 * Non-negative counts and 1-based starts are caller
     ++		 * preconditions (it normalizes hunks into xdiff coordinates
     ++		 * before this point), so a violation is a bug, not a bad
     ++		 * tool response.
     ++		 */
     ++		if (h->old_count < 0 || h->new_count < 0)
     ++			BUG("external hunk %"PRIuMAX": "
      +				"negative count (old=%ld, new=%ld)",
      +				(uintmax_t)(i + 1),
      +				h->old_count, h->new_count);
     -+			return -1;
     -+		}
     -+		if (h->old_start < 1 || h->new_start < 1) {
     -+			warning("diff process hunk %"PRIuMAX": "
     -+				"start must be >= 1 (old=%ld, new=%ld)",
     ++		if (h->old_start < 1 || h->new_start < 1)
     ++			BUG("external hunk %"PRIuMAX": "
     ++				"start not 1-based (old=%ld, new=%ld)",
      +				(uintmax_t)(i + 1),
      +				h->old_start, h->new_start);
     -+			return -1;
     -+		}
      +
      +		/*
     -+		 * Range must fit: start + count - 1 <= nrec,
     -+		 * rewritten to avoid overflow.  Same for both sides.
     -+		 *
     -+		 * When count is 0 (pure insert/delete) the check
     -+		 * reduces to 0 > nrec - start + 1, which rejects
     -+		 * start > nrec + 1 and allows start == nrec + 1
     -+		 * (the position after the last line).
     ++		 * The caller validates ordering, overlap and lockstep
     ++		 * alignment (and diagnoses a bad response).  This is only a
     ++		 * silent in-bounds guard so the marking loop cannot index
     ++		 * changed[] out of range: start + count - 1 <= nrec,
     ++		 * rewritten to avoid overflow.  A count of 0 (pure
     ++		 * insert/delete) allows start == nrec + 1, the position
     ++		 * after the last line.  On a miss, return -1 and let the
     ++		 * caller fall back to the builtin diff.
      +		 */
     -+		if (h->old_count > (long)xe->xdf1.nrec - h->old_start + 1) {
     -+			warning("diff process hunk %"PRIuMAX": "
     -+				"old range %ld+%ld exceeds %lu lines",
     -+				(uintmax_t)(i + 1),
     -+				h->old_start, h->old_count,
     -+				(unsigned long)xe->xdf1.nrec);
     -+			return -1;
     -+		}
     -+		if (h->new_count > (long)xe->xdf2.nrec - h->new_start + 1) {
     -+			warning("diff process hunk %"PRIuMAX": "
     -+				"new range %ld+%ld exceeds %lu lines",
     -+				(uintmax_t)(i + 1),
     -+				h->new_start, h->new_count,
     -+				(unsigned long)xe->xdf2.nrec);
     ++		if (h->old_count > (long)xe->xdf1.nrec - h->old_start + 1 ||
     ++		    h->new_count > (long)xe->xdf2.nrec - h->new_start + 1)
      +			return -1;
     -+		}
     -+
     -+		/* Ordering: no overlap with previous hunk (adjacent is OK) */
     -+		if (h->old_start < prev_old_end ||
     -+		    h->new_start < prev_new_end) {
     -+			warning("diff process hunk %"PRIuMAX": "
     -+				"overlaps with previous hunk",
     -+				(uintmax_t)(i + 1));
     -+			return -1;
     -+		}
      +
      +		for (j = 0; j < h->old_count; j++)
      +			xe->xdf1.changed[h->old_start - 1 + j] = true;
      +		for (j = 0; j < h->new_count; j++)
      +			xe->xdf2.changed[h->new_start - 1 + j] = true;
     -+
     -+		prev_old_end = h->old_start + h->old_count;
     -+		prev_new_end = h->new_start + h->new_count;
     -+	}
     -+
     -+	/*
     -+	 * Synchronization invariant: unchanged line counts must match.
     -+	 * Otherwise xdl_build_script() would walk off one array.
     -+	 *
     -+	 * Count changed lines from the arrays rather than accumulating
     -+	 * during the loop to avoid any overflow in the summation.
     -+	 */
     -+	for (j = 0; j < (long)xe->xdf1.nrec; j++)
     -+		if (xe->xdf1.changed[j])
     -+			changed_old++;
     -+	for (j = 0; j < (long)xe->xdf2.nrec; j++)
     -+		if (xe->xdf2.changed[j])
     -+			changed_new++;
     -+	if ((long)xe->xdf1.nrec - changed_old !=
     -+	    (long)xe->xdf2.nrec - changed_new) {
     -+		warning("diff process: unchanged line count mismatch "
     -+			"(old: %ld unchanged, new: %ld unchanged)",
     -+			(long)xe->xdf1.nrec - changed_old,
     -+			(long)xe->xdf2.nrec - changed_new);
     -+		return -1;
      +	}
      +
      +	return 0;
  2:  30617ee17b =  3:  926cf01af6 userdiff: add diff.<driver>.process config
  3:  459e485e6d =  4:  363d459ff6 sub-process: separate process lifecycle from hashmap management
  4:  10b3980f59 !  5:  d003bc1f15 diff: add long-running diff process via diff.<driver>.process
     @@ Commit message
          textconv-transformed content.  The tool controls which lines
          are marked as changed while the display shows the file content.
          Patch output features (word diff, function context, color) work
     -    normally; --stat uses its own diff codepath and never consults
     -    the diff process.
     +    normally.  A new "Which features consult the diff process"
     +    documentation section lays out which features use the tool's hunks,
     +    which compute independently, and why; the summary formats such as
     +    --stat still use the builtin diff for now.
      
          The handshake negotiates version=1 and capability=hunks.  Per-file
     -    requests send command=hunks, pathname, and both file contents as
     -    packetized data.  The tool responds with hunk lines and a status
     -    packet (success, error, or abort).  On error, Git warns and falls
     -    back to the builtin diff algorithm for that file.  On abort, Git
     -    silently falls back for the current file and stops sending further
     -    requests to the tool for the remainder of the session.
     +    requests send command=hunks, pathname, the old and new blob object
     +    names as old-oid/new-oid, and both file contents as packetized data.
     +    The tool responds with hunk lines and a status packet (success,
     +    error, or abort).  On error, Git warns and falls back to the builtin
     +    diff algorithm for that file.  On abort, Git silently falls back for
     +    the current file and stops sending further requests to the tool for
     +    the remainder of the session.
     +
     +    old-oid/new-oid name the two blobs so a tool can cache its analysis
     +    keyed on the pair.  A side's oid is sent only when the content the
     +    tool receives is that raw blob: it is omitted under textconv, which
     +    rewrites the bytes, and for a working-tree side with no stored
     +    object, so an oid that is sent always names the bytes the tool
     +    receives.  This is where the process protocol diverges from
     +    diff.<driver>.command, which never composes with textconv (the
     +    command replaces the whole diff and always gets the raw blob).  Tools
     +    ignore unknown request keys, so old tools skip them.
      
          When the tool returns no hunks followed by status=success, Git
          treats the file as having no changes and produces no diff output.
     @@ Commit message
          the failure is cached on the driver to avoid retrying and
          re-warning on every subsequent file.
      
     +    Git falls back to the builtin diff (rather than consulting the
     +    tool) when an option the tool cannot honor is in effect: the
     +    whitespace-ignoring flags, --ignore-blank-lines, -I<regex>, and
     +    --anchored.  The bypass keys off the effective diff parameters (xpp)
     +    rather than diffopt, so a later caller whose flags live elsewhere is
     +    covered uniformly.  A change that only adds or removes the trailing
     +    newline is likewise not expressible as hunks, so it too uses the
     +    builtin diff.  The hunk parser ignores unknown trailing fields on a
     +    hunk line for response forward-compatibility.
     +
     +    Hunk accumulation is bounded by the combined byte count of the two
     +    files, so a misbehaving tool that floods hunk lines cannot grow
     +    memory without bound before validation runs.
     +
          diff_process_fill_hunks() is the sole public entry point.  It
          handles driver lookup, flag checks, subprocess management, and
          error reporting, returning an enum that lets callers distinguish
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
      +long-running process protocol (described in
      +Documentation/technical/long-running-process-protocol.adoc).
      +Unlike `diff.<name>.command`, which replaces Git's output entirely,
     -+the diff process feeds results back into the standard pipeline.
     ++the diff process feeds results back into the standard pipeline.  If
     ++both are configured for a path, `diff.<name>.command` takes precedence
     ++for the patch output it replaces; the summary formats, `git blame`,
     ++and `git log -L` never run the command and still consult the process.
      +
      +First, in `.gitattributes`, assign the `diff` attribute for paths.
      +
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
      +the process and performs the handshake.  In the handshake, the welcome
      +message sent by Git is "git-diff-client", only version 1 is supported,
      +and the supported capability is "hunks" (the changed regions
     -+described below).
     ++described below).  The tool replies with "git-diff-server", the
     ++version it supports, and the capabilities it supports.
      +
      +For each file, Git sends a list of "key=value" pairs terminated with
      +a flush packet, followed by the old and new file content as packetized
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
      +-----------------------
      +packet:          git> command=hunks
      +packet:          git> pathname=path/file.c
     ++packet:          git> old-oid=<hex>
     ++packet:          git> new-oid=<hex>
      +packet:          git> 0000
      +packet:          git> OLD_CONTENT
      +packet:          git> 0000
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
      +packet:          git> 0000
      +-----------------------
      +
     ++The optional `old-oid` and `new-oid` keys give the object names of the
     ++old and new blobs, so a tool can cache its analysis keyed on the pair.
     ++A side's key is sent only when the content for that side is the raw
     ++blob it names: it is omitted when the content is textconv-transformed,
     ++and for a working-tree side that has no stored object.  A tool that
     ++does not recognize these keys ignores them.
     ++
      +The tool is expected to respond with zero or more hunk lines,
      +a flush packet, and a status packet terminated with a flush packet.
      +Each hunk line has the form:
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
      +
      +where `<old_start>` and `<old_count>` identify a range of lines in
      +the old file, and `<new_start>` and `<new_count>` identify the
     -+replacement range in the new file.  Start values are 1-based and
     -+counts are non-negative.  Ranges must not extend beyond the end of
     -+the file.  For example, `hunk 3 2 3 4` means that 2 lines starting
     -+at line 3 in the old file were replaced by 4 lines starting at
     -+line 3 in the new file.  An `<old_count>` of 0 means no lines were
     -+removed (pure insertion); a `<new_count>` of 0 means no lines were
     -+added (pure deletion).  A start value of 0 is accepted when
     -+the corresponding count is 0 (e.g., `hunk 0 0 1 5` for a newly
     -+added file), matching what `git diff` itself emits for empty
     -+file sides.
     ++replacement range in the new file.  The four fields are separated by
     ++single spaces.  Start values are 1-based and counts are non-negative.
     ++For example, `hunk 3 2 3 4` means that 2 lines starting at line 3 in
     ++the old file were replaced by 4 lines starting at line 3 in the new
     ++file.  An `<old_count>` of 0 means no lines were removed (pure
     ++insertion); a `<new_count>` of 0 means no lines were added (pure
     ++deletion).  For a side with a count of 0 (a pure insertion or
     ++deletion) the start is the 1-based line the change sits before,
     ++ranging from 1 to one past the last line (the line count plus 1, to
     ++place the change at the end of the file); like every start it must
     ++keep the unchanged runs aligned on both sides (see below), so for a
     ++given change it takes one specific value, not an arbitrary one.  A
     ++start of 0 is also accepted and treated as 1, matching the
     ++empty-file-side form `git diff` emits (e.g. `hunk 0 0 1 5` for a newly
     ++added file).  A nonzero range must not extend beyond the end of the
     ++file.  Git ignores any extra
     ++whitespace-separated tokens after `<new_count>`, so a future protocol
     ++version can append fields to a hunk line (for example a "moved"
     ++marker) without older tools rejecting it.
      +
      +Lines are delimited by newlines.  A file `"foo\nbar\n"` and a
      +file `"foo\nbar"` both have 2 lines.
      +
     -+Hunks must be listed in order and must not overlap.  Any line
     -+not covered by a hunk is treated as unchanged, so the total
     -+number of unchanged lines must be the same on both sides.
     -+For example, if the old file has 10 lines and the hunks cover
     -+4 of them (`old_count` values summing to 4), then 6 old lines
     -+are unchanged.  The new file must also have exactly 6 lines
     -+not covered by hunks, so the `new_count` values must sum to
     -+`new_file_lines - 6`.
     ++Hunks must be listed in order and must not overlap.  Any line not
     ++covered by a hunk is treated as unchanged and is paired, in order,
     ++with the unchanged lines on the other side.  Each run of unchanged
     ++lines between two hunks (and the run before the first hunk and
     ++after the last) must therefore be the same length on both sides,
     ++not merely equal in total.  For the hunks `1 3 1 5` and `10 2 12 2`
     ++below, lines 4-9 of the old file and lines 6-11 of the new file are
     ++both the six unchanged lines between the two hunks.  A response that
     ++balances only the total unchanged count but misaligns one of these
     ++runs is rejected, and Git falls back to the builtin diff.
     ++
     ++Git does not check that the lines a hunk leaves unchanged are
     ++byte-for-byte identical between the two sides; it pairs them by
     ++position and shows the new side as context.  A tool may therefore
     ++report lines that differ textually (a pure reformatting, say) as
     ++unchanged, and the diff reflects that judgment.  This is
     ++the point of a semantic backend, but it means a misbehaving tool can
     ++produce a diff whose context does not match the old blob; as with
     ++`git diff -w`, such a patch may not apply against the old content.
      +
      +-----------------------
      +packet:          git< hunk 1 3 1 5
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
      +-----------------------
      +
      +If the tool responds with hunks and "success", Git marks those lines
     -+as changed and feeds them into the standard diff pipeline.  Patch
     -+output features (word diff, function context, color) work normally.
     -+Note that `--stat` and other summary formats use their own diff path
     -+and are not affected by the diff process.
     ++as changed and feeds them into the standard diff pipeline.  Git may
     ++still slide or regroup those changes against matching context for
     ++display, exactly as it compacts its own diffs, so the tool controls
     ++which lines are reported as changed, not the precise hunk boundaries.
     ++Patch output features (word diff, function context, color) work
     ++normally.  Summary formats such as `--stat` still compute their counts
     ++with the builtin diff for now; see "Which features consult the diff
     ++process" below for the full picture and the reasoning behind it.
      +
      +If no hunk lines precede the flush, followed by "success", Git
     -+treats the files as having no changes: `git diff` produces no output
     -+and `git blame` skips the commit, attributing lines to earlier commits.
     ++treats the files as having no changes: `git diff` produces no output,
     ++`git diff --exit-code` and `--quiet` report success even though the
     ++stored blobs differ, and `git blame` skips the commit, attributing
     ++lines to earlier commits.
     ++The one exception is a change that only adds or removes the file's
     ++trailing newline: it cannot be expressed as line hunks, so when the
     ++line content otherwise matches Git keeps the builtin diff for that
     ++file (preserving the `\ No newline at end of file` marker) instead of
     ++treating the two sides as equal.
      +
      +-----------------------
      +packet:          git< 0000
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
      +packet:          git< 0000
      +-----------------------
      +
     -+If the tool returns invalid hunks (out of bounds, overlapping, or
     -+mismatched unchanged line counts), Git warns and falls back to the
     -+builtin diff algorithm.
     ++If the tool returns well-formed but invalid hunks (out of bounds,
     ++overlapping, or with misaligned unchanged runs), Git warns and falls
     ++back to the builtin diff for that file; the tool stays available for
     ++subsequent files.  A malformed hunk line, by contrast (bad syntax, a
     ++nonzero count paired with a start of 0, or more hunks than the file
     ++has lines), is a protocol violation: Git stops the process and does
     ++not send it further requests, as described below.
      +
      +In case the tool cannot or does not want to process the content,
      +it is expected to respond with an "error" status.  Git warns and
     -+falls back to the builtin diff algorithm for this file.  The tool
     ++falls back to the builtin diff algorithm for this file, treating any
     ++status other than "success" or "abort" the same way.  The tool
      +remains available for subsequent files.
      +
      +-----------------------
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
      +forward-compatible.  Future versions of Git may send additional
      +`command=` values; tools that receive an unrecognized command should
      +respond with `status=error` rather than terminating.
     ++
     ++Which features consult the diff process
     ++^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     ++
     ++The diff process answers a single question: given two blobs, which
     ++line ranges differ?  Whether a particular feature consults it follows
     ++from whether that is the question the feature is really asking.
     ++
     ++Features that ask "which lines changed" use the tool's hunks in place
     ++of the builtin algorithm:
     ++
     ++- `git diff` patch output, together with everything layered on it:
     ++  word diff, function context (`-W`), `--color-moved`, the `@@` hunk
     ++  headers, and the `-L` line-range display.  These operate on the
     ++  lines the patch step already emitted, so they reflect the tool's
     ++  hunks without any further negotiation.
     ++- `git blame`: a commit whose change the tool reports as equivalent is
     ++  skipped, and its lines are attributed to an earlier commit.
     ++
     ++Features that ask a different question do not consult the process, by
     ++design:
     ++
     ++- The pickaxe `-G<regex>` searches the textual diff for a pattern; it
     ++  asks "does this string appear in the diff," not "did these lines
     ++  change."  (`-S` runs at an earlier stage and is likewise unaffected.)
     ++- `git patch-id` must produce a stable hash for `git rebase` and
     ++  cherry-pick detection; deriving it from a configured tool would make
     ++  equal patches hash differently from machine to machine.
     ++- The merge machinery (`git merge-tree`, `rerere`) computes merge
     ++  content and conflict signatures rather than display output, so the
     ++  tool's hunks must not alter its results.
     ++- `git range-diff` diffs patch text, not source blobs, so source-file
     ++  hunks do not apply to it.
     ++- `--check` reports whitespace errors in added lines using the builtin
     ++  diff's notion of which lines are added, not the tool's.  It can
     ++  therefore flag (and exit non-zero on) a line the tool treats as
     ++  unchanged and that `git diff` shows as context.  Whitespace breakage
     ++  is a property of the literal bytes, so `--check` keeps the builtin
     ++  partition deliberately; a future change could wire it to the tool if
     ++  matching `git diff` exactly became desirable.
     ++- `--raw`, `--name-only`, and `--name-status` compare object ids at
     ++  the tree level and never run a line-level diff at all.
     ++
     ++Some features ask "which lines changed" but still use the builtin
     ++algorithm for now, and may consult the process in a later change: the
     ++summary formats (`--stat`, `--numstat`, `--shortstat`); `git log -L`'s
     ++commit selection and parent range propagation (as distinct from its
     ++display, which is covered above); and combined diffs (`--cc` and merge
     ++diffs), whose protocol would have to be extended from a single old/new
     ++pair to one comparison per merge parent.
     ++
     ++`--diff-algorithm` bypasses the process entirely, for every feature
     ++listed above.  The whitespace-ignoring options (`-w`,
     ++`--ignore-space-change`, `--ignore-blank-lines`, and the like),
     ++`-I<regex>`, and `--anchored` also bypass it for the affected files:
     ++the tool is never told about these options, so it could not honor
     ++them, and Git falls back to the builtin diff, which does.
      +
       Defining a custom hunk-header
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     @@ diff-process.c (new)
      + *   tool< capability=hunks / flush
      + *
      + * Per-file:
     -+ *   git> command=hunks / pathname=<path> / flush
     ++ *   git> command=hunks / pathname=<path> / [old-oid=<hex>] / [new-oid=<hex>] / flush
      + *   git> <old content packetized> / flush
      + *   git> <new content packetized> / flush
      + *   tool< hunk <old_start> <old_count> <new_start> <new_count>
     @@ diff-process.c (new)
      +#include "diff-process.h"
      +#include "diff.h"
      +#include "gettext.h"
     ++#include "hex.h"
      +#include "repository.h"
      +#include "sigchain.h"
      +#include "userdiff.h"
     @@ diff-process.c (new)
      +	return packet_flush_gently(fd);
      +}
      +
     -+static int parse_hunk_line(const char *line, struct xdl_hunk *hunk)
     ++/*
     ++ * A hunk in the diff process's presentation coordinates: the line
     ++ * numbering it reports over the protocol.  Kept distinct from struct
     ++ * xdl_hunk (xdiff's coordinates) so that only translated hunks ever
     ++ * reach the diff algorithm; diff_process_hunk_to_xdl() is the single
     ++ * crossing point.
     ++ */
     ++struct diff_process_hunk {
     ++	long old_start, old_count;
     ++	long new_start, new_count;
     ++};
     ++
     ++/*
     ++ * Parse one non-negative decimal field of a hunk line into *out and
     ++ * advance *line past it.  Fields must be plain decimal with no leading
     ++ * whitespace or sign (isdigit() takes an unsigned char to stay defined
     ++ * for high-bit bytes).  The first three fields are followed by a single
     ++ * space; the last (is_last) is followed by end-of-string or a space.
     ++ * Trailing space-separated tokens after the last field are allowed and
     ++ * ignored, so a future protocol version can append fields (e.g. a
     ++ * "moved" marker) without older tools rejecting the line -- mirroring
     ++ * the request-side rule that tools ignore unknown keys.
     ++ */
     ++static int parse_hunk_field(const char **line, long *out, int is_last)
      +{
     ++	const char *p = *line;
      +	char *end;
      +
     -+	/*
     -+	 * Format: "hunk <old_start> <old_count> <new_start> <new_count>"
     -+	 * All numbers must be non-negative decimal with no leading
     -+	 * whitespace or sign characters.
     -+	 */
     -+	if (!skip_prefix(line, "hunk ", &line))
     -+		return -1;
     -+
     -+	if (!isdigit(*line))
     ++	if (!isdigit((unsigned char)*p))
      +		return -1;
      +	errno = 0;
     -+	hunk->old_start = strtol(line, &end, 10);
     -+	if (errno || end == line || *end++ != ' ')
     ++	*out = strtol(p, &end, 10);
     ++	if (errno || end == p)
      +		return -1;
     -+	line = end;
     ++	if (is_last) {
     ++		if (*end != '\0' && *end != ' ')
     ++			return -1;
     ++	} else {
     ++		if (*end != ' ')
     ++			return -1;
     ++		end++;
     ++	}
     ++	*line = end;
     ++	return 0;
     ++}
      +
     -+	if (!isdigit(*line))
     ++static int parse_hunk_line(const char *line,
     ++			   struct diff_process_hunk *presented)
     ++{
     ++	/* Format: "hunk <old_start> <old_count> <new_start> <new_count>" */
     ++	if (!skip_prefix(line, "hunk ", &line))
      +		return -1;
     -+	errno = 0;
     -+	hunk->old_count = strtol(line, &end, 10);
     -+	if (errno || end == line || *end++ != ' ')
     ++	if (parse_hunk_field(&line, &presented->old_start, 0) ||
     ++	    parse_hunk_field(&line, &presented->old_count, 0) ||
     ++	    parse_hunk_field(&line, &presented->new_start, 0) ||
     ++	    parse_hunk_field(&line, &presented->new_count, 1))
      +		return -1;
     -+	line = end;
     ++	return 0;
     ++}
      +
     -+	if (!isdigit(*line))
     -+		return -1;
     -+	errno = 0;
     -+	hunk->new_start = strtol(line, &end, 10);
     -+	if (errno || end == line || *end++ != ' ')
     -+		return -1;
     -+	line = end;
     ++/*
     ++ * Translate a hunk from the diff process's presentation coordinates
     ++ * into xdiff's.
     ++ *
     ++ * Protocol starts are already 1-based positions (the line a change
     ++ * sits before), the same numbering xdiff uses, so the only adjustment
     ++ * is for an empty file side: "git diff" addresses it with a start of 0
     ++ * and a count of 0 (e.g. "0 0 1 5" adds five lines to an empty old
     ++ * side), and since xdiff uses start-1 as an array index that 0 becomes
     ++ * 1 here.  This is NOT the full inverse of xdl_emit_hunk_hdr()
     ++ * (xdiff/xutils.c): that emitter shifts a count-0 range to start-1 for
     ++ * the displayed "@@" header, but the protocol keeps the unshifted
     ++ * 1-based position for a mid-file insert or delete.  This is the single
     ++ * point where presentation coordinates become xdiff coordinates, so
     ++ * xdl_populate_hunks_from_external() may assume 1-based starts.
     ++ *
     ++ * Returns -1 for a start of 0 paired with a nonzero count, which names
     ++ * no line in either coordinate system.  (parse_hunk_line() already
     ++ * guarantees non-negative starts and counts.)
     ++ */
     ++static int diff_process_hunk_to_xdl(const struct diff_process_hunk *presented,
     ++				    struct xdl_hunk *xdl)
     ++{
     ++	long old_start = presented->old_start;
     ++	long new_start = presented->new_start;
      +
     -+	if (!isdigit(*line))
     ++	if ((!old_start && presented->old_count) ||
     ++	    (!new_start && presented->new_count))
      +		return -1;
     -+	errno = 0;
     -+	hunk->new_count = strtol(line, &end, 10);
     -+	if (errno || end == line || *end != '\0')
     -+		return -1;
     -+
     -+	/*
     -+	 * git diff emits start=0 when count=0 (empty file side).
     -+	 * Normalize to 1-based so downstream validation can assume start >= 1.
     -+	 */
     -+	if (!hunk->old_count && !hunk->old_start)
     -+		hunk->old_start = 1;
     -+	if (!hunk->new_count && !hunk->new_start)
     -+		hunk->new_start = 1;
     -+
     ++	if (!old_start)
     ++		old_start = 1;
     ++	if (!new_start)
     ++		new_start = 1;
     ++
     ++	xdl->old_start = old_start;
     ++	xdl->old_count = presented->old_count;
     ++	xdl->new_start = new_start;
     ++	xdl->new_count = presented->new_count;
      +	return 0;
      +}
      +
     @@ diff-process.c (new)
      +		const char *path,
      +		const char *old_buf, long old_size,
      +		const char *new_buf, long new_size,
     ++		const struct object_id *oid_a,
     ++		const struct object_id *oid_b,
      +		struct xdl_hunk **hunks_out,
      +		size_t *nr_hunks_out)
      +{
     @@ diff-process.c (new)
      +	int fd_in, fd_out;
      +	struct strbuf status = STRBUF_INIT;
      +	struct xdl_hunk *hunks = NULL;
     ++	struct diff_process_hunk presented;
      +	struct xdl_hunk hunk;
      +	size_t nr_hunks = 0, alloc_hunks = 0;
     ++	size_t max_hunks;
      +	int len;
      +	char *line;
      +
     @@ diff-process.c (new)
      +
      +	/* Send request */
      +	if (packet_write_fmt_gently(fd_in, "command=hunks\n") ||
     -+	    packet_write_fmt_gently(fd_in, "pathname=%s\n", path) ||
     -+	    packet_flush_gently(fd_in))
     ++	    packet_write_fmt_gently(fd_in, "pathname=%s\n", path))
     ++		goto comm_error;
     ++	/*
     ++	 * old-oid/new-oid let the tool key a cache on the blob pair.  A
     ++	 * side is sent only when its content is the raw blob (the caller
     ++	 * passes NULL otherwise, e.g. for textconv'd content), so an oid
     ++	 * that is present always names the bytes the tool receives.
     ++	 */
     ++	if (oid_a &&
     ++	    packet_write_fmt_gently(fd_in, "old-oid=%s\n", oid_to_hex(oid_a)))
     ++		goto comm_error;
     ++	if (oid_b &&
     ++	    packet_write_fmt_gently(fd_in, "new-oid=%s\n", oid_to_hex(oid_b)))
     ++		goto comm_error;
     ++	if (packet_flush_gently(fd_in))
      +		goto comm_error;
      +
      +	/* Send old file content */
     @@ diff-process.c (new)
      +	if (send_file_content(fd_in, new_buf, new_size))
      +		goto comm_error;
      +
     ++	/*
     ++	 * Hunks are non-overlapping and each useful hunk covers at least
     ++	 * one line, so a valid response cannot contain more hunks than the
     ++	 * two files have lines, which is bounded by their byte sizes.  Cap
     ++	 * the accumulation accordingly so a misbehaving tool that floods
     ++	 * hunk lines cannot drive unbounded memory growth before validation.
     ++	 */
     ++	max_hunks = (size_t)old_size + (size_t)new_size + 1;
     ++
      +	/* Read hunks until flush packet */
      +	while ((len = packet_read_line_gently(fd_out, NULL, &line)) >= 0 &&
      +	       line) {
     -+		if (parse_hunk_line(line, &hunk) < 0)
     ++		if (parse_hunk_line(line, &presented) < 0)
     ++			goto comm_error;
     ++		if (diff_process_hunk_to_xdl(&presented, &hunk) < 0)
     ++			goto comm_error;
     ++		if (nr_hunks >= max_hunks) {
     ++			warning(_("diff process '%s' sent too many hunks"
     ++				  " for '%s'"), drv->process, path);
      +			goto comm_error;
     ++		}
      +		ALLOC_GROW(hunks, nr_hunks + 1, alloc_hunks);
      +		hunks[nr_hunks++] = hunk;
      +	}
     @@ diff-process.c (new)
      +	return DIFF_PROCESS_ERROR;
      +}
      +
     ++/*
     ++ * Whether exactly one of the two blobs ends in a newline.  A change
     ++ * that only adds or removes the trailing newline is not expressible as
     ++ * line hunks, so a tool comparing lines reports the files as equal.
     ++ */
     ++static int eof_newline_differs(const mmfile_t *a, const mmfile_t *b)
     ++{
     ++	int a_nl = a->size > 0 && a->ptr[a->size - 1] == '\n';
     ++	int b_nl = b->size > 0 && b->ptr[b->size - 1] == '\n';
     ++	return a_nl != b_nl;
     ++}
     ++
     ++/*
     ++ * Number of lines in a blob, matching xdiff's record count: one per
     ++ * newline, plus one more if the last line has no trailing newline.
     ++ */
     ++static long count_lines(const char *buf, long size)
     ++{
     ++	long lines = 0, i;
     ++
     ++	for (i = 0; i < size; i++)
     ++		if (buf[i] == '\n')
     ++			lines++;
     ++	if (size > 0 && buf[size - 1] != '\n')
     ++		lines++;
     ++	return lines;
     ++}
     ++
     ++/*
     ++ * Validate the tool's hunks (already in xdiff coordinates) against the
     ++ * two blobs before they bypass the diff algorithm.  Each hunk must fit
     ++ * within its file, the hunks must be ordered and non-overlapping, and
     ++ * the unchanged run before each hunk (and after the last) must be the
     ++ * same length on both sides -- xdl_build_script() walks the two files
     ++ * in lockstep over unchanged lines, so a mismatched gap desynchronizes
     ++ * it and yields a corrupt diff even when the totals balance.  This is
     ++ * the git layer's job so xdiff stays diagnostic-free; on a bad response
     ++ * we warn and the caller falls back to the builtin diff.  Returns 0 if
     ++ * valid, -1 (after warning) otherwise.
     ++ */
     ++static int validate_external_hunks(const struct xdl_hunk *hunks, size_t nr,
     ++				   long old_lines, long new_lines,
     ++				   const char *process, const char *path)
     ++{
     ++	size_t i;
     ++	long prev_old_end = 0, prev_new_end = 0;
     ++
     ++	for (i = 0; i < nr; i++) {
     ++		const struct xdl_hunk *h = &hunks[i];
     ++
     ++		if (h->old_count > old_lines - h->old_start + 1 ||
     ++		    h->new_count > new_lines - h->new_start + 1) {
     ++			warning(_("diff process '%s' returned a hunk past the "
     ++				  "end of '%s'; using the builtin diff"),
     ++				process, path);
     ++			return -1;
     ++		}
     ++		if (h->old_start < prev_old_end || h->new_start < prev_new_end) {
     ++			warning(_("diff process '%s' returned overlapping hunks "
     ++				  "for '%s'; using the builtin diff"),
     ++				process, path);
     ++			return -1;
     ++		}
     ++		if (h->old_start - prev_old_end != h->new_start - prev_new_end) {
     ++			warning(_("diff process '%s' returned hunks that leave "
     ++				  "'%s' misaligned; using the builtin diff"),
     ++				process, path);
     ++			return -1;
     ++		}
     ++		prev_old_end = h->old_start + h->old_count;
     ++		prev_new_end = h->new_start + h->new_count;
     ++	}
     ++	if (old_lines - prev_old_end != new_lines - prev_new_end) {
     ++		warning(_("diff process '%s' returned hunks that leave '%s' "
     ++			  "misaligned; using the builtin diff"),
     ++			process, path);
     ++		return -1;
     ++	}
     ++	return 0;
     ++}
     ++
      +enum diff_process_result diff_process_fill_hunks(
      +		struct diff_options *diffopt,
      +		const char *path,
      +		const mmfile_t *file_a,
      +		const mmfile_t *file_b,
     ++		const struct object_id *oid_a,
     ++		const struct object_id *oid_b,
      +		xpparam_t *xpp)
      +{
      +	struct userdiff_driver *drv;
     @@ diff-process.c (new)
      +		return DIFF_PROCESS_SKIP;
      +	if (diffopt->flags.no_diff_process || diffopt->ignore_driver_algorithm)
      +		return DIFF_PROCESS_SKIP;
     ++	/*
     ++	 * Whitespace-ignoring, regex-ignore (-I) and anchored options
     ++	 * change which lines count as different, but the tool is never
     ++	 * told about them, so its hunks could not honor them.  Rather
     ++	 * than silently override the user's request, fall back to the
     ++	 * builtin diff, which does honor these flags.  Key this off xpp
     ++	 * (the parameters this diff actually runs with) rather than
     ++	 * diffopt, so a caller like blame that keeps its flags outside
     ++	 * diffopt is covered without a separate guard of its own.
     ++	 */
     ++	if ((xpp->flags & (XDF_WHITESPACE_FLAGS | XDF_IGNORE_BLANK_LINES)) ||
     ++	    xpp->ignore_regex_nr || xpp->anchors_nr)
     ++		return DIFF_PROCESS_SKIP;
      +
      +	drv = userdiff_find_by_path(diffopt->repo->index, path);
      +	if (!drv || !drv->process)
     @@ diff-process.c (new)
      +	res = get_hunks(drv, path,
      +			file_a->ptr, file_a->size,
      +			file_b->ptr, file_b->size,
     ++			oid_a, oid_b,
      +			&ext_hunks, &nr);
      +	if (res == DIFF_PROCESS_OK) {
      +		if (!nr) {
      +			free(ext_hunks);
     ++			/*
     ++			 * Zero hunks means the tool considers the line
     ++			 * content identical, but it cannot express a
     ++			 * trailing-newline-only change.  When that is the
     ++			 * actual difference, fall back to the builtin diff
     ++			 * so the "\ No newline at end of file" marker is
     ++			 * preserved instead of reporting the files equal.
     ++			 */
     ++			if (eof_newline_differs(file_a, file_b))
     ++				return DIFF_PROCESS_SKIP;
      +			return DIFF_PROCESS_EQUIVALENT;
      +		}
     ++		if (validate_external_hunks(ext_hunks, nr,
     ++					    count_lines(file_a->ptr, file_a->size),
     ++					    count_lines(file_b->ptr, file_b->size),
     ++					    drv->process, path) < 0) {
     ++			free(ext_hunks);
     ++			return DIFF_PROCESS_SKIP;
     ++		}
      +		xpp->external_hunks = ext_hunks;
      +		xpp->external_hunks_nr = nr;
      +		return DIFF_PROCESS_OK;
     @@ diff-process.h (new)
      +#include "xdiff/xdiff.h"
      +
      +struct diff_options;
     ++struct object_id;
      +
      +enum diff_process_result {
     -+	DIFF_PROCESS_ERROR = -1, /* tool failure: warned, fell back */
     ++	DIFF_PROCESS_ERROR = -1, /* failed; caller falls back to builtin */
      +	DIFF_PROCESS_OK = 0,     /* hunks populated in xpp */
     -+	DIFF_PROCESS_SKIP,       /* no process configured: use builtin */
     ++	DIFF_PROCESS_SKIP,       /* process did not apply: use builtin */
      +	DIFF_PROCESS_EQUIVALENT, /* tool says files are equivalent */
      +};
      +
     @@ diff-process.h (new)
      + * Returns DIFF_PROCESS_OK when hunks are populated in xpp.
      + * The caller owns xpp->external_hunks and must free() it.
      + *
     -+ * Returns DIFF_PROCESS_EQUIVALENT when the tool returns no hunks
     -+ * (files are considered identical); caller should skip diff/blame.
     ++ * Returns DIFF_PROCESS_EQUIVALENT when the tool returns no hunks and
     ++ * the blobs are not a trailing-newline-only change (files are
     ++ * considered identical); caller should skip diff/blame.
      + * Returns DIFF_PROCESS_SKIP when no process applies; caller
      + * should use the builtin diff algorithm.
      + * Returns DIFF_PROCESS_ERROR on tool failure (already warned);
      + * caller should fall back to the builtin diff algorithm.
     ++ *
     ++ * oid_a/oid_b, when non-NULL, are sent to the tool as old-oid/new-oid
     ++ * so it can key a cache on the blob pair.  Pass NULL for a side whose
     ++ * content is not the raw blob (e.g. textconv'd) or whose object name is
     ++ * unknown, so any oid that is sent always names the bytes the tool
     ++ * receives.
      + */
      +enum diff_process_result diff_process_fill_hunks(
      +		struct diff_options *diffopt,
      +		const char *path,
      +		const mmfile_t *file_a,
      +		const mmfile_t *file_b,
     ++		const struct object_id *oid_a,
     ++		const struct object_id *oid_b,
      +		xpparam_t *xpp);
      +
      +#endif /* DIFF_PROCESS_H */
     @@ diff.c: static void builtin_diff(const char *name_a,
       		xpp.anchors = o->anchors;
       		xpp.anchors_nr = o->anchors_nr;
      +
     -+		if (diff_process_fill_hunks(o, name_a,
     -+					    &mf1, &mf2, &xpp)
     ++		/*
     ++		 * Send the blob oids only for a side whose content is the
     ++		 * raw blob: textconv rewrites the bytes, and a working-tree
     ++		 * side has no stored oid, so pass NULL there rather than an
     ++		 * oid that would not name what the tool receives.
     ++		 */
     ++		if (diff_process_fill_hunks(o, name_a, &mf1, &mf2,
     ++					    (textconv_one || !one->oid_valid) ? NULL : &one->oid,
     ++					    (textconv_two || !two->oid_valid) ? NULL : &two->oid,
     ++					    &xpp)
      +		    == DIFF_PROCESS_EQUIVALENT) {
      +			if (textconv_one)
      +				free(mf1.ptr);
     @@ t/helper/test-diff-process-backend.c (new)
      + *
      + *   packet:          git> command=hunks
      + *   packet:          git> pathname=<path>
     ++ *   packet:          git> [old-oid=<hex>]   (omitted for textconv/worktree)
     ++ *   packet:          git> [new-oid=<hex>]
      + *   packet:          git> 0000
      + *   packet:          git> OLD_CONTENT
      + *   packet:          git> 0000
     @@ t/helper/test-diff-process-backend.c (new)
      + *
      + * Response varies by --mode (default: whole-file):
      + *
     -+ *   whole-file   packet: git< hunk 1 <old_lines> 1 <new_lines>
     ++ *   whole-file   packet: git< hunk <1|0> <old_lines> <1|0> <new_lines>
     ++ *                (start is 0 for an empty side, matching git diff)
      + *   fixed-hunk   packet: git< hunk 5 2 5 2
      + *   no-hunks     (no hunk packets)
      + *   bad-hunk     packet: git< hunk 999 1 999 1
      + *   bad-parse    packet: git< garbage not a hunk
      + *   bad-sync     packet: git< hunk 1 2 1 1
     ++ *   bad-gap      packet: git< hunk 1 1 3 1
     ++ *   bad-start    packet: git< hunk 0 1 1 1
     ++ *   multi-hunk   packet: git< hunk 5 2 5 2
     ++ *                packet: git< hunk 9 2 9 2
     ++ *   insert       packet: git< hunk 3 0 3 2   (mid-file count-0 insertion)
     ++ *   flood        packet: git< hunk 1 1 1 1   (x100000)
      + *   overlap      packet: git< hunk 1 5 1 5
      + *                packet: git< hunk 3 2 3 2
      + *   no-cap       (omits capability=hunks during handshake)
     @@ t/helper/test-diff-process-backend.c (new)
      + *   abort        (status=abort instead of status=success)
      + *   crash        exit(1) before sending any response
      + *
     -+ * All non-error/abort modes end with:
     ++ * All success modes (not error/abort/crash) end with:
      + *
      + *   packet:          git< 0000
      + *   packet:          git< status=success
     @@ t/helper/test-diff-process-backend.c (new)
      + *
      + * Each request is logged to --log as:
      + *
     -+ *   command=<cmd> pathname=<path> old=<first line> new=<first line>
     ++ *   command=<cmd> pathname=<path> old-oid=<hex> new-oid=<hex> old=<first line> new=<first line>
      + */
      +
      +#include "test-tool.h"
     @@ t/helper/test-diff-process-backend.c (new)
      +	MODE_BAD_HUNK,
      +	MODE_BAD_PARSE,
      +	MODE_BAD_SYNC,
     ++	MODE_BAD_GAP,
     ++	MODE_BAD_START,
     ++	MODE_MULTI_HUNK,
     ++	MODE_INSERT,
     ++	MODE_FLOOD,
      +	MODE_OVERLAP,
      +	MODE_NO_CAP,
      +	MODE_ERROR,
     @@ t/helper/test-diff-process-backend.c (new)
      +		return MODE_BAD_PARSE;
      +	if (!strcmp(s, "bad-sync"))
      +		return MODE_BAD_SYNC;
     ++	if (!strcmp(s, "bad-gap"))
     ++		return MODE_BAD_GAP;
     ++	if (!strcmp(s, "bad-start"))
     ++		return MODE_BAD_START;
     ++	if (!strcmp(s, "multi-hunk"))
     ++		return MODE_MULTI_HUNK;
     ++	if (!strcmp(s, "insert"))
     ++		return MODE_INSERT;
     ++	if (!strcmp(s, "flood"))
     ++		return MODE_FLOOD;
      +	if (!strcmp(s, "overlap"))
      +		return MODE_OVERLAP;
      +	if (!strcmp(s, "no-cap"))
     @@ t/helper/test-diff-process-backend.c (new)
      + * variant: once inside a request, truncation is a protocol violation
      + * and dying loudly is the correct response.
      + */
     -+static int read_request_header(char **command, char **pathname)
     ++static int read_request_header(char **command, char **pathname,
     ++			       char **old_oid, char **new_oid)
      +{
      +	int first = 1;
      +	char *line;
      +
     -+	*command = *pathname = NULL;
     ++	*command = *pathname = *old_oid = *new_oid = NULL;
      +	for (;;) {
      +		const char *value;
      +
     @@ t/helper/test-diff-process-backend.c (new)
      +			*command = xstrdup(value);
      +		else if (skip_prefix(line, "pathname=", &value))
      +			*pathname = xstrdup(value);
     ++		else if (skip_prefix(line, "old-oid=", &value))
     ++			*old_oid = xstrdup(value);
     ++		else if (skip_prefix(line, "new-oid=", &value))
     ++			*new_oid = xstrdup(value);
      +	}
      +	return 1;
      +}
     @@ t/helper/test-diff-process-backend.c (new)
      +	case MODE_BAD_SYNC:
      +		packet_write_fmt(1, "hunk 1 2 1 1\n");
      +		break;
     ++	case MODE_BAD_GAP:
     ++		/*
     ++		 * Globally balanced (1 changed line on each side, so the
     ++		 * total unchanged counts match) but the gap before the
     ++		 * change differs between sides: old line 1 vs new line 3.
     ++		 * Exercises the per-gap lockstep-alignment check.
     ++		 */
     ++		packet_write_fmt(1, "hunk 1 1 3 1\n");
     ++		break;
     ++	case MODE_BAD_START:
     ++		/*
     ++		 * A start of 0 is valid only for an empty (count 0) range;
     ++		 * pairing it with a nonzero count names no line in either
     ++		 * the protocol's or xdiff's coordinates, so the translation
     ++		 * rejects it and git falls back to the builtin diff.
     ++		 */
     ++		packet_write_fmt(1, "hunk 0 1 1 1\n");
     ++		break;
     ++	case MODE_MULTI_HUNK:
     ++		/*
     ++		 * Two valid, non-overlapping, gap-aligned hunks.  Exercises
     ++		 * the accepting branch of the per-gap lockstep check with a
     ++		 * non-zero previous-hunk end (the realistic two-region case).
     ++		 */
     ++		packet_write_fmt(1, "hunk 5 2 5 2\n");
     ++		packet_write_fmt(1, "hunk 9 2 9 2\n");
     ++		break;
     ++	case MODE_INSERT:
     ++		/*
     ++		 * A mid-file pure insertion (count 0 on the old side) in the
     ++		 * protocol's 1-based-position form: 2 lines inserted before
     ++		 * old line 3.  Exercises the count-0 path, which uses the
     ++		 * unshifted position (not git diff's "-3,0" display start).
     ++		 */
     ++		packet_write_fmt(1, "hunk 3 0 3 2\n");
     ++		break;
     ++	case MODE_FLOOD: {
     ++		/*
     ++		 * Emit far more hunks than any small file has lines, so Git
     ++		 * trips its accumulation cap and falls back before reading
     ++		 * them all.
     ++		 */
     ++		int i;
     ++		for (i = 0; i < 100000; i++)
     ++			packet_write_fmt(1, "hunk 1 1 1 1\n");
     ++		break;
     ++	}
      +	case MODE_OVERLAP:
      +		packet_write_fmt(1, "hunk 1 5 1 5\n");
      +		packet_write_fmt(1, "hunk 3 2 3 2\n");
     @@ t/helper/test-diff-process-backend.c (new)
      +{
      +	for (;;) {
      +		char *command = NULL, *pathname = NULL;
     ++		char *old_oid = NULL, *new_oid = NULL;
      +		struct strbuf obuf = STRBUF_INIT;
      +		struct strbuf nbuf = STRBUF_INIT;
      +
     -+		if (!read_request_header(&command, &pathname))
     ++		if (!read_request_header(&command, &pathname,
     ++					 &old_oid, &new_oid))
      +			break; /* EOF: Git closed its end */
      +
      +		read_packetized_to_strbuf(0, &obuf, 0);
     @@ t/helper/test-diff-process-backend.c (new)
      +
      +		if (logfile) {
      +			fprintf(logfile,
     -+				"command=%s pathname=%s old=%.*s new=%.*s\n",
     ++				"command=%s pathname=%s old-oid=%s new-oid=%s"
     ++				" old=%.*s new=%.*s\n",
      +				command ? command : "(none)",
      +				pathname ? pathname : "(none)",
     ++				old_oid ? old_oid : "(none)",
     ++				new_oid ? new_oid : "(none)",
      +				(int)(strchrnul(obuf.buf, '\n') - obuf.buf),
      +				obuf.buf,
      +				(int)(strchrnul(nbuf.buf, '\n') - nbuf.buf),
     @@ t/helper/test-diff-process-backend.c (new)
      +
      +		free(command);
      +		free(pathname);
     ++		free(old_oid);
     ++		free(new_oid);
      +		strbuf_release(&obuf);
      +		strbuf_release(&nbuf);
      +	}
     @@ t/helper/test-diff-process-backend.c (new)
      +	enum mode mode = MODE_WHOLE_FILE;
      +	struct option options[] = {
      +		OPT_STRING(0, "mode", &mode_str, "mode",
     -+			   "response shape: whole-file (default), fixed-hunk,"
     -+			   " no-hunks, bad-hunk, bad-sync, overlap, error,"
     -+			   " abort, crash"),
     ++			   "response shape (default whole-file);"
     ++			   " see the file header for the full list of modes"),
      +		OPT_STRING(0, "log", &log_path, "path",
      +			   "append per-request summary to this file"),
      +		OPT_END()
     @@ t/t4080-diff-process.sh (new)
      +
      +test_description='diff process via long-running process'
      +
     ++TEST_PASSES_SANITIZE_LEAK=true
      +. ./test-lib.sh
      +
      +# See t/helper/test-diff-process-backend.c for the backend implementation
     @@ t/t4080-diff-process.sh (new)
      +	EOF
      +	git add logtest.c &&
      +
     -+	# two.c/one.c: two-file pair for error/abort/startup-failure tests.
     ++	# one.c/two.c: two-file pair for error/abort/startup-failure tests.
      +	cat >one.c <<-\EOF &&
      +	int first(void) { return 1; }
      +	EOF
     @@ t/t4080-diff-process.sh (new)
      +	test_grep ! "^+NEW10" actual
      +'
      +
     ++test_expect_success 'diff process accepts valid multi-hunk output' '
     ++	# multi-hunk reports both changed regions (5-6 and 9-10) as two
     ++	# gap-aligned hunks.  This exercises the accepting branch of the
     ++	# per-gap lockstep check (non-zero previous-hunk end) and must
     ++	# produce a correct two-region diff with the lines between the
     ++	# hunks kept as context.
     ++	git -c diff.cdiff.process="$BACKEND --mode=multi-hunk" \
     ++		diff boundary.c >actual 2>stderr &&
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "^+NEW5" actual &&
     ++	test_grep "^-OLD9" actual &&
     ++	test_grep "^+NEW9" actual &&
     ++	test_grep "^ line7" actual &&
     ++	test_grep "^ line8" actual &&
     ++	test_must_be_empty stderr
     ++'
     ++
     ++test_expect_success 'diff process accepts a mid-file count-0 insertion' '
     ++	# insert mode reports "hunk 3 0 3 2": a pure insertion (count 0 on
     ++	# the old side) in the protocol 1-based-position form.  Exercises
     ++	# the count-0 hunk path that the other valid-hunk modes (full
     ++	# replacements, equal-count modifies) never hit.  Empty stderr is
     ++	# the discriminator: a mishandled count-0 start would be rejected
     ++	# by the lockstep check and warn.
     ++	cat >insert.c <<-\EOF &&
     ++	a
     ++	b
     ++	c
     ++	d
     ++	e
     ++	EOF
     ++	git add insert.c &&
     ++	git commit -m "add insert.c" &&
     ++	cat >insert.c <<-\EOF &&
     ++	a
     ++	b
     ++	X
     ++	Y
     ++	c
     ++	d
     ++	e
     ++	EOF
     ++	git -c diff.cdiff.process="$BACKEND --mode=insert" \
     ++		diff insert.c >actual 2>stderr &&
     ++	test_grep "^+X" actual &&
     ++	test_grep "^+Y" actual &&
     ++	test_grep "^ c" actual &&
     ++	test_must_be_empty stderr
     ++'
     ++
      +test_expect_success 'diff process works with modified file' '
      +	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     @@ t/t4080-diff-process.sh (new)
      +		diff --exit-code nohunks.c
      +'
      +
     ++test_expect_success 'diff process equivalent commit: --exit-code and --quiet agree' '
     ++	# A committed blob pair (not a worktree file) whose oids differ but
     ++	# the tool reports equivalent.  --exit-code and --quiet must agree
     ++	# with the shown diff (empty) and report success, not fall back to
     ++	# the byte-level "oids differ" answer.
     ++	cat >ecq.c <<-\EOF &&
     ++	alpha
     ++	EOF
     ++	git add ecq.c &&
     ++	git commit -m "ecq v1" &&
     ++	cat >ecq.c <<-\EOF &&
     ++	beta
     ++	EOF
     ++	git add ecq.c &&
     ++	git commit -m "ecq v2" &&
     ++	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
     ++		diff --exit-code HEAD^ HEAD -- ecq.c &&
     ++	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
     ++		diff --quiet HEAD^ HEAD -- ecq.c
     ++'
     ++
     ++test_expect_success 'diff process falls back for trailing-newline-only change' '
     ++	test_when_finished "rm -f backend.log" &&
     ++	printf "a\nb\nc\n" >eofnl.c &&
     ++	git add eofnl.c &&
     ++	git commit -m "add eofnl.c" &&
     ++	printf "a\nb\nc" >eofnl.c &&
     ++	# Same lines, only the final newline removed.  The tool reports
     ++	# no hunks (it sees identical lines), but that change is not
     ++	# expressible as hunks, so git falls back to the builtin diff
     ++	# rather than treating the files as equivalent.
     ++	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
     ++		diff eofnl.c >actual 2>stderr &&
     ++	test_grep "No newline at end of file" actual &&
     ++	test_grep "pathname=eofnl.c" backend.log &&
     ++	test_must_be_empty stderr
     ++'
     ++
     ++test_expect_success 'diff process falls back for added file (empty old side)' '
     ++	test_when_finished "rm -f backend.log" &&
     ++	printf "x\ny\nz\n" >addnl.c &&
     ++	git add addnl.c &&
     ++	# The empty old side has no trailing newline while the new side
     ++	# does, so the newline fallback shows the addition rather than
     ++	# letting no-hunks suppress the whole new file.
     ++	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
     ++		diff --cached addnl.c >actual 2>stderr &&
     ++	test_grep "^+x" actual &&
     ++	test_grep "pathname=addnl.c" backend.log &&
     ++	test_must_be_empty stderr
     ++'
     ++
      +test_expect_success 'diff process with --exit-code and hunks returns failure' '
      +	test_expect_code 1 git -c diff.cdiff.process="$BACKEND" \
      +		diff --exit-code newfile.c
     @@ t/t4080-diff-process.sh (new)
      +	test_path_is_missing backend.log
      +'
      +
     -+test_expect_success 'diff process not used by --stat' '
     ++test_expect_success 'diff process bypassed under whitespace-ignoring flags' '
      +	test_when_finished "rm -f backend.log" &&
     -+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     -+		diff --stat worddiff.c >actual &&
     -+	test_grep "worddiff.c" actual &&
     -+	test_path_is_missing backend.log
     ++	printf "a\nb\nc\n" >wsbypass.c &&
     ++	git add wsbypass.c &&
     ++	git commit -m "add wsbypass.c" &&
     ++	printf "a\n  b  \nc\n" >wsbypass.c &&
     ++	# The tool is never told about these options and could not honor
     ++	# them, so git bypasses the process for each (covering the whole
     ++	# XDF_WHITESPACE_FLAGS | XDF_IGNORE_BLANK_LINES mask, not just -w).
     ++	for opt in -w -b --ignore-space-at-eol --ignore-blank-lines
     ++	do
     ++		rm -f backend.log &&
     ++		git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     ++			diff $opt wsbypass.c >actual 2>stderr &&
     ++		test_path_is_missing backend.log &&
     ++		test_must_be_empty stderr ||
     ++		return 1
     ++	done &&
     ++	# -w additionally suppresses the whitespace-only change via the
     ++	# builtin diff that now runs.
     ++	git -c diff.cdiff.process="$BACKEND" diff -w wsbypass.c >actual &&
     ++	test_must_be_empty actual
      +'
      +
      +#
     @@ t/t4080-diff-process.sh (new)
      +	test_grep "^+NEW5" actual &&
      +	test_grep "^-OLD9" actual &&
      +	test_grep "^+NEW9" actual &&
     -+	test_grep "exceeds.*lines" stderr
     ++	test_grep "hunk past the end" stderr
      +'
      +
      +test_expect_success 'diff process fallback on mismatched unchanged totals' '
     @@ t/t4080-diff-process.sh (new)
      +	git -c diff.cdiff.process="$BACKEND --mode=bad-sync" \
      +		diff synctest.c >actual 2>stderr &&
      +	test_grep "changed" actual &&
     -+	test_grep "unchanged line count mismatch" stderr
     ++	test_grep "misaligned" stderr
     ++'
     ++
     ++test_expect_success 'diff process fallback on misaligned hunk gap' '
     ++	# bad-gap reports hunk 1 1 3 1 on boundary.c: one changed line
     ++	# on each side, so the total unchanged counts match, but the
     ++	# unchanged run before the change differs (old line 1 vs new
     ++	# line 3).  A global count check would accept this and emit a
     ++	# corrupt diff; the per-gap lockstep check rejects it and git
     ++	# falls back to the builtin algorithm.
     ++	git -c diff.cdiff.process="$BACKEND --mode=bad-gap" \
     ++		diff boundary.c >actual 2>stderr &&
     ++	# The builtin fallback shows both changed regions as additions
     ++	# (a corrupt-accepted hunk would show NEW5 only as context).
     ++	test_grep "^+NEW5" actual &&
     ++	test_grep "^+NEW9" actual &&
     ++	test_grep "misaligned" stderr
      +'
      +
      +test_expect_success 'diff process fallback on overlapping hunks' '
      +	# boundary.c has 10 lines, so both hunks are in bounds
     -+	# but they overlap at lines 3-5, triggering the ordering check.
     ++	# but they overlap at lines 3-4, triggering the ordering check.
      +	git -c diff.cdiff.process="$BACKEND --mode=overlap" \
      +		diff boundary.c >actual 2>stderr &&
      +	test_grep "NEW5" actual &&
     -+	test_grep "overlaps with previous" stderr
     ++	test_grep "overlapping hunks" stderr
      +'
      +
      +test_expect_success 'diff process fallback on malformed hunk line' '
     @@ t/t4080-diff-process.sh (new)
      +	test_grep "^+NEW5" actual
      +'
      +
     -+test_expect_success 'diff process skipped when tool omits capability' '
     -+	git -c diff.cdiff.process="$BACKEND --mode=no-cap" \
     ++test_expect_success 'diff process fallback on start 0 with nonzero count' '
     ++	# bad-start reports hunk 0 1 1 1.  A start of 0 is valid only for
     ++	# an empty (count 0) range, so the presentation-to-xdiff
     ++	# translation rejects it and git falls back to the builtin diff
     ++	# instead of handing xdiff an out-of-range start.
     ++	git -c diff.cdiff.process="$BACKEND --mode=bad-start" \
      +		diff boundary.c >actual 2>stderr &&
      +	test_grep "^-OLD5" actual &&
      +	test_grep "^+NEW5" actual &&
     ++	test_grep "diff process.*failed" stderr
     ++'
     ++
     ++test_expect_success 'diff process caps a flood of hunks and falls back' '
     ++	# flood emits far more hunks than the file has lines.  Git must
     ++	# stop accumulating and fall back to the builtin diff rather than
     ++	# grow memory without bound.
     ++	git -c diff.cdiff.process="$BACKEND --mode=flood" \
     ++		diff boundary.c >actual 2>stderr &&
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "too many hunks" stderr
     ++'
     ++
     ++test_expect_success 'diff process skipped when tool omits capability' '
     ++	test_when_finished "rm -f backend.log" &&
     ++	git -c diff.cdiff.process="$BACKEND --mode=no-cap --log=backend.log" \
     ++		diff boundary.c >actual 2>stderr &&
     ++	# Builtin diff runs: all changes appear, including lines 9-10
     ++	# that a tool-provided hunk would have narrowed away.
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "^-OLD9" actual &&
     ++	# The process launched (creating the log) but was
     ++	# never sent a per-file request, so no hunks command is logged.
     ++	test_path_is_file backend.log &&
     ++	test_grep ! "command=hunks" backend.log &&
     ++	test_must_be_empty stderr
     ++'
     ++
     ++test_expect_success 'diff process receives old-oid and new-oid for a blob pair' '
     ++	test_when_finished "rm -f backend.log" &&
     ++	cat >oidpair.c <<-\EOF &&
     ++	int f(void) { return 1; }
     ++	EOF
     ++	git add oidpair.c &&
     ++	git commit -m "oidpair v1" &&
     ++	old=$(git rev-parse HEAD:oidpair.c) &&
     ++
     ++	cat >oidpair.c <<-\EOF &&
     ++	int f(void) { return 2; }
     ++	EOF
     ++	git add oidpair.c &&
     ++	git commit -m "oidpair v2" &&
     ++	new=$(git rev-parse HEAD:oidpair.c) &&
     ++
     ++	# Both sides are stored blobs, so their object names are sent.
     ++	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     ++		diff HEAD^ HEAD -- oidpair.c >actual 2>stderr &&
     ++	test_grep "old-oid=$old new-oid=$new" backend.log &&
     ++	test_must_be_empty stderr
     ++'
     ++
     ++test_expect_success 'diff process omits old-oid and new-oid for textconv content' '
     ++	test_when_finished "rm -f backend.log" &&
     ++	write_script oidcat <<-\EOF &&
     ++	cat "$1"
     ++	EOF
     ++	cat >oidtc.c <<-\EOF &&
     ++	alpha
     ++	EOF
     ++	git add oidtc.c &&
     ++	git commit -m "oidtc v1" &&
     ++	cat >oidtc.c <<-\EOF &&
     ++	beta
     ++	EOF
     ++	git add oidtc.c &&
     ++	git commit -m "oidtc v2" &&
     ++
     ++	# textconv rewrites the bytes, so the raw-blob object name that
     ++	# would otherwise identify each side is omitted.
     ++	git -c diff.cdiff.textconv="./oidcat" \
     ++	    -c diff.cdiff.process="$BACKEND --log=backend.log" \
     ++		diff HEAD^ HEAD -- oidtc.c >actual 2>stderr &&
     ++	test_grep "pathname=oidtc.c" backend.log &&
     ++	test_grep "old-oid=(none) new-oid=(none)" backend.log &&
      +	test_must_be_empty stderr
      +'
      +
  5:  6ec6716ea4 !  6:  b2e80f014e diff: bypass diff process with --no-ext-diff and in format-patch
     @@ Documentation/diff-options.adoc: endif::git-format-patch[]
       `--textconv`::
       `--no-textconv`::
      
     + ## Documentation/gitattributes.adoc ##
     +@@ Documentation/gitattributes.adoc: display, which is covered above); and combined diffs (`--cc` and merge
     + diffs), whose protocol would have to be extended from a single old/new
     + pair to one comparison per merge parent.
     + 
     +-`--diff-algorithm` bypasses the process entirely, for every feature
     +-listed above.  The whitespace-ignoring options (`-w`,
     +-`--ignore-space-change`, `--ignore-blank-lines`, and the like),
     ++`--no-ext-diff` and `--diff-algorithm` bypass the process entirely,
     ++for every feature listed above.  The whitespace-ignoring options
     ++(`-w`, `--ignore-space-change`, `--ignore-blank-lines`, and the like),
     + `-I<regex>`, and `--anchored` also bypass it for the affected files:
     + the tool is never told about these options, so it could not honor
     + them, and Git falls back to the builtin diff, which does.
     +
       ## builtin/log.c ##
      @@ builtin/log.c: int cmd_format_patch(int argc,
       	if (argc > 1)
     @@ diff.h: struct diff_flags {
       
      -	/** Disables diff.<driver>.process. */
      +	/**
     -+	 * Disables diff.<driver>.process.  Set by --no-ext-diff.
     ++	 * Disables diff.<driver>.process.  Set by --no-ext-diff and by
     ++	 * format-patch.
      +	 */
       	unsigned no_diff_process;
       
     @@ t/t4080-diff-process.sh: test_expect_success 'diff process bypassed by --diff-al
      +	test_path_is_missing backend.log
      +'
      +
     - test_expect_success 'diff process not used by --stat' '
     + test_expect_success 'diff process bypassed under whitespace-ignoring flags' '
       	test_when_finished "rm -f backend.log" &&
     - 	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     + 	printf "a\nb\nc\n" >wsbypass.c &&
  6:  3dadafa1bc !  7:  cf5bb8984a blame: consult diff process for no-hunk detection
     @@ Commit message
          commit as having no changes, causing blame to attribute lines
          to earlier commits.
      
     -    The consultation happens at the pass_blame_to_parent() callsite
     -    using diff_process_fill_hunks(), matching how builtin_diff() in
     -    diff.c uses the same function.  A new diff_hunks_xpp() variant
     -    accepts a pre-populated xpparam_t so callers can pass external
     -    hunks, while the existing diff_hunks() retains its original
     -    signature and behavior.  The copy-detection callsite is
     -    unaffected since it does not use the diff process.
     +    Introduce xdi_diff_process(), a process-aware xdi_diff() that
     +    consults the process, runs xdiff on the tool's hunks or on the
     +    builtin algorithm when it does not apply, frees the hunks, and
     +    reports DIFF_PROCESS_EQUIVALENT (without running xdiff) so the caller
     +    can drop or skip the change.  It is the shared consult-then-diff path
     +    for consumers that work on raw hunks: blame's pass_blame_to_parent()
     +    uses it here, and git log -L reuses it later.  builtin_diff() keeps
     +    consulting the process directly, because it tests for equivalence
     +    early, before its funcname-pattern and word-diff setup, so a
     +    reformat-only file short-circuits without that work.
      
     -    The subprocess is long-running (one startup cost amortized
     -    across the blame traversal), but each commit in the file's
     -    history incurs a round-trip to the tool.
     +    Blame's -w option is not communicated to the process and it could not
     +    honor it, so blame must fall back to the builtin diff there.  Because
     +    blame keeps its whitespace flags in sb->xdl_opts rather than diffopt,
     +    the process bypass keys off xpp (the flags the diff actually runs
     +    with), which covers blame without a guard of its own.
     +
     +    The subprocess is long-running (one startup cost amortized across the
     +    blame traversal), but each commit in the file's history incurs a
     +    round-trip to the tool.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ blame.c
       #include "alloc.h"
       #include "commit-slab.h"
       #include "bloom.h"
     -@@ blame.c: static struct commit *fake_working_tree_commit(struct repository *r,
     - 
     - 
     - 
     --static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
     --		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
     -+static int diff_hunks_xpp(mmfile_t *file_a, mmfile_t *file_b,
     -+			  xdl_emit_hunk_consume_func_t hunk_func,
     -+			  void *cb_data, xpparam_t *xpp)
     - {
     --	xpparam_t xpp = {0};
     - 	xdemitconf_t xecfg = {0};
     - 	xdemitcb_t ecb = {NULL};
     - 
     --	xpp.flags = xdl_opts;
     - 	xecfg.hunk_func = hunk_func;
     - 	ecb.priv = cb_data;
     --	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
     -+	return xdi_diff(file_a, file_b, xpp, &xecfg, &ecb);
     -+}
     -+
     -+static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
     -+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
     -+{
     -+	xpparam_t xpp = {0};
     -+
     -+	xpp.flags = xdl_opts;
     -+	return diff_hunks_xpp(file_a, file_b, hunk_func, cb_data, &xpp);
     - }
     - 
     - static const char *get_next_line(const char *start, const char *end)
      @@ blame.c: static void pass_blame_to_parent(struct blame_scoreboard *sb,
       				 struct blame_origin *parent, int ignore_diffs)
       {
       	mmfile_t file_p, file_o;
      +	xpparam_t xpp = {0};
     ++	xdemitconf_t xecfg = {0};
     ++	xdemitcb_t ecb = {NULL};
       	struct blame_chunk_cb_data d;
       	struct blame_entry *newdest = NULL;
       
     @@ blame.c: static void pass_blame_to_parent(struct blame_scoreboard *sb,
       	sb->num_get_patch++;
       
      -	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
     --		die("unable to generate diff (%s -> %s)",
     --		    oid_to_hex(&parent->commit->object.oid),
     --		    oid_to_hex(&target->commit->object.oid));
      +	xpp.flags = sb->xdl_opts;
     ++	xecfg.hunk_func = blame_chunk_cb;
     ++	ecb.priv = &d;
      +	/*
     -+	 * If the diff process considers the files equivalent,
     -+	 * skip the diff so blame looks past this commit.
     ++	 * Consult the diff process, then attribute the resulting chunks
     ++	 * via blame_chunk_cb.  It bypasses the process for the whitespace-
     ++	 * ignoring options it cannot honor (they live in xpp.flags, which
     ++	 * the consultation checks), and when the process reports the blobs
     ++	 * equivalent it runs no diff, so blame passes this commit and looks
     ++	 * past it.  Look up the driver by the parent (old) path, as
     ++	 * builtin_diff() does with name_a, so a renamed file resolves to the
     ++	 * same driver across diff, blame, and line-log.  Pass no
     ++	 * old-oid/new-oid: blame diffs each blob pair once, so the tool gains
     ++	 * nothing from a per-invocation cache key.
      +	 */
     -+	if (diff_process_fill_hunks(&sb->revs->diffopt, target->path,
     -+				    &file_p, &file_o, &xpp)
     -+	    != DIFF_PROCESS_EQUIVALENT) {
     -+		if (diff_hunks_xpp(&file_p, &file_o, blame_chunk_cb,
     -+				   &d, &xpp))
     -+			die("unable to generate diff (%s -> %s)",
     -+			    oid_to_hex(&parent->commit->object.oid),
     -+			    oid_to_hex(&target->commit->object.oid));
     -+	}
     -+	free(xpp.external_hunks);
     - 	/* The rest are the same as the parent */
     - 	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, 0,
     - 		    parent, target, 0);
     ++	if (xdi_diff_process(&sb->revs->diffopt, parent->path,
     ++			     &file_p, &file_o, NULL, NULL, &xpp, &xecfg, &ecb)
     ++	    == DIFF_PROCESS_ERROR)
     + 		die("unable to generate diff (%s -> %s)",
     + 		    oid_to_hex(&parent->commit->object.oid),
     + 		    oid_to_hex(&target->commit->object.oid));
     +
     + ## diff-process.c ##
     +@@
     + #include "sub-process.h"
     + #include "pkt-line.h"
     + #include "strbuf.h"
     ++#include "xdiff-interface.h"
     + #include "xdiff/xdiff.h"
     + 
     + #define CAP_HUNKS (1u << 0)
     +@@ diff-process.c: enum diff_process_result diff_process_fill_hunks(
     + 	}
     + 	return DIFF_PROCESS_SKIP;
     + }
     ++
     ++enum diff_process_result xdi_diff_process(
     ++		struct diff_options *diffopt,
     ++		const char *path,
     ++		mmfile_t *file_a,
     ++		mmfile_t *file_b,
     ++		const struct object_id *oid_a,
     ++		const struct object_id *oid_b,
     ++		xpparam_t *xpp,
     ++		xdemitconf_t *xecfg,
     ++		xdemitcb_t *ecb)
     ++{
     ++	enum diff_process_result res;
     ++
     ++	/*
     ++	 * Consult the diff process, then run xdiff either constrained to
     ++	 * the tool's hunks or, when the process does not apply, computing
     ++	 * the diff itself as a fallback.  EQUIVALENT short-circuits: the
     ++	 * caller decides what "no change" means for it (drop the commit,
     ++	 * skip the file, ...), so xdiff is not run.
     ++	 *
     ++	 * A SKIP/ERROR from the process just selects the builtin path
     ++	 * (its warning, if any, was already emitted), so the result then
     ++	 * reflects whether xdiff itself succeeded, not the process.
     ++	 */
     ++	res = diff_process_fill_hunks(diffopt, path, file_a, file_b,
     ++				      oid_a, oid_b, xpp);
     ++	if (res == DIFF_PROCESS_EQUIVALENT)
     ++		return res;
     ++
     ++	res = xdi_diff(file_a, file_b, xpp, xecfg, ecb) < 0
     ++		? DIFF_PROCESS_ERROR : DIFF_PROCESS_OK;
     ++
     ++	FREE_AND_NULL(xpp->external_hunks);
     ++	xpp->external_hunks_nr = 0;
     ++	return res;
     ++}
     +
     + ## diff-process.h ##
     +@@ diff-process.h: enum diff_process_result diff_process_fill_hunks(
     + 		const struct object_id *oid_b,
     + 		xpparam_t *xpp);
     + 
     ++/*
     ++ * Process-aware xdi_diff(): consult the diff process for 'path', then
     ++ * run xdiff either constrained to the tool's hunks or computing the
     ++ * diff itself when the process does not apply or fails.  Frees any
     ++ * hunks it obtained before returning.
     ++ *
     ++ * Returns DIFF_PROCESS_EQUIVALENT (without running xdiff) when the tool
     ++ * reports the blobs equal, so the caller can drop or skip the change;
     ++ * DIFF_PROCESS_OK when xdiff ran (on tool hunks or builtin); and
     ++ * DIFF_PROCESS_ERROR if xdiff itself errored.
     ++ *
     ++ * The caller fills xpp (flags, ignore_regex, anchors) and xecfg/ecb as
     ++ * for a direct xdi_diff() call.  oid_a/oid_b are forwarded to
     ++ * diff_process_fill_hunks() (see there).
     ++ */
     ++enum diff_process_result xdi_diff_process(
     ++		struct diff_options *diffopt,
     ++		const char *path,
     ++		mmfile_t *file_a,
     ++		mmfile_t *file_b,
     ++		const struct object_id *oid_a,
     ++		const struct object_id *oid_b,
     ++		xpparam_t *xpp,
     ++		xdemitconf_t *xecfg,
     ++		xdemitcb_t *ecb);
     ++
     + #endif /* DIFF_PROCESS_H */
      
       ## t/t4080-diff-process.sh ##
     -@@ t/t4080-diff-process.sh: test_expect_success 'diff process skipped when tool omits capability' '
     +@@ t/t4080-diff-process.sh: test_expect_success 'diff process omits old-oid and new-oid for textconv content
       	test_must_be_empty stderr
       '
       
     @@ t/t4080-diff-process.sh: test_expect_success 'diff process skipped when tool omi
      +	test_grep "$CHANGE" line9 &&
      +	test_path_is_missing backend.log
      +'
     ++
     ++test_expect_success 'blame -w bypasses diff process' '
     ++	test_when_finished "rm -f backend.log" &&
     ++	printf "alpha\nbeta\ngamma\n" >blamew.c &&
     ++	git add blamew.c &&
     ++	git commit -m "add blamew.c" &&
     ++	orig=$(git rev-parse --short HEAD) &&
     ++	printf "alpha\n   beta   \ngamma\n" >blamew.c &&
     ++	git commit -am "reindent beta" &&
     ++	reindent=$(git rev-parse --short HEAD) &&
     ++	# blame -w must ignore the whitespace-only change and attribute
     ++	# beta to the original commit, not the reindent commit.  The tool
     ++	# is never told about -w, so blame must bypass it (not let tool
     ++	# hunks override -w).
     ++	git -c diff.cdiff.process="$BACKEND --mode=whole-file --log=backend.log" \
     ++		blame -w blamew.c >actual &&
     ++	sed -n "2p" actual >line2 &&
     ++	test_grep "$orig" line2 &&
     ++	test_grep ! "$reindent" line2 &&
     ++	test_path_is_missing backend.log
     ++'
      +
       test_done
  -:  ---------- >  8:  c1d02d0e15 diff: consult diff process for --stat counts
  -:  ---------- >  9:  c3c17ba8fc line-log: consult diff process for range tracking

-- 
gitgitgadget
