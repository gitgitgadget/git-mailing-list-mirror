Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11237C77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 14:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbjFBO3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjFBO3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 10:29:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B119B
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 07:29:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30ad752f433so1914774f8f.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 07:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685716162; x=1688308162;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z38yac+2YtNuI0A43nminW38sLSs0CwZUKPeqVD9YPU=;
        b=R3LG0VeN8BfVR7NPNJb38yPRMHfmxeRBabQG625XTtDiAHD2yXHauwgxJNdQEH+Oq0
         OlWb2wptEpgiKJ9RacW0iYGq4nC1KtyDOHBAJ2s58CXJFFh5jNXWhYLX2eLi1Sn3PT3R
         3mD4LaiLt8SmjxC+OfDaE/WS6USnlRkH0UNn9GEYeJFdvVUPfnr9lKEmjkfSdBztOPix
         4tRbUTay0CsY/iiH+wqjyTGCuys8nQPAzWyibfE2TVdpjCfaXPlQ/mETPSkzzO6vNoXj
         Kt//7obBwePqsIEtOHgzrYooKYe97f+aaVRp4Lf2L/Sg7FJpjJmeKWbqc5F7vmgEA8x1
         S2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716162; x=1688308162;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z38yac+2YtNuI0A43nminW38sLSs0CwZUKPeqVD9YPU=;
        b=EFZgTTMzxU00+F+zHP6CL13g+3boNclT3ZAnt3MUjeKswaLj62eJUfzoafMIKOBTIk
         kezlGy7aLN3njX0yVrdA6bTzTyuYEvEiw3ENCH1iLJAR8RbBMK2OAVBRQDX8wGOQrYLR
         V+ZKkYjYXXv2LjAaw2cuzhOSheq7x265qdocwTFtZhlNy7ZPmepZS7bGgGzCln5Wdi/h
         5o0LZAVTo4RAneZoQcQ2NpX5PdwuVsct8d2oGThE+u6Xk7BTRuZ8SnivPk4XTh2RR443
         J7RSByHhcHgmITc6QSMONTDz885v8GsRQXs0AWgtqSOjEdaNZhkAIcIrRlmarxQeaGFS
         40kw==
X-Gm-Message-State: AC+VfDzYw7mkfsDECF+ojLBDmAIy5a5ntVseYmArNe+v/pa0nRouDrd5
        YBBHCe1egFmzhzE+isng8DLmwvOqqOk=
X-Google-Smtp-Source: ACHHUZ7OZOap8+EpC1TXm0TEBPrKk41/Bkg5Nzlwm5uQpYWef8hC8fZ4igz3SzIIumn5QW7Mbx29lg==
X-Received: by 2002:adf:dc4f:0:b0:302:5d34:38a7 with SMTP id m15-20020adfdc4f000000b003025d3438a7mr110262wrj.36.1685716161937;
        Fri, 02 Jun 2023 07:29:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17-20020a1c4c11000000b003f43f82001asm5771613wmf.31.2023.06.02.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:29:21 -0700 (PDT)
Message-Id: <0831e7f8b5e23d0af68aa55d66e0cd745ced1e22.1685716158.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
        <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Jun 2023 14:29:16 +0000
Subject: [PATCH v2 2/3] replace-objects: create wrapper around setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, me@ttaylorr.com, newren@gmail.com,
        gitster@pobox.com, Jeff King <peff@peff.net>,
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

