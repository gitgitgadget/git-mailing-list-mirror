Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3109EC7EE25
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbjEKSLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbjEKSLF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:11:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4993C1FD6
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:10:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-306281edf15so8439833f8f.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683828638; x=1686420638;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4STwXsYC5zaqNwPZjors7t5vDArRyXy8FMMZAV/Z6w=;
        b=X8C4wjFlui8S3vT3qGSABfbQQmky8PNgig4PkqlbZAmOvLgvkP6FoUtvLN4kRJs3Ep
         PJV8r3CUf8wC21Eq31lTtgynNjzCV0FgKQbzT4eEndbJLI6ylM07QO0sWfZCDictSePL
         gNEcscHbzZKbsW2tfCAQn37jcj9hfwgpg5woF+0BIYMyviV873XLq6PmwFLhulOGsFuy
         Z32QxKTUMYw68PEN7KIU19YAFNUmWqOTwBw4sRUN+BKkH7UsCHXveIK+WaE8oMcPpC5b
         0ui+JrsKdDw3OxyLVh4lp0A06J2IF52Ol/9WHDdXubxw6HfvYgrK/FZW8nT11Je+d7T4
         jyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683828638; x=1686420638;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4STwXsYC5zaqNwPZjors7t5vDArRyXy8FMMZAV/Z6w=;
        b=d3eNKd7tOYSkTBnsy+OtHFcR2tmvpAfXlapFky8FjDaRrJ8yacocAy6NUVNq4Yd4a9
         sQHb688qS0vhpDyLnkMmU+lAYnR/Ks2Gl9w35zt6eIIdK6oBZF7eNsAnAKwe4olrF4O/
         xhn3/eYHwi6rU9Qcgr0bS6+poQs6dT9LFOA6xskvjMUtNzzC0yrg4g6rHJIp0KvHAroB
         agPt9hrtZM7d9Zv8pDRXobuaTPDBjMZFDylPTj9tJwDSaig+pLWPwkEzBxblJp3phUDe
         xzJG0HL/4LrqemhS9TtcyRx4qb3gKrPS+kwsY8yb3CP/S/Wwj0KY+7Xzgri+3GpFKX21
         XPsg==
X-Gm-Message-State: AC+VfDyPgjrGB1fgMT3RQtp8/QhxaI9+g7RESloXTL4nf+MPRl9AWXEg
        6W9O/guP4fS4b3ZLqL4y0hmcWU3zmg4=
X-Google-Smtp-Source: ACHHUZ7WyTn2gu627H1ZJPyw2XziovjFrodUD/VI3UH1Y3xTp7AOMdgaO1w7/5S2zhk7f8XPUhs6+Q==
X-Received: by 2002:a5d:5143:0:b0:306:3bfb:fe94 with SMTP id u3-20020a5d5143000000b003063bfbfe94mr15521533wrt.53.1683828638495;
        Thu, 11 May 2023 11:10:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5-20020adff985000000b002fda1b12a0bsm21342315wrr.2.2023.05.11.11.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:10:38 -0700 (PDT)
Message-Id: <0a0693ad612755e675861dfa5a660baf8d325ed0.1683828635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
        <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 18:10:33 +0000
Subject: [PATCH v3 3/4] revision: modify ref_exclusions to handle inclusions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

The ref_exclusions API provides the ability to check if certain refs are
to be excluded. We can easily extend this API to check if certain refs
are included, which a subsequent commit will make use of.

Rename ref_exclusions to ref_visibility and add a member to keep track
of inclusions. Add add_ref_inclusion(), ref_included() to be used for
refs to explicitly include.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/pack-refs.c  |  6 ++--
 builtin/rev-parse.c  | 18 +++++------
 refs.h               |  2 +-
 refs/files-backend.c |  2 +-
 revision.c           | 71 +++++++++++++++++++++++++++-----------------
 revision.h           | 26 ++++++++++------
 6 files changed, 75 insertions(+), 50 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 1d1a64fe386..2464575a665 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -14,8 +14,8 @@ static char const * const pack_refs_usage[] = {
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	unsigned int flags = PACK_REFS_PRUNE;
-	static struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
-	struct pack_refs_opts pack_refs_opts = {.exclusions = &excludes, .flags = flags};
+	static struct ref_visibility visibility = REF_VISIBILITY_INIT;
+	struct pack_refs_opts pack_refs_opts = {.visibility = &visibility, .flags = flags};
 	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 
@@ -31,7 +31,7 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 		usage_with_options(pack_refs_usage, opts);
 
 	for_each_string_list_item(item, &option_excluded_refs)
-		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
+		add_ref_exclusion(pack_refs_opts.visibility, item->string);
 
 	return refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
 }
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 852e49e3403..9036d8876fc 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -46,7 +46,7 @@ static int abbrev_ref_strict;
 static int output_sq;
 
 static int stuck_long;
