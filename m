Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89A1CAA78
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439655; cv=none; b=qU2X605ZasoQrIOvYQ4AFVwEwnIULEgNPKRWGafXCwSmakoBnvHrJ4afngCEfYIsVNN8ltR/s63PPCWjVeZB3AkvzKID3WRErGW5nds721C5NZPeLNPknh8pareCTZccGd8AWbHvyvNqjpMfxSoYGq/8/MwWmjK0YZBYv19XeH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439655; c=relaxed/simple;
	bh=2hraQfjzWwHnWmxueAX+eec/g8mKcp2w/1vX7VLOGyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp1OZU1c3v2xY/tRVh2vXAdK7mEsACsnhxwaWUTSfHFuWdTwkDlzIb4IThQNUHKmi9kJYIzVjoiFBQGUTFdQak6ZZH+QRmzJZf7kseqCx8QMFZBivQVxRVq4bdKIGpB7aswqexAMP4Af98+KO0pZXu1F5SZZqPtRnnPDeegycyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ln66A6kj; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln66A6kj"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5b166b8fso46204585a.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790439651; x=1791044451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RHS8SrgX2p5lacYy4sqMBwZGUd4KrbX3DIG5RUVd4I=;
        b=Ln66A6kj9bxqWT1BoVHIzNvlZprZ/u1XGpRFcQ/K+ETXYcEIsMGUj/u704LzNzO6eP
         Q8ayRA+CBLqGryKtZUHkD9w+dwP1m3PyWx4eRA0mM8woch1yow3xc910FwOniBOuaejQ
         WgmayznCQ0uZ8xr40vU7221C66gNqhFI3WQ2p1HLUusKVGvr6XPLvqjmqSOQZykf/Sn9
         0k19y5mmIfjRq+KMXxMEMBpEFoHnuml+gFVGgB/ls33EAqgth+YhMDPciG1PrMN5cxr5
         GetPXCvjXIaiLLi4thWgIsDXaE5ScnrMKyTx273eOUaun06+aKsAOS+X50vMNpjYSBtM
         EfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790439651; x=1791044451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RHS8SrgX2p5lacYy4sqMBwZGUd4KrbX3DIG5RUVd4I=;
        b=m5djA9qeTRSNcEwct01dUnh4vXtWFOCG5T5j8SkVRH8+Npv4RC2RHH1p0bl5K06I8A
         BIOnal6HmIeqFklzpKX+sTzIZCoq5oMzIg3SHhQF+BroU3a5QXdNMjZyuotItBxPbRUn
         hB5py/1hjVZu9ocKLvreAqNOuOo7U7QmWZchikX/3lr0MLR6YnnWEuqV8lEpT5j2R69M
         yyAufXq9sFbhMNouCbRy+tPq7liZxMAtdySZATmnl7wmVCvMyVyJZ1DXgmr6XxACB1DX
         qVJPIkfqzFkCF+iXT7VApUi+ghiFRE+oa5/HH43kilZKGq4/cj7yL99OJzwILAS6Bl9e
         S0oA==
X-Gm-Message-State: AFuF++kHORrsckzQF9EaSolCVVAa0+u+u5IgbnLb4QaSVbl2MkuNaSYx
	Puyr9G5CLYVVt4G6JDSQ8+fJbB0+iCiMx7YuuoQ5O1q9UaM4f7mhFvHnKaKy1YFmH30MCA==
