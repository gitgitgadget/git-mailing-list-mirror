Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE741D7E5B
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588084; cv=none; b=DvtNAZvQzwxBQvaluY54hDxVSL30xA4UpF4dEhmf1VYBGPvz4UnOCUmV/vk4fdNvhZHPVPIZKH+P3pcXdxZHQAJxkyWG+7Xz57x/0EML8QvHNckRijQ37Stsmi4pGmjgKIOOgrgDnsYnWraayk+f+qtsRzdmogSkbM4MkNQrj7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588084; c=relaxed/simple;
	bh=cqPszrERzCXyHwUZ6eIiApQ/hytXFsbr1wqjO+zvcTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DjflquuohEpylRcPcYErS4DEAL9Uf7q7Rd+onraAZEQoqfpM/X2MpZBUs0T+/0lXAZHGAs8q6p/TW6CfYSaeV8EdhEOMwTCY/AXAO8RXWYB90GbnsiuO7CsAZXKpo+GlPg9ji/4pwLJdl6KIji80tiZ/qmtJyMa3ZivjtmtkzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6HnRz8p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6HnRz8p"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d7b50815so36111535e9.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752588081; x=1753192881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkTF0jKr9oVLf2ZQa5vGspJPFq39+Ws0Ox6FkZ+iVR0=;
        b=D6HnRz8pZNzG0FEWxjvvmz7MwbFQ0phorkuL7Zz2SspFt8OhYTfIockk48upANztOX
         A1WPxKwsSX9VxptsBSWOkqhcLjTaR7ymgLtsmkkPHpsBRNKAJH2ako083DRPjd4GZfef
         JJqKm3L1/hZh8N5foPIxqJxrIADdYv29Mx3gf0AVxnDf3qXg5+tF4JWn0/9pjdMgOrjY
         waPTAfhOfSbS2z2KDYfQ7tkpdKacmekAGWfLNoyLhVTPxeJgrE96zJ3BVeqEC1TaCtOB
         IfkJddkR9QGKq0vuvPuVyWy+z5XcbupV8ISL9q3gVFrF4am40ooBofkx0NLS30SXZeH7
         jKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588081; x=1753192881;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkTF0jKr9oVLf2ZQa5vGspJPFq39+Ws0Ox6FkZ+iVR0=;
        b=t7lJiFe+/adSunj4Ocl3uds0EkQMAkrdHDCwE3HNbaVU/L+iFnM6jEkCudzPH6yhLy
         mgAfASbG/XmVBcIabrXqCTP8EjgRq/+pOBVmoidC5Sz5rUOsuVACRlZnPxn/RlvPDv+S
         UGHvyA3nLTs5oB1eqsIao4C93q0cwxTPmQQ+SjH4oysJr9sCB/Fr1Jy/PmwFMR67NQgI
         gAsRYMguEY6AiAuBh4JgA26TMo9oUTsaBrhQTS68v6yLt1Nxv2KCjHTOFdXLFcREAt47
         nK+hsuJUVx6r4FLrpSxiZRPu8lpXF0FMV4NCtHj8G1vEMURpfGTQi1uFlKH86pLI1pGQ
         4jcw==
X-Gm-Message-State: AOJu0YxoqZJPOovqiNYfqRvAPbCoAWzBy0xyVR/FAQJ9Y5MPPF8N5x1c
	BLrNbIcsysqMmyeM/biUiXGFe3TgGbLvLuJ1GqRJkm9Q06h+Bk+zcFRUJAMTqw==
