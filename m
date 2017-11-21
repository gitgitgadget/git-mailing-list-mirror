Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948032036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdKUVhV (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:37:21 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:43915 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdKUVhU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:37:20 -0500
Received: by mail-wm0-f67.google.com with SMTP id x63so6335313wmf.2
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 13:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHNwrKFmgH4wFYLvWsr4q2lSigsMKA7Fy1BEA9wuy8Y=;
        b=O1AXREENE9d1OnArt08HWbWl3N0oF0zgCzwfzWsmvyyHNkpc3x6Tai5jGPizz7tUoc
         NUNN7YK6wPKGuFIrAJA7Y4OBl/OdVxlXRywJg0BKHzYoTzF2/VGSVx7Aj3+4V8CCcpzY
         sGFT/Z2YWwL5C0f5Ct2umgbubLhqtQHOtgrqJ3Is5DcvwsTgd0rmMalcxz5hqZ99P+1L
         locN8r3echgvNUgOIMY0BKGiz3/Gq43uSJuKX+TC+7y+EOmzu1VmyTCeI2oO6GIjaG61
         pBEI3KmWODJNMS2x0T0fyYcc7PEbcXOIqlvTjqcM4RqvK/+XO9xQI+UH8fyOMapWbKpG
         nR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHNwrKFmgH4wFYLvWsr4q2lSigsMKA7Fy1BEA9wuy8Y=;
        b=ByJkDLfu1K2YFn9w7iFnNJ+lxz2C8yO1eLON4pddOWPsJqN4eIBGV3TEmqgllgbdqo
         GMRWtrSzfQS1qcMTXKyVIL0J+8BGz/2sW3jBW4N8OvHd7Dy9udy9yDhaUEBWPJwlp4R9
         vkfUygKcGQ1cVaWRq9FrU2OHyJqA65X7aBz7h07nQ13fJ9dVu3sw3zm3bFR8HvZXlJXX
         kymKIrogbmfN+ebY3RVkoBWIA597AXHnjQRNIWF/t4xNmhah/+bQjLTbYoou8aX/5Ads
         A8NzXjByzIBM2aTPdiehYLvKaifUwsFBDkzAs2ZThd9XxXV+rFPNmSehe/zdjLUHyCvC
         fLYw==
X-Gm-Message-State: AJaThX4QSUBc4WMAHedBawctqzt3vzkseDSnMrUNiqvhrNOlrf8hPJdn
        mFptZndiRT4eOVZnHt9aOEDPQjo9
X-Google-Smtp-Source: AGs4zMYIy0zvHNsu8tRa/d5PpppIGu48+TqMvSkVYXxAovbUSccCAeYBKKXOsVAbRVB27akrTcsMAg==
X-Received: by 10.28.69.8 with SMTP id s8mr2145309wma.65.1511300238323;
        Tue, 21 Nov 2017 13:37:18 -0800 (PST)
Received: from rigel.lan (101.154.108.93.rev.vodafone.pt. [93.108.154.101])
        by smtp.gmail.com with ESMTPSA id h185sm5275803wma.19.2017.11.21.13.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 13:37:17 -0800 (PST)
From:   =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ikke.info, gitster@pobox.com, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: [PATCH v2] log: add option to choose which refs to decorate
Date:   Tue, 21 Nov 2017 21:33:41 +0000
Message-Id: <20171121213341.13939-1-rafa.almas@gmail.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171104004144.5975-1-rafa.almas@gmail.com>
References: <20171104004144.5975-1-rafa.almas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `log --decorate` is used, git will decorate commits with all
available refs. While in most cases this the desired effect, under some
conditions it can lead to excessively verbose output.

Introduce two command line options, `--decorate-refs=<pattern>` and
`--decorate-refs-exclude=<pattern>` to allow the user to select which
refs are used in decoration.

When "--decorate-refs=<pattern>" is given, only the refs that match the
pattern are used in decoration. The refs that match the pattern when
"--decorate-refs-exclude=<pattern>" is given, are never used in
decoration.

These options follow the same convention for mixing negative and
positive patterns across the system, assuming that the inclusive default
is to match all refs available.

 (1) if there is no positive pattern given, pretend as if an
     inclusive default positive pattern was given;

 (2) for each candidate, reject it if it matches no positive
     pattern, or if it matches any one of the negative patterns.

The rules for what is considered a match are slightly different from the
rules used elsewhere.

Commands like `log --glob` assume a trailing '/*' when glob chars are
not present in the pattern. This makes it difficult to specify a single
ref.  On the other hand, commands like `describe --match --all` allow
specifying exact refs, but do not have the convenience of allowing
"shorthand refs" like 'refs/heads' or 'heads' to refer to
'refs/heads/*'.

The commands introduced in this patch consider a match if:

  (a) the pattern contains globs chars,
	and regular pattern matching returns a match.

  (b) the pattern does not contain glob chars,
         and ref '<pattern>' exists, or if ref exists under '<pattern>/'

This allows both behaviours (allowing single refs and shorthand refs)
yet remaining compatible with existent commands.

Helped-by: Kevin Daudt <me@ikke.info>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rafael Ascensão <rafa.almas@gmail.com>
---

Notable changes since v1:

  * Do not change refs.c:for_each_glob_ref. Those changes were meant
  to address inconsistencies between commands, but they should be done
  in a separate topic.

  * Use new matching behaviour suggested by Junio for '--decorate-refs*'
  and change documentation/comments to reflect that.

  * Change help strings to clarify the commands expects a pattern
  instead of 'ref'.

  * Fix small inconsistencies on tests, and issues pointed by the
  feedback on the previous version.


 Documentation/git-log.txt |   7 ++++
 builtin/log.c             |  10 ++++-
 log-tree.c                |  24 ++++++++---
 log-tree.h                |   6 ++-
 pretty.c                  |   4 +-
 refs.c                    |  65 +++++++++++++++++++++++++++++
 refs.h                    |  24 +++++++++++
 revision.c                |   2 +-
 t/t4202-log.sh            | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 232 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 32246fdb0..5437f8b0f 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -38,6 +38,13 @@ OPTIONS
 	are shown as if 'short' were given, otherwise no ref names are
 	shown. The default option is 'short'.
 
+--decorate-refs=<pattern>::
+--decorate-refs-exclude=<pattern>::
+	If no `--decorate-refs` is given, pretend as if all refs were
+	included.  For each candidate, do not use it for decoration if it
+	matches any patterns given to `--decorate-refs-exclude` or if it
+	doesn't match any of the patterns given to `--decorate-refs`.
+
 --source::
 	Print out the ref name given on the command line by which each
 	commit was reached.
diff --git a/builtin/log.c b/builtin/log.c
index 6c1fa896a..14fdf3916 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -142,11 +142,19 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	struct userformat_want w;
 	int quiet = 0, source = 0, mailmap = 0;
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
+	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
+	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
+	struct decoration_filter decoration_filter = {&decorate_refs_include,
+						      &decorate_refs_exclude};
 
 	const struct option builtin_log_options[] = {
 		OPT__QUIET(&quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
+		OPT_STRING_LIST(0, "decorate-refs", &decorate_refs_include,
+				N_("pattern"), N_("only decorate refs that match <pattern>")),
+		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
+				N_("pattern"), N_("do not decorate refs that match <pattern>")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
 		  PARSE_OPT_OPTARG, decorate_callback},
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
@@ -205,7 +213,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 
 	if (decoration_style) {
 		rev->show_decorations = 1;
-		load_ref_decorations(decoration_style);
+		load_ref_decorations(&decoration_filter, decoration_style);
 	}
 
 	if (rev->line_level_traverse)
diff --git a/log-tree.c b/log-tree.c
index 3b904f037..fca29d479 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -94,8 +94,12 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 {
 	struct object *obj;
 	enum decoration_type type = DECORATION_NONE;
+	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
 
-	assert(cb_data == NULL);
+	if (filter && !ref_filter_match(refname,
+			      filter->include_ref_pattern,
+			      filter->exclude_ref_pattern))
+		return 0;
 
 	if (starts_with(refname, git_replace_ref_base)) {
 		struct object_id original_oid;
@@ -148,15 +152,23 @@ static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 	return 0;
 }
 
-void load_ref_decorations(int flags)
+void load_ref_decorations(struct decoration_filter *filter, int flags)
 {
 	if (!decoration_loaded) {
-
+		if (filter) {
+			struct string_list_item *item;
+			for_each_string_list_item(item, filter->exclude_ref_pattern) {
+				normalize_glob_ref(item, NULL, item->string);
+			}
+			for_each_string_list_item(item, filter->include_ref_pattern) {
+				normalize_glob_ref(item, NULL, item->string);
+			}
+		}
 		decoration_loaded = 1;
 		decoration_flags = flags;
-		for_each_ref(add_ref_decoration, NULL);
-		head_ref(add_ref_decoration, NULL);
-		for_each_commit_graft(add_graft_decoration, NULL);
+		for_each_ref(add_ref_decoration, filter);
+		head_ref(add_ref_decoration, filter);
+		for_each_commit_graft(add_graft_decoration, filter);
 	}
 }
 
diff --git a/log-tree.h b/log-tree.h
index 48f11fb74..deba03518 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -7,6 +7,10 @@ struct log_info {
 	struct commit *commit, *parent;
 };
 
+struct decoration_filter {
+	struct string_list *include_ref_pattern, *exclude_ref_pattern;
+};
+
 int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
 void init_log_tree_opt(struct rev_info *);
 int log_tree_diff_flush(struct rev_info *);
@@ -24,7 +28,7 @@ void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p);
-void load_ref_decorations(int flags);
+void load_ref_decorations(struct decoration_filter *filter, int flags);
 
 #define FORMAT_PATCH_NAME_MAX 64
 void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
diff --git a/pretty.c b/pretty.c
index 2f6b0ae6c..f7ce49023 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1186,11 +1186,11 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		load_ref_decorations(DECORATE_SHORT_REFS);
+		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 		format_decorations(sb, commit, c->auto_color);
 		return 1;
 	case 'D':
-		load_ref_decorations(DECORATE_SHORT_REFS);
+		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
 		return 1;
 	case 'g':		/* reflog info */
diff --git a/refs.c b/refs.c
index 339d4318e..20ba82b43 100644
--- a/refs.c
+++ b/refs.c
@@ -242,6 +242,50 @@ int ref_exists(const char *refname)
 	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, NULL, NULL);
 }
 
