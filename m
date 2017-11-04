Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC6820450
	for <e@80x24.org>; Sat,  4 Nov 2017 00:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756420AbdKDAmt (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 20:42:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54467 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756367AbdKDAmo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 20:42:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id r68so4560524wmr.3
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 17:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cpkWoXd/+jTKEGNMxQTbcR7YggTLl60aa4KYf7WhujA=;
        b=Ly5Gno2UxVS2vIIazAmQG6FOweCEEXDfJyzmKSo6Vcwt1btR506kPcM/IO7vUYqav2
         kr0IGTbGBr926+eGbrs9c2SVbwJHluFsdW25PE/Wab1eP+oeo2exn+RunIoFnnyGNbZA
         LTV4aC/IZcOequhmAs3BxPA3iYNTJ6FdzvS5Gf8TBe7LpZISVPl/8fbKUKekS6l6QnH6
         1kPvhI1pasY+c5heTA2peo7a3bqSSYeXXOkt9oz4pC2LtQOsztEG2S07/JvjvbMefwtf
         ZP5y09anvx8c63xCBbQzpx2NreM1GDuM80+48lf9G4friYdUxkDL34GhrVFRhyEVI9AM
         IE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpkWoXd/+jTKEGNMxQTbcR7YggTLl60aa4KYf7WhujA=;
        b=tCGiTbfi0cSvOwDa4aIL/5jprdSXJSF99RYJhBY/6mh+mOcN1xk7y7RYr6ktBDJ+rF
         t51IDnq31Uia5ouBAjK5nnP1Ln0vvNKR77sZn3CDAr+f8lwuRGADyu22kLJBrQH8kQZ6
         lBtXVEBVS1lHWy2aFOi7KZkTTpg+3kWMPbJvnyltwa4jTqWdIQ3OIJhafPNqpF4BudUG
         nstp5+SQBbysKxoZ0xtUU/9zVa6tRpWOuH6i2Gjfk7Ck/8/ekrdmN1OiZHAmGpt0nXd6
         RveOv9H1wDOoAKlh2TsW8wol0uMpvG7T0YspoAulwkeMQoAGgrf3U2/PmHjZ9s9Vokqc
         Uh7A==
X-Gm-Message-State: AJaThX4v/pUviO3yQjD9SEWJEZQJujwwrp54V1Ace+FgkE+O0izuCV0X
        GHm1hN+F2Qekjf59iYH+DhglNlWBl1E=
X-Google-Smtp-Source: ABhQp+S2B5Eo33XFPkzbOgfkGfkZ7V+15DGDuoavf+1QQHIN4ZtAtXlKKgdf3QnZD6awKHTVVKLUXw==
X-Received: by 10.28.203.195 with SMTP id b186mr383898wmg.93.1509756162548;
        Fri, 03 Nov 2017 17:42:42 -0700 (PDT)
Received: from rigel.lan (101.154.108.93.rev.vodafone.pt. [93.108.154.101])
        by smtp.gmail.com with ESMTPSA id o8sm11956418wrc.10.2017.11.03.17.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 17:42:42 -0700 (PDT)
From:   =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        me@ikke.info, gitster@pobox.com, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
Subject: [PATCH v1 2/2] log: add option to choose which refs to decorate
Date:   Sat,  4 Nov 2017 00:41:44 +0000
Message-Id: <20171104004144.5975-3-rafa.almas@gmail.com>
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

Using `--exclude=<pattern>` can help mitigate that verboseness by
removing unnecessary 'branches' from the output. However, if the tip of
an excluded ref points to an ancestor of a non-excluded ref, git will
decorate it regardless.

With `--decorate-refs=<pattern>`, only refs that match <pattern> are
decorated while `--decorate-refs-exclude=<pattern>` allows to do the
reverse, remove ref decorations that match <pattern>

Both can be used together but --decorate-refs-exclude patterns have
precedence over --decorate-refs patterns.

The pattern follows similar rules as `--glob` except it doesn't assume a
trailing '/*' if glob characters are missing.

Both `--decorate-refs` and `--decorate-refs-exclude` can be used
multiple times.

Signed-off-by: Kevin Daudt <me@ikke.info>
Signed-off-by: Rafael Ascensão <rafa.almas@gmail.com>
---
 Documentation/git-log.txt |  12 ++++++
 builtin/log.c             |  10 ++++-
 log-tree.c                |  37 ++++++++++++++---
 log-tree.h                |   6 ++-
 pretty.c                  |   4 +-
 revision.c                |   2 +-
 t/t4202-log.sh            | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 162 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 32246fdb0..314417d89 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -38,6 +38,18 @@ OPTIONS
 	are shown as if 'short' were given, otherwise no ref names are
 	shown. The default option is 'short'.
 
+--decorate-refs=<pattern>::
+	Only print ref names that match the specified pattern. Uses the same
+	rules as `git rev-list --glob` except it doesn't assume a trailing a
+	trailing '/{asterisk}' if pattern lacks '?', '{asterisk}', or '['.
+	`--decorate-refs-exlclude` has precedence.
+
+--decorate-refs-exclude=<pattern>::
+	Do not print ref names that match the specified pattern. Uses the same
+	rules as `git rev-list --glob` except it doesn't assume a trailing a
+	trailing '/{asterisk}' if pattern lacks '?', '{asterisk}', or '['.
+	Has precedence over `--decorate-refs`.
+
 --source::
 	Print out the ref name given on the command line by which each
 	commit was reached.
diff --git a/builtin/log.c b/builtin/log.c
index d81a09051..3587c0055 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -143,11 +143,19 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	struct userformat_want w;
 	int quiet = 0, source = 0, mailmap = 0;
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
+	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_DUP;
+	static struct string_list decorate_refs_include = STRING_LIST_INIT_DUP;
+	struct ref_include_exclude_list ref_filter_lists = {&decorate_refs_include,
+							    &decorate_refs_exclude};
 
 	const struct option builtin_log_options[] = {
 		OPT__QUIET(&quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
+		OPT_STRING_LIST(0, "decorate-refs", &decorate_refs_include,
+				N_("ref"), N_("only decorate these refs")),
+		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
+				N_("ref"), N_("do not decorate these refs")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
 		  PARSE_OPT_OPTARG, decorate_callback},
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
@@ -206,7 +214,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 
 	if (decoration_style) {
 		rev->show_decorations = 1;
-		load_ref_decorations(decoration_style);
+		load_ref_decorations(decoration_style, &ref_filter_lists);
 	}
 
 	if (rev->line_level_traverse)
diff --git a/log-tree.c b/log-tree.c
index cea056234..8efc7ac3d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -94,9 +94,33 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 {
 	struct object *obj;
 	enum decoration_type type = DECORATION_NONE;
+	struct ref_include_exclude_list *filter = (struct ref_include_exclude_list *)cb_data;
+	struct string_list_item *item;
+	struct strbuf real_pattern = STRBUF_INIT;
+
+	if(filter && filter->exclude->nr > 0) {
+		/* if current ref is on the exclude list skip */
+		for_each_string_list_item(item, filter->exclude) {
+			strbuf_reset(&real_pattern);
+			normalize_glob_ref(&real_pattern, NULL, item->string, 0);
+			if (!wildmatch(real_pattern.buf, refname, 0))
+				goto finish;
+		}
+	}
 
-	assert(cb_data == NULL);
+	if (filter && filter->include->nr > 0) {
+		/* if current ref is present on the include jump to decorate */
+		for_each_string_list_item(item, filter->include) {
+			strbuf_reset(&real_pattern);
+			normalize_glob_ref(&real_pattern, NULL, item->string, 0);
+			if (!wildmatch(real_pattern.buf, refname, 0))
+				goto decorate;
+		}
+		/* Filter was given, but no match was found, skip */
+		goto finish;
+	}
 
+decorate:
 	if (starts_with(refname, git_replace_ref_base)) {
 		struct object_id original_oid;
 		if (!check_replace_refs)
@@ -136,6 +160,9 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			parse_object(&obj->oid);
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
+
+finish:
+	strbuf_release(&real_pattern);
 	return 0;
 }
 
@@ -148,15 +175,15 @@ static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 	return 0;
 }
 
-void load_ref_decorations(int flags)
+void load_ref_decorations(int flags, struct ref_include_exclude_list *data)
 {
 	if (!decoration_loaded) {
 
 		decoration_loaded = 1;
 		decoration_flags = flags;
-		for_each_ref(add_ref_decoration, NULL);
-		head_ref(add_ref_decoration, NULL);
-		for_each_commit_graft(add_graft_decoration, NULL);
+		for_each_ref(add_ref_decoration, data);
+		head_ref(add_ref_decoration, data);
+		for_each_commit_graft(add_graft_decoration, data);
 	}
 }
 
diff --git a/log-tree.h b/log-tree.h
index 48f11fb74..66563af88 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -7,6 +7,10 @@ struct log_info {
 	struct commit *commit, *parent;
 };
 
+struct ref_include_exclude_list {
+	struct string_list *include, *exclude;
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
+void load_ref_decorations(int flags, struct ref_include_exclude_list *);
 
 #define FORMAT_PATCH_NAME_MAX 64
 void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
diff --git a/pretty.c b/pretty.c
index 2f6b0ae6c..87a6cc4f9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1186,11 +1186,11 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		load_ref_decorations(DECORATE_SHORT_REFS);
+		load_ref_decorations(DECORATE_SHORT_REFS, NULL);
 		format_decorations(sb, commit, c->auto_color);
 		return 1;
 	case 'D':
-		load_ref_decorations(DECORATE_SHORT_REFS);
+		load_ref_decorations(DECORATE_SHORT_REFS, NULL);
 		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
 		return 1;
 	case 'g':		/* reflog info */
diff --git a/revision.c b/revision.c
index d167223e6..298ff054b 100644
--- a/revision.c
+++ b/revision.c
@@ -1822,7 +1822,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->simplify_by_decoration = 1;
 		revs->limited = 1;
 		revs->prune = 1;
-		load_ref_decorations(DECORATE_SHORT_REFS);
+		load_ref_decorations(DECORATE_SHORT_REFS, NULL);
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
 		revs->topo_order = 1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 8f155da7a..e26d09a5c 100755
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
+	git log -n6 --decorate=short --pretty="%f%d" \
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
+	git log -n6 --decorate=short --pretty='tformat:%f%d' \
+		--decorate-refs='heads/octopus*' \
+		--decorate-refs='tags/reach' >actual &&
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
+	git log -n6 --decorate=short --pretty="%f%d" \
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
+	git log -n6 --decorate=short --pretty='tformat:%f%d' \
+		--decorate-refs-exclude='heads/octopus*' \
+		--decorate-refs-exclude='tags/reach' >actual &&
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
+	git log -n6 --decorate=short --pretty='tformat:%f%d' \
+		--decorate-refs='heads/*' \
+		--decorate-refs-exclude='heads/oc*' >actual &&
+	test_cmp expect.decorate actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=full >expect.full &&
 	git log --oneline --decorate=short >expect.short &&
-- 
2.15.0

