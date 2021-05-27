Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A0BC4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 22:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941A06113B
	for <git@archiver.kernel.org>; Thu, 27 May 2021 22:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhE0WFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhE0WFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 18:05:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C5C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 15:03:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lz27so2336387ejb.11
        for <git@vger.kernel.org>; Thu, 27 May 2021 15:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=aG93ICXJJpl6MQ59aMc2DkWp4bvllEIo+kbBhNHR5XM=;
        b=uo2EUmno5/kN7JvgFZew37thzeLoucYofqSyDszF/JQISclw3FDTnVPfmGFsf5Lyv5
         V7M/G6VgF2/ZRl1UrRlbKaHgW7GQLmhK4Opx0sBOSTtqJsZvIQvxEbiqiTmL6oG79mp4
         0bMcPvvVuhttwEhWffsFm/XkM8OI1F2Fh1g3k7P2cpaBwN1RwRW2vl/l1g9NrBItXlnv
         AfnYOJQmTLHoPTRGWKD8UX8gR5ERg7MOnkWq/dd+LbU6mXRXOZd4UkzlpcDQOwcRcq2u
         x/nvUTRdj5UHuh+Rw1pYuXOthBtRMhrEhzzLdlsWTkkvPgZ5rhbaCRWus+WHhNGIlPVe
         TQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=aG93ICXJJpl6MQ59aMc2DkWp4bvllEIo+kbBhNHR5XM=;
        b=sMzfeM4ESQ8qu++JY9A+hjH29i1gK6Vke62PlJdoPIjBAd1UagLoM2SFEaYqwLqWvQ
         DTkZGnWAIgV21glNX3HVzdKoTsI7Y0o/uFCxkdsYkgnf7TAgoiNSrl1kjtjS+R3pI0KD
         GlWrOZ+2hn4IhcDJTjSvwQh6eLzztz9g5ktkF5XeDt4r8OiukUz13e1Viv3iGQuscNL7
         W1W3zFMXIZOLiCh0cetW0BKh32x7dX/TF27PqryzI0aPolBsA+CfCBn6ubexnird61QS
         GBulCYpzEgHcYFXnV4cDHR3U2i79NqBkKeAkzajjjqlWzSmWDsc29Ur7W1pPQcukL5e2
         /cxA==
X-Gm-Message-State: AOAM532EVfQufYWIAQSZojgces4fpdeSKeYWFln8U3GitsBsOVKXwko2
        IDjFmZLcyfW8aA0948fPEnM=
X-Google-Smtp-Source: ABdhPJz8J1fQwh0M1nbkcJZsYEPWYZB+wuy6BgFYsvpDttN1Fpmvm6RbHqZolb9ugWMxKECg/uwAWg==
X-Received: by 2002:a17:906:408d:: with SMTP id u13mr6273539ejj.128.1622153005634;
        Thu, 27 May 2021 15:03:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l6sm1757663edr.47.2021.05.27.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 15:03:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Cc:     Kevin Daudt <me@ikke.info>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Should we do something with #git-devel on Freenode?
Date:   Thu, 27 May 2021 23:54:32 +0200
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com> <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net> <YK6XvmrtrdkJvsnI@nand.local>
 <YK6o/j7P0JIGW0Q0@alpha> <7e9683aee2c0fea2ff77b82bfa547e15@jk.gs>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <7e9683aee2c0fea2ff77b82bfa547e15@jk.gs>
Message-ID: <87im33ltqr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 27 2021, Jan Kr=C3=BCger wrote:

> Here's a bit of an update on the situation.
>
> freenode has, indeed, scorched the earth by destroying more than 700
> channels, simply for mentioning Libera in the topic (before they even
> added a rule that forbids this). I was willing to wait and see how the
> "new" freenode was going to pan out, but with stuff like this happening
> I don't see that as an option anymore. Basically I expect freenode to
> keep destroying community with no prior notice whenever they feel like
> it, and who wants to stay in a place like that?

How have the channels been destroyed?

I'm still joined on freenode and #git has ~700ish users and the
liberachat one has ~300ish as I write this.

I see there was a mass action to revert topics that stated that channels
had moved, but e.g. #git@freenode still has active discussion about git,
among other things.

> On 26.05.2021 22:01, Kevin Daudt wrote:
>
>> In the mean time, the ircops on libera helped us to register #git there
>> pending the official namespace registration from Junio (they have a
>> backlog, so they are working through that).
>
> #git on Libera is already picking up steam, though the numbers aren't
> quite on the same level yet. However, an arbitrary quorum of regulars
> has
> decided that it's time to throw the switch.
>
> * We've moved the gitinfo bot to Libera (which required a fair bit of
>   code rewriting to support the differences between their respective
>   ircds);
> * The IRC logger has moved;
> * The old channel's topic has a link to https://gitirc.eu/fnmove.html
>   which explains the situation.
>
> I expect that if anyone from freenode staff notices this, the channel
> on freenode will get destroyed soon after...

I agree that ~300/~700 is quite the arbitrary quorum :)

I'm not going to weigh in on whatever pissing contest is going on over
at Freenode and related networks other than to say that it seems to me
that the goal(s) of the new owner/team or whatever is to try to prevent
some mass adversiting of the nature of "this network is
deprecated". "Destroying" prominent channels seems to be
conterproductive to that goal.

In any case, I agree with Jeff King's earlier comments that our primary
goal here should not be to pick sides, but to direct our users to useful
venues where they can get help, discuss git etc.

I don't see why we'd advertise #git@liberachat and not #git@freenode in
order to achieve that goal, the latter doesn't seem to be a graveyard
and is probably still more active. I don't see why we'd need to pick
between the two, any more than we'd pick between advertising
#git@liberachat and the git-users mailing list. Both currently seem like
useful venues for git users to go to get help.
