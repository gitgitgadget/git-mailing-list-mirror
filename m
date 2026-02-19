Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683F33A717
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506014; cv=none; b=BfHuDkx/WjLGUosnHLZUAfjh5olQK4xbIbiD8m/P/o5gNqvkmgkWYj5y1WwMwMrbiAvKGQXsVdbnTdF6nbdqE8sASbKywwuPgj872cD0hBdihLtzbYY19Yhxs6Oiftk1OIanD4C5YC9coCjuaRydBHK2UdlhW3L6fv7rDPY+0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506014; c=relaxed/simple;
	bh=1UMv4KreyEDSYIsUfxvx07NiVJ+yrxVYq+GrE6mPS1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8Lr4znaY5KgdoxEqi3KvZ9Es0MZdB5EWrWkB6XrbzW86qFG+TGIjiNKDyYg7lnU3thH6zwyPYVWImTmfY+yNuG6Vlwf/eorbf8iGbOug+c/i096RaBi7cbfHiIXWpzphs0rjf1YtZ9PNJTvoAQgfmw55Vuao+XHhjoucLsH0To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ir0480Xf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir0480Xf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso8170045e9.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 05:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771506011; x=1772110811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqoJs0JoNMZDX6JzfDAxTXlr6uNdPrHRrLk3yWXNefU=;
        b=ir0480XfNmeko+QjAdN7+GGopOOCBN3YyJyqWQiGzNomj8edXFeetOWNueV4+UIPBk
         ol7nR8CWj+ZLTr1NKfZtTm6CcQWjUbdsn3OBsgbxMgAenVUA5FucosP1waRiCXzNuQlh
         zUXqzpaUS873aNXXUlAU2dgzgLQF+DAVsYMzf7JhO+XZUqR3ET8l7p0SX+cnSEd7E7//
         OCCI+Jwsz7cXxm1ZMOdLX8JZrlFwrmPXpV8qUJg7Ag39J7Vpim49W44pK3w8JNESIEkF
         3LE3ouiKrzUtodxbX2nXOVq5BVZzrzDdjA5l3234lF7akCtY6C75FdnuFAFbp6Rhgr21
         RvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771506011; x=1772110811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HqoJs0JoNMZDX6JzfDAxTXlr6uNdPrHRrLk3yWXNefU=;
        b=qbFtA8vFd/iKS5deNxp7EO5Pvk7oXkFcbu4va0qtTPC+s3VyCz2maMJDXiD1m/7Gqc
         FroEcNtHsfyLIESV/pJvDMydFr45O65DP0SnVSSlbqDgPHMY2cEevPEULcCmMXxKnQYC
         kBA2FiIzmQ+CIAF0taEt+jLPerntpt3j8qzOd0Ol6fhcpa+u1Cb+rt8lE2Njq2nzrRSj
         GhMtNdWgnCOLQcv0p9/s3I2Ey55o+3Krq47mr50p0XAs401TqVtoCfe2OwX/J+Zyrd4P
         ANBL25JNNFV/tpt5l9g7gn3iCCD4qCKlXF2zj+t0IPa3tTNt+Oa0b00qmchrD6NUcsiF
         h3WQ==
X-Gm-Message-State: AOJu0YzAF5iu61otfMnN1zmt1/8oGVnb4yEdbL5Qm4+ZswRlLQaDoBDj
	ZVCH4xvIQojxD+X3Y6SVXvOngMhT7F4E5/J58Hy9hmoSCCK6hpMtUmPzE9fZkw==
X-Gm-Gg: AZuq6aKknAXlhTwWE1kdNtwg1btHSyM02GRPREWrG3PMGqoU7LSWlXq2ZpmdT8ilmsU
	3ihSB4Gd1nZ8W9CRlvwAqRyccJ9gi6LZ1S9wbSY22ZnKlxiUyXywQBchC26ZM96rsqbcYPO4lKC
	oRJD4I05yxBdRU5DB3mADkLP5Q7UTy21kRQqbob8zVO17E0uuriQxePnKZ45TsSslFFziEbtq+c
	eDvDsqj4LEASTaHYWkvg5dgFOg/s2RbDHn7MoHn+0HzgP+oogKk/OOOQ7Vve7Us2AhT1FHC9abv
	IEQkAFvr3HfJ1zGfPSIEz/PHrVKPNmyGntg+FAUAN/eahd7NghmJWyUMQvWS+XEmZqeosYIJrwy
	2sc+wB40IWMvqkBSO1PmaK4eoxzVCsp9qfA3Le1uh4ni1LklNprHZ2sXM19lzGjj/pL70IVUgVm
	LiYinEqcFLWK+FKaQ=
