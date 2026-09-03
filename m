Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF129ACCD
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403797; cv=none; b=aJQbPgA/GDnc3ZhgFIvT6uUFh4KEd8DnVeFeN+yL4/N3U8OCmNKfeQJA0DYB1KaggcDu2BbTjDxO6b4M5csBUzqfp7oA/3Ca39GnAGuPcFT8oG5EX309gU+jycAC5hzC3OogFyvxQPDHchr2iC2wO+tPlEt4I7MuLKusZUkttUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403797; c=relaxed/simple;
	bh=vmw4Tmm0zcyTpixxYMgGOy0poOm1CXN/cTlDOPzs/4g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PKD3wqTlrVqaToIlc5q6EefMVWPfoZ2PoSFnAHblgpgw43kxhU+FV6zxOSz+Lj8F+ioEilxiK/8UCNpgTF5XbUiBUzRvL76IBIOi46bn2H2aVhvb0yqVwG+ZE11Ugge9KYnY6yHaGoIaZ5UpMHEc76rpwDOorVkqho/AX7BZEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsRAJ0yq; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsRAJ0yq"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90e7d9c747eso22886956d6.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 19:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788403794; x=1789008594; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zrhFKgym6IbawLvY96sU2VORb9XiMnsBfCvVMpfD318=;
        b=SsRAJ0yqptw8zI8C6QIaZDkY/TBNiaHxE7CQhR9MYpTdVp0X4l5Oq1jwkIGHhIuoaz
         0hnsgndkwjUeShnI3zIrZLU4DZWKsuUX9AJkL9tgguLB7qZPL/ASXAl8z7s8D4ZRGR2Q
         NkOumYBM3w/P1YBiTLkMQ0UHV5rozNm2PLv6vDHEGpcE9QssrA3kNgVkRCe3qFgMnsRe
         T4o+UGGInB3V99y3Ece7lEU8vSi8te515zvAEDarGesggDVQxRxlBFlfY160Eobv4Hp9
         sj38WoG0jHU4EgG/Oc46i1EWCNAU5yyckBOpgbCqmMEnoYLGwHu82uIwyjJHN2BMtP9L
         hUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788403794; x=1789008594;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrhFKgym6IbawLvY96sU2VORb9XiMnsBfCvVMpfD318=;
        b=H425zTTCiZXwLE5RbBckvVcP8Z9Z7wa4rK3oLe1fvLv29QLzFJMUjUFyIgP1psUq5Z
         Z6dDJV30JRPVMnUCPLjkUAEEFwWEqiSDhSt+dX4L8DEJfrh8xGFjPLKpXjtyD5AIEROt
         Xr7/GJjIlshlSgMk8NE86iwCsEkdgO7u0oXTMSwkMqUi8OlWGPVkVV6RWJW7iZApuRJl
         ZpTI82f4dbR9LXwwg4kieqafo2FI7tXqOH1z2qNO+0m9nqEk91gm5aDBO3P/t3rP5dqj
         SDEc2O8WPU3ThSW9PVDAR7fjCmk+kZKuibvBqqXVfkcHhFLQgUFMEDG7zRXYXZC2p1Ig
         MwgA==
X-Gm-Message-State: AFuF++m3gFVEMOn4NqVLv9NSocVkeVX05w5+ZdS532JjWLr1IiG5wFaF
	ATfQLzNc1McGZISIr2Yuv7zZDZnSn3iOdvMmCrKflSjfv6GWj/27UzF4d2aWUw==
X-Gm-Gg: AYBFou2kRvcPl4AngvzZpAhzUKV4P4NGzzcXzOepYwLpr9gGxvdAc/834cBXpPKQ3Tq
	FHYfSwZo8BWFvl+m+VQLkURexxW6GUQY8l+cbZ0t6lidgDN6ZXI2crv6fgCCLlGeUeBfEgXtUEH
	Xcl7kXCmWpq5hBbLSONIaawWlcX8jTU/s5RhDmqnug60VaJhyT3SN7Q6CPOUzUd2ygW4CyxIzli
	8Ka0ezgdBY8OcsOXmQKbUI8lpqTM7qMiv/djjfP8zWYKpbI15sdBf8Wncc8VuzkuhthR1pWf8/s
	j5uuiUwkL9PrAVxv2nEhXrZ8c8r9nP/bkHNev9c6QcDITaUBhUP3mHwp76tqgpRmZ4rT4HDgPbZ
	ni6MmXWLdh0M8IirPawdV23jmoh6xY53+BTbu8+WFH2Phi9vraoOs6LL8phe1RTx/Efufbv8sWD
	UaOx5ctJPoBsRN+JnkA5Q0tsYfL9wFYW0Xs51KE/+gB0UHwIMevFF9z7b7vq2vc6k=
