Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F99C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 19:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbiCHTpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 14:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiCHTpD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 14:45:03 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77EA4EA31
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 11:44:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v4so299966pjh.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JGI9LXsxBlzWBli8TwWoPI7sc8SQ7cbqpoZfxDXoek8=;
        b=rPOCXFq0MPlN/xPgaZ8DfhrxAwGrSQq4KwMTFSp+RSRWiYlcx8s/1rvmatcq5af5kO
         P5HqrxuZR/f0tDzxmAF8gMePMm7N+wYsPo8cqbaV/8Gt7X45sFzkXKIdiH9LaRu/sHR0
         z99TOQjs/Rp/pbQ9MaaKwCbW7u+miX1b8wbMgV4YFq224mLvtsiQ5Tmuuq8o+zk00MSH
         8XpJFe/vm4erHhdvuOKpkkkyHknqb9RV8LncV7q5NQpGRGeS2OzGbZV7sYUR+1YcfuQE
         fvuTkoxh67mHuMfahm2FJgz+Q2iCsydFPOeJ7ZgPvwszE+8MuKAAwbyrw00PUkMVzFPU
         7uSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=JGI9LXsxBlzWBli8TwWoPI7sc8SQ7cbqpoZfxDXoek8=;
        b=oXrOQqywbi7MytI7iY08fTz7u2R2kcP7/7v5a4D7dQXRchXo9sHKB1oJvntB0fxEen
         +J29tMS7YxdZtf5dbt2oH1ruy+oNeSDwG6NVxZVopXhVPYmg8Vg67zHL6S9YNOXQHkRE
         zxmzv/EZnfrwdxlfGjWrJbfek+MkrhqeJlxR/XKW1jo85AWpO49lzFuhI68Bv1Bq1I2h
         IosinbV/xZq4VuS4tbvAvijM0LBZoNOBTz0FyBUXNjm8oJoblPAJaTa/cCzcicUT59Ab
         M3MrqvTngwBjaBbG/9oebHrctyCcE5PS82uG5UpneZJUbRLzij02pWofI9t1FsevVdDZ
         dkIw==
X-Gm-Message-State: AOAM533s2oDOREZ266e0+VLGO2etMIrcLIWAzDG1umuqZ3yUEXwpxPWE
        Rcwwi4edT2V3h/RnAc0AVj9aMg==
X-Google-Smtp-Source: ABdhPJwwsZzOPL3j1on7Csy92JQWPeWedkQFQC+hWGeLQW7jxsp09B2xtIKd6O8Hh3EIIlW3HJZ83g==
X-Received: by 2002:a17:903:41c9:b0:151:a545:2d5f with SMTP id u9-20020a17090341c900b00151a5452d5fmr19600542ple.114.1646768645839;
        Tue, 08 Mar 2022 11:44:05 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:d378:557f:66de:402f])
        by smtp.gmail.com with ESMTPSA id h17-20020a63df51000000b0036b9776ae5bsm15804446pgj.85.2022.03.08.11.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:44:05 -0800 (PST)
Date:   Tue, 8 Mar 2022 11:43:59 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>, git <git@vger.kernel.org>
Subject: Re: What does it mean to have multiple upstream tracking branches?
Message-ID: <Yiex/y8s7mlHTydz@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>, git <git@vger.kernel.org>
References: <CAPMMpoiTJAuadBEOPWOVa-kguSXMDvAhvD22B63QwYpu=H7xEw@mail.gmail.com>
 <220303.868rtr42mg.gmgdl@evledraar.gmail.com>
 <kl6l4k4ek73o.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqzgm2vjab.fsf@gitster.g>
 <CAPMMpoh38fm-jNi=GD+uf6O+JLiJz-ue2zh5ceWpwmTYBRKzvw@mail.gmail.com>
 <220307.86a6e20xi2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220307.86a6e20xi2.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.03.07 13:12, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 07 2022, Tao Klerks wrote:
