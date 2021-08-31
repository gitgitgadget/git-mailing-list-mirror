Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D74C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 23:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E58E60EE3
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 23:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhHaX4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 19:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhHaX4B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 19:56:01 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8CEC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 16:55:05 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id s4so387276uar.5
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 16:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YhnsmJtxtyOYBHSHLlt2M9RKAQrfrpRJSlDb6ocHLoM=;
        b=Fv0EzKYuzyFatVuj0jSDQcomdy/m5IKdmuIJe0cdFyWC8VbYsJ8PzazsOnJFJNh3ED
         ZzLmaMNUOR2JF2pgZgUg4YU6O7bE7bC4z6J1EAhvecfmXgROd22IT+uZTzNMw4My2WQ4
         ec9LvP5my5GNTPlQz5z0fyAN4RuztK0eK2CFhsJr5Zs32HmEkF0g7GL/emgryEHMWKbb
         MvKYl7XzB6zWpHwpf8B3+2jKGE950euLzHwdVtNGTrjkIkMgDnNVlr+CjSxJGsexvryP
         FTe/5ayCX6YZgRFCM+PCcZA1VC0UbloJgbkCmKCWsWGNLGpQLcBpwLgzcM3bNYSzR7/F
         qlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YhnsmJtxtyOYBHSHLlt2M9RKAQrfrpRJSlDb6ocHLoM=;
        b=K34orMbUwLolml38VvDADBtg5q/NcjFOi12fORJRmAEzd7gg+EQQSpxd5+b8ZDf+OK
         TQi5BiO87Qa+eGQwEQ9W2qlWu0y8fwN9J0NVJAwkihukKR8H/IMHFmhFQ+YX2x7mldpJ
         POcraN+QlyRyEf3n5YpbL0GfFZi8Mlgy2iQSdqb+6XDCJM8keTUQyHPOuYBZx6rxTuIH
         EcZ/kLxzOdL9a91jo03KBZ9/BanBWFTlB3cPiorS2ODDl2XeYCzXI9H8Sg+eNnJknI3l
         OoZ9c7z0ym7oTTRGH4S8EV0rkQCaHskTILigRgt4BCQJ/23hoGTcyPO/glOFXWEGy6/O
         DiFg==
X-Gm-Message-State: AOAM531cZMpGz2pNDOWEEgeUYyEFlOTnf6ASBAYD1WctRDkdzLGyLqR7
        wyvFfcYAKUL7UvAQgQuafg4qoRHREkcPpf2GEis=
X-Google-Smtp-Source: ABdhPJxjYHv6/NEZL4GpXekjGtnBPuHXDmDsawfebyA02OSnMXitO6JVwFDMcX2C7iowqDngIvlQROIJjwnDBrJ095I=
X-Received: by 2002:ab0:3418:: with SMTP id z24mr21180944uap.96.1630454104876;
 Tue, 31 Aug 2021 16:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com> <20210809013833.58110-4-carenas@gmail.com>
 <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com> <87zgszxirn.fsf@evledraar.gmail.com>
 <CAPUEspj43=z8nSdh8UAiqZ+UR8UAZkSsQr1WviGtasQ7d-fHTQ@mail.gmail.com> <87bl5dwcx0.fsf@evledraar.gmail.com>
In-Reply-To: <87bl5dwcx0.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 31 Aug 2021 16:54:52 -0700
Message-ID: <CAPUEsphbUHgt09A2qdy-5U0L1y13pkeNjBEUbjkE6JOPeqDVMA@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub workflow
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org, e@80x24.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 1:57 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On the other hand maybe we should just remove
> USE_PARENS_AROUND_GETTEXT_N entirely, i.e. always use the parens.

that would break pedantic in all versions of gcc since it is a GNU
extension and is not valid in any C standard.
(unlike the ones we are using with weather balloons and that are valid C99)

the C standard says arrays can be initialized by a string literal
(obviously with quotes) and allows only optional {} which would avoid
the accidental concatenation that triggered this, but can't be used as
an alternative.

> It doesn't seem worth the effort to forever maintain this special case
> and use CI resources etc. to catch what was effectively a one-off typo.

under that argument, removing this safeguard might be also possible.

Carlo