-static struct ref_exclusions ref_excludes = REF_EXCLUSIONS_INIT;
+static struct ref_visibility ref_visibility = REF_VISIBILITY_INIT;
 
 /*
  * Some arguments are relevant "revision" arguments,
@@ -208,7 +208,7 @@ static int show_default(void)
 static int show_reference(const char *refname, const struct object_id *oid,
 			  int flag UNUSED, void *cb_data UNUSED)
 {
-	if (ref_excluded(&ref_excludes, refname))
+	if (ref_excluded(&ref_visibility, refname))
 		return 0;
 	show_rev(NORMAL, oid, refname);
 	return 0;
@@ -596,7 +596,7 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
 		for_each_glob_ref_in(show_reference, pattern, prefix, NULL);
 	else
 		for_each_ref_in(prefix, show_reference, NULL);
-	clear_ref_exclusions(&ref_excludes);
+	clear_ref_visibility(&ref_visibility);
 }
 
 enum format_type {
@@ -874,7 +874,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--all")) {
 				for_each_ref(show_reference, NULL);
-				clear_ref_exclusions(&ref_excludes);
+				clear_ref_visibility(&ref_visibility);
 				continue;
 			}
 			if (skip_prefix(arg, "--disambiguate=", &arg)) {
@@ -888,13 +888,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
-				if (ref_excludes.hidden_refs_configured)
+				if (ref_visibility.hidden_refs_configured)
 					return error(_("--exclude-hidden cannot be used together with --branches"));
 				handle_ref_opt(arg, "refs/heads/");
 				continue;
 			}
 			if (opt_with_value(arg, "--tags", &arg)) {
-				if (ref_excludes.hidden_refs_configured)
+				if (ref_visibility.hidden_refs_configured)
 					return error(_("--exclude-hidden cannot be used together with --tags"));
 				handle_ref_opt(arg, "refs/tags/");
 				continue;
@@ -904,17 +904,17 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (opt_with_value(arg, "--remotes", &arg)) {
-				if (ref_excludes.hidden_refs_configured)
+				if (ref_visibility.hidden_refs_configured)
 					return error(_("--exclude-hidden cannot be used together with --remotes"));
 				handle_ref_opt(arg, "refs/remotes/");
 				continue;
 			}
 			if (skip_prefix(arg, "--exclude=", &arg)) {
-				add_ref_exclusion(&ref_excludes, arg);
+				add_ref_exclusion(&ref_visibility, arg);
 				continue;
 			}
 			if (skip_prefix(arg, "--exclude-hidden=", &arg)) {
-				exclude_hidden_refs(&ref_excludes, arg);
+				exclude_hidden_refs(&ref_visibility, arg);
 				continue;
 			}
 			if (!strcmp(arg, "--show-toplevel")) {
diff --git a/refs.h b/refs.h
index 46020bd335c..57949a1726b 100644
--- a/refs.h
+++ b/refs.h
@@ -65,7 +65,7 @@ struct worktree;
 
 struct pack_refs_opts {
 	unsigned int flags;
-	struct ref_exclusions *exclusions;
+	struct ref_visibility *visibility;
 };
 
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 76aebfde695..3ef19199788 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1183,7 +1183,7 @@ static int should_pack_ref(const char *refname,
 	    REF_WORKTREE_SHARED)
 		return 0;
 
-	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
+	if (opts->visibility && ref_excluded(opts->visibility, refname))
 		return 0;
 
 	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
diff --git a/revision.c b/revision.c
index b33cc1d106a..d59cd728e9e 100644
--- a/revision.c
+++ b/revision.c
@@ -1533,54 +1533,71 @@ static void add_rev_cmdline_list(struct rev_info *revs,
 	}
 }
 
-int ref_excluded(const struct ref_exclusions *exclusions, const char *path)
+static int ref_matched(const char *path,
+		       const struct string_list *l,
+		       const struct string_list *hidden_refs)
 {
 	const char *stripped_path = strip_namespace(path);
 	struct string_list_item *item;
 
-	for_each_string_list_item(item, &exclusions->excluded_refs) {
+	for_each_string_list_item(item, l) {
 		if (!wildmatch(item->string, path, 0))
 			return 1;
 	}
 
-	if (ref_is_hidden(stripped_path, path, &exclusions->hidden_refs))
+	if (ref_is_hidden(stripped_path, path, hidden_refs))
 		return 1;
 
 	return 0;
 }
 
-void init_ref_exclusions(struct ref_exclusions *exclusions)
+int ref_excluded(const struct ref_visibility *visibility, const char *path)
 {
-	struct ref_exclusions blank = REF_EXCLUSIONS_INIT;
-	memcpy(exclusions, &blank, sizeof(*exclusions));
+	return ref_matched(path, &visibility->excluded_refs, &visibility->hidden_refs);
 }
 
-void clear_ref_exclusions(struct ref_exclusions *exclusions)
+int ref_included(const struct ref_visibility *visibility, const char *path)
 {
-	string_list_clear(&exclusions->excluded_refs, 0);
-	string_list_clear(&exclusions->hidden_refs, 0);
-	exclusions->hidden_refs_configured = 0;
+	return ref_matched(path, &visibility->included_refs, &visibility->hidden_refs);
 }
 
-void add_ref_exclusion(struct ref_exclusions *exclusions, const char *exclude)
+void init_ref_visibility(struct ref_visibility *visibility)
 {
-	string_list_append(&exclusions->excluded_refs, exclude);
+	struct ref_visibility blank = REF_VISIBILITY_INIT;
+	memcpy(visibility, &blank, sizeof(*visibility));
+}
+
+void clear_ref_visibility(struct ref_visibility *visibility)
+{
+	string_list_clear(&visibility->excluded_refs, 0);
+	string_list_clear(&visibility->hidden_refs, 0);
+	visibility->hidden_refs_configured = 0;
+}
+
+void add_ref_exclusion(struct ref_visibility *visibility, const char *exclude)
+{
+	string_list_append(&visibility->excluded_refs, exclude);
+}
+
+void add_ref_inclusion(struct ref_visibility *visibility, const char *include)
+{
+	string_list_append(&visibility->included_refs, include);
 }
 
 struct exclude_hidden_refs_cb {
-	struct ref_exclusions *exclusions;
+	struct ref_visibility *visibility;
 	const char *section;
 };
 
 static int hide_refs_config(const char *var, const char *value, void *cb_data)
 {
 	struct exclude_hidden_refs_cb *cb = cb_data;
-	cb->exclusions->hidden_refs_configured = 1;
+	cb->visibility->hidden_refs_configured = 1;
 	return parse_hide_refs_config(var, value, cb->section,
-				      &cb->exclusions->hidden_refs);
+				      &cb->visibility->hidden_refs);
 }
 
-void exclude_hidden_refs(struct ref_exclusions *exclusions, const char *section)
+void exclude_hidden_refs(struct ref_visibility *visibility, const char *section)
 {
 	struct exclude_hidden_refs_cb cb;
 
@@ -1588,10 +1605,10 @@ void exclude_hidden_refs(struct ref_exclusions *exclusions, const char *section)
 			strcmp(section, "uploadpack"))
 		die(_("unsupported section for hidden refs: %s"), section);
 
-	if (exclusions->hidden_refs_configured)
+	if (visibility->hidden_refs_configured)
 		die(_("--exclude-hidden= passed more than once"));
 
-	cb.exclusions = exclusions;
+	cb.visibility = visibility;
 	cb.section = section;
 
 	git_config(hide_refs_config, &cb);
@@ -1935,7 +1952,7 @@ void repo_init_revisions(struct repository *r,
 
 	init_display_notes(&revs->notes_opt);
 	list_objects_filter_init(&revs->filter);
-	init_ref_exclusions(&revs->ref_excludes);
+	init_ref_visibility(&revs->ref_excludes);
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
@@ -2724,12 +2741,12 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 			init_all_refs_cb(&cb, revs, *flags);
 			other_head_refs(handle_one_ref, &cb);
 		}
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
 		if (revs->ref_excludes.hidden_refs_configured)
 			return error(_("--exclude-hidden cannot be used together with --branches"));
 		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
 		read_bisect_terms(&term_bad, &term_good);
 		handle_refs(refs, revs, *flags, for_each_bad_bisect_ref);
@@ -2740,17 +2757,17 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 		if (revs->ref_excludes.hidden_refs_configured)
 			return error(_("--exclude-hidden cannot be used together with --tags"));
 		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--remotes")) {
 		if (revs->ref_excludes.hidden_refs_configured)
 			return error(_("--exclude-hidden cannot be used together with --remotes"));
 		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->ref_excludes);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref(handle_one_ref, optarg, &cb);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->ref_excludes);
 		return argcount;
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
@@ -2764,21 +2781,21 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 			return error(_("--exclude-hidden cannot be used together with --branches"));
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--tags=", &optarg)) {
 		struct all_refs_cb cb;
 		if (revs->ref_excludes.hidden_refs_configured)
 			return error(_("--exclude-hidden cannot be used together with --tags"));
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--remotes=", &optarg)) {
 		struct all_refs_cb cb;
 		if (revs->ref_excludes.hidden_refs_configured)
 			return error(_("--exclude-hidden cannot be used together with --remotes"));
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--indexed-objects")) {
diff --git a/revision.h b/revision.h
index 25776af3815..296c520a003 100644
--- a/revision.h
+++ b/revision.h
@@ -84,7 +84,12 @@ struct rev_cmdline_info {
 	} *rev;
 };
 
-struct ref_exclusions {
+struct ref_visibility {
+	/*
+	 * Included refs is a list of wildmatch patterns. If any of the
+	 * patterns match, the reference will be included.
+	 */
+	struct string_list included_refs;
 	/*
 	 * Excluded refs is a list of wildmatch patterns. If any of the
 	 * patterns match, the reference will be excluded.
@@ -106,9 +111,10 @@ struct ref_exclusions {
 };
 
 /**
- * Initialize a `struct ref_exclusions` with a macro.
+ * Initialize a `struct ref_visibility` with a macro.
  */
