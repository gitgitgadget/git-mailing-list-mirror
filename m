Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC2374D9
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615034; cv=none; b=fv93U+0k6hs27Ry5pGcvI7arE2iOmSMMccbfGW8nypbl3xhkQK1yXr80My6Lu4QDcnSKcngdvBke1E9vV32JVj9m9/9LFLn4u/PxdN0lC5LoyDfwh7yu1uKRDipwhT2gk06+hcuNc0SY0rqlBvT1jm3igKzuaMThEYfPzF8sRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615034; c=relaxed/simple;
	bh=ehbenQxsdavUEI9yIW4vkNOH5l/s+m7737KhE5jqgAw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=N/w+01N/j/27ldUA1dVZbSLVmPOizui1vwW0vwO7hcKOYzFQ3MmaTMatpSVZTu7Bp7wQho4nApAuISh9TFzxGb1bdAXeCZzCE/4T4SMQwxELpYAJRYuxzdsEzwv//CmlEVxuljGYYOBNnVnCmVV4utnd9r4vW2Mcxylb+h5zUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0OBHorA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0OBHorA"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c94cf4c9bso4959238e87.2
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718615030; x=1719219830; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIvtaGI/youAs6lDvm5FvvrUzP/n2N0dEWVsonkbeQU=;
        b=g0OBHorADiaHFpAeXta6gBI3Ed4gyxzHVTNH0HQXnTAFdIWcVbpsnm0RqOWkH4EMrQ
         K+yDngHVthE3rMXkpDHq4a9AkqMACQmsGmWorc8kQmnE2G1bVTAdC9AOQXqfnPobLhdX
         Tw4ZHoZXkb5GxZc7eU018CU3F/qBYcJ2EaHT2VVPDEwRMX2rPzAH4IN8gh57oJfpFm2U
         Gjtmysykl966Whl4reWOtmdHdDCOKWnYElRFXK1JC9FPDyjGMZk4cRWIaOTDePdl7gVs
         dEnzXwFXhDavZWsuRmeCik3e7q7QnSd/9pFjWCc4BTEhnvBYdnIgvA6MuvpuJLM6QgzY
         a/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615030; x=1719219830;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIvtaGI/youAs6lDvm5FvvrUzP/n2N0dEWVsonkbeQU=;
        b=dFh/PsqTX82y/mL6Llwt2fdCrCDJ+E1L2Exdh9jBONysrV8mOUoFq3V5YIsAwrwKCP
         v6lYm2uXAVuTYEquXS4dsa0Dhc23PBPp0aSudpRXxI0JtQx+vry338wvWxln9tv9RpDo
         V1voXCghGuUsx3a9Zk+gnQ0W1yeyBEe7EZEF0zyOpZvCkmZRnp7otJdgcDUhltJJNqhT
         AE1t0MKtYRf1Tw+1LFFXEJxLn90zpCUYP1wnwveDRoUrjv6hqlUP5oid3fZQNMSBLbP3
         knUus+424Ftu8gXjU0v/J4/pK/Nnq+wflZifdOcDCi6tbl3QX8905pzK4s4/wMkSFJC2
         zY7g==
X-Gm-Message-State: AOJu0YxQ0IW15esUQ/NAh3CQhcQ61fTk/FemWzTbOzWTbhDfH58bKd/Y
	JCg/kj6QccKOYb1+/AYN3hXcfb4WFZ2AJ6RHdn1UmS3hShzokBjH6dehOQ==
X-Google-Smtp-Source: AGHT+IEgmXtI5ovcmjSsJoE4s5EOIhDfShOoPv/rzgqYViwLZYr+NzZXzbsUAxXpCOW6npN698bzHg==
X-Received: by 2002:ac2:5a44:0:b0:52b:bc4c:5c35 with SMTP id 2adb3069b0e04-52ca6e6e7fcmr7409640e87.39.1718615030289;
        Mon, 17 Jun 2024 02:03:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360751037absm11331908f8f.91.2024.06.17.02.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:03:49 -0700 (PDT)
Message-Id: <cbf38c7281de33289f622c9926c75744323311af.1718615028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1751.git.1718615028.gitgitgadget@gmail.com>
References: <pull.1751.git.1718615028.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Miguel=20=C3=81ngel=20Pastor=20Olivar?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 09:03:47 +0000
Subject: [PATCH 1/2] cat-file: configurable number of symlink resolutions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Miguel =?UTF-8?Q?=C3=81ngel?= Pastor Olivar <miguelinlas3@gmail.com>,
    =?UTF-8?q?Miguel=20=C3=81ngel=20Pastor=20Olivar?= <migue@github.com>

From: =?UTF-8?q?Miguel=20=C3=81ngel=20Pastor=20Olivar?= <migue@github.com>

