From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/4] parse-opts: prepare for OPT_FILENAME
Date: Sat, 23 May 2009 11:53:12 -0700
Message-ID: <1243104793-3254-4-git-send-email-bebarino@gmail.com>
References: <1243104793-3254-1-git-send-email-bebarino@gmail.com>
 <1243104793-3254-2-git-send-email-bebarino@gmail.com>
 <1243104793-3254-3-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 20:53:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wLs-0007xZ-Su
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 20:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbZEWSxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 14:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbZEWSxa
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 14:53:30 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:43464 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbZEWSx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 14:53:28 -0400
Received: by rv-out-0506.google.com with SMTP id f9so787841rvb.1
        for <git@vger.kernel.org>; Sat, 23 May 2009 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=URqhwiqlrzM1dvAsl2ULL39euV85HveqPJROCGFi6aU=;
        b=Q1854TvT/hQh+ZG5Y+HhwZ2v7+mI3bB7pV7x7mc/k40ONKqKJftGrIEIHSMIVL8n2L
         RnYkjriD7AqnEzShBXjtTfUp47lSghOrOo73VYwcEmT3T0NxZmQIz7oz2z2W177Q2jwH
         LH/ek7gZqRzKHoxtpDOhyJPQXDOMJljFMKSNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VQcwoHxvJIA+B5kwMHU/n7WYaxXXKjrgqEkbgWhjHXRXVYyWUXHryHlQzY67UVrklu
         Y+W/geF5Nj2F89hKYCwFW1lU7fpbr12mPnOW98F/tsIySIR2MVseY9+czwR2wUcmoJwL
         +sq5Z7r86YpbKwF4ofpuTCCv9gN+wzVqWBXvg=
Received: by 10.141.82.20 with SMTP id j20mr2099954rvl.54.1243104809419;
        Sat, 23 May 2009 11:53:29 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id f42sm13841025rvb.51.2009.05.23.11.53.26
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 11:53:28 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 23 May 2009 11:53:25 -0700
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243104793-3254-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119786>

To give OPT_FILENAME the prefix, we pass the prefix to parse_options()
which passes the prefix to parse_options_start() which sets the prefix
member of parse_opts_ctx accordingly. If there isn't a prefix in the
calling context, passing NULL will suffice.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

This is mostly passing prefix through.

 Documentation/technical/api-parse-options.txt |    4 ++--
 archive.c                                     |    2 +-
 builtin-add.c                                 |    2 +-
 builtin-apply.c                               |    2 +-
 builtin-archive.c                             |    3 ++-
 builtin-bisect--helper.c                      |    3 ++-
 builtin-blame.c                               |    2 +-
 builtin-branch.c                              |    3 ++-
 builtin-cat-file.c                            |    2 +-
 builtin-check-attr.c                          |    4 ++--
 builtin-checkout-index.c                      |    2 +-
 builtin-checkout.c                            |    2 +-
 builtin-clean.c                               |    3 ++-
 builtin-clone.c                               |    2 +-
 builtin-commit.c                              |    3 ++-
 builtin-config.c                              |    3 ++-
 builtin-count-objects.c                       |    2 +-
 builtin-describe.c                            |    2 +-
 builtin-fast-export.c                         |    2 +-
 builtin-fetch.c                               |    2 +-
 builtin-fmt-merge-msg.c                       |    3 ++-
 builtin-for-each-ref.c                        |    2 +-
 builtin-fsck.c                                |    2 +-
 builtin-gc.c                                  |    3 ++-
 builtin-grep.c                                |    2 +-
 builtin-help.c                                |    2 +-
 builtin-ls-files.c                            |    2 +-
 builtin-merge-base.c                          |    2 +-
 builtin-merge-file.c                          |    2 +-
 builtin-merge.c                               |    4 ++--
 builtin-mv.c                                  |    3 ++-
 builtin-name-rev.c                            |    2 +-
 builtin-pack-refs.c                           |    2 +-
 builtin-prune.c                               |    2 +-
 builtin-push.c                                |    2 +-
 builtin-remote.c                              |   16 ++++++++++------
 builtin-reset.c                               |    2 +-
 builtin-rev-parse.c                           |    4 ++--
 builtin-revert.c                              |    2 +-
 builtin-rm.c                                  |    3 ++-
 builtin-shortlog.c                            |    2 +-
 builtin-symbolic-ref.c                        |    3 ++-
 builtin-tag.c                                 |    2 +-
 builtin-update-ref.c                          |    3 ++-
 hash-object.c                                 |    3 ++-
 parse-options.c                               |   11 +++++++----
 parse-options.h                               |    6 ++++--
 test-parse-options.c                          |    2 +-
 48 files changed, 83 insertions(+), 61 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index b43458e..aace580 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -60,13 +60,13 @@ Steps to parse options
 . in `cmd_foo(int argc, const char **argv, const char *prefix)`
   call
 
