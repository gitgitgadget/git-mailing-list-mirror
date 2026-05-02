Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB62E7185
	for <git@vger.kernel.org>; Sat,  2 May 2026 05:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777699734; cv=none; b=m5UkBiNQ/2+F8JL92PIPfv0kOuEth6prGwucFqRKM+3checHr8eE6USbaEDXa+1Wpe/3h0giC0d2EW+o0EAom1YvYC6iNSWChLqnNcAl3NGCL9Yz1X2/82F0kEVTonoaYmI9bmlRcx3znIu2Na2qWQZwxgpY+FEz0DmmmZGpejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777699734; c=relaxed/simple;
	bh=sEUmkmYPpco77qQCchI/9jynmVYFp1Slc7CoJ9Unj3I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Jsl1Wy1xvzLOgC+sxo2ZFOsTRkvi0OMUzk2S0I1oXvQ5EcaHWah78gVORjWdRi7rUO/7hyAuU3tPxf3VwjSc/cs7B3CleWslesR8HPTmWlCMlfK7nhIlQOq6U96ZxXKUPo+2yBcz+/IHqiSrZRhvVBNBf7WU6TUqPOu7u/iJnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lshfi/m5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lshfi/m5"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ea8563c693so293911985a.2
        for <git@vger.kernel.org>; Fri, 01 May 2026 22:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777699731; x=1778304531; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZPgh3Zav7aw7r7uD/3rIO+4QfeD0vskNZvV6eiTvaQ=;
        b=Lshfi/m5k5x5m+5bwUHeTJpkPfP4hMtrNvQTHe/3gBf3Af3np3NuDg9dHiAtxCfeq3
         8QrVd67qNY93kI8lvmtu96Gsz6zWiAb+7W1Fyk8GrThp/a3etCnlS/IJhXEATZk76v5O
         w9+Lr+buZlqL5bSLBFJZzfu4WtV4CqaBX7NWL3FWZI6dscog1F5u+ajkhkVKiL8Sj1NL
         68arbc4OnJ6907etqhAa/zgGfVh9qfj2PxeGOhElz0r5/DmaQwPjf+V/+zc+W3gwDeQM
         DHpcsBqu8EtMu0HvzjA9tN0zXOjXLw1+j1km7ORPs6SCFbCE8I5Q/2UzWz3a910LFXH5
         AEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777699731; x=1778304531;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZPgh3Zav7aw7r7uD/3rIO+4QfeD0vskNZvV6eiTvaQ=;
        b=eqjGEkHIN8gkVYJlD7qg7lFLJgvm93x5ZsJUCotT//d+yCaV74WjBr93yX0RYjK9Zr
         aNuLhRqJGkwyrSV0Bb8pSQj8nOQZTwbNpKE09Zq8zKu9cAEH+2PKL1sJrJljxtDxpTpL
         qRA5GzngnfJa97xjJI3S9nD9GJlAX0dS5Ixkpz3gpkGHd4xk5PGQ9mBuqSSqhvUFV/q7
         C9C4EWTN95ahumapgg2HZhxgdRmyhPptjk2ZB/e8N/4CnZXUKWZdhCSWRG6IUcBlTHPU
         9oOPkI0nYcco/oQyIGVexiISs4+Pb3CqoQxhpcY6dLf3YoE74+7GlGh+LIdH45lNl2wP
         Z78w==
X-Gm-Message-State: AOJu0Yyckr1V/nHYzRChpYY+N1hPWaYZzA98Qv9tN9XtRqaDEaH1GHil
	kouiVNcH5iEQ+AxvG8WOx5nyqDuGV3+mq/HuLrEl4XdHu2AVnwHbpgZ+W27BRQ==
X-Gm-Gg: AeBDiesGt4P09FPSUBM9fOrEC/AiLVV8+AzI/uMWJhP3hbZ1Z3pziP1p0O8xVA1Vo14
	fCzFNN1Jb8ig4T3OS4g4E0JhMbHlc4pebgZStgMBZ/dKPUC3XFjlN3oGbc6ZJ3xyChoENWpPvm9
	sKVmh05LNibTGfucKBnrs3SfmoO9lEAYdzsPyirQebH0DnP1YPBNqLvzuMDOlbJOXYda7Bgg5Kd
	YLmOfnj5wzHCrlzoIfgn/8AkRj5lc0qVaQhJe2Ct6vp0WgLzZ1GzkeLgZD4Uj4FoP2E+lThpHmL
	7Je59y+xlQnTz0yIIkcHMhgANfmCiBrf75yMuYIqN+6w383YRJ/9zGuMZqAmTVx6iXp9AzHXDM3
	zGYfhUw1k2fxKalYeEAPjZefmuSLBTnKCj5MWw/rXKUFr1Cj1/vekeC6Bux8VZE+nIfPCHUtSSe
	Qn1bJbdq4NjqnQOn6+kHVa4h/Esk86TNIf3dleON8=
