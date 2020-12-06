Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239F7C4167B
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 10:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC9523122
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 10:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgLFKDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 05:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgLFKDo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 05:03:44 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836F2C061A4F
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 02:03:04 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id d17so15115995ejy.9
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 02:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Q+gFjFjaaTIrOY7dCj+1Tp3M8uYJIxgo6hvk6E8crA=;
        b=qtiTbDK1lWHlMT0aigNUr/KLUfC6gT2oL/hR7MFiihRT29bvweFGbhh7gMeFCHvgF2
         G2eEKQRDK8f06S3yTTbmW9IAC9ev4GcnJ9YqDPpMVmqUYEAHMTrFsDIJ9AIXm/iBHyTA
         1H6+WqNDzourhzq46Yx1G0q3iYu6gJEj/Hyw5hLFHc5YpIAJ/iTjtnUvJeXqc8V4kHoc
         zLnVi/Yh5ifIT3qOuz/rilUmXtMtbWGACnZo6nEE4+yLZSkIL9uIKzeYhO09kSbNpnUl
         h1xrGI4ktCIRZ0/1RTvwvhY9LYJ32faYs2f1nOz9PigFSihOuj3vh4wEHEmelje+VGmC
         CMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Q+gFjFjaaTIrOY7dCj+1Tp3M8uYJIxgo6hvk6E8crA=;
        b=JMnuifgsKsSLv6YA67I5NAlb3GgxFxpNY0cVdFikj85knq4BwHq1KizrFz5o7R2rk7
         oK3MHX0pMPVNmRf5zv4x/LB9Htx3AG0SyrBL6xmxyVhQw8XWTBfud+V7/C/Uv19OjBa5
         iFk5VWvqOS9JzZeVb3BQhwineuZEjiwNGs9ZZZgwrFxg/58Ck41OCfR4hLH7u+odbvY/
         fb3DvskzUIUPysrXwRQyaLk8wAMJs7HkPz01JXiA9+roDp/8lLBKlZUlX8hC9QlO81q/
         K2e2uSeP/gBwdcTdWan+vj8aJIr2IM442zDg37gw995S/gJEKbxxJSrggz0WQoua0eYd
         qRyQ==
X-Gm-Message-State: AOAM532piQp66gTdmVMNLWQjFquTeA1L78qqy2jpN1kKuks+jjUyR2xQ
        61Sf/GgOqq5eY8jncm7xkfja32K9l4NsFh13ogblxDy+ruRjAQ==
X-Google-Smtp-Source: ABdhPJzEOXumLcMc/+QcwkKb7OTnjIfsz1rpbNLnyFgnpKcd41PVZrrUEWH1L2hbGQc/iSOPHKVIMSPkCl2OUPK/T8Y=
X-Received: by 2002:a17:906:ae0c:: with SMTP id le12mr14591525ejb.283.1607248983309;
 Sun, 06 Dec 2020 02:03:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br> <aa635bda21c43e0d82ce21e791df280ee6231d43.1604521275.git.matheus.bernardino@usp.br>
In-Reply-To: <aa635bda21c43e0d82ce21e791df280ee6231d43.1604521275.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 6 Dec 2020 11:02:51 +0100
Message-ID: <CAP8UFD3SpzGbkeBas+yDEjDgtDiTdztD=6fMfG=8rHKN5B6kCQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/19] entry: add checkout_entry_ca() which takes
 preloaded conv_attrs
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

The title might be a bit shorter with: s/which takes/taking/ or
s/which takes/using/

> @@ -530,12 +531,12 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
>         if (nr_checkouts)
>                 (*nr_checkouts)++;
>
> -       if (S_ISREG(ce->ce_mode)) {
> +       if (S_ISREG(ce->ce_mode) && !ca) {
>                 convert_attrs(state->istate, &ca_buf, ce->name);
>                 ca = &ca_buf;
>         }

I wonder if it's possible to avoid repeating the above 4 lines twice
in this function.

> -       return write_entry(ce, path.buf, NULL, state, 0);
> +       return write_entry(ce, path.buf, ca, state, 0);

It's good that ca is eventually passed here, but it might belong to
the previous patch.

> -int checkout_entry(struct cache_entry *ce, const struct checkout *state,
> -                  char *topath, int *nr_checkouts);
> +#define checkout_entry(ce, state, topath, nr_checkouts) \
> +               checkout_entry_ca(ce, NULL, state, topath, nr_checkouts)

I thought that we prefer inline functions over macros when possible.
