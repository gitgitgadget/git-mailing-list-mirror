Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA21C64ED8
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 02:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBYC0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 21:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYC0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:07 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D65819F2D
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso650796wmp.4
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peBHW3eb6OI1S9N9ZVBYEtN6iHUgGTjMZ0aFsS2cnR0=;
        b=LO5MWUUGFHW+uUOCx7eAMb3ALapSQtbRVYqU5J3IZ3ptfgld9PD4/FxYBAg2q52dds
         bXn1kuuCNzPaeHHohJWM7rc1OTkITBHMkwwNAPv6Sbvcj6YaX8dbd2roS2/wca/4LkiJ
         KDnv8oTaZEMfJ9buP9VIJP7qvBi1iGCQGFiJFjFdYASrU68yZBYP9fswWU01hvWWBznK
         rFsIe/REYCQrEUOwbk4qWw6o8kssHJ1jH/8ur0Uy+M/DZsuQzMnQfY3AM0gQzHzAoDQR
         Kf1YH2d1qZXUO517BO75UyZ3DjiAOU9206Ras6oqvIWLeSD0uADr9DJBHfMNdXpp2I9O
         Po7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peBHW3eb6OI1S9N9ZVBYEtN6iHUgGTjMZ0aFsS2cnR0=;
        b=Bie0lSq3reoz1TBGjMgemx9GjHbEdENwz/HpnC1UD0EBAjBHZ69sfysvXfjD1AvcPk
         CN0p8VeMlpGyXdcVe/YbtvNnYdaAJWJ+k9xTP8aGGhRjZ1G/yULXeceK9RQnqS+FUgO2
         lfXbfhgeRNvqrTsgkX3G2XU2KUmZKTf+1VlbnXFUhCvvv+7PbXaLvgxHH4s8wHgOhb/h
         aJBZuU4Q5Pn/XrWHAjcNfjEeQ3lqJkwfKTtHo+huQoL3QeLW2BtmjV/5FumRQdb4TXFa
         AootEmi/NCU/bxGXOaODCciSXh0U35NBm5SzxVUAs3jRNvgHSoZ5is9m1WZttTIcHhXa
         wkjg==
X-Gm-Message-State: AO0yUKWcgCKAouCY6oRJVLrQ29d0wRQiFXEIrNTd4r5MsRV30VIcxTS0
        19cJBTPDHCR4vb7Br6mF/i+3UVlflDw=
X-Google-Smtp-Source: AK7set/lWRKV7VECOBAwAbnj5M6wQRmp7/Quv0J/mHbVz4aL56cRXtIbZZK+IjVDCHDZ1pv7hMzTOA==
X-Received: by 2002:a05:600c:810:b0:3e2:2467:d3f5 with SMTP id k16-20020a05600c081000b003e22467d3f5mr13001159wmp.25.1677291962777;
        Fri, 24 Feb 2023 18:26:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003e0238d9101sm1003586wmb.31.2023.02.24.18.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:26:02 -0800 (PST)
Message-Id: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 02:25:49 +0000
Subject: [PATCH v2 00/11] Clarify API for dir.[ch] and unpack-trees.[ch] -- mark relevant fields as
 internal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1 (thanks to Jonathan Tan for the careful reviews!)

 * Clear o->pl when freeing pl, to avoid risking use-after-free.
 * Initialize o->result in update_sparsity() since it is actually used (by
   check_ok_to_remove()).

Some time ago, I noticed that struct dir_struct and struct
unpack_trees_options both have numerous fields meant for internal use only,
most of which are not marked as such. This has resulted in callers
accidentally trying to initialize some of these fields, and in at least one
case required a fair amount of review to verify other changes were okay --
review that would have been simplified with the apriori knowledge that a
combination of multiple fields were internal-only[1]. Looking closer, I
found that only 6 out of 18 fields in dir_struct were actually meant to be
public[2], and noted that unpack_trees_options also had 11 internal-only
fields (out of 36).

