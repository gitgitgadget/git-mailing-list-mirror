Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C9BC77B73
	for <git@archiver.kernel.org>; Fri, 26 May 2023 18:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbjEZSoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 14:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243066AbjEZSoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 14:44:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45BA10CF
        for <git@vger.kernel.org>; Fri, 26 May 2023 11:43:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3093eb8cd1fso708767f8f.1
        for <git@vger.kernel.org>; Fri, 26 May 2023 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685126620; x=1687718620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad/OLidCTz3clGkbpTtxt06siL9dGAGsJNirvKwTiis=;
        b=jaz020ZzqjJ+uHXEOanWb1yHtyDX1JVeOa5Z3wyDXt8JpwJidN4jRpib171PZ/E7zW
         gwr6XsRzrzmJaQDOfPZ8WN92hwXIFiUhQFUuAN59X7PiRQxaS0IpoGkZu/ipN58dz/BT
         cb33hPvi5UTqUtm6gTIaG/NWsG0pvrOsRtrmaYUZelPOGbaIoG+hSZMdXf3Tw5eehWnO
         CZCTojQfCOJk6K4e4X9eFfVSil3E/8vDVcriWScE7b3id0DoRWt9qg8AqCvH6tgfDu3t
         Hb7/B+YjWn2GOzmfHn1vKw91S2MZRp2o+0wesytOSBH+ubMUv1w9hZ7XfDYjM7pIRxRq
         laFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126620; x=1687718620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad/OLidCTz3clGkbpTtxt06siL9dGAGsJNirvKwTiis=;
        b=ZYFHTng9Q9ENP6k3B1NLfgIAk4yVrdetjX5L83H01hu+O7CQ6YPifYiRiJtNkPVPZW
         C8Zrab9WMLAxWC2Pz3IK2/TZOPMQ+8XGmrC0rEIcaLB6I4oumzJb3FSA+V4RbKAyV3uY
         FwyVhwDsLI74U49xosaCUVXCUGFHCUyhBryNHPAH87EA4CCSRJVolknrMtAavzRMZAGy
         8aOR+rOkKv8PwJQg5YBlfYW+kVeeYDATLgf3nadnHUAkSw3yof4R6dpAqK8daiiJQV2Q
         AQMPY1M0zr+SE1Hg/OVorw9YqG9nVxYLMmvBF59yII8OThsJpNXco/6Vyi5ARhqK6HWw
         U6xQ==
X-Gm-Message-State: AC+VfDyi/29SknUDSvQW7pmzho3ID74/yNXtAtKtV32vVtbXIJl+jv7I
        KBQiNd9DJmquwhTQVmH+mHP3dD4WdNY=
X-Google-Smtp-Source: ACHHUZ5qi1Ttk8AtKpG/GZIr4ZVJPyMzG5f6YzP+X8y3invsLBpVrVGSTNvaYWlykTUeSWXk4bZ++A==
X-Received: by 2002:a05:6000:cd:b0:30a:d8df:6800 with SMTP id q13-20020a05600000cd00b0030ad8df6800mr1791553wrx.33.1685126619722;
        Fri, 26 May 2023 11:43:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6-20020adff706000000b0030903371ef9sm5846317wrp.22.2023.05.26.11.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:43:39 -0700 (PDT)
Message-Id: <56544abc15d1fce6fb4a0946e709470af9225395.1685126618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 May 2023 18:43:35 +0000
Subject: [PATCH 1/3] repository: create disable_replace_refs()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, me@ttaylorr.com, newren@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Several builtins depend on being able to disable the replace references
so we actually operate on each object individually. These currently do
so by directly mutating the 'read_replace_refs' global.

A future change will move this global into a different place, so it will
be necessary to change all of these lines. However, we can simplify that
transition by abstracting the purpose of these global assignments with a
method call.

We will never scope this to an in-memory repository as we want to make
sure that we never use replace refs throughout the life of the process
if this method is called.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/cat-file.c       | 2 +-
 builtin/commit-graph.c   | 5 ++---
 builtin/fsck.c           | 2 +-
 builtin/index-pack.c     | 2 +-
 builtin/pack-objects.c   | 3 +--
 builtin/prune.c          | 3 ++-
 builtin/replace.c        | 3 ++-
 builtin/unpack-objects.c | 3 +--
 builtin/upload-pack.c    | 3 ++-
 environment.c            | 2 +-
 git.c                    | 2 +-
 replace-object.c         | 5 +++++
 replace-object.h         | 8 ++++++++
 repo-settings.c          | 1 +
 14 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0bafc14e6c0..27f070267a4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -805,7 +805,7 @@ static int batch_objects(struct batch_options *opt)
 		if (repo_has_promisor_remote(the_repository))
 			warning("This repository uses promisor remotes. Some objects may not be loaded.");
 
