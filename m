Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EF3C4167B
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 20:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiL3UGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 15:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiL3UGH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 15:06:07 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C1D1A833
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 12:06:05 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j206so24555761ybj.1
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 12:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VHt4lw/QRU0mj50zF5JbRBxzxE+JjcRdHwRdBs1eumA=;
        b=bC045j5Gs3Z4cbhlRrwL7cag4zrsfbWBHfYaZxjxBGBM1M3W5S7KJvQZ0Lf6nAJh9p
         0afNjYWfrWfgDpX9PGLshjNkq9Hrsq8zZYzJZ7PkPcEQmxfVaBV/C/ofTjlDtW+7Rd7x
         oMJ99ErRz/psshEvc3m3kNeOkThF4hOCyNCD9pwuFLhhz30svyepjeD+LGiK2jiazsev
         nx0kvZ86W7fl7z/c+hFJ6PR6RbFofQur3+32NEqySLextdDfNWg9AT9QSGE+0JgtQs11
         R+D2HPyRMdxDw4bItf/8bnuYnFf+Oz64iu0RmJjMEQoqDXoCyMXTGwcoophU7Xt4BmAb
         UlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHt4lw/QRU0mj50zF5JbRBxzxE+JjcRdHwRdBs1eumA=;
        b=vmIS0hhjc0i6bIDdQJ1uWuga+2W96C7Ucu7nd4A5bRCzPF5rhsRXVrXYBgaGzJiP8F
         KemWyCe9fwCZ4xQFBulFilrK9Hk+kQFU0rzwpxiYBs2yTC/gbOWMgzGv9BpRikSGTq7s
         k+uYOjk5ifP+Ol2A8k2h5cIPlI6g3uUykxrugSF4SjAM8kteHWzuIwYS2Rf7DonA9l88
         e7Ai/5xBhUcdNOx9xq+R3zmt9wnOMBw44M4xRMLcUT8H0sADeGrI3RaZCb+r5vx22bcl
         s6RL3O4MhsDsjYJs15nWXLpYLgmMD626gVaO89C5mvVJEv8YNu3ZY92NnhT8mhkvSqJG
         QP4g==
X-Gm-Message-State: AFqh2krxcnLYp5If3Ndc76q94gn2wYwEfRz+NchAiDCZGwGMbdVu/0CV
        cGnJUTdqQsYOAcSz7D91IQ4lPgKi9z+y2TkvKNzecrK9ivY=
X-Google-Smtp-Source: AMrXdXsM2KjsvFGgMxrpI6BELHTK4/XrpiJv0F4KpnxGax6CSz268QiEwdLYwTp0B5px+Mgq1p6OUaYBR4PKCy5V0Sc=
X-Received: by 2002:a25:7910:0:b0:6f6:e111:a9ec with SMTP id
 u16-20020a257910000000b006f6e111a9ecmr2439678ybc.259.1672430764562; Fri, 30
 Dec 2022 12:06:04 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 30 Dec 2022 21:05:53 +0100
Message-ID: <CAP8UFD1uDd6d-8Qk-4Uxrn55wzuqRnr6s6AaQ5Gh+KE8L+g8OA@mail.gmail.com>
Subject: Draft of Git Rev News edition 94
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Martin Englund <martin@englund.nu>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Siddharth Asthana <siddharthasthana31@gmail.com>,
        Mirth Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-94.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/620

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Sunday
January 1st in the evening.

Thanks,
Christian.
