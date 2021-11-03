Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F4CC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 00:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFD46054F
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 00:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhKCAab (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 20:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhKCAaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 20:30:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9052CC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 17:27:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m26so614032pff.3
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 17:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=wXjjr3mCWtC8SbFbQ7VYq0yrv9PLxeRBQ6Fb4Gslufs=;
        b=lpHaqUlBz+IBeuaQS2rR0hU9wMi8tzXmOocVH160fbVcltNHRYabYP8ouUNyDBnVxr
         cZ5hF2Ojh04bR1d5eb6PgOaPmRzdcnmT0DhUkax0OtjIyrPVqoMZa43OQWT544/mLYdG
         Juiu8bZ3LEqg/V9/vcC/3xM2h9dMfOZQB1ZPL75LGOXb3spEFTJtvNaoOviCkLL+k84v
         K+rAg+EmQsG/aruoY1X7RFub/Cu7HG8eTv+mx1GDfm3zzekx7TkKgJZuawtHkaOlMxGK
         czJTrydvbS/zzuFZn5O8WdzNxPqw/toWliCxUw9ZlGFKKI5/DcIyBHdvplZwi8MelMPY
         dQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wXjjr3mCWtC8SbFbQ7VYq0yrv9PLxeRBQ6Fb4Gslufs=;
        b=XyoKmh7KzoDiqK7/zHO+h/uT6T2CXrIHLveMUhAuKacO1KI6KkV04I6Kf26B5Z7Nnc
         1vI2rVaKLWqBVMJbmSY1xRAMbuWbifQ1WCVoF5kDf8plkX6o558FUQPFKCs5oPwa9XKZ
         0JLkYI61Hja7AK3oHlGE5M4UFQzy6U8pCa6uMeYyb+FYiY2YMl7QHMu4QB5kDX8us9CL
         ztK2zZw6OATLCZzfbGlRUFGXAVkJv54kwTTeXcdPT/4Co0AdDfFTiUFqihf0bOxa3LmT
         vtKT4CVmPF5Lz3bZxSGMRRrYHqEHWdRrZgzshbnnpT5ZJDV8n8xDU89nLuWLohYHQ4gN
         2eqw==
X-Gm-Message-State: AOAM533b13BgQ5YJGrFd5KR5BItFVEhksJAtMYThsp4V8KaWxae70jUH
        0YFy3FWBEmVPnf+o2EkqytCbOe+hlyvRLf5DUDuB4okb3zUcRg/J
X-Google-Smtp-Source: ABdhPJx99Nqn/uzrmnNqEAviVEGgtT8PMY5O7iz3hXpORdQNeHMz6xiEZbqH3cd87exvWIE9bUzmwDjgYgLVTUGpCCE=
X-Received: by 2002:a63:89c3:: with SMTP id v186mr15781790pgd.57.1635899274926;
 Tue, 02 Nov 2021 17:27:54 -0700 (PDT)
MIME-Version: 1.0
From:   Steven Penny <srpen6@gmail.com>
Date:   Tue, 2 Nov 2021 19:27:44 -0500
Message-ID: <CAP8dQmu6Dfo4KBsVk+6xeR6=+S8bOKk-kbc3ub7c0jAsH61-cg@mail.gmail.com>
Subject: credential-store get: No such file or directory
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently tried to use this:

    git config --global credential.helper store

but whenever I run this:

    git push

I get this result:

    fatal: cannot run git credential-store get: No such file or directory

I have tried changing HOME value, as well as XDG_CONFIG_HOME, and it
doesn't seem to change anything. I also tried manually creating the
credentials file, to see if that would fix it, but error remains. I am
using Git 2.33. I know this worked
in the past, but it's been some years since I tried it.
