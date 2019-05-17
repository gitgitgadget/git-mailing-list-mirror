Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 095EB1F461
	for <e@80x24.org>; Fri, 17 May 2019 18:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfEQSlt (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 14:41:49 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:40479 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfEQSlt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 14:41:49 -0400
Received: by mail-ed1-f47.google.com with SMTP id j12so11901102eds.7
        for <git@vger.kernel.org>; Fri, 17 May 2019 11:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=sv7Wg0o5UCvkcUi2Z7AE+O3ALQQqAf9U/E96Otw+6Ew=;
        b=CImGmDx6AqEnY3E7ZyGjzp1SDTOsefcZUc9jNY5MNay6SnVG9QR/gCUvvHDdpX2T8I
         D26KY7Lsev08MXKKyO+SBj8DjyXd2w5vTUygCy9cZTaQtu3gqDjycy7eeAryAYy0OHqT
         M66RbYcESSPN+ubn0zH0uQ5z5i0GTs4RoBqMvjXYRe8JMmJR3/qtG1ISzqqFw6fBpqNK
         2ufMdRYyZQKSlKxQ+E3595FwUHdbu8am2K5+/GQbFskOep7s8N+SlsxenJaMX3FHn60a
         TqD8GHWyFPchLlSDdPYq79g+KMDKgrWGm16YLmh88mJtiytbUmNLM1WMdCSCsAnWqTvv
         0BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sv7Wg0o5UCvkcUi2Z7AE+O3ALQQqAf9U/E96Otw+6Ew=;
        b=ivFjiCT6t3Erna5Sh5OffCHOBrJM9/Ang/Q3DhdygPFwLczhqhBxmCvWLI4qBPaVLt
         a0PjlqQP9JgdAKdgR20BvXuVEBzvwPLB3DJWA4yEsH/BnNcmEEj0w5Tkqb/xiqnH7D78
         hKPGAUoTHa+04eepVrD3hZIcjXwPL+lfxHfxKUDOBCjgrkyFC5uBUoEDIoBsjIXb7wQt
         qeRrMYZcIhdQkLEdgWEgxsH8fs8B6Mn5+2CoFFzR27rNTE2z5xrYN0q1WVrDk2RgyojE
         ewWjA1LEGUc/Kg2gzZCbYgRL5YEGmU7hdslengnMEJib/DcYgzK4+E6LjepOfsj+nZ5O
         bWhg==
X-Gm-Message-State: APjAAAVim+E7ANjLyO3z9vwhXK+Y4NiuCSXq8WeXcqlXyyDl7dQszTCp
        GxGtdTsDOXz8PzJikNWFBY9G+zYv
X-Google-Smtp-Source: APXvYqxzUQfqrUtXM/dDaRNroPhdHEfjnrKR/4jUSGjlEFp9Su9NFYsbLf/YwH+4gqypdtwNeKS8qQ==
X-Received: by 2002:a50:ee11:: with SMTP id g17mr43546427eds.242.1558118507475;
        Fri, 17 May 2019 11:41:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hb11sm1687776ejb.43.2019.05.17.11.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:41:46 -0700 (PDT)
Date:   Fri, 17 May 2019 11:41:46 -0700 (PDT)
X-Google-Original-Date: Fri, 17 May 2019 18:41:43 GMT
Message-Id: <pull.208.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] Close commit-graph before calling 'gc'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Windows, the way we rename a lock file to replace the underlying file
does not work when a process holds a read handle. For this reason, we call 
close_all_packs() everywhere before starting a git gc --auto subprocess. We
also call close_commit_graph() before renaming the commit-graph lock file.
But we don't close the commit-graph handles before running gc, which can
cause an issue when gc.writeCommitGraph is enabled.

This series adds close_commit_graph() to close_all_packs() and then renames 
close_all_packs() to close_object_store(). This name is more descriptive of
its larger purpose.

This is based on ds/commit-graph-write-refactor to avoid conflicts.

Thanks, -Stolee

Derrick Stolee (3):
  commit-graph: use raw_object_store when closing
  packfile: close commit-graph in close_all_packs
  packfile: close_all_packs to close_object_store

 builtin/am.c           | 2 +-
 builtin/clone.c        | 2 +-
 builtin/fetch.c        | 2 +-
 builtin/gc.c           | 4 ++--
 builtin/merge.c        | 2 +-
 builtin/rebase.c       | 2 +-
 builtin/receive-pack.c | 2 +-
 builtin/repack.c       | 2 +-
 commit-graph.c         | 8 ++++----
 commit-graph.h         | 2 +-
 object.c               | 2 +-
 packfile.c             | 5 ++++-
 packfile.h             | 2 +-
 upload-pack.c          | 2 +-
 14 files changed, 21 insertions(+), 18 deletions(-)


base-commit: 8520d7fc7c6edd4d71582c69a873436029b6cb1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-208%2Fderrickstolee%2Fclose-graph-everywhere-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-208/derrickstolee/close-graph-everywhere-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/208
-- 
gitgitgadget
