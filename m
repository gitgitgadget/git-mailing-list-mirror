Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AEEC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 12:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiI3Mgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 08:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiI3Mgq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 08:36:46 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32D9A3461
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 05:36:45 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c9so5062659ybf.5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vL/J7nSyLUzYzzOtXEeKdVDQfae5dxckAE65yEn6SLU=;
        b=YxOf0yAJU0BnVN5C02NydiLQtOfiRRrkNr5NtJEzkk2qCnIeKhxJIqgGzgXwwuA7zD
         IyOX6JU0hEl/QcpM3Mqop2YPfPGh8/99V/8tEImnjeesmRw4U7opVxs4VfFpUIYAdFCv
         eRKDGkMxQEFjNVAwpQ3Dyiz8sDdE0xF8TxUUMwfOy1r3vLArjsG4Aj4tO1uy1sc/dW1p
         it95cff2CURLWuPMj+mzRD6jEY0cpX5wKAM6eruYcDXvpu76yzYIfyob5ShHnWxQ53BU
         /isb/M3Ptqe74WcVw6ddKGtW9VqHgNMwyzYJy9vL4iL0d88lcZlTsqd+qRvWsQrRRJUj
         xGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vL/J7nSyLUzYzzOtXEeKdVDQfae5dxckAE65yEn6SLU=;
        b=pX17YHs1HEsk9kcZYfcwrkGk6Psw+nPQ5gQxFUMdMcvm0ZMkaQOEXKsiTpExB54NuV
         4SYHA1Kl2Wks7ow45YQTLME/cf/24XV8DC7JqJ3ngG+012SjfALNMhzomLs5eNEr1nZW
         72POuoMawyFhhqaab8yJhFR6SYnZ9pLKzEHP3w1lNqbSYBUFwoNsowEGY2PvZyMnbTM3
         TVTdv4+si8bRzW1DsI48TxK7FjoC2mswzgVsY1slVARbtf1imUXaHNck20xB2TQ8zxAd
         Vw6W3iYVXj0QCiGQwL+i3Re/RjQMQF79dQ6pI8OEo+6xZvdFTHxzf8ChP10Z15vL24yK
         YjWA==
X-Gm-Message-State: ACrzQf3UCcO3H7gzdnHjwkXlUn3OaxtoTW+M4Pf0icaP3EUx3107/IJt
        c1J5atGrQMzz0RhJoumM8Fpxf7VedNwc3j04DpI=
X-Google-Smtp-Source: AMsMyM79+AcaM4c5yAHU8gI0L3DwzfOFHqYfTjjR582tuBgVem7mtDxk9P9ic77gl4SKkiePhNaNPi9TDpf+AFyUpZ0=
X-Received: by 2002:a25:4441:0:b0:6ba:51bf:5ce3 with SMTP id
 r62-20020a254441000000b006ba51bf5ce3mr8282370yba.494.1664541405023; Fri, 30
 Sep 2022 05:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD2pG7f5-9eywHE4ziz7OKLZ_A9AnNnQEQvdvOTYvsdP+A@mail.gmail.com>
 <YzY7XWHyI8waS1vd@nand.local>
In-Reply-To: <YzY7XWHyI8waS1vd@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 30 Sep 2022 14:36:33 +0200
Message-ID: <CAP8UFD0XfV0sm=CWMGZreUmiMp-VvnzwH7kHk0GwaOq6TfH9dA@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 91
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tim Hockin <thockin@google.com>,
        Bruno Brito <bruno@git-tower.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2022 at 2:42 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Sep 29, 2022 at 05:51:58PM +0200, Christian Couder wrote:
> > You can also reply to this email.
>
> Your email reminded me to send the notes we all took during the
> Contributor's Summit a couple of weeks ago. I did that today beginning
> in this thread:
>
>   https://lore.kernel.org/git/YzXvMRc6X60kjVeY@nand.local/

Great, thanks!

> You may want to squash in a link to that in your article, since it
> mentions the notes hopefully making their way to the list soon.

Done.

> Thanks for preparing these, as always :-). This was a delightful read.

Thanks for all your work to organize the Git Merge and the Contributor's Summit!
