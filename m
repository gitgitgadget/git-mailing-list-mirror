Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37962176FA5
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935353; cv=none; b=BUGq2KhOFdb3Im2g9mLauG33hS+rQnTELnNCuqnUKvgdZWr2V0aPJpx6PgGMxsgYnBeuOejah/Ps4szwPqbbNCAe21McE0nbPl1IeQ7bnH0+3cAmVhEMJYyRv7r2Mg/TCSakm3lky7VpIe6j8KxbzsTFOxEZSRddKm7e/j9XeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935353; c=relaxed/simple;
	bh=cpXSFDQ571W8jKACYpRAozMOaFxC0Dt5V1aitd3Aq4g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IDmy64Lk4VkyLFfbqMTi53eA7x56X6/qfyPaxEArvYENKctkvr5GBEuA84EOZKyCYN843p7QXditf6Jkmq1hTcSScgn3LEq148YzEAMZnt1UaNmZOI9zwoO2TjzefXgtHHQ7qTreLokOdvJSlTqA9LCyE/XZH3R/FEX3V6snEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcMWV5ax; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcMWV5ax"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so5544090a12.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935349; x=1726540149; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MFLD0kB3zXHEO4hN2bbn+KjTFRmzPx4JwLlLJ1ZJZ4=;
        b=EcMWV5axpMHXQB+Ek2iUJe94SfkAYxq+TUoAcpBIDjDqly7Th+01LvcAaCziVY8qFh
         OBD/FB/G7D6uCpeeUnK4SFfVLH2gVuM6he8tPKMx95RwsUlQBuefx7KGkQFW7uxWemc7
         SXcNUVxah1WSFnm9xyjE9uUqvOsoahbXaKeU+mWur7lN9M+fxXPGuL0io2JqEsC51v9H
         sTNIPFNlshub3utHKXBgvLmOsL7Upd+Dpg2riY57/jo1qHqwEEtkvTwvLRXQK0kF3xG6
         8wtl/CUcmDtUkJYrnN8oYfiDo00kz9h8qZa9rdmmjcKFF9daRWgAxqTJN4VxazvT84Lv
         ra2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935349; x=1726540149;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MFLD0kB3zXHEO4hN2bbn+KjTFRmzPx4JwLlLJ1ZJZ4=;
        b=QYfSWKXJh7KbZp/0DmQ5byNHadEdqeAEi6Zn+knAmkbNgy/Bi2V8Yu6a9DOsbA23Zr
         Tfv8VyF4wWuuITuFi80yeM+C5klvaTNHmuY2YsZ5bJGJPnY2ND/iSHvGjAkXOiY6bOWW
         iVugazXx5YTsU1ya4nsqs/cPKIuJwE23G34k1VPWWMdZqT5OCU+E/5Q0CK+pEsCWYh2D
         jIOLu4P0NKT19vf6F/sWIhe1WMb0xGjnojNSwLLLK7m7ZDzVnHfdRqC3kuOwif20Q05T
         BsSYaHOGRtVNyWopblPtBNh4sVt9oOuB0vzI1Mhctnh59UFdqzRjvPNPCeUJZkmXWqy6
         EMrA==
X-Gm-Message-State: AOJu0YyE4dZ4C4fJ2FqhNGu37wflR1ERbjgIfWrs8so1y+2DmMKDxBen
	IIsLDdrWoEo7HYw+bkszAdZtoZXq+lwSmSlAteQfGddSredBv2YyciPVqA==
X-Google-Smtp-Source: AGHT+IGRr2SEcS0Bu4ogigNbnyO3qo6+H18DruWB0p2VaJIkKs8VFDywLVpTheFjDk4Ez7kAKq0SGQ==
X-Received: by 2002:a05:6402:2751:b0:5c2:5075:7d1 with SMTP id 4fb4d7f45d1cf-5c3dc785341mr11495936a12.7.1725935348811;
        Mon, 09 Sep 2024 19:29:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76eb6sm3652946a12.61.2024.09.09.19.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:08 -0700 (PDT)
Message-Id: <efa1793a5729b152b8961238dd834a26275e969a.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:36 +0000
Subject: [PATCH 11/30] survey: collect the set of requested refs
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Collect the set of requested branches, tags, and etc into a ref_array and
collect the set of requested patterns into a strvec.

