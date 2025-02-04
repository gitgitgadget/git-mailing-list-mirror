Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05B21E0B2
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709707; cv=none; b=S+weX6348Y724VaqsPgjh0yYDAs2T+1Ib8b0lXrts/mwZoD2+kABY5NLcVz/o69GCa0k1S62uMizN02Ni5zf1VXxTNpKKQeNlEqK0OftCVh2NRGRLvxsLGG7d/btfeZHl9Kv0jvmtMb8SNFVqb23sVERTDPnazRtDcOA44ZNe2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709707; c=relaxed/simple;
	bh=vn1mCFrKirf0M8MN0JOxFBB0dK4rmqLtgafxhtesXeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ksl4V6bMW4ZVrjHu6nO7Wz1BxIRZTqg+RrEMGZlN3cmwxze3vXAA2uiUmJUZQxAKtcWf+Y6uD1Lxi4JiCXXS45krXQq+g+/qvK3cZx140ojeLfxWJmBMoeX8jfyLERSlAyKTAbzqkEa+2pXQkXMIHkdLGZl/W9EDjegcjr9rvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2yfUqCD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2yfUqCD"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166360285dso104721835ad.1
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 14:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738709704; x=1739314504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLj150244wXvkC4QRYHxKK2DMcPSWgDUuZbCq2bldq8=;
        b=c2yfUqCDz7NLTIkdA6O7NQ5UpZ8DlkUj9adb1JfgAKraSG5nkPqa7x94iId897+6aZ
         NP/ztLGgsJjOXZ/rOq7LEpspdmiz/uwq+gMDeUH9+jdOAN65ZV91QwaBA+vIBIh171zq
         /+ohRh15sVnmDLMYF/WM5sRLQzQwW3Db1D0qOZBThXn3OWH7+IsMjKHO0s+QNrD2uLHm
         lv16dEW2UBJvGW0ihxnIRuo4l2fpgr+QlybHz+v0c8BwEiNEcHrs4LWQrtEOw32m1rfI
         a4iwST/66RJ7euIrr6Buk2+S4b7Q+r2cOPhCtLAPIXhelBYP5A/h/FR6fahpVz3w086z
         uyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738709704; x=1739314504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLj150244wXvkC4QRYHxKK2DMcPSWgDUuZbCq2bldq8=;
        b=TCtg61VmZsYv+yBePIC70LVbQiqhx1IoD6604tS0CKx/2AyVN5DcaKJUrkTHM26zBG
         /WtnEBjiGHLmMVzrfJUZDN+Sr5rm5VBAAcsUcF+B6mPf9hgbjcPE5cc8/jr9NI/2AYYN
         OEun4oET6NeCa6C3exvCSBYycbX1QZ4Dsh5Kic4kSQ0j0y0q6qY3jDK97ucTSsdT8gqa
         Rxl9QfURN19bsgqnUw02/j39JBN2raF1QVvZXxRj6xMN9kinv1xocQrKTO14LU20Sn+Z
         Sw9DyABsDhCX7KZ2ubYNTfwva3XcZ/jEoqAlVm5kgXcIOi5k1uqMkkFdZzrdwQw3pUIq
         imAw==
X-Forwarded-Encrypted: i=1; AJvYcCXCDED84YoWfNT42xnmGbfW/CK5lRCZoKHcfmp18pcuu83EAVjtydbkckpkJyLkzlSpIWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6/CtLSzVZsoUhUm3LnMnbysCBsd0x9pVEYZDXG9XU2aALeaR8
	YDIPbaK4yPmMXthEDutGeXxN+TPbUkQzJQIJ5BYENSEqPEtO9E7L
X-Gm-Gg: ASbGncuBGB0q4fia0prCDjdic+E+s7ZmxZevNamoxWo5ZGZb2pn5pSesWvlhs7BcLyM
	4rnmS4HaNOvZKJHXslvWovzGRx18pFmsTXsX+ap5am3E6z5VZ0hRo2QjOAC+Do9yctpTGxBhKUD
	e4H8gAvYJ0AeizIY8HvHtZXaA/X4HfyLVdXuIFp3K6viVm30u5LLnO8/6tu45B5TJEUuqFYMjec
	NCy2aTewhpKfTKkiHe/v/U8unaNts1bu3HyXZQuVoCqeIJ8AT+2pj2zkqy72Bwi+TDxtog22LzE
	4FN8JtUC0JInu+kEYlEag0AtCg==
