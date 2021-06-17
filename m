Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615F2C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D2961249
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhFQQFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 12:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbhFQQFe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27520C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:03:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l1so10736525ejb.6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=LVKigdIidLLabewNFBuZLUmiYwDQvii9d7h0bMpC6/8=;
        b=fGdZZLQ+BR6oLwqLDxbsTVap0wMP6QQvSKEMHRwZ44+BEHU0T6IEol5SK12KTudrl4
         HsSEv0mNyrNzF5Wqf1GIvKGpUZGqhZMNCEUvI244hPIP7TF+xMe5aLC+VWzTL/fA6spb
         TPTkb+gGQvNqdl4hD0sMlUZzERdzyXzK2vb2kPj4RJ/tTEEuhjLaSdzh4D5XHcKO7+Zp
         jGvA03y0yL6o9gODYPRbxn0y5e0QaF3yjWgzeCYIy18H/46WSeWUsoYKJwoY5qwnpNci
         B8b/VlShbiCeS+W+jSSHml1gDMavNl0WOznq/ksm47hOLSmzdjrDnEbsgTFa5y1PZroV
         BJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LVKigdIidLLabewNFBuZLUmiYwDQvii9d7h0bMpC6/8=;
        b=tr2m6fw/6QYiquNeuPJ5tKSq1jN81l/v7NWXzKJlcvVkR0ulWY3PCHagAkpFSZBH0/
         I3KpO7GN2PYrp6ZXJ9TNlDUHBPlqg+B8hFkpw+R2vf3KQ0wP/NXS/BBkuAxYOfIhkiks
         SF9Njx3+F+PorUP2L3IjzVwPAW7Ij3RBffS45RxH4Dn5TlPjhaSJ6HeHL/hCZQpqtpM9
         jMzmb7ARKkozei9WQJtKb6YTDT/TCOQH6g/BGylxqON5AH9tZzbBtYu5VB6dEotD4293
         5M1CHgu7ed39obuG1x4BqDsQFX8lpkZ1o92H8t5NMXZoWbGh474Ov/R7ajS+AIHxjPwH
         cP6A==
X-Gm-Message-State: AOAM530SR5C/rhag8tRK2a1ZZoJ69icp8D0mBYuoXm0li4aStKnRDrvG
        Uuvx7CvBV3ZHDSEf2PsguzA=
X-Google-Smtp-Source: ABdhPJzplcA0OGahVnjgYb6Tgk+ygmDoEx2ufXJuwGfnpmdoSIlknhFTWakzQtfqxDlvlvZ947Xftw==
X-Received: by 2002:a17:907:6fd:: with SMTP id yh29mr6184160ejb.432.1623945804672;
        Thu, 17 Jun 2021 09:03:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r4sm3919832ejd.105.2021.06.17.09.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 09:03:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Date:   Thu, 17 Jun 2021 17:58:51 +0200
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com> <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g> <87bl85y15s.fsf@evledraar.gmail.com>
 <xmqqtulxnyhb.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqtulxnyhb.fsf@gitster.g>
Message-ID: <87lf78wkac.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 17 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>   - Discussing command-line options, and program functionality:
>>
>>     Prefer succinctness and matter-of-factly describing functionality in
>>     the abstract.  E.g.
>>
>>      --short:: Emit output in the short-format.
>>
>>     Avoid more verbose constructions, such as:
>>
>>      --short:: Use this to emit output in the short-format.
>>      --short:: You can use this to get output in the short-format.
>>      --short:: A user who prefers shorter output could....
>>      --short:: Should a person and/or program want shorter output, he
>>                she/they/it can...
>
> This applies the most broadly and addresses common readability
> issues, which is why I like this part the most.

*nod*

>>   - Addressing the reader:
>>   - Discussing Git, "the command" etc.:
>
> I am not sure if these are even worth saying, especially when we do
> not explain why we recommend to do so.

