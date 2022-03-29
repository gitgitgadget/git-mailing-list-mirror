Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0640C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 01:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiC2BIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 21:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiC2BIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 21:08:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0235464FD
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 18:07:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so22606000wrg.12
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 18:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F40Mcrq+7hAoMc6NU7zgbVlXpucevbNfLeXbkPm+VGA=;
        b=nIMn8zXnif04t0z5qbOx6VqzBeg7sIjaXUd69XPZnLmqmWacOBgpX+lG+1i2T7gfvI
         aAQSoe1LM+iG0urweN6E8k53dqD+FZPhXSC5sEs7pzNzctn7w6zAc3FbVn7kB2/6rWwA
         X3W+67QAU996dObBqv+mY+yomjJQAtgh22FedlmgcuXnaXPWqP9EeJ31kcANVnJtPcr8
         NHQJ8nOpmBPV/tOGxs//KbdVZkq+D8p+dFTkC5BOUrVfoIZ9efFCc8jqA9mAjrx07yqh
         /oJC/NTvFVvxBCRkY0g49AWOUPTYS3GiBB+M45DsB/+UEMcmFrOjG1u+NUT/gsD2yeKD
         Ueyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F40Mcrq+7hAoMc6NU7zgbVlXpucevbNfLeXbkPm+VGA=;
        b=iHGcoxtV9n5vK47VGxByyGvX4dbb1bXpwqxiJGgr3VQV9V70JyG3n46R3tNYsUVFbz
         nwnxeU77K0fbdz9ktzzAfQ0rMG0H0XBB1yR2bm6OkmD2JUm0LfJp7C4qAdmXSHTOMrEQ
         0CLr9K3vUtnqukD1MrI3ibbv00CgyNx8oHZvx7TT6A9pn9UJ4NjLRy0X9ykwYLxzrAUp
         Et6AmztGmUVh3Ktt+taRf3xz9/AmMjm9zNBydpEQJ/jlYIgWf39bqftNBKKJDZeyaaZj
         g2sPIsXFQINIoRLmcrgaLDTn8PPDHSz+/PwF8X22stqk4S6tsRtRR4Vtfk6VXAR0pgyD
         lsXA==
X-Gm-Message-State: AOAM530j6QDzkEb+5BE1XZItiqiEPxm1hzlnDT2Q0tb+Mq20Pc231XUk
        +Q7ErfyhULuO1vxotmZ/Ekjf+cMOucM=
X-Google-Smtp-Source: ABdhPJxXwadbLiZVOcWji022Sx09CB+gxQK7d+qPGsOOx0CjHArTSdTscBOhlROEQseNA7ukdxPZog==
X-Received: by 2002:a5d:6211:0:b0:1ef:85dd:c96b with SMTP id y17-20020a5d6211000000b001ef85ddc96bmr27659093wru.456.1648516029075;
        Mon, 28 Mar 2022 18:07:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d6d52000000b00203da94cf01sm13460233wri.14.2022.03.28.18.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 18:07:08 -0700 (PDT)
Message-Id: <pull.1187.v2.git.1648516027925.gitgitgadget@gmail.com>
In-Reply-To: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
References: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 01:07:07 +0000
Subject: [PATCH v2] mv: refresh stat info for moved entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     reichemn@icloud.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update the stat info of the moved index entry in 'rename_index_entry_at()'
if the entry is up-to-date with the index. Internally, 'git mv' uses
'rename_index_entry_at()' to move the source index entry to the destination.
However, it directly copies the stat info of the original cache entry, which
will not reflect the 'ctime' of the file renaming operation that happened as
part of the move. If a file is otherwise up-to-date with the index, that
difference in 'ctime' will make the entry appear out-of-date until the next
index-refreshing operation (e.g., 'git status').

Some commands, such as 'git reset', use the cached stat information to
determine whether a file is up-to-date; if this information is incorrect,
the command will fail when it should pass. In order to ensure a moved entry
is evaluated as 'up-to-date' when appropriate, refresh the destination index
entry's stat info in 'git mv' if and only if the file is up-to-date.

Note that the test added in 't7001-mv.sh' requires a "sleep 1" to ensure the
'ctime' of the file creation will be definitively older than the 'ctime' of
the renamed file in 'git mv'.

