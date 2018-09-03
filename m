Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD7611F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeICWcB (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:32:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45437 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICWcA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:32:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id r4-v6so999191lff.12
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PUsHALRDUmSEmNUCKmJp82psRI0cL/UHvl1XHb/WAOs=;
        b=K8pnMijSM5L9rhbVEjml/vlhQUm/GN9uxLtiT9LIRWk8KpXWpANXkK9NLgrgA0s+KT
         HA+y19TAGqD/21Mx6Me/MZiFKbVpc8W5FGmLfYyLnb2ZoXAmzsVIfiFPprREwuWRgre2
         LffodlEfTwe+YcF9ut5ZGh5ICSVFkDYr9GfO3GxKxM9WQr3WuUnLcYfLBm7GXUyIsNZU
         x94N0kt2W5vBd2RxhpA0nVYYzyUcK+iQgdreqfmV2geObTX2hEWSwUTp4+IeSSt2XbcO
         XB/0bzsweiPMY0WFSQezGpyuESzwPHDNc6BV2tzzfs00OYNQDwtnwRdir1BuwvmseXA/
         3QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PUsHALRDUmSEmNUCKmJp82psRI0cL/UHvl1XHb/WAOs=;
        b=jayyr3gWZxaxpKElgc1U6ayQrHpkrawXUiy5gL8Xc5gRILo4urVtygVz+Pub/WF6LS
         rnibhpBufJHbpfwTvX97Znu4XFswHvKAriP3LnBfm7wCLCYzk/5bIm6zTOhBf+1KvaOO
         U1gxmd7aIExaTzfw5z8g+ByvMWCTy/lVf/kzStf+S1L725JFpbq1CG/Zxwc1rKwrQOWl
         BGMKfvG7dxGNBPqscKb7LgzhsmL03RjmTHICVovX4rvBlJ6Z0Oz57UISJgyvMyz2Evc/
         9NZmXqjiXPALAEJWUrQLBdZ8tVxZ97D0GgODUA0Q+z7/9iRLDL5K9/FVltDO5JOPAAR0
         c4sg==
X-Gm-Message-State: APzg51AecgBMWU1s6AGHX+gbGmsLKWRnDcElrxT8LUajmpr332+gKuc8
        OZusdD9rldaoU9230YJvwGw=
X-Google-Smtp-Source: ANB0VdaZ2dY0XTMZCe0kgnPCTimsXbMEehvJoPxaw9HKxUVNLMNCMOW7rBfi+SFcf1q4Lz8LR13slw==
X-Received: by 2002:a19:1d8:: with SMTP id 207-v6mr562131lfb.151.1535998236545;
        Mon, 03 Sep 2018 11:10:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 22/24] revision.c: remove implicit dependency on the_index
Date:   Mon,  3 Sep 2018 20:09:30 +0200
Message-Id: <20180903180932.32260-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"remove" is probably a strong word because the dependency is still
there, hidden behind the_repository. This patch is almost mechanical,
all call sites are updated to take the_repository, no exception.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 bisect.c                         |  4 ++--
 builtin/add.c                    |  4 ++--
 builtin/am.c                     |  6 +++---
 builtin/blame.c                  |  2 +-
 builtin/checkout.c               |  4 ++--
 builtin/commit.c                 |  2 +-
 builtin/describe.c               |  4 ++--
 builtin/diff-files.c             |  2 +-
 builtin/diff-index.c             |  2 +-
 builtin/diff-tree.c              |  2 +-
 builtin/diff.c                   |  2 +-
 builtin/fast-export.c            |  2 +-
 builtin/fmt-merge-msg.c          |  2 +-
 builtin/log.c                    | 16 ++++++++--------
 builtin/merge.c                  |  4 ++--
 builtin/pack-objects.c           |  2 +-
 builtin/prune.c                  |  2 +-
 builtin/reflog.c                 |  2 +-
 builtin/rev-list.c               |  2 +-
 builtin/revert.c                 |  2 +-
 builtin/shortlog.c               |  2 +-
 builtin/submodule--helper.c      |  2 +-
 bundle.c                         |  4 ++--
 diff-lib.c                       |  4 ++--
 http-push.c                      |  2 +-
 merge-recursive.c                |  2 +-
 pack-bitmap-write.c              |  2 +-
 ref-filter.c                     |  2 +-
 remote.c                         |  2 +-
 revision.c                       | 32 ++++++++++++++++++--------------
 revision.h                       | 10 +++++++---
 sequencer.c                      |  8 ++++----
 shallow.c                        |  2 +-
 submodule.c                      |  6 +++---
 t/helper/test-revision-walking.c |  2 +-
 wt-status.c                      | 10 +++++-----
 36 files changed, 84 insertions(+), 76 deletions(-)

