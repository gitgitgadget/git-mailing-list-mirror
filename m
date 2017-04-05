Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60661FAFB
	for <e@80x24.org>; Wed,  5 Apr 2017 10:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbdDEK0A (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 06:26:00 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:32794 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753901AbdDEKYq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 06:24:46 -0400
Received: by mail-pg0-f54.google.com with SMTP id x125so5943815pgb.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 03:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FbSc65+bWbya6K19688EL6TKYzPcSJnj1IIwT2/Qz8=;
        b=I9CwhkrSn9oftpEpsa81mPQCiTpjorPrHtkX2Qx5F7ZaNLuJSdv+Z93dIsSiQ1IQlY
         xIL7bimsdNDOkGTRcDb52LlACyaOmY+XAu6LLE6JIbN1B8u73mu1h3veMg7T2Yg87z6V
         KG/e5l4tEFYElefRur7AZZprMBN1/xn9VQkLOT/l+NUKhR+ci+/4yqAyLlsqdx1RTrQj
         klJKlWDk9v7eSCbt0BoLejk8T6itg/K8qDf1JeUQBmKB/CVL5K+xYu/lS30AXlI7hQ1D
         bvi3NmToKB44H9yUfCnCjlWTrgKXIa98TKNqUxC/dEscObrHiTbOWoVEKhBQ1x/mDR97
         uIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FbSc65+bWbya6K19688EL6TKYzPcSJnj1IIwT2/Qz8=;
        b=Vh8G+dcrMV+NKcM3OR6OyFpTpBGHxjsFFBp7o/t76gdQdooOn3Epn5Iq3/gHHKOHCO
         oe7vRDDH95f17hn2o3QLrCOo38gMEPQtN+XZilNlLfucInxAl5fR2ylNTOL3MKlv4M9k
         ZkDv5201GIwm8ccNAWIeoUBINwmQPrf9ju14JDWWi90j2EYaoSh0Q3TeC5KutDix/bEg
         d+XkKgjEfQsYwL20tRAaaQafbkkBEvRy3grkfL6P/q9BZMXxdJ19Df0e4YemsxoYqPw3
         lkH5MneISkxSDAjD4DEk8PoOIpDeknbNBCRW4Oipqmyck1A36GSgVv2C/RAqHwtJ8lcP
         YoAw==
X-Gm-Message-State: AFeK/H11H7p07klVfOid0eSPV2hXYB18gIqwfjhRaGgSnxlpGrRXLrKsrlVZCkVCoGPsxA==
X-Received: by 10.84.218.203 with SMTP id g11mr34541312plm.6.1491387885571;
        Wed, 05 Apr 2017 03:24:45 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id p16sm36878623pgc.4.2017.04.05.03.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Apr 2017 03:24:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 05 Apr 2017 17:24:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, tboegi@web.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/2] path.c: and an option to call real_path() in expand_user_path()
