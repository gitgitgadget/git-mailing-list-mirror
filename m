Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B2367F26
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677090; cv=none; b=WZDTwi8F8G0FyAFAzse2+wJT6FP1GoUHp66p4NDIY99IzxSg7Kk7OCa0YKGwf9zJn9T8f3hOgVWO6svrSjRYjZe0BW25EQuSG/9Y3nmmLcpj5m3iFjNmK2c7HToJEDETQQk2EgdeeC22PPF/gb2HuJB5cfcZOe29N0tcl34+KF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677090; c=relaxed/simple;
	bh=ekYcdapelQc9ySE6dCt+JUUcd+bju6gFsKaRi/VSlJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbIOw4rklZqfq3+7pypZtIlhtVN73zU+Ob7o8cvUQTtnwg1Z01rjDDtw6Gb/jriHjYvA7HlEeLovdGaW1LVHYbOQCzHlF2XwVmTH03vs/RQmS6df6hqVqzwNNwKkIuJxuzO4yKL8m+RG3BJRgwLTswC40WcWhy85i4g9DUqYCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APuXFcwT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APuXFcwT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so14842995ad.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780677083; x=1781281883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohXKg64+ZXvhImiILJg5Jh2R/qYUT00CVZKpeObZrlo=;
        b=APuXFcwTtowzlcPhnNcGP0qZJuoiAvuAkkQjJG9QcxhzCoHQRyQEC720n2F9isHQmA
         Tz66tqUmmPJ3wsYH4ubZAMGDHq7jrNlPslUgz0m8xQBQPwnrHoQkZgwFkA+CD2w+jnH1
         mjcNJ3mPC9pmB8NOsv0RfKwfo5ZCMH8wLiSQokZfgRWPUhih8FpRNizLcn0LaruYGlC9
         //qjPC6HeftJCIoIK7xqV1l+eNsKkZVGGT/7O54NzkoKHWECkPWG2UCR9XoYT9rKUKkq
         oBY9KVC9CJyOUQDCR27cUsiyoKNIqria8+1NmLTk8nhR97k7lsrfXtdMQXlY/VzE+aIP
         sA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677083; x=1781281883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ohXKg64+ZXvhImiILJg5Jh2R/qYUT00CVZKpeObZrlo=;
        b=P41oi0BGiru8V6aYvs0AOz/odmfFiNc53p3/GqAFMUv/3fKpU2vjyTYyz5yf+zzsiP
         AfAIJtfEUelB46W28pZkreUIZVCButk6Uzrx/2z/vZMFDlJpPV9P4OemBcxpAiEqSqzL
         GT8niAPt+Klqoo2nnvjzXA3Of4GqpT/6EP9Y4lFbhLrHwaTXLrYqPXb3ufatKRex7/Qc
         FcBsN6SfPo+vW2j8443ehurTTG/kra2HR5JWz5s69+8YBx01GueaSbUmJfmuA7I8bURw
         +PySYsvLBBhtyKwju+GLsocxUvlNZxyHnb0+9OleUP249ZRGfa3t3RmrCyGWXnPmIKV5
         LP8w==
X-Gm-Message-State: AOJu0YwOFYwufA3m9M5Uu6YteDXtxOI8EPI5sMlHnlhdUDs5HoEZpn1+
	WDCMmiWqPIKKolHUFTlrimxhJLB13oInkPy/wCHXKQNoPKs7fWeqnhzEs9EwEw==
X-Gm-Gg: Acq92OGjjIrS9ZBRXu/C0KaGddBVTXzWQxyn8NW2LNBhTw/occVpK/LA6bOp5wiEhsA
	qPU1+cWGCo/Tr4Ln/k0D+5RMwuKhgZs7nyPAyR4GdOZmMzCkDetT1b3BrA9/e3koelW71U7R8PA
	7XGpsSCQX8+Fv7gRShi/TL0RAhM1TLfh5FTqln2wNyGRsabV5ifCYss5Q/lUnAuZEX48eTtnSil
	U/YKowA6oWQUVqD7yVEMvZCbq6xxHwPJTxQcBz4FIfBOrbDqn0yaizw6KMU/FGC0eR8DRq5/sgI
	y4P9lsgdgV+rdbo75vQcAFdWe96vf5jg0WSaZrU7VNpjVEGYbCU0e9PH0rQuUegNle9+a50IOzp
	EBaRUmgIoI4pJ3UMHXkhxEu4NEzzUQwLGBDRisXlgQL4woApc+xXtTGLuKWPCo/YcBqSqDcWku+
	Xxk32HVM16faDmjqTEfmg8o9hykp9kREsYL2tJwNixbnQ2Aov+mfsE27Qn6k3eiigLiWzX3qiih
	zNDhLJhqhdy9NvLDtm2q3N3yZYWjzeRx84KKbXVUlJc
