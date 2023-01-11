Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5742C46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 04:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjAKETq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 23:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjAKETn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 23:19:43 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E85F004
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 20:19:40 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i1so3955541ilu.8
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 20:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N4QZkt2SndMdBJ1qTl7RPA7VLQCxcMXRk2Xz3PFNA7c=;
        b=bfjqt9fNlaUd0G6ImtKlptsdYIo7bJmFBZindVO4SdrD9Ey6D4DaBFjy1SCo9udUdG
         5KR1WILpHJm/mrjiqN+WTLBlvuR4Qi5huaCwOdHV6ZzUpccIpXGWboAyMXY/g5FYWYWF
         ikDgjaDsl0iGIvlrt2wnLiyLtEFjYQ7aGhpkIPmxWyoBUlgvDUv/N4LffNVWx0cEBCTG
         VZPC9nbeZdu5EbMPgiib0Z0CBMkqI3/KjZl4/Cx/mQiTD5C4amA4RVztIBJmXtifN/JR
         1bwkDJbUcqZ+0CxY7knPpzDtam3QDfBQbvbQ+ZubWfz1VlBcM4RFEVvx0xbF+XCg6MdY
         AnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N4QZkt2SndMdBJ1qTl7RPA7VLQCxcMXRk2Xz3PFNA7c=;
        b=Z1R6Jst3Kxg1NIYs2Iu1u9X3itYoY1MNDBypxqLj8KfQ+3Y6pyaaZRGmna32tLC9Yi
         XcwsTf60yaiy61W5FQHhulQH0frK7YLCmlefxocvMORVbbBmHzIs3sEQ6vXFY1eBfOKi
         ndLmGAo3Ag3FXZGEJGpAqFpyf/qN3zaPC5lBUzo6I0+3FV+rVm36gt7Dms+4goH/Bnvm
         eKoa2+nHTM207nxW/RQ5IT8ogkIDtrHEej3Sz59LGvjUaA7oyZASdz6koHs3KFML/niI
         LHiftltv1vRTWXZH05xIWJmQt9Ls26yK1esiFwPEXtjtYQPc6md+Xld78F2XwoJGIvLH
         vNtA==
X-Gm-Message-State: AFqh2kr3W3Yv6Ms9yAKZMpw5VeiNEVjugMmMbHiCSaHnlUc4UaunNDan
        KLHmfmPxMV/9Fk6+Yk8aOR5ocLP4ao0tulLxemz+ZG1lMOY=
X-Google-Smtp-Source: AMrXdXuhczQZ0rCsOQiMM2/l377Y6RJoFGSCpg3PVTrY0pSeWax4GSy8WCOf8Iz340zdXbiH+JEFVRj/AIZdB3mno9Y=
X-Received: by 2002:a05:6e02:974:b0:30d:c2cd:2dc7 with SMTP id
 q20-20020a056e02097400b0030dc2cd2dc7mr61456ilt.190.1673410779947; Tue, 10 Jan
 2023 20:19:39 -0800 (PST)
MIME-Version: 1.0
From:   Arthur Milchior <arthur.milchior@gmail.com>
Date:   Wed, 11 Jan 2023 05:19:29 +0100
Message-ID: <CAEcbrFc=R=3aEwEE56EvZSPSV4+RWFxt=hm7csZ7oBTR8BDQzA@mail.gmail.com>
Subject: Misleading error message on a failed `git mv`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for git, and happy new year.
Here is what I believe to be a bug in an error message

Thank you for filling out a Git bug report!

Please answer the following questions to help us understand your issue.


What did you do before the bug happened? (Steps to reproduce your issue)

git init

touch file

git add file

git mv file folder/file


What did you expect to happen? (Expected behavior)

Either creating folder, or stating that folder does not exists


What happened instead? (Actual behavior)

Error message is

fatal: renaming 'file' failed: No such file or directory


What's different between what you expected and what actually happened?

The error message seems to indicate that file does not exists. It
actually exists. The destination directory does not exists and is the
one that should be mentionned.


Anything else you want to add:


Please review the rest of the bug report below.

You can delete any lines you don't wish to share.



[System Info]

git version:

git version 2.39.0.314.g84b9a713c41-goog

cpu: x86_64

no commit associated with this build

sizeof-long: 8

sizeof-size_t: 8

shell-path: /bin/sh

feature: fsmonitor--daemon

uname: Darwin 22.2.0 Darwin Kernel Version 22.2.0: Fri Nov 11 02:03:51
PST 2022; root:xnu-8792.61.2~4/RELEASE_ARM64_T6000 x86_64

compiler info: clang: 13.1.6 (clang-1316.0.21.2.5)

libc info: no libc information available

$SHELL (typically, interactive shell): /bin/bash



[Enabled Hooks]

Regards,
Arthur
