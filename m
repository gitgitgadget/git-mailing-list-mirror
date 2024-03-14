Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D67441E
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435920; cv=none; b=QMKjjx6ChW07Ag2sflD1FGwIgLvAKRXWiWMv1mRvfZMx+UdWs6OPhWpeGlIYb0Crrl5jtMpaAMXxJmhkVTDBuiojCTvu17fp//FzyfbiMpsigN4RIjBlLfBPRg89djzlVSLPraFXpEIMAhb2K5/Z2dOMtODyL880x0lSll1XX7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435920; c=relaxed/simple;
	bh=CYD5hsYJGR9Vff/Oka/sXb4YIdjC6E7wFeuDHnzotSc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pfdU45onhMDALmKKHsAdx8qj/4dJmn5pU/8NO42tBJGFAmY97Ru5m5E9G9mdvAes6XOuHygT9xVKhdcWHIl6NMeWyI+IPMZhFAwgfZDt6zamSO9TJjv2bwZ51DqLGfJdJjq2J5LLbuthYFXwd/aFl4IBFIBqbrHNFAjA3zF0OAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh5EaHqY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh5EaHqY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ddd1624beso800579f8f.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710435916; x=1711040716; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsJ8TEZg0txHu9Hy3/ysMau8lmP9fqFYypA0BO+pP+4=;
        b=Lh5EaHqYn43mB/IhxndUSHdvh8HIza30sbwLxnAQruYch8W+qoZ9A01YIPhRbrWuTB
         AiyJVJkrHbg27oHs4hY7en+4tgCHe6SehgZDbSAkazPyjjxCvh5OzfPbf1nrv/mXxvd1
         7iDv0Z5LrYoR7noYRWc104Se7lCCQ3pzQYz362BgOdCEBJ6fPiU0VHEYONLHwGJN33vO
         gAfEUqQLTdC+iYxgnVzXKtbZYsNSBedrgxkat6Pz4tFeIDfZ8PB4HZZIuSj3GWrNf/Di
         1YqztONHzoLBhqrSZRrN7Kl+U8RHwp2ODo+a4Mhvs7avBhaltht1sgZ5y5D2v7pMuQXC
         HdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435916; x=1711040716;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsJ8TEZg0txHu9Hy3/ysMau8lmP9fqFYypA0BO+pP+4=;
        b=UzME3nP5FpOESouuyrsBhDGn7lZoJJ/PXb2HegfWUt9qTawggC29/MpgFTJKDMVmCX
         fb/en5sdqkXwjgjVDkUnvOwaHT6q/F02fW+BSF34Ucvte5bE7SVv1ABRq1n8dsxhXB/V
         oZQxd+ohe3ouoJViJSmi0jgOmeYjU73v123YoeotueuQMXaxVBnVLWybC1jbc/k3c17Z
         bMULEBnIBVXM+7o5vZvKqt1jzu4mhOxK4iTvGFoF3eG79LZgcfXKL+0HJgTzPm2A2sLQ
         IRXO8mHkL2uxFtBG6dBwt8gQ7v2bhcrdoZCKU6yyRlPmar/7DmRfdrScsIN+Qj6f+LQl
         cJoQ==
X-Gm-Message-State: AOJu0YwjBMOE0zqXUJRxvXy7oPIkbOCykXoFVy0+neHGdJUT5gTYyJHd
	E8pBbIkzGXurtZQ+e95yr3gBZ37G8F1QW6/E+3ExtbutMxtdK2CjFCnsXENY
X-Google-Smtp-Source: AGHT+IFew2bbEPxJkJNZO6tQNRqOZQt1X3vkI8cdHXbexZZH4CMo6SF9l6YGtinnbh7xEyAd1KjDQA==
X-Received: by 2002:adf:f68e:0:b0:33e:9f16:33c with SMTP id v14-20020adff68e000000b0033e9f16033cmr535030wrp.18.1710435915866;
        Thu, 14 Mar 2024 10:05:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b00412d4c8b743sm3023445wms.30.2024.03.14.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:05:14 -0700 (PDT)
Message-ID: <511e03d3db26b174fa6585310b9866a06ac2dff0.1710435907.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
	<pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 17:05:06 +0000
Subject: [PATCH v2 4/5] checkout: cleanup --conflict=<style> parsing
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
Cc: Elijah Newren <newren@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Passing an invalid conflict style name such as "--conflict=bad" gives
the error message

    error: unknown style 'bad' given for 'merge.conflictstyle'

which is unfortunate as it talks about a config setting rather than
the option given on the command line. This happens because the
implementation calls git_xmerge_config() to set the conflict style
using the value given on the command line. Use the newly added
parse_conflict_style_name() instead and pass the value down the call
chain to override the config setting. This also means we can avoid
setting up a struct config_context required for calling
git_xmerge_config().

The option is now parsed in a callback to avoid having to store the
option name. This is a change in behavior as now

    git checkout --conflict=bad --conflict=diff3

