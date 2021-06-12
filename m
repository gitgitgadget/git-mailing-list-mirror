Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05102C48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 23:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D942D611C2
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 23:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhFLXMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 19:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLXMe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 19:12:34 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F44C061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 16:10:17 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id b74so7869891yba.6
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 16:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2S4vZ7T4RGHklP0XM1JY40b91rlYvilH2YYAIjO8LE=;
        b=rjaa6Oc1KrIlRi8pMizz48BEQ0EXpcFRTvaoM1Lb66XnzxxXufh8ExVsKRtDpa1HA+
         JsYnJebON2yqJAjKMGD94c6imUeIDZeZK5i2PMUBLrOcQ0+tB5/dqRISj3oDhchgSlbg
         VAt3gmnZ7DVjLmRZyWTZgiUcLnmSnoFAtNkvJLyaQyQYgGeWHqHvACyySvroI7U0Q8P3
         b2kULFRJb4FTUiwqo5pFnoBr2DzIT0qtyQ5pLi6nOxiQ6WIw68W3ul+95aGYwNQVmfMn
         d0//kOwVreu3LTDVFIB3VFcJ57x6Sj+zrtUoKSX2asFfGbUmgOXSguJD4SNvaDkeJsM5
         ft/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2S4vZ7T4RGHklP0XM1JY40b91rlYvilH2YYAIjO8LE=;
        b=J7aovRC9Zq4dBsHihLI8G25uLIHEUhUE1LIpveaypnoLlGJx7kt0XjuBRO9wruPzR3
         uBFC/yfIYLctguuDX7NKe/INcPToVg40DqzcjZR/wOa6709Wv2fHCbcXXrQko3GmjFAt
         xR8U3Dep35UOMAeflMHzkLpaqQLeNBVv/JORrWtdNhkDXOzAkGyN9qpDgIag7iuQS34e
         sPOGszj+ldESqdzjHk5oyJ+Ixjy7GWa1/U4iwSVxW4GVBmbc5hBOB/bHOFTNTTYTn7lp
         jP2X2roIeR69cZqdTt7jeBvmgI4aLYBA1gvXqCA/98wTyQP+QisALpsFRL4qJqAWTF5E
         YEXA==
X-Gm-Message-State: AOAM5330yCt+Huu1uuipIfKQ+I9/3ZzrFJoC+DtcCCmm9WFcLOqa4HIq
        +kXLwOMyjO0fYpajw5BpdAQH1M9O8nYgvx5h6ug=
X-Google-Smtp-Source: ABdhPJzd91FXVgdgxR4Co/JEBvrC/nCBoaLf5HgMFToRLc30xaaBPrcDOGAPsQIiYFpCNNXQf54cg+DIy0bUUdemCGs=
X-Received: by 2002:a25:74c9:: with SMTP id p192mr14669425ybc.503.1623539416912;
 Sat, 12 Jun 2021 16:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <8d3f8cf4-24ec-1271-ccd3-70db24f53523@gmail.com>
In-Reply-To: <8d3f8cf4-24ec-1271-ccd3-70db24f53523@gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Sat, 12 Jun 2021 16:10:04 -0700
Message-ID: <CABURp0pUDtKEDcFx+Yh3hZRXnHOzUxiOEU=epBz3SB1O5e2HqA@mail.gmail.com>
Subject: Re: Wrong tabs in terminal output for git diff
To:     Timothy Madden <terminatorul@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 11, 2021 at 12:30 PM Timothy Madden <terminatorul@gmail.com> wrote:
> For git diff and git show commands, terminal output appears with wrong
> tab stops (missaligned).
>
> Because diff operation inserts a new column at character position 1, for
> the +, - and space characters, the diff content appears shifted to the
> right by 1 column. But not the tab stop positions. So relative to the
> text, the tab stops now appear off-by-one (shifted to the left).

I think "fixing" this would require modifying the diff output so it
would no longer be correct. If we accept that a switch can make a
incorrect diff for display only, though, it seems something could be
done here.

I think the only approach that can fix the alignment, however, is to
remove the +/- prefix markers altogether.  We do this now with the
`--color-words` switch. This kind of solution only works if there is
some way to indicate added/removed lines other than the line-prefix
marker; ANSI color codes, for example.  Would that work for your
needs, or were you thinking of something else?
