Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C758C77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 14:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjFBOd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjFBOdv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 10:33:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79F019B
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 07:33:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso21375715e9.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685716427; x=1688308427;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBrYx7mqtAUHq986DHvsu5h0B8Yfr2dbWSDkzvT4xIc=;
        b=XNZOc6UrovYf8XZSTKHPuVOyNbwig/gQ3XiXA5W+43kDU8C9kQN+PA85pHTDhJy+mm
         jIoD8KlpFEmm6kI1oGUP+4qsv52/EG+4meAiAvLP/WjAVHt3c3KKE/pZheBzk/B3DOxi
         08xl4AKZmiRQ1j6wAZ/Q06PUEEcgbA1iTOLxN/GRhjHRl4T+JOy4LbXAtOVpwcgOm3ff
         WGbCcPTlSoC5jn4vMSbTZNzbKy0rJ1tG4ry3ct3nWjsPc3jFRHQEF8JmCmgmD6pi4Pio
         pAqYstlfCOPU0byBGd5RucfDgZROMfFLqEAJ20qEhXrLj9rnNDhIZdOvQLWOnPCVEcqh
         rXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716427; x=1688308427;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBrYx7mqtAUHq986DHvsu5h0B8Yfr2dbWSDkzvT4xIc=;
        b=DKWUAn3AjjapXnjEwUzD6jXBDboL4EXyq3rUDxJHkJ87SGPk+BEeZRWvvPYjGbmtvX
         9BMLhrItRHuSJUmu8U/VKMyj8a70ketYktwVhHy4NXgwJ1t4RT2QdLbi/lOSGHSt2URj
         G2fPk5fpKTn6K9gsTl3VL0gTnz0UVPmynGfGwCAr4rqL3eQdEDCy2SPiePXQAYvEG9zu
         VvIGqzWocaBeYapNLMneO5PFTd5DMT3PY3j7CH8x+0s7QCJuTw/ov417AgdgsYmkNYwr
         SpGcFCP1x0XHFCnkMHTQI+v74f3xB1FOvc/P224pYcVUEtl1WxIWWOmmT8vxnGHTcGSr
         Hr6A==
X-Gm-Message-State: AC+VfDxctyXOIAMvgFgkyADKMtSucu5KxO+9qg8125EYbnoFyrAt9po8
        Yh/tfEuBpkSHCjHqUQ6ZE2rBVt/Ll+M=
X-Google-Smtp-Source: ACHHUZ4vY1CCHwAnQweSGAe/zsGFOPHYpvzHNtt88A99iA3DZMdHZ8MzYWUZ6Qo5QqnUJm9b38hsQA==
X-Received: by 2002:a7b:c7da:0:b0:3f4:23a4:7a93 with SMTP id z26-20020a7bc7da000000b003f423a47a93mr2017501wmk.25.1685716426736;
        Fri, 02 Jun 2023 07:33:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4c89000000b002fe96f0b3acsm1874349wrs.63.2023.06.02.07.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:33:46 -0700 (PDT)
Message-Id: <2b4198c09cb6c04c60608d19072d419503dfe5df.1685716421.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
References: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Jun 2023 14:33:40 +0000
Subject: [PATCH 6/6] config: move ignore_case to global config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, johannes.schindelin@gmx.de, newren@gmail.com,
        peff@peff.net, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The core.ignoreCase config setting is currently stored in the
ignore_case global. Add it to the list of config globals as
INT_CONFIG_IGNORE_CASE instead as a precaution. This allows us to load
the config only when needed.

There is a subtle use of force-enabling this global in 'test-tool
init-name-hash', since it is trying to test a feature that is only on
when core.ignoreCase is true. Instead of forcing it on in-memory, adjust
the test scripts to set the config.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 apply.c                                 |  3 ++-
 builtin/mv.c                            |  2 +-
 config.c                                |  5 -----
 dir.c                                   | 23 ++++++++++++++---------
 environment.c                           |  1 -
 environment.h                           |  1 -
 global-config.c                         |  2 ++
 global-config.h                         |  1 +
 merge-recursive.c                       |  8 ++++----
 name-hash.c                             |  6 +++---
 read-cache.c                            |  8 ++++----
 t/helper/test-lazy-init-name-hash.c     |  5 -----
 t/perf/p0004-lazy-init-name-hash.sh     |  6 ++++++
 t/t3008-ls-files-lazy-init-name-hash.sh |  1 +
 unpack-trees.c                          |  2 +-
 15 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/apply.c b/apply.c
