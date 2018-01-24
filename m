Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC6C1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933101AbeAXLML (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:12:11 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:38131 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932891AbeAXLMK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:10 -0500
Received: by mail-lf0-f48.google.com with SMTP id g72so4716389lfg.5
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rnVQUKwSYEIpb/DDoik2iha3OWsY1l4jWAjBWjWOm/s=;
        b=taR2KEVNRQENtMkhKM9COV4nJydC744isL7SOUzWleSTmZvkM6tvHbiNeqmees4Opw
         ikffHMTMRR8tx+vio1aOVPD1TxEvGcN/zGOyaRSIsnvygv4glsJHshRZzoGRBD4KtwoY
         BjtDfkZqdTQMG/ek+G1Sc6sdUG6nk0vtSTlINIqkkBGrQMsAbKJRv+6r+uLDYwhggGVx
         ywt9z8VsOmUeQh1alKNCQrnBOEPbJJbIb6MuAS9BBzwSmcndBnquFwDZtZfsiDcs6pFy
         0EzHnsbxqAAmRxMWfJZDRYN1et61XZ6DX+y3S53XR3x822zFPPsc8A1yk8YJeFG7qWpD
         FcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnVQUKwSYEIpb/DDoik2iha3OWsY1l4jWAjBWjWOm/s=;
        b=XhpmahMbJ+fG6/stvfOrUgOuwSEEt91NVNsYdVdLsoYuZAYEwb4btyAqKLghMDfkUV
         B+eKUKoghR2/rZBJBppDUgIFGX+0YtoJSTggMaXDkV40P7W99/bMF6W5sST/XM5XXqZv
         fVyKu1C76oPSJfPTlkNhikjnR11UohdYWb1chcAOAWokR9htAH1E7Y+7aTxk2Z+utFyu
         WdxyXS0cbd8u4f4/tXXlTkwgJZcLSs6f5OY4lejMJjGG6+uCobgkV1t/Ts6biJSMVofl
         zAoci1znX0GUxD5lyhScAB/WklHpJQNa0xNyhHpyDew/YsrSru8O8gG0V9yj00FEQR/r
         Sgzw==
X-Gm-Message-State: AKwxytftus4FNapDjEnvvsjsKDh3mQHO+qV6DRV0ww4TeN6fnP/pMNa+
        I7KkbqELM1A8Wi0wWk6manI5k92F
X-Google-Smtp-Source: AH8x227IMCe7kwkNLDCGlxGYe4ImK27e3TkiXNeVTLVoGCA60Q+xWQzbMfzuXtADkKwxj0rDCbBEyg==
X-Received: by 10.46.41.71 with SMTP id u68mr3340139lje.17.1516792328455;
        Wed, 24 Jan 2018 03:12:08 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:07 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 00/14] Some fixes and bunch of object_id conversions
Date:   Wed, 24 Jan 2018 12:11:52 +0100
Message-Id: <cover.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to v2:

* rebased to latest master

* patch 1 and 2
I kept them in, but if Junio prefers them separately then I'll send
them as separate patches.

* patch 5
- strbuf_add(buf, sha1_to_hex(oid.hash), GIT_SHA1_HEXSZ);
+ strbuf_addstr(buf, oid_to_hex(&oid));

* patch 7
On suggestion from Duy Nguyễn, I renamed parameter names:
'hash1' and 'hash2' with 'oid1' and 'oid2' to avoid e.g. 'hash1->hash'.

I decided *not to* implement suggested replace_tree_entry_hash
function (when implemented as in mail, t6026-merge-subtree fails).
I think this overwriting of object_id needs to be addressed, but
probably at the time of adjusting tree object format for longer hash.

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
 match-trees.c                                 |  46 ++++++------
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
 40 files changed, 281 insertions(+), 256 deletions(-)


base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
-- 
2.14.3

