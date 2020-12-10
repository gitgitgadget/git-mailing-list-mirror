Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3825AC433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 09:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E305622C7D
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 09:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbgLJJJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 04:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbgLJJJw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 04:09:52 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AF2C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 01:09:11 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d3so3930762wmb.4
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 01:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FySRewJrZlK52eDowG0NtmtAuVxKNf5zERalI9ex6uY=;
        b=GBLAxgCknVYVgqfcgPeLaPmKnzdBi3aa4OkqbeM9PecUHa5oSyEsNWn2GaaFmf0YOQ
         9tMWzXrnw/pPLLGwtWxEVmTSO+onCMOe2gjjEXvDP8sBF4CYqxH4aDCo8s3y/S1ruxsC
         e7udeQfO3+VBnziGTv8BT3LyZjdgTwCRvyqekWKLcLkWNGUKjTyXC4u341uEPTcrrFM4
         xMKbv76MGnu3ErrA3QBpjTKCb6bpDaxfmguMKPc800XY6/pWdoqL4EgEOZLDfgWRxV3O
         yOlOC8Tab1H32PO7IJnD5E5wxFTGs7Hlb6o3HW9KMuO1IIrVzKdabLWsbsnyVceE+nSD
         kgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FySRewJrZlK52eDowG0NtmtAuVxKNf5zERalI9ex6uY=;
        b=BBp5HcUC2LqRiMRlT+GibaUqIdgr7VEXxJ9YnxMjAKqgsLRRwZt5D1MexIBIyc+nYj
         +tU/8wkcbxFq/Eg6YXx2K4bLwZBw8pQC3g/PFzSa2lsOcjoBpw52JPvn1QlZFPQNvWVa
         ldFgU5IS4z3D3/vDlGgWTn28ZQieHVNFbICfYI0W8hjG44TnidSmlfe0i22c7Tbiun/6
         vrhuo8ZjLn3KTddPY/uOE2n9VZQ+pQQS7rr2FZ/kTpSad8LrhvunnuevEcNKngu8Cr+0
         gvqw1OLgD2a3oluR2QXNyRlHfxKULzW2E0IHfJDm/H6sPWPMkAdwhl9vHIHCjBfIfvyA
         mdPQ==
X-Gm-Message-State: AOAM533VEVEp1GmvebODPwQOuqBZ9VxPClwSmvZy76og0eDSCh9hPLwE
        eERqhDYIpgvOb8THbYI7ybUlLgC6/MSFLy4/AB4=
X-Google-Smtp-Source: ABdhPJzk0DXrkeJx4EVWWqsA6UK5Ifu2m2G9Ur2hwVGrP5tNDbyzjc86e/cB8g1Jttsdi5McAwC69T09tedduo6F9Ac=
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr7124416wml.48.1607591350553;
 Thu, 10 Dec 2020 01:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
 <xmqqeek2cc14.fsf@gitster.c.googlers.com> <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
 <xmqqpn3lbhxn.fsf@gitster.c.googlers.com> <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
 <xmqqlfe99yvy.fsf@gitster.c.googlers.com> <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
 <xmqq360h8286.fsf@gitster.c.googlers.com> <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
 <xmqqy2i86ok1.fsf@gitster.c.googlers.com> <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
 <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com> <xmqqy2i6w45c.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2i6w45c.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 03:08:59 -0600
Message-ID: <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 12:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Have I missed some subtlety here?  This whole email appears to me to
> > be arguing against a strawman.  Reading Junio's other emails in this
> > thread[1][2], it's pretty clear he thinks the current behavior is
> > buggy and suggests how it should be changed.  From what I can tell,
> > you appear to be arguing against doing nothing and against only
> > accepting perfection, neither of which were positions I saw anyone
> > take.  In fact, the positions you argue for at length appear to
> > exactly match the ones he took[1][2].  What am I missing?
> >
> > [1] https://lore.kernel.org/git/xmqq360h8286.fsf@gitster.c.googlers.com/
> > [2] https://lore.kernel.org/git/xmqqlfe99yvy.fsf@gitster.c.googlers.com/
>
> I tend to agree that the endgame state I want is pretty similar to
> what Felipe wants.  The seeming confusion is probably due to what
> exactly I mean by "default" is different from what he means.
>
> I view the proposed "for unconfigured users, pull dies, and tells
> them to choose between rebase or merge before it can continue, when
> faced with a non-ff history" as a safe fallback behaviour until the
> users make their choice.
>
> It is a safe fallback to disable the more dangerous half of the
> command until the user gives enough information to the command to do
> its job without damaging the resulting history; it is not something
> the users would actively want to choose.
>
> And that is what I meant by the default behaviour.
>
> And when we stop in such a manner, it is sensible to give an error
> message telling them
>
>  - why we are stopping,
>
>  - what they can do to move the immediate situation forward
>    (i.e. command line option that lets them choose), and
>
>  - what they can do to make their choice permanent so that they
>    would never see the command stop when facing a non-ff history
>    (i.e. the configuration variables).
>
> Up to this point, I think both of us agree with the above.

I don't agree with the above.

The error I propose is just:

  The pull was not fast-forward, please either merge or rebase.

That's it. Nothing more.

I explained that was the final end goal in my list of steps [1]. I do
not think any suggestion for commands or configurations belongs in a
*permanent* error message.

