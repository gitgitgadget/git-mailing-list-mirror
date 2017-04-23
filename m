Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0ADD207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046098AbdDWVfg (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:35:36 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37282 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046083AbdDWVf3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 42354280AD;
        Sun, 23 Apr 2017 21:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983327;
        bh=QGGs8n2jMiXwIUp5hcZMr9U/sCIzRYa99rD/Hk0JDIk=;
        h=From:To:Cc:Subject:Date:From;
        b=UvwxouiDxRvSGSToabI11YaSowJrjw5Wo0J1AUDd9VM3KVI+aOiHTvx83EEDq9G3k
         0ig6s9KktjVJ4Kj7FHjXBUc576zi9rCIAH6+fGvtCzdgdV7RvnGhfQMJVo2Mrf6zRN
         ZjHf93dvvhZdaQ3I9GpGHDIz4qm15RJNLLRtAykCU8r2afoz8zDxgd+emtYLVb/LNz
         +KqQNQarQH8JfkGTFA7K5AYACQ3O4cFfBwUZgAcmwH/RPA87wdBioviOV5Y8/nrB+d
         P/0Ed2f7BeEc2lJk2zUnxMCbCwYM67FzEjinMRU/Pf+VMIBIhbMcq0ziq1KQSkI+mO
         64W1gfilrrjNmEWD3jNY2smxjWEwaSajnfYTXcovhfc1tbDKccV+d2E0gG5ociOU3r
         +HS59cZ4bryx2qDr1+OvTmUaiFMA1KVdaili6Ehm6CVLkIZBHe/xSs1y+6y6OFSTh7
         RDcsAVccA07CQOLjRDqZHWqIDe/22jrqqm0rJUer7yL1pdtPnkz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/53] object_id part 8
Date:   Sun, 23 Apr 2017 21:34:00 +0000
Message-Id: <20170423213453.253425-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the eighth series of patches to convert unsigned char [20] to
struct object_id.  This series converts lookup_commit, lookup_blob,
lookup_tree, lookup_tag, and finally parse_object to struct object_id.

A small number of functions have temporaries inserted during the
conversion in order to allow conversion of functions that still need to
take unsigned char *; they are removed either later in the series or
will be in a future series.

This series can be fetched from the object-id-part8 branch from either
of the follwing:

https://github.com/bk2204/git
https://git.crustytoothpaste.net/git/bmc/git.git

