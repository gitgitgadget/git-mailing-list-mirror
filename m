Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ED5C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 07:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D581F206F4
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 07:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFBf7tN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfLHHxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 02:53:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46938 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLHHxp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 02:53:45 -0500
Received: by mail-ed1-f68.google.com with SMTP id m8so9596416edi.13
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 23:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXjdPshW1fiEQELmf1ZSah8N+tO1lfLfVAT6mLUMpJQ=;
        b=YFBf7tN0sam/3iJzoDzi2PvnCXIANYRoPYOrPThkBZ8fNFfAb6l7CwiIvlk0xuW104
         2eT2gPi28SBPynKssS3bpIh2tRjKUeZbR+J1qjamWqON+ly96XXFdiBPVg6P8nhRJEms
         tmWMVoXM2JR5tl0gNlmu0OsDd6OFzBAZrT2Jh3U/afR3VOKDu2SrnVvpZEj+axE9DdTk
         6ntOm74NdbdX7TCMvJLZUxvlz53ml26omqoqLibbgQaXtLJZb9EFnVO5fPwAjKoH/xlv
         xY77tKVuFr4OyZwD26HMpiGcRSUvOk7arMK99wg/YPTHNmMGaCeG5AE0X7Xb4I2r0ygS
         iljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXjdPshW1fiEQELmf1ZSah8N+tO1lfLfVAT6mLUMpJQ=;
        b=P32ocMgutQjC5JWrFZFz5lYPTGmNBKtHOYDvLu15/jGkMEMZ3Vbfvy/dpUSW+btF7x
         j2pFM9eORVlJELJ3Uqj/umR7gFy5gg9adzmLnkduZ8wFaOsG8MKys1Hw4EfBOHG2vn7Y
         8wTnb/SkB3H2Y+XXlGO9j6TnNVdAXd9OJFgbQn7sSRRvflw27sXTsuxKX8ogp/n4CF7f
         OZ/SBdjR0Px3YnPs/kTtxcOUN+BxLw840zCShjD/bCkAcEtTgYV6R7WzfiR+93JMLtfr
         ai3qJtHctSYxdOSgt5RRA3TmNoJaxHx5Sa+Sdj7VRWVFuM0DTyNUegOz/754JXtwU/RH
         Manw==
X-Gm-Message-State: APjAAAWXK/4Ud5qSJVQyLVhL22xJeGuWZ7SDdp+bHrpNAqMP69KG8z/u
        bJALT1AOq/P4T3yHw4XFPBeiC5u8uh944c3OxGg=
X-Google-Smtp-Source: APXvYqxqe7InCETAAYHuqm19m+/D/dTIxJyiWh7x6dvzYIvdTTlASBMVN33vDelggJ52sIPeCCsbN+lEkTglWiVN4O8=
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr24335357ejj.6.1575791623354;
 Sat, 07 Dec 2019 23:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115180319.113991-1-jonathantanmy@google.com> <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com>
 <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com> <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD20LMxuV7KWAvobybHYZruDiADX-yOFPLyMxsHS7HZN0g@mail.gmail.com> <nycvar.QRO.7.76.6.1912072145290.31080@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1912072145290.31080@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 8 Dec 2019 08:53:31 +0100
Message-ID: <CAP8UFD1rmv7dvWBe5=dnrh8icfsE_PWEukmuUmqB9dWJ9NQTkg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Sat, Dec 7, 2019 at 9:47 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Sat, 7 Dec 2019, Christian Couder wrote:
>
> > On Fri, Dec 6, 2019 at 10:42 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Junio C Hamano <gitster@pobox.com> writes:
> > >
> > > > Junio C Hamano <gitster@pobox.com> writes:
> > > >
> > > >> Jonathan Tan <jonathantanmy@google.com> writes:
> > > >>
> > > >>>> It could be a good idea if Peff could answer some of the comments made
> > > >>>> by Jonathan Tan about patch 9/9.
> > > >>>>
> > > >>>> I have put Peff as the author of all the commits.
> > > >>>
> > > >>> Thanks. I think the series looks mostly good except for the questions I
> > > >>> raised in patch 9/9, so I'll wait for Peff to respond too.
> > > >>
> > > >> Hmph, the round before this one has been in 'next' for quite a
> > > >> while, so should I eject it before waiting for Peff to respond
> > > >> before queuing this one?
> > > >
> > > > After rebasing these v3 patches on top of the base of the one in
> > > > 'next', the only difference seems to be the log message of 3/9 and
> > > > the contents of 9/9.  I guess I'll mark the topic as "on hold" for
> > > > now before doing anything, as I am officially taking a time-off most
> > > > of this week ;-)
> > >
> > > So..., that week has passed---anything new?
> >
> > Unfortunately, no.
> >
> > If you want I can send an incremental change on the content of 9/9 on
> > top of what's in next. Otherwise I can't see what I could do on this.
> >
> > Peff, could you tell us if you might have time to take a look at this soon?
>
> Chris, correct me if I am wrong, but was it not your decision to
> contribute these patches?

Please take a look at:

https://public-inbox.org/git/3E56B0FD-EBE8-4057-A93A-16EBB09FBCE0@jramsay.com.au/

and Peff's response to James Ramsay's email.

Peff wrote:

> It's been on my todo list to upstream for a while, but I've dragged my
> feet on it because there's a lot of cleanup/polishing from the original
> patches (they were never very clean in the first place, and we've merged
> a dozen or more times with upstream since then, so the updates are
> spread across a bunch of merge commits).

and then:

> Yeah, I think we should work on getting our changes (including those
> stats) into upstream.

So actually I thought that I was helping Peff on this, though I know
of course that it's also helping GitLab and everyone else. That's why
I put Peff as the author of the patches.

> Are you saying that you do not understand them
> well enough to drive this patch series forward (e.g. address all reviews
> and questions) and are basically trying to force Peff to contribute them
> instead?

Yeah, I don't understand them well enough to answer Jonathan Tan's questions.

But no I am not trying to force Peff. I am trying to work with him.
When he said he thought we should work on getting the change into
upstream, I just thought he meant it and would be willing to help.





> Ciao,
> Johannes
