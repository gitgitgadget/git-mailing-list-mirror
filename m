Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A26C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 01:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8110D61057
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 01:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhIGB3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 21:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhIGB3i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 21:29:38 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8907BC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 18:28:33 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id j19so6952519vsi.6
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 18:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d73na/utcRX5bCu9Z01GaZuBwNoXZ8vY2moUZJK/HnA=;
        b=V/hHsARCwEz8yP0sdWOL2nggCjkELfsaq+qUM+VAPS7xpVVIx0ReztjYj//2KK/GD4
         hZJXyXKj1HBC9Y1+epFXydYi+SD2hIMgExgMjUdVaIUG19dGmSCqqtcfW2J6k+yuwiNh
         uXS+hBfFwh61uI8H8oVjSslSMCK/z9vTF7lLKrZbSx4z/qYV9bjnxpkWNTOXrXaIgPab
         xDVMlk+5bfPTBR2wZQZjloOnP81i6T6JizxhKFsU8BhJKJxca62qy+43SHeV4IUxnwNV
         MLkK/xi5o+2y6L/sfWg5G8drrny/lJjI5LUtToUMmAPQmp8KAprtDMOg+NcroDsvtfze
         JPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d73na/utcRX5bCu9Z01GaZuBwNoXZ8vY2moUZJK/HnA=;
        b=oVTiVvRjVvOrxNHqdQqgKHNNGqDKIz3PF6zsi/tLdKK9YYdicFw4jQ0jW0YTlHS12c
         Z2P13ejaG7KEVUi/282H9xK39Hx6Or9QfpZNx5T4Uyxwfx7YXYFA+xGlBsxlrhNPk3Bh
         oXZA+Bmwtb9wRVfkAWIjXdPL79UQAV75sogS8Lt7pErisa9bzLO0rNe0m5zM73y+rMtj
         cSpO174AlBp13ZBR8KVnP3dF4d//KdfVYxt/ALu/xM/P11aJb/YgYzUPUbyLgyo+642e
         WwaHQFwzsU6TSkZXbAHygs12Iq3rPWKlMvYyPpV641CeDe5dSkzQna+oj/7t9nUF7kfr
         pVXg==
X-Gm-Message-State: AOAM532wU22hg1foySJ7ickDpb/NudZT23+0An/lI55ywo3TbDrTXT5r
        iw7i5Xvlh94UFJ013t7Tdfv33mgLZXYIOXe1/zM=
X-Google-Smtp-Source: ABdhPJxlB8OG8we+Od8/hb/7HDviO3dqW6HXS+iJPHdAI1K4fJJIQUiZvMnbc2SyVMgexvbdRC2y9kYPParJ4KdW510=
X-Received: by 2002:a67:ef48:: with SMTP id k8mr7274004vsr.57.1630978112428;
 Mon, 06 Sep 2021 18:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUEsphYPqaZueCcZ-SJx9HabuesSyx8MJOhkEjAJjWGGrzxEw@mail.gmail.com>
 <20210907001609.156105-1-tbperrotta@gmail.com>
In-Reply-To: <20210907001609.156105-1-tbperrotta@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 6 Sep 2021 18:28:21 -0700
Message-ID: <CAPUEsphn15H9HbHKHRk+GFMvjq5O=8NL0Vo4L8NoUwiRrQUJJA@mail.gmail.com>
Subject: Re: [PATCH] send-email: move bash completions to core script
To:     Thiago Perrotta <tbperrotta@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 6, 2021 at 5:16 PM Thiago Perrotta <tbperrotta@gmail.com> wrote:
>
> Let me know how you would like me to proceed here, I see 3 options:
>
> 1. drop the second part of the patch (v3 2/3) completely, only keep the
>   other ones (1/3 and 3/3), which just adds the newline and touches the
>   man page - leave automated flags for another series

This seems like the most straightforward and quick way out, but I was
really hoping you could take the time to instead do the move to perl
with the programmatic option, which is long overdue anyway.

If you go with 1, then 2 and an improved 4 could be done as a follow up

Carlo
