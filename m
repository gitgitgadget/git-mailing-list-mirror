Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A74E1F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbeELIAn (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:00:43 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40351 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeELIAj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:39 -0400
Received: by mail-lf0-f68.google.com with SMTP id p85-v6so11044553lfg.7
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHjD4L+S9TCvh3hjiFk1zJSfLp8yJt5d84geHgPLuJE=;
        b=F0npenrZoyz6JOdJKBdD0KeYcV7R7BC+0vxHj/9kAUyFEg6MwqXdFPTK5uarlTPPvg
         HoIfoo49eb7acZwhQZCQc5cMvtFNm9/i5QQm+f2DvmlhOTLG7mPL0wIRhNz+TTQ7q/jZ
         uu+w5YqteJyQCdsHTX3K5nUWlR7f2Tu9Q17qjtehq29hQ3UPHBvlZA54bJ1COn6AtIxi
         QFhcPl50oZ9kEkAQzYfjM+WCwaYHhSJO8y4VntmPnd+WtQ9nuSG9WLO+tqjkxeEhiQaU
         K2x3yWzhudraRcoBMqa09Ys6fNYNP7vp+/RuLrjvYMN7aGmKm2CHWno89eYUO+VCAdhc
         If3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHjD4L+S9TCvh3hjiFk1zJSfLp8yJt5d84geHgPLuJE=;
        b=KbbTfPqsWfYP5Tztu6C1xsjn5idYFvJm4HFdWxigq8FS+BTi5PcDBn4WETtytJ1M5/
         dyxthcAZKouj+DVW12uzu/UwlnfyHR1NvxN5GudObmwdr+HyE5+2ylR+/6Gnomys09ff
         o++i1U5wqoNzYdClqWAXsPyeG5ux4TfnMy5AYt4M+eWIobkxl69XBlgAFpAqsVMyLNPz
         nexuy+j2W+KJduNFX7hq2R9vPd5lffAXdp8aqky9abo6YeXma9RcEXcPQvxCKHaXnzdX
         rLAEBCAMBUdkTGYcY83Kpk5yMrQErL/uPFHrWnqGCbjsN4v55KXNhFbu1YYjfVzBFfTT
         41Ag==
X-Gm-Message-State: ALKqPwfFiFqXInT06YFOTXr/LQ3XMoJQlvoqUeMk7wSxDfuAcSdD9cEx
        iSVdGL/Wf7WzxcIzBQP9XlEIYg==
X-Google-Smtp-Source: AB8JxZob4FXVU/AfhoL3GUekamMOS6B0qZi/WO4LBnQcAARY/SavqKHCdZ2ruIRBuvocYPo9JvdNZQ==
X-Received: by 2002:a19:1d84:: with SMTP id d126-v6mr3590787lfd.100.1526112038017;
        Sat, 12 May 2018 01:00:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/12] revision.c: use commit-slab for show_source
Date:   Sat, 12 May 2018 10:00:22 +0200
Message-Id: <20180512080028.29611-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of relying on commit->util to store the source string, let the
user provide a commit-slab to store the source strings in.

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fast-export.c | 14 +++++++++-----
 builtin/log.c         |  7 +++++--
 log-tree.c            |  8 ++++++--
 revision.c            | 17 +++++++++++++----
 revision.h            |  5 ++++-
 5 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 530df12f05..092e29583e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -21,6 +21,7 @@
 #include "quote.h"
 #include "remote.h"
 #include "blob.h"
+#include "commit-slab.h"
 
 static const char *fast_export_usage[] = {
 	N_("git fast-export [rev-list-opts]"),
@@ -38,6 +39,7 @@ static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct refspec *refspecs;
 static int refspecs_nr;
 static int anonymize;
+static struct source_slab source_slab;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -590,7 +592,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
 			export_blob(&diff_queued_diff.queue[i]->two->oid);
 
-	refname = commit->util;
+	refname = *source_slab_peek(&source_slab, commit);
 	if (anonymize) {
 		refname = anonymize_refname(refname);
 		anonymize_ident_line(&committer, &committer_end);
@@ -862,10 +864,11 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		 * This ref will not be updated through a commit, lets make
 		 * sure it gets properly updated eventually.
 		 */
-		if (commit->util || commit->object.flags & SHOWN)
+		if (*source_slab_at(&source_slab, commit) ||
+		    commit->object.flags & SHOWN)
 			string_list_append(&extra_refs, full_name)->util = commit;
-		if (!commit->util)
-			commit->util = full_name;
+		if (!*source_slab_at(&source_slab, commit))
+			*source_slab_at(&source_slab, commit) = full_name;
 	}
 }
 