X-Received: by 2002:ae9:e209:0:b0:92e:7c7e:9c9a with SMTP id af79cd13be357-93960fa4eaemr927017085a.31.1788403794115;
        Wed, 02 Sep 2026 19:49:54 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.159.149])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f187083sm377399485a.15.2026.09.02.19.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 19:49:53 -0700 (PDT)
Message-Id: <pull.2388.v3.git.git.1788403792962.gitgitgadget@gmail.com>
In-Reply-To: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
From: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 02:49:52 +0000
Subject: [PATCH v3] var: support broken-down idents, default key, multiple
 args, and -z
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Andrew Pleeter <andrewpleeter@gmail.com>,
    Andrew Pleeter <andrewpleeter@gmail.com>

From: Andrew Pleeter <andrewpleeter@gmail.com>

While 'git var' exposes GIT_AUTHOR_IDENT and GIT_COMMITTER_IDENT,
extracting individual components (name, email, or date) currently
requires callers to manually parse the composite string. Furthermore,
there is no way to query the resolved commit signing key through
'git var', and the command only accepts a single variable at a time.

Teach 'git var' to expose individual identity components and commit
signing configuration, and allow querying multiple variables with
optional NUL-termination:

- Add GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE.
- Add GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE.
- Add GIT_DEFAULT_KEY (with GIT_SIGNING_KEY alias) to resolve the
  configured or default commit signing key ID / fingerprint.
