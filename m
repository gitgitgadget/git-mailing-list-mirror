Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DEDC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F1D613D1
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347284AbhI2XIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 19:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347466AbhI2XIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 19:08:16 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B1FC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:34 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v10-20020ad4554a000000b0038250b18b6dso9354233qvy.12
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Upy0c5uTxmwwaMQ3imcsowolViZMkgLpftPPpt7wA8M=;
        b=H2q/B2gje0WDUF59n/r7XJSrq9+fqYbEK4Tt5AnYqhGw8dDZ128cdtVsyvWUyf2gII
         NMJKHROfH6VZTeuo3sePlKfih4RmWZpRg3lGimZw09Os/qX0+yZaw2Rs1TI11TPeQBTm
         V8f3rLF0rZAnoii2wDMJPePFGfqpNOeR9Z1HnWcbDl8jbhoQaRIQHIWjVZKBhKw0AsaA
         fXnqyoP7jRPCUKf7l2As/VhSCbw3MX6UwDnQUEtqni0m8cOzSfzWT9i9TisftEWTHVDM
         MX8+UMnkkWbblJcTYaqsa9yNYW4gE6SvACQNRshpAd1tqBIQvT4lHPT8lEyTlKiMpnsZ
         3JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Upy0c5uTxmwwaMQ3imcsowolViZMkgLpftPPpt7wA8M=;
        b=MkXlcYIIMT75hc0LV66wfOZzTXeQbbuugZWyv/iKBlo7f1yEnFjVoUTo/0OVVBTXuj
         fASZqlwBeOT67UYJ7KA6r+Cha+E9GW56/HzMILPXRHWTSPLQAvHr3be8cdlxehBSw0cW
         tQQD4P7OKjAEGh8GBx4o6OMPBwhJS/kGkcfWTiidHUw3iz+rAPHsVPnPPPJyI/DF177o
         +LkqfWtjFBigQlIYUmQHufU6oAHtNwsb+CE449tZw7afjxcORousUspe8OuULkGcDvTU
         sOG3G2JIjN+AYvWaJ3khpxl4PSuN2Ey3Fc3q9x/uRuFQ1YwbV0K5ALupsac7SHeDy8we
         lN1g==
X-Gm-Message-State: AOAM5325sUYRxeOU9V6tkCNfIj7JtGsmAsstDoAezwmG2cmg6qx6BIXs
        hzVwbQJu5gG1UhU/pKZLnGnGsOj8d3ScFnkImYVQUHSnALHetHOQHYUoLdvXmFV8yKPDrChk0L5
        CwmgA1+AArrkr54CVkFmHEUwdgJ/UpLCV2Ks7WNcKsXcoNo/qDhQ7hwtYVfVe0yy+VI1k1rqmvc
        Nc
X-Google-Smtp-Source: ABdhPJyWux6HZHd9s1mobA6wlcy8uE7pQttZnWnafLeLPNeLTrfSAevn8lQazCBubglei1Cce0xV+Lbk5kKOa2LdnuBH
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:4a83:: with SMTP id
 h3mr979222qvx.25.1632956793676; Wed, 29 Sep 2021 16:06:33 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:06:20 -0700
In-Reply-To: <cover.1632956589.git.jonathantanmy@google.com>
Message-Id: <e4a1be22c8759d495cf00d71a06227b87d433ecf.1632956589.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632956589.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 4/7] merge-{ort,recursive}: remove add_submodule_odb()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the parent commit and some of its ancestors, the only place
commits are being accessed through alternates is in the user-facing
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
index b88475475d..fbc5c204c1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -609,6 +609,7 @@ static int err(struct merge_options *opt, const char *err, ...)
 
 static void format_commit(struct strbuf *sb,
 			  int indent,
+			  struct repository *repo,
 			  struct commit *commit)
 {
 	struct merge_remote_desc *desc;
@@ -622,7 +623,7 @@ static void format_commit(struct strbuf *sb,
 		return;
 	}
 
-	format_commit_message(commit, "%h %s", sb, &ctx);
+	repo_format_commit_message(repo, commit, "%h %s", sb, &ctx);
 	strbuf_addch(sb, '\n');
 }
 
@@ -1578,17 +1579,6 @@ static int merge_submodule(struct merge_options *opt,
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
@@ -1653,7 +1643,7 @@ static int merge_submodule(struct merge_options *opt,
 		break;
 
 	case 1:
-		format_commit(&sb, 4,
+		format_commit(&sb, 4, &subrepo,
 			      (struct commit *)merges.objects[0].item);
 		path_msg(opt, path, 0,
 			 _("Failed to merge submodule %s, but a possible merge "
@@ -1670,7 +1660,7 @@ static int merge_submodule(struct merge_options *opt,
 		break;
 	default:
 		for (i = 0; i < merges.nr; i++)
-			format_commit(&sb, 4,
+			format_commit(&sb, 4, &subrepo,
 				      (struct commit *)merges.objects[i].item);
 		path_msg(opt, path, 0,
 			 _("Failed to merge submodule %s, but multiple "
diff --git a/merge-recursive.c b/merge-recursive.c
index 5a2d8a60c0..80594153f1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -334,7 +334,9 @@ static void output(struct merge_options *opt, int v, const char *fmt, ...)
 		flush_output(opt);
 }
 
-static void output_commit_title(struct merge_options *opt, struct commit *commit)
+static void repo_output_commit_title(struct merge_options *opt,
+				     struct repository *repo,
+				     struct commit *commit)
 {
 	struct merge_remote_desc *desc;
 
@@ -343,23 +345,29 @@ static void output_commit_title(struct merge_options *opt, struct commit *commit
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
@@ -1149,14 +1157,14 @@ static int find_first_merges(struct repository *repo,
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
@@ -1196,15 +1204,6 @@ static int merge_submodule(struct merge_options *opt,
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
@@ -1229,7 +1228,7 @@ static int merge_submodule(struct merge_options *opt,
 		oidcpy(result, b);
 		if (show(opt, 3)) {
 			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
-			output_commit_title(opt, commit_b);
+			repo_output_commit_title(opt, &subrepo, commit_b);
 		} else if (show(opt, 2))
 			output(opt, 2, _("Fast-forwarding submodule %s"), path);
 		else
@@ -1242,7 +1241,7 @@ static int merge_submodule(struct merge_options *opt,
 		oidcpy(result, a);
 		if (show(opt, 3)) {
 			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
-			output_commit_title(opt, commit_a);
+			repo_output_commit_title(opt, &subrepo, commit_a);
 		} else if (show(opt, 2))
 			output(opt, 2, _("Fast-forwarding submodule %s"), path);
 		else
@@ -1274,7 +1273,7 @@ static int merge_submodule(struct merge_options *opt,
 	case 1:
 		output(opt, 1, _("Failed to merge submodule %s (not fast-forward)"), path);
 		output(opt, 2, _("Found a possible merge resolution for the submodule:\n"));
-		print_commit((struct commit *) merges.objects[0].item);
+		print_commit(&subrepo, (struct commit *) merges.objects[0].item);
 		output(opt, 2, _(
 		       "If this is correct simply add it to the index "
 		       "for example\n"
@@ -1287,7 +1286,7 @@ static int merge_submodule(struct merge_options *opt,
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
2.33.0.685.g46640cef36-goog

