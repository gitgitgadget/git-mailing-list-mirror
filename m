Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41644C001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 23:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGaXuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 19:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjGaXuD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 19:50:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E02103
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:49:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942667393so64655577b3.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690847395; x=1691452195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKBykUg19E8qWdIb2KledQLUxNTMY8Qfj0DyUlA8+TY=;
        b=ZUaTbkYlET6Iz0yk5DYu0HXIqd/lZ/cAIz23BdP3vzYT7CKl5OpL4RSIH5zeeDkpkq
         +l2P7fEZws9dXaACRE3Mm+pCq4GWxxzrB4QPi47OZ0fymzLCNRPpE1edQdT/8bRKXsoG
         qxgZn6RWInMV8uGPp9JX8aelJmOMmDW5WH4Cw5rFE6nKKGpNMWgELWt4cUlzPg+Lp4IT
         SDK9fso9hiUl9QLHlr0NmIEJttP3OVzxXDZAX/cVW4qGI1qn5BTdqKTjD/HhC2mvFABT
         YGaJRXYVGATqg8jIKeylNjT8TdgLE+MGQCp4eJD3RVlQsMMwMslaNC7raC34rlAQw/7w
         lc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690847395; x=1691452195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKBykUg19E8qWdIb2KledQLUxNTMY8Qfj0DyUlA8+TY=;
        b=g52nze64+OplhG4gDxWcCQc7K7RuUbvfeoVciwOuHa6Byv3xVeIeu6xgIpx0Tes24p
         ieHn+IC9+T9KBp//AKzqvU7cDYexIkUSvQKgJqanl+XWjgWSAR1TYZpyMo0FK53yIJ/F
         YBl4ouy2q0oY2201lRLeIEVEGMozi4prEaOId+kVY9JweIyF/+A8qYcWCJs7MJWDCmt9
         pU94QoypRCN8/orH8asHt6qOhRRjpxqT8oBG+2myyj46wdGsDPb+nng8OXa+l4gN06NV
         0vKnFg6jqhXtoiTxpVr11F8ZowhFtkCk1FICK5HBXpLfrsqTGRhNIx9CJfcfmpd7d3h2
         Y+0g==
X-Gm-Message-State: ABy/qLb7hm/am0WMIDFMCNIvtkAwKdhypia9eW4etv/JcJQxCt2f7W5p
        37gGQEe6C+JP3ss0C9BgByGRuPSAae4iQRXUQTChQkmi3HlepBZMdrlNJQoG+n8Pzr898jBBDfA
        U5+efi0cHx6fCa0osLudBgcJ/8Uvm86bk8+jfv2NQFMPuB/FzLR5cfCRIGZBwGqI=
X-Google-Smtp-Source: APBJJlFsMErJtP4B1jXH0KC2oOvu5PXe2wJPIf/aj8libW+hd1lNsuDoyd0VEO1MI6qXJ0YDumJjFSKGk8VRMw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:ad27:0:b0:581:3899:91bc with SMTP id
 l39-20020a81ad27000000b00581389991bcmr87842ywh.6.1690847395133; Mon, 31 Jul
 2023 16:49:55 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:46:40 -0700
In-Reply-To: <20230731234910.94149-1-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <20230731234910.94149-1-chooglen@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731234910.94149-4-chooglen@google.com>
Subject: [RFC PATCH v1.5 3/5] config: report config parse errors using cb
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, config parsing will become its own library, and
it's likely that the caller will want flexibility in handling errors
(instead of being limited to the error handling we have in-tree).

Move the Git-specific error handling into a config_parser_event_fn_t
that responds to config errors, and make git_parse_source() always
return -1 (careful inspection shows that it was always returning -1
already). This makes CONFIG_ERROR_SILENT obsolete since that is
equivalent to not specifying an error event listener. Also, remove
CONFIG_ERROR_UNSET and the config_source 'default', since all callers
are now expected to specify the error handling they want.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/config.c   |   4 +-
 bundle-uri.c       |   4 +-
 config.c           | 175 ++++++++++++++++++++++++++-------------------
 config.h           |  20 ++++--
 fsck.c             |   4 +-
 submodule-config.c |   9 ++-
 6 files changed, 129 insertions(+), 87 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8a2840f0a8..de1878b947 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -42,7 +42,9 @@ static int actions, type;
 static char *default_value;
 static int end_nul;
 static int respect_includes_opt = -1;