diff --git a/bisect.c b/bisect.c
index e1275ba79e..e19c60829c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -632,7 +632,7 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 	struct argv_array rev_argv = ARGV_ARRAY_INIT;
 	int i;
 
-	init_revisions(revs, prefix);
+	init_revisions(revs, the_repository, prefix);
 	revs->abbrev = 0;
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
@@ -889,7 +889,7 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 	struct rev_info opt;
 
 	/* diff-tree init */
-	init_revisions(&opt, prefix);
+	init_revisions(&opt, the_repository, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt.abbrev = 0;
 	opt.diff = 1;
diff --git a/builtin/add.c b/builtin/add.c
index 9916498a29..26e9cba9b6 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -110,7 +110,7 @@ int add_files_to_cache(const char *prefix,
 	memset(&data, 0, sizeof(data));
 	data.flags = flags;
 
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	if (pathspec)
 		copy_pathspec(&rev.prune_data, pathspec);
@@ -232,7 +232,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("Could not read the index"));
 
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	rev.diffopt.context = 7;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/builtin/am.c b/builtin/am.c
index 9b2a2dd0ea..6f0990ad59 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1372,7 +1372,7 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	FILE *fp;
 
 	fp = xfopen(am_path(state, "patch"), "w");
-	init_revisions(&rev_info, NULL);
+	init_revisions(&rev_info, the_repository, NULL);
 	rev_info.diff = 1;
 	rev_info.abbrev = 0;
 	rev_info.disable_stdin = 1;
@@ -1407,7 +1407,7 @@ static void write_index_patch(const struct am_state *state)
 				   the_repository->hash_algo->empty_tree);
 
 	fp = xfopen(am_path(state, "patch"), "w");
-	init_revisions(&rev_info, NULL);
+	init_revisions(&rev_info, the_repository, NULL);
 	rev_info.diff = 1;
 	rev_info.disable_stdin = 1;
 	rev_info.no_commit_id = 1;
@@ -1565,7 +1565,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		struct rev_info rev_info;
 		const char *diff_filter_str = "--diff-filter=AM";
 
-		init_revisions(&rev_info, NULL);
+		init_revisions(&rev_info, the_repository, NULL);
 		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
 		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
 		add_pending_oid(&rev_info, "HEAD", &our_tree, 0);
