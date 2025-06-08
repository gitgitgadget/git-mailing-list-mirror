Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E3BA3F
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749344861; cv=none; b=VIvuPNvFEP4GR9PXZ0aEIsHd/SpsZZzzO12myLmzD5b/ddXGcIAR3nKkYNQ2LvTGQZQ4rRjNXlO1kzV/Qx2AwJwF+iRZGpMKQ1uj5iJhbfRsLQPqOR6NsAktHvIZ+SuuMfOslYAcBAn3JCU2TMitfez1bZRR7vqYaO6YcrvwUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749344861; c=relaxed/simple;
	bh=ZwvU+ZPiTXJfM0T4t7iJHKt6vzyo51dbfiykhNyr4CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwnUtM9HeE3jaSqjORNA5stIvZVKUpSt0qxrvlcoJQMxn2JRZtHRAL3hkBFLAMgNomfxVbGKn9EuMsaR2HRkstLGoOSOQPTZln35TJEiIah8IGidpM3iGURw5rB1FpsyhO7Oo/ozI62ecMM1eSwC1iehnFIxBfie6nhnDhe9vI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxSLzTLi; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxSLzTLi"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so2527048b3a.1
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749344856; x=1749949656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qwzfOzl0V9ODB1JbSDPXEzENHo0TMjJCJjmObT5bEw=;
        b=OxSLzTLivslECIQXlY6HFvIL8xvm1eYAapWvqSPClqchTEEYrH8ykgvqFFIrLehihu
         yB+jEnYGwqQseYQQJ7Bn2QTlq8mnZvVqsA3RMQ1/SInbMakK5HmwmRLx8Gm68syfntiC
         4Ol2DGtwo+8TMnMyP01804/2NU3J/++LBzgbw+rqdvZAm19c37l18XbhEH3DW1EDQbcP
         FO7NJ0IT+HdSn946CA2h/Nw8luueHTDWI2TG0jLBV0/lTLr6EE5grwag2njockeO+6fZ
         rt5TgCsvstU130utL5SaYJRqjM9k9PEtHHAKBBSLeT57ARuZO0KhIJOurtD5s9tCSeJa
         eYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749344856; x=1749949656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qwzfOzl0V9ODB1JbSDPXEzENHo0TMjJCJjmObT5bEw=;
        b=xHk3buTRWWRRwEtylfsP2+ajtzmprags2s1cYdCyHCVrJlcFFzSsFssLzZOm7sK5+N
         c06GwlOKjUtOy7IFLLTGip26N2JGZq1/TFfyvoGeYxLRcbwfCUYlhjdJTfkebEhtxAX2
         pDVTSCnFNBCxWuSk/MvYtSchDRu7ES5P8aIbObN2jC19AFVjIJtuAqgo4wtao/27BE1E
         7tJEvItyiUpKpJ1JimlVVznUkJKkJxcIcWFj6b19rJDz1IO0fAK5LgsVGboB8ZXP/zhx
         S2C7a/tJw5UVuLASBChyvlEEfk80B4CegSWhlaio3qFzbcA/PzxaWdpdDMOrq1N9Ux6o
         YGxw==
X-Gm-Message-State: AOJu0YyvlbJ+jx8ivQ8V60PuJfFy/yrLKYbZ200hbQrUSc4t+cuu6W0R
	yzhTdatFmAulAidc/PPS/4nuivLNBRL8R6J7ZhElBFeQyBl/+W4kXUfT32HGEPGf
X-Gm-Gg: ASbGncswWdk3rNweRzND4kK1upmX3D4LYEhPWrUY771zUOYuYZbsqAyHackHWDkWm0W
	kws90DoXuQHJVNs38x1/VmFUeXMQkjkbhGItwu7Qm2GZn6acgJmnJxRuJlQssVihAP6lOO/v51A
	4dFtn+EyIzC/8DWeA7pS+Dhdr+fANe+sBtQmCLBTWSTN6cvzWP8abJ4IQcYIVt4h50qQS60OAZa
	qwPzZPdebb2nFeI+nQreCvup87PLdWHeH+QrEiC/Zo1jON07BHvkhkfSBxYcFajcrI57XCYCcpA
	xJWU9pM98XasPJl3QcialfDRMEZRnkPE7Kecwvas2sd8DqNW8flXnyBG83iGSZsTvzb/F1Bz55w
	EI1A=
X-Google-Smtp-Source: AGHT+IGMoimxhuYmu0YUamnwGxMn/DQEofsr7ch5Y6pkVotO74FTdUUpK7MGZuBBacUrdjeOx7y9gQ==
X-Received: by 2002:a05:6a00:4603:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-748292e42b9mr10556696b3a.2.1749344856525;
        Sat, 07 Jun 2025 18:07:36 -0700 (PDT)
