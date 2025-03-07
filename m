Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010433DF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390578; cv=none; b=sM5JWaFtdZ2nDh/CnIRG3sFquoKljgWX9mGYEiN5EvegqlyfdlNIortcKINzwnpUL4W6SsRNLvJ6uVscDid+9pWhtqTFcCRqUfHmjqFRdVp4MpyHaKmq/DAnxX+20H9S1Uw80ALvIhWnPduFEoQQCwxYMCcgNDVIhmxngDlGIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390578; c=relaxed/simple;
	bh=TG99l56WB7uG4AXm/m6Glul8x/2FBo3QBSFbry78VAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UahCE5E9NfQty1+0NnqnNOZp9NhY3oPJ7l3bDchgBUHRmJr8MMhmtrk74HeRvopW5apoUp4rKF14d3ydDeBMUkLO0XKLGqvxFpJ9tP5TgBKMNc6hSbdf2HntX/QFDo7qvZirzs43nxXuUmw8+HMdk0CEIafWRwnR32kZgDISAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKFrYSGJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKFrYSGJ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224100e9a5cso46590315ad.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390576; x=1741995376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZagCCvp4BrHRFQq8PkN50cz/wHDlWnYErUpQ8WNHbY=;
        b=NKFrYSGJ2UV28FwwvR0Y/JkTs6KwZQFnCsIBBHBEVEanRSQ27MAn675nWBMtdCs8xz
         mosTlN6DL+++z/kefi3oRxghVP7R5GSWTnLAnAcv/ZV9u1Og/FV80twI7BOxxX5GijnR
         tEfqT9x9ASc0M+zF9NDmUJsw6V4R3pO/3W3cCEWW0F+nhLNgMbKK9sJcuyvn5I9ekRJi
         tbnXw7Z5PZBi0GPIYnJ+L0wsudh1TH37sx7kvCF/HZzm1ABPvizUbu0L/9cuRkxezg3t
         ET6YfN2ocr2s2rAdxsuB5Y50YUkezOaMoZYtWKupCrqk5BXXjhnT5//UIInPPkffuA7K
         Hs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390576; x=1741995376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZagCCvp4BrHRFQq8PkN50cz/wHDlWnYErUpQ8WNHbY=;
        b=OXCYMp21OfYDT/beIVzQsAwe7CRRPbnUyo95+hhsVCXwG5WkjhKXFj8gfLZgv/u8/3
         MpgUJPNW3VBaZYlf1c9C6pV8r77UYZyiX6j946efpE0dZ8Es/mMPPbc21eXE3JedroAD
         ql9c3ldAhgJlhOiZWHDyPJcIHnrazpUK7yiNesIiSxLWVQnjVYIyc75/dAQlRNqEda5J
         maMFFyVwMfbcSJ4/tQG0t4HY8o4iTeDS4iQW6UzH5B5oa4l37NIrIu0tUCKpLcxFXip5
         N4CXTs1XVUFgNfOYnNXKWrL6CkmB/349gZKaRwiAobnUH1HmI0meDc0plIspjZs8NBcA
         aPxQ==
X-Gm-Message-State: AOJu0YwJetNWon4kYL7FbE7dWeEznmjA9xml3ioSre+uJkE5yOcunr9n
	Gt1dlWp9BeYPi9BYd/cGMI55WpnHwoZVgU929mCWdFbTWtGMfLUSGgSnxw0D
X-Gm-Gg: ASbGnctbOeMGu+yYHJV/bdKJTT6SMjDrtLgaty3Vj/5ZlTDmrt5CThhdpHndLCgr/Bm
	vWFmmFtwHCfwAEg4hxHgFZ5JjqYnaF5UBQQIIvxI22zcDQjUCUVJJStkK+DjTwXpOLaeiGf4XCi
	3KwlbCNi0ITRBY7zjGmpgh7qANgXoaFEoIoZQXqKB7/CJnBadkELXMFVMa4uQoowL0EARSxvmGv
	Uuy708MK7IgqcwYqsfTKAX2Gl8DdSXPAT8FKAx3lwWhYzL5D0Y56v6dh5hW8I/neUkaeVPVyqbj
	f02OFCfgB8Me9tJ9nNcLAhS6+rMxA3G6C1ZBaqlwG9mJTYDGS5N56eLEiNmUNz1vOKqSGw==