X-Google-Smtp-Source: AGHT+IE+VhM0hBjHiSYyHF4CYxGvx92TOc6mjjNzUFU8vlCRTgSyISaLbeXsECKT8etXdNiM1FxJPA==
X-Received: by 2002:a05:6a21:458a:b0:1e7:6f82:3217 with SMTP id adf61e73a8af0-1ede88106c5mr928486637.3.1738709704056;
        Tue, 04 Feb 2025 14:55:04 -0800 (PST)
Received: from localhost.localdomain ([172.56.121.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6427abdsm11551055b3a.59.2025.02.04.14.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 14:55:03 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH] difftool: eliminate use of global variables
Date: Tue,  4 Feb 2025 14:55:00 -0800
Message-ID: <20250204225501.597873-1-davvid@gmail.com>
X-Mailer: git-send-email 2.48.1.437.g11abf3cdc8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the 'USE_THE_REPOSITORY_VARIABLE' macro now that all state is
passed to each function from callers.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c | 95 +++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 39 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 03a8bb92a9..cd1e5882e3 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -12,8 +12,6 @@
  * Copyright (C) 2016 Johannes Schindelin
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 
 #include "abspath.h"
@@ -36,18 +34,27 @@
 #include "entry.h"
 #include "setup.h"
 
-static int trust_exit_code;
-
 static const char *const builtin_difftool_usage[] = {
 	N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]"),
 	NULL
 };
 
+struct difftool_state {
+	int has_symlinks;
+	int symlinks;
+	int trust_exit_code;
+};
+
 static int difftool_config(const char *var, const char *value,
 			   const struct config_context *ctx, void *cb)
 {
+	struct difftool_state *dt_state = (struct difftool_state *)cb;
 	if (!strcmp(var, "difftool.trustexitcode")) {
-		trust_exit_code = git_config_bool(var, value);
+		dt_state->trust_exit_code = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "core.symlinks")) {
+		dt_state->has_symlinks = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -63,7 +70,8 @@ static int print_tool_help(void)
 	return run_command(&cmd);
 }
 
