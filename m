Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0668E20248
	for <e@80x24.org>; Thu,  7 Mar 2019 01:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfCGBxX (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 20:53:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38529 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCGBxX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 20:53:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id k136so131774lfg.5
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 17:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AZfZTU3z5etlTN8EeeL/pa8/UFuVBVSvtUrzIaJ3tAs=;
        b=lYBqdMNKlLtAcOaCuqNnA1Tcw+4eUFAp/KIoLbot61rcA+ZWFWcj0i13Bo7qwqwl+L
         u0g1mBqWVUIWwKSQ/wCM1CulYhkiMwCkiOpw7kIylkluqlo/dVhfGwCtvOoEjK6pstdz
         zN/UMQf+7eQoLjN0W5JLDfbz4yluoSQFTV5hRhCW6tlhsfRaivV+5aUgux6xul+G5vHd
         m5OgtbCa7jQMXblXazBl0IuGgM9p6Bhnz3yhxpXg8Eso8wB4bDkKwrN07E6XZFnDqxkH
         k3cbhKKAGt03cwXfIPPH1C+q52Z59Bfd1QN7TLxwJc7lRBuruqrfIqWL0J7MnSl4H2XL
         t6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AZfZTU3z5etlTN8EeeL/pa8/UFuVBVSvtUrzIaJ3tAs=;
        b=qzzmeG1KTv96NHhXwrEiOY8jGbZZfF6k82AJXfNwpbgwNty+rYpyO1q44vN8qy/mIF
         5ahesDirmohjq/JoIDn7eIDzBCOIAsSB9kIYYFDWjG+jQ4i1RrsnlR42yMRYaw/Uoytw
         1n2F6/Dh+75GtsyoiuslYti886ZQp7QDb40eOOkUb5VpFERryBSIZRh6Zi4CSGtHQqxT
         BFxSpQoK+nTulVEOXmTlcYUWMefN9RJjQlOYbaqXUs4mX0inM209Nf3nnn673umI0M7I
         hnBbD8HiEQw12vj99BYCV02ci96ilCzXu2geOlQ72E00dCQCFOzdL4lHTENTYH3wkyIM
         6nRw==
X-Gm-Message-State: APjAAAVnff6PfD4ejnobKY5VBmtGcz+HrPLS0G9iPSEYhtMdtZMAKFtg
        y2an3LRZ6JdAoXDuHBVTPjjP7872c6Pu1Y+kiFI=
X-Google-Smtp-Source: APXvYqzbHmTIiLLBcDNHx1XOmhoqOJ3rHCA+IIDU64OmMx/ZJe1bPYYpcsLWoXqB13uKral4ch1GVGbDWvKUH5Jnshs=
X-Received: by 2002:ac2:4192:: with SMTP id z18mr5405023lfh.39.1551923601131;
 Wed, 06 Mar 2019 17:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20190305154951.4407-1-brandon1024.br@gmail.com> <xmqqy35rpp13.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy35rpp13.fsf@gitster-ct.c.googlers.com>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Wed, 6 Mar 2019 21:52:55 -0400
Message-ID: <CAETBDP4MUN6pV2-xC=qsxnVynHuexOkU-nYbQ1OWeNGwBt3-Ng@mail.gmail.com>
Subject: Re: [PATCH v4] commit-tree: utilize parse-options api
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 6, 2019 at 7:21 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > +When mixing `-m` and `-F` options, the commit log message will be
> > +composed in the order in which the options are given.
>
> It may be just me, but this new paragraph made me think that we can
> give at most one -m and one -F option at the same time in any order,
> and multiple -m or -F options are not supported.  That, obviously,
> is not the impression we want to give to the readers.
>
> Even when you are not mixing -m and -F, but using -m more than once,
> the log message will be composed in the order in which options are
> given.  So probably the word "mixing" is the primary culprit of
> making the sentence easier to be misunderstood.
>
>         When using more than one `-m` or `-F` options, ...
>
> perhaps.

Good call, 'mixing' is not the right word here. Will fix.

> The change to this main function looks quite straight-forward.  I am
> kind of surprised that a very low hanging fruit like this had survived
> without getting hit by parseopt a lot earlier ;-)

I was surprised too, commit-tree hasn't seen much love over the years.
There are certainly others that could benefit from parse-options.
