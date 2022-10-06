Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02650C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 15:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiJFPBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJFPBV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 11:01:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D60ACA3E
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 08:01:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w18so3125697wro.7
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy/+c4Tloz952lvsI+F8t6q9MjxrLJCKuuYeBx3pOWY=;
        b=nMoOsIQjLnH+rG9K6hFpl94wR4qKaK+YtQH9Mk856xvW5Gs8aCthjrjsyMdfb9sQzG
         o2PLdZzdfwNIoISDD4VwqZtZERyechYR03TJ75FWP1S6epqMgyK6wLtyroC72tpOXn/K
         I71/Bs7zdxxLiANC4rb2FANKlNHW0TSkE00hzdxpnV+fDdtGWjoGA3Py7hS3Sn5X/NlM
         v1Urh8XvaIFgr02iu8TkJzZGLSDNnseje7nacGLJcPQbUJUHJ/bDeIncHObydHm3wWBK
         ak0uJjJJ4+8BZ3z6ZP7SnCnLCOM7KMRSpW3+bivT7itE39wQ0pEc/MrLTA/LZQGVwtja
         Ttlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zy/+c4Tloz952lvsI+F8t6q9MjxrLJCKuuYeBx3pOWY=;
        b=kogLAcZ026z6/M1xRsb2QJWO6ByxvbevqZnkS3zWGiYEl3DQV9b9iKO9s1s/SQmwwv
         M5sXAqQlVHLASsmqiEmD3xvufP3KbMAaYVbJUCOoONcec2xcErLo+yI/fDD6SN9Mo45g
         A1s9/F8bI1kR94DWQgh5rfPFZAtxy1sBHI1LwKxzvgUC9R1WtoWizIw3dW4c/9pX9HzT
         hCuyxV+b0pdJVXqqo3eZg68+n4Q5s+UvROGgy4OJp6u7G3knqIOauvvs1hiVDH9/6mS1
         ogoD3O3ngT8xA3MADtv7/OI6ukpsnUzBnwz4ig6JeQ5EIe7rOHGGFVXN53BMRGzPBWao
         6YvA==
X-Gm-Message-State: ACrzQf2qbiuc5CJa3KI1VUcOJCIMXs3xrEAcEt8cO7EuPW2H3nvgZPX9
        m54uMV3CmDYwEjl/b0j09fsOhrl76eU=
X-Google-Smtp-Source: AMsMyM6Jwrcs6+inddA7PehyJJ5zulWQ7x6gfEy73BS3ZuoXH924vR30zKKstaCb70o7sVFcGKwu5g==
X-Received: by 2002:a05:6000:2c1:b0:22e:7507:a182 with SMTP id o1-20020a05600002c100b0022e7507a182mr244622wry.550.1665068477306;
        Thu, 06 Oct 2022 08:01:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g22-20020a05600c4c9600b003b33de17577sm4940074wmp.13.2022.10.06.08.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:01:16 -0700 (PDT)
Message-Id: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 15:01:13 +0000
Subject: [PATCH 0/3] [RFC] tests: add test_todo() for known failures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test_todo() is intended as a fine grained alternative to
test_expect_failure(). Rather than marking the whole test as failing
test_todo() is used to mark individual failing commands within a test. This
approach to writing failing tests allows us to detect unexpected failures
that are hidden by test_expect_failure().

This series attempts to keep most of the benefits test_expect_todo()
previously proposed by Ævar[1] while being simpler to use.

[1]
https://lore.kernel.org/git/cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com/

Phillip Wood (3):
  [RFC] tests: add test_todo() to mark known breakages
  [RFC] test_todo: allow [!] grep as the command
  [RFC] test_todo: allow [verbose] test as the command

 t/README                        |  12 ++
 t/t0000-basic.sh                |  92 +++++++++++++++
 t/t0050-filesystem.sh           |   4 +-
 t/t3401-rebase-and-am-rename.sh |  12 +-
 t/t3424-rebase-empty.sh         |   6 +-
 t/t3510-cherry-pick-sequence.sh |  12 +-
 t/t3600-rm.sh                   |   8 +-
 t/t3903-stash.sh                |  12 +-
 t/t4014-format-patch.sh         |  20 ++--
 t/test-lib-functions.sh         | 194 +++++++++++++++++++++++++-------
 10 files changed, 293 insertions(+), 79 deletions(-)


base-commit: bcd6bc478adc4951d57ec597c44b12ee74bc88fb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1374%2Fphillipwood%2Ftest-todo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1374/phillipwood/test-todo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1374
-- 
gitgitgadget
