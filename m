Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25325211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfANSfO (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 13:35:14 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:37172 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfANSfN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 13:35:13 -0500
Received: by mail-lj1-f177.google.com with SMTP id t18-v6so26045ljd.4
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 10:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWK5I93Byk/rouU7TgtXihxUgScoLQqR9h1DmpnZGLk=;
        b=tOw5PG4JIVNfTMQDlx6xPN2gvY7nzZB9IIc0u27Oh7Fs9XDVRQbqwwz3EdMCjE+sf9
         YdTuTTq7b6tu3neryxwQjAuzyaug6cZapecHDh3itttOyp6+2HT/qxsMBM7tAv7gBE+0
         4Fu4jxKPmZRrENVRyFpShsQQbp5how3mvoc6B3E3aIP4cDtc961KBzTOaVKUlIOhjTQ0
         faHzNCWHoK7LFeQRNXYBSrqiFXN6ccWavhA49j6hNKGYMjDQp98bZo6oEVpwerhSx0Ns
         YitGm4H8CWYy9fSg+/+kIAgCQd+1sTSQRjVdZt3bCRig4d3POGZP+T7GinyHXQoiefGR
         P5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWK5I93Byk/rouU7TgtXihxUgScoLQqR9h1DmpnZGLk=;
        b=h+q7/Ss1JSts1eCetV/1J67//WluyD/f80xhPjHpDlYYklJxYooAbaTXS6b2GOPbHK
         1DzRhV1IUAwCoUiYRzZAwbscLg6oDEoVDLOHNz2qosApg5elYKC/lZoArfb8OWrCnjsP
         dX8luBS24SkFTyrkMjDaE1a9izYPq9JGLeUV+ErP+tvmw8d292FXtDZXz51jLEUMxR2i
         wfd9jkqO6bn5IiL0dvp0yWs+7vmOGLaAmYcsmjujG4e9ACgVCPMatrmh+dHRuC4dmS5j
         gJg0k35/wh0qW5Et7AGDwLputN2KZpZX0EDJ/yAHHPqh5uT8v2BgrSsDgfOwd0782lJF
         1lLQ==
X-Gm-Message-State: AJcUukcGDtm1TEn5fnnI1T4NNPHDo+04Yg7KsR/FY2qWJDpoRir7Wa3f
        TfHOe+me1qeGTdiNYloxhhss4v/c
X-Google-Smtp-Source: ALg8bN4PZ83Fr7h5aHaIW0InlRGJfVr/NzkACel4uUxeAXNUXyRRkASwLdj5epaKFbR2c507vCtSmA==
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr15212132lji.30.1547490911295;
        Mon, 14 Jan 2019 10:35:11 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id x24-v6sm224492ljc.54.2019.01.14.10.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 10:35:10 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 3/3] setup: add `clear_repository_format()`
Date:   Mon, 14 Jan 2019 19:34:57 +0100
Message-Id: <7b0ca165bce684bde38b753ab98f7858f20130c0.1547488709.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1547488709.git.martin.agren@gmail.com>
References: <20181218072528.3870492-1-martin.agren@gmail.com> <cover.1547488709.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we set up a `struct repository_format`, it owns various pieces of
allocated memory. We then either use those members, because we decide we
want to use the "candidate" repository format, or we discard the
candidate / scratch space. In the first case, we transfer ownership of
the memory to a few global variables. In the latter case, we just
silently drop the struct and end up leaking memory.

Fixing these memory leaks is complicated by two issues:

  1) As described above, we "steal" the fields of the struct in case of
     success.

  2) We might end up calling `read_repository_format()` more than once
     -- as we enter it a second time, we lose track of our pointers and
     leak memory. As a further complication, we do not initialize (zero)
     the structs before calling `read_...()` so as we first enter it, we
     cannot blindly free the pointers in it.

To free this memory, in light of (1), we must either carefully cover all
error paths but no success paths; or we should stop grabbing the
pointers. To address 2), we must either zero the struct before calling
`read_repository_format()`, or try to keep track of when we should zero
it and when we should first free the memory.

Introduce `REPO_FORMAT_INIT` and `clear_repository_format()` to be used
on each side of `read_repository_format()`. Make the users duplicate the
memory from the structs, rather than copying the pointers.

Call `clear_...()` at the start of `read_...()` instead of just zeroing
the struct. In the error path of the same function, be sure to restore
the error sentinel after we clear it with the rest of the struct.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 I do wonder if introducing and depending on `REPOSITORY_FORMAT_INIT`
 like this is 100% sane. Out-of-tree users could be in for a nasty
 surprise. :-/

 cache.h           | 12 ++++++++++++
 builtin/init-db.c |  3 ++-
 repository.c      |  3 ++-
 setup.c           | 30 ++++++++++++++++++++++--------
 worktree.c        |  4 +++-
 5 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index ca36b44ee0..3ef63d27c4 100644
--- a/cache.h
+++ b/cache.h
@@ -972,6 +972,12 @@ struct repository_format {
 	struct string_list unknown_extensions;
 };
 
+/**
+ * Always use this to initialize a `struct repository_format`
+ * to a well-defined state before calling `read_repository()`.
+ */
+#define REPOSITORY_FORMAT_INIT { 0 }
+
 /*
  * Read the repository format characteristics from the config file "path" into
  * "format" struct. Returns the numeric version. On error, -1 is returned,
@@ -980,6 +986,12 @@ struct repository_format {
  */
 int read_repository_format(struct repository_format *format, const char *path);
 
