Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A078C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C086615E1
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhKQDkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhKQDkC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 22:40:02 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9FC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 19:37:04 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id y5so2820156ual.7
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 19:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRVcVf3K1x1YLjoij5PhKbEoPiPqeTSlJI6k01bi8q8=;
        b=Jz4/FOJOReltbmkFMQN+aMq2si6EeNsMMW63n11itCWGydVR9jiZ5bSw833I/QAVOv
         lDAxT3BJLzXs1tEGDo4X+ix9WiEhsAB5gIie+JrBGXVRG32vrAWbFe1WVD27c/0D/qXO
         +MFkhR/LKjtZofQJlyVhz/FOZzviMmQ2I27RcxYPLqm5Lt4h30K9EBkGaM/qsGxF3Gfs
         fvvjTxX8CrJM8rwtEHrJgFwNEBSHIi+vfMDf/4qKLehQ8Vv+FCSZqZodvjfoKB3J60jI
         xSIhzdhE/tnNQuf0T7/squcvndjgra5oNML4+lhwJhbYfjFW0RxGwGBjceajAlrsYVYZ
         Y8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRVcVf3K1x1YLjoij5PhKbEoPiPqeTSlJI6k01bi8q8=;
        b=3MfqTMwtcjrsm6URyil074QHrwLG534XsVXTlMOhC1pzllvDvaoOUD2oKRMsH6SExC
         2QsdoeQDWv8WUsrilneFOAMjzLVNRG/MMyQCjsfARZZzzl///gmYxOdYQr57hk02kdZC
         RpENj9ACs1dC/yxgcqM+H7+B44nNhZqOZf+oXQ2aKwHeDaud2V2bgEC4dR5tPJ1yQICD
         0gRR+RbFwLkSyKaurlKmQ+gECmSzfFQPwTU69oEsUglwCk/omcFcwlySwgZpypUv8qEU
         2utGBB25HKa69SIEdZZ7IdLjoVrMtw08JyTH/yovYqMUMPIWkFukz34g6r+aN0zzzsG8
         372A==
X-Gm-Message-State: AOAM5324615U977hZDdL6wg0lQEFiJ/C0ZoT55SCvGFAwa9WBNcybrsk
        H9bmTb5aJaV0bsyqbPE9I2M9J8w137mDn9csVJjmu1q8
X-Google-Smtp-Source: ABdhPJxDHXVUXE3vIalWbbcYpnoWrzcmkq+RTDGcOyQwC6Gt/MUKfhoOJqB0BQtNSg032XQcLl8MIeiO7VuhHNa9mFI=
X-Received: by 2002:a67:c181:: with SMTP id h1mr63453949vsj.3.1637120224020;
 Tue, 16 Nov 2021 19:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-2-sandals@crustytoothpaste.net> <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
 <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com> <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net>
 <00e001d7db40$985c61a0$c91524e0$@nexbridge.com> <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net>
 <CAPUEspiHnTkwbUJ5o+fT2u4Kn+fwNe-3FoqVtNsjTF+Pg6Tryg@mail.gmail.com> <YZRxOrv9JFt2oeSU@coredump.intra.peff.net>
In-Reply-To: <YZRxOrv9JFt2oeSU@coredump.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 16 Nov 2021 19:36:51 -0800
Message-ID: <CAPUEsphh-enSYS66mi7_XaS0n1bmUvGXRcgVp6iqhg94xSHVog@mail.gmail.com>
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a CSPRNG
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 7:04 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Nov 16, 2021 at 05:50:44PM -0800, Carlo Arenas wrote:
>
> > for the little amount of random data we need, it might be wiser to
> > fallback to something POSIX like lrand48 which is most likely to be
> > available, but of course your tests that consume lots of random data
> > will need to change.
>
> Unfortunately that won't help. You have to seed lrand48 with something,
> which usually means pid and/or timestamp. Which are predictable to an
> attacker, which was the start of the whole conversation. You really need
> _some_ source of entropy, and only the OS can provide that.

again, showing my ignorance here; but that "something" doesn't need to
be guessable externally; ex: git add could use as seed contents from
the file that is adding, or even better mix it up with the other
sources as a poor man's /dev/urandom

I agree though that having a true random source will require the OS,
but isn't it about generating 6 random letters?

Carlo
