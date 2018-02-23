Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3EA21F404
	for <e@80x24.org>; Fri, 23 Feb 2018 16:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeBWQ0g (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 11:26:36 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40592 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeBWQ0d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 11:26:33 -0500
Received: by mail-wm0-f67.google.com with SMTP id t82so5608589wmt.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 08:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qVpAlUgAdP6hfIYtekRrv5u+zZnCSwXye6pJ+TAXJcw=;
        b=Y79KfxzEPk2Gnp1RsUXL5eNVWfhxPSyTRxZBh2BCxkClShCppYfW6PPYDblrALLtbP
         ArYd10qfDduDZ+zRwd1IcK5NG2TDesPhpLmsbEHbGn7oYAevwAE2SUiBnO+Gl8FFDuLl
         kXIksVD5rs3v/Qkr5cAplm0M4wTml57KZ7Ca0hLrVapDOTnWagPSXMdmAwp1lFRDGnMz
         jkbyqW7GZk0x29ubrcFvR1mszZJyL0zehsh6jTfQZh9xI18A4l7Tq2ZHNijk+UN7jFrk
         +6pDDh36Zh8qujaPNuA8oQWvSdDhR43qiMdC6ctPM0Wb5JLf4tIAOg510rOIgtVNNRpj
         4t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qVpAlUgAdP6hfIYtekRrv5u+zZnCSwXye6pJ+TAXJcw=;
        b=fWIX2/+7CapCcDhb7HyKbBFwoU65MnO23RQ2gzpbT3e+whZZLCdy3LYD44HXT/qIgO
         Zjyd9yWOg+fmd0cjKG6OSNmAjDFd2gNzMlpIi9UleCrtxvb9gYmfcgOB8uJx+XGS08Fc
         xDx+nr/ZMbhxzyH63F5Zs71fh/49J47b/XG3flXH8WkpV8tzg9UFu5iybabCvig4w+Oi
         +J2wLFEe+USm7N7TDIMsqMGunjoHyGLuis6j9V6PGg0dAA0dtBoSGnIo3Ft6GKrHlFvG
         HYWkZHAiebfCpduhpKJnHPHj4NnXsMewaYqhdy5w19lPFfZ2VfP0krhRrGcWp7754EBK
         /Lgg==
X-Gm-Message-State: APf1xPCEeacN1y652oYbJ+RzXHSy07TqBFv4LL+HrDoS0ratpq0ISMll
        Zkqck76cfRJEdnFRlhdk6N9LkA==
X-Google-Smtp-Source: AH8x226f+mn0XJTcCJMcg7ZjplZbObxui3tLSOIpeQiOxQbE2JDv32UHcrZAk0fwa9Yz7bzhGccWMQ==
X-Received: by 10.28.183.195 with SMTP id h186mr2187234wmf.66.1519403191405;
        Fri, 23 Feb 2018 08:26:31 -0800 (PST)
Received: from localhost.localdomain ([92.55.154.23])
        by smtp.gmail.com with ESMTPSA id 55sm4212517wrw.87.2018.02.23.08.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 08:26:30 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [GSoC][PATCH v2] ref-filter: Make "--contains <id>" less chatty if <id> is invalid
Date:   Fri, 23 Feb 2018 18:25:57 +0200
Message-Id: <20180223162557.31477-1-ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.16.1.195.g8f471d4ad.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I have made the changes after review. This is the updated patch
based on what was discussed last time [1].

In this patch, I have fixed the same issue that was also seen
in "git branch" and "git for-reach-ref". I have also removed the
dead code that was left and updated the patches accordingly.

[1] https://public-inbox.org/git/20180219212130.4217-1-ungureanupaulsebastian@gmail.com/

Best regards,
Paul Ungureanu

https://public-inbox.org/git/20180219212130.4217-1-ungureanupaulsebastian@gmail.com/

---

Some git commands which use --contains <id> print the whole
help text if <id> is invalid. It should only show the error
message instead.

This patch applies to "git tag", "git branch", "git for-each-ref".

This bug was a side effect of looking up the commit in option
parser callback. When a error occurs in the option parser, the
full usage is shown. To fix this bug, the part related to
looking up the commit was moved outside of the option parser
to the ref-filter module.

Basically, the option parser only parses strings that represent
commits and the ref-filter performs the commit look-up. If an
error occurs during the option parsing, then it must be an invalid
argument and the user should be informed of usage, but if a error
occurs during ref-filtering, then it is a problem with the
argument.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/branch.c       | 12 +++----
 builtin/for-each-ref.c |  4 +--
 builtin/tag.c          | 16 ++++-----
 parse-options.h        |  3 +-
 ref-filter.c           | 23 +++++++++++++
 ref-filter.h           |  3 ++
 t/tcontains.sh         | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 136 insertions(+), 17 deletions(-)
 create mode 100755 t/tcontains.sh

diff --git a/builtin/branch.c b/builtin/branch.c
index 8dcc2ed05..43442c12e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -596,10 +596,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
 		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
 			FILTER_REFS_REMOTES),