-	argc = parse_options(argc, argv, builtin_foo_options, builtin_foo_usage, flags);
+	argc = parse_options(argc, argv, prefix, builtin_foo_options, builtin_foo_usage, flags);
 +
 `parse_options()` will filter out the processed options of `argv[]` and leave the
 non-option arguments in `argv[]`.
 `argc` is updated appropriately because of the assignment.
 +
-You can also pass NULL instead of a usage array as fourth parameter of
+You can also pass NULL instead of a usage array as the fifth parameter of
 parse_options(), to avoid displaying a help screen with usage info and
 option list.  This should only be done if necessary, e.g. to implement
 a limited parser for only a subset of the options that needs to be run
diff --git a/archive.c b/archive.c
index b2b90d3..0bca9ca 100644
--- a/archive.c
+++ b/archive.c
@@ -309,7 +309,7 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, opts, archive_usage, 0);
+	argc = parse_options(argc, argv, NULL, opts, archive_usage, 0);
 
 	if (remote)
 		die("Unexpected option --remote");
diff --git a/builtin-add.c b/builtin-add.c
index bee45f0..c1b229a 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -298,7 +298,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 
-	argc = parse_options(argc, argv, builtin_add_options,
+	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
 	if (patch_interactive)
 		add_interactive = 1;
diff --git a/builtin-apply.c b/builtin-apply.c
index a40b982..bac03d7 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -3313,7 +3313,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 	if (apply_default_whitespace)
 		parse_whitespace_option(apply_default_whitespace);
 
-	argc = parse_options(argc, argv, builtin_apply_options,
+	argc = parse_options(argc, argv, prefix, builtin_apply_options,
 			apply_usage, 0);
 	fake_ancestor = parse_options_fix_filename(prefix, fake_ancestor);
 	if (fake_ancestor)
diff --git a/builtin-archive.c b/builtin-archive.c
index ab50ceb..3c5a5a7 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -80,7 +80,8 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, local_opts, NULL, PARSE_OPT_KEEP_ALL);
+	argc = parse_options(argc, argv, prefix, local_opts, NULL,
+			     PARSE_OPT_KEEP_ALL);
 
 	if (output)
 		create_output_file(output);
diff --git a/builtin-bisect--helper.c b/builtin-bisect--helper.c
index cb3e155..5b22639 100644
--- a/builtin-bisect--helper.c
+++ b/builtin-bisect--helper.c
@@ -17,7 +17,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, options, git_bisect_helper_usage, 0);
+	argc = parse_options(argc, argv, prefix, options,
+			     git_bisect_helper_usage, 0);
 
 	if (!next_all)
 		usage_with_options(git_bisect_helper_usage, options);
diff --git a/builtin-blame.c b/builtin-blame.c
index cf74a92..9dc3335 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2229,7 +2229,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
 
