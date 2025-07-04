Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813E1922D3
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638450; cv=none; b=uULahdzmTp+j8DlSHvQlSVOBw75BYEi9dFrzkU2rGUPIx4OS6a5wmRfbjMCya+8z/W4jQmvlm4WqF9l94xg76hLSi0hvoFudICAtU6cZmZNSjQGBWDMhvNBG67ur3V9Pcq2FZn2TbRtMUYtRrZD+wPVqfB7u0WipaMeSVnf7Lf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638450; c=relaxed/simple;
	bh=NbvqmdC0kR1CvGAMONEF7nRluS4hKZ8MRlTfQBNep+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSMpGmhXAaGjmPkWcaOvOksBnpbmf0yZfG9izOaWR5oLyD4UO1clpGNz6w1URRdP1qjUOuXgAzFgT5xTCKZNh54YSX8Pv4806i7cJTWwiGFIKvC7+iQ6clUlQVVdDD66P//Fsu6H5gwvQFFwXjMPYgV2s42o6xmjdHzkwjfzOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpJm9RHD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpJm9RHD"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3121aed2435so1055466a91.2
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751638448; x=1752243248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32RYXbVplVde+1JmNE5Ctvw3/BJghE2e9z+5XfA8ovY=;
        b=CpJm9RHDzj2HriyirxKTIa8WdNd/7E4ZTS8iBAVWdPxgHZGT1beXXf39Imn5+b6N0+
         C3B8SC4ntknOAU37xIkbaJ0i8NrAHVVvVL3lAKDP6/DVz6ZOF9KwK0X4KXJjy7SMjWti
         lavd3tR61J9M/DCS6qtCYS8rc7UDCrgg5cB1IZFXH/+4kwoIQcXm9f0+iRCF3mlXPPw+
         Tj5SEE+pl8Q6rQYlkntI1OkCQlKYEvbXXazsG86gCrqTsVBHHk7YNXg/dBytoSp5HCI4
         T9UDerydxVyZI/r5mB9YZg6KzCp3fxwp9s3C3LbGb5TIBb8OaRbWir0VdFdQuukEp1i/
         795Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751638448; x=1752243248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32RYXbVplVde+1JmNE5Ctvw3/BJghE2e9z+5XfA8ovY=;
        b=U5KYkfHn5+xgAEjCA+v0Rdz3L6olBTzvOO4F1G/noQOCAHL67s1pjLIM0x6faHobxM
         MEpdd267RqcLJwb9/dl4i1kD0k+Fcv6NyzrH82ysTa4qM4N/dA97mB1kU1mAI8fw9r0T
         7qiddK5rFgdHKegrWlHdC4ggWymHs2RYHEbCoP5Fu2gnm77c0Vx1vj3FAAgmVObwbdMy
         RoXSQVT/1L8w2w3ked5Y53TZcuKUwkYzI6UK3UfRpc/j9D/bOFDOm8Ovvpy34R3TjmAm
         22KZ+d9jA2HAj0nISAkyGLHWxtjUYoVJjo6+Vke/5pohjYsji7o1JwImRv95Cu3ClqFC
         6i0w==
X-Forwarded-Encrypted: i=1; AJvYcCXTBdo4iLeO7mU2otEbyAYaA8UG0h81fYLgxJwQmzhs8NqJsaauKm7RJ1i6hw9zp094vyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjg/3eGDy1FIhLhuo10FIev/XTVgUOYTpgkWWiviNG9QjDEkfd
	CqF9Wwd8t40XY/InybNQ4skOev9F1WrqTGNd6JQi4luFPOPid7b39o3tYWWfLb9VgPM=
X-Gm-Gg: ASbGncvhROt3SbYvPa56ZmIoVMjBYDgnwNR4Vxf1zfGG7j3Asn4CTEb3j72SC+WohV/
	PcHq4OqLTSca7RTgUJXpJVGAetqejxysFNOzOXCykWuKqbyG+G2IBbtUMiFxSse9v9Wg3mxJt4x
	Nzb9qLQffhmYgcOODQmo359QubgzVil5YHkbsxdVZh9rPAtDozdjCjcKJovgAKDv8x/HGZW//6h
	0aUJP7TjS1dVxlLh2iWSAG2BzT6K6SQeZuibPtzafu2VGtnodepqIsP9etfke+McLJPWMkMgr83
	ifacZQ1lGDQJ0OcY34YvPvRd+i89Le4wkG+MS0pOcybW6N2neslkETq7yOrzZrnRiE90+eyKgnx
	5yNaX
X-Google-Smtp-Source: AGHT+IHF3tHwrfZwejq+ZTnxVdg82l+N9pZSsElNPpOXocPzgAo4k6yedDCDpLGi1+EXywMUZiuDKw==
X-Received: by 2002:a17:90b:4a81:b0:313:f883:5d36 with SMTP id 98e67ed59e1d1-31aac436a54mr3963649a91.1.1751638447925;
        Fri, 04 Jul 2025 07:14:07 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c96:b11f:29cd:a954:9c31:7c0d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaaf2cd54sm2115780a91.23.2025.07.04.07.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 07:14:07 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shejialuo@gmail.com,
	shyamthakkar001@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com
Subject: [GSOC PATCH v3 1/2] repository: move 'repository_format_precious_objects' to repo scope
Date: Fri,  4 Jul 2025 19:42:34 +0530
Message-ID: <a828ade541b9255a655ad6d4cb3b6a64c900627f.1751630981.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751630981.git.ayu.chandekar@gmail.com>
References: <cover.1751630981.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'extensions.preciousObjects' setting when set true, prevents
operations that might drop objects from the object storage. This setting
is populated in the global variable
'repository_format_precious_objects'.

Move this global variable to repo scope by adding it to 'struct
repository and also refactor all the occurences accordingly.

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

