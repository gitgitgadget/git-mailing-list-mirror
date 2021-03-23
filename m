Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A862AC433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 05:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DF1619AE
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 05:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbhCWFEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 01:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCWFEP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 01:04:15 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCABC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 22:04:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id l79so15731647oib.1
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 22:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XgILcHNsA68auY1s0t8ReuUAgE9KCPcN/fHb+ImloRE=;
        b=d/vFU8yuI6EbJo5onASfXTkplMnnn/r3+ZmqQ6D5VLfDJ5q51Qqdnf+8acNgmv6uFL
         S3Puo5neifjwd9AD/1SL+nEZDZ2hr94Gec7MmLzddBw/LQY4GDa8tWz4CJAxkERIK+8K
         rykGJ44Mx/AJQuS+oihf/6eAvrTy4/yX5HPZ0qad3ZoheaFKKfAKnCfbNbzqhxVbsraa
         SDrq8W0GFe/sc35WWgmtd5f+TDpMLUMGTIRyHiD2avHDyE0CMfobCysWTKr/ssjgNVAV
         pbiYmzSvUxh2rC3FWoRIO5nvDVYCwA75Gv9WsSBNgoon7LtBuYQXLb10P+ALo0/Ob6MN
         3U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XgILcHNsA68auY1s0t8ReuUAgE9KCPcN/fHb+ImloRE=;
        b=lJi+Qio3tqvQYQ5DzAitXvLJ8JSxccQt1jFzNY6F4uhzJd7Ebe2cvE5BwNS8HUw/ry
         hkg4kloUo95fhFYB9eFoS5KlnIv07Uk8Ml3wWajticEXTM61/OE1zj7JGWOSMZx7jDay
         QjimvEZDdOKM2dBLZj/mfzZMXsxNofnnL26gkcOCpLe+pIsrcDr048L4q18lRY14Eou0
         VJ51Wi0O/DTAkn5NLlZiAaE24plBLISbYoU9Qmze8bMbgRpQK+mRfxZGfTPakhOMcV/M
         bf0gNaZFmmKJ/PT5z1D1A4/+GYMp+7rLCR4we8p/8MCPOdm7VI4LgwUsMyIqKuVk07yz
         sMRQ==
X-Gm-Message-State: AOAM532raJ0jOniHlmoVvMxFtRBsbWw7MeGhZkplgRGAzvGo59Ie92pb
        wbv7VdbtzmkR1t6QF7+/Sld/MB2pHGNV3TQVzAg=
X-Google-Smtp-Source: ABdhPJy/GtVpvyVP7bx8VodFRM1sBX7NybGPDWFF+6O09rHGJatjjaLdYT8pVaCgfFcwpmE1f60W9R0EDq4QJVdVFRI=
X-Received: by 2002:aca:d68e:: with SMTP id n136mr2029419oig.179.1616475852484;
 Mon, 22 Mar 2021 22:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
 <pull.911.v2.git.1616317134.gitgitgadget@gmail.com> <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
 <CAP8UFD1Oo-eWmoV-1mh1M=pA8+yRUYHy1wg8NvN3bthmCHBfvQ@mail.gmail.com>
 <xmqqwnu0bga9.fsf@gitster.g> <CAOLTT8TU+XwLmDQRROHW6iumFgMKok9mi+_OBmN4FbvgWkNb7Q@mail.gmail.com>
 <xmqqv99j6rt1.fsf@gitster.g>
In-Reply-To: <xmqqv99j6rt1.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 23 Mar 2021 13:04:01 +0800
Message-ID: <CAOLTT8SRbe8bked2X9uOVexPQPLW6E+ON=Fs66fPDLp9eOWn5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:07=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8812:52=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> Christian Couder <christian.couder@gmail.com> writes:
> >> ...
> >> > So even without this patch, after your first patch that implements
> >> > `git commit --trailer ...`, it should be easy to setup something les=
s
> >> > verbose and less error-prone.
> >>
> >> It is nice that it makes the complexity of 2/2 unnecessary ;-)
> >
> > A little frustrated, both `--own-identity` and `@nickname` seem to be
> >  rejected. I will roll back to the first patch.
>
> If existing functionality can be used to achieve the same end result
> without any extra effort by end-users, that's a happy endgame, isn't
> it?  There isn't a reason to be frustrated---the users benefit with
> the new --trailer option without adding (hence having to learn) new
> extra features like --own-ident or @name, which is a big plus.
>
>

Thanks, Junio, you are right :)
