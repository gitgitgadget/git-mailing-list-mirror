Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FECC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 23:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCIXXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 18:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCIXXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 18:23:09 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46DC41081
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 15:23:07 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536af432ee5so65741677b3.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 15:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678404187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak54ip+q2w6WvrxC9VNHYgOMY6sekF1461S80aXUOr0=;
        b=FkAQlLP9KbarCCA1TU4TrTHVO1Ly9A6niGSoV0lscYYrUPILt3E01gTrqjRzFpVfJz
         mJfiQsTSIM9SnO6uDdXDv23Ztefey63ppdcfkSpKxtgipvI3ZXmO1WuogQOys3B2pVVL
         jTh7x6qLefFIojesjZwILmkxKzpdRaoabftw2S5oCsxRdF2U1O/C+J8JWxmqqAUQq9us
         bPDoMj4aEYiG15UXPsV7VOSn4XwVbvfPBthajrW+4FCnuu9htBMZhR5v1HyS25Z9ORfl
         +WCsOtRwOt+cm/2mhx19mNsNF0cuJ6hirCaA6/6mWhmH2BReMtlaWwAcQ7RvAN6DBS/p
         NQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678404187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak54ip+q2w6WvrxC9VNHYgOMY6sekF1461S80aXUOr0=;
        b=qQR/5qCsEuswmDZAppMFsjvKe5NrHtrsaAlX/U9XSyev6o691/Zith6RtPZ3qiWXvb
         9ePTp12W093xsFHkDTaARmA9cCq9FJ6Ye/E9b7JIIUA2oRbX1EQ7eyN5pdouoTtRqT0b
         p8NRaXjcJcL+3aanY7xjF8+04F5WoyJjQSi1Kz9MALHQKBoG1byxAI3FOdsJSK4OEP0F
         0+DiCc0Yzr3ZJ1FQnDhSAHX/UWkeHg5gqIfjG8nb3Es409tP0sXNsy4ifwSAhVOML1iE
         OxlZ4vsMg+VOz03D1P/TVR1K5CSPyblQsGKyakmqPA69QC++gcbI6J8+Y6hI7tYLCWfg
         INHg==
X-Gm-Message-State: AO0yUKWuNUOmCg23ROyLV8lBvq+Jevh62TLPxK/bThZG1GrqNNswdr+A
        dDSLDSmV7PJXpT2E481jcejBLqOvKqUqkNK101kG/rdaPng=
X-Google-Smtp-Source: AK7set+DUCMb+pYA2hghGVSErCgLQ1vLpPplIiBAFY+LJsGs1SY2tjci/EG3CgGGlnwNnWimbJa21iVrgLCOqQ0rEz0=
X-Received: by 2002:a81:ae4b:0:b0:536:5557:33a8 with SMTP id
 g11-20020a81ae4b000000b00536555733a8mr15232423ywk.9.1678404187053; Thu, 09
 Mar 2023 15:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20230309220405.219212-1-anarcat@debian.org>
In-Reply-To: <20230309220405.219212-1-anarcat@debian.org>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 9 Mar 2023 17:22:55 -0600
Message-ID: <CAMP44s2=qzmF1Odc_auCaKQmTBYD53YYtaJv_LGwvoFDmTxPSA@mail.gmail.com>
Subject: Re: [RFC PATCH] hooks--pre-push.sample: identify branch point
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antoine,

On Thu, Mar 9, 2023 at 4:34=E2=80=AFPM Antoine Beaupr=C3=A9 <anarcat@debian=
.org> wrote:

> https://stackoverflow.com/a/71193866/1174784
>
> There are currently a whopping twenty-five answers to that question in
> that thread, and I'm hoping the community here will have a more
> definitive answer to this question. I have picked the answer that uses
> the least possible external commands, but it still uses a `tail -1`
> which I'm somewhat unhappy about. I have thought of using
> `--max-count` for this instead, but I understand that probably does
> the equivalent of a `head -n` *and* it's applied before `--reverse`,
> so there's not other way to do this.

I spent an inordinate amount of time trying to answer that question a
decade ago, and my conclusion after trying every possible combination
is that it's simply not possible. Every solution at the end of the day
will be a hack that can be broken with a corner case. It has already
been discussed in this mailing list [1], and nobody found a solution.

That's why I wrote a patch to implement a branch@{tail} helper to show
an auxiliary ref to the beginning of the branch. I don't think I ever
sent it to the mailing list, as my patches are rarely merged, but I'm
sure I have it somewhere.

The other solution I thought of was adding an update-branch hook that
could be run every time a branch is updated, and then the hook would
update the branch tail reference [2]. As expected, that patch wasn't
merged either.

It's interesting how we keep coming back to the same problems; right
now there's a discussion in the git-users mailing list precisely about
the same topic: how to find the branch point, in particular so `git
name-rev` shows the correct branch a commit belongs to (which is
otherwise just a bad guess).

FWIW my motivation at the time was to prove Mercurial users wrong
regarding features that they have and Git doesn't, I contended that
Mercurial named branches (aka commit labels) were not necessary, and
everything they achieved could be achieved in Git through different
means. That turned out to be untrue, as there is one thing Mercurial
can do that Git can't: show the precise point a branch started from.

I abandoned my efforts back then, but the topic seems inescapable, as
that is also needed by new tools like `git range-diff`, so in my own
tool to keep track of patch series (`git send-series`[2])I end up
creating a ton of refs just to properly keep track of the branch
points of my different patch series.

If only Git developers acknowledged the current very real limitation,
something could be done about it.

Cheers.

[1] https://lore.kernel.org/git/CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc6=
1fetFkJA@mail.gmail.com/
[2] https://lore.kernel.org/git/1398047016-21643-1-git-send-email-felipe.co=
ntreras@gmail.com/
[3] https://github.com/felipec/git-send-series

--=20
Felipe Contreras
