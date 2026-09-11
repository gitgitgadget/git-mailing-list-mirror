Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DAC310645
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144895; cv=none; b=NBf2cgNA6C+oG37jwgbSVxt1GeuSXfLWRdwRgZn2VlDrw0bo58ll6tAmlJtouK+0QIch5Zd/I9V6qKmFZKtMtt7wrliKrcgIupm8ADvUJ779LAwM2FwI0bjCq25eNIQiezwah99EROvcOw0vo3H5793B37Wjo7JkV1ul4jXV4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144895; c=relaxed/simple;
	bh=FY6iJpEi6ARWNqhg6LJIBEmmAK8hRMXcsnRzGOGTZug=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Pc/pBhb5SFAcX5MZHXuGkL2T2De/ZDWHK6zlpOewcKPVvUXLSwD/MxFRhXOXJ1fGPHvKW7Z806qc7vsX8/vd9eXPqTG6meWqWJnxtx3NYoWBwtLg+41t/icJTrbVjW4yh789CWQwHLMbQOTLq776HvJTg09HkPYXDsMNpyODK/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/DGEpgG; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/DGEpgG"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97cad2f51edso509624241.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789144879; x=1789749679; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qECiTB0ApnN07uEwS2KVV5VMEsbKDR24gY1TwYNBu1g=;
        b=Q/DGEpgGmtWkDJSwygefUkg5Vf9jxM/8ERunVJdlhynSNFUZ17dQq24uLZRdixlALV
         CKyBPYmBmiw74oIjokWNoOH9s5SW3jv9sYRS4BCgrGvlQT3CJgbAGw/kkI4d32af3zdg
         RqhKZudxn/xJ+K2syUBU5siyJCCfoE/EYE6rqzWaDs9g1M1yXLXJa96ROpOUFhsNtgn8
         vQPPnUi0huQ+XBEaIpUo/vT55h1rh3KUVrlI7OqQ7NUnHFWCXLQCCC/KP1Q4XCLdpgOS
         lPkVyb5/SJPmxNlRacQhxCWgdznUwqb4BGJKgd3qQVIeG5dqRT2oeSx1AcvqN3M41O3R
         Aixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144879; x=1789749679;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qECiTB0ApnN07uEwS2KVV5VMEsbKDR24gY1TwYNBu1g=;
        b=efoLPS9uyLsE/uLoOhEC7ctO1hFu7rWgmyyImoZPQShCzsE56Xqxz0dA98nvbBbnPh
         hnhrCu4AUwHAHzpzXAADxiaOjgJE/VD4VUpnrz6LPbY3tFPPFLzNfK7vaVi51NG48smu
         PnxQDEt3C1YUKQrRkGA0sTNUZuw6kOJGjcVV2HvfreHqZoJt4W0E7nmMLSqOKyEdavOQ
         ojB+DRFTmRz6I7hWF6LVWADb5rzfAuMkh+Zs2R+kvlvEOVY8dYpjG1Zjz32YB4552lMu
         YdXsDRb6lI4rXhVrkUPaB1MjYd7p4wjwy7470PhndCdx4oVjRJppujtnfWZaYQ84o2kA
         O9lw==
X-Gm-Message-State: AFuF++mpQEwm/5meqNg5H07jzLRM84Th+2+xy5HO7Hq/bXycU6L3GPlN
	993RV/+WDx4NqDHw+3BjzNdgZScBohwibM9emCHWz7DyGil92gXlEv0NV0zdKQ==
X-Gm-Gg: AYBFou1qRQg0UCTezn/pzQJxU4bGn5YGAmYkViAYdFjcbVtdWLx1LCGntKInWQrGR4l
	g1jTBxr6b2UKbuKfaRqhiZ68g9pfGcHzZA/wlenwFlnCRcS9Gw6hfhzwEn5qImcTD6HoNl4pAnq
	fzE9TyV4PNnX/U26iHDdldgk0pTNrKPQY9xFDRnqSrq09p777lGUK9oIJ37GYlFd9H4VOmu+FoE
	0HkCnj051FUSBKCtBWlPvfyjUuLHXm0WJBrl+HFeiFjOvLxT0oVAGwG4ScAP2XtEpHHodAFYGwl
	ZrIgHRZ1d46+Mw1AB8rYev4sSgcL8k81s1uBJ7BjtnuKhafVArEhRYVLUUX7QaDaup69TPP1Ttx
	EZlkuywzpSRX5H+gTpRhLJ9pl++iXSSMU3YydZSy5YW/HXgs7UZGDydS9a73Vw+j8jwbGySDYPr
	TikY5Az2iDywyiD40eW2/COH2S7EQK2obe0J7yTaf18ALqhVKKun0HmFaXlzTYB1ODA//ny7ign
	unx
