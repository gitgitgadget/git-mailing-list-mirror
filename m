Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307C5C433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB25764EAF
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBSGeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 01:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBSGeN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 01:34:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF96C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:33:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id ba1so2829597plb.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBgs6OCs6dV2vEL1Go2m5RgZfrnSeLlmIX32ojvT6J8=;
        b=N47MVZ9He3kReb2XMdgbQYTtVA7khxFzUXou1fG7rMh1PaXKynbyiRV7Tl0ZO4d3aQ
         3sJ3Os7xK5hg8WDrSutV8SQcTkAeRLFvkl6u3T01qC/L0+0aKk4xznvsNR7whhnSuROq
         Y6pvaS6zAfFlosYddHV4ClgWU5elw8xSM/XX0Jqx9n0mIgnQOo2ECW+UCTA/clTROV3U
         MDtNt6V0ynj7+R5TD6xczTim09gyTW22J2friDtQC6XwcHmEOs6pYBtoi6eJjum8S7Ai
         WhIK3ctALEWp8wP2IhJhGktNODYMzVPvzaJ4Vxiuo0ml0dukiG8iQI/fZufyN9flTLEp
         07Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBgs6OCs6dV2vEL1Go2m5RgZfrnSeLlmIX32ojvT6J8=;
        b=h71Q8k9q/yukuAhEoNJpxJ2Yt1U+Hi5HHnKC1T6UFRj2nIOeqGjdVlxTogU9idZW9u
         68qqwXLnNcghM4yPx437uyx/q5pIL4G82cWkg2camHFUHJ3BlHI4vBPKCH9bojF83Lmq
         yqpQVWE6VsaIVML2pIaR9g91iTklOzekM4Uq4y8Oq832tDi5d/j44+e/ajS1WYNbhrO3
         x6s4cnNQihSiasgbGgc4mXC7WurUomsjz3wCsXDvcoC7E8mPQrrOlp4QYZ8fAER7oKvd
         8/UDryvl8h6axiFHKQUXy0kaYd4Es29oAgylIV0KJ6jELi8stSbi23ENt3Tk8Q5lP8Kd
         ItOA==
X-Gm-Message-State: AOAM531FOGC2FzS1sr4JvksnCvckv8c9Ay3OAsx/mqQ9hdDCXRZTC2MH
        7D9Yn0iyDJd24XSsH1lCxvlXKiHCtVUJW5PTCzQ=
X-Google-Smtp-Source: ABdhPJwLn103vqJHnSZaLYpuUAUmCuZbtmi7mKkby4Gcr+68z0EFHTgIP14PWlEihU9+UZ5Y6fYIx5SOBqqo46gt20Y=
X-Received: by 2002:a17:902:bc87:b029:e3:aae4:3188 with SMTP id
 bb7-20020a170902bc87b02900e3aae43188mr5772025plb.56.1613716413111; Thu, 18
 Feb 2021 22:33:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613590761.git.martin.agren@gmail.com> <97c686dd7ba1bbd1c0be6f7f61a3a033adf8adb6.1613590761.git.martin.agren@gmail.com>
 <xmqqim6pgqev.fsf@gitster.g>
In-Reply-To: <xmqqim6pgqev.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 19 Feb 2021 07:33:22 +0100
Message-ID: <CAN0heSp_Jc6x-xNqt4uSPHi17GwuVtcOEStxe66MAD-6h1cyhg@mail.gmail.com>
Subject: Re: [PATCH 2/3] git.txt: fix monospace rendering
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Feb 2021 at 19:51, Junio C Hamano <gitster@pobox.com> wrote:
>
> The "two" diffs may indeed be misleading.
>
> The patch only changes one source and the "supporting material" is
> not something that we need to use on the source file---it is only
> showing the change in the output.
>
> I did appreciate the inclusion of doc-diff myself, but it seems that
> it confused Chris and Patrick.  I doubt that it is an improvement to
> omit doc-diff.  We may want to find a way to make it easier for the
> readers to tell which part is the patch to be applied and which part
> is not in similar changes we discuss on the list in the future, and
> apparently, a one column indentation alone was not quite sufficient
> in this case.  Replacing "doc-diff:" label and patch header lines up
> to the hunk header with a prose to explain what the intended diff is
> may have helped, e.g.

Glad to know you found the included doc-diff useful. Thanks for the
suggestion on how to present it. Next time I'll try wrapping the
doc-diff in English prose to make it stand out more. The "doc-diff:" I
used now was definitely a bit too subtle.

Thanks
Martin