- Allow passing multiple variable arguments (e.g., 'git var
  GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL') to output each variable
  sequentially.
- Support '-z' to terminate variable outputs and 'git var -l -z'
  entries with NUL bytes.
- Update Documentation/git-var.adoc and t/t0007-git-var.sh.

Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
---
    var: support broken-down idents, default key, multiple args, and -z
    
    Teach git var to expose individual identity components and commit
    signing configuration, and allow querying multiple variables with
    optional NUL-termination.
    
    Following discussion on v1/v2 with Jeff King and Junio C Hamano, rather
    than introducing a new standalone subcommand (whoami or ident), this
    version enhances git var:
    
    
    Changes since v2:
    =================
    
     * Drop git ident / git whoami subcommand entirely.
     * Add GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE.
     * Add GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE.
     * Add GIT_DEFAULT_KEY (with GIT_SIGNING_KEY alias) to resolve commit
       signing keys.
     * Teach git var to accept multiple variable arguments (git var <var1>
       <var2> ...).
     * Add -z option to terminate outputs with NUL bytes (including git var
       -l -z).
     * Update Documentation/git-var.adoc and t/t0007-git-var.sh.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2388%2Fanpl1623%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2388/anpl1623/master-v3
Pull-Request: https://github.com/git/git/pull/2388

Range-diff vs v2:

 1:  f322e7fedd < -:  ---------- builtin/ident: add new 'ident' command
 -:  ---------- > 1:  b86340dd0e var: support broken-down idents, default key, multiple args, and -z


 Documentation/git-var.adoc |  43 ++++++++-
 builtin/var.c              | 189 ++++++++++++++++++++++++++++++++-----
 t/t0007-git-var.sh         |  77 +++++++++++++++
 3 files changed, 284 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 697c10aded..30bf2c12a8 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -9,7 +9,7 @@ git-var - Show a Git logical variable
 SYNOPSIS
 --------
 [synopsis]
-git var (-l | <variable>)
+git var (-l [-z] | [-z] <variable>...)
 
 DESCRIPTION
 -----------
@@ -24,20 +24,55 @@ OPTIONS
 	as well. (However, the configuration variables listing functionality
 	is deprecated in favor of `git config list`.)
 
+`-z`::
+	Terminate entries with NUL instead of newline.
+
 EXAMPLES
 --------
-	$ git var GIT_AUTHOR_IDENT
-	Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
-
+* Get the author identity:
++
+------------
+$ git var GIT_AUTHOR_IDENT
+Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
+------------
+
+* Get the author name and email:
++
+------------
+$ git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+Eric W. Biederman
+ebiederm@lnxi.com
+------------
 
 VARIABLES
 ---------
 `GIT_AUTHOR_IDENT`::
     The author of a piece of code.
 
+`GIT_AUTHOR_NAME`::
+    The name of the author of a piece of code.
+
+`GIT_AUTHOR_EMAIL`::
+    The email of the author of a piece of code.
+
+`GIT_AUTHOR_DATE`::
+    The date and timezone of the author of a piece of code.
+
 `GIT_COMMITTER_IDENT`::
     The person who put a piece of code into Git.
 
+`GIT_COMMITTER_NAME`::
+    The name of the person who put a piece of code into Git.
+
+`GIT_COMMITTER_EMAIL`::
+    The email of the person who put a piece of code into Git.
+
+`GIT_COMMITTER_DATE`::
+    The date and timezone of the person who put a piece of code into Git.
+
+`GIT_DEFAULT_KEY`::
+    The default commit signing key ID or fingerprint, if configured or enabled.
+
 `GIT_EDITOR`::
     Text editor for use by Git commands.  The value is meant to be
     interpreted by the shell when it is used.  Examples: `~/bin/vi`,
diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..94207cbc7c 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -12,25 +12,103 @@
 #include "config.h"
 #include "editor.h"
 #include "environment.h"
+#include "gpg-interface.h"
 #include "ident.h"
 #include "pager.h"
 #include "refs.h"
 #include "path.h"
 #include "strbuf.h"
+#include "strvec.h"
 #include "run-command.h"
 
-static const char var_usage[] = "git var (-l | <variable>)";
+static const char var_usage[] = "git var (-l [-z] | [-z] <variable>...)";
 
 static char *committer(int ident_flag)
 {
 	return xstrdup_or_null(git_committer_info(ident_flag));
 }
 
+static char *ident_part(const char *ident, char part)
+{
+	struct ident_split split;
+
+	if (!ident)
+		return NULL;
+	if (split_ident_line(&split, ident, strlen(ident)))
+		return NULL;
+
+	switch (part) {
+	case 'n':
+		if (!split.name_begin || !split.name_end)
+			return NULL;
+		return xmemdupz(split.name_begin, split.name_end - split.name_begin);
+	case 'e':
+		if (!split.mail_begin || !split.mail_end)
+			return NULL;
+		return xmemdupz(split.mail_begin, split.mail_end - split.mail_begin);
+	case 'd':
+		if (!split.date_begin)
+			return NULL;
+		if (split.tz_end)
+			return xmemdupz(split.date_begin, split.tz_end - split.date_begin);
+		if (split.date_end)
+			return xmemdupz(split.date_begin, split.date_end - split.date_begin);
+		return NULL;
+	default:
+		return NULL;
+	}
+}
+
+static char *committer_name(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), 'n');
+}
+
+static char *committer_email(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), 'e');
+}
+
+static char *committer_date(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), 'd');
+}
+
 static char *author(int ident_flag)
 {
 	return xstrdup_or_null(git_author_info(ident_flag));
 }
 