X-Received: by 2002:a17:903:2388:b0:2bf:1cda:29ce with SMTP id d9443c01a7336-2c1e7b4003emr50410785ad.6.1780677082456;
        Fri, 05 Jun 2026 09:31:22 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm95883955ad.20.2026.06.05.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:31:21 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jayatheerthkulkarni2005@gmail.com,
	a3205153416@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC PATCH v2 2/4] rev-parse: use format_path for path formatting
Date: Fri,  5 Jun 2026 22:00:10 +0530
Message-ID: <20260605163012.181089-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the core path-formatting logic has been abstracted into
format_path() inside path.c, remove the localized duplicate formatting
mechanics from builtin/rev-parse.c.

Drop the usage of the old local format_type and default_type enums,
and update print_path() to act as a light wrapper around the new shared
engine. Resolve user-provided formatting flags directly within rev-parse
to pass the final determined path_format to format_path().

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/rev-parse.c | 103 ++++++++++----------------------------------
 1 file changed, 23 insertions(+), 80 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 218b5f34d6..c78bdc04c1 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -632,73 +632,16 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
 	clear_ref_exclusions(&ref_excludes);
 }
 
-enum format_type {
-	/* We would like a relative path. */
-	FORMAT_RELATIVE,
-	/* We would like a canonical absolute path. */
-	FORMAT_CANONICAL,
-	/* We would like the default behavior. */
-	FORMAT_DEFAULT,
-};
-
-enum default_type {
-	/* Our default is a relative path. */
-	DEFAULT_RELATIVE,
-	/* Our default is a relative path if there's a shared root. */
-	DEFAULT_RELATIVE_IF_SHARED,
-	/* Our default is a canonical absolute path. */
-	DEFAULT_CANONICAL,
-	/* Our default is not to modify the item. */
-	DEFAULT_UNMODIFIED,
-};
-
-static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
+static void print_path(const char *path, const char *prefix,
+		       int arg_path_format, enum path_format def_format)
 {
-	char *cwd = NULL;
-	/*
-	 * We don't ever produce a relative path if prefix is NULL, so set the
-	 * prefix to the current directory so that we can produce a relative
-	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
-	 * we want an absolute path unless the two share a common prefix, so don't
-	 * set it in that case, since doing so causes a relative path to always
-	 * be produced if possible.
-	 */
-	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
-		prefix = cwd = xgetcwd();
-	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
-		puts(path);
-	} else if (format == FORMAT_RELATIVE ||
-		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE)) {
-		/*
-		 * In order for relative_path to work as expected, we need to
-		 * make sure that both paths are absolute paths.  If we don't,
-		 * we can end up with an unexpected absolute path that the user
-		 * didn't want.
-		 */
-		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
-		if (!is_absolute_path(path)) {
-			strbuf_realpath_forgiving(&realbuf, path,  1);
-			path = realbuf.buf;
-		}
-		if (!is_absolute_path(prefix)) {
-			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
-			prefix = prefixbuf.buf;
-		}
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
-		strbuf_release(&realbuf);
-		strbuf_release(&prefixbuf);
-	} else if (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED) {
-		struct strbuf buf = STRBUF_INIT;
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
-	} else {
-		struct strbuf buf = STRBUF_INIT;
-		strbuf_realpath_forgiving(&buf, path, 1);
-		puts(buf.buf);
-		strbuf_release(&buf);
-	}
-	free(cwd);
+	struct strbuf sb = STRBUF_INIT;
+	enum path_format fmt = (arg_path_format != -1) ? arg_path_format : def_format;
+
+	format_path(&sb, path, prefix, fmt);
+	puts(sb.buf);
+
+	strbuf_release(&sb);
 }
 
 int cmd_rev_parse(int argc,
@@ -717,7 +660,7 @@ int cmd_rev_parse(int argc,
 	const char *name = NULL;
 	struct strbuf buf = STRBUF_INIT;
 	int seen_end_of_options = 0;
-	enum format_type format = FORMAT_DEFAULT;
+	int arg_path_format = -1;
 
 	show_usage_if_asked(argc, argv, builtin_rev_parse_usage);
 
@@ -797,8 +740,8 @@ int cmd_rev_parse(int argc,
 					die(_("--git-path requires an argument"));
 				print_path(repo_git_path_replace(the_repository, &buf,
 								 "%s", argv[i + 1]), prefix,
-						format,
-						DEFAULT_RELATIVE_IF_SHARED);
+						arg_path_format,
+						PATH_FORMAT_RELATIVE_IF_SHARED);
 				i++;
 				continue;
 			}
@@ -820,9 +763,9 @@ int cmd_rev_parse(int argc,
 				if (!arg)
 					die(_("--path-format requires an argument"));
 				if (!strcmp(arg, "absolute")) {
-					format = FORMAT_CANONICAL;
+					arg_path_format = PATH_FORMAT_CANONICAL;
 				} else if (!strcmp(arg, "relative")) {
-					format = FORMAT_RELATIVE;
+					arg_path_format = PATH_FORMAT_RELATIVE;
 				} else {
 					die(_("unknown argument to --path-format: %s"), arg);
 				}
@@ -985,7 +928,7 @@ int cmd_rev_parse(int argc,
 			if (!strcmp(arg, "--show-toplevel")) {
 				const char *work_tree = repo_get_work_tree(the_repository);
 				if (work_tree)
-					print_path(work_tree, prefix, format, DEFAULT_UNMODIFIED);
+					print_path(work_tree, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
 				else
 					die(_("this operation must be run in a work tree"));
 				continue;
@@ -993,7 +936,7 @@ int cmd_rev_parse(int argc,
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
 				struct strbuf superproject = STRBUF_INIT;
 				if (get_superproject_working_tree(&superproject))
-					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
+					print_path(superproject.buf, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
 				strbuf_release(&superproject);
 				continue;
 			}
@@ -1028,18 +971,18 @@ int cmd_rev_parse(int argc,
 				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 				char *cwd;
 				int len;
-				enum format_type wanted = format;
+				int wanted = arg_path_format;
 				if (arg[2] == 'g') {	/* --git-dir */
 					if (gitdir) {
-						print_path(gitdir, prefix, format, DEFAULT_UNMODIFIED);
+						print_path(gitdir, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
 						continue;
 					}
 					if (!prefix) {
-						print_path(".git", prefix, format, DEFAULT_UNMODIFIED);
+						print_path(".git", prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
 						continue;
 					}
 				} else {		/* --absolute-git-dir */
-					wanted = FORMAT_CANONICAL;
+					wanted = PATH_FORMAT_CANONICAL;
 					if (!gitdir && !prefix)
 						gitdir = ".git";
 					if (gitdir) {
@@ -1055,11 +998,11 @@ int cmd_rev_parse(int argc,
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "%s%s.git", cwd, len && cwd[len-1] != '/' ? "/" : "");
 				free(cwd);
-				print_path(buf.buf, prefix, wanted, DEFAULT_CANONICAL);
+				print_path(buf.buf, prefix, wanted, PATH_FORMAT_CANONICAL);
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				print_path(repo_get_common_dir(the_repository), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
+				print_path(repo_get_common_dir(the_repository), prefix, arg_path_format, PATH_FORMAT_RELATIVE_IF_SHARED);
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
@@ -1089,7 +1032,7 @@ int cmd_rev_parse(int argc,
 				if (the_repository->index->split_index) {
 					const struct object_id *oid = &the_repository->index->split_index->base_oid;
 					const char *path = repo_git_path_replace(the_repository, &buf, "sharedindex.%s", oid_to_hex(oid));
-					print_path(path, prefix, format, DEFAULT_RELATIVE);
+					print_path(path, prefix, arg_path_format, PATH_FORMAT_RELATIVE);
 				}
 				continue;
 			}
-- 
2.54.0

