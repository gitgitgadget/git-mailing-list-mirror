Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65737237707
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771567496; cv=none; b=VcwNXezh1q8ooaj7UZxCNdhCiBGFEx2KUyDrqpT0UlHTOWDQdOPfKm1mFCveglLCdbpiFnvL96CUQm6Cl9WfrWT6njE+4jiik+tVeEwpmM1MyqJYmtvdI8oXfyO3jHJoxXu9FYMuTKraYNWd6QJ7jsKZB7Sny8dG0cjcU43tyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771567496; c=relaxed/simple;
	bh=KOX99Fu6qPslRs6o95/x9yItcoAiv7hxk65IB2ppHo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPedCG8DfuFScNiUUQwC3ITBOClgtnwspck3nyiRXefWMcF9GnM5JQObKKx02mHNQTXqQ18OFZCaLOdwZYhJp8e7xuykLliwC53euIViupy19teD1gKGO0zUdnPTG7P/tIVNENNPeF82XHDgdDyMxkbpPY1c2RI+HVXtEmtJYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUylYgWq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUylYgWq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371bb515eso21789475e9.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 22:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771567493; x=1772172293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDiqhpwZpZtMvnekmH6SRMu+AY4tzYZsVxLUFyyQ0/8=;
        b=MUylYgWqDhTCGQAoyhFfx7n2VCmmJyccI7JW2FPl9du9UqpJpg6GWiQpTrkZqamY1a
         h3LplHaOwRwMbcvS3IWcjVfbvYhHNvrkXluSToNpK9nhCBmkaWTXdKic2pOGJpAXh1MX
         d1NshMYO04taTQYvTiXYHrnhcZ3ENjIvVx6e1zXBwsrv8TkwVNo7S5uhtr8C65PuGx8B
         99cKTKfIretwv9L0UD5WzwZmUQDms3PKGNjMleATlohZcngPFRQt/lEEjNzGfJ1yAVLj
         11I0Ceoa6HLswxxzD88J7uc/B6VFyNanMDIHrFCBpgWgoU0c0qGoI7s9OAsOhmJ16VGx
         qiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771567493; x=1772172293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MDiqhpwZpZtMvnekmH6SRMu+AY4tzYZsVxLUFyyQ0/8=;
        b=czphUHiWDkcTdHhoUTudXa/k06Zo9QYteBejAVM2meRgKe+A+ZXxzSKk5jeD+7vdHA
         B2jw7pxJTD542D9WsYbt1/drHpYWe7OLQy1gGWvyUM73OW9Qr0meXBJf8WQR6JseiB5M
         qz9y3bGvszmjdNhtyvsQ3qihhrxZ9hkB5ftpyj76QmTXc8rkDP4mPzCiu9BvWfmrm+oz
         eFsAM9bpvz3JanbL/IUKymng3ITSHrlHo7a0j/4LNfLv9Z5o4ibePKJvX6mhw8e0VGE8
         nThEILbqQ77oCl9KFlgfCuPdwzhYUvVqDmHlfQetdFWWSXHGH6WFUvp/WXj2amZKcxyG
         oZJA==
X-Gm-Message-State: AOJu0YxjP1VYx9AhYpLxAs+pG5x7J7+s+opr0TS+krqwNey9KCVbQ6l9
	bvkSluumcm884CAbN3ox6t0HnUFJcFxxfhgNLlNnuAlUNSqExhIP2CSNvTsYwA==
X-Gm-Gg: AZuq6aL20UVXDSSuqiCwiNEKp+WUfeTkcamhqadlvIO3+h86j72fIHSmOjYZMYRQiAU
	UdyNCisNi0NsvHWqGWXTqGVUVdArPHdONtPaHjBOmy86K3skeIkawgz1weMD/rTl5y7c1ML0Skm
	qsNoQlH13CQiGPSd7rtqEz/liFlCLEr5DNrZ5YVeRtK8ynkEYGNg9BOQelyIL2XqN71goMIQ3vy
	m+oD9uDraOVjnBaHAgfHWC+T/k1CAa47Gi3aSFLl3EqUaJaRA/f6O0AyYEOdGrkKO05IpQMZwP+
	zQ9uma4oeCdi8qakvSThbjrQI+0oj3RjYx/WMhF+9UzWK5TJfUNxbep6o3tpyrZHZRrUcqELlzU
	XHuwAJl9aFYwkkhFfWNJOGatkFhPWHFIHLiVFTgpIaZMTArrF2wOilKuDMtsPFOrylVJrB0e7u+
	ukqBKPvKpIxicHPfM6aNyacgV5H9iuX7GEew==
X-Received: by 2002:a05:600c:3110:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-48398b6dba0mr127764715e9.25.1771567493203;
        Thu, 19 Feb 2026 22:04:53 -0800 (PST)
Received: from fedora.marun.edu.tr ([193.255.169.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm43477255e9.5.2026.02.19.22.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 22:04:52 -0800 (PST)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [GSOC PATCH v2 2/2] mailmap: drop global config variables
Date: Fri, 20 Feb 2026 09:04:42 +0300
Message-ID: <20260220060442.29469-3-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220060442.29469-1-bkkaracay@gmail.com>
References: <20260219125954.3539324-1-bkkaracay@gmail.com>
 <20260220060442.29469-1-bkkaracay@gmail.com>
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
index cf70956675..3b2691781d 100644
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
index fda329d715..6866cb6f1d 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -4,9 +4,6 @@
 struct repository;
 struct string_list;
 
-extern char *git_mailmap_file;
-extern char *git_mailmap_blob;
-
 /* Flags for read_mailmap_file() */
 #define MAILMAP_NOFOLLOW (1<<0)
 
-- 
2.52.0

