Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868A8C433E0
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 14:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDA722482
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 14:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbhABOlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 09:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbhABOli (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 09:41:38 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F2AC061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 06:40:58 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 22so19818322qkf.9
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 06:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IeQX0yIl/fvHDnM+m1FsrL9gWP1Ms63AuiXSa6xHV1Q=;
        b=kX6QUx5ftU57DHSv+mpiqDfEj3VA65Cy4e0EeKOQj70U4xkMPmN37URpOa5X8OagYt
         YX+1V/PpCOYCRrNgqy/wMcYN2vY4UZHvd+/o0WGFJLRxjDPu2CfSy3g2dZc4G/UUsEPG
         2AkF0ZR+PjN4wiAkI0KGHdVSJsSnUdL959vWvniLXIYP4rgZ0HdAt8cdl0MAV4TlccNp
         i+sNzCOM4yaLLJXAhl4jhG3BGpLt2z0Vh51HnPMznGuT/oGLplUfGgJgTxVm9DRWy7HN
         iHn9iGIGt2+CwHtyGNcBthHoDkY5Lh0gp5z6WB1Gy3zqixqwk+J1+r1dls6j+pt2wAPZ
         mv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IeQX0yIl/fvHDnM+m1FsrL9gWP1Ms63AuiXSa6xHV1Q=;
        b=Pl1i6az9gewji3CElRBKkcLOoSOmqH3JaHFKpy+gZia1gSeb82ARL7PQTjieIY/nLh
         6eQ1uromP1MWPKQTwTo3zD9LhwGlCr/G5NTO+733yAXJHBtJmM/qPQiLnYcoWbhfdvbl
         XUpw/zz558+mpGORmxf1ROJxlmSB1DhAbXbYZCS56saA1z4bRtghLiIk568ocefYaDCS
         Qi33lqv+ptzuXqxbylGbyYY0rxTiTr+wk82n7vj4YdXkurQYebOZNw66a1Sr+68eEiAE
         bZWHAkZA4r+FOctJOCMlCA/dj4y/MRyIOAExjX6CqMRDkEdx7NyeorrzT72oRBNDRN8U
         dgrg==
X-Gm-Message-State: AOAM531iErAHGJetssLXbSsvi34lO593iypB8HkmcQDF9ehrnB/DWkVb
        ZSXnVwdre8Gmd9la57LhUL+py2P534HPB+uJ0C3yRduD
X-Google-Smtp-Source: ABdhPJyqCkR1lCiCgc14EH0sh8YO1mLel6toGreaGo2nNlgakvqMiUktyRxlf5BSJYmM3g6qj22QL+dleuDlMAwngn0=
X-Received: by 2002:a05:620a:39c:: with SMTP id q28mr27418193qkm.276.1609598457208;
 Sat, 02 Jan 2021 06:40:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:e3c9:0:0:0:0:0 with HTTP; Sat, 2 Jan 2021 06:40:56 -0800 (PST)
From:   Yaroslav Nikitenko <metst13@gmail.com>
Date:   Sat, 2 Jan 2021 17:40:56 +0300
Message-ID: <CA+RLzGCtp2T=8DG74geBs67X5vUvhwRP4FMZ6MJv+E+Pj=YbWw@mail.gmail.com>
Subject: git-dir requires work-tree; documentation improvements for working directory
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git users and maintainers,

I use git to manage my dotfiles with this command:

    git --git-dir=/home/yaroslav/.cfg/ --work-tree=/home/yaroslav

When reading documentation, I noticed two issues.

1) The command doesn't work without --work-tree (even from the top
level directory, which is my home directory).

    [~]$ git --git-dir=/home/yaroslav/.cfg/ status
    fatal: this operation must be run in a work tree

I don't have any configuration or environment variables for work-tree
(as warned here,
https://lore.kernel.org/git/CAPig+cRqkzPzNX8UN4OcgEOOKbtZRLCjNNiZsOVkGBy0pvsEkQ@mail.gmail.com/).

In `man git` for git-dir it says "If you are not at the top-level
directory of the working tree, you should tell Git where the top-level
of the working tree is" ("If"), the same is quoted in a recent thread
(https://lore.kernel.org/git/88D2A179-806F-4321-828A-359692E646B1@gmail.com/)

I'm using git version 2.30.0 on the most recent Arch Linux.

2) In the man documentation for git > git-dir it's written
"It can be an absolute path or relative path to current working directory."
I think this can be confused with work-tree. I suggest removing the
word 'working' (and probably add an article 'the' before the
'current', but I'm not a native speaker).

I can see that the expression "working directory" is used throughout
the man page of git, and it is used ambiguously (sometimes it means
the current directory, sometimes git working directory).

I don't subscribe to the mailing list but hope that I'll receive the replies.

Thank you and Happy New Year!

Best regards,
Yaroslav Nikitenko