X-Gm-Gg: AYBFou2MMV5QGf7De7oG0i0M84cJcW1Ctxit5fvauUWgprmDEj4ramy96LJ93lEV3gv
	xTU2vtWG0gk0Q7BQ6hUikAHPQt3tm+K396gncDDjNaMAR6ocLLF+UYajdhY36qTIVO6l1Y9HGHn
	kBrgUrB0YRic12u+n9SxFpOmWytVxHPzQxLGHHNtIlqBHxE8dhN1vma0+oGhl7KT+pic41yQtg8
	tKYdOzNneNpPR//GManyNR2NebOabj8eeb1y/J10M2ep74E2layuZUzIQViYmdX1pXn3dK2R7ue
	fSMEnCu1Kx8ScZQHbtvXm8Cnwk1P+TF0DAId7cJQ6XG/K/ZrEwoYQCBlxRqEB5ElX5oFplcn6Cl
	dCV+Uhpelr4HZro0DXPwoyuYsjx6bqcwo3ljymoq3dA4Kzpsf2WDHmCtTljMp2JeYl983ERtznt
	ysZ5dzenZlOFK9bnhVKUomQQZqkHEckp9nMmRoXIX8NRrHz7BiffiSQh5DGNFuHsGEQ3liM0hU7
	StDDNVwhlLRnEHoHKq7jQf7EzIa+zaCWleKcNd++O9onyXwR6PJZxX9upM5A7BreKx6VLPjctzx
	i9BJx9Kd8KNE1aYkVtmwq/rl1UkAlSsR0JzMSvnhxXWzxqxxpTHu
X-Received: by 2002:a05:620a:400d:b0:93b:d7a2:dd29 with SMTP id af79cd13be357-93c43d2d070mr1061060985a.57.1790439650997;
        Sat, 26 Sep 2026 09:20:50 -0700 (PDT)
