From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC v2 2/2] use the new git_default_config()
Date: Wed, 13 Aug 2014 19:09:49 +0530
Message-ID: <53EB6AA5.7070706@gmail.com>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>	<vpqppg4vdii.fsf@anie.imag.fr> <53EB58A0.10307@gmail.com> <vpq4mxgtu07.fsf@anie.imag.fr> <53EB6914.2030807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 13 15:40:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHYmZ-0002ux-8I
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 15:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbaHMNj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 09:39:58 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:55775 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbaHMNj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 09:39:56 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so14388972pdb.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=c5R34RPTuT1QSYlYVYPE6lGJK+ND/Ak2V/UB/ZyB5uQ=;
        b=k94Klj5USr2f6EKbHXl4AKl7hHy2vaHCqArEThzWeDJptSCVN8GnheRWmkK3/8eZzl
         njggRzWebFeGubyg/dMxIqo6NzNrygDJzLOCQjdo0u+SOMwe3FJZDeizSKQSbOXqi/Ma
         OpP9i02gPoB34ebv2/b1pAeIrXJcTPVYecqVvbnxI3jHo6NFwCVs53C8xvIpap7nHLmJ
         2jmcDZZoHadOcPBcgbk9mB194b20CyQmwWnACJvLNT8Gf7EKHAeZ29m0tyO1l2UJR0FA
         haUZm9Ny2695ulbhwKSVc+IbaNAbjZVQ8izBRZyLbgRmErhZ5XDNe5Hjr7CSvxQrdjRY
         mmJw==
X-Received: by 10.70.35.67 with SMTP id f3mr4212553pdj.34.1407937195866;
        Wed, 13 Aug 2014 06:39:55 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.223.107])
        by mx.google.com with ESMTPSA id sm4sm7061999pab.7.2014.08.13.06.39.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Aug 2014 06:39:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53EB6914.2030807@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255211>

If we change the signature to void git_default_config(void),
we would have to use a patch like this to change the call sites
of the function. This patch is just for illustrative purpose,
I couldn't finalize if this was unnecessary code cruft or
a valid approach.

---
 builtin/check-attr.c         | 2 +-
 builtin/check-ignore.c       | 2 +-
 builtin/check-mailmap.c      | 2 +-
 builtin/checkout-index.c     | 2 +-
 builtin/clone.c              | 2 +-
 builtin/config.c             | 2 +-
 builtin/describe.c           | 2 +-
 builtin/fast-export.c        | 2 +-
 builtin/for-each-ref.c       | 2 +-
 builtin/hash-object.c        | 2 +-
 builtin/init-db.c            | 2 +-
 builtin/ls-files.c           | 2 +-
 builtin/ls-tree.c            | 2 +-
 builtin/merge-base.c         | 2 +-
 builtin/mv.c                 | 2 +-
 builtin/name-rev.c           | 2 +-
 builtin/notes.c              | 2 +-
 builtin/push.c               | 2 +-
 builtin/read-tree.c          | 2 +-
 builtin/reset.c              | 2 +-
 builtin/rev-list.c           | 2 +-
 builtin/rev-parse.c          | 2 +-
 builtin/revert.c             | 4 ++--
 builtin/rm.c                 | 2 +-
 builtin/shortlog.c           | 2 +-
 builtin/stripspace.c         | 2 +-
 builtin/symbolic-ref.c       | 2 +-
 builtin/unpack-file.c        | 2 +-
 builtin/unpack-objects.c     | 2 +-
 builtin/update-index.c       | 2 +-
 builtin/update-ref.c         | 2 +-
 builtin/update-server-info.c | 2 +-
 builtin/var.c                | 2 +-
 builtin/verify-pack.c        | 2 +-
 builtin/write-tree.c         | 2 +-
 http-fetch.c                 | 2 +-
 pager.c                      | 2 +-
 37 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 5600ec3..e2d7826 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -105,7 +105,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	if (!is_bare_repository())
 		setup_work_tree();

-	git_config(git_default_config, NULL);
+	git_default_config();

 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 594463a..c14c977 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -144,7 +144,7 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 	int num_ignored;
 	struct dir_struct dir;

-	git_config(git_default_config, NULL);
+	git_default_config();

 	argc = parse_options(argc, argv, prefix, check_ignore_options,
 			     check_ignore_usage, 0);
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 8f4d809..f9d0de6 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -40,7 +40,7 @@ int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
 	int i;
 	struct string_list mailmap = STRING_LIST_INIT_NODUP;

-	git_config(git_default_config, NULL);
+	git_default_config();
 	argc = parse_options(argc, argv, prefix, check_mailmap_options,
 			     check_mailmap_usage, 0);
 	if (argc == 0 && !use_stdin)
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 05edd9e..197a987 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -213,7 +213,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_checkout_index_usage,
 				   builtin_checkout_index_options);
