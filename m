Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A568C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBB921744
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTNjEH9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgGaUnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgGaUnp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:43:45 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DECC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:43:45 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 125so2366668vsg.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hn42SDabsTSQCfxY4tasqYQWbK6EABiOLiqcauAgSKo=;
        b=tTNjEH9e6FDwSSJri8+lYxIudB29tR9KdQE1R77SMoW4A3DYnBw1qAPbJknrxZ0DLw
         VggfxccmAcSP1gxXoxwKKuK3NCb84lMCyf7mKIPyyIZUj6zo/JnjlGmmIfUU21iMjWcM
         Nyulu8pl58wxzlzBZJGC3vig2blWw7fum0Qjs1u08Ru6hY0MXDIGiYuyM1CdWlBZFwIu
         NwcunNHQWenoBalmUIQeyEHQ/tbrVe+1bo23MaSpjpdmROAque3MdbpIhCTuNReEVcdz
         hqdZIDYDmwMBgHj3MAnjVo+Ge2y1yVhmT0G0hFGO+FkiUtzqh644PK1Tzlcx/9vkAcH6
         gsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hn42SDabsTSQCfxY4tasqYQWbK6EABiOLiqcauAgSKo=;
        b=a2ETabvH/IOdiFkAWpvFDAickrWnJFuVaw5Kn/DWGgIyV0G3nkgdCAhHtmuekA/4Ha
         y+6vQBzjruhIUyY/ZcewC08PdQUngKJGJFdIs34jryTbnUEVjrezFyoPmiG9RjjspUwq
         mvwvTclNYKvGhSCbpPkUyV1xdn1h+u7XDlfPjxl+XNyHp2MHhTruBcdPjwgInIA8vMAl
         gFFFdazyRERy/MjIQpFpT2ccvYGfBIW3zai1JA04UlELoJzLQB8K7grQgPw6x7Iz75dY
         1BaHLO67+YfQzFFVLYmzFf6Ky6Y2XW8Nx7isYm5/VqpLurrjKQgxT2L5wWcMB2fA/jMM
         TkPw==
X-Gm-Message-State: AOAM533iDudBKugNhw1MyG6T4nOLU6G/XDHK5q1QUFhafNazngp7I6tQ
        wECdizPd20Ww0UKZ1p+JZxX0y0C4lYNYuQ/0kFE=
X-Google-Smtp-Source: ABdhPJyISOkntmRgb49RQF/0xhvGWVa1E47dfdLwOKxi2x/UOm8BjLdLEcaIMZNHHmRtfwodSTT4UdB0x8Ah5COiD/k=
X-Received: by 2002:a67:f3cd:: with SMTP id j13mr4626803vsn.40.1596228224388;
 Fri, 31 Jul 2020 13:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOjrSZtQPQ8Xxuz+7SGykR8Q-gFDEZANSE5yQASqKjpbUAq_5Q@mail.gmail.com>
 <20200731174149.GB843002@coredump.intra.peff.net> <CAOjrSZskJRj+TVV35fEp-Mhd+proVV72rh3vAcVFnNfhRy2ayA@mail.gmail.com>
 <xmqqeeor300w.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeeor300w.fsf@gitster.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Fri, 31 Jul 2020 16:43:33 -0400
Message-ID: <CAOjrSZu7-KxgoxNTWiYF+_suDMo6S808L6iRWvK0HYZT8rqN7A@mail.gmail.com>
Subject: Re: Diff --stat for files that differ only in whitespace
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 4:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>
> After re-reading the thread, I think it takes a bit more than just
> re-reading and testing, because even the author of the patch said
> (and I think I still agree with the assessment) that the patch does
> one thing that is not exactly what we want it to do.  So we'd need
> to tweak it more to do what we want to do, I would suspect.

Got it, I'll try to look into this more over the weekend then if there's
no problems with that

-- 
Matthew Rogers
