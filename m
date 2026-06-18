Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397C1330666
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806605; cv=none; b=ke0X9ysGuiFL7IRD60oRAMqCNcyCslGmnKSQw+bwLiZ+qUqC2VzYsatvR7IFJdVBoR4rfkw8w7t69bYT9/uGKvAlLMrJbYoOqgMQyxq3h4OPOV+GR/2kpAXD2V1uocM6rsB9MtVJyi1ya7c7CjtBvRzsdoxp6ZR2yfBZLD5pllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806605; c=relaxed/simple;
	bh=YAEMaY26/c2lzPj4h1ZR7973+7GAZM6TLqftaly51zE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PjuoOLGqPEpjxEi/NDGqFkZNdphAWopt48sH9WVSv2ptvutlr59hYfBs8UdpokT0pODYkKFMRIxOVqX5Zpems6eAwdWsJb/afTJCocNzQuNfXG/TEcW+lOdrQW2eZYCl9PMWkoEqV9R6Zi14cHiCGof0aEOCBtOKFeoEvDgqHdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVOFV3uf; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVOFV3uf"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7f69b71f7b2so16400777b3.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781806602; x=1782411402; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTOHBIkWi8sRv1j4Gf1VLZadduZhQaOzjM6GU33UHDU=;
        b=lVOFV3ufzi3E7ykZewLJT6pco48idj92p4493SHcD0MeAPnZ9gM4o55VN3MYGkgSIh
         xAArFL08oA1pYOFpAhHocZWcTwF3z59GBpXQdm4se+OaERnPW2aKG8GYXjZi4TlCXlg0
         TVKalD5OrgTrglP4y5pdCqNnndNqO5YQikyO/Xx5u20iolmIL4qvjjUDbV97UO7fs/TM
         KEg4MO6eFrVGM0AsWnqrWBERow9tj0mEtsyGEkb48A0cCyj69gX7zM1tszQZsd45fcKp
         /qMnpTk/o4IlGUf3NOPd93fCGhJaIZGClUL9NeGRLNbcVmlsimE1nsaK7+c5kccMvZDo
         HHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806602; x=1782411402;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dTOHBIkWi8sRv1j4Gf1VLZadduZhQaOzjM6GU33UHDU=;
        b=s5hg8386cjzFjDLh5jl9OxV5qsFGt29EmYZViVlnRIIQR1hSA5Kd7lBGL/cILeq2dO
         pr+1C+iSo0n22T0AmmBakxY+nI8SmmNyUTpe9bk5BHN3/fAkAsijOIZxKD9xTyPEEDpT
         OQj3F8n5mPIyE7yVlaFnLNxNCIgH/HC8ajFnC/AqTWaZ5uPRM2cluDQMjgB+ef4xqR/0
         b3gvOLhcYsaqpLEZnSd3OwJHDuxRnse6WKby/GVAR3N350tmxi5lYv4LNGOQ1mJHm1Mw
         0NFmDT/dCjRNRDk+PZVFyluG1/JyFfheKNMor+QsgPg5nCgThxQyztlqA8qKWdHTDcB9
         AHPQ==
X-Gm-Message-State: AOJu0YwBRoxHwMDHS4sQDW7nEm/avIiKeGxhAACrsF0qzKtn7aUKAlrq
	nC14cPYMNwsP7iWtYxeiz5QPITbuWfXkD3Q2N0AKiZVtcV7whUkYPlbUDouz0w==
