Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E227C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiHGC5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHGC5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:57:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39F4B34
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:57:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z16so7253528wrh.12
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=JOXu2MMWvS8I2wvif1Xbk7gkmjE9MrZA4v2So1bdScM=;
        b=IWmot/MUNNgsCtkMAhfeHK4BvcA4jB9xBStAxBx7M88CXTbBWOQubkMZa1C08Iy9PJ
         jg5OXkGw0RCVFVVlqe24co4iYyLVFQ1NvPWOAgmoY95PVg0FLRk1ooL0xg7193Z2ieWC
         JrwcQ9RDbgZ7keCc+vKQ3QaOwe5hzAnc6YtGjFLNCJopxUjcIyB5i8fkagWAHz+LD9uj
         AoFEpCZAWw6ptskP0f52oGcfTTQs7P+goNOBdjZMAVQ7jGgL4B1KS+xyaXE3alQDrv/6
         o31dxX5FGVnD/utHVxMuQFUlSBGkN+DeK+c9Ygg9TnLZrkTSCpZ4syrhuwyhV6T6hK+J
         uuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=JOXu2MMWvS8I2wvif1Xbk7gkmjE9MrZA4v2So1bdScM=;
        b=DNoE8HkJlMe86TU/65TJovu35OyW8+d3a0Vva1QAvQPpWODuBzfFUG6xqc1EckvKfB
         RwSalqf0ZL+7nJjZK0ASd49PtpmMFH605RfKvSryhvIlaqrD5ui6q7Znis1xjJsTz0by
         +KZFHjRttb6fH9MOISzsRW5Rq02EKgYM9a4C/FwvDLZhxiDpI0iRh3jAndwtj5Cf6WBU
         m4xaI9pcpVdU+Bj6p8vYR9gqk/ikHhf5kvZwvbQjgqeKbKs4Qm4SJXMzGvMMihrA78A3
         Aq429I0ad2LB7RB/ZycRFR3neflxj3IhbCOpeEC842zdfXdRVbyrRD4zXjTp783fJb1w
         qS1g==
X-Gm-Message-State: ACgBeo3soL3JSFU7xHg824bJfEDVaI5SIfRu/m2z94STmjHEQffYWRBb
        m1Rs5+OK+0VcEqq/s0j2wB3nS0BC2yo=
X-Google-Smtp-Source: AA6agR7zf+cHOWdMtLtsct4qOddn7B6zYumJbZjhdSR/dXSytIaDLCisgyUIyOBmIdHX65eLlv69kw==
X-Received: by 2002:adf:e0cb:0:b0:21e:9ed9:d862 with SMTP id m11-20020adfe0cb000000b0021e9ed9d862mr7990918wri.518.1659841032242;
        Sat, 06 Aug 2022 19:57:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d6112000000b002207cec45cesm9754188wrt.81.2022.08.06.19.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:57:11 -0700 (PDT)
Message-Id: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 Aug 2022 02:57:05 +0000
Subject: [PATCH v2 0/4] reset/checkout: fix miscellaneous sparse index bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on sparse index integration for 'git rm' [1], Shaoxuan found
that removed sparse directories, when reset, would no longer be sparse. This
was due to how 'unpack_trees()' determined whether a traversed directory was
a sparse directory or not; it would only unpack an entry as a sparse
directory if it existed in the index. However, if the sparse directory was
removed, it would be treated like a non-sparse directory and its contents
would be individually unpacked.

To avoid this unnecessary traversal and keep the results of 'reset' as
sparse as possible, the decision logic for whether a directory is sparse is
changed to:

 * If the directory is a sparse directory in the index, unpack it.
 * If not, is the directory inside the sparse cone? If so, do not unpack it.
 * If the directory is outside the sparse cone, does it have any child
   entries in the index? If so, do not unpack it.
 * Otherwise, unpack the entry as a sparse directory.

