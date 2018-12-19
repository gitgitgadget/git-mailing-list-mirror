Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F921F405
	for <e@80x24.org>; Wed, 19 Dec 2018 20:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeLSUOI (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 15:14:08 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:40572 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbeLSUOI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 15:14:08 -0500
Received: by mail-pf1-f176.google.com with SMTP id i12so10329843pfo.7
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 12:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=R4NBySA1xRscPMbYZzQq6GYEC9YRSZG+qs7wS3lq01Y=;
        b=bLp90LfFSqZ9Pk7HvddIfjSIDjzpq5RkCJL4+Nf753WesvgghVHu8EbIHzBSJ+9Sj6
         Unjl5sHXFTNXKZPKVrEFdPrDS0BrsdU8p/r9+G3/p1ZsAfWniCDSTi1TSeE4v0j1xSmo
         YLwUVEQHiTpvTSwg+izNV1tR0x4QsR6wR9YCJKZJ/8qs2ynfZyFBXN8mb8/8ni9fLdca
         g/rbKNOXlVMqeizHF63f5+9hF7xZGWgfnoGVG8Hcx11nn3JAoI89PwT8NLm+273Ho2TY
         tODARRiwLTtc017BAjatxm1eFzwaTpoT2FUJ4obLUj8Z69OF/wBfG6xisAje+MGwiGNb
         UxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R4NBySA1xRscPMbYZzQq6GYEC9YRSZG+qs7wS3lq01Y=;
        b=cS+TgbWaLJiqaa4VMjIi/XiQTBgZ5U0FvI3S6lTpD+bAdZ6mVgBV+L0HXunWgXja+u
         pe+dLaXxPh/TVXH0xPSAi+BgU4fwwc5WglH+QkcszV2Tg27VWfxmIkZCk51MVce60rnu
         s7Ad/U10lwiCONW29yBDdgTMNCUBLW71mTg6xxuhUGA8TDooCNfanGBy0dLGjd/O0GVh
         DWybkH5RqvL7CEv4NT22UbjEQc2Wf3az6spNut+yFAUxtlGGkGy4X3MZ7io7A890pqNE
         UlY7Ex9pJwplx4VSY6Oy3u5mxN2HDgKv7HCdHx46odKkvsx1ibOlKX6w61uFzkXA/XjE
         Ep3Q==
X-Gm-Message-State: AA+aEWYIKZ8cmGdiOGIhq84piLsYA1p8hDW4NVlvwdQIR6FA9samxytn
        z3IG+rrzNCgYkrQ1V492jhALaqld
X-Google-Smtp-Source: AFSGD/Xn4r1EV+ed8nLl17wGvlC/C+RLb3LzX26NvZU80PUC2anrG+sGFGsE+o4TFejkVA68CNfFKg==
X-Received: by 2002:a63:902:: with SMTP id 2mr7218795pgj.219.1545250446770;
        Wed, 19 Dec 2018 12:14:06 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id s4sm22078235pgp.13.2018.12.19.12.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 12:14:05 -0800 (PST)
Date:   Wed, 19 Dec 2018 12:14:05 -0800 (PST)
X-Google-Original-Date: Wed, 19 Dec 2018 20:14:01 GMT
Message-Id: <pull.102.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] commit-graph: writing missing parents is a BUG
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A user complained that they had the following message in a git command:

fatal: invalid parent position 2147483647

In hex, this value is 0x7fffffff, corresponding to the GRAPH_MISSING_PARENT
constant. This constant was intended as a way to have the commit-graph store
commits with parents that are not also in the commit-graph. During
development, however, we chose to require the commit-graph to be closed
under reachability. Thus, this value should never be written, and we don't
fall back to parsing usual commits when we see the constant.

This actually happened, and the root cause is unknown. This either means the
reachable closure logic is broken somewhere, or something caused the binary
search to find the parent in our list of commits. This second problem is
more likely, as we have seen RAM issues cause corrupted memory before. I'm
still investigating the root cause, but for now we can hit a BUG() statement
instead of writing bad data.

Thanks, -Stolee

Derrick Stolee (1):
  commit-graph: writing missing parents is a BUG

 commit-graph.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)


base-commit: 0d0ac3826a3bbb9247e39e12623bbcfdd722f24c
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-102%2Fderrickstolee%2Fcommit-graph-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-102/derrickstolee/commit-graph-bug-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/102
-- 
gitgitgadget
