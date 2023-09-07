Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A0EC8740
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 15:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbjIGPYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbjIGPX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AEA135
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 08:23:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52bca2e8563so1463348a12.2
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100232; x=1694705032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP2xLNexPSEfDaAGvi8wRAr8r0tqMuFFTeNgKqilVuk=;
        b=hlis+7y1x4dVAL7O0YYhD15BJxxNIMGzvmvnynttQRmDvJvlt1Wnor9B071sjkDZ7I
         hab8x+a9v5gTfZ/Ij5f9EH0Jm/IixW9eniUSbP15ihoQHSNU2m6J46yldDH1o75EJgv2
         WrC6ylNxHQN65St000GvV6mMJS7lR/UPL2CJV4+eqMNhWA/pDVhfd5MLdndHyjbPug4L
         cvT4EwBuoBfTfIpWPIEf47EnjSKOsMonLvdoJ/WbqLpXSpDO0ekW3ZaQeR5Cl51cWqyM
         92l28boLgCalmAKNR//kuiiVBoORBVGoWNORuoVQlzcOcPSC0WmlwhA/gMgtRCWGXKtP
         xckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100232; x=1694705032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vP2xLNexPSEfDaAGvi8wRAr8r0tqMuFFTeNgKqilVuk=;
        b=XOxf28bMjR4omZzhqi/EegiD55Z9mj2WCsXHkskQubyGdl+M9M3C2ZOjjgk1MAAiMp
         09O283I9kpe/XOoUrv5vK4YVlmzZ5yCKKAjZIrTHvN7PcT8aSa2e0N1KWKghitxBlRor
         8TZrNHbgT6zUzoTg7SykALvWCgvBezECRB09qkBy7Cen9wdDeo83De1PtnIN69Sq3WnW
         fSAqH167lfxXIeDXpZzcKoDgusV1zs3BPcVmlR5Os3cePE2q7GmpE+rX9amXDfJz6lnT
         PlKhvFmx2U5CG2/Q0SS5cA66KagTElxqzhP+vxtgGiF2f9k2DD3Ij1QTK4GRNPStqzyx
         6bDA==
X-Gm-Message-State: AOJu0YzFP9BI3EJO5GQ45yt9eVspgz2hB5TtmzNqQA9BaDenBMmEYe3O
        Q8kM9Fr560nUGUid5bdka1yRin/vtLIcmNoHKmF7xDOm
X-Google-Smtp-Source: AGHT+IHJ6pDZ95pn6k3d95xo3Vf4fKYSN+yR/8QTforrfcWwNpt0xjlUi8RtVGg5r0LIVb/Pcg44yilLKxDPw0LxMEc=
X-Received: by 2002:a17:906:ef8f:b0:9a9:d5dd:dacd with SMTP id
 ze15-20020a170906ef8f00b009a9d5dddacdmr2905567ejb.26.1694075738277; Thu, 07
 Sep 2023 01:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com> <20230602102533.876905-14-christian.couder@gmail.com>
 <xmqq8rb3is8c.fsf@gitster.g>
In-Reply-To: <xmqq8rb3is8c.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Sep 2023 10:35:26 +0200
Message-ID: <CAP8UFD3bpLrVW97DH7j=V9H2GsTSAkksC9L3QujQERFk_kLnZA@mail.gmail.com>
Subject: Re: [PATCH v3 13/15] replay: add --advance or 'cherry-pick' mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2023 at 11:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > There is already a 'rebase' mode with `--onto`. Let's add an 'advance' =
or
> > 'cherry-pick' mode with `--advance`. This new mode will make the target
> > branch advance as we replay commits onto it.
>
> If I say
>
>         $ git replay --(advance|onto) xyzzy frotz..nitfol yomin
>
> where the topology of the cherry-picked range look like this
>
>                       x---x---Y yomin
>                      /
>             E---F---x----x----N nitfol
>            /  frotz
>           /
>          X xyzzy
>
> after transplanting the commits, we would get something like
>
>                       x---x---Y yomin
>                      /
>             E---F---x----x----N nitfol
>            /  frotz
>           /
>          X---x----x----N'
>               \
>                x---x---Y'
>
> Now, if this was done with --onto, nitfol and yomin would point at
> N' and Y', but with --advance, where would xyzzy go?
>
> Yes, my point is that without --advance, there always is a
> reasonable set of branch tips that will be moved, but with
> "--advance", you cannot guarantee that you have any reasonable
> answer to that question.
>
> The answer could be "when there is no single 'tip of the new
> history', the command with '--advance' errors out", but whatever
> behaviour we choose, it should be documented.