In the process of updating 'reset', a separate issue was found in 'checkout'
where collapsed sparse directories did not have modified contents reported
file-by-file. A similar bug was found with 'status' in 2c521b0e49 (status:
fix nested sparse directory diff in sparse index, 2022-03-01), and
'checkout' was corrected the same way (setting the diff flag 'recursive' to
1).


Changes since V1
================

 * Reverted the removal of 'index_entry_exists()' to avoid breaking other
   in-flight series.
 * Renamed 'is_missing_sparse_dir()' to 'is_new_sparse_dir()'; revised
   comments and commit messages to clarify what that function is doing and
   why.
 * Handled "unexpected" inputs to 'is_new_sparse_dir()' more gently,
   returning 0 if 'p' is not a directory or the directory already exists in
   the index (rather than exiting with 'BUG()'). This is intended to make
   'is_new_sparse_dir()' less reliant on information about the index
   established by 'unpack_callback()' & 'unpack_single_entry()', resulting
   in easier-to-read and more reusable code.

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/20220803045118.1243087-1-shaoxuan.yuan02@gmail.com/

Victoria Dye (4):
  checkout: fix nested sparse directory diff in sparse index
  oneway_diff: handle removed sparse directories
  cache.h: create 'index_name_pos_sparse()'
  unpack-trees: unpack new trees as sparse directories

 builtin/checkout.c                       |   1 +
 cache.h                                  |   9 ++
 diff-lib.c                               |   5 ++
 read-cache.c                             |   5 ++
 t/t1092-sparse-checkout-compatibility.sh |  25 ++++++
 unpack-trees.c                           | 106 ++++++++++++++++++++---
 6 files changed, 141 insertions(+), 10 deletions(-)


base-commit: 4af7188bc97f70277d0f10d56d5373022b1fa385
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1312%2Fvdye%2Freset%2Fhandle-missing-dirs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1312/vdye/reset/handle-missing-dirs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1312

