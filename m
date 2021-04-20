Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ACFC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 10:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE3861002
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 10:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhDTKfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 06:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhDTKfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 06:35:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CCCC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 03:34:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r20so7735102ejo.11
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XUbJSnWkUqYa96RrhAHlLMosKBpLXNMIOYrR0JaD2n0=;
        b=LK+rwQaX+xNuAWxcGNTqdhA4WQKcXesOwjSyU4bwsVgkbBOnmyJi1R/BSNxBasNwUC
         GzM4uIHXPIcfGlWo82TYmwofIfUw5ekiy3IoyX+DTyAPf1cvs/8ZjLzoXmPBdf5Dl7n8
         cHDbGsWqnzW1V8mJHc7d2fGQ4VjQiq0Rg3LUUPV/a4TCb+uneGjoSmYowpkuGUeTdF+h
         oLXkkEo1SfAkYA51TqLQvTSbiiUBrHSENqRVA6SwlQ0kZ/SEM8q7JyXd0paVGH+d24fN
         ADRBk+XyE+2/OLTA9Yav2ntlK3rPQBrOLpHZuPP8UW45NM9t3sWoAdvaSQtQ5spw4ICU
         8NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XUbJSnWkUqYa96RrhAHlLMosKBpLXNMIOYrR0JaD2n0=;
        b=Op8mwVVfQuygvi3MreKwjbh51vwnvnOVYvgjbvVSEofbSmw8qSRROLRHNlm6eRuvUG
         TIt588Xv2CTasafPYYN/0oxL35xl2o4BwqnlJAVclmVZQFQ3Gt3tryUKNNjDycQpNct3
         pUxiZtcaUoMnSuib2hCdNQx3S9ByETspfKAvnWOcLNX+of6u7m7uGj85HPKwwbr9GJsA
         Ao21AQsWeC+OdstnG8gS89/s2ZLB2tBgFZFGBacb6e6LkNk9Lk6oxH6nifzFXSnXgvMM
         qCttipYPx9WYQXyNHktJ8Ry9ojIgABGlCVj8vuuHn7u+GMspucJOzX6wtUaMVcDkxvWv
         RMdw==
X-Gm-Message-State: AOAM532fS0cikhrqZAJA4F6VS/ZoozeA/yflRBt+OLgkdxFAImTxsEKp
        iaZLx6fF6hsP8+3nemcF+MuUsxYiawo=
X-Google-Smtp-Source: ABdhPJybkK2QCwbRInw7uJ1FTIHuuaMbPuuo8D21QSA4gJOyulDs4zMdhcpNi2us6wyk/r/n+S9U3g==
X-Received: by 2002:a17:906:6bc8:: with SMTP id t8mr27336749ejs.115.1618914881110;
        Tue, 20 Apr 2021 03:34:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d1sm14503271ede.31.2021.04.20.03.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 03:34:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
References: <YHaIBvl6Mf7ztJB3@google.com>
        <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
        <87fszn48lh.fsf@evledraar.gmail.com>
        <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
        <87czuq4r4l.fsf@evledraar.gmail.com>
        <CAHGBnuMedez4SE-4-JwCcR8k=_FRtjgBdBSEJqshQnVceCvGug@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAHGBnuMedez4SE-4-JwCcR8k=_FRtjgBdBSEJqshQnVceCvGug@mail.gmail.com>
Date:   Tue, 20 Apr 2021 12:34:39 +0200
Message-ID: <87a6pt4534.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Sebastian Schuberth wrote:

> On Mon, Apr 19, 2021 at 10:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> > If you send around code patches by mail instead of directly working on
>> > Git repos plus some UI, that feels to me like serializing a data class
>> > instance to JSON, printing the JSON string to paper, taking that sheet
>> > of paper to another PC with a scanner, using OCR to scan it into a
>> > JSON string, and then deserialize it again to a new data class
>> > instance, when you could have just a REST API to push the data from on
>> > PC to the other.
>>
>> That's not inherent with the E-Mail workflow, e.g. Linus on the LKML
>> also pulls from remotes.
>
> Yeah, I was vaguely aware of this. To me, the question is why "also"?
> Why not *only* pull from remotes? What's the feature gap email patches
> try to close?
>
>> It does ensure that e.g. if someone submits patches and then deletes
>> their GitHub account the patches are still on the ML.
>
> Ah, so it's basically just about a backup? That could also be solved
> differently by forking / syncing Git repos.

I just mentioned that as an example, FWIW I think Linus mainly uses that
method for pulling "for-linus" tags from lieutenants, but that those
"forks" in turn are developed over E-Mail (e.g. on the linux-usb list).

So they're supporting a flow the Git ML doesn't, of e.g. needing
hundreds of patches from a subsystem maintainer to bring that subsystem
up-to-date for a release.

Aside from that:

 1. Once you have patches sent to the list for review / commenting you
    might as well use them to apply the changes, why also require a
    repository to pull from?

    I may just not be understanding what you're suggesting here.

 2. One thing you may have missed is that patches !=3D sending someone a
    repo URL to "pull" / run "log" etc. on because:

    2.1: You can provide different context (-U<n> -W) and diff algorithm
         for patches, and submitters sometimes do on this list to make
         the job of reviewers easier. I.e. sometimes I'll want to
         manually extend the context to some relevant code related to
         what's being changed.

    2.2: There's also the convention of a free-form (e.g. extra
         commentary, a reply to another E-Mail, whatever) after the
         "---" in the patch.

