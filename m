Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18C6C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF2460C4C
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhJKUjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhJKUjh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:39:37 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D80DC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:37:37 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id z202so8051741vkd.1
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NQPVaIUQvzxeGCrdwl2cVQrYAlAU+ey7PKCLPra3GuE=;
        b=T3p50wnkeZLV2Dv8EnqFBuUHeNi94+8QZvKR6P8BgWvfcEb0Ws1HfPegFi6wcgoud/
         A+BLON7xpO1K5EqAaJ641Foi8DoRsZHxZWbFOY+Px0migY/6ovlGM2KiwTm3afpTGjN9
         W1Wv6kI8yUW2KRCBuE/OdOBuDy0y5g9hoV19QSRq1tf2WPjuICGxVDp9dxbye63fvH7a
         gawFxjGaO1z6DmBbmcENUY2GlWO1mRJa1Hem5YGGxgSaag6pk5f9K7/lPaQSbvmWTLB/
         pvtWKQpazJUvSuD0EPr86rbRraNFCJRlAFGsb8M5GxFBq23CWn98NE1vGiA0s2CvfPO0
         ZV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NQPVaIUQvzxeGCrdwl2cVQrYAlAU+ey7PKCLPra3GuE=;
        b=vi2Mq3cprVyxffdFH4U0K8rFJ2NLO9TXVAqm1brEeS5Gc96j1bIQMN3UWl60gCuazm
         lqp1lEFw5JnciNumkuZ5dBtAa16WG/kH+DmkODKroNV26zh1FXUdXrWCoAWvVZqU97tk
         YBVt5G3dpqsyhKj4qVVk7CWhKiZsfFOJ0ny/lUQd0c6j4u54excLUWM0dCuG8+TVlcAw
         ejSlMjjqunDVFU39iXIcdu+nydxmZ45QT6FAhafbCt2BdrMf75VgSP6DiO4pDOy8ZUpb
         i0Eo1tZmibYARCRQudIJcUSagNfk0xep1D5eF8FUyOEGaS/LOK6zGTKZkWveVzTmQ3tX
         uWXw==
X-Gm-Message-State: AOAM530r3hA775+Dy62CDw3mdDVjdiWeyXIEUkKm3/M9OQvbdPAqCox2
        XC3dd3Zb1/VSdXXrHQLukVAzhVH6zDM5aXTQGHpouyfYCwg=
X-Google-Smtp-Source: ABdhPJz8LtAIkPnY9jjMAlkTf+9BNyobYmw7Ou+Quml/nA5ni4ChKBExH79mxaGzcUBdBXQ4Z/COWiKwH7Ibg4oBpSs=
X-Received: by 2002:a1f:b44f:: with SMTP id d76mr22210134vkf.25.1633984656388;
 Mon, 11 Oct 2021 13:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211011114723.204-1-carenas@gmail.com> <20211011195550.3355-1-carenas@gmail.com>
 <CAPig+cQi_baTaV+Z=UJcrwS+C1dYnQ6bKEA-Bcim2VUOu8VGJA@mail.gmail.com>
In-Reply-To: <CAPig+cQi_baTaV+Z=UJcrwS+C1dYnQ6bKEA-Bcim2VUOu8VGJA@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 11 Oct 2021 13:37:25 -0700
Message-ID: <CAPUEspha9Ymxaqp17JA5DaftvxeU_XmTZs089D1zb9WidYn+Pg@mail.gmail.com>
Subject: Re: [PATCH] gitk: avoid hardcoded 40 character length for oid
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Rostislav Krasny <rosti.bsd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 1:04 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Mon, Oct 11, 2021 at 3:56 PM Carlo Marcelo Arenas Bel=C3=B3n
> > diff --git a/gitk b/gitk
> > @@ -12338,6 +12347,18 @@ catch {
> > +if {![catch {exec git config --get extensions.objectformat} oid_type]
> > +    && $oid_type eq "sha256" } {
> > +    set oid_size 64
> > +} else {
> > +    set oid_type "sha1"
> > +    set oid_size 40
> > +}
>
> Should this be using:
>
>     git rev-parse --show-object-format
>
> rather than `git-config`?

definitely a better fit, will be included in the next version.

Carlo
