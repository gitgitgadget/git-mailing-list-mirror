Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECB8C433FE
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 12:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbiDKMls (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 08:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346176AbiDKMll (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 08:41:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB24BD6
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 05:39:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bh17so30543031ejb.8
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mBxa7UFe9VfLywc6OYjHZU//VC79QB7NiiU/xjlnL9U=;
        b=bXB15bS5htEaXvwskH0uzFPQc9Bv23p/DHk0xGisbnrAuW4wiURcF9xnG08mjpp+ZM
         /OhR+XfOwztujHDwslVpNrINdTKDTIniwiDFvgSLevUeGZr8soY+p3u5oRdD8OqBRP5p
         +wutN7RvLADuq5hja7L71QS3KrCYILv9+v+++vmNxRxf/l7tkS1EtuNA/pEipd4KYQVu
         TZrotgdUsGSFIpGnS5+XFw52UIIvpdmc6loRqVwx0YwuRYKt44nZnaNY0fkKDo09h7jc
         wnAQB3AdKxT02c+7B033jifxcCTMR0/S69Sm1BuyE2as71OCZeZmk9L46Jy+C7aFM0Bh
         iF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mBxa7UFe9VfLywc6OYjHZU//VC79QB7NiiU/xjlnL9U=;
        b=k703MwYhoK2NwwsYcPeJcNXLRXI8N3I+ahBlfhhxNu3D4GwhnO1sFnvD8ft8ez1yAs
         5F1XK9E/RI/EFqm9Q9JHln7/3hUc2MT6bZVdLzdZd4dqbGZA+1lS/FU89VOKFGRhWQSt
         RrpBGkwPtb9csWJp9p8x8Y0QX1RinLra7nLQ8qyV2r4xjgQw2j0+6xCf3AR2xi+0iB4i
         mVlI7REjpvYJfmieikqlsMGpvr+3yHpoN5JHmtY4NMqmXj8ihL0AvWeNPOb4Z/QAE+HC
         6RxJ7kEsnzEdA4aUgWkgkFfqTorfVOMdnRr1INQU5nrx9q60M3v395cUN+oy9hR0mU4C
         vOxA==
X-Gm-Message-State: AOAM530RUecYwsIUad47DrDRAgV7bXw8CK19BfurM5Zl0tCzAxh8OyNs
        nCmsgf8jvuSPCi5DCFXbd2vw+Spjdq+CNrP3ZHizRg==
X-Google-Smtp-Source: ABdhPJx2mVCpZ3kqpjJyI7Zksj4CqkLYkpnR9Wg0jr6eKnVEMXxDiD4M5OthV+k8ozrlxMgNu2HLHfjl+yCMn3EKEXI=
X-Received: by 2002:a17:906:1c0d:b0:6e8:94a5:c5d6 with SMTP id
 k13-20020a1709061c0d00b006e894a5c5d6mr3443645ejg.134.1649680763918; Mon, 11
 Apr 2022 05:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <YlC3devsgmv17PnQ@camp.crustytoothpaste.net> <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
 <20220409113244.GX163591@kunlun.suse.cz> <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
 <220411.861qy3khkk.gmgdl@evledraar.gmail.com>
In-Reply-To: <220411.861qy3khkk.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 11 Apr 2022 14:39:12 +0200
Message-ID: <CAPMMpohNYizpbqerAuFZnSY9mFsTJEJbfFWNGY41GcHxdwGrew@mail.gmail.com>
Subject: Re: Make commit messages optional
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        rsbecker@nexbridge.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 11, 2022 at 1:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> E.g. something that (if you have empty commit messages) would prompt you
> to interactively rebase the to-be-pushed history or whatever.

Personally, I strive to recommend workflows where rebasing is not
necessary, and I believe that this is a better direction for git to go
in, rather than rebasing-by-default.

Rebasing is awesome, I use it all the time, it is definitely part of
the joy (my joy?) of using git - but again, the more we can design
workflows where rebasing is a private matter, the better the on-ramp
looks, I believe.

>
> Another thing that occurred to me after sending [1] was that perhaps
> "repo size" would be good heuristic, we already have a fast estimation
> of that for showing abbreviated commit OIDs.
>
> That wouldn't do the right thing on e.g. large private git-annex repos,
> but would serve to distinguish a "real, mid-size or large repo" like
> git.git, redis.git, linux.git etc. from dotfiles, gists etc.

I'm sorry, I didn't get it; are you proposing that empty commit
messages should be more acceptable in small repos, presumably on the
assumption that they are likely private?

>
> > In that sense, allowing people to create empty commit messages when
> > they shouldn't, is often "trapping" them into a commit history that is
> > less valuable (or even acceptable) than they might otherwise have
> > achieved.
>
> I agree with that if you s/allowing people to create empty/force people
> to create non-empty/ :)

At the risk of projecting my own experience too much, I'd like to
understand the assumptions in play: I assume that most people
committing in git end up doing so in the context of some process, some
organization, with the goal of eventually pushing the work "upstream",
to somewhere others will be able to evaluate and/or benefit from the
change. I assume that people using git as part of personal logging
systems, backup systems etc is far more rare, and that the mindset
associated with committing to most single-user private projects is
still "one day, I'll want to make use of that".

Given these assumptions, I personally believe that the cost to a new
user of having to figure out how to change a commit message (and not
fall afoul of the many risks changing the past introduces, eg
accidentally duplicating history via a "merge pull" after a rebase of
already-pushed commits), is higher than the risk of a user being
intimidated by the need to write a message and choosing to not write
(or commit) anything, rather than writing something silly.

All that said, I'll happily bow to the experience of my betters, of
which there are many already in this thread. My objective in joining
the discussion was only to point out that enhancing the
*discoverability* (of the empty-commit-message option) may allay
*some* of the sentiment behind this thread's initiation and popularity
without aggravating the counter-concerns raised.


>
> E.g. I've helped a lot of novice people with git (being the go-to "git
> guy" at a past job), and one of *the most common* things I encountered
> was users with some absolute mess of a working tree with large
> outstanding changes, which ultimately came down to them being afraid to
> commit it as it "wasn't ready".
>
> So I really think anything we can do to break that particular pattern is
> more helpful than not.

I can see how such a tendency may be aggravated by the need to set a
message, but I still don't believe the risk/reward of *more often
accidentally* creating commits without commit messages would be
favorable.

> But what I am confident in saying is that tweaking the UX in this area
> will have cost/benefits whatever you do, and I think that whatever
> "side" one picks here the interesting arguments to be had is trying to
> discuss and mitigate those costs.
>

+1

> > While I therefore disagree with Aevar's proposal to "allow empty, and
> > advise", I do think the notion of giving advice makes perfect sense -
> > let's do it the other way around, with an advice message something
> > like:
>
> Note that that's a pretty narrow reading of [1]. The main thrust of my
> point was that we should consider moving this to "push" or "merge" time.

My apologies for the misunderstanding and misrepresentation; as far as
I can tell I disagree with you on the desirability of push/merge-time
commit modification automation or advice, but I clearly did not
read/understand your proposal properly before paraphrasing it.

>
> > ---
> > Empty commit messages aren't normally allowed, as they reduce the
> > understandability of the commit history. If you do need to create a
> > commit with an empty message, you can do so by providing the
> > '--allow-empty-message' argument to 'git commit'.
> > ---
> > Has this already been considered/discussed? Would it meet the
> > objectives of those folks saying "the rejection of empty messages
> > wasted my time", while also keeping the spirit of "we should make it
> > easy to do the right thing and harder to do the wrong thing,
> > especially for beginners"?
>
> I think that's a lot worse than the status quo, at least now our
> behavior just seems like a very basic safeguard, e.g.:
>
>         $ git commit -a
>         hint: Waiting for your editor to close the file... Waiting for Em=
acs...
>         Aborting commit due to empty commit message.
>
> There I opened my editor, saved the empty file that came up ("empty"
> when adjusted for comments), and "git commit" aborted.
>
> Even if I think we should make some version of "allow empty" the default
> I think *that* particular thing should stay.

I don't really understand what you are saying is worse - the very idea
of accompanying the "Aborting commit due to empty commit message"
error with advice clarifying that you *can* in fact commit with an
empty message? Or the specifics of the message I proposed?

It looks like we agree that the current behavior of aborting the
commit when an editor is popped up and closed empty, is one that we
agree on, at least. I had not understood that from your initial "I
agree that we should do away with the check for the empty commit
message." response.

I assumed that at least some others in this thread intent on "not
changing the behavior" were reacting to the risk of *accidentally* or
"ignorantly" creating messageless commits, rather than advocating for
doing away with the --allow-empty-message option altogether.

>
> I.e. that's really helping a user to mitigate a genuine mistake,
> particularly if something goes wrong with the external editor. I.e. I
> think something like this would be sufficient (as in, it should
> succeed):
>
>     $ git commit -a --no-edit
>     Aborting commit due to empty commit message.

That seems very reasonable to me, fwiw - it's hard to see how you do
--no-edit by accident.

>
> All of those would be good cases to get feedback on, i.e. let's leave
> aside the question of whether the UX should "encourage" and whether
> --allow-empty-message should be the default, do the proponents of the
> status quo think all of these are sensible:
>
>     git commit -a # launches editor
Yes - I believe that interactively prompting the user for a message is
the right thing.

>     git commit -a -m"" # empty message
Yes - I believe that rejecting the empty message by default here is
still the right thing - there are many ways of doing this by accident,
I believe we should require a more explicit signal of intent before
accepting an empty message.

>     git commit -a --no-edit # no editor
No - I agree "--no-edit" seems like a clear enough signal of intent
that we shouldn't *also* require --allow-empty-message

>
> Aside from anything else I think --allow-empty-message for that last one
> is rather silly, it's basically making the user say
> --yes-i-know-the-default-messages-is-the-empty-message. Maybe it's
> arguably in the case of a pre-commit hook & without --no-verify?
>
> Anyway, that was a bit of a digression, sorry.
>

I don't believe it is a digression, at all. I think this thread could
head in a more productive direction if a series of specific measures
were proposed, each outlining what it hopes to achieve, and evaluated
each on their merits.

> The reason I think it's "worse than the status quo" is that it takes us
> from something that seems to be an overzelous CLI option check gone
> wrong to actively recommending a "novice forever" UX pattern. I.e. the
> "reduce the understandability of the commit history" etc. assumes or
> implies that we won't have a "git rebase -i" before pushing.
>

So, it sounds like you don't believe the discoverability of
"--allow-empty-message" is a significant concern, and the really
important question here, the one you were referring to when you
suggested to "do away with the check for the empty commit message",
was the behavior when an empty message is "more explicitly" passed in,
using the "--message" or "--file" options...?

Fwiw, I think those patterns still very easily allow for *accidental*
empty messages, and I would prefer to require a more explicit  signal
of intent, and I would have thought *some* reasonably-worded advice
would remove the "sting" of having to do something different from "-m
''". One other possibility I don't see discussed, is whether a
single-letter flag for "--allow-empty-message" (or "--no-edit" would
help. Several discussion participants noted they use garbage rather
than empty just to avoid typing so much...
