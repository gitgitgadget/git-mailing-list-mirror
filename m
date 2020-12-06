Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2BDC433FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 09:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA1022D2A
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 09:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgLFJgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 04:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgLFJgl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 04:36:41 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05693C0613D0
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 01:36:00 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id c7so10432855edv.6
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 01:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TbinPpREgpxgjjdRT27viEniIKMaYCOz4K+R7mLGiI=;
        b=A8dsOLlYuSVpdFmUcQ4+hGG/FWWaDIbbAc7YLk3amjQNW8a52A9XA3dXrjnkxDt+b9
         FjyNnhZEANlLI6OdphZ8ndg+CIHAOI3saCuNH+rnHMtGNM1YbtrrIdTuG4bHUgeF4IZL
         cNToLkxLWjvdELcqVlkKOeWu/DH89e23PYdRyCY258sylZ7KcXH01w5r7++lOpR7VnbH
         tBGoDLjQomZMQUkWLuRHzqYXSobolUT2vkfku3GtARIyziorvgoGm6Dm5oEX171o4Jr7
         cpWeIJz8FD6W+nGFH77QHkW+ttGGyXpkvGaO4ifkdeaJ59VNoD6bMNJOA+I/vfwL5x/W
         ipVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TbinPpREgpxgjjdRT27viEniIKMaYCOz4K+R7mLGiI=;
        b=Ex9hV9kiskgC4/bR4Noe0Y6Wv9LYxpcmFj5oyBU3yXOLappW+XF5M0DTjXvtC8YtIq
         SbbBe50VbUvbgepJstt+UAbOoDlSuPF32G76S/uh7xrNtx+2nXHlVKWiSOZPEo1EmkA6
         6d/tSXn7xERnvDIm8hZI66dIgCb60N8BBgh6okIcHs+aiaX6iWabAvvOM9967Mt6D38M
         FYExmMV57KWo8Y4d4Em3gcHbi1tUB6WVSsu3cKe7P6so6lQh1Qx907loP8MFRIKUK2A+
         KBJMWfPRVxJPbT2NoIpOjpSD1P8hENErWTlfwAaoDtUN/y5fUpmo9DScegvQejiYmvJK
         NZzA==
X-Gm-Message-State: AOAM532Wicljkqd8t6rqAzO/zxWv6gjS4qhPhE1D1yYvz/F0YRhsV383
        Dt3qaT3LkydQBgS56Kk1M8jwGmDMtoXRmNb/AmgjRbQ3UhCGDw==
X-Google-Smtp-Source: ABdhPJyNmdp4jaVDuJ8/Ir6T4L1i2OjSyE1mWmCxHh8TQNHwMaw8JA9cpQ+wgLL0AOCwNYWV77egyhH9I5X006rWgVI=
X-Received: by 2002:a50:af65:: with SMTP id g92mr15144022edd.273.1607247359678;
 Sun, 06 Dec 2020 01:35:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br> <5c993cc27f67109828390c7856d6c03d4a2cbb32.1604521275.git.matheus.bernardino@usp.br>
In-Reply-To: <5c993cc27f67109828390c7856d6c03d4a2cbb32.1604521275.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 6 Dec 2020 10:35:48 +0100
Message-ID: <CAP8UFD1-3YxT42K77Rd-XSRsoXYr_RM8Dj_r8-2GQ0noQw58iQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/19] entry: move conv_attrs lookup up to checkout_entry()
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 9:34 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:

> +       if (topath) {
> +               if (S_ISREG(ce->ce_mode)) {
> +                       convert_attrs(state->istate, &ca_buf, ce->name);
> +                       ca = &ca_buf;
> +               }
> +               return write_entry(ce, topath, ca, state, 1);

We pass `ca` here instead of `&ca_buf` because ca is NULL if we are
not dealing with a regular file. Ok, I think it's indeed better to
pass NULL in this case.

> @@ -517,9 +526,16 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
>                 return 0;
>
>         create_directories(path.buf, path.len, state);
> +
>         if (nr_checkouts)
>                 (*nr_checkouts)++;
> -       return write_entry(ce, path.buf, state, 0);
> +
> +       if (S_ISREG(ce->ce_mode)) {
> +               convert_attrs(state->istate, &ca_buf, ce->name);
> +               ca = &ca_buf;
> +       }
> +
> +       return write_entry(ce, path.buf, NULL, state, 0);

I am not sure why NULL is passed here though instead of `ca`.

The following comment is added in front of write_entry():

+/* Note: ca is used (and required) iff the entry refers to a regular file. */

So I would think that `ca` should be passed.
