Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A68C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 15:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjDXPXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjDXPXq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 11:23:46 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E937D8A58
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:23:44 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b99e10f1c4cso183639276.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682349824; x=1684941824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nVskcPkx2xIXQCAI665PopFD66yy1y7eOd0zwbq4w8=;
        b=Lbu2USX14l/YwVix6ZswTsmcHb3rJx0G4t6Vf4EwpUjfulde7yQ6NDJL8sSfUVL3NW
         LqYslYbSX0hjcuDTNSYKmi0xP2iDNPg7OHe54zgvDlbERZ5/bvGsKDWeOfnY7CBFVkvN
         pzLEcKZQL7is0uIgDDecVk5JSL5uT/yyKzTGs1vvyqOc4LGsXasKSLHobBl6IfaX3vIX
         bcxMwzIvEvHFK0yfGUvGW4otwjBXO/FnCpXcmgnFxrMySkroPnxhA7YvQIBnAZkQCaWp
         /3WhfF5yb8UiSaiI+N1cgYSeaF5MUFGH+B+h8JffZ5SIVZiePwoKEdlBB8WB05gwawqB
         2YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349824; x=1684941824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nVskcPkx2xIXQCAI665PopFD66yy1y7eOd0zwbq4w8=;
        b=jMcjZJQuqL/iJwgjQfEGMTvWJj6Hoe/4iXZJC62VvoI2QCW21Oje+Guque1Jp7r/sw
         knE8ot3V1Tu6ug4TVAvcQNXGXH9dA85Q61wBW/byo8dTOFm51MNiz9pguyJF5lSy/779
         qwytBezcFwYU6e/1ws19nA8HVgcFpBQluP5prwAoY3k3F9NFMuKsyJaVx1kpX1Kuehjz
         NDbra/JVls2DFBVnfxNjYUP+krMt3KtL+/gH9CXhT2FJnYPwn0Q9RDV169KP8f+nIEqw
         QVllmK9l8H0+riAZwFE4UFHGIScNr834rbxGY+Rp5yJi+6PUSv4nMEOJ4sJc45Ku4Su9
         lweQ==
X-Gm-Message-State: AAQBX9cabwFbrASdsey01HMhu3qXIb3xVFzcdNmV9daf5oIvGFIJ+CNv
        d2IFGjRy06RYpQcIiK84Uj/8PLkgSXQjvbZ84g==
X-Google-Smtp-Source: AKy350awf7tLcHuCU2EK3lqIUV1cMNeECnNgqqIYKrcXqwsCbHw+6LodlaBwoidWutxwUorKDOn2sQ==
X-Received: by 2002:a81:6f43:0:b0:54c:f42:b259 with SMTP id k64-20020a816f43000000b0054c0f42b259mr8848269ywc.25.1682349823938;
        Mon, 24 Apr 2023 08:23:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4c:5bca:4632:1d72? ([2600:1700:e72:80a0:4c:5bca:4632:1d72])
        by smtp.gmail.com with ESMTPSA id p66-20020a817445000000b0054fb931adefsm3005515ywc.4.2023.04.24.08.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 08:23:43 -0700 (PDT)
Message-ID: <58f7918f-6ca3-2158-7d9e-bfcd8eb24b0d@github.com>
Date:   Mon, 24 Apr 2023 11:23:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com>
 <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com>
 <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
 <b9732826-5732-0f87-9527-f49c38514fd7@github.com>
 <CABPp-BG3xNmwbtu+tstLr8bT24rr0gG65ZvD1rEeus_V8OYk=Q@mail.gmail.com>
 <bbdd3697-bc10-f311-dbef-99917603ce4f@github.com>
 <CABPp-BH5rLZyjLD91Bn=xThMXHk=q+kGcqPjPDOT0-N4fHfquA@mail.gmail.com>
 <f5dd91a7-ba11-917a-39e2-2737829558cb@github.com>
 <CABPp-BFCKrbSZQtRD1MnXrwB91O2YK9ZuGd6BiYQZ2zrpLp+uw@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BFCKrbSZQtRD1MnXrwB91O2YK9ZuGd6BiYQZ2zrpLp+uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/22/2023 9:18 PM, Elijah Newren wrote:
