Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83748C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C38F206DA
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVzD2avt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHKWw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKWw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 18:52:29 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A43C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:29 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id v25so333855pfm.15
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MEuc7uiqOSf7EKUT1zQlP53+nKV8o7z8YcNKS/3iQyc=;
        b=vVzD2avtGrx04WIzg5WgWiF3QdtGHwr0qiVV+YeaCDGTe5k6kPjK+ZC4hEGK1hiz0E
         IgA0BiU3HnMOLek7OM/ExXk9+fb68/a/lKAozp7yOp04dOOB5VczqE4QtHbhFVRRSiX6
         E5ntqqrAdjlIw5qwpdnAyMEciniyrhHGtEIYBDCtCMJuAFi9eCMAgRM6NW6jQGCoM0RT
         BN8JrNh3R8x3wi/YqAqtiTVtLCUYhCDMT+wktSo2eYvaEbmFiWVBVhtxsc0GNkGoG/GQ
         1OmZBr17uJpCyaohNjF1Ds1Eu9CAnLxHovaHlE9rMoAodKIPFjNiSdil4/Q4/JguNwXt
         eXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MEuc7uiqOSf7EKUT1zQlP53+nKV8o7z8YcNKS/3iQyc=;
        b=OEms9VVZ3zeHMFE14m3JYWcIcoZfbjt/uMeRBlZXKieAK71hbxeZw+KC7Tq7GbHPF0
         yFjNJTE368UOCDBF3lcJZkppIHmdj0jxrRrsXDZzct/CaUdhQd46jmYanrb8l/osyB06
         4Nqs7gJQ8Nf2CyjRTWD45ixrlabg1WZnRPI2m/kZsr1VFItje39U2pmlLBiPFcjpnG3l
         2hOEnRMkUCRLAva8yse5P4ChSKQTxaG+PzoJvvS++q2NOYDOoNI2XHhE9nSeiZxW3x9G
         Iny+1nBSUwOSAoMpiAl3uXVDqOP6EovjBI1dHS4b5keCbORFUOfGhuu6nIz7NEigtalH
         WypQ==
X-Gm-Message-State: AOAM530pccYQpDe35SYzY7VsIoEBP7UF32627iNcVok9aztTqMUzzUz/
        xSsSnXvB3jpJzELhuoiS/F+3EHswnIzyta1YSFlK1tnWBPxYnNoSYJN4hr1zSz9LZto5QMu/jQ0
        4Gc5OaJLD4bz/TG8CCB4w6tUdGD4U7vKmuLPw2ydqpfNlEOMCUPm9mHCJsYt57EuY2T5ZdNEW3A
        sy
X-Google-Smtp-Source: ABdhPJwpwUwKQoKzPpmC41j2cfObDll8/cvqVv0Au7q08UOguS7Hi3UgKc8plVQxjthq61Gqz1K3kjMcGQ5DGKp+xnWP
X-Received: by 2002:a17:90a:6807:: with SMTP id p7mr3331179pjj.42.1597186348228;
 Tue, 11 Aug 2020 15:52:28 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:52:15 -0700
In-Reply-To: <20200724223844.2723397-1-jonathantanmy@google.com>
Message-Id: <cover.1597184948.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 0/7] Lazy fetch with subprocess
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are based on jc/no-update-fetch-head.

After the email exchange with Junio, I went back and took a look to see
if I could accomplish what I needed without using NULL methods in the
fetch negotiators. And I could do it - I just had to be more careful
when iterating over refs and dereferencing them. You can see it in patch
5.

In version 1, I wrote that these needed to be done:

 - Commit messages
 - User-facing documentation
 - A way to prevent a promisor-remote fetch from invoking another
   promisor-remote fetch (use a file as a lock?)
 - Remove no_dependents code (fetch-pack, transport)

1, 2, and 4 are already done. As for 3, we currently don't have this
safeguard before this patch set, so I did not include one in this patch
set either.

Jonathan Tan (7):
  negotiator/null: add null fetch negotiator
  fetch: allow refspecs specified through stdin
  fetch: avoid reading submodule config until needed
  fetch: only populate existing_refs if needed
  fetch-pack: do not lazy-fetch during ref iteration
  promisor-remote: lazy-fetch objects in subprocess
  fetch-pack: remove no_dependents code

 Documentation/config/fetch.txt            |   5 +-
 Documentation/git-fetch.txt               |   4 +
 Documentation/technical/partial-clone.txt |  13 +-
 Makefile                                  |   1 +
 builtin/fetch-pack.c                      |   4 -
 builtin/fetch.c                           |  42 ++++-
 fetch-negotiator.c                        |   5 +
 fetch-pack.c                              | 189 +++++++++-------------
 fetch-pack.h                              |  14 --
 negotiator/null.c                         |  44 +++++
 negotiator/null.h                         |   8 +
 promisor-remote.c                         |  46 +++---
 remote-curl.c                             |   6 -
 repo-settings.c                           |   2 +
 repository.h                              |   1 +
 submodule-config.c                        |   5 +-
 t/t0410-partial-clone.sh                  |   2 +-
 t/t4067-diff-partial-clone.sh             |   8 +-
 t/t5554-null-fetch-negotiator.sh          |  22 +++
 t/t5601-clone.sh                          |   2 +-
 t/t5616-partial-clone.sh                  |  20 +++
 transport.c                               |   4 -
 transport.h                               |   7 -
 23 files changed, 252 insertions(+), 202 deletions(-)
 create mode 100644 negotiator/null.c
 create mode 100644 negotiator/null.h
 create mode 100755 t/t5554-null-fetch-negotiator.sh

-- 
2.28.0.236.gb10cc79966-goog

