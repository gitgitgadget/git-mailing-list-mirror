Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57CCC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjBWJPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWJPF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:15:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46CA38EB8
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:02 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p3-20020a05600c358300b003e206711347so7551706wmq.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+BRYGk8sGk0SQdE1c1MmmRFamq+9eL43JyE5SEVtuzM=;
        b=h65R5vf9lA4Jfy/jL8XjnU2Khr7nwLc+GbwX99SB1NbUcQ/uu7pMNPXmkRRBUYhjcp
         pCQ2ejy8HusLVAnnq+Cx0k4L3OjBPIFoDIEzmmpUtE3W7PEh4YzEvggTPGeuxczWNq8k
         Or5uAQwaZ4X7swgKNYIDYsenxRNGsDK0uQXRnAnestzd5/2DM17Byc4DebNbFe1BYZVN
         cFnjVRm+48sAMFAubwtvxBcCxuzM3YK7ya0eHY2PDJncGx4xDQXlgEXRHpQc+I2v/MBM
         ICuoD31vy2ALddF+LdZnsoQUEmVJm66o75hpIY/JudBD2wlhNvv/TNky7FRiBx8V1W8I
         0P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BRYGk8sGk0SQdE1c1MmmRFamq+9eL43JyE5SEVtuzM=;
        b=BpM/A3LPGP54Ms5nZzMoMRd+6Q2ikHke4YrGOn05bxagogmjH+cAotxvuKC6iNKlHq
         HohCpLhEzFSf2RcMKwNnernOxJwnxsOAF33ZnwuSsUNp4qY4zmQ5WyutgWCxiCFTVB/E
         kwvLSYcSmRoaAtSq4t1Gdx1o2RrpfFpPTjHmHTJ95VEkzKZtDKWfFZigJrsDJ/jgoWsn
         4AsS3BoGXF7LcD+2QWs0xycB+1bAItdtrVFvho76aqG0DoFR0RPxclz2cj/31HteMW3B
         wIXx6zMxg1w+Kv25MJE9upWuu6de72fhRQmcIGkuJsrNSJiOnaZgY/U9DVmL7BQwHEnb
         y6Ew==
X-Gm-Message-State: AO0yUKVke+PUqLp8ZShIxC5xzga98cGKIsykLwc1g+wVUjn4Dlwu3V8p
        dRO3axMedm4QEvFqTNTz/rPa5iH4QTo=
X-Google-Smtp-Source: AK7set+GF+FuF78ycQjLaPU9otlG1y7rg5nkcofTd9we87Kw6ewvWBjJ/JZjcAPhxl/rhJgyz410xQ==
X-Received: by 2002:a05:600c:43d5:b0:3db:2df0:f2b8 with SMTP id f21-20020a05600c43d500b003db2df0f2b8mr2337882wmn.36.1677143701127;
        Thu, 23 Feb 2023 01:15:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003dd1bd66e0dsm8101573wmh.3.2023.02.23.01.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:15:00 -0800 (PST)
Message-Id: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 09:14:49 +0000
Subject: [PATCH 00/11] Clarify API for dir.[ch] and unpack-trees.[ch] -- mark relevant fields as
 internal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote this patch series about a year and a half ago, but never submitted
it. I rebased and updated it due to [0].

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
 unpack-trees.c            | 245 ++++++++++++++++++++------------------
 unpack-trees.h            |  42 ++++---
 6 files changed, 275 insertions(+), 250 deletions(-)


base-commit: 06dd2baa8da4a73421b959ec026a43711b9d77f9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1149%2Fnewren%2Fclarify-api-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1149/newren/clarify-api-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1149
-- 
gitgitgadget
