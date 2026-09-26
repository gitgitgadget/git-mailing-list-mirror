Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C03379EEF
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439656; cv=none; b=flvawQ85wGYZo3g2oJbTyw4zF6qKiyq7PowN9gWdy76+x1Cu+oEnDQATf1Ck8h+olTyeZVeZHWYMS1I0qWGBrT+2cCPNlz1jf/TRs80jtI3BheFgXQRtMtfrx9ZgMQ3hAkQHvQciUpPhhS32ZKPrsicsU1osO6PlO3WxxI4QMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439656; c=relaxed/simple;
	bh=w+6sIpMoR3PnUPuszX0Vzr9r/LBsAkfRWamZWQZ5OPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsdvOPZdNN3L02e+eyzL6LBdsLpvNekBei311FrmYgaWd6EvpTQSEXDBGmvz11N2KQsYm38u9fvikJ3iBrW7XZYcdV0uP5woHVCJb93/2k334iIbBj6kKa545o5OCkmiHlbr5xoAt8bp3RRtk56crcLf17zU4zBopdJ8TYXtZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMjhF0PA; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMjhF0PA"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5bda9b8aso23530385a.1
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790439652; x=1791044452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NJLRHpNxu+V1y2iZLxH0xNohI+Vl3nQSZ+nfzM5Ecag=;
        b=ZMjhF0PAoOrcHwBu+uc8ebCf/g4FaEOjT7XfftTNojS2rs6Sac7IVhAphPVMiUTWkD
         9zMAFKTzz8PJkaghGDEDU88IiUDPckOUilPEamvPJu++gJqc06zMWLEb638TwjKQT3x0
         SE1tjx8EPAbdUHQs5lki+BWVUZem6HUhIwnqq8Ex/WSRrx+c5nr2dZ0Z/8o2szuCXCVJ
         Gr6dT2htz42R4QxRH4JvBTngzzr8NJ4R9FNbdAUTvNMIwjqiLrDhDvouVgUMCvFCB9WH
         RZqjF9YaeE9MrchEFGhCdGNKAh+TnNtExuXbF1/xq0jAMK2c4GVH5PhfNZ3eSSG7gyMU
         cyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790439652; x=1791044452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NJLRHpNxu+V1y2iZLxH0xNohI+Vl3nQSZ+nfzM5Ecag=;
        b=k8hcSZ41F64v8sjWbYP2Ai/Qahnzv41LhMlwUhEb6AeAaehwLvD3JdkPMQ3yLmCFDC
         ytz/bZXQsp5n1qiKA4Jm3+u9Wv06rZN33tp/qjbznuT8H6jZxidK8SeLbhW9hwypaYIy
         wLVpasZSQ6tabq7PLz9cKExxDIqLdImPjCKpIF830S05sYeZMr/TjBARCak3UBfgHlYl
         kS9iO2cN62x1A7y3XFiPNhorCNpqZ8w/27Pj00rxD4fjo58tE1JIEh+p/a/4HrJ18QHP
         FAtSZewqrYeGrOg5EPkxdLfeNbDHJlBZrpLI7gqAmqbf68I0n6ohihbX5S/j6489bVcp
         4UBw==
X-Gm-Message-State: AFuF++ls/j4iEEszrCGpf/2gOgBT1sn68z5wTmVJDGVfMQ314LRI6OWw
	2rCDPHYq4GRKh32LKWKYDEWTdGqfitfn+fTeDUNbZSsSEu3FFTJZ4tMeEi58Mi7tmziu5g==
X-Gm-Gg: AYBFou1grW7d1QJ+JhrMaqSUjHkLrxxulSDV42JYUoU3hBlXPtv+YGY99IWPG8Z7JAR
	xKTwCVBAe+rG3brYGDpnqb0eFriwRWLzIMrVH7u4asISKZj1RDINJylzocsg2Zgnm4D3P+xs9Mi
	Q8zHrmzWzrUzptjyPUyeafeD0ZC0COlhiLYNVMO8Y6OSfHz/DPM3o5+OrdJJO6Ic7Gj+lHte+j/
	U7CdDXfJac/YMLapRWibdK27Ctv4VK7ZEVdYS2nfmUqGY9K4tCKPvO+hPEm+fzsKhz3YSObRS8N
	e7Cac11w6MOMO7Xq0wffeNXEIiQow8gLBQtjKQ1Lwqcs/UAql2/4mZb6YjEqjLjsU9G9JdYkGIQ
	iohA3qb+yQWJ24aK1QlOncmBme9TJ6xNX2GbC3ctywEKoVmiNm4CHQwUlfg2xy+ejAS2ZigQYK5
	S2aRkon1pLIMyjj7VdsfHcVm7JrPuExNuy/7j8qZ6CoC7f6MJb6XXTYcLcISFgEdbNUeN9+zi+H
	ixojFzc4KbVc6DCPawjtoIGzC0V2+10yH7jdUK60NoDWlbHr3PsZPoF/wy5X8QfqVVUJHcE2O2A
	y2Nu8moYV7y54Rah2OsDxdu9ycIA648JYfqK4G5Oo6hK67UG/5dV
