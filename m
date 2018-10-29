Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8083B1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 17:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJ3CL3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 22:11:29 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52819 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeJ3CL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 22:11:29 -0400
Received: by mail-it1-f194.google.com with SMTP id r5-v6so8512842ith.2
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JiD0gIw7wxF5ck8999pCl1gfg/q2D4XHV85r+hzbwBg=;
        b=uKSHYNwkx7M06esTBMhdVF7OiPOUOPyNAkQeUEE6RfbXtLoeLIipqyGXMWQDfIq0Ha
         c3q/mGHdincGfVSKpv5zHf5fmwNyUdsTHYxJL80Z+6xMusqzU6YNxAFcoOl342UrQoDI
         75O7IttfHfucoRbCPqRp/a1hRfkWOLNU9NaCwd6vkRKwa0ubWm7ct9T/KU013l36I3wn
         Gp6LEkc1SN1WpeAPJCq4JBnN77opTLc2gJmBg3wKrTNysvXXd/KA5uLNn+cMljJEjObf
         fp49cI9Q9EvupsE6p73ZfGcOtGClocJ2ju/BpK7xN1R//uxZRRMA9D2cWe1EwCEDwgrF
         Qh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JiD0gIw7wxF5ck8999pCl1gfg/q2D4XHV85r+hzbwBg=;
        b=IpZWT0zUZvFClqKFrCigZTdVUrNL3jgFeBXaXJjKngnU1N9ooiukqeSjhUNqxkH5LD
         AX+qmYTxKqb3yOfl3qsgEfVaIB16EtrVSNDbk/s9OC5EvM1WvdDyBtt+WiDwBUHxH+7E
         VbvUkPcZ8JKN3HJJFF18COnTVt4e8+4S25HUCy39UqtAHvKmFJiT5XZIRWCdatR2c5Qt
         LoUiguq/BD0zR0U1qm2oTCAw3f/Hvuts7VTGsx6NaBPoF7yaBzWJs0psTJ4jms5kludc
         SvuSD4gMwaVCjh46Wbxj5SL8U7kPYpad7lmWJymWgok1X+v01BAGJ73ZQhksUbx2REkL
         BnGg==
X-Gm-Message-State: AGRZ1gI+YGmC0YxhtB5IJPF/kRdG3AYKd3zMXHQXSC1g5C2NxP75OEd2
        OOPPvbFZwqeKFft1liXSThi4S2MG/v8OBYYKZTQ=
X-Google-Smtp-Source: AJdET5fBUo/VluZxCwX2ARArfFRmNeufbihk2Ki3swmwsm76V+uWfAQa/rfUvZErOC1rlr2QwnVaRXudGzrzn8r3Ais=
X-Received: by 2002:a24:b64b:: with SMTP id d11-v6mr1850787itj.10.1540833717227;
 Mon, 29 Oct 2018 10:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181027071003.1347-1-pclouds@gmail.com> <20181027071003.1347-10-pclouds@gmail.com>
 <9e489011-36b9-a8b3-838d-de1a097f4854@gmail.com>
In-Reply-To: <9e489011-36b9-a8b3-838d-de1a097f4854@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 18:21:30 +0100
Message-ID: <CACsJy8BD8nUfJoNjWCnaYgUn5+LaunOx74AgwPf5okG0OhwEXw@mail.gmail.com>
Subject: Re: [PATCH 09/10] read-cache.c: remove #ifdef NO_PTHREADS
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 6:05 PM Ben Peart <peartben@gmail.com> wrote:
> > @@ -2756,8 +2745,11 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
> >       if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
> >               return -1;
> >
> > -#ifndef NO_PTHREADS
> > -     nr_threads = git_config_get_index_threads();
> > +     if (HAVE_THREADS)
>
> This shouldn't be needed either.  My assumption was that if someone
> explicitly asked for multiple threads we're better off failing than
> silently ignoring their request.  The default/automatic setting will
> detect the number of cpus and behave correctly.

No. I can have ~/.gitconfig shared between different machines. One
with multithread support and one without. I should not have to fall
back to conditional includes in order to use the same config file on
the machine without multithread.
-- 
Duy
