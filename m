Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420A37F8AF
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458707; cv=none; b=bl/mlZPPGb462lHXqZZuKxySyAZr2YiksA+pn4fbdwYPQlBfswJbOaFDGa1pEinJ3RriHw96owMf9Sojnjza3xCCoPEKl7YPs0rUwjceQWskN0GiK3XwTi4ZP9j7LT8Qo4oNmOneaPpWXMs6LRUv/ldSuiWZrzZ943/j4Alq0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458707; c=relaxed/simple;
	bh=mdKcQPRRrQic5zEWcNSV0zp1xap15Hm+H8vfCEPaWxM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Azm3Vappm4q6SZc78e3BPd2FVrJDMRd+YiihGefrGfPYuulCgANzmyDsE/2cWdalmNeKSkyAXqLtyX8UpoUk8tWK5Hirqs40DyhWooFS8nDXH/7aRdknViPFCterLuAa99AxS2FAPN6Nv0hEtmoMz/cZIao/ZfpzNc25aJweCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko9zTxFM; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko9zTxFM"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9105d241693so30655016d6.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 00:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789458705; x=1790063505; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4SBw15FWxLjwbREPlvFvufLEUNLiF4QWGdSD2qtAgo8=;
        b=ko9zTxFMR+f2+f2HPSPxdJ2n76Pg0wxqoMw02gftORYlQX59gI5cAaBkq/tf3BlEfs
         nDjVKBpUBTZJWy+MmJvFqE77XRvPs5wo1QyJwVq0ToD2YV3HvGDIdYgiPrxm55jFNN1D
         BFrK20cr612ICOQa4qF3Jlq4B+lca9SYgwHibflQVkrOtimgY+cURdWTxIxD13xDkWBV
         yHo+9oAQ2UoX0Yboy4qd1i4cQX0I2DP0+5Xhi63QJGvauWoW5Fyeyf3I6aAJuvw/KQPR
         aemlKnRBUqDaidX+wcC6y8gON5ehDXfG1Bpsm3kXslPR7x8YLlDYi0TR3eTv2yfa/ze0
         ZVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789458705; x=1790063505;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SBw15FWxLjwbREPlvFvufLEUNLiF4QWGdSD2qtAgo8=;
        b=Q6t1PlROvS80/Ta4bdGQ/bhSXHe3g+PxKTVk5igPUUFAGBNqg/6K7GZguLNrKXWNHv
         QwJ5699DJqdb2wcKZgixYjNZub/AFPHs4GUeT+AgaxSFrV5SQpJYs+EmTlj++x3i2EER
         4NqwE9yfHBgBC6IOGzdV3FUWmpLPyBUZ0RtB2fNPv/Z7lt0KnaEo2XKKDMsbPfCiipxi
         7I/64vYTldkM5pfP2b3q2ICMsnn8vWRF4BWoqHNhon6WXYCamrQ6jioFVdmyw573JOlt
         q6Ecp1ZeE+KgJHE1zX97P1N9c8VkSt/kfIRbW2tIJhn/Hzenujd0Me8uUY7xWgu5DcgY
         X6LQ==
X-Gm-Message-State: AFuF++m2nW3goMDgIYMjwyhSghLQg3CWxWgR0o/FERrPs7eXytwC/eOY
	pxjSZLTicYp5h6CIDPDkIulwno8PSMHy8RTQuppCPi3iGh8gSZQ/iM1JMd6LjQ==
X-Gm-Gg: AYBFou3lLCv9U6ZMYckq5D8WBmvJlzYltftnJEPuAkxtNsH3Tqh6cuT4CG6zdirGdTy
	mvdyiEI4VYTq8aYobHK2BwVNFB3Lxk+jZzYlHLnCROYQ2k5e1J/jPwYb3HmLPMJ2/n7xYt2vUaI
	xTDBgfqYRUeVO3rTVXBw0X11sQ88Encjzb5ICJrH9S7RiV/cvjGsOP9snt8n88kRhJD4zAhKqVe
	qGch415mAM64dkD1kpG3i2Thnxav266zl8Hk3hd+hE2/MFs94L6jSfj7CyEmXZHROcHEVE5+Fbp
	jqyFuvmk+WYCFOxZ0Rm0rZ4yJkEtK4n/XV655BD0g+QEpZwIoQGXYV34YtOP/WDniEp+TJ1D1lx
	mgugSqabP/WpJRL0+6+oTaX0Ms5rwsVNodj9myE+7Q+Sa941B5yqOzfp1e9P3dA54mB+F8h+vp7
	2hB01UUhzjEaOcXXD6/FapQTVxfKwzJa0vpLyWJcmjfBUd4Izb508ZEu7t//dDej9nEswX57ENc
	g==
