Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3EBC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 06:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A0822B40
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 06:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrqcKWej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHEGx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEGxz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 02:53:55 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E33C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 23:53:55 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id s81so4656657vkb.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 23:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vk0uMN8f8TYlJP5M9wgfW2OsR8wjvaLpnTzPPXo1B48=;
        b=JrqcKWejI7Rxhq1EIKxxRP1m6UaFH3/Ea9M+4RJRb3/5ZNShw1n+oI/QvcphSTi2Hx
         vKraHJGIIVSSD82mgJ/OKIZnpLo3GqOAt18kiG7+YHDSiFBktZO0xgfb0SjDtxyRFhMi
         NDCCF5+taNGTH6/FpEbyS/TRYRkr2kAWqirbjQrAm9LSW8GraucCtDUN3RrDutfrDpzM
         Sg1U2TLHxkXJLtKKOjwPIFnTH1LqoWlEnKOH6ipnTZfQq/L/1S5fnV+ba38Pns2nBp0a
         EtQ7epQaQe/Pt5ROip8/hvl7DUdZ3Y82vGHQRcA1LJ53rgn8i+MrBVKJ0sagfNaBSGEx
         ZLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vk0uMN8f8TYlJP5M9wgfW2OsR8wjvaLpnTzPPXo1B48=;
        b=ABojGiurtLEzG2LlOd73QqxVSmMu5xKIffyA1tP/hzRbyxKJPIvTjl+4pnKCjThdE8
         XKO38jDcEgZAb9T703/Nfc/3zpW0M4dEscOk+wNF/LKsaqnhWG/YMy5Pi1P/lOyHKqQU
         KCSzZMTPEQPC3djTSPdsIVMLcRGMIBzmTOAi8S33Fn+XcPQeECVQuncKqCbt/Y2YcxW1
         FZ5f0XeNqnBqXdvENwp6ScNAFlP2mJ1Yr0XMTMbR+wg9IB6kSRV8/pnYQFiGs81hLqnB
         Nckuay0tzUjQ6GTtDlRoYYs5NPN8makZKqSLpZyHscygq6Os3Ji1FwIp1mLt8neUS1dA
         XJwA==
X-Gm-Message-State: AOAM532Z29x1a1DM41TgyK+xabqS2pF7DtBwDjmjzFNdj1GJU2FrSzGz
        b+Bu8d60qgWL2esOiGsZUm0iBWQv3IvE0FssWFc=
X-Google-Smtp-Source: ABdhPJydGA/OBfyESLlwtuAY7UK9FPAlQ/sz+0/ZQdDu18uSRNN0aBOwapRIcqisnZFzdZTCj/D1SkOhdpHf8pIXQXo=
X-Received: by 2002:a1f:c946:: with SMTP id z67mr1255666vkf.85.1596610434645;
 Tue, 04 Aug 2020 23:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200804210758.1241259-1-martin.agren@gmail.com>
 <20200804212831.GD2020725@coredump.intra.peff.net> <xmqqy2muqddg.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2muqddg.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 5 Aug 2020 08:53:41 +0200
Message-ID: <CAN0heSp+yf5jg0eNxGQXYUf2Y48nOuK-H3TX-y-Yc-TuzhOzuA@mail.gmail.com>
Subject: Re: [PATCH] Update .mailmap
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Aug 2020 at 00:01, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > On Tue, Aug 04, 2020 at 11:07:58PM +0200, Martin =C3=85gren wrote:
> >
> >> Similar to a35b13fce0 ("Update .mailmap", 2018-11-09), make the output
> >> of `git shortlog -nse v2.10.0..master` duplicate-free by taking/guessi=
ng
> >> the current and preferred addresses for authors that appear with more
> >> than one address.
> >
> > I don't have any specific objections, but you might want to cc all of
> > the impacted people, which would make them more likely to notice if thi=
s
> > isn't the right thing to do.
>
> Excellent suggestion.
>
> A commit with 10 acked-by would be ideal, but at least let's make
> sure we made enough effort to make them aware of, and asked them to
> help make these entries correct.

Thanks, both. I even kept adding to a list of the addresses in Cc form,
but in the last second I bailed on adding a long-ish Cc list. Resend on
its way.

Martin