-static struct config_options config_options;
+static struct config_options config_options = {
+	.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE)
+};
 static int show_origin;
 static int show_scope;
 static int fixed_value;
diff --git a/bundle-uri.c b/bundle-uri.c
index f93ca6a486..856bffdcad 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -237,9 +237,7 @@ int bundle_uri_parse_config_format(const char *uri,
 				   struct bundle_list *list)
 {
 	int result;
-	struct config_parse_options opts = {
-		.error_action = CONFIG_ERROR_ERROR,
-	};
+	struct config_parse_options opts = CP_OPTS_INIT(CONFIG_ERROR_ERROR);
 
 	if (!list->baseURI) {
 		struct strbuf baseURI = STRBUF_INIT;
diff --git a/config.c b/config.c
index dc6cda03aa..b6d0e16240 100644
--- a/config.c
+++ b/config.c
@@ -55,7 +55,6 @@ struct config_source {
 	enum config_origin_type origin_type;
 	const char *name;
 	const char *path;
-	enum config_error_action default_error_action;
 	int linenr;
 	int eof;
 	size_t total_len;
@@ -185,13 +184,15 @@ static int handle_path_include(const struct key_value_info *kvi,
 	}
 
 	if (!access_or_die(path, R_OK, 0)) {
+		struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
+
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
 			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
 			    !kvi ? "<unknown>" :
 			    kvi->filename ? kvi->filename :
 			    "the command line");
 		ret = git_config_from_file_with_options(git_config_include, path, inc,
-							kvi->scope, NULL);
+							kvi->scope, &config_opts);
 		inc->depth--;
 	}
 cleanup:
@@ -339,7 +340,9 @@ static int add_remote_url(const char *var, const char *value,
 
 static void populate_remote_urls(struct config_include_data *inc)
 {
-	struct config_options opts;
+	struct config_options opts = {
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+	};
 
 	opts = *inc->opts;
 	opts.unconditional_remote_url = 1;
@@ -1029,6 +1032,56 @@ static void kvi_from_source(struct config_source *cs,
 	out->path = cs->path;
 }
 
+int git_config_err_fn(enum config_event_t type, size_t begin_offset UNUSED,
+		      size_t end_offset UNUSED, struct config_source *cs,
+		      void *data)
+{
+	char *error_msg = NULL;
+	int error_return = 0;
+	enum config_error_action *action = data;
+
+	if (type != CONFIG_EVENT_ERROR)
+		return 0;
+
+	switch (cs->origin_type) {
+	case CONFIG_ORIGIN_BLOB:
+		error_msg = xstrfmt(_("bad config line %d in blob %s"),
+				      cs->linenr, cs->name);
+		break;
+	case CONFIG_ORIGIN_FILE:
+		error_msg = xstrfmt(_("bad config line %d in file %s"),
+				      cs->linenr, cs->name);
+		break;
+	case CONFIG_ORIGIN_STDIN:
+		error_msg = xstrfmt(_("bad config line %d in standard input"),
+				      cs->linenr);
+		break;
+	case CONFIG_ORIGIN_SUBMODULE_BLOB:
+		error_msg = xstrfmt(_("bad config line %d in submodule-blob %s"),
+				       cs->linenr, cs->name);
+		break;
+	case CONFIG_ORIGIN_CMDLINE:
+		error_msg = xstrfmt(_("bad config line %d in command line %s"),
+				       cs->linenr, cs->name);
+		break;
+	default:
+		error_msg = xstrfmt(_("bad config line %d in %s"),
+				      cs->linenr, cs->name);
+	}
+
+	switch (*action) {
+	case CONFIG_ERROR_DIE:
+		die("%s", error_msg);
+		break;
+	case CONFIG_ERROR_ERROR:
+		error_return = error("%s", error_msg);
+		break;
+	}
+
+	free(error_msg);
+	return error_return;
+}
+
 static int git_parse_source(struct config_source *cs, config_fn_t fn,
 			    struct key_value_info *kvi, void *data,
 			    const struct config_parse_options *opts)
@@ -1036,8 +1089,6 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 	int comment = 0;
 	size_t baselen = 0;
 	struct strbuf *var = &cs->var;
-	int error_return = 0;
-	char *error_msg = NULL;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	const char *bomptr = utf8_bom;
@@ -1119,53 +1170,14 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 			break;
 	}
 
-	if (do_event(cs, CONFIG_EVENT_ERROR, &event_data) < 0)
-		return -1;
-
-	switch (cs->origin_type) {
-	case CONFIG_ORIGIN_BLOB:
-		error_msg = xstrfmt(_("bad config line %d in blob %s"),
-				      cs->linenr, cs->name);
-		break;
-	case CONFIG_ORIGIN_FILE:
-		error_msg = xstrfmt(_("bad config line %d in file %s"),
-				      cs->linenr, cs->name);
-		break;
-	case CONFIG_ORIGIN_STDIN:
-		error_msg = xstrfmt(_("bad config line %d in standard input"),
-				      cs->linenr);
-		break;
-	case CONFIG_ORIGIN_SUBMODULE_BLOB:
-		error_msg = xstrfmt(_("bad config line %d in submodule-blob %s"),
-				       cs->linenr, cs->name);
-		break;
-	case CONFIG_ORIGIN_CMDLINE:
-		error_msg = xstrfmt(_("bad config line %d in command line %s"),
-				       cs->linenr, cs->name);
-		break;
-	default:
-		error_msg = xstrfmt(_("bad config line %d in %s"),
-				      cs->linenr, cs->name);
-	}
-
-	switch (opts && opts->error_action ?
-		opts->error_action :
-		cs->default_error_action) {
-	case CONFIG_ERROR_DIE:
-		die("%s", error_msg);
-		break;
-	case CONFIG_ERROR_ERROR:
-		error_return = error("%s", error_msg);
-		break;
-	case CONFIG_ERROR_SILENT:
-		error_return = -1;
-		break;
-	case CONFIG_ERROR_UNSET:
-		BUG("config error action unset");
-	}
-
-	free(error_msg);
-	return error_return;
+	/*
+	 * FIXME for whatever reason, do_event passes the _previous_ event, so
+	 * in order for our callback to receive the error event, we have to call
+	 * do_event twice
+	 */
+	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
+	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
+	return -1;
 }
 
 static uintmax_t get_unit_factor(const char *end)
@@ -2002,7 +2014,6 @@ static int do_config_from_file(config_fn_t fn,
 	top.origin_type = origin_type;
 	top.name = name;
 	top.path = path;
-	top.default_error_action = CONFIG_ERROR_DIE;
 	top.do_fgetc = config_file_fgetc;
 	top.do_ungetc = config_file_ungetc;
 	top.do_ftell = config_file_ftell;
@@ -2016,8 +2027,10 @@ static int do_config_from_file(config_fn_t fn,
 static int git_config_from_stdin(config_fn_t fn, void *data,
 				 enum config_scope scope)
 {
+	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
+
 	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
-				   data, scope, NULL);
+				   data, scope, &config_opts);
 }
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
@@ -2040,8 +2053,10 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
+	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
+
 	return git_config_from_file_with_options(fn, filename, data,
-						 CONFIG_SCOPE_UNKNOWN, NULL);
+						 CONFIG_SCOPE_UNKNOWN, &config_opts);
 }
 
 int git_config_from_mem(config_fn_t fn,
@@ -2058,7 +2073,6 @@ int git_config_from_mem(config_fn_t fn,
 	top.origin_type = origin_type;
 	top.name = name;
 	top.path = NULL;
-	top.default_error_action = CONFIG_ERROR_ERROR;
 	top.do_fgetc = config_buf_fgetc;
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
@@ -2077,6 +2091,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	char *buf;
 	unsigned long size;
 	int ret;
+	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_ERROR);
 
 	buf = repo_read_object_file(repo, oid, &type, &size);
 	if (!buf)
@@ -2087,7 +2102,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	}
 
 	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size,