X-Received: by 2002:a05:6122:88c:b0:5c8:fa1e:9f5b with SMTP id 71dfb90a1353d-5c8fa1ebc00mr1902607e0c.2.1789144878607;
        Fri, 11 Sep 2026 09:41:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.167.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f478bf1sm24674776d6.25.2026.09.11.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:41:18 -0700 (PDT)
Message-Id: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 11 Sep 2026 16:41:17 +0000
Subject: [PATCH] range-diff: add --matched-only to skip one-sided commits
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Reviewing a range-diff often means scrolling past commits that were
simply added or dropped, when only the ones that correspond between
the two ranges are of interest.

--left-only and --right-only already each suppress one of those
one-sided groups, so give --matched-only its own name for applying
both suppressions at once instead of documenting the combination of
two options whose names read as contradictory together. Internally it
just sets both flags, reusing the existing suppression logic in
show_range_diff().

Extend the existing '--left-only'/'--right-only' conflict check in
show_range_diff() to also reject any combination with --matched-only,
since all three narrow the output in ways that cannot be combined.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    range-diff: add --matched-only to skip one-sided commits
    
    Add git range-diff --matched-only to only show commits that correspond
    between the two ranges, skipping ones that were only added or only
    removed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2401%2FHaraldNordgren%2Frange-diff-matched-only-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2401/HaraldNordgren/range-diff-matched-only-v1
Pull-Request: https://github.com/git/git/pull/2401

 Documentation/git-range-diff.adoc | 10 ++++-
 builtin/range-diff.c              |  5 ++-
 range-diff.c                      | 11 +++++-
 range-diff.h                      |  2 +-
 t/t3206-range-diff.sh             | 63 +++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-range-diff.adoc b/Documentation/git-range-diff.adoc