Date:   Wed,  5 Apr 2017 17:24:38 +0700
Message-Id: <20170405102439.14797-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170330113723.20474-1-pclouds@gmail.com>
References: <20170330113723.20474-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch we need the ability to expand '~' to
real_path($HOME). But we can't do that from outside because '~' is part
of a pattern, not a true path. Add an option to expand_user_path() to do
so.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 No changes in v2.

 builtin/commit.c   |  2 +-
 builtin/config.c   |  2 +-
 cache.h            |  2 +-
 config.c           |  8 ++++----
 credential-cache.c |  2 +-
 credential-store.c |  2 +-
 path.c             | 11 ++++++++---
 7 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 4e288bc513..ad188fea9e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1404,7 +1404,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 static const char *implicit_ident_advice(void)
 {
-	char *user_config = expand_user_path("~/.gitconfig");
+	char *user_config = expand_user_path("~/.gitconfig", 0);
 	char *xdg_config = xdg_config_home("config");
 	int config_exists = file_exists(user_config) || file_exists(xdg_config);
 
diff --git a/builtin/config.c b/builtin/config.c
index 05843a0f96..70bfaaaa1d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -502,7 +502,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (use_global_config) {
-		char *user_config = expand_user_path("~/.gitconfig");
+		char *user_config = expand_user_path("~/.gitconfig", 0);
 		char *xdg_config = xdg_config_home("config");
 
 		if (!user_config)
diff --git a/cache.h b/cache.h
index 2214d52f61..62e44bfa2f 100644
--- a/cache.h
+++ b/cache.h
@@ -1146,7 +1146,7 @@ typedef int create_file_fn(const char *path, void *cb);
 int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
 
 int mkdir_in_gitdir(const char *path);
-extern char *expand_user_path(const char *path);
+extern char *expand_user_path(const char *path, int real_home);
 const char *enter_repo(const char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
diff --git a/config.c b/config.c
index 1a4d85537b..f036c721e6 100644
--- a/config.c
+++ b/config.c
@@ -135,7 +135,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	if (!path)
 		return config_error_nonbool("include.path");
 
-	expanded = expand_user_path(path);
+	expanded = expand_user_path(path, 0);
 	if (!expanded)
 		return error("could not expand include path '%s'", path);
 	path = expanded;
@@ -177,7 +177,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 	char *expanded;
 	int prefix = 0;
 
-	expanded = expand_user_path(pat->buf);
+	expanded = expand_user_path(pat->buf, 0);
 	if (expanded) {
 		strbuf_reset(pat);
 		strbuf_addstr(pat, expanded);
@@ -948,7 +948,7 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 {
 	if (!value)
 		return config_error_nonbool(var);
-	*dest = expand_user_path(value);
+	*dest = expand_user_path(value, 0);
 	if (!*dest)
 		die(_("failed to expand user dir in: '%s'"), value);
 	return 0;
@@ -1498,7 +1498,7 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
 {
 	int ret = 0;
 	char *xdg_config = xdg_config_home("config");
-	char *user_config = expand_user_path("~/.gitconfig");
+	char *user_config = expand_user_path("~/.gitconfig", 0);
 	char *repo_config = have_git_dir() ? git_pathdup("config") : NULL;
 
 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
diff --git a/credential-cache.c b/credential-cache.c
index 3cbd420019..91550bfb0b 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -87,7 +87,7 @@ static char *get_socket_path(void)
 {
 	struct stat sb;
 	char *old_dir, *socket;
-	old_dir = expand_user_path("~/.git-credential-cache");
+	old_dir = expand_user_path("~/.git-credential-cache", 0);
 	if (old_dir && !stat(old_dir, &sb) && S_ISDIR(sb.st_mode))
 		socket = xstrfmt("%s/socket", old_dir);
 	else
diff --git a/credential-store.c b/credential-store.c
index 55ca1b1334..ac295420dd 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -168,7 +168,7 @@ int cmd_main(int argc, const char **argv)
 	if (file) {
 		string_list_append(&fns, file);
 	} else {
-		if ((file = expand_user_path("~/.git-credentials")))
+		if ((file = expand_user_path("~/.git-credentials", 0)))
 			string_list_append_nodup(&fns, file);
 		file = xdg_config_home("credentials");
 		if (file)
diff --git a/path.c b/path.c
index 22248436bf..010c565512 100644
--- a/path.c
+++ b/path.c
@@ -638,8 +638,10 @@ static struct passwd *getpw_str(const char *username, size_t len)
  * Return a string with ~ and ~user expanded via getpw*.  If buf != NULL,
  * then it is a newly allocated string. Returns NULL on getpw failure or
  * if path is NULL.
+ *
+ * If real_home is true, real_path($HOME) is used in the expansion.
  */
-char *expand_user_path(const char *path)
+char *expand_user_path(const char *path, int real_home)
 {
 	struct strbuf user_path = STRBUF_INIT;
 	const char *to_copy = path;
@@ -654,7 +656,10 @@ char *expand_user_path(const char *path)
 			const char *home = getenv("HOME");
 			if (!home)
 				goto return_null;
-			strbuf_addstr(&user_path, home);
+			if (real_home)
+				strbuf_addstr(&user_path, real_path(home));
+			else
+				strbuf_addstr(&user_path, home);
 #ifdef GIT_WINDOWS_NATIVE
 			convert_slashes(user_path.buf);
 #endif
@@ -723,7 +728,7 @@ const char *enter_repo(const char *path, int strict)
 		strbuf_add(&validated_path, path, len);
 
 		if (used_path.buf[0] == '~') {
-			char *newpath = expand_user_path(used_path.buf);
+			char *newpath = expand_user_path(used_path.buf, 0);
 			if (!newpath)
 				return NULL;
 			strbuf_attach(&used_path, newpath, strlen(newpath),
-- 
2.11.0.157.gd943d85