+static char *author_name(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), 'n');
+}
+
+static char *author_email(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), 'e');
+}
+
+static char *author_date(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), 'd');
+}
+
+static char *default_key(int ident_flag UNUSED)
+{
+	int gpgsign = 0;
+	char *signing_key = NULL;
+
+	if (repo_config_get_string(the_repository, "user.signingkey", &signing_key) == 0 && signing_key && *signing_key)
+		return signing_key;
+	free(signing_key);
+
+	if (repo_config_get_bool(the_repository, "commit.gpgsign", &gpgsign) == 0 && gpgsign)
+		return get_signing_key_id();
+
+	return NULL;
+}
+
 static char *editor(int ident_flag UNUSED)
 {
 	return xstrdup_or_null(git_editor());
@@ -125,10 +203,34 @@ static struct git_var git_vars[] = {
 		.name = "GIT_COMMITTER_IDENT",
 		.read = committer,
 	},
+	{
+		.name = "GIT_COMMITTER_NAME",
+		.read = committer_name,
+	},
+	{
+		.name = "GIT_COMMITTER_EMAIL",
+		.read = committer_email,
+	},
+	{
+		.name = "GIT_COMMITTER_DATE",
+		.read = committer_date,
+	},
 	{
 		.name = "GIT_AUTHOR_IDENT",
 		.read = author,
 	},
+	{
+		.name = "GIT_AUTHOR_NAME",
+		.read = author_name,
+	},
+	{
+		.name = "GIT_AUTHOR_EMAIL",
+		.read = author_email,
+	},
+	{
+		.name = "GIT_AUTHOR_DATE",
+		.read = author_date,
+	},
 	{
 		.name = "GIT_EDITOR",
 		.read = editor,
@@ -145,6 +247,10 @@ static struct git_var git_vars[] = {
 		.name = "GIT_DEFAULT_BRANCH",
 		.read = default_branch,
 	},
+	{
+		.name = "GIT_DEFAULT_KEY",
+		.read = default_key,
+	},
 	{
 		.name = "GIT_SHELL_PATH",
 		.read = shell_path,
@@ -172,10 +278,11 @@ static struct git_var git_vars[] = {
 	},
 };
 
-static void list_vars(void)
+static void list_vars(int null_term)
 {
 	struct git_var *ptr;
 	char *val;
+	char eol = null_term ? '\0' : '\n';
 
 	for (ptr = git_vars; ptr->read; ptr++)
 		if ((val = ptr->read(0))) {
@@ -184,10 +291,10 @@ static void list_vars(void)
 
 				string_list_split(&list, val, "\n", -1);
 				for (size_t i = 0; i < list.nr; i++)
-					printf("%s=%s\n", ptr->name, list.items[i].string);
+					printf("%s=%s%c", ptr->name, list.items[i].string, eol);
 				string_list_clear(&list, 0);
 			} else {
-				printf("%s=%s\n", ptr->name, val);
+				printf("%s=%s%c", ptr->name, val, eol);
 			}
 			free(val);
 		}
@@ -196,6 +303,8 @@ static void list_vars(void)
 static const struct git_var *get_git_var(const char *var)
 {
 	struct git_var *ptr;
+	if (!strcmp(var, "GIT_SIGNING_KEY"))
+		var = "GIT_DEFAULT_KEY";
 	for (ptr = git_vars; ptr->read; ptr++) {
 		if (strcmp(var, ptr->name) == 0) {
 			return ptr;
@@ -207,10 +316,13 @@ static const struct git_var *get_git_var(const char *var)
 static int show_config(const char *var, const char *value,
 		       const struct config_context *ctx, void *cb)
 {
+	int null_term = cb ? *(int *)cb : 0;
+	char eol = null_term ? '\0' : '\n';
+
 	if (value)
-		printf("%s=%s\n", var, value);
+		printf("%s=%s%c", var, value, eol);
 	else
-		printf("%s\n", var);
+		printf("%s%c", var, eol);
 	return git_default_config(var, value, ctx, cb);
 }
 
@@ -219,30 +331,65 @@ int cmd_var(int argc,
 	    const char *prefix UNUSED,
 	    struct repository *repo UNUSED)
 {
-	const struct git_var *git_var;
-	char *val;
+	struct strvec vars = STRVEC_INIT;
+	int list = 0;
+	int null_term = 0;
+	int i;
 
 	show_usage_if_asked(argc, argv, var_usage);
-	if (argc != 2)
-		usage(var_usage);
 
-	if (strcmp(argv[1], "-l") == 0) {
-		repo_config(the_repository, show_config, NULL);
-		list_vars();
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (!strcmp(arg, "-l")) {
+			list = 1;
+		} else if (!strcmp(arg, "-z")) {
+			null_term = 1;
+		} else if (!strcmp(arg, "--")) {
+			for (i = i + 1; i < argc; i++)
+				strvec_push(&vars, argv[i]);
+			break;
+		} else if (arg[0] == '-') {
+			usage(var_usage);
+		} else {
+			strvec_push(&vars, arg);
+		}
+	}
+
+	if (list) {
+		if (vars.nr > 0) {
+			strvec_clear(&vars);
+			usage(var_usage);
+		}
+		repo_config(the_repository, show_config, &null_term);
+		list_vars(null_term);
 		return 0;
 	}
-	repo_config(the_repository, git_default_config, NULL);
 
-	git_var = get_git_var(argv[1]);
-	if (!git_var)
+	if (!vars.nr)
 		usage(var_usage);
 
-	val = git_var->read(IDENT_STRICT);
-	if (!val)
-		return 1;
+	repo_config(the_repository, git_default_config, NULL);
+
+	for (size_t j = 0; j < vars.nr; j++) {
+		const struct git_var *git_var = get_git_var(vars.v[j]);
+		char *val;
+
+		if (!git_var) {
+			strvec_clear(&vars);
+			usage(var_usage);
+		}
+
+		val = git_var->read(IDENT_STRICT);
+		if (!val) {
+			strvec_clear(&vars);
+			return 1;
+		}
 
-	printf("%s\n", val);
-	free(val);
+		printf("%s%c", val, null_term ? '\0' : '\n');
+		free(val);
+	}
 
+	strvec_clear(&vars);
 	return 0;
 }
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 2b60317758..c437c968bb 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -276,4 +276,81 @@ test_expect_success '`git var -l` works even without HOME' '
 	)
 '
 
+test_expect_success 'get author identity components' '
+	test_tick &&
+	echo "$GIT_AUTHOR_NAME" >expect.name &&
+	echo "$GIT_AUTHOR_EMAIL" >expect.email &&
+	echo "$GIT_AUTHOR_DATE" >expect.date &&
+	git var GIT_AUTHOR_NAME >actual.name &&
+	git var GIT_AUTHOR_EMAIL >actual.email &&
+	git var GIT_AUTHOR_DATE >actual.date &&
+	test_cmp expect.name actual.name &&
+	test_cmp expect.email actual.email &&
+	test_cmp expect.date actual.date
+'
+
+test_expect_success 'get committer identity components' '
+	test_tick &&
+	echo "$GIT_COMMITTER_NAME" >expect.name &&
+	echo "$GIT_COMMITTER_EMAIL" >expect.email &&
+	echo "$GIT_COMMITTER_DATE" >expect.date &&
+	git var GIT_COMMITTER_NAME >actual.name &&
+	git var GIT_COMMITTER_EMAIL >actual.email &&
+	git var GIT_COMMITTER_DATE >actual.date &&
+	test_cmp expect.name actual.name &&
+	test_cmp expect.email actual.email &&
+	test_cmp expect.date actual.date
+'
+
+test_expect_success 'get multiple variables' '
+	test_tick &&
+	cat >expect <<-EOF &&
+	$GIT_AUTHOR_NAME
+	$GIT_AUTHOR_EMAIL
+	$GIT_COMMITTER_NAME
+	$GIT_COMMITTER_EMAIL
+	EOF
+	git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables with -z' '
+	test_tick &&
+	printf "%s\0%s\0" "$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
+	git var -z GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git var -l -z' '
+	git var -l -z >actual &&
+	tr "\0" "\n" <actual | grep "^GIT_AUTHOR_NAME=" >filtered &&
+	echo "GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME" >expect &&
+	test_cmp expect filtered
+'
+
+test_expect_success 'get GIT_DEFAULT_KEY with user.signingkey configured' '
+	test_config user.signingkey "TEST_KEY_ID" &&
+	echo "TEST_KEY_ID" >expect &&
+	git var GIT_DEFAULT_KEY >actual &&
+	test_cmp expect actual &&
+	git var GIT_SIGNING_KEY >actual.alias &&
+	test_cmp expect actual.alias
+'
+
+test_expect_success 'get GIT_DEFAULT_KEY fails when unset and signing disabled' '
+	test_config user.signingkey "" &&
+	test_config commit.gpgsign false &&
+	test_must_fail git var GIT_DEFAULT_KEY
+'
+
+test_expect_success 'git var -l lists new variables' '
+	git var -l >actual &&
+	grep "^GIT_AUTHOR_NAME=" actual &&
+	grep "^GIT_AUTHOR_EMAIL=" actual &&
+	grep "^GIT_AUTHOR_DATE=" actual &&
+	grep "^GIT_COMMITTER_NAME=" actual &&
+	grep "^GIT_COMMITTER_EMAIL=" actual &&
+	grep "^GIT_COMMITTER_DATE=" actual
+'
+
 test_done

base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
-- 
gitgitgadget
