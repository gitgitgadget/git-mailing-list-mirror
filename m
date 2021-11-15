Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2113C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FAF61A0A
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhKPAbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345797AbhKOT3V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:21 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B26C0BC9B1
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 11:03:14 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p24-20020a170902a41800b001438d6c7d71so5018730plq.7
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 11:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :content-transfer-encoding;
        bh=Z7AIctsY1HqUU7qQuXrQoc6BooNHDq2SyIzI/uUYukU=;
        b=VMPxV12pxrgf5jLKOB2ZD8OiSrOM2OyjcJekAcw5HaaG0gyDaK+ZiwPHdtP4PSpzLW
         KTIake3evKEGL0Kef23kjthxLaXY5NeANiTo9l/WLzdMpAJJcuFvB/1qBcoYeWSKqEid
         Fe5quzjJTTNcEOAt6b/ijI/AVzjWPBsldBUp/kBRPygYW/ReVGs8lJ+jwkKPK3Hj25It
         BdD6FHI9wy2HpZeLvDiTaEyzyP+Jxu3QUEN1h08dX6AVZDFdLl6tee4uB4GJhVbZKwRB
         LJzU3lVSR3NRdkGRmaUg3nzsL1C7uVc73WwrNbBjgvklISgQui3IURmN6NJ+dn/0rgeQ
         l3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:content-transfer-encoding;
        bh=Z7AIctsY1HqUU7qQuXrQoc6BooNHDq2SyIzI/uUYukU=;
        b=2Iw8kgjXQPiW+VFJ9Lrt8Umx6kbuYGhthQJ/06ZGowTjvklseCFnWoUfads7HZaG7Q
         0Sz3DUJjDw+PYamBj8dP021N0xeCZUjuwc63jDpFDdC5p8gK8WIj4tgiG43ZhtyGr9f/
         EXajbmvKCmAzlKa6rmaprNBElHoQBwqJGc/uxMEDHUpI1tTlAIgjawV1jTmv2wSt1Coo
         KP6RsgqUhC9Bcc210723vSvqNj7efRw9nq2qJiq9UWmsf8iSoGmyvPFAO4vaiA2k4X1v
         ljr1hbjcQNYJcMTvurEsCBjpCEOMCcsfnPl6/V2lGkw9Nh+o+tclUPHD713TN5qsRaVm
         TNDA==
X-Gm-Message-State: AOAM531JejiojPZZb4lRonDY3a9pEkFTBq1G1fOO2F/t3ertKWFD6mvK
        mmWUVV4Qk/ERqlov7VO+BPNHELD25ga9ZA==
X-Google-Smtp-Source: ABdhPJxiFiGchUzpgRg/9Dt3pqEnFZTNu64bjzLQReBNi4DE6b5cMfYDsF1dqWLL92pgjYu0ikVo2MSQ5IOq0g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:a94:b0:44c:ecb2:6018 with SMTP
 id b20-20020a056a000a9400b0044cecb26018mr35306369pfl.57.1637002994440; Mon,
 15 Nov 2021 11:03:14 -0800 (PST)
Date:   Mon, 15 Nov 2021 11:03:12 -0800
In-Reply-To: <bb9c0094-8532-c463-47a2-442b225ad52e@gmail.com>
Message-Id: <kl6lr1bhtf67.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com> <bb9c0094-8532-c463-47a2-442b225ad52e@gmail.com>
Subject: Re: [RFC] Branches with --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks so much Philippe, your responses are very thoughtful.

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> * `git branch --recurse-submodules topic` should create the branch
>>    `topic` in each of the repositories.
>
> I guess for some workflow this would be the good, but for others you migh=
t
> not need to create submodule branches for each new superproject branch yo=
u
> create.  I think I pointed that out before; I don't necessarily think tha=
t
> creating branches in all submodules should *not* be the default behaviour=
,
> but I think that it should be configurable. I mean that if I have 'submod=
ule.recurse'
> set to true, I would not like 'git branch topic' to create a 'topic' bran=
ch
> in each submodule. So I wish I'll be able to add 'branch.recurseSubmodule=
s =3D false'
> to my config (or something similar) to have more granularity in behaviour=
.

Yes, as we discussed earlier, this behavior may not be desirable for
different workflows. I've come to suspect that the branching behavior
that I proposed should be the default, but I'm ambivalent on being able
to opt out of the branching.