> On Thu, Apr 20, 2023 at 6:44 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 4/20/2023 12:53 AM, Elijah Newren wrote:
>>> On Tue, Apr 18, 2023 at 6:10 AM Derrick Stolee <derrickstolee@github.com> wrote:

>>  3. (Ordering options) Modifications to how those commits are ordered,
>>     such as --topo-order, --date-order, and --reverse. These seem to
>>     be overridden by git-replay (although, --reverse probably causes
>>     some confusion right now).
> 
> Yep, intentionally overridden.
> 
> Could you elaborate on what you mean by --reverse causing confusion?

It's very unlikely that a list of patches will successfully apply
when applied in the reverse order. If we allow the argument, then
someone will try it thinking they can flip their commits. Then they
might be surprised when there are a bunch of conflicts on every
commit.

Basically, I'm not super thrilled about exposing options that are
unlikely to be valuable to users and instead are more likely to cause
confusion due to changes that won't successfully apply.

>>> I feel like you're brushing aside those repeated attempts to point out
>>> those usecases as though they don't exist or don't matter, with some
>>> separate new motivation needed for these options to be allowed?  And
>>> perhaps saying those usecases should all be *ruled out* apriori,
>>> because you're concerned the implementation *might* also allow other
>>> unintended uses?
>>>
>>> Something isn't working here.
>>
>> I'm trying to read the patches and make sense of what is written there.
>>
>> The current patch especially is far too lightly documented for what
>> it is actually implementing.
>>
>> Even its documentation states this:
>>
>> +<revision-range>::
>> +       Range of commits to replay; see "Specifying Ranges" in
>> +       linkgit:git-rev-parse.
>>
>> This "Specifying Ranges" section describes exactly category (1) of
>> what I was talking about, but really the patch enables everything
>> in "Commit Limiting" from git-rev-list.
>>
>> Based on what I see in the patch, I can't help but think that the
>> extra options are an accident.
> 
> This all would be a fine review comment, if you had said that.
> Instead, you stated that setup_revisions() shouldn't be used (which
> might have been fine as an initial comment), and when I pointed out
> exact options and flags that were needed at a minimum you still said
> they shouldn't generally be supported, and after pointing out
> usecases, multiple times, you responded with "if we can find a
> motivation".
> 
> There are two reasons I found that problematic:
> 
> Sometimes it makes sense to say that a usecase shouldn't be supported.
> But, when there's months of effort so far put into implementing those
> usecases, I would expect strong statements about ruling out usecases
> to be accompanied with really good explanations of why those exact
> cases are deemed "bad" and the best possible alternative solutions
> that should instead be implemented to solve something close to the
> proposer's stated desires.  I didn't see that.
> 
> Similarly, there are times when a reviewer should say that code should
> not be implemented a certain way.  But when the person responds with
> some alternatives and their _minimum_ needs trying to find some common
> ground, and has put months of efforts into this wider goal, I would
> expect that ruling out certain methods and their follow up
> alternatives to be accompanied with alternative solutions of your own
> that can solve the proposer's goals; not merely attempting to veto
> suggestions immediately with seemingly no path forward.
> 
> It was an unfortunate set of examples that seemed far below your
> typically excellent reviews.  In contrast, this latest email of yours
> is another high quality response in line with your emails prior to this thread.

I'm sorry I didn't read the prior work linked in the cover letter.
Since cover letters and their external links are not recorded in our
commit history, I have a habit of ignoring them other than getting
some basic context of the series.

I also was less specific about my complaints because I thought that
saying "things like --author" was enough to point out that
setup_revisions() is too generic. Didn't seem like context that was
required until you showed it was required.

> The rest is all fair, but I'd like to point out that there are a few
> problems here:
> 
>   * Tests should generally be passing before submitting upstream, so
> all the code to implement them needs to be sent too
>   * Submitted patch series have to be digestible sizes; not everything
> can be submitted at once
>   * Christian and Dscho wanted some of what I had implemented despite
> other parts not being ready

Outside of my first response (using positional arguments, recommended
before you provided the extra context I was missing) I have not
suggested implementing something that can't be forward compatible. Note
that I've used A..B notation in those replies. I'm suggesting that we
focus on a critical core of functionality that can be carefully tested
while the rest of the system is being worked out. Then, those more
advanced bits can be added carefully with test cases.

