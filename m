Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B711F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbeGWUAX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 23 Jul 2018 16:00:23 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:45792 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387970AbeGWUAX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 16:00:23 -0400
Received: by mail-yb0-f195.google.com with SMTP id h127-v6so657665ybg.12
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I3XOCbLecvYiEyE0w1Mq6E/xouwFKGXgvAlaeMBKtxU=;
        b=byrvzd8LUgHeWAQmhYjIPwdFS9y57fI7uXeT0zj0ddB4WhUY8cS7a7hzeHETo6kOvO
         fE/UoSeU14ceLMkTNkvNghvAe+Nk//73L1RbNG/f2QgYhds7zUeQag6pG5V4iRjzg2Ad
         pxS2V4uJOeu1Z4NdYjIMaGTC8M0gLrs6vE9P5rIU/pGRyYsRYxiQDwPtFto8CQBjN7ms
         AumpMbugZbmRFKHO4ccVN8zYtH4P3vGWEQdIGJhIvAqXr+XGDHZ32gqA5LzMj4lwiFpd
         azRDcFZ5WuVy0qb07iDgm0lTxbi0QhR7ywKCulrhfY37OerL5RIrlrY3TpGDz++6978m
         pu2A==
X-Gm-Message-State: AOUpUlFFWNvuj/fxGn9nwySOW+PsnMb2Ig4ITDY6GBIh0EVIpL8wPTkf
        ohEa0j5U6o+GZSeyqK8exNQkwWRAyiq7iRNTyXc=
X-Google-Smtp-Source: AAOMgpeMtMAjBU7kUV6qH2wEHseCmiUMDv2NGKaegNFWSgIOWMl9iU28e7WhRQeuO08N97TTADh+la54WONuwykjvrU=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr7620247ybl.12.1532372268666;
 Mon, 23 Jul 2018 11:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180723135100.24288-1-szeder.dev@gmail.com> <20180723135100.24288-4-szeder.dev@gmail.com>
 <CAPig+cSOZd+t17j7FSCYAydS34ZtfcRFZyE6E9fz=u7xB-01Mg@mail.gmail.com> <CAM0VKjkJoqRFmXdnuujSaiZ=hvz6MeAmgoUQNAkZ+82ZrKtotw@mail.gmail.com>
In-Reply-To: <CAM0VKjkJoqRFmXdnuujSaiZ=hvz6MeAmgoUQNAkZ+82ZrKtotw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Jul 2018 14:57:37 -0400
Message-ID: <CAPig+cQM-hdXXe6uZ768HbJ5T5QqJNKo9kuz6F=i7D+9Q-M90Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] coccinelle: exclude sha1dc source files from static analysis
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 2:44 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Mon, Jul 23, 2018 at 8:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Mon, Jul 23, 2018 at 9:51 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > > +ifdef DC_SHA1_SUBMODULE
> > > +COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
> > > +else
> > > +COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
> > > +endif
> >
> > Can't you just filter out both of these unconditionally without
> > worrying about DC_SHA1_SUBMODULE?
>
> I'm not sure what you mean by that.  Like this perhaps?
>
>   COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(filter-out
> sha1dc/%,$(C_SOURCES)))
>
> While it's only a single line, I don't think it's any easier on the
> eyes.

I wasn't worried about readability or one or two lines (indeed, you
could still do the filtering over two statements).

What I meant was that sha1dc/ contains files whether DC_SHA1_SUBMODULE
is defined or not. If the idea of this change is that there's no point
in having Coccinelle check those foreign, imported files (and waste
time in the process), then I was thinking that you'd want to omit
sha1dc/* regardless of whether DC_SHA1_SUBMODULE is defined.

Looking more closely at the Makefile, however, I see that C_SOURCES
holds only one or the other of sha1dc/* or
sha1collisiondetection/lib/*, so my concern is unfounded, which
explains why my question confused you.
