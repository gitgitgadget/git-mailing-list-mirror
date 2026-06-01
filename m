Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F583DD862
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327310; cv=none; b=nhZpD7t2Soo5FO7Uloh6srTxGRe7PYLqUdvbXUymXBPZAfgydpPx3uRohnK/TuOLPzu8NT41Wa6709z6kt6HS1uLbr0JKqTJsxh9TGdl3T6C26bO587Cj9BtSGtV7WX29xyKTzfuG5M7xQUpzOwCKQWia3tL1ih5HidO5UeSYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327310; c=relaxed/simple;
	bh=sFbUFDV7qABcyftE7fVHSBefugqeM7x8hJww3wYRWTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c14grsTFo+xRGe1qqUUPi1KAzA7BvtiCqAQzlytWwgZ4ciU4eU+fLU6/eCiyjegBQRua2uWC1xf01TxW39GHwBHjDDdcDINPr2wn/l04cEZ489ls/qre1rER4yVxvlNf3Q9ArVGpBZ4jWTENvm4uQ9Xdpl+EbKh+eVOkH8H27Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrM7uYuP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrM7uYuP"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8424b6792efso310774b3a.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327307; x=1780932107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkn+3fRqgazSK/rcSVuIevinMtrJOlI0HVd9jaflYLI=;
        b=NrM7uYuPXoP7YEFhz9dexKKv9Xb62zotHaL/MgA3dM67ZWpIm1edDDWbd81VfCKbeA
         yBYaobAuXrzRqrGduyjvnn9wInX3i4nvF5zR66vImv9a0MhCOzULPKUaUiwC2ZasQQPp
         ahc4kxysRJat5JZ2F7F7IWlhoVGtrFmrdVkaVG9gtfrwE/5+LPVvWoJXXzKdSA0EGAM6
         meblykU5JSOWcRPPyttaRMpgzHoJnl9RA4ZaMdD7og5VVo0OJ605mnJ+Tiyzejm0qXjr
         Yjw2RzUQ3mjrrRQpdVGAHEnsAvyp8w4NgAO8EtYH9IUiDilkxIQod2Omcu0FsLxDUC1X
         WcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327307; x=1780932107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tkn+3fRqgazSK/rcSVuIevinMtrJOlI0HVd9jaflYLI=;
        b=bxMDkYgLbIEcbTjhYfZnMAo+H4+HWBHe3I6gXa51iV7fqQ5aIS+EYj4HsxnlLOAmfW
         OFbsXGW0KUSAY9vEhcwzr+qiIEj32ymNVMvI3pk5svbEGNw8Xi4kuc8D4nibFMQFwsud
         9dCyXBQ5s8z68YnqUrWE1d011p+6/2VLfQYCyMtO0evU3XuQH4YL2wqxymww2tF1+AQr
         dRYW5u1JKAvO2rCyviIE3haX/QhjIuqSuK7nPZEbGgX6uuIylRRBpA3s2OSaIzjrDYvN
         1lL6gKFUHrbn39JB/ol1gVfldVB9px7wzkI3ZCu8m8Z3c6RqamLpYRMOP5gEue04a66z
         7f3A==
X-Gm-Message-State: AOJu0YwPu7PCPkzvlJGepyoDGsEj5cGXiF0Nlo+9eFdM+arKclR5xE5a
	DaWgA+9RzyqkqxoTU9is9SWoe5DgtMWA6loeg8Rc4DaNzWz6NXspFjtUrYZJ3g==
X-Gm-Gg: Acq92OEYICZRSNUCPvdzZbEJ+6q8lgCgOiTxsPji5lOFKiDonhXPRFRR0B/GRXiquNV
	LQEVQrUsrK3xS5JvfT/brMfGMox4QCCgUjCaGiffzoNUsaYFHJ7MVq0aAC8/HeKoimdM3/mo/kp
	LscCCPVgXoAUfhc1IOYzAQtOPwK/S9cJnnJifUNbD/+BX7LeDa/QqqYINZF3A7pmf68+/uQhB+R
	TgMk0+lugRwTNIpkzEOyoXpUzq4fslSj11wiuP0g4HijGFU4FYmfFYrGJviyB2MYQOmYbV4fiOu
	g+2Tbvzz+7+hK8ldOv9AnJRFlPPNuIaXFwaCL6Yi3BnI6Is4DEpuiylRBGi/OU437Lt2X6Bjnpz
	JqcBOab0eV8ZVQgDRV96CUAVk7ybxGNpsNKw8peJAYzmIqN1+7k1LgO3J1/n2R0f16CyZYLFF+0
	8dzefLPc7R1xxD8/y0QY7K3y3MDZQIywbm/x1Q2R0j29gdz2U1OWVphXyMbQUYprj4oMYk9Exot
	dowE9G0qoSVmEXrIz9unxvrf+lc9foPPbOFgKBvk8d1
X-Received: by 2002:a05:6a00:429a:b0:831:7f71:c810 with SMTP id d2e1a72fcca58-84225760e14mr10857121b3a.35.1780327306645;
        Mon, 01 Jun 2026 08:21:46 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm7352779b3a.12.2026.06.01.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:21:46 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC][PATCH 2/4] rev-parse: use strbuf_add_path for path formatting
