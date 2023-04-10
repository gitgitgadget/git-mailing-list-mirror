Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F72EC76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 17:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjDJRBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 13:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDJRBv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 13:01:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDEC1BF2
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 10:01:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d9so5125880wrb.11
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681146109;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l9jJM2zKjM8sAOPWQPAfBpEHB8B3VSnzol6t7vlFQzM=;
        b=UU+utOa2o2BmrPFU3x0HoKX4TllX621ryh4h/p7euayUfUiN/xiuhQizUpVUcugcC6
         NyUWNJfhoakk4lWL/lMn6KkbAYCjdsv6WvjRn+CCGHD1R/40ZAA2FzMIpolYbCCtSkq0
         eNteTXd8aZ3DJgydIBbEyd73hNePDw7J9cUpkQNrwfDfeA4hCQZpOxoP4ZqMu+s40STz
         Gx89rVd2t2xcp9Xr59DWL/KxHu5MXDQBNlsH6Y/59J3sYMuuWxfUKC8zBxYqhsoufR+B
         ZHwuhCknGcEJekUN5AV01G5a+X6Ohy9SRSbrT15zxOYoV8Ql8NL1YW2rtqg6A4N/2cQ3
         dNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146109;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9jJM2zKjM8sAOPWQPAfBpEHB8B3VSnzol6t7vlFQzM=;
        b=fqtvpu7Ugff6RfSvxVyKZtZWj/sD/hDMB1wcpgn+m3BAWyfaPauGjgD75o+tVKH86w
         s4f4JchHKq0gpjIhbIgxHwzpZruN1JHoAjOq56fWit6QtR00lMEpB74gekLDm+wbPsbA
         PHcrtH3VfvwA7YbqrhU4wQ+j+N8ocmmEMz9ROj1W72dMOtuC+f/9VQ9pJcH8R0vQTPig
         6szB6Fy5dcLrwozoCK+kg/5PEEvlyyTl0N4ks/VpjoBw2vL3wKnugVY+m4g3wODaLyt4
         i5O80pWujcvlKywwcdIgDgeRVtz7kjZkfPCsqAIrQW6Yh8OKLE4hjc/4L7suV4d4TklO
         vlgQ==
X-Gm-Message-State: AAQBX9eAB87psDuS8SxWjUTrCvbOxWMa2PPlUSgUBmQ3QiFnyD0eeRoG
        YmGHvNP92T239zmgEdS48xJgqoZT9ok=
X-Google-Smtp-Source: AKy350bE0lG9PDGnBbt5cjJUiRuA4PUpyj29yvb6Wki2KQ+lMCMlS/iXCwJxzpNZoU0J4kFp/N4cJA==
X-Received: by 2002:a5d:6842:0:b0:2d7:9206:488d with SMTP id o2-20020a5d6842000000b002d79206488dmr7290434wrw.36.1681146108673;
        Mon, 10 Apr 2023 10:01:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d4845000000b002e5f6f8fc4fsm12200860wrs.100.2023.04.10.10.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:01:48 -0700 (PDT)
Message-Id: <pull.1490.git.git.1681146107.gitgitgadget@gmail.com>
From:   "Allen Reese via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Apr 2023 17:01:45 +0000
Subject: [PATCH 0/2] subtree: support GPG commit signing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Allen Reese <java.allen@apple.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for -S/--gpg-sign/--no-gpg-sign command line options and
commit.gpgsign configuration. These are passed to invocations of git
commit-tree.

cc: Avery apenwarr@gmail.com

Allen Reese (1):
  contrib/subtree: fix gpg_sign_arg not being passed to git merge.

Jacques Vidrine (1):
  subtree: support GPG commit signing

 contrib/subtree/git-subtree.sh     | 36 ++++++++++++++++++++++++------
 contrib/subtree/git-subtree.txt    |  9 ++++++++
 contrib/subtree/t/t7900-subtree.sh |  2 +-
 3 files changed, 39 insertions(+), 8 deletions(-)


base-commit: 0607f793cbe0af16aee6d2480056d891835884bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1490%2Fareese%2Fgit-subtree-support-gpg-signing-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1490/areese/git-subtree-support-gpg-signing-v1
Pull-Request: https://github.com/git/git/pull/1490
-- 
gitgitgadget