X-Received: by 2002:a05:6214:226a:b0:912:16df:a5a5 with SMTP id 6a1803df08f44-9122e4eb48cmr111752586d6.9.1789458704634;
        Tue, 15 Sep 2026 00:51:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.46.147])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4963fcsm115142726d6.33.2026.09.15.00.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:51:43 -0700 (PDT)
Message-Id: <pull.2401.v3.git.git.1789458703432.gitgitgadget@gmail.com>
In-Reply-To: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
References: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 15 Sep 2026 07:51:43 +0000
Subject: [PATCH v3] range-diff: add --matched-only to skip one-sided commits
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
one-sided groups, but they are defined as "only show this side" and
so cannot be given together, which is exactly why show_range_diff()
already rejected that combination. Give the "show only the commits
that correspond on both sides" behavior its own name, --matched-only,
instead of asking users to reach for a combination that errors out.

Extend the existing '--left-only'/'--right-only' conflict check to
also reject any combination with --matched-only, since all three
narrow the output in ways that cannot be combined.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    range-diff: add --matched-only to skip one-sided commits
    
    Add git range-diff --matched-only to only show commits that correspond
    between the two ranges, skipping ones that were only added or only
    removed.
    
    Changes in v2:
    
     * Update docs and commit message.
     * Use die_for_incompatible_opt3.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2401%2FHaraldNordgren%2Frange-diff-matched-only-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2401/HaraldNordgren/range-diff-matched-only-v3
Pull-Request: https://github.com/git/git/pull/2401

Range-diff vs v2:

 1:  6d392249a2 ! 1:  ee195c14fc range-diff: add --matched-only to skip one-sided commits
     @@ builtin/range-diff.c: int cmd_range_diff(int argc,
       	strvec_clear(&log_arg);
      
       ## range-diff.c ##
     -@@
     - #include "userdiff.h"
     - #include "apply.h"
     - #include "revision.h"
     -+#include "parse-options.h"
     - 
     - struct patch_util {
     - 	/* For the search for an exact match */
      @@ range-diff.c: int show_range_diff(const char *range1, const char *range2,
       	struct string_list branch2 = STRING_LIST_INIT_DUP;
       	unsigned int include_merges = range_diff_opts->include_merges;
       
      -	if (range_diff_opts->left_only && range_diff_opts->right_only)
      -		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
     -+	die_for_incompatible_opt3(range_diff_opts->left_only, "--left-only",
     -+				  range_diff_opts->right_only, "--right-only",
     -+				  range_diff_opts->matched_only, "--matched-only");
     - 
     --	if (!res && read_patches(range1, &branch1, range_diff_opts->log_arg, include_merges))
     ++	if (range_diff_opts->left_only + range_diff_opts->right_only +
     ++	    range_diff_opts->matched_only > 1)
     ++		res = error(_("options '%s', '%s', or '%s' cannot be used together"),
     ++			    "--left-only", "--right-only", "--matched-only");
     ++
      +	if (range_diff_opts->matched_only) {
      +		range_diff_opts->left_only = 1;
      +		range_diff_opts->right_only = 1;
      +	}
     -+
     -+	if (read_patches(range1, &branch1, range_diff_opts->log_arg, include_merges))
     + 
     + 	if (!res && read_patches(range1, &branch1, range_diff_opts->log_arg, include_merges))
       		res = error(_("could not parse log for '%s'"), range1);
     - 	if (!res && read_patches(range2, &branch2, range_diff_opts->log_arg, include_merges))
     - 		res = error(_("could not parse log for '%s'"), range2);
      
       ## range-diff.h ##
      @@


 Documentation/git-range-diff.adoc |  9 ++++-
 builtin/range-diff.c              |  5 ++-
 range-diff.c                      | 11 +++++-
 range-diff.h                      |  2 +-
 t/t3206-range-diff.sh             | 63 +++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-range-diff.adoc b/Documentation/git-range-diff.adoc
index 5cc5e2ed56..d448f897d6 100644
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
@@ -82,6 +83,12 @@ to revert to color all lines according to the outer diff markers
 	Suppress commits that are missing from the second specified range
 	(or the "right range" when using the `<rev1>...<rev2>` form).
 
+`--matched-only`::
+	Only emit commits that have a corresponding commit in the other
+	range, suppressing any commit that exists on only one side. Useful
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

base-commit: 3699d22b59a6ea467ce13edb81b6bdea0398c803
-- 
gitgitgadget
