Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FAAC7EE2E
	for <git@archiver.kernel.org>; Fri, 26 May 2023 18:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbjEZSoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243121AbjEZSoK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 14:44:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590B4E61
        for <git@vger.kernel.org>; Fri, 26 May 2023 11:43:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30a8dc89c33so697322f8f.0
        for <git@vger.kernel.org>; Fri, 26 May 2023 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685126620; x=1687718620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z38yac+2YtNuI0A43nminW38sLSs0CwZUKPeqVD9YPU=;
        b=WqW0jIj5k5LOYZ70F1xPdmSVS9v9NnPKefz5TtjQkE52pO3Dw+bI1TgLUedRz2s1Pp
         ctNcfs5BDFX/QlMmBsCAj/PmuYly8Oy31BBzIvT6xA/PkBxcqIb4cSoLjomecANt9o8c
         GPPaq2tLl+qpwRUXQ2heAV2BwFsnhHG7tNLg+984dThr8vp77j9cOHWT1X1Kh0pjbV8g
         Q2ABXUH9ghj0NEJ+Xq5nq5EKcCYiSjyefYIb8UooOJJYR1fEZ/Ut5VUERJzAPsmued2O
         EF4l5g1ozmuPYN4At5v7z5LHoQFG4mskKB8IT0BmFr7atb4rp04xrMCeKS6iAJSa3cek
         qk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126620; x=1687718620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z38yac+2YtNuI0A43nminW38sLSs0CwZUKPeqVD9YPU=;
        b=BC+gQ3UsLjlXOaQcqPqXwICGMiXiWPOfnwN/qwOWR2k0MdqidqiUCvzahk073gRzjX
         di9cRLLfK4/uGm3BT4Wq45O6GGVj4kyRXvHLc194EsSYB1Hps/CE2BUEL+lAWBU9NsNF
         qD7Yzkszzf4JFNg9w4bwYDboMZZlfx6vRugC9WT8RSD2Z3c7Ut1TFHIQhScJTPJcOG4e
         VHkrSiF1uhBl1l8tSig1OM0935y/bSIRk68yyu2nYzovfz+QuveRuBcC2oomfquNTB2X
         xCND+c3+nfL0TT0NfrYhQYApuoyWNh/3PPvFNyTjaIkU3JojmhMbRspikN5HdwXIuehs
         3LpQ==
X-Gm-Message-State: AC+VfDyi7imYb4P0OSWtBsmlIHyqwJvGl8E7WH7zedu1DI8ZBZWZi7vv
        PUFsrkNJPBpm1UZxbmyFClhslf9banw=
X-Google-Smtp-Source: ACHHUZ7i9rA+tA14+e3I8x121C+k/hXm7LumqaKYw9MBTWaJiRLL820hwQ8qVh0tzhO/JWTm9XWQyw==
X-Received: by 2002:adf:f64c:0:b0:307:8e1b:6cc7 with SMTP id x12-20020adff64c000000b003078e1b6cc7mr1831344wrp.67.1685126620640;
        Fri, 26 May 2023 11:43:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe590000000b002fb60c7995esm5853274wrm.8.2023.05.26.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:43:40 -0700 (PDT)
Message-Id: <5fc2f923d9e6aa13781d7d6567c9bd38a9dd1f0e.1685126618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 May 2023 18:43:36 +0000
Subject: [PATCH 2/3] replace-objects: create wrapper around setting
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

The 'read_replace_objects' constant is initialized by git_default_config
(if core.useReplaceRefs is disabled) and within setup_git_env (if
GIT_NO_REPLACE_OBJECTS) is set. To ensure that this variable cannot be
set accidentally in other places, wrap it in a replace_refs_enabled()
method.

This allows us to remove the global from being recognized outside of
replace-objects.c.

Further, a future change will help prevent the variable from being read
before it is initialized. Centralizing its access is an important first
step.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c   |  4 +---
 environment.c    |  1 -
 log-tree.c       |  2 +-
 replace-object.c |  7 +++++++
 replace-object.h | 15 ++++++++++++++-
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 43558b4d9b0..95873317bf7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -203,14 +203,12 @@ static struct commit_graph *alloc_commit_graph(void)
 	return g;
 }
 
-extern int read_replace_refs;
-
 static int commit_graph_compatible(struct repository *r)
 {
 	if (!r->gitdir)
 		return 0;
 
-	if (read_replace_refs) {
+	if (replace_refs_enabled(r)) {
 		prepare_replace_object(r);
 		if (hashmap_get_size(&r->objects->replace_map->map))
 			return 0;
diff --git a/environment.c b/environment.c
index 3b4d87c322f..e198b48081a 100644
--- a/environment.c
+++ b/environment.c
@@ -63,7 +63,6 @@ const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
-int read_replace_refs = 1;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding = "SHIFT-JIS";
diff --git a/log-tree.c b/log-tree.c
index 143b86fecf9..86212af3626 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -155,7 +155,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 
 	if (starts_with(refname, git_replace_ref_base)) {
 		struct object_id original_oid;
-		if (!read_replace_refs)
+		if (!replace_refs_enabled(the_repository))
 			return 0;
 		if (get_oid_hex(refname + strlen(git_replace_ref_base),
 				&original_oid)) {
diff --git a/replace-object.c b/replace-object.c
index ceec81c940c..cf91c3ba456 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -85,7 +85,14 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 	die(_("replace depth too high for object %s"), oid_to_hex(oid));
 }
 
+static int read_replace_refs = 1;
+
 void disable_replace_refs(void)
 {
 	read_replace_refs = 0;
 }
+
+int replace_refs_enabled(struct repository *r)
+{
+	return read_replace_refs;
+}
diff --git a/replace-object.h b/replace-object.h
index 7786d4152b0..b141075023e 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -27,6 +27,19 @@ void prepare_replace_object(struct repository *r);
 const struct object_id *do_lookup_replace_object(struct repository *r,
 						 const struct object_id *oid);
 
+
+/*
+ * Some commands disable replace-refs unconditionally, and otherwise each
+ * repository could alter the core.useReplaceRefs config value.
+ *
+ * Return 1 if and only if all of the following are true:
+ *
+ *  a. disable_replace_refs() has not been called.
+ *  b. GIT_NO_REPLACE_OBJECTS is unset or zero.
+ *  c. the given repository does not have core.useReplaceRefs=false.
+ */
+int replace_refs_enabled(struct repository *r);
+
 /*
  * If object sha1 should be replaced, return the replacement object's
  * name (replaced recursively, if necessary).  The return value is
@@ -41,7 +54,7 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 static inline const struct object_id *lookup_replace_object(struct repository *r,
 							    const struct object_id *oid)
 {
-	if (!read_replace_refs ||
+	if (!replace_refs_enabled(r) ||
 	    (r->objects->replace_map_initialized &&
 	     r->objects->replace_map->map.tablesize == 0))
 		return oid;
-- 
gitgitgadget

