Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7341D5151
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772318680; cv=none; b=e4dqSiDRGZrGuFAOubCCeAewWqMOidtUhGBZS1MVK++1w3oBhqhNh8AOu84eH2F+texjOzAxY/JZGyY+oGbsSOixxBn/P1xI5Paqbz5OPtX6CpdEVpCWjKMa6KpM7ID5yOh9PN/0KmF4BM5DQ6LfB2YhHfA+79uj8BSpiLLZLgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772318680; c=relaxed/simple;
	bh=Xwia/hoiw8F0oIFjz5lB1n1CyKNBKDnZa1pzTjzMM7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WS6KI9rld11IRyICKjwnKsNC4/vWxOZn2IhUt+sf480SMrXUD0UYB+Ar28wqAAzqcaCUmb32lGSKXPMGWO2AXxjEnmch2mGUdjxccJJqu5CAYfIQiD1X68vaNgvo98w0BHsR2cA3+1JLHo7JEDMPQj0GSjp1aqUhbQi9qynUD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDmymDFx; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDmymDFx"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a8584e3a2so3082223e0c.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 14:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772318678; x=1772923478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUNMBxKQNpg+MkPMh/vwl/HSX9Y4FuyNBc/yy2yykeE=;
        b=BDmymDFxF1S2LwvKeoD/Ns2CRqwzu3iSNYppPxVcqb25xrH+ehXdXcFfa1xPq96Ayb
         jpQorcTaDGUC82US5A1k+9DRABWoW7LMyEDLhUU0uV+V4gYn5Te+Z/xkLcGNWmWSawUY
         1viU/SeP1lIz029iCqKEmXd8Kw9U+U6lKcCm72fsIjYHVP/T4saYyHVepwHh5uaIhE9s
         lIJ5Mm1p2JDGdamuUx1F2IADnJFgZaojYF13y1z6lnWjneo9sZXDqSitvAGlhnywj0S9
         8V9lFx8G9hUmsyT+ztdwC9D5SQ8+3p35RsAmhkmSJQM56oVu5vkKTvXwwIFQnIASHAe9
         izww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772318678; x=1772923478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUNMBxKQNpg+MkPMh/vwl/HSX9Y4FuyNBc/yy2yykeE=;
        b=FBOUmpNxvmD2wFf9YncUvFAZ3Dunh2Y4uonuoY4sdlcYl2Ufy4BqN6xZtc+g8PuO+G
         7hpNenHFpPYM6Gty4j+xlZ7pDaG/mjLQPIHaSynJmXaL2vWKVfgBm/PS5lZ55SIYr6Kg
         GVe4oOKWIm9+RzP1khXZwbJU11vOlcUD+gBZC/gX5d6uyO05wy7w/M+r6/9AUv8tw6JB
         Z2zIx5mxQcm6sW/p7cOVFU1i6olD75VllBnyAWUKyFkyj8jiFQtYaYq4S5Mc1J4Wvsev
         XXFbWEywGqn9FBbe1v4YWImmkgstRoBlKQUxcnrvrkhzl0HTMDYrS7nU7BOXmi9x5l+o
         m4fw==
X-Gm-Message-State: AOJu0YwMlEWyk1UxjT5E0264uU782ecfpsj31De9skC5RztiR+wcKDOV
	8N3fXFDLqKqZxhFMtgpmCmV3VTd22SLxbTw95D1DUwRSzlDOJ0GWIyvotzHB/I7t
X-Gm-Gg: ATEYQzy0mNbN8KrJWLi395xs9GZADjAmhdMmt84YzAlM8mHWlr+1s7pgN66VQ5F/nFy
	7hCCP/g3mlk9zKV49gf/QhhIEi6pfwnEgDUTm7DJxJKdMQ3xLSJgRumlUSUAoQue1GaKyVpVddk
	71NnV8QfPegZmJy06Ms3Tu7DDMfEObTs97hdL3UfnilfYengUYo/RFw9DpV9lCfrcIZFi/YgDVp
	NRT9gYPfIQVShOg55+IQ3Txt9NLMZocanLIlkwErGxY8Embxw3AHBviNq21qX8UlZU1sw9o2hm6
	dg6enaig6jpUCD2emMaQmb1+pTj/L5IGwkLv8q0rg9d2AkQj+VXFKbt/g7LXlNWWZl68nzzBZhr
	sTLuhw1eP3B1AXDE6E9qZJldfts1qr9xM6ooPG7low/fXTaEzelCaDThPJ4Tgsglt+SOw6EDIei
	O8qZIYZE2tD8UtAHf5wToSs2FZ8pXIIFlAawGc7mD6LK3GDMKPHFLp6gE8tsJZBuKFK8Q=
X-Received: by 2002:a05:6102:c47:b0:5fd:f145:b88a with SMTP id ada2fe7eead31-5ff325a1c1cmr3986006137.40.1772318677851;
        Sat, 28 Feb 2026 14:44:37 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91659421sm11739094e0c.0.2026.02.28.14.44.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 14:44:37 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	jayatheerthkulkarni2005@gmail.com,
	valusoutrik@gmail.com,
	pushkarkumarsingh1970@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 1/4] rev-parse: prepend `path_` to path-related enums
Date: Sat, 28 Feb 2026 19:05:55 -0300
Message-ID: <20260228224252.72788-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two enums used in rev-parse for deciding how paths will
be printed by the function `print_path`: `format_type` and
`default_type`. Even though there aren't any ambiguities yet, their
names aren't clear that those "types" are path types.

