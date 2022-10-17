Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04307C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 02:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJQCXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiJQCXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 22:23:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4A54456F
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j16so16438048wrh.5
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrBojq2Dd90cjmbzNdU3/wlCsY8ddFuvZ0iEklEsrh8=;
        b=BmLfQw8b/9F/6MMM/7jSicXBUg4D0ryEGzjkM/mH07d+31ZiRpdvSLQ1qPfHuTbTte
         emGRoJA8Hxkv2kP0VlIAHe4/7UXryZEkR90DobsZBqeGP6u8XTNmsdmlI/N7rksCcMfB
         5O/IWHP6W4uAfyn7p2opBKo5mxvsJxDIaB2vFLZYfz8Dv0W5t/GBssihnF5wn1z0Ptkr
         oNmKRzFCkCRwEu1BWKkOc0MQrn/HI3R2r6yym9O1GGJ1iDygjTNJDjOUl3tljGDziK/A
         iCpFNQmm5MvU0iCNWcyrcDkIg/Tk6uuy8jgUm7CWF/jPX4EojlhNtWSmTgM52Z5d8/Mx
         ZSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrBojq2Dd90cjmbzNdU3/wlCsY8ddFuvZ0iEklEsrh8=;
        b=mSR6B1Xxma9fIFKd0S5ZHIZfTf3JEonEN3zKJop+HhdWSvQEupLPyDbl5CoJ69+r2N
         dFOakoPaoNNghpKDeDG6EZXcztWpSOZP+cIue8kNrUY7PY3N7RVQNUiAt84R1tuoCcYs
         eUqozVIHN4piFBxGVi64JKEcnV2PTDPBM2KUmnHwmZUSFWw+5DqWsxj6qyj/L8QOD9vW
         PwUPYE1xBOMqg6+7gsbiu1JxxOLXgYsCFuTcoXa4TdwdNnv2waB0NbSVk5QXyLEAJklq
         LbS3s7397n4tik3M0nZSgyfhmkpVFbDkV8p3rAzpanxWO+T3kLHCq0RrvlsFDHLsMubz
         iMjQ==
X-Gm-Message-State: ACrzQf2YbQe0c1jKijwqpj8wT2Mknu1wieepfb8ILFMNB0QSbdbqAfWs
        kaf1/vjamp6Z+FI8xb+5NpY2vhm3N3M=
X-Google-Smtp-Source: AMsMyM407ARhx7z4ypcbMCFyaNndHMxW69wdEuU+WLK0tUepXPmM/gVPXM79iMxEs42Giw4inCF5Og==
X-Received: by 2002:adf:fec6:0:b0:22e:3218:f7e1 with SMTP id q6-20020adffec6000000b0022e3218f7e1mr4665115wrs.522.1665973407914;
        Sun, 16 Oct 2022 19:23:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0a4a00b003c6cdbface4sm9086580wmq.11.2022.10.16.19.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:23:27 -0700 (PDT)
Message-Id: <376345fdf66b274a7ce3dfff4d0a2b185858147c.1665973401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
From:   "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 02:23:17 +0000
Subject: [PATCH v3 5/9] tree: add repository parameter to read_tree_fn_t
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heather Lapointe <alpha@alphaservcomputing.solutions>

Add a repo paramter to read_tree_fn_t because most callbacks do
need some repo instance.
This avoids having to use the_repository functions otherwise
and improves repo context switching for submodules.

Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
---
 archive.c                         | 11 ++++++----
 builtin/checkout.c                |  4 +++-
 builtin/log.c                     |  4 +++-
 builtin/ls-files.c                |  8 ++++++--
 builtin/ls-tree.c                 | 34 ++++++++++++++++++++-----------
 merge-recursive.c                 |  4 +++-
 sparse-index.c                    |  4 +++-
 t/helper/test-tree-read-tree-at.c |  3 ++-
 tree.c                            |  2 +-
 tree.h                            |  2 +-
 wt-status.c                       |  4 +++-
 11 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/archive.c b/archive.c
index 61a79e4a227..15f3ac92dfc 100644
--- a/archive.c
+++ b/archive.c
@@ -225,7 +225,9 @@ static int write_directory(struct archiver_context *c)
 	return ret ? -1 : 0;
 }
 