This patch is primarily about moving internal-only fields within these two
structs into an embedded internal struct. Patch breakdown:

 * Patches 1-3: Restructuring dir_struct
   * Patch 1: Splitting off internal-use-only fields
   * Patch 2: Add important usage note to avoid accidentally using
     deprecated API
   * Patch 3: Mark output-only fields as such
 * Patches 4-11: Restructuring unpack_trees_options
   * Patches 4-6: Preparatory cleanup
   * Patches 7-10: Splitting off internal-use-only fields
   * Patch 11: Mark output-only field as such

To make the benefit more clear, here are compressed versions of dir_struct
both before and after the changes. First, before:

struct dir_struct {
    int nr;
    int alloc;
    int ignored_nr;
    int ignored_alloc;
    enum [...] flags;
    struct dir_entry **entries;
    struct dir_entry **ignored;
    const char *exclude_per_dir;
#define EXC_CMDL 0
#define EXC_DIRS 1
#define EXC_FILE 2
    struct exclude_list_group exclude_list_group[3];
    struct exclude_stack *exclude_stack;
    struct path_pattern *pattern;
    struct strbuf basebuf;
    struct untracked_cache *untracked;
    struct oid_stat ss_info_exclude;
    struct oid_stat ss_excludes_file;
    unsigned unmanaged_exclude_files;
    unsigned visited_paths;
    unsigned visited_directories;
};


And after the changes:

struct dir_struct {
    enum [...] flags;
    int nr; /* output only */
    int ignored_nr; /* output only */
    struct dir_entry **entries; /* output only */
    struct dir_entry **ignored; /* output only */
    struct untracked_cache *untracked;
    const char *exclude_per_dir; /* deprecated */
    struct dir_struct_internal {
        int alloc;
        int ignored_alloc;
#define EXC_CMDL 0
#define EXC_DIRS 1
#define EXC_FILE 2
        struct exclude_list_group exclude_list_group[3];
        struct exclude_stack *exclude_stack;
        struct path_pattern *pattern;
        struct strbuf basebuf;
        struct oid_stat ss_info_exclude;
        struct oid_stat ss_excludes_file;
        unsigned unmanaged_exclude_files;
        unsigned visited_paths;
        unsigned visited_directories;
    } internal;
};


The former version has 18 fields (and 3 magic constants) which API users
will have to figure out. The latter makes it clear there are only at most 2
fields you should be setting upon input, and at most 4 which you read at
output, and the rest (including all the magic constants) you can ignore.

[0] Search for "Extremely yes" in
https://lore.kernel.org/git/CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com/
[1]
https://lore.kernel.org/git/CABPp-BFSFN3WM6q7KzkD5mhrwsz--St_-ej5LbaY8Yr2sZzj=w@mail.gmail.com/
[2]
https://lore.kernel.org/git/CABPp-BHgot=CPNyK_xNfog_SqsNPNoCGfiSb-gZoS2sn_741dQ@mail.gmail.com/

Elijah Newren (11):
  dir: separate public from internal portion of dir_struct
  dir: add a usage note to exclude_per_dir
  dir: mark output only fields of dir_struct as such
  unpack-trees: clean up some flow control
  sparse-checkout: avoid using internal API of unpack-trees
  sparse-checkout: avoid using internal API of unpack-trees, take 2
  unpack_trees: start splitting internal fields from public API
  unpack-trees: mark fields only used internally as internal
  unpack-trees: rewrap a few overlong lines from previous patch
  unpack-trees: special case read-tree debugging as internal usage
  unpack-trees: add usage notices around df_conflict_entry

 builtin/read-tree.c       |  10 +-
 builtin/sparse-checkout.c |   4 +-
 dir.c                     | 114 +++++++++---------
 dir.h                     | 110 +++++++++--------
 unpack-trees.c            | 247 ++++++++++++++++++++------------------
 unpack-trees.h            |  42 ++++---
 6 files changed, 277 insertions(+), 250 deletions(-)


base-commit: 06dd2baa8da4a73421b959ec026a43711b9d77f9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1149%2Fnewren%2Fclarify-api-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1149/newren/clarify-api-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1149

