Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664322F167
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997278; cv=none; b=EtNkZ0FHyIw6ewSq5N6kdAEn6vzXYJdvxyZfGJfQVcZhqN6ofNsfq+9vp+JrLHNM7KrQAbmHQTtFneZAY9+IaDTK03+LAUKQ+sHX0yUX6z27KPvg3DWnnXTeISTuxy4lcNxnU1BxqiBcRmveb0ZIfHCfbTBII19VYDvu+rkZAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997278; c=relaxed/simple;
	bh=q6T+HtPjuHyF2QaJdoltFUAyCmmFxMkZ4DVKyDRl5rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC8oj9MzZk4ueI7/RO34ki6TM5wOXGR2dhZ1uDo5V3k3f/XPlQFA8HhY6RmF0IBHf7Tj3YXFQdctNFKu1TidGpqSDxaZJFAHiLOgk5+lDpTrdqjZFuB5RoJmsXK5WUROpRHV9tqysbUL+sowKP5xVAjjPudam2CgF9yBsLSz47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQnaDgkf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQnaDgkf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2212a930001so4352205ad.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997276; x=1740602076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQWzcKLc7oSM5BCdhcaEoI50j67Udj+50400HTzw0gI=;
        b=EQnaDgkfk0WRsSBUEEU+GNAfpCzLHo3t3yMTWtpEDdwInVbcl4QSCxx/09AySJBLJB
         /ZOfpQdZiY++dpx/EpnlCJ7m6GwnikbFDzX82tJi2YuOhuA8ai/QOiN/q2wbm+lrwieE
         xmGX1G1vKuKvgJaNAAmva5DKrKy/3pqKXlrjdYjTAuEpSxZSw+CBdJvudIqOHwgFQ0ZW
         pXiE5FcjiA4vtn/1f08VITdz4Y3/8jatJvj7QiPCihePZc+A+Mh4rUPapFFyiDQz8Xz0
         Ca1JZqgZ6UaKI3bRPfe8RCwdbY2190rQV5f/TaiX+PYXGvtblWHeJqKcFEp69RSeLtKq
         n1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997276; x=1740602076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQWzcKLc7oSM5BCdhcaEoI50j67Udj+50400HTzw0gI=;
        b=X41el/7LEVNwSO78hTd+GkJtCc88e0FLRiOPIx5eHP2sqZZD4UD7H9ekAWyI0jMocc
         e7FqJkSTUhd3D867XZ2WyRyEBgJVMR5ydtSFUJQqSTl+zSYhHWocxt+EdB9C0DLH6fEh
         /GjGdSPNHSiGvSkWKlZXMuhE29LPnLuD0A9V1LVjS4CubTwYA1v45d/7sQABbMoIgL8X
         s7msDS3aq0n7AR4QO1iLT7pydwWKhhkIo+z8guKxg4SzfU3os4F3uR2U1DFE7ssX+8Uc
         B7CUSWkkY3BOpA3ZndgHcT9pQdBC0eLdcGr2fixLhRrWs1bwd/HldE5ArPlSoZKs6yB/
         Ly1g==
X-Forwarded-Encrypted: i=1; AJvYcCU2qxGNkDRoC/Nt7FMDOr1Z5LHujsKzP6ImqOlB2wtjUlX3diHvob2Xpsv9V8J2VL4SO8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YybdHz7Dssf5pWzujP1DSj2Ean+JrYKFlyU4YDJiLglKE2icchD
	KtKYBi3vcg5fSIIsskH6Wdi3N5dPLBa1g9UiTMOY/Sj5rWeOipZd
X-Gm-Gg: ASbGncunDByhEBYjhab1TldRCjj7iULmUoaKqWCz7mCFU2udUnOkFG9CMBlo8bAUjG7
	/7/wQ3J/vCcZtxTvpOX5XZQDkzaiwpOSwFY2gTg1EqxiS/CnHd71k0z9omS9uk9xNGF9XhNUl6p
	bMoRRPQ0IkSGHJvBxMk09tHyJ23MmaEoIrH3eUdlUxdeuQb+6Lz7bCwIHsaa00vY9hyzXJEb5BK
	dih102cnAHiDtnNcKYap+/5iHPqj7irPhLCTsLxMZrIh3KnsUge8G5PG7PeY5zKaVB7h9acFOU7
	yUSXGbchQ+qs0SelmVQVi66PBJr0xQOPpHGHKqkL
X-Google-Smtp-Source: AGHT+IHus3iBHNx6C5HYQTs40qef+rt1DCFieOONEipVYTphUELbObPfZzXGJwp41c7xJMAG7AhgwA==
X-Received: by 2002:a17:902:e544:b0:220:ff3f:6cba with SMTP id d9443c01a7336-221040ab941mr335494065ad.38.1739997276219;
        Wed, 19 Feb 2025 12:34:36 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:35 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 12/12] builtin/checkout-index: stop using `the_repository`
