Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454121F453
	for <e@80x24.org>; Sat, 27 Oct 2018 14:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeJ0XZW (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 19:25:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33732 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbeJ0XZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 19:25:22 -0400
Received: by mail-io1-f65.google.com with SMTP id l25-v6so2476693ioj.0
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pgh6vtb92Y9UxEqoYN5AbKC0AytYBYM1v0kD7hmRXmk=;
        b=SIFdQQKZ4Mcpdz1YscdFxIw2IVZDhz+E+Dq1agjmBTLVLv2Wov1j11whlAoVXR3GI/
         wPo2zZ7hJXpHCvakSFgvg99SrZvDuhquW/wF+Os/NtQxKngf9BXylFXQwn9HEGIPn6X5
         DzF3tMZoOpUHxvsvCCWqy2EUO+W+8Fm3YiFTFP2JkjhrmNBlFQDp2c7MxYV7ARvlCxa/
         yYuDO6TR6H87kmFExFW6NPIUGbr8M6lvEi2D+QpAD8EcRC2wkEoJJkDJ6N26SKQVUOPM
         nclq0TJelCo79yZoJpAnjssEQDs0Y5i/4rhcy5HV8OyGFIYCvBlTj1N3UurdvepjsxAU
         xShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pgh6vtb92Y9UxEqoYN5AbKC0AytYBYM1v0kD7hmRXmk=;
        b=KPYfYP+2oEnjTkOljCS1wNXbaWwzOpyJ6md19Dsa6MYH0ymJDJEt1uF+KSf7UmQHrk
         k2SQWxTOuy0o8h89A945w+GRdyB0EhoY1Azplkp3WTaEEhmVlHJv2O36+hCN78wuwiNV
         P6FOxzEsbWQN0Ik8BODFO8CVwzODBOV0mweZvsDA1mPSygWFsACQSrX2JdQc18AN/B27
         9N1z9i9AZoR46x2qpRj07DJ8h5oZXxDmmuarY6BmtTFm7XTes0f8qet344+xpXhxIpRe
         wkFfBS+fd2Db1nS/Z92Knpitm4AO01yDZaSPnbDdPn9R86tK+WodHhzqCUKQ822hDCFa
         l0fg==
X-Gm-Message-State: AGRZ1gJBTqd6QTExyH6Tf7OdXsnohjHO8QfcafUu3vkDmcISisQqpaLk
        HkIsbi9xhxvLafMTy1AjemgIQdG0ufA2r9+NqGM=
X-Google-Smtp-Source: AJdET5f8JljldWn2rn2H20waa30hczrMfdn/U9cgKCq47uM26yyen9P0HooR5AN+iKtCYUBXtfHedbb45h4Oru5RWGU=
X-Received: by 2002:a6b:6f06:: with SMTP id k6-v6mr3787518ioc.236.1540651448864;
 Sat, 27 Oct 2018 07:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181027071003.1347-1-pclouds@gmail.com> <20181027071003.1347-2-pclouds@gmail.com>
 <20181027073125.GB26685@sigill.intra.peff.net> <CACsJy8AA8ABmV5myBEETWP0uSNNFjvUP5mE705OV9=JtyHgTkg@mail.gmail.com>
 <20181027081538.GG26685@sigill.intra.peff.net>
In-Reply-To: <20181027081538.GG26685@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 27 Oct 2018 16:43:42 +0200
Message-ID: <CACsJy8DLW_smOJd6aCoRcJZxQ2Lzut5US=sPadj7=fhne0UHGg@mail.gmail.com>
Subject: Re: [PATCH 01/10] thread-utils: macros to unconditionally compile
 pthreads API
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 10:15 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Oct 27, 2018 at 09:40:13AM +0200, Duy Nguyen wrote:
>
> > > We expect to be able to store a void pointer here and get it back, which
> > > should work even for a single thread. Do we need something like:
> > >
> > >   extern void *pthread_specific_data;
> > >
> > >   #define pthread_setspecific(key, data) do { \
> > >         pthread_specific_data = data; \
> > >   } while(0)
> > >
> > >   void pthread_getspecific(key) pthread_specific_data
> >
> > The data is per key though so a correct implementation may involve a
> > hashmap or a list.
>
> Ah, yeah, you're right, I was mixing up the thread id and the key in my
> head. I think it would just be an array of void pointers, with
> pthread_key_create() returning an static index.

We could redefine pthread_key_t as "void *" though, then
_setspecific(key, data) is key = data; But there will be more changes
in index-pack.c to take advantage of it. I took a stab but couldn't
figure out fast enough where _setspecific(.., &nothread_data) should
be called in NO_PTHREADS mode (to simplify get_thread_data() to just a
wrapper of _getspecific) and got bored. It could be a micro project
for someone really wants to learn about index-pack.c
-- 
Duy
