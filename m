Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79459C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392267AbiDUUU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiDUUUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:20:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5E937BF5
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:17:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c10so8208279wrb.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=D6ndHeWT7bX9DplJeikOTQGc7oMWiiuWS3XZeUy7Y5k=;
        b=dXhmyuFHAyEE73vvczh2UQ5rvjQuyeOb1aQcjalaNDjYIwMIWFp0sc6DerqydgdBFR
         ESRN6fZvA+vnjkjDs3mMyA4Mpafk6ZPxZCu9aweCDKCUPlDjncAHsMaNCYf+5/BMBAj/
         gB90oumOsYFxfBNYLxRAplLUbFFfuP2lIAzO02stWxJazXBLg/WVh3rphKUG6CdKFmhG
         cs8ywOk/o2AfkBJT6S0YUx2OJbrJLkISsmHbchCdVByRvh14qFSC99OISDQoEhbbewO0
         Fqlfw21kYagb4fRqDcbfTlvQ7m6rZJPptMJdLAZtbStnQJwqNRa0A3HfuC1adZejDHfN
         g0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D6ndHeWT7bX9DplJeikOTQGc7oMWiiuWS3XZeUy7Y5k=;
        b=6cx/Y9JiHwl6EbtuCco00/4IX6kP9oUw5fEAZ3zwIvUxkwtlcLEIZBsm3K4UnlEZ7e
         dS4uzSaWLiuychL97frCgHOpBPRAm58XO140HLrw8jVEVaHa4aJ/IXG4weARU7E4HSQL
         L5tSYLnjsZgRqKe3JUaiyyaQ8gNdTwkBss2ylT9BmJvcvMzO81EYf4Kfz4GjrTsxy16j
         fgHZDnLqH1OQmoWRLVz1R7SuMHHtrNPLQZFVJBxZNNeK1oZsNzEWrSEIXFfr5y1Qclk/
         B165Qw1bByp4VLGVRh962qVDub3nrNA33Hz5W7shmoZuYgUnkMS8O0XUIu+7ILpnsqwk
         OUJw==
X-Gm-Message-State: AOAM533xxXHWDNi+5UdD7FTMUtZJ7cK3jXxbEmI1hDkAff1EQyZdZYnP
        K7OW9n7xXuOjqHihzYGvce6LRfedZmU=
X-Google-Smtp-Source: ABdhPJz4y1IEH/GUl4a4JKE9bjR/6yGnqZnFkY8dOKfOPpy1RxGyO4Bo5MXP2Jx/IgJftEDXx7BNlQ==
X-Received: by 2002:adf:e9d1:0:b0:207:b80e:dc22 with SMTP id l17-20020adfe9d1000000b00207b80edc22mr1028855wrn.405.1650572252010;
        Thu, 21 Apr 2022 13:17:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 62-20020a1c1941000000b00393a1a024desm1263366wmz.14.2022.04.21.13.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:16:03 -0700 (PDT)
Message-Id: <pull.1256.git.git.1650572159.gitgitgadget@gmail.com>
From:   "Thomas Koutcher via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Apr 2022 20:15:57 +0000
Subject: [PATCH 0/2] diff- family --stat width
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Koutcher <thomas.koutcher@online.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff- family commands do not use the full terminal width. This is visible in
Tig which uses git diff-files to show diffs for unstaged changes. When
trying to display diffs with long filenames, the diffstat does not improve
when the Tig window size is increased.

This patch makes diff-files, diff-index and diff-tree --stat behave like
diff --stat and use the full terminal width. The handling of the config
option diff.statGraphWidth is also added.

Thomas Koutcher (2):
  diff- family --stat: use the full terminal width
  diff- family --stat: honour config option to limit graph width

 builtin/diff-files.c | 2 ++
 builtin/diff-index.c | 2 ++
 builtin/diff-tree.c  | 2 ++
 diff.c               | 9 +++++----
 4 files changed, 11 insertions(+), 4 deletions(-)


base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1256%2Fkoutcher%2Fdiff-family-stat-width-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1256/koutcher/diff-family-stat-width-v1
Pull-Request: https://github.com/git/git/pull/1256
-- 
gitgitgadget
