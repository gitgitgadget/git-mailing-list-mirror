Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A23BC43215
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB6C20684
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PleXNKFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfLCOCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46040 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCOCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so3745199wrj.12
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zO+63HI0GVuYPy9zE4sRrFrJVN/Z/ZST+PHQUennf/8=;
        b=PleXNKFojzQeh80+ltZ9LXNgJ/RO8korpG5wLNkKxW8t5CyFuAJ4vBMmSHMskgQeWl
         zEtVu2HrBsI3BKuOteyPcKRuDGsWg3Frrsz1fOZOwpXlXBgz+EKmJHOsRzvYiLl37xm9
         gaVduPNvoMqwafJIDBPVrJqR66zrx+hcxM56c0ndEhOVNuVlX78zk07nYu/Gdb9FNONU
         4GYv729mutgcw6g6A1DpUb7zT/R6awECbGhQG3uQoM8K/ntLOqpPS2ztIzHEym4qACE8
         peC+OPR4u0OJOEPUx8ZzGuRgOJFmZLghe0HeLjgHGtEK1Y/ojuz9KYHRVHyyCWlyKspl
         82lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zO+63HI0GVuYPy9zE4sRrFrJVN/Z/ZST+PHQUennf/8=;
        b=WUeiuqhGItzA+4JJBw9WgMWAH71HwXcH2QTr2XiHxps1P44H1fxBS1wdGkj/f2N4ps
         j4urAAOymW5O2W05NZj2hDoIy9hFztJ60aHcyv+LmAkKmJjt4TXvuE0xNJMEvRBnyoVJ
         grogwXswc9jSCB5/BYoO/H9MyW3FlKDwMDPgjB8IdyCkRLPPu1PcLpnkGFbIIYRDGVeC
         FMFbqSrJgAtcmtm6J03PBIwL694cc1DY5rd4VE5+sIAdnEO2AZLZotWvKMTHkNRyi4vE
         60pouAnhDiAOfjMcEqwr2ELG387C5ZiiGIwiqxg9cacImxVHBZD1cewIUtbvTTwU38W2
         Anmw==
X-Gm-Message-State: APjAAAUi6R8fG+teOaOAu10U10DhY5pxtEUFl9CAwbbXGWxJQ5ZDnxKd
        /AfCr8coQ3R5zCeSkLfxO6nK7RX3
X-Google-Smtp-Source: APXvYqzF2kHZKgHOSMfjSBZBOjt/hLuy4SgBSsuaLyHF9ubOkxyiLarUMDqFF9Q+UdvjKPUFpTbtgw==
X-Received: by 2002:a05:6000:354:: with SMTP id e20mr5799091wre.17.1575381740156;
        Tue, 03 Dec 2019 06:02:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm3237805wmf.29.2019.12.03.06.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:19 -0800 (PST)
Message-Id: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:05 +0000
Subject: [PATCH v4 00/13] Add --pathspec-from-file option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from V3:
================

The branch was rebased onto latest master. These patches remain unchanged
since they were accepted in V3: parse-options.h: add new options 
--pathspec-from-file, --pathspec-file-nulpathspec: add new function to parse
file doc: reset: synchronize description reset: support the 
--pathspec-from-file option doc: commit: synchronize description commit:
support the --pathspec-from-file option These patches are new, extending
support to more git commands: cmd_add: prepare for next patch add: support
the --pathspec-from-file option doc: checkout: remove duplicate synopsis
doc: checkout: fix broken text reference doc: checkout: synchronize 
description doc: restore: synchronize description checkout, restore: support
the --pathspec-from-file option

Cc: Phillip Wood phillip.wood123@gmail.com [phillip.wood123@gmail.com]

Alexandr Miloslavskiy (13):
  parse-options.h: add new options `--pathspec-from-file`,
    `--pathspec-file-nul`
  pathspec: add new function to parse file
  doc: reset: synchronize <pathspec> description
  reset: support the `--pathspec-from-file` option
  doc: commit: synchronize <pathspec> description
  commit: support the --pathspec-from-file option
  cmd_add: prepare for next patch
  add: support the --pathspec-from-file option
  doc: checkout: remove duplicate synopsis
  doc: checkout: fix broken text reference
  doc: checkout: synchronize <pathspec> description
  doc: restore: synchronize <pathspec> description
  checkout, restore: support the --pathspec-from-file option

 Documentation/git-add.txt         |  16 ++-
 Documentation/git-checkout.txt    |  50 +++++++---
 Documentation/git-commit.txt      |  29 ++++--
 Documentation/git-reset.txt       |  48 ++++++---
 Documentation/git-restore.txt     |  26 ++++-
 builtin/add.c                     |  60 ++++++++----
 builtin/checkout.c                |  31 +++++-
 builtin/commit.c                  |  25 ++++-
 builtin/reset.c                   |  25 ++++-
 parse-options.h                   |   2 +
 pathspec.c                        |  38 ++++++++
 pathspec.h                        |  10 ++
 t/t2026-checkout-pathspec-file.sh | 139 +++++++++++++++++++++++++++
 t/t2072-restore-pathspec-file.sh  | 139 +++++++++++++++++++++++++++
 t/t3704-add-pathspec-file.sh      | 127 ++++++++++++++++++++++++
 t/t7107-reset-pathspec-file.sh    | 155 ++++++++++++++++++++++++++++++
 t/t7526-commit-pathspec-file.sh   | 130 +++++++++++++++++++++++++
 t/t9902-completion.sh             |   2 +
 18 files changed, 982 insertions(+), 70 deletions(-)
 create mode 100755 t/t2026-checkout-pathspec-file.sh
 create mode 100755 t/t2072-restore-pathspec-file.sh
 create mode 100755 t/t3704-add-pathspec-file.sh
 create mode 100755 t/t7107-reset-pathspec-file.sh
 create mode 100755 t/t7526-commit-pathspec-file.sh


base-commit: 228f53135a4a41a37b6be8e4d6e2b6153db4a8ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-445%2FSyntevoAlex%2F%230207_pathspec_from_file-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-445/SyntevoAlex/#0207_pathspec_from_file-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/445

Range-diff vs v3:

  1:  19b80326ea =  1:  cca5aee392 parse-options.h: add new options `--pathspec-from-file`, `--pathspec-file-nul`
  2:  55a7c6ec3c =  2:  fea64dfbf9 pathspec: add new function to parse file
  3:  d9f32e523c =  3:  1182ba3953 doc: reset: synchronize <pathspec> description
  4:  8a10ff881b =  4:  cea470fc91 reset: support the `--pathspec-from-file` option
  5:  0b79797e77 =  5:  0e1ac7e8a7 doc: commit: synchronize <pathspec> description
  6:  7e48212002 =  6:  c877866c13 commit: support the --pathspec-from-file option
  -:  ---------- >  7:  a97910cb55 cmd_add: prepare for next patch
  -:  ---------- >  8:  9a62da3470 add: support the --pathspec-from-file option
  -:  ---------- >  9:  5e449c8d29 doc: checkout: remove duplicate synopsis
  -:  ---------- > 10:  a498dda97b doc: checkout: fix broken text reference
  -:  ---------- > 11:  fd166755aa doc: checkout: synchronize <pathspec> description
  -:  ---------- > 12:  9e37a740e6 doc: restore: synchronize <pathspec> description
  -:  ---------- > 13:  c4dd4eaf13 checkout, restore: support the --pathspec-from-file option

-- 
gitgitgadget