+static int match_ref_pattern(const char *refname,
+			     const struct string_list_item *item)
+{
+	int matched = 0;
+	if (item->util == NULL) {
+		if (!wildmatch(item->string, refname, 0))
+			matched = 1;
+	} else {
+		const char *rest;
+		if (skip_prefix(refname, item->string, &rest) &&
+		    (!*rest || *rest == '/'))
+			matched = 1;
+	}
+	return matched;
+}
+
+int ref_filter_match(const char *refname,
+		     const struct string_list *include_patterns,
+		     const struct string_list *exclude_patterns)
+{
+	struct string_list_item *item;
+
+	if (exclude_patterns && exclude_patterns->nr) {
+		for_each_string_list_item(item, exclude_patterns) {
+			if (match_ref_pattern(refname, item))
+				return 0;
+		}
+	}
+
+	if (include_patterns && include_patterns->nr) {
+		int found = 0;
+		for_each_string_list_item(item, include_patterns) {
+			if (match_ref_pattern(refname, item)) {
+				found = 1;
+				break;
+			}
+		}
+
+		if (!found)
+			return 0;
+	}
+	return 1;
+}
+
 static int filter_refs(const char *refname, const struct object_id *oid,
 			   int flags, void *data)
 {
@@ -369,6 +413,27 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
+void normalize_glob_ref(struct string_list_item *item, const char *prefix,
+			const char *pattern)
+{
+	struct strbuf normalized_pattern = STRBUF_INIT;
+
+	if (*pattern == '/')
+		BUG("pattern must not start with '/'");
+
+	if (prefix) {
+		strbuf_addstr(&normalized_pattern, prefix);
+	}
+	else if (!starts_with(pattern, "refs/"))
+		strbuf_addstr(&normalized_pattern, "refs/");
+	strbuf_addstr(&normalized_pattern, pattern);
+	strbuf_strip_suffix(&normalized_pattern, "/");
+
+	item->string = strbuf_detach(&normalized_pattern, NULL);
+	item->util = has_glob_specials(pattern) ? NULL : item->string;
+	strbuf_release(&normalized_pattern);
+}
+
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	const char *prefix, void *cb_data)
 {
diff --git a/refs.h b/refs.h
index 18582a408..01be5ae32 100644
--- a/refs.h
+++ b/refs.h
@@ -312,6 +312,30 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_rawref(each_ref_fn fn, void *cb_data);
 
+/*
+ * Normalizes partial refs to their fully qualified form.
+ * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs/'.
+ * <prefix> will default to 'refs/' if NULL.
+ *
+ * item.string will be set to the result.
+ * item.util will be set to NULL if <pattern> contains glob characters, or
+ * non-NULL if it doesn't.
+ */
+void normalize_glob_ref(struct string_list_item *item, const char *prefix,
+			const char *pattern);
+
+/*
+ * Returns 0 if refname matches any of the exclude_patterns, or if it doesn't
+ * match any of the include_patterns. Returns 1 otherwise.
+ *
+ * If pattern list is NULL or empty, matching against that list is skipped.
+ * This has the effect of matching everything by default, unless the user
+ * specifies rules otherwise.
+ */
+int ref_filter_match(const char *refname,
+		     const struct string_list *include_patterns,
+		     const struct string_list *exclude_patterns);
+
 static inline const char *has_glob_specials(const char *pattern)
 {
 	return strpbrk(pattern, "?*[");
diff --git a/revision.c b/revision.c
index e2e691dd5..f6a3da5cd 100644
--- a/revision.c
+++ b/revision.c
@@ -1832,7 +1832,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->simplify_by_decoration = 1;
 		revs->limited = 1;
 		revs->prune = 1;
-		load_ref_decorations(DECORATE_SHORT_REFS);
+		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
 		revs->topo_order = 1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 8f155da7a..25b1f8cc7 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -737,6 +737,107 @@ test_expect_success 'log.decorate configuration' '
 
 '
 
+test_expect_success 'decorate-refs with glob' '
+	cat >expect.decorate <<-\EOF &&
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
+	seventh
+	octopus-b (octopus-b)
+	octopus-a (octopus-a)
+	reach
+	EOF
+	git log -n6 --decorate=short --pretty="tformat:%f%d" \
+		--decorate-refs="heads/octopus*" >actual &&
+	test_cmp expect.decorate actual
+'
+
+test_expect_success 'decorate-refs without globs' '
+	cat >expect.decorate <<-\EOF &&
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
+	seventh
+	octopus-b
+	octopus-a
+	reach (tag: reach)
+	EOF
+	git log -n6 --decorate=short --pretty="tformat:%f%d" \
+		--decorate-refs="tags/reach" >actual &&
+	test_cmp expect.decorate actual
+'
+
+test_expect_success 'multiple decorate-refs' '
+	cat >expect.decorate <<-\EOF &&
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
+	seventh
+	octopus-b (octopus-b)
+	octopus-a (octopus-a)
+	reach (tag: reach)
+	EOF
+	git log -n6 --decorate=short --pretty="tformat:%f%d" \
+		--decorate-refs="heads/octopus*" \
+		--decorate-refs="tags/reach" >actual &&
+    test_cmp expect.decorate actual
+'
+
+test_expect_success 'decorate-refs-exclude with glob' '
+	cat >expect.decorate <<-\EOF &&
+	Merge-tag-reach (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b
+	seventh (tag: seventh)
+	octopus-b (tag: octopus-b)
+	octopus-a (tag: octopus-a)
+	reach (tag: reach, reach)
+	EOF
+	git log -n6 --decorate=short --pretty="tformat:%f%d" \
+		--decorate-refs-exclude="heads/octopus*" >actual &&
+	test_cmp expect.decorate actual
+'
+
+test_expect_success 'decorate-refs-exclude without globs' '
+	cat >expect.decorate <<-\EOF &&
+	Merge-tag-reach (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b
+	seventh (tag: seventh)
+	octopus-b (tag: octopus-b, octopus-b)
+	octopus-a (tag: octopus-a, octopus-a)
+	reach (reach)
+	EOF
+	git log -n6 --decorate=short --pretty="tformat:%f%d" \
+		--decorate-refs-exclude="tags/reach" >actual &&
+	test_cmp expect.decorate actual
+'
+
+test_expect_success 'multiple decorate-refs-exclude' '
+	cat >expect.decorate <<-\EOF &&
+	Merge-tag-reach (HEAD -> master)
+	Merge-tags-octopus-a-and-octopus-b
+	seventh (tag: seventh)
+	octopus-b (tag: octopus-b)
+	octopus-a (tag: octopus-a)
+	reach (reach)
+	EOF
+	git log -n6 --decorate=short --pretty="tformat:%f%d" \
+		--decorate-refs-exclude="heads/octopus*" \
+		--decorate-refs-exclude="tags/reach" >actual &&
+	test_cmp expect.decorate actual
+'
+
+test_expect_success 'decorate-refs and decorate-refs-exclude' '
+	cat >expect.decorate <<-\EOF &&
+	Merge-tag-reach (master)
+	Merge-tags-octopus-a-and-octopus-b
+	seventh
+	octopus-b
+	octopus-a
+	reach (reach)
+	EOF
+	git log -n6 --decorate=short --pretty="tformat:%f%d" \
+		--decorate-refs="heads/*" \
+		--decorate-refs-exclude="heads/oc*" >actual &&
+	test_cmp expect.decorate actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=full >expect.full &&
 	git log --oneline --decorate=short >expect.short &&
-- 
2.15.0

