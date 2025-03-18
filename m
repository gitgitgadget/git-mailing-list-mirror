Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9B207E12
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299184; cv=none; b=ZPSvAUH5QMxuH4apaQ3GMoY3bjOh8w3AFRPGgorRa/LuT2UVVE/ULxdPaKN3uHA8m03trDQfbkgITgFqNgRKZXCEb4x2RuH7Dp1gyqobWRBnDzH4mrx5ZqZHoREbNOIJs/bD8S6LpTUY8kAKl6m9TzliQYHD4cqRfyrFlpVxfCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299184; c=relaxed/simple;
	bh=uyPEZR42xGEUWWqABH7AINQb5hhX4uxPZN3aXjnIdLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sym4GQ5HtMkxZ1U0etQUgbV8fXDxGSerkQfAqAujrjiLI9VDaI4aIdD5rbF2zoyB5d2vHkapg/HX8RC8AKUMLhPGY0dVfGdjKGCs/13kL+64FO8ZBKJuPQhjX+lJ0VDusIqPm+D7u6aeZYV2RCFovzO+B5NkOpg3XmLiDwxkvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/wWEXWZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/wWEXWZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22359001f1aso58259915ad.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299178; x=1742903978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mTtvDBKpgj+WV6qsVkiH+6irNu3ohNrVLzshn7Enuw=;
        b=j/wWEXWZNYjeZzXfnFE7bLeOtdeoRH7MHfoAGNwKOk31gQNisLixVNLcPSjF2Z+CSC
         6/P32IGGANZFVAGYvQDAQ52JQLQnLyKf7fKAuAZTRp2JQUe2+BkQW7M32aH56kOEzPAM
         /eAAihc71/Tr3/XgQji/8SWcGqRtDrp2P+8vc4VBDiLy9+L0j2RYr/hdg1kQLDeVGxSx
         BiYGcBYAEybKcAfiG/F6PjsA8+ZICVkE+JxyYUm56+4OKtFjZ0PpqIL/sXARksqEqOXD
         a0Vk3Nxpmp+Pe7Sf33dsmO7bxJVdITBwXBDZy/kW3o6FxXj6v3FEuzRO+SlAQVfDHcmD
         cXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299178; x=1742903978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mTtvDBKpgj+WV6qsVkiH+6irNu3ohNrVLzshn7Enuw=;
        b=Kie26CSb3YTbP4IjSkrLqW0ANZkLyNEmzKUasOwqipBtJLa1kZfgUsY61y+iume72g
         nFwU6SPX6z+wrUdiSK5nTt88ZE1ztl2cE+oZuIZY5Kd5Iz0xwBkMcSc4cFOrhmJuTEs9
         9s7bysQIi/sxU/VZDAIbfvLvmH52oGFC5i6Vwk9lY6K5xxAmU2ikbjRSwaPQ1vo7WTKG
         vR0lElpTOIphFQZcPZ/mLGHqxVT+3ETiZZGgO5qw5rlXx3HHGuo6ngl7miD2aHFwo/hd
         QKEAGkmQrNTLNDRJZrjFQVSGAtR+vJeqabgNK18K3DTxgYzo3VDLv3QlIVOVZXIQDEat
         g22g==
X-Gm-Message-State: AOJu0YyQp5f+le3gKBbvPxgpCrIHlckooGmoE677iqGCpO1Dn4IcuFVV
	rDQ2nRKAJi/HmyLHFAlewarDBjo/il3dQr6BZN+z7PfSVeIFZ0fxAcQlCkRH
X-Gm-Gg: ASbGncvfPVoTVxqxhyK6MAUTXjdyTeX4+wrtCKo+bnE1CnErtHultX1mvQen+tbaFbd
	XEDKVzNyWhw9eunU2nwcwUNcxlqc0eqAI7x66l9ghcxVaPkij4ThoZF7k5TVc7QyaZYK3G2MQGR
	vpuREusUMQOGUv0JoHkW3TVURIob0QVOOrYU9bxaBU2c8X2MjecdFglRKiufLtgX/V4aiL0vwzi
	QMjhlI9YpUqpvoJSuZ7n0aANFnVEERm3AN/hNWtrIehqVGwh1uUWQENO+ug7yEIjvy8HAjOz2n9
	nDry5UVDYrmXkQqzNIzS3UjnmKPToQ6x+08F6cv+yIMZf6KfQ7m7MCDjXgasDv4aCN+z2w==
X-Google-Smtp-Source: AGHT+IFzuVS6xJFR4I3MJpJxxUCNFkkNBvcIAdsqZsm44KpMfMO1p1S5RIzx3160+mFwsG5VRlYRag==
X-Received: by 2002:a17:902:ced0:b0:224:584:6f04 with SMTP id d9443c01a7336-2262c537c85mr36206385ad.18.1742299177970;
        Tue, 18 Mar 2025 04:59:37 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bc012bsm92101605ad.205.2025.03.18.04.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:59:37 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/9] builtin/ls-files: stop using `the_repository`
