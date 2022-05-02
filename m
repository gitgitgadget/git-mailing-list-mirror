Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9A7C433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 19:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiEBTmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 15:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiEBTmm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 15:42:42 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC3465CF
        for <git@vger.kernel.org>; Mon,  2 May 2022 12:39:12 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s2-20020a17090302c200b00158ea215fa2so6980455plk.3
        for <git@vger.kernel.org>; Mon, 02 May 2022 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e/+pK1RVogfoe94mPJhdEp6m8IF047hmuJVJaKH8OYw=;
        b=m7FPG9ULfmYKHmmMvM/jomrr2TEcQiZY5YezfvAc6ATJGAAr/1l88tYeaMqJxlRJOM
         TF3jGAaIApIR6Z1ds2gP2ljOfsuUW9DsLBV6oBKZTkJGgyOHPA5Ct6nO1kLS8kpdac5j
         NCu4WHkV7X7AJOVxEM7cu9ZB14PTOqN5Tg+f4wn4u4bf4sGYWNrNc2/u1xNLkvUDdnFp
         Ua2S0E31wpVZYEzxXYsao3Qtq7AOki4UuIo0T0o4r9i5tofIOFYPMuZ+QOmGDkzy3wjL
         F1+QHST/At9ywgwXrs2vM+OsnaKro/ZKg2OP8ZKGz41zhYMXipTLLZ9D4x+ntC/lCrSW
         eM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e/+pK1RVogfoe94mPJhdEp6m8IF047hmuJVJaKH8OYw=;
        b=0ZD2aus5JvFjJhOOVBcGpl22W1IP04WmUb1pUg1KSkbJ8lerZCv4y/aS0N7II/XSoq
         iGolg900yscK3RBDJzGUIWf8SoHqg5o29/xdJchVvK/jzCuzV7yJf+B3canRW2bNlONp
         gqjV3tmPX0+7HmH6pUwxYNFOmCKO6d6lRfYlmJKfcQmAZYTQmgTSSI1wblqmejU1P1RV
         Ycts25sx8UPFFXq++d1djlQReeSVqMePfN/arp/bPNEkDbpHdPg0M6b7jinxbMxNgx5q
         LiYSjEvV3KI/yfH7JbtDWmZIFJMdrnym4XSk8f79XNtHM8QD79Xy6jVub0rDlhh3rAtY
         HbLA==
X-Gm-Message-State: AOAM533/duwccOVuJhUYotbLR4n0QxoMoEx+qkoHBRjTakUY+7V4ETSa
        ZSWEM/XAjuQp1LZ3TAhv8ORyeg9xCQtwwA==
X-Google-Smtp-Source: ABdhPJwmn/gek7Xv/xelwwJbEhCqyHt/MNH52s8XOl588dyvLOY15XKTKdtv9Ymg+dZWDpnumbppov2HHC6qaA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:df0f:b0:1d9:2372:b55e with SMTP
 id gp15-20020a17090adf0f00b001d92372b55emr830959pjb.104.1651520352143; Mon,
 02 May 2022 12:39:12 -0700 (PDT)
Date:   Mon, 02 May 2022 12:39:01 -0700
In-Reply-To: <YmyNacEAiRl4zLW4@nand.local>
Message-Id: <kl6llevju3l6.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Ylobp7sntKeWTLDX@nand.local> <kl6ly1zno328.fsf@chooglen-macbookpro.roam.corp.google.com>
 <YmyNacEAiRl4zLW4@nand.local>
Subject: Re: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> >>   1. Prevent checking out an embedded bare repo.
>> >>   2. Detect if the bare repo is embedded and refuse to work with it.
>> >>   3. Detect if the bare repo is embedded and do not read its config/hooks, but
>> >>      everything else still 'works'.
>> >>   4. Don't detect bare repos.
>> >>   5. Only detect bare repos that are named `.git` [1].
>> >>
>> >>   (I've responded with my thoughts on each of these approaches in-thread).
>> >
>> >   1. Likely disrupts too many legitimate workflows for us to adopt
>> >      without designing some way to declare an embedded bare repository
>> >      is "safe".
>> >   2. Ditto.
>> >   3. This seems the most promising approach so far. Similar to (1), I
>> >      would also want to make sure we provide an easy way to declare a
>> >      bare repository as "safe" in order to avoid permanently disrupting
>> >      valid workflows that have accumulated over the past >15 years.
>> >   4. Seems like this approach is too heavy-handed.
>> >   5. Ditto.
>>
>> If I understand you correctly, it seems like we can ship any of the options from
>> 1.-3., provided there is an easy way to opt-in known, "safe" bare repos.
>
> After thinking about it some more, I think that we should probably try
> to ship (3) of the ones that we agree are viable, but more on that
> below...
>
>> I really like the `safe.embeddedRepo` idea, though I'm not convinced about
>> "respect only the safe parts of the embedded repo". I'll address the latter
>> first.
>
> To be clear, I am advocating for "only the safe parts" insofar as "read
> repository extensions, core.repositoryFormatVersion and literally
> nothing else". I'm definitely not suggesting we go and enumerate every
> configurable value, determine whether it's safe or not, and then read
> only the safe ones. That approach seems doomed to fail, since no matter
> how clever we are, there will always be some slightly-cleverer attacker
> who can find a vector that we missed.

[...]

>> - This complicates the rules significantly for the user, who now has to figure
>>   out which parts of the bare repo are respected and which are not.
>
> On this point I disagree, but I suspect we weren't on the same page
> about what "only the safe parts" meant when you wrote this. To be
> extra-extra clear, I don't think we should read some parts of config and
> not other, I mean we should read _only_ the above listed parts (the
> format version and extensions) and nothing else.

Ah, to clarify, I'm taking an even more pessimistic stance here, which
is that I'd prefer to avoid trusting any parts of the repo (not the
config) as "safe", e.g. I'm not even keen on something as
innocuous-looking as "We trust _only_ HEAD, refs/ and objects/".

