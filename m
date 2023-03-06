Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E10C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 00:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCFADW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 19:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCFADV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 19:03:21 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13018A4E
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 16:03:19 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id bd3-20020a4aee03000000b00517affa07c0so1298562oob.7
        for <git@vger.kernel.org>; Sun, 05 Mar 2023 16:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678060999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLZ3VGdwju3H1inJOu/kQ6ZWS4y7Nav2rF7alVq8m9w=;
        b=iMhdKKYdNhUk4qhn9d0M8+BP+ChIfmP1RcBSgefOWsLu4+GEoNzJva5/CVDveASh9D
         zHTiJWFLU3f0osmO+lZpAknfCY1VuzkKFGn71T0uNlxev9LckLMeHfTakRD/y9EhnFb6
         TWXUUBiFNZ4XgQCRSAFprVreeGOzvGQRxE5BD6lDHmeYB/D7aHnXjmchixGb8elYm+XZ
         5yEoeELdlJB6mRLzjjDfc1C0iV2PcRVovAMcFScPd9zGjUJWulbP4BkEs4Yd01u16x9Z
         Dv4solszYZUdk/TPwdfpdNHn7Mp24aIrmrVtQzeMxt1T9djdPEYAhdpbvl0d3HaZryt/
         WBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678060999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLZ3VGdwju3H1inJOu/kQ6ZWS4y7Nav2rF7alVq8m9w=;
        b=KnaI9RC380pMhRMK8ldjRktp3dleoNl0CI27lI4rmTlR7uFAzTxGizantCz2/B7+sK
         DCJaJAWsyEbiVLoNNxrLz51OQ6g4SeDVvy1CvgkCMSQl/GjuAcOjSMkjwtAASdm44IX9
         5P7BOIL4IhamBUZa8Ip3ZUgJdB4bicnGxaXt8JQxiEP0SxkzC+o11u/bvME3oyG0/ymR
         5lAdiCpJDSBfPubArs9vNNZ0pYEpc7uv7G2KxOTypO3xHCtFSqbBDeyEB8/I1L6aZknF
         oKSF4GUOTqkprKPwqoZM0Emz0dPuYq9GHBzo2K0vGPwBU4Xdv6Jg52bmHneghldA5YYX
         0TQQ==
X-Gm-Message-State: AO0yUKVCFlTNeY42JVqxingBVbjmkB8Grn9/OrNkHKsoLI1bIS1Iuiju
        3eaGCcHbwtwYRzbEIqkSwCx2CRPfZy4/rfaiULg=
X-Google-Smtp-Source: AK7set/JwE/5iPUE3kCadzjFzhzZi7HfkwVHt8sz0B560imYfmBapXmYn+pFS3R+h7tTt750HgBR/g/apXtHNHJGC1w=
X-Received: by 2002:a4a:a3c9:0:b0:517:bff1:77e with SMTP id
 t9-20020a4aa3c9000000b00517bff1077emr3232100ool.1.1678060998861; Sun, 05 Mar
 2023 16:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <87ilff2xsl.fsf@osv.gnss.ru>
 <CAMMLpeSowxoJgPOt84Dos8BVKU=y=M+Ph0xaGe6UTxwwE5zsXQ@mail.gmail.com> <87ttyyn71f.fsf@osv.gnss.ru>
In-Reply-To: <87ttyyn71f.fsf@osv.gnss.ru>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 5 Mar 2023 17:02:42 -0700
Message-ID: <CAMMLpeTUykcgdijRPEiBJHH1xz50s=aPK_hi=FJv6C3=cj4XEg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] rebase: document, clean up, and introduce a config
 option for --rebase-merges
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com,
        calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 5, 2023 at 3:54=E2=80=AFPM Sergey Organov <sorganov@gmail.com> =
wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > On Sun, Mar 5, 2023 at 5:22=E2=80=AFAM Sergey Organov <sorganov@gmail.c=
om> wrote:
> >>
> >> Alex Henrie <alexhenrie24@gmail.com> writes:
> >>
> >> [...]
> >>
> >> > - Rephrase the warning about --rebase-merges=3D"" to recommend
> >> >   --rebase-merges without an argument instead, and clarify that that
> >> >   will do the same thing
> >>
> >> Not a strong objection to the series as they are, but, provided option=
s
> >> with optional arguments are considered to be a bad practice in general
> >> (unless something had recently changed), I'd like to vote for adding:
> >>
> >>   --rebase-merges=3Don (=E2=89=A1 --reabase-merges=3D"")
> >>
> >> and for suggesting to use that one instead of --rebase-merges=3D"" rat=
her
> >> than naked --rebase-merges.
> >>
> >> It'd be best to actually fix --rebase-merges to always have an argumen=
t,
> >> the more so as we have '-r' shortcut, but as this is unlikely to fly d=
ue
> >> to backward compatibility considerations, this way we would at least
> >> avoid promoting bad practices further.
> >>
> >> If accepted, please consider to introduce
> >>
> >>   --rebase-merges=3Doff (=E2=89=A1 --no-rebase-merges)
> >>
> >> as well for completeness.
> >>
> >> BTW, that's how we settled upon in the implementation of --diff-merges=
,
> >> so these two will then be mutually consistent.
> >
> > I am curious as to why you say that flags with optional arguments are
> > considered bad practice.
>
> As far as I can tell, the core problem with such options is that generic
> options parsing code can't tell if in "--option value" "value" is an
> argument to "--option", or separate argument, that in turn may lead to
> very surprising behaviors and bugs.

Interesting, thank you for clarifying. I just tried it and it appears
that --rebase-merges requires an equals sign when it has an argument.
For example:

$ git rebase --rebase-merges=3Drebase-cousins
Current branch master is up to date.

$ git rebase --rebase-merges rebase-cousins
fatal: invalid upstream 'rebase-cousins'

So there is no ambiguity because if an argument to a flag is optional,
an equals sign is required.

Conversely, because the argument to --diff-merges is required, the
equals sign is optional.

I can see the argument (no pun intended) for avoiding optional
arguments to flags because it is confusing that '=3D' is required for
optional arguments but not for mandatory arguments, and it's easy to
forget which arguments are mandatory and which are optional.

However, --rebase-merges already has an optional argument. If we make
it look more like --diff-merges by accepting the value "on", it could
actually be even more confusing because users would be more likely to
try "--rebase-merges on", thinking that that will work because
"--diff-merges on" works.

Given the current situation, users are just going to have to learn
that in Git, optional arguments to flags must be preceded by an equals
sign. Maybe someday Git will make breaking changes to get rid of
optional arguments to flags, but for better or for worse, that day
will not come soon :-/

> > As it is, we're certainly not going to drop support for
> > --no-rebase-merges
>
> --no-rebase-merges is fine, as it has no optional arguments
>
> > or --rebase-merges without an argument,
>
> Yep, but that's a pity and the whole point of my comment: if we can't
> fix it, at least don't promote it.
>
> > so it seems fine to advertise them to users.
>
> --no-rebase-merges is fine, but then you don't advertise it anyway.

I am not sure what you mean by this. The first patch of the series
adds documentation and a test for --no-rebase-merges, so I am
advertising it. Or are you saying that I /should/ advertise neither
--no-rebase-merges nor --rebase-merges without an argument, because
you think --rebase-merges=3Doff and --rebase-merges=3Don would be better?

-Alex
