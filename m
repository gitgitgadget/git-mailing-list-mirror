Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26125C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE136135A
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhEaP7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 11:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbhEaP5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 11:57:37 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4CAC0494D5
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:37:45 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id x1so6714044uau.1
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MiiEATiExJFsqvFY546hs+z2KAJesTJEY51jnkwUbUI=;
        b=qcfWQzrRMYzAJQstOtru7wyB8JBUPgUQAPw21LojcW0ry+War9JqnI0goF30RSkm8B
         82TmnybF8MfVjbu8oQ/JMqUnV6f7XVErkcI64ZK6BltvEmctqX1OZc0LY5MqCVjOS/75
         9zDpISGbYMM+f8ZF51/dLCgP8NrGitYZspgnZ/x2fjMpgKY34YennWj136AjsVHGGXPA
         qyUd2iTsGWe55/XOMZKiba/IdwhKGx80hmNkr1If7eLNQ4qmV+Fc3h52+V3Smxk4wJ/3
         yzebKbmW7RRzbPc9m2heSix14oahHLN7kYnq+LEKdwh163bvW9WpuJgciNQnln+mgd1e
         c4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MiiEATiExJFsqvFY546hs+z2KAJesTJEY51jnkwUbUI=;
        b=TAzvQtqUbq/tjg/zShR7rrkg+Fz7QpRBXS6e8Rcnhw2RNdWLqekoonk8ijRBefHUmM
         7NhYxct/W6PFeDJp9WH7SDvawLsXTY3DoUnlkv22KwHrjZOug888p/td/ZA7pv/elJUk
         c81c89d6I9dl6Ws6CZSeS/3+D8+vOwi3nhZoYFP8kg9QDc32R/4wxPaDcL7ylcO6bcKZ
         wK4Gstia7QTNxq7pB3iRqkbKvdLYTn51Zv3s2ll1HX2ePrnUrkJQjMnzzESRFhUPH0jt
         MG2k/ARtFAvsS9ciw6aRpHkTqYWhcySk18sT3LhTmuuehw3OYKIUrOi3DerkJARkXH2R
         UWTA==
X-Gm-Message-State: AOAM530koaiYxv9H+Ta5BUUHbJoiV7/1AFnbySGXDdvvV/7CYQHXvwwV
        lPElM1osGWFDVBolpW9sSPI7gQq9NLRJ0H4IddEvwQ==
X-Google-Smtp-Source: ABdhPJxcxkJLeBcl0NZVbqUkxFnDXke5HUpOZziwoLOzjoOx0alpPPBdQV5/JK3B+Sclsc82JJ5T79Oz3ue27bFz8Lg=
X-Received: by 2002:ab0:758e:: with SMTP id q14mr10219656uap.85.1622471864832;
 Mon, 31 May 2021 07:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <878s49pdmd.fsf@evledraar.gmail.com>
 <CAFQ2z_NDKn4vTM_WBrDMumrcTkzS2nOT-cd-TQ=LpTHG+m8Fug@mail.gmail.com> <87pmxdn6zo.fsf@evledraar.gmail.com>
In-Reply-To: <87pmxdn6zo.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 May 2021 16:37:33 +0200
Message-ID: <CAFQ2z_NmSHdLuh=ksnZcEAPJV66Uej5KUk0Gw6BMEi2uqy16mg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Prepare tests for reftable backend
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 12:07 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> >> I looked this all over and left some nits, suspect/probably/definite b=
ug
> >> comments on specific patches, the ones with no comments from me LGTM.
> >
> > Awesome. Thanks for reviewing. I'll try to go over your comments this w=
eek.

I'm sending out the series shortly, with a Reviewed-By footer added to
the commits.

Jun, is this OK to schedule for 'next'  ?

> >> I intentionally didn't review my own earlier feedback on v1 to look at
> >> this with fresh eyes, I'd forgetten what points I raised, aside from t=
he
> >> general "let's not skip tests but test the new behavior" mantra I thin=
k
> >> I either mentioned there or in related discussions.
> >
> > "test new behavior" is troublesome, because it requires merging the
> > reftable support first, which in itself is a tough job, and predicated
> > on getting reviews for that code. This is why I split this series off,
> > because it can be merged early without impacting coverage of the
> > existing loose/packed backend.
> >
> > How about I document more clearly, for each test marked REFFILES, what
> > is going on, and what should be done for coverage with reftable? We
> > can go over it as part of the reftable series. "REFFILES" will be an
> > easy term to grep for.
>
> Indeed, as I pointed out in some (particularly later patches) v2
> commentary there's that chicken & egg problem.
>
> Having re-skimmed my v2 reviews I think these would help:
>
>  A. Just leaning on the side of splitting up tests, e.g in my comment on
>     20/21[1], there's a test with file backend specific logic there, but
>     also a general assertion. Should just be two tests.

I split a few tests.

>  B. My suggestion in 15/21[2] to split up maybe make these two
>     prerequisites, i.e. REFFILES and REFTABLE.

Until reftable is actually merged that will introduce a lot of dead
code in the tests. Besides requiring time for me to write that code,
it also introduces extra reviewer effort. I think that is best done as
part of the reftable series, when it is close to being merged.

>     One one hand it's a bit silly to have two prerequisites required for
>     the one reftable mode we don't have yet, and as long as we just have
>     two backends it'll be an informed guess at best.
>
>     But I'm leaning on the side of it being a good idea, to clearly
>     document those cases that are really files-backend.c specific, such
>     as low-level test to check that a .git/HEAD exists along with a "git
>     rev-parse HEAD" for that backend.
>
>     And then REFTABLE (and !REFTABLE) to test/skip things that are
>     specific to the behavior of reftable, but not in a way that has to
>     do with the "ref files" v.s. "a ref database" distinction. E.g. a
>     maintenance command calling pack-refs is skipped under REFTABLE, but
>     one could imagine us e.g. having a PostgreSQL backend where that

Let's first see the actual PostgreSQL backend materialize before
making investments to support it.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
