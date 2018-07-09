Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA4EF1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 14:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932727AbeGIOdv (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 10:33:51 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34744 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeGIOdu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 10:33:50 -0400
Received: by mail-oi0-f49.google.com with SMTP id 13-v6so36278400ois.1
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C85o+t1H/COanhkQQMki4AkE3A+UeYpIloPwfhE7U8E=;
        b=YaLrBpMNgfl79g2izucaoMiCgQ33C55nNA0oR8/Mk5b4w9cIBcRIFkwjcbP8fM2IEi
         mPpjX4wxUasUuCUPUtjfRVy+31kb9acGeCnU7ABpOD2rVf+wkXf+/0egUT1N4DV8Oxiv
         SrqouLBv6swawBqLZXv0vhW/qHWbMz7uMCOsMRyezF6PExzjh51XrAMrI+6wBRI58vmS
         YT9J/yyharlQMyoRHw0uS6NTOUqc2ZbCt1u5GgBNm0RvWLA5R/CXvnWEVUzk7zebI/O5
         GeqCdDg0Kawcew3LynludGE1NWByUDcgq2q/K2YrDB9S8ZmUlYTPKxoHpaHyLiDrlL4R
         LLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C85o+t1H/COanhkQQMki4AkE3A+UeYpIloPwfhE7U8E=;
        b=ScyWuk3WRJBRqPB16QHRu/azDARLCr5uFi44266mQ8f5lZAApib8GuCnN/ft1EtWoZ
         med7J8XxHPfy1k/V6sjETG3ZLd3xvBniOOz4ZtQ4+SSqZDyZqNdhn+Ej9jZni0Ue1vwB
         +LeM1E9Em0+Jvp+FcTAzLgsBIhZn5gE3H+NekInhIZws8lcsu0TClRGWKVUSmC7LHynU
         h44ds/r+8i5UZijGlr1wLqQwsrhYHjTyED1BdzVIdzIFPQQquPYmLchmNUOSsU64RD9t
         z5srDWQKfC68QJkIS1mhILaXVuMDQFo4Wy58QNUkIkU9quByNL5xXnu9QV9Uuj9+pYBW
         2yyg==
X-Gm-Message-State: APt69E15R+YGu5+vNsKW2vqVj8b4MLnQQQiMyoXxQw2gZhHCP5cjX08P
        czm6lkPu2I0jflb3Dl+lbvoB/dpK76Uz3fI1/+A=
X-Google-Smtp-Source: AAOMgpdGZyqYsFdbnJwUneDK/gAYdPhjVm0Cylc2bdUvTR0IIyAN2bHmKyi78tC9OOlbt9PLXqFZ8PFi3+Busk/sH28=
X-Received: by 2002:a54:4406:: with SMTP id k6-v6mr12529543oiw.34.1531146830265;
 Mon, 09 Jul 2018 07:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180630133822.4580-1-kgybels@infogroep.be> <20180630145849.GA9416@duynguyen.home>
 <xmqqpo00mi7q.fsf@gitster-ct.c.googlers.com> <CAM0VKj=u0OVad3QDRFOc+NWZ9TfwqAwmZ47s=5e5jGZaPQRH6g@mail.gmail.com>
 <20180707231651.GB6152@infogroep.be>
In-Reply-To: <20180707231651.GB6152@infogroep.be>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Jul 2018 16:33:22 +0200
Message-ID: <CACsJy8C=Xs1QY_cMu+H4DR9XovBd5bO-ZC=ie-1x9yZepgUMdA@mail.gmail.com>
Subject: Re: [PATCH] gc --auto: release pack files before auto packing
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 8, 2018 at 1:16 AM Kim Gybels <kgybels@infogroep.be> wrote:
> Should I post a v3 that goes back to the original fix, but uses
> test_i18ngrep instead of grep?

Yes please. In my comment I did write we didn't need the repo anymore
(or something along that line) which turns out to be wrong.

> In addition to not breaking any tests, close_all_packs is already used
> in a similar way in am and fetch just before running "gc --auto".
>
> -Kim



-- 
Duy