Sometimes, it can be useful to limit the number of symlink resolutions
performed while looking for a tree entry.

The goal is to provide the ability to resolve up to a particular depth,
instead of reaching the end of the link chain.

The current code already provides a limit to the maximum number of
resolutions that can be performed
(GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS). This patch introduces a new
config setting to make the previous property configurable. No logical
changes are introduced in this patch

Signed-off-by: Miguel Ángel Pastor Olivar <migue@github.com>
---
 Documentation/config/core.txt |  5 +++++
 config.c                      |  5 +++++
 environment.c                 |  1 +
 environment.h                 |  1 +
 t/t1006-cat-file.sh           | 17 +++++++++++++++++
 tree-walk.c                   |  7 ++++++-
 6 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 93d65e1dfd2..ca2d1eede52 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -757,3 +757,8 @@ core.maxTreeDepth::
 	tree (e.g., "a/b/cde/f" has a depth of 4). This is a fail-safe
 	to allow Git to abort cleanly, and should not generally need to
 	be adjusted. The default is 4096.
+
+core.maxSymlinkDepth::
+	The maximum number of symlinks Git is willing to resolve while
+	looking for a tree entry.
+	The default is GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS.
\ No newline at end of file
diff --git a/config.c b/config.c
index abce05b7744..d69e9a3ae6b 100644
--- a/config.c
+++ b/config.c
@@ -1682,6 +1682,11 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "core.maxsymlinkdepth")) {
+		max_symlink_depth = git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return platform_core_config(var, value, ctx, cb);
 }
diff --git a/environment.c b/environment.c
index 701d5151354..6d7a5001eb1 100644
--- a/environment.c
+++ b/environment.c
@@ -95,6 +95,7 @@ int max_allowed_tree_depth =
 #else
 	2048;
 #endif
+int max_symlink_depth = -1;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/environment.h b/environment.h
index e9f01d4d11c..ea39c2887b1 100644
--- a/environment.h
+++ b/environment.h
@@ -141,6 +141,7 @@ extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
 extern int max_allowed_tree_depth;
+extern int max_symlink_depth;
 
 /*
  * Accessors for the core.sharedrepository config which lazy-load the value
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index e12b2219721..fd7ab1d1eff 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -878,6 +878,9 @@ test_expect_success 'cat-file -t and -s on corrupt loose object' '
 test_expect_success 'prep for symlink tests' '
 	echo_without_newline "$hello_content" >morx &&
 	test_ln_s_add morx same-dir-link &&
+	test_ln_s_add same-dir-link link-to-symlink-1 &&
+	test_ln_s_add link-to-symlink-1 link-to-symlink-2 &&
+	test_ln_s_add link-to-symlink-2 link-to-symlink-3 &&
 	test_ln_s_add dir link-to-dir &&
 	test_ln_s_add ../fleem out-of-repo-link &&
 	test_ln_s_add .. out-of-repo-link-dir &&
@@ -1096,6 +1099,20 @@ test_expect_success 'git cat-file --batch --follow-symlink returns correct sha a
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file --batch --follow-symlink stop resolving symlinks' '
+	printf "loop 22\nHEAD:link-to-symlink-3\n">expect &&
+	printf 'HEAD:link-to-symlink-3' | git -c core.maxsymlinkdepth=1 cat-file --batch="%(objectname) %(objecttype) %(objectsize)" --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	printf 'HEAD:link-to-symlink-3' | git -c core.maxsymlinkdepth=2 cat-file --batch="%(objectname) %(objecttype) %(objectsize)" --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	printf 'HEAD:link-to-symlink-3' | git -c core.maxsymlinkdepth=3 cat-file --batch="%(objectname) %(objecttype) %(objectsize)" --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	oid=$(git rev-parse HEAD:morx) &&
+	printf "${oid} blob 11\nHello World\n" >expect &&
+	printf 'HEAD:link-to-symlink-3' | git -c core.maxsymlinkdepth=4 cat-file --batch="%(objectname) %(objecttype) %(objectsize)" --follow-symlinks > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cat-file --batch-all-objects shows all objects' '
 	# make new repos so we know the full set of objects; we will
 	# also make sure that there are some packed and some loose
diff --git a/tree-walk.c b/tree-walk.c
index 6565d9ad993..3ec2302309e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -664,7 +664,12 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 	struct object_id current_tree_oid;
 	struct strbuf namebuf = STRBUF_INIT;
 	struct tree_desc t;
-	int follows_remaining = GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
+	int follows_remaining =
+		max_symlink_depth > -1 &&
+				max_symlink_depth <=
+					GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS ?
+			max_symlink_depth :
+			GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
 
 	init_tree_desc(&t, NULL, NULL, 0UL);
 	strbuf_addstr(&namebuf, name);
-- 
gitgitgadget

