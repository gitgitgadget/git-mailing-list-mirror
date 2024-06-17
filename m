Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B618F2CE
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615035; cv=none; b=pS+pC82DaxU4YuUA9eRq7LPFlqC5PLcVLzG2H+ST14y8578LCxU/BObKgfejoc5mbNcg/w0RLBg6jEqVUK5/gMMsd1a8zQ1SJ8nJWCKzECB0VEDo1iInKCAgNyxIJ7wUGkzOBuu2gwkUIXB9PIDUJ2KxoBLKcCcHRJiJboghphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615035; c=relaxed/simple;
	bh=Qgd78TN6am1o79+7mwACkb4xv/A7R8gnG/Hlm4v186Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=H6dGRqy0+zDH/jLvoT7V90XoBcOB9iAeyVDLbSMZPnslmX+l/1Aq1bUUyFGni2WWQ5CwX1ajFTlS6RHZopvE8nxeJYQEjiLvMzoCYWuQBjn+UWwRWGNPJk+ObJiEtCo2O6sPhWIAmSZn2btPfgdSGBDG9MQR2H279PluTGeVk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU5peD72; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU5peD72"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so36250595e9.2
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718615031; x=1719219831; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuZFZqPODb4Up1nJ6cQCuica5gYsxVUc3Mo6xQqIUf8=;
        b=UU5peD72aRs9989vt+y2yhR+/5pJmvBQup48XtbxcG/A1iSaC4fbGXorr83ADo6waW
         KE1rXyyMYgRskIBPcmN+rBsyUxWZDx3wpROuiwL7X0ckCv+elyGGnGPUXMpePMOxa4we
         lctp0+GjX/6MKjbdvQySn6MO+qHpwHpCeBGlXxAVwOs2/B+MfYtMPVmcezIFqpXRsvSx
         NWbfFDmw6V+yi2zhQiQN5Hm2SUl2m1zpKZCcEunx9xk896T5tQmPIiy8Kq/Bv4qOMP3M
         B3zFJJ75bJeZQXmzDDULdqQMg5JL8lfnO3cicVcW7bfgee0vgjuszjqMBvzmPEP2PCrJ
         kJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615031; x=1719219831;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuZFZqPODb4Up1nJ6cQCuica5gYsxVUc3Mo6xQqIUf8=;
        b=dcRqnUzqZ+DiKqDZ+HOIEtkh5EkH6XJNebLG1CWFyIoGRm5ZMGGOinje9NIVzrGZvM
         8WfcetNPFqM8T81kKsTqermvyb2SZXHsOSuy2xJgFYmdiKdmMEkuDgM/AQKHikLrgclp
         js5YCai96v++8eRhuZ0bl2rHQymCsqsMo4llLE1vopF0Iv0s+svqXmKjpUGjYAZLxNdd
         W+ju9c5ZLSir/4iM2SqN5QnGLz/h3Tkb/rNBT6zsk+bblWY4LptkvVVSRIQ68TWQOzK1
         x3+e/YW9P+aFLj5dQFuYYC+OXpA1eDGY3cCYxIvJGyEz4pSmVSM2qMiJcTrmw5rf2mue
         xehw==
X-Gm-Message-State: AOJu0YyGceGSHrsatYkoTwoIpos1LZg1YBWI5Lrd24lzjvpzIs7AFVn6
	PdE/Wmw2PMaMUAAvVB4JNYHn2L+oW1scdA3hXqBgKMfY9Bmon0owTyGFPQ==
X-Google-Smtp-Source: AGHT+IHTWgcKefLFjDeUMohoSqDvrHAsYeuTqDCqbUiwVBcaGq++MEXJkaIGiqCgouUsel7aU+RtfA==
X-Received: by 2002:a05:600c:4ca9:b0:422:52c3:7fe0 with SMTP id 5b1f17b1804b1-4230482c1e9mr77903155e9.22.1718615031052;
        Mon, 17 Jun 2024 02:03:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33be5sm155663135e9.2.2024.06.17.02.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:03:50 -0700 (PDT)
