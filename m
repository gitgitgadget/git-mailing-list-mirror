Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735ED1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 16:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeKSC7o (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 21:59:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38348 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeKSC7n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 21:59:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so19667357lfg.5
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZM/N5GT1s+rbZo4JPKnqFg2jbhd4pxtacZyYlFoo6C0=;
        b=t9QF0/RZTAzhDEyiY/FG6akFh+iiRGN+3Sn5oMtH6hxq91pGtUrt6tni8oyZThId8o
         K+/B974u3rbb9mFpK17ZpFFCuz6N/RUICENOnd9axRYhpcXfCa/wNQPm6FVfxmvgivDj
         +iIflNQCpIpIswrDuAj2DRveg5IogneYmIcwYb4urzw+COmQzWmUXrfMnEquvqsDDZno
         hE+h5FghXMV/VOr4+Y6UobmBDZy1mJMtEXbzJ0/VNwitmW/akN8JA3U10F4VFtV9OUyF
         aL8r6IgweLTXiyptVIvBNOUdnH8E+VKQpb+FfH8g9ilgf+/V826XQKNs85M282+DDPnk
         62tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZM/N5GT1s+rbZo4JPKnqFg2jbhd4pxtacZyYlFoo6C0=;
        b=qG3elBa2Udv6shAQ2r2KEGOhoS0Q8v0nI4xNl6i57uV2vLvETypzKcMam4tgh/CQ7N
         w+1SVj9gAZYU9rfOeZbo7WdB1Nf2R7XBIlxYDrVJCmDp2A9YQuyy7djl0hAP29zOVCZV
         sqFRGQjIJ65pbPFtKh8iX1UWiCAOT/iBxQ5CX9KAWMTGOGk8vLo8JHv2PWCZ9sgZ8Nn5
         sxRW1T6+jcc+O/Ms6y6psj2RJT4LAuuBjk6k/YCS1DQWGjb86GfGMcux/Ipka/tiD3cH
         XB54IrIsrwexw17Mw9smM5xUPb9IFSMk9xBSXL1g/YSEWAj91TmvdJO675u5r7twjLM5
         pJgg==
X-Gm-Message-State: AGRZ1gKgDPc2mk4SKAGIQu1I+eOhsmYWy9DINIvMpoSu7fqmfVS9yw97
        u/MOo7YHjXvo3mQberEs9Aukyv+v
X-Google-Smtp-Source: AJdET5eD2sxsB8Ua9wOjEdfhscdh63MibCppJvwYIiSR1P7vz5jcxfPQ345+Dzk9HyC8HR17LwkqPw==
X-Received: by 2002:a19:c345:: with SMTP id t66mr8644093lff.55.1542559137552;
        Sun, 18 Nov 2018 08:38:57 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z6sm5292627lfa.87.2018.11.18.08.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 08:38:56 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] grep: use grep_opt->repo instead of explict repo argument
Date:   Sun, 18 Nov 2018 17:38:51 +0100
Message-Id: <20181118163851.32178-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command is probably the first one that operates on a repository
other than the_repository, in f9ee2fcdfa (grep: recurse in-process
using 'struct repository' - 2017-08-02). An explicit 'struct
repository *' was added in that commit to pass around the repository
that we're supposed to grep from.

Since 38bbc2ea39 (grep.c: remove implicit dependency on the_index -
2018-09-21). 'struct grep_opt *' carries in itself a repository
parameter for grepping. We should now be able to reuse grep_opt to
hold the submodule repo instead of a separate argument, which is just
room for mistakes.

While at there, use the right reference instead of the_repository and
the_index in this code. I was a bit careless in my attempt to kick
the_repository / the_index out of library code. It's normally safe to
just stick the_repository / the_index in bultin/ code, but it's not
the case for grep.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 56e4a11052..bdc49cd34e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -408,18 +408,20 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 		exit(status);
 }
 
-static int grep_cache(struct grep_opt *opt, struct repository *repo,
+static int grep_cache(struct grep_opt *opt,
 		      const struct pathspec *pathspec, int cached);
 static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
-		     int check_attr, struct repository *repo);
+		     int check_attr);
 
