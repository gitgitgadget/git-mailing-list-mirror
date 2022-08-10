Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB61C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiHJPCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiHJPCe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:02:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9762875FF6
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso593944wmh.5
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=/iiPhiR4+oTGxeLdIqrz/zlgLUNM+ZoJAfLo5s+C7gw=;
        b=GlKlIhOoVH2ccGOT9oUecZB5GnCAhB0pqKk0U7hukklSJNsiAWuf8IsrSwPSx4oy04
         82vkmrrSyh3t7TlVcrsmTF4SI56gEjV47jWUIi0rCUiQZD/I5+M3/MQHZg5t4ucTFG5M
         TDgKkROQNOn9xSlfKYb/tjEuk0TBOmEtXt3nvuVbkTC150xe/TwI+9UA5GRE9sEh6wzJ
         WmChsTGvotJPvzyTfG75pIgl33jssT7CW/5pEHJz/L3CxNzm41U1igAJ8AnkrJswc8f0
         wzeP6TAFpLbzY/RRMgeRvAF4e5MXA01kHzl38dSz1aTJUS37Z0wYRKoAoWutx59Gups6
         KI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=/iiPhiR4+oTGxeLdIqrz/zlgLUNM+ZoJAfLo5s+C7gw=;
        b=dHWiIt/yp4bbcnNLlP4NOmPlQ8PCSCzq+JUMK65eLzYj4UheOtRrigweX2U8w+TTrS
         +pQX65kTSU86yZdfFZoD7gooS9h3P64YUx121+4DYpkTDW4U5AClfTQi5u420IktFOEv
         ivfq85tEQfMI16mhZ1BWCgj03+2f72F2O1ziAb4kM0vvblPD/FKyVj8n5pnZcegb84Ol
         CCbApQrjO+N9Htx50Ye+7n5eJda42P6TcDhZOwnfYbbgo+hqBW8qxy0C1/ap3BBqB7ra
         wrPWEuGEZMztKArpkrmOEK1qlFAdocw8mo2PopaMWYORQBKvTKR6DsXeqmvYwNs7yR3p
         f6Dw==
X-Gm-Message-State: ACgBeo38j2SvAdAOxRubFcEObY+HzDfmOzKq25MDx9KYmHDUtEjTDVdT
        WzyDr+/n+tWAyxwao5ihAWsnBnzfTV0=
X-Google-Smtp-Source: AA6agR73p4o6SwxOPF3BmEzTJ9n6lMXG3yQF/hSz8G7ppcvXTltbK4IO5O0tqm3uT4rb63r+pkSq5g==
X-Received: by 2002:a05:600c:35d6:b0:3a3:1c4f:6f46 with SMTP id r22-20020a05600c35d600b003a31c4f6f46mr2763482wmq.206.1660143751747;
        Wed, 10 Aug 2022 08:02:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c4e9300b003a30fbde91dsm3170742wmq.20.2022.08.10.08.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:02:31 -0700 (PDT)
Message-Id: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 15:02:25 +0000
Subject: [PATCH 0/5] Some fixes and an improvement for using CTest on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the CMake definition, Git enjoy support for running the test
suite via CTest.

In https://github.com/git-for-windows/git/issues/3966, it has been reported
that this does not work out of the box, though, but causes a couple of test
failures instead. These problems are not caught by Git's CI runs because the
vs-tests jobs actually use prove to run the test suite, not CTest.

In addition to fixing these problems, this patch series also addresses a
long-standing gripe I have with the way Git's CMake definition supports
CTest: It edits t/test-lib.sh, which leaves this file eternally modified
(but these modification should never be committed, they refer to a
local-only, configuration-dependent directory).

Johannes Schindelin (5):
  cmake: align CTest definition with Git's CI runs
  cmake: copy the merge tools for testing
  tests: explicitly skip `chmod` calls on Windows
  add -p: avoid ambiguous signed/unsigned comparison
  cmake: avoid editing t/test-lib.sh

 .gitignore                          |  1 +
 Makefile                            |  1 +
 add-patch.c                         |  2 +-
 contrib/buildsystems/CMakeLists.txt | 12 ++++--------
 t/test-lib-functions.sh             | 10 ++++++++--
 t/test-lib.sh                       | 11 ++++++++++-
 6 files changed, 25 insertions(+), 12 deletions(-)


base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1320%2Fdscho%2Fctest-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1320/dscho/ctest-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1320
-- 
gitgitgadget