Message-Id: <5de72c45e767c4d704503c8cd5c8e6dce4ea04d6.1718615028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1751.git.1718615028.gitgitgadget@gmail.com>
References: <pull.1751.git.1718615028.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Miguel=20=C3=81ngel=20Pastor=20Olivar?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 09:03:48 +0000
Subject: [PATCH 2/2] cat-file: configurable "best effort mode" for symlink
 resolution
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

This patch introduces a new "best effort mode" where the object found at
resolution step N is returned. If we've reached the end of the chain, the
returned object will be the file at the end of the chain, however, if, after
n resolutions we haven't reached the end of the chain, the returned object
will represent a symlink

The goal is to extend the symlink resolution process and provide the ability
to return the object found at the designated depth instead of returning an
error.

The current code already provides a limit to the maximum number of
resolutions that can be performed and something similar to this is returned
back to the caller:

loop SP <size> LF <object> LF

With the new config setting we are looking to return the actual information
of the object where the resolution stopped. Something similar to:

<oid> blob <size>\ndata\n

Signed-off-by: Miguel Ángel Pastor Olivar <migue@github.com>
---
 Documentation/config/core.txt | 16 +++++++++++++++-
 config.c                      | 13 +++++++++++++
 environment.c                 |  2 ++
 environment.h                 |  7 +++++++
 t/t1006-cat-file.sh           | 29 +++++++++++++++++++++++++++++
 tree-walk.c                   | 11 +++++++++++
 6 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index ca2d1eede52..706f316c89e 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -761,4 +761,18 @@ core.maxTreeDepth::
 core.maxSymlinkDepth::
 	The maximum number of symlinks Git is willing to resolve while
 	looking for a tree entry.
-	The default is GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS.
\ No newline at end of file
+	The default is GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS.
+
+core.symlinkResolutionMode::
+	The result returned by the symlink resolution process when
+	core.maxSymlinkDepth is reached. When set to "error"
+	`
+	loop SP <size> LF
+	<object> LF
+	` is returned.
+	If `best-effort` is set, the resolution process will return
+	something like:
+	`
+	<oid> blob <size> 120000\nname\n
+	`
+	The default is "error".
\ No newline at end of file
diff --git a/config.c b/config.c
index d69e9a3ae6b..fa753565e68 100644
--- a/config.c
+++ b/config.c
@@ -1687,6 +1687,19 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "core.symlinkresolutionmode")) {
+		if (!value)
+			symlink_resolution_mode = SYMLINK_RESOLUTION_MODE_ERROR;
+		if (!strcmp(value, "error"))
+			symlink_resolution_mode = SYMLINK_RESOLUTION_MODE_ERROR;
+		else if (!strcmp(value, "best-effort"))
+			symlink_resolution_mode =
+				SYMLINK_RESOLUTION_MODE_BEST_EFFORT;
+		else
+			warning(_("ignoring unknown core.symlinkresolutionmode value '%s'"),
+				value);
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return platform_core_config(var, value, ctx, cb);
 }
diff --git a/environment.c b/environment.c
index 6d7a5001eb1..a497331f2bc 100644
--- a/environment.c
+++ b/environment.c
@@ -96,6 +96,8 @@ int max_allowed_tree_depth =
 	2048;
 #endif
 int max_symlink_depth = -1;
+enum symlink_resolution_mode symlink_resolution_mode =
+	SYMLINK_RESOLUTION_MODE_ERROR;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/environment.h b/environment.h
index ea39c2887b1..5a6eebb061b 100644
--- a/environment.h
+++ b/environment.h
@@ -143,6 +143,13 @@ extern unsigned long pack_size_limit_cfg;
 extern int max_allowed_tree_depth;
 extern int max_symlink_depth;
 
