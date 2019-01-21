Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD831F453
	for <e@80x24.org>; Mon, 21 Jan 2019 21:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfAUVE6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 16:04:58 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35074 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfAUVE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 16:04:57 -0500
Received: by mail-vs1-f65.google.com with SMTP id e7so13440245vsc.2
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 13:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36+n5U8sVhfyUiakZr1PsGSXHUS0gRvGpCkdlBVOecE=;
        b=aNu4HFX6m0g6TvS33ERFV4zbBWUBQiShpgIPl/jC+mY4jYmJeu5JXNqYEDRghfbVYc
         TiCj5pAuENKtp0Ht5M3q9SGtACZNEpSg7GjzP2FCzcYzDojkPRobriDpREQU2GU50PIt
         sEJks4NC6F/7qpixPJvcuvnGemnIs5No9ycgqOs3Yr8t3PY/hTB9FL6n/Xnseqbg16ZM
         n3ci6c8IlmdSpZo0GSTZWD+uTf4GMw37o1v+Li+eul/mkzWJADemCIi4XgvjssNzAy38
         ZJNXRTbJ/VZcoqClGdKh5qhjw+l5NZocu8j3kBK5rQo7u6RRemRAcH2DPEIp6aIIkEdt
         UpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36+n5U8sVhfyUiakZr1PsGSXHUS0gRvGpCkdlBVOecE=;
        b=c3zSmwg7YmUI6TMAPIibXpChp5lL9bj0tRUVYs2Kepn8RbMYaNoyTsz7PWWEYzDEXf
         LnUsJCPgBdqYTuOerdlAwvx68X+EObQXqRNft294t/RQkdoGz/506TtleaqQM0KB7Epf
         q1G6SLEGl4Kcwtr06uShHb7sR5ErJl++VdEfGnedMXVbCOYLueJ6rnyVOlckpHfPmlct
         D54+HWbTvwqiX4s1wtWMO8wtERxHPdLAPK6LkeoK4wxtu3eKWWZ+X9oTDkRHy9w5AaDI
         Kr544deAkhC60jjU6zdKqo3XbLhMXL0uUyNdrNSytsTlS3t+7V//7OY/gZ+1LSQmd8ti
         pegg==
X-Gm-Message-State: AJcUukfUEtbrtsOFgsPLVNO1ejSv3mVGduiO+wZB4tRrVwAjDnq7eoN8
        NNV8GkykIffh9JAPWHTGasSUtwa4SbBotnNCHMk=
X-Google-Smtp-Source: ALg8bN4p43gNQz0rvaGyt5EUnYZUr5RgQ7pAcx/r9x4JHYJ0MZJ1oWC8tmFzPBhLiaaGGzU8oZNESx3SMNuxb9PX9Zc=
X-Received: by 2002:a67:7657:: with SMTP id r84mr5635339vsc.117.1548104696654;
 Mon, 21 Jan 2019 13:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com>
 <nycvar.QRO.7.76.6.1901211702380.41@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1901212200400.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901212200400.41@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jan 2019 13:04:43 -0800
Message-ID: <CABPp-BEienJstg63Z8a09TQq+-mJf1CUwp4GWeo+odDXzzaK0w@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive machinery
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, Jan 21, 2019 at 1:01 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Mon, 21 Jan 2019, Johannes Schindelin wrote:
>
> > On Tue, 11 Dec 2018, Elijah Newren wrote:
> >
> > > Differences since v3 (full range-diff below):
> > >   - Fixed the redundant "fatal: error:" error message prefixes, as pointed
> > >     out by Duy
> > >   - Rebased on 2.20.0
> >
> >     - Fixed the "comptable" tyop
> >
> > This, and the range-diff, look reasonable to me.
>
> And now that I looked through all 8 patches, those look reasonable to me,
> too. I think this is ready for `next`.
>
> Ciao,
> Dscho

Thanks for reviewing it!
