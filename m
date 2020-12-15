Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F657C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 01:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA81722209
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 01:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgLOBmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 20:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbgLOBmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 20:42:21 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE7DC061793
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 17:41:41 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id r5so19256186eda.12
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 17:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mRPa61nnmpxeb1ny9CETnaLyDRpPAEcSgWlQUKEDl1w=;
        b=D3SIPCvIsH4AJGvz9tSoa6jE0ZseQwViUXpxW5+ify8wbUBFtSmvL4LE8Ilq3C/Ng0
         6ix/e38NNfCfwL/y7oWCDkfRVLT1crPx2J7KaEekSE9q3SEhczQ8k0QS2OWK5L35oCvA
         zjh+HRH6hOQ8V8ete5zC1khSh78+6LTWJWMtdqu/m+f3KBNd7jDjHg0yGGmp1h0rOh9w
         H2/TnMzTVQ7ncdkosXGCib+fiadsIfv/2hL6CmqR8LJwNV3eljLuL7JW5LNuCg3/YnCz
         DfeLLtxbqgm1+NHR6ma44QxDmgKN5GriTtK47OotpJDmMxGz0pKa/0o7QT83GM9gGBL7
         DgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mRPa61nnmpxeb1ny9CETnaLyDRpPAEcSgWlQUKEDl1w=;
        b=rfRCfNAbewxigo8K5PNRy99067GQZXJMJAlFYESKmmZXdcLOBNNCJMvQ9ZhJhZYpOi
         CmgXyBrIjCY045GNLpjs2Ea2j+/LM/qBaOgGd3i70zBYWBBB8r6b5DBXA2fRjeg1bOuS
         qJbkvbdSYiynr6j5W7W9nqZlqxzYx4/qZ8KOQknNlxGpwPls1oOvvFUR2Xe3n1spmGMI
         XuqYUYP82fG/hlluhqY5xCG9QNfrj9ppgF+nJXQuO4kv1KYX/UopdkqwPOlQdHJ6k6PS
         qm9RrDQevRK91lW9aYN07WtHfB4CIc8a9rnTkX7ba8nSjMx3/RwlNwdlAi7xT2cu5D2b
         T/Xg==
X-Gm-Message-State: AOAM531rqRo+hpSbR8b8O3yZUtGBh+aeQPiSMruwdwGnkehqoAI/hQT0
        oWB9omaoo80I2PrjdG+15ZE=
X-Google-Smtp-Source: ABdhPJzbMp3+TdN+25v+X8Q0+aAD0/WDSUyQ7pbdAV4qeptRWW5uVUnNN4kXoy091EaPpF8pczbOZQ==
X-Received: by 2002:a50:ee8e:: with SMTP id f14mr11988503edr.176.1607996499969;
        Mon, 14 Dec 2020 17:41:39 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id x16sm114650ejo.104.2020.12.14.17.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 17:41:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <20201211210508.2337494-1-jonathantanmy@google.com>
 <87blewwoil.fsf@evledraar.gmail.com>
 <xmqqim94e4et.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqqim94e4et.fsf@gitster.c.googlers.com>
Date:   Tue, 15 Dec 2020 02:41:38 +0100
Message-ID: <878s9zx2ul.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 14 2020, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> Maybe not for reasons I haven't thought of, but I'd at least be much
>> happier with an updated commit message justifying another special-case
>> in clone that you can't do with "init/fetch".
>
> This is *not* another special-case, but is 14-year old outstanding
> one, so I do not think there specifically needs such justification.
> The log message DOES need to be clarified.  Your mistaking that this
> is a new feature and not a bugfix may be a good indication that the
> proposed log message is not doing its job.

For context: This clone feature has been there since early 2009, it
wasn't until late 2017/early 2018 that we had protocol v2 that gave us
the ability to fix the bug.

I suppose the distinction between what's new behavior and what's a
bugfix in something that was really meant to work a certain way all
along but didn't is too subtle for me to discern sometimes :)

86ac7518590 (Allow cloning an empty repository, 2009-01-23) which added
it seems to match my mental model of it being just a shortcut for some
of the the URL config "init" otherwise wouldn't setup for you. At a time
when git-init.txt said:

    An initial `HEAD` file that references the HEAD of the master branch
    is also created.

> > Another reason I'm not a fan of it is because it's another piece of
> > magic "clone" does that you can't emulate in "init/fetch".
>=20
> That ship has sailed longlonglong time ago when dfeff66e (revamp
> git-clone., 2006-03-20) started pointing our HEAD to match theirs.

Let me rephrase: I think it's unfortunate when we add new things things
to porcelain commands that aren't easy or possible to emulate in
plumbing.

I.e. this feature seems like a candidate to be exposed by something like
by a ls-remote flag if you'd like to do an init/config/fetch. AFAIK the
only way to do it is to mock a "clone" with GIT_TRACE_PACKET or get the
information out-of-bounds.

>> And on the "litte gain" side of things: I very much suspect that the
>> only users who'll ever use this will be some big hosting providers (but
>> maybe not, the commit doesn't suggest a use-case).
>
> Explorers who learn this new GitHub or GitLab thingy, create an
> empty repository there and then clone it to their local disk, just
> to dip their toes in the water, would most benefit.  Those of us who
> are working on an already existing and populated projects won't be
> helped or bothered.  We do sometimes create our own repositories and
> publish to hosting sites, and I expect that many experienced Git
> users follow the "local first and the push", and they won't be
> helped or bothered.
>
> But I expect some do "create a void at the hosting site and clone to
> get a local playpen" for their real projects.  They would be helped,
> and because Git userbase is populous enough that their number in
> absolute terms would not be insignificant, even if they weren't in
> percentage terms.

That's how I've always used it. Seems from the above-referenced
5cd12b85fe8 that's what it was meant for to begin with.

Anyway, there's 3 replies to my E-Mail including yours insisting this
makes perfect sense, I'm happy to go along with the consensus. I wrote
my reply with the assumption that it was obvious that this was a change
in established behavior, but apparently that's not the prevailing view.

To borrow from Felipe Contreras's reply in the side-thread "I expect the
branch name to be chosen by the person who created that repository".

I suppose this comes down to a mental model of what it means to have
"created a repository". When I click "create repo" on those popular
hosting sites (e.g. github & gitlab) and clone it I was expecting it to
just be a shorthand init + a URL in my config (and refspecs...).

That's also what happens with this patch if you "git init --bare
/tmp/my.git", then edit the HEAD symref to point to "foobar" and clone
it with file:///, it'll be "master" in your clone (or whatever
init.defaultBranch is). Isn't that discrepancy a bug then?

But of course then when you push your "foobar" as the first branch the
HEAD symref won't be updated. In the olden times when everyone ran their
own git server this was a common FAQ, "just run 'git symbolic-ref'".

On both of those big hosting sites (didn't test others) whatever their
preferred default name is they'll go with your idea and update HEAD's
pointer on the first such push. So this notion that the default unborn
symref isn't transported & it's up to the client to set it on-push (or
manually afterwards) has been reinforced by in-the-wild use.