In favor of letting users opt out: I'd imagine that behavior might be
disruptive to users who make frequent changes on the submodule and may
not appreciate having two sets of branch names (one from the
superproject and one from the submodule's remotes). I'm not clear on
whether or not this is disruptive primarily because it is a breaking
change, or if this just an objectively bad fit for what these users
want.

In favor of not letting users opt out: exposing fewer switches to users
makes it easier for them to get a good user experience. Instead of
giving users the ability to build-your-own UX, maintaining a small
configuration surface makes configuration easy and puts the onus back on
Git (or me, really :P) to make sure that the UX really works well for
all users, instead of opting out and saying "oh the user has
branches.recurseSubmodules=3Dfalse, so I'll choose not to support them".
I think this stance is good from a product excellence perspective, but
it's an obvious risk.

A way forward might be:

* mitigate the breaking changes by flagging this with
  feature.experimental
* test this behavior with real users (aka internal) and iterate from
  there

Does that make sense? I'd like to make sure I'm not missing something
very big here.

> Also, I assume the new behaviour would carry over to 'git checkout -b' an=
d
> 'git switch -c' ?
>> * `git switch --recurse-submodules topic` should checkout the branch
>>    `topic` in each of the repositories
>
> Nit: I guess you also include 'git checkout --r topic' here also ?

Yes and yes (I believe --r refers to --recurse-submodules?).

>> * If the branch is in an unexpected state, we either:
>> ** Fallback to the version that the user would expect (if it is safe to
>>      do so).
>
> What would be 'the version the user would expect' here ?

The issues is that defaulting to 'the version the user would expect' is
a fairly uncontroversial opinion, but it leaves a lot of room for
interpretation. I suspect that there won't be a single set of rules that
can apply in every single command and situation; we would never make
progress if we tried to start with a top down approach.

Instead, this RFC prescribes one consistent set of 'expected versions'
under a subset of operations {branch,switch,checkout}...

>> =3D=3D=3D Switching _to_ a branch `topic`, i.e. `git {switch,checkout} t=
opic`
>>=20
>> Switch to `topic` in the superproject. Then in each submodule, switch to=
:
>>=20
>> * `topic`, if it exists
>> * Otherwise, the commit id in the superproject gitlink (and warn the
>>    user that HEAD is detached)
>>=20
>> If the submodule `topic` points to a different commit from the
>> superproject gitlink, this will leave the superproject with a dirty
>> worktree with respect to the gitlinks. This allows a user to recover
>> work if they had previously switched _away from_ "topic".
>
> OK, so you seem to answer my interrogation above about "what is the versi=
on
> the user would expect ?" with "the commit at the tip of 'topic' in the su=
bmodule,
> if that branch exists.".

which you have noted here :)

>> =3D=3D=3D Switching _away from_ a branch `topic`, i.e. `git {switch,chec=
kout} other-branch`
>>=20
>> Checkout `other-branch` if each submodule=E2=80=99s worktree is clean (e=
xcept for
>> gitlinks), and has one of the following checked out:
>>=20
>> * `topic`
>> * the commit id in the superproject gitlink at the tip of 'topic'
>
> Is that what you meant ? (that would indeed make sense).

Yes, thanks for the wording suggestion.

>> If a dirty worktree is unacceptable, we may need an option that is
>> guaranteed to check out the superproject=E2=80=99s `topic`.
>
> Yes, I would think that should be configurable, maybe something like
> '--recurse-submodules=3Dbranch' vs '--recurse-submodules=3Ddetached' (whi=
ch
> is the actual behaviour). Just thinking out loud here.

Yes, your wording is also similar to what I was thinking of. I'm holding
back from this because, as stated earlier, I'm worried about having a
build-your-own UX situation and bifurcating (or worse) our development
efforts.

>> Check each submodule at the superproject=E2=80=99s `start-point` (not th=
e
>> submodule=E2=80=99s `start-point`) for the following:
>>=20
>> * The submodule is initialized (in .git/modules)
>
> The submodule should also be active, no ? Maybe it was cloned before,
> so exists in .git/modules, but was then set as inactive (submodule.<name>=
.active=3Dfalse)...

Ah yes, good catch.

>> * For uninitialized submodules, prompt them to initialize it via git
>>    checkout start-point && git submodule update (we are working to
>>    eliminate manual initialization in the long run, so this will become
>>    obsolete eventually).
>
> I think if the submodule are not initialized, they should be left alone, =
without
> prompting the user. Projects that use non-optional submodules already ins=
truct
> their users to clone with --recurse-submodules or run 'git submodule
> update --init --recursive' after the clone, so I'm not sure that sort
> of nagging would be necessary...

To make sure we're on the same page, I'll give a motivating example.
Let's consider a superproject with remote-tracking branches
`origin/main` and `origin/topic`.

`origin/main` has submodules `sub1` and `sub2`.
`origin/topic` has submodules `sub1` and `sub3`.

Imagine a user has branched off `origin/main` and has initialized the
submodules using git submodule update --init. At this point, `sub1` and
`sub2` are initialized. `sub3` is not initialized (because it's not in
`origin/main`).

What happens when the user now wants to work off `origin/topic` with
`git branch --recurse-submodules topic origin/topic`? `sub3` isn't
initialized, so the branch can't be created.

So to get back to your main point, before we eliminate this problem,
what do we do? Do we abort and naggily warn the user? Do we try our best
and just ignore `sub3`?

Your suggestion might be superior to mine:

* for users who don't care about `sub3`, they are not blocked from
  creating branches
* for users who do care, they would checkout `topic`, realize
  that `sub3` isn't initialized and then perform the initialization and
  (at some point) realize that `sub3` doesn't have the `topic` branch
  and so they fix this manually.

I'll consider this more deeply, thanks.