X-Received: by 2002:a05:600c:1d19:b0:483:a2db:6743 with SMTP id 5b1f17b1804b1-483a2db6aabmr7673545e9.4.1771506011441;
        Thu, 19 Feb 2026 05:00:11 -0800 (PST)
Received: from fedora ([159.146.42.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c0779sm4603015e9.6.2026.02.19.05.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 05:00:11 -0800 (PST)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	ps@pks.im,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [GSOC PATCH 2/2] mailmap: drop global config variables
Date: Thu, 19 Feb 2026 15:59:54 +0300
Message-ID: <20260219125954.3539324-3-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219125954.3539324-1-bkkaracay@gmail.com>
References: <20260219125954.3539324-1-bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 'mailmap.file' and 'mailmap.blob' configurations are currently
parsed and stored in the global variables 'git_mailmap_file' and
'git_mailmap_blob'. Since these values are typically only needed once
when initializing a mailmap, there is no need to keep them as global
state throughout the lifetime of the Git process.

To reduce global state, remove these global variables and instead use
'repo_config_get_*' functions to read the configuration on demand.

Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
---
 environment.c | 19 -------------------
 mailmap.c     | 21 ++++++++++++++-------
 mailmap.h     |  3 ---
 3 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/environment.c b/environment.c
index 0026eb2274..2764d8f481 100644
--- a/environment.c
+++ b/environment.c
@@ -647,22 +647,6 @@ static int git_default_push_config(const char *var, const char *value)
 	return 0;
 }
 
-static int git_default_mailmap_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "mailmap.file")) {
-		FREE_AND_NULL(git_mailmap_file);
-		return git_config_pathname(&git_mailmap_file, var, value);
-	}
-
-	if (!strcmp(var, "mailmap.blob")) {
-		FREE_AND_NULL(git_mailmap_blob);
-		return git_config_string(&git_mailmap_blob, var, value);
-	}
-
-	/* Add other config variables here and to Documentation/config.adoc. */
-	return 0;
-}
-
 static int git_default_attr_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "attr.tree")) {
@@ -697,9 +681,6 @@ int git_default_config(const char *var, const char *value,
 	if (starts_with(var, "push."))
 		return git_default_push_config(var, value);
 
-	if (starts_with(var, "mailmap."))
-		return git_default_mailmap_config(var, value);
-
 	if (starts_with(var, "attr."))
 		return git_default_attr_config(var, value);
 
diff --git a/mailmap.c b/mailmap.c
index 6628975f30..cdae3f65bc 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -7,9 +7,7 @@
 #include "object-name.h"
 #include "odb.h"
 #include "setup.h"
-
-char *git_mailmap_file;
-char *git_mailmap_blob;
+#include "config.h"
 
 struct mailmap_info {
 	char *name;
@@ -213,20 +211,29 @@ int read_mailmap_blob(struct repository *repo, struct string_list *map,
 int read_mailmap(struct repository *repo, struct string_list *map)
 {
 	int err = 0;
+	char *mailmap_file = NULL, *mailmap_blob = NULL;
+
+	repo_config_get_pathname(repo, "mailmap.file", &mailmap_file);
+	repo_config_get_string(repo, "mailmap.blob", &mailmap_blob);
 
 	map->strdup_strings = 1;
 	map->cmp = namemap_cmp;
 
-	if (!git_mailmap_blob && is_bare_repository())
-		git_mailmap_blob = xstrdup("HEAD:.mailmap");
+	if (!mailmap_blob && is_bare_repository())
+		mailmap_blob = xstrdup("HEAD:.mailmap");
 
 	if (!startup_info->have_repository || !is_bare_repository())
 		err |= read_mailmap_file(map, ".mailmap",
 					 startup_info->have_repository ?
 					 MAILMAP_NOFOLLOW : 0);
 	if (startup_info->have_repository)
-		err |= read_mailmap_blob(repo, map, git_mailmap_blob);
-	err |= read_mailmap_file(map, git_mailmap_file, 0);
+		err |= read_mailmap_blob(repo, map, mailmap_blob);
+	
+	err |= read_mailmap_file(map, mailmap_file, 0);
+
+	free(mailmap_file);
+	free(mailmap_blob);
+
 	return err;
 }
 
diff --git a/mailmap.h b/mailmap.h
index 11346835cb..36d5d10daf 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -3,9 +3,6 @@
 
 struct string_list;
 
-extern char *git_mailmap_file;
-extern char *git_mailmap_blob;
-
 /* Flags for read_mailmap_file() */
 #define MAILMAP_NOFOLLOW (1<<0)
 
-- 
2.52.0

