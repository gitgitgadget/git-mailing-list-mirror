Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606F38B7D7
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411933; cv=none; b=plM/V1qigjX6zjHowpiaDZJZ85a7rklXj7jRgnR9isg3SQlG0S5Q3dUmlpA3vqi45ieE9tm0XdUXxW2n9IRa9JrCFnvkAvfB/ukHqXRizQNOC51vV/gOmkDbCJrsLKQNPsP4lIAIBhQy6ewL6QTMizBd6AOcJJgbbbCwfI5eMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411933; c=relaxed/simple;
	bh=yxVeBech+dT2yauOEZI44gtvs+/G+eu8eaIZRG+U7YY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KYu6y/5mdEI2XDrvQneU7Pg6DPfrhUa0+B2+xnRzacEYQo6/oL2+m3d2G1Wg8AN1eIcAnxHIt/1EZyyT/6d77pWAUMJzHq5K/97JGSX+wsL69Cfaj0XFTgFSCyXwqX3834awcblWEZInaWzrUYvvHW/hRwzNy2hqbRyGnYyUD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtN6qLlF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtN6qLlF"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90ccbed6edcso29532006d6.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 22:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411929; x=1789016729; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+7VCNu9N52+3PTnJC/w7SteIyVAn6t4bQoWh1VxYP/w=;
        b=mtN6qLlF/D1XN8GEKG1hqQ1AFP/91spm0jo7hykOafikN6PIYcTIl2Wve5gl4rE16k
         4SkYF1xgvzvig2KskwafXSG4Z/x8wWgctyAxKC427FP2L50BxCcP7/M2VxvMiFkgcS8A
         dTi3VrCVAKT8qIKEXfw7GHf3dLsni/jPz97zEgRjnRWEJFhizIMPso83AkAjqJNb+Y3r
         JYDr8Oek472a48QGpzR5DVY/Csyf4S9kMa5E87eGwE8KD/URhl/p1CIGLJ8hCm9PeCEZ
         9UiXNnWfRFHOI2kbQVEHhrAvinBaDLnxLYTm2RjxDmNIgcJAKCRy2jsxNj/06pUDJAzV
         bHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411929; x=1789016729;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+7VCNu9N52+3PTnJC/w7SteIyVAn6t4bQoWh1VxYP/w=;
        b=PaPtO80FcITm27Pz/bWMlGYiRF7wHFAWg1tEpXUsZzn8dexDq8eKwK3Q776tyXPlLB
         GyL+rqS8TTBxfkgs9iV/ynVrZLSWk2NtQ6j/BLqp41VE6tOwkwVXjAYLyt1fwtbEJUPf
         +Pq3xoNCbqM1AdSzBWnxYmTB0LWWMr+Pbl02W0D1qnER4eFBtf4NA1gDjMUS+Z0atYqx
         eUyDSxL9xjdCSFNZ3Mam+G2kM+DaEuWXOOq4oWTafcx65pEzctfVBv6MNkMTCS2tJPDF
         RRxmb5ZyC6iC997OsuABvSsdtg+YXaO3ZMypHU2WYQhfsJPocUo1RXEQhHROp7/gr5ma
         9M9A==
X-Gm-Message-State: AFuF++kAfZTORcHMnTtccu7e3FgZmiYJBV4ZE6ahDJHPbYGFbyU0QE30
	6rp/E+BYf0fEGiJ21XZKczPEcod8wIegDKJG9aJj3ORuW1ioc/RxWfY8aSZCBQZ+
X-Gm-Gg: AYBFou09k7T/uebR12U5CUCworYWuTEQ2W4F1mIctqOsitMTw+rAl/oMX6csRS/5tG6
	KAuBq006Zxz/dDsR+1DAKJbckkEunwm/QrKqC8DTKwLnGmX4R0YQ8/IDZYWDAvnWPHa4RzCpYtK
	d6HzaEXSdDillPX79dl/Sm4tCaIKJgXoEHNwRSfb5T1lYak5vCS2fqacSG8I1dVh5i/bHMip8kH
	ZV2htgbeGhDC52gGrxKoeBzmgAVgS8VLftiDl98Pm9z3b50a33/ivCfFd6hv0u3Jwlgf6yYMv8T
	yk5vuLBAcdT3CgVJZSj5713qR9OMH4piRpSUYKD0JjxTqjmWNInWOIEHNkCq5S73kOojazhCHJ+
	8rnwuLjnIkED87IR+eHMub+6LRVP9IEP/kc7x4Qm51tqLywt3xgoNsn/vTFc4J+dloZQYiudIk0
	PxYp7bcxvmcf/mI9Z4+V9tTvOkRzeNyg46QRhWPDjtOA3AUfMYfj77en/s17J2gDb2
