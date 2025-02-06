Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93246BF
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 04:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738815616; cv=none; b=S/NSTQ6v2chQXth0ryEjtX28OdCI3H07LrNfWD7FIar+0UolCp54v5IPgoE7pq9WdiAKE8ZaR2d8gfy00iuzWYELpBLVgAv+7vfpgvvLlWIW5Tyf4/HCZ4+HnPexrqetpWa0ZSllcg6A9oQrNmGjX76rT7rk9JKLr0d9hVgrFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738815616; c=relaxed/simple;
	bh=cV0IG1531Qdul9tGxMibARyOuYzM/quZBYdQzCHdx+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9Wdpa+/q23COd0ZNiiGXp10hwcBoCZEH+nil83Og3bGuhoatShbYRm+cozG8zi2ezZhkAo9f/IvYebHxzoBhD8PBQBVszNN0BaGcIzEiJsYQ2Wh4g65HCyiIkICw0Mn+pp9abwIK9eZ45FGsP38KMWOx5FHuY50jlgPdilIB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSNABhFP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSNABhFP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f3c119fe6so570945ad.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 20:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738815614; x=1739420414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IF+HkbO76EORDYaxAwvziXpXpimHkSHw/ZIRdNlFzt0=;
        b=FSNABhFPruyvFFUnOLDoByvT7W6/9OSpTRe7q0CZIxBwbywul2OzKfgc+wfjem8mI+
         t84qxT3PVlDyWYLSw1MsZCnkWZDqaNAlY1Hf5Tt3t+HgDlZHm5vybRChaOEJWFzj1LoS
         hnRHTRGGhL4FKu6eLqkDBTETMEdjWtaSLO2J8UcMkGf167rQidNMeeZKktPzyaEJ7j9b
         ziOXaR1koo/87wrIbLjCy9k22uGBwx6xrFZ9XicZZ64WXDIf5Fj04WF5jmLNGZbTn2ms
         3zrXG3IH/gozguYGKBUuzrQyhfq3q9KgwYD7BgSQhhOXuUlettoZlXjwiqJLcJPlt4/t
         1peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738815614; x=1739420414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IF+HkbO76EORDYaxAwvziXpXpimHkSHw/ZIRdNlFzt0=;
        b=ABAW5NqegqpVNhf3SG9QwNK9Rbwo18N3oXrtyGPyxZI8Q/2ZqH58Bx0rlZZevnf3g7
         2i0FzaQAkj1wq9qt83Ufdb0P3G1U9ZVNbGxPbFLk7e1QuNC+k3Nj62IInkAvaQfAcT44
         mAhnqFysae8w5Fn7OzmGTt720heyaWqQvLHZGDZ6bmHODMXklVf2pxe0XmA5ipCsSR1E
         suKgDynTZhBu8MghBKKux4S4QdRl9+tShz3sbfc/vScMDCFpUmr1N0i1WhnssZevDwcH
         Wtz8UNQlRi+C//Cv6d1n7hNPEMzDkYBGzJewVdqJJyLs3jP3sEcsOF3aIYjiMgWTYpq+
         jZQQ==
X-Gm-Message-State: AOJu0YwpyBl2gB43tgNzEllqL1pxdkHSSDgTkjNUeQJPAj9asSxDoMa7
	p8UfZMF0DIkZIjA7PUAvkSSOd/TA03/BQgbi7q8DuE2Bkk1lUNhGAXCdfA==
X-Gm-Gg: ASbGncscjGKwxbUaGdk8CTUHlbqah0H5EWlAr/jCwEqjo40nLYNfZJ2vAGkxUsSWV24
	jWCJvm4w3Tnk4HNwpkrgC9Md8kKUNmkLFeA8lSjGYcDDX6Km3wW0HTNIK29K+/kOa389xBu3qGR
	e/T6TlKUO+YGat3XJgy4FNcnjt7AUweU0drFrjcYsxea92kczazBBP0XeQ3wonJ5gu+qirRDVK5
	t2BjGrolMk19zyKA70/QLXpra6/pM0HYfaKVfrkklzFNM84a7YcJD6tr5PZaffCkX0QGoT0q4G+
	YGsDctUtMzpr5ssCxsEE5asPrQ==
X-Google-Smtp-Source: AGHT+IGCoAqnt60RE+Uy1qs2DqJjf+E8tJbR/V6CLXJM291Pmh+4V8sHD73ZXRb7MkygQPidUYTOgQ==
X-Received: by 2002:a17:903:22cd:b0:21f:dbb:20a6 with SMTP id d9443c01a7336-21f17ef0184mr90642315ad.33.1738815614169;
        Wed, 05 Feb 2025 20:20:14 -0800 (PST)
Received: from localhost.localdomain ([172.56.121.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e63fsm2384045ad.41.2025.02.05.20.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 20:20:13 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 1/3] difftool: eliminate use of global variables
Date: Wed,  5 Feb 2025 20:20:08 -0800
Message-ID: <20250206042010.865947-1-davvid@gmail.com>
X-Mailer: git-send-email 2.48.1.461.g612e419e04
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move difftool's global variables into a difftools_option struct
in preparation for removal of USE_THE_REPOSITORY_VARIABLE.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c | 51 ++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 03a8bb92a9..0b6b92aee0 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -36,18 +36,27 @@
 #include "entry.h"
 #include "setup.h"
 
-static int trust_exit_code;
-
 static const char *const builtin_difftool_usage[] = {
 	N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]"),
 	NULL
 };
 
