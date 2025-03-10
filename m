Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6522DFB1
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619478; cv=none; b=iVbCmFs7yFObVtJl5sR0i8B76Wr5xDgNTN3ARbkCJ9U/dMox6f+AzqfJNWRg97y+oGIw0qfXpjUqzbYFjN2vClP0q+L9ofbBL0Hs9Dnl9aGQb8HIO20AupXrf4SQCpDYFdK/FhGhUqS1jkibT2HpheP9YNGo/mmaZ5K6PY99muQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619478; c=relaxed/simple;
	bh=e2gQUjqP7pL1yZEGKmf1K9g/TnpSGAJy/Ya+hqlDpQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4nwM2MJ2AbTeSkjkEpOr6dIIMjc7LnLB7FJTZJCQm44o91DdCqJiXIFShLQKACTJp9qqvtIr5KTxldgUFhsfprcY5zGqjyOsvzY0gmdTkUdl4fY9urFvQ91UO4/hJPHs5w3i4SLmVCPIs9EXqCJPwFdu9DkQZ5ei41EEWSJ0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9dff32x; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9dff32x"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223959039f4so86460415ad.3
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741619476; x=1742224276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTdsgIbmcNz4p0eL9/uQxo4wXB4UOfN+DrkksRCZezI=;
        b=V9dff32xzkcKpDnDx43LL2LqDjN4XOzc9KQVjDZnODb6lhwMQlN/zXHfOq/hT6fyaK
         M3dhnEsQ+4/s5oPI9eG6xFn9VVae8q+Q6ii9hBxnsP45ItCrbzWACxo8x7I5ekQqoolh
         hZmds/vgmWjlvl3IA/zF6D9Wp3TLm6LtTD2kUQ0rVyL8YpMW5YFkuoPYdhDeLY4GxNzS
         hnL0TK1qiJYTBkYnU9i9kwVbG3j9vdiYisMBjG8E4Ea8DTnXVcKXh31pIaQKgCJQ6Owb
         2Ff5+wahkroy+4uz9HMNSDY594Y35Z2Bzx9C89u5ahUWbVwb1V/YGARRXgf8mIrPVDb4
         7ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619476; x=1742224276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTdsgIbmcNz4p0eL9/uQxo4wXB4UOfN+DrkksRCZezI=;
        b=Ci6SqAp2vJQgxAXcDLIC2f+T6hiNLNz7vIVoxxVK6WvoTQgIEvCmFL65+n7OOFVI8l
         AHqx8Sxcq9fire+O3ulMs3bRzWuBcDWyHZwhSwA5m7cRNq+pDpGNHN8gxH7upa/bSt8H
         PnQeFBQfq5IBfLK2SDSRH5EgZs3oS+ct9PoqJYwp8gNmq/jiZazCCwWoOt/GZ4brK2K8
         wKi8JAkpzjdt1wsTZPzEJS8MaknhNttHieYJ/DmzsYCoqMhpxTUctrWPQITrTkwG7E0W
         aMYbcUZsP0q1VvEqKeFuD0HdDdo8VAdtXE4zJy3h0jOJHjZV32WBwTxuaCdPYgM+TsYg
         Ea2w==
X-Gm-Message-State: AOJu0Yyxc7KovN4eMUGETVwRqVWIFRyhSInzoykBUS1f+BMHiYF8d2/o
	pSWou6M+IIMc9TfnhbLNmp8mO75dRwkKbdPHbinVDv4mrYehD9nMaE2rOH00lB8=
X-Gm-Gg: ASbGncs020jAlF7xfIsW2I79SnY46EClMc/V6hxzWQ5I+Ay1GqsalmtMKDUknTVn8zl
	pvS/ajbUzgrraWmBC298AyOZpeIeXT93/pwNnB1msMeZtVsdd/yDinNEuaXrjNWu2+g49h1HJKy
	VNKYwMS8jC31MhqQaW5R07WQ//yrtkKanvn9rBtv3gRH+ELqZLxK71d+sQ3K06QJlJKreQ8Nsv/
	ldc0IC3EMrWXV7xDcQLLaYa+O2G3sWK1ltdrjWxf+oAAKS27+QY43jVbyIxiEvSTPuLyk3FPGT7
	nfPE2ZzwQYfMf05UIHNYBiPq5T9dYjKRD4a/eVDcRIqTV+AkQwggppLUgr581Q==
X-Google-Smtp-Source: AGHT+IGgGqECt4fYRXjoZ+sSx60098Jvno6wLCtNu91wBqLCMA7Xw1/P+X9qA9HKesPokxsEHyxZ5g==
X-Received: by 2002:a17:902:e5d2:b0:224:23ab:b88b with SMTP id d9443c01a7336-2242887ecc6mr196011545ad.8.1741619476382;
        Mon, 10 Mar 2025 08:11:16 -0700 (PDT)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e98adsm79528715ad.90.2025.03.10.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:11:15 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v2 2/2] attr: use `repo_settings_get_attributesfile_path()` and update callers
Date: Mon, 10 Mar 2025 20:40:48 +0530
Message-ID: <20250310151048.69825-3-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
In-Reply-To: <20250310151048.69825-1-ayu.chandekar@gmail.com>
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
 <20250310151048.69825-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update attribute-related functions to retrieve the "core.attributesfile"
configuration via the new repository-scoped accessor
`repo_settings_get_attributesfile_path()`. This improves behaviour in
multi-repository contexts and aligns with the goal of minimizing
reliance on global state.

Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 attr.c               | 28 ++++++++++------------------
 attr.h               |  7 +++----
 builtin/check-attr.c |  2 +-
 builtin/var.c        |  2 +-
 4 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/attr.c b/attr.c