When we get to that point, there are creative ways to prepare tests in
advance of a code change such that they make reviewable patches, instead
of creating test debt to be left for later.

> Importantly, the first two issues in particular mean that when the
> first series comes:
> 
>   * If you insist on (or even just suggest) certain changes that
> happen to break capabilities in the pipeline, especially in a fashion
> that cannot backward-compatibly be fixed, then I think the only path
> forward (other than dropping your suggestions) is to engage in
> discussions about those usecases & design *without* the testcases and
> code being available yet.
This sounds a lot like your arguments are focused on reducing the
amount of rework you'd need to do on your pipeline of work that hasn't
been submitted for review. I find that to be an expected risk of working
so far ahead of reviewed patches, and am familiar with that pain. I
don't find that to be a convincing argument.

>> But back to my original suggestion: you can also do something simpler
>> for v1 of git-replay
> 
> That's workable.
> 
>> (say, very limited revision parsing such as one A..B range)
> 
> I'm not fine with that, though.  We already have tests of multiple
> positive refs, so there's no reason to exclude those.  In fact,
> keeping them in is especially important as a means of avoiding having
> other reviewers make suggestions to copy rebase's broken design
> (namely, being limited to a couple commits passed as positional
> arguments with one implicitly being an exclude).

I'm just making one suggestion about where to limit the parsing. If
multiple ranges are doable before refactoring setup_revisions(), then
by all means go ahead. And whatever parsing is accepted in this v1,
we can make sure it works with those future plans.

Focusing on the revisions as described by 'git rev-parse' pointed to
in the 'git replay' docs in this patch would be a great place to start.
 
>> so your progress here isn't blocked on refactoring the revisions
>> API.
> 
> Is that a positive or a negative?  That question may surprise you, so
> let me explain.
> 
> I have a conflict of interest of sorts.  When Christian and Dscho
> (separately) approached me earlier this year and pointed out that
> git-replay had the functionality they wanted, I was happy that others
> liked it, and gave some pointers here and there, but I was _very_
> worried that upstreaming it would result in something getting
> backward-incompatibly locked into place that prevents the pieces that
> are  still in progress from getting implemented.  And I was concerned
> that my plans to create a tool people could experiment with, and that
> we could get usability feedback on (as I suggested at the Git
> contributors summit last year) might be in jeopardy as pieces of its
> functionality get locked into place before it's even ready for
> usability testing.  I was silently hoping they'd lose steam on
> rebasing and cleaning up my patches or choose to just delay until I
> could get real time to work on it with them.  (Since then, the one
> person who had ever advocated for my Git work at $DAYJOB, the best
> manager I had ever worked under, became not-a-manager.  I was
> blindsided by that in February.  Also, I have been transferred to a
> different team and am spinning up there.  And so, to my dismay, I'm
> worried my little sliver of Git time at work may evaporate entirely
> rather than return to previous healthier levels.)  Anyway, I've been
> fretting about things getting "locked-in" for a few months.

I'm also upset that you have been disrupted like this.

> They didn't lose steam, as I found out when these patches were
> submitted.  But, uh, I'm silently torn because I want to help
> Christian and Dscho get what they want, but having them be blocked on
> progress would reduce my stress.  A lot.

From my perspective, git-replay's most important use is being able
to generate rebases without a worktree or an interactive user. For
now, I don't even care if that includes conflict resolution. That's
enough of a lift that has enough unknowns that adding a complex CLI
at this early stage seems like a hasty decision to me. I'm voicing
my opinion that we should avoid backwards-compatibility issues by
implementing only the essentials.

That said, I also want to make sure that you eventually get the
super-flexible command that you want, but only when the framework
is ready for that kind of flexibility.

> Is there any chance people would be willing to accept a "NO BACKWARD
> COMPATIBILITY GUARANTEES" disclaimer on this command for a (long?)
> while, like Victoria suggested at Review club?  That might be an
> alternate solution that would lower my worries.

I'm not crazy about this idea, especially when it is easy to do
something simpler and avoid the need for it. But I'm just one voice
and one opinion.

Thanks,
-Stolee