-	git_config(git_default_config, NULL);
+	git_default_config();
 	state.base_dir = "";
 	prefix_length = prefix ? strlen(prefix) : 0;

diff --git a/builtin/clone.c b/builtin/clone.c
index bbd169c..bcfd322 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -864,7 +864,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	init_db(option_template, INIT_DB_QUIET);
 	write_config(&option_config);

-	git_config(git_default_config, NULL);
+	git_default_config();

 	if (option_bare) {
 		if (option_mirror)
diff --git a/builtin/config.c b/builtin/config.c
index fcd8474..eed430d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -558,7 +558,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			die("editing stdin is not supported");
 		if (given_config_source.blob)
 			die("editing blobs is not supported");
-		git_config(git_default_config, NULL);
+		git_default_config();
 		launch_editor(given_config_source.file ?
 			      given_config_source.file : git_path("config"),
 			      NULL, NULL);
diff --git a/builtin/describe.c b/builtin/describe.c
index ee6a3b9..a4969d8 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -413,7 +413,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};

-	git_config(git_default_config, NULL);
+	git_default_config();
 	argc = parse_options(argc, argv, prefix, options, describe_usage, 0);
 	if (abbrev < 0)
 		abbrev = DEFAULT_ABBREV;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 92b4624..344a8a4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -726,7 +726,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		usage_with_options (fast_export_usage, options);

 	/* we handle encodings */
-	git_config(git_default_config, NULL);
+	git_default_config();

 	init_revisions(&revs, prefix);
 	revs.topo_order = 1;
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 47bd624..3991679 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1095,7 +1095,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		sort = default_sort();

 	/* for warn_ambiguous_refs */
-	git_config(git_default_config, NULL);
+	git_default_config();

 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.grab_pattern = argv;
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index d7fcf4c..0a9fe1b 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -96,7 +96,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 			vpath = prefix_filename(prefix, prefix_length, vpath);
 	}

-	git_config(git_default_config, NULL);
+	git_default_config();

 	if (stdin_paths) {
 		if (hashstdin)
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 56f85e2..337cd0a 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -211,7 +211,7 @@ static int create_default_files(const char *template_path)
 	 */
 	copy_templates(template_path);

-	git_config(git_default_config, NULL);
+	git_default_config();
 	is_bare_repository_cfg = init_is_bare_repository;

 	/* reading existing config may have overwrote it */
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 47c3880..18d4241 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -513,7 +513,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
-	git_config(git_default_config, NULL);
+	git_default_config();

 	if (read_cache() < 0)
 		die("index file corrupt");
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 51184df..814b358 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -146,7 +146,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};

-	git_config(git_default_config, NULL);
+	git_default_config();
 	ls_tree_prefix = prefix;
 	if (prefix && *prefix)
 		chomp_prefix = strlen(prefix);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 0ecde8d..c442e49 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -223,7 +223,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};

-	git_config(git_default_config, NULL);
+	git_default_config();
 	argc = parse_options(argc, argv, prefix, options, merge_base_usage, 0);

 	if (cmdmode == 'a') {
diff --git a/builtin/mv.c b/builtin/mv.c
index 6ffe540..ea5da87 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -78,7 +78,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;

 	gitmodules_config();
-	git_config(git_default_config, NULL);
+	git_default_config();

 	argc = parse_options(argc, argv, prefix, builtin_mv_options,
 			     builtin_mv_usage, 0);
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 3c8f319..fdf9771 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -325,7 +325,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};

-	git_config(git_default_config, NULL);
+	git_default_config();
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
 	if (all + transform_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
diff --git a/builtin/notes.c b/builtin/notes.c
index 820c341..47cec8a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -944,7 +944,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};

-	git_config(git_default_config, NULL);
+	git_default_config();
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);

diff --git a/builtin/push.c b/builtin/push.c
index f50e3d5..a25fc00 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -510,7 +510,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	};

 	packet_trace_identity("push");
-	git_config(git_default_config, NULL);
+	git_default_config();
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);

 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index e7e1c33..40d41fa 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -144,7 +144,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;

-	git_config(git_default_config, NULL);
+	git_default_config();

 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
diff --git a/builtin/reset.c b/builtin/reset.c
index 855d478..3f5c0c0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -288,7 +288,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};

-	git_config(git_default_config, NULL);
+	git_default_config();

 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff84a82..3243fcd 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -280,7 +280,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int bisect_find_all = 0;
 	int use_bitmap_index = 0;

-	git_config(git_default_config, NULL);
+	git_default_config();
 	init_revisions(&revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index d85e08c..0465540 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -527,7 +527,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	}

 	prefix = setup_git_directory();
-	git_config(git_default_config, NULL);
+	git_default_config();
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];