diff --git a/builtin/blame.c b/builtin/blame.c
index 97632828db..b6ece2c3f5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -830,7 +830,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	revs.date_mode = blame_date_mode;
 	revs.diffopt.flags.allow_textconv = 1;
 	revs.diffopt.flags.follow_renames = 1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cd9be50161..2563f8e1c3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -392,7 +392,7 @@ static void show_local_changes(struct object *head,
 {
 	struct rev_info rev;
 	/* I think we want full paths, even if we're in a subdirectory. */
-	init_revisions(&rev, NULL);
+	init_revisions(&rev, the_repository, NULL);
 	rev.diffopt.flags = opts->flags;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
 	diff_setup_done(&rev.diffopt);
@@ -801,7 +801,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	struct rev_info revs;
 	struct object *object = &old_commit->object;
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
 
 	object->flags &= ~UNINTERESTING;
diff --git a/builtin/commit.c b/builtin/commit.c
index 731e98fd63..cc06b5837c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -980,7 +980,7 @@ static const char *find_author_by_nickname(const char *name)
 	const char *av[20];
 	int ac = 0;
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	strbuf_addf(&buf, "--author=%s", name);
 	av[++ac] = "--all";
 	av[++ac] = "-i";
diff --git a/builtin/describe.c b/builtin/describe.c
index 41606c8a90..4d723665c7 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -488,7 +488,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 		"--objects", "--in-commit-order", "--reverse", "HEAD",
 		NULL);
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
 		BUG("setup_revisions could not handle all args?");
 
@@ -636,7 +636,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			if (0 <= fd)
 				update_index_if_able(&the_index, &index_lock);
 
-			init_revisions(&revs, prefix);
+			init_revisions(&revs, the_repository, prefix);
 			argv_array_pushv(&args, diff_index_args);
 			if (setup_revisions(args.argc, args.argv, &revs, NULL) != 1)
 				BUG("malformed internal diff-index command line");
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index e88493ffe5..0217e9e2bf 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -25,7 +25,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		usage(diff_files_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 522f4fdffd..2c30c5adad 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -22,7 +22,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		usage(diff_cache_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index d07bf2e4c4..e1ebbb8b14 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -110,7 +110,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		usage(diff_tree_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	init_revisions(opt, prefix);
+	init_revisions(opt, the_repository, prefix);
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 	opt->abbrev = 0;
diff --git a/builtin/diff.c b/builtin/diff.c
index ab89b06d18..0313dde133 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -318,7 +318,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_ui_config, NULL);
 	precompose_argv(argc, argv);
 
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 
 	if (no_index && argc != i + 2) {
 		if (no_index == DIFF_NO_INDEX_IMPLICIT) {
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9bd8a14b57..5034b995ba 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1033,7 +1033,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
 
-	init_revisions(&revs, prefix);
+	init_revisions(&revs, the_repository, prefix);
 	init_revision_sources(&revision_sources);
 	revs.topo_order = 1;
 	revs.sources = &revision_sources;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index f35ff1612b..e2a01861d6 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -642,7 +642,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		struct rev_info rev;
 
 		head = lookup_commit_or_die(&head_oid, "HEAD");
-		init_revisions(&rev, NULL);
+		init_revisions(&rev, the_repository, NULL);
 		rev.commit_format = CMIT_FMT_ONELINE;
 		rev.ignore_merges = 1;
 		rev.limited = 1;
diff --git a/builtin/log.c b/builtin/log.c
index 2910122d90..d9d1c22983 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -467,7 +467,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	rev.diff = 1;
 	rev.simplify_history = 0;
 	memset(&opt, 0, sizeof(opt));
@@ -585,7 +585,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	git_config(git_log_config, NULL);
 
 	memset(&match_all, 0, sizeof(match_all));
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	rev.diff = 1;
 	rev.always_show_header = 1;
 	rev.no_walk = REVISION_WALK_NO_WALK_SORTED;
@@ -665,7 +665,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	init_reflog_walk(&rev.reflog_info);
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
@@ -704,7 +704,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
@@ -917,7 +917,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	init_patch_ids(ids, the_repository);
 
 	/* given a range a..b get all patch ids for b..a */
-	init_revisions(&check_rev, rev->prefix);
+	init_revisions(&check_rev, the_repository, rev->prefix);
 	check_rev.max_parents = 1;
 	o1->flags ^= UNINTERESTING;
 	o2->flags ^= UNINTERESTING;
@@ -1367,7 +1367,7 @@ static void prepare_bases(struct base_tree_info *bases,
 
 	oidcpy(&bases->base_commit, &base->object.oid);
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	revs.max_parents = 1;
 	revs.topo_order = 1;
 	for (i = 0; i < total; i++) {
@@ -1528,7 +1528,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_cc.strdup_strings = 1;
 	init_log_defaults();
 	git_config(git_format_config, NULL);
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
@@ -1939,7 +1939,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	init_revisions(&revs, prefix);
+	init_revisions(&revs, the_repository, prefix);
 	revs.max_parents = 1;
 
 	if (add_pending_commit(head, &revs, 0))
diff --git a/builtin/merge.c b/builtin/merge.c
index 432dcbe4cd..6fe511521a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -389,7 +389,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 
 	printf(_("Squash commit -- not updating HEAD\n"));
 
-	init_revisions(&rev, NULL);
+	init_revisions(&rev, the_repository, NULL);
 	rev.ignore_merges = 1;
 	rev.commit_format = CMIT_FMT_MEDIUM;
 
@@ -911,7 +911,7 @@ static int evaluate_result(void)
 	struct rev_info rev;
 
 	/* Check how many files differ. */
-	init_revisions(&rev, "");
+	init_revisions(&rev, the_repository, "");
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |=
 		DIFF_FORMAT_CALLBACK;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d1144a8f7e..aab2e43cd6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2989,7 +2989,7 @@ static void get_object_list(int ac, const char **av)
 	char line[1000];
 	int flags = 0;
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
diff --git a/builtin/prune.c b/builtin/prune.c
index 4916a4daa2..1cea2b2b70 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -120,7 +120,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	read_replace_refs = 0;
 	ref_paranoia = 1;
-	init_revisions(&revs, prefix);
+	init_revisions(&revs, the_repository, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3acef5a0ab..9320228687 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -567,7 +567,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	 * from reflog if the repository was pruned with older git.
 	 */
 	if (cb.cmd.stalefix) {
-		init_revisions(&cb.cmd.revs, prefix);
+		init_revisions(&cb.cmd.revs, the_repository, prefix);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("Marking reachable objects...");
 		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5b07f3f4a2..754cb11717 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -370,7 +370,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		usage(rev_list_usage);
 
 	git_config(git_default_config, NULL);
-	init_revisions(&revs, prefix);
+	init_revisions(&revs, the_repository, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 
diff --git a/builtin/revert.c b/builtin/revert.c
index 9a66720cfc..4db27e9c4b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -174,7 +174,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	} else {
 		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
-		init_revisions(opts->revs, NULL);
+		init_revisions(opts->revs, the_repository, NULL);
 		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3898a2c9c4..22e92a62d6 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -278,7 +278,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b56028ba9d..701f2f42ce 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -792,7 +792,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			 path, NULL);
 
 	git_config(git_diff_basic_config, NULL);
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	rev.abbrev = 0;
 	diff_files_args.argc = setup_revisions(diff_files_args.argc,
 					       diff_files_args.argv,
diff --git a/bundle.c b/bundle.c
index 24cbe40986..05d4b7b4c9 100644
--- a/bundle.c
+++ b/bundle.c
@@ -140,7 +140,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	int i, ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
 		struct object *o = parse_object(the_repository, &e->oid);
@@ -441,7 +441,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* init revs to list objects for pack-objects later */
 	save_commit_buffer = 0;
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 
 	/* write prerequisites */
 	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
diff --git a/diff-lib.c b/diff-lib.c
index c54773fe12..745c2c69ec 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -542,7 +542,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 {
 	struct rev_info revs;
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
 	revs.diffopt = *opt;
 
@@ -557,7 +557,7 @@ int index_differs_from(const char *def, const struct diff_flags *flags,
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	init_revisions(&rev, NULL);
+	init_revisions(&rev, the_repository, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = def;
 	setup_revisions(0, NULL, &rev, &opt);
diff --git a/http-push.c b/http-push.c
index 5eaf551b51..5324b8511d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1925,7 +1925,7 @@ int cmd_main(int argc, const char **argv)
 		if (!push_all && !is_null_oid(&ref->old_oid))
 			argv_array_pushf(&commit_argv, "^%s",
 					 oid_to_hex(&ref->old_oid));
-		init_revisions(&revs, setup_git_directory());
+		init_revisions(&revs, the_repository, setup_git_directory());
 		setup_revisions(commit_argv.argc, commit_argv.argv, &revs, NULL);
 		revs.edge_hint = 0; /* just in case */
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 9e6c7eedc1..733bfd413e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1115,7 +1115,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 	/* get all revisions that merge commit a */
 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
 		  oid_to_hex(&a->object.oid));
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	rev_opts.submodule = path;
 	/* FIXME: can't handle linked worktrees in submodules yet */
 	revs.single_worktree = path != NULL;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index d977e9bacb..9b54195dce 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -261,7 +261,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	if (writer.show_progress)
 		writer.progress = start_progress("Building bitmaps", writer.selected_nr);
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	revs.tag_objects = 1;
 	revs.tree_objects = 1;
 	revs.blob_objects = 1;
diff --git a/ref-filter.c b/ref-filter.c
index 0bccfceff2..05a206f91d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2138,7 +2138,7 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 	struct ref_array *array = ref_cbdata->array;
 	struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 
 	for (i = 0; i < array->nr; i++) {
 		struct ref_array_item *item = array->items[i];
diff --git a/remote.c b/remote.c
index 7f6277a145..d0081e86c0 100644
--- a/remote.c
+++ b/remote.c
@@ -1903,7 +1903,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 			 oid_to_hex(&theirs->object.oid));
 	argv_array_push(&argv, "--");
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	setup_revisions(argv.argc, argv.argv, &revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/revision.c b/revision.c
index d4a539dc69..20c8fd4d1b 100644
--- a/revision.c
+++ b/revision.c
@@ -877,7 +877,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		return;
 
 	left_first = left_count < right_count;
-	init_patch_ids(&ids, the_repository);
+	init_patch_ids(&ids, revs->repo);
 	ids.diffopts.pathspec = revs->diffopt.pathspec;
 
 	/* Compute patch-ids for one side */
@@ -1370,8 +1370,8 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 {
 	struct worktree **worktrees, **p;
 
-	read_cache();
-	do_add_index_objects_to_pending(revs, &the_index);
+	read_index(revs->repo->index);
+	do_add_index_objects_to_pending(revs, revs->repo->index);
 
 	if (revs->single_worktree)
 		return;
@@ -1439,10 +1439,13 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 	return 1;
 }
 
-void init_revisions(struct rev_info *revs, const char *prefix)
+void init_revisions(struct rev_info *revs,
+		    struct repository *repo,
+		    const char *prefix)
 {
 	memset(revs, 0, sizeof(*revs));
 
+	revs->repo = repo;
 	revs->abbrev = DEFAULT_ABBREV;
 	revs->ignore_merges = 1;
 	revs->simplify_history = 1;
@@ -1464,11 +1467,11 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->commit_format = CMIT_FMT_DEFAULT;
 	revs->expand_tabs_in_log_default = 8;
 
-	init_grep_defaults(the_repository);
-	grep_init(&revs->grep_filter, the_repository, prefix);
+	init_grep_defaults(revs->repo);
+	grep_init(&revs->grep_filter, revs->repo, prefix);
 	revs->grep_filter.status_only = 1;
 
-	diff_setup(&revs->diffopt, the_repository);
+	diff_setup(&revs->diffopt, revs->repo);
 	if (prefix && !revs->diffopt.prefix) {
 		revs->diffopt.prefix = prefix;
 		revs->diffopt.prefix_length = strlen(prefix);
@@ -1496,6 +1499,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	struct object_id oid;
 	const char **prune = NULL;
 	int i, prune_num = 1; /* counting terminating NULL */
+	struct index_state *istate = revs->repo->index;
 
 	if (get_oid("HEAD", &oid))
 		die("--merge without HEAD?");
@@ -1511,20 +1515,20 @@ static void prepare_show_merge(struct rev_info *revs)
 	free_commit_list(bases);
 	head->object.flags |= SYMMETRIC_LEFT;
 
-	if (!active_nr)
-		read_cache();
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	if (!istate->cache_nr)
+		read_index(istate);
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
 			continue;
-		if (ce_path_match(&the_index, ce, &revs->prune_data, NULL)) {
+		if (ce_path_match(istate, ce, &revs->prune_data, NULL)) {
 			prune_num++;
 			REALLOC_ARRAY(prune, prune_num);
 			prune[prune_num-2] = ce->name;
 			prune[prune_num-1] = NULL;
 		}
-		while ((i+1 < active_nr) &&
-		       ce_same_name(ce, active_cache[i+1]))
+		while ((i+1 < istate->cache_nr) &&
+		       ce_same_name(ce, istate->cache[i+1]))
 			i++;
 	}
 	clear_pathspec(&revs->prune_data);
diff --git a/revision.h b/revision.h
index 007278cc11..a47064cd37 100644
--- a/revision.h
+++ b/revision.h
@@ -28,8 +28,9 @@
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
 
-struct rev_info;
 struct log_info;
+struct repository;
+struct rev_info;
 struct string_list;
 struct saved_parents;
 define_shared_commit_slab(revision_sources, char *);
@@ -60,6 +61,7 @@ struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
 	struct object_array pending;
+	struct repository *repo;
 
 	/* Parents of shown commits */
 	struct object_array boundary_commits;
@@ -248,12 +250,14 @@ extern volatile show_early_output_fn_t show_early_output;
 struct setup_revision_opt {
 	const char *def;
 	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
-	const char *submodule;
+	const char *submodule;	/* TODO: drop this and use rev_info->repo */
 	int assume_dashdash;
 	unsigned revarg_opt;
 };
 
-void init_revisions(struct rev_info *revs, const char *prefix);
+void init_revisions(struct rev_info *revs,
+		    struct repository *repo,
+		    const char *prefix);
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
 void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
diff --git a/sequencer.c b/sequencer.c
index 49cd9aaad1..038cc62870 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1143,7 +1143,7 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	strbuf_release(&author_ident);
 	strbuf_release(&committer_ident);
 
-	init_revisions(&rev, prefix);
+	init_revisions(&rev, the_repository, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 
 	rev.diff = 1;
@@ -2566,7 +2566,7 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
 
 	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
-	init_revisions(&log_tree_opt, NULL);
+	init_revisions(&log_tree_opt, the_repository, NULL);
 	log_tree_opt.abbrev = 0;
 	log_tree_opt.diff = 1;
 	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
@@ -3477,7 +3477,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			struct object_id orig, head;
 
 			memset(&log_tree_opt, 0, sizeof(log_tree_opt));
-			init_revisions(&log_tree_opt, NULL);
+			init_revisions(&log_tree_opt, the_repository, NULL);
 			log_tree_opt.diff = 1;
 			log_tree_opt.diffopt.output_format =
 				DIFF_FORMAT_DIFFSTAT;
@@ -4212,7 +4212,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	revs.verbose_header = 1;
 	if (!rebase_merges)
 		revs.max_parents = 1;
diff --git a/shallow.c b/shallow.c
index dbe8a2a290..92bbb22117 100644
--- a/shallow.c
+++ b/shallow.c
@@ -184,7 +184,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 
 	is_repository_shallow(the_repository); /* make sure shallows are read */
 
-	init_revisions(&revs, NULL);
+	init_revisions(&revs, the_repository, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
diff --git a/submodule.c b/submodule.c
index c0c1224760..841315ec63 100644
--- a/submodule.c
+++ b/submodule.c
@@ -428,7 +428,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 {
 	struct commit_list *list;
 
-	init_revisions(rev, NULL);
+	init_revisions(rev, the_repository, NULL);
 	setup_revisions(0, NULL, rev, NULL);
 	rev->left_right = 1;
 	rev->first_parent_only = 1;
@@ -773,7 +773,7 @@ static void collect_changed_submodules(struct index_state *istate,
 	struct rev_info rev;
 	const struct commit *commit;
 
-	init_revisions(&rev, NULL);
+	init_revisions(&rev, the_repository, NULL);
 	setup_revisions(argv->argc, argv->argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
@@ -784,7 +784,7 @@ static void collect_changed_submodules(struct index_state *istate,
 		data.changed = changed;
 		data.commit_oid = &commit->object.oid;
 
-		init_revisions(&diff_rev, NULL);
+		init_revisions(&diff_rev, the_repository, NULL);
 		diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 		diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
 		diff_rev.diffopt.format_callback_data = &data;
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 4f8bc75821..58cad3bbae 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -32,7 +32,7 @@ static int run_revision_walk(void)
 	int argc = ARRAY_SIZE(argv) - 1;
 	int got_revision = 0;
 
-	init_revisions(&rev, NULL);
+	init_revisions(&rev, the_repository, NULL);
 	setup_revisions(argc, argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
diff --git a/wt-status.c b/wt-status.c
index 5ffab61015..29bcfab3eb 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -582,7 +582,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 {
 	struct rev_info rev;
 
-	init_revisions(&rev, NULL);
+	init_revisions(&rev, the_repository, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.flags.dirty_submodules = 1;
@@ -607,7 +607,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	init_revisions(&rev, NULL);
+	init_revisions(&rev, the_repository, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
@@ -982,7 +982,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	int dirty_submodules;
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	init_revisions(&rev, NULL);
+	init_revisions(&rev, the_repository, NULL);
 	rev.diffopt.flags.allow_textconv = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 
@@ -2314,7 +2314,7 @@ int has_unstaged_changes(int ignore_submodules)
 	struct rev_info rev_info;
 	int result;
 
-	init_revisions(&rev_info, NULL);
+	init_revisions(&rev_info, the_repository, NULL);
 	if (ignore_submodules) {
 		rev_info.diffopt.flags.ignore_submodules = 1;
 		rev_info.diffopt.flags.override_submodule_config = 1;
@@ -2336,7 +2336,7 @@ int has_uncommitted_changes(int ignore_submodules)
 	if (is_cache_unborn())
 		return 0;
 
-	init_revisions(&rev_info, NULL);
+	init_revisions(&rev_info, the_repository, NULL);
 	if (ignore_submodules)
 		rev_info.diffopt.flags.ignore_submodules = 1;
 	rev_info.diffopt.flags.quick = 1;
-- 
2.19.0.rc0.337.ge906d732e7

