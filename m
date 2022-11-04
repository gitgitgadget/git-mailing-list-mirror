Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954D5C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiKDPTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiKDPTF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 11:19:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00A228C
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 08:19:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z14so7509295wrn.7
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 08:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xDhG2+3x7srKazQRM9W9ZqI6OfRG/56EEnow1UVd8/4=;
        b=JUqh0gGmNSLSCe+e7pWK8DRZ1GepWuvWDTf7+9YSlHQZO6b0xjldtr1iHtWLqk4IQB
         avyKnjlqZOEXweS/SYfMIFeBGwX61gokBgmQg9VEtXoa2TmYkgN1u5MUUhQivRl2ant3
         3uyi054tRHxKy3EZ8GweOn9G/fVTa3EhyLSGNHwtgKMmvxRUCVhB++PneZWtSI0mQXTp
         5pJsEVq75Q3xU9PPvjKG0WIY2JnkQihsp0ali/pg5RsRfAjZCXU2oGIa3X0A61xkq61h
         9frFmjSjQBqYBwuoUnuWdbajmmYHkDzz4Y+/glXLPlKdBU6toR6LsWcY9n+7UIh+ZzXP
         wJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDhG2+3x7srKazQRM9W9ZqI6OfRG/56EEnow1UVd8/4=;
        b=ar04x9IjB+fP0kAEXUsib/wGmvlZ/6/ygROJQKPuKIQUvkeKKaaPfhXfbXarMwavTT
         HReKYTJ6R7yZShGmmM1Swe2SejSYLCQsuzzBQ0wqzTTRwk3APCfRSYWbEo76v2JN6BO+
         0jwu9hjwCe8kx7Q8oTxJPmau/y8OVJapYrf2LJ6gf7n6GYzhHD8tHWXF9EhJeqEc7i6p
         fFNRRNBPK0ZwLOj8PEtOEmE5EKq0DLitmOo7YaryfRbxsYryRPqwUpoxLQLznWjEEJdf
         Zp1QQJICULMgnURC2FjjT9LBk8wvNZdAcL2iYmx3FxbVfm8+lpGtDbEclH6Z9Z5s/Y+W
         6ziA==
X-Gm-Message-State: ACrzQf1T6tJcKFV58y6kgevHhm8JyaLDkxDohHyb8pPNjQiFzbSv1bcM
        kafwNaxE/u3Z9goVcHUdTG8yA5MLnn8=
X-Google-Smtp-Source: AMsMyM7Y5bv/OrEqBjxl2UIN5h1CIdjI+RJNFB6mSSSX27o7Yh2ane34LiUMWUG1gGWjTeeLD3HT2g==
X-Received: by 2002:a5d:4708:0:b0:23a:43b7:cdcc with SMTP id y8-20020a5d4708000000b0023a43b7cdccmr2801820wrq.545.1667575143138;
        Fri, 04 Nov 2022 08:19:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003c6d21a19a0sm3725285wms.29.2022.11.04.08.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:19:02 -0700 (PDT)
Message-Id: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Nov 2022 15:19:00 +0000
Subject: [PATCH 0/2] rebase: stop setting GIT_REFLOG_ACTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow up to pw/rebase-reflog-fixes that moves away from using
GIT_REFLOG_ACTION internally. This conflicts with patches 12 & 14 in [1]. As
this series replaces the code being changed in those patches I think the
best solution would be to just drop them.

[1]
https://lore.kernel.org/git/cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com/

Phillip Wood (2):
  sequencer: stop exporting GIT_REFLOG_ACTION
  rebase: stop exporting GIT_REFLOG_ACTION

 builtin/rebase.c | 27 +++++++++++++++------------
 sequencer.c      | 45 +++++++++++++++++++++++++--------------------
 sequencer.h      |  6 ++++++
 3 files changed, 46 insertions(+), 32 deletions(-)


base-commit: 3b08839926fcc7cc48cf4c759737c1a71af430c1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1405%2Fphillipwood%2Fmore-rebase-reflog-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1405/phillipwood/more-rebase-reflog-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1405
-- 
gitgitgadget
