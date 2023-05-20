Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB86C77B7A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjETQOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjETQOD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:14:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF2DB
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3078fa679a7so4262704f8f.3
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684599240; x=1687191240;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt6f11KNmvVdiM7mydcz/tAwhywfaZeYX1iO6OWfNTM=;
        b=Ia4SQKQZZ9QOVpg/vyVrL6vu3d35mBbDBnITdRjFgRGSpTWDdjiCXyHxr6uwtKpOE0
         vy2bXVnXSsNQ6VV+Rs3xYesXAOjZmf/ewHJcBVCt+AqX1MQUz3InXM/T2WbhOvIM4qu3
         o9IFLR1X9KhN4iiqfq0z7+WBMnjvwK8SPjc6KxqE9/Q+4+MUuy1N1iKtvrJM2Ak7cpCb
         EXancWV6R3i3Mfro2hOf47p8VOeus3NmGrGE1qKXKwMBgZFg1aSOxE3ciO2AH7DVKzv7
         AEDEcL3SI9zf4bIRAWtmhxIAmyjyZd0HrAbtgsyvdK1R86ZS/SjJkDk+f5/9MqWNUOmO
         yBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684599240; x=1687191240;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vt6f11KNmvVdiM7mydcz/tAwhywfaZeYX1iO6OWfNTM=;
        b=kqx259yPnx3kNGdQbD/FbAeMlhv+SwGo2PDyIoLyI+41lHOjKFLqlh/zwC7r0eeH/L
         lapkpeeiTaub7NuVEnqbCNFfG1d785OahdNid47IyXgoSz5IAM2Gf+wZDtJtD8LFmB4F
         3ErWiePjSwARSjbKxkGxBnPiqROJxfNrdaXc2eJFL9ICYkoF2fpDlWkbBvj44xaNuXdE
         zp8zqu7R6V8YMqTwmu0bj8qwnN23EFXjjV4LqYMKhczY1f88tITYLsikIbYAxFroE12I
         IikbpS1ESBEP2z/qRcQV63nK0DM6/jjb6jBgKlv20J5lVgYXkRLVQ4/kOCZiiBVWQ+8H
         aW+A==
X-Gm-Message-State: AC+VfDxxBUKWQuu62M2ZKB7SBatpae5fL4aHMaWq8XKKoWmhUTNlXv7r
        fa15H566a2DezVlxztJy4CobU/H4Pq0=
X-Google-Smtp-Source: ACHHUZ4+mqzK7Bd3dYJm238Nr18w1hVbksXWi7lv/70Iel04ayztIF+ThQZTmlVRqOwhSPZVCQLFqw==
X-Received: by 2002:a5d:45c4:0:b0:309:3ddc:1c8d with SMTP id b4-20020a5d45c4000000b003093ddc1c8dmr3630527wrs.70.1684599240218;
        Sat, 20 May 2023 09:14:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d58ec000000b00309257ad16csm2349403wrd.29.2023.05.20.09.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 09:13:59 -0700 (PDT)
Message-Id: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 16:13:48 +0000
Subject: [PATCH 00/10] tests: modernize test format part 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a number of tests that still follow an old convention of using
four-space indentation. Update a bunch of tests to use the new convention
with tab indentation.

This is a continued effort from [1]

 1. https://lore.kernel.org/git/pull.1513.git.git.1684440205.gitgitgadget@gmail.com/

John Cai (10):
  t7110-reset-merge: modernize test format
  t7111-reset-table: modernize test format
  t7201-co: modernize test format
  t7508-status: modernize test format
  t7600-merge: modernize test format
  t7700-repack: modernize test format
  t9100-git-svn-basic: modernize test format
  t9104-git-svn-follow-parent: modernize test format
  t9200-git-cvsexportcommit: modernize test format
  t9400-git-cvsserver-server: modernize test format

 t/t7110-reset-merge.sh           | 314 +++++++++---------
 t/t7111-reset-table.sh           |  20 +-
 t/t7201-co.sh                    |  92 +++---
 t/t7508-status.sh                |   4 +-
 t/t7600-merge.sh                 |  40 +--
 t/t7700-repack.sh                |  10 +-
 t/t9100-git-svn-basic.sh         |  31 +-
 t/t9104-git-svn-follow-parent.sh |  62 ++--
 t/t9200-git-cvsexportcommit.sh   | 351 ++++++++++----------
 t/t9400-git-cvsserver-server.sh  | 530 ++++++++++++++++---------------
 10 files changed, 739 insertions(+), 715 deletions(-)


base-commit: 9e49351c3060e1fa6e0d2de64505b7becf157f28
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1514%2Fjohn-cai%2Fjc%2Ftest-modernization-continued-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1514/john-cai/jc/test-modernization-continued-v1
Pull-Request: https://github.com/git/git/pull/1514
-- 
gitgitgadget