-static int queue_or_write_archive_entry(const struct object_id *oid,
+static int queue_or_write_archive_entry(
+		struct repository *r,
+		const struct object_id *oid,
 		struct strbuf *base, const char *filename,
 		unsigned mode, void *context)
 {
@@ -246,7 +248,7 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 		/* Borrow base, but restore its original value when done. */
 		strbuf_addstr(base, filename);
 		strbuf_addch(base, '/');
-		check = get_archive_attrs(c->args->repo->index, base->buf);
+		check = get_archive_attrs(r->index, base->buf);
 		strbuf_setlen(base, baselen);
 
 		if (check_attr_export_ignore(check))
@@ -382,7 +384,8 @@ struct path_exists_context {
 	struct archiver_args *args;
 };
 
-static int reject_entry(const struct object_id *oid UNUSED,
+static int reject_entry(
+			struct repository *r, const struct object_id *oid UNUSED,
 			struct strbuf *base,
 			const char *filename, unsigned mode,
 			void *context)
@@ -394,7 +397,7 @@ static int reject_entry(const struct object_id *oid UNUSED,
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addbuf(&sb, base);
 		strbuf_addstr(&sb, filename);
-		if (!match_pathspec(ctx->args->repo->index,
+		if (!match_pathspec(r->index,
 				    &ctx->pathspec,
 				    sb.buf, sb.len, 0, NULL, 1))
 			ret = READ_TREE_RECURSIVE;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a132392fbe..ee98858afe6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -124,7 +124,9 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
 
 }
 
-static int update_some(const struct object_id *oid, struct strbuf *base,
+static int update_some(
+		       struct repository *r UNUSED,
+			   const struct object_id *oid, struct strbuf *base,
 		       const char *pathname, unsigned mode, void *context UNUSED)
 {
 	int len;
diff --git a/builtin/log.c b/builtin/log.c
index ee19dc5d450..608a448fe4d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -698,7 +698,9 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 	return 0;
 }
 
-static int show_tree_object(const struct object_id *oid UNUSED,
+static int show_tree_object(
+			    struct repository *r UNUSED,
+			    const struct object_id *oid UNUSED,
 			    struct strbuf *base UNUSED,
 			    const char *pathname, unsigned mode,
 			    void *context)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4cf8a236483..fbb07fa08c2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -533,7 +533,9 @@ static int read_one_entry_opt(struct index_state *istate,
 	return add_index_entry(istate, ce, opt);
 }
 
-static int read_one_entry(const struct object_id *oid, struct strbuf *base,
+static int read_one_entry(
+			  struct repository *r UNUSED,
+			  const struct object_id *oid, struct strbuf *base,
 			  const char *pathname, unsigned mode,
 			  void *context)
 {
@@ -547,7 +549,9 @@ static int read_one_entry(const struct object_id *oid, struct strbuf *base,
  * This is used when the caller knows there is no existing entries at
  * the stage that will conflict with the entry being added.
  */
-static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
+static int read_one_entry_quick(
+				struct repository *r UNUSED,
+				const struct object_id *oid, struct strbuf *base,
 				const char *pathname, unsigned mode,
 				void *context)
 {
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c3ea09281af..dd571abad1c 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -141,8 +141,10 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
-static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
-			 const char *pathname, unsigned mode, void *context UNUSED)
+static int show_tree_fmt(
+			struct repository *r UNUSED,
+			const struct object_id *oid, struct strbuf *base,
+			const char *pathname, unsigned mode, void *context UNUSED)
 {
 	size_t baselen;
 	int recurse = 0;
@@ -211,9 +213,11 @@ static void show_tree_common_default_long(struct strbuf *base,
 	strbuf_setlen(base, baselen);
 }
 
-static int show_tree_default(const struct object_id *oid, struct strbuf *base,
-			     const char *pathname, unsigned mode,
-			     void *context UNUSED)
+static int show_tree_default(
+		struct repository *r,
+		const struct object_id *oid, struct strbuf *base,
+		const char *pathname, unsigned mode,
+		void *context UNUSED)
 {
 	int early;
 	int recurse;
@@ -224,12 +228,14 @@ static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 		return early;
 
 	printf("%06o %s %s\t", data.mode, type_name(data.type),
-	       find_unique_abbrev(data.oid, abbrev));
+	       repo_find_unique_abbrev(r, data.oid, abbrev));
 	show_tree_common_default_long(base, pathname, data.base->len);
 	return recurse;
 }
 
-static int show_tree_long(const struct object_id *oid, struct strbuf *base,
+static int show_tree_long(
+			  struct repository *r,
+			  const struct object_id *oid, struct strbuf *base,
 			  const char *pathname, unsigned mode,
 			  void *context UNUSED)
 {
@@ -244,7 +250,7 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 
 	if (data.type == OBJ_BLOB) {
 		unsigned long size;
-		if (oid_object_info(the_repository, data.oid, &size) == OBJ_BAD)
+		if (oid_object_info(r, data.oid, &size) == OBJ_BAD)
 			xsnprintf(size_text, sizeof(size_text), "BAD");
 		else
 			xsnprintf(size_text, sizeof(size_text),
@@ -254,12 +260,14 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 	}
 
 	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
-	       find_unique_abbrev(data.oid, abbrev), size_text);
+	       repo_find_unique_abbrev(r, data.oid, abbrev), size_text);
 	show_tree_common_default_long(base, pathname, data.base->len);
 	return recurse;
 }
 
-static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
+static int show_tree_name_only(
+			       struct repository *r UNUSED,
+			       const struct object_id *oid, struct strbuf *base,
 			       const char *pathname, unsigned mode,
 			       void *context UNUSED)
 {
@@ -280,7 +288,9 @@ static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
 	return recurse;
 }
 
-static int show_tree_object(const struct object_id *oid, struct strbuf *base,
+static int show_tree_object(
+			    struct repository *r,
+				const struct object_id *oid, struct strbuf *base,
 			    const char *pathname, unsigned mode,
 			    void *context UNUSED)
 {
@@ -292,7 +302,7 @@ static int show_tree_object(const struct object_id *oid, struct strbuf *base,
 	if (early >= 0)
 		return early;
 
-	printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
+	printf("%s%c", repo_find_unique_abbrev(r, oid, abbrev), line_termination);
 	return recurse;
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 4ddd3adea00..dccde276655 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -456,7 +456,9 @@ static void unpack_trees_finish(struct merge_options *opt)
 	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
 }
 
-static int save_files_dirs(const struct object_id *oid UNUSED,
+static int save_files_dirs(
+			   struct repository *r UNUSED,
+			   const struct object_id *oid UNUSED,
 			   struct strbuf *base, const char *path,
 			   unsigned int mode, void *context)
 {
diff --git a/sparse-index.c b/sparse-index.c
index e4a54ce1943..4187c7ce9c4 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -232,7 +232,9 @@ static void set_index_entry(struct index_state *istate, int nr, struct cache_ent
 	add_name_hash(istate, ce);
 }
 
-static int add_path_to_index(const struct object_id *oid,
+static int add_path_to_index(
+			     struct repository *r UNUSED,
+			     const struct object_id *oid,
 			     struct strbuf *base, const char *path,
 			     unsigned int mode, void *context)
 {
diff --git a/t/helper/test-tree-read-tree-at.c b/t/helper/test-tree-read-tree-at.c
index bba759bb264..d2bcc8c849a 100644
--- a/t/helper/test-tree-read-tree-at.c
+++ b/t/helper/test-tree-read-tree-at.c
@@ -6,7 +6,8 @@ We call it tree-read-tree-at to disambiguate with the read-tree tool.
 #include "test-tool.h"
 #include "tree.h"
 
-static int test_handle_entry(const struct object_id *oid,
+static int test_handle_entry(
+		struct repository *r UNUSED, const struct object_id *oid,
 		struct strbuf *base, const char *filename,
 		unsigned mode, void *context UNUSED) {
 	printf("%i %s %s%s\n", mode, oid_to_hex(oid), base->buf, filename);
diff --git a/tree.c b/tree.c
index 2a087c010f9..17c3af819e2 100644
--- a/tree.c
+++ b/tree.c
@@ -38,7 +38,7 @@ int read_tree_at(struct repository *r,
 				continue;
 		}
 
-		switch (fn(&entry.oid, base,
+		switch (fn(r, &entry.oid, base,
 			   entry.path, entry.mode, context)) {
 		case 0:
 			continue;
diff --git a/tree.h b/tree.h
index cc6402e4738..94b1e11d9eb 100644
--- a/tree.h
+++ b/tree.h
@@ -37,7 +37,7 @@ struct tree *repo_parse_tree_indirect(struct repository *r, const struct object_
 int cmp_cache_name_compare(const void *a_, const void *b_);
 
 #define READ_TREE_RECURSIVE 1
-typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
+typedef int (*read_tree_fn_t)(struct repository *r, const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
 
 int read_tree_at(struct repository *r,
 		 struct tree *tree, struct strbuf *base,
diff --git a/wt-status.c b/wt-status.c
index 5813174896c..cff2a780f32 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -665,7 +665,9 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	release_revisions(&rev);
 }
 
-static int add_file_to_list(const struct object_id *oid,
+static int add_file_to_list(
+			    struct repository *r UNUSED,
+			    const struct object_id *oid,
 			    struct strbuf *base, const char *path,
 			    unsigned int mode, void *context)
 {
-- 
gitgitgadget