Maybe not, I tried to just grep around / search in my memory for how we
talk about this, to cover that base. I.e. when we talk about "you", then
other commands (this part), permissions, remote users etc...

>>   - Discussing other users:
>>
>>     When referring to other users on the same system prefer talking
>>     about "a user" or "another user". There's usually no reason to
>>     invent a cast of characters with names, titles and hobbies.
>>
>>     Your OS's users don't cleanly map onto any particular people, a user
>>     of git might be having a merge conflict with another person, or an
>>     automated commit from a cron daemon.
>>
>>     We prefer the style typical of standard library adn system tooling
>>     documentation in this and most other cases, you can look at the
>>     documentation of chmod(2) and other commands, syscalls and libraries
>>     that deal with UIDs or GIDs for examples.
>
> I cannot exactly put my fingers on where this feeling comes from,
> but this part appears to spend many lines to tell me very little.
>
> For example, it is unclear why the second paragraph is there at all.
> Sure, some commits may be created by a non people, but how does that
> fact affect how I write the documentation?  Writing about such an
> activity by non people, what are our recommendations?  The third
> paragraph does not do much better.  Unless you have UNIX man pages
> handy, chmod(2) may not be very easily accessible.  It feels as if
> it wants to encourage descriptions without human actors, without
> doing a very good job at explaining to readers why the guideline
> does not want to see them in our documentation.

The real problem here is that a clearly overly verbose person is trying
to write guidelines about how to be less verbose :) Yes, that can
probably go entirely.

> Unlike chmod(2) and getpwnam(3), but more like any dSCM, Git is a
> tool to help inter-person communication, and at some point we will
> have to talk about contributors asking their upstreams to pull their
> work from their repositories.  It won't be like system calls dealing
> with pure numbers.  We do not have to give them names like Alice and
> Bob, but we do have to refer to repositories of these cast of
> characters individually to clearly explain/describe how data flow
> among them.

I'd think that the *nix permission model in general and FS-like
permission models (including pseudo-implementations thereof, such as
Google Docs sharing etc.) in general are a much bigger helper of
inter-persion communication than Git is.

Which is what I was trying to aim for, the documentation for such
systems can usually talk about the permission models and "foreign" data
in matter of fact terms. E.g. we really don't need to drag up an example
of another person on the system to explain core.sharedRepository to you,
or more generally why you get a permission error when you "cat"
something on a *nix system.

But yes, could be improved etc.; does anyone have a better suggestion? I
think whatever I come up with at this point is probably much better
copyedited by others.

>>   - Discussing other systems:
>>
>>     As with discussing other users, git might interact with other
>>     systems over the network. In these cases we also avoid a cast of
>>     characters, preferring to talk about concepts like "fetching data
>>     from a remote", having a conflict with "diverging histories" etc.
>
> Unlike the above "other users", I have littleproblem with this part.
> It however feels funny to warn against use of "cast of characters",
> when the first sentence talks about "with other systems", which are
> clearly not people.  Even when you are "fetching from a remote", you
> are getting the result of work by "other people", so I would not
> have separated "other users" and "other systems" in separate
> sections.

What I was trying to go for here is that we could say you do a fetch,
get a divergent branch, and a conflict, and then proceed from
there. It's just a distraction in such examples to set up a scenario
where J. Doe is the author of those commits, you can't reach them at the
office right now (maybe they're at lunch), but you need to resolve the
conflict yourself etc...

>> The references to "gendered prounouns" etc. are gone, perhaps there's a
>> good reason to re-include them, but the point of "isn't that issue
>> solved by recommending an orthagonal approach?" is one of the many
>> things Stolee hasn't been addressing in the threads related to this
>> series.
>>
>> To me that whole approach is somewhere between a solution in search of a
>> problem and a "let's fix it and move on". Not something we need
>> explicitly carry in our CodingGuidelines forever.
>
> This I think is the crux of the differences between you two.  I'd
> love to hear Derrick's response and eventually see a middle ground
> reached.

Covered downthread.