Maybe this is overly-pessimistic though; your response (further down)
suggests that this might not be as bad as I think.

>> - I'm also of the opinion that changing the rules like this actually does affect
>>   workflows, even if it doesn't break libgit2's tests.
>>   - A diligent user still has to convince themselves that the tests are passing
>>     for the right reasons, possibly adapting to the new rules (e.g. by
>>     selectively enabling `safe.embeddedRepo` on the right test fixtures).
>>   - A less diligent user might not even realize the change has happened and
>>     end up with difficult to debug results somewhere down the line.
>
> I am sympathetic to what you're saying, but I (a) think there's still a
> tradeoff here that doesn't obviously point us in one direction or the
> other and (b) we should equally keep in mind other workflows besides
> just test fixtures. Does that change our thinking at all? I'm not sure.

Just musing here. I think (b) is particularly important to keep in mind.
If a workflow is well-served by something else, I really don't mind
breaking it at all.

I suppose the test fixture use case comes up the most frequently because
it is one that we are familiar with, and doesn't seem to have a good
alternative.

Maybe we're approaching the limits of what we can know without
performing some studies of users in the wild.

>> I'm also not keen on it for other reasons:
>>
>> - This expands the attack surface significantly, and I'm pessimistic that we
>>   can maintain a list of the 'safe' parts of a bare repo. A lot of attention has
>>   been focused on config/hooks, but I wouldn't be surprised if a creative
>>   attacker finds some other avenue that we missed (maybe a buffer overflow
>>   attack on a malicious index file?).
>
> I disagree, though again I suspect we were thinking of different thing
> when saying "only read safe parts of the config". Still though, I would
> argue that it limits the attack surface at the right level, which is to
> say any vector that we _did_ miss is something that we should just fix
> (e.g., preventing a buffer overflow) and not "oops, this config value
> does specify an executable".
>
> (We shouldn't have to deal with the index file, though, since a bare
> repository would not read the index, no?).

I think this comment highlights the difference in opinion (in a good
way!).

IMO 'only reading parts of the repo and not others' will fix this
particular arbitrary code execution problem, but it won't fix (and might
even open us up to) other, future problems with embedded bare repos.

From this comment, I get the impression (and I hope I'm representing you
correctly) that you think these future problems are manageable, and
don't justify breaking more workflows than we need to in order to fix
this arbitrary code execution problem.

I think it's a healthy disagreement though - there's enough common
ground for us to start working our approaches separately (plus I don't
think either of us will be able to convince the other by thinking up
hypotheticals on a mailing list thread :p), and the discussion will
probably get even better once we start comparing, reviewing, and
internally testing the patches.

(Ah, I'm not sure about the index file in particular, I was just
speculating.)

>> - I expect that this is also going to be really complex to implement and
>>   maintain; instead of looking in a single gitdir for everything, we now look in
>>   two gitdirs.
>
> I'd think that any approach we take that has different behavior
> for bare repositories depending on whether or not they are embedded has
> to do a similar check, so I don't think this adds significant
> complexity. Though not having written any code here yet, I'd take what I
> say with a huge grain of salt ;-).

;)

>> - There might be some unifying principles behind "allowlisting certain embedded
>>   bare repos" and "disabling/enabling bare repo detection" that can guide our
>>   fix.
>>   - Perhaps we could allow different 'levels' of bare repo protection, like
>>     'allow all bare repos', 'allow only non-embedded bare repos', 'allow no bare
>>     repos', 'allow embedded bare repos but not their configs".
>>
>>   - If we do want to discourage embedded bare repos (and flip the default), this
>>     kind of gradual roll-out might give projects a way to incrementally migrate.
>
> Ah! Are you suggesting a global configuration setting that controls the
> behavior of embedded bare repositories that _aren't_ listed in a
> repositories safe.embeddedRepo list?

Yes, and an even more restrictive mode that disables bare repo detection
altogether. I suspect this is a safe, non-disruptive default for many
user, but it obviously can't be the default today (or possibly ever?
we'd need a lot of user testing for sure).
