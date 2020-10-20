Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B4C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4025322265
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="y/DL9yCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407396AbgJTNTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406341AbgJTNTN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 09:19:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B8EC061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:19:12 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d24so1936289ljg.10
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJUV4MCGV7KyU5UcHRBmwjo2KUWBPXMSrPKV2hAOrWY=;
        b=y/DL9yCVbyIOlkRLnaDmo8dA0O+Cu2pAWS9ictusbeo8L/hLwYvwPgDVV0Muhj5Jm5
         GCsp5nF4PCQB15Yl6N91J9P0cX3Lz20f9TwysW4eVmXhm/GrfDjMeS+UQObsR1Igw5Dg
         4nqh/FIdOICXLDndGS9rh5qfRO2QlLpkKdPPRIXINUFT2FleiXDtXAyflAmhb4ZBueAX
         VFYXK+G+zE4YwDoEpzyULfBSUzreVWY8mQqsb3nGOGEp5rma581lKLnRTUa2YsiP/lEH
         TPF2AkSoPEEM7shAARH7y9MUXvTffuNMpeJu3hpDpEywaU5ko6hyGHbhul71ivaXVcpX
         PVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJUV4MCGV7KyU5UcHRBmwjo2KUWBPXMSrPKV2hAOrWY=;
        b=SDfVFgGMPUMyNVIHg+wFpF+h5qgeuOkPnYeyb0uSb4qM+qq87bX71GJEZMubS8qz3B
         JO8x0A+6QVDRbk4JvvzLhjdd0q/nq9TU2aieFpMEC2wLS+8UbhrCy1thZB1/J3rRgn4u
         7QoSPIcsrfAPgRKDmYpo7BJoWaCqd6vXit9IYjgS/CViUiPntntLwzZaT09Z/wHbqQiS
         UyqiRQliivSXfaj5UobrM4xY+sQ2bB1XztSIb8W1hRwTZEVJ6K00dXS9vY01APQFtEbE
         3I+xezhlpDigpT6tzDX43+9kah2i9K2LlvB+Mo0suXOnLnDv4xfaeXvtqfEuFrOSi4P1
         j+Hw==
X-Gm-Message-State: AOAM533nmsA4uDdKcmArzjkx2Vq+nAYEI+jZx3VTMC6PjwNWqUengiKD
        z0KC+yr3FBQHCFop7P9wrP30VnHvf8uMniFooaQdXg==
X-Google-Smtp-Source: ABdhPJy2zUatpkfAyd/PpLwViA8JEN38GdNBbsBLKdt9H+ExhPX70xidJF1GyHzqh/hKIWSGL/QemkhUO0P7hjN1Wak=
X-Received: by 2002:a2e:7614:: with SMTP id r20mr1064827ljc.202.1603199951304;
 Tue, 20 Oct 2020 06:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600814153.git.matheus.bernardino@usp.br>
 <64b41d537e68a45f2bb0a0c3078f2cd314b5a57d.1600814153.git.matheus.bernardino@usp.br>
 <20201020013558.GA15198@google.com> <20201020025525.GG54484@nand.local>
In-Reply-To: <20201020025525.GG54484@nand.local>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 20 Oct 2020 10:18:59 -0300
Message-ID: <CAHd-oW4A0S6Wb58HA7nRo37sU7YTEbnbsFmwLKN_Onc6ART=PA@mail.gmail.com>
Subject: Re: [PATCH v2 16/19] parallel-checkout: add tests for basic operations
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 11:55 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Oct 19, 2020 at 06:35:58PM -0700, Jonathan Nieder wrote:
> > > +
> > > +   # Check that the expected number of workers has been used. Note that it
> > > +   # can be different than the requested number in two cases: when the
> > > +   # quantity of entries to be checked out is less than the number of
> > > +   # workers; and when the threshold has not been reached.
> > > +   #
> > > +   local workers_in_trace=$(grep "child_start\[.\+\] git checkout--helper" trace | wc -l) &&
> >
> > Do we use grep's \+ operator in other tests?  I thought we preferred to
> > use the more portable *, but it may be that I'm out of date.
>
> You're not out-of-date; I looked at this myself a couple of months ago:
>
>   https://lore.kernel.org/git/20200812140352.GC74542@syl.lan/

Thanks for the pointer, I'll replace .\+ by ..*, then.

I noticed we also have some uses of + and ? in tests, with `grep -E`
(or egrep). Are we OK with ERE or did these maybe just slip in by
accident?