Reported-by: Maximilian Reichel <reichemn@icloud.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
    mv: refresh stat info for moved entry
    
    This patch fixes a bug [1] encountered when executing 'git reset --merge
    HEAD' immediately after 'git mv'. Because the stat info of the original
    entry is copied to the new one, including all cached stat information,
    the 'ctime' isn't updated corresponding to the rename. If the index
    entry is otherwise up-to-date with the contents on-disk, the incorrect
    'ctime' makes subsequent operations (e.g., 'git reset --merge') identify
    the index entry as out-of-date, failing when they should succeed.
    
    Note, however, that we use 'refresh_cache_entry()' to refresh the stat
    information rather than 'fill_stat_cache_info()' directly because the
    stat information should only be updated if the index entry is up-to-date
    with the file on-disk. If we ignored this distinction, the stat info
    would match the state of unstaged changes on-disk, not the entry in the
    index as it should.
    
    To avoid exiting 'git mv' with a stale index that may affect subsequent
    commands, 'rename_index_entry_at()' (used internally by 'git mv') is
    updated to refresh the destination index entry's stat information after
    the move is complete.
    
    [1]
    https://lore.kernel.org/git/84FF8F9A-3A9A-4F2A-8D8E-5D50F2F06203@icloud.com/
    
    
    Changes since V1
    ================
    
     * Determined the exact cause of the failure (the mismatched 'ctime'),
       as well as the reasoning for why the stat information cannot always
       be updated; revised the implementation accordingly.
     * Fixed usage of 'refresh_cache_entry()'; because it does not update
       cache entries in-place, insert its return value into the index (if
       valid), and discard the no-longer-needed 'new_entry' cache entry.
     * Updated the test for the bug report scenario to wait long enough such
       that the 'ctime' of the 'mv' is distinct from the original file
       creation time.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1187%2Fvdye%2Freset%2Fmerge-inconsistency-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1187/vdye/reset/merge-inconsistency-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1187