X-Received: by 2002:a05:620a:2849:b0:8ee:eb50:4f64 with SMTP id af79cd13be357-8fd18c2e8f4mr344762685a.57.1777699731215;
        Fri, 01 May 2026 22:28:51 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91dd48sm383465085a.38.2026.05.01.22.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 22:28:50 -0700 (PDT)
Message-Id: <af6c71227b795d59916e0383ec053067f77835fb.1777699722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
	<pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 05:28:40 +0000
Subject: [PATCH v3 6/8] builtin: create url-parse command
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Git commands can accept a rather wide variety of URLs syntaxes.
The range of accepted inputs might expand even more in the future.
This makes the parsing of URL components difficult since standard URL
parsers cannot be used. Extracting the components of a git URL would
require implementing all the schemes that git itself supports, not to
mention tracking its development continuously in case new URL schemes
are added.

The url-parse builtin command is designed to solve this problem
by exposing git's native URL parsing facilities as a plumbing command.
Other programs can then call upon git itself to parse the git URLs
and extract their components. This should be quite useful for scripts.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 .gitignore          |   1 +
 Makefile            |   1 +
 builtin.h           |   1 +
 builtin/url-parse.c | 135 ++++++++++++++++++++++++++++++++++++++++++++
 command-list.txt    |   1 +
 git.c               |   1 +
 meson.build         |   1 +
 7 files changed, 141 insertions(+)
 create mode 100644 builtin/url-parse.c

diff --git a/.gitignore b/.gitignore
index 24635cf2d6..c5673daa6e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -182,6 +182,7 @@
 /git-update-server-info
 /git-upload-archive
 /git-upload-pack
+/git-url-parse
 /git-var
 /git-verify-commit
 /git-verify-pack
diff --git a/Makefile b/Makefile
index cedc234173..1c757a1aa0 100644
--- a/Makefile
+++ b/Makefile
@@ -1497,6 +1497,7 @@ BUILTIN_OBJS += builtin/update-ref.o
 BUILTIN_OBJS += builtin/update-server-info.o
 BUILTIN_OBJS += builtin/upload-archive.o
 BUILTIN_OBJS += builtin/upload-pack.o
+BUILTIN_OBJS += builtin/url-parse.o
 BUILTIN_OBJS += builtin/var.o
 BUILTIN_OBJS += builtin/verify-commit.o
 BUILTIN_OBJS += builtin/verify-pack.o
