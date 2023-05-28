Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFC2C77B7E
	for <git@archiver.kernel.org>; Sun, 28 May 2023 10:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjE1KAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 May 2023 06:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjE1KAI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2023 06:00:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA5AD2
        for <git@vger.kernel.org>; Sun, 28 May 2023 03:00:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso16457085e9.1
        for <git@vger.kernel.org>; Sun, 28 May 2023 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685268003; x=1687860003;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjWpdawP5RYrY/FRrDt9XSthpmjgH6iCgUbcfp+BkO8=;
        b=XUHAX4wG+/h3qwqK9521QyMzHtUb4TRcvK9cd/GogWpeTjjv4tk2VEqrRqbFn1WrJA
         VLtWRNE81G4/FmAcM48iEODk6wbFIR6iw2sPRfFSajnC0/rEutG32f6/MAOMYk8Q07wq
         ZC2fUmXdT9x0utKQ6tuKDBbtkj6XwSUpnFkUOdE/9lazKFWG1VK0tAzLaKUhf8E4l0aw
         Fmirqz6upr6vUZ7lVqs+c5PrFvfXC7Jb6kbAZBQ+iYlrsRsf0ezdTiLr1JTrtb5z08p3
         03vjEBy39b/DCuQZw4txm+MG+P0EltkQU9u1It/O/cYz/XtFcHsof14B5xq94tUE5EZi
         C+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685268003; x=1687860003;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjWpdawP5RYrY/FRrDt9XSthpmjgH6iCgUbcfp+BkO8=;
        b=W/obkb5u6/2QKnyYEQBv93qnWTiiWHrMP0V88cW01/D5E71Wy0D8OwmEky3zmVT92F
         5I0hC8r2EhUwikuPlTxiHEKLK1gsAQ4HgHx9mLyqK2mBkWi1bYrLMRUQqe4LoTUqmymu
         MoqBx66xoiaL4EpQ6bAJ86AbYkgAZs0ZbfdVWFh1fXwSKRLKD4xn8MFqk36rNdA6eh7l
         +9ZIb63YjQpTOBMueqDfcxEmDUF/gICbUFA/4k7093IGVR19hsipb2Le7PCCAsuTzijl
         j19PU28CSnHh8EJYtqRjdERlMdM6WEkUN//8/gJBDaPE+h+hL+bVptMocNKUVFEWTG4B
         BFAw==
X-Gm-Message-State: AC+VfDyvmiMjJ46MDgxCil+C3lhjYXMVXfOlh77bKXn67cSd06BZt9sq
        WwPDc0Hw5kaX6ibPZsHqfgPBfhTaKKY=
X-Google-Smtp-Source: ACHHUZ4FnXVu68lyeuTNGCIRrQjSL3L/gQ9GO+qn7zQv1ezUHy7tjAT+rNC4hNhAyyZYaiqkEQJ0ng==
X-Received: by 2002:a05:600c:46c5:b0:3f5:fbc0:a8cc with SMTP id q5-20020a05600c46c500b003f5fbc0a8ccmr4082770wmo.2.1685268003292;
        Sun, 28 May 2023 03:00:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15-20020a7bc38f000000b003f6028a4c85sm14216113wmj.16.2023.05.28.03.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 03:00:03 -0700 (PDT)
Message-Id: <52359738532ab89c4612e4b83f08ab50fa169dd4.1685267999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1257.v3.git.1685267999.gitgitgadget@gmail.com>
References: <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>
        <pull.1257.v3.git.1685267999.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 May 2023 09:59:59 +0000
Subject: [PATCH v3 3/3] apply: support case-only renames in case-insensitive
 filesystems
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

"git apply" checks, when validating a patch, to ensure that any files
being added aren't already in the worktree.

When this check runs on a case-only rename, in a case-insensitive
filesystem, this leads to a false positive - the command fails with an
error like:
error: File1: already exists in working directory