index 5cc5e2ed56..58e59e8e3b 100644
--- a/Documentation/git-range-diff.adoc
+++ b/Documentation/git-range-diff.adoc
@@ -10,7 +10,8 @@ SYNOPSIS
 [synopsis]
 git range-diff [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
-	[--left-only | --right-only] [--diff-merges=<format>]
+	[--left-only | --right-only | --matched-only]
+	[--diff-merges=<format>]
 	[--remerge-diff] [--no-notes | --notes[=<ref>]]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
 	[[--] <path>...]
@@ -82,6 +83,13 @@ to revert to color all lines according to the outer diff markers
 	Suppress commits that are missing from the second specified range
 	(or the "right range" when using the `<rev1>...<rev2>` form).
 
+`--matched-only`::
+	Only emit commits that have a corresponding commit in the other
+	range, suppressing any commit that exists on only one side. This is
+	the same as using `--left-only` and `--right-only` together. Useful
+	to skip added or removed commits when reviewing how the commits
+	that survived a rebase changed.
+
 `--diff-merges=<format>`::
 	Instead of ignoring merge commits, generate diffs for them using the
 	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index e54c0f7fe1..8059f92eaa 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -46,7 +46,7 @@ int cmd_range_diff(int argc,
 		.diffopt = &diffopt,
 		.log_arg = &log_arg
 	};
-	int simple_color = -1, left_only = 0, right_only = 0;
+	int simple_color = -1, left_only = 0, right_only = 0, matched_only = 0;
 	struct option range_diff_options[] = {
 		OPT_INTEGER(0, "creation-factor",
 			    &range_diff_opts.creation_factor,
@@ -68,6 +68,8 @@ int cmd_range_diff(int argc,
 			 N_("only emit output related to the first range")),
 		OPT_BOOL(0, "right-only", &right_only,
 			 N_("only emit output related to the second range")),
+		OPT_BOOL(0, "matched-only", &matched_only,
+			 N_("only emit commits that have a corresponding commit in the other range")),
 		OPT_END()
 	};
 	struct option *options;
@@ -186,6 +188,7 @@ int cmd_range_diff(int argc,
 	range_diff_opts.dual_color = simple_color < 1;
 	range_diff_opts.left_only = left_only;
 	range_diff_opts.right_only = right_only;
+	range_diff_opts.matched_only = matched_only;
 	res = show_range_diff(range1.buf, range2.buf, &range_diff_opts);
 
 	strvec_clear(&log_arg);
diff --git a/range-diff.c b/range-diff.c
index 8e2dd2eb19..fa895f5760 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -591,8 +591,15 @@ int show_range_diff(const char *range1, const char *range2,
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
 	unsigned int include_merges = range_diff_opts->include_merges;
 
-	if (range_diff_opts->left_only && range_diff_opts->right_only)
-		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
+	if (range_diff_opts->left_only + range_diff_opts->right_only +
+	    range_diff_opts->matched_only > 1)
+		res = error(_("options '%s', '%s', or '%s' cannot be used together"),
+			    "--left-only", "--right-only", "--matched-only");
+
+	if (range_diff_opts->matched_only) {
+		range_diff_opts->left_only = 1;
+		range_diff_opts->right_only = 1;
+	}
 
 	if (!res && read_patches(range1, &branch1, range_diff_opts->log_arg, include_merges))
 		res = error(_("could not parse log for '%s'"), range1);
diff --git a/range-diff.h b/range-diff.h
index 9b70a80009..effd10b9b8 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -19,7 +19,7 @@
 struct range_diff_options {
 	int creation_factor;
 	unsigned dual_color:1;
-	unsigned left_only:1, right_only:1;
+	unsigned left_only:1, right_only:1, matched_only:1;
 	unsigned include_merges:1;
 	size_t max_memory;
 	const struct diff_options *diffopt; /* may be NULL */
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index ef92704de3..f85fd0c4ad 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -860,6 +860,69 @@ test_expect_success '--left-only/--right-only' '
 	test_cmp expect actual
 '
 
+test_expect_success '--left-only, --right-only and --matched-only are incompatible' '
+	test_must_fail git range-diff --left-only --right-only ...common 2>err &&
+	test_grep "cannot be used together" err &&
+
+	test_must_fail git range-diff --left-only --matched-only ...common 2>err &&
+	test_grep "cannot be used together" err &&
+
+	test_must_fail git range-diff --right-only --matched-only ...common 2>err &&
+	test_grep "cannot be used together" err &&
+
+	test_must_fail git range-diff --left-only --right-only --matched-only \
+		...common 2>err &&
+	test_grep "cannot be used together" err
+'
+
+test_expect_success '--left-only, --right-only and --matched-only each suppress one-sided commits' '
+	test_create_repo matched-only &&
+	(
+		cd matched-only &&
+		git switch --orphan combined-old &&
+		test_commit c-first &&
+		test_commit c-old-only &&
+		test_commit c-common &&
+		git switch -C combined-new c-first &&
+		test_commit c-new-only &&
+		git cherry-pick c-common &&
+
+		old_only_oid=$(git rev-parse --short=7 c-old-only) &&
+		new_only_oid=$(git rev-parse --short=7 c-new-only) &&
+		common_old_oid=$(git rev-parse --short=7 c-common) &&
+		common_new_oid=$(git rev-parse --short=7 HEAD) &&
+
+		git range-diff -s --abbrev=7 combined-old...combined-new >actual &&
+		cat >expect <<-EOF &&
+		1:  $old_only_oid < -:  ------- c-old-only
+		-:  ------- > 1:  $new_only_oid c-new-only
+		2:  $common_old_oid = 2:  $common_new_oid c-common
+		EOF
+		test_cmp expect actual &&
+
+		git range-diff -s --abbrev=7 --left-only combined-old...combined-new \
+			>actual &&
+		cat >expect <<-EOF &&
+		1:  $old_only_oid < -:  ------- c-old-only
+		2:  $common_old_oid = 2:  $common_new_oid c-common
+		EOF
+		test_cmp expect actual &&
+
+		git range-diff -s --abbrev=7 --right-only combined-old...combined-new \
+			>actual &&
+		cat >expect <<-EOF &&
+		-:  ------- > 1:  $new_only_oid c-new-only
+		2:  $common_old_oid = 2:  $common_new_oid c-common
+		EOF
+		test_cmp expect actual &&
+
+		git range-diff -s --abbrev=7 --matched-only combined-old...combined-new \
+			>actual &&
+		echo "2:  $common_old_oid = 2:  $common_new_oid c-common" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'ranges with pathspecs' '
 	git range-diff topic...mode-only-change -- other-file >actual &&
 	test_line_count = 2 actual &&

base-commit: fa7f9290efe2bd22dd736689597b474b93798e11
-- 
gitgitgadget
