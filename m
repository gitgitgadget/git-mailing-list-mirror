Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1E8C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35EE611C5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhIUQw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhIUQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:52:50 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6EDC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:22 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id v206-20020a627ad7000000b0043e010e5392so38124pfc.1
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6/+0f8JDOAEVdbdXaTV1+hoWjLFcXUrCQTK555FD/Ak=;
        b=Pqz8iSFBmXBLv4VonDxoA1uZs53u7SJAnR354SELwc7M/t1gCHIBfPJGiDWX0zzgJ/
         X27XbfvcfiZ5lCD5/DlA/zAHX/aYCb41RU4cavXhO47s1ve3vcBdd0/Kbz/H6AfqxrIk
         dvGnzhaT1JLkZhtkY3l4k0SRSBWow6goKj8mk5UDMNlCDZdXZWREVev7pXfjSdbqK6Py
         H51cazIwlB7yM6gwXt/X12H9L2cdzYLA2BMkN7on0ep4bM7nygfz10GN52ZrePpAFSnw
         PDUh6p4RileGBCogEr5syFqqJHNjdUj6yhylkMn8DW7G7m+PS6GwVjjXH/psWfq7L4PM
         5HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6/+0f8JDOAEVdbdXaTV1+hoWjLFcXUrCQTK555FD/Ak=;
        b=AhSff3jw5U3t6ntNb51K21jzcR7R3B8EN9tBFVcrMbcvFaizTJq/d6A6kwFfs5ufm1
         VnYIMfnk4HduhftapbHlJGEcEBNPm5A2U49aF3TbYOFHIDgxjdNKkHhtIQBfLzWOUwzU
         6LDzxGVocoJufrj+xv9oQPOf3AdUepPnYduEKBWBELBXuxaR4YFBJJIdlPJu5R/mWqE5
         XFXrSN+Ss1WpgFeU3dcwrUfKA9OiNiOVXApYBSpkUaSvFIPjLu5M1dg/o7tSvUY1hrtk
         XIiHmxY2UOK4bcsI332dKq/3/DSRmdMIWemBx0aZzZkwykiLDnShIDt9nUkxuQA//eTC
         9Rlw==
X-Gm-Message-State: AOAM531rAtv7D6NS1rZvf7izLQUx0oDrffJAJuZGWHWzf6FmaJAmALi3
        svyNivQupsdVKN0syuM0QiZsLo9N1aHzASidkyt+UjruM8X9cAh3kDno7Ws6/b/S6fQOQiPsbtf
        Do9uX9FIIGsGS0hgwLEGfHszNKzxlucHZ8omZOUul8YJfwsSKaZALk7w0cQr6WckMi+yTiBQjRo
        qE
X-Google-Smtp-Source: ABdhPJwSeZgFnG2vlxug+/6j7q8/CmdAhwE7wcYmHfj+6Af4Dug18WNOLjgUoriKHSFgL2/zhvMHX3m20crywEBuk+bU
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:8d4:b0:447:cfd7:1b6a with
 SMTP id s20-20020a056a0008d400b00447cfd71b6amr8271501pfu.28.1632243081793;
 Tue, 21 Sep 2021 09:51:21 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:51:07 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <0655a321bd9630736d6853437cc8d11a5cd012b6.1632242495.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 5/9] merge-{ort,recursive}: remove add_submodule_odb()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the parent commit and some of its ancestors, the only place
commits are being accessed through alternates are in the user-facing
message formatting code. Fix those, and remove the add_submodule_odb()
calls.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 merge-ort.c                | 18 ++++-------------
 merge-recursive.c          | 41 +++++++++++++++++++-------------------
 strbuf.c                   | 12 ++++++++---
 strbuf.h                   |  6 ++++--
 t/t6437-submodule-merge.sh |  3 +++
 5 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index b8efaee8e0..a4aad8f33f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -628,6 +628,7 @@ static int err(struct merge_options *opt, const char *err, ...)
 
 static void format_commit(struct strbuf *sb,
 			  int indent,
+			  struct repository *repo,
 			  struct commit *commit)
 {
 	struct merge_remote_desc *desc;
@@ -641,7 +642,7 @@ static void format_commit(struct strbuf *sb,
 		return;
 	}
 
-	format_commit_message(commit, "%h %s", sb, &ctx);
+	repo_format_commit_message(repo, commit, "%h %s", sb, &ctx);
 	strbuf_addch(sb, '\n');
 }
 
