Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF041F453
	for <e@80x24.org>; Mon, 29 Apr 2019 16:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfD2QS5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 12:18:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40499 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfD2QS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 12:18:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id e56so3368909ede.7
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lpYY8Kr7wO/AyY7ykn3WrQWgpnZ6J8ab4BVifMJZG8U=;
        b=KldTigRwaIl1iFTGuYVEJ+5Dym0jvEW/TAdt+/efpenVWmryWfM7+3s9C2nnUS0SUz
         gxCHycR1AONGF6TNxc430C3vI1bG9Xq7oucYEDqdyi+p1SFkqeGS/8F4bvfzcyK/IgN6
         Kup9Mb3cJaJ/syfhrzQSv4Mic5lvykcaUJNJvNc1IewyPp0pTZCEN6Gc31sPyKWB+4h0
         OspRu2S/rrTXk/QTa2R8NmcQ/wnjX3t2OWBuzDHTlNmtkxu1WkVDyTK6TUdzKJtNTNxv
         GuIu/TTnqhFkPNueSdASlOpUmLylV54MJaYWBTSZdin8CclI864SmtHDa/yaaBqS7a6k
         93Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lpYY8Kr7wO/AyY7ykn3WrQWgpnZ6J8ab4BVifMJZG8U=;
        b=Cd6TeLImuloExTr2W+eXegh+G9ix4VrePsJl4KkR8yxKGEO0YmTzSfZRVBZZjhBJ8r
         +XliTgYEnmFAdLn/N2rFMBPgETCglOW5NhNZ/oD9ofZ/ZdG7+IAxZpCxWkq8tEkiBIVW
         AnEXMJixG9iWuK6oAuPkDRulrxhiP6ifRH+2eLJosKnptqCbdoldOa1oSRbIfPLPMRaI
         wYyCOFRTNbOPoVFzwZAiMLREDdJweV+79Q0gTVGepDWEq1iXPiMTUuTKD3UKUs/mfOit
         1c4zLmrcsZr9xEGzezVmh0hF4TLhbPhDtdh3WeQkjE3ArEk9qujC1GhHQhbaxqdz08ts
         7a0w==
X-Gm-Message-State: APjAAAU06VsNFX55vSXXWCfYgLPdkFuL8+0SLEvwA0a7Ab5+Y+YHaF2m
        DsWyd3bAk0vAPTCu+qgnxO40sbQU
X-Google-Smtp-Source: APXvYqzY2v0D9Wi69H72c2pI1VgyG0r/cRQxhoxO1cGDCEbd4BZ8u3XzbfouPcBVS+xUL8L68ciFbw==
X-Received: by 2002:a50:85c3:: with SMTP id q3mr11781341edh.84.1556554735286;
        Mon, 29 Apr 2019 09:18:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm1422139ejp.76.2019.04.29.09.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 09:18:54 -0700 (PDT)
Date:   Mon, 29 Apr 2019 09:18:54 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 16:18:52 GMT
Message-Id: <pull.182.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Multi-pack-index: Fix "too many file descriptors" bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Jeff H for finding the problem with the multi-pack-index regarding
many packs. Specifically: if we open too many packs, the close_one_pack()
method cannot find the packs from the multi-pack-index to close.

Jeff already fixed the problem explicitly in 'git multi-pack-index verify'
which would hit this issue 100% of the time we had 2000+ packs. This issue
could still happen in 'git rev-list --all --objects' if there are enough
packs containing commits and trees. This series fixes the issue.

The basic solution is to add packs from the multi-pack-index into the
packed_git struct as they are opened. To avoid performance issues, add a 
multi_pack_index bit to the packed_git struct. Midx-aware algorithms can
then ignore those packs.

There was a very subtle issue that happens during a 'git repack': we clear
the multi-pack-index after possibly reading some packs from it, thus leaving
some packs in the packed_git struct but having a NULL multi_pack_index in
the object store. This informs the change to close_midx().

I'm based on a recent 'master' commit that contains the following three
branches due to nearby changes causing conflicts if I pick only Jeff's
change as a base:

jh/midx-verify-too-many-packs jk/server-info-rabbit-hole
bc/hash-transition-16

Thanks, -Stolee

Derrick Stolee (2):
  midx: pass a repository pointer
  midx: add packs to packed_git linked list

 builtin/multi-pack-index.c |  2 +-
 builtin/pack-objects.c     |  2 +-
 midx.c                     | 42 +++++++++++++++++++++++++-------------
 midx.h                     |  7 ++++---
 object-store.h             |  9 ++------
 packfile.c                 | 30 ++++++++-------------------
 sha1-name.c                |  6 ++++++
 7 files changed, 51 insertions(+), 47 deletions(-)


base-commit: 83232e38648b51abbcbdb56c94632b6906cc85a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-182%2Fderrickstolee%2Fmany-packs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-182/derrickstolee/many-packs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/182
-- 
gitgitgadget
