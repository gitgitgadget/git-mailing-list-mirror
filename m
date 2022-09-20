Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC568C6FA8B
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 00:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiITAUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 20:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiITAUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 20:20:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB111021
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:19:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso5781153wma.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=A7E27ebvEaJ37K8UVUR5I2bhx3H8+aKSZTmXOrND7LA=;
        b=FOL04am3gUuxktEso9XDWycHJnzaato5YoXb5+pb6hDdI8gSAnfM0WgGeTScoxC+Ib
         Iw9KiilXrsxf/eHRoZlz038peqggazoyx0JcsClMrKv2u9/oJ7oKKkjfghb8QrZXFeOC
         x3XuM5LbuvgVHrts4DOimYa1vU+T8ksrszQjYfKj/JDXTS6RM1iLbi26UmG7dQnDslBA
         hJUcVN+3omY1zJSfYg3e9XMwmqJ5OodpNyHtfjJ1D53roL7/+OydL1MPac0PrIQtBoYU
         iFN4IRspIB4SIGf3WxjOheznd2qDagv81T2cJYsLSglrjBb2YM85HNBqnzVCH6EobezE
         B3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=A7E27ebvEaJ37K8UVUR5I2bhx3H8+aKSZTmXOrND7LA=;
        b=n5Z2IK5LpgJFS9joVn9DgEVowj2wz4Ec8eIs3IZ3YGdQsJQSMY16v3XtMpxAlNyKbE
         7mEK7zi7RW1oZPARZK0GO+lAfToSaYcxag7Uhq8UDw9cAqT1tlCEBCbM+Y4qN8MRWY68
         e62Yduth1ECw9mVBiJgB/5Ji/sppwksDSrJUX4hiSoo77OqIO5Wey3fvSz47E5iuhX/z
         gZMIwVXZ52zyX/EwB544YBHWwvJp0MlUl27vMyHgBp0TbSNbJ7k9RqwPiQBHGPvNIewS
         ZdyTMRHiWFYgnbjD4Miz0ho4haEGD0q1QSnymLkz8CAHDt3nOZQBlY2G59c7l8DKfCDS
         qbKg==
X-Gm-Message-State: ACrzQf3nYLWapQvwfQhSMkxCWNoyG52i14J3VFFyeDLbw2zZx0tbwnuE
        Rg4aBjqnOj8kpkhZCSIMuKy46nM51Ho=
X-Google-Smtp-Source: AMsMyM6wtmC95KKqttKFsJ6VNRsZGS+5uHAGOKBVmrZi/iEtrYbGt7NvvClpK464j3ENaa3z9yr1kA==
X-Received: by 2002:a05:600c:2050:b0:3b4:a51a:a1f5 with SMTP id p16-20020a05600c205000b003b4a51aa1f5mr420180wmg.177.1663633196786;
        Mon, 19 Sep 2022 17:19:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003a608d69a64sm16223072wmq.21.2022.09.19.17.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 17:19:56 -0700 (PDT)
Message-Id: <pull.1360.git.1663633195.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 00:19:53 +0000
Subject: [PATCH 0/2] check-docs: fix 'diagnose' and 'version'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While locally verifying an unrelated documentation change, I noticed that
the 'check-docs' target displayed two warnings on the 'master' branch:

no link: git-diagnose
removed but documented: git-version


The first message was due to the introduction of 'git diagnose' [1] not
including a corresponding update to 'command-list.txt'; the latter was due
to 'git-version' not being built as a standalone builtin executable. This
series corrects both, adding 'git-diagnose' and 'git-version' as
"ancilliaryinterrogators" to 'command-list.txt' and building a 'git-version'
executable.

A possible future improvement to avoid this sort of thing could be to have
'check-docs' exit with an error if it encounters any issues (rather than
printing a warning that's easily lost in build logs). For now, though, this
series is restricted to fixing what's currently broken for ease of review
and minimal risk.

Maintainer's note: if this would be too much of a disruption to include in
v2.38 last-minute, I'm happy deferring it to the next release cycle.
Alternatively, the series could be split, aiming to review & merge the first
patch in this release cycle (since the 'git diagnose' error was introduced
in this version) and leave the second the next cycle.

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/pull.1310.v4.git.1660335019.gitgitgadget@gmail.com/

Victoria Dye (2):
  diagnose: add to command-list.txt
  version: fix builtin linking & documentation

 .gitignore       | 1 +
 Makefile         | 1 +
 command-list.txt | 2 ++
 3 files changed, 4 insertions(+)


base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1360%2Fvdye%2Fbugfix%2Fcheck-docs-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1360/vdye/bugfix/check-docs-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1360
-- 
gitgitgadget
