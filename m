Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB4C77B73
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 13:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjFFNYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbjFFNYo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 09:24:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E941118
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 06:24:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30e53cacc10so158251f8f.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686057879; x=1688649879;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLPoIt7gEahXdge9UNnfFkP1i1lLANoeVF53AuiZHx4=;
        b=YiIm37We896ae1O4QJYNeA32opS/SzqK5YumM+wNjKAdRguFyuuiMBzzy/63HH94zC
         twY+j+qvN7DAR2unnJ7de02rJfIGr4hRFQfjVGbhdhltT8v6yVDny5ET1X1ytk7p0brb
         NU8Nvi+f6DEYEwNtfsnG4QAGrlNNv04DLnrGWz/X5K2Kgc8na30aDsEOHtL0cAy89kfw
         iqIJuFyUB2g3TktjJTghh4MrrQWaNteRrr4TBQ61f2yUWR5o/DImwRh7IJB0wDOSp8Fc
         FMoooT2FbAdRIbbakPyzmHz5y87TrfnYXvARGItXbjY7SWEJuF95Mcsv7WDE4BAfL5lg
         I0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686057879; x=1688649879;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLPoIt7gEahXdge9UNnfFkP1i1lLANoeVF53AuiZHx4=;
        b=fqsYVkyjlUADsYoxwS3GaCNzoMOCYVggO98RZmBE5kKOzSCuTP4z2bRCU3tFHMMFlT
         mGck1ySVj1FcMOYVpi2T+Yr//vfOgiIU0Ump9HwoVU6GWQpqYnLx13uoSR9Z6FvYxFgn
         y60RZXjiJ9vyIInEo3YAst3Zoj3jOrqCOzYZRy+xcZmHfQpJ7ZqZnJu4Eq3yiDzGvaM1
         PI4sQlfAmNOkoS4oNolBughyJx9FaqKzUEk2bt7anXM3w9KSjCV664YQJsvgoUVx5hAd
         7jUFTb9RSlY1Ac9JRN2j6GOcAfx+/K5IMs7HVzYVNzpMmz/JyYk7/c35G4Bpw6HJdE77
         +fHw==
X-Gm-Message-State: AC+VfDwZcKbCsUJZYoPRVRJMAYNAeA2w4yDIM3W4uauBH140Wh6Jf2a+
        D+iOzuye2H5b8Sm3S2kXd9copnzyx70=
X-Google-Smtp-Source: ACHHUZ5c5Fc10CmTFKHA7E1GJyLBCPTNPGBNjyEN5yTZ75PYzxNvvhb20wgkwbE3lg4FDjIDO70u7A==
X-Received: by 2002:a5d:6045:0:b0:306:2e48:6ded with SMTP id j5-20020a5d6045000000b003062e486dedmr1905240wrt.13.1686057879472;
        Tue, 06 Jun 2023 06:24:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2-20020adfd4c2000000b0030aeb3731d0sm12555276wrk.98.2023.06.06.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:24:39 -0700 (PDT)
Message-Id: <0616fdbf303de9d8a81a1ff1977a8da31d5e6cfd.1686057877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.v3.git.1686057877.gitgitgadget@gmail.com>
References: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
        <pull.1537.v3.git.1686057877.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 13:24:35 +0000
Subject: [PATCH v3 1/3] repository: create disable_replace_refs()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, me@ttaylorr.com, newren@gmail.com,
        gitster@pobox.com, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
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

We will need to keep this read_replace_refs global forever, as we want
to make sure that we never use replace refs throughout the life of the
process if this method is called. Future changes may present a
repository-scoped version of the variable to represent that repository's
core.useReplaceRefs config value, but a zero-valued read_replace_refs
will always override such a setting.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/cat-file.c       | 2 +-
 builtin/commit-graph.c   | 2 +-
 builtin/fsck.c           | 2 +-
 builtin/index-pack.c     | 2 +-
 builtin/pack-objects.c   | 2 +-
 builtin/prune.c          | 2 +-
 builtin/replace.c        | 2 +-
 builtin/unpack-objects.c | 2 +-
 builtin/upload-pack.c    | 2 +-
 environment.c            | 2 +-
 git.c                    | 2 +-
 replace-object.c         | 5 +++++
 replace-object.h         | 8 ++++++++
 13 files changed, 24 insertions(+), 11 deletions(-)

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
index a3d00fa232b..dd732b35348 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -324,7 +324,7 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	read_replace_refs = 0;
+	disable_replace_refs();
 	save_commit_buffer = 0;
 
 	argc = parse_options(argc, argv, prefix, options,
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2cd461b84c1..a2fe760cc0e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -927,7 +927,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	fetch_if_missing = 0;
 
 	errors_found = 0;
-	read_replace_refs = 0;
+	disable_replace_refs();
 	save_commit_buffer = 0;
 
 	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
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
index a5b466839ba..e23fe82ca1a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4284,7 +4284,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
 		BUG("too many dfs states, increase OE_DFS_STATE_BITS");
 
-	read_replace_refs = 0;
+	disable_replace_refs();
 
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
 	if (the_repository->gitdir) {
diff --git a/builtin/prune.c b/builtin/prune.c
index 5dc9b207200..28772017376 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -164,7 +164,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 
 	expire = TIME_MAX;
 	save_commit_buffer = 0;
-	read_replace_refs = 0;
+	disable_replace_refs();
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
diff --git a/builtin/replace.c b/builtin/replace.c
index 981f1894436..abff800276c 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -566,7 +566,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	read_replace_refs = 0;
+	disable_replace_refs();
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2c52c3a741f..0b4fe803cc1 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -609,7 +609,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 	int i;
 	struct object_id oid;
 
-	read_replace_refs = 0;
+	disable_replace_refs();
 
 	git_config(git_default_config, NULL);
 
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index beb9dd08610..81d2008e017 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -36,7 +36,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	};
 
 	packet_trace_identity("upload-pack");
-	read_replace_refs = 0;
+	disable_replace_refs();
 
 	argc = parse_options(argc, argv, prefix, options, upload_pack_usage, 0);
 
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
-- 
gitgitgadget

