Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B0EC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 19:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EE3206E6
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 19:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liOJAe31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFTDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:03:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44494 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFTDT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 14:03:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id n7so3579819wrt.11
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 11:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=drmxDzlvGZu/zKmR4VbczSZF5RawGooti/+oH53kFgY=;
        b=liOJAe31mQOTYUgrhlULOR3+9CF5U9wrV6wxVf0y9fEvWVSFHKwbEnFURZZm+uoDgh
         7upORCStPlscujdfSrOpT3HV0jV0gEcyyvrTiznvgJy9RDCNsioY7W5x5tpgrs9DH7cQ
         KKoCvKSd8ls0wVSSsx/pisWCV4lvFSMDwQR4mop/MLhKxZ5fNTcC0h98QrjXNI5nXx9t
         EoPwlh12JefxpFiGVOUePLxE8iJRBJzW9LO89uhvPJRkC43ogjY3OD16lrnKKvon1LR6
         s59a9fHW5mr7wc0BytCF0yJsDNKA7VafmO7l8gYmbeqKaHvPveVOjOkX60+LqPdK7O4w
         trdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=drmxDzlvGZu/zKmR4VbczSZF5RawGooti/+oH53kFgY=;
        b=TZf54PLQkwtgppuxoGLciQgf43UquGVjPHVvm6r2yl4o5kOYKl09VA+Oej95m3Bk/e
         CDz1Ai/v2yFcxMnJ1P1aEsuWuqBUetsNVGCNC0ZXDnpXni06nRX/NmmdPEggbj6IYWwr
         c1tTNMRtxz2lR8GZR5avnIBo4/yP86zZLZatKvf77pKYpTfSBcrtn6pcOBs65OS5NMku
         zroPlaQl43hNl7t/PNivftJSjq36e2VvyKRlyGnT5aHGigFi8K2EfFTGd7YYjDSdfaDM
         VV6PJ5hT7PF/3VuxVSxTQGZlJTf10e8nN+Qsuq1mPa7/Wl6LW1NbxJ4Bi2WYWeCj+vDS
         BVwQ==
X-Gm-Message-State: ANhLgQ17n51fCKBY/wvhyOn2alLJL6YNe8Ch36ha42+UQHaKq2z4Ej/Y
        /T12XrIrtVAaBYU5pYNbKY4iRUqR
X-Google-Smtp-Source: ADFU+vscWdHI8zP+RjBXO8F1XrkZy+hbcAMNZYim1lWXCrhCfvywtHxRC6lJ9wmy8bAJLyLAm3JD8Q==
X-Received: by 2002:a5d:6884:: with SMTP id h4mr5291080wru.91.1583521397844;
        Fri, 06 Mar 2020 11:03:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m25sm14169760wml.35.2020.03.06.11.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 11:03:17 -0800 (PST)
Message-Id: <pull.575.git.1583521396.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Mar 2020 19:03:12 +0000
Subject: [PATCH 0/4] Fix bugs related to real_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The issue with `real_path()` seems to be long-standing, where multiple
people solved parts of it over time. I'm adding another part here
after I have discovered a crash related to it.

Even with this step, there are still problems remaining:
* `read_gitfile_gently()` still uses shared buffer.
* `absolute_path()` was not removed.

These issues remain because there're too many code references and I'd like
to avoid submitting a single topic of a scary size.

Alexandr Miloslavskiy (4):
  set_git_dir: fix crash when used with real_path()
  real_path: remove unsafe API
  real_path_if_valid(): remove unsafe API
  get_superproject_working_tree(): return strbuf

 abspath.c                  | 18 +-----------------
 builtin/clone.c            |  7 ++++++-
 builtin/commit-graph.c     |  6 +++++-
 builtin/init-db.c          |  4 ++--
 builtin/rev-parse.c        | 12 ++++++++----
 builtin/worktree.c         | 10 +++++++---
 cache.h                    |  4 +---
 editor.c                   | 11 +++++++++--
 environment.c              | 18 ++++++++++++++++--
 path.c                     |  4 ++--
 setup.c                    | 37 ++++++++++++++++++++++++-------------
 sha1-file.c                | 13 ++++---------
 submodule.c                | 22 ++++++++++++----------
 submodule.h                |  4 ++--
 t/helper/test-path-utils.c |  6 +++++-
 worktree.c                 | 13 ++++++++++---
 16 files changed, 114 insertions(+), 75 deletions(-)


base-commit: 076cbdcd739aeb33c1be87b73aebae5e43d7bcc5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-575%2FSyntevoAlex%2F%230205(git)_crash_real_path-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-575/SyntevoAlex/#0205(git)_crash_real_path-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/575
-- 
gitgitgadget
