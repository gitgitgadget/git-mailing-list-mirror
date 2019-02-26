Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E463420248
	for <e@80x24.org>; Tue, 26 Feb 2019 23:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfBZXmV (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 18:42:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34665 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfBZXmS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 18:42:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id u21so11065256lfu.1
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 15:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PK2he1IH+YnBo6lwN7yM0moBtB3+uJ9AfPjeTAGQgI=;
        b=t+mJAu+2xWXxoDBHgA1p2W+ESI0C7mBgpFs53A53rnZKc6qDwJehR6SaTmgekINx3f
         f57iSWOJjACM9aGNhQg4LkIWzX+90pyysP9+rUjwNNLtZSYhLSl6QTeJ0yXMkRjefWTb
         SG5FU/C+j1qUQxUhZXmu3q6U8ZpMC6tTi+nto+KloryjeP2c5EG7Z9KXtwVRbbE8UmHL
         9c7VMBDJPMqJqZbXW3PRe67bTvCe0kZas86gGaGMx1dsMAK7GAr184tEmHAZzHDbx9b3
         lHb9NHeYyyPO3FId3vYbtk4ac8UqAlb5P58rLXM+gRoBScdf3P1RyQwpvn7Gu7RdNr26
         99Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PK2he1IH+YnBo6lwN7yM0moBtB3+uJ9AfPjeTAGQgI=;
        b=W+9UPW1LqtDBo1UYYE/6yaQHKbcz85aL+o+fWhBLplzfrlJfYz7mFDdFg0vAI0RNqm
         ASwXNLmReNUYkZwfTep335ZX6mkXzTzBR1wOv6pm4r8TWtXoDLLEGCEXcvfglrDLk5Vh
         mKYwm4uO1wB6mVOuecz12rpDI/zWz+pr34ALWkraX0JINK3PjOYrfQP1/04tNeSaqQN7
         3shTtWOP7CwVh3yDS3LlWPd8+PVZL/tA6YzyFzM+xygjVtd/fAKj2IcZIaoIqeVMpBR5
         dvygg7+GkLG2mCfKORUEGYsO+m91gdfH42WGAE8THwdTZAwlZ6E5gh+CsKF6c6TSqZzL
         BEKA==
X-Gm-Message-State: AHQUAuaLcKWidI/E2ET94qEYgLDxseN4ZGcFYiBin/IkdiJRmpKynEGN
        ZBdCti8jt5H1E6S6MY0qH8UxoaXtP6E1+KxPvig=
X-Google-Smtp-Source: AHgI3IYIs1sXv5aOLxIjqFenhgkanu/E5BPH5PHTh1LikKHRZeXXujjdG7AenV3YehkfXAG2LnaIuIUYKJ+rKVmmXso=
X-Received: by 2002:a19:c409:: with SMTP id u9mr8232729lff.32.1551224535976;
 Tue, 26 Feb 2019 15:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20190226200952.33950-1-brandon1024.br@gmail.com> <33efa988-ea80-d9b4-f4aa-3876331a1dfb@gmail.com>
In-Reply-To: <33efa988-ea80-d9b4-f4aa-3876331a1dfb@gmail.com>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Tue, 26 Feb 2019 19:42:04 -0400
Message-ID: <CAETBDP7AyYKE2gQY-HbP+LBhYwvf1QXt0-JaEQwnVyr=PjrKMw@mail.gmail.com>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrei,

> > would attempt to translate the option as a tree oid.It was also
>
> Missing space after period.

Oops, thanks for pointing that out.

>
> > +             { OPTION_CALLBACK, 'p', NULL, &parents, "parent",
> > +               N_("id of a parent commit object"), PARSE_OPT_NONEG,
>
> Comparing to other similar places, a single tab should be used to
> align "N_" instead of two spaces.

I've seen a mix of both conventions scattered around, and wasn't sure which
to stick to. I'll switch to that.

Thanks for your comments :-)