index 17092d2bb12..4292d595062 100644
--- a/apply.c
+++ b/apply.c
@@ -3882,7 +3882,8 @@ static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *na
 			struct cache_entry *ce;
 
 			ce = index_file_exists(state->repo->index, name->buf,
-					       name->len, ignore_case);
+					       name->len,
+					       get_int_config_global(INT_CONFIG_IGNORE_CASE));
 			if (ce && S_ISLNK(ce->ce_mode))
 				return 1;
 		} else {
diff --git a/builtin/mv.c b/builtin/mv.c
index 32935af48e6..e7a0280ad34 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -359,7 +359,7 @@ dir_check:
 			goto act_on_entry;
 		}
 		if (lstat(dst, &st) == 0 &&
-		    (!ignore_case || strcasecmp(src, dst))) {
+		    (!get_int_config_global(INT_CONFIG_IGNORE_CASE) || strcasecmp(src, dst))) {
 			bad = _("destination exists");
 			if (force) {
 				/*
diff --git a/config.c b/config.c
index e104bc704ae..4292a3be416 100644
--- a/config.c
+++ b/config.c
@@ -1568,11 +1568,6 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 			check_stat = 0;
 	}
 
-	if (!strcmp(var, "core.ignorecase")) {
-		ignore_case = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.attributesfile"))
 		return git_config_pathname(&git_attributes_file, var, value);
 
diff --git a/dir.c b/dir.c
index aa840995c40..45f09bcbe4d 100644
--- a/dir.c
+++ b/dir.c
@@ -84,7 +84,8 @@ int count_slashes(const char *s)
 
 int fspathcmp(const char *a, const char *b)
 {
-	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
+	return get_int_config_global(INT_CONFIG_IGNORE_CASE) ?
+		strcasecmp(a, b) : strcmp(a, b);
 }
 
 int fspatheq(const char *a, const char *b)
@@ -94,12 +95,14 @@ int fspatheq(const char *a, const char *b)
 
 int fspathncmp(const char *a, const char *b, size_t count)
 {
-	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
+	return get_int_config_global(INT_CONFIG_IGNORE_CASE) ?
+		strncasecmp(a, b, count) : strncmp(a, b, count);
 }
 
 unsigned int fspathhash(const char *str)
 {
-	return ignore_case ? strihash(str) : strhash(str);
+	return get_int_config_global(INT_CONFIG_IGNORE_CASE) ?
+		strihash(str) : strhash(str);
 }
 
 int git_fnmatch(const struct pathspec_item *item,
@@ -148,7 +151,7 @@ static int fnmatch_icase_mem(const char *pattern, int patternlen,
 		use_str = str_buf.buf;
 	}
 
-	if (ignore_case)
+	if (get_int_config_global(INT_CONFIG_IGNORE_CASE))
 		flags |= WM_CASEFOLD;
 	match_status = wildmatch(use_pat, use_str, flags);
 
@@ -1749,7 +1752,8 @@ static struct dir_entry *dir_add_name(struct dir_struct *dir,
 				      struct index_state *istate,
 				      const char *pathname, int len)
 {
-	if (index_file_exists(istate, pathname, len, ignore_case))
+	if (index_file_exists(istate, pathname, len,
+			      get_int_config_global(INT_CONFIG_IGNORE_CASE)))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->internal.alloc);
@@ -1786,7 +1790,8 @@ static enum exist_status directory_exists_in_index_icase(struct index_state *ist
 	if (index_dir_exists(istate, dirname, len))
 		return index_directory;
 
-	ce = index_file_exists(istate, dirname, len, ignore_case);
+	ce = index_file_exists(istate, dirname, len,
+			       get_int_config_global(INT_CONFIG_IGNORE_CASE));
 	if (ce && S_ISGITLINK(ce->ce_mode))
 		return index_gitdir;
 
@@ -1805,7 +1810,7 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
 {
 	int pos;
 
-	if (ignore_case)
+	if (get_int_config_global(INT_CONFIG_IGNORE_CASE))
 		return directory_exists_in_index_icase(istate, dirname, len);
 
 	pos = index_name_pos(istate, dirname, len);
@@ -2313,7 +2318,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 
 	/* Always exclude indexed files */
 	has_path_in_index = !!index_file_exists(istate, path->buf, path->len,
-						ignore_case);
+						get_int_config_global(INT_CONFIG_IGNORE_CASE));
 	if (dtype != DT_DIR && has_path_in_index)
 		return path_none;
 
@@ -3067,7 +3072,7 @@ static int cmp_icase(char a, char b)
 {
 	if (a == b)
 		return 0;
-	if (ignore_case)
+	if (get_int_config_global(INT_CONFIG_IGNORE_CASE))
 		return toupper(a) - toupper(b);
 	return a - b;
 }
diff --git a/environment.c b/environment.c
index 312e006feb0..44cbaa3e0f9 100644
--- a/environment.c
+++ b/environment.c
@@ -32,7 +32,6 @@
 
 int check_stat = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
-int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
diff --git a/environment.h b/environment.h
index fb2cfa9c1aa..d77f4b233f8 100644
--- a/environment.h
+++ b/environment.h
@@ -113,7 +113,6 @@ void set_git_work_tree(const char *tree);
 /* Environment bits from configuration mechanism */
 extern int check_stat;
 extern int minimum_abbrev, default_abbrev;
-extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int warn_ambiguous_refs;
diff --git a/global-config.c b/global-config.c
index 526ced5b24c..779b894cf07 100644
--- a/global-config.c
+++ b/global-config.c
@@ -8,6 +8,7 @@ static int global_ints[] = {
 	[INT_CONFIG_TRUST_CTIME] = 1,
 	[INT_CONFIG_QUOTE_PATH_FULLY] = 1,
 	[INT_CONFIG_HAS_SYMLINKS] = 1,
+	[INT_CONFIG_IGNORE_CASE] = 0,
 };
 
 /* Bitmask for the enum. */
@@ -19,6 +20,7 @@ static const char *global_int_names[] = {
 	[INT_CONFIG_TRUST_CTIME] = "core.trustctime",
 	[INT_CONFIG_QUOTE_PATH_FULLY] = "core.quotepath",
 	[INT_CONFIG_HAS_SYMLINKS] = "core.symlinks",
+	[INT_CONFIG_IGNORE_CASE] = "core.ignorecase",
 };
 
 static int config_available;
diff --git a/global-config.h b/global-config.h
index 2532f426e2b..cb32503fbd9 100644
--- a/global-config.h
+++ b/global-config.h
@@ -7,6 +7,7 @@ enum int_config_key {
 	INT_CONFIG_TRUST_CTIME,
 	INT_CONFIG_QUOTE_PATH_FULLY,
 	INT_CONFIG_HAS_SYMLINKS,
+	INT_CONFIG_IGNORE_CASE,
 };
 
 /**
diff --git a/merge-recursive.c b/merge-recursive.c
index 10fdd14a642..ec806be4753 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -709,10 +709,9 @@ static int remove_file(struct merge_options *opt, int clean,
 			return -1;
 	}
 	if (update_working_directory) {
-		if (ignore_case) {
+		if (get_int_config_global(INT_CONFIG_IGNORE_CASE)) {
 			struct cache_entry *ce;
-			ce = index_file_exists(opt->repo->index, path, strlen(path),
-					       ignore_case);
+			ce = index_file_exists(opt->repo->index, path, strlen(path), 1);
 			if (ce && ce_stage(ce) == 0 && strcmp(path, ce->name))
 				return 0;
 		}
@@ -875,7 +874,8 @@ static int was_dirty(struct merge_options *opt, const char *path)
 		return !dirty;
 
 	ce = index_file_exists(opt->priv->unpack_opts.src_index,
-			       path, strlen(path), ignore_case);
+			       path, strlen(path),
+			       get_int_config_global(INT_CONFIG_IGNORE_CASE));
 	dirty = verify_uptodate(ce, &opt->priv->unpack_opts) != 0;
 	return dirty;
 }
diff --git a/name-hash.c b/name-hash.c
index fb13716e430..7c32e2be2e9 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -119,7 +119,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		hashmap_add(&istate->name_hash, &ce->ent);
 	}
 
-	if (ignore_case)
+	if (get_int_config_global(INT_CONFIG_IGNORE_CASE))
 		add_dir_entry(istate, ce);
 }
 
@@ -200,7 +200,7 @@ static int lookup_lazy_params(struct index_state *istate)
 	 * code to build the "istate->name_hash".  We don't
 	 * need the complexity here.
 	 */
-	if (!ignore_case)
+	if (!get_int_config_global(INT_CONFIG_IGNORE_CASE))
 		return 0;
 
 	nr_cpus = online_cpus();
@@ -642,7 +642,7 @@ void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
 	ce->ce_flags &= ~CE_HASHED;
 	hashmap_remove(&istate->name_hash, &ce->ent, ce);
 
-	if (ignore_case)
+	if (get_int_config_global(INT_CONFIG_IGNORE_CASE))
 		remove_dir_entry(istate, ce);
 }
 