There is a mechanism to ensure that "seemingly conflicting" files are
handled correctly - for example overlapping rename pairs or swaps -
this mechanism treats renames as add/remove pairs, and would end up
treating a case-only rename as a "self-swap"... Except it does not
account for case-insensitive filesystems yet.

Because the index is inherently case-sensitive even on a
case-insensitive filesystem, we actually need this mechanism to
handle both requirements, lest we fail to account for conflicting
files only in the index.

Fix the "rename chain" existence exemption mechanism to account for
case-insensitive config, fixing case-only-rename-handling as a
"self-swap" and also fixing less-common "case-insensitive rename
pairs" when config core.ignorecase is set, but keep the index checks
file-sensitive.

Also add test cases around these behaviors - verifying that conflicting
file conditions are still caught correctly, including case-only
conflicts on case-sensitive filesystems, and edge cases around
case-sensitive index behaviors on a case-insensitive filesystem.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 apply.c                |  81 ++++++++++++++++------
 apply.h                |   5 +-
 t/t4142-apply-icase.sh | 154 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 207 insertions(+), 33 deletions(-)

diff --git a/apply.c b/apply.c
index 6212ab3a1b3..a2e2f6b531d 100644
--- a/apply.c
+++ b/apply.c
@@ -113,7 +113,9 @@ int init_apply_state(struct apply_state *state,
 	state->ws_error_action = warn_on_ws_error;
 	state->ws_ignore_action = ignore_ws_none;
 	state->linenr = 1;
-	string_list_init_nodup(&state->fn_table);
+	string_list_init_nodup(&state->fs_fn_table);
+	state->fs_fn_table.cmp = fspathcmp;
+	string_list_init_nodup(&state->index_fn_table);
 	string_list_init_nodup(&state->limit_by_name);
 	strset_init(&state->removed_symlinks);
 	strset_init(&state->kept_symlinks);
@@ -134,7 +136,10 @@ void clear_apply_state(struct apply_state *state)
 	strset_clear(&state->kept_symlinks);
 	strbuf_release(&state->root);
 
-	/* &state->fn_table is cleared at the end of apply_patch() */
+	/*
+	 * &state->fs_fn_table and &state->index_fn_table are cleared at the
+	 * end of apply_patch()
+	 */
 }
 
 static void mute_routine(const char *msg UNUSED, va_list params UNUSED)
@@ -3294,14 +3299,28 @@ static int read_file_or_gitlink(const struct cache_entry *ce, struct strbuf *buf
 	return read_blob_object(buf, &ce->oid, ce->ce_mode);
 }
 
-static struct patch *in_fn_table(struct apply_state *state, const char *name)
+static struct patch *in_fs_fn_table(struct apply_state *state, const char *name)
 {
 	struct string_list_item *item;
 
 	if (!name)
 		return NULL;
 
-	item = string_list_lookup(&state->fn_table, name);
+	item = string_list_lookup(&state->fs_fn_table, name);
+	if (item)
+		return (struct patch *)item->util;
+
+	return NULL;
+}
+
+static struct patch *in_index_fn_table(struct apply_state *state, const char *name)
+{
+	struct string_list_item *item;
+
+	if (!name)
+		return NULL;
+
+	item = string_list_lookup(&state->index_fn_table, name);
 	if (item)
 		return (struct patch *)item->util;
 
@@ -3333,7 +3352,7 @@ static int was_deleted(struct patch *patch)
 	return patch == PATH_WAS_DELETED;
 }
 
