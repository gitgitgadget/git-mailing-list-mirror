Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBDBC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242195AbiFVQ7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377051AbiFVQ6l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 12:58:41 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4B2B1B7
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:58:40 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m5-20020a17090a4d8500b001e0cfe135c7so9547pjh.3
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uzJtJWrg/quYjKnkH2vWgOODNx3elrSzlvpNiUlWATk=;
        b=gwGbcX135srTMldKfuuspoVH4f1z68jpKGb9nl+luCDz3tOGJxNCN83y+G3uqAtGO9
         E2iPRswsphILlbM0AKdZ0OoDFCXry/s4ERykcFHOJN5TfHFyeEeNEdZiE3N/y0mUVT+7
         BfXZ4fDDnUWxWxpvoEwekYfBXnlEBHkTa2iOb3wuS0ygj+q9BtTP15MnkGoEon6K+YlE
         opSatkSw1aARLbjpagGzxeQ+D7z+1DgR0HDq00wEUCyLyVCsmTqp7xGe2i/iQg73OZu+
         R5JSMHkVQzRHtI+XfIjgeycjwshvrND9gZ2idC6Ls62QUDdPoPOE9x07/3N9zgMQALnK
         W0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uzJtJWrg/quYjKnkH2vWgOODNx3elrSzlvpNiUlWATk=;
        b=DVYL2r8fWonZSQJ0yLnkQqRpK7KoosbO2r4lfecmsM/X9JDjMUO7/meo/PTxSqYsip
         f004+GWnrsblqEbSyyg3OtgW5UIzKcC3TzKcXW/g6yWenEQYJD8HQkXalB7R3dU9y0L7
         GUDMqjF44N5VoUW/jaCerOmE3FqQTSTtvFFGWWutYY6l5Wn1jCMyBPg6wAbl3Ryd/uhG
         ldZvNVkor8azm6k45MYbGY10qiEoGnZdtsN6aDov229FS1XowbyGxnACgqK6LcK7rtoQ
         WjrC7JfxJQxEmoK1PaabAEEtIgcEvENx6MedGLy8+qUNkloe2uks2BcNExCqObsXn1E6
         Z6jA==
X-Gm-Message-State: AJIora9PwIGwlFTOnr+EzZspYqQKmsGw5VkveDILxIZ0d1pEEgdeGwAB
        mrKgrQWA/QafMdSZSMQgi3vdjjuqRSytmQ==
X-Google-Smtp-Source: AGRyM1sYyGqvXtMh+9BI6J+LzntamIyPmLC+w7XbPbrdbU9Am4Tdhh10pCWqa1s/1W8unLky6YxVsjyN+SEzTg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:4cc3:b0:1ec:7bda:2e68 with SMTP
 id k61-20020a17090a4cc300b001ec7bda2e68mr31269680pjh.33.1655917120130; Wed,
 22 Jun 2022 09:58:40 -0700 (PDT)
Date:   Wed, 22 Jun 2022 09:58:38 -0700
In-Reply-To: <CABPp-BGN0DoSr3bcjTmGZkcoj_dSVzOgFUQ++R=_z8v=nAJsTg@mail.gmail.com>
Message-Id: <kl6l7d58k535.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BEW2WF5AJeKqCiL2zhcPwPH-u6p=myoX_GkU6tbV=+TZA@mail.gmail.com>
 <xmqqczfgfojb.fsf@gitster.g> <CABPp-BEXdfEw5jYn-WM_pyEyS5AHmYEJhVNS8GtHAd2BXCaB_A@mail.gmail.com>
 <kl6l35g87bga.fsf@chooglen-macbookpro.roam.corp.google.com> <CABPp-BGN0DoSr3bcjTmGZkcoj_dSVzOgFUQ++R=_z8v=nAJsTg@mail.gmail.com>
