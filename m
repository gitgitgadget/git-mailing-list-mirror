Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8E372B4E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875820; cv=none; b=eJULOGGLY5K0/kdSbRiSleonodu6K781qZOVzWFFN8o/cvsjz+2a0a6hS+dtbQBho2XrQyYpqV1HYDAU5fkUUXCpp8Ec/LX6a5zNft3CKpHJkDgPU0G53UCCrYv6OfkrpfSamsaerPhnnYfBD5GWmi2ILiA+CdENzcjloyRjNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875820; c=relaxed/simple;
	bh=OjNb9GbMmvoo/AvzqMKMll5S6aCm26qmvy45GbcFE+Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BuKeYatgzYZGeU6fGwAWPi6ICCrCz8p9XIhGzXQy9fch0H2XzmOxo9jrky1lB6H/W8iYxOmb1gmACiBLbQwpydsyqazvPJS9nn93+lmH3RvRQ53oPC7Q2bkoRD40nUTYBeTyz/WM3UuIOKsNIN2W+8EE/1Ip1xFSysAgrSHh51E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHBMcAYM; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHBMcAYM"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-896f8feee14so57286426d6.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875818; x=1772480618; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMW1I8meSSb/l+AUNZEA2AyUORzirRK8gxnH32iO8mE=;
        b=kHBMcAYMvmGTJhGknSpD622hIhxJ9yl+dDEvoqYwYrduk5HKrcppdv5GUwCuSM5v55
         veqL1m2LWt8cW1zAfTndVh7aBIgC/aGXDs9d++yLKLrI79lFokjy8z7Yx9UShqxAMZ0J
         nYhKNjxD84mIbCw5btqDuBtX6amE573sftzR72jFPGugRcj5TsQlCJRPb6PmDuk5mFOv
         G32U39QJMVZMYEnVUWRMcMl5Ip4QRiGwto/JyOIC9EdUfTqz5GbajcaHxc734bY+TSXI
         x+w2mSbsRlyctHZeLoskEKoS+1VB1vBnDqSw7iaruF8aqOKn+n614xXqyVmVkWe68MFY
         ejrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875818; x=1772480618;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMW1I8meSSb/l+AUNZEA2AyUORzirRK8gxnH32iO8mE=;
        b=NW4m1pZpJl6P+jQLbX7zmY3TR5MIhzQOYPCTnXXLSKtr3PgQcMiRbIhnrnbLSytN6d
         sLisYVv/tdYbclz/gvzAkBV2mlKjwo5eFQZBMCHeFi4n2m4BDIq5xVNOIrowLN2E3a8z
         rkVWyn9iNOcjjTTbLrgvek1DPOtMqz5U2Qpt7w7klx8G1vhqQ+459Lu1o/N6Ko9BiDFj
         jHsRTG7zVT/wbTKF3cunQd4EHspI0XWt3pM/V1zMn1dz1DuzjZ9ju2tFGut91mOtW6bY
         7HpJTYFoDbx0WAjupQPTi5wj8s9b8J91ajBaPVyJcbUR6Sk4FyLGaRqkJTB6JIpwOqts
         jYVw==
X-Gm-Message-State: AOJu0Yyi5NGY7YPp0xcXFuYjhL0AiHy27Gy6DATzqC3oFWZFnJVrWqZE
	6txqCqXp+/JUSLycv9H7g7HacbIdHJ5lpu7q6b27nSPxK0KA0YJPswl8mUUx3Q==
X-Gm-Gg: AZuq6aKc+QEYIBJSAe0q79TZULjYdLeQ/oyxhYMjzXFMQB9Q/H8N4sTkN/ew5QWt48v
	b6XFHjazqeuZpaMbNFHMUPFAMvjqWGs97Z3So9Z1eZ1bJrn40z3ANzO1jt51tToVG8L88hTSwHv
	1wwni54NXfqG+jqfOn3xQCHk3awS6ZdvO5Xy17BfE1r1Vh7oz+IzCa90ERbbjk0mIIe6b3XMpBY
	BJ7+T4XI0xahSnlJ0Z1zOPu0+JEOAMpkLcRUaZeltl8ffAyc3iGzHWPdEc8gOd1htiFpaCR2yj2
	jowkluPAUkIxR4AOAKDUEP3KSgO7e747Dp60HerHPI2D99/4NrG001Qj/npTqG20Pu5QJcnNOyQ
	jYxy8/LfTm6r0+tgDndXRGhqTp63LGHB/1qVZDLO0aWelw9Sqnxis4mroi/FjK53+BUmUJghZfg
	BIqrArqdoJY/meUNGYMHmgxObj5A8=
