Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF9BE1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 15:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbdBMPUW (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 10:20:22 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36282 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbdBMPUU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 10:20:20 -0500
Received: by mail-ot0-f193.google.com with SMTP id 36so11905370otx.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 07:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nf42zkyg28mAdKM5Y68zKZA3lZhtbIK2C3j9gMbL108=;
        b=JKLa5a7Fxd2KrPb+ABn3Gc3zRJX5K2EVFkRtvn3ykv+leu8IXzocVKJOt40CmB+k5m
         5XYL8JnJbeFnQ75PuCxZoURUtdFV7z+Ee5iPzH33phN8iR9YasBY5hQLU0WfDFPokKfV
         CkRYUmPXIvr5UTi+N1xatkEFsMxwj85/AO2kFaliUeiw54tGBTIw46K4wP/zHMI+Uyiz
         H0Q1thzyo2ggke/WYc9zXk+FGNuLLtaQwoeblaPBkRS0sjGtiGbcuxCU6paeuF5OMwqm
         syo7ZGGTkhDABrYmjn26z1TSJUoYiTZUiJl4gipwhi1yL6i6e/RzcXR6Z15fkFuBuRzi
         AdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nf42zkyg28mAdKM5Y68zKZA3lZhtbIK2C3j9gMbL108=;
        b=dsIBFHJzgLwU2Aby9ibrsI5nTuFwrEdIeVZPoFJf+1+m7fQOIIHPnw3xQrAjTFF8BM
         OALkwuQvVLjT1NaRskUHWVZ5TM0GvQeuvXnu2og+xFTYo6ouTElIc7rj6MEESZz4jWiV
         F9VaIyvQrxGGujXUkgar7/ZNVQWkPJCnNG0oE18tsMR5HBFIjMnpJHmAfgReUPuabvIc
         sFjdHOSpwB5E9uFIb1fwV4PZJ3PKV+GZzso8aTk3GCT5c1WvFzWUSHn0EQZAK8JBV6EG
         vH2I2a5m/O1MhbmlN6BSAAxIfeB0RkXweUbe3jOTlMJFdQeLR5XITTOlF/T0dhYqvTrg
         ukHQ==
X-Gm-Message-State: AMke39mErQXraBTCHgC8pQSgSYWS2G1MT8x4laYRtBasRI7FHrxNAXVQ8EUOZm4pagN6eg==
X-Received: by 10.98.41.5 with SMTP id p5mr26907875pfp.183.1486999219343;
        Mon, 13 Feb 2017 07:20:19 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id m20sm21827303pgd.17.2017.02.13.07.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 07:20:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Feb 2017 22:20:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 00/11] Remove submodule from files-backend.c
Date:   Mon, 13 Feb 2017 22:20:00 +0700
Message-Id: <20170213152011.12050-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on top of mh/submodule-hash, it:

 - centralizes path manipulation around submodule, $GIT_DIR... in
   files-backend.c to a new function files_path() with the intention
   to make it easier to change later. files_path() is destined to
   become

      strbuf_addbuf(&sb, refs->gitdir);
      strbuf_complete(&sb, '/');
      strbuf_vaddf(&sb, fmt, vap);

   but that can only be achieved once we get compound ref store.

 - removes git_path() and submodule_git_path() from files-backend.c. No
   more magic path translation as far as ref backend is concerned.

 - moves submodule path resolution code outside the backend.
   files-backend is now oblivious of submodules and in theory a
   submodule ref-store supports all operations (but I could be wrong,
   I didn't stare hard)

 - exposes get_submodule_ref_store() and get_main_ref_store() as public
   API. A new set of API around ref-store will be added. And
   get_worktree_ref_store() of course. The *_submodule() API might be
   removed, we'll see.

The problem with set_worktree_head_symref() (which peeks into another
gitdir) should be solved once we have get_worktree_ref_store(). That's
my next step.

Compound ref store will have to wait until I'm done with my
gc-in-worktree problem as I think I can live without it for now. I
think after compound ref store is in place, adding lmdb backend back
should be much cleaner because it does not care about either
submodules or worktrees.

Nguyễn Thái Ngọc Duy (11):
  refs-internal.c: make files_log_ref_write() static
  files-backend: convert git_path() to strbuf_git_path()
  files-backend: add files_path()
  files-backend: replace *git_path*() with files_path()
  refs.c: share is_per_worktree_ref() to files-backend.c
  refs-internal.h: correct is_per_worktree_ref()
  files-backend: remove the use of git_path()
  refs.c: factor submodule code out of get_ref_store()
  refs: move submodule code out of files-backend.c
  files-backend: remove submodule_allowed from files_downcast()
  refs: split and make get_*_ref_store() public API

 refs.c               | 125 ++++++++++++------
 refs.h               |  13 ++
 refs/files-backend.c | 350 ++++++++++++++++++++++++++++++---------------------
 refs/refs-internal.h |  28 ++---
 4 files changed, 316 insertions(+), 200 deletions(-)

-- 
2.11.0.157.gd943d85