Subject: Re: Bug in merge-ort (rename detection can have collisions?)
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Sorry for the long delay.  I haven't gotten much Git time lately...
>
> On Mon, Jun 13, 2022 at 9:52 AM Glen Choo <chooglen@google.com> wrote:
>>
> [...]
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Fri, Jun 10, 2022 at 9:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>> >>
>> >> Elijah Newren <newren@gmail.com> writes:
>> >>
>> >> > On Tue, Jun 7, 2022 at 5:11 PM Glen Choo <chooglen@google.com> wrote:
>> >> >>
>> >> >> (I'm not 100% what the bug _is_, only that there is one.)
>> >> >>
>> >> >> = Report
>> >> >>
>> >> >> At $DAYJOB, there was a report that "git merge" was failing on certain
>> >> >> branches. Fortunately, the repo is publicly accessible, so I can share
>> >> >> the full reproduction recipe:
>> >> >> ...
>> >> > Thanks for the detailed report; very cool.  Interestingly, if you
>> >> > reverse the direction of the merge (checkout origin/upstream-master
>> >> > and merge origin/master) then you get a different error:
>> >> > ...
>> >> > Anyway, long story short...I don't have a fix yet, but just thought
>> >> > I'd mention I saw the email and spent some hours digging in.
>> >>
>> >> Thanks for continued support for the ort strategy.  From the very
>> >> beginning, I was hesitant to make our tools try to be too clever
>> >> with excessive heuristics, but at least we are not making a silent
>> >> mismerge in this case, so it is probably OK, especially with "-s
>> >> recursive" still left as an escape hatch.
>> >
>> > In fact, the more general problem area here appears to affect the
>> > recursive strategy as well.  I'm glad the specific testcase reported
>> > works under recursive and gave Glen (or his user) a workaround, but
>> > that feels like luck rather than design because my minimal
>> > reproduction testcase not only triggers the same issue he saw with the
>> > ort strategy, but also triggers a previously unknown fatal bug in the
>> > recursive strategy too.
>>
>> Yeah, hm. I was surprised that we encountered this bug at all, but it's
>> not so surprising after seeing how many edge conditions this bug
>> contains.
>
> To be fair, I've dug into cases with more.  :-)

:)

>> I wonder if there other rename detection bugs lurking beyond the
>> horizon,
>
> I was trying to dig around for related issues so I can fix the class
> of problems rather than just the instance.  Reversing the direction of
> the merge was just one component of that (and I reported that
> particular tweak since it triggered something a little different).
>
> The original motivation for writing merge-ort was to address bugs I
> couldn't otherwise fix within merge-recursive's implementation.  I've
> put a lot of time into corner cases, many of which (perhaps even the
> majority) were not actually motivated by real-life testcases but me
> just having an obsession with making Git's merge machinery handle
> weird inputs.  Junio even commented on some of my testcases with 'I am
> not sure if there is a single "correct" answer everybody can agree on
> for each of these "insane" cases, though.'.  Now, obviously I can miss
> some inputs, as evidenced by the issue you reported, so there is
> always a chance there are more.  However...
>
>> whether we already assume that these bugs exist, and if so,
>> whether we should officially document "merge without rename detection"
>> as a workaround [1].
>>
>> [1] Assuming that the workaround works of course. I tried to disable
>> rename detection several times, but I couldn't really figure out whether
>> I did it correctly or whether it fixed the bug (which is why I didn't
>> include it in the initial report.)
>
> Turning off renames and relying on users to correct merge issues may
> be reasonable when there are only a few.  When there are more than a
> few, my experience in the past with turning off rename detection (or
> there being too many renames that rename detection turns itself off)
> is that users often:
>
>   * don't match up renamed files and do a three-way merge, but just
> pick one of the two conflicting sides, unknowingly discarding changes
> made on the other side
>   * sometimes notice the files that should have been renames, and
> manually hand apply the subset of changes they remember from one file
> to the other, and unknowingly discarding the remaining subset of
> changes (which were often changes made by people other than the one
> doing the merges).
>
> In the particular repository in question, you've got 600+ renames on
> one side, and 200+ on the other -- including multiple different entire
> directories.  (Also, since lack of rename detection makes renames get
> reported as modify/delete conflicts, and you've got 400+ actual
> modify/delete conflicts on top of all the renames, users would have
> lots of "fun" attempting to sort things all out without tool support.)
>  So, I'm worried the "fallback"/"workaround" is likely to put users in
> a worse situation rather than a better one.

Ah, that's a good point. I hadn't given too much thought to the
complexity of manually resolving a merge without rename detection, but,
like you said, it's probably not a useful fallback anyway.


> But, even if your goal really is to have a fallback, why not just use
> the `resolve` strategy?  Your testcase doesn't have multiple merge
> bases, and the resolve strategy is roughly the recursive strategy
> minus the renames and the multiple merge base handling.

Oh, today I learned about the `resolve` strategy..


> (Also, I'm not just avoiding work.  I have already written patches to
> turn off rename detection in the ort strategy.  I pointed these out to
> Stolee and Dscho for a special internal usecase of theirs, and at
> least one of those emails cc'ed the mailing list. so you should be
> able to find those patches with a search.  I'm just not convinced of
> the need to merge those patches.)
>
>
>
> Anyway, that all said, I posted a fix for this issue over at
> https://lore.kernel.org/git/pull.1268.git.1655871651.gitgitgadget@gmail.com/.
> With it, I can repeat the tensorflow merge you highlighted, in either
> direction, without issue.

That's fantastic. Thanks for keeping me in the loop :)