-		OPT_CONTAINS(&filter.with_commit, N_("print only branches that contain the commit")),
-		OPT_NO_CONTAINS(&filter.no_commit, N_("print only branches that don't contain the commit")),
-		OPT_WITH(&filter.with_commit, N_("print only branches that contain the commit")),
-		OPT_WITHOUT(&filter.no_commit, N_("print only branches that don't contain the commit")),
+		OPT_CONTAINS(&filter.with_commit_strs, N_("print only branches that contain the commit")),
+		OPT_NO_CONTAINS(&filter.no_commit_strs, N_("print only branches that don't contain the commit")),
+		OPT_WITH(&filter.with_commit_strs, N_("print only branches that contain the commit")),
+		OPT_WITHOUT(&filter.no_commit_strs, N_("print only branches that don't contain the commit")),
 		OPT__ABBREV(&filter.abbrev),
 
 		OPT_GROUP(N_("Specific git-branch actions:")),
@@ -657,8 +657,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!delete && !rename && !copy && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
-	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr ||
-	    filter.no_commit)
+	if (filter.with_commit_strs.nr || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr ||
+	    filter.no_commit_strs.nr)
 		list = 1;
 
 	if (!!delete + !!rename + !!copy + !!new_upstream +
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index e931be9ce..deb9a779a 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -44,8 +44,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 			     parse_opt_object_name),
 		OPT_MERGED(&filter, N_("print only refs that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only refs that are not merged")),
-		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
-		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
+		OPT_CONTAINS(&filter.with_commit_strs, N_("print only refs which contain the commit")),
+		OPT_NO_CONTAINS(&filter.no_commit_strs, N_("print only refs which don't contain the commit")),
 		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_END(),
 	};
