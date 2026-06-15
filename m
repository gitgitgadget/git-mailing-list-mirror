Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8E3A1DB
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499161; cv=none; b=jJkzhqAAQbqBkXxyWTinehs9p0OlSeuq8S9UaWPE9ewi9cv9WWS5f3SvpupolXzOl7aKB8oNbYrpXI0aWIavnQocH2zwWY+Yl0TWHIMQw9294nJBiFqZrD3qFTTR9kVwUtBN8VQ0G4bj4G0byjF4fWL3QvSeI91iOXuhZw36HZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499161; c=relaxed/simple;
	bh=TjG9fGnsOs1ovkLUIFQn2Psam4uxpH563BO48d69phA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtDyUWboAmvU49C1V7rfiS7V/FiQqRH9vNPythLu/9QGxuvxeORlJf/9Xu+KFM3iwM/ytxgbPXX9Z6SXsEViW9LEgAHypZKQ+p3Mi6JT+WR5YJnufm7uQkvZ5aDUwYTN5WR77r8L5OivEc5AxFI7YcyIMPveOSGzVhGlHGLw+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH+T2Z07; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH+T2Z07"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf1cda2b17so20287005ad.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781499159; x=1782103959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htzmQEkjSM0FFlZEOOvQaC8mdqHEyD4SJ/CSguRJNJA=;
        b=PH+T2Z07VCwEcB1dVrTEq6xYGqAMwnLHSLP8Z8tS+K76sey8hvweBtDjt09NjsG+sO
         GGWHemfkIh4a6adpQ9T70tdkt4QkTywHNe7jN4qYYjOQSddHmLJrm27OuUGGBcUo095M
         2ryM6AG+57exKbdYoY41EUR9oKDiX08r1F5hzJB0RILu9eylQHc5BH1YI3ToMTLuGLIK
         1XCYV+b91cSAy0JO36QfO4bFgoJBCrZEnhs4x8XjdP5pyuspIGHG+nNzhxX9cI3YCVbn
         0K0/dwT04teQ0ixbowIdtQKWv0u8OuoZZw2cpqX+1mse5CiIpligHey1f5lh9iGkzc//
         JmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781499159; x=1782103959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htzmQEkjSM0FFlZEOOvQaC8mdqHEyD4SJ/CSguRJNJA=;
        b=seeb4y0VCrNDOVc0Nr63I8po/IBJfqdZNyBRJnogFHsPRMMB6rPafQGfnopPkxZtAa
         DB4SN3GIh9b3wRIEkwZsw3U38S9HaBg2Vo2Zt1aCWzOoQ+bFFiwWwWervGx81CRtPqGG
         78svjzFvHP0PVlAHZnD2UIJVhm9jXCTs7OmLr+S+jZ1S7piYo/opCCy37Ooy6bcw8Gro
         EUpz0bEvtgS8Bzyy/TfFL46tCMnW6nRs6YJy4e58KlHxGvvPpd38EfryMtD2RG/y2ckG
         vmT4sHgTXksxsvh8nqr3VOK4KcUa2cQxBmB4zzLVkQSSUFvm42fLSYtxeoRpkAbo1Ip/
         lfgA==
X-Gm-Message-State: AOJu0YyoSXMwSK4jsFeYPMPiwFjJCR6I0GFwBm/aUT9yJoi1/nFRbndN
	g7umpn8/daDWYwOyPilU8gC6a6JJ727IiRWFUyc5mQP0aiO9kYE5pi8tXdN17A==
X-Gm-Gg: Acq92OHRIIDCeft30UhwjhHU6GZ6xvm+5VTL2AhirnwMzLVnJVq0MCHLZ4hDjfOTpOk
	fs0vTe4xjXbQj+ea0zVRbU5ZGA7AaJOlWUPEXB04dh+3w4abVjOsFnZhW/pXwF6/obNk5H/GIhD
	sb6RjYctLZisImV+BCUKNBX8t6m0s3U8JNcNQuOfFfurplUGuLSbqIu+1JoKpmnb/7qoINHVopO
	mWWMhFqImksZcNrL1PyqsYGn9es9ucovHl87EVtYVCEdQtiL9GWC3TPpLtBsLBJMBqTqZmdh58I
	gJITrGnB34ZKizufqIm2EddvGPNGXAjMPC6gE1JPjWOPgzpmOvioPBl9ZzXjV94JqIGiJ0u5KLs
	r68u3SZ4Az9JJW8F2sMrfzKyN0tvL3tZyP35M3FI6H5Co+7LxSn4wPGiQbQVR7TbbIlqp8CeVUx
	/cqHbuxmKV4ZpI6m7hRRZXoaCe7k770WBWikwo5m4QqArqaJB7GYZmomy5dsKtvP7SOjAOpGhPz
	S7osYWt9pHaefw9MAB6HPpCZ0vSm5w/nGaOwrUClEDm
X-Received: by 2002:a17:903:390d:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2c3fd132a29mr114980015ad.20.1781499159386;
        Sun, 14 Jun 2026 21:52:39 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a4c1fsm85528075ad.53.2026.06.14.21.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 21:52:38 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: a3205153416@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kristofferhaugsbakk@fastmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v4 2/4] rev-parse: use append_formatted_path() for path formatting
Date: Mon, 15 Jun 2026 10:21:10 +0530
Message-ID: <20260615045112.50686-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that path formatting logic lives in a shared helper, keeping a
duplicate implementation in rev-parse is unnecessary and risks the
two diverging over time.

Replace the local format_type and default_type enums and the
hand-rolled formatting logic with a call to append_formatted_path().
Introduce PATH_FORMAT_DEFAULT as the initial value of arg_path_format
so that per-path fallback behavior is resolved in print_path() rather
than leaked into the shared helper.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/rev-parse.c | 103 ++++++++++----------------------------------
 1 file changed, 23 insertions(+), 80 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 218b5f34d6..2dd35361f3 100644
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
+		       enum path_format arg_path_format, enum path_format def_format)
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
+	enum path_format fmt = (arg_path_format != PATH_FORMAT_DEFAULT) ? arg_path_format : def_format;
+
+	append_formatted_path(&sb, path, prefix, fmt);
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
+	enum path_format arg_path_format = PATH_FORMAT_DEFAULT;
 
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
+				enum path_format wanted = arg_path_format;
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