Ok, I have improved the commit message by adding the following:

"The replayed commits should have a single tip, so that it's clear where
the target branch should be advanced. If they have more than one tip,
this new mode will error out."

I have also updated the doc for <revision-range> like this:

"<revision-range>::
    Range of commits to replay. More than one <revision-range> can
    be passed, but in `--advance <branch>` mode, they should have
    a single tip, so that it's clear where <branch> should point
    to. See "Specifying Ranges" in linkgit:git-rev-parse."

> > +--advance <branch>::
> > +     Starting point at which to create the new commits; must be a
> > +     branch name.
> > ++
> > +When `--advance` is specified, the update-ref command(s) in the output
> > +will update the branch passed as an argument to `--advance` to point a=
t
> > +the new commits (in other words, this mimics a cherry-pick operation).
>
> This part is not giving much useful information to determine the
> answer (which might be fine, as long as the answer can easily be
> found in some other parts of this document, but I would have
> expected everything necessary would be found here or one item before
> this one about --onto).

The doc about <revision-range> is just after the above, so I think the
above change in the <revision-range> doc is Ok and enough here.

> > @@ -47,7 +55,10 @@ input to `git update-ref --stdin`.  It is basically =
of the form:
> >       update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
> >       update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
> >
> > -where the number of refs updated depend on the arguments passed.
> > +where the number of refs updated depend on the arguments passed.  When
> > +using `--advance`, the number of refs updated is always one, but for
> > +`--onto`, it can be one or more (rebasing multiple branches
> > +simultaneously is supported).
>
> "dependS on the arguments passed" is not incorrect per-se, in the
> sense that if you "replay --onto X E..N" (in the above picture), I
> think you'll move F and N (two), while "F..N" will only move N
> (one).  But the important thing to convey is how many branches had
> their tips in the replayed range, no?  "depends on the shape of the
> history being replayed" would be a more correct thing to say for the
> "--onto" mode.  For "--advance", presumably you would require to
> have a single positive endpoint [*], so "depends on the arguments"
> is still not wrong per-se, because "when --advance is part of the
> arguments, the number becomes one".

Yeah, I agree.

>         Side note: even then, I suspect that
>
>                 git replay --advance X E..F N
>
>         should be allowed, simply because there is only one sensible
>         interpretation.  You'll end up with a single strand of
>         pearls F--x--x--N transplanted on top of X, and the range
>         happens to contain F and N but it is obvious the end result
>         should advance xyzzy to N because F fast-forwards to N.
>
> I'd say "where the number of ..." and everything after these sample
> "update" lines should be removed,

I am not sure it's a good thing to remove that, as I think repeating
how things work in the context of an example output can help people
understand. I have updated these sentences to the following:

"where the number of refs updated depends on the arguments passed and
the shape of the history being replayed.  When using `--advance`, the
number of refs updated is always one, but for `--onto`, it can be one
or more (rebasing multiple branches simultaneously is supported)."

> and instead we should add a few
> words to the main description of the options, e.g.  for "--onto"
>
> > +When `--onto` is specified, the update-ref command(s) in the output wi=
ll
> > +update the branch(es) in the revision range to point at the new
> > +commits (in other words, this mimics a rebase operation).
>
> we could update the above to something like
>
>     ... will update the branches in the revision range to point at the
>     new commits, similar to the way how "rebase --update-refs" updates
>     multiple branches in the affected range.

Yeah, I agree. In the version 4 I will send soon, have updated the above to=
:

"When `--onto` is specified, the update-ref command(s) in the output will
update the branch(es) in the revision range to point at the new
commits, similar to the way how `git rebase --update-refs` updates

multiple branches in the affected range."
