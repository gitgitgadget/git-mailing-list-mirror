Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DD9C07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiIWSzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiIWSza (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:55:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6A9EE66C
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n15so1314388wrq.5
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=rFNzguVxGAkKVZNIOeWGPcgTAcriW2kfSZ+87ehMgQk=;
        b=NH2CHGitMl+Z9+tKPuqzvaNeaegwVj8s57QDAsVADzHzjXUplpBGpOXJbXnNDhjdAM
         q/w6GRWOvpiYWYv0ygKRzNjdKBcHpwVCSrKxn3HSIbna7BKFLoPN7xblq9qdiA75XN9w
         qksA+PdREqzryrgB8sprp/AJ54yXWHB663GLnPShPLiR84eqyEJl6xwparQuKQht7lxI
         COEMqq6sfwBLHHJ6d2LyE1xOkwL1KCSDKKDKJozYzngBzSk60r+uLopkk01TVaoW+zlV
         u8h112FPav8gCojNYlGGqeF9QFJmg/IWSpstVl0KXzFwsGMdx8JgEeZuZoiH5sNkNLPy
         Bj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=rFNzguVxGAkKVZNIOeWGPcgTAcriW2kfSZ+87ehMgQk=;
        b=AdR7NtK2cYr0OyjTsJC+LKAly2gKoHWiX0xhNtu51QvIt5x2e0qdclBDAeXEaViiGF
         jCZbh/IjtcoCA5+W6aJiQSwjG4su07LS6oAl7tNDISw2kgxD9mWDDjzFM+o7thZmBAKg
         uwb8eK95bFaUGocL5CKtp28YLii1k8Bg0LHDn7hTgbLqIIEsFtVpWHC8kuxeYKhFuaOO
         zAI7TJUT3kPZ7rXJ3fKt6l/mBila9sVAJ5e5AH70n58YpfQUth2o43VtadmbAphDpODa
         Z6YmtyVXkfpJAEXbqoimh/IicNKB6IVTg/fF6YL2QX+oRhi8p4fzLqqaPcHkEJFDIpgV
         b5QQ==
X-Gm-Message-State: ACrzQf1RmW8mCapz5ZyJ7r2LlWh5NlUxZIr84nCYLpVROW6Z9IyR2vMZ
        psXLz/Jo77u9qhKs8m7oBKj3DknIGoQ=
X-Google-Smtp-Source: AMsMyM5OEJaD2VhVhVGszDu9ZBSDeUCZnVjBz29nu9j/J7A+3f1wqhDPPkpUppu2g3XjiLVn3kUECA==
X-Received: by 2002:a05:6000:1863:b0:22a:af11:8ed2 with SMTP id d3-20020a056000186300b0022aaf118ed2mr6270071wri.58.1663959326024;
        Fri, 23 Sep 2022 11:55:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6b02000000b00229e0def760sm8037596wrw.88.2022.09.23.11.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:55:25 -0700 (PDT)
Message-Id: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
From:   "Christophe Poucet via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 18:55:14 +0000
Subject: [PATCH 00/10] Add the Git Change command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm reviving the original git evolve work that was started by
sxenos@google.com
(https://public-inbox.org/git/20190215043105.163688-1-sxenos@google.com/)

This work is intended to make it easier to deal with stacked changes.

The following set of patches introduces the design doc on the evolve command
as well as the basics of the git change command.

Chris Poucet (4):
  sha1-array: implement oid_array_readonly_contains
  ref-filter: add the metas namespace to ref-filter
  evolve: add delete command
  evolve: add documentation for `git change`

Stefan Xenos (6):
  technical doc: add a design doc for the evolve command
  evolve: add support for parsing metacommits
  evolve: add the change-table structure
  evolve: add support for writing metacommits
  evolve: implement the git change command
  evolve: add the git change list command

 .gitignore                         |    1 +
 Documentation/git-change.txt       |   55 ++
 Documentation/technical/evolve.txt | 1051 ++++++++++++++++++++++++++++
 Makefile                           |    4 +
 builtin.h                          |    1 +
 builtin/change.c                   |  342 +++++++++
 change-table.c                     |  179 +++++
 change-table.h                     |  132 ++++
 git.c                              |    1 +
 metacommit-parser.c                |  110 +++
 metacommit-parser.h                |   19 +
 metacommit.c                       |  404 +++++++++++
 metacommit.h                       |   58 ++
 oid-array.c                        |   12 +
 oid-array.h                        |    7 +
 ref-filter.c                       |   10 +-
 ref-filter.h                       |    8 +-
 t/helper/test-oid-array.c          |    6 +
 t/t0064-oid-array.sh               |   22 +
 19 files changed, 2418 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/git-change.txt
 create mode 100644 Documentation/technical/evolve.txt
 create mode 100644 builtin/change.c
 create mode 100644 change-table.c
 create mode 100644 change-table.h
 create mode 100644 metacommit-parser.c
 create mode 100644 metacommit-parser.h
 create mode 100644 metacommit.c
 create mode 100644 metacommit.h


base-commit: 4b79ee4b0cd1130ba8907029cdc5f6a1632aca26
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1356%2Fpoucet%2Fevolve-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1356/poucet/evolve-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1356
-- 
gitgitgadget
