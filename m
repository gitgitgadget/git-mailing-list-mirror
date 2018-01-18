Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11BE41FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756633AbeAROvL (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:51:11 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45691 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756624AbeAROvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:51:09 -0500
Received: by mail-lf0-f68.google.com with SMTP id x196so6991575lfd.12
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=JbfIIVHH0zpKypvP/v8/bYLQ0aB+ocG3ro4n0s9Dg1U=;
        b=iR2FkaMnD8rkw4ibzYPAlkaMS9mtJLJWDMhzCxy8pobDoief/74/XZ2tWbwxA/BkPs
         Cy06q8bH0RcjyrBw3NIV7PLFUebDEapsNTgWutTPl8P+gqtVArCDM7KrgvGEq8swMnWH
         rdQhcxxSzZ/UnOWO/xm8Q+qKQEAMKdaQrTTY6OR4p+bcywr304yHuLaf25JoS5Ux16tL
         a/c1T9dxmPnjUiT91JSWtoWz8lztXf0Tbo9Zh76UvIAj3ijhz7v36jgby1rGcCKkXKVS
         1SaXkcSv/QFiODSm9+ULI48gOrzwftBGS6YU/5Et/ysGdtalg9Y9QyKF8DNJZOQfakMn
         sarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=JbfIIVHH0zpKypvP/v8/bYLQ0aB+ocG3ro4n0s9Dg1U=;
        b=fq+4pjX0HHHdSBleOY92dtVCB9Ue9jm+eEQXEhfKxE0APXAa01dnf5PUbORUjSSObZ
         /amhyjqrdEZAMVlJ/GXP6OtifR1YXmZ3Fvueh6WswxPdFfe1fHYwXbYKPBODWwlZpBED
         WYpOHLxaxkpPSzSwCAm/ZGjgiZHwUiV2l6SSzTd8AIuHHiZ7ZtwiZ7+5NWHqJo97pMSe
         HUWibQKhvTUmMwkJNWy6AyNUcf4w8Sbae2Sob0saYrMXwG1VhlXACLvTFBqImA9kPmuc
         +k+jUInKhjvK3fepvY/+xvSlwj/YOalUiVcEUZkDOgWJP8UQSD4oKXOTfO/K/5990MDU
         STgQ==
X-Gm-Message-State: AKwxytfVRUfCr59ETQg5AQrgWgNuz3z8OfsbDrYQ6PlEequvkT15NGpC
        EFnHb+9o8oIfkQagcXXjGaccpgUVjgc=
X-Google-Smtp-Source: ACJfBouaCwafSZGRkwTQWlcLEbIJmtyVg6eiKNacU8t9lELP86CJPHhl/f1+44iH96RZgicUCUn4Ow==
X-Received: by 10.46.101.19 with SMTP id z19mr2833898ljb.66.1516287067179;
        Thu, 18 Jan 2018 06:51:07 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id 23sm560988lju.28.2018.01.18.06.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 06:51:06 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH 00/11] Some fixes and bunch of object_id conversions
Date:   Thu, 18 Jan 2018 15:50:52 +0100
Message-Id: <cover.1516282880.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series puts some mundane groundwork for experimentation with a new
hashing algorithm in git-hash-object.

Some time has passed since my last patches, and  I see, that work on new
hashing algorithm progressed nicely since then:

* brian m. carlson implemented vtable for hash algorithm selection and pushed
the repository format front - thanks to him it's now quite easy to
experimentally replace hashing functions and, e.g. do some performance testing.

* _a lot of people_ contributed to the transition plan, and now it's available
in text format in Documentation dir - Thank you all! It's much more readable
this way.

Patch 1 is not directly related to object_id conversions but helped with
debugging t5540, which kept failing on master for me (spoiler: it was Fedora
fault).  It helps with debugging of failing git-push over HTTP in case of
internal server error, so I think it might be worthwhile.

Patch 2 is a small adjustment to .clang-format, which prevents unnecessary
line breaks after function return type.

Patch 6 is a tiny fix in oidclr function.

All other patches are progressive conversions to struct object_id with some
formatting fixes sprinkled in. These should be somewhat uncontroversial, I hope.

Patryk Obara (11):
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

 .clang-format                        |  2 +-
 apply.c                              | 12 +++----
 blame.c                              |  2 +-
 builtin/am.c                         |  4 +--
 builtin/checkout.c                   |  3 +-
 builtin/commit-tree.c                |  4 +--
 builtin/commit.c                     |  5 +--
 builtin/index-pack.c                 |  3 +-
 builtin/merge.c                      |  8 ++---
 builtin/mktag.c                      |  6 ++--
 builtin/mktree.c                     | 10 +++---
 builtin/notes.c                      |  8 ++---
 builtin/receive-pack.c               | 11 ++++---
 builtin/replace.c                    |  4 +--
 builtin/tag.c                        |  2 +-
 builtin/unpack-objects.c             | 11 ++++---
 cache-tree.c                         | 13 ++++----
 cache.h                              | 13 ++++----
 commit.c                             | 13 ++++----
 commit.h                             | 11 ++++---
 convert.c                            |  6 ++--
 diffcore-rename.c                    |  2 +-
 dir.c                                | 31 +++++++++---------
 dir.h                                |  2 +-
 http-push.c                          |  4 +++
 log-tree.c                           |  2 +-
 match-trees.c                        | 40 +++++++++++------------
 merge-recursive.c                    |  5 +--
 notes-cache.c                        |  8 ++---
 notes-merge.c                        |  9 +++---
 notes-utils.c                        |  9 +++---
 notes-utils.h                        |  3 +-
 notes.c                              | 63 ++++++++++++++++++------------------
 notes.h                              | 29 ++++++++++-------
 read-cache.c                         |  6 ++--
 sha1_file.c                          | 51 +++++++++++++++--------------
 t/helper/test-dump-untracked-cache.c |  4 +--
 37 files changed, 217 insertions(+), 202 deletions(-)

-- 
2.14.3

