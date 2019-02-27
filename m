Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 003EF20248
	for <e@80x24.org>; Wed, 27 Feb 2019 22:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfB0Wp6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 17:45:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45122 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfB0Wp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 17:45:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so19797518wrn.12
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 14:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TYmbTniAjEaMifZcVG6RzasKAfxL1pTyY5iekl8nC2M=;
        b=bOAALX8NrXoozDD5OzbnEotrxe41eZz/AfiYezxRjaJKBk8cES4Kw7l4MhGKXXq0qj
         naAJArscS9httfw29kosbhm10Dy9F6uJTIghKaVETBIn8V/rT79r53h8E6ksq7ub9zqH
         OJcbwK2c63aEF19wu5+c1kczewz3+qRv1QSVC1gHOGJVEojtYW4MBkOFQ80R4ntLq2wr
         sWvO2yKvl3YSep9vkql87nYASHf2UciiRc6WXTOe/uEpFKMT5M5ANKw8LHeofopUW1It
         TT6zsw9oIFEw2INKRaMv24pWYQkHLjFE9dK7pTRDezYGZOfs76Iu5dgVonFrqwDMZoKi
         XLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYmbTniAjEaMifZcVG6RzasKAfxL1pTyY5iekl8nC2M=;
        b=Fu87sGrXffesYnt3I05g7+6thoscqwEZxANlZC/0O+j2oMrom1sG5YyE1eK1uvpnu3
         9tV3Rx3tBd61ehTn0p0C1wLr2oPtplnq0zSq1zlav/QIBZpxRlLu7euTMo9mFu9QKQ8/
         RvZwhJMDvmIgGLQscRjKSa0g8phgn0w7dGj2NDFvdWDYSP4xY1TKpmR6AebK0OkJKKEu
         XsdntUP1itTqM0gNIq+ELq9QIsgJPorcaTO200hJ7w76iG5wUXUpYSXA1kHrIGK7U065
         S2SZH4mDZjhoeQfr6B3ldJ/Tp9n/HOhfjE9wmh1OEjosihK99BUb6U4qETmd22fWOJiW
         JHpA==
X-Gm-Message-State: APjAAAXeiY81EZX3XXiHksEkKNjLZTcz0C7j29Kxh+Q5Vvj2inCy/eEp
        Yr3O4YxaESaiT3WebxlgPZE=
X-Google-Smtp-Source: APXvYqyEkLTs5ubS7f+Y+izoAin42IoJZeYSZ4mBRIBQIE5QJBzIl6PLt9hxlDLrvhn3w03hjYKaiw==
X-Received: by 2002:a05:6000:1185:: with SMTP id g5mr3831360wrx.299.1551307556172;
        Wed, 27 Feb 2019 14:45:56 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id i16sm14140876wru.16.2019.02.27.14.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 14:45:54 -0800 (PST)
Date:   Wed, 27 Feb 2019 22:45:53 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP RFC PATCH v2 4/5] clone: extract function from
 copy_or_link_directory
Message-ID: <20190227224553.GS6085@hank.intra.tgummerer.com>
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
 <20190226051804.10631-5-matheus.bernardino@usp.br>
 <CACsJy8BztC=GNuPU_CuLbPSmhsjrSk8MmkyeK6ahgjEOzY=yOQ@mail.gmail.com>
 <CAHd-oW5aOf+TE_AeA=VkaZUt7LTeSK_buojsEgb3NYMVVm1B_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW5aOf+TE_AeA=VkaZUt7LTeSK_buojsEgb3NYMVVm1B_g@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Matheus Tavares Bernardino wrote:
> On Tue, Feb 26, 2019 at 9:18 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Tue, Feb 26, 2019 at 12:18 PM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> > > +        */
> > > +       struct stat st;
> > > +
> > > +       if (mkdir(pathname, mode)) {
> >
> > Good opportunity to unindent this by doing
> >
> >     if (!mkdir(...
> >          return;
> >
> > but it's up to you.
> >
> 
> Ok. But being such a small snippet, is the indentation really a code
> smell here? (sorry, I'm still getting used to git's coding guidelines)

I don't think the indentation here is too bad here, but I think the
code is slightly easier to read with less indentation, and it's easier
to see what's happening in the success case as well without reading
the whole method.

And since this patch is already refactoring code we could do it here.
I don't think it's a very big deal either way, which is why Duy left
the decision on whether to use the suggestion or not up to you.