X-Received: by 2002:a05:622a:11d6:b0:505:e52b:1024 with SMTP id d75a77b69052e-5070bbbb481mr146114671cf.29.1771875817804;
        Mon, 23 Feb 2026 11:43:37 -0800 (PST)
Received: from [127.0.0.1] ([135.232.224.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d582c1esm76506241cf.15.2026.02.23.11.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:43:37 -0800 (PST)
Message-Id: <348e361fe77946b9fd3b751591d9475a95499c48.1771875812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
References: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
	<pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 19:43:29 +0000
Subject: [PATCH v3 2/5] repo: add path keys to repo info
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Add a path category to git repo info with key-value pairs that
mirror repository paths users commonly retrieve via rev-parse and
git-path lookups.

This makes scripting against repo metadata more direct and avoids
shelling out to multiple commands for related paths.

The new keys are introduced as explicit path.* entries in
repo_info_fields and are resolved through dedicated helpers.

This keeps lookup behavior predictable and makes future path
additions straightforward.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index e34914a9a7..35e1eaf7d7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,10 +1,12 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "abspath.h"
 #include "environment.h"
 #include "hex.h"
 #include "odb.h"
 #include "parse-options.h"
+#include "path.h"
 #include "path-walk.h"
 #include "progress.h"
 #include "quote.h"
@@ -14,6 +16,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
+#include "submodule.h"
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
@@ -40,6 +43,13 @@ struct field {
 	get_value_fn *get_value;
 };
 
+static void repo_info_add_path(struct repo_info *info,
+			      struct strbuf *buf,
+			      const char *path)
+{
+	strbuf_add_absolute_path(buf, path);
+}
+
 static int get_layout_bare(struct repo_info *info UNUSED, struct strbuf *buf)
 {
 	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
@@ -61,6 +71,119 @@ static int get_object_format(struct repo_info *info, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_common_dir(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_common_dir(info->repo));
+	return 0;
+}
+
+static int get_path_config_file(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "config"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_git_dir(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_git_dir(info->repo));
+	return 0;
+}
+
+static int get_path_git_prefix(struct repo_info *info, struct strbuf *buf)
+{
+	if (info->prefix)
+		strbuf_addstr(buf, info->prefix);
+	return 0;
+}
+
+static int get_path_grafts_file(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_graft_file(info->repo));
+	return 0;
+}
+
+static int get_path_hooks_directory(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "hooks"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_index_file(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_index_file(info->repo));
+	return 0;
+}
+
+static int get_path_logs_directory(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "logs"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_objects_directory(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_object_directory(info->repo));
+	return 0;
+}
+
+static int get_path_packed_refs_file(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "packed-refs"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_refs_directory(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "refs"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_shallow_file(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "shallow"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_superproject_working_tree(struct repo_info *info,
+					     struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (get_superproject_working_tree(&superproject))
+		repo_info_add_path(info, buf, superproject.buf);
+
+	strbuf_release(&superproject);
+	return 0;
+}
+
+static int get_path_toplevel(struct repo_info *info, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(info->repo);
+
+	if (work_tree)
+		repo_info_add_path(info, buf, work_tree);
+
+	return 0;
+}
+
 static int get_references_format(struct repo_info *info, struct strbuf *buf)
 {
 	struct repository *repo = info->repo;
@@ -74,6 +197,20 @@ static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.common-dir", get_path_common_dir },
+	{ "path.config-file", get_path_config_file },
+	{ "path.git-dir", get_path_git_dir },
+	{ "path.git-prefix", get_path_git_prefix },
+	{ "path.grafts-file", get_path_grafts_file },
+	{ "path.hooks-directory", get_path_hooks_directory },
+	{ "path.index-file", get_path_index_file },
+	{ "path.logs-directory", get_path_logs_directory },
+	{ "path.objects-directory", get_path_objects_directory },
+	{ "path.packed-refs-file", get_path_packed_refs_file },
+	{ "path.refs-directory", get_path_refs_directory },
+	{ "path.shallow-file", get_path_shallow_file },
+	{ "path.superproject-working-tree", get_path_superproject_working_tree },
+	{ "path.toplevel", get_path_toplevel },
 	{ "references.format", get_references_format },
 };
 
-- 
gitgitgadget