RFC TODO: This patch has some changes that should be in the previous patch,
to make the diff look a lot better.

Co-authored-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/survey.c      | 258 ++++++++++++++++++++++++++++++++++--------
 t/t8100-git-survey.sh |   9 ++
 2 files changed, 217 insertions(+), 50 deletions(-)

diff --git a/builtin/survey.c b/builtin/survey.c
index e0e844201de..1b4fe591e59 100644
--- a/builtin/survey.c
+++ b/builtin/survey.c
@@ -1,6 +1,12 @@
 #include "builtin.h"
 #include "config.h"
+#include "object.h"
+#include "object-store-ll.h"
 #include "parse-options.h"
+#include "progress.h"
+#include "ref-filter.h"
+#include "strvec.h"
+#include "trace2.h"
 
 static const char * const survey_usage[] = {
 	N_("(EXPERIMENTAL!) git survey <options>"),
@@ -17,18 +23,8 @@ struct survey_refs_wanted {
 	int want_other; /* see FILTER_REFS_OTHERS -- refs/notes/, refs/stash/ */
 };
 
-/*
- * The set of refs that we will search if the user doesn't select
- * any on the command line.
- */
-static struct survey_refs_wanted refs_if_unspecified = {
-	.want_all_refs = 0,
-
-	.want_branches = 1,
-	.want_tags = 1,
-	.want_remotes = 1,
-	.want_detached = 0,
-	.want_other = 0,
+static struct survey_refs_wanted default_ref_options = {
+	.want_all_refs = 1,
 };
 
 struct survey_opts {
@@ -37,19 +33,51 @@ struct survey_opts {
 	struct survey_refs_wanted refs;
 };
 
-static struct survey_opts survey_opts = {
-	.verbose = 0,
-	.show_progress = -1, /* defaults to isatty(2) */
+struct survey_report_ref_summary {
+	size_t refs_nr;
+	size_t branches_nr;
+	size_t remote_refs_nr;
+	size_t tags_nr;
+	size_t tags_annotated_nr;
+	size_t others_nr;
+	size_t unknown_nr;
+};
+
+/**
+ * This struct contains all of the information that needs to be printed
+ * at the end of the exploration of the repository and its references.
+ */
+struct survey_report {
+	struct survey_report_ref_summary refs;
+};
+
+struct survey_context {
+	/* Options that control what is done. */
+	struct survey_opts opts;
+
+	/* Info for output only. */
+	struct survey_report report;
 
-	.refs.want_all_refs = -1,
+	/*
+	 * The rest of the members are about enabling the activity
+	 * of the 'git survey' command, including ref listings, object
+	 * pointers, and progress.
+	 */
+
+	struct repository *repo;
+
+	struct progress *progress;
+	size_t progress_nr;
+	size_t progress_total;
 
-	.refs.want_branches = -1, /* default these to undefined */
-	.refs.want_tags = -1,
-	.refs.want_remotes = -1,
-	.refs.want_detached = -1,
-	.refs.want_other = -1,
+	struct strvec refs;
 };
 
+static void clear_survey_context(struct survey_context *ctx)
+{
+	strvec_clear(&ctx->refs);
+}
+
 /*
  * After parsing the command line arguments, figure out which refs we
  * should scan.
@@ -57,9 +85,9 @@ static struct survey_opts survey_opts = {
  * If ANY were given in positive sense, then we ONLY include them and
  * do not use the builtin values.
  */
-static void fixup_refs_wanted(void)
+static void fixup_refs_wanted(struct survey_context *ctx)
 {
-	struct survey_refs_wanted *rw = &survey_opts.refs;
+	struct survey_refs_wanted *rw = &ctx->opts.refs;
 
 	/*
 	 * `--all-refs` overrides and enables everything.
@@ -82,7 +110,7 @@ static void fixup_refs_wanted(void)
 	    rw->want_remotes == -1 &&
 	    rw->want_detached == -1 &&
 	    rw->want_other == -1) {
-		*rw = refs_if_unspecified;
+		*rw = default_ref_options;
 		return;
 	}
 
@@ -106,54 +134,184 @@ static void fixup_refs_wanted(void)
 		rw->want_other = 0;
 }
 
-static struct option survey_options[] = {
-	OPT__VERBOSE(&survey_opts.verbose, N_("verbose output")),
-	OPT_BOOL(0, "progress", &survey_opts.show_progress, N_("show progress")),
-
-	OPT_BOOL_F(0, "all-refs", &survey_opts.refs.want_all_refs, N_("include all refs"),          PARSE_OPT_NONEG),
-
-	OPT_BOOL_F(0, "branches", &survey_opts.refs.want_branches, N_("include branches"),          PARSE_OPT_NONEG),
-	OPT_BOOL_F(0, "tags",     &survey_opts.refs.want_tags,     N_("include tags"),              PARSE_OPT_NONEG),
-	OPT_BOOL_F(0, "remotes",  &survey_opts.refs.want_remotes,  N_("include all remotes refs"),  PARSE_OPT_NONEG),
-	OPT_BOOL_F(0, "detached", &survey_opts.refs.want_detached, N_("include detached HEAD"),     PARSE_OPT_NONEG),
-	OPT_BOOL_F(0, "other",    &survey_opts.refs.want_other,    N_("include notes and stashes"), PARSE_OPT_NONEG),
-
-	OPT_END(),
-};
-
 static int survey_load_config_cb(const char *var, const char *value,
-				 const struct config_context *ctx, void *pvoid)
+				 const struct config_context *cctx, void *pvoid)
 {
+	struct survey_context *sctx = pvoid;
 	if (!strcmp(var, "survey.verbose")) {
-		survey_opts.verbose = git_config_bool(var, value);
+		sctx->opts.verbose = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "survey.progress")) {
-		survey_opts.show_progress = git_config_bool(var, value);
+		sctx->opts.show_progress = git_config_bool(var, value);
 		return 0;
 	}
 
-	return git_default_config(var, value, ctx, pvoid);
+	return git_default_config(var, value, cctx, pvoid);
 }
 
-static void survey_load_config(void)
+static void survey_load_config(struct survey_context *ctx)
 {
-	git_config(survey_load_config_cb, NULL);
+	git_config(survey_load_config_cb, ctx);
+}
+
+static void do_load_refs(struct survey_context *ctx,
+			 struct ref_array *ref_array)
+{
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct ref_sorting *sorting;
+	struct string_list sorting_options = STRING_LIST_INIT_DUP;
+
+	string_list_append(&sorting_options, "objectname");
+	sorting = ref_sorting_options(&sorting_options);
+
+	if (ctx->opts.refs.want_detached)
+		strvec_push(&ctx->refs, "HEAD");
+
+	if (ctx->opts.refs.want_all_refs) {
+		strvec_push(&ctx->refs, "refs/");
+	} else {
+		if (ctx->opts.refs.want_branches)
+			strvec_push(&ctx->refs, "refs/heads/");
+		if (ctx->opts.refs.want_tags)
+			strvec_push(&ctx->refs, "refs/tags/");
+		if (ctx->opts.refs.want_remotes)
+			strvec_push(&ctx->refs, "refs/remotes/");
+		if (ctx->opts.refs.want_other) {
+			strvec_push(&ctx->refs, "refs/notes/");
+			strvec_push(&ctx->refs, "refs/stash/");
+		}
+	}
+
+	filter.name_patterns = ctx->refs.v;
+	filter.ignore_case = 0;
+	filter.match_as_path = 1;
+
+	if (ctx->opts.show_progress) {
+		ctx->progress_total = 0;
+		ctx->progress = start_progress(_("Scanning refs..."), 0);
+	}
+
+	filter_refs(ref_array, &filter, FILTER_REFS_KIND_MASK);
+
+	if (ctx->opts.show_progress) {
+		ctx->progress_total = ref_array->nr;
+		display_progress(ctx->progress, ctx->progress_total);
+	}
+
+	ref_array_sort(sorting, ref_array);
+
+	stop_progress(&ctx->progress);
+	ref_filter_clear(&filter);
+	ref_sorting_release(sorting);
+}
+
+/*
+ * The REFS phase:
+ *
+ * Load the set of requested refs and assess them for scalablity problems.
+ * Use that set to start a treewalk to all reachable objects and assess
+ * them.
+ *
+ * This data will give us insights into the repository itself (the number
+ * of refs, the size and shape of the DAG, the number and size of the
+ * objects).
+ *
+ * Theoretically, this data is independent of the on-disk representation
+ * (e.g. independent of packing concerns).
+ */
+static void survey_phase_refs(struct survey_context *ctx)
+{
+	struct ref_array ref_array = { 0 };
+
+	trace2_region_enter("survey", "phase/refs", ctx->repo);
+	do_load_refs(ctx, &ref_array);
+
+	ctx->report.refs.refs_nr = ref_array.nr;
+	for (size_t i = 0; i < ref_array.nr; i++) {
+		size_t size;
+		struct ref_array_item *item = ref_array.items[i];
+
+		switch (item->kind) {
+		case FILTER_REFS_TAGS:
+			ctx->report.refs.tags_nr++;
+			if (oid_object_info(ctx->repo,
+					    &item->objectname,
+					    &size) == OBJ_TAG)
+				ctx->report.refs.tags_annotated_nr++;
+			break;
+
+		case FILTER_REFS_BRANCHES:
+			ctx->report.refs.branches_nr++;
+			break;
+
+		case FILTER_REFS_REMOTES:
+			ctx->report.refs.remote_refs_nr++;
+			break;
+
+		case FILTER_REFS_OTHERS:
+			ctx->report.refs.others_nr++;
+			break;
+
+		default:
+			ctx->report.refs.unknown_nr++;
+			break;
+		}
+	}
+
+	trace2_region_leave("survey", "phase/refs", ctx->repo);
+
+	ref_array_clear(&ref_array);
 }
 
 int cmd_survey(int argc, const char **argv, const char *prefix)
 {
+	static struct survey_context ctx = {
+		.opts = {
+			.verbose = 0,
+			.show_progress = -1, /* defaults to isatty(2) */
+
+			.refs.want_all_refs = -1,
+
+			.refs.want_branches = -1, /* default these to undefined */
+			.refs.want_tags = -1,
+			.refs.want_remotes = -1,
+			.refs.want_detached = -1,
+			.refs.want_other = -1,
+		},
+		.refs = STRVEC_INIT,
+	};
+
+	static struct option survey_options[] = {
+		OPT__VERBOSE(&ctx.opts.verbose, N_("verbose output")),
+		OPT_BOOL(0, "progress", &ctx.opts.show_progress, N_("show progress")),
+
+		OPT_BOOL_F(0, "all-refs", &ctx.opts.refs.want_all_refs, N_("include all refs"),          PARSE_OPT_NONEG),
+
+		OPT_BOOL_F(0, "branches", &ctx.opts.refs.want_branches, N_("include branches"),          PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "tags",     &ctx.opts.refs.want_tags,     N_("include tags"),              PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "remotes",  &ctx.opts.refs.want_remotes,  N_("include all remotes refs"),  PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "detached", &ctx.opts.refs.want_detached, N_("include detached HEAD"),     PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "other",    &ctx.opts.refs.want_other,    N_("include notes and stashes"), PARSE_OPT_NONEG),
+
+		OPT_END(),
+	};
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(survey_usage, survey_options);
 
-	prepare_repo_settings(the_repository);
-	survey_load_config();
+	ctx.repo = the_repository;
+	prepare_repo_settings(ctx.repo);
+	survey_load_config(&ctx);
 
 	argc = parse_options(argc, argv, prefix, survey_options, survey_usage, 0);
 
-	if (survey_opts.show_progress < 0)
-		survey_opts.show_progress = isatty(2);
-	fixup_refs_wanted();
+	if (ctx.opts.show_progress < 0)
+		ctx.opts.show_progress = isatty(2);
+	fixup_refs_wanted(&ctx);
+
+	survey_phase_refs(&ctx);
 
+	clear_survey_context(&ctx);
 	return 0;
 }
diff --git a/t/t8100-git-survey.sh b/t/t8100-git-survey.sh
index 2df7fa83629..5903c90cb57 100755
--- a/t/t8100-git-survey.sh
+++ b/t/t8100-git-survey.sh
@@ -15,4 +15,13 @@ test_expect_success 'git survey -h shows experimental warning' '
 	grep "EXPERIMENTAL!" usage
 '
 
+test_expect_success 'creat a semi-interesting repo' '
+	test_commit_bulk 10
+'
+
+test_expect_success 'git survey (default)' '
+	git survey >out 2>err &&
+	test_line_count = 0 err
+'
+
 test_done
-- 
gitgitgadget