Do we even have an error message that long?

> We start to differ after this point.  I would want to see only
> "rebase" and "merge in the "choice" in the above list.  Felipe, if I
> understand correctly, wants to add the third one, "ff-only", which
> means the more dangerous half of "pull" is disabled by default.

No. I don't want to present the user *any* configuration option in the
*permanent error* message, just: "please either merge or rebase".
That's it.

> I do not want to include that choice, as it would mean the more
> familiar pull.rebase=yes/no would no longer work, and we'd need to
> introduce a new variable, like pull.mode=ff-only.

Whether we present the user with that option or not doesn't matter.
"pull.rebase=yes/no", would still work. The only thing that changes is
what happens if the user does *not* set that option.

The reason "pull.mode=ff-only" needs to be introduced is that
--ff-only doesn't work. Otherwise there's no way the user cannot
select the "safe default" mode. It has absolutely nothing to do with
what we present the user with.

> Without introducing pull.mode, the only thing the users cannot do,
> as far as I can tell, is to explicitly ask for the behaviour of an
> unconfigured user (i.e. error out when faced with non-ff history)
> without being told about the way to use configuration variable to
> permanently record their choice.

That's right, which is a *crucial* thing they must have.

Part II of the proposal has these:

  pull: add pull.mode
  pull: add pull.mode=ff-only
  pull: advice of future changes

This is where we want to be for a good considerable amount of time. A
point where the user is a) warned about future changes, b) can
configure both the old and the new behavior, and c) we have time to
test and tune this new behavior (in case there are mistakes), *BEFORE*
forcing all our users to switch to this new mode (unless they haven't
configured otherwise).

This is what happened with "push.default=simple". We didn't just say:
the simple mode is the default mode, so just leave "push.default"
blank if you want this mode. No. Because in theory we might have
decided before v2.0 that another mode was to be the default, or
perhaps in v3.0 another one will. We want the user to be able to say:
this is the mode I want. Not whatever mode the Git project decides
it's better this day of the week: *this* mode.

There is nothing good about the user being unable to specify the mode
he/she wants instead of the default, even if at this moment in time
they happen to be the same.

Moreover, I can attach a patch on top of part I that skips right ahead
towards part 3, and flips the switch without any intermediary steps.
The patch is simple, but it's likely to be wrong. And I doubt anyone
has tested this patch series at this point. No amount of looking at
the code is going to spot all the problems.

People actually need to try this code.

Otherwise it's just some patches flying around that will never be
merged, and the problem will remain forever there.

> Other than that, the existing
> pull.rebase=yes/no is perfectly adequate.

You cannot specify "pull.rebase=ff-only", but I did send a patch for
that [2]. It was you the one that said it looked "quite funny" [3]:
"it looks quite funny for that single variable that controls the way
how pull works, whether rebase or merge is used, is pull.REBASE".

If you think it's fine to have this warning:

  The pull was not fast-forward, in the future you will have to choose
a merge, or a rebase.

  To quell this message you have two main options:

  1. Adopt the new behavior:

    git config --global pull.rebase ff-only

  2. Maintain the current behavior:

    git config --global pull.rebase false

  For now we will fall back to the traditional behavior (merge).
  Read "git pull --help" for more information.

For months, possibly a year, possibly until v3.0, instead of this one
(which is my proposal):

  The pull was not fast-forward, in the future you will have to choose
a merge, or a rebase.

  To quell this message you have two main options:

  1. Adopt the new behavior:

    git config --global pull.mode fast-forward

  2. Maintain the current behavior:

    git config --global pull.mode merge

  For now we will fall back to the traditional behavior (merge).
  Read "git pull --help" for more information.

By all means, let's go for that, make the decision.

But it was you who wanted to see how a pull.mode solution would look
like [4][5]. Well, this is how it looks like: 3 patches.

> Felipe seems to think
> otherwise and wants not just the "safe fallback behaviour", but can
> explicitly be configured using pull.mode=ff-only (and if that is not
> what Felipe thinks, perhaps we are already in agreement without
> realizing it).

No. It doesn't matter if it's "pull.mode=ff-only", or
"pull.rebase=ff-only", or "pull.ff=only", but one of those must turn
on the behavior that we want. And right now no option does.

> Thinking about it again, I guess pull.rebase=yes/no plus a new
> advise entry can easily give what Felipe seems to want.

It's not about what I want, it's about what the project wants. And I
think it's pretty clear what the project wants:

  1. git pull to eventually fail in non-fast-forward cases
  2. A grace period before that switch is flipped

That's it.

My proposal is the only one (so far) that gives us that.

Cheers.

[1] https://lore.kernel.org/git/CAMP44s2hUCd9qc83LReGyjy8N+u++eK6VjwGhDhrX0f0SbKmig@mail.gmail.com/
[2] https://lore.kernel.org/git/20201123224621.2573159-2-felipe.contreras@gmail.com/
[3] https://lore.kernel.org/git/xmqqim9vlkdn.fsf@gitster.c.googlers.com/
[4] https://lore.kernel.org/git/xmqqy2irjy4f.fsf@gitster.c.googlers.com/
[5] https://lore.kernel.org/git/xmqq7dqagtgx.fsf@gitster.c.googlers.com/

-- 
Felipe Contreras