index 0bd2750528..8f28463e8c 100644
--- a/attr.c
+++ b/attr.c
@@ -879,14 +879,6 @@ const char *git_attr_system_file(void)
 	return system_wide;
 }
 
-const char *git_attr_global_file(void)
-{
-	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
-
-	return git_attributes_file;
-}
-
 int git_attr_system_is_enabled(void)
 {
 	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
@@ -906,7 +898,7 @@ static void push_stack(struct attr_stack **attr_stack_p,
 	}
 }
 
-static void bootstrap_attr_stack(struct index_state *istate,
+static void bootstrap_attr_stack(struct repository *repo, struct index_state *istate,
 				 const struct object_id *tree_oid,
 				 struct attr_stack **stack)
 {
@@ -927,8 +919,8 @@ static void bootstrap_attr_stack(struct index_state *istate,
 	}
 
 	/* home directory */
-	if (git_attr_global_file()) {
-		e = read_attr_from_file(git_attr_global_file(), flags);
+	if (repo_settings_get_attributesfile_path(repo)) {
+		e = read_attr_from_file(repo_settings_get_attributesfile_path(repo), flags);
 		push_stack(stack, e, NULL, 0);
 	}
 
@@ -946,7 +938,7 @@ static void bootstrap_attr_stack(struct index_state *istate,
 	push_stack(stack, e, NULL, 0);
 }
 
-static void prepare_attr_stack(struct index_state *istate,
+static void prepare_attr_stack(struct repository *repo, struct index_state *istate,
 			       const struct object_id *tree_oid,
 			       const char *path, int dirlen,
 			       struct attr_stack **stack)
@@ -969,7 +961,7 @@ static void prepare_attr_stack(struct index_state *istate,
 	 * .gitattributes in deeper directories to shallower ones,
 	 * and finally use the built-in set as the default.
 	 */
-	bootstrap_attr_stack(istate, tree_oid, stack);
+	bootstrap_attr_stack(repo, istate, tree_oid, stack);
 
 	/*
 	 * Pop the "info" one that is always at the top of the stack.
@@ -1143,7 +1135,7 @@ static void determine_macros(struct all_attrs_item *all_attrs,
  * If check->check_nr is non-zero, only attributes in check[] are collected.
  * Otherwise all attributes are collected.
  */
-static void collect_some_attrs(struct index_state *istate,
+static void collect_some_attrs(struct repository *repo, struct index_state *istate,
 			       const struct object_id *tree_oid,
 			       const char *path, struct attr_check *check)
 {
@@ -1164,7 +1156,7 @@ static void collect_some_attrs(struct index_state *istate,
 		dirlen = 0;
 	}
 
-	prepare_attr_stack(istate, tree_oid, path, dirlen, &check->stack);
+	prepare_attr_stack(repo, istate, tree_oid, path, dirlen, &check->stack);
 	all_attrs_init(&g_attr_hashmap, check);
 	determine_macros(check->all_attrs, check->stack);
 
@@ -1310,7 +1302,7 @@ void git_check_attr(struct index_state *istate,
 	int i;
 	const struct object_id *tree_oid = default_attr_source();
 
-	collect_some_attrs(istate, tree_oid, path, check);
+	collect_some_attrs(the_repository, istate, tree_oid, path, check);
 
 	for (i = 0; i < check->nr; i++) {
 		unsigned int n = check->items[i].attr->attr_nr;
@@ -1321,14 +1313,14 @@ void git_check_attr(struct index_state *istate,
 	}
 }
 
-void git_all_attrs(struct index_state *istate,
+void git_all_attrs(struct repository *repo, struct index_state *istate,
 		   const char *path, struct attr_check *check)
 {
 	int i;
 	const struct object_id *tree_oid = default_attr_source();
 
 	attr_check_reset(check);
-	collect_some_attrs(istate, tree_oid, path, check);
+	collect_some_attrs(repo, istate, tree_oid, path, check);
 
 	for (i = 0; i < check->all_attrs_nr; i++) {
 		const char *name = check->all_attrs[i].attr->name;
diff --git a/attr.h b/attr.h
index a04a521092..1ff058bef7 100644
--- a/attr.h
+++ b/attr.h
@@ -213,11 +213,13 @@ void git_check_attr(struct index_state *istate,
 		    const char *path,
 		    struct attr_check *check);
 
+struct repository;
+
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
  */
-void git_all_attrs(struct index_state *istate,
+void git_all_attrs(struct repository *repo, struct index_state *istate,
 		   const char *path, struct attr_check *check);
 
 enum git_attr_direction {
@@ -232,9 +234,6 @@ void attr_start(void);
 /* Return the system gitattributes file. */
 const char *git_attr_system_file(void);
 
-/* Return the global gitattributes file, if any. */
-const char *git_attr_global_file(void);
-
 /* Return whether the system gitattributes file is enabled and should be used. */
 int git_attr_system_is_enabled(void);
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 7cf275b893..1b8a89dfb2 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -70,7 +70,7 @@ static void check_attr(const char *prefix, struct attr_check *check,
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 
 	if (collect_all) {
-		git_all_attrs(the_repository->index, full_path, check);
+		git_all_attrs(the_repository, the_repository->index, full_path, check);
 	} else {
 		git_check_attr(the_repository->index, full_path, check);
 	}
diff --git a/builtin/var.c b/builtin/var.c
index ada642a9fe..8fbf5430a4 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -71,7 +71,7 @@ static char *git_attr_val_system(int ident_flag UNUSED)
 
 static char *git_attr_val_global(int ident_flag UNUSED)
 {
-	char *file = xstrdup_or_null(git_attr_global_file());
+	char *file = xstrdup_or_null(repo_settings_get_attributesfile_path(the_repository));
 	if (file) {
 		normalize_path_copy(file, file);
 		return file;
-- 
2.48.GIT

