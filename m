Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AA0EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 19:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjFUTfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 15:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjFUTfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 15:35:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF1010DB
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 12:35:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f9bdb01ec0so12303835e9.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376115; x=1689968115;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu16g35e9nJB/zMAFRfSlvZ0eKJBmYKVZGJvlH6TCbk=;
        b=goxKhXY44x3oK/se3Ch7aBFfNA8faffzNLdF9zFmMfzD7uY2JxY9+EbZJNYg1CDso/
         UhJ+fkASPFYzdKnz6bg9ZcXXZsbh0/JHJOgyDPg0tRyfTyiRAUVUTGK4xhO1Tlgnh2I1
         c6ZKOfhzkifLHGdqLSVxD1hkoODaD9t/kR5eZzOh9PZnqg/6Y25jZb+q8FZbwV8EQPyx
         v2tBGNfFTW6WBB+5l7OdmqyUdmab1HDcOThYvkgj8kGrpHIZvkcVMeAWoAS1Xg2tuYZz
         XtxYfcrwoY9Av5vW9kQX2syKzaUd87jeaHvKYxCIgNgrDqZ1OEZ+ofPlD0pDR03GB/xb
         1oyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376115; x=1689968115;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fu16g35e9nJB/zMAFRfSlvZ0eKJBmYKVZGJvlH6TCbk=;
        b=TU+yvcx88WJB60GF+PdMb4lO30tsrjAnq0SXupImIMkL5Q/g0KjyBlpQFHn7QMi1YL
         rjfMxTiJ8cxuD2kC4n/9DIXG0HN5Y9u4i0MF8E29aW5xLqwUQ0OaxD4zuQPCa9fQ46+G
         OndLjYgX5j0J5ndKOl03fJ7/2G8mBX6s8Sn4bt9gxSsZDJ5l/LWBoPCGlI/m04ovWmmG
         bc82qELPQYsdKh9SUPcma62SmznZuPQj5B4eFzCjoPzqL/mzGNHFwx1VnTOUMn5M5kIc
         tqBzVUY9+FG1LckNEg3xz/JPb5IuWhKFYIwqO8eVZ0rOpgZWjnbN5/82KeYNBOo+3Y9C
         cnQA==
X-Gm-Message-State: AC+VfDxth4VZ/tAP1UvcqrngHpOPc77ZYHrRjkpJKOm6+iMmwxz5qHPT
        YcDqtM2tbua9kQaJ5nYq7TCBM7mhceo=
X-Google-Smtp-Source: ACHHUZ5de2SX//ArHu9Rghn67KCHMAMrv2qoBHNk7UX4nsXgNA6TrCL0qMYNcNGsPfMYGLk9chXJlw==
X-Received: by 2002:a7b:ca54:0:b0:3f9:b552:411a with SMTP id m20-20020a7bca54000000b003f9b552411amr5740009wml.37.1687376115026;
        Wed, 21 Jun 2023 12:35:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003fa52928fcbsm192464wml.19.2023.06.21.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:35:14 -0700 (PDT)
Message-Id: <43e88a945226e1e08f2bd1a2bdebebda09cd6ec8.1687376112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jun 2023 19:35:10 +0000
Subject: [PATCH 1/3] revision: rename ref_excludes to ref_visibility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

The ref_exclusions API provides the ability to check if certain refs are
to be excluded. We can easily extend this API to check if certain refs
are included, which [1] considered when teaching git-pack-refs the
ability to specify not only refs to exclude but ones to include.