Range-diff vs v1:

 1:  255318f4dc6 = 1:  255318f4dc6 checkout: fix nested sparse directory diff in sparse index
 2:  55c77ba4b29 = 2:  55c77ba4b29 oneway_diff: handle removed sparse directories
 3:  f7978d223fe ! 3:  d0bdec63286 cache.h: replace 'index_entry_exists()' with 'index_name_pos_sparse()'
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    cache.h: replace 'index_entry_exists()' with 'index_name_pos_sparse()'
     +    cache.h: create 'index_name_pos_sparse()'
      
     -    Replace 'index_entry_exists()' (which returns a binary '1' or '0' depending
     -    on whether a specified entry exists in the index) with
     -    'index_name_pos_sparse()' (which behaves the same as 'index_name_pos()',
     +    Add 'index_name_pos_sparse()', which behaves the same as 'index_name_pos()',
          except that it does not expand a sparse index to search for an entry inside
     -    a sparse directory).
     +    a sparse directory.
      
     -    'index_entry_exists()' was original implemented in 20ec2d034c (reset: make
     -    sparse-aware (except --mixed), 2021-11-29) to allow callers to search for an
     -    index entry without expanding a sparse index. That particular case only
     -    required knowing whether the requested entry existed. This patch expands the
     -    amount of information returned by indicating both 1) whether the entry
     -    exists, and 2) its position (or potential position) in the index.
     +    'index_entry_exists()' was originally implemented in 20ec2d034c (reset: make
     +    sparse-aware (except --mixed), 2021-11-29) as an alternative to
     +    'index_name_pos()' to allow callers to search for an index entry without
     +    expanding a sparse index. However, that particular use case only required
     +    knowing whether the requested entry existed, so 'index_entry_exists()' does
     +    not return the index positioning information provided by 'index_name_pos()'.
      
     -    Signed-off-by: Victoria Dye <vdye@github.com>
     +    This patch implements 'index_name_pos_sparse()' to accommodate callers that
     +    need the positioning information of 'index_name_pos()', but do not want to
     +    expand the index.
      
     - ## cache-tree.c ##
     -@@ cache-tree.c: static void prime_cache_tree_rec(struct repository *r,
     - 			 * as normal.
     - 			 */
     - 			if (r->index->sparse_index &&
     --			    index_entry_exists(r->index, tree_path->buf, tree_path->len))
     -+			    index_name_pos_sparse(r->index, tree_path->buf, tree_path->len) >= 0)
     - 				prime_cache_tree_sparse_dir(sub->cache_tree, subtree);
     - 			else
     - 				prime_cache_tree_rec(r, sub->cache_tree, subtree, tree_path);
     +    Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## cache.h ##
      @@ cache.h: struct cache_entry *index_file_exists(struct index_state *istate, const char *na
     +  */
       int index_name_pos(struct index_state *, const char *name, int namelen);
       
     - /*
     -- * Determines whether an entry with the given name exists within the
     -- * given index. The return value is 1 if an exact match is found, otherwise
     -- * it is 0. Note that, unlike index_name_pos, this function does not expand
     -- * the index if it is sparse. If an item exists within the full index but it
     -- * is contained within a sparse directory (and not in the sparse index), 0 is
     -- * returned.
     -- */
     --int index_entry_exists(struct index_state *, const char *name, int namelen);
     ++/*
      + * Like index_name_pos, returns the position of an entry of the given name in
      + * the index if one exists, otherwise returns a negative value where the negated
      + * value minus 1 is the position where the index entry would be inserted. Unlike
     @@ cache.h: struct cache_entry *index_file_exists(struct index_state *istate, const
      + * inside a sparse directory.
      + */
      +int index_name_pos_sparse(struct index_state *, const char *name, int namelen);
     - 
     ++
       /*
     -  * Some functions return the negative complement of an insert position when a
     +  * Determines whether an entry with the given name exists within the
     +  * given index. The return value is 1 if an exact match is found, otherwise
      
       ## read-cache.c ##
      @@ read-cache.c: int index_name_pos(struct index_state *istate, const char *name, int namelen)
       	return index_name_stage_pos(istate, name, namelen, 0, EXPAND_SPARSE);
       }
       
     --int index_entry_exists(struct index_state *istate, const char *name, int namelen)
      +int index_name_pos_sparse(struct index_state *istate, const char *name, int namelen)
     - {
     --	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE) >= 0;
     ++{
      +	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE);
     - }
     - 
     - int remove_index_entry_at(struct index_state *istate, int pos)
     ++}
     ++
     + int index_entry_exists(struct index_state *istate, const char *name, int namelen)
     + {
     + 	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE) >= 0;
 4:  016971a6711 ! 4:  97ca668102c unpack-trees: handle missing sparse directories
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    unpack-trees: handle missing sparse directories
     +    unpack-trees: unpack new trees as sparse directories
      
     -    If a sparse directory does not exist in the index, unpack it at the
     -    directory level rather than recursing into it an unpacking its contents
     -    file-by-file. This helps keep the sparse index as collapsed as possible in
     -    cases such as 'git reset --hard' restoring a sparse directory.
     +    If 'unpack_single_entry()' is unpacking a new directory tree (that is, one
     +    not already present in the index) into a sparse index, unpack the tree as a
     +    sparse directory rather than traversing its contents and unpacking each file
     +    individually. This helps keep the sparse index as collapsed as possible in
     +    cases such as 'git reset --hard' restoring a outside-of-cone directory
     +    removed with 'git rm -r --sparse'.
      
     -    A directory is determined to be truly non-existent in the index (rather than
     -    the parent of existing index entries), if 1) its path is outside the sparse
     -    cone and 2) there are no children of the directory in the index. This check
     -    is performed by 'missing_dir_is_sparse()' in 'unpack_single_entry()'. If the
     -    directory is a missing sparse dir, 'unpack_single_entry()'  will proceed
     -    with unpacking it. This determination is also propagated back up to
     -    'unpack_callback()' via 'is_missing_sparse_dir' to prevent further tree
     -    traversal into the unpacked directory.
     +    Without this patch, 'unpack_single_entry()' will only unpack a directory
     +    into the index as a sparse directory (rather than traversing into it and
     +    unpacking its files one-by-one) if an entry with the same name already
     +    exists in the index. This patch allows sparse directory unpacking without a
     +    matching index entry when the following conditions are met:
     +
     +    1. the directory's path is outside the sparse cone, and
     +    2. there are no children of the directory in the index
     +
     +    If a directory meets these requirements (as determined by
     +    'is_new_sparse_dir()'), 'unpack_single_entry()' unpacks the sparse directory
     +    index entry and propagates the decision back up to 'unpack_callback()' to
     +    prevent unnecessary tree traversal into the unpacked directory.
      
          Reported-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
     @@ unpack-trees.c: static struct cache_entry *create_ce_entry(const struct traverse
       }
       
      +/*
     -+ * Determine whether the path specified corresponds to a sparse directory
     -+ * completely missing from the index. This function is assumed to only be
     -+ * called when the named path isn't already in the index.
     ++ * Determine whether the path specified by 'p' should be unpacked as a new
     ++ * sparse directory in a sparse index. A new sparse directory 'A/':
     ++ * - must be outside the sparse cone.
     ++ * - must not already be in the index (i.e., no index entry with name 'A/'
     ++ *   exists).
     ++ * - must not have any child entries in the index (i.e., no index entry
     ++ *   'A/<something>' exists).
     ++ * If 'p' meets the above requirements, return 1; otherwise, return 0.
      + */
     -+static int missing_dir_is_sparse(const struct traverse_info *info,
     -+				 const struct name_entry *p)
     ++static int entry_is_new_sparse_dir(const struct traverse_info *info,
     ++				   const struct name_entry *p)
      +{
      +	int res, pos;
      +	struct strbuf dirpath = STRBUF_INIT;
      +	struct unpack_trees_options *o = info->data;
      +
     ++	if (!S_ISDIR(p->mode))
     ++		return 0;
     ++
      +	/*
     -+	 * First, check whether the path is in the sparse cone. If it is,
     -+	 * then this directory shouldn't be sparse.
     ++	 * If the path is inside the sparse cone, it can't be a sparse directory.
      +	 */
      +	strbuf_add(&dirpath, info->traverse_path, info->pathlen);
      +	strbuf_add(&dirpath, p->path, p->pathlen);
     @@ unpack-trees.c: static struct cache_entry *create_ce_entry(const struct traverse
      +		goto cleanup;
      +	}
      +
     -+	/*
     -+	 * Given that the directory is not inside the sparse cone, it could be
     -+	 * (partially) expanded in the index. If child entries exist, the path
     -+	 * is not a missing sparse directory.
     -+	 */
      +	pos = index_name_pos_sparse(o->src_index, dirpath.buf, dirpath.len);
     -+	if (pos >= 0)
     -+		BUG("cache entry '%s%s' shouldn't exist in the index",
     -+		    info->traverse_path, p->path);
     ++	if (pos >= 0) {
     ++		/* Path is already in the index, not a new sparse dir */
     ++		res = 0;
     ++		goto cleanup;
     ++	}
      +
     ++	/* Where would this sparse dir be inserted into the index? */
      +	pos = -pos - 1;
      +	if (pos >= o->src_index->cache_nr) {
     ++		/*
     ++		 * Sparse dir would be inserted at the end of the index, so we
     ++		 * know it has no child entries.
     ++		 */
      +		res = 1;
      +		goto cleanup;
      +	}
      +
     ++	/*
     ++	 * If the dir has child entries in the index, the first would be at the
     ++	 * position the sparse directory would be inserted. If the entry at this
     ++	 * position is inside the dir, not a new sparse dir.
     ++	 */
      +	res = strncmp(o->src_index->cache[pos]->name, dirpath.buf, dirpath.len);
      +
      +cleanup:
     @@ unpack-trees.c: static int unpack_single_entry(int n, unsigned long mask,
       			       const struct name_entry *names,
      -			       const struct traverse_info *info)
      +			       const struct traverse_info *info,
     -+			       int *is_missing_sparse_dir)
     ++			       int *is_new_sparse_dir)
       {
       	int i;
       	struct unpack_trees_options *o = info->data;
     @@ unpack-trees.c: static int unpack_single_entry(int n, unsigned long mask,
       
      -	if (mask == dirmask && !src[0])
      -		return 0;
     -+	*is_missing_sparse_dir = 0;
     ++	*is_new_sparse_dir = 0;
      +	if (mask == dirmask && !src[0]) {
      +		/*
     -+		 * If the directory is completely missing from the index but
     -+		 * would otherwise be a sparse directory, we should unpack it.
     -+		 * If not, we'll return and continue recursively traversing the
     -+		 * tree.
     ++		 * If we're not in a sparse index, we can't unpack a directory
     ++		 * without recursing into it, so we return.
      +		 */
      +		if (!o->src_index->sparse_index)
      +			return 0;
     @@ unpack-trees.c: static int unpack_single_entry(int n, unsigned long mask,
      +		while (!p->mode)
      +			p++;
      +
     -+		*is_missing_sparse_dir = missing_dir_is_sparse(info, p);
     -+		if (!*is_missing_sparse_dir)
     ++		/*
     ++		 * If the directory is completely missing from the index but
     ++		 * would otherwise be a sparse directory, we should unpack it.
     ++		 * If not, we'll return and continue recursively traversing the
     ++		 * tree.
     ++		 */
     ++		*is_new_sparse_dir = entry_is_new_sparse_dir(info, p);
     ++		if (!*is_new_sparse_dir)
      +			return 0;
      +	}
       
     @@ unpack-trees.c: static int unpack_single_entry(int n, unsigned long mask,
      -	if (mask == dirmask && src[0] &&
      -	    S_ISSPARSEDIR(src[0]->ce_mode))
      +	if (mask == dirmask &&
     -+	    (*is_missing_sparse_dir || (src[0] && S_ISSPARSEDIR(src[0]->ce_mode))))
     ++	    (*is_new_sparse_dir || (src[0] && S_ISSPARSEDIR(src[0]->ce_mode))))
       		conflicts = 0;
       
       	/*
     @@ unpack-trees.c: static int unpack_sparse_callback(int n, unsigned long mask, uns
       	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
       	struct unpack_trees_options *o = info->data;
      -	int ret;
     -+	int ret, is_missing_sparse_dir;
     ++	int ret, is_new_sparse_dir;
       
       	assert(o->merge);
       
     @@ unpack-trees.c: static int unpack_sparse_callback(int n, unsigned long mask, uns
       	 * 'dirmask' accordingly.
       	 */
      -	ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info);
     -+	ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info, &is_missing_sparse_dir);
     ++	ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info, &is_new_sparse_dir);
       
       	if (src[0])
       		discard_cache_entry(src[0]);
     @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned l
       	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
       	struct unpack_trees_options *o = info->data;
       	const struct name_entry *p = names;
     -+	int is_missing_sparse_dir;
     ++	int is_new_sparse_dir;
       
       	/* Find first entry with a real name (we could use "mask" too) */
       	while (!p->mode)
     @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned l
       	}
       
      -	if (unpack_single_entry(n, mask, dirmask, src, names, info) < 0)
     -+	if (unpack_single_entry(n, mask, dirmask, src, names, info, &is_missing_sparse_dir))
     ++	if (unpack_single_entry(n, mask, dirmask, src, names, info, &is_new_sparse_dir))
       		return -1;
       
       	if (o->merge && src[0]) {
     @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned l
       		}
       
       		if (!is_sparse_directory_entry(src[0], names, info) &&
     -+		    !is_missing_sparse_dir &&
     ++		    !is_new_sparse_dir &&
       		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
       						    names, info) < 0) {
       			return -1;

-- 
gitgitgadget
