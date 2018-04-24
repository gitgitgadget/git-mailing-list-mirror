Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62AFB1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeDXV7Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:59:16 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:47026 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeDXV7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:59:15 -0400
Received: by mail-pf0-f174.google.com with SMTP id h69so13391700pfe.13
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7niLFJ9I755sC9mkXUh7ViTka518MKfuaWvbcmF+qko=;
        b=qWrtRJ9LKm/fiZnPKtTTUccA3cLEsF7gcAZqcLWofoH6MwbMKoIQqv4jQ/BwGyYXjh
         N1sxmHTZP9GtzjSRYPMOqWg6virx4UKUalcTZTTqIO24m51z3H5ZrRzY5XKVq3liaeAu
         f5K7931NKfmDwj+h/0hiDIMayXiK4FCbqnytuPf0LKpB43D9GtFp357V7GxPnkfx7Zac
         QYxBMzm/aMMwfvja5Ge40JJnk3p648d2Y5AA8N+3nBDHG3yBVo8ICfg876q6VM7IR81R
         HXgumknQew4zaKQ1+ua+OXp0EUyAlvvHD/oqNMaQMTRIBq6kdAlEif0/ROrrDZY8bhrR
         rUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7niLFJ9I755sC9mkXUh7ViTka518MKfuaWvbcmF+qko=;
        b=B9TaW2nVfp/57TwfcQOX03dJuWKs0jkSG4llsYLB0YrYyb+Jjh4BC31c68zXaLcEHK
         nBAQGo1+PDXKQxrVRdvifvsLtKXNaS2BWhWUguRm4h98AEyj7kSc3tGRewMjibZltphw
         i5pakrTZ0fMKcTfAoeH6zNewIZs368EhZmPkj/pe6rVZ+Ef2a9a78rPGinC/Y5/hJuPH
         HMKwQbjLk1pYscqxOfeONYsUYGlbgFCSjDF5a3hDGz/4EgI20znY1mUolijJJTV3o/q4
         dKeJT7kvwZR3A+tBCPaHBnsPb0sdONCswjfPz6ZdEHrVzFDq/cbIRbByvxUeaixKy46q
         jLnw==
X-Gm-Message-State: ALQs6tB7b04F7SpVMSRvz6qurUIWNH1EaBHetMR05sSTxFl2FJdcHxhh
        Hu47tZAD//OSgz47FnwW/Di16cZ9hzU=
X-Google-Smtp-Source: AIpwx4/LFUjOsFF4TE3ED9FPVuXditAj0NuzhMVcs1rp/MyRusBApFBgqKQHNoBfcv7wEUdTrFQwJA==
X-Received: by 2002:a17:902:1e2:: with SMTP id b89-v6mr26962730plb.389.1524607153760;
        Tue, 24 Apr 2018 14:59:13 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v16sm27312809pfj.123.2018.04.24.14.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:59:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/9] object store: oid_object_info is the next contender
Date:   Tue, 24 Apr 2018 14:59:00 -0700
Message-Id: <20180424215910.22201-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:

* fixed the sha1/oid typo
* removed spurious new line
* Brandon and Jonthan discovered another dependency that I missed due
  to cherrypicking that commit from a tree before partial clone was a thing.
  We error out when attempting to use fetch_object for repos that are not
  the_repository.
  
Thanks,
Stefan

v1:
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
  cache.h: allow oid_object_info to handle arbitrary repositories

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
 sha1_file.c              | 36 +++++++++++++++++++++---------------
 sha1_name.c              | 12 ++++++------
 streaming.c              |  2 +-
 submodule.c              |  2 +-
 tag.c                    |  2 +-
 35 files changed, 124 insertions(+), 92 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog

