Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B51BA285
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891096; cv=none; b=nBaOi5Naz0Uh3Nre+fCW+IQc4vZmKmUfB9E4Lujm1oUOXwfb7M7t5IUsxeoqSK1NeL9Y1PnxDJrmBTWwv9fF+I4M0eyE3jdSIULlzyly6fDMDph1Yr5VIwv283P/ReZsFJAsFm3NfmoIsmftwln7xIaAhCSP3BlJx0R0EsFtZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891096; c=relaxed/simple;
	bh=/3tru9nUU86DfWrnphmXIPp1AalQIsfq42SmyUWsJ2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/fL8/YrTcXvee9yEANCh5p6d7oDd6cAEYnyfo2VZ00cpkDjzfZJWzUT1ZYm7JdNf0tQIbokzIJ/A70SlNt87c8K7dk1A88fIOctoNrSrJPlzN0rd/RaYNJjZRCI3y6UrAfo0trt80dCmqBI/xCTHR+Lm+pK3H5zPQw3C2y0poI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmDuJvBf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmDuJvBf"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2054e22ce3fso37784815ad.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725891094; x=1726495894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+jOuBnZNVhZ5bbtrY6gyfWJ1D6OGTgorY0sA7Ze+uw=;
        b=SmDuJvBfF5RijWrphd6eWhfU3lS5esfBFSKu2QGf7FbwdBRm23z6oussqA5OrXohf0
         IBDTZDAIKVYZvSEsVCf4wNH1fdAW1dt3KPiRHsFgCu/XMeXdKBXfYnza1XxOvTM3uFLx
         382ivi8+PFZySk+i5VwAfxApiErRSIgOF0N/Bv21tYcUVZriH/lDwWoEM+H1sBTpsWqh
         Lw86izoQ9vEEGcwgZDH1WWHnbr0uxoxP3SQ0aDb3PAShq8fN6dgKPY0YOYpSCC9xiOXO
         +mIxw7CJnvAwQXZuVbMNA/RXOWuKRLmuKbhiseTS6d9OUkH2NCrql8PdofetWefR39Yc
         WTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725891094; x=1726495894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+jOuBnZNVhZ5bbtrY6gyfWJ1D6OGTgorY0sA7Ze+uw=;
        b=Hyz1LAtKeFaeJdO1PxggNgj//EPEszzMTu25Sxvck3jsVb0cRjgb4VmQuczsZV0y3d
         qUPdkxnx5SSliyefd9PLKJ4DvxJmbqPsargVfLcLqZOa+dplb9hyBDQ6eoiK/k89WOUT
         dn2Zz5lGM/RT5pL2LzbDiDsFGZ/AAy0256Cvv8B4gk2KXehCHlL1wWl9tbGWH7lLHsQP
         FaiwvMbmhWjpQFgyTLxAz47ZBk6T+nNhS2nm5LMxCSGNMVlUUPcv9X+Pwr8neuWXElXw
         ZujLeEYr9qVNX80+pzKoY0XyeNZ5g/Y1olfZjJzwtS5X2gqDoGoVQspYJwQYSEcW0Dlj
         bgCA==
X-Gm-Message-State: AOJu0YyxWnExBII/sPhIWCKVQXYqZP9Y2A0BpVxwOOrkV28o1FBPcMJ/
	WN3paBG0J+wBhvLnpxqtIe1WJCvay+V09qIsYKnlxsvl5cbIEHyTtF9L9A==
X-Google-Smtp-Source: AGHT+IEt7QeYfaxDNNnwdIbLsB0mNOKEXrCByNRi1oAG4P4i1XYSjgAnen6jfTxTOyMdqWRZOqryuA==
X-Received: by 2002:a17:903:606:b0:206:98c8:4a71 with SMTP id d9443c01a7336-206f05f688cmr75388235ad.38.1725891093504;
        Mon, 09 Sep 2024 07:11:33 -0700 (PDT)
