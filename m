Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87731FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 11:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932764AbdC3Lhk (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 07:37:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34550 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbdC3Lhj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 07:37:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id o123so9388491pga.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 04:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8yy8ePobDWKTHSsFCIJgLzBJSHyM+lH5JkgCON5u1A=;
        b=GmGRVlT+XdQZM7HhKWVXNaTawBPCSq3dkLKaazRjq51GobIaFf8jmyhLU94KLtPCs1
         fsgXXG2qAvBwAhvPInfq/TpbywVesAQJQ33nJInv6KS2hioEDO3PdCuG7nC2pqCROcrU
         1bjwnlPaQ2iR51KvkuURnvdCGpvCpAylUE02NPRWycvw6GLqyzx34xadp0ToxEzJzLnh
         i4ECnpO1WgOl5PngnIepZjdnkhnxIy2d8kWq5R/946WCdacf3US7V9d/q9bBrbOjeZ5B
         yqmasV7HO0uETEz2D7KwEj5f0rC99OIB4/XqBB4jlLJXv4nWOEEwwdWGgJwMukYkNJyq
         JI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8yy8ePobDWKTHSsFCIJgLzBJSHyM+lH5JkgCON5u1A=;
        b=Q5spATxM+oQvItfLDGKr7vUTQ0okJEftq6mVIuucDzVFTewCp6JXId2DWjieJCJchH
         NtPc3t/zvBt8UrBsgqbHyG/6oPwewHsTl/NSk9TI1f1E5PdsMVSIBdlDlKZ3sGrX+Grd
         up3nhlrOgMQCEDLBdBdJ5pCWJObupk4FZtbYUjNgQob6mPI0Ffc/jHQ6F7UbgRsRjkJZ
         Dt6PfdN20E6IIyBStBCRwf1qyAkdbtrW0vj/EDBkWKT35jTQqit8RsGb2SneXjGDl4jS
         EA63RihP17tGE4ca2QLnzwSiAU3e/B8ZhUbe279liV1kkG3GvLYYtQeUCJyYLW7h63X2
         YlHg==
X-Gm-Message-State: AFeK/H23YOWKzPZnvcXtnm2e5DejsfCEbCBPq8aEc41ZbSDnvhpftdSW8riNsg+E8XEVaQ==
X-Received: by 10.84.214.129 with SMTP id j1mr6578888pli.23.1490873858414;
        Thu, 30 Mar 2017 04:37:38 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id s20sm4121734pfg.11.2017.03.30.04.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Mar 2017 04:37:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 30 Mar 2017 18:37:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     tboegi@web.de, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] path.c: and an option to call real_path() in expand_user_path()
Date:   Thu, 30 Mar 2017 18:37:22 +0700
Message-Id: <20170330113723.20474-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170325130549.GA20618@ash>
References: <20170325130549.GA20618@ash>
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