brian m. carlson (53):
  fetch-pack: convert to struct object_id
  Clean up outstanding object_id transforms.
  Convert struct cache_tree to use struct object_id
  builtin/name-rev: convert to struct object_id
  builtin/prune: convert to struct object_id
  bundle: convert to struct object_id
  branch: convert to struct object_id
  builtin/blame: convert static function to struct object_id
  builtin/rev-parse: convert to struct object_id
  fast-import: convert internal structs to struct object_id
  fast-import: convert to struct object_id
  submodule: convert merge_submodule to use struct object_id
  notes-cache: convert to struct object_id
  parse-options-cb: convert to struct object_id
  reflog_expire: convert to struct object_id
  builtin/verify-commit: convert to struct object_id
  tag: convert parse_tag_buffer to struct object_id
  http-push: convert some static functions to struct object_id
  notes-utils: convert internals to struct object_id
  revision: convert prepare_show_merge to struct object_id
  shallow: convert shallow registration functions to object_id
  sequencer: convert some functions to struct object_id
  builtin/tag: convert to struct object_id
  Convert remaining callers of lookup_commit_reference* to object_id
  Convert lookup_commit* to struct object_id
  pack: convert struct pack_idx_entry to struct object_id
  builtin/unpack-objects: convert to struct object_id
  Convert remaining callers of lookup_blob to object_id
  Convert lookup_blob to struct object_id
  tree: convert read_tree_1 to use struct object_id internally
  builtin/reflog: convert tree_is_complete to take struct object_id
  Convert lookup_tree to struct object_id
  log-tree: convert to struct object_id
  Convert lookup_tag to struct object_id
  Convert the verify_pack callback to struct object_id
  Convert struct ref_array_item to struct object_id
  ref-filter: convert some static functions to struct object_id
  refs: convert struct ref_update to use struct object_id
  refs/files-backend: convert many internals to struct object_id
  http-push: convert process_ls_object and descendants to object_id
  revision: rename add_pending_sha1 to add_pending_oid
  revision: convert remaining parse_object callers to object_id
  upload-pack: convert remaining parse_object callers to object_id
  sha1_name: convert internals of peel_onion to object_id
  builtin/read-tree: convert to struct object_id
  builtin/ls-files: convert overlay_tree_on_cache to object_id
  sequencer: convert fast_forward_to to struct object_id
  merge: convert checkout_fast_forward to struct object_id
  builtin/ls-tree: convert to struct object_id
  diff-lib: convert do_diff_cache to struct object_id
  sequencer: convert do_recursive_merge to struct object_id
  tree: convert parse_tree_indirect to struct object_id
  object: convert parse_object* to take struct object_id

 archive.c                       |   6 +-
 bisect.c                        |   2 +-
 blob.c                          |   6 +-
 blob.h                          |   2 +-
 branch.c                        |  16 +-
 builtin/am.c                    |  18 +-
 builtin/blame.c                 |  14 +-
 builtin/branch.c                |   6 +-
 builtin/checkout.c              |  18 +-
 builtin/clone.c                 |   4 +-
 builtin/commit-tree.c           |   2 +-
 builtin/commit.c                |   8 +-
 builtin/describe.c              |  10 +-
 builtin/diff-tree.c             |   8 +-
 builtin/diff.c                  |   6 +-
 builtin/fast-export.c           |   8 +-
 builtin/fetch.c                 |   7 +-
 builtin/fmt-merge-msg.c         |   8 +-
 builtin/fsck.c                  |  16 +-
 builtin/grep.c                  |   2 +-
 builtin/index-pack.c            |  56 ++---
 builtin/log.c                   |  10 +-
 builtin/ls-files.c              |   6 +-
 builtin/ls-tree.c               |   6 +-
 builtin/merge-base.c            |   6 +-
 builtin/merge-tree.c            |  10 +-
 builtin/merge.c                 |  12 +-
 builtin/name-rev.c              |  32 +--
 builtin/notes.c                 |   2 +-
 builtin/pack-objects.c          |  71 ++++---
 builtin/prune.c                 |   7 +-
 builtin/pull.c                  |  14 +-
 builtin/read-tree.c             |  10 +-
 builtin/receive-pack.c          |   8 +-
 builtin/reflog.c                |  36 ++--
 builtin/replace.c               |   6 +-
 builtin/reset.c                 |  10 +-
 builtin/rev-list.c              |   2 +-
 builtin/rev-parse.c             |  56 ++---
 builtin/show-branch.c           |   4 +-
 builtin/tag.c                   |  66 +++---
 builtin/unpack-objects.c        |  65 +++---
 builtin/verify-commit.c         |  12 +-
 bulk-checkin.c                  |   4 +-
 bundle.c                        |  39 ++--
 bundle.h                        |   4 +-
 cache-tree.c                    |  33 +--
 cache-tree.h                    |   3 +-
 cache.h                         |   4 +-
 commit.c                        |  38 ++--
 commit.h                        |  16 +-
 diff-lib.c                      |  12 +-
 diff.c                          |   4 +-
 diff.h                          |   2 +-
 fast-import.c                   | 441 ++++++++++++++++++++--------------------
 fetch-pack.c                    |  97 ++++-----
 fsck.c                          |   6 +-
 http-backend.c                  |   2 +-
 http-push.c                     |  55 ++---
 list-objects.c                  |   4 +-
 log-tree.c                      |  26 +--
 merge-recursive.c               |  16 +-
 merge.c                         |   4 +-
 notes-cache.c                   |  29 ++-
 notes-cache.h                   |   4 +-
 notes-merge.c                   |  26 +--
 notes-utils.c                   |  18 +-
 object.c                        |  38 ++--
 object.h                        |   8 +-
 pack-bitmap-write.c             |   8 +-
 pack-bitmap.c                   |   4 +-
 pack-check.c                    |  26 ++-
 pack-objects.c                  |   8 +-
 pack-write.c                    |  10 +-
 pack.h                          |   4 +-
 parse-options-cb.c              |   6 +-
 pretty.c                        |   2 +-
 reachable.c                     |   8 +-
 ref-filter.c                    |  38 ++--
 ref-filter.h                    |   2 +-
 reflog-walk.c                   |   6 +-
 refs.c                          |   4 +-
 refs.h                          |   6 +-
 refs/files-backend.c            | 163 +++++++--------
 refs/refs-internal.h            |   4 +-
 remote.c                        |  17 +-
 revision.c                      |  76 +++----
 revision.h                      |   6 +-
 sequencer.c                     |  59 +++---
 server-info.c                   |   2 +-
 sha1_name.c                     |  38 ++--
 shallow.c                       |  34 ++--
 submodule.c                     |  32 +--
 submodule.h                     |   8 +-
 t/helper/test-dump-cache-tree.c |   4 +-
 t/helper/test-match-trees.c     |   4 +-
 tag.c                           |  25 ++-
 tag.h                           |   2 +-
 transport.c                     |   2 +-
 tree.c                          |  22 +-
 tree.h                          |   4 +-
 upload-pack.c                   |  60 +++---
 walker.c                        |   8 +-
 wt-status.c                     |   2 +-
 104 files changed, 1174 insertions(+), 1137 deletions(-)