X-Gm-Gg: AfdE7cllYpu2d4nm6fIN5IYGOpKuJJP9dIDD/DhSei1KJBY/pw4KL1RKlr2ihVTXD1z
	i0wKR0+aT+cCpyOXIc/fmjxYcJNQalatHm8q05w/dgjMSKah2Ep15IeNW3j3dCWxmbA3d96rdBa
	YwmVRfaVXY/2EmqXUQF1t+nZFv/rRQEwy3tcTo7pacNUacVOw/fRgIxYipvQhEUFGN/iA49CKJj
	+/Ee8QzO3uiLWiUdkUsWPVksVcniLxAzUpaw6oywF1Ig5EdXEmxHhf15F2eUz8hUUx7FJW7yqZ3
	SIP9S2G8eWDW5j3m2HA4zvsjF7uWJX6a5s3/beWA5FSVTRyjwhCXcOOmXTYe+wzLlvWyCMc7xWN
	DLMwJTF+BRbNnT9yGgRYvfVOcZgEBpqje3uRam8z4bla8TvasILlcZKzZkgOPD519zDGntGK2ib
	Mu5G+FQS6hutLJKA==
X-Received: by 2002:a05:690c:6e01:b0:7ff:1e22:d187 with SMTP id 00721157ae682-7ff1e22d30cmr85771447b3.37.1781806602047;
        Thu, 18 Jun 2026 11:16:42 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f21a20b6sm101041066d6.21.2026.06.18.11.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:16:41 -0700 (PDT)
Message-Id: <a70d861d27a13459bab34f6681b3ccfe2f20d0d8.1781806593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 18:16:30 +0000
Subject: [PATCH 5/7] line-log: support diff stat formats with -L
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
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Reuse the line_range_filter in builtin_diffstat() to produce
range-scoped statistics.  When a filepair carries line_ranges, the
filter wraps diffstat_consume() as its output callback, forwarding only
in-range lines for counting.  flush_range_hunk() replays buffered
content through diffstat_consume(), which ignores synthetic @@ headers
since it only counts '+' and '-' lines.

Expand the output format allowlist in setup_revisions() to accept
--stat, --numstat, and --shortstat with -L.

Leave --dirstat out of the allowlist so it is rejected like any other
unsupported format.  Its default mode counts each file's whole-file
byte damage via diffcore_count_changes(), outside the line-based
pipeline that the -L filter scopes, so bare --dirstat cannot honor the
tracked range.  The --dirstat=lines mode could: it aggregates the same
per-file line counts as --numstat, which -L already scopes.  But
accepting only that sub-mode while bare --dirstat keeps erroring is a
confusing split, so the whole format is deferred to a follow-up;
--numstat already reports the exact range-scoped per-file counts.

