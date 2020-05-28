Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2273C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 02:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B652720888
	for <git@archiver.kernel.org>; Thu, 28 May 2020 02:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsLJzRk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgE1C4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 22:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1C4r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 22:56:47 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE3DC05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 19:56:46 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id y5so9110695qtd.0
        for <git@vger.kernel.org>; Wed, 27 May 2020 19:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=7v/K9bhbrfMsbtn/iC/PPLSLYzVXE4vbdOxn1jN7nUg=;
        b=VsLJzRk65+zmvMG2mqz9iV52YMSxzEbudzmMsafOPf0hCFrXJa4YzGjk8yZwcQT5oD
         UCk2RXfyEnEPZOcfw8bjxethihEWdODFPuph0kyvonITkjsxxQEhZog2ON3FEUKNMg6L
         MCcUVx6o8OFZf4+ybFkP+Nen+TJ/DcKT8dRDZ8eEZYok5II0/WdpmDEQ5aAZhdIzWS1C
         27GDqJGld1v2/p+/Eq6iTL17wtM025BYrtzpLsQRKeGA28bzA+8MCfhgRQmC1G4AI6SD
         d2HLgfjfIqdrMECgCm5K1tydYj9+nwbtLGVG+D04EilVF0ZD5t4xiIUFB1DrwpJF4rDM
         Y2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=7v/K9bhbrfMsbtn/iC/PPLSLYzVXE4vbdOxn1jN7nUg=;
        b=bEMgtDDF5oWYtrq5+yPW4lTYpiNZ2hrJWIRlnyo4lDIktpcEsHSWnBjZeA/oVwgHqX
         sptmOJnB5O8GtZygO7ZSAZeZl8a63/YAE+CJT5/zV8VSjN2kYvXrs1zWbqTg+rDEBTE5
         FXpQPaa3Rrp1HFASUH5i/qere9Y3+whiSO2ye7nLO6OZR2ZEk/Jo81aufs4GQcC+E0km
         C0eu7JzTOVljY2IFU6QDmeJZPJf+OuYGAAIWbAFnCfZmPoswyYIsJFYqSN2oF8x0um8j
         KpuMOljSjJzX733H6RvKxkhdUISXcctiUHE+/IccXUfSV+Jnoh33azPJQJHDBsYwC8E3
         7vHA==
X-Gm-Message-State: AOAM5304k/2eUZmclU46V0tNgva9cb+4XfD8zXNV/kCMi7atuqWbRa1s
        YrNuKjWkjj9FfzsJ0KDkacIA9UQY8xuKTiiusIhKdwb4oJg6dSwuQMx6rCiukSVh7AiLscv9qjA
        otu3MAO4LqmRxxs48fWAzAcLmcquWxqPSxqixF/Nc37qVxvA4n+12avxXRdxa
X-Google-Smtp-Source: ABdhPJw0ldbahD7u5aws0Gdb3ZFFR2vaoLo5lX9M/DXjjK3vg1dNuStg7T1xJNpZEWqBDELchJPZO/TBCy9y
X-Received: by 2002:a0c:e254:: with SMTP id x20mr979450qvl.153.1590634605068;
 Wed, 27 May 2020 19:56:45 -0700 (PDT)
Date:   Wed, 27 May 2020 19:53:59 -0700
In-Reply-To: <20200513234435.GG6605@camp.crustytoothpaste.net>
Message-Id: <20200528025359.20931-1-delphij@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 0/1] fetch: allow adding a filter after initial clone
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>, jrn@google.com, iankaz@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, to retroactively add filter to an existing (shallow) clone
one would have to manually change the repository configuration to make
git to believe that there was an existing promisor, like:

  git config core.repositoryFormatVersion 1
  git config extensions.partialClone origin
  git fetch --unshallow --filter=blob:none origin

Because the code can already set up promisor, it would be safer and more
convenient to just do that in git itself.

This version of change will also prevent the code from making damaging
repository upgrades (when non-standard extensions exists) as pointed out
by earlier reviewers.

Xin Li (1):
  fetch: allow adding a filter after initial clone.

 builtin/fetch.c               |  3 ---
 list-objects-filter-options.c |  3 ++-
 repository.h                  |  6 ++++++
 setup.c                       | 30 ++++++++++++++++++++++++++++++
 t/t0410-partial-clone.sh      | 21 +++++++++++++++++++++
 5 files changed, 59 insertions(+), 4 deletions(-)

-- 
2.27.0.rc0.183.gde8f92d652-goog