+enum symlink_resolution_mode {
+	SYMLINK_RESOLUTION_MODE_ERROR = 0,
+	SYMLINK_RESOLUTION_MODE_BEST_EFFORT
+};
+
+extern enum symlink_resolution_mode symlink_resolution_mode;
+
 /*
  * Accessors for the core.sharedrepository config which lazy-load the value
  * from the config (if not already set). The "reset" function can be
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index fd7ab1d1eff..c1d807a0d7f 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1113,6 +1113,35 @@ test_expect_success 'git cat-file --batch --follow-symlink stop resolving symlin
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file --batch --follow-symlink stop resolving symlink at designated depth with error mode config' '
+	printf "loop 22\nHEAD:link-to-symlink-3\n">expect &&
+	printf 'HEAD:link-to-symlink-3' | git -c core.maxsymlinkdepth=1 -c core.symlinkresolutionmode=error cat-file --batch="%(objectname) %(objecttype) %(objectsize)" --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	printf 'HEAD:link-to-symlink-3' | git -c core.maxsymlinkdepth=2 -c core.symlinkresolutionmode=error cat-file --batch="%(objectname) %(objecttype) %(objectsize)" --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	printf 'HEAD:link-to-symlink-3' | git -c core.maxsymlinkdepth=3 -c core.symlinkresolutionmode=error cat-file --batch="%(objectname) %(objecttype) %(objectsize)" --follow-symlinks > actual &&
+	test_cmp expect actual &&
+	oid=$(git rev-parse HEAD:morx) &&
+	printf "${oid} blob 11\nHello World\n" >expect &&
+	printf 'HEAD:link-to-symlink-3' | git -c core.maxsymlinkdepth=4 cat-file --batch="%(objectname) %(objecttype) %(objectsize)" --follow-symlinks > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch --follow-symlink return object info at designated depth' '
+	oid=$(git rev-parse HEAD:link-to-symlink-1) &&
+	printf "${oid} blob 13\nsame-dir-link\n" >expect &&
+	printf 'HEAD:link-to-symlink-1' | git -c core.maxsymlinkdepth=1  -c core.symlinkresolutionmode=best-effort cat-file --batch="%(objectname) %(objecttype) %(objectsize)" --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	oid=$(git rev-parse HEAD:same-dir-link) &&
+	printf "${oid} blob 4\nmorx\n" > expect &&
+	printf 'HEAD:link-to-symlink-1' | git -c core.maxsymlinkdepth=2  -c core.symlinkresolutionmode=best-effort cat-file --batch="%(objectname) %(objecttype) %(objectsize)" --follow-symlinks >actual &&
+	test_cmp expect actual &&
+	oid=$(git rev-parse HEAD:morx) &&
+	printf "${oid} blob 11\nHello World\n" > expect &&
+	printf 'HEAD:link-to-symlink-1' | git -c core.maxsymlinkdepth=3  -c core.symlinkresolutionmode=best-effort cat-file --batch="%(objectname) %(objecttype) %(objectsize)" --follow-symlinks >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cat-file --batch-all-objects shows all objects' '
 	# make new repos so we know the full set of objects; we will
 	# also make sure that there are some packed and some loose
diff --git a/tree-walk.c b/tree-walk.c
index 3ec2302309e..ee861fd6351 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -821,6 +821,17 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 			contents_start = contents;
 
 			parent = &parents[parents_nr - 1];
+
+			if (follows_remaining == 0 &&
+			    symlink_resolution_mode ==
+				    SYMLINK_RESOLUTION_MODE_BEST_EFFORT) {
+				strbuf_addstr(result_path, contents);
+				oidcpy(result, &current_tree_oid);
+				free(contents);
+				retval = FOUND;
+				goto done;
+			}
+
 			init_tree_desc(&t, &parent->oid, parent->tree, parent->size);
 			strbuf_splice(&namebuf, 0, len,
 				      contents_start, link_len);
-- 
gitgitgadget
