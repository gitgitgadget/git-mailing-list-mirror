Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A2AC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbiD3ERn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiD3ERm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A8B2E6AC
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g20so11051416edw.6
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMOcLslCbqtDn79iTLPudktFscjDRwIIE9z62+WsJT4=;
        b=bP5tgxpRqa1fnJJNy4YGKFrJEPiznYUoi2ONyf2YOn/c4W1ir281XeIaT7bpbazB4l
         twAAH3fQuLJ0w0+0UwNCqph65PabABTQ5HIHoYRJJLWbnG31X3AONyc1FHG6UZl5pER9
         +VolsoY4ZBWzuFoEpOFGgP6v42cudFjsw6p/4e0MmvysteYj602Dug3x+Yn4MVUNn9MW
         cQupZNYVDqdl/3bHgK+va1OYRxJDTKov9hoDv+gaj/kJpw0LwtyGjB4VTAUwi6CHHbbr
         0eCCWUhaMJM53Q5oXXXAUDGSs4xT+ULA8xsva7eyt911z7RR8DhkMf0bWGQIIysf+bOO
         Qseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMOcLslCbqtDn79iTLPudktFscjDRwIIE9z62+WsJT4=;
        b=B8uVCJFaTc6us2AJR8g0Uxkz9cu9moetoYeqazDSbs43kLNaS+SBO7mYsbl8nxtv6z
         DMDCzCXdJlBJBtOLxsNNDXAS9iF6EjiJSOk5sfzOb52xngvV6lXSvT8turDBOLXN79Pz
         wjfGf9o3Y2ecQLM+D2/VE+lMRxlaZNLcxBZtBNZyIw3YfaHyI0LvQsi3bkEhDJeHEEo/
         EdSIDTb4101fU4kzir8YJjwQq2JcpMljsEw8C3mwRNeB7/W7jrMKtZEf4iSy4TCUfDFP
         3aM8qErWXQgaRfaRfOhLd3ROmtW42um4A1UoVjUbPSDy78GbZePxb+7I/9l9BUmxveMt
         a6rA==
X-Gm-Message-State: AOAM5300wVI3fToscjoFBD/ZyAC4hX3L9g6fMngsPXW8FNJMjRe65W5Y
        VYYbyBygK6S48Ewx6hyoFGr210R6ElI=
X-Google-Smtp-Source: ABdhPJwE5ciODw1zPa4q4+lZ6xjYUaLB8L4ty0vYsbfDU2nMMyZYCRnWGjLOBOvMH4qEJvPAkc+R0Q==
X-Received: by 2002:a50:d78e:0:b0:416:2cd7:7ac5 with SMTP id w14-20020a50d78e000000b004162cd77ac5mr2651306edi.320.1651292059788;
        Fri, 29 Apr 2022 21:14:19 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:18 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/23] add a new coccinelle semantic patch to enforce a
Date:   Sat, 30 Apr 2022 04:13:43 +0000
Message-Id: <20220430041406.164719-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds a new coccinelle semantic patch to enforce the git coding
style that requires "Do not explicitly compute an integral value with constant 0
or '\ 0', or a pointer value with constant NULL."

It also fixes a set of sources using the new semantic patch.

Elia Pinto (23):
  contrib/coccinnelle: add equals-null.cocci
  apply.c: Fix coding style
  archive.c: Fix coding style
  blame.c: Fix coding style
  branch.c: Fix coding style
  builtin/bisect--helper.c: Fix coding style
  builtin/checkout.c: Fix coding style
  builtin/clone.c: Fix coding style
  builtin/commit.c: Fix coding style
  builtin/diff.c: Fix coding style
  builtin/gc.c: Fix coding style
  builtin/index-pack.c: Fix coding style
  builtin/log.c: Fix coding style
  builtin/ls-remote.c: Fix coding style
  builtin/mailsplit.c: Fix coding style
  builtin/pack-redundant.c: Fix coding style
  builtin/receive-pack.c: Fix coding style
  builtin/replace.c: Fix coding style
  builtin/rev-parse.c: Fix coding style
  builtin/shortlog.c: Fix coding style
  builtin/tag.c: Fix coding style
  combine-diff.c: Fix coding style
  commit-graph.c: Fix coding style

 apply.c                              |  6 +++---
 archive.c                            |  2 +-
 blame.c                              |  6 +++---
 branch.c                             |  4 ++--
 builtin/bisect--helper.c             |  2 +-
 builtin/checkout.c                   |  2 +-
 builtin/clone.c                      |  4 ++--
 builtin/commit.c                     |  2 +-
 builtin/diff.c                       |  2 +-
 builtin/gc.c                         |  6 +++---
 builtin/index-pack.c                 |  6 +++---
 builtin/log.c                        |  2 +-
 builtin/ls-remote.c                  |  2 +-
 builtin/mailsplit.c                  |  2 +-
 builtin/pack-redundant.c             | 10 +++++-----
 builtin/receive-pack.c               |  4 ++--
 builtin/replace.c                    |  2 +-
 builtin/rev-parse.c                  |  2 +-
 builtin/shortlog.c                   |  2 +-
 builtin/tag.c                        |  4 ++--
 combine-diff.c                       |  4 ++--
 commit-graph.c                       |  4 ++--
 contrib/coccinelle/equals-null.cocci | 30 ++++++++++++++++++++++++++++
 23 files changed, 70 insertions(+), 40 deletions(-)
 create mode 100644 contrib/coccinelle/equals-null.cocci

-- 
2.35.1

