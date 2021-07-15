Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FACC636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C3C6115B
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhGOV6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhGOV6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 17:58:13 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADEFC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 14:55:18 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e13so6404923ilc.1
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QB2BbYHfRRBHbyao5qlUsERgwY1AF9+y4YSLCRHF6Bg=;
        b=U+r+k18Qfj6t6mIbysZAf83KX1DaEhNZMGcAfNXRmbZs+lidai6iOWR5wFYb6sZtyp
         BED9VnkV9tmtGnDMoyQ2+0DwTDV2ObM2Iu5U3pYCPAZ1a8/PiTXZPddze46ltwojQ2J5
         mfNRVp//W4eVdrgfuX3wddBoLkgpRUhsdgRZFPaSqdFSOEMmlhSRSDo6FmNxe2G5nhnz
         uN4C3byxRE8TatLXlY2ulITaeX6PgvbXElCbyHGnDKFd7FGlcdoZ02TEetw+mq+mS3iB
         NwBbsf3Y80Q6xAWDWgekrwBaJ+43I6jK4kiikDSGB90LkGrLw0Pq8aP1WOmP1n92gTqc
         wcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QB2BbYHfRRBHbyao5qlUsERgwY1AF9+y4YSLCRHF6Bg=;
        b=M0ZIVKINL2y9ilVdiFDPx0g/uAcUmZYR4J7OWXpNB8p12PbyMlVwNC+qw14PPR+owk
         W48+IcN1lerb7xTpbcZVopyFxVpGGd6BbkVYxwJPbfnoXtMm04p/7/mSIQZRy5NNTpN7
         zjMCfDf0VwcZyvw4oXbIo3lt+mJHLq2IGvfvqzimM+SEaCzvQmzhQ9TngohVsisXGpV1
         QW8s68JV18cnIS/Zlh2OKCWRjXocwrOSYV6m+80EQahpY0duLRz1FQ2HpuBb5ANiykkg
         ulagaXM8eAjfU0V6mc5Ozy2WLr2OM316Uzmde/QkyzTC79pdeNuKfcS9diufHvb8OxKc
         Hn1A==
X-Gm-Message-State: AOAM530NXfhtNWuUJXKPvCoPj9N3zXdvSkMdadJ9yEqGJNPBsEnZ1wGo
        fJ602eexUUbO2Oae4++UrX/qAHpeyUDjQmJSJ+H9Vpbkhf8=
X-Google-Smtp-Source: ABdhPJxVe4uJazPewCpifvUSB1QvbVd4PVKn+pn57e397ewgWGAB4Z7Wativl00RU85rRxNreTFN8x2CJKoOXWh0n2k=
X-Received: by 2002:a92:200b:: with SMTP id j11mr4127075ile.183.1626386117805;
 Thu, 15 Jul 2021 14:55:17 -0700 (PDT)
MIME-Version: 1.0
From:   Rostislav Krasny <rosti.bsd@gmail.com>
Date:   Fri, 16 Jul 2021 00:55:07 +0300
Message-ID: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
Subject: Incorrect and inconsistent End-Of-Line characters in .gitmodules
 after "git submodule set-branch --branch <branch_name>"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Originally this bug was reported in the Git for Windows project and
contains two screenshots:
https://github.com/git-for-windows/git/issues/3321
Johannes Schindelin (dscho) is convinced that this is not a
Windows-specific issue. Following is a brief description of this bug
as I've faced it:

After running the "git submodule set-branch --branch master -- ms1"
I've noticed that the .gitmodules file is encoded with both DOS and
UNIX End-of-Line characters simultaneously: all original lines use DOS
EOL characters but the added "branch = master" line uses UNIX EOL.

Found on the following environment:

$ git --version --build-options
git version 2.32.0.windows.2
cpu: x86_64
built from commit: 3d45ac813c4adf97fe3733c1f763ab6617d5add5
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon

$ cmd.exe /c ver

Microsoft Windows [Version 10.0.19042.1083]

$ cat /etc/install-options.txt

Editor Option: VIM
Custom Editor Path:
Default Branch Option:
Path Option: Cmd
SSH Option: OpenSSH
Tortoise Option: false
CURL Option: OpenSSL
CRLF Option: CRLFAlways
Bash Terminal Option: MinTTY
Git Pull Behavior Option: Merge
Use Credential Manager: Core
Performance Tweaks FSCache: Enabled
Enable Symlinks: Enabled
Enable Pseudo Console Support: Disabled
Enable FSMonitor: Disabled

Comments of Johannes Schindelin (dscho) in the GitHub bug report:

> I don't believe that Git considers its config files free game regarding line endings.
> Therefore, I think that having DOS line endings in there is already a violation of Git's
> assumptions. In any case, this is not a Windows-specific issue, even if DOS line
> endings are much more prevalent on Windows than on other platforms. Please take
> it to the Git mailing list (send plain-text messages, HTML messages are dropped
> silently).
