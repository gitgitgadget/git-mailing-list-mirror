Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFE21F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 08:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeCUIfb (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 04:35:31 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:37042 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCUIf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 04:35:28 -0400
Received: by mail-ot0-f176.google.com with SMTP id t2-v6so4751617otj.4
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AgFsFQEP2Ae+KqVqXTS6wtxTNNeOBeEHPZSVTHyNRow=;
        b=J7iMw+P8wnUu8kthCH/MR+Np4LWgD1pyhEPR3lOx/UsbAmh6643ZaNXSw7fnAIyv+y
         j9XRtpWAx6n7Ln1cwzU3zgF7CNr55Bo5ML9lmjDqvFBT1AAB1yyM6XvV61TaFaDBfVbZ
         1+H2rbmDx3iRtfx6SQOunzHCtf1nePPmA6nqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AgFsFQEP2Ae+KqVqXTS6wtxTNNeOBeEHPZSVTHyNRow=;
        b=tzMxP2fEqi103xIR4vJH/A/47rcGDzbtZj7ajY4B4veMLGpVksdFd/qLEaHU7eRW28
         2qEP4b4dvJ+/nqLI0Hk7mDULt9rsJ2Hs+rIVMf8mS73tL7MHssiEZoaTgOJ4Hkn4JAfv
         kzVuaZ/PGt4FFkeBxNTc6N6mHQ1YpuSTg0yaRNKgEeFz4iwhVJRnwkmr/cCk5frQUknB
         tXifAHigH2edzuZArRWhSYZWWUNHzAiQHPmll2QzAXra3MRkalKgPcJdSDACfpIOd1Do
         mOr4x0EqYZFc+xeKGr5Al0Oj0GKd7J39EDCShGBAhFhYkawUcAyRZOBsIlOFIIYXUYRn
         9v0A==
X-Gm-Message-State: AElRT7HDGNffIVdbCVWRlPkvRPsESGI/VXzXkxnTn+3SdweeeQG5QSeX
        IUlhdttrsim8s6wXHAAqPtN0yWVIGcpPFKYgNDNzyQ==
X-Google-Smtp-Source: AG47ELtjnqOXUXkHnes1Pz0/hX+83LqzE1Gvpbo541lCHQLS7g6RH46JGJpxLY62OlLbOLhdrIn3xCUpX+O8myNX42Q=
X-Received: by 2002:a9d:3b85:: with SMTP id k5-v6mr11961040otc.209.1521621327506;
 Wed, 21 Mar 2018 01:35:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Wed, 21 Mar 2018 01:35:26
 -0700 (PDT)
In-Reply-To: <20180321075041.GA24701@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net> <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
 <20180320044036.GD13302@sigill.intra.peff.net> <CACsJy8BP+ov0jeHp6QZoi=etPDQX5qEFqEfktyA-U-ffUE92vA@mail.gmail.com>
 <CAHnyXxRsqR3A0FpHJwnfOWo29WNx05qWSXfxvmwPv1TUdqm0aQ@mail.gmail.com>
 <20180321065212.GC16784@sigill.intra.peff.net> <CAHnyXxTf16ukf8CFSfzjQjTEjf5yJXFqK5TnS9KiXZEeAD7dgg@mail.gmail.com>
 <20180321075041.GA24701@sigill.intra.peff.net>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Wed, 21 Mar 2018 04:35:26 -0400
Message-ID: <CAHnyXxTP7i4G=4G_ihRQTSbLNzAWuqZ3FoX0NtesAX219Pa5-g@mail.gmail.com>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think it means "for the rest of the description of how the patterns
> work". I.e., "foo/" matches as "foo" when the rest of the matching rules
> are applied. I agree it's a bit awkward. Patches welcome. :)

I'd be more than happy to do that!

It will take me a while, this (email and text-patches) is foreign to
me and will take me some extra time, but I think I can figure it out.

Is "consistent with the way how pathspec works in general in Git"
absolutely still true (and relevant?)
