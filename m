Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0B01F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeA2Whn (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:37:43 -0500
Received: from mail-yb0-f202.google.com ([209.85.213.202]:47250 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbeA2Whl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:37:41 -0500
Received: by mail-yb0-f202.google.com with SMTP id d13so6627071ybn.14
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=TQwy96IiIA3/zb//s4o+jvpcH98RlKf3LmuwbHr0Hh4=;
        b=X/B/y2grb8ZZTbaWuwb94XVAVHHOIsEjB5oaiDGpfBa5uFijN0SmyzBDsvXOzGQ5G+
         dgePhyQI/1Kpl3TI1QCD43lzan534G8mSNKH/BX1m8tQHB/hDq06I+ENtgKtrcUZhDpT
         uoNSGs9vUKgPFTNRYI411/TtI7ApQDcOyZhuwY1zBqDoFxJcZLlC9NCxMwXdVzXnsG+/
         T3EDdAN9uH88/3El8w79mcMJv4uACxLDzx53ESIf/p47RaZFDLHweYUG7pxUpWBIaYS2
         fbVbaaixrnl5hqIVs3JRpUhChKzqRjlVJ9xMellB21EpZei7ycVXKPH/ocOTmc3M6SMF
         RRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=TQwy96IiIA3/zb//s4o+jvpcH98RlKf3LmuwbHr0Hh4=;
        b=J2vW4w8/tP4TNqZJIou3fBO0AFpruuP/qBhe7mNiEF+/FZMSgftL1ujjzGGFcwiTIs
         ZJA5iTynbzC9tVZ9ltfOxzJsDA0MMA+lrhjJbv5OPZ6XHu+hx+2Hy5/ojulPPmSEORfZ
         sXWB+/5EMXJ0gTBPfZUV2ce/0Td+BKe8PZcHfQE/XwIRF1fJKEja0eXb9vSLVGsA5iGm
         74mTsd1MfxPrY64eKfLZO2TKfxw6hlDwBMaByvwVKRjbFGRX6YboKEesxL2sPt1c1O/Q
         kOKbvD/iC/yjTsuYlqsoFIKKziD+ZldwWvFxLOhhi9a1NqElCHoe5t8ZDyBcSuL630Ke
         rqNw==
X-Gm-Message-State: AKwxytc9qCq0Nf0gOQDn9XWSs5Md2H8rPnXtYhwqDzuZQC1mpuWU/mUx
        OtOI4ViyVF8C6+Ag1Jx76ppd/40SbdODd5+zHvQGyr+kVPhJzDgR2Y67YiuGggmolw5el/a9UgS
        yDqILdns+0QA8ihJWMnO04Qw7kRx7nehoK83xHow/nt042orPP9xbHFKciw==
X-Google-Smtp-Source: AH8x227ZpPKfJD+wHBDqOjh4UWfA9m/I+z7s3Zc8MRutLL2WPSA3OdXC6nNgi2a3sYm0zFHSDnlqesrDavw=
MIME-Version: 1.0
X-Received: by 10.129.55.145 with SMTP id e139mr14091554ywa.35.1517265460956;
 Mon, 29 Jan 2018 14:37:40 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:36:51 -0800
Message-Id: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 00/37] removal of some c++ keywords
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A while back there was some discussion of getting our codebase into a state
where we could use a c++ compiler if we wanted to (for various reason like
leveraging c++ only analysis tools, etc.).  Johannes Sixt had a very large
patch that achieved this but it wasn't in a state where it could be upstreamed.
I took that idea and did some removals of c++ keywords (new, template, try,
this, etc) but broke it up into several (well maybe more than several) patches.
I don't believe I've captured all of them in this series but this is at least
moving a step closer to being able to compile using a c++ compiler.

I don't know if this is something the community still wants to move towards,
but if this is something people are still interested in, and this series is
wanted, then we can keep doing these sort of conversions in chunks slowly.

Brandon Williams (37):
  object_info: change member name from 'typename' to 'type_name'
  object: rename function 'typename' to 'type_name'
  blame: rename 'this' variables
  pack-objects: rename 'this' variables
  rev-parse: rename 'this' variable
  diff: rename 'this' variables
  apply: rename 'try' variables
  apply: rename 'new' variables
  checkout: rename 'new' variables
  help: rename 'new' variables
  pack-redundant: rename 'new' variables
  reflog: rename 'new' variables
  remote: rename 'new' variables
  combine-diff: rename 'new' variables
  commit: rename 'new' variables
  diff-lib: rename 'new' variable
  diff: rename 'new' variables
  diffcore-delta: rename 'new' variables
  entry: rename 'new' variables
  http: rename 'new' variables
  imap-send: rename 'new' variables
  line-log: rename 'new' variables
  read-cache: rename 'new' variables
  ref-filter: rename 'new' variables
  remote: rename 'new' variables
  split-index: rename 'new' variables
  submodule: rename 'new' variables
  trailer: rename 'new' variables
  unpack-trees: rename 'new' variables
  init-db: rename 'template' variables
  environment: rename 'template' variables
  diff: rename 'template' variables
  environment: rename 'namespace' variables
  wrapper: rename 'template' variables
  tempfile: rename 'template' variables
  trailer: rename 'template' variables
  replace: rename 'new' variables

 apply.c                                | 106 ++++++++++++-------------
 blame.c                                |  33 ++++----
 builtin/cat-file.c                     |   4 +-
 builtin/checkout.c                     | 138 ++++++++++++++++-----------------
 builtin/diff-tree.c                    |   2 +-
 builtin/fast-export.c                  |   8 +-
 builtin/fsck.c                         |   4 +-
 builtin/grep.c                         |   2 +-
 builtin/help.c                         |  10 +--
 builtin/index-pack.c                   |  12 +--
 builtin/init-db.c                      |  30 +++----
 builtin/merge.c                        |   2 +-
 builtin/mktree.c                       |   4 +-
 builtin/pack-objects.c                 |   8 +-
 builtin/pack-redundant.c               |  48 ++++++------
 builtin/prune.c                        |   2 +-
 builtin/reflog.c                       |   8 +-
 builtin/remote.c                       |  44 +++++------
 builtin/replace.c                      |  28 +++----
 builtin/rev-parse.c                    |  34 ++++----
 builtin/tag.c                          |   2 +-
 builtin/unpack-objects.c               |  10 +--
 builtin/verify-commit.c                |   2 +-
 bulk-checkin.c                         |   2 +-
 cache.h                                |   4 +-
 combine-diff.c                         |  12 +--
 commit.c                               |  20 ++---
 contrib/examples/builtin-fetch--tool.c |   2 +-
 diff-lib.c                             |  20 ++---
 diff.c                                 |  38 ++++-----
 diffcore-delta.c                       |  16 ++--
 entry.c                                |  40 +++++-----
 environment.c                          |  24 +++---
 fast-import.c                          |  16 ++--
 fsck.c                                 |   2 +-
 git-compat-util.h                      |   4 +-
 http-push.c                            |   2 +-
 http.c                                 |  10 +--
 imap-send.c                            |  14 ++--
 line-log.c                             |  48 ++++++------
 log-tree.c                             |   2 +-
 object.c                               |   6 +-
 object.h                               |   2 +-
 pack-check.c                           |   2 +-
 packfile.c                             |   8 +-
 reachable.c                            |   2 +-
 read-cache.c                           |  36 ++++-----
 ref-filter.c                           |  20 ++---
 remote.c                               |  16 ++--
 sequencer.c                            |   2 +-
 sha1_file.c                            |  28 +++----
 sha1_name.c                            |   6 +-
 split-index.c                          |  10 +--
 split-index.h                          |   2 +-
 submodule.c                            |  16 ++--
 submodule.h                            |   2 +-
 tag.c                                  |   2 +-
 tempfile.c                             |  12 +--
 tempfile.h                             |  34 ++++----
 trailer.c                              |  44 +++++------
 unpack-trees.c                         |   6 +-
 walker.c                               |   4 +-
 wrapper.c                              |  40 +++++-----
 63 files changed, 559 insertions(+), 558 deletions(-)

-- 
2.16.0.rc1.238.g530d649a79-goog