Date: Mon,  1 Jun 2026 20:49:48 +0530
Message-ID: <20260601151950.30686-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the core path-formatting logic has been abstracted into
strbuf_add_path() inside path.c, remove the duplicate localized
implementation from builtin/rev-parse.c.

Drop the local format_type and default_type enums from the builtin, and
update print_path() to act as a light wrapper around the new shared
strbuf engine. Update cmd_rev_parse() to use the new path_ format and
default enum types exposed via path.h.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/rev-parse.c | 100 ++++++++++----------------------------------
 1 file changed, 21 insertions(+), 79 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 218b5f34d6..812cfd55ad 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -632,73 +632,15 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
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
+		       enum path_format_type format, enum path_default_type def)
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
+
+	strbuf_add_path(&sb, path, prefix, format, def);
+	puts(sb.buf);
+
+	strbuf_release(&sb);
 }
 
 int cmd_rev_parse(int argc,
@@ -717,7 +659,7 @@ int cmd_rev_parse(int argc,
 	const char *name = NULL;
 	struct strbuf buf = STRBUF_INIT;
 	int seen_end_of_options = 0;
-	enum format_type format = FORMAT_DEFAULT;
+	enum path_format_type format = PATH_FORMAT_DEFAULT;
 
 	show_usage_if_asked(argc, argv, builtin_rev_parse_usage);
 
@@ -798,7 +740,7 @@ int cmd_rev_parse(int argc,
 				print_path(repo_git_path_replace(the_repository, &buf,
 								 "%s", argv[i + 1]), prefix,
 						format,
-						DEFAULT_RELATIVE_IF_SHARED);
+						PATH_DEFAULT_RELATIVE_IF_SHARED);
 				i++;
 				continue;
 			}
@@ -820,9 +762,9 @@ int cmd_rev_parse(int argc,
 				if (!arg)
 					die(_("--path-format requires an argument"));
 				if (!strcmp(arg, "absolute")) {
-					format = FORMAT_CANONICAL;
+					format = PATH_FORMAT_CANONICAL;
 				} else if (!strcmp(arg, "relative")) {
-					format = FORMAT_RELATIVE;
+					format = PATH_FORMAT_RELATIVE;
 				} else {
 					die(_("unknown argument to --path-format: %s"), arg);
 				}
@@ -985,7 +927,7 @@ int cmd_rev_parse(int argc,
 			if (!strcmp(arg, "--show-toplevel")) {
 				const char *work_tree = repo_get_work_tree(the_repository);
 				if (work_tree)
-					print_path(work_tree, prefix, format, DEFAULT_UNMODIFIED);
+					print_path(work_tree, prefix, format, PATH_DEFAULT_UNMODIFIED);
 				else
 					die(_("this operation must be run in a work tree"));
 				continue;
@@ -993,7 +935,7 @@ int cmd_rev_parse(int argc,
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
 				struct strbuf superproject = STRBUF_INIT;
 				if (get_superproject_working_tree(&superproject))
-					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
+					print_path(superproject.buf, prefix, format, PATH_DEFAULT_UNMODIFIED);
 				strbuf_release(&superproject);
 				continue;
 			}
@@ -1028,18 +970,18 @@ int cmd_rev_parse(int argc,
 				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 				char *cwd;
 				int len;
-				enum format_type wanted = format;
+				enum path_format_type wanted = format;
 				if (arg[2] == 'g') {	/* --git-dir */
 					if (gitdir) {
-						print_path(gitdir, prefix, format, DEFAULT_UNMODIFIED);
+						print_path(gitdir, prefix, format, PATH_DEFAULT_UNMODIFIED);
 						continue;
 					}
 					if (!prefix) {
-						print_path(".git", prefix, format, DEFAULT_UNMODIFIED);
+						print_path(".git", prefix, format, PATH_DEFAULT_UNMODIFIED);
 						continue;
 					}
 				} else {		/* --absolute-git-dir */
-					wanted = FORMAT_CANONICAL;
+					wanted = PATH_FORMAT_CANONICAL;
 					if (!gitdir && !prefix)
 						gitdir = ".git";
 					if (gitdir) {
@@ -1055,11 +997,11 @@ int cmd_rev_parse(int argc,
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "%s%s.git", cwd, len && cwd[len-1] != '/' ? "/" : "");
 				free(cwd);
-				print_path(buf.buf, prefix, wanted, DEFAULT_CANONICAL);
+				print_path(buf.buf, prefix, wanted, PATH_DEFAULT_CANONICAL);
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				print_path(repo_get_common_dir(the_repository), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
+				print_path(repo_get_common_dir(the_repository), prefix, format, PATH_DEFAULT_RELATIVE_IF_SHARED);
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
@@ -1089,7 +1031,7 @@ int cmd_rev_parse(int argc,
 				if (the_repository->index->split_index) {
 					const struct object_id *oid = &the_repository->index->split_index->base_oid;
 					const char *path = repo_git_path_replace(the_repository, &buf, "sharedindex.%s", oid_to_hex(oid));
-					print_path(path, prefix, format, DEFAULT_RELATIVE);
+					print_path(path, prefix, format, PATH_DEFAULT_RELATIVE);
 				}
 				continue;
 			}
-- 
2.54.0

