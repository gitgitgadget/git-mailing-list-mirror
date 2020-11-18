Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6AEC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 10:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0661F22227
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 10:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUShy7mc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgKRKMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 05:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgKRKMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 05:12:47 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836A1C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 02:12:47 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so538416wmd.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 02:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9yWcYSe3ko+GWR9lJB+ckHey7qSire4XqW+ZgWQmGg=;
        b=tUShy7mcGcIYxZ1gJ6DSGwX7DSys7aPsonjBW8D+HGfy8XkmuOwJsbZiG5zPubjbBS
         kJJ//VkEU3i0b4QtGKI8ceH6ZQg1VBjVWW2e9kFXgLYg74TjGUBFhgMKZmf0BDHbRXTj
         1f1a47/do4cbBO0m5pbYsA9D2t6FXlc6GwKFTzVZx0AOK//uh20m2UgBhj0l1LPXUmfI
         jMvB7drxyJUZsd2IxQSLDMOfhBMD8F80P3aKXjliMSl6J1CL+OCoXu421yexNeycdyOS
         1Zx9+YoqPENkLXYbPe362N1LAnMAJdkvQGOIwbSoVlZt1/vJfOtcP4XRPW3vhcvRGIrb
         GLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9yWcYSe3ko+GWR9lJB+ckHey7qSire4XqW+ZgWQmGg=;
        b=ioCbDKH9o2fiQYEQ1aKKE/TasuMvyHe14R5cYgphVcUxMT/jdfrKEmWcMYO5DivxGd
         CA9C0bRFzQarszkRu3XOX76Ikmdf0ZmyNMAEDJMMASwUXlP2v9J8I5SzsSWv6RQrvTT2
         oaXLbcTgNKe8aI3yAF6/79SQSg1YCaptYZgrXmghtWxSFL/ZGMao1zD2Q+rgyW9Yrs4/
         R9glDTid6MSE7iJ/P8k3QL33eId6/kiWgtJhoiLz36YorWIlSjhmDGq5rBMcw2dqe6Rh
         EhjEohxRT/GP8/ILrGVCkdoYCnqAdmLkXmW0iEFsZm6fdbciGSGFyLjlkzEGyNBUzFo/
         qmWg==
X-Gm-Message-State: AOAM5301AKOHVkW/ee3jybk/rcp9+A5ZqyPLoDljfAwERW5aZvXKN9X+
        /MeXQ5yMT+jqj86O4His4zZcNHiLKRF2Z7OQja4=
X-Google-Smtp-Source: ABdhPJwkkmIhiyFcHfMebw0f5Neg4eK3R87PrPoRhi0DqWhk9Y6f4yKVvvR9vlkaJdjJiQEjOcKoX3qErqXTZ33aVqM=
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr3461027wmj.37.1605694366258;
 Wed, 18 Nov 2020 02:12:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org> <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
 <20201117233313.GB642410@coredump.intra.peff.net> <CAMP44s1HhiDYfji9L2sj3QbCDmsb9dnrLCS6cQJPbmS1F3vKoQ@mail.gmail.com>
 <20201118012230.GB650959@coredump.intra.peff.net> <CAMP44s1t3CKF3btQwSwaz_Pu2fE6PGyb+_iMW8dAbY3aE3mH7w@mail.gmail.com>
 <20201118020618.GE650959@coredump.intra.peff.net> <20201118023902.GD360414@google.com>
In-Reply-To: <20201118023902.GD360414@google.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 18 Nov 2020 04:12:35 -0600
Message-ID: <CAMP44s1Mf=zHB3xmCV_zCVOs4eoggOL+Lo=7V4AauXkQ8v4C+A@mail.gmail.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 8:39 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jeff King wrote:
> > On Tue, Nov 17, 2020 at 07:45:21PM -0600, Felipe Contreras wrote:
> >> Jeff King wrote:
>
> >>> Yes, I have run into that, and it's definitely annoying. The
> >>> refs/remotes/<remote>/HEAD symref is created by clone, but is not
> >>> updated by "fetch". That's intentional, because it's supposed to
> >>> represent a local choice (that is merely seeded by the remote side). But
> >>> it seems like adding it if it's missing might be reasonable.
> >>
> >> The equivalent of this choice is in "git remote add -m":
> >>
> >>   With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD`
> >>   is set up to point at remote's `<master>` branch. See also the
> >>   set-head command.
> >
> > Wow, I'm not sure how that option escaped my notice for all these years.
> > Of course it would be much more useful if it pulled the value from the
> > remote HEAD (but again, unless we use "-f" we are not contacting the
> > remote at all).
>
> When would I want this implicit "set-head -a" and *not* want "-f"?

This is what I often do:

 git remote add origin $url
 git fetch origin

That should work (update origin/HEAD), and it currently doesn't.

> > E.g., remote.origin.updateHEAD that can be set to one of:
> >
> >   - never; do not touch it
> >
> >   - create-if-missing; as discussed here
> >
> >   - always; update it on every fetch
> >
> > And then it is just a question of what the default is. Currently it is
> > "never". I suspect most people would be happy with "always", but it does
> > break some existing flows. But perhaps "create-if-missing" is a good
> > medium.
>
> Thanks for bringing this up --- this is something I had been
> interested in as well but hadn't gotten around to contacting the list
> about it.
>
> The default value for a config setting like this has two purposes:
>
> - it makes the config setting for affected people who have not
>   discovered it
>
> - it provides a sensible, predictable standard behavior
>
> Those two goals are often in tension, as they were for example when
> setting the default for push.default.
>
> If I consider them separately:
>
> - to make as smooth a transition as possible for people who were
>   relying on "git remote set-head", a good behavior would be to
>   *fail the fetch* when the remote HEAD changes.  That would force
>   the user to make a choice between "never" and "always".

We don't need to fail the fetch, we can print a warning so the user
can decide what to do next, including ignoring the warning.

Moreover, since projects rarely change the HEAD, we might want to
print the warning always, until the user sets the configuration.

> - one way to relax that without hurting that goal too much would be to
>   fail the fetch when the remote HEAD changes from something other
>   than "master" or "main".  That way, the common case (moving from a
>   default to a project-appropriate setting) would work without
>   friction, and in other cases the user could make a choice between
>   "never" and "always".

This thread started in an attempt to move away from hard-coded values.
This doesn't help in my opinion.

> - all that said, the default that I prefer is simply "always".  Like
>   Felipe hinted, this is a simple, intuitive behavior that most people
>   would expect.
>
> As a transition plan, I can imagine going from one of those first two
> to the third after some appropriate period of time has passed.

I think the default should be "missing", after a warning period. And
perhaps change it to "always" in the next major version, but that
basically gets rid of the manual "origin/HEAD" that seems to have been
there since forever (at least 2007).

I personally don't see any point in manually setting the HEAD (I have
never done so), but that's just me, others might.

Cheers.

-- 
Felipe Contreras