Received: from localhost.localdomain ([2603:7002:a00:5733:58df:3319:3c13:321f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c448ae8ecsm440919985a.9.2026.09.26.09.20.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:20:50 -0700 (PDT)
From: Andrew Pleeter <andrewpleeter@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	ben.knoble@gmail.com,
	peff@peff.net,
	sandals@crustytoothpaste.net
Subject: [PATCH v9 1/4] var: represent multi-valued variables with a string_list
Date: Sat, 26 Sep 2026 12:20:45 -0400
Message-ID: <20260926162048.30853-2-andrewpleeter@gmail.com>
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

A variable whose value is a list, of which GIT_CONFIG_GLOBAL is
currently the only one, is read into a single string whose elements are
joined with newlines, and "git var -l" splits that string apart again
before showing each element.  Round-tripping through a delimiter that
can legitimately appear in a value is fragile, and it forces every
future caller to know which variables need splitting.

Give "struct git_var" a separate "multiread" function that appends the
elements to a string_list, and let the single "read" function stay for
the variables that have exactly one value.  A variable uses one or the
other, never both, so which one is set also says whether the variable
is multi-valued.

The output is unchanged.  While at it, say in the documentation that
GIT_CONFIG_GLOBAL can have multiple values, so that callers know when
to expect a list.

Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
---
 Documentation/git-var.adoc |  1 +
 builtin/var.c              | 79 +++++++++++++++++++++-----------------
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 697c10aded..de3007732d 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -83,6 +83,7 @@ endif::git-default-pager[]
 
 `GIT_CONFIG_GLOBAL`::
     The path to the global (per-user) configuration files, if any.
+    This variable can have multiple values.
 
 Most path values contain only one value. However, some can contain multiple
 values, which are separated by newlines, and are listed in order from highest to
diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..9f7c8a6113 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -14,10 +14,11 @@
 #include "environment.h"
 #include "ident.h"
 #include "pager.h"
-#include "refs.h"
 #include "path.h"
-#include "strbuf.h"
+#include "refs.h"
 #include "run-command.h"
+#include "strbuf.h"
+#include "string-list.h"
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
@@ -90,35 +91,27 @@ static char *git_config_val_system(int ident_flag UNUSED)
 	return NULL;
 }
 
-static char *git_config_val_global(int ident_flag UNUSED)
+static void git_config_val_global(struct string_list *list)
 {
-	struct strbuf buf = STRBUF_INIT;
 	char *user, *xdg;
-	size_t unused;
 
 	git_global_config_paths(&user, &xdg);
 	if (xdg && *xdg) {
 		normalize_path_copy(xdg, xdg);
-		strbuf_addf(&buf, "%s\n", xdg);
+		string_list_append(list, xdg);
 	}
 	if (user && *user) {
 		normalize_path_copy(user, user);
-		strbuf_addf(&buf, "%s\n", user);
+		string_list_append(list, user);
 	}
 	free(xdg);
 	free(user);
-	strbuf_trim_trailing_newline(&buf);
-	if (buf.len == 0) {
-		strbuf_release(&buf);
-		return NULL;
-	}
-	return strbuf_detach(&buf, &unused);
 }
 
 struct git_var {
 	const char *name;
 	char *(*read)(int);
-	int multivalued;
+	void (*multiread)(struct string_list *);
 };
 static struct git_var git_vars[] = {
 	{
@@ -163,8 +156,7 @@ static struct git_var git_vars[] = {
 	},
 	{
 		.name = "GIT_CONFIG_GLOBAL",
-		.read = git_config_val_global,
-		.multivalued = 1,
+		.multiread = git_config_val_global,
 	},
 	{
 		.name = "",
@@ -175,28 +167,30 @@ static struct git_var git_vars[] = {
 static void list_vars(void)
 {
 	struct git_var *ptr;
-	char *val;
-
-	for (ptr = git_vars; ptr->read; ptr++)
-		if ((val = ptr->read(0))) {
-			if (ptr->multivalued && *val) {
-				struct string_list list = STRING_LIST_INIT_DUP;
-
-				string_list_split(&list, val, "\n", -1);
-				for (size_t i = 0; i < list.nr; i++)
-					printf("%s=%s\n", ptr->name, list.items[i].string);
-				string_list_clear(&list, 0);
-			} else {
+
+	for (ptr = git_vars; ptr->read || ptr->multiread; ptr++) {
+		if (ptr->read) {
+			char *val = ptr->read(0);
+
+			if (val) {
 				printf("%s=%s\n", ptr->name, val);
+				free(val);
 			}
-			free(val);
+		} else {
+			struct string_list list = STRING_LIST_INIT_DUP;
+
+			ptr->multiread(&list);
+			for (size_t i = 0; i < list.nr; i++)
+				printf("%s=%s\n", ptr->name, list.items[i].string);
+			string_list_clear(&list, 0);
 		}
+	}
 }
 
 static const struct git_var *get_git_var(const char *var)
 {
 	struct git_var *ptr;
-	for (ptr = git_vars; ptr->read; ptr++) {
+	for (ptr = git_vars; ptr->read || ptr->multiread; ptr++) {
 		if (strcmp(var, ptr->name) == 0) {
 			return ptr;
 		}
@@ -220,7 +214,6 @@ int cmd_var(int argc,
 	    struct repository *repo UNUSED)
 {
 	const struct git_var *git_var;
-	char *val;
 
 	show_usage_if_asked(argc, argv, var_usage);
 	if (argc != 2)
@@ -237,12 +230,26 @@ int cmd_var(int argc,
 	if (!git_var)
 		usage(var_usage);
 
-	val = git_var->read(IDENT_STRICT);
-	if (!val)
-		return 1;
+	if (git_var->read) {
+		char *val = git_var->read(IDENT_STRICT);
+
+		if (!val)
+			return 1;
 
-	printf("%s\n", val);
-	free(val);
+		printf("%s\n", val);
+		free(val);
+	} else {
+		struct string_list list = STRING_LIST_INIT_DUP;
+
+		git_var->multiread(&list);
+		if (!list.nr) {
+			string_list_clear(&list, 0);
+			return 1;
+		}
+		for (size_t i = 0; i < list.nr; i++)
+			printf("%s\n", list.items[i].string);
+		string_list_clear(&list, 0);
+	}
 
 	return 0;
 }
-- 
2.54.0 (Apple Git-157)

