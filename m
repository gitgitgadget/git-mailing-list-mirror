Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BDBC282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8652081E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESB9QZsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgAGTEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:04:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34591 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgAGTEe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 14:04:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so525169edw.1
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 11:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ZqVQnTiMlVng8Co2Yvotxn8QdXyjH1cKTw0DAEzNH8w=;
        b=ESB9QZsVVCp8n2GjrAik07qACcQZJ3kJdGoQJWPMwh8lShWmXzp1dEH64+Wz8f55u6
         BwZ0sHwJhISWX0hDFv93jmkt1k63kfj96G3mGSM4Slt+lC1IiYcVVTZztqO5F4cbtV3X
         3SvbugDuXmMtpqJWz22FQ8S2Db62KikTnlKXYiI9o3M/l6pyWt1aXFdFkF2ovlW0/Vzc
         HRIXTvN7B5aOeg8VAv+4d3nASrAWrL+fZ1M6qfcnmQib5+Gq4qJnyeda8aTZvhBO8rCk
         hOENPuXeUkO2ciyB+1+Gia5AimCvvMJvA2ZmjJe4VwH3DIrhgwSBgEJN49wv6gqpB+BG
         XDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZqVQnTiMlVng8Co2Yvotxn8QdXyjH1cKTw0DAEzNH8w=;
        b=jfd8km4it62HzNMt7z1WlFzTgpgCHwB/WaTyPPUXPBevIgi6FaVWEHcXbWhliyAzaM
         ZAuhA+sbwfprfiivFGxv0qqQ8CkSDcg/S6oJEJclQ1VLDgxrdElCJuES5xKq/3jXARho
         brm46sc1ReIy8AqRpbhTuMtaCLtfr55GVi2270jWWwWvSsYFQMbcO6ovVwDKnAPwBAQA
         vKyM2Es5h/goMEkj5Jyl1Eyy2ZjYN0MyMQCSpT1Ok3tcRCkLJDcmF+ApH4z2agh369xO
         v5YU0OMQH4kPj0qF155HLM70oiHgmNRaC9n60P1CyOFNKR/RdJY4uNQ0FOmxPtk10YkI
         fSLw==
X-Gm-Message-State: APjAAAXNAJgrxgY4zrk4rofYePGvTgrnR6zq29xtGKxuLxpDwuR/UjdC
        y14X3/DgBTWoDYOVvtPurkLvu3di
X-Google-Smtp-Source: APXvYqxaDVkhIaZabH1SsmC01nOVNrAd19BGnENRAAQ98AT3q+aXexYUdvxf+YaAtBOQFwT290dFPg==
X-Received: by 2002:a17:906:c791:: with SMTP id cw17mr905316ejb.69.1578423872586;
        Tue, 07 Jan 2020 11:04:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j27sm18722ede.4.2020.01.07.11.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:04:32 -0800 (PST)
Message-Id: <pull.510.git.1578423871.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 19:04:27 +0000
Subject: [PATCH 0/4] fsmonitor: start using an opaque token for last update
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using watchman for the fsmonitor there are race conditions when using a
timestamp for the last update as noted in the watchman documentation "Using
a timestamp is prone to race conditions in understanding the complete state
of the file tree." https://facebook.github.io/watchman/docs/clockspec.html

Watchman uses something referred to as a clock id to remove these race
conditions. In order to use a clock id for the last update, an opaque value
needs to be returned by the fsmonitor hook and saved so that it can be
passed back to the fsmonitor hook for the next query. This requires a new
version for the fsmonitor index extension and new versions for the fsmonitor
watchman hooks. We also need to make sure version 1 of the hook continues to
work because users may not update their hook when they update git and we
want things to continue to work on repos still using a version 1 hook.

Kevin Willford (4):
  fsmonitor: change last update timestamp on the index_state to opaque
    token
  fsmonitor: handle version 2 of the hooks that will use opaque token
  fsmonitor: add fsmonitor hook scripts for version 2
  fsmonitor: update documentation for hook version and watchman hooks

 Documentation/config/core.txt              |  11 ++
 Documentation/githooks.txt                 |  13 +-
 cache.h                                    |   2 +-
 fsmonitor.c                                | 120 ++++++++++----
 t/helper/test-dump-fsmonitor.c             |   2 +-
 t/t7519-status-fsmonitor.sh                |   7 +-
 t/t7519/fsmonitor-all                      |   1 -
 t/t7519/fsmonitor-all-v2                   |  21 +++
 t/t7519/fsmonitor-watchman                 |   3 +-
 t/t7519/fsmonitor-watchman-v2              | 173 +++++++++++++++++++++
 templates/hooks--fsmonitor-watchman.sample | 138 ++++++++++------
 11 files changed, 405 insertions(+), 86 deletions(-)
 create mode 100755 t/t7519/fsmonitor-all-v2
 create mode 100755 t/t7519/fsmonitor-watchman-v2


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-510%2Fkewillford%2Ffsmonitor_opaque_token-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-510/kewillford/fsmonitor_opaque_token-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/510
-- 
gitgitgadget