Range-diff vs v1:

 1:  fe9f5f0d8ec ! 1:  bde58070eda mv: refresh stat info for moved entry
     @@ Metadata
       ## Commit message ##
          mv: refresh stat info for moved entry
      
     -    Add 'refresh_cache_entry()' after moving the index entry in
     -    'rename_index_entry_at()'. Internally, 'git mv' uses
     -    'rename_index_entry_at()' to move the source index entry to the destination,
     -    overwriting the old entry if '-f' is specified. However, it does not refresh
     -    the stat information on destination index entry, making its 'CE_UPTODATE'
     -    flag out-of-date until the index is refreshed (e.g., by 'git status').
     +    Update the stat info of the moved index entry in 'rename_index_entry_at()'
     +    if the entry is up-to-date with the index. Internally, 'git mv' uses
     +    'rename_index_entry_at()' to move the source index entry to the destination.
     +    However, it directly copies the stat info of the original cache entry, which
     +    will not reflect the 'ctime' of the file renaming operation that happened as
     +    part of the move. If a file is otherwise up-to-date with the index, that
     +    difference in 'ctime' will make the entry appear out-of-date until the next
     +    index-refreshing operation (e.g., 'git status').
      
     -    Some commands, such as 'git reset', assume the 'CE_UPTODATE' information
     -    they read from the index is accurate, and use that information to determine
     -    whether the operation can be done successfully or not. In order to ensure
     -    the index is correct for commands such as these, explicitly refresh the
     -    destination index entry in 'git mv' before exiting.
     +    Some commands, such as 'git reset', use the cached stat information to
     +    determine whether a file is up-to-date; if this information is incorrect,
     +    the command will fail when it should pass. In order to ensure a moved entry
     +    is evaluated as 'up-to-date' when appropriate, refresh the destination index
     +    entry's stat info in 'git mv' if and only if the file is up-to-date.
     +
     +    Note that the test added in 't7001-mv.sh' requires a "sleep 1" to ensure the
     +    'ctime' of the file creation will be definitively older than the 'ctime' of
     +    the renamed file in 'git mv'.
      
          Reported-by: Maximilian Reichel <reichemn@icloud.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## read-cache.c ##
     +@@ read-cache.c: static void replace_index_entry(struct index_state *istate, int nr, struct cache
     + 
     + void rename_index_entry_at(struct index_state *istate, int nr, const char *new_name)
     + {
     +-	struct cache_entry *old_entry = istate->cache[nr], *new_entry;
     ++	struct cache_entry *old_entry = istate->cache[nr], *new_entry, *refreshed;
     + 	int namelen = strlen(new_name);
     + 
     + 	new_entry = make_empty_cache_entry(istate, namelen);
      @@ read-cache.c: void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
     + 	cache_tree_invalidate_path(istate, old_entry->name);
       	untracked_cache_remove_from_index(istate, old_entry->name);
       	remove_index_entry_at(istate, nr);
     - 	add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
     -+	refresh_cache_entry(istate, new_entry, CE_MATCH_REFRESH);
     +-	add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
     ++
     ++	/*
     ++	 * Refresh the new index entry. Using 'refresh_cache_entry' ensures
     ++	 * we only update stat info if the entry is otherwise up-to-date (i.e.,
     ++	 * the contents/mode haven't changed). This ensures that we reflect the
     ++	 * 'ctime' of the rename in the index without (incorrectly) updating
     ++	 * the cached stat info to reflect unstaged changes on disk.
     ++	 */
     ++	refreshed = refresh_cache_entry(istate, new_entry, CE_MATCH_REFRESH);
     ++	if (refreshed && refreshed != new_entry) {
     ++		add_index_entry(istate, refreshed, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
     ++		discard_cache_entry(new_entry);
     ++	} else
     ++		add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
       }
       
       void fill_stat_data(struct stat_data *sd, struct stat *st)
     @@ t/t7001-mv.sh: test_description='git mv in subdirs'
      +
      +	echo foo >foo &&
      +	git add foo &&
     ++
     ++	# Wait one second to ensure ctime of rename will differ from original
     ++	# file creation ctime.
     ++	sleep 1 &&
      +	git mv -f foo bar &&
     -+	git reset --merge HEAD
     ++	git reset --merge HEAD &&
     ++
     ++	# Verify the index has been reset
     ++	git diff-files >out &&
     ++	test_must_be_empty out
      +'
      +
       test_expect_success 'prepare reference tree' '


 read-cache.c  | 17 +++++++++++++++--
 t/t7001-mv.sh | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 3e0e7d41837..4df97e185e9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -134,7 +134,7 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 
 void rename_index_entry_at(struct index_state *istate, int nr, const char *new_name)
 {
-	struct cache_entry *old_entry = istate->cache[nr], *new_entry;
+	struct cache_entry *old_entry = istate->cache[nr], *new_entry, *refreshed;
 	int namelen = strlen(new_name);
 
 	new_entry = make_empty_cache_entry(istate, namelen);
@@ -147,7 +147,20 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 	cache_tree_invalidate_path(istate, old_entry->name);
 	untracked_cache_remove_from_index(istate, old_entry->name);
 	remove_index_entry_at(istate, nr);
-	add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+
+	/*
+	 * Refresh the new index entry. Using 'refresh_cache_entry' ensures
+	 * we only update stat info if the entry is otherwise up-to-date (i.e.,
+	 * the contents/mode haven't changed). This ensures that we reflect the
+	 * 'ctime' of the rename in the index without (incorrectly) updating
+	 * the cached stat info to reflect unstaged changes on disk.
+	 */
+	refreshed = refresh_cache_entry(istate, new_entry, CE_MATCH_REFRESH);
+	if (refreshed && refreshed != new_entry) {
+		add_index_entry(istate, refreshed, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+		discard_cache_entry(new_entry);
+	} else
+		add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
 
 void fill_stat_data(struct stat_data *sd, struct stat *st)
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 963356ba5f9..a402908142d 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -4,6 +4,25 @@ test_description='git mv in subdirs'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
+test_expect_success 'mv -f refreshes updated index entry' '
+	echo test >bar &&
+	git add bar &&
+	git commit -m test &&
+
+	echo foo >foo &&
+	git add foo &&
+
+	# Wait one second to ensure ctime of rename will differ from original
+	# file creation ctime.
+	sleep 1 &&
+	git mv -f foo bar &&
+	git reset --merge HEAD &&
+
+	# Verify the index has been reset
+	git diff-files >out &&
+	test_must_be_empty out
+'
+
 test_expect_success 'prepare reference tree' '
 	mkdir path0 path1 &&
 	COPYING_test_data >path0/COPYING &&

base-commit: abf474a5dd901f28013c52155411a48fd4c09922
-- 
gitgitgadget
