Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A81C4332F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D75061215
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhIUKL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhIUKLx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:11:53 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9FBC0613CF
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:10:21 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id g16so13090808uam.7
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2UpujBOc/tTrXBV5FNjqYiaIVMW3jQS3Te8FFtxiHs=;
        b=LMe/wS7Av5qcBKfTi2Y6F+UoOSSyNyCwToPKPBFS8cRe1tuD2sqKK9TUYUn3CNYWti
         S1Tc+o27OST9LIlJyTlqfE23VD2p+aFSzZI3o4SIHSPTd32FhQ2vIKN/Ij/vaGJv8lC+
         POYKmn7GWWSmSM2aFKdSOSBirka1t6qJRFMsXF2n1E1TUMRHnNqlWJ6jnHFrucquMHdE
         bXiiKccv9PMSQOyQ2Wvy6oUuLX/ANVToDvA3TOAJxX3+VJBtoM6RkfxTNHM6LsNEywQc
         iGah6DpqxQQsYCVSQrWuD8uar5YmF2LE5lFdo7cZgctelYJA/Nv+v9J90W+vN31welhB
         azoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2UpujBOc/tTrXBV5FNjqYiaIVMW3jQS3Te8FFtxiHs=;
        b=Pdqqyd4THCODs/HGxM8yXlOLNbWCcvkfOcMorvxegXPxbSOBEOS8ZIhU4AOywsf3WC
         IMAhlBT7jEkIo+9AxcVe6R5rdsJx4Y6pcb64GyhSlOdUyh3wkVynEX/W/wnzvyv9AwCN
         li2KckMv88QHSKykZkgIni99Ac0L/5Lk+2v7BpDuZ1UEJLbPToxRjOeDYGV1rC7WhLsY
         IWCj66c4Ae/Y2LVSaJhlkGNTuwI9KLba34l9K026D2RzQV9gKd1O9T0JmDayZOpJle2j
         ENkuNaUB5uEcOYlig3wo7LSDw60RUDwl2iTzL4y3Eg/rIhCETcsxyTFqhYXWXchHZOfE
         iIBA==
X-Gm-Message-State: AOAM533wWiqudI/zbxoI3t4y4KGtxVmL38XJJhkeGk7PjG+6Yruvoyr4
        sHQGTRbrmSQsWXanEKqrJCTea0QfCGGf3KTDP5Q=
X-Google-Smtp-Source: ABdhPJwngJx2LbTi8X/QKivYs0FUf4dWQVpFggCsCPKspMVwM+6sLXwRhj+fMZb2mLbw3QU2cExua9l8BZASRgFwnNY=
X-Received: by 2002:ab0:7c4a:: with SMTP id d10mr15334856uaw.138.1632219020112;
 Tue, 21 Sep 2021 03:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq1r5iaj9j.fsf@gitster.g> <87lf3q9u6b.fsf@evledraar.gmail.com>
In-Reply-To: <87lf3q9u6b.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 21 Sep 2021 03:10:09 -0700
Message-ID: <CAPUEspiBP+4Ac4O5ZRTK0N+8PhHeewksrhL=x8TcswrvnS1JOw@mail.gmail.com>
Subject: Re: cb/pedantic-build-for-developers, POSIX-but-not-C99 and -Wno-pedantic-ms-format
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>     -       strbuf_addf(&fmt, "%%s%%s%%s-%%0%1$lud.%%0%1$lud-%%s-%%s-%%s",
>     -                   (unsigned long)tmp.len);
>     +       strbuf_addf(&fmt, "%%s%%s%%s-%%0%lud.%%0%lud-%%s-%%s-%%s",
>     +                   (unsigned long)tmp.len, (unsigned long)tmp.len);

The C standard version seems simpler to me, so I would say this was a
good outcome overall.

> I may be wrong, but I believe that construct is widely portable, we
> don't use it in the main source, but in the po/ files (so anything that
> uses git + gettext tests for this already):
>
>     git grep -P '%\d+\$' -- po

It is not part of ANY C standard, so it will just print gibberish in
systems that don't carry this extension.

FWIW is not supported in Windows, which probably explains why they
don't carry the po files.

Carlo