+/*
+ * Free the memory held onto by `format`, but not the struct itself.
+ * (No need to use this after `read_repository_format()` fails.)
+ */
+void clear_repository_format(struct repository_format *format);
+
 /*
  * Verify that the repository described by repository_format is something we
  * can read. If it is, return 0. Otherwise, return -1, and "err" will describe
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 41faffd28d..04c60eaad5 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -96,7 +96,7 @@ static void copy_templates(const char *template_dir)
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf template_path = STRBUF_INIT;
 	size_t template_len;
-	struct repository_format template_format;
+	struct repository_format template_format = REPOSITORY_FORMAT_INIT;
 	struct strbuf err = STRBUF_INIT;
 	DIR *dir;
 	char *to_free = NULL;
@@ -148,6 +148,7 @@ static void copy_templates(const char *template_dir)
 	free(to_free);
 	strbuf_release(&path);
 	strbuf_release(&template_path);
+	clear_repository_format(&template_format);
 }
 
 static int git_init_db_config(const char *k, const char *v, void *cb)
diff --git a/repository.c b/repository.c
index 7b02e1dffa..df88705574 100644
--- a/repository.c
+++ b/repository.c
@@ -148,7 +148,7 @@ int repo_init(struct repository *repo,
 	      const char *gitdir,
 	      const char *worktree)
 {
-	struct repository_format format;
+	struct repository_format format = REPOSITORY_FORMAT_INIT;
 	memset(repo, 0, sizeof(*repo));
 
 	repo->objects = raw_object_store_new();
@@ -165,6 +165,7 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
+	clear_repository_format(&format);
 	return 0;
 
 error:
diff --git a/setup.c b/setup.c
index 4d3d67c50b..70d9007ae5 100644
--- a/setup.c
+++ b/setup.c
@@ -477,7 +477,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	}
 
 	repository_format_precious_objects = candidate->precious_objects;
-	repository_format_partial_clone = candidate->partial_clone;
+	repository_format_partial_clone = xstrdup_or_null(candidate->partial_clone);
 	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
 
@@ -500,11 +500,9 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		}
 		if (candidate->work_tree) {
 			free(git_work_tree_cfg);
-			git_work_tree_cfg = candidate->work_tree;
+			git_work_tree_cfg = xstrdup(candidate->work_tree);
 			inside_work_tree = -1;
 		}
-	} else {
-		free(candidate->work_tree);
 	}
 
 	return 0;
@@ -512,15 +510,27 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 
 int read_repository_format(struct repository_format *format, const char *path)
 {
-	memset(format, 0, sizeof(*format));
+	clear_repository_format(format);
 	format->version = -1;
 	format->is_bare = -1;
 	format->hash_algo = GIT_HASH_SHA1;
 	string_list_init(&format->unknown_extensions, 1);
 	git_config_from_file(check_repo_format, path, format);
+	if (format->version == -1) {
+		clear_repository_format(format);
+		format->version = -1;
+	}
 	return format->version;
 }
 
+void clear_repository_format(struct repository_format *format)
+{
+	string_list_clear(&format->unknown_extensions, 0);
+	free(format->work_tree);
+	free(format->partial_clone);
+	memset(format, 0, sizeof(*format));
+}
+
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err)
 {
@@ -1008,7 +1018,7 @@ int discover_git_directory(struct strbuf *commondir,
 	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
 	size_t gitdir_offset = gitdir->len, cwd_len;
 	size_t commondir_offset = commondir->len;
-	struct repository_format candidate;
+	struct repository_format candidate = REPOSITORY_FORMAT_INIT;
 
 	if (strbuf_getcwd(&dir))
 		return -1;
@@ -1045,9 +1055,11 @@ int discover_git_directory(struct strbuf *commondir,
 		strbuf_release(&err);
 		strbuf_setlen(commondir, commondir_offset);
 		strbuf_setlen(gitdir, gitdir_offset);
+		clear_repository_format(&candidate);
 		return -1;
 	}
 
+	clear_repository_format(&candidate);
 	return 0;
 }
 
@@ -1056,7 +1068,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT;
 	const char *prefix;
-	struct repository_format repo_fmt;
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	/*
 	 * We may have read an incomplete configuration before
@@ -1146,6 +1158,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
+	clear_repository_format(&repo_fmt);
 
 	return prefix;
 }
@@ -1203,9 +1216,10 @@ int git_config_perm(const char *var, const char *value)
 
 void check_repository_format(void)
 {
-	struct repository_format repo_fmt;
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	check_repository_format_gently(get_git_dir(), &repo_fmt, NULL);
 	startup_info->have_repository = 1;
+	clear_repository_format(&repo_fmt);
 }
 
 /*
diff --git a/worktree.c b/worktree.c
index d6a0ee7f73..b45bfeb9d3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -444,7 +444,7 @@ int submodule_uses_worktrees(const char *path)
 	DIR *dir;
 	struct dirent *d;
 	int ret = 0;
-	struct repository_format format;
+	struct repository_format format = REPOSITORY_FORMAT_INIT;
 
 	submodule_gitdir = git_pathdup_submodule(path, "%s", "");
 	if (!submodule_gitdir)
@@ -462,8 +462,10 @@ int submodule_uses_worktrees(const char *path)
 	read_repository_format(&format, sb.buf);
 	if (format.version != 0) {
 		strbuf_release(&sb);
+		clear_repository_format(&format);
 		return 1;
 	}
+	clear_repository_format(&format);
 
 	/* Replace config by worktrees. */
 	strbuf_setlen(&sb, sb.len - strlen("config"));
-- 
2.20.1

