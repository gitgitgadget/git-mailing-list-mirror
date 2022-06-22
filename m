Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46894C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 04:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356644AbiFVEaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347603AbiFVEap (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 00:30:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C61535267
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:30:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id cw10so7864734ejb.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcNCZT3sywWArjXl5q/7fpxdV6KtHWc/EL1DyaGk4mo=;
        b=dm0VxABlKjH4ixAfYlKRi5/dVlg572vj9841bEnpC0rc0wQwn/PTy0dHMetj8fH9eR
         aMx3neqTKsuZIU3GLK2NIKMAm2jvVNU4B8lCqPvLDaw/lcz8WhzZYRnUl6OLQq0rXIxT
         GtufkwvkLFjpbbBGM13UIbpk1el1qUs/nU+6iO1K9mzkJhKYIDko95LR8KvUf/5cgalb
         O0589jvmcSmkoOka4rl2Oed8u0ypYgdUXgWcTFUmZtKrz425cdn10nncMQZDj6sUMAkL
         Pp2EwSEv5qTHC+hSRDEsbBs+trrK/i/vModL0SR8b0aDUvcoSMAxYSNSnWosRHkRI+iv
         M0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcNCZT3sywWArjXl5q/7fpxdV6KtHWc/EL1DyaGk4mo=;
        b=URQzNBweliwKeqYdD8q4yG8bQ0Bep07lZ9WYLmr92VJ2nojTOoSaLpqGi+SBQbkCYG
         ohnYwn/maQrmE9TL0JRTJ03R4S+X6E45ssRK1vyCHRvi6tsOsQDWmqlgUo7iZe56WtDQ
         w9fYFGi/1RAwbIDRQ23dmbIZFLL5dDPbHyahl7ABowXU5y+hUoyZRnruwloq3jGo1y+h
         EsGbxAd87R2QmSlTsPitz202jwFFABpyFjP1lGMFAB9ey+rV2nhi7TYpMDtBeevzqwwu
         +kWMcKCR22E5SiWiqiX7QU7nKyZrnOeVSS7sOuv5qAp7w0iXTU8S7q6h8So0q+N49Znw
         kO1g==
X-Gm-Message-State: AJIora8KiG31S2x9GG3DC9L5UR59rmQNR+FZ6hWSjmOW7H/aNmm31nYe
        6MOc7Jx8SPSJeBJpJO4EHHv2lxLFuY4C7I88MHY=
X-Google-Smtp-Source: AGRyM1u7ECYp6iumj0y9cLubh678EAmea+QQP/kZ2JMqG45uHBPsCcCwyUBVbmfcOPpKmDzTWCBi0ZobVE+6upRQC08=
X-Received: by 2002:a17:906:99c5:b0:6ff:4c8f:6376 with SMTP id
 s5-20020a17090699c500b006ff4c8f6376mr1319391ejn.328.1655872242892; Tue, 21
 Jun 2022 21:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BEW2WF5AJeKqCiL2zhcPwPH-u6p=myoX_GkU6tbV=+TZA@mail.gmail.com>
 <xmqqczfgfojb.fsf@gitster.g> <CABPp-BEXdfEw5jYn-WM_pyEyS5AHmYEJhVNS8GtHAd2BXCaB_A@mail.gmail.com>
 <kl6l35g87bga.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6l35g87bga.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Jun 2022 21:30:31 -0700
Message-ID: <CABPp-BGN0DoSr3bcjTmGZkcoj_dSVzOgFUQ++R=_z8v=nAJsTg@mail.gmail.com>
Subject: Re: Bug in merge-ort (rename detection can have collisions?)
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the long delay.  I haven't gotten much Git time lately...

On Mon, Jun 13, 2022 at 9:52 AM Glen Choo <chooglen@google.com> wrote:
>
[...]
> Elijah Newren <newren@gmail.com> writes:
>
> > On Fri, Jun 10, 2022 at 9:53 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > On Tue, Jun 7, 2022 at 5:11 PM Glen Choo <chooglen@google.com> wrote:
> >> >>
> >> >> (I'm not 100% what the bug _is_, only that there is one.)
> >> >>
> >> >> = Report
> >> >>
> >> >> At $DAYJOB, there was a report that "git merge" was failing on certain
> >> >> branches. Fortunately, the repo is publicly accessible, so I can share
> >> >> the full reproduction recipe:
> >> >> ...
> >> > Thanks for the detailed report; very cool.  Interestingly, if you
> >> > reverse the direction of the merge (checkout origin/upstream-master
> >> > and merge origin/master) then you get a different error:
> >> > ...
> >> > Anyway, long story short...I don't have a fix yet, but just thought
> >> > I'd mention I saw the email and spent some hours digging in.
> >>
> >> Thanks for continued support for the ort strategy.  From the very
> >> beginning, I was hesitant to make our tools try to be too clever
> >> with excessive heuristics, but at least we are not making a silent
> >> mismerge in this case, so it is probably OK, especially with "-s
> >> recursive" still left as an escape hatch.
> >
> > In fact, the more general problem area here appears to affect the
> > recursive strategy as well.  I'm glad the specific testcase reported
> > works under recursive and gave Glen (or his user) a workaround, but
> > that feels like luck rather than design because my minimal
> > reproduction testcase not only triggers the same issue he saw with the
> > ort strategy, but also triggers a previously unknown fatal bug in the
> > recursive strategy too.
>
> Yeah, hm. I was surprised that we encountered this bug at all, but it's
> not so surprising after seeing how many edge conditions this bug
> contains.

To be fair, I've dug into cases with more.  :-)

> I wonder if there other rename detection bugs lurking beyond the
> horizon,

I was trying to dig around for related issues so I can fix the class
of problems rather than just the instance.  Reversing the direction of
the merge was just one component of that (and I reported that
particular tweak since it triggered something a little different).

The original motivation for writing merge-ort was to address bugs I
couldn't otherwise fix within merge-recursive's implementation.  I've
put a lot of time into corner cases, many of which (perhaps even the
majority) were not actually motivated by real-life testcases but me
just having an obsession with making Git's merge machinery handle
weird inputs.  Junio even commented on some of my testcases with 'I am
not sure if there is a single "correct" answer everybody can agree on
for each of these "insane" cases, though.'.  Now, obviously I can miss
some inputs, as evidenced by the issue you reported, so there is
always a chance there are more.  However...

> whether we already assume that these bugs exist, and if so,
> whether we should officially document "merge without rename detection"
> as a workaround [1].
>
> [1] Assuming that the workaround works of course. I tried to disable
> rename detection several times, but I couldn't really figure out whether
> I did it correctly or whether it fixed the bug (which is why I didn't
> include it in the initial report.)

Turning off renames and relying on users to correct merge issues may
be reasonable when there are only a few.  When there are more than a
few, my experience in the past with turning off rename detection (or
there being too many renames that rename detection turns itself off)
is that users often:

  * don't match up renamed files and do a three-way merge, but just
pick one of the two conflicting sides, unknowingly discarding changes
made on the other side
  * sometimes notice the files that should have been renames, and
manually hand apply the subset of changes they remember from one file
to the other, and unknowingly discarding the remaining subset of
changes (which were often changes made by people other than the one
doing the merges).

In the particular repository in question, you've got 600+ renames on
one side, and 200+ on the other -- including multiple different entire
directories.  (Also, since lack of rename detection makes renames get
reported as modify/delete conflicts, and you've got 400+ actual
modify/delete conflicts on top of all the renames, users would have
lots of "fun" attempting to sort things all out without tool support.)
 So, I'm worried the "fallback"/"workaround" is likely to put users in
a worse situation rather than a better one.

But, even if your goal really is to have a fallback, why not just use
the `resolve` strategy?  Your testcase doesn't have multiple merge
bases, and the resolve strategy is roughly the recursive strategy
minus the renames and the multiple merge base handling.

(Also, I'm not just avoiding work.  I have already written patches to
turn off rename detection in the ort strategy.  I pointed these out to
Stolee and Dscho for a special internal usecase of theirs, and at
least one of those emails cc'ed the mailing list. so you should be
able to find those patches with a search.  I'm just not convinced of
the need to merge those patches.)



Anyway, that all said, I posted a fix for this issue over at
https://lore.kernel.org/git/pull.1268.git.1655871651.gitgitgadget@gmail.com/.
With it, I can repeat the tensorflow merge you highlighted, in either
direction, without issue.