Received: from panther.lan ([2607:fa18:92fe:92b::47f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eef1e7sm34251735ad.120.2024.09.09.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:11:32 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org,
	gitster@pobox.com,
	bert.wesarg@googlemail.com
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 1/1] apply: support --ours, --theirs, and --union for three-way merges
Date: Mon,  9 Sep 2024 08:10:58 -0600
Message-ID: <20240909141109.3102-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909141109.3102-1-alexhenrie24@gmail.com>
References: <20240906044222.4881-1-alexhenrie24@gmail.com>
 <20240909141109.3102-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--ours, --theirs, and --union are already supported in `git merge-file`
for automatically resolving conflicts in favor of one version or the
other, instead of leaving conflict markers in the file. Support them in
`git apply -3` as well because the two commands do the same kind of
file-level merges.

In case in the future --ours, --theirs, and --union gain a meaning
outside of three-way-merges, they do not imply --3way but rather must be
specified alongside it.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-apply.txt |  9 ++++++++-
 apply.c                     | 20 +++++++++++++++++--
 apply.h                     |  1 +
 t/t4108-apply-threeway.sh   | 40 +++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 9cce68a38b..dd4a61ef28 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,7 +9,8 @@ git-apply - Apply a patch to files and/or to the index
 SYNOPSIS
 --------
 [verse]
-'git apply' [--stat] [--numstat] [--summary] [--check] [--index | --intent-to-add] [--3way]
+'git apply' [--stat] [--numstat] [--summary] [--check]
+	  [--index | --intent-to-add] [--3way] [--ours | --theirs | --union]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
@@ -92,6 +93,12 @@ OPTIONS
 	When used with the `--cached` option, any conflicts are left at higher stages
 	in the cache.
 
+--ours::
+--theirs::
+--union::
+	Instead of leaving conflicts in the file, resolve conflicts favouring
+	our (or their or both) side of the lines. Requires --3way.
+
 --build-fake-ancestor=<file>::
 	Newer 'git diff' output has embedded 'index information'
 	for each blob to help identify the original version that
diff --git a/apply.c b/apply.c
index 6e1060a952..cc885f8fec 100644
--- a/apply.c
+++ b/apply.c
@@ -3561,6 +3561,7 @@ static int three_way_merge(struct apply_state *state,
 			   const struct object_id *theirs)
 {
 	mmfile_t base_file, our_file, their_file;
+	struct ll_merge_options merge_opts = LL_MERGE_OPTIONS_INIT;
 	mmbuffer_t result = { NULL };
 	enum ll_merge_result status;
 
@@ -3573,12 +3574,13 @@ static int three_way_merge(struct apply_state *state,
 	read_mmblob(&base_file, base);
 	read_mmblob(&our_file, ours);
 	read_mmblob(&their_file, theirs);
+	merge_opts.variant = state->merge_variant;
 	status = ll_merge(&result, path,
 			  &base_file, "base",
 			  &our_file, "ours",
 			  &their_file, "theirs",
 			  state->repo->index,
-			  NULL);
+			  &merge_opts);
 	if (status == LL_MERGE_BINARY_CONFLICT)
 		warning("Cannot merge binary files: %s (%s vs. %s)",
 			path, "ours", "theirs");
@@ -5151,6 +5153,15 @@ int apply_parse_options(int argc, const char **argv,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &state->threeway,
 			 N_( "attempt three-way merge, fall back on normal patch if that fails")),
+		OPT_SET_INT_F(0, "ours", &state->merge_variant,
+			N_("for conflicts, use our version"),
+			XDL_MERGE_FAVOR_OURS, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "theirs", &state->merge_variant,
+			N_("for conflicts, use their version"),
+			XDL_MERGE_FAVOR_THEIRS, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "union", &state->merge_variant,
+			N_("for conflicts, use a union version"),
+			XDL_MERGE_FAVOR_UNION, PARSE_OPT_NONEG),
 		OPT_FILENAME(0, "build-fake-ancestor", &state->fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
@@ -5190,5 +5201,10 @@ int apply_parse_options(int argc, const char **argv,
 		OPT_END()
 	};
 
-	return parse_options(argc, argv, state->prefix, builtin_apply_options, apply_usage, 0);
+	argc = parse_options(argc, argv, state->prefix, builtin_apply_options, apply_usage, 0);
+
+	if (state->merge_variant && !state->threeway)
+		die(_("--ours, --theirs, and --union require --3way"));
+
+	return argc;
 }
diff --git a/apply.h b/apply.h
index cd25d24cc4..90e887ec0e 100644
--- a/apply.h
+++ b/apply.h
@@ -59,6 +59,7 @@ struct apply_state {
 	struct repository *repo;
 	const char *index_file;
 	enum apply_verbosity apply_verbosity;
+	int merge_variant;
 	char *fake_ancestor;
 	const char *patch_input_file;
 	int line_termination;
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 3211e1e65f..c6302163d8 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -82,6 +82,46 @@ test_expect_success 'apply with --3way with merge.conflictStyle = diff3' '
 	test_apply_with_3way
 '
 
+test_apply_with_3way_favoritism () {
+	apply_arg=$1
+	merge_arg=$2
+
+	# Merging side should be similar to applying this patch
+	git diff ...side >P.diff &&
+
+	# The corresponding conflicted merge
+	git reset --hard &&
+	git checkout main^0 &&
+	git merge --no-commit $merge_arg side &&
+	git ls-files -s >expect.ls &&
+	print_sanitized_conflicted_diff >expect.diff &&
+
+	# should apply successfully
+	git reset --hard &&
+	git checkout main^0 &&
+	git apply --index --3way $apply_arg P.diff &&
+	git ls-files -s >actual.ls &&
+	print_sanitized_conflicted_diff >actual.diff &&
+
+	# The result should resemble the corresponding merge
+	test_cmp expect.ls actual.ls &&
+	test_cmp expect.diff actual.diff
+}
+
+test_expect_success 'apply with --3way --ours' '
+	test_apply_with_3way_favoritism --ours -Xours
+'
+
+test_expect_success 'apply with --3way --theirs' '
+	test_apply_with_3way_favoritism --theirs -Xtheirs
+'
+
+test_expect_success 'apply with --3way --union' '
+	echo "* merge=union" >.gitattributes &&
+	test_apply_with_3way_favoritism --union &&
+	rm .gitattributes
+'
+
 test_expect_success 'apply with --3way with rerere enabled' '
 	test_config rerere.enabled true &&
 
-- 
2.46.0