Date: Thu, 20 Feb 2025 02:03:00 +0530
Message-ID: <20250219203349.787173-13-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250219203349.787173-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/checkout-index.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_checkout_index()` function with `repo`
set to NULL and then early in the function, `show_usage_with_options_if_asked()`
call will give the options help and exit, without having to consult much
of the configuration file.

Pass the repository available in the calling context to both `checkout_all()`
and `checkout_file()` to remove their dependency on the global
`the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/checkout-index.c | 43 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index e30086c7d4..46035444eb 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -5,7 +5,6 @@
  *
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -68,10 +67,10 @@ static void write_tempfile_record(const char *name, const char *prefix)
 	}
 }
 
-static int checkout_file(const char *name, const char *prefix)
+static int checkout_file(struct repository *repo, const char *name, const char *prefix)
 {
 	int namelen = strlen(name);
-	int pos = index_name_pos(the_repository->index, name, namelen);
+	int pos = index_name_pos(repo->index, name, namelen);
 	int has_same_name = 0;
 	int is_file = 0;
 	int is_skipped = 1;
@@ -81,8 +80,8 @@ static int checkout_file(const char *name, const char *prefix)
 	if (pos < 0)
 		pos = -pos - 1;
 
-	while (pos <the_repository->index->cache_nr) {
-		struct cache_entry *ce =the_repository->index->cache[pos];
+	while (pos < repo->index->cache_nr) {
+		struct cache_entry *ce =repo->index->cache[pos];
 		if (ce_namelen(ce) != namelen ||
 		    memcmp(ce->name, name, namelen))
 			break;
@@ -137,13 +136,13 @@ static int checkout_file(const char *name, const char *prefix)
 	return -1;
 }
 
-static int checkout_all(const char *prefix, int prefix_length)
+static int checkout_all(struct repository *repo, const char *prefix, int prefix_length)
 {
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
 
-	for (i = 0; i < the_repository->index->cache_nr ; i++) {
-		struct cache_entry *ce = the_repository->index->cache[i];
+	for (i = 0; i < repo->index->cache_nr ; i++) {
+		struct cache_entry *ce = repo->index->cache[i];
 
 		if (S_ISSPARSEDIR(ce->ce_mode)) {
 			if (!ce_skip_worktree(ce))
@@ -156,8 +155,8 @@ static int checkout_all(const char *prefix, int prefix_length)
 			 * first entry inside the expanded sparse directory).
 			 */
 			if (ignore_skip_worktree) {
-				ensure_full_index(the_repository->index);
-				ce = the_repository->index->cache[i];
+				ensure_full_index(repo->index);
+				ce = repo->index->cache[i];
 			}
 		}
 
@@ -213,7 +212,7 @@ static int option_parse_stage(const struct option *opt,
 int cmd_checkout_index(int argc,
 		       const char **argv,
 		       const char *prefix,
-		       struct repository *repo UNUSED)
+		       struct repository *repo)
 {
 	int i;
 	struct lock_file lock_file = LOCK_INIT;
@@ -253,19 +252,19 @@ int cmd_checkout_index(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 builtin_checkout_index_usage,
 					 builtin_checkout_index_options);
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
 
-	if (repo_read_index(the_repository) < 0) {
+	if (repo_read_index(repo) < 0) {
 		die("invalid cache");
 	}
 
 	argc = parse_options(argc, argv, prefix, builtin_checkout_index_options,
 			builtin_checkout_index_usage, 0);
-	state.istate = the_repository->index;
+	state.istate = repo->index;
 	state.force = force;
 	state.quiet = quiet;
 	state.not_new = not_new;
@@ -285,8 +284,8 @@ int cmd_checkout_index(int argc,
 	 */
 	if (index_opt && !state.base_dir_len && !to_tempfile) {
 		state.refresh_cache = 1;
-		state.istate = the_repository->index;
-		repo_hold_locked_index(the_repository, &lock_file,
+		state.istate = repo->index;
+		repo_hold_locked_index(repo, &lock_file,
 				       LOCK_DIE_ON_ERROR);
 	}
 
@@ -304,7 +303,7 @@ int cmd_checkout_index(int argc,
 		if (read_from_stdin)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
-		err |= checkout_file(p, prefix);
+		err |= checkout_file(repo, p, prefix);
 		free(p);
 	}
 
@@ -326,7 +325,7 @@ int cmd_checkout_index(int argc,
 				strbuf_swap(&buf, &unquoted);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
-			err |= checkout_file(p, prefix);
+			err |= checkout_file(repo, p, prefix);
 			free(p);
 		}
 		strbuf_release(&unquoted);
@@ -334,7 +333,7 @@ int cmd_checkout_index(int argc,
 	}
 
 	if (all)
-		err |= checkout_all(prefix, prefix_length);
+		err |= checkout_all(repo, prefix, prefix_length);
 
 	if (pc_workers > 1)
 		err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
@@ -344,7 +343,7 @@ int cmd_checkout_index(int argc,
 		return 1;
 
 	if (is_lock_file_locked(&lock_file) &&
-	    write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
+	    write_locked_index(repo->index, &lock_file, COMMIT_LOCK))
 		die("Unable to write new index file");
 	return 0;
 }
-- 
2.48.1

