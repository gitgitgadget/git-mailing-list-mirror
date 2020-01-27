Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F797C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 13:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DE3207FD
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 13:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="k/MkL9tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgA0NxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:53:08 -0500
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:39485 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgA0NxI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Jan 2020 08:53:08 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id w4p4iLYf3T6sRw4p8i8EKX; Mon, 27 Jan 2020 14:53:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1580133186; bh=dJhfqijYXOL+5rygYcgBZrfTarKr8h+kZ6l22ZVbpf8=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:From:
         Subject;
        b=k/MkL9tZMfpLMnZba+MOdyr4SUxh/NwKpPRa6WfP0cqgHqWFoxQ0EGnyh1VPzKnSV
         mNG9Fjwlh/1g0eHdZTwyFZ9svdidJalJo33Clrfxk9Cx5ms8N4hIS2xd7ut4MDYe/L
         bjaKBgKl5PUxd/zsji49p1okyy+Hrt6N9FssFFmex1tyXVswYo5lCmjpca8lR1G3Mf
         SzN21Cyw1HEnaASv9888eWcfOeNxrlywgKih3mwQ4KtI9RlAQ/IVep3wvtrwbhJ9Qs
         C+b2opojHKe31p8HZTcF1W9S2KsK3EnP0RU+jAcrJXIrmom/YT0QPowLALrWKyu8LQ
         0ti4H2TBRYpRA==
Received: by mail-oi1-f170.google.com with SMTP id p125so6657560oif.10
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 05:53:06 -0800 (PST)
X-Gm-Message-State: APjAAAXY4asY4ikKWUeNZuAd0han/87KPWY0mpFUBlombkLVVGW2LwzK
        LsEiYJ8a28oEarhhGHlsG0lpKbf4YYD5RMePsbg=
X-Google-Smtp-Source: APXvYqwI4BgmfiOwFz0W5WJna+kUVy2Ov6yLqqk9WrBknd7J/2CxinFP/K8T4TwjPGkiVxHlAK4j1mBhXt+DiFx+lPM=
X-Received: by 2002:aca:5795:: with SMTP id l143mr4731078oib.27.1580133182612;
 Mon, 27 Jan 2020 05:53:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com> <xmqqy2tx3l1y.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2tx3l1y.fsf@gitster-ct.c.googlers.com>
Reply-To: hanwenn@gmail.com
From:   Han-Wen Nienhuys <hanwen@xs4all.nl>
Date:   Mon, 27 Jan 2020 14:52:51 +0100
X-Gmail-Original-Message-ID: <CAOw_e7Y7w2Az65iuzWT5SHLv+iHwFZ=ZE11TFS=m0Vh59M2a=A@mail.gmail.com>
Message-ID: <CAOw_e7Y7w2Az65iuzWT5SHLv+iHwFZ=ZE11TFS=m0Vh59M2a=A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reftable support git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4wfNApmtif4p+qFNZz/49Me0CF4F2g6ahxiCW7UC/0rKUsxSH/6CQG0myvMbGhbQhm13SNRSMyee1jvN05qZ5nKDGkDkeM2z1M9m5q5pBDJW/P2jzc402I
 5hhEbr5duGqNJ0aC8VbXqe8GUkEFwyIllPsAuXLroKDilB2bU80KjuxTQDvTwRiuLqBpB6F3VW7PQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 10:44 PM Junio C Hamano <gitster@pobox.com> wrote:
> > This adds the reftable library, and hooks it up as a ref backend.
>
> Just a quick impression before getting into details of individual
> steps.
>
>  * With this series, the reftable backend seems to take over as the
>    default and only backend.  We would need to design and decide how
>    repositories would specify which backend it uses (I personally do
>    not think we need to allow more than one backend to be active at
>    the same time) before we take this series out of RFC status.

Yes, obviously. Would you have concrete ideas on how this should work?

>  * What's reftable/VERSION file?  Does it really have what you
>    intended to add?

Fixed, and explained in reftable/VERSION.

>  * Mixed indentation and many whitespace breakages make the code
>    distracting to review.

Do you mean in the changes to refs/reftable-backend.c? Or the imported code?

The imported code is uniformly formatted with clang-format.

Is there a clang-format setting for uniformly formatting to Linux/Git
style? I really love automated formatting, so we don't have to spend
time debating irrelevant details.


>
>  * Comparison with 0 is written as "if (!strcmp(a, b))" in this
>    codebase, and never "if (0 != strcmp(a, b))".
>
>  * We unfortunately do not use var defn "for (int i = 0; ..." yet.
>
>  * We do not use // comments.
>

fixed.