-				  data, scope, NULL);
+				  data, scope, &config_opts);
 	free(buf);
 
 	return ret;
@@ -2188,29 +2203,32 @@ static int do_git_config_sequence(const struct config_options *opts,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
 		ret += git_config_from_file_with_options(fn, system_config,
 							 data, CONFIG_SCOPE_SYSTEM,
-							 NULL);
+							 &opts->parse_options);
 
 	git_global_config(&user_config, &xdg_config);
 
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file_with_options(fn, xdg_config, data,
-							 CONFIG_SCOPE_GLOBAL, NULL);
+							 CONFIG_SCOPE_GLOBAL,
+							 &opts->parse_options);
 
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file_with_options(fn, user_config, data,
-							 CONFIG_SCOPE_GLOBAL, NULL);
+							 CONFIG_SCOPE_GLOBAL,
+							 &opts->parse_options);
 
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file_with_options(fn, repo_config, data,
-							 CONFIG_SCOPE_LOCAL, NULL);
+							 CONFIG_SCOPE_LOCAL,
+							 &opts->parse_options);
 
 	if (!opts->ignore_worktree && worktree_config &&
 	    repo && repo->repository_format_worktree_config &&
 	    !access_or_die(worktree_config, R_OK, 0)) {
 			ret += git_config_from_file_with_options(fn, worktree_config, data,
 								 CONFIG_SCOPE_WORKTREE,
-								 NULL);
+								 &opts->parse_options);
 	}
 
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
@@ -2251,7 +2269,7 @@ int config_with_options(config_fn_t fn, void *data,
 	} else if (config_source && config_source->file) {
 		ret = git_config_from_file_with_options(fn, config_source->file,
 							data, config_source->scope,
-							NULL);
+							&opts->parse_options);
 	} else if (config_source && config_source->blob) {
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 					       data, config_source->scope);
@@ -2289,9 +2307,11 @@ static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 
 void read_early_config(config_fn_t cb, void *data)
 {
-	struct config_options opts = {0};
 	struct strbuf commondir = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
+	struct config_options opts = {
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+	};
 
 	opts.respect_includes = 1;
 
@@ -2323,7 +2343,9 @@ void read_early_config(config_fn_t cb, void *data)
  */
 void read_very_early_config(config_fn_t cb, void *data)
 {
-	struct config_options opts = { 0 };
+	struct config_options opts = {
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+	};
 
 	opts.respect_includes = 1;
 	opts.ignore_repo = 1;
@@ -2614,7 +2636,9 @@ int git_configset_get_pathname(struct config_set *set, const char *key, const ch
 /* Functions use to read configuration from a repository */
 static void repo_read_config(struct repository *repo)
 {
-	struct config_options opts = { 0 };
+	struct config_options opts = {
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+	};
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -2761,12 +2785,14 @@ int repo_config_get_pathname(struct repository *repo,
 static void read_protected_config(void)
 {
 	struct config_options opts = {
-		.respect_includes = 1,
-		.ignore_repo = 1,
-		.ignore_worktree = 1,
-		.system_gently = 1,
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
 	};
 
+	opts.respect_includes = 1;
+	opts.ignore_repo = 1;
+	opts.ignore_worktree = 1;
+	opts.system_gently = 1;
+
 	git_configset_init(&protected_config);
 	config_with_options(config_set_callback, &protected_config, NULL,
 			    NULL, &opts);
@@ -2977,6 +3003,7 @@ struct config_store_data {
 		enum config_event_t type;
 		int is_keys_section;
 	} *parsed;
+	enum config_error_action error_action;
 	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
@@ -3044,6 +3071,10 @@ static int store_aux_event(enum config_event_t type, size_t begin, size_t end,
 			store->seen[store->seen_nr] = store->parsed_nr;
 		}
 	}
+	if (type == CONFIG_EVENT_ERROR) {
+		return git_config_err_fn(type, begin, end, cs,
+					 &store->error_action);
+	}
 
 	store->parsed_nr++;
 
@@ -3380,7 +3411,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		struct stat st;
 		size_t copy_begin, copy_end;
 		int i, new_line = 0;
-		struct config_parse_options opts;
+		struct config_parse_options opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
 
 		if (!value_pattern)
 			store.value_pattern = NULL;
@@ -3407,8 +3438,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 		ALLOC_GROW(store.parsed, 1, store.parsed_alloc);
 		store.parsed[0].end = 0;
+		store.error_action = CONFIG_ERROR_DIE;
 
-		memset(&opts, 0, sizeof(opts));
 		opts.event_fn = store_aux_event;
 		opts.event_fn_data = &store;
 
diff --git a/config.h b/config.h
index b13586307d..1aed02cd5d 100644
--- a/config.h
+++ b/config.h
@@ -86,12 +86,6 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 					void *event_fn_data);
 
 struct config_parse_options {
-	enum config_error_action {
-		CONFIG_ERROR_UNSET = 0, /* use source-specific default */
-		CONFIG_ERROR_DIE, /* die() on error */
-		CONFIG_ERROR_ERROR, /* error() on error, return -1 */
-		CONFIG_ERROR_SILENT, /* return -1 */
-	} error_action;
 	/*
 	 * event_fn and event_fn_data are for internal use only. Handles events
 	 * emitted by the config parser.
@@ -100,6 +94,11 @@ struct config_parse_options {
 	void *event_fn_data;
 };
 
+#define CP_OPTS_INIT(error_action) { \
+	.event_fn = git_config_err_fn, \
+	.event_fn_data = (enum config_error_action []){(error_action)}, \
+}
+
 struct config_options {
 	unsigned int respect_includes : 1;
 	unsigned int ignore_repo : 1;
@@ -119,6 +118,15 @@ struct config_options {
 	unsigned int unconditional_remote_url : 1;
 };
 
+enum config_error_action {
+	CONFIG_ERROR_DIE, /* die() on error */
+	CONFIG_ERROR_ERROR, /* error() on error, return -1 */
+};
+
+int git_config_err_fn(enum config_event_t type, size_t begin_offset,
+		      size_t end_offset, struct config_source *cs,
+		      void *event_fn_data);
+
 /* Config source metadata for a given config key-value pair */
 struct key_value_info {
 	const char *filename;
diff --git a/fsck.c b/fsck.c
index 522ee1c18a..bc0ca11421 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1219,7 +1219,6 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		return 0;
 
 	if (oidset_contains(&options->gitmodules_found, oid)) {
-		struct config_parse_options config_opts = { 0 };
 		struct fsck_gitmodules_data data;
 
 		oidset_insert(&options->gitmodules_done, oid);
@@ -1238,10 +1237,9 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		data.oid = oid;
 		data.options = options;
 		data.ret = 0;
-		config_opts.error_action = CONFIG_ERROR_SILENT;
 		if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
 					".gitmodules", buf, size, &data,
-					CONFIG_SCOPE_UNKNOWN, &config_opts))
+					CONFIG_SCOPE_UNKNOWN, NULL))
 			data.ret |= report(options, oid, OBJ_BLOB,
 					FSCK_MSG_GITMODULES_PARSE,
 					"could not parse gitmodules blob");
diff --git a/submodule-config.c b/submodule-config.c
index 2aafc7f9cb..bcdd6feefa 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -565,6 +565,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	enum object_type type;
 	const struct submodule *submodule = NULL;
 	struct parse_config_parameter parameter;
+	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_ERROR);
+
 
 	/*
 	 * If any parameter except the cache is a NULL pointer just
@@ -608,7 +610,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.gitmodules_oid = &oid;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
-			    config, config_size, &parameter, CONFIG_SCOPE_UNKNOWN, NULL);
+			    config, config_size, &parameter,
+			    CONFIG_SCOPE_UNKNOWN, &config_opts);
 	strbuf_release(&rev);
 	free(config);
 
@@ -652,7 +655,9 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		struct git_config_source config_source = {
 			0, .scope = CONFIG_SCOPE_SUBMODULE
 		};
-		const struct config_options opts = { 0 };
+		struct config_options opts = {
+			.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+		};
 		struct object_id oid;
 		char *file;
 		char *oidstr = NULL;
-- 
2.41.0.585.gd2178a4bd4-goog