X-Google-Smtp-Source: AGHT+IHO/WR87B5wT7jLYJdrZ6VISR7H5XD++4XM1X4p7+flwi1AFDhI4IJlbesH51oPkpJOEG42Dg==
X-Received: by 2002:a05:6a00:194b:b0:732:5611:cbb5 with SMTP id d2e1a72fcca58-736aaa56ddemr6150539b3a.11.1741390576099;
        Fri, 07 Mar 2025 15:36:16 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bcb8de04sm423880b3a.154.2025.03.07.15.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:36:15 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 8/8] builtin/checkout-index: stop using `the_repository`
Date: Sat,  8 Mar 2025 05:05:07 +0530
Message-ID: <20250307233543.1721552-9-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
References: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
 <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
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

Pass an instance of "struct index_state" available in the calling
context to both `checkout_all()` and `checkout_file()` to remove their
dependency on the global `the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/checkout-index.c        | 43 ++++++++++++++++-----------------
 t/t2006-checkout-index-basic.sh |  7 ++++++
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index e30086c7d4..7f74bc702f 100644
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
+static int checkout_file(struct index_state *index, const char *name, const char *prefix)
 {
 	int namelen = strlen(name);
-	int pos = index_name_pos(the_repository->index, name, namelen);
+	int pos = index_name_pos(index, name, namelen);
 	int has_same_name = 0;
 	int is_file = 0;
 	int is_skipped = 1;
@@ -81,8 +80,8 @@ static int checkout_file(const char *name, const char *prefix)
 	if (pos < 0)
 		pos = -pos - 1;
 
-	while (pos <the_repository->index->cache_nr) {
-		struct cache_entry *ce =the_repository->index->cache[pos];
+	while (pos < index->cache_nr) {
+		struct cache_entry *ce = index->cache[pos];
 		if (ce_namelen(ce) != namelen ||
 		    memcmp(ce->name, name, namelen))
 			break;
@@ -137,13 +136,13 @@ static int checkout_file(const char *name, const char *prefix)
 	return -1;
 }
 
-static int checkout_all(const char *prefix, int prefix_length)
+static int checkout_all(struct index_state *index, const char *prefix, int prefix_length)
 {
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
 
-	for (i = 0; i < the_repository->index->cache_nr ; i++) {
-		struct cache_entry *ce = the_repository->index->cache[i];
+	for (i = 0; i < index->cache_nr ; i++) {
+		struct cache_entry *ce = index->cache[i];
 
 		if (S_ISSPARSEDIR(ce->ce_mode)) {
 			if (!ce_skip_worktree(ce))
@@ -156,8 +155,8 @@ static int checkout_all(const char *prefix, int prefix_length)
 			 * first entry inside the expanded sparse directory).
 			 */
 			if (ignore_skip_worktree) {
-				ensure_full_index(the_repository->index);
-				ce = the_repository->index->cache[i];
+				ensure_full_index(index);
+				ce = index->cache[i];
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
+		err |= checkout_file(repo->index, p, prefix);
 		free(p);
 	}
 
@@ -326,7 +325,7 @@ int cmd_checkout_index(int argc,
 				strbuf_swap(&buf, &unquoted);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
-			err |= checkout_file(p, prefix);
+			err |= checkout_file(repo->index, p, prefix);
 			free(p);
 		}
 		strbuf_release(&unquoted);
@@ -334,7 +333,7 @@ int cmd_checkout_index(int argc,
 	}
 
 	if (all)
-		err |= checkout_all(prefix, prefix_length);
+		err |= checkout_all(repo->index, prefix, prefix_length);
 
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