A subsequent commit will actuall extend the API to add the ability to
keep track of ref inclusions. As a preparatory patch, rename
 ref_exclusions to ref_visibility.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/pack-refs.c       |  6 ++--
 builtin/rev-parse.c       | 18 +++++-----
 refs.h                    |  2 +-
 refs/files-backend.c      |  2 +-
 revision.c                | 72 +++++++++++++++++++--------------------
 revision.h                | 18 +++++-----
 t/helper/test-ref-store.c |  4 +--
 7 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index bcf383cac9d..ff07986edaf 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -14,9 +14,9 @@ static char const * const pack_refs_usage[] = {
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	unsigned int flags = PACK_REFS_PRUNE;
-	static struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
+	static struct ref_visibility visibility = REF_VISIBILITY_INIT;
 	static struct string_list included_refs = STRING_LIST_INIT_NODUP;
-	struct pack_refs_opts pack_refs_opts = { .exclusions = &excludes,
+	struct pack_refs_opts pack_refs_opts = { .visibility = &visibility,
 						 .includes = &included_refs,
 						 .flags = flags };
 	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
@@ -36,7 +36,7 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 		usage_with_options(pack_refs_usage, opts);
 
 	for_each_string_list_item(item, &option_excluded_refs)
-		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
+		add_ref_exclusion(pack_refs_opts.visibility, item->string);
 
 	if (pack_refs_opts.flags & PACK_REFS_ALL)
 		string_list_append(pack_refs_opts.includes, "*");
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 852e49e3403..abbf240f498 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -46,7 +46,7 @@ static int abbrev_ref_strict;
 static int output_sq;
 
 static int stuck_long;
-static struct ref_exclusions ref_excludes = REF_EXCLUSIONS_INIT;
+static struct ref_visibility refs_visible = REF_VISIBILITY_INIT;
 
 /*
  * Some arguments are relevant "revision" arguments,
@@ -208,7 +208,7 @@ static int show_default(void)
 static int show_reference(const char *refname, const struct object_id *oid,
 			  int flag UNUSED, void *cb_data UNUSED)
 {
-	if (ref_excluded(&ref_excludes, refname))
+	if (ref_excluded(&refs_visible, refname))
 		return 0;
 	show_rev(NORMAL, oid, refname);
 	return 0;
@@ -596,7 +596,7 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
 		for_each_glob_ref_in(show_reference, pattern, prefix, NULL);
 	else
 		for_each_ref_in(prefix, show_reference, NULL);
-	clear_ref_exclusions(&ref_excludes);
+	clear_ref_visibility(&refs_visible);
 }
 
 enum format_type {
@@ -874,7 +874,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--all")) {
 				for_each_ref(show_reference, NULL);
-				clear_ref_exclusions(&ref_excludes);
+				clear_ref_visibility(&refs_visible);
 				continue;
 			}
 			if (skip_prefix(arg, "--disambiguate=", &arg)) {
@@ -888,13 +888,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
-				if (ref_excludes.hidden_refs_configured)
+				if (refs_visible.hidden_refs_configured)
 					return error(_("--exclude-hidden cannot be used together with --branches"));
 				handle_ref_opt(arg, "refs/heads/");
 				continue;
 			}
 			if (opt_with_value(arg, "--tags", &arg)) {
-				if (ref_excludes.hidden_refs_configured)
+				if (refs_visible.hidden_refs_configured)
 					return error(_("--exclude-hidden cannot be used together with --tags"));
 				handle_ref_opt(arg, "refs/tags/");
 				continue;
@@ -904,17 +904,17 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (opt_with_value(arg, "--remotes", &arg)) {
-				if (ref_excludes.hidden_refs_configured)
+				if (refs_visible.hidden_refs_configured)
 					return error(_("--exclude-hidden cannot be used together with --remotes"));
 				handle_ref_opt(arg, "refs/remotes/");
 				continue;
 			}
 			if (skip_prefix(arg, "--exclude=", &arg)) {
-				add_ref_exclusion(&ref_excludes, arg);
+				add_ref_exclusion(&refs_visible, arg);
 				continue;
 			}
 			if (skip_prefix(arg, "--exclude-hidden=", &arg)) {
-				exclude_hidden_refs(&ref_excludes, arg);
+				exclude_hidden_refs(&refs_visible, arg);
 				continue;
 			}
 			if (!strcmp(arg, "--show-toplevel")) {
diff --git a/refs.h b/refs.h
index 933fdebe584..ac334bf545d 100644
--- a/refs.h
+++ b/refs.h
@@ -65,7 +65,7 @@ struct worktree;
 
 struct pack_refs_opts {
 	unsigned int flags;
-	struct ref_exclusions *exclusions;
+	struct ref_visibility *visibility;
 	struct string_list *includes;
 };
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9a8333c0d07..2e716a3e201 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1194,7 +1194,7 @@ static int should_pack_ref(const char *refname,
 	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
 		return 0;
 
-	if (ref_excluded(opts->exclusions, refname))
+	if (ref_excluded(opts->visibility, refname))
 		return 0;
 
 	for_each_string_list_item(item, opts->includes)
diff --git a/revision.c b/revision.c
index b33cc1d106a..13e86a96498 100644
--- a/revision.c
+++ b/revision.c
@@ -1533,54 +1533,54 @@ static void add_rev_cmdline_list(struct rev_info *revs,
 	}
 }
 
-int ref_excluded(const struct ref_exclusions *exclusions, const char *path)
+int ref_excluded(const struct ref_visibility *visibility, const char *path)
 {
 	const char *stripped_path = strip_namespace(path);
 	struct string_list_item *item;
 
-	for_each_string_list_item(item, &exclusions->excluded_refs) {
+	for_each_string_list_item(item, &visibility->excluded_refs) {
 		if (!wildmatch(item->string, path, 0))
 			return 1;
 	}
 
-	if (ref_is_hidden(stripped_path, path, &exclusions->hidden_refs))
+	if (ref_is_hidden(stripped_path, path, &visibility->hidden_refs))
 		return 1;
 
 	return 0;
 }
 
-void init_ref_exclusions(struct ref_exclusions *exclusions)
+void init_ref_visibility(struct ref_visibility *visibility)
 {
-	struct ref_exclusions blank = REF_EXCLUSIONS_INIT;
-	memcpy(exclusions, &blank, sizeof(*exclusions));
+	struct ref_visibility blank = REF_VISIBILITY_INIT;
+	memcpy(visibility, &blank, sizeof(*visibility));
 }
 
-void clear_ref_exclusions(struct ref_exclusions *exclusions)
+void clear_ref_visibility(struct ref_visibility *visibility)
 {
-	string_list_clear(&exclusions->excluded_refs, 0);
-	string_list_clear(&exclusions->hidden_refs, 0);
-	exclusions->hidden_refs_configured = 0;
+	string_list_clear(&visibility->excluded_refs, 0);
+	string_list_clear(&visibility->hidden_refs, 0);
+	visibility->hidden_refs_configured = 0;
 }
 
-void add_ref_exclusion(struct ref_exclusions *exclusions, const char *exclude)
+void add_ref_exclusion(struct ref_visibility *visibility, const char *exclude)
 {
-	string_list_append(&exclusions->excluded_refs, exclude);
+	string_list_append(&visibility->excluded_refs, exclude);
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
 
@@ -1588,10 +1588,10 @@ void exclude_hidden_refs(struct ref_exclusions *exclusions, const char *section)
 			strcmp(section, "uploadpack"))
 		die(_("unsupported section for hidden refs: %s"), section);
 
-	if (exclusions->hidden_refs_configured)
+	if (visibility->hidden_refs_configured)
 		die(_("--exclude-hidden= passed more than once"));
 
-	cb.exclusions = exclusions;
+	cb.visibility = visibility;
 	cb.section = section;
 
 	git_config(hide_refs_config, &cb);
@@ -1612,7 +1612,7 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 	struct all_refs_cb *cb = cb_data;
 	struct object *object;
 
-	if (ref_excluded(&cb->all_revs->ref_excludes, path))
+	if (ref_excluded(&cb->all_revs->refs_visible, path))
 	    return 0;
 
 	object = get_reference(cb->all_revs, path, oid, cb->all_flags);
@@ -1935,7 +1935,7 @@ void repo_init_revisions(struct repository *r,
 
 	init_display_notes(&revs->notes_opt);
 	list_objects_filter_init(&revs->filter);
-	init_ref_exclusions(&revs->ref_excludes);
+	init_ref_visibility(&revs->refs_visible);
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
@@ -2724,12 +2724,12 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 			init_all_refs_cb(&cb, revs, *flags);
 			other_head_refs(handle_one_ref, &cb);
 		}
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->refs_visible);
 	} else if (!strcmp(arg, "--branches")) {
-		if (revs->ref_excludes.hidden_refs_configured)
+		if (revs->refs_visible.hidden_refs_configured)
 			return error(_("--exclude-hidden cannot be used together with --branches"));
 		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->refs_visible);
 	} else if (!strcmp(arg, "--bisect")) {
 		read_bisect_terms(&term_bad, &term_good);
 		handle_refs(refs, revs, *flags, for_each_bad_bisect_ref);
@@ -2737,48 +2737,48 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 			    for_each_good_bisect_ref);
 		revs->bisect = 1;
 	} else if (!strcmp(arg, "--tags")) {
-		if (revs->ref_excludes.hidden_refs_configured)
+		if (revs->refs_visible.hidden_refs_configured)
 			return error(_("--exclude-hidden cannot be used together with --tags"));
 		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->refs_visible);
 	} else if (!strcmp(arg, "--remotes")) {
-		if (revs->ref_excludes.hidden_refs_configured)
+		if (revs->refs_visible.hidden_refs_configured)
 			return error(_("--exclude-hidden cannot be used together with --remotes"));
 		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->refs_visible);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref(handle_one_ref, optarg, &cb);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->refs_visible);
 		return argcount;
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
-		add_ref_exclusion(&revs->ref_excludes, optarg);
+		add_ref_exclusion(&revs->refs_visible, optarg);
 		return argcount;
 	} else if ((argcount = parse_long_opt("exclude-hidden", argv, &optarg))) {
-		exclude_hidden_refs(&revs->ref_excludes, optarg);
+		exclude_hidden_refs(&revs->refs_visible, optarg);
 		return argcount;
 	} else if (skip_prefix(arg, "--branches=", &optarg)) {
 		struct all_refs_cb cb;
-		if (revs->ref_excludes.hidden_refs_configured)
+		if (revs->refs_visible.hidden_refs_configured)
 			return error(_("--exclude-hidden cannot be used together with --branches"));
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->refs_visible);
 	} else if (skip_prefix(arg, "--tags=", &optarg)) {
 		struct all_refs_cb cb;
-		if (revs->ref_excludes.hidden_refs_configured)
+		if (revs->refs_visible.hidden_refs_configured)
 			return error(_("--exclude-hidden cannot be used together with --tags"));
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->refs_visible);
 	} else if (skip_prefix(arg, "--remotes=", &optarg)) {
 		struct all_refs_cb cb;
-		if (revs->ref_excludes.hidden_refs_configured)
+		if (revs->refs_visible.hidden_refs_configured)
 			return error(_("--exclude-hidden cannot be used together with --remotes"));
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
-		clear_ref_exclusions(&revs->ref_excludes);
+		clear_ref_visibility(&revs->refs_visible);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--indexed-objects")) {
diff --git a/revision.h b/revision.h
index 25776af3815..8eaca125cd1 100644
--- a/revision.h
+++ b/revision.h
@@ -84,7 +84,7 @@ struct rev_cmdline_info {
 	} *rev;
 };
 
-struct ref_exclusions {
+struct ref_visibility {
 	/*
 	 * Excluded refs is a list of wildmatch patterns. If any of the
 	 * patterns match, the reference will be excluded.
@@ -106,9 +106,9 @@ struct ref_exclusions {
 };
 
 /**
- * Initialize a `struct ref_exclusions` with a macro.
+ * Initialize a `struct ref_visibility` with a macro.
  */
-#define REF_EXCLUSIONS_INIT { \
+#define REF_VISIBILITY_INIT { \
 	.excluded_refs = STRING_LIST_INIT_DUP, \
 	.hidden_refs = STRING_LIST_INIT_DUP, \
 }
@@ -135,7 +135,7 @@ struct rev_info {
 	struct list_objects_filter_options filter;
 
 	/* excluding from --branches, --refs, etc. expansion */
-	struct ref_exclusions ref_excludes;
+	struct ref_visibility refs_visible;
 
 	/* Basic information */
 	const char *prefix;
@@ -487,11 +487,11 @@ void show_object_with_name(FILE *, struct object *, const char *);
  * Helpers to check if a reference should be excluded.
  */
 
-int ref_excluded(const struct ref_exclusions *exclusions, const char *path);
-void init_ref_exclusions(struct ref_exclusions *);
-void clear_ref_exclusions(struct ref_exclusions *);
-void add_ref_exclusion(struct ref_exclusions *, const char *exclude);
-void exclude_hidden_refs(struct ref_exclusions *, const char *section);
+int ref_excluded(const struct ref_visibility *exclusions, const char *path);
+void init_ref_visibility(struct ref_visibility *);
+void clear_ref_visibility(struct ref_visibility *);
+void add_ref_exclusion(struct ref_visibility *, const char *exclude);
+void exclude_hidden_refs(struct ref_visibility *, const char *section);
 
 /**
  * This function can be used if you want to add commit objects as revision
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index a6977b5e839..504935c1d84 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -117,10 +117,10 @@ static struct flag_definition pack_flags[] = { FLAG_DEF(PACK_REFS_PRUNE),
 static int cmd_pack_refs(struct ref_store *refs, const char **argv)
 {
 	unsigned int flags = arg_flags(*argv++, "flags", pack_flags);
-	static struct ref_exclusions exclusions = REF_EXCLUSIONS_INIT;
+	static struct ref_visibility visibility = REF_VISIBILITY_INIT;
 	static struct string_list included_refs = STRING_LIST_INIT_NODUP;
 	struct pack_refs_opts pack_opts = { .flags = flags,
-					    .exclusions = &exclusions,
+					    .visibility = &visibility,
 					    .includes = &included_refs };
 
 	if (pack_opts.flags & PACK_REFS_ALL)
-- 
gitgitgadget