diff --git a/builtin/tag.c b/builtin/tag.c
index 8885e21dd..6be7f53ae 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -396,10 +396,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
-		OPT_CONTAINS(&filter.with_commit, N_("print only tags that contain the commit")),
-		OPT_NO_CONTAINS(&filter.no_commit, N_("print only tags that don't contain the commit")),
-		OPT_WITH(&filter.with_commit, N_("print only tags that contain the commit")),
-		OPT_WITHOUT(&filter.no_commit, N_("print only tags that don't contain the commit")),
+		OPT_CONTAINS(&filter.with_commit_strs, N_("print only tags that contain the commit")),
+		OPT_NO_CONTAINS(&filter.no_commit_strs, N_("print only tags that don't contain the commit")),
+		OPT_WITH(&filter.with_commit_strs, N_("print only tags that contain the commit")),
+		OPT_WITHOUT(&filter.no_commit_strs, N_("print only tags that don't contain the commit")),
 		OPT_MERGED(&filter, N_("print only tags that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
@@ -435,8 +435,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (!cmdmode) {
 		if (argc == 0)
 			cmdmode = 'l';
-		else if (filter.with_commit || filter.no_commit ||
-			 filter.points_at.nr || filter.merge_commit ||
+		else if (filter.points_at.nr || filter.merge_commit ||
+			 filter.with_commit_strs.nr || filter.no_commit_strs.nr ||
 			 filter.lines != -1)
 			cmdmode = 'l';
 	}
@@ -473,9 +473,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	if (filter.lines != -1)
 		die(_("-n option is only allowed in list mode"));
-	if (filter.with_commit)
+	if (filter.with_commit_strs.nr)
 		die(_("--contains option is only allowed in list mode"));
-	if (filter.no_commit)
+	if (filter.no_commit_strs.nr)
 		die(_("--no-contains option is only allowed in list mode"));
 	if (filter.points_at.nr)
 		die(_("--points-at option is only allowed in list mode"));
diff --git a/parse-options.h b/parse-options.h
index af711227a..4b4734f2e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -256,8 +256,9 @@ extern int parse_opt_passthru_argv(const struct option *, const char *, int);
 #define _OPT_CONTAINS_OR_WITH(name, variable, help, flag) \
 	{ OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
 	  PARSE_OPT_LASTARG_DEFAULT | flag, \
-	  parse_opt_commits, (intptr_t) "HEAD" \
+	  parse_opt_string_list, (intptr_t) "HEAD" \
 	}
+
 #define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PARSE_OPT_NONEG)
 #define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, h, PARSE_OPT_NONEG)
 #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
diff --git a/ref-filter.c b/ref-filter.c
index f9e25aea7..aa282a27f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2000,6 +2000,25 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 	free(to_clear);
 }
 
+int add_str_to_commit_list(struct string_list_item *item, void *commit_list)
+{
+	struct object_id oid;
+	struct commit *commit;
+
+	if (get_oid(item->string, &oid)) {
+		error(_("malformed object name %s"), item->string);
+		exit(1);
+	}
+	commit = lookup_commit_reference(&oid);
+	if (!commit) {
+		error(_("no such commit %s"), item->string);
+		exit(1);
+	}
+	commit_list_insert(commit, commit_list);
+
+	return 0;
+}
+
 /*
  * API for filtering a set of refs. Based on the type of refs the user
  * has requested, we iterate through those refs and apply filters
@@ -2012,6 +2031,10 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	int ret = 0;
 	unsigned int broken = 0;
 
+	/* Convert string representation and add to commit list. */
+	for_each_string_list(&filter->with_commit_strs, add_str_to_commit_list, &filter->with_commit);
+	for_each_string_list(&filter->no_commit_strs, add_str_to_commit_list, &filter->no_commit);
+
 	ref_cbdata.array = array;
 	ref_cbdata.filter = filter;
 
diff --git a/ref-filter.h b/ref-filter.h
index 0d98342b3..62f37760f 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -55,6 +55,9 @@ struct ref_filter {
 	struct commit_list *with_commit;
 	struct commit_list *no_commit;
 
+	struct string_list with_commit_strs;
+	struct string_list no_commit_strs;
+
 	enum {
 		REF_FILTER_MERGED_NONE = 0,
 		REF_FILTER_MERGED_INCLUDE,
diff --git a/t/tcontains.sh b/t/tcontains.sh
new file mode 100755
index 000000000..4856111ff
--- /dev/null
+++ b/t/tcontains.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='Test "contains" argument behavior'
+
+. ./test-lib.sh
+
+test_expect_success 'setup ' '
+	git init . &&
+	echo "this is a test" >file &&
+	git add -A &&
+	git commit -am "tag test" &&
+	git tag "v1.0" &&
+	git tag "v1.1"
+'
+
+test_expect_success 'tag --contains <existent_tag>' '
+	git tag --contains "v1.0" >actual &&
+	grep "v1.0" actual &&
+	grep "v1.1" actual
+'
+
+test_expect_success 'tag --contains <inexistent_tag>' '
+	test_must_fail git tag --contains "notag" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'tag --no-contains <existent_tag>' '
+	git tag --no-contains "v1.1" >actual &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'tag --no-contains <inexistent_tag>' '
+	test_must_fail git tag --no-contains "notag" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'tag usage error' '
+	test_must_fail git tag --noopt 2>actual &&
+	test_i18ngrep "usage" actual
+'
+
+test_expect_success 'branch --contains <existent_commit>' '
+	git branch --contains "master" >actual &&
+	test_i18ngrep "master" actual
+'
+
+test_expect_success 'branch --contains <inexistent_commit>' '
+	test_must_fail git branch --no-contains "nocommit" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'branch --no-contains <existent_commit>' '
+	git branch --no-contains "master" >actual &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'branch --no-contains <inexistent_commit>' '
+	test_must_fail git branch --no-contains "nocommit" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'branch usage error' '
+	test_must_fail git branch --noopt 2>actual &&
+	test_i18ngrep "usage" actual
+'
+
+test_expect_success 'for-each-ref --contains <existent_object>' '
+	git for-each-ref --contains "master" >actual &&
+	test_line_count = 3 actual
+'
+
+test_expect_success 'for-each-ref --contains <inexistent_object>' '
+	test_must_fail git for-each-ref --no-contains "noobject" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'for-each-ref --no-contains <existent_object>' '
+	git for-each-ref --no-contains "master" >actual &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'for-each-ref --no-contains <inexistent_object>' '
+	test_must_fail git for-each-ref --no-contains "noobject" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'for-each-ref usage error' '
+	test_must_fail git for-each-ref --noopt 2>actual &&
+	test_i18ngrep "usage" actual
+'
+
+test_done
-- 
2.16.1.195.g8f471d4ad.dirty

