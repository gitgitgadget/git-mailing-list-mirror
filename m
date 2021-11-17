Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD760C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A71E61B72
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhKQBx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhKQBx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 20:53:56 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE342C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 17:50:58 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id o1so2423699uap.4
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 17:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=H3cgRk8kUDEg5I7DkBWUJSme+G3mkPxt7krqAa4bGh0=;
        b=U/r7OMwo35DXmaXIyuiFPwuNFxaAI+XNEwjSlxloFKsEc5lU7FtGYROmwmVhbIzzNy
         xtuJCZPyZlL7lEhCHMMY6SHeOB9C+Z9XOPILnuP12+VH1FtHHfgsL+XWbP5KH7mr9JrA
         IwSY0VasP/mrcvAj1SKj49lYHtyTYaE9kfcgi+xd4Z5NxnfiEbw2cShC25rpwtsxZ/mu
         3RpbQr5ALkzNcBzwlUWRkXP3Ek0lDmJ+9feLeb1wSyS9pcl7cfT73QoGde4gZ4BdIe6c
         RSFrdG5uiA1rpb+qUgtmAffyxrgwQIeL4MxGVjsu+gKK1E57Xm8bOlcE54XhlqIz7U5/
         jBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=H3cgRk8kUDEg5I7DkBWUJSme+G3mkPxt7krqAa4bGh0=;
        b=Ou3gx9Qx76clbCs9AvZN/Zl3ckbslVdOu7+SFmCBEgVIT/JUkzhsz5iPNIOy7Nf8Xq
         +hyXakQZMbla6ss2VtwNVhD82soPPjcSrrtJ6rViDJ3bB9UKY6YsqUIUuX0uP0noECMw
         QmAmTVCobhlAgv96DsuLZn9UjyRUmn707MyOu3JAZM3Gh4OqNKTUbkJyxWKh0J0K+y3K
         Bp1eCUFmIWn+wowXcSCpPMkIBScO/NvBRtT7g7fsYxw7oqi96kLV7ajTtp9fZ61XZV8+
         jB2Yg5ribCIdbFHHtth0Jowd9QNamgwma44bn6csMBsUZH1oBLvSWUd/KWQM48Eryudv
         T4oA==
X-Gm-Message-State: AOAM531GpufBq1BfevoomxPGPrdhOOcRmLO5dRnUUZU/WIH2qW5k4SZQ
        2YDuyoVb95c0w7TyZgIVUfQQ6XSKhXgkmoSqdDc=
X-Google-Smtp-Source: ABdhPJwnU7xaYBUVsdaauHqoalqRpeRcZX4budZpL9aCikM1RQJyAJXxDqVTPOmmCzgEI8+XGFpj2i2eOY8axp9iQVU=
X-Received: by 2002:a05:6102:512b:: with SMTP id bm43mr63336868vsb.14.1637113857978;
 Tue, 16 Nov 2021 17:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-2-sandals@crustytoothpaste.net> <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
 <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com> <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net>
 <00e001d7db40$985c61a0$c91524e0$@nexbridge.com> <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net>
In-Reply-To: <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 16 Nov 2021 17:50:44 -0800
Message-ID: <CAPUEspiHnTkwbUJ5o+fT2u4Kn+fwNe-3FoqVtNsjTF+Pg6Tryg@mail.gmail.com>
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a CSPRNG
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 5:04 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-11-16 at 23:20:45, rsbecker@nexbridge.com wrote:
> > We do link with libcurl and use OpenSSL as a DLL to handle TLS. The
> > underlying random source for the nonstop-* configurations as of
> > OpenSSL 3.0 are PNRG supplied by the vendor (HPE) on ia64 and the
> > hardware rdrand* instructions on x86. I know that part of the OpenSSL
> > code rather intimately.
>
> Great, as long as you don't define NO_OPENSSL, I think I can make this
> work with OpenSSL by calling RAND_bytes, which will use whatever OpenSSL
> uses.

not that RAND_bytes return high entropy bytes (like /dev/random) and
is therefore limited and prone to draining, blocking and erroring when
drained, so if we are going this route, will most likely need a second
layer on top that doesn't block (like arc4random does), and at that
point I would think we would rather use something battle tested than
our own.

for the little amount of random data we need, it might be wiser to
fallback to something POSIX like lrand48 which is most likely to be
available, but of course your tests that consume lots of random data
will need to change.

Carlo

PS. Probably missing context as I don't know what was discussed
previously, but indeed making this the libc problem by using mkstemp
(plus some compatibility on top), like Peff mentioned seems like a
more straightforward "fix"



  I'll work on that for a v2 to see if that will meet the needs for
> your platform, and if not, I'll try something else.
>
> That should also have the pleasant side effect of making this more
> portable even for those people who do have less common platforms, since
> OpenSSL will likely be an option there.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
