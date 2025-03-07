Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509333DF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390571; cv=none; b=WCUEjxa+9XqI1/QNtCYZCSx3We+P2NrnJ2VziwFSOoU7YkOYjr9McRkm2p2CCptbGDgWvGrbBQtaoFkILaYmPooWxXHPFV/0JpzEKDNQ+T0EJMCM/OFmPf/OodHE07LChiFDPwT5/SONN7+fhmt7bxV5mWygiNjU1CtVdMe0PVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390571; c=relaxed/simple;
	bh=uyPEZR42xGEUWWqABH7AINQb5hhX4uxPZN3aXjnIdLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtPYJNCnXZNsVByOwIDppGrE4FNqC2NFhW/Bp7gyRorXve7IP3p8IxoaBvDLBIT0PlE9b2m8BNkJLJJKk5JCbJ4zPpNcFJWqaQqxz+CYy4ESvEVbwVchzhTY5KG2vSEBXMCYvefOEeFsRN0TOlpoJkoGZlI8A8MWsZueiD+rG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT+vdvAv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT+vdvAv"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223594b3c6dso45197365ad.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390569; x=1741995369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mTtvDBKpgj+WV6qsVkiH+6irNu3ohNrVLzshn7Enuw=;
        b=bT+vdvAv5a+gX9zSwZ4i76V3u5R8fDYxycD1F1W1XTFXKWIDwQBmjXg2WsGLzKA2Do
         5JYzhU44jCRm08E2YVLVMhJttzEvs/iMZCsxKh8HtK3gIUawtyIy+V+2gTANXaGGKhyZ
         mJdNVdGniqJ1lkKBU5IK1FcqSiWWCPIrj89nvTzaOTwC814cryKNNfCp99MoyIDD1B7c
         IZj2QVdRudiNTj5QQF2hK3CGEdI7NDki+ypCeFglSdVd/OeDqejZrUA5gdeaM5Qtu7bs
         gGOdOxU2KhU/072Tnl+FZzparFoIjtdUmmjBds54p3GCvRc5YuQBunlc3/dbJIUanv7d
         u/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390569; x=1741995369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mTtvDBKpgj+WV6qsVkiH+6irNu3ohNrVLzshn7Enuw=;
        b=opuNQrY2GsDLoxtyElQCKy0RUvimWiFYeog0Ik0hwOgoAb20vpIN555dylFDSo8v3Q
         dRpK0rFDNGnoUymw37H6rffxr/xMiyL/SWGEQ9Hw3v0BEV/ujYlffZsSIBJvuEZcsuIQ
         0D3tESzv+WMNZTM4dFDRTycom/GM4WfpfYXLagIXEPURsFqurnxzqDZWb+AXFbL68r11
         cVcCHNnUg7aHoB7rMgO0iYsQPbrtW8hpSe2ULu704uu4EKXFvOcsCaaSKWY5K1o9TksR
         iRc/Khaa5doGanTw1lvMOhecVaIUZc/YsJ0jb9se7TIaEeHzI3vh8KtTExUky7aLgD92
         W6WA==
X-Gm-Message-State: AOJu0Yyr7xeS9SR9bE7qRc76ojJFtf4WaOLATOnrchvA2VkHoTOoD6Ke
	3wZuogsTwE65KVrsMN223ZzQPq38uPwZStNiA43YtpQWlxuMPhX9mB4qbfzmvis=
X-Gm-Gg: ASbGncu165wxsKJrR8cv7/gkfJ0ranSaktPltfdru49ujZ67WqGD5Srac8ZsfZed2VT
	mmbd1YC/ynzHKJ8OklvaQITXq7hC+cHSjPlqLw142HmELiilsBqBqOeM1DSY3gqG2mBEiWgD0xK
	oi9MfDxZm4oPc974sqif/veCLiJQfRVgy/VAkuzoiaw2Tmr8h3qGcK/aE7AeeoGlK4jtxfT6suP
	7bAB9MtpKMuOUkpHqqh2v1v+SiXCUqcEcADrnfKs5maRN1TbatqC6tGEBZVEnT0campcWcfOsk1
	+CNb53GOmoMAbtbIRXhN+Y7/9DJMgV5xBL/M5bu1Q8z5lydCeQPdUajE9eziPXKa+4alRQ==
X-Google-Smtp-Source: AGHT+IGFF+6dglBl1ANx6ZQ88DhFfWq//VkwVagRfAuJRZBbSX2JaIxxEhDAR8FAr/2hprN9e66guQ==
X-Received: by 2002:a05:6a00:987:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-736aa9c1adbmr9860846b3a.3.1741390569402;
        Fri, 07 Mar 2025 15:36:09 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bcb8de04sm423880b3a.154.2025.03.07.15.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:36:09 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 6/8] builtin/ls-files: stop using `the_repository`
Date: Sat,  8 Mar 2025 05:05:05 +0530
Message-ID: <20250307233543.1721552-7-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
References: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
 <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
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

