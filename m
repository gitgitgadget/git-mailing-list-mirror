Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BFEC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKBHyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBHyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:54:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF15325283
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:54:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f7so19471531edc.6
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7T1zgORiW9jE0OSFnuxmM1U3AbTkD0IRtj1U4ggiCaU=;
        b=m9Wf9b+iFWiBlfJDPqEGGKUf3fRqT0ZlyHffCI7uHY3ozNyL/Xl1z0SQGx4tUpEfYE
         WH5zqwuq71NSjCQO5HZB0yeKyavLupYTw0ySoGSDcjWzLlhPPEiFrPv0FuCZIsZeyqrv
         2rD01QPGrYGQsjtjGTHyeMWl2+KeR8HVmy6vOF2z7rWin21TDfNXrtq52QokhjEHBWqJ
         Zxqgg8DYhqBema3JgWf+yl6jqP+plLR9cP80yoPlOOCYOP3zrn98+gMwyi77YbKliE0G
         uhJQX5uGF5hYRU2Crk5vVU/NpET0QPzyhSk4NUW/FkEbrcw+JTmgXTVbRHPn6KmLeOaz
         WtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7T1zgORiW9jE0OSFnuxmM1U3AbTkD0IRtj1U4ggiCaU=;
        b=Datd3D620yRhJAkxtVR8N9FmfGmwVWyzX8WK3ryfDEMHOjFpxBJ44powKgRXpvN37K
         guo4UDh268yigd98CGvEJUhZHtuH8Z7UWi880ejAMa1V4aOVLwsqEdjrqGdm0GAMD5Jn
         CiCFbM1jM6ifaUI5kbAmcWwPsrhxYCS4Ws3fWn3tcEFf6AA2cr3ihzb64tmtA9Jp2EC0
         LG9vrdboMqYtSx3CL+2jo87nq47tMSyIdPysCFcsqgbFYcwic/lfZDa5eknOi+lKCcBp
         yU88brCoEz4gCsLcZJAmkPTDX7kJ0xz6BtYe85C7tyS8TAvxuRoypRVAeBK/sCNw/PuV
         V9EQ==
X-Gm-Message-State: ACrzQf3s/eJH4dhCCFU5AKPKyQhXIQ/dNIdGfBVg3cqIApvnrrWyuXNh
        hi7ZGoXdyQWalxBP8bd8MpSHCFouNiDRAQ==
X-Google-Smtp-Source: AMsMyM7k8ysM3EnQSPE4xvlChZN+MmXeDaWwlVRxh873YkNKwM6Si9UGSVPMAGEiiIJC/8L+Pgf3SA==
X-Received: by 2002:a05:6402:1219:b0:462:e788:723f with SMTP id c25-20020a056402121900b00462e788723fmr22853402edw.319.1667375647853;
        Wed, 02 Nov 2022 00:54:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0073d84a321c8sm5045466ejc.166.2022.11.02.00.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:54:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] submodule: tests, cleanup to prepare for built-in
Date:   Wed,  2 Nov 2022 08:53:57 +0100
Message-Id: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a topic on-list to remove git-submodule.sh and create a
builtin/submodule.c, i.e. promoting "git submodule--helper" to the
"real thing"[1].

Glen gave me a bunch of good feedback on it, including (but not
limited to) pointing out that we have outstanding dead code in
[2][3].

Once I started pulling at that thread things became a lot simpler for
the re-roll of [1], e.g. the migration of git-submodule.sh's commands
can squash in the "update" step, as it's no longer a special-case.

But that also made the series larger, and it's conflicted with other
outstanding patches. First René's strvec() cleanup in submodule.c, and
currently with Glen's in-flight submodule topic.

So here's "just the prep" part of that split-out. See also [4] and [5]
for previous "prep" topics, we're getting closer...

This only adds missing test coverage, and deletes dead code that we'd
otherwise have to account for. Then 8/8 converts submodule--helper to
use the OPT_SUBCOMMAND() API in 8/8.

CI & branch at: https://github.com/avar/git/tree/avar/submodule-builtin-final-prep

For a peek at the WIP re-roll of [1] that'll come after this:
https://github.com/avar/git/compare/avar/submodule-builtin-final-prep...avar/submodule-sh-dispatch-to-helper-directly-3

1. https://lore.kernel.org/git/cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com/
2. https://lore.kernel.org/git/kl6lpmemxg8p.fsf@chooglen-macbookpro.roam.corp.google.com/
3. https://lore.kernel.org/git/kl6lv8oexiyy.fsf@chooglen-macbookpro.roam.corp.google.com/
4. 361cbe6d6d2 (Merge branch 'ab/submodule-cleanup', 2022-07-14)
5. f322e9f51b5 (Merge branch 'ab/submodule-helper-prep', 2022-09-13)

Ævar Arnfjörð Bjarmason (8):
  submodule--helper: move "config" to a test-tool
  submodule tests: add tests for top-level flag output
  submodule tests: test for a "foreach" blind-spot
  submodule.c: refactor recursive block out of absorb function
  submodule API & "absorbgitdirs": remove "----recursive" option
  submodule--helper: remove --prefix from "absorbgitdirs"
  submodule--helper: drop "update --prefix <pfx>" for "-C <pfx> update"
  submodule--helper: use OPT_SUBCOMMAND() API

 builtin/rm.c                           |   3 +-
 builtin/submodule--helper.c            | 139 ++++++--------------
 git-submodule.sh                       |   3 +-
 git.c                                  |   2 +-
 submodule.c                            |  41 +++---
 submodule.h                            |   4 +-
 t/helper/test-submodule.c              |  84 ++++++++++++
 t/t7400-submodule-basic.sh             |  10 ++
 t/t7407-submodule-foreach.sh           |   5 +
 t/t7411-submodule-config.sh            |  28 ++--
 t/t7418-submodule-sparse-gitmodules.sh |   4 +-
 t/t7422-submodule-output.sh            | 169 +++++++++++++++++++++++++
 12 files changed, 349 insertions(+), 143 deletions(-)
 create mode 100755 t/t7422-submodule-output.sh

-- 
2.38.0.1280.g8136eb6fab2