diff --git a/builtin/revert.c b/builtin/revert.c
index f9ed5bd..1975f46 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -190,7 +190,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (isatty(0))
 		opts.edit = 1;
 	opts.action = REPLAY_REVERT;
-	git_config(git_default_config, NULL);
+	git_default_config();
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
 	if (res < 0)
@@ -205,7 +205,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)

 	memset(&opts, 0, sizeof(opts));
 	opts.action = REPLAY_PICK;
-	git_config(git_default_config, NULL);
+	git_default_config();
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
 	if (res < 0)
diff --git a/builtin/rm.c b/builtin/rm.c
index bc6490b..7e4c2c6 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -283,7 +283,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	char *seen;

 	gitmodules_config();
-	git_config(git_default_config, NULL);
+	git_default_config();

 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
 			     builtin_rm_usage, 0);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 4b7e536..9f4627b 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -239,7 +239,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)

 	struct parse_opt_ctx_t ctx;

-	git_config(git_default_config, NULL);
+	git_default_config();
 	shortlog_init(&log);
 	init_revisions(&rev, prefix);
 	parse_options_start(&ctx, argc, argv, prefix, options,
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 1259ed7..27cd0bb 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -105,7 +105,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 		usage(usage_msg);

 	if (strip_comments || mode == COMMENT_LINES)
-		git_config(git_default_config, NULL);
+		git_default_config();

 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die_errno("could not read the input");
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index b6a711d..c6abff3 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -44,7 +44,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};

-	git_config(git_default_config, NULL);
+	git_default_config();
 	argc = parse_options(argc, argv, prefix, options,
 			     git_symbolic_ref_usage, 0);
 	if (msg && !*msg)
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 1920029..47eba5f 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -29,7 +29,7 @@ int cmd_unpack_file(int argc, const char **argv, const char *prefix)
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);

-	git_config(git_default_config, NULL);
+	git_default_config();

 	puts(create_temp_file(sha1));
 	return 0;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 99cde45..970056b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -499,7 +499,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)

 	check_replace_refs = 0;

-	git_config(git_default_config, NULL);
+	git_default_config();

 	quiet = !isatty(2);

diff --git a/builtin/update-index.c b/builtin/update-index.c
index e8c7fd4..0a5fff9 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -837,7 +837,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(update_index_usage, options);

-	git_config(git_default_config, NULL);
+	git_default_config();

 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
 	lock_file = xcalloc(1, sizeof(struct lock_file));
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 3067b11..e12edfe 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -355,7 +355,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};

-	git_config(git_default_config, NULL);
+	git_default_config();
 	argc = parse_options(argc, argv, prefix, options, git_update_ref_usage,
 			     0);
 	if (msg && !*msg)
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 6c8cc3e..ecf791c 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -15,7 +15,7 @@ int cmd_update_server_info(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};

-	git_config(git_default_config, NULL);
+	git_default_config();
 	argc = parse_options(argc, argv, prefix, options,
 			     update_server_info_usage, 0);
 	if (argc > 0)
diff --git a/builtin/var.c b/builtin/var.c
index aedbb53..d4b7dcd 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -82,7 +82,7 @@ int cmd_var(int argc, const char **argv, const char *prefix)
 		list_vars();
 		return 0;
 	}
-	git_config(git_default_config, NULL);
+	git_default_config();
 	val = read_var(argv[1]);
 	if (!val)
 		usage(var_usage);
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 972579f..c017efd 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -69,7 +69,7 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};

-	git_config(git_default_config, NULL);
+	git_default_config();
 	argc = parse_options(argc, argv, prefix, verify_pack_options,
 			     verify_pack_usage, 0);
 	if (argc < 1)
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 084c0df..95a0ca4 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -33,7 +33,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 		OPT_END()
 	};

-	git_config(git_default_config, NULL);
+	git_default_config();
 	argc = parse_options(argc, argv, unused_prefix, write_tree_options,
 			     write_tree_usage, 0);

diff --git a/http-fetch.c b/http-fetch.c
index ba3ea10..afa9f40 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -67,7 +67,7 @@ int main(int argc, const char **argv)

 	setup_git_directory();

-	git_config(git_default_config, NULL);
+	git_default_config();

 	http_init(NULL, url, 0);
 	walker = get_http_walker(url);
diff --git a/pager.c b/pager.c
index 8b5cbc5..c22fc04 100644
--- a/pager.c
+++ b/pager.c
@@ -47,7 +47,7 @@ const char *git_pager(int stdout_is_tty)
 	pager = getenv("GIT_PAGER");
 	if (!pager) {
 		if (!pager_program)
-			git_config(git_default_config, NULL);
+			git_default_config();
 		pager = pager_program;
 	}
 	if (!pager)
-- 
1.9.0.GIT