Also drop "yet" from the generic -L rejection message ("does not
yet support the requested diff format").  Some rejected formats do
not fit a line range at all, so "yet" wrongly implied they are all
just awaiting support.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/line-range-options.adoc |  12 ++-
 diff.c                                |  13 ++-
 revision.c                            |   6 +-
 t/t4211-line-log.sh                   | 150 ++++++++++++++++++++++----
 4 files changed, 155 insertions(+), 26 deletions(-)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index 72f639b5e7..1a25f55bb1 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -9,10 +9,14 @@
 	_<start>_ and _<end>_ (or _<funcname>_) must exist in the starting revision.
 	You can specify this option more than once. Implies `--patch`.
 	Patch output can be suppressed using `--no-patch`.
-	Non-patch diff formats `--raw`, `--name-only`, `--name-status`,
-	and `--summary` are supported.  Diff stat formats
-	(`--stat`, `--numstat`, `--shortstat`, `--dirstat`) are not
-	currently implemented.
+	The following non-patch diff formats are supported: `--raw`,
+	`--name-only`, `--name-status`, `--summary`,
+	`--stat`, `--numstat`, and `--shortstat`.
+	The stat formats show range-scoped counts: only lines within
+	the tracked range are counted.  `--dirstat` is not supported
+	with `-L`: it summarizes change as each directory's share of
+	the total churn, not as counts for the tracked lines.  Use
+	`--numstat` for exact per-file counts within the range.
 +
 Patch formatting options such as `--word-diff`, `--color-moved`,
 `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
diff --git a/diff.c b/diff.c
index 6233a96bf0..026fafeb90 100644
--- a/diff.c
+++ b/diff.c
@@ -4289,7 +4289,18 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
-		if (xdi_diff_outf(&mf1, &mf2, NULL,
+
+		if (p->line_ranges) {
+			struct line_range_filter lr_filter;
+
+			line_range_filter_init(&lr_filter, p->line_ranges,
+					       diffstat_consume, diffstat);
+
+			if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
+						   &xpp, &xecfg))
+				die("unable to generate diffstat for %s",
+				    one->path);
+		} else if (xdi_diff_outf(&mf1, &mf2, NULL,
 				  diffstat_consume, diffstat, &xpp, &xecfg))
 			die("unable to generate diffstat for %s", one->path);
 
diff --git a/revision.c b/revision.c
index 6a8101e8b7..2c76e15778 100644
--- a/revision.c
+++ b/revision.c
@@ -3193,8 +3193,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	     (revs->diffopt.output_format &
 	      ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT |
 		DIFF_FORMAT_RAW | DIFF_FORMAT_NAME |
-		DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY))))
-		die(_("-L does not yet support the requested diff format"));
+		DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY |
+		DIFF_FORMAT_NUMSTAT | DIFF_FORMAT_DIFFSTAT |
+		DIFF_FORMAT_SHORTSTAT))))
+		die(_("-L does not support the requested diff format"));
 
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index e9691066de..af37bd532f 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -176,24 +176,15 @@ test_expect_success '--name-status shows status and path' '
 	test_grep ! "^@@" actual
 '
 
-test_expect_success '--stat is not yet supported with -L' '
-	test_must_fail git log -L1,24:b.c --stat 2>err &&
-	test_grep "does not yet support" err
-'
-
-test_expect_success '--numstat is not yet supported with -L' '
-	test_must_fail git log -L1,24:b.c --numstat 2>err &&
-	test_grep "does not yet support" err
-'
-
-test_expect_success '--shortstat is not yet supported with -L' '
-	test_must_fail git log -L1,24:b.c --shortstat 2>err &&
-	test_grep "does not yet support" err
-'
-
-test_expect_success '--dirstat is not yet supported with -L' '
+test_expect_success '--dirstat is not supported with -L' '
+	# --dirstat is not supported with -L: its default mode measures
+	# whole-file change, not the tracked lines, and the
+	# --dirstat=lines variant is deferred too, so both forms are
+	# rejected like any other unsupported format.
 	test_must_fail git log -L1,24:b.c --dirstat 2>err &&
-	test_grep "does not yet support" err
+	test_grep "does not support" err &&
+	test_must_fail git log -L1,24:b.c --dirstat=lines 2>err &&
+	test_grep "does not support" err
 '
 
 test_expect_success 'setup for checking fancy rename following' '
@@ -887,9 +878,9 @@ test_expect_success '-L with -S suppresses non-matching commits' '
 	test_cmp expect actual
 '
 
-test_expect_success '--full-diff is not yet supported with -L' '
+test_expect_success '--full-diff is not supported with -L' '
 	test_must_fail git log -L1,24:b.c --full-diff 2>err &&
-	test_grep "does not yet support" err
+	test_grep "does not support" err
 '
 
 test_expect_success '-L --oneline has no extra blank line before diff' '
@@ -900,6 +891,127 @@ test_expect_success '-L --oneline has no extra blank line before diff' '
 	test_grep "^diff --git" line2
 '
 
+test_expect_success 'setup for stat range-scoping tests' '
+	git checkout --orphan stat-scoping &&
+	git reset --hard &&
+	cat >file.c <<-\EOF &&
+	int func1()
+	{
+	    return F1;
+	}
+
+	int func2()
+	{
+	    return F2;
+	}
+	EOF
+	git add file.c &&
+	test_tick &&
+	git commit -m "Add func1() and func2()" &&
+
+	# Modify both functions in a single commit so that
+	# whole-file stats differ from range-scoped stats.
+	sed -e "s/F1/F1 + 1/" -e "s/F2/F2 + 2/" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "Modify both functions"
+'
+
+test_expect_success '--numstat counts only lines in tracked range' '
+	# "Modify both functions" changes one line in func1 and one in
+	# func2.  Whole-file numstat would show 2 added, 2 deleted.
+	# Range-scoped numstat for func2 should show only 1 and 1.
+	git log -L:func2:file.c --numstat --format=%s -1 >actual &&
+	test_grep "Modify both functions" actual &&
+	test_grep "^1	1	file.c$" actual &&
+	test_grep ! "^diff --git" actual
+'
+
+test_expect_success '--numstat counts only additions for root commit' '
+	# Root commit creates both func1 (4 lines) and func2 (4 lines).
+	# Whole-file numstat would show 9 lines added.  Range-scoped
+	# numstat for func2 should show only 4.
+	git log -L:func2:file.c --numstat --format=%s >actual &&
+	test_grep "Add func1() and func2()" actual &&
+	test_grep "^4	0	file.c$" actual &&
+	test_grep ! "^diff --git" actual
+'
+
+test_expect_success '--stat counts only lines in tracked range' '
+	git log -L:func2:file.c --stat --format=%s -1 >actual &&
+	test_grep "Modify both functions" actual &&
+	test_grep "file.c |" actual &&
+	test_grep "1 insertion" actual &&
+	test_grep "1 deletion" actual &&
+	test_grep ! "^diff --git" actual
+'
+
+test_expect_success '--shortstat counts only lines in tracked range' '
+	# --shortstat prints only the summary line: no per-file "file.c |"
+	# line.  Counts are range-scoped as for --numstat above.
+	git log -L:func2:file.c --shortstat --format=%s -1 >actual &&
+	test_grep "Modify both functions" actual &&
+	test_grep "1 insertion" actual &&
+	test_grep "1 deletion" actual &&
+	test_grep ! "file.c |" actual &&
+	test_grep ! "^diff --git" actual
+'
+
+test_expect_success '--numstat across renames and multiple commits' '
+	# parallel-change carries the tracked function f across an a.c -> b.c
+	# rename and a merge of two parallel histories.  With -M, --numstat
+	# follows the rename and reports range-scoped (not whole-file)
+	# added/removed counts for f per commit; the file column flips from
+	# b.c to a.c at the rename as the walk goes back in time.  Commits
+	# that do not change the range of f emit no row (the merge and the
+	# pure file-move produce nothing), so there are fewer rows than
+	# commits.
+	git checkout parallel-change &&
+	git log -M -L ":f:b.c" --format= --numstat >actual &&
+	cat >expect <<-\EOF &&
+	1	1	b.c
+	1	1	a.c
+	1	1	a.c
+	1	1	a.c
+	1	0	a.c
+	13	0	a.c
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '-L multiple ranges with --numstat excludes untracked change' '
+	git checkout --orphan multi-range &&
+	git reset --hard &&
+	cat >m.c <<-\EOF &&
+	int func1()
+	{
+	    return F1;
+	}
+
+	int func2()
+	{
+	    return F2;
+	}
+
+	int func3()
+	{
+	    return F3;
+	}
+	EOF
+	git add m.c &&
+	test_tick &&
+	git commit -m "add m.c" &&
+	# Change all three functions but track only func1 and func2.
+	# Whole-file numstat would be 3 3; a 2 2 result proves the
+	# untracked func3 change is excluded and the two ranges just sum.
+	sed -e "s/F1/F1 + 1/" -e "s/F2/F2 + 2/" -e "s/F3/F3 + 3/" m.c >tmp &&
+	mv tmp m.c &&
+	git commit -a -m "Modify all three functions" &&
+	git log -L:func1:m.c -L:func2:m.c --numstat --format=%s -1 >actual &&
+	test_grep "Modify all three functions" actual &&
+	test_grep "^2	2	m.c$" actual &&
+	test_grep ! "^3	3	m.c$" actual
+'
+
 test_expect_success '--summary shows new file on root commit' '
 	git checkout parent-oids &&
 	git log -L:func2:file.c --summary --format= >actual &&
-- 
gitgitgadget