diff --git a/read-cache.c b/read-cache.c
index b80a54133f9..444b37aff63 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -828,12 +828,12 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	 * case of the file being added to the repository matches (is folded into) the existing
 	 * entry's directory case.
 	 */
-	if (ignore_case) {
+	if (get_int_config_global(INT_CONFIG_IGNORE_CASE)) {
 		adjust_dirname_case(istate, ce->name);
 	}
 	if (!(flags & ADD_CACHE_RENORMALIZE)) {
 		alias = index_file_exists(istate, ce->name,
-					  ce_namelen(ce), ignore_case);
+					  ce_namelen(ce), get_int_config_global(INT_CONFIG_IGNORE_CASE));
 		if (alias &&
 		    !ce_stage(alias) &&
 		    !ie_match_stat(istate, alias, st, ce_option)) {
@@ -854,7 +854,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	} else
 		set_object_name_for_intent_to_add_entry(ce);
 
-	if (ignore_case && alias && different_name(ce, alias))
+	if (get_int_config_global(INT_CONFIG_IGNORE_CASE) && alias && different_name(ce, alias))
 		ce = create_alias_ce(istate, ce, alias);
 	ce->ce_flags |= CE_ADDED;
 
@@ -1024,7 +1024,7 @@ static int verify_dotfile(const char *rest, unsigned mode)
 	switch (*rest) {
 	/*
 	 * ".git" followed by NUL or slash is bad. Note that we match
-	 * case-insensitively here, even if ignore_case is not set.
+	 * case-insensitively here, regardless of core.ignoreCase.
 	 * This outlaws ".GIT" everywhere out of an abundance of caution,
 	 * since there's really no good reason to allow it.
 	 *
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index f23d983c118..5b69f90d888 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -212,11 +212,6 @@ int cmd__lazy_init_name_hash(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
-	/*
-	 * istate->dir_hash is only created when ignore_case is set.
-	 */
-	ignore_case = 1;
-
 	if (dump) {
 		if (perf || analyze > 0)
 			die("cannot combine dump, perf, or analyze");
diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
index 85be14e4ddb..90dad259161 100755
--- a/t/perf/p0004-lazy-init-name-hash.sh
+++ b/t/perf/p0004-lazy-init-name-hash.sh
@@ -6,6 +6,12 @@ test_description='Tests multi-threaded lazy_init_name_hash'
 test_perf_large_repo
 test_checkout_worktree
 
+test_expect_success 'initialize core.ignorecase' '
+	# This is needed since the name-hash structure is ignored when
+	# core.ignorecase is false.
+	git config core.ignorecase true
+'
+
 test_expect_success 'verify both methods build the same hashmaps' '
 	test-tool lazy-init-name-hash --dump --single >out.single &&
 	if test-tool lazy-init-name-hash --dump --multi >out.multi
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 51d3dffaa66..54bde980769 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -22,6 +22,7 @@ test_expect_success 'no buffer overflow in lazy_init_name_hash' '
 	) |
 	sed "s/^/100644 $EMPTY_BLOB	/" |
 	git update-index --index-info &&
+	git config core.ignoreCase true &&
 	test-tool lazy-init-name-hash -m
 '
 
diff --git a/unpack-trees.c b/unpack-trees.c
index c0732aa0c2d..b678745e699 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2405,7 +2405,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	 *
 	 * Ignore that lstat() if it matches.
 	 */
-	if (ignore_case && icase_exists(o, name, len, st))
+	if (get_int_config_global(INT_CONFIG_IGNORE_CASE) && icase_exists(o, name, len, st))
 		return 0;
 
 	if (o->internal.dir &&
-- 
gitgitgadget