>> To begin with if we'd have used the bugtracker solution from the
>> beginning we'd probably be talking about moving away from Bugzilla
>> now. I.e. using those things means your data becomes entangled with the
>> their opinionated data models.
>
> Indeed, it's an art to choose the right tool at the time, and to
> ensure you're not running into some "vendor-lock-in" if data export is
> made too hard. And aligning on someone's "opinionated data model" is
> not necessarily a bad thing, as standardization can also help
> interoperability and to smoothen workflows.
>
>> > Not necessarily. As many of these tools have (REST) APIs, also
>> > different API clients exist that you could try.
>>
>> API use that usually (always?) requires an account/EULA with some entity
>> holding the data, and as a practical concern getting all the data is
>> usually some huge number of API requests.
>
> I'm not sure how relevant that concern really is, but in any cause it
> would be irrelevant for a self-hosted solution.

Yes and no, getting kicked off the service due to e.g. being from Iran
would probably be a non-issue (as was the case with GitHub until
recently).

I've still done various searching/for-looping over the ML archive in a
way that would if translated to API requests against some remote service
probably be considered a DoS, so being distributed helps there.

>> >> And to e.g. as one good example to use (as is the common convention on
>> >> this list) git-range-diff to display a diff to the "last rebased
>> >> revision" would mean some long feature cycle in those tools, if they'=
re
>> >> even interested in implementing such a thing at all.
>> >
>> > AFAIK Gerrit can already do that.
>>
>> Sure, FWIW the point was that you needed Gerrit to implement that, and
>> to suggest what if they weren't interested. Would you need to maintain a
>> forked Gerrit?
>
> Sorry, I can't follow that. Why would you need to maintain a fork of
> Gerrit if Gerrit already has the feature you're looking for? Is it a
> hypothetical question about what to do if Gerrit would not have the
> feature yet?

My example of range-diff upthread in
<87fszn48lh.fsf@evledraar.gmail.com> which started this discussion
wasn't to make a point about range-diff per-se, but just mention it
offhand as a "feature" that in an E-Mail based flow is simply a matter
of someone including a thing like that in their cover letter and sending
a patch.

So for that example the specifics of range-diff being a part of Gerrit
now don't matter that much, the point is that the next thing lik
range-diff first has to be made part of such a service, it can't easily
emerge "bottom-up".

Of course there's disadvantages to that too, I'm just pointing out that
the free-form of text also has advantages that shouldn't be overlooked.

>> Anyway, as before don't take any of the above as arguing, FWIW I
>> wouldn't mind using one of these websites overall if it helped
>> development velocity in the project.
>
> I appreciate that open mindset of yours here.
>
>> I just wanted to help bridge the gap between the distributed E-Mail v.s
>> centralized website flow.
>
> Maybe, instead of jumping into something like an email vs Gerrit
> discussion, what would help is to get back one step and gather the
> abstract requirements. Then, with a fresh and unbiased mind, look at
> all the tools and infrastructure out there that are able to fulfill
> the needs, and then make a choice.

The abstract requirement comes down to one thing: Whatever Junio
decides.

For a bit of context on the current discussion:

There have been versions of this discussion in-person in various "git
merge" developer meets over the years, Junio doesn't attend most of
those (I believe the last one was the one in April 2016 in NYC, but I
missed a couple since then, so don't take my word for it).

So those discussions re-hashing of the various pain points that have
been brought up over the years (and again in this thread), but have had
to tip-toe around the fact that most things can't make radical forward
progress (as is being proposed by some here) unless Junio is on board
with them, without the benefit of being able to get feedback from him in
real-time.

So the things that have come out of them are things like submitGit
(later GitGitGadget), which are very useful, but still something
implemented inside the narrow confines of fitting into the confines of
the existing E-Mail/ML-based workflow.

My reading of [1] and [2] (including some "between the lines", so I may
be wrong) is that Junio's very much interested in using his current
workflow as the primary "source of truth", and that any (issue) tracking
system will need to be shimmied on top of that.

Which I think means that any such "system on top" is going to have to be
bespoke and inevitably drift from the real "source of truth" which is
the mailing list, What's Cooking E-Mails etc.

As opposed to say, imagining some "light" in-between state where we
don't use a bugtracker, or have any discussion on some centralized
website, but would (or rather, Junio would) commit to creating one-line
tracking issues for what's now the topics in "next" and "seen"
branches. I.e. just the smaller step of answering "what's the status of
my topic" via a some bug tracker, nevermind using it for anything else.

Which at least for some contributors like myself means that I'm
uninterested in using any such system myself, not because I would mind
using it in theory, but as long as it's not the "source of truth" I
don't see the point. I'd still need to scour the ML for anything it may
have missed.

1. https://lore.kernel.org/git/xmqqv98orsj5.fsf@gitster.g/
2. https://lore.kernel.org/git/xmqqfszqko0k.fsf@gitster.g/