will error out when parsing "--conflict=bad" whereas before this change
it would succeed because it would only try to parse the value of the
last "--conflict" option given on the command line.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/checkout.c | 51 +++++++++++++++++++++++++++++-----------------
 t/t7201-co.sh      |  6 ++++++
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6ded58bd95c..d6ab3b1d665 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -91,7 +91,7 @@ struct checkout_opts {
 	int new_branch_log;
 	enum branch_track track;
 	struct diff_options diff_options;
-	char *conflict_style;
+	int conflict_style;
 
 	int branch_exists;
 	const char *prefix;
@@ -100,6 +100,8 @@ struct checkout_opts {
 	struct tree *source_tree;
 };
 
+#define CHECKOUT_OPTS_INIT { .conflict_style = -1 }
+
 struct branch_info {
 	char *name; /* The short name used */
 	char *path; /* The full name of a real branch */
@@ -251,7 +253,8 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 }
 
 static int checkout_merged(int pos, const struct checkout *state,
-			   int *nr_checkouts, struct mem_pool *ce_mem_pool)
+			   int *nr_checkouts, struct mem_pool *ce_mem_pool,
+			   int conflict_style)
 {
 	struct cache_entry *ce = the_index.cache[pos];
 	const char *path = ce->name;
@@ -286,6 +289,7 @@ static int checkout_merged(int pos, const struct checkout *state,
 
 	git_config_get_bool("merge.renormalize", &renormalize);
 	ll_opts.renormalize = renormalize;
+	ll_opts.conflict_style = conflict_style;
 	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
 				&ours, "ours", &theirs, "theirs",
 				state->istate, &ll_opts);
@@ -416,7 +420,8 @@ static int checkout_worktree(const struct checkout_opts *opts,
 			else if (opts->merge)
 				errs |= checkout_merged(pos, &state,
 							&nr_unmerged,
-							&ce_mem_pool);
+							&ce_mem_pool,
+							opts->conflict_style);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
@@ -886,6 +891,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			}
 			o.branch1 = new_branch_info->name;
 			o.branch2 = "local";
+			o.conflict_style = opts->conflict_style;
 			ret = merge_trees(&o,
 					  new_tree,
 					  work,
@@ -1618,6 +1624,21 @@ static int checkout_branch(struct checkout_opts *opts,
 	return switch_branches(opts, new_branch_info);
 }
 
+static int parse_opt_conflict(const struct option *o, const char *arg, int unset)
+{
+	struct checkout_opts *opts = o->value;
+
+	if (unset) {
+		opts->conflict_style = -1;
+		return 0;
+	}
+	opts->conflict_style = parse_conflict_style_name(arg);
+	if (opts->conflict_style < 0)
+		return error(_("unknown conflict style '%s'"), arg);
+
+	return 0;
+}
+
 static struct option *add_common_options(struct checkout_opts *opts,
 					 struct option *prevopts)
 {
@@ -1628,8 +1649,9 @@ static struct option *add_common_options(struct checkout_opts *opts,
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
-		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
-			   N_("conflict style (merge, diff3, or zdiff3)")),
+		OPT_CALLBACK(0, "conflict", opts, N_("style"),
+			     N_("conflict style (merge, diff3, or zdiff3)"),
+			     parse_opt_conflict),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
@@ -1720,15 +1742,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->show_progress = isatty(2);
 	}
 
-	if (opts->conflict_style) {
-		struct key_value_info kvi = KVI_INIT;
-		struct config_context ctx = {
-			.kvi = &kvi,
-		};
+	if (opts->conflict_style >= 0)
 		opts->merge = 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", opts->conflict_style,
-				  &ctx, NULL);
-	}
+
 	if (opts->force) {
 		opts->discard_changes = 1;
 		opts->ignore_unmerged_opt = "--force";
@@ -1893,7 +1909,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
-	struct checkout_opts opts;
+	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options;
 	struct option checkout_options[] = {
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -1909,7 +1925,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	int ret;
 	struct branch_info new_branch_info = { 0 };
 
-	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.only_merge_on_switching_branches = 0;
@@ -1948,7 +1963,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 int cmd_switch(int argc, const char **argv, const char *prefix)
 {
-	struct checkout_opts opts;
+	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options = NULL;
 	struct option switch_options[] = {
 		OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
@@ -1964,7 +1979,6 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	int ret;
 	struct branch_info new_branch_info = { 0 };
 
-	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
 	opts.accept_ref = 1;
 	opts.accept_pathspec = 0;
@@ -1990,7 +2004,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 int cmd_restore(int argc, const char **argv, const char *prefix)
 {
-	struct checkout_opts opts;
+	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options;
 	struct option restore_options[] = {
 		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
@@ -2007,7 +2021,6 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	int ret;
 	struct branch_info new_branch_info = { 0 };
 
-	memset(&opts, 0, sizeof(opts));
 	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
 	opts.empty_pathspec_ok = 0;
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 10cc6c46051..e1f85a91565 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -631,6 +631,12 @@ test_expect_success 'checkout --conflict=diff3' '
 	test_cmp merged file
 '
 
+test_expect_success 'checkout with invalid conflict style' '
+	test_must_fail git checkout --conflict=bad 2>actual -- file &&
+	echo "error: unknown conflict style ${SQ}bad${SQ}" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'failing checkout -b should not break working tree' '
 	git clean -fd &&  # Remove untracked files in the way
 	git reset --hard main &&
-- 
gitgitgadget

