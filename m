Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317BAC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F146820C09
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWgxT/sK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbgFXAiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbgFXAix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 20:38:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4541C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 17:38:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r12so427408wrj.13
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 17:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=J/hXdOtEwrncC68ZkHI72aP59SCauwS6lXnAIR8U6nE=;
        b=rWgxT/sKQ0GxCqbNZ+1X0gMBhEkeEjNGrDm4urU839jooDG9fRssWjNVDFL7hezjc4
         caiMjNXHlQZSLpqLgAR4fTZEI1gBMcYpx7WdmDO1oauTcYxxtzryLGG67VIuOBq5N5wN
         OtqBzonWBhMzeSB2wIOpGmteHD/R6gffe0X6554L1Ia8PGRtN4/wZcq2r1C8EMzS74g9
         qD9sGC3bSsMxGKTh32BsDI2Ef2j3+40W1hsU5/VCvwwp+zBernG7Rw0bTiBxWuJMnQtQ
         dMcbtXwPdi0opyAOtexNcgqDq9qIWuGiqV4q18mPXLoGf502UtvGIbD/JPfADTZkJG+2
         D3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=J/hXdOtEwrncC68ZkHI72aP59SCauwS6lXnAIR8U6nE=;
        b=brAEO/Kyym29ezDZgJxr2WetnuElWHxiNIbVNTR95uaUjylcg4/9PXbXMAP1CggPI4
         PgIrYp/wgw5uByN8WQ81d4vbbKhfvzfomlvRLsNC0xkSRj1ooZ9lKupqES6hJCBsOCCn
         2m/Iy4BuuhcumIDC/uNHOS9Qx6J+FOLx8zPnd3Y1+W/LYrgPDHzqPQmwRcHnWI4vwmaK
         ZN3vjMqvTC5WVMjR6ykI1IZlUTUgYkiYgpd69WRt8QTb4892AbVCZ57nDIx4Ta4FVCRI
         JBfDY/NHjoxYhF77Dgb0dm12TmU0twURqLBtVdItchU2m5ZrVh/KtRRpUBJqU+ADDqhl
         xmtw==
X-Gm-Message-State: AOAM530G6y9y6Q38uVcWZumaj8N9eNAPEr6PiLxKO0iE7XqpLVgmYLA6
        Au80MJEUj4BW5uEPYJ3CVHwbsxlOUOp8QvOZe93caa25uoU=
X-Google-Smtp-Source: ABdhPJw3wkBhgQeId3UsGTv9C9BXjynHXHpaCqefkCvEjLZrgUbXRqhHqeR2Z2opq20l5CTDvAu+osWr4+TGSKcAdh4=
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr29556705wru.117.1592959131261;
 Tue, 23 Jun 2020 17:38:51 -0700 (PDT)
MIME-Version: 1.0
From:   shejan shuza <shejan0@gmail.com>
Date:   Tue, 23 Jun 2020 19:38:39 -0500
Message-ID: <CABO4vy0WTYbeAiyWf7hE_4QurwH_c1wJUdU=A4FSC0uSxiEO7g@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I have a repository with about 55GB of contents, with binary files
that are less than 100MB each (so no LFS mode) from a project which
has almost filled up an entire hard drive. I am trying to add all of
the contents to a git repo and push it to GitHub but every time I do

git add .

in the folder with my contents after initializing and setting my
remote, git starts caching all the files to .git/objects, making the
.git folder grow in size rapidly. All the files are binaries, so git
cannot stage changes between versions anyway, so there is no reason to
cache versions.

Is there any way, such as editing the git attributes or changing
something about how files are staged in the git repository, to only
just add indexes or references to files in the repository rather than
cache them into the .git folder, while also being able to push all the
data to GitHub?