-static int parse_index_info(char *p, int *mode1, int *mode2,
+static int parse_index_info(struct repository *repo,
+			    char *p, int *mode1, int *mode2,
 			    struct object_id *oid1, struct object_id *oid2,
 			    char *status)
 {
@@ -75,11 +83,11 @@ static int parse_index_info(char *p, int *mode1, int *mode2,
 	*mode2 = (int)strtol(p + 1, &p, 8);
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
-	if (parse_oid_hex(++p, oid1, (const char **)&p))
+	if (parse_oid_hex_algop(++p, oid1, (const char **)&p, repo->hash_algo))
 		return error("expected object ID, got '%s'", p);
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
-	if (parse_oid_hex(++p, oid2, (const char **)&p))
+	if (parse_oid_hex_algop(++p, oid2, (const char **)&p, repo->hash_algo))
 		return error("expected object ID, got '%s'", p);
 	if (*p != ' ')
 		return error("expected ' ', got '%c'", *p);
@@ -106,7 +114,8 @@ static void add_path(struct strbuf *buf, size_t base_len, const char *path)
 /*
  * Determine whether we can simply reuse the file in the worktree.
  */
-static int use_wt_file(const char *workdir, const char *name,
+static int use_wt_file(struct repository *repo,
+		       const char *workdir, const char *name,
 		       struct object_id *oid)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -121,7 +130,7 @@ static int use_wt_file(const char *workdir, const char *name,
 		int fd = open(buf.buf, O_RDONLY);
 
 		if (fd >= 0 &&
-		    !index_fd(the_repository->index, &wt_oid, fd, &st, OBJ_BLOB, name, 0)) {
+		    !index_fd(repo->index, &wt_oid, fd, &st, OBJ_BLOB, name, 0)) {
 			if (is_null_oid(oid)) {
 				oidcpy(oid, &wt_oid);
 				use = 1;
@@ -212,13 +221,14 @@ static int path_entry_cmp(const void *cmp_data UNUSED,
 	return strcmp(a->path, key ? key : b->path);
 }
 
-static void changed_files(struct hashmap *result, const char *index_path,
+static void changed_files(struct repository *repo,
+			  struct hashmap *result, const char *index_path,
 			  const char *workdir)
 {
 	struct child_process update_index = CHILD_PROCESS_INIT;
 	struct child_process diff_files = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	const char *git_dir = absolute_path(repo_get_git_dir(the_repository));
+	const char *git_dir = absolute_path(repo_get_git_dir(repo));
 	FILE *fp;
 
 	strvec_pushl(&update_index.args,
@@ -291,13 +301,15 @@ static int ensure_leading_directories(char *path)
  * to compare the readlink(2) result as text, even on a filesystem that is
  * capable of doing a symbolic link.
  */
-static char *get_symlink(const struct object_id *oid, const char *path)
+static char *get_symlink(struct repository *repo,
+			 struct difftool_state *dt_state,
+			 const struct object_id *oid, const char *path)
 {
 	char *data;
 	if (is_null_oid(oid)) {
 		/* The symlink is unknown to Git so read from the filesystem */
 		struct strbuf link = STRBUF_INIT;
-		if (has_symlinks) {
+		if (dt_state->has_symlinks) {
 			if (strbuf_readlink(&link, path, strlen(path)))
 				die(_("could not read symlink %s"), path);
 		} else if (strbuf_read_file(&link, path, 128))
@@ -307,8 +319,7 @@ static char *get_symlink(const struct object_id *oid, const char *path)
 	} else {
 		enum object_type type;
 		unsigned long size;
-		data = repo_read_object_file(the_repository, oid, &type,
-					     &size);
+		data = repo_read_object_file(repo, oid, &type, &size);
 		if (!data)
 			die(_("could not read object %s for symlink %s"),
 				oid_to_hex(oid), path);
@@ -355,7 +366,9 @@ static void write_standin_files(struct pair_entry *entry,
 		write_file_in_directory(rdir, rdir_len, entry->path, entry->right);
 }
 
-static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
+static int run_dir_diff(struct repository *repo,
+			struct difftool_state *dt_state,
+			const char *extcmd, const char *prefix,
 			struct child_process *child)
 {
 	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
@@ -375,7 +388,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct hashmap symlinks2 = HASHMAP_INIT(pair_cmp, NULL);
 	struct hashmap_iter iter;
 	struct pair_entry *entry;
-	struct index_state wtindex = INDEX_STATE_INIT(the_repository);
+	struct index_state wtindex = INDEX_STATE_INIT(repo);
 	struct checkout lstate, rstate;
 	int err = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -383,7 +396,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct hashmap tmp_modified = HASHMAP_INIT(path_entry_cmp, NULL);
 	int indices_loaded = 0;
 
-	workdir = repo_get_work_tree(the_repository);
+	workdir = repo_get_work_tree(repo);
 
 	/* Setup temp directories */
 	tmp = getenv("TMPDIR");
@@ -438,8 +451,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			       "not supported in\n"
 			       "directory diff mode ('-d' and '--dir-diff')."));
 
-		if (parse_index_info(info.buf, &lmode, &rmode, &loid, &roid,
-				     &status))
+		if (parse_index_info(repo, info.buf, &lmode, &rmode, &loid, &roid, &status))
 			break;
 		if (strbuf_getline_nul(&lpath, fp))
 			break;
@@ -469,13 +481,13 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		}
 
 		if (S_ISLNK(lmode)) {
-			char *content = get_symlink(&loid, src_path);
+			char *content = get_symlink(repo, dt_state, &loid, src_path);
 			add_left_or_right(&symlinks2, src_path, content, 0);
 			free(content);
 		}
 
 		if (S_ISLNK(rmode)) {
-			char *content = get_symlink(&roid, dst_path);
+			char *content = get_symlink(repo, dt_state, &roid, dst_path);
 			add_left_or_right(&symlinks2, dst_path, content, 1);
 			free(content);
 		}
@@ -500,7 +512,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			}
 			hashmap_add(&working_tree_dups, &entry->entry);
 
-			if (!use_wt_file(workdir, dst_path, &roid)) {
+			if (!use_wt_file(repo, workdir, dst_path, &roid)) {
 				if (checkout_path(rmode, &roid, dst_path,
 						  &rstate)) {
 					ret = error("could not write '%s'",
@@ -528,7 +540,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 					goto finish;
 				}
 				add_path(&wtdir, wtdir_len, dst_path);
-				if (symlinks) {
+				if (dt_state->symlinks) {
 					if (symlink(wtdir.buf, rdir.buf)) {
 						ret = error_errno("could not symlink '%s' to '%s'", wtdir.buf, rdir.buf);
 						goto finish;
@@ -614,7 +626,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		if (lstat(rdir.buf, &st))
 			continue;
 
-		if ((symlinks && S_ISLNK(st.st_mode)) || !S_ISREG(st.st_mode))
+		if ((dt_state->symlinks && S_ISLNK(st.st_mode)) || !S_ISREG(st.st_mode))
 			continue;
 
 		if (!indices_loaded) {
@@ -626,9 +638,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 				ret = error("could not write %s", buf.buf);
 				goto finish;
 			}
-			changed_files(&wt_modified, buf.buf, workdir);
+			changed_files(repo, &wt_modified, buf.buf, workdir);
 			strbuf_setlen(&rdir, rdir_len);
-			changed_files(&tmp_modified, buf.buf, rdir.buf);
+			changed_files(repo, &tmp_modified, buf.buf, rdir.buf);
 			add_path(&rdir, rdir_len, name);
 			indices_loaded = 1;
 		}
@@ -702,11 +714,15 @@ static int run_file_diff(int prompt, const char *prefix,
 int cmd_difftool(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
-	int use_gui_tool = -1, dir_diff = 0, prompt = -1, symlinks = 0,
-	    tool_help = 0, no_index = 0;
+	int use_gui_tool = -1, dir_diff = 0, prompt = -1, tool_help = 0, no_index = 0;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
+	struct difftool_state dt_state = {
+		.has_symlinks = 1,
+		.symlinks = 1,
+		.trust_exit_code = 0
+	};
 	struct option builtin_difftool_options[] = {
 		OPT_BOOL('g', "gui", &use_gui_tool,
 			 N_("use `diff.guitool` instead of `diff.tool`")),
@@ -717,14 +733,14 @@ int cmd_difftool(int argc,
 			0, PARSE_OPT_NONEG),
 		OPT_SET_INT_F(0, "prompt", &prompt, NULL,
 			1, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
-		OPT_BOOL(0, "symlinks", &symlinks,
+		OPT_BOOL(0, "symlinks", &dt_state.symlinks,
 			 N_("use symlinks in dir-diff mode")),
 		OPT_STRING('t', "tool", &difftool_cmd, N_("tool"),
 			   N_("use the specified diff tool")),
 		OPT_BOOL(0, "tool-help", &tool_help,
 			 N_("print a list of diff tools that may be used with "
 			    "`--tool`")),
-		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
+		OPT_BOOL(0, "trust-exit-code", &dt_state.trust_exit_code,
 			 N_("make 'git-difftool' exit when an invoked diff "
 			    "tool returns a non-zero exit code")),
 		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
@@ -734,8 +750,9 @@ int cmd_difftool(int argc,
 	};
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	git_config(difftool_config, NULL);
-	symlinks = has_symlinks;
+	if (repo)
+		repo_config(repo, difftool_config, &dt_state);
+	dt_state.symlinks = dt_state.has_symlinks;
 
 	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
 			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN_OPT |
@@ -749,8 +766,8 @@ int cmd_difftool(int argc,
 
 	if (!no_index){
 		setup_work_tree();
-		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(the_repository)), 1);
-		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(the_repository)), 1);
+		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(repo)), 1);
+		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(repo)), 1);
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
@@ -783,7 +800,7 @@ int cmd_difftool(int argc,
 	}
 
 	setenv("GIT_DIFFTOOL_TRUST_EXIT_CODE",
-	       trust_exit_code ? "true" : "false", 1);
+	       dt_state.trust_exit_code ? "true" : "false", 1);
 
 	/*
 	 * In directory diff mode, 'git-difftool--helper' is called once
@@ -799,6 +816,6 @@ int cmd_difftool(int argc,
 	strvec_pushv(&child.args, argv);
 
 	if (dir_diff)
-		return run_dir_diff(extcmd, symlinks, prefix, &child);
+		return run_dir_diff(repo, &dt_state, extcmd, prefix, &child);
 	return run_file_diff(prompt, prefix, &child);
 }
-- 
2.48.1.437.g11abf3cdc8