-#define REF_EXCLUSIONS_INIT { \
+#define REF_VISIBILITY_INIT { \
+	.included_refs = STRING_LIST_INIT_DUP, \
 	.excluded_refs = STRING_LIST_INIT_DUP, \
 	.hidden_refs = STRING_LIST_INIT_DUP, \
 }
@@ -135,7 +141,7 @@ struct rev_info {
 	struct list_objects_filter_options filter;
 
 	/* excluding from --branches, --refs, etc. expansion */
-	struct ref_exclusions ref_excludes;
+	struct ref_visibility ref_excludes;
 
 	/* Basic information */
 	const char *prefix;
@@ -487,11 +493,13 @@ void show_object_with_name(FILE *, struct object *, const char *);
  * Helpers to check if a reference should be excluded.
  */
 
-int ref_excluded(const struct ref_exclusions *exclusions, const char *path);
-void init_ref_exclusions(struct ref_exclusions *);
-void clear_ref_exclusions(struct ref_exclusions *);
-void add_ref_exclusion(struct ref_exclusions *, const char *exclude);
-void exclude_hidden_refs(struct ref_exclusions *, const char *section);
+int ref_excluded(const struct ref_visibility *exclusions, const char *path);
+int ref_included(const struct ref_visibility *exclusions, const char *path);
+void init_ref_visibility(struct ref_visibility *);
+void clear_ref_visibility(struct ref_visibility *);
+void add_ref_exclusion(struct ref_visibility *, const char *exclude);
+void add_ref_inclusion(struct ref_visibility *, const char *exclude);
+void exclude_hidden_refs(struct ref_visibility *, const char *section);
 
 /**
  * This function can be used if you want to add commit objects as revision
-- 
gitgitgadget

