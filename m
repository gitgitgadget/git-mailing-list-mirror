Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE521F453
	for <e@80x24.org>; Thu, 14 Feb 2019 22:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfBNWEI (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 17:04:08 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53835 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfBNWEI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 17:04:08 -0500
Received: by mail-it1-f195.google.com with SMTP id x131so17974725itc.3
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qIZF4S0owid7ufd5kSGCvAvy+kafbeufIQPC4TAvW8=;
        b=FhlC1Ul//gmTWKJIul5WQzuELwTlHuxUsqiN87D4/s1OFA8kFEljluhCk26+A2Hdae
         N+LEWZ+eCI7KJ3fG3C86fKIE+nesIUUqXuZUzwl1H1uL1SQp8+RuR8jyAgkW6EvOdxLx
         pFvaZSwjXHcIX8CGFi3GrnVS5idjyDyA1O6X5susrKJ6boz6j1hD1iXE67VFKo8pV8/5
         i7+dgo3bnAVoc0WbJkvWbFjCCxSicTluiBFbmcQUjY1Mca6sFW5Etl2nK6UiZCj1DMEm
         YQGXW4hVqBFtp8muTmG8R2uPpHrd85kijUJSZpkLs2RpVXcTWs/rWaRtBetpDOnmwOOJ
         CmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qIZF4S0owid7ufd5kSGCvAvy+kafbeufIQPC4TAvW8=;
        b=HUW4A1ZT/D5HPJ1u2nuGyrPBMnygcpHXElINhWE1FWWQ5sGZTxrqtyiEXma2tRw/tJ
         Z/jnWNEJOhmZNZy2DdLXdqdjfH6+7RyNSwwwBcK94aTLXU1C4M/JdUXfuZimRAZoO6Bh
         uZJv6baXMVAPeih9wdL1mYILuEeygWHou+/A8pzbERDD7Og84ZSLUSmpOhaCTZFYMgin
         n3xeUuIcRBOKTU45KyFyfSVgL3E7TFOdHbmObLGOpH16DXIqHzs8cOyn2zQANigZo+Cv
         yVyM/jBESJDuqlX9OCv/ba+MLmfdEq4QH8iuTa4a7g3zfqra0Lw069QU+1jb12x8MPFj
         SotA==
X-Gm-Message-State: AHQUAuZ4KIDFNNOaTcibd/xk7wVgUbvtp2aeRG/P/JaxeusVpriXcMJo
        UAxIfv94FEb0NTLPMXaM0KEolUIjh8zqOeyjTzhTbQ==
X-Google-Smtp-Source: AHgI3IYIShgcMhqrQDSTgil2+DTr/3EsfgJ8btYA4Q9LQSeUjvhzXLZ7q6agW1At5oRnCnPNeI1L4DFzwYdeXm8610Q=
X-Received: by 2002:a5d:88ce:: with SMTP id i14mr4405163iol.66.1550181847181;
 Thu, 14 Feb 2019 14:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20190213205554.4086-1-matheus.bernardino@usp.br> <CAP8UFD1aBn8=KOTp-D=CmO1iEnWUBS1-jR-aqfg3MZ7HZRU7Pg@mail.gmail.com>
In-Reply-To: <CAP8UFD1aBn8=KOTp-D=CmO1iEnWUBS1-jR-aqfg3MZ7HZRU7Pg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 14 Feb 2019 20:03:55 -0200
Message-ID: <CAHd-oW6uHKfa_P+fZNZxG4+pme=SH_Wi+SJkhxwOtfR+L=0JBA@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH] clone: use dir-iterator to avoid explicit dir traversal
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 7:16 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Feb 14, 2019 at 1:16 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > Replace usage of opendir/readdir/closedir API to traverse directories
> > recursively, at copy_or_link_directory function, by the dir-iterator
> > API.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> > This is my microproject for GSoC 2019. It's still a RFC because I have
> > some questions. Any help will be much appreciated.
>
> Thanks for working on a microproject!
>

Hi, Christian. Thank you for the review and comments.

> > There're three places inside copy_or_link_directory's loop where
> > die_errno() is called. Should I call dir_iterator_abort, at these
> > places, before die_errno() is called (to free resources)?
>
> I don't think it's necessary. We care about freeing resources when we
> report errors (for example by returning an error code from inside a
> function), but not when we are exiting.
>

Ok, thanks!

> > -static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> > -                                  const char *src_repo, int src_baselen)
> > +static void mkdir_if_missing(const char *pathname, mode_t mode)
>
> It looks like your patch is both splitting copy_or_link_directory()
> into 2 functions and converting it to use the dir-iterator API. Maybe
> it would be better to have 2 patches instead, one for splitting it and
> one for converting it.
>

Got it. As the justification for splitting the function was to use the
extracted part in the section that was previously recursive, I thought
both changes should be in the same patch. But I really was in doubt
about that. Should I split it into two patches and mention that
justification at the first one? Or just split?

> >  {
> > -       struct dirent *de;
> > +       /*
> > +        * Tries to create a dir at pathname. If pathname already exists and
> > +        * is a dir, do nothing.
> > +        */
>
> I think we usually put such comments just before the function. And
> maybe it could be shortened to "Create a dir at pathname unless
> there's already one"

Right, the shortened version does sounds much better, thanks! About
the comment placement, I followed what I saw in other functions from
the same file ("copy_alternates", for example). But also, I couldn't
find any instruction about that at Documentation/CodingGuidelines. So
should I move it as you suggested?
