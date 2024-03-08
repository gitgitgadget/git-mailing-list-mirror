Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32735339B
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907280; cv=none; b=EzKrNcFAherD6n3ROvzlZCra7a+C/OFLoX0yq4jY6gQS5iEaJo9TyOYRpAAGgOxdaPAPn9pMOrgavg6V5vsHq/S9fczQ3L1dD7v9z+rHKMnEC/qoyj+T+Mdoq1LM8fO0UOtXMJ1SVFLnUzM4XY4euAHn/+sWT/QQyuN8UzbbaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907280; c=relaxed/simple;
	bh=mCqkT0G2EZrIymJHIXn/7kkAfgMDhI/Vvzd5mT+8+bg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YV28F7V6nZ6CuE9ndO2SiCWeN3S7TEqSFGrJuKNZ/AUcDmhuGkv0BhhJxZFqjESXnxTaaPf5JoYVZYl851EGnV50O1RB8WNYwJWeNeXCWPusmAIyaJDaTTzO7rPVcqPSLEYPGBxhn1MFk+bNMfA8F8BXDoSHmZRcs+fBRsj2DbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF/+pi14; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF/+pi14"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e383546c1so1272854f8f.2
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 06:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709907276; x=1710512076; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtPk7SV/A8XooDvCNOOiFWmXHz1TF1ummXpO+MFiZSQ=;
        b=SF/+pi14SpUxCQ9mxfh/5hZhv7+q9goaflIGNPAN9o45Q5eTHCrSaUOGkdIOqtb1H3
         bOIs48LH/YnHV+q19kqRzwsqTOd4lxDrpeafTnLMgAF6OkMsdQ6hNDdW/G3qfE97OmA7
         34o5KMBG70tKEHIniEkxbPNfVkB1Y5rQgGK57cuNtcwKuc9wm5nhSAAIHLDG4YG1onpV
         3MJkoBfW0zNalVsHgEQa3CKeWQYprZYGs/pUCsCd2YF9FwlbdS/eV7E/JjevVbbGZyYM
         Xlho/nn5+rXCKvR3TAk2RpDAA/X2dm9juIsySk9yjEmh4eHKQLE2ymtudphcO0cskKOI
         GwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907276; x=1710512076;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtPk7SV/A8XooDvCNOOiFWmXHz1TF1ummXpO+MFiZSQ=;
        b=o79ySKQUBf5GIc2y8XOVl5fT3MsNBsgi72PM47BGBfZGjTyxyNoVIa64O8DaN5/5U0
         DfpGDmT9Sjk+pSTOM4TYFTHYO7mgD12xZFc5cJavCSaPsWRjOetrZGacNUUszlKRKWC7
         2KhRToAT39PJFwthjTmStm7cU9LNf5oZLsPhO5xILNvzPNo1cieSvxkwC15YWuVcNFuM
         Ei/IfjKtKioy/DLOmYHeJ/9yIbpxfp8AJdhIYiq7gHYn4eM/2WGxJlYa5kiULe8/xkGs
         grhO6Mam+DzsocLrU8G75AFXF73KXFvDsy4oyqbtpHn3whnVFdD09cGXP4MsYht7NKT5
         Fhuw==
X-Gm-Message-State: AOJu0YwdeQyyAHlLegclD0QgHl2KPggWfLnPhB2MFHKXgI3QPqM8Xk1P
	f9bKUKmN96tr3cORTqc+/xlv8XY1nmfstKYACCHfos2hBhI1SOE/xJrv7sxT
X-Google-Smtp-Source: AGHT+IGynynVGuE58kTkSnMNFxJc2dtIdZvkXGM73Ibb7IAU96Iz6sm6pQ+oG/uOtR2c4UBA3XyksA==
X-Received: by 2002:adf:cc84:0:b0:33e:798f:6d1e with SMTP id p4-20020adfcc84000000b0033e798f6d1emr819157wrj.37.1709907276020;
        Fri, 08 Mar 2024 06:14:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe78c000000b0033e745176f5sm2367572wrm.110.2024.03.08.06.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 06:14:34 -0800 (PST)
Message-ID: <317bb7a70d023278087f4370b843d7f28f9ee2f6.1709907271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Mar 2024 14:14:30 +0000
Subject: [PATCH 4/4] checkout: cleanup --conflict=<style> parsing
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Passing an invalid conflict style name such as "--conflict=bad" gives
the error message

    error: unknown style 'bad' given for 'merge.conflictstyle'

