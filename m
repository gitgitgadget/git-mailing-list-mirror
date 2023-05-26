Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF5C7EE29
	for <git@archiver.kernel.org>; Fri, 26 May 2023 01:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbjEZBdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 21:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbjEZBdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 21:33:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C9F19C
        for <git@vger.kernel.org>; Thu, 25 May 2023 18:33:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6dbe3c230so2320345e9.3
        for <git@vger.kernel.org>; Thu, 25 May 2023 18:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685064784; x=1687656784;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5In658HuEr9Imsym7VWv+SQUBncebTUUIorKDBJEL8=;
        b=se8vE6dHrWYXSM4VT/qisURjuAFIVrbPwETPSEShLs0C7QmqM+R71D5Z+qfs7x8vkd
         Yr5Fc2vPQn/r0oFYLsUjHp0QcrwNto8Mb0QMA0urj/Pm8Ld1ZnZGijgURuy8vNgsuq+4
         S6x1+Brb79vZVeipaa6EOZ5NoJAY7Yg3PQfA4LU9XelBYz4hmdMhW2sj8oy9lEcIkQqS
         mfjmkcjakpvCxCN/BPN7cEbRt+L5Qs7fdttltNn6snxnDGLsoJ6bY8HEPG+IqGs6LmNt
         0QdofXijvS3spH+YyqEoCKEFHfFrnyOEgfGZnq+Zusy6RcZX3N3wmcr6pS0SCWLcJG1W
         ln2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685064784; x=1687656784;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5In658HuEr9Imsym7VWv+SQUBncebTUUIorKDBJEL8=;
        b=b5cnc7vuAl+WZgMS/BZAt8BBrnoJ+Iwu4l3WB+VZOxKWCG4A27g/ADj/+G7JosP3Nx
         G2YN8shLyXz5B3YuIty1fyMu3t6VGGlfMg7Cu21Z2sv1h/9U53FJ4g2ZOmPB/BJ+Qeu7
         YG+g7n4PtWdsDiLrfxVzas0f+qQnSSq9J0qF5f5wO7NOaGC6Yy8BthcD63UzqXETmvWW
         XY9qFX9M52ylMgcIZfw4mhxAO1w/88sXycWBbSOLmww9v6Uqzggs7o39hgUAuhEE6Zjq
         +bJsd4AYSrcnLM3/AICZQrnbnvHXd9KSTc1w/Zs6LGQUF/BOAkoe3JceoutX9me0Cy67
         j8hg==
X-Gm-Message-State: AC+VfDyDeZE53MKqP/+xGFn+58QUrRNpjERqI4vctRfseF1gPFI/3Gni
        a6iMzdy9u26z80C1F/pyxndI/0330wE=
X-Google-Smtp-Source: ACHHUZ5QCA3xSf/v5x+vKq8+8OFAIILNvsmBxyiKsZ1xWMq3HtowHxHdy3DPJQQ0J89vOZbh2v+7Bg==
X-Received: by 2002:a05:600c:245:b0:3f6:683:627d with SMTP id 5-20020a05600c024500b003f60683627dmr285027wmj.18.1685064784058;
        Thu, 25 May 2023 18:33:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11-20020a5d49cb000000b0030732d6e104sm3364245wrs.105.2023.05.25.18.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:33:03 -0700 (PDT)
Message-Id: <26a36423a8a8449871a0695e835e7a2616487251.1685064781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
        <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 May 2023 01:32:59 +0000
Subject: [PATCH v2 2/3] config: pass 'repo' directly to
 'config_with_options()'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, chooglen@google.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a 'struct repository' argument to 'config_with_options()' and remove the
'repo' field from 'struct git_config_source'.

A 'struct repository' instance was originally added to the config source in
e3e8bf046e9 (submodule-config: pass repo upon blob config read, 2021-08-16)
to improve how submodule blob config content was accessed. At the time, this
was the only use for a 'repository' instance, so it was naturally added only
where it was needed: to 'struct git_config_source'. However, in upcoming
patches, 'config_with_options()' will need the repository instance to access
extension information (regardless of whether a 'config_source' exists). To
make the 'struct repository' instance more easily accessible, move it into
the function's arguments.

Update all callers of 'config_with_options()' to pass the appropriate 'repo'
value:

* in 'builtin/config.c', use 'the_repository'
* in 'submodule--config.c', use the 'repo' arg in 'config_from_gitmodules()'
* in 'read_[very_]early_config()' & 'read_protected_config()', set 'repo' to
  NULL (repository instances aren't available there)
* in 'populate_remote_urls()', use the repo instance that has been added to
  the 'struct config_include_data'
* in 'repo_read_config()', use the given 'repo' arg

Finally, note that this patch eliminates the fallback to 'the_repository'
that previously existed for the 'config_source' repo instance if it was
NULL. The fallback is no longer necessary, as the 'repo' is set explicitly
in all cases where it is needed.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/config.c   | 14 +++++++++-----
 config.c           | 16 +++++++++-------
 config.h           |  4 ++--
 submodule-config.c |  3 +--
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ff2fe8ef125..8fc90288f9e 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -375,7 +375,8 @@ static int get_value(const char *key_, const char *regex_, unsigned flags)
 	}
 
 	config_with_options(collect_config, &values,
-			    &given_config_source, &config_options);
+			    &given_config_source, the_repository,
+			    &config_options);
 
 	if (!values.nr && default_value) {
 		struct strbuf *item;
@@ -486,7 +487,8 @@ static void get_color(const char *var, const char *def_color)
 	get_color_found = 0;
 	parsed_color[0] = '\0';
 	config_with_options(git_get_color_config, NULL,
-			    &given_config_source, &config_options);
+			    &given_config_source, the_repository,
+			    &config_options);
 
 	if (!get_color_found && def_color) {
 		if (color_parse(def_color, parsed_color) < 0)
@@ -518,7 +520,8 @@ static int get_colorbool(const char *var, int print)
 	get_diff_color_found = -1;
 	get_color_ui_found = -1;
 	config_with_options(git_get_colorbool_config, NULL,
-			    &given_config_source, &config_options);
+			    &given_config_source, the_repository,
+			    &config_options);
 
 	if (get_colorbool_found < 0) {
 		if (!strcmp(get_colorbool_slot, "color.diff"))
@@ -607,7 +610,8 @@ static int get_urlmatch(const char *var, const char *url)
 	}
 
 	config_with_options(urlmatch_config_entry, &config,
-			    &given_config_source, &config_options);
+			    &given_config_source, the_repository,
+			    &config_options);
 
 	ret = !values.nr;
 
