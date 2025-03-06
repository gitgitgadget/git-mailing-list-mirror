Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F43188A0E
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271824; cv=none; b=ZRXP8pP0qigXUlBK54xWsDNvJnpTEeRkn97CNjs+v9RcM6kYaq2CnssP6X/+wzRfY60Ldeg9TULhN+kRqEB9Fg+8XJFmcgttyZ9NVZ3xMtgTLQ7bl0c6nVE6ey2opvI/rMwi9zkiEMjAIk0Oupvgwb07Gty2FQuBikA69O2S5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271824; c=relaxed/simple;
	bh=OOuocYm/o6iHxD4hH78Ud5/4/gAXbkbBxfgKp9NLIS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBgyklSt7JRMHBG2iNSRuIB9liQ0UpU2W5unT0US3H6ZlwTCanlADhaADd0WioaW8c0MvSyJf9i8x06fFuCbl6RIA/9rICTGghQLYdK+x7PWGvFFpGwgzeLgHvzVlnxIEXLwls2rRtSTkrcKefXyYe1wwJv9JnLek3sPGy1Qc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIzlr15X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIzlr15X"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2feb867849fso1187109a91.3
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741271821; x=1741876621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0TiMUI5l54jqyfeIJLHiEJvUTmL2bCQdsfSYZRn3RE=;
        b=UIzlr15XK6pTNcxiTZAr8nS8uqWyZfbYjNw9BKaqSNLIUtHoGArSnlARg6dcXPlbD6
         DYPui+EoxN94kg1gTAGj8EIC0IE6ajkwPpdLwNSktWIYdtxYIkYV9VpXt+XLngIKiSpz
         7FKJKK8pvPHsKPY5rNtZ9hETt/0zIOnea0n3VK5Nkcmy0cjLIkNtYkMKEuI4B0woJFe9
         ZSmMqAACtWEddLODoxEDPestGnz3HG2lcJkARCsAqfbk5vZmwGfH3FIOJyBnQbwAGkxI
         pGwaTWF5s2wY1QjjNLF4FJlfziS3Yo1cZkdc26ft5QYJS+cVg0wPnxHpw3/uDC8SJSbl
         suww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271821; x=1741876621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0TiMUI5l54jqyfeIJLHiEJvUTmL2bCQdsfSYZRn3RE=;
        b=K9UkcrXBznfiiqUcYE05kKX8TFYxom41fyToHK1K/3ZIfhTWFdEX/Q9/5VOup1kd9M
         0s1b18UsQKCnkEyqMCbWWTDoSpfa+uV3rBWa0isPeLXNk1vkMGrhSPF3Z0+EgkpEfFie
         K6almxOYyhnw5hpEyD6L52ZqsI0RsMYYoO/Zm0kWPazEFLmIQKzv5NHCIJ48FqvebIhu
         3YzIB2OHFA1g0wFmd9aAmqrYCROooO6sKGNir03wNWPt/pA9F4gIk6vJtj2Lch5MIbY2
         9HgqkrXic5ITunPg+T8yR89pChlch+oCcC4tXXNANHDOAZbNVAD2mMjxtsbJhdI2bpV9
         QWwA==
X-Gm-Message-State: AOJu0YxhfVYH/T0gFdH27Q5yLlIMGr8P3CkmGwd2N/pGYphwn/7prCRX
	AB7DEQPrYK58aL/5Km5s79dKbPugyDGzfSj2JVR7OGyfDKJfrKjHuOqvTP2I
X-Gm-Gg: ASbGncvnJbphWRrU5kjIULSUhNI/aoFlE3WrqWRHEEhWJHYB67l7c/Jfi+PH1Ll0EM8
	73KbGxHXlLz2P7tMDqcpFx+5kKRE9Wk+8Hx1IvmSgjHyBS6PQLrqtco/DreCEWJ395ELs0OkWec
	Cj03A7zo4L+qVNGXr3nAAzg9D0hdaMcz3gxfzTbpzmtssyarnUnp6X4NXMcPU7acy4V+b6e+mSe
	XaYS1NuU7RoMi/y8QB7IQonU6jdE/eNMCO/WkvrWlokShJBSD5MckJ+uqtmK/pt3G6Ouh40EL7b
	HdOCBNkUGH5lPeCmU4i2zTtgq6J9H5dS4TkhxRssfA9PLRVlVeaaeisTfSuDQmXrHQUKaQ==
X-Google-Smtp-Source: AGHT+IG/1FAvyWb2VjoorB0m4saqHiPvbDjTP4bDaxoYS+YaMjE7GTQG3qtgaJLUqkb0mwHxxeclDQ==
X-Received: by 2002:a17:90b:498d:b0:2fa:15ab:4dff with SMTP id 98e67ed59e1d1-2ff497c418dmr10382221a91.31.1741271821567;
        Thu, 06 Mar 2025 06:37:01 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff944sm3561184a91.34.2025.03.06.06.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:37:01 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 8/8] builtin/checkout-index: stop using `the_repository`
Date: Thu,  6 Mar 2025 20:05:52 +0530
Message-ID: <20250306143629.1267358-9-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
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
call will give the options help and exit.

Pass the repository available in the calling context to both `checkout_all()`
and `checkout_file()` to remove their dependency on the global
`the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/checkout-index.c        | 43 ++++++++++++++++-----------------
 t/t2006-checkout-index-basic.sh |  7 ++++++
 2 files changed, 28 insertions(+), 22 deletions(-)

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
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index bac231b167..fedd2cc097 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -21,6 +21,13 @@ test_expect_success 'checkout-index -h in broken repository' '
 	test_grep "[Uu]sage" broken/usage
 '
 
+test_expect_success 'checkout-index does not crash with -h' '
+	test_expect_code 129 git checkout-index -h >usage &&
+	test_grep "[Uu]sage: git checkout-index " usage &&
+	test_expect_code 129 nongit git checkout-index -h >usage &&
+	test_grep "[Uu]sage: git checkout-index " usage
+'
+
 test_expect_success 'checkout-index reports errors (cmdline)' '
 	test_must_fail git checkout-index -- does-not-exist 2>stderr &&
 	test_grep not.in.the.cache stderr
-- 
2.48.1