-static void add_to_fn_table(struct apply_state *state, struct patch *patch)
+static void add_to_fn_tables(struct apply_state *state, struct patch *patch)
 {
 	struct string_list_item *item;
 
@@ -3343,7 +3362,9 @@ static void add_to_fn_table(struct apply_state *state, struct patch *patch)
 	 * file creations and copies
 	 */
 	if (patch->new_name) {
-		item = string_list_insert(&state->fn_table, patch->new_name);
+		item = string_list_insert(&state->fs_fn_table, patch->new_name);
+		item->util = patch;
+		item = string_list_insert(&state->index_fn_table, patch->new_name);
 		item->util = patch;
 	}
 
@@ -3352,7 +3373,9 @@ static void add_to_fn_table(struct apply_state *state, struct patch *patch)
 	 * later chunks shouldn't patch old names
 	 */
 	if ((patch->new_name == NULL) || (patch->is_rename)) {
-		item = string_list_insert(&state->fn_table, patch->old_name);
+		item = string_list_insert(&state->fs_fn_table, patch->old_name);
+		item->util = PATH_WAS_DELETED;
+		item = string_list_insert(&state->index_fn_table, patch->old_name);
 		item->util = PATH_WAS_DELETED;
 	}
 }
@@ -3365,7 +3388,9 @@ static void prepare_fn_table(struct apply_state *state, struct patch *patch)
 	while (patch) {
 		if ((patch->new_name == NULL) || (patch->is_rename)) {
 			struct string_list_item *item;
-			item = string_list_insert(&state->fn_table, patch->old_name);
+			item = string_list_insert(&state->fs_fn_table, patch->old_name);
+			item->util = PATH_TO_BE_DELETED;
+			item = string_list_insert(&state->index_fn_table, patch->old_name);
 			item->util = PATH_TO_BE_DELETED;
 		}
 		patch = patch->next;
@@ -3395,7 +3420,7 @@ static struct patch *previous_patch(struct apply_state *state,
 	if (patch->is_copy || patch->is_rename)
 		return NULL; /* "git" patches do not depend on the order */
 
-	previous = in_fn_table(state, patch->old_name);
+	previous = in_index_fn_table(state, patch->old_name);
 	if (!previous)
 		return NULL;
 
@@ -3706,7 +3731,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	}
 	patch->result = image.buf;
 	patch->resultsize = image.len;
-	add_to_fn_table(state, patch);
+	add_to_fn_tables(state, patch);
 	free(image.line_allocated);
 
 	if (0 < patch->is_delete && patch->resultsize)
@@ -3805,11 +3830,12 @@ static int check_preimage(struct apply_state *state,
 
 static int check_to_create(struct apply_state *state,
 			   const char *new_name,
-			   int ok_if_exists)
+			   int ok_if_exists_in_fs,
+			   int ok_if_exists_in_index)
 {
 	struct stat nst;
 
-	if (state->check_index && (!ok_if_exists || !state->cached)) {
+	if (state->check_index && (!ok_if_exists_in_index || !state->cached)) {
 		int pos;
 
 		pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
@@ -3817,7 +3843,7 @@ static int check_to_create(struct apply_state *state,
 			struct cache_entry *ce = state->repo->index->cache[pos];
 
 			/* allow ITA, as they do not yet exist in the index */
-			if (!ok_if_exists && !(ce->ce_flags & CE_INTENT_TO_ADD))
+			if (!ok_if_exists_in_index && !(ce->ce_flags & CE_INTENT_TO_ADD))
 				return EXISTS_IN_INDEX;
 
 			/* ITA entries can never match working tree files */
@@ -3830,7 +3856,7 @@ static int check_to_create(struct apply_state *state,
 		return 0;
 
 	if (!lstat(new_name, &nst)) {
-		if (S_ISDIR(nst.st_mode) || ok_if_exists)
+		if (S_ISDIR(nst.st_mode) || ok_if_exists_in_fs)
 			return 0;
 		/*
 		 * A leading component of new_name might be a symlink
@@ -3940,7 +3966,8 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	const char *name = old_name ? old_name : new_name;
 	struct cache_entry *ce = NULL;
 	struct patch *tpatch;
-	int ok_if_exists;
+	int ok_if_exists_in_fs;
+	int ok_if_exists_in_index;
 	int status;
 
 	patch->rejected = 1; /* we will drop this after we succeed */
@@ -3963,16 +3990,29 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	 * B; ask to_be_deleted() about the later rename.  Removal of
 	 * B and rename from A to B is handled the same way by asking
 	 * was_deleted().
+	 *
+	 * These exemptions account for the core.ignorecase config -
+	 * a file that differs only by case is also considered "deleted"
+	 * if git is configured to ignore case. This means a case-only
+	 * rename, in a case-insensitive filesystem, is treated here as
+	 * a "self-swap" or mode change.
 	 */
-	if ((tpatch = in_fn_table(state, new_name)) &&
+	if ((tpatch = in_fs_fn_table(state, new_name)) &&
+	    (was_deleted(tpatch) || to_be_deleted(tpatch)))
+		ok_if_exists_in_fs = 1;
+	else
+		ok_if_exists_in_fs = 0;
+
+	if ((tpatch = in_index_fn_table(state, new_name)) &&
 	    (was_deleted(tpatch) || to_be_deleted(tpatch)))
-		ok_if_exists = 1;
+		ok_if_exists_in_index = 1;
 	else
-		ok_if_exists = 0;
+		ok_if_exists_in_index = 0;
 
 	if (new_name &&
 	    ((0 < patch->is_new) || patch->is_rename || patch->is_copy)) {
-		int err = check_to_create(state, new_name, ok_if_exists);
+		int err = check_to_create(state, new_name, ok_if_exists_in_fs,
+					  ok_if_exists_in_index);
 
 		if (err && state->threeway) {
 			patch->direct_to_threeway = 1;
@@ -4870,7 +4910,8 @@ static int apply_patch(struct apply_state *state,
 end:
 	free_patch_list(list);
 	strbuf_release(&buf);
-	string_list_clear(&state->fn_table, 0);
+	string_list_clear(&state->fs_fn_table, 0);
+	string_list_clear(&state->index_fn_table, 0);
 	return res;
 }
 
diff --git a/apply.h b/apply.h
index 7cd38b1443c..a1419672507 100644
--- a/apply.h
+++ b/apply.h
@@ -95,8 +95,11 @@ struct apply_state {
 	/*
 	 * Records filenames that have been touched, in order to handle
 	 * the case where more than one patches touch the same file.
+	 * Two separate structures because with ignorecase, one of them
+	 * needs to be case-insensitive and the other not.
 	 */
-	struct string_list fn_table;
+	struct string_list fs_fn_table;
+	struct string_list index_fn_table;
 
 	/*
 	 * This is to save reporting routines before using
diff --git a/t/t4142-apply-icase.sh b/t/t4142-apply-icase.sh
index 17eb023a437..1c785133d16 100755
--- a/t/t4142-apply-icase.sh
+++ b/t/t4142-apply-icase.sh
@@ -30,7 +30,16 @@ test_expect_success setup '
        git diff HEAD HEAD^ -- file1 >deletion-patch &&
        git diff --cached HEAD -- file1 file2 >rename-file1-to-file2-patch &&
        git diff --cached HEAD -- file1 File1 >rename-file1-to-File1-patch &&
-       git diff --cached HEAD -- file0 >modify-file0-patch
+       git diff --cached HEAD -- file0 >modify-file0-patch &&
+
+       # then set up for swap
+       git reset --hard current &&
+       test_commit "swappable" file3 "different content for file3" swappable &&
+       file3blob=$(git rev-parse :file3) &&
+       git rm --cached file1 file3 &&
+       git update-index --add --cacheinfo 100644,$file1blob,File3 &&
+       git update-index --add --cacheinfo 100644,$file3blob,File1 &&
+       git diff --cached HEAD -- file1 file3 File1 File3 >swap-file1-and-file3-to-File3-and-File1-patch
 '
 
 # Basic creation, deletion, modification and renaming.
@@ -53,7 +62,7 @@ test_expect_success 'creation and deletion' '
        test_must_fail git rev-parse --verify :file1
 '
 
-test_expect_success 'modificaiton' '
+test_expect_success 'modification (index-only)' '
        # start at "initial" with file0 only
        git reset --hard initial &&
 
@@ -70,7 +79,7 @@ test_expect_success 'modificaiton' '
        test_cmp_rev :file0 "$file0blob"
 '
 
-test_expect_success 'rename file1 to file2' '
+test_expect_success 'rename file1 to file2 (index-only)' '
        # start from file0 and file1
        git reset --hard current &&
 
@@ -91,7 +100,7 @@ test_expect_success 'rename file1 to file2' '
        test_cmp_rev :file1 "$file1blob"
 '
 
-test_expect_success 'rename file1 to file2' '
+test_expect_success 'rename file1 to File1 (index-only)' '
        # start from file0 and file1
        git reset --hard current &&
 
@@ -112,17 +121,138 @@ test_expect_success 'rename file1 to file2' '
        test_cmp_rev :file1 "$file1blob"
 '
 
-# We may want to add tests with working tree here, without "--cached" and
-# with and without "--index" here.  For example, should modify-file0-patch
-# apply cleanly if we have File0 with $file0blob in the index and the working
-# tree if core.icase is set?
+# involve filesystem on renames
+test_expect_success 'rename file1 to File1 (with ignorecase, working tree)' '
+       # start from file0 and file1
+       git reset --hard current &&
+
+       # do the same with ignorecase
+       git -c core.ignorecase=true apply --index rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_cmp_rev :File1 "$file1blob" &&
+       git -c core.ignorecase=true apply --index -R rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :File1 &&
+       test_cmp_rev :file1 "$file1blob"
+'
+
+test_expect_success CASE_INSENSITIVE_FS 'rename file1 to File1 (without ignorecase, case-insensitive FS)' '
+       # start from file0 and file1
+       git reset --hard current &&
+
+       # rename file1 to File1 without ignorecase (fails as expected)
+       test_must_fail git -c core.ignorecase=false apply --index rename-file1-to-File1-patch &&
+       git rev-parse --verify :file1 &&
+       test_cmp_rev :file1 "$file1blob"
+'
+
+test_expect_success !CASE_INSENSITIVE_FS 'rename file1 to File1 (without ignorecase, case-sensitive FS)' '
+       # start from file0 and file1
+       git reset --hard current &&
+
+       # rename file1 to File1 without ignorecase
+       git -c core.ignorecase=false apply --index rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_cmp_rev :File1 "$file1blob" &&
+       git -c core.ignorecase=false apply --index -R rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :File1 &&
+       test_cmp_rev :file1 "$file1blob"
+'
+
+test_expect_success 'rename file1 to file2 with working tree conflict' '
+       # start from file0 and file1, and file2 untracked
+       git reset --hard current &&
+       test_when_finished "rm file2" &&
+       touch file2 &&
+
+       # rename file1 to file2 with conflict
+       test_must_fail git -c core.ignorecase=false apply --index rename-file1-to-file2-patch &&
+       git rev-parse --verify :file1 &&
+       test_cmp_rev :file1 "$file1blob" &&
 
-test_expect_success CASE_INSENSITIVE_FS 'a test only for icase fs' '
-       : sample
+       # do the same with ignorecase
+       test_must_fail git -c core.ignorecase=true apply --index rename-file1-to-file2-patch &&
+       git rev-parse --verify :file1 &&
+       test_cmp_rev :file1 "$file1blob"
 '
 
-test_expect_success !CASE_INSENSITIVE_FS 'a test only for !icase fs' '
-       : sample
+test_expect_success 'rename file1 to file2 with case-insensitive conflict (index-only - ignorecase disabled)' '
+       # start from file0 and file1, and File2 in index
+       git reset --hard current &&
+       git update-index --add --cacheinfo 100644,$file3blob,File2 &&
+
+       # rename file1 to file2 without ignorecase
+       git -c core.ignorecase=false apply --cached rename-file1-to-file2-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_cmp_rev :file2 "$file1blob" &&
+       git -c core.ignorecase=false apply --cached -R rename-file1-to-file2-patch &&
+       test_must_fail git rev-parse --verify :file2 &&
+       test_cmp_rev :file1 "$file1blob" &&
+       test_cmp_rev :File2 "$file3blob"
+'
+
+test_expect_failure 'rename file1 to file2 with case-insensitive conflict (index-only - ignorecase enabled)' '
+       # start from file0 and file1, and File2 in index
+       git reset --hard current &&
+       git update-index --add --cacheinfo 100644,$file3blob,File2 &&
+
+       # rename file1 to file2 with ignorecase, with a "File2" conflicting file in place - expect failure.
+       # instead of failure, we get success with "File1" and "file1" both existing in the index, despite
+       # the ignorecase configuration.
+       test_must_fail git -c core.ignorecase=true apply --cached rename-file1-to-file2-patch &&
+       git rev-parse --verify :file1 &&
+       test_cmp_rev :file1 "$file1blob" &&
+       test_cmp_rev :File2 "$file3blob"
+'
+
+test_expect_success 'rename file1 to File1 with case-sensitive conflict (index-only)' '
+       # start from file0 and file1, and File1 in index
+       git reset --hard current &&
+       git update-index --add --cacheinfo 100644,$file3blob,File1 &&
+
+       # On a case-insensitive filesystem with core.ignorecase on, a single git
+       # "reset --hard" will actually leave things wrong because of the
+       # index-to-working-tree discrepancy - see "reset --hard handles
+       # index-only case-insensitive duplicate" under t7104-reset-hard.sh.
+       # We are creating this unexpected state, so we should explicitly queue
+       # an extra reset. If reset ever starts to handle this case, this will
+       # become unnecessary but also not harmful.
+       test_when_finished "git reset --hard" &&
+
+       # rename file1 to File1 when File1 is already in index (fails with conflict)
+       test_must_fail git -c core.ignorecase=false apply --cached rename-file1-to-File1-patch &&
+       git rev-parse --verify :file1 &&
+       test_cmp_rev :file1 "$file1blob" &&
+       test_cmp_rev :File1 "$file3blob" &&
+
+       # do the same with ignorecase
+       test_must_fail git -c core.ignorecase=true apply --cached rename-file1-to-File1-patch &&
+       git rev-parse --verify :file1 &&
+       test_cmp_rev :file1 "$file1blob" &&
+       test_cmp_rev :File1 "$file3blob"
+'
+
+test_expect_success CASE_INSENSITIVE_FS 'case-insensitive swap - file1 to File2 and file2 to File1 (working tree)' '
+       # start from file0, file1, and file3
+       git reset --hard swappable &&
+
+       # "swap" file1 and file3 to case-insensitive versions without ignorecase on case-insensitive FS (fails as expected)
+       test_must_fail git -c core.ignorecase=false apply --index swap-file1-and-file3-to-File3-and-File1-patch &&
+       git rev-parse --verify :file1 &&
+       git rev-parse --verify :file3 &&
+       test_cmp_rev :file1 "$file1blob" &&
+       test_cmp_rev :file3 "$file3blob" &&
+
+       # do the same with ignorecase
+       git -c core.ignorecase=true apply --index swap-file1-and-file3-to-File3-and-File1-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_must_fail git rev-parse --verify :file3 &&
+       test_cmp_rev :File3 "$file1blob" &&
+       test_cmp_rev :File1 "$file3blob" &&
+       git -c core.ignorecase=true apply --index -R swap-file1-and-file3-to-File3-and-File1-patch &&
+       test_must_fail git rev-parse --verify :File1 &&
+       test_must_fail git rev-parse --verify :File3 &&
+       test_cmp_rev :file1 "$file1blob" &&
+       test_cmp_rev :file3 "$file3blob"
 '
 
 test_done
-- 
gitgitgadget
