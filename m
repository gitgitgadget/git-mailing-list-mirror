Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFFCC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhKVW0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbhKVW0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:26:17 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6E6C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:23:09 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id l24so39814434uak.2
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKaiRv37lWShLFHYFFZxFcrnDLcr8zwVx1qnxJqTJRE=;
        b=e3pR2v0bvs1A26LnYB1EFrNC7h8KkZrbFEUcfgDbO8X8DNl2DVesxp/2Gw+wd+mC4M
         hRWFvXBnSJo7lTi5ymsDlX0Mp5B6eEQEAYjJPxQt4MR0A7lF7cOnwnx8iXdAi9bnvtW4
         uGbaqTMviMHM1i48DvhU34jDepOyInAMXvPhwjtazipb3iSRFBQxk9lK9U0tDqbnd71Z
         RVO3o0LvZMZ3G8BXXnBT/XxNhy6Jf64wv9cAgfHTEf24nsPSo/P8LMP2/N3Z/mHhR4Rt
         xk3/0N8/ZD4vSEncRbi6LZD9NBxoIFDjiUPF9u3TSPo/Y4a3OCZLtNNkXA52nyI5o416
         b8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKaiRv37lWShLFHYFFZxFcrnDLcr8zwVx1qnxJqTJRE=;
        b=LQQYjCkakRzB7ywg0THxZxeDJ+ccIBKyR4Dej9FH5lVvoBm04Cy3atEC4tTEghPJg4
         GjlxWDeBk386G0OMiKlYBIwQWJb631kOKqofWSqd6Y+IjyQEXsmxh5t2Bw5HzXP8gtx/
         C1ARfTnUM1t0H7831dNohQaUBSL+Cs5ajkUfE2z3aM9hbki1TPHFa+AE5g5Aw2hOw6T9
         7lcerWr5A6NQ8H6xsQTuyfJ6Lw/aL0P3mNWFHUnviAQU3zZcSJn7k8JYCLIz4hKDGbtK
         gxdFNVeY3gMroYKtiz6+kUiCvx+4Gn3hBcgw9TsYoo6qsUSoIDAEdBDHAN1snORKP8ag
         hvGw==
X-Gm-Message-State: AOAM531n773DmBJT0tmT5gWqymiT0Vk3NjOEB7NqOAvFS5P+hjw8R3ar
        WwHmJvGguhc7d/cq75L4NRn5fqDZ1ExhKbGKlR4=
X-Google-Smtp-Source: ABdhPJzZMYbPVD0WkcP8GkSD98UyhQBBOvCjXubDqSqkl7LVjpY4amZE5583XJigL5X3MM11N3aUHvQZ8YNCZwcnUkM=
X-Received: by 2002:a67:c181:: with SMTP id h1mr1143610vsj.3.1637619788704;
 Mon, 22 Nov 2021 14:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net>
 <20211114211622.1465981-2-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet>
 <xmqqk0h7423v.fsf@gitster.g> <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
 <xmqq1r38hzi9.fsf@gitster.g> <CAPUEspibE6AMyoxwJGno9R=21JU5MpFVGBxCQYBCbCBwx-y25A@mail.gmail.com>
 <xmqq8rxgf254.fsf@gitster.g> <xmqqv90jewwa.fsf@gitster.g> <nycvar.QRO.7.76.6.2111222300580.63@tvgsbejvaqbjf.bet>
 <xmqqwnkzdepm.fsf@gitster.g>
In-Reply-To: <xmqqwnkzdepm.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 22 Nov 2021 14:22:55 -0800
Message-ID: <CAPUEspjj4bpnRsr=vpnzuvoHqw9A19fpPcX65oSHZryiyKXxEg@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 supporty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 2:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> But if we were to do so, perhaps we'd want something like what I
> >> gave at https://lore.kernel.org/git/xmqqy25lwa86.fsf@gitster.g/ in
> >> its place to avoid confusing people.
> >
> > That sounds like a good course of action to me.
> >
> > Please note that the MSVC-related adjustment of the `FLEX_ARRAY` block is
> > still needed, I think.
>
> The "something like what I gave ... to avoid confusing people" patch
> is following up on the direction to drop the patch with -std=gnu99
> change.  IIRC, your MSVC adjustment was to tweak that patch we were
> discussing of dropping, so even if it is still needed, it won't be
> part of what I was doing.

I think it will still be needed, I have somewhere indeed a bugfix
(which I never got back to clean up enough for sending) to that
section because it was not C89 safe either, which is what dscho is
likely fixing from the point of view of MSVC that doesn't support the
GNU syntax that we use as a fallback eagerly than we should.

FWIW I got the chance to try to build in a long unmaintained debian 6
(AKA squeeze) with gcc 4.4.5 and was greeted by the following edited
message:

  error: 'for' loop initial declarations are only allowed in C99 mode
  note: use option -std=c99 or -std=gnu99 to compile your code

So I think whatever we do, likely it wouldn't be confusing to whoever
is affected.

Carlo
