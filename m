Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C61C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 10:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbiAFKLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 05:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiAFKLw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 05:11:52 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62E2C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 02:11:51 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id j83so6012941ybg.2
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/hAW/YCNGKLMW7zt858XKy6fmstP9OKJUwL+37gU3g=;
        b=IX7zeUViwzzi2JF/qVyB/W490wig/wCtWwVr5QI/fiFpJq/eJKdwR/UG9am8s2yqah
         /H3ly/nvtYstHvLs30GreZvs3Jd2/zOia0mRmhjYAKPDaSbdu8sFaedokWAPzHObACDm
         VCMz6QQ+XCMz+peT9EI/r7ni/nXzloMvfBE00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/hAW/YCNGKLMW7zt858XKy6fmstP9OKJUwL+37gU3g=;
        b=a6o5jq3O1DWShXMHItfaYnUOCme9/DW6fB1JUTg1NdYls2QQ/KQY1ArPzYbJrTCMHL
         Rmbd8J6jTlRwmcBI8DjoSUHg/06TTvlsdk9yfctr/DlgvrVDZka3aH8sHHEfM40JXlgi
         xvt2t9hfa1xj8boMhg2JCc24k+gax+68opOzm6HTjZYUI/N0R06Uzw/pL2+GJTHY0BNO
         OmQxg+N5ZT3K1ru87ChP56oB965xddRLxQZuaXF4+DGqCuICZS62CAAfbzYBEDwYR17e
         G+Lwq7JZgsvKmt764X3ve1HsrArahqmudjc8/T2q5twxvd5tV3r+o6zLBo8Iof9YYIm7
         AoBQ==
X-Gm-Message-State: AOAM532ImIXN9RYF18NRHbp9OzvEwG/ulH5lHatnFze54JIxIJkvCXtf
        jhakyKduoM5uIlAkxNEM/FDUXOMnVP2Br/XlSUX+Ua9e5IQV2w==
X-Google-Smtp-Source: ABdhPJxX2nCmVga9/u2FxdvsSCoNJprfLFLZ/2zAr5OZzgwl7Zum5XPNmXuMmPHBrh2OQAH84S3/WOD4GTEzjxP4Ch8=
X-Received: by 2002:a25:d690:: with SMTP id n138mr60203946ybg.326.1641463911017;
 Thu, 06 Jan 2022 02:11:51 -0800 (PST)
MIME-Version: 1.0
References: <CA+kUOak9_RLpdr9d4pQiwU=K42taCwhMdg5WkLP4GreQd4yWig@mail.gmail.com>
 <CAGyf7-HSia4pRs4FZ107v0jmP4k4Zfw5zJ-3Oz8UvF9oobczEw@mail.gmail.com> <CA+kUOam-Dd-XUk0XaOfw4_rUTg=Ws7w5H=vZ=ZZeEo4XJfsVOg@mail.gmail.com>
In-Reply-To: <CA+kUOam-Dd-XUk0XaOfw4_rUTg=Ws7w5H=vZ=ZZeEo4XJfsVOg@mail.gmail.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Thu, 6 Jan 2022 10:11:14 +0000
Message-ID: <CA+kUOakkd2j_-W9cmcJNQeRzYHim2K2s9ugj29OHDgnh4r1yGg@mail.gmail.com>
Subject: Re: Bug using `fetch` with blank `-c` arguments to git
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Patrick Steinhardt <ps@pks.im>,
        Bryan Turner <bturner@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 4 Jan 2022 at 21:00, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> <snip>
> For the sake of double-checking, though, I just uninstalled the
> version of Git in /usr/bin (after spending some time working out how
> to do that with apt, without also uninstalling dependencies I wanted
> to leave alone) and repeated the above commands, and got exactly the
> same output.

On the off-chance anyone is following along at home: I've just
attempted to reproduce this problem with a fresh Debian installation,
and the problem does not reproduce. So there's clearly something odd
about my environments. I'm baffled about what it might be, but for now
I'll keep investigating on my side.