X-Received: by 2002:a05:620a:31a9:b0:93b:d7a4:9d4b with SMTP id af79cd13be357-93c43db7b1amr1111254085a.30.1790439651980;
        Sat, 26 Sep 2026 09:20:51 -0700 (PDT)
Received: from localhost.localdomain ([2603:7002:a00:5733:58df:3319:3c13:321f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c448ae8ecsm440919985a.9.2026.09.26.09.20.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:20:51 -0700 (PDT)
From: Andrew Pleeter <andrewpleeter@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	ben.knoble@gmail.com,
	peff@peff.net,
	sandals@crustytoothpaste.net
Subject: [PATCH v9 2/4] var: add "-z" output mode
Date: Sat, 26 Sep 2026 12:20:46 -0400
Message-ID: <20260926162048.30853-3-andrewpleeter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqq33va1lcg.fsf@gitster.g>
References: <xmqq33va1lcg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts that read from "git var" have no unambiguous way to parse its
output.  A value that itself contains a newline, and a variable that
has more than one value, both run together with the newline that
terminates each entry.

Teach "git var" a "-z" option that terminates each entry with a NUL
byte instead.  With "-l", the variable name and its value are separated
by a newline and each entry is terminated by NUL, which is the same
convention "git config list -z" already uses.  When a single variable
is asked for, its bare value is terminated by NUL.

Parsing of the command line is switched over to parse_options() in
order to accept the new option; as a side effect, options now have to
come before the variable name.

Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
---
 Documentation/git-var.adoc | 19 ++++++++---
 builtin/var.c              | 67 +++++++++++++++++++++++++++-----------
 t/t0007-git-var.sh         | 30 +++++++++++++++++
 3 files changed, 93 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index de3007732d..9052fbc549 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -9,13 +9,19 @@ git-var - Show a Git logical variable
 SYNOPSIS
 --------
 [synopsis]
-git var (-l | <variable>)
+git var [-z] -l
+git var [-z] <variable>
 
 DESCRIPTION
 -----------
 Prints a Git logical variable. Exits with code 1 if the variable has
 no value.
 
+If `-z` is given, the value is terminated by a NUL byte instead of a
+newline. With `-l`, the variable name and its value are separated by a
+newline, and each entry is terminated by a NUL byte
+(`VARIABLE\nvalue\0`), in the same way as `git config list -z`.
+
 OPTIONS
 -------
 `-l`::
@@ -24,6 +30,11 @@ OPTIONS
 	as well. (However, the configuration variables listing functionality
 	is deprecated in favor of `git config list`.)
 
+`-z`::
+	Terminate entries with NUL instead of newline. When used with
+	`-l`, the variable name and its value are separated by a
+	newline, and each entry is terminated with a NUL byte.
+
 EXAMPLES
 --------
 	$ git var GIT_AUTHOR_IDENT
@@ -86,9 +97,9 @@ endif::git-default-pager[]
     This variable can have multiple values.
 
 Most path values contain only one value. However, some can contain multiple
-values, which are separated by newlines, and are listed in order from highest to
-lowest priority.  Callers should be prepared for any such path value to contain
-multiple items.
+values, which are separated by newlines (or NUL bytes if `-z` is given), and are
+listed in order from highest to lowest priority.  Callers should be prepared for
+any such path value to contain multiple items.
 
 Note that paths are printed even if they do not exist, but not if they are
 disabled by other environment variables.
diff --git a/builtin/var.c b/builtin/var.c
index 9f7c8a6113..c9691070b8 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -14,13 +14,18 @@
 #include "environment.h"
 #include "ident.h"
 #include "pager.h"
+#include "parse-options.h"
 #include "path.h"
 #include "refs.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
 
-static const char var_usage[] = "git var (-l | <variable>)";
+static const char * const var_usage[] = {
+	N_("git var [-z] -l"),
+	N_("git var [-z] <variable>"),
+	NULL
+};
 
 static char *committer(int ident_flag)
 {
@@ -164,16 +169,18 @@ static struct git_var git_vars[] = {
 	},
 };
 
-static void list_vars(void)
+static void list_vars(int nul_term)
 {
 	struct git_var *ptr;
+	char delim = nul_term ? '\n' : '=';
+	char term = nul_term ? '\0' : '\n';
 
 	for (ptr = git_vars; ptr->read || ptr->multiread; ptr++) {
 		if (ptr->read) {
 			char *val = ptr->read(0);
 
 			if (val) {
-				printf("%s=%s\n", ptr->name, val);
+				printf("%s%c%s%c", ptr->name, delim, val, term);
 				free(val);
 			}
 		} else {
@@ -181,7 +188,8 @@ static void list_vars(void)
 
 			ptr->multiread(&list);
 			for (size_t i = 0; i < list.nr; i++)
-				printf("%s=%s\n", ptr->name, list.items[i].string);
+				printf("%s%c%s%c", ptr->name, delim,
+				       list.items[i].string, term);
 			string_list_clear(&list, 0);
 		}
 	}
@@ -201,34 +209,55 @@ static const struct git_var *get_git_var(const char *var)
 static int show_config(const char *var, const char *value,
 		       const struct config_context *ctx, void *cb)
 {
+	int *nul_term = cb;
+	char delim = *nul_term ? '\n' : '=';
+	char term = *nul_term ? '\0' : '\n';
+
 	if (value)
-		printf("%s=%s\n", var, value);
+		printf("%s%c%s%c", var, delim, value, term);
 	else
-		printf("%s\n", var);
+		printf("%s%c", var, term);
 	return git_default_config(var, value, ctx, cb);
 }
 
 int cmd_var(int argc,
 	    const char **argv,
-	    const char *prefix UNUSED,
+	    const char *prefix,
 	    struct repository *repo UNUSED)
 {
 	const struct git_var *git_var;
-
-	show_usage_if_asked(argc, argv, var_usage);
-	if (argc != 2)
-		usage(var_usage);
-
-	if (strcmp(argv[1], "-l") == 0) {
-		repo_config(the_repository, show_config, NULL);
-		list_vars();
+	int list = 0;
+	int nul_term = 0;
+	char term;
+	struct option options[] = {
+		OPT_BOOL('l', NULL, &list,
+			 N_("list all variables")),
+		OPT_BOOL('z', NULL, &nul_term,
+			 N_("terminate entries with NUL")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     var_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (list) {
+		if (argc)
+			usage_with_options(var_usage, options);
+		repo_config(the_repository, show_config, &nul_term);
+		list_vars(nul_term);
 		return 0;
 	}
+
+	if (argc != 1)
+		usage_with_options(var_usage, options);
+
 	repo_config(the_repository, git_default_config, NULL);
 
-	git_var = get_git_var(argv[1]);
+	term = nul_term ? '\0' : '\n';
+
+	git_var = get_git_var(argv[0]);
 	if (!git_var)
-		usage(var_usage);
+		usage_with_options(var_usage, options);
 
 	if (git_var->read) {
 		char *val = git_var->read(IDENT_STRICT);
@@ -236,7 +265,7 @@ int cmd_var(int argc,
 		if (!val)
 			return 1;
 
-		printf("%s\n", val);
+		printf("%s%c", val, term);
 		free(val);
 	} else {
 		struct string_list list = STRING_LIST_INIT_DUP;
@@ -247,7 +276,7 @@ int cmd_var(int argc,
 			return 1;
 		}
 		for (size_t i = 0; i < list.nr; i++)
-			printf("%s\n", list.items[i].string);
+			printf("%s%c", list.items[i].string, term);
 		string_list_clear(&list, 0);
 	}
 
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 2b60317758..661d0539c0 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -276,4 +276,34 @@ test_expect_success '`git var -l` works even without HOME' '
 	)
 '
 
+test_expect_success 'get a variable with -z' '
+	printf "%sQ" "$(git var GIT_AUTHOR_IDENT)" >expect &&
+	git var -z GIT_AUTHOR_IDENT >actual.raw &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multi-valued variable with -z' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" git var -z GIT_CONFIG_GLOBAL >actual.raw &&
+	printf "%sQ%sQ" "$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" >expect &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git var -l -z' '
+	git var -l -z >actual &&
+	tr "\0" "\n" <actual >actual.lines &&
+	git var GIT_AUTHOR_IDENT >expect &&
+	sed -n "/^GIT_AUTHOR_IDENT$/{n;p;}" actual.lines >actual.author &&
+	test_cmp expect actual.author &&
+	echo false >expect &&
+	sed -n "/^core\.bare$/{n;p;}" actual.lines >actual.bare &&
+	test_cmp expect actual.bare
+'
+
+test_expect_success 'options must precede variable arguments' '
+	test_must_fail git var GIT_AUTHOR_IDENT -z
+'
+
 test_done
-- 
2.54.0 (Apple Git-157)