X-Gm-Gg: ASbGncv8nfBTBj9SYMSJqF37Qbj12dMjrN3BYg68TyCMlhNTF+ch7OCRb8ySD4nZ+Z2
	kNfd6/EqpTX+hkND1wZbaBKOoPW1l9TlzxplLPL3wBjQDC7ePp4RGJ6PQzWDmrehsPN0xJCcjnu
	iInHmgYGkNP4TEXiQadZum0tEqBYZOinSWiVutROmiVVPnqdMvTzJ1iHQQ27Q43Ev3Cu9hB7xXE
	IiIWso4/v8KqbYdgAlzm9YUFdt2jck417PHwjcZhIWL22HO6s81VM0dpVfIk8yBP6gx0QWaRKc7
	uXyn+b394cXCI+oKZMQEM06zevPT6w61JUxFEknNJrPdIEwoUqgXNRxSQqHr1pZ8OV+p+DMR0Pr
	mP0o62JZf0oMLQ/WeudLkoZ2HrLUCIEPs4OwV7r3CIGmx
X-Google-Smtp-Source: AGHT+IE+eMiDK/QoxERvkZza4N22x1gOTILskhXg0wM+m5qaCNFL4qyhs9DFpKbim9kSSm76sCc/RA==
X-Received: by 2002:a05:600c:3f0c:b0:456:1006:5401 with SMTP id 5b1f17b1804b1-4561006660amr105394895e9.5.1752588078729;
        Tue, 15 Jul 2025 07:01:18 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc9349sm15005026f8f.45.2025.07.15.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 07:01:18 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] config: remove unneeded struct field
Date: Tue, 15 Jul 2025 15:00:56 +0100
Message-ID: <31724ce432b19088b7c7643654788d8e712b3193.1752588042.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As well as receiving the config key and value, config callbacks
also receive a "struct key_value_info" containing information about
the source of the key-value pair. Accessing the "path" field of
this struct from a callback passed to repo_config() results in a
use-after-free. This happens because repo_config() first populates a
configset by calling config_with_options() and then iterates over the
configset with the callback passed by the caller. When the configset
is constructed it takes a shallow copy of the "struct key_value_info"
for each config setting. This leads to the use-after-free as the
"path" member is freed before config_with_options() returns.

We could fix this by interning the "path" field as we do
for the "filename" field but the "path" field is not actually
needed. It is populated with a copy of the "path" field from "struct
config_source". That field was added in d14d42440d8 (config: disallow
relative include paths from blobs, 2014-02-19) to distinguish between
relative include directives in files and those in blobs. However,
since 1b8132d99d8 (i18n: config: unfold error messages marked for
translation, 2016-07-28) we can differentiate these by looking at the
"origin_type" field in "struct key_value_info". So let's remove the
"path" members from "struct config_source" and "struct key_value_info"
and instead use a combination of the "filename" and "origin_type"
fields to determine the absolute path of relative includes.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
I stumbled across this use-after-free while working on the deprecation
of core.commentChar=auto.
Base-Commit: a30f80fde927d70950b3b4d1820813480968fb0d
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fconfig-remove-kvi-path%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/a30f80fde...31724ce43
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/config-remove-kvi-path/v1

 config.c | 28 +++++++++++++---------------
 config.h |  2 --
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/config.c b/config.c
index f55508bdc21..479ac7bf1e8 100644
--- a/config.c
+++ b/config.c
@@ -56,7 +56,6 @@ struct config_source {
 	} u;
 	enum config_origin_type origin_type;
 	const char *name;
-	const char *path;
 	enum config_error_action default_error_action;
 	int linenr;
 	int eof;