@@ -1029,8 +1032,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	init_revisions(&revs, prefix);
+	init_source_slab(&source_slab);
 	revs.topo_order = 1;
-	revs.show_source = 1;
+	revs.source_slab = &source_slab;
 	revs.rewrite_parents = 1;
 	argc = parse_options(argc, argv, prefix, options, fast_export_usage,
 			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
diff --git a/builtin/log.c b/builtin/log.c
index 71f68a3e4f..0d199ebd5d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -148,6 +148,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
 	struct decoration_filter decoration_filter = {&decorate_refs_include,
 						      &decorate_refs_exclude};
+	static struct source_slab source_slab;
 
 	const struct option builtin_log_options[] = {
 		OPT__QUIET(&quiet, N_("suppress diff output")),
@@ -194,8 +195,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	    rev->diffopt.filter || rev->diffopt.flags.follow_renames)
 		rev->always_show_header = 0;
 
-	if (source)
-		rev->show_source = 1;
+	if (source) {
+		init_source_slab(&source_slab);
+		rev->source_slab = &source_slab;
+	}
 
 	if (mailmap) {
 		rev->mailmap = xcalloc(1, sizeof(struct string_list));
diff --git a/log-tree.c b/log-tree.c
index d1c0bedf24..d36a945fc4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -295,8 +295,12 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	if (opt->show_source && commit->util)
-		fprintf(opt->diffopt.file, "\t%s", (char *) commit->util);
+	if (opt->source_slab) {
+		char **slot = source_slab_peek(opt->source_slab, commit);
+
+		if (slot && *slot)
+			fprintf(opt->diffopt.file, "\t%s", *slot);
+	}
 	if (!opt->show_decorations)
 		return;
 	format_decorations(&sb, commit, opt->diffopt.use_color);
diff --git a/revision.c b/revision.c
index 1cff11833e..41b56f789d 100644
--- a/revision.c
+++ b/revision.c
@@ -255,14 +255,19 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 */
 	if (object->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)object;
+
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
 			revs->limited = 1;
 		}
-		if (revs->show_source && !commit->util)
-			commit->util = xstrdup(name);
+		if (revs->source_slab) {
+			char **slot = source_slab_at(revs->source_slab, commit);
+
+			if (!*slot)
+				*slot = xstrdup(name);
+		}
 		return commit;
 	}
 
@@ -814,8 +819,12 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			}
 			return -1;
 		}
-		if (revs->show_source && !p->util)
-			p->util = commit->util;
+		if (revs->source_slab) {
+			char **slot = source_slab_at(revs->source_slab, p);
+
+			if (!*slot)
+				*slot = *source_slab_at(revs->source_slab, commit);
+		}
 		p->object.flags |= left_flag;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= SEEN;
diff --git a/revision.h b/revision.h
index b8c47b98e2..72404e2599 100644
--- a/revision.h
+++ b/revision.h
@@ -6,6 +6,7 @@
 #include "notes.h"
 #include "pretty.h"
 #include "diff.h"
+#include "commit-slab.h"
 
 /* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
@@ -29,6 +30,7 @@ struct rev_info;
 struct log_info;
 struct string_list;
 struct saved_parents;
+define_commit_slab(source_slab, char *);
 
 struct rev_cmdline_info {
 	unsigned int nr;
@@ -111,7 +113,6 @@ struct rev_info {
 			right_only:1,
 			rewrite_parents:1,
 			print_parents:1,
-			show_source:1,
 			show_decorations:1,
 			reverse:1,
 			reverse_output_stage:1,
@@ -224,6 +225,8 @@ struct rev_info {
 
 	struct commit_list *previous_parents;
 	const char *break_bar;
+
+	struct source_slab *source_slab;
 };
 
 extern int ref_excluded(struct string_list *, const char *path);
-- 
2.17.0.705.g3525833791