@@ -1566,17 +1567,6 @@ static int merge_submodule(struct merge_options *opt,
 	if (is_null_oid(b))
 		return 0;
 
-	/*
-	 * NEEDSWORK: Remove this when all submodule object accesses are
-	 * through explicitly specified repositores.
-	 */
-	if (add_submodule_odb(path)) {
-		path_msg(opt, path, 0,
-			 _("Failed to merge submodule %s (not checked out)"),
-			 path);
-		return 0;
-	}
-
 	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
 		path_msg(opt, path, 0,
 				_("Failed to merge submodule %s (not checked out)"),
@@ -1641,7 +1631,7 @@ static int merge_submodule(struct merge_options *opt,
 		break;
 
 	case 1:
-		format_commit(&sb, 4,
+		format_commit(&sb, 4, &subrepo,
 			      (struct commit *)merges.objects[0].item);
 		path_msg(opt, path, 0,
 			 _("Failed to merge submodule %s, but a possible merge "
@@ -1658,7 +1648,7 @@ static int merge_submodule(struct merge_options *opt,
 		break;
 	default:
 		for (i = 0; i < merges.nr; i++)
-			format_commit(&sb, 4,
+			format_commit(&sb, 4, &subrepo,
 				      (struct commit *)merges.objects[i].item);
 		path_msg(opt, path, 0,
 			 _("Failed to merge submodule %s, but multiple "
diff --git a/merge-recursive.c b/merge-recursive.c
index fc8ac39d8c..6e8fb39315 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -337,7 +337,9 @@ static void output(struct merge_options *opt, int v, const char *fmt, ...)
 		flush_output(opt);
 }
 
-static void output_commit_title(struct merge_options *opt, struct commit *commit)
+static void repo_output_commit_title(struct merge_options *opt,
+				     struct repository *repo,
+				     struct commit *commit)
 {
 	struct merge_remote_desc *desc;
 
@@ -346,23 +348,29 @@ static void output_commit_title(struct merge_options *opt, struct commit *commit
 	if (desc)
 		strbuf_addf(&opt->obuf, "virtual %s\n", desc->name);
 	else {
-		strbuf_add_unique_abbrev(&opt->obuf, &commit->object.oid,
-					 DEFAULT_ABBREV);
+		strbuf_repo_add_unique_abbrev(&opt->obuf, repo,
+					      &commit->object.oid,
+					      DEFAULT_ABBREV);
 		strbuf_addch(&opt->obuf, ' ');
-		if (parse_commit(commit) != 0)
+		if (repo_parse_commit(repo, commit) != 0)
 			strbuf_addstr(&opt->obuf, _("(bad commit)\n"));
 		else {
 			const char *title;
-			const char *msg = get_commit_buffer(commit, NULL);
+			const char *msg = repo_get_commit_buffer(repo, commit, NULL);
 			int len = find_commit_subject(msg, &title);
 			if (len)
 				strbuf_addf(&opt->obuf, "%.*s\n", len, title);
-			unuse_commit_buffer(commit, msg);
+			repo_unuse_commit_buffer(repo, commit, msg);
 		}
 	}
 	flush_output(opt);
 }
 
+static void output_commit_title(struct merge_options *opt, struct commit *commit)
+{
+	repo_output_commit_title(opt, the_repository, commit);
+}
+
 static int add_cacheinfo(struct merge_options *opt,
 			 const struct diff_filespec *blob,
 			 const char *path, int stage, int refresh, int options)
@@ -1152,14 +1160,14 @@ static int find_first_merges(struct repository *repo,
 	return result->nr;
 }
 
-static void print_commit(struct commit *commit)
+static void print_commit(struct repository *repo, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	ctx.date_mode.type = DATE_NORMAL;
 	/* FIXME: Merge this with output_commit_title() */
 	assert(!merge_remote_util(commit));
-	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
+	repo_format_commit_message(repo, commit, " %h: %m %s", &sb, &ctx);
 	fprintf(stderr, "%s\n", sb.buf);
 	strbuf_release(&sb);
 }
@@ -1199,15 +1207,6 @@ static int merge_submodule(struct merge_options *opt,
 	if (is_null_oid(b))
 		return 0;
 
-	/*
-	 * NEEDSWORK: Remove this when all submodule object accesses are
-	 * through explicitly specified repositores.
-	 */
-	if (add_submodule_odb(path)) {
-		output(opt, 1, _("Failed to merge submodule %s (not checked out)"), path);
-		return 0;
-	}
-
 	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
 		output(opt, 1, _("Failed to merge submodule %s (not checked out)"), path);
 		return 0;
@@ -1232,7 +1231,7 @@ static int merge_submodule(struct merge_options *opt,
 		oidcpy(result, b);
 		if (show(opt, 3)) {
 			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
-			output_commit_title(opt, commit_b);
+			repo_output_commit_title(opt, &subrepo, commit_b);
 		} else if (show(opt, 2))
 			output(opt, 2, _("Fast-forwarding submodule %s"), path);
 		else
@@ -1245,7 +1244,7 @@ static int merge_submodule(struct merge_options *opt,
 		oidcpy(result, a);
 		if (show(opt, 3)) {
 			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
-			output_commit_title(opt, commit_a);
+			repo_output_commit_title(opt, &subrepo, commit_a);
 		} else if (show(opt, 2))
 			output(opt, 2, _("Fast-forwarding submodule %s"), path);
 		else
@@ -1277,7 +1276,7 @@ static int merge_submodule(struct merge_options *opt,
 	case 1:
 		output(opt, 1, _("Failed to merge submodule %s (not fast-forward)"), path);
 		output(opt, 2, _("Found a possible merge resolution for the submodule:\n"));
-		print_commit((struct commit *) merges.objects[0].item);
+		print_commit(&subrepo, (struct commit *) merges.objects[0].item);
 		output(opt, 2, _(
 		       "If this is correct simply add it to the index "
 		       "for example\n"
@@ -1290,7 +1289,7 @@ static int merge_submodule(struct merge_options *opt,
 	default:
 		output(opt, 1, _("Failed to merge submodule %s (multiple merges found)"), path);
 		for (i = 0; i < merges.nr; i++)
-			print_commit((struct commit *) merges.objects[i].item);
+			print_commit(&subrepo, (struct commit *) merges.objects[i].item);
 	}
 
 	object_array_clear(&merges);
diff --git a/strbuf.c b/strbuf.c
index c8a5789694..b22e981655 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1059,15 +1059,21 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 	strbuf_setlen(sb, sb->len + len);
 }
 
-void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
-			      int abbrev_len)
+void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
+				   const struct object_id *oid, int abbrev_len)
 {
 	int r;
 	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
-	r = find_unique_abbrev_r(sb->buf + sb->len, oid, abbrev_len);
+	r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
 	strbuf_setlen(sb, sb->len + r);
 }
 
+void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
+			      int abbrev_len)
+{
+	strbuf_repo_add_unique_abbrev(sb, the_repository, oid, abbrev_len);
+}
+
 /*
  * Returns the length of a line, without trailing spaces.
  *
diff --git a/strbuf.h b/strbuf.h
index 5b1113abf8..2d9e01c16f 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -634,8 +634,10 @@ void strbuf_list_free(struct strbuf **list);
  * Add the abbreviation, as generated by find_unique_abbrev, of `sha1` to
  * the strbuf `sb`.
  */
-void strbuf_add_unique_abbrev(struct strbuf *sb,
-			      const struct object_id *oid,
+struct repository;
+void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
+				   const struct object_id *oid, int abbrev_len);
+void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 			      int abbrev_len);
 
 /**
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index e5e89c2045..178413c22f 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -5,6 +5,9 @@ test_description='merging with submodules'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
+export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
-- 
2.33.0.464.g1972c5931b-goog

