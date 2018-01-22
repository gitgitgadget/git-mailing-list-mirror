Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66D5D1F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeAVLEm (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:04:42 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:39668 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbeAVLEl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:04:41 -0500
Received: by mail-wm0-f54.google.com with SMTP id b21so15973863wme.4
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=dw5EcrAyV8h2EL2XY3THg1WY/bVr2i5tCddEDE4AtCU=;
        b=gB4KRlfBSAUZSTrQvZkdaE/iHl6guFYKP/UUqBUhmvtWdnUeSZ+lpnU6ainWb/IAFZ
         Gk+2KQtixnjtl3dZnnuFZ8vAidvYawPU6Smk1H+J0clURy6WlbAqXMSnLQJg7jwFLhug
         hxewI4gXZiXPCV6uQXhbFZnnKEOEwMtSSDSNm/lvzNvETrYtkUyV6Bsm3kGZl3G1NYu0
         z+bUzwGCOdaBNFH7+mReTq7mAlvURX1y9D5gLMPM1y2/7wUl9qDghAaNDN69ZebTfs/Y
         mcu9XuXRXLbJRKlQG7JKjGOOriIRxXJGjVOu1UoucTM3kauJ1TsnPHzj2rrBiuncXEGW
         UpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=dw5EcrAyV8h2EL2XY3THg1WY/bVr2i5tCddEDE4AtCU=;
        b=TcV/Lg5gtKoaE6InH2FoWCkbZgolje57LC56c/9mxHs+9MPNKuBUiuH2nrx5XN2pex
         W5EdUWLuO8ZGrfcBsM0vBcFu0lRrcGEj5FPaqryafm9eB2R76dgWVhgZjz5d+xMtN8vp
         Ezj8XKroW3bIeIPdw/XzBzDTdbx2yvwLxubkZf5hVpBNKEzvKTSXeZOBj93oIq54Sfpv
         Fa1s0tuT1WV+YDXuEfmS4bpzzr7oOdk5ezshCqpTxFFwt2X7nygat7QgmodmjlQGboiM
         capedHvcNShi0YzURNfiMmJfbbpnfkQd/d0IlOy0J5yGpvFWG2JY4fDrJJRAJ+vBTFHj
         cykA==
X-Gm-Message-State: AKwxyteqKN8omLxwIkHQpDccfu9a3GYnTSzlVuxl4UuUEhk0o/jeSegM
        8F3YE24dOuK5WVsf+sMaZVRDn79H
X-Google-Smtp-Source: AH8x225WA4dd6E13RCgb0Jk3oBeLqP/i8fXSzVNYIRMRG5sx5zyRm7vUbI7quq1Nip43VBtkigPS6g==
X-Received: by 10.80.177.67 with SMTP id l3mr12501034edd.267.1516619079792;
        Mon, 22 Jan 2018 03:04:39 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id e12sm10833591edm.42.2018.01.22.03.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 03:04:38 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 00/14] Some fixes and bunch of object_id conversions
Date:   Mon, 22 Jan 2018 12:04:23 +0100
Message-Id: <cover.1516617960.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to v1:

Following brian's suggestion I renamed following functions and struct
names to indicate, that they are no longer intended for sha1 algorithm
only:

struct sha1_stat         -> struct oid_stat
pretend_sha1_file        -> pretend_object_file
write_sha1_file          -> write_object_file
hash_sha1_file           -> hash_object_file
hash_sha1_file_literally -> hash_object_file_literally

Added two more patches converting some more functions to struct object_id
and one with pure function rename.

Patryk Obara (14):
  http-push: improve error log
  clang-format: adjust penalty for return type line break
  sha1_file: convert pretend_sha1_file to object_id
  dir: convert struct sha1_stat to use object_id
  sha1_file: convert hash_sha1_file to object_id
  cache: clear whole hash buffer with oidclr
  match-trees: convert splice_tree to object_id
  commit: convert commit_tree* to object_id
  notes: convert combine_notes_* to object_id
  notes: convert write_notes_tree to object_id
  sha1_file: convert write_sha1_file to object_id
  sha1_file: convert force_object_loose to object_id
  sha1_file: convert write_loose_object to object_id
  sha1_file: rename hash_sha1_file_literally

 .clang-format                                 |   2 +-
 Documentation/technical/api-object-access.txt |   2 +-
 apply.c                                       |  12 ++--
 blame.c                                       |   2 +-
 builtin/am.c                                  |   4 +-
 builtin/checkout.c                            |   3 +-
 builtin/commit-tree.c                         |   4 +-
 builtin/commit.c                              |   5 +-
 builtin/hash-object.c                         |   3 +-
 builtin/index-pack.c                          |   5 +-
 builtin/merge.c                               |   8 +--
 builtin/mktag.c                               |   6 +-
 builtin/mktree.c                              |  10 +--
 builtin/notes.c                               |   8 +--
 builtin/pack-objects.c                        |   2 +-
 builtin/receive-pack.c                        |  11 +--
 builtin/replace.c                             |   4 +-
 builtin/tag.c                                 |   2 +-
 builtin/unpack-objects.c                      |  11 +--
 cache-tree.c                                  |  16 ++---
 cache.h                                       |  25 ++++---
 commit.c                                      |  15 ++--
 commit.h                                      |  11 +--
 convert.c                                     |   6 +-
 diffcore-rename.c                             |   4 +-
 dir.c                                         |  56 +++++++--------
 dir.h                                         |  12 ++--
 http-push.c                                   |   4 ++
 log-tree.c                                    |   2 +-
 match-trees.c                                 |  42 ++++++-----
 merge-recursive.c                             |   5 +-
 notes-cache.c                                 |   8 +--
 notes-merge.c                                 |   9 ++-
 notes-utils.c                                 |   9 +--
 notes-utils.h                                 |   3 +-
 notes.c                                       |  63 ++++++++--------
 notes.h                                       |  29 ++++----
 read-cache.c                                  |   6 +-
 sha1_file.c                                   | 100 ++++++++++++++------------
 t/helper/test-dump-untracked-cache.c          |   4 +-
 40 files changed, 279 insertions(+), 254 deletions(-)


base-commit: 59c276cf4da0705064c32c9dba54baefa282ea55
-- 
2.14.3