@@ -827,7 +831,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (config_with_options(show_all_config, NULL,
-					&given_config_source,
+					&given_config_source, the_repository,
 					&config_options) < 0) {
 			if (given_config_source.file)
 				die_errno(_("unable to read config file '%s'"),
diff --git a/config.c b/config.c
index a93f7bfa3aa..67e60e131c2 100644
--- a/config.c
+++ b/config.c
@@ -199,6 +199,7 @@ struct config_include_data {
 	void *data;
 	const struct config_options *opts;
 	struct git_config_source *config_source;
+	struct repository *repo;
 	struct config_reader *config_reader;
 
 	/*
@@ -415,7 +416,8 @@ static void populate_remote_urls(struct config_include_data *inc)
 
 	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
 	string_list_init_dup(inc->remote_urls);
-	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
+	config_with_options(add_remote_url, inc->remote_urls,
+			    inc->config_source, inc->repo, &opts);
 
 	config_reader_set_scope(inc->config_reader, store_scope);
 }
@@ -2261,6 +2263,7 @@ static int do_git_config_sequence(struct config_reader *reader,
 
 int config_with_options(config_fn_t fn, void *data,
 			struct git_config_source *config_source,
+			struct repository *repo,
 			const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
@@ -2271,6 +2274,7 @@ int config_with_options(config_fn_t fn, void *data,
 		inc.fn = fn;
 		inc.data = data;
 		inc.opts = opts;
+		inc.repo = repo;
 		inc.config_source = config_source;
 		inc.config_reader = &the_reader;
 		fn = git_config_include;
@@ -2289,8 +2293,6 @@ int config_with_options(config_fn_t fn, void *data,
 	} else if (config_source && config_source->file) {
 		ret = git_config_from_file(fn, config_source->file, data);
 	} else if (config_source && config_source->blob) {
-		struct repository *repo = config_source->repo ?
-			config_source->repo : the_repository;
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 						data);
 	} else {
@@ -2353,7 +2355,7 @@ void read_early_config(config_fn_t cb, void *data)
 		opts.git_dir = gitdir.buf;
 	}
 
-	config_with_options(cb, data, NULL, &opts);
+	config_with_options(cb, data, NULL, NULL, &opts);
 
 	strbuf_release(&commondir);
 	strbuf_release(&gitdir);
@@ -2373,7 +2375,7 @@ void read_very_early_config(config_fn_t cb, void *data)
 	opts.ignore_cmdline = 1;
 	opts.system_gently = 1;
 
-	config_with_options(cb, data, NULL, &opts);
+	config_with_options(cb, data, NULL, NULL, &opts);
 }
 
 RESULT_MUST_BE_USED
@@ -2681,7 +2683,7 @@ static void repo_read_config(struct repository *repo)
 	data.config_set = repo->config;
 	data.config_reader = &the_reader;
 
-	if (config_with_options(config_set_callback, &data, NULL, &opts) < 0)
+	if (config_with_options(config_set_callback, &data, NULL, repo, &opts) < 0)
 		/*
 		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
@@ -2825,7 +2827,7 @@ static void read_protected_config(void)
 	git_configset_init(&protected_config);
 	data.config_set = &protected_config;
 	data.config_reader = &the_reader;
-	config_with_options(config_set_callback, &data, NULL, &opts);
+	config_with_options(config_set_callback, &data, NULL, NULL, &opts);
 }
 
 void git_protected_config(config_fn_t fn, void *data)
diff --git a/config.h b/config.h
index 247b572b37b..d1c5577589e 100644
--- a/config.h
+++ b/config.h
@@ -3,6 +3,7 @@
 
 #include "hashmap.h"
 #include "string-list.h"
+#include "repository.h"
 
 
 /**
@@ -49,8 +50,6 @@ const char *config_scope_name(enum config_scope scope);
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
-	/* The repository if blob is not NULL; leave blank for the_repository */
-	struct repository *repo;
 	const char *blob;
 	enum config_scope scope;
 };
@@ -196,6 +195,7 @@ void git_config(config_fn_t fn, void *);
  */
 int config_with_options(config_fn_t fn, void *,
 			struct git_config_source *config_source,
+			struct repository *repo,
 			const struct config_options *opts);
 
 /**
diff --git a/submodule-config.c b/submodule-config.c
index 58dfbde9ae5..7eb7a0d88d2 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -659,7 +659,6 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 			config_source.file = file;
 		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
-			config_source.repo = repo;
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
 			if (repo != the_repository)
 				add_submodule_odb_by_path(repo->objects->odb->path);
@@ -667,7 +666,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 			goto out;
 		}
 
-		config_with_options(fn, data, &config_source, &opts);
+		config_with_options(fn, data, &config_source, repo, &opts);
 
 out:
 		free(oidstr);
-- 
gitgitgadget

