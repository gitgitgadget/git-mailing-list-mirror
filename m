Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02E01F731
	for <e@80x24.org>; Thu,  8 Aug 2019 15:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbfHHPUF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 11:20:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44885 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfHHPUE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 11:20:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so69825882otl.11
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vVP8o6AXywWLUkhBozMD+VTNqBjm5oArI5B5gBlS6Yg=;
        b=B1DNrTMuKJG0dF37usmn1v4dnqAX3OSyS2v20ge9W2Wjrk4P0Iqn6ySVuAeHWDNZ26
         E6/YkfweuPuxFylYhRirE9C1BTDDWB8BKWW3/EGCucqMo9eJfZXxGULbyp0brFuyJf2F
         5OYvKczgPSDRuauc/kwzi3Cmd6DLvOFOm36jEp2hfDcCvWqyyltmi6zEdM5JEDoYaWlF
         M/wnWI+6vM3JCJcycgDi5s+u6OEIegkjASe69QRRl69n7XAUGyvqAEdymiRDnkqnBHo3
         NmvTZkjBRoHd6OeG30Y4lICTXJrArle8zr8JiK1H9tCQ07JDiB+U2cHB8xIXSGdRI5wg
         OmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vVP8o6AXywWLUkhBozMD+VTNqBjm5oArI5B5gBlS6Yg=;
        b=CpLC0hp0e4NyIvDWaPxjiMsJFUVL9tYVADtb7vwuUNBikeS9VDwAqCxCQ5PP7zXyn1
         2paJ17BLd9NeyX91bkk6+Z5LxZHD6DgyhkQ2kbjPpb00Cx3emKeYsakBiACPyf+tZpbP
         KwvwCGJRjB9zvhJB/NRSD4ZY4p+9gtCpfYkm5sG8GHgaLk85i/rZvWdxqNjOaSzTXgaS
         2taj94508boSzom3tNCnKn6c73SR1U9YgaOsKS8VduP1Kp3cjaXX+JK6m73W0lCzLeE4
         hZj9ilFJR0fQLiN5TyfviX/VZht9KzyO51YO1NFusnV6UMsEq5S3ViMABjs5j8ALKBV4
         /eFg==
X-Gm-Message-State: APjAAAW3dXAcFdYhuw0aSB3OyJHNRmLytOCchnhFpripBXmApj7cROFb
        wgyQOKhsor1CS2NL0NWxn6aQl7/vm54xexymWCw=
X-Google-Smtp-Source: APXvYqwq6EJwUs4tSlqR6svQveLNR3vD+9zi7yRmFl9sAp144T9PQbSGMv5VEPYkPzA8mV+lcPWHKFsg/MiQdr76ms4=
X-Received: by 2002:a6b:b804:: with SMTP id i4mr4119929iof.205.1565277603345;
 Thu, 08 Aug 2019 08:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com> <20190806085014.47776-1-carenas@gmail.com>
 <20190806085014.47776-2-carenas@gmail.com> <nycvar.QRO.7.76.6.1908081552440.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1908081552440.46@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 8 Aug 2019 08:19:52 -0700
Message-ID: <CAPUEsphLZ+x1hL+=8P+bh34mR6pUcXB5Qd2htj4AzUjjrKC=nQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] grep: make PCRE1 aware of custom allocator
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 8, 2019 at 6:55 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> On Tue, 6 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> > 63e7e9d8b6 ("git-grep: Learn PCRE", 2011-05-09) didn't include a way
> > to override the system allocator, and so it is incompatible with
> > USE_NED_ALLOCATOR as reported by Dscho[1] (in similar code from PCRE2)
> >
> > Make the minimum change possible to ensure this combination is supporte=
d
> >
> > [1] https://public-inbox.org/git/pull.306.git.gitgitgadget@gmail.com
> >
> > Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> > ---
> >  Makefile |  2 +-
> >  grep.c   | 10 ++++++++++
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index bd246f2989..4b384f3759 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1764,7 +1764,7 @@ ifdef NATIVE_CRLF
> >  endif
> >
> >  ifdef USE_NED_ALLOCATOR
> > -     COMPAT_CFLAGS +=3D -Icompat/nedmalloc
> > +     COMPAT_CFLAGS +=3D -DUSE_NED_ALLOCATOR -Icompat/nedmalloc
>
> This pretends that all custom allocators are selected at build time,
> something I tried to stress in my commit message as not true. You can
> pre-load not only nedmalloc, but also jemalloc and unless I am mistaken
> also tcmalloc. And mi-malloc.

the patch only fixes the case when NED was chosen at build time, which
before this patch meant that the system allocator was used by PCRE1
and NED by git.

That combination happened to work unless any pointer crossed over but
neglected any benefit of using NED instead of the system allocator
with PCRE1.

the PCRE1 API was therefore safer to use, PCRE2 is not and that will
be addressed[1] in a future version by making sure this "layering
violation" is covered

runtime custom allocator changes are not affected and will keep
working as usual, which (at least in Linux when using LD_PRELOAD which
is probably what you are refer to by "preload") means that the dynamic
linker will replace all calls to malloc/free with the ones you
provided at exec time and before it starts the binary (including
whichever libraries it loaded) and therefore will make both git and
PCRE2 to use the same allocator.

nedmalloc seems (at least in Linux) to be smart enough to cope with
pointers that were not allocated by itself and doesn't crash so
presume there is something else in Windows (maybe the dynamic linker,
if there is one) that might be also part of the reason for this
segfault.

of course, the trigger of this is my patch, so I'll take the blame for
this bug regardless and I am looking forward to a fix

> So the premise of this patch, that you can tell at compile time that a
> different allocator than the system one will be in use is simply
> incorrect.

in the context that the only available (and integrated with our build
system) allocator is NED at compile time, I think it is correct.
you are correct though that if another allocator will be added as a
compile time option, we will need to do something similar as well.

Carlo

[1] https://bugs.exim.org/show_bug.cgi?id=3D2429
