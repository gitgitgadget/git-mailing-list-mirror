Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A491F404
	for <e@80x24.org>; Tue,  4 Sep 2018 16:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeIDUjv (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 16:39:51 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45812 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeIDUjv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 16:39:51 -0400
Received: by mail-io0-f193.google.com with SMTP id e12-v6so3429057iok.12
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOIXNln7hA1WJSOWHvAYnKYyuVfdqr0Pe7hXhnxwFYU=;
        b=D95anxZQ0LAwHq+YwHYlo9LMWIRbszuL3391563l4ublBRDStp7nO6AgLpBdCo9y4v
         IY0nKqNfq3W8MWsM22QZfAeFhjr9DAoIjb2AIsFnom6f8Jm1eiAnhwaNh+wiDAGz70Dm
         Apm3R4dR3hSKGq0GcDWXzN+0Ag01DF9yFYGNYW+d3amQewd6enZwnhjRzowtUnLKWVFr
         eCLpCggLgBUrgXwt9Wui5uk8aRvE1S0ok7+IoWZuFL06itjLtAh46UHd9DS0G2+n8BNU
         SFnXO0liiM1GbkDi3azYEJTGqPvgxfMtii6r5PwzizRxPkpCCJuetZfE6rjSa9Jkj/hx
         Ieqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOIXNln7hA1WJSOWHvAYnKYyuVfdqr0Pe7hXhnxwFYU=;
        b=MpfLfoBtucfEnCO10eSh83HZJtaOlxbkVVoBauzsUYRzdovNCDn69MoFlw+PxUwDWv
         2cQ6fVA5TlxOcF/zsXJos/5CiATjaQSBaLS2+dX9oKEswqbrsSwyMFPlrutCqkp+6l3/
         onJxQpddNLx6ICujIir6ucHOqYk/2MVX4iaFLNaBGEdzwueguvwF0lw+CPKLk5KJYOQ9
         V4/ONdcBTPfFb52quhF5y9pHTx1b+8SKYu9iuDgiDrAHTS/Qk+F3nxg8nUNNi3HU7Ax4
         nbxUhHNzW+o4MMmw5k1GHjH0GL1K2uUSxkYW5QOnQiRbf7eJvkHV/+UAu28x8gM5En13
         QBhg==
X-Gm-Message-State: APzg51Aj8RpvbyGZogVISM3UZXuMiu8d0DdS6CdsTItEQiDzfKatRvbK
        H1a7xAQPGkmklWAh7yihlQ0tvBWEmR0UbletEG8=
X-Google-Smtp-Source: ANB0VdauXmOoAI6RHGPQGRAyB+37B0EpEUukITH9T9RpIxd7bVgslSBsU+O8SMm/h9dJ3fqNx7lGX03kN/fA0Jy0FaU=
X-Received: by 2002:a6b:294b:: with SMTP id p72-v6mr21733197iop.17.1536077643202;
 Tue, 04 Sep 2018 09:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local> <87tvn8c166.fsf@evledraar.gmail.com>
 <20180902050803.GA21324@sigill.intra.peff.net> <20180902071204.GA2868@duynguyen.home>
 <20180902072408.GA18787@sigill.intra.peff.net> <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 4 Sep 2018 18:13:36 +0200
Message-ID: <CACsJy8AuWKxAdETaqYmcSY2VeLeWFyjnSYrK4GJeyG5ecv3OcA@mail.gmail.com>
Subject: Re: [BUG] index corruption with git commit -p
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Van Oostenryck Luc <luc.vanoostenryck@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 5:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >> diff --git a/builtin/commit.c b/builtin/commit.c
> >> index 2be7bdb331..60f30b3780 100644
> >> --- a/builtin/commit.c
> >> +++ b/builtin/commit.c
> >> @@ -432,6 +432,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
> >>              if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
> >>                      if (reopen_lock_file(&index_lock) < 0)
> >>                              die(_("unable to write index file"));
> >> +                    ftruncate(index_lock.tempfile->fd, 0);
> >>                      if (write_locked_index(&the_index, &index_lock, 0))
> >>                              die(_("unable to update temporary index"));
> >>              } else
> >
> > Doh, of course. I even thought about this issue and dug all the way into
> > reopen_lock_file(), but for some reason temporarily forgot that O_WRONLY
> > does not imply O_TRUNC.
> >
> > Arguably this should be the default for reopen_lockfile(), as getting a
> > write pointer into an existing file is not ever going to be useful for
> > the way Git uses lockfiles. Opening with O_APPEND could conceivably be
> > useful, but it's pretty unlikely (and certainly not helpful here, and
> > this is the only caller). Alternatively, the function should just take
> > open(2) flags.
> >
> > At any rate, I think this perfectly explains the behavior we're seeing.
>
> Thanks all for digging this down (I am a bit jealous to see that I
> seem to have missed all this fun over the weekend X-<).

And just to be clear I'm looking forward to a patch from Jeff to fix
this since he clearly put more thoughts on this than me. With commit.c
being the only user of reopen_lock_file() I guess it's even ok to just
stick O_TRUNC in there and worry about O_APPEND when a new caller
needs that.
-- 
Duy