Received: from thinku.localdomain ([2409:40c2:103a:88af:d97c:9fa4:c832:49bf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0836bdsm3451716b3a.93.2025.06.07.18.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 18:07:36 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [GSOC PATCH 1/2] repository: move 'repository_format_precious_objects' to repo scope
Date: Sun,  8 Jun 2025 06:36:34 +0530
Message-ID: <6ffb071295272a1d5311f52d8d2015d0aec7e71f.1749343601.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749343601.git.ayu.chandekar@gmail.com>
References: <cover.1749343601.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'extensions.preciousObjects' settings when set true, prevents
operations that might drop objects from the object storage.
This setting is populated in the global variable
'repository_format_precious_objects'.
Move this global variable to repo scope by adding it to 'struct
repository' and also refactor all the occurences accordingly.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/gc.c     | 2 +-
 builtin/prune.c  | 2 +-
 builtin/repack.c | 2 +-
 environment.c    | 1 -
 environment.h    | 2 --
 repository.c     | 1 +
 repository.h     | 1 +
 setup.c          | 5 ++++-
 8 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e33ba946e4..764f123b1c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -976,7 +976,7 @@ int cmd_gc(int argc,
 
 	gc_before_repack(&opts, &cfg);
 
-	if (!repository_format_precious_objects) {
+	if (!the_repository->repository_format_precious_objects) {
 		struct child_process repack_cmd = CHILD_PROCESS_INIT;
 
 		repack_cmd.git_cmd = 1;
diff --git a/builtin/prune.c b/builtin/prune.c
index e930caa0c0..dab3c19b6f 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -177,7 +177,7 @@ int cmd_prune(int argc,
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
 
-	if (repository_format_precious_objects)
+	if (the_repository->repository_format_precious_objects)
 		die(_("cannot prune in a precious-objects repo"));
 
 	while (argc--) {
diff --git a/builtin/repack.c b/builtin/repack.c
index 59214dbdfd..e1174a7a53 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1235,7 +1235,7 @@ int cmd_repack(int argc,
 	po_args.depth = xstrdup_or_null(opt_depth);
 	po_args.threads = xstrdup_or_null(opt_threads);
 
-	if (delete_redundant && repository_format_precious_objects)
+	if (delete_redundant && the_repository->repository_format_precious_objects)
 		die(_("cannot delete packs in a precious-objects repo"));
 
 	die_for_incompatible_opt3(unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE), "-A",
diff --git a/environment.c b/environment.c
index c61d773e7e..f3d318f1a0 100644
--- a/environment.c
+++ b/environment.c
@@ -37,7 +37,6 @@ int ignore_case;
 int assume_unchanged;
 int is_bare_repository_cfg = -1; /* unspecified */
 int warn_on_object_refname_ambiguity = 1;
-int repository_format_precious_objects;
 char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
diff --git a/environment.h b/environment.h
index 3d98461a06..bee1ffb91d 100644
--- a/environment.h
+++ b/environment.h
@@ -190,8 +190,6 @@ extern enum object_creation_mode object_creation_mode;
 
 extern int grafts_keep_true_parents;
 
-extern int repository_format_precious_objects;
-
 const char *get_log_output_encoding(void);
 const char *get_commit_output_encoding(void);
 
diff --git a/repository.c b/repository.c
index 9b3d6665fc..62709d1c91 100644
--- a/repository.c
+++ b/repository.c
@@ -284,6 +284,7 @@ int repo_init(struct repository *repo,
 	repo_set_ref_storage_format(repo, format.ref_storage_format);
 	repo->repository_format_worktree_config = format.worktree_config;
 	repo->repository_format_relative_worktrees = format.relative_worktrees;
+	repo->repository_format_precious_objects = format.precious_objects;
 
 	/* take ownership of format.partial_clone */
 	repo->repository_format_partial_clone = format.partial_clone;
diff --git a/repository.h b/repository.h
index c4c92b2ab9..ad23a243c6 100644
--- a/repository.h
+++ b/repository.h
@@ -151,6 +151,7 @@ struct repository {
 	/* Configurations */
 	int repository_format_worktree_config;
 	int repository_format_relative_worktrees;
+	int repository_format_precious_objects;
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
diff --git a/setup.c b/setup.c
index f93bd6a24a..3ea01e9331 100644
--- a/setup.c
+++ b/setup.c
@@ -753,7 +753,8 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		die("%s", err.buf);
 	}
 
-	repository_format_precious_objects = candidate->precious_objects;
+	the_repository->repository_format_precious_objects = candidate->precious_objects;
+
 	string_list_clear(&candidate->unknown_extensions, 0);
 	string_list_clear(&candidate->v1_only_extensions, 0);
 
@@ -1864,6 +1865,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			the_repository->repository_format_partial_clone =
 				repo_fmt.partial_clone;
 			repo_fmt.partial_clone = NULL;
+			the_repository->repository_format_precious_objects =
+				repo_fmt.precious_objects;
 		}
 	}
 	/*
-- 
2.49.0