Rename both enums and their values by prepending the word `path_`,
to clarify that they are used for choosing path types.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/rev-parse.c | 56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 9032cc6327..a2162ff39e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -623,27 +623,27 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
 	clear_ref_exclusions(&ref_excludes);
 }
 
-enum format_type {
+enum path_format_type {
 	/* We would like a relative path. */
-	FORMAT_RELATIVE,
+	PATH_FORMAT_RELATIVE,
 	/* We would like a canonical absolute path. */
-	FORMAT_CANONICAL,
+	PATH_FORMAT_CANONICAL,
 	/* We would like the default behavior. */
-	FORMAT_DEFAULT,
+	PATH_FORMAT_DEFAULT,
 };
 
-enum default_type {
+enum path_default_type {
 	/* Our default is a relative path. */
-	DEFAULT_RELATIVE,
+	PATH_DEFAULT_RELATIVE,
 	/* Our default is a relative path if there's a shared root. */
-	DEFAULT_RELATIVE_IF_SHARED,
+	PATH_DEFAULT_RELATIVE_IF_SHARED,
 	/* Our default is a canonical absolute path. */
-	DEFAULT_CANONICAL,
+	PATH_DEFAULT_CANONICAL,
 	/* Our default is not to modify the item. */
-	DEFAULT_UNMODIFIED,
+	PATH_DEFAULT_UNMODIFIED,
 };
 
-static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
+static void print_path(const char *path, const char *prefix, enum path_format_type format, enum path_default_type def)
 {
 	char *cwd = NULL;
 	/*
@@ -654,12 +654,12 @@ static void print_path(const char *path, const char *prefix, enum format_type fo
 	 * set it in that case, since doing so causes a relative path to always
 	 * be produced if possible.
 	 */
-	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
+	if (!prefix && (format != PATH_FORMAT_DEFAULT || def != PATH_DEFAULT_RELATIVE_IF_SHARED))
 		prefix = cwd = xgetcwd();
-	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
+	if (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_UNMODIFIED) {
 		puts(path);
-	} else if (format == FORMAT_RELATIVE ||
-		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE)) {
+	} else if (format == PATH_FORMAT_RELATIVE ||
+		  (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_RELATIVE)) {
 		/*
 		 * In order for relative_path to work as expected, we need to
 		 * make sure that both paths are absolute paths.  If we don't,
@@ -679,7 +679,7 @@ static void print_path(const char *path, const char *prefix, enum format_type fo
 		strbuf_release(&buf);
 		strbuf_release(&realbuf);
 		strbuf_release(&prefixbuf);
-	} else if (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED) {
+	} else if (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_RELATIVE_IF_SHARED) {
 		struct strbuf buf = STRBUF_INIT;
 		puts(relative_path(path, prefix, &buf));
 		strbuf_release(&buf);
@@ -708,7 +708,7 @@ int cmd_rev_parse(int argc,
 	const char *name = NULL;
 	struct strbuf buf = STRBUF_INIT;
 	int seen_end_of_options = 0;
-	enum format_type format = FORMAT_DEFAULT;
+	enum path_format_type format = PATH_FORMAT_DEFAULT;
 
 	show_usage_if_asked(argc, argv, builtin_rev_parse_usage);
 
@@ -789,7 +789,7 @@ int cmd_rev_parse(int argc,
 				print_path(repo_git_path_replace(the_repository, &buf,
 								 "%s", argv[i + 1]), prefix,
 						format,
-						DEFAULT_RELATIVE_IF_SHARED);
+					   PATH_DEFAULT_RELATIVE_IF_SHARED);
 				i++;
 				continue;
 			}
@@ -811,9 +811,9 @@ int cmd_rev_parse(int argc,
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
@@ -977,7 +977,7 @@ int cmd_rev_parse(int argc,
 			if (!strcmp(arg, "--show-toplevel")) {
 				const char *work_tree = repo_get_work_tree(the_repository);
 				if (work_tree)
-					print_path(work_tree, prefix, format, DEFAULT_UNMODIFIED);
+					print_path(work_tree, prefix, format, PATH_DEFAULT_UNMODIFIED);
 				else
 					die(_("this operation must be run in a work tree"));
 				continue;
@@ -985,7 +985,7 @@ int cmd_rev_parse(int argc,
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
 				struct strbuf superproject = STRBUF_INIT;
 				if (get_superproject_working_tree(&superproject))
-					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
+					print_path(superproject.buf, prefix, format, PATH_DEFAULT_UNMODIFIED);
 				strbuf_release(&superproject);
 				continue;
 			}
@@ -1020,18 +1020,18 @@ int cmd_rev_parse(int argc,
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
@@ -1047,11 +1047,11 @@ int cmd_rev_parse(int argc,
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
@@ -1081,7 +1081,7 @@ int cmd_rev_parse(int argc,
 				if (the_repository->index->split_index) {
 					const struct object_id *oid = &the_repository->index->split_index->base_oid;
 					const char *path = repo_git_path_replace(the_repository, &buf, "sharedindex.%s", oid_to_hex(oid));
-					print_path(path, prefix, format, DEFAULT_RELATIVE);
+					print_path(path, prefix, format, PATH_DEFAULT_RELATIVE);
 				}
 				continue;
 			}
-- 
2.50.1 (Apple Git-155)

