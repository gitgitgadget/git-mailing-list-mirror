Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B6DC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D878461181
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbhJOT5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242838AbhJOT5H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 15:57:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C75EC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 12:55:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r18so28307247wrg.6
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ZiWCv8TCttMSn0zhQQ7FoHGRlGhrC9wlNFPd1QUn1+I=;
        b=oBH8nm0e9vNxioA0oj5U9gsYa3JbVDLylHxgTKbWO2wL+nC3DoblAsrbkPAwCP8/CW
         tnnY5usFhuTYp4nfoy9BJG1AyktXRsvj1bczvxX0pn4Vq6KlVLVhXJp4PdC5cyrgn5cA
         PtG/E9vfHvsZNe8h9ni6vY/iHw18WuQhcxNQ9WX7QBreaByA40EWjfvg8xw490PfMZYe
         oKhm9DFYXbkHXPTx1goLtfaiacTup+vt5WMUszTbOFbOwlHazoEMicVxSSo+sSR2sGdQ
         ejFAaw94MUwyqd7zT+dAjswRIaIOHWvK9dmB74OUJXvBM9fHlXx3llHLdioibNErDjIz
         RHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZiWCv8TCttMSn0zhQQ7FoHGRlGhrC9wlNFPd1QUn1+I=;
        b=SAh9jja2syJS6SlRel2FtM72/IvGlAHG0sY9oJeKOKqWals7wMZ25Ut9e9vAs9BwQR
         uXTOsKOKsTkFSHugp0W7uGeShstvHZbNjzZQ9XI1lw9piMu5iYacQZFZEVCC9EO+5slt
         y6TdlTEF+RTRYcbKgGo9TiMvU/JHHALIKO2pUZkCMe3fTY3lflTQZ26/LY3YUZJgFqxn
         CgC2GOdQ5gZ8u4w0JOy0wtwkMmAWIhhcdzjpCDSGJXnHDNowSRGPS+iZT4UbLZXKrZ1Y
         Eih5n62+7PkKxVFvYfo0/NXVYF0hHT/iKDsWFEEfmJeuSwjwzUXHQAQLL4HVoyhoWcyy
         MvPg==
X-Gm-Message-State: AOAM5309DRmHzVqL29wd3YwV9GyJYTWfrmDiZCzQqMcvbimuhudMJWhe
        2sFgFUNse3mH4zfZl6xToRxYUBtQu+U=
X-Google-Smtp-Source: ABdhPJwyT4+u32XP4VEbDXSpWSdq8sQZdgFpWX451l5tj7ICVs6csnTVeqzkkCOycc5ch/PPawTR4A==
X-Received: by 2002:adf:bd8a:: with SMTP id l10mr16692369wrh.159.1634327699074;
        Fri, 15 Oct 2021 12:54:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm5685683wrn.79.2021.10.15.12.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 12:54:58 -0700 (PDT)
Message-Id: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Oct 2021 19:54:55 +0000
Subject: [PATCH 0/2] sparse-index: expand/collapse based on 'index.sparse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series updates do_read_index to use the index.sparse config setting
when determining whether the index should be expanded or collapsed. If the
command & repo allow use of a sparse index, index.sparse is enabled, and a
full index is read from disk, the index is collapsed before returning to the
caller. Conversely, if index.sparse is disabled but the index read from disk
is sparse, the index is expanded before returning. This allows index.sparse
to control use of the sparse index in addition to its existing control over
how the index is written to disk. It also introduces the ability to
enable/disable the sparse index on a command-by-command basis (e.g.,
allowing a user to troubleshoot a sparse-aware command with '-c
index.sparse=false' [1]).

While testing this change, a bug was found in 'test-tool read-cache' in
which config settings for the repository were not initialized before
preparing the repo settings. This caused index.sparse to always be 'false'
when using the test helper in a cone-mode sparse checkout, breaking tests in
t1091 and t1092. The issue is fixed by moving prepare_repo_settings after
config setup.

[1]
https://lore.kernel.org/git/cc60c6e7-ecef-ae22-8ec7-ab290ff2b830@gmail.com/

Thanks! -Victoria

Victoria Dye (2):
  test-read-cache.c: prepare_repo_settings after config init
  sparse-index: update index read to consider index.sparse config

 read-cache.c                             |  5 +++-
 t/helper/test-read-cache.c               |  5 ++--
 t/t1092-sparse-checkout-compatibility.sh | 31 ++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)


base-commit: f443b226ca681d87a3a31e245a70e6bc2769123c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1059%2Fvdye%2Fsparse%2Findex-sparse-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1059/vdye/sparse/index-sparse-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1059
-- 
gitgitgadget
