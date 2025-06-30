Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A728B7F8
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301693; cv=none; b=FqRmqEVtFxvL+Ngl937cg+sw4hyUPM2War+l4CYU5NyAGUj8MQc/zZvihlrrhvVbgro6YtNUllfVg0T7rd/utk4CUY/2L4KH8HoICmyn4rLoH+zHDwmMO8VJ54YkqDZ2t93dpH5ibGAoDiqvvYw7/G9X0u2WrKAxZ5FtX7CgttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301693; c=relaxed/simple;
	bh=CObBzljV5TPXFZrHFjryFmMpj54GF310xS43KtnJ5MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYPvpl/sUY+XQCFmOOcoLrnvhBqNuhXwDyRzwnCFS09/mg5qiMNDNZiVtG16+EIJ1EN33XAFYuCZb8LKo8dr2Jzs+6esfT9CzOPpvnV1ojQl/oI+foM45RIzzToZpLcuWDJYQw7uSrPrmYE0mQEwqv5+Zq2k3HtBjyG9xFMmG08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKXw8jkr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKXw8jkr"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23633a6ac50so58829115ad.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751301691; x=1751906491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oD1w7EZ21fW0Kux3mTXkWAeW3ZvZ3RFq59MsP/6EOE=;
        b=OKXw8jkr5zoLxggBcX3U+4IIwYL1oYe3lzUS/YwKv8bocg2zy/hVVpymRqjC2W3DYn
         HqcCyYB7vU4n1SfLACB6bK8ZMh78bKORCHFFCwjl+/G4VI/cDsbR8h7gY8BuYj88EQtf
         9txAbx+YdH4FYBMHVtxmmB2H7ojAA333Dicv46VL7J19vvlMPnvFOCKGc0r1bVR5pvuk
         qKBslqb8Xl/0u/6U1IhgRGhRj5ymA+d22Z90ilqvmzzcOYXC9YJt1pHxOoqp3+JHnd69
         kTW6VT5y7tWftEc5dTqM0GbvSyxJiEtg3SeytzQclwWTRPTT8MXvPkStxaCmERdRjQ1N
         BuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301691; x=1751906491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oD1w7EZ21fW0Kux3mTXkWAeW3ZvZ3RFq59MsP/6EOE=;
        b=k1870NUcuuDI3LIf5PSc3gEm/QeD2gSKy32KP6FcVUctTAiA7XIDlkIjPODI6ge+EB
         aQsiLStd6w8ZHIdzQ9J1visWcS78M4TGbULcVZUcRbQqns4d9qwNr7a+59ALKI8JFtGI
         uJWK0Q5+lSkHp7oEkfiyHUle4up/maGm1B+GCLWAEshZDjOtNg2fxN1LVCQtF/3zDvND
         kzydigfCcUgY1nP3350Q0+te+N/wT16ABKDkFSqNEvFD+0xkb2ConVHP8Ba7JpllTb1F
         ZVgtTD9aLPZNeX+uIJ6VRBZt8spIBUDX5XY3RfI59VK2lqgDG0LyuiFxseA9lOJgQXPT
         TLjg==
X-Forwarded-Encrypted: i=1; AJvYcCUWtOr19PzKvrgvx5iBBpF69Gs9NUMwwqOsnaAgZ9HDquyj38fYLLqGBI6GX75qQ9OOrpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEef9i/q062IoSZwLP7Y4QJuO26K3CvL1QtBnIhtpGx3DqMbaO
	hlPz9qN/cEH/x2NEERyf2n68ZQrozGq0szY9ZEm+O696FuexLSXismB4AV0jmhbN
X-Gm-Gg: ASbGncuri+jQSsDwttjAgE4LMvIcli1/5UOmONWiYbW9rgYwaZ9FSafVlTe7SvmTH/n
	NurqNg6aN3sYGVcaz6eQExIwPr2sAj4mwXaNF/s6AQ1JcxRXBOpsTTnqX/mj/S7jVeMpm9w7scC
	Udw8hySO8gCywVeOa3rsWwpaArn2kVpXSgI3sE09IQ0BDLqEf4GAlzGa85F/1P5LIeQea5t7yg9
	6FCzZfEHCAhdNsFMimQ33qThNauF/IGyWkInz9WEOHQMuzRAFCDkt1htlXnHvdfhl6dKjv851Hd
	aSY7eXfepsBPG+eM08+X/GAKc4l7mSrLlvJeO58VU3/8bOjD9Ac6Zbjv7MnoAFmtD4dQYrl+r+6
	Ta6BC
X-Google-Smtp-Source: AGHT+IHCo9WweFJRY4HGn7oosyClTcwI1YGb1qghGDsACPBxwf8LVkA+XtqSEuI23zScB/PmqOEdzQ==
X-Received: by 2002:a17:902:d506:b0:235:f459:69c7 with SMTP id d9443c01a7336-23ac4891f78mr224489105ad.52.1751301690878;
        Mon, 30 Jun 2025 09:41:30 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c20:3d25:645c:9adb:1b15:c2cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39f34dsm84841385ad.130.2025.06.30.09.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:41:30 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	shejialuo@gmail.com
Subject: [GSOC PATCH v2 1/2] repository: move 'repository_format_precious_objects' to repo scope
Date: Mon, 30 Jun 2025 22:11:04 +0530
Message-ID: <995389d6229df0c2a76ee4ba57e663a43abb4540.1751296633.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751296633.git.ayu.chandekar@gmail.com>
References: <cover.1751296633.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'extensions.preciousObjects' setting when set true, prevents
operations that might drop objects from the object storage.
This setting is populated in the global variable
'repository_format_precious_objects'.
Move this global variable to repo scope by adding it to struct
`repository` and also refactor all the occurences accordingly.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
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
index 845876ff02..ec10b81dcc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -998,7 +998,7 @@ int cmd_gc(int argc,
 	if (opts.detach <= 0 && !skip_foreground_tasks)
 		gc_foreground_tasks(&opts, &cfg);
 
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
index 5ddc6e7f95..d0e4fa6bed 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1240,7 +1240,7 @@ int cmd_repack(int argc,
 	po_args.depth = xstrdup_or_null(opt_depth);
 	po_args.threads = xstrdup_or_null(opt_threads);
 
-	if (delete_redundant && repository_format_precious_objects)
+	if (delete_redundant && the_repository->repository_format_precious_objects)
 		die(_("cannot delete packs in a precious-objects repo"));
 
 	die_for_incompatible_opt3(unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE), "-A",
diff --git a/environment.c b/environment.c
index 7bf0390a33..7c2480b22e 100644
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
index 9a3d05d414..3d806ced6e 100644
--- a/environment.h
+++ b/environment.h
@@ -189,8 +189,6 @@ extern enum object_creation_mode object_creation_mode;
 
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

