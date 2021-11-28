Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B08C433EF
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 06:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356160AbhK1G4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 01:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356347AbhK1Gyo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 01:54:44 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375EFC061759
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 22:51:28 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v203so32281553ybe.6
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 22:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=l+tALQ+NQxr4ciAHXrOkeTbKF0Jl1n1KCFzO+voMOEk=;
        b=Hx02K/YND7a8WIhtL6v0ZdGRKCEMbvdLkY4T5hROllGXeyXib8TscMpIqktLkQ19jF
         YBlhZnd5M+NrLFNB4DHplB36r2EEFdVSC7QjTwCZKBPPL1uinDmRffGDmPlhnx2Ry6JA
         0aQ60H9EwgtjiMgxeSkq7/PTUV8nDhfDo2InQTOAto2KyPGp+wffuus1VRApOl2XydJt
         BTQ3tteuUIrUUfztimmLVzEyHNOti8EfnR1Mgbp7jz2myR12SaGXGlASFPmerB6gaync
         XuArCRsGHHVwiKixjumJ8koAg7cgrCE7i+QE3GVm5fGiWXrKsy6SExRczsJxgnmyLtzc
         yTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l+tALQ+NQxr4ciAHXrOkeTbKF0Jl1n1KCFzO+voMOEk=;
        b=bPjXkHPtuDbkTJPmE/zZpjPS53F15YCCEnOKpZC1DCKDSHJFAcPtoklCALRzUiFJTY
         d2KK5RlJCHymjpUj52uethdx5VpgD2Pr2G+EyFUpxGxUigdIwxWAzeF1/5KFEV62od7U
         Qzk0Tk5S7REsvA5IdWa00AdS69m4f8tOvZu05n7cH7rr3gnzyMmSXSwdCcU7puxHI5Ry
         NjTIJiU8w2sE1Q5DfkCYvHYXCZlhzjbehMcuYRbfO3/Twy2XlBWpZLY8PEBginq93VH1
         I+OqnSOj1lG3LiNfBBDkxIJ6sFAraKuZGa3++3eWpEKzS6fMqoCGFNhrafrg3b1W+q/g
         9Lag==
X-Gm-Message-State: AOAM530IfQlN2SnMWh3rJy9Q6IzpitvNfjGR6mgMAQ19aEO+fwpdWEsm
        3WL9+e7p28KRe7fybWHsM8VyQ/fsGj+Fu5NzFBn52YSG8OWBQA==
X-Google-Smtp-Source: ABdhPJz4p+gHbP4Bcqj+PcE7qJ538DWBNqWUnTyH9zpRbvGANVEX/WW8aJXCioEVLwnu7E3SS6MoQgfyvF0mAayIBc8=
X-Received: by 2002:a25:7385:: with SMTP id o127mr27006337ybc.439.1638082287045;
 Sat, 27 Nov 2021 22:51:27 -0800 (PST)
MIME-Version: 1.0
From:   Baruch Burstein <bmburstein@gmail.com>
Date:   Sun, 28 Nov 2021 08:50:54 +0200
Message-ID: <CA+34VNLj6VB1kCkA=MfM7TZR+6HgqNi5-UaziAoCXacSVkch4A@mail.gmail.com>
Subject: misleading message printed when worktree add fails
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

run `git worktree add <path> <branch>`, where <branch> is an already
checked-out branch

What did you expect to happen? (Expected behavior)

fail to create worktree

What happened instead? (Actual behavior)

worktree was not created, but a confusing message was printed:
"Preparing worktree (checking out '<branch>')"

What's different between what you expected and what actually happened?

The printed message seems to indicate that the command was a success,
when in fact
it was not

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.1.windows.1
cpu: x86_64
built from commit: 05d80adb775077d673fab685009ede4a1003ed92
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 18363
compiler info: gnuc: 10.3
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe
