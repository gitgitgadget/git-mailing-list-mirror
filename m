Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FDCC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 03:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A477722D06
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 03:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgLGDWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 22:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGDWE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 22:22:04 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5652FC0613D0
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 19:21:18 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g185so12310506wmf.3
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 19:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YURBYwusBHrnoW2b8vGFDAo4QIbXqENEpgp5EXoSohg=;
        b=cMXR9qD1UT3/7ke4dti0NNQe4b/ZkAm9tlrpCn+w16dxToP8tIDKSoHqZ6NEUwcoPb
         9WMmAguraZZuIAU9/C/BArRcaXVbPAmVO8NcHq1ExY0U8nZ+GL6ppMWGqEjB+LSSCvnc
         nR3yZRR6jK156rxgVQi8LLzD9EOuZ6FUxitYHICI0U5UZNi3zPODe3u1xKidD3FYppaL
         kVzfw/5KVqlcs1OIxRUfn2mUsVVipZWVh12DBVhvaJd6+mcaeaZl/D06EkaREyUHx0gy
         zG4PnXLRip1YV8ZvMvi/9Ddl3/icbFWVD7M8Xt5280zgnKQ3kmTRM/JRDW6RPCiRGTcW
         OtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YURBYwusBHrnoW2b8vGFDAo4QIbXqENEpgp5EXoSohg=;
        b=JbEMiC/3FmOf8OJKrjrliT25MRyzHd0dLqyq0K56TbiTmlAGMxdRdYm8paRzhg4ykf
         2RMg1tlbfCxZ/5k2QVPQZuBHhGnKzeBLcdYl1FvbW27FutdUVNUUhZ2ZmYVuWEINTk9L
         9UFE6/XyMGXMkw4x5I1Vovon00DLkyQ90RjkGGPPjyLFoCmlfleqSmyxR7rUJ46QYviA
         YRneLOL3K+s/C+GlD0+ejRMPlMKin6czvGzndGO0IzDTt2aOepZz5+zUKe6q798WWahy
         GcEYVrLZqnejkAPNCGArxHOMYV+xND+M364yQ7yLVdx0H9eiWVK7kgUKAccs15Hl9p3g
         6ngA==
X-Gm-Message-State: AOAM532FvMB4Zeq4FOxAXG9ce2bl8bPjyOrV/2m/T47ao11U2tGNPPlq
        QlkxYW+keXdOAqlhx/EcWaNSPOgJZnIlwRzzShA=
X-Google-Smtp-Source: ABdhPJybx7bjy+Tb2YWsaQCR3epLLklO/vLdsymCIVHpr0VPdw+KfKx8ZNvxG81YgWDpXcXo7CdyMv0IfGolHZL6zJE=
X-Received: by 2002:a1c:f619:: with SMTP id w25mr15975627wmc.55.1607311277114;
 Sun, 06 Dec 2020 19:21:17 -0800 (PST)
MIME-Version: 1.0
References: <3e085045-99d5-29ee-ed3f-076b1b8bb6b6@ramsayjones.plus.com>
In-Reply-To: <3e085045-99d5-29ee-ed3f-076b1b8bb6b6@ramsayjones.plus.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 6 Dec 2020 21:21:06 -0600
Message-ID: <CAMP44s3hCm_2=jRv-4knNWe+V5vR_+XWjHVFkVm_LNzJ+n1sDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] Documentation/Makefile: conditionally include ../GIT-VERSION-FILE
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 6, 2020 at 6:35 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>
>
> The 'clean' target is still noticeably slow on cygwin, despite the
> substantial improvement made by the previous patch. For example, the
> second invocation of 'make clean' below:
>
>   $ make clean >/dev/null 2>&1
>   $ make clean
>   ...
>   make[1]: Entering directory '/home/ramsay/git/Documentation'
>   make[2]: Entering directory '/home/ramsay/git'
>   make[2]: 'GIT-VERSION-FILE' is up to date.
>   make[2]: Leaving directory '/home/ramsay/git'
>   ...
>   $
>
> has been timed at 12.364s on my laptop (on old core i5-4200M @ 2.50GHz,
> 8GB RAM, 1TB HDD).
>
> Notice that the 'clean' target is making a nested call to the parent
> Makefile to ensure that the GIT-VERSION-FILE is up-to-date (prior to
> the previous patch, there would have been _two_ such invocations).
> This is to ensure that the $(GIT_VERSION) make variable is set, once
> that file had been included.  However, the 'clean' target does not use
> the $(GIT_VERSION) variable, so this is wasted effort.

Yes, this is the important information: "the 'clean' target does not use
the $(GIT_VERSION) variable". I would feature it at the start of the
commit message.

-- 
Felipe Contreras