-static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
+static int grep_submodule(struct grep_opt *opt,
 			  const struct pathspec *pathspec,
 			  const struct object_id *oid,
 			  const char *filename, const char *path)
 {
+	struct repository *superproject = opt->repo;
 	struct repository submodule;
+	struct grep_opt subopt;
 	int hit;
 
 	/*
@@ -455,6 +457,9 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	add_to_alternates_memory(submodule.objects->objectdir);
 	grep_read_unlock();
 
+	memcpy(&subopt, opt, sizeof(subopt));
+	subopt.repo = &submodule;
+
 	if (oid) {
 		struct object *object;
 		struct tree_desc tree;
@@ -476,21 +481,22 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 		strbuf_addch(&base, '/');
 
 		init_tree_desc(&tree, data, size);
-		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
-				object->type == OBJ_COMMIT, &submodule);
+		hit = grep_tree(&subopt, pathspec, &tree, &base, base.len,
+				object->type == OBJ_COMMIT);
 		strbuf_release(&base);
 		free(data);
 	} else {
-		hit = grep_cache(opt, &submodule, pathspec, 1);
+		hit = grep_cache(&subopt, pathspec, 1);
 	}
 
 	repo_clear(&submodule);
 	return hit;
 }
 
-static int grep_cache(struct grep_opt *opt, struct repository *repo,
+static int grep_cache(struct grep_opt *opt,
 		      const struct pathspec *pathspec, int cached)
 {
+	struct repository *repo = opt->repo;
 	int hit = 0;
 	int nr;
 	struct strbuf name = STRBUF_INIT;
@@ -528,7 +534,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 			}
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
 			   submodule_path_match(repo->index, pathspec, name.buf, NULL)) {
-			hit |= grep_submodule(opt, repo, pathspec, NULL, ce->name, ce->name);
+			hit |= grep_submodule(opt, pathspec, NULL, ce->name, ce->name);
 		} else {
 			continue;
 		}
@@ -550,8 +556,9 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 
 static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
-		     int check_attr, struct repository *repo)
+		     int check_attr)
 {
+	struct repository *repo = opt->repo;
 	int hit = 0;
 	enum interesting match = entry_not_interesting;
 	struct name_entry entry;
@@ -597,10 +604,10 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			strbuf_addch(base, '/');
 			init_tree_desc(&sub, data, size);
 			hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
-					 check_attr, repo);
+					 check_attr);
 			free(data);
 		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
-			hit |= grep_submodule(opt, repo, pathspec, entry.oid,
+			hit |= grep_submodule(opt, pathspec, entry.oid,
 					      base->buf, base->buf + tn_len);
 		}
 
@@ -642,7 +649,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		}
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
-				obj->type == OBJ_COMMIT, the_repository);
+				obj->type == OBJ_COMMIT);
 		strbuf_release(&base);
 		free(data);
 		return hit;
@@ -659,12 +666,12 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
-		real_obj = deref_tag(the_repository, list->objects[i].item,
+		real_obj = deref_tag(opt->repo, list->objects[i].item,
 				     NULL, 0);
 
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
-			submodule_free(the_repository);
+			submodule_free(opt->repo);
 			gitmodules_config_oid(&real_obj->oid);
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,
@@ -689,9 +696,9 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 	if (exc_std)
 		setup_standard_excludes(&dir);
 
-	fill_directory(&dir, &the_index, pathspec);
+	fill_directory(&dir, opt->repo->index, pathspec);
 	for (i = 0; i < dir.nr; i++) {
-		if (!dir_path_match(&the_index, dir.entries[i], pathspec, 0, NULL))
+		if (!dir_path_match(opt->repo->index, dir.entries[i], pathspec, 0, NULL))
 			continue;
 		hit |= grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
@@ -1124,7 +1131,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (!cached)
 			setup_work_tree();
 
-		hit = grep_cache(&opt, the_repository, &pathspec, cached);
+		hit = grep_cache(&opt, &pathspec, cached);
 	} else {
 		if (cached)
 			die(_("both --cached and trees are given"));
-- 
2.19.1.1327.g328c130451.dirty

