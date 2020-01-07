Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CAEC282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC762072A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAAGvASU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgAGUkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:40:20 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:40025 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgAGUkT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 15:40:19 -0500
Received: by mail-il1-f171.google.com with SMTP id c4so750060ilo.7
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 12:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AYt9Mm3afS/ne0/JqZ/OdRZACWRtvv35zPA8ck4NSLo=;
        b=FAAGvASU+/uSsagXrgmr3n6+ed+AeoV72/peyHQ48SNzwseDY058lKMrxbxXLUX5A2
         imF0gYajwYya4s1BO73VgIcECURRy0vaQ4y28d4bIPh06J30ruK0mAsrMYXpV2+i7YiP
         aig/VwWCXqZPAlNq70frU74xGnU1AlFBDMMaN+be0kUvTMaoonOJuSUGwIsVPB7Cswhg
         YJFFydMDo6m9DK6AFSmpaT4A4Bo2A0zyBIbIeqHpLHOzWprplmOgoUgKcNVWwYMdTh5c
         6tz0G9TIzpdPv5+sY2xW79heaPFbahwMkce2j8wIxFYrqnocGVirWxV/zidXwcGrl2rY
         /6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=AYt9Mm3afS/ne0/JqZ/OdRZACWRtvv35zPA8ck4NSLo=;
        b=iHyKbewJjB1JOgEhImgNNqrPcaIVPpzzqHjp5KvhsH87w8QgDJtkC+17Xks3jeYcoC
         eFEhSmKq1GVLmJ4vuc9PO+HlspKIxU8BqlSLyq+uR3WO7DpoJ3QSgFaf86lls45uVGpJ
         KPSWYUBgWz+vqbt9HiYPc19NxtU2+/Sz+fpTilc0RN50upR92b3ui5otPBSMA3okaw/r
         GuW1ohQZOikZyoKJ8gDDM4ac0bnnLWK+Eai33Lbsxs/zWBqoGlwczw7Mb9o8ISqstSTZ
         YVo4vECegTEVzadlwo/rFavl1gE+wKHBudMcc4iLeF6zYO0te98mg7aHqRDCed/im5u1
         VvPw==
X-Gm-Message-State: APjAAAWiOcSGDTcsSw0fmXNvzdcGt+A10PS0tlC2joq6HIs7Bfk1N8e0
        wIq/rKlYHwe4rksVShf2Di0ZUq4qD20xb9XfbPo=
X-Google-Smtp-Source: APXvYqxzx0Mh4ZB9tMPPlC9FkotYas71dak8AnK2wK0V2MMnKJL2zqzSUj29cdRffxI8tW/9No7SGYVu8rYUdTOfroQ=
X-Received: by 2002:a92:ca8b:: with SMTP id t11mr932410ilo.227.1578429618953;
 Tue, 07 Jan 2020 12:40:18 -0800 (PST)
MIME-Version: 1.0
References: <CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=EjR6v6jE1mnxvUJQSF_0Q@mail.gmail.com>
 <20200106213051.GD980197@coredump.intra.peff.net> <20200107010809.GH6570@camp.crustytoothpaste.net>
 <20200107015859.GJ6570@camp.crustytoothpaste.net>
In-Reply-To: <20200107015859.GJ6570@camp.crustytoothpaste.net>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 7 Jan 2020 21:40:08 +0100
Message-ID: <CAN7CjDAZCxEmkvkqOw++VvBwF54cn_S1J+Uem61aNvjA7F3AiQ@mail.gmail.com>
Subject: Re: [Outreachy] Return value before or after free()?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, "Miriam R." <mirucam@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El mar., 7 ene. 2020 a las 2:59, brian m. carlson
(<sandals@crustytoothpaste.net>) escribi=C3=B3:
>
> On 2020-01-07 at 01:08:09, brian m. carlson wrote:
> > Unfortunately, compilers have gotten much more aggressive about assumin=
g
> > that undefined behavior never occurs and rewriting code based on that.
> > clang is not as bad about doing that, but GCC is very aggressive about
> > it.  There are multiple instances where NULL pointer checks have been
> > optimized out because the compiler exploited undefined behavior to
> > assume a pointer was never NULL.
> >
> > In this case, the only case in which we can safely assume that this
> > behavior is acceptable is that r is NULL, in which case C11 tells us
> > that "no action occurs" due to the free. So the compiler could just
> > optimize this out to a "return 0".  Just because it doesn't now doesn't
> > mean we can assume it won't in the future, so we do need to fix this.
> >
> > I'll send a patch.
>
> Oof, I just realized that you had tagged this with "[Outreachy]", which
> means that you were probably planning on sending a patch to fix this,
> and then I went and did it instead, so let me apologize for doing that.
>
Sorry for my late reply, but I have been traveling all day.

Don't worry Brian, I am working on finishing bisect-helper conversion
from shell to C.
I am planning to send a patch related with this function as part of a
patch series. My patch only changes the static header to be used in
bisect related files.
My mentor (Christian Couder) detected this and suggested me to ask the
community.

> I sent it because oftentimes we say "we should fix this thing" and then
> never do it because nobody sends a patch, but in this case I should have
> paid more attention and waited for you to respond and send one instead.
>
Don't worry again, next time if my question is related to a patch I am
going to send I will actively write it and this way there will be no
confusion. :)

> Again, sorry about that.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
