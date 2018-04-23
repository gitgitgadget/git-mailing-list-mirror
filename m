Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29591F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932727AbeDWXnc (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:43:32 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:38660 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932608AbeDWXnb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:43:31 -0400
Received: by mail-pf0-f177.google.com with SMTP id o76so5912910pfi.5
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0xdA0FvGEu/M3Ald6JkB7VY6Pwd1vV4D3nQQxmkGcxY=;
        b=ZjiZElocmWyNdgqHxjy2b8OR0yQaRiusY8+5FRDl+azYgYJ44DpDUcTRU3SmNOw20u
         3x7+EoPAqNk5R++/O/4UpbctUMcbZ6jaktQCvT/MkUgDglOJEdYRC8FDp6m5+ZNE84L+
         VvJuCmodXp7yiNo/7Gv4EbVjNaAr/BbFYvtvVpg+elRx7kriYGea2OZdYQVJc3Xm3H+7
         R3fRtrMQQukQYIyHYNoYQvej6HZRzDXkzmuyN+lmH0s16/ZS8imRIzcBi3lJV3YByhAy
         S1UGMWUAB5iRBozrxpSZXdN6iLnwBkfN5xKJ2Bwh7p8SEDS29bvkafWaEeFQaZExR+QZ
         8yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0xdA0FvGEu/M3Ald6JkB7VY6Pwd1vV4D3nQQxmkGcxY=;
        b=HVuMc2BRHTfarSi4UWIjhy00qPMnrooeSFrlXieJXNWuK+PNXsabZtS5/IbUTzSgsk
         DZlAVPOrRe5U7RSMYgzxRVt5TNfZHptk3iFATQxMfeRY00fDSJ72qhwdLrY61tRMmGA0
         aqIHE9VrHqng774Hzz22kVK/ckpt8pq9LVi8cgYahsKbIAeJVjQd62lbxrB4ZxRbSbFY
         a9td/Ugjd+0EmgC0gXdrMJcu4iwzo/RSGFg7NSwOUufdkaHTRZJYfkFqFtCM8fo24M03
         LQB+0IsysIKgUfh2cKEb2XBtHZwy1QhtI1SMuClRHhjF4xxTMskhpWeyI3Ad8wmmsHM+
         42vQ==
X-Gm-Message-State: ALQs6tC7kRripv68gC2YTXcEj1Iz9nWb0tui6DQrAa2pMytu1yPyy+vT
        9y9cWfHAEqlvYHVdSer2czu+VlYBt4A=
X-Google-Smtp-Source: AIpwx4/4tG/NQVs6fYCEV4m24JYYj+BiyoUWEYl57qOh8nOaZJSORZ17vJDiHJPoCz9rq7HqRSv4fQ==
X-Received: by 2002:a17:902:24c7:: with SMTP id l7-v6mr23216939plg.320.1524527010014;
        Mon, 23 Apr 2018 16:43:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y6sm24580017pfd.18.2018.04.23.16.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:43:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/9] object store: oid_object_info is the next contender
Date:   Mon, 23 Apr 2018 16:43:18 -0700
Message-Id: <20180423234327.250484-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This applies on top of origin/sb/object-store-replace and is available as
https://github.com/stefanbeller/git/tree/oid_object_info

This continues the work of sb/packfiles-in-repository,
extending the layer at which we have to pass in an explicit
repository object to oid_object_info.

A test merge to next shows only a minor merge conflicit (adding
different #include lines in one c file), so this might be a good next
step for the object store series.

Notes on further object store series:
I plan on converting the "parsed object store" next,
which would be {alloc, object, tree, commit, tag}.c as that is a prerequisite
for migrating shallow (which is intermingled with grafts) information to the
object store.

There is currently work going on in allocation (mempool - Jameson Miller)
and grafts (deprecate grafts - DScho), which is why I am sending this
series first. I think it can go in parallel to the "parsed object store"
that is coming next.

Thanks,
Stefan

Jonathan Nieder (1):
  packfile: add repository argument to packed_object_info

Stefan Beller (8):
  cache.h: add repository argument to oid_object_info_extended
  cache.h: add repository argument to oid_object_info
  packfile: add repository argument to retry_bad_packed_offset
  packfile: add repository argument to packed_to_object_type
  packfile: add repository argument to read_object
  packfile: add repository argument to unpack_entry
  packfile: add repository argument to cache_or_unpack_entry
  cache.h: allow sha1_object_info to handle arbitrary repositories

 archive-tar.c            |  2 +-
 archive-zip.c            |  3 ++-
 blame.c                  |  4 ++--
 builtin/blame.c          |  2 +-
 builtin/cat-file.c       | 12 ++++++------
 builtin/describe.c       |  2 +-
 builtin/fast-export.c    |  2 +-
 builtin/fetch.c          |  2 +-
 builtin/fsck.c           |  3 ++-
 builtin/index-pack.c     |  4 ++--
 builtin/ls-tree.c        |  2 +-
 builtin/mktree.c         |  2 +-
 builtin/pack-objects.c   | 11 +++++++----
 builtin/prune.c          |  3 ++-
 builtin/replace.c        | 11 ++++++-----
 builtin/tag.c            |  4 ++--
 builtin/unpack-objects.c |  2 +-
 cache.h                  |  7 +++++--
 diff.c                   |  3 ++-
 fast-import.c            | 16 ++++++++++------
 list-objects-filter.c    |  2 +-
 object.c                 |  2 +-
 pack-bitmap-write.c      |  3 ++-
 pack-check.c             |  3 ++-
 packfile.c               | 40 +++++++++++++++++++++++-----------------
 packfile.h               |  6 ++++--
 reachable.c              |  2 +-
 refs.c                   |  2 +-
 remote.c                 |  2 +-
 sequencer.c              |  3 ++-
 sha1_file.c              | 32 ++++++++++++++++++--------------
 sha1_name.c              | 12 ++++++------
 streaming.c              |  2 +-
 submodule.c              |  2 +-
 tag.c                    |  2 +-
 35 files changed, 121 insertions(+), 91 deletions(-)

-- 
2.17.0.484.g0c8726318c-goog