X-Received: by 2002:a05:6214:809b:b0:910:3453:505f with SMTP id 6a1803df08f44-91034535374mr46510906d6.33.1788411928889;
        Wed, 02 Sep 2026 22:05:28 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.140.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec7608sm34446796d6.26.2026.09.02.22.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 22:05:28 -0700 (PDT)
Message-Id: <f1f5af8f77694ec4f775bcf33f17ed2cd00670e3.1788411919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 05:05:18 +0000
Subject: [PATCH v3 6/7] diff: support --check with -L line ranges
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Reuse the line_range_filter in builtin_checkdiff() so -L supports
the --check option.

Add orig_hunk_fn field similar to orig_line_fn that forwards
xdiff_emit_hunk_fn calls when we flush filtered hunks. This is necessary
because --check relies on receiving calls to its checkdiff_consume_hunk
function for managing state.

Document and ungate the newly enabled option, and add tests verifying
the new behavior.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/line-range-options.adoc | 11 ++--
 diff.c                                | 43 +++++++++++++-
 revision.c                            |  2 +-
 t/t4211-line-log.sh                   | 83 +++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 9 deletions(-)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index b3e8b5c62c..4a7ab97d75 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -10,11 +10,12 @@
 	You can specify this option more than once. Implies `--patch`.
 	Patch output can be suppressed using `--no-patch`.
 	The following non-patch diff formats are supported: `--raw`,
