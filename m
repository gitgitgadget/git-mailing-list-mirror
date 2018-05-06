Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09BE200B9
	for <e@80x24.org>; Sun,  6 May 2018 14:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeEFOK4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 10:10:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41860 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeEFOKz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 10:10:55 -0400
Received: by mail-wr0-f194.google.com with SMTP id g21-v6so25355906wrb.8
        for <git@vger.kernel.org>; Sun, 06 May 2018 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ccz6QIDBKM73QzlC1rpEu22bV04JShaLVcF/q8EiQ0g=;
        b=rdp8nrGM88KjzMxacLWkXRGuwcLUew2OHQ6T6b/mb6jbWdwtyRhYjdHwjorCx1ewr0
         7fnE4dYKb+ZpPaa5/16w6Tz03AiWAXioREGvn+nGdJUD+Fp2vkAphhrvW+TKzJajxpIg
         9y4xbO2YIPqeDYRgylONz6znkxzszrcaAeA74RldYTB/0hDqgX+o1PwkdFyDsaS/TuGg
         IkWGJJOdACIlsCPEKlr8Kh1l62iWUJdYkOmhAjjMRf8Dl1JaAWfgejnedgNO9nScp68U
         l318fAEZAhUwzhlDmf51XCVtRasIjCvK3T7u1gWXReXE5RmvXqWeh3fxsRkMLD7hdxro
         GzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ccz6QIDBKM73QzlC1rpEu22bV04JShaLVcF/q8EiQ0g=;
        b=M9pBYtXdvSZwB53yvkJEARx3fsMTTi3WoDw4SjbGhcEsQnxHcWlqIAE6z/CorC5YEt
         7bcQ4ckxY/cppBkX1Wm8E5OMV/FGkc3Gl5Pb96Hnz13B6JuL/G08jAvwMvpdryAqtYtj
         M8dg5D8sFN4c3etFrijBUXXmUElqLhrVH3rSq++edY5qj4tMQsVHv2ynE0QT783VcnBK
         JPqSxP6+mi1l5L1Okhi+o/eTw1CG950NBzW/zhADHnNHcJ75t/9rPyP9Kz+bZluKsLtH
         rQBgl3NnkyqF8QJ5lmucCi7zwqICyBTgJo//pRbsLSTcG2sUYaaxSvqA/gs2UZGaHJYo
         AOZg==
X-Gm-Message-State: ALQs6tBq9NWzeuolzc982f5sb28v3G/jUiuRcCk6GDCRlxclDqM8Cnyh
        p8GLdgd/8FZDat8PUguxaQtvXmnh
X-Google-Smtp-Source: AB8JxZoJ1N1bSdsm/f59yUlJJ5JQWP8jEyZZ6b5nttKsvAYD/U6PCi4r2lFajFchdXZjgDjsNhEM1A==
X-Received: by 2002:adf:83c6:: with SMTP id 64-v6mr28257788wre.270.1525615854288;
        Sun, 06 May 2018 07:10:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p17sm4914857wmc.17.2018.05.06.07.10.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 May 2018 07:10:53 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] getting rid of most "static struct lock_file"s
Date:   Sun,  6 May 2018 16:10:26 +0200
Message-Id: <20180506141031.30204-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series addresses two classes of "static struct lock_file", removing
the staticness: Those locks that already live inside a function, and
those that can simply be moved into the function they are used from.

The first three patches are some cleanups I noticed along the way, where
we first take a lock using LOCK_DIE_ON_ERROR, then check whether we got
it.

After this series, we have a small number of "static struct lock_file"
left, namely those locks that are used from within more than one
function. Thus, after this series, when one stumbles upon a static
lock_file, it should be a clear warning that the lock is being
used by more than one function.

Martin

Martin Ågren (5):
  t/helper/test-write-cache: clean up lock-handling
  refs.c: do not die if locking fails in `write_pseudoref()`
  refs.c: drop dead code checking lock status in `delete_pseudoref()`
  lock_file: make function-local locks non-static
  lock_file: move static locks into functions

 t/helper/test-scrap-cache-tree.c |  4 ++--
 t/helper/test-write-cache.c      | 14 +++++---------
 apply.c                          |  2 +-
 builtin/add.c                    |  3 +--
 builtin/describe.c               |  2 +-
 builtin/difftool.c               |  2 +-
 builtin/gc.c                     |  2 +-
 builtin/merge.c                  |  4 ++--
 builtin/mv.c                     |  2 +-
 builtin/read-tree.c              |  3 +--
 builtin/receive-pack.c           |  2 +-
 builtin/rm.c                     |  3 +--
 bundle.c                         |  2 +-
 fast-import.c                    |  2 +-
 refs.c                           | 12 ++++--------
 refs/files-backend.c             |  2 +-
 rerere.c                         |  3 +--
 shallow.c                        |  2 +-
 18 files changed, 27 insertions(+), 39 deletions(-)

-- 
2.17.0.411.g9fd64c8e46

