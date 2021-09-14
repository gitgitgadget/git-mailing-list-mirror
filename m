Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57DDC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A04C60EB6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhINTDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhINTDk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:03:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38918C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 12:02:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 18so193036pfh.9
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mesbUHJlrYnKkHvYSwO5rBa+Rckhk2wGkL8lGrK0vtU=;
        b=VfBcujcFt1/kVb7aGlmXRSELa6ZMBki4ZOrpyRw6sNsV4hNLhxkh6n13w/kk6B9Gxp
         uaNwnfQ1ynKOkOGnnYCvO9yNugBAFeF40DhBDtYt3RxSbFBXGzVt6t8spLr4w+AwgtF3
         bQo0o7IdbGVIG3+DXsWnOGW/l2ocdg4vIQ4hpS0DhWyoNpgMos6G6G0I5ayEGKabVqfA
         7m8Cks0I3+l21u9pBgfvPKbhVO5FhQJIGtBD2crq6SqCa/xwKOBpn1U6N2T+mNMGGpy1
         hcTRok+AuQp4SZ+Y0cRID2vdAVkH7Y/DM14zGtTHfyprEio4XdN/wSDxAucW9VHnvg8h
         lSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mesbUHJlrYnKkHvYSwO5rBa+Rckhk2wGkL8lGrK0vtU=;
        b=KydMSixKaIi5jx1mTXLNVnm2dSoegI3vj1NQNhp5qzmEQF0oQx0v863F5AwLNGTDGb
         hTdsDqBaolpYRfLz/xSco//W3lvfuv8Tb/bpz44tkcIk9PUqqMU1DO7zyx4eQGiIP6mZ
         XgcRir7ERGkDtdqPep7tfeHW6THm/FeNOaRAMUMOkoW4cl+xT9dMMY8QxWVZbdlBLSCk
         XyqmfYwZqKzEThZBDatz6BSkMof0yVYZPmcqGrmOBiNonZ6EHB927nISKfkttRdrOpcn
         1G9WNyXwktTcnhQ4MmY3A1HzVcoREdjjmXp6RuLtDQKcw2WF5/q/MLIuBo0ohPKd7jpB
         /TQA==
X-Gm-Message-State: AOAM532pGJcx/JOje+WgXQ+6+BDba4r6V3dJo+N7g2uFUY/nrPeLZiMC
        ZGfqxNpcCv9KZqhImb957bfEl83seiO1lu1bySc=
X-Google-Smtp-Source: ABdhPJxFiswFioqbgMF5KCFhSfxnaOvzWq/F0wHdKNXEewsjO9tLwOfzI6nA/T6rN61hMBpAWO3erzcqmWPdyZJKL+I=
X-Received: by 2002:a63:e510:: with SMTP id r16mr16855032pgh.34.1631646142733;
 Tue, 14 Sep 2021 12:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net> <YUDAtbHcbv6zNFxe@coredump.intra.peff.net>
In-Reply-To: <YUDAtbHcbv6zNFxe@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 14 Sep 2021 21:02:10 +0200
Message-ID: <CAN0heSrCibpcU0NXfZfJvb7puRVLPRz2qEbko6+SEh_BcKtgvA@mail.gmail.com>
Subject: Re: [PATCH 5/9] serve: provide "receive" function for session-id capability
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Sept 2021 at 17:34, Jeff King <peff@peff.net> wrote:
>
> Rather than pulling the session-id string from the list of collected
> capabilities, we can handle it as soon as we receive it. This gets us
> closer to dropping the collected list entirely.

Looking good.

> As this removes the last caller of the static has_capability(), we can
> remove it, as well (and in fact we must to avoid -Wunused-function
> complaining).

> I had originally dropped has_capability() in a separate patch, to keep
> this one more readable. That breaks bisectability, but only with
> -Werror. I'm not sure where we should fall on that spectrum (I generally
> bisect with -Wno-error just because warnings may come and go when
> working with different compilers than what was normal at the time).
>
> Not that big a deal either way for this patch, but I wonder if people
> have opinions in general.

First of all, agreed about the "not that big a deal" part. Just a random
thought: You could do the opposite of what Elijah sometimes does by
first adding a "MAYBE_UNUSED" function, then actually using it. You'd
add "MAYBE_UNUSED" here, then the next commit would drop the whole
thing. It could be worth it if you're removing many many lines so that
the "actual" change gets lost in the noise. But this patch isn't near
any such threshold, IMHO (if there even is such a "threshold").

> +static void session_id_receive(struct repository *r,
> +                              const char *client_sid)
> +{
> +       if (!client_sid)
> +               client_sid = "";
> +       trace2_data_string("transfer", NULL, "client-sid", client_sid);
> +}

Handling NULL. Nice. :)


Martin
