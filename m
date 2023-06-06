Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B850DC77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 13:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbjFFNYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjFFNYo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 09:24:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F153E126
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 06:24:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30d181952a2so4127918f8f.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686057880; x=1688649880;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1cBiQJdsh7pYsS/7KUWAs7EY/F51Yn46TGLMvgYpCk=;
        b=bxwXQARxebV43Gk7Zi4t9Ri3Lh/di5Vp9Cn22ErN6WVXO/eP8vGLQLe4qCdksurm+y
         Yk9VNh6ox0ag6NgfqhsCemYJ3YLUEXF5qzfdee9uxkTaM+OU8TeQVq3gw/Yq9UjmZxRi
         Y362VsjK7y7XLaJS7oVwElu2M2mq8Cn+yoIO0LLbxebNUM58enRtVCswU0gbGLLTvM74
         0HBWHmW53my0tI3oS4h4+vWOonqqlRMuM4G0SQAv0OosoaXdhgjhKwZq7NT366M9CqT5
         Cb5w7T+9hmITuNk5HDGj0t9dIuA9VaQ0utPMdZMCxNZ3e4iLOTa2hP1svWMH4DdzXA1V
         p1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686057880; x=1688649880;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1cBiQJdsh7pYsS/7KUWAs7EY/F51Yn46TGLMvgYpCk=;
        b=XwRTBsexCJLEHRobjDd6ZCL16jys5n/m2BGzMCfPYL8gRPep8zg3Fx4vk6aKax8Ony
         7I/pvCCu33YSBbJzeqbMn2SmjphKiC98g/iGLxcUyqDa5TIxn+PiuHOvQ6IycrghqyX5
         g7omaNBfYrjkfkZ/B96WVShFr0tDVhGWLvQ8jvSIF9aBJybvhrjNdjETDB5kdFxypnz6
         mh8ui82ajr2x7Deyd/fDV6Cu2RL4zE0DwwBxkCuCQj9DUYaYGIKudyKkvulrOItPNBgU
         LEEUL7b/zuje1odAnXzOYiKAfKXaZV/8QEjdhHMl8aj7PoliQTyEhxUVUg7vOKZY0dsJ
         80tQ==
X-Gm-Message-State: AC+VfDxAHkdj34oyhT46olSeMUc+bYa2RRQ9Z6rVcarqhIhkBAQ0rnc8
        KYqG5XgWOvXIYnmw7QjSQRs9niv0Hh8=
X-Google-Smtp-Source: ACHHUZ5g4MjzBkLyM50RnabT+hMAdMHTyV6Lqd4ZW3XORrgS3lw1EBcY8//OwBV/7ccrnNboEcJ5Sw==
X-Received: by 2002:a5d:6acb:0:b0:30a:d5e2:dc6f with SMTP id u11-20020a5d6acb000000b0030ad5e2dc6fmr2038740wrw.21.1686057880242;
        Tue, 06 Jun 2023 06:24:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d458c000000b00307acec258esm12687678wrq.3.2023.06.06.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:24:39 -0700 (PDT)
Message-Id: <4e75a76f5dd9a9fdce3c542bf885efdfb44dfe40.1686057877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.v3.git.1686057877.gitgitgadget@gmail.com>
References: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
        <pull.1537.v3.git.1686057877.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 13:24:36 +0000
Subject: [PATCH v3 2/3] replace-objects: create wrapper around setting
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

The 'read_replace_objects' constant is initialized by git_default_config
(if core.useReplaceRefs is disabled) and within setup_git_env (if
GIT_NO_REPLACE_OBJECTS) is set. To ensure that this variable cannot be
set accidentally in other places, wrap it in a replace_refs_enabled()
method.

Since we still assign this global in config.c, we are not able to remove
the global scope of this variable and make it a static within
replace-object.c. This will happen in a later change which will also
prevent the variable from being read before it is initialized.

Centralizing read access to the variable is an important first step.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c   |  4 +---
 log-tree.c       |  2 +-
 replace-object.c |  5 +++++
 replace-object.h | 14 +++++++++++++-
 4 files changed, 20 insertions(+), 5 deletions(-)

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
index ceec81c940c..07cfedd6df4 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -89,3 +89,8 @@ void disable_replace_refs(void)
 {
 	read_replace_refs = 0;
 }
+
+int replace_refs_enabled(struct repository *r)
+{
+	return read_replace_refs;
+}
diff --git a/replace-object.h b/replace-object.h
index 7786d4152b0..3e9c3516c3c 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -27,6 +27,18 @@ void prepare_replace_object(struct repository *r);
 const struct object_id *do_lookup_replace_object(struct repository *r,
 						 const struct object_id *oid);
 
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
@@ -41,7 +53,7 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
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