-	parse_options_start(&ctx, argc, argv, PARSE_OPT_KEEP_DASHDASH |
+	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH |
 			    PARSE_OPT_KEEP_ARGV0);
 	for (;;) {
 		switch (parse_options_step(&ctx, options, blame_opt_usage)) {
diff --git a/builtin-branch.c b/builtin-branch.c
index 6aaa708..5687d60 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -610,7 +610,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	}
 	hashcpy(merge_filter_ref, head_sha1);
 
-	argc = parse_options(argc, argv, options, builtin_branch_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
+			     0);
 	if (!!delete + !!rename + !!force_create > 1)
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 8fad19d..991e40f 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -231,7 +231,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	if (argc != 3 && argc != 2)
 		usage_with_options(cat_file_usage, options);
 
-	argc = parse_options(argc, argv, options, cat_file_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
 
 	if (opt) {
 		if (argc == 1)
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 15a04b7..8bd0430 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -69,8 +69,8 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	int cnt, i, doubledash;
 	const char *errstr = NULL;
 
-	argc = parse_options(argc, argv, check_attr_options, check_attr_usage,
-		PARSE_OPT_KEEP_DASHDASH);
+	argc = parse_options(argc, argv, prefix, check_attr_options,
+			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 	if (!argc)
 		usage_with_options(check_attr_usage, check_attr_options);
 
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index afe35e2..a7a5ee1 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -249,7 +249,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		die("invalid cache");
 	}
 
-	argc = parse_options(argc, argv, builtin_checkout_index_options,
+	argc = parse_options(argc, argv, prefix, builtin_checkout_index_options,
 			builtin_checkout_index_usage, 0);
 	state.force = force;
 	state.quiet = quiet;
diff --git a/builtin-checkout.c b/builtin-checkout.c
index b8a4b01..8a9a474 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -605,7 +605,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
 
-	argc = parse_options(argc, argv, options, checkout_usage,
+	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	/* --track without -b should DWIM */
diff --git a/builtin-clean.c b/builtin-clean.c
index c5ad33d..1c1b6d2 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -56,7 +56,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	else
 		config_set = 1;
 
-	argc = parse_options(argc, argv, options, builtin_clean_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
+			     0);
 
 	memset(&dir, 0, sizeof(dir));
 	if (ignored_only)
diff --git a/builtin-clone.c b/builtin-clone.c
index c935833..5c46496 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -360,7 +360,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	junk_pid = getpid();
 
-	argc = parse_options(argc, argv, builtin_clone_options,
+	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
 	if (argc == 0)
diff --git a/builtin-commit.c b/builtin-commit.c
index baaa75c..b9a1528 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -697,7 +697,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 {
 	int f = 0;
 
-	argc = parse_options(argc, argv, builtin_commit_options, usage, 0);
+	argc = parse_options(argc, argv, prefix, builtin_commit_options, usage,
+			     0);
 	logfile = parse_options_fix_filename(prefix, logfile);
 	if (logfile)
 		logfile = xstrdup(logfile);
diff --git a/builtin-config.c b/builtin-config.c
index a81bc8b..60915f9 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -316,7 +316,8 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 
 	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
 
-	argc = parse_options(argc, argv, builtin_config_options, builtin_config_usage,
+	argc = parse_options(argc, argv, prefix, builtin_config_options,
+			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (use_global_config + use_system_config + !!given_config_file > 1) {
diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index b814fe5..1b0b6c8 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -83,7 +83,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, opts, count_objects_usage, 0);
+	argc = parse_options(argc, argv, prefix, opts, count_objects_usage, 0);
 	/* we do not take arguments other than flags for now */
 	if (argc)
 		usage_with_options(count_objects_usage, opts);
diff --git a/builtin-describe.c b/builtin-describe.c
index 63c6a19..7a66298 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -322,7 +322,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, options, describe_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, describe_usage, 0);
 	if (max_candidates < 0)
 		max_candidates = 0;
 	else if (max_candidates > MAX_TAGS)
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 6731713..6cef810 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -515,7 +515,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&revs, prefix);
 	argc = setup_revisions(argc, argv, &revs, NULL);
-	argc = parse_options(argc, argv, options, fast_export_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, fast_export_usage, 0);
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
 
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 77acabf..0ed6016 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -634,7 +634,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
-	argc = parse_options(argc, argv,
+	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
 	if (argc == 0)
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index fae1482..d4c7206 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -360,7 +360,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	int ret;
 
 	git_config(fmt_merge_msg_config, NULL);
-	argc = parse_options(argc, argv, options, fmt_merge_msg_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
+			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
 	inpath = parse_options_fix_filename(prefix, inpath);
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index d091e04..784733b 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -905,7 +905,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	parse_options(argc, argv, opts, for_each_ref_usage, 0);
+	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
 	if (maxcount < 0) {
 		error("invalid --count argument: `%d'", maxcount);
 		usage_with_options(for_each_ref_usage, opts);
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 6436bc2..7da706c 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -590,7 +590,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	errors_found = 0;
 
-	argc = parse_options(argc, argv, fsck_opts, fsck_usage, 0);
+	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
 	if (write_lost_and_found) {
 		check_full = 1;
 		include_reflogs = 0;
diff --git a/builtin-gc.c b/builtin-gc.c
index fc556ed..7d3e9cc 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -194,7 +194,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (pack_refs < 0)
 		pack_refs = !is_bare_repository();
 
-	argc = parse_options(argc, argv, builtin_gc_options, builtin_gc_usage, 0);
+	argc = parse_options(argc, argv, prefix, builtin_gc_options,
+			     builtin_gc_usage, 0);
 	if (argc > 0)
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
 
diff --git a/builtin-grep.c b/builtin-grep.c
index 5308b34..73fc922 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -765,7 +765,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	 * unrecognized non option is the beginning of the refs list
 	 * that continues up to the -- (if exists), and then paths.
 	 */
-	argc = parse_options(argc, argv, options, grep_usage,
+	argc = parse_options(argc, argv, prefix, options, grep_usage,
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
diff --git a/builtin-help.c b/builtin-help.c
index 67dda3e..af565fb 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -423,7 +423,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	setup_git_directory_gently(&nongit);
 	git_config(git_help_config, NULL);
 
-	argc = parse_options(argc, argv, builtin_help_options,
+	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
 
 	if (show_all) {
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 3d59b0e..2312866 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -486,7 +486,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		prefix_offset = strlen(prefix);
 	git_config(git_default_config, NULL);
 
-	argc = parse_options(argc, argv, builtin_ls_files_options,
+	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	if (show_tag || show_valid_bit) {
 		tag_cached = "H ";
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index 03fc1c2..a6ec2f7 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -53,7 +53,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, options, merge_base_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, merge_base_usage, 0);
 	if (argc < 2)
 		usage_with_options(merge_base_usage, options);
 	rev = xmalloc(argc * sizeof(*rev));
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 96edb97..afd2ea7 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -48,7 +48,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			merge_style = git_xmerge_style;
 	}
 
-	argc = parse_options(argc, argv, options, merge_file_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, merge_file_usage, 0);
 	if (argc != 3)
 		usage_with_options(merge_file_usage, options);
 	if (quiet) {
diff --git a/builtin-merge.c b/builtin-merge.c
index 0b58e5e..8d101ef 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -462,7 +462,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
 		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
 		argc++;
-		parse_options(argc, argv, builtin_merge_options,
+		parse_options(argc, argv, NULL, builtin_merge_options,
 			      builtin_merge_usage, 0);
 		free(buf);
 	}
@@ -855,7 +855,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
 
-	argc = parse_options(argc, argv, builtin_merge_options,
+	argc = parse_options(argc, argv, prefix, builtin_merge_options,
 			builtin_merge_usage, 0);
 	if (verbosity < 0)
 		show_diffstat = 0;
diff --git a/builtin-mv.c b/builtin-mv.c
index 01270fe..8b81d4b 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -72,7 +72,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	argc = parse_options(argc, argv, builtin_mv_options, builtin_mv_usage, 0);
+	argc = parse_options(argc, argv, prefix, builtin_mv_options,
+			     builtin_mv_usage, 0);
 	if (--argc < 1)
 		usage_with_options(builtin_mv_usage, builtin_mv_options);
 
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 08c8aab..06a38ac 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -238,7 +238,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, opts, name_rev_usage, 0);
+	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
 	if (!!all + !!transform_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 34246df..091860b 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -15,7 +15,7 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "prune", &flags, "prune loose refs (default)", PACK_REFS_PRUNE),
 		OPT_END(),
 	};
-	if (parse_options(argc, argv, opts, pack_refs_usage, 0))
+	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
 	return pack_refs(flags);
 }
diff --git a/builtin-prune.c b/builtin-prune.c
index 145ba83..0ed9cce 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -142,7 +142,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	init_revisions(&revs, prefix);
 
-	argc = parse_options(argc, argv, options, prune_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
 	while (argc--) {
 		unsigned char sha1[20];
 		const char *name = *argv++;
diff --git a/builtin-push.c b/builtin-push.c
index 2eabcd3..c869974 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -198,7 +198,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, options, push_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
 	if (tags)
 		add_refspec("refs/tags/*");
diff --git a/builtin-remote.c b/builtin-remote.c
index 71abf68..13d5db1 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -79,7 +79,8 @@ static int add(int argc, const char **argv)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+			     0);
 
 	if (argc < 2)
 		usage_with_options(builtin_remote_usage, options);
@@ -986,7 +987,8 @@ static int show(int argc, const char **argv)
 	struct string_list info_list = { NULL, 0, 0, 0 };
 	struct show_info info;
 
-	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+			     0);
 
 	if (argc < 1)
 		return show_all();
@@ -1076,7 +1078,8 @@ static int set_head(int argc, const char **argv)
 			    "delete refs/remotes/<name>/HEAD"),
 		OPT_END()
 	};
-	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+			     0);
 	if (argc)
 		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
 
@@ -1130,7 +1133,8 @@ static int prune(int argc, const char **argv)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+			     0);
 
 	if (argc < 1)
 		usage_with_options(builtin_remote_usage, options);
@@ -1220,7 +1224,7 @@ static int update(int argc, const char **argv)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
 			     PARSE_OPT_KEEP_ARGV0);
 	if (argc < 2) {
 		argc = 2;
@@ -1306,7 +1310,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 	};
 	int result;
 
-	argc = parse_options(argc, argv, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, prefix, options, builtin_remote_usage,
 		PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc < 1)
diff --git a/builtin-reset.c b/builtin-reset.c
index 7e7ebab..5fa1789 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -203,7 +203,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	argc = parse_options(argc, argv, options, git_reset_usage,
+	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
 	reflog_action = args_to_str(argv);
 	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index c5b3d6e..112d622 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -318,7 +318,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	int onb = 0, osz = 0, unb = 0, usz = 0;
 
 	strbuf_addstr(&parsed, "set --");
-	argc = parse_options(argc, argv, parseopt_opts, parseopt_usage,
+	argc = parse_options(argc, argv, prefix, parseopt_opts, parseopt_usage,
 	                     PARSE_OPT_KEEP_DASHDASH);
 	if (argc < 1 || strcmp(argv[0], "--"))
 		usage_with_options(parseopt_usage, parseopt_opts);
@@ -393,7 +393,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	/* put an OPT_END() */
 	ALLOC_GROW(opts, onb + 1, osz);
 	memset(opts + onb, 0, sizeof(opts[onb]));
-	argc = parse_options(argc, argv, opts, usage,
+	argc = parse_options(argc, argv, prefix, opts, usage,
 	                     keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0);
 
 	strbuf_addf(&parsed, " --");
diff --git a/builtin-revert.c b/builtin-revert.c
index 3f2614e..fa4752f 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -60,7 +60,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_END(),
 	};
 
-	if (parse_options(argc, argv, options, usage_str, 0) != 1)
+	if (parse_options(argc, argv, NULL, options, usage_str, 0) != 1)
 		usage_with_options(usage_str, options);
 	arg = argv[0];
 
diff --git a/builtin-rm.c b/builtin-rm.c
index 269d608..0cc4912 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -157,7 +157,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	argc = parse_options(argc, argv, builtin_rm_options, builtin_rm_usage, 0);
+	argc = parse_options(argc, argv, prefix, builtin_rm_options,
+			     builtin_rm_usage, 0);
 	if (!argc)
 		usage_with_options(builtin_rm_usage, builtin_rm_options);
 
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index b28091b..6a3812e 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -263,7 +263,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
 	init_revisions(&rev, prefix);
-	parse_options_start(&ctx, argc, argv, PARSE_OPT_KEEP_DASHDASH |
+	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH |
 			    PARSE_OPT_KEEP_ARGV0);
 
 	for (;;) {
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index 6ae6bcc..ca855a5 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -36,7 +36,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, options, git_symbolic_ref_usage, 0);
+	argc = parse_options(argc, argv, prefix, options,
+			     git_symbolic_ref_usage, 0);
 	if (msg &&!*msg)
 		die("Refusing to perform update with empty message");
 	switch (argc) {
diff --git a/builtin-tag.c b/builtin-tag.c
index e544430..6e8b464 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -405,7 +405,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	git_config(git_tag_config, NULL);
 
-	argc = parse_options(argc, argv, options, git_tag_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 	msgfile = parse_options_fix_filename(prefix, msgfile);
 
 	if (keyid) {
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 378dc1b..76ba1d5 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -23,7 +23,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, options, git_update_ref_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, git_update_ref_usage,
+			     0);
 	if (msg && !*msg)
 		die("Refusing to perform update with empty message.");
 
diff --git a/hash-object.c b/hash-object.c
index ebb3bed..47cf43c 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -84,7 +84,8 @@ int main(int argc, const char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
-	argc = parse_options(argc, argv, hash_object_options, hash_object_usage, 0);
+	argc = parse_options(argc, argv, NULL, hash_object_options,
+			     hash_object_usage, 0);
 
 	if (write_object) {
 		prefix = setup_git_directory();
diff --git a/parse-options.c b/parse-options.c
index c52b8cc..bfeb9d3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -285,12 +285,14 @@ static void check_typos(const char *arg, const struct option *options)
 }
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
-			 int argc, const char **argv, int flags)
+			 int argc, const char **argv, const char *prefix,
+			 int flags)
 {
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->argc = argc - 1;
 	ctx->argv = argv + 1;
 	ctx->out  = argv;
+	ctx->prefix = prefix;
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
@@ -389,12 +391,13 @@ int parse_options_end(struct parse_opt_ctx_t *ctx)
 	return ctx->cpidx + ctx->argc;
 }
 
-int parse_options(int argc, const char **argv, const struct option *options,
-		  const char * const usagestr[], int flags)
+int parse_options(int argc, const char **argv, const char *prefix,
+		  const struct option *options, const char * const usagestr[],
+		  int flags)
 {
 	struct parse_opt_ctx_t ctx;
 
-	parse_options_start(&ctx, argc, argv, flags);
+	parse_options_start(&ctx, argc, argv, prefix, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
 		exit(129);
diff --git a/parse-options.h b/parse-options.h
index 919b9b4..624f192 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -118,7 +118,7 @@ struct option {
  * non-option arguments in argv[].
  * Returns the number of arguments left in argv[].
  */
-extern int parse_options(int argc, const char **argv,
+extern int parse_options(int argc, const char **argv, const char *prefix,
                          const struct option *options,
                          const char * const usagestr[], int flags);
 
@@ -144,13 +144,15 @@ struct parse_opt_ctx_t {
 	int argc, cpidx;
 	const char *opt;
 	int flags;
+	const char *prefix;
 };
 
 extern int parse_options_usage(const char * const *usagestr,
 			       const struct option *opts);
 
 extern void parse_options_start(struct parse_opt_ctx_t *ctx,
-				int argc, const char **argv, int flags);
+				int argc, const char **argv, const char *prefix,
+				int flags);
 
 extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 			      const struct option *options,
diff --git a/test-parse-options.c b/test-parse-options.c
index e0669dc..da3d658 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -65,7 +65,7 @@ int main(int argc, const char **argv)
 	};
 	int i;
 
-	argc = parse_options(argc, argv, options, usage, 0);
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
 
 	printf("boolean: %d\n", boolean);
 	printf("integer: %u\n", integer);
-- 
1.6.3.1.145.gb74d77