> 
> > On Sun, Mar 6, 2022 at 10:54 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Glen Choo <chooglen@google.com> writes:
> >>
> >> > Not that I would ever _recommend_ someone to work like this though.
> >> > Junio also wondered whether anyone uses this [1].
> >> >
> >> > [1] https://lore.kernel.org/git/xmqqbl2hw10h.fsf@gitster.g
> >>
> >> I actually think the current octopus behaviour is a sensible one
> >> (after all, that was what we envisioned how it would be used when we
> >> did the mechanism long time ago).  If you have mutliple, say source
> >> and docs, groups working for you and you are taking their work from
> >> time to time, something like this:
> >>
> >>     [branch "main"]
> >>         remote = central-repo
> >>         merge = sources
> >>         merge = docs
> >>
> >> would let your folks push into the central-repo, and a "git pull"
> >> will help you advance your main branch that you'll publish later.
> >>
> >> You can explain multiple .merge entries for such an integration
> >> branch like I just did and I think such an explanation makes perfect
> >> sense, but these are quite different from what we view as "upstream"
> >> in the traditional sense.  In the setting illustrated here, yours is
> >> the main integration repository, the center of the universe, and
> >> those folks working in the 'sources' and 'docs' groups view yours as
> >> their "upstream".
> >>
> >> So, "what does it mean to have multiple branch.*.merge entries" has
> >> a good answer: you are integrating from these contributors and these
> >> entries are not your "upstream" in the usual sense---you do not even
> >> push back to them.  Asking "what does it mean to have multiple
> >> upstream" makes little sense, I would think.
> >>
> >> Now, with the 'main' branch used in such a manner, if you did
> >>
> >>    $ git branch --track=inherit topic main
> >>
> >> and worked on the "topic" branch, you do not push back to either the
> >> sources or docs of the central-repo, of course, but it is unclear if
> >> you even want to "pull" to create octopus from these two branches at
> >> the central-repo, which essentially duplicates the pull's you would
> >> do on your 'main' branch.  I suspect that you'd rather want to merge
> >> updates 'main' accumulated (or rebase on them).
> >>
> >> The reason why I asked what Josh's plans are for the multiple .merge
> >> entries in that thread [1] when the "--inherit" feature was being
> >> invented was exactly about this point.  I wondered if last-one-wins
> >> may make sense (and as the above octopus set-up tells us, it may
> >> not), but if we want to keep "multiple .merge entries means an
> >> integrator making octpus merges", then it may make sense not to copy
> >> them when there are multiple with "--track=inherit", to avoid
> >> spreading the "curious" nature of the branch like 'main' depicted
> >> above.
> >
> > Given that the notion of "inherit"ing the tracking configuration is a
> > (relatively) new one anyway, and given the slightly esoteric nature of
> > the "multiple branch merge entries lead to octopus merges"
> > functionality, I would argue that it makes more sense to die when
> > branching under this specific configuration, saying something like
> > "inheriting the tracking configuration of a branch with multiple
> > branch merge entries is not supported - we think you're making a
> > mistake".
> 
> I don't know if this is plausible in this case, but we need to be very
> careful with that in general. I.e. some people might set the "sensible"
> default remote config for "origin" in their ~/.gitconfig or whatever,
> including "merge" for a "master" and all.
> 
> Then expect that if they have a local repo that we'll take whatever
> custom values there to override them, if any.
> 
> So for most config variables that take a "last set wins" it's a feature
> to ignore any previous entries.
> 
> But in this case it might be different due to the odditity of the remote
> config, how we almost always manage it with "git remote" or "git clone"
> etc.
> 
> > Skipping the creation of tracking entries in this case, even with a
> > warning/explanation output to stdout, would be a "slightly hidden
> > surprise", in that git command output is often not read by, or even
> > visible to users when a command is successful, eg in a GUI.
> >
> > If we think this will basically never happen and really makes no sense
> > anyway, as Junio seems to suggest, then I would argue the extra
> > complexity in the codebase to support the "inheriting multiple branch
> > merge entries" is unwarranted.
> >
> > Either way, I will happily drop this topic as it does not appear to
> > require follow-up in direct relation to my "--track=simple"
> > work/proposal. On the other hand, I'd be happy to work on a patch to
> > eliminate this multi-tracking-branch-inheritance path/support (undoing
> > some of Josh's work here) if the team believes this makes sense.
> 
> Just on my side: Don't take any of my comments in this thread as a "we
> shouldn't do this", it was genuine confusion, thanks for clearing it up
> :)
> 
> Perhaps a gently step into adding validation for this (if needed) is to
> do the die()/advise() or whatever or the write (i.e. when we copy
> branches, or use --track=inherit) v.s. when we use the config (in "git
> fetch" et al) ?

Sorry for the late response to this thread. I don't have strong feelings
regarding either keeping the current --track=inherit behavior or
disallowing inheritance of multiple merge options. However, here is my
original thinking that led me to the current implementation:

If someone is using multiple merge branches, they are already treating
the "upstream" config in a somewhat non-standard manner, as Junio
already mentioned. Presumably, they know what they're doing. While the
--track=inherit mode is intended for automatically setting up *push*
configuration, there may be some unforeseen-by-me benefit to also
inheriting this non-standard setup. Since there's nothing technical
preventing inheriting multiple merge branches, it seems better to trust
the user to know what they're doing, rather than put a die() in place to
stop them.

If folks feel that I'm wrong in my reasoning here, I'm happy to help
review patches to fix the issue, and wouldn't feel like anyone is
stepping on my toes if they do so :).
