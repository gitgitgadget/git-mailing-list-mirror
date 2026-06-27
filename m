Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0EB3382C8
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581355; cv=none; b=GLTme0vzhQEadzUkV8my/1VIqkCYBfOvB60PRt/MQ7Ch5zZPtrEV6Y3JSLnkHF5mGvhy2BHlu+925lwI3H6dxWtBe/q4kkO1S3d+1RVtqrqyGFlEFIed0foKu6NZi4H3t0saiyL/2UrdfNUcdp7srJ49F4VlzrXXLiSvcHvw5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581355; c=relaxed/simple;
	bh=1tkkmQhf4Df8/nr5qofAnCcm+ZK7VMVk5BYU3rlzh4g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wk8N6HmL88iP8F1D9KD0zWq2SWW7zzLRX3mVrn+bNhyQdtuVrdifKUoVjofIhPA4OXYsmlkuABVmwnGY1whUS19OUVZNIepptD+H3lgbEmf9DKKbhG0JBWrH8i0KWH/8r494mThNBzxUE6Kpf6pLD+Y2ZN/QUdeTwIYGrXz5ujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiswFQRb; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiswFQRb"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-920fbdffa31so166732185a.3
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581353; x=1783186153; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l66i6ZF5ssNmSsUXgJsJ+50R2EdXFeCXt0HSfJ7Dbw=;
        b=MiswFQRbUDzxgvN8D3qgDT2iO+lDDUfT/NoGeakVkp2lOZZpo/+IPA1z/CzrcWBpbn
         zwvokY2kc6xEaPRBa+SqEI/42IwPA+biT0BGIafWn9WGGXamZ3nL863HFDKOsgMtf1XZ
         9OHp9zyR2kzC3G8v7Un+yb3UDWGtGlflykti8iay0xrQ0VdMPTpUCY1H58ZqiTpFJ7+p
         FYm1FoVfUCtpmJpEHf7Ob1n7Qg6TGWlblEeNW7zJSRafM3SEjuY8Dto25xO/ZhRpc0ay
         4a+ENNt7ReEwR26fmivdVGarPjTT/wPNQ7uA6H9xquO/PBhZj+AI5NkjMTl7xIq+C07h
         c1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581353; x=1783186153;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+l66i6ZF5ssNmSsUXgJsJ+50R2EdXFeCXt0HSfJ7Dbw=;
        b=OU3nu1YagNvHplqR+4tOs0WQIuNe7kRCluhnj3F9AgozT2NU+0x6+C1TPz27YWA8rH
         WHrDbOXVQ5C0mBuhSzgnj6ll4jW4fkr/NisPQVQ7djDkuUF9TD1izVfLDi+VOVbe3ngv
         DXekIprgkxJ94bclfUrCE5+KnuTPwZoj2k/pvkC5S8XB0luN+OkhWiuc1gThqrH9niin
         5r7zEQy2UGl573TsO60Uejk/EoYxLKl+XYsuVC6++rmva2MkxzaUS6+BpMDCLsXAfmBe
         t6OgzwH4cFS5QnzE75GpZM9+ht8rHdnteuXREVuVPSmNJd00NOfx9ya63nw5vAXGtWav
         AKsA==
X-Gm-Message-State: AOJu0YwYI7t+E+vOn0cBYCp8XDJpe3xcwBKfEjFqASBYO/avW+x5qv4a
	0uVQaMCM0ND1lGVGOEA0A+Ue7nbKQv92DXy6OqwtHB2EbFjSA51BuRBGk227WQ==
X-Gm-Gg: AfdE7ckJOrWubUKB6/IF0A58LyV27CpzXq4dve3a0Lb1mhFrkx2xQ7kjHLRwKVfAngX
	iQcJX32igk6tQkUzfWqFInN+fZ0EU6gkUgj9q4kI0Y0dlsPui1LCEan+XWXzpVICrEYu4yR6zQ4
	EVONnon2CHEY26x1fg7h4E+6fWRPuM8OHfLjMmaFWQlsNHZ8fYw4DWWXGDob0RD2ZSMeCyK7RJy
	DryDRpyCp2wNdd1Clw5cImcf9cP7zPi1IaOC0OS2e555vYNvrGHmQOet5JwL3VHWkw5znWI8A5D
	18J3ghSjmGu5GGfSRPTZsGcMxHfUZe6rZiaejnpGcSq4QS/ZsxZbHYoEVVh8voul5fsP4Oakwvq
	laKLieplxu8YztWB1oL/2gNMaocQXVboHr71ywviVnFhKyhUk+jVMs0AunjNnTYoeUGclM0B4U/
	u9GqZQWEDM7LBe6Gs=
X-Received: by 2002:a05:620a:46a0:b0:914:7e9a:2716 with SMTP id af79cd13be357-9293c506503mr1787929885a.38.1782581352626;
        Sat, 27 Jun 2026 10:29:12 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92dc13f0279sm172377485a.3.2026.06.27.10.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:29:12 -0700 (PDT)
Message-Id: <3d0091b549114f6bf32c9fb7626da9fc2583e88b.1782581342.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 17:28:59 +0000
Subject: [PATCH v2 5/7] line-log: support diff stat formats with -L
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

Reuse the line_range_filter in builtin_diffstat() so the stat formats
count only the lines within the tracked range.  When a filepair carries
line_ranges, the filter wraps diffstat_consume() as its output callback,
forwarding only the lines inside the range for counting.
flush_range_hunk() replays buffered content through diffstat_consume(),
which ignores synthetic @@ headers since it only counts '+' and '-'
lines.

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
--numstat already reports the exact per-file counts within the tracked
range.

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
index 72f639b5e7..a111a492b4 100644
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
+	The stat formats count only lines within the tracked range.
+	`--dirstat` is not supported
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
index e9691066de..b9ca336dbc 100755
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
+	# whole-file stats differ from the counts for the tracked range.
+	sed -e "s/F1/F1 + 1/" -e "s/F2/F2 + 2/" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "Modify both functions"
+'
+
+test_expect_success '--numstat counts only lines in tracked range' '
+	# "Modify both functions" changes one line in func1 and one in
+	# func2.  Whole-file numstat would show 2 added, 2 deleted.
+	# numstat for func2 within the tracked range should show only 1 and 1.
+	git log -L:func2:file.c --numstat --format=%s -1 >actual &&
+	test_grep "Modify both functions" actual &&
+	test_grep "^1	1	file.c$" actual &&
+	test_grep ! "^diff --git" actual
+'
+
+test_expect_success '--numstat counts only additions for root commit' '
+	# Root commit creates both func1 (4 lines) and func2 (4 lines).
+	# Whole-file numstat would show 9 lines added.  numstat for func2
+	# within the tracked range should show only 4.
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
+	# line.  Counts cover only the tracked range, as for --numstat above.
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
+	# follows the rename and reports added/removed counts for f within
+	# the tracked range (not whole-file) per commit; the file column flips from
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