+struct difftool_options {
+	int has_symlinks;
+	int symlinks;
+	int trust_exit_code;
+};
+
 static int difftool_config(const char *var, const char *value,
 			   const struct config_context *ctx, void *cb)
 {
+	struct difftool_options *dt_options = (struct difftool_options *)cb;
 	if (!strcmp(var, "difftool.trustexitcode")) {
-		trust_exit_code = git_config_bool(var, value);
+		dt_options->trust_exit_code = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "core.symlinks")) {
+		dt_options->has_symlinks = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -291,13 +300,14 @@ static int ensure_leading_directories(char *path)
  * to compare the readlink(2) result as text, even on a filesystem that is
  * capable of doing a symbolic link.
  */
-static char *get_symlink(const struct object_id *oid, const char *path)
+static char *get_symlink(struct difftool_options *dt_options,
+			 const struct object_id *oid, const char *path)
 {
 	char *data;
 	if (is_null_oid(oid)) {
 		/* The symlink is unknown to Git so read from the filesystem */
 		struct strbuf link = STRBUF_INIT;
-		if (has_symlinks) {
+		if (dt_options->has_symlinks) {
 			if (strbuf_readlink(&link, path, strlen(path)))
 				die(_("could not read symlink %s"), path);
 		} else if (strbuf_read_file(&link, path, 128))
@@ -355,7 +365,8 @@ static void write_standin_files(struct pair_entry *entry,
 		write_file_in_directory(rdir, rdir_len, entry->path, entry->right);
 }
 
-static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
+static int run_dir_diff(struct difftool_options *dt_options,
+			const char *extcmd, const char *prefix,
 			struct child_process *child)
 {
 	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
@@ -469,13 +480,13 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		}
 
 		if (S_ISLNK(lmode)) {
-			char *content = get_symlink(&loid, src_path);
+			char *content = get_symlink(dt_options, &loid, src_path);
 			add_left_or_right(&symlinks2, src_path, content, 0);
 			free(content);
 		}
 
 		if (S_ISLNK(rmode)) {
-			char *content = get_symlink(&roid, dst_path);
+			char *content = get_symlink(dt_options, &roid, dst_path);
 			add_left_or_right(&symlinks2, dst_path, content, 1);
 			free(content);
 		}
@@ -528,7 +539,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 					goto finish;
 				}
 				add_path(&wtdir, wtdir_len, dst_path);
-				if (symlinks) {
+				if (dt_options->symlinks) {
 					if (symlink(wtdir.buf, rdir.buf)) {
 						ret = error_errno("could not symlink '%s' to '%s'", wtdir.buf, rdir.buf);
 						goto finish;
@@ -614,7 +625,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		if (lstat(rdir.buf, &st))
 			continue;
 
-		if ((symlinks && S_ISLNK(st.st_mode)) || !S_ISREG(st.st_mode))
+		if ((dt_options->symlinks && S_ISLNK(st.st_mode)) || !S_ISREG(st.st_mode))
 			continue;
 
 		if (!indices_loaded) {
@@ -704,9 +715,13 @@ int cmd_difftool(int argc,
 		 const char *prefix,
 		 struct repository *repo UNUSED)
 {
-	int use_gui_tool = -1, dir_diff = 0, prompt = -1, symlinks = 0,
-	    tool_help = 0, no_index = 0;
+	int use_gui_tool = -1, dir_diff = 0, prompt = -1, tool_help = 0, no_index = 0;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
+	struct difftool_options dt_options = {
+		.has_symlinks = 1,
+		.symlinks = 1,
+		.trust_exit_code = 0
+	};
 	struct option builtin_difftool_options[] = {
 		OPT_BOOL('g', "gui", &use_gui_tool,
 			 N_("use `diff.guitool` instead of `diff.tool`")),
@@ -717,14 +732,14 @@ int cmd_difftool(int argc,
 			0, PARSE_OPT_NONEG),
 		OPT_SET_INT_F(0, "prompt", &prompt, NULL,
 			1, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
-		OPT_BOOL(0, "symlinks", &symlinks,
+		OPT_BOOL(0, "symlinks", &dt_options.symlinks,
 			 N_("use symlinks in dir-diff mode")),
 		OPT_STRING('t', "tool", &difftool_cmd, N_("tool"),
 			   N_("use the specified diff tool")),
 		OPT_BOOL(0, "tool-help", &tool_help,
 			 N_("print a list of diff tools that may be used with "
 			    "`--tool`")),
-		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
+		OPT_BOOL(0, "trust-exit-code", &dt_options.trust_exit_code,
 			 N_("make 'git-difftool' exit when an invoked diff "
 			    "tool returns a non-zero exit code")),
 		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
@@ -734,8 +749,8 @@ int cmd_difftool(int argc,
 	};
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	git_config(difftool_config, NULL);
-	symlinks = has_symlinks;
+	git_config(difftool_config, &dt_options);
+	dt_options.symlinks = dt_options.has_symlinks;
 
 	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
 			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN_OPT |
@@ -783,7 +798,7 @@ int cmd_difftool(int argc,
 	}
 
 	setenv("GIT_DIFFTOOL_TRUST_EXIT_CODE",
-	       trust_exit_code ? "true" : "false", 1);
+	       dt_options.trust_exit_code ? "true" : "false", 1);
 
 	/*
 	 * In directory diff mode, 'git-difftool--helper' is called once
@@ -799,6 +814,6 @@ int cmd_difftool(int argc,
 	strvec_pushv(&child.args, argv);
 
 	if (dir_diff)
-		return run_dir_diff(extcmd, symlinks, prefix, &child);
+		return run_dir_diff(&dt_options, extcmd, prefix, &child);
 	return run_file_diff(prompt, prefix, &child);
 }
-- 
2.48.1.461.g612e419e04

