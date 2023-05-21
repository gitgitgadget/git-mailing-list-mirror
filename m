Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2F6C77B7C
	for <git@archiver.kernel.org>; Sun, 21 May 2023 13:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjEUNwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 May 2023 09:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjEUNtz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2023 09:49:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D70184
        for <git@vger.kernel.org>; Sun, 21 May 2023 06:49:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso872064e87.1
        for <git@vger.kernel.org>; Sun, 21 May 2023 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684676972; x=1687268972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmhUal0HDMsTHQ2Cf9xrQRINeb0AR6ouH75GOfqC5+c=;
        b=LSd9aySXxTrl6sd6Dlu620MZr+sOjw2v1GBkE00WVQNrpeyBua6DRObUA5wYRTekbe
         4h5Nibmeau2VR6CsSZXBhDnxz6KCyEvO2tcWsUCY0gV9UHYBW5xKvlZmbGYL+eC6B7zr
         uB+KlqqwBmMaveRQly/Kmwe/9IikE8BLRe8snnmkHT4fQm6Z/gP7qwwgYlIUCATBjFV+
         JAM6J0B31IiTznJGRrSmAac4s9J1Log6VRPxS+zEovS/AW9Yq9988vFSTjlOVmbZYkZI
         +FJzUydYOMrlEDXTFJonqcrPWXUcqZBJ7ePJ1Tdt+tLTzLPh46z7SEKeZ5S9AQLm5O5G
         wPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684676972; x=1687268972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmhUal0HDMsTHQ2Cf9xrQRINeb0AR6ouH75GOfqC5+c=;
        b=CKzlFc3VoyTH229WHSQ43Rt7OhQjM5F6pwPikqhp9DeLkuFu8KTaOxZQRyGxsvG/AZ
         PVh8IZRA2Rl81E5eX351oDP6T0yqXkw5vCwUwgpV7PhK5aD7+oU9oQCw0X76WtGTayAc
         X3q59ZbBFTg17zJMFakScpAfRmawKi00CZWhtURYI/HoEKC4wLVGbh9OCdcgtNR8h22h
         dDm0j0ms9DnibgX3vMZELILhpBZO1DKNM1mX7zcikOHgs/7KRlvzrnpku128dsV+pnhD
         I6NnJXRL+fWktws9hrzc8PH/qlO/oDamvAKb7qS4qo9McuHA4n2Go5JCV1EPbLeNDOrz
         O3/w==
X-Gm-Message-State: AC+VfDxCH/QJYLoCtIRho2vWRkuYoFDyMT0nTgXKrJWNdVgagMhYm4Ll
        tzvc/BvYPzp36xuQ+MT7d69WBhPzrxIPfEvoteki0hFLpCk=
X-Google-Smtp-Source: ACHHUZ7liCgkQpcoEpWL8x9ZH2PsUvgbKimAg2DoAnGnXtSAPbJrSHXJueVw2WzHcPPSCcLvJP3zdztd98eQEDbzBsA=
X-Received: by 2002:ac2:5315:0:b0:4ef:6ed9:7af2 with SMTP id
 c21-20020ac25315000000b004ef6ed97af2mr2754464lfh.8.1684676972266; Sun, 21 May
 2023 06:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQx3AYx+sSD4REfTdQ0muY2zRgzE2nR7RgG7cxNgXvwzYzixg@mail.gmail.com>
 <xmqq353qk59y.fsf@gitster.g> <87zg5xq3es.fsf@osv.gnss.ru> <CAOQx3Ab80NMGiMnX+XciYHfXkQG1-PEeuhYO6npP-koCQqsHww@mail.gmail.com>
In-Reply-To: <CAOQx3Ab80NMGiMnX+XciYHfXkQG1-PEeuhYO6npP-koCQqsHww@mail.gmail.com>
From:   Minnie Shi <minnie.shi@gmail.com>
Date:   Sun, 21 May 2023 15:49:06 +0200
Message-ID: <CAOQx3AZMo5pkPjAg5dF=sgQws=nQrHvoPpz70h7sZPuidD0swQ@mail.gmail.com>
Subject: Re: I think there is error in merge documents - current branch
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

do not worry, I found the instructions:
https://git-scm.com/docs/SubmittingPatches;
also just realized that Kristofer Haugsbakk already submitted a patch
(initially I thought his email was just a response).
We are all good now.

Thanks for your time.

Min

On Sun, May 21, 2023 at 3:28=E2=80=AFPM Minnie Shi <minnie.shi@gmail.com> w=
rote:
>
> Hi All,
>
> What is the procedure to update the document to correct the error? As
> I responded yesterday, see below. we need to change the error.
>
> From: Minnie Shi <minnie.shi@gmail.com>
> Date: Sat, May 20, 2023 at 11:41=E2=80=AFAM
> Subject: Re: [PATCH] doc: merge: fix mention of `ORIG_HEAD`
> To: Kristoffer Haugsbakk <code@khaugsbakk.name>
> Cc: <git@vger.kernel.org>, Kristoffer Haugsbakk <code@khaugsbakk.name>
>
>
> Okay, i read one more time, i think it should be read as
>
> Before the operation,
> -`ORIG_HEAD` is set to the tip of the "current" branch (`G`)
>
> instead of
> Before the operation,
> -`ORIG_HEAD` is set to the tip of the "current" branch (`C`)
>
> Kind regards,
> Mi
>
> On Sun, May 21, 2023 at 2:23=E2=80=AFPM Sergey Organov <sorganov@gmail.co=
m> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Minnie Shi <minnie.shi@gmail.com> writes:
> > >
> > >> in summary the sentence should be read as
> > >>
> > >> Before the operation, ORIG_HEAD is set to the tip of the current bra=
nch (H).
> > >> instead of
> > >> Before the operation, ORIG_HEAD is set to the tip of the current bra=
nch (C).
> > >
> > > Not C but G (i.e. the tip _before_ the history is updated).
> > >
> > > I notice that we overuse "current" there.  One is to refer to the
> > > most recent commit on a branch, the other is to refer to the branch
> > > that is checked out.  For the former, we say "the tip" in the other
> > > sentence, and it probably will make it less ambiguous if used that
> > > phrase.
> > >
> > >     Then "`git merge topic`" will replay the changes made on the
> > >     `topic` branch since it diverged from `master` (i.e., `E`) until
> > >     the commit at the tip of the `topic` (`C`) on top of `master`,
> > >     and record the result
> > >     in a new commit along with the names of the two parent commits an=
d
> > >     a log message from the user describing the changes. Before the op=
eration,
> > >     `ORIG_HEAD` is set to the tip of the current branch (`G`).
> > >
> > > My reading also hiccupped with "replay"; the first sentence to
> > > explain the command says "incorporate the changes", and that may be
> > > a less confusing expression; "replay" somehow makes me imagine that
> > > the changes are cherry-picked one by one---it may be only me, so I
> > > left it as-is in the suggestion above.
> >
> > For me "apply changes" or even "apply cumulative changes" works much
> > better than "replay changes" in this context, especially provided we
> > will apparently have "git replay" soon.
> >
> > Thanks,
> > -- Sergey Organov
>
>
>
> --
> Kind regards
> Min



--=20
Kind regards
Min
