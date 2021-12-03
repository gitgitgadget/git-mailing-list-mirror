Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF57FC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 20:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383103AbhLCUcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 15:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383105AbhLCUcB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 15:32:01 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144E4C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 12:28:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r11so15988331edd.9
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 12:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IJ0h8lTE6UuE3psW5YrjZeQofbEQwjw/6HTBRTg3tz4=;
        b=hFZZXunikjwwMGE35rU92wtVV8kKYjLzRHBx/p+xl+fR+1sm6b/cRw31wbgI2X/N9q
         AADC8uovBbPvbhcscHfJ9EzTwJakpA3CQDLWjagxvbKCpmohWNNM7ajrC3Qq8lkxK1NH
         yldNVG2NXBIi3Sw3ASVtbsFGP0NjChCciwI0PNBBmght8Mqr56sjljYIghRPMaZMBhTn
         4jJs5l2uCAdzVa4tp9QzcTFhR9e2CCwLsxRoKUJDneTDeGHsNPPHBNa0vEE+hwoGcdav
         vNN7+OL5MpKkKIIFPBaVuCIKy1NCoeBrEwQdDxUAl+SHw8hqFFcWt+Oi4mxrCO0Tz/se
         JTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IJ0h8lTE6UuE3psW5YrjZeQofbEQwjw/6HTBRTg3tz4=;
        b=MkbBNavETIN4pYRLak4+Zhx/pwdv6k/bfNnjda7Ej96i51xX59lANbinqcT44wn7rS
         6AzuffCHTw0XI8WiJHf26Xf2DGqO8jYeaL4fanfFOhwKzEntyoJnNsbK+ftVFjXuHfEg
         hBz8rO1zlhrEh58sdcLnwcdKCjCWmiyp/pzh8TmXr8MJVIDb6kQgBAVRx11rgGHso6iR
         3jYY9l0Ctizh9AhBjvpj+ZFo5s15ns5jXI/p0o2mQ745WKjYsqQiEGBS239O8tT26sVt
         b1x4UUspCA2I+E8WWRk+HI/NvVMVEpttA6YsR3dI1VaOx7hz9eHiyZ8i+7LrKo49WuQx
         LqNA==
X-Gm-Message-State: AOAM531RLCsa7LhU4Gz0ZFGSr0IkTQBbaG3foUQUncmK61I+qzponstd
        HO2UivuarMb9CDLnUPnhXOrRQXtBV2r2hA==
X-Google-Smtp-Source: ABdhPJz1oaZ2hlz5cn0qxaqvO/jHz3l3WRSpUCj5zt3OQaXaQ6Jhl+m4nRUYta5jHgA760N6nWVWCQ==
X-Received: by 2002:a17:907:7250:: with SMTP id ds16mr26333482ejc.54.1638563315677;
        Fri, 03 Dec 2021 12:28:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id oz31sm2466626ejc.35.2021.12.03.12.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:28:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mtFAY-000J83-O3;
        Fri, 03 Dec 2021 21:28:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Large delays in mailing list delivery?
Date:   Fri, 03 Dec 2021 21:26:08 +0100
References: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
 <211203.86sfv9qwdm.gmgdl@evledraar.gmail.com>
 <20211203202427.o575sgrx4auqkmjp@meerkat.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211203202427.o575sgrx4auqkmjp@meerkat.local>
Message-ID: <211203.86k0glqvpp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Konstantin Ryabitsev wrote:

> On Fri, Dec 03, 2021 at 09:02:48PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> When I've experienced delays (sometimes of half a day or more) both
>> https://public-inbox.org/git/ and https://lore.kernel.org/git/ have been
>> updated.
>
> Btw, you can source lore.kernel.org straight into your gmail inbox. :)
>
>     https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
>     https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap
>
> Or, you can read it via nntp://nntp.lore.kernel.org/.

Nice. I was looking into doing that the other day but stopped at not
finding a way to do that with the public-inbox software itself.

Well, "the other day" was probably ~6 months ago, but at the time I
could only find some TODO item for a Maildir export. Looks like that
works now, great!