which is unfortunate as it talks about a config setting rather than
the option given on the command line. This happens because the
implementation calls git_xmerge_config() to set the conflict style
using the value given on the command line. Use the newly added
parse_conflict_style() instead and pass the value down the call chain
to override the config setting. This also means we can avoid setting
up a struct config_context required for calling git_xmerge_config().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/checkout.c | 37 ++++++++++++++++++++-----------------
 t/t7201-co.sh      |  6 ++++++
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6ded58bd95c..f5055f059ad 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -91,7 +91,8 @@ struct checkout_opts {
 	int new_branch_log;
 	enum branch_track track;
 	struct diff_options diff_options;
-	char *conflict_style;
+	char *conflict_style_name;
+	int conflict_style;
 
 	int branch_exists;
 	const char *prefix;
@@ -100,6 +101,8 @@ struct checkout_opts {
 	struct tree *source_tree;
 };
 
+#define CHECKOUT_OPTS_INIT { .conflict_style = -1 }
+
 struct branch_info {
 	char *name; /* The short name used */
 	char *path; /* The full name of a real branch */
@@ -251,7 +254,8 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 }
 
 static int checkout_merged(int pos, const struct checkout *state,
-			   int *nr_checkouts, struct mem_pool *ce_mem_pool)
+			   int *nr_checkouts, struct mem_pool *ce_mem_pool,
+			   int conflict_style)
 {
 	struct cache_entry *ce = the_index.cache[pos];
 	const char *path = ce->name;
@@ -286,6 +290,7 @@ static int checkout_merged(int pos, const struct checkout *state,
 
 	git_config_get_bool("merge.renormalize", &renormalize);
 	ll_opts.renormalize = renormalize;
+	ll_opts.conflict_style = conflict_style;
 	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
 				&ours, "ours", &theirs, "theirs",
 				state->istate, &ll_opts);
@@ -416,7 +421,8 @@ static int checkout_worktree(const struct checkout_opts *opts,
 			else if (opts->merge)
 				errs |= checkout_merged(pos, &state,
 							&nr_unmerged,
-							&ce_mem_pool);
+							&ce_mem_pool,
+							opts->conflict_style);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
@@ -886,6 +892,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			}
 			o.branch1 = new_branch_info->name;
 			o.branch2 = "local";
+			o.conflict_style = opts->conflict_style;
 			ret = merge_trees(&o,
 					  new_tree,
 					  work,
@@ -1628,7 +1635,7 @@ static struct option *add_common_options(struct checkout_opts *opts,
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
-		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
+		OPT_STRING(0, "conflict", &opts->conflict_style_name, N_("style"),
 			   N_("conflict style (merge, diff3, or zdiff3)")),
 		OPT_END()
 	};
@@ -1720,14 +1727,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->show_progress = isatty(2);
 	}
 
-	if (opts->conflict_style) {
-		struct key_value_info kvi = KVI_INIT;
-		struct config_context ctx = {
-			.kvi = &kvi,
-		};
+	if (opts->conflict_style_name) {
 		opts->merge = 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", opts->conflict_style,
-				  &ctx, NULL);
+		opts->conflict_style =
+			parse_conflict_style(opts->conflict_style_name);
+		if (opts->conflict_style < 0)
+			die(_("unknown conflict style '%s'"),
+			    opts->conflict_style_name);
 	}
 	if (opts->force) {
 		opts->discard_changes = 1;
@@ -1893,7 +1899,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
-	struct checkout_opts opts;
+	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options;
 	struct option checkout_options[] = {
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -1909,7 +1915,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	int ret;
 	struct branch_info new_branch_info = { 0 };
 
-	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.only_merge_on_switching_branches = 0;
@@ -1948,7 +1953,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 int cmd_switch(int argc, const char **argv, const char *prefix)
 {
-	struct checkout_opts opts;
+	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options = NULL;
 	struct option switch_options[] = {
 		OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
@@ -1964,7 +1969,6 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	int ret;
 	struct branch_info new_branch_info = { 0 };
 
-	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
 	opts.accept_ref = 1;
 	opts.accept_pathspec = 0;
@@ -1990,7 +1994,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 int cmd_restore(int argc, const char **argv, const char *prefix)
 {
-	struct checkout_opts opts;
+	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options;
 	struct option restore_options[] = {
 		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
@@ -2007,7 +2011,6 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	int ret;
 	struct branch_info new_branch_info = { 0 };
 
-	memset(&opts, 0, sizeof(opts));
 	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
 	opts.empty_pathspec_ok = 0;
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 10cc6c46051..5746d152b6d 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -631,6 +631,12 @@ test_expect_success 'checkout --conflict=diff3' '
 	test_cmp merged file
 '
 
+test_expect_success 'checkout with invalid conflict style' '
+	test_must_fail git checkout --conflict=bad 2>actual -- file &&
+	echo "fatal: unknown conflict style ${SQ}bad${SQ}" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'failing checkout -b should not break working tree' '
 	git clean -fd &&  # Remove untracked files in the way
 	git reset --hard main &&
-- 
gitgitgadget