-		read_replace_refs = 0;
+		disable_replace_refs();
 
 		cb.opt = opt;
 		cb.expand = &data;
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index a3d00fa232b..639c9ca8b91 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -122,7 +122,6 @@ static int graph_verify(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-extern int read_replace_refs;
 static struct commit_graph_opts write_opts;
 
 static int write_option_parse_split(const struct option *opt, const char *arg,
@@ -323,13 +322,13 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 	struct option *options = parse_options_concat(builtin_commit_graph_options, common_opts);
 
 	git_config(git_default_config, NULL);
-
-	read_replace_refs = 0;
 	save_commit_buffer = 0;
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_commit_graph_usage, 0);
 	FREE_AND_NULL(options);
 
+	disable_replace_refs();
+
 	return fn(argc, argv, prefix);
 }
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2cd461b84c1..8a2d7afc83a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -927,7 +927,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	fetch_if_missing = 0;
 
 	errors_found = 0;
-	read_replace_refs = 0;
 	save_commit_buffer = 0;
 
 	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
@@ -953,6 +952,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	git_config(git_fsck_config, &fsck_obj_options);
 	prepare_repo_settings(the_repository);
+	disable_replace_refs();
 
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bb67e166559..d0d8067510b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1752,7 +1752,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
 
-	read_replace_refs = 0;
+	disable_replace_refs();
 	fsck_options.walk = mark_link;
 
 	reset_pack_idx_option(&opts);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a5b466839ba..55635bdf4b4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4284,9 +4284,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
 		BUG("too many dfs states, increase OE_DFS_STATE_BITS");
 
-	read_replace_refs = 0;
-
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
+	disable_replace_refs();
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
 		if (sparse < 0)
diff --git a/builtin/prune.c b/builtin/prune.c
index 5dc9b207200..a8f3848c3a3 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -164,7 +164,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 
 	expire = TIME_MAX;
 	save_commit_buffer = 0;
-	read_replace_refs = 0;
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
@@ -172,6 +171,8 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	if (repository_format_precious_objects)
 		die(_("cannot prune in a precious-objects repo"));
 
+	disable_replace_refs();
+
 	while (argc--) {
 		struct object_id oid;
 		const char *name = *argv++;
diff --git a/builtin/replace.c b/builtin/replace.c
index 981f1894436..6c6f0b3ed01 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -566,11 +566,12 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	read_replace_refs = 0;
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
 
+	disable_replace_refs();
+
 	if (!cmdmode)
 		cmdmode = argc ? MODE_REPLACE : MODE_LIST;
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2c52c3a741f..3f5f6719405 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -609,9 +609,8 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 	int i;
 	struct object_id oid;
 
-	read_replace_refs = 0;
-
 	git_config(git_default_config, NULL);
+	disable_replace_refs();
 
 	quiet = !isatty(2);
 
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index beb9dd08610..6fc9a8feab0 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -36,7 +36,6 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	};
 
 	packet_trace_identity("upload-pack");
-	read_replace_refs = 0;
 
 	argc = parse_options(argc, argv, prefix, options, upload_pack_usage, 0);
 
@@ -50,6 +49,8 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
 
+	disable_replace_refs();
+
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
 		if (advertise_refs)
diff --git a/environment.c b/environment.c
index 8a96997539a..3b4d87c322f 100644
--- a/environment.c
+++ b/environment.c
@@ -185,7 +185,7 @@ void setup_git_env(const char *git_dir)
 	strvec_clear(&to_free);
 
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
-		read_replace_refs = 0;
+		disable_replace_refs();
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
diff --git a/git.c b/git.c
index 45899be8265..3252d4c7661 100644
--- a/git.c
+++ b/git.c
@@ -185,7 +185,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--no-replace-objects")) {
-			read_replace_refs = 0;
+			disable_replace_refs();
 			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
 			if (envchanged)
 				*envchanged = 1;
diff --git a/replace-object.c b/replace-object.c
index e98825d5852..ceec81c940c 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -84,3 +84,8 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 	}
 	die(_("replace depth too high for object %s"), oid_to_hex(oid));
 }
+
+void disable_replace_refs(void)
+{
+	read_replace_refs = 0;
+}
diff --git a/replace-object.h b/replace-object.h
index 500482b02b3..7786d4152b0 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -48,4 +48,12 @@ static inline const struct object_id *lookup_replace_object(struct repository *r
 	return do_lookup_replace_object(r, oid);
 }
 
+/*
+ * Some commands override config and environment settings for using
+ * replace references. Use this method to disable the setting and ensure
+ * those other settings will not override this choice. This applies
+ * globally to all in-process repositories.
+ */
+void disable_replace_refs(void);
+
 #endif /* REPLACE_OBJECT_H */
diff --git a/repo-settings.c b/repo-settings.c
index 7b566d729d0..1df0320bf33 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -3,6 +3,7 @@
 #include "repository.h"
 #include "midx.h"
 #include "compat/fsmonitor/fsm-listen.h"
+#include "environment.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 			  int def)
-- 
gitgitgadget