-	`--name-only`, `--name-status`, `--summary`, `--stat`, `--numstat`,
-	and `--shortstat`. The stat formats count only lines within the tracked
-	range. `--dirstat` is not supported with `-L`: it summarizes change as each
-	directory's share of the total churn, not as counts for the tracked lines.
-	Use `--numstat` for exact per-file counts within the range.
+	`--name-only`, `--name-status`, `--summary`, `--check`, `--stat`,
+	`--numstat`, and `--shortstat`. The stat formats count only lines
+	within the tracked range. `--dirstat` is not supported with `-L`: it
+	reports how change is distributed across directories over whole files,
+	which is not meaningful for line ranges within a file. Use `--numstat`
+	for exact per-file counts within the range.
 +
 Patch formatting options such as `--word-diff`, `--color-moved`,
 `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
diff --git a/diff.c b/diff.c
index 4a30d7b631..49b6732c81 100644
--- a/diff.c
+++ b/diff.c
@@ -614,6 +614,7 @@ struct emit_callback {
  */
 struct line_range_filter {
 	xdiff_emit_line_fn orig_line_fn;
+	xdiff_emit_hunk_fn orig_hunk_fn;
 	void *orig_cb_data;
 	const struct range_set *range_sets_to_filter_by;
 	unsigned int range_set_idx;
@@ -2577,6 +2578,13 @@ static void flush_range_hunk(struct line_range_filter *filter)
 			       filter->accumulating_hunk.func_name,
 			filter->accumulating_hunk.func_name_len);
 
+	if (filter->orig_hunk_fn)
+		filter->orig_hunk_fn(filter->orig_cb_data,
+				filter->accumulating_hunk.old_begin, old_count,
+				filter->accumulating_hunk.new_begin, new_count,
+				filter->accumulating_hunk.func_name,
+		       filter->accumulating_hunk.func_name_len);
+
 	filter->ret = filter->orig_line_fn(filter->orig_cb_data, hdr.buf, hdr.len);
 	strbuf_release(&hdr);
 
@@ -4203,11 +4211,23 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	diff_free_filespec_data(two);
 }
 
+static int idx_in_ranges(const struct range_set *ranges, long idx)
+{
+	unsigned int i;
+
+	for (i = 0; i < ranges->nr; i++)
+		if (idx >= ranges->ranges[i].start &&
+		    idx < ranges->ranges[i].end)
+			return 1;
+	return 0;
+}
+
 static void builtin_checkdiff(const char *name_a, const char *name_b,
 			      const char *attr_path,
 			      struct diff_filespec *one,
 			      struct diff_filespec *two,
-			      struct diff_options *o)
+			      struct diff_options *o,
+			      const struct range_set *line_ranges)
 {
 	mmfile_t mf1, mf2;
 	struct checkdiff_t data;
@@ -4247,7 +4267,19 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		memset(&xecfg, 0, sizeof(xecfg));
 		xecfg.ctxlen = 1; /* at least one context line */
 		xpp.flags = 0;
-		if (xdi_diff_outf(&mf1, &mf2, checkdiff_consume_hunk,
+
+		if (line_ranges) {
+			struct line_range_filter lr_filter;
+
+			line_range_filter_init(&lr_filter, line_ranges,
+					       checkdiff_consume, &data);
+			lr_filter.orig_hunk_fn = checkdiff_consume_hunk;
+
+			if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
+						   &xpp, &xecfg))
+				die("unable to generate checkdiff for %s",
+				    one->path);
+		} else if (xdi_diff_outf(&mf1, &mf2, checkdiff_consume_hunk,
 				  checkdiff_consume, &data,
 				  &xpp, &xecfg))
 			die("unable to generate checkdiff for %s", one->path);
@@ -4260,6 +4292,10 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 			blank_at_eof = ecbdata.blank_at_eof_in_postimage;
 
+			if (blank_at_eof && line_ranges &&
+			    !idx_in_ranges(line_ranges, blank_at_eof - 1))
+				blank_at_eof = 0;
+
 			if (blank_at_eof) {
 				static char *err;
 				if (!err)
@@ -5055,7 +5091,8 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	diff_fill_oid_info(p->one, o->repo->index);
 	diff_fill_oid_info(p->two, o->repo->index);
 
-	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
+	builtin_checkdiff(name, other, attr_path, p->one, p->two, o,
+			  p->line_ranges);
 }
 
 void repo_diff_setup(struct repository *r, struct diff_options *options)
diff --git a/revision.c b/revision.c
index 4639c0df8e..4cc0d032bc 100644
--- a/revision.c
+++ b/revision.c
@@ -3231,7 +3231,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		DIFF_FORMAT_RAW | DIFF_FORMAT_NAME |
 		DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY |
 		DIFF_FORMAT_NUMSTAT | DIFF_FORMAT_DIFFSTAT |
-		DIFF_FORMAT_SHORTSTAT))))
+		DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_CHECKDIFF))))
 		die(_("-L does not support the requested diff format"));
 
 	if (revs->expand_tabs_in_log < 0)
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 4e8f71c289..2a542aa643 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -924,4 +924,87 @@ test_expect_success 'get_commit_action() does not mutate a not-yet-walked commit
 	)
 '
 
+test_expect_success 'setup for --check test' '
+	git checkout --orphan check-test &&
+	git reset --hard &&
+	cat >check.c <<-\EOF &&
+	void tracked()
+	{
+	    return;
+	}
+
+	void other()
+	{
+	    return;
+	}
+	EOF
+	git add check.c &&
+	test_tick &&
+	git commit -m "add check.c" &&
+	sed "s/return;/return; /" check.c >check.c.tmp &&
+	mv check.c.tmp check.c &&
+	git commit -a -m "introduce trailing whitespace"
+'
+
+test_expect_success '--check is limited to tracked ranges and reports real file line numbers' '
+	test_must_fail git log -L:tracked:check.c --check --format= >raw &&
+	grep -E ":[0-9]+:" raw >actual &&
+	echo "check.c:3: trailing whitespace." >expect &&
+	test_cmp expect actual &&
+
+	test_must_fail git log -L:tracked:check.c -L:other:check.c \
+		--check --format= >raw &&
+	grep -E ":[0-9]+:" raw >actual &&
+	cat >expect <<-\EOF &&
+	check.c:3: trailing whitespace.
+	check.c:8: trailing whitespace.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--check reports each error at its real line across a gap in one range' '
+	git checkout --orphan check-gap &&
+	git reset --hard &&
+	cat >gap.c <<-\EOF &&
+	void tracked()
+	{
+	    int a = 1;
+	    int b = 2;
+	    int c = 3;
+	    int d = 4;
+	    int e = 5;
+	    int g = 7;
+	    return;
+	}
+	EOF
+	git add gap.c &&
+	test_tick &&
+	git commit -m "add gap.c" &&
+	sed -e "s/int a = 1;/int a = 1; /" -e "s/int g = 7;/int g = 7; /" gap.c >tmp &&
+	mv tmp gap.c &&
+	git commit -a -m "ws errors with a gap" &&
+	test_must_fail git log -L:tracked:gap.c --check --format= >raw &&
+	grep -E ":[0-9]+:" raw >actual &&
+	cat >expect <<-\EOF &&
+	gap.c:3: trailing whitespace.
+	gap.c:8: trailing whitespace.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--check does not report blank-at-eof outside the range' '
+	git checkout --orphan check-eof &&
+	git reset --hard &&
+	printf "void tracked()\n{\n    return;\n}\n\nint tail = 1;\n" >eof.c &&
+	git add eof.c &&
+	test_tick &&
+	git commit -m "add eof.c" &&
+	printf "void tracked()\n{\n    return; \n}\n\nint tail = 1;\n\n" >eof.c &&
+	git commit -a -m "ws in range, blank at eof out of range" &&
+	test_must_fail git log -L:tracked:eof.c --check --format= >raw &&
+	grep -E ":[0-9]+:" raw >actual &&
+	echo "eof.c:3: trailing whitespace." >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