Range-diff vs v1:

  1:  7f59ad548d0 =  1:  7f59ad548d0 dir: separate public from internal portion of dir_struct
  2:  239b10e1181 =  2:  239b10e1181 dir: add a usage note to exclude_per_dir
  3:  b8aa14350d3 =  3:  b8aa14350d3 dir: mark output only fields of dir_struct as such
  4:  f5a58123034 =  4:  f5a58123034 unpack-trees: clean up some flow control
  5:  508837fc182 !  5:  975dec0f0eb sparse-checkout: avoid using internal API of unpack-trees
     @@ unpack-trees.c: enum update_sparsity_result update_sparsity(struct unpack_trees_
      +	if (free_pattern_list) {
      +		clear_pattern_list(pl);
      +		free(pl);
     ++		o->pl = NULL;
      +	}
       	trace_performance_leave("update_sparsity");
       	return ret;
  6:  8955b45e354 !  6:  429f195dcfe sparse-checkout: avoid using internal API of unpack-trees, take 2
     @@ Commit message
          Commit 2f6b1eb794 ("cache API: add a "INDEX_STATE_INIT" macro/function,
          add release_index()", 2023-01-12) mistakenly added some initialization
          of a member of unpack_trees_options that was intended to be
     -    internal-only.  Further, it served no purpose as it simply duplicated
     -    the initialization that unpack-trees.c code was already doing.
     +    internal-only.  This initialization should be done within
     +    update_sparsity() instead.
     +
     +    Note that while o->result is mostly meant for unpack_trees() and
     +    update_sparsity() mostly operates without o->result,
     +    check_ok_to_remove() does consult it so we need to ensure it is properly
     +    initialized.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/sparse-checkout.c: static int update_working_directory(struct pattern_li
       	o.skip_sparse_checkout = 0;
       
       	setup_work_tree();
     +
     + ## unpack-trees.c ##
     +@@ unpack-trees.c: enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
     + 
     + 	old_show_all_errors = o->show_all_errors;
     + 	o->show_all_errors = 1;
     ++	index_state_init(&o->result, o->src_index->repo);
     + 
     + 	/* Sanity checks */
     + 	if (!o->update || o->index_only || o->skip_sparse_checkout)
  7:  63ee57478ed !  7:  993da584dbb unpack_trees: start splitting internal fields from public API
     @@ unpack-trees.c: enum update_sparsity_result update_sparsity(struct unpack_trees_
       			       CE_NEW_SKIP_WORKTREE, o->verbose_update);
       
       	/* Then loop over entries and update/remove as needed */
     +@@ unpack-trees.c: enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
     + 	if (free_pattern_list) {
     + 		clear_pattern_list(pl);
     + 		free(pl);
     +-		o->pl = NULL;
     ++		o->internal.pl = NULL;
     + 	}
     + 	trace_performance_leave("update_sparsity");
     + 	return ret;
      @@ unpack-trees.c: static int verify_clean_subdirectory(const struct cache_entry *ce,
       	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
       
  8:  081578b3210 !  8:  8ecb24a45f0 unpack-trees: mark fields only used internally as internal
     @@ unpack-trees.c: enum update_sparsity_result update_sparsity(struct unpack_trees_
       
      -	old_show_all_errors = o->show_all_errors;
      -	o->show_all_errors = 1;
     +-	index_state_init(&o->result, o->src_index->repo);
      +	old_show_all_errors = o->internal.show_all_errors;
      +	o->internal.show_all_errors = 1;
     ++	index_state_init(&o->internal.result, o->src_index->repo);
       
       	/* Sanity checks */
       	if (!o->update || o->index_only || o->skip_sparse_checkout)
  9:  f492ab27b19 =  9:  36ca49c3624 unpack-trees: rewrap a few overlong lines from previous patch
 10:  a5048ea00b2 = 10:  5af04d7fe23 unpack-trees: special case read-tree debugging as internal usage
 11:  efec74c8b49 = 11:  c4f31237634 unpack-trees: add usage notices around df_conflict_entry

-- 
gitgitgadget