Date: Tue, 18 Mar 2025 17:28:58 +0530
Message-ID: <20250318115912.2978992-7-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/ls-files.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_ls_files()` function with `repo` set
to NULL and then early in the function, `show_usage_with_options_if_asked()`
call will give the options help and exit.

Pass the repository available in the calling context to both
`expand_objectsize()` and `show_ru_info()` to remove their
dependency on the global `the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/ls-files.c        | 32 ++++++++++++++++----------------
 t/t3004-ls-files-basic.sh |  7 +++++++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a4431429b7..70a377e9c0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -6,7 +6,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -245,12 +244,13 @@ static void show_submodule(struct repository *superproject,
 	repo_clear(&subrepo);
 }
 
-static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
+static void expand_objectsize(struct repository *repo, struct strbuf *line,
+			      const struct object_id *oid,
 			      const enum object_type type, unsigned int padded)
 {
 	if (type == OBJ_BLOB) {
 		unsigned long size;
-		if (oid_object_info(the_repository, oid, &size) < 0)
+		if (oid_object_info(repo, oid, &size) < 0)
 			die(_("could not get object info about '%s'"),
 			    oid_to_hex(oid));
 		if (padded)
@@ -283,10 +283,10 @@ static void show_ce_fmt(struct repository *repo, const struct cache_entry *ce,
 		else if (skip_prefix(format, "(objecttype)", &format))
 			strbuf_addstr(&sb, type_name(object_type(ce->ce_mode)));
 		else if (skip_prefix(format, "(objectsize:padded)", &format))
-			expand_objectsize(&sb, &ce->oid,
+			expand_objectsize(repo, &sb, &ce->oid,
 					  object_type(ce->ce_mode), 1);
 		else if (skip_prefix(format, "(objectsize)", &format))
-			expand_objectsize(&sb, &ce->oid,
+			expand_objectsize(repo, &sb, &ce->oid,
 					  object_type(ce->ce_mode), 0);
 		else if (skip_prefix(format, "(stage)", &format))
 			strbuf_addf(&sb, "%d", ce_stage(ce));
@@ -348,7 +348,7 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 	}
 }
 
-static void show_ru_info(struct index_state *istate)
+static void show_ru_info(struct repository *repo, struct index_state *istate)
 {
 	struct string_list_item *item;
 
@@ -370,7 +370,7 @@ static void show_ru_info(struct index_state *istate)
 			if (!ui->mode[i])
 				continue;
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
-			       repo_find_unique_abbrev(the_repository, &ui->oid[i], abbrev),
+			       repo_find_unique_abbrev(repo, &ui->oid[i], abbrev),
 			       i + 1);
 			write_name(path);
 		}
@@ -567,7 +567,7 @@ static int option_parse_exclude_standard(const struct option *opt,
 int cmd_ls_files(int argc,
 		 const char **argv,
 		 const char *cmd_prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
 	int require_work_tree = 0, show_tag = 0, i;
 	char *max_prefix;
@@ -647,15 +647,15 @@ int cmd_ls_files(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 ls_files_usage, builtin_ls_files_options);
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
 
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
-	if (repo_read_index(the_repository) < 0)
+	if (repo_read_index(repo) < 0)
 		die("index file corrupt");
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
@@ -724,7 +724,7 @@ int cmd_ls_files(int argc,
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
-	prune_index(the_repository->index, max_prefix, max_prefix_len);
+	prune_index(repo->index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec.nr && error_unmatch)
@@ -748,13 +748,13 @@ int cmd_ls_files(int argc,
 		 */
 		if (show_stage || show_unmerged)
 			die(_("options '%s' and '%s' cannot be used together"), "ls-files --with-tree", "-s/-u");
-		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
+		overlay_tree_on_index(repo->index, with_tree, max_prefix);
 	}
 
-	show_files(the_repository, &dir);
+	show_files(repo, &dir);
 
 	if (show_resolve_undo)
-		show_ru_info(the_repository->index);
+		show_ru_info(repo, repo->index);
 
 	if (ps_matched && report_path_error(ps_matched, &pathspec)) {
 		fprintf(stderr, "Did you forget to 'git add'?\n");
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index a1078f8701..4034a5a59f 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -34,6 +34,13 @@ test_expect_success 'ls-files -h in corrupt repository' '
 	test_grep "[Uu]sage: git ls-files " broken/usage
 '
 
+test_expect_success 'ls-files does not crash with -h' '
+	test_expect_code 129 git ls-files -h >usage &&
+	test_grep "[Uu]sage: git ls-files " usage &&
+	test_expect_code 129 nongit git ls-files -h >usage &&
+	test_grep "[Uu]sage: git ls-files " usage
+'
+
 test_expect_success SYMLINKS 'ls-files with absolute paths to symlinks' '
 	mkdir subs &&
 	ln -s nosuch link &&
-- 
2.48.1

