Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AD51F462
	for <e@80x24.org>; Mon, 20 May 2019 21:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfETVic (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 17:38:32 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44259 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfETVic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 17:38:32 -0400
Received: by mail-ua1-f65.google.com with SMTP id p13so5841441uaa.11
        for <git@vger.kernel.org>; Mon, 20 May 2019 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9EeGxY4se8wmjoRLn71XdOn6UuW9h4BvIOISfBgFZ4=;
        b=tvK6Y4hyDzVcAhnVcrXn7vPC+cJwJM+JZfWNOIg8NYqs5BfyE6suF2dicD7LmP8DL6
         8oKtQKxtook6BfKvw5thP31jXQ2gnBIoJGRUUssXXTLKl1tbQ2iaIzHAEglEqJD/dr49
         5ovtibxBdUt1fHQwwuY5UD0oZH5lpEJ4RdYOg+PQDyOBg/tBGnlfqsTooNN9jljMnJ7F
         6O8qCQb01kNMu80IFIJAXjbVfGD8vCcP9P+ziNaLrH0iXFOJ2dwupPVP8xRKqglIHNeO
         GyLJ8w+0arl/Ok+kjD0Lp22bWupdgrdUSJalm0OuQdIKkyLJXLIIRTuZLjx/IN0h6F3j
         Gesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9EeGxY4se8wmjoRLn71XdOn6UuW9h4BvIOISfBgFZ4=;
        b=V5ywmHpZ60eNHmUWk+Y6QPFnqwJ/6Bu3L3f/UURVqRuMn1zp/mPyznImvolokopvac
         WlhUWmT6RP8Z2+EfZbztE97QNicbTksZtYYbO5ZAGDa9kiSW/NtVIKlD6O4XGUgw3S8G
         eNzquW6lYYYBcs+RXS4qHaf0KhxwQWNIewsJsX1Fl6Qzsm2B4zaw3FDzhWFXQslrCcdy
         H6W1/yFcdM0BTp3UoaqAWiOGZx5vQZieiehIxHIqE7opMH3aP83rksWao25ZmC301E/M
         QJUFjHvyWle/YFhK99Rw2UCUudUUcK3FgNMixAjpEesFT7BGJ2paPaln3e66Qv7r11Kb
         jxdg==
X-Gm-Message-State: APjAAAXEfJeYfRFYsl8Q+xeB18IlOkW1TNChLz8fBDMvnOueRWVgbTQy
        HJ2JiKELQ0QWqKjN77PQ2Oal4N3hd481QrXViFY=
X-Google-Smtp-Source: APXvYqyCxjuMQwvVczEOTO8r0Ufc2wNlL2aQWAhDhKtcS2aDc1APZfB3Ft3xSqeS5Fi9O1ysTJA7t7i5A7U63NKoNeY=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr35243491ual.95.1558388311391;
 Mon, 20 May 2019 14:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com> <20190515233230.GA124956@thyrsus.com>
 <87woiqvic4.fsf@evledraar.gmail.com> <86woimox24.fsf@gmail.com>
 <20190520004559.GA41412@thyrsus.com> <86r28tpikt.fsf@gmail.com> <20190520141417.GA83559@thyrsus.com>
In-Reply-To: <20190520141417.GA83559@thyrsus.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 May 2019 14:38:20 -0700
Message-ID: <CABPp-BHK1N2zZoeBeSgnh12LPqLgZxfbL0DzALj28y97_Q-ahg@mail.gmail.com>
Subject: Re: Finer timestamps and serialization in git
To:     esr@thyrsus.com
Cc:     Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, May 20, 2019 at 11:09 AM Eric S. Raymond <esr@thyrsus.com> wrote:

> > For cookie to be unique among all forks / clones of the same repository
> > you need either centralized naming server, or for the cookie to be based
> > on contents of the commit (i.e. be a hash function).
>
> I don't need uniquess across all forks, only uniqueness *within the repo*.

You've lost me.  In other places you stated you didn't want to use the
commit hash, and now you say this.  If you only care about uniqueness
within the current copy of the repo and don't care about uniqueness
across forks (i.e. clones or copies that exist now or in the future --
including copies stored using SHA256), then what's wrong with using
the commit hash?

> I want this for two reasons: (1) so that action stamps are unique, (2)
> so that there is a unique canonical ordering of commits in a fast export
> stream.

A stable ordering of commits in a fast-export stream might be a cool
feature.  But I don't know how to define one, other than perhaps sort
first by commit-depth (maybe optionally adding a few additional
intermediate sorting criteria), and then finally sort by commit hash
as a tiebreaker.  Without the fallback to commit hash, you fall back
on normal traversal order which isn't stable (it depends on e.g. order
of branches listed on the command line to fast-export, or if using
--all, what new branch you just added that comes alphabetically before
others).

I suspect that solution might run afoul of your dislike for commit
hashes, though, so I'm not sure it'd work for you.

> (Without that second property there are surgical cases I can't
> regression-test.)
>
> > >                                                          For my use case
> > > that cookie should *not* be a hash, because hashes always break N years
> > > down.  It should be an eternally stable product of the commit metadata.
> >
> > Well, the idea for SHA-1 <--> NewHash == SHA-256 transition is to avoid
> > having a flag day, and providing full interoperability between
> > repositories and Git installations using the old hash ad using new
> > hash^1.  This will be done internally by using SHA-1 <--> SHA-256
> > mapping.  So after the transition all you need is to publish this
> > mapping somewhere, be it with Internet Archive or Software Heritage.
> > Problem solved.
>
> I don't see it.  How does this prevent old clients from barfing on new
> repositories?

Depends on range of time for "old".  The plan as I understood it
(which is suspect): make git version which understand both SHA-1 and
SHA-256 (which I think is already done, though I haven't followed
closely), wait some time, allow people to opt in to converting, allow
more time, consider ways of nudging people to switch.

You are right that clients older than any version that understands
SHA-256 would barf on the new repositories.

> So let me back up a step.  I will cheerfully drop advocating bumping
> timestamps if anyone can tell me how a different way to define a per-commit
> reference cookie that (a) is unique within its repo, and (b) only requires
> metadata visible in the fast-export representation of the commit.

Does passing --show-original-ids option to fast-export and using the
resulting original-oid field as the cookie count?
