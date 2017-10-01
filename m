Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC2D20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbdJAWIp (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:08:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54072 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751901AbdJAWIo (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:08:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2154060D89;
        Sun,  1 Oct 2017 22:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895721;
        bh=by2+8S3fxkWzFaLETeSvWVd+zF7yChs4sRm0Zn+tXJM=;
        h=From:To:Cc:Subject:Date:From;
        b=j3hNe/nXgE2jbKNNfwbAZ7WM1UAQ9256ltJnhFJ4ZTz6ln/hDVEvGBgfeJdidutFW
         YXWsUFKH6YH3QTEfnz0UQnvJPJ8QAN/Mc9YN926LOAeYfvHYwEzj06YdSQO60nmsRy
         4z9J71cxIzsVq+0hqP0QcybtXomZtuMVlVOTkZnUWju/91gwzuDk/lIevpNkJ+J7t7
         548O3LInucQhairmcYqIa0Vnb38hgNSD0sy9SeoYbVkkEyX7SMichKFG8tI0ZazLjt
         v4joa/0AcsilgusOj1EqJAs9WNpTNBrScKTHN1BujrWdhdX6qTAukGfQJFYcVosqGe
         HU6URu3o7z/9AGAOaBbh4Z/5EUeaSl1OPf6yaKPFGfgITX0hu/kzRWgXfQVtgQp/2Y
         cD3ulWNSldaq/6fVKMJ++xM1rtnSZm2YsvGOfIXtQq9PxFEF3LCitLcp/GBYGpX4PL
         Set4sg6SozTlyyebKswkzEn+TLNY6XQh7QMDbhI+OQRiOB6nsKq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 00/24] object_id part 10
Date:   Sun,  1 Oct 2017 22:08:07 +0000
Message-Id: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the tenth in a series of patches to convert from unsigned char
[20] to struct object_id.  This series mostly involves changes to the
refs code.  After these changes, there are almost no references to
unsigned char in the main refs code.

I've tried to update the code comments as I've touched them, but if I've
missed any, please point them out.  A big thank-you goes out to René
Scharfe, who did the work to make resolve_ref_unsafe optionally take a
NULL pointer; this dramatically reduced the size of one of the patches,
and allowed a few others to be dropped during the rebase.

I apologize for the unintended bounced emails that occurred in late
August; my mail server (previously hosted at home) got knocked offline
because I was without Internet for over a week after Hurricane Harvey.
I've since relocated mail to New York, so that shouldn't happen again.

This series is available from the following URL:
https://github.com/bk2204/git.git object-id-part10

brian m. carlson (24):
  walker: convert to struct object_id
  refs/files-backend: convert struct ref_to_prune to object_id
  refs: convert delete_ref and refs_delete_ref to struct object_id
  refs: convert update_ref and refs_update_ref to use struct object_id
  refs: update ref transactions to use struct object_id
  Convert check_connected to use struct object_id
  refs: convert resolve_refdup and refs_resolve_refdup to struct
    object_id
  refs: convert read_ref and read_ref_full to object_id
  refs: convert dwim_ref and expand_ref to struct object_id
  builtin/reflog: convert remaining unsigned char uses to object_id
  refs: convert dwim_log to struct object_id
  pack-bitmap: convert traverse_bitmap_commit_list to object_id
  builtin/pack-objects: convert to struct object_id
  refs: convert peel_ref to struct object_id
  refs: convert read_ref_at to struct object_id
  refs: convert reflog_expire parameter to struct object_id
  sha1_file: convert index_path and index_fd to struct object_id
  Convert remaining callers of resolve_gitlink_ref to object_id
  refs: convert resolve_gitlink_ref to struct object_id
  worktree: convert struct worktree to object_id
  refs: convert resolve_ref_unsafe to struct object_id
  refs: convert peel_object to struct object_id
  refs: convert read_raw_ref backends to struct object_id
  refs/files-backend: convert static functions to object_id

 archive.c                   |   2 +-
 bisect.c                    |   6 +-
 blame.c                     |   4 +-
 branch.c                    |   4 +-
 builtin/am.c                |  16 ++--
 builtin/branch.c            |   8 +-
 builtin/checkout.c          |  13 ++-
 builtin/clone.c             |  22 ++---
 builtin/commit.c            |   4 +-
 builtin/describe.c          |   2 +-
 builtin/fast-export.c       |   2 +-
 builtin/fetch.c             |   8 +-
 builtin/fmt-merge-msg.c     |   2 +-
 builtin/fsck.c              |   2 +-
 builtin/log.c               |   2 +-
 builtin/merge-base.c        |   2 +-
 builtin/merge.c             |  17 ++--
 builtin/notes.c             |  12 +--
 builtin/pack-objects.c      | 135 +++++++++++++-------------
 builtin/pull.c              |   2 +-
 builtin/receive-pack.c      |  16 ++--
 builtin/reflog.c            |  18 ++--
 builtin/remote.c            |   2 +-
 builtin/replace.c           |   8 +-
 builtin/reset.c             |   6 +-
 builtin/rev-list.c          |   4 +-
 builtin/rev-parse.c         |   2 +-
 builtin/show-branch.c       |  13 ++-
 builtin/show-ref.c          |   4 +-
 builtin/submodule--helper.c |   2 +-
 builtin/tag.c               |   8 +-
 builtin/update-index.c      |  10 +-
 builtin/update-ref.c        |  12 +--
 builtin/worktree.c          |   6 +-
 bundle.c                    |   4 +-
 combine-diff.c              |   2 +-
 connected.c                 |  18 ++--
 connected.h                 |   4 +-
 diff-lib.c                  |   4 +-
 dir.c                       |   8 +-
 fast-import.c               |   6 +-
 notes-cache.c               |   5 +-
 notes-merge.c               |   2 +-
 notes-utils.c               |   4 +-
 notes.c                     |   2 +-
 pack-bitmap.c               |   8 +-
 pack-bitmap.h               |   2 +-
 read-cache.c                |   6 +-
 ref-filter.c                |   4 +-
 reflog-walk.c               |   6 +-
 refs.c                      | 228 +++++++++++++++++++++-----------------------
 refs.h                      |  75 +++++++--------
 refs/files-backend.c        | 118 +++++++++++------------
 refs/packed-backend.c       |  14 +--
 refs/ref-cache.c            |   2 +-
 refs/refs-internal.h        |  22 ++---
 remote-testsvn.c            |   2 +-
 remote.c                    |   9 +-
 sequencer.c                 |  15 ++-
 sha1_file.c                 |  32 +++----
 sha1_name.c                 |  11 +--
 submodule.c                 |   2 +-
 t/helper/test-ref-store.c   |  28 +++---
 transport-helper.c          |  15 ++-
 transport.c                 |   6 +-
 unpack-trees.c              |   8 +-
 upload-pack.c               |   4 +-
 walker.c                    |  24 ++---
 worktree.c                  |   2 +-
 worktree.h                  |   2 +-
 wt-status.c                 |   4 +-
 71 files changed, 532 insertions(+), 552 deletions(-)

-- 
2.14.2.822.g60be5d43e6