diff --git a/builtin.h b/builtin.h
index 235c51f30e..c6f7672991 100644
--- a/builtin.h
+++ b/builtin.h
@@ -271,6 +271,7 @@ int cmd_update_server_info(int argc, const char **argv, const char *prefix, stru
 int cmd_upload_archive(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_upload_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_url_parse(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_var(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_verify_commit(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_verify_tag(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/url-parse.c b/builtin/url-parse.c
new file mode 100644
index 0000000000..7e705538c0
--- /dev/null
+++ b/builtin/url-parse.c
@@ -0,0 +1,135 @@
+#include "builtin.h"
+#include "gettext.h"
+#include "parse-options.h"
+#include "url.h"
+#include "urlmatch.h"
+
+static const char * const builtin_url_parse_usage[] = {
+	N_("git url-parse [-c <component>] [--] <url>..."),
+	NULL
+};
+
+static char *component_arg;
+
+static struct option builtin_url_parse_options[] = {
+	OPT_STRING('c', "component", &component_arg, N_("component"),
+		N_("which URL component to extract")),
+	OPT_END(),
+};
+
+enum url_component {
+	URL_NONE = 0,
+	URL_SCHEME,
+	URL_USER,
+	URL_PASSWORD,
+	URL_HOST,
+	URL_PORT,
+	URL_PATH,
+};
+
+static void parse_or_die(const char *url, struct url_info *info)
+{
+	if (url_is_local_not_ssh(url)) {
+		if (*url == '/')
+			die("'%s' is not a URL; if you meant a local "
+			    "repository, use 'file://%s'", url, url);
+		if (has_dos_drive_prefix(url))
+			die("'%s' is not a URL; if you meant a local "
+			    "repository, use 'file:///%s'", url, url);
+		die("'%s' is not a URL; if you meant a local repository, "
+		    "use a 'file://' URL with an absolute path", url);
+	}
+	if (!url_parse(url, info))
+		die("invalid git URL '%s': %s", url, info->err);
+}
+
+static enum url_component get_component_or_die(const char *arg)
+{
+	if (!strcmp("path", arg))
+		return URL_PATH;
+	if (!strcmp("host", arg))
+		return URL_HOST;
+	if (!strcmp("scheme", arg))
+		return URL_SCHEME;
+	if (!strcmp("user", arg))
+		return URL_USER;
+	if (!strcmp("password", arg))
+		return URL_PASSWORD;
+	if (!strcmp("port", arg))
+		return URL_PORT;
+	die("invalid git URL component '%s'", arg);
+}
+
+static char *extract_component(enum url_component component,
+			       struct url_info *info)
+{
+	size_t offset, length;
+
+	switch (component) {
+	case URL_SCHEME:
+		offset = 0;
+		length = info->scheme_len;
+		break;
+	case URL_USER:
+		offset = info->user_off;
+		length = info->user_len;
+		break;
+	case URL_PASSWORD:
+		offset = info->passwd_off;
+		length = info->passwd_len;
+		break;
+	case URL_HOST:
+		offset = info->host_off;
+		length = info->host_len;
+		break;
+	case URL_PORT:
+		offset = info->port_off;
+		length = info->port_len;
+		break;
+	case URL_PATH:
+		offset = info->path_off;
+		length = info->path_len;
+		break;
+	case URL_NONE:
+		return NULL;
+	}
+
+	return xstrndup(info->url + offset, length);
+}
+
+int cmd_url_parse(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
+{
+	struct url_info info;
+	enum url_component selected = URL_NONE;
+	char *extracted;
+	int i;
+
+	argc = parse_options(argc, argv, prefix, builtin_url_parse_options,
+			     builtin_url_parse_usage, 0);
+
+	if (argc == 0)
+		usage_with_options(builtin_url_parse_usage,
+				   builtin_url_parse_options);
+
+	if (component_arg)
+		selected = get_component_or_die(component_arg);
+
+	for (i = 0; i < argc; i++) {
+		parse_or_die(argv[i], &info);
+
+		if (selected != URL_NONE) {
+			extracted = extract_component(selected, &info);
+			if (extracted) {
+				puts(extracted);
+				free(extracted);
+			}
+		}
+
+		free(info.url);
+	}
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index f9005cf459..1ede48186f 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -202,6 +202,7 @@ git-update-ref                          plumbingmanipulators
 git-update-server-info                  synchingrepositories
 git-upload-archive                      synchelpers
 git-upload-pack                         synchelpers
+git-url-parse                           purehelpers
 git-var                                 plumbinginterrogators
 git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
diff --git a/git.c b/git.c
index 5a40eab8a2..a073eed931 100644
--- a/git.c
+++ b/git.c
@@ -670,6 +670,7 @@ static struct cmd_struct commands[] = {
 	{ "upload-archive", cmd_upload_archive, NO_PARSEOPT },
 	{ "upload-archive--writer", cmd_upload_archive_writer, NO_PARSEOPT },
 	{ "upload-pack", cmd_upload_pack },
+	{ "url-parse", cmd_url_parse },
 	{ "var", cmd_var, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
 	{ "verify-pack", cmd_verify_pack },
diff --git a/meson.build b/meson.build
index 11488623bf..dc3cf68ee5 100644
--- a/meson.build
+++ b/meson.build
@@ -686,6 +686,7 @@ builtin_sources = [
   'builtin/update-server-info.c',
   'builtin/upload-archive.c',
   'builtin/upload-pack.c',
+  'builtin/url-parse.c',
   'builtin/var.c',
   'builtin/verify-commit.c',
   'builtin/verify-pack.c',
-- 
gitgitgadget