@@ -173,14 +172,14 @@ static int handle_path_include(const struct key_value_info *kvi,
 	if (!is_absolute_path(path)) {
 		char *slash;
 
-		if (!kvi || !kvi->path) {
+		if (!kvi || kvi->origin_type != CONFIG_ORIGIN_FILE) {
 			ret = error(_("relative config includes must come from files"));
 			goto cleanup;
 		}
 
-		slash = find_last_dir_sep(kvi->path);
+		slash = find_last_dir_sep(kvi->filename);
 		if (slash)
-			strbuf_add(&buf, kvi->path, slash - kvi->path + 1);
+			strbuf_add(&buf, kvi->filename, slash - kvi->filename + 1);
 		strbuf_addstr(&buf, path);
 		path = buf.buf;
 	}
@@ -224,11 +223,11 @@ static int prepare_include_condition_pattern(const struct key_value_info *kvi,
 	if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
 		const char *slash;
 
-		if (!kvi || !kvi->path)
+		if (!kvi || kvi->origin_type != CONFIG_ORIGIN_FILE)
 			return error(_("relative config include "
 				       "conditionals must come from files"));
 
-		strbuf_realpath(&path, kvi->path, 1);
+		strbuf_realpath(&path, kvi->filename, 1);
 		slash = find_last_dir_sep(path.buf);
 		if (!slash)
 			BUG("how is this possible?");
@@ -633,7 +632,6 @@ void kvi_from_param(struct key_value_info *out)
 	out->linenr = -1;
 	out->origin_type = CONFIG_ORIGIN_CMDLINE;
 	out->scope = CONFIG_SCOPE_COMMAND;
-	out->path = NULL;
 }
 
 int git_config_parse_parameter(const char *text,
@@ -1036,7 +1034,6 @@ static void kvi_from_source(struct config_source *cs,
 	out->origin_type = cs->origin_type;
 	out->linenr = cs->linenr;
 	out->scope = scope;
-	out->path = cs->path;
 }
 
 static int git_parse_source(struct config_source *cs, config_fn_t fn,
@@ -1850,17 +1847,19 @@ static int do_config_from(struct config_source *top, config_fn_t fn,
 
 static int do_config_from_file(config_fn_t fn,
 			       const enum config_origin_type origin_type,
-			       const char *name, const char *path, FILE *f,
-			       void *data, enum config_scope scope,
+			       const char *name, FILE *f, void *data,
+			       enum config_scope scope,
 			       const struct config_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 	int ret;
 
+	if (origin_type == CONFIG_ORIGIN_FILE && (!name || !*name))
+		BUG("missing filename for CONFIG_ORIGIN_FILE");
+
 	top.u.file = f;
 	top.origin_type = origin_type;
 	top.name = name;
-	top.path = path;
 	top.default_error_action = CONFIG_ERROR_DIE;
 	top.do_fgetc = config_file_fgetc;
 	top.do_ungetc = config_file_ungetc;
@@ -1875,8 +1874,8 @@ static int do_config_from_file(config_fn_t fn,
 static int git_config_from_stdin(config_fn_t fn, void *data,
 				 enum config_scope scope)
 {
-	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
-				   data, scope, NULL);
+	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", stdin, data,
+				   scope, NULL);
 }
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
@@ -1891,7 +1890,7 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 	f = fopen_or_warn(filename, "r");
 	if (f) {
 		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
-					  filename, f, data, scope, opts);
+					  f, data, scope, opts);
 		fclose(f);
 	}
 	return ret;
@@ -1916,7 +1915,6 @@ int git_config_from_mem(config_fn_t fn,
 	top.u.buf.pos = 0;
 	top.origin_type = origin_type;
 	top.name = name;
-	top.path = NULL;
 	top.default_error_action = CONFIG_ERROR_ERROR;
 	top.do_fgetc = config_buf_fgetc;
 	top.do_ungetc = config_buf_ungetc;
diff --git a/config.h b/config.h
index 29a02774837..cbb0f4fddcd 100644
--- a/config.h
+++ b/config.h
@@ -122,14 +122,12 @@ struct key_value_info {
 	int linenr;
 	enum config_origin_type origin_type;
 	enum config_scope scope;
-	const char *path;
 };
 #define KVI_INIT { \
 	.filename = NULL, \
 	.linenr = -1, \
 	.origin_type = CONFIG_ORIGIN_UNKNOWN, \
 	.scope = CONFIG_SCOPE_UNKNOWN, \
-	.path = NULL, \
 }
 
 /* Captures additional information that a config callback can use. */
-- 
2.49.0.897.gfad3eb7d210

