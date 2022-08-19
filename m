Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4441AC00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 01:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiHSBMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 21:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHSBMd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 21:12:33 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169E1DDA85
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 18:12:33 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id j17so2404237qtp.12
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 18:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=G1ysBlQN/FM+DKqWxXLHFk5ZznYGrPP4dZMg6QJW+Ik=;
        b=axumMsjDDYXv4h+KFtw9H4b/q+gJJGuGqYBZ6wHqbZUjfJiGFFTJ/LbrISATjEEA7+
         4jUHYINeFASWhcItzZVbq94XqRkF2bHmDM931JevLtZrK9oeNI5ximBnsozgWD7W9Q1u
         iN0fz/KrY7UsLnpR9yCa86sL5qPUXvwRNMvxjJaWIBXy1q2uamWl/mF2Z6g0Fykopw4n
         +rUAQ1dadppQac1MphHjJog/ZLsiyR85cnYOs0wYYICWNntaUSuiEHnOfcG0dncNr8LS
         XiG15l3csFaKKFjaVVbeQyQIe8MZ0Q/bNfdCDbcNy+wn6FoNpwdpbPNcKfoTP4cEjb4o
         j/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=G1ysBlQN/FM+DKqWxXLHFk5ZznYGrPP4dZMg6QJW+Ik=;
        b=evfqlbhmJzJy4hC7smjj9TeSD/amqqXl3r3EFmkOa0b754MxV5pKunP9oh7AzeAlL9
         hbn5QS7+TcqT6dMejQJ7+VoOZhc3b0QdFain6zAuL3loqOcpX/u48ufJwW9qX94CmYVA
         2kWzUlyViTblqwGYsyA+wwuIfdPKltLFvl4NNe3AobVNR1zNykKmhChmnY4ONgmz8Hfl
         FfW+VTNnQ3qR5mJnqjxI7n7kdWQU3ylqHdzoXYzsXL1710dPZKSCPXWt5QeBlxeid003
         AS3ESDrPTCNUd+4oamOKrHdwBYLzQdlHJ4cu3DvoIFkoYJY1oiMUoWgIOe9CdOGajn6l
         u/7A==
X-Gm-Message-State: ACgBeo3wWdcFvUVLE2fHIA8bV4CXdl1pRfu7/n/PLwqt8QhZbvmExuYs
        DslrmiCTbWIJk8XJbpKaCdybfTbIGnp+XtE2iGg=
X-Google-Smtp-Source: AA6agR47qO0pXLUR2ZmrpiheZX8Mwi2v47e9AVEK3Gto/5wN7hFwzvImxRitK4U4b9RxwcDhZUoGpfnloXTWFWJuffo=
X-Received: by 2002:ac8:5c8e:0:b0:343:5983:a246 with SMTP id
 r14-20020ac85c8e000000b003435983a246mr4964226qta.153.1660871552139; Thu, 18
 Aug 2022 18:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
 <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com> <f580ec6d06072ea6ed2ecc4f8142b94fccbe4c0f.1660803467.git.gitgitgadget@gmail.com>
 <ee4a7a7f-d646-6357-233a-1fefde5607bf@github.com> <220818.86ilmp8rzn.gmgdl@evledraar.gmail.com>
In-Reply-To: <220818.86ilmp8rzn.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Aug 2022 18:12:00 -0700
Message-ID: <CABPp-BFOrKDEnq6R7k5+CxUKHObkfNWDGZghkqvkCnuXQC8rTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] revision: allow --ancestry-path to take an argument
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2022 at 8:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Aug 18 2022, Derrick Stolee wrote:
>
> > On 8/18/2022 2:17 AM, Elijah Newren via GitGitGadget wrote:
> >> +test_expect_success 'rev-list --ancestry-path=3DF D..M' '
> >> +    test_write_lines E F J L M >expect &&
> >> +    git rev-list --ancestry-path=3DF --format=3D%s D..M |
> >> +    sed -e "/^commit /d" |
> >> +    sort >actual &&
> >> +    test_cmp expect actual
> >> +'
> >
> > These tests follow the patterns from other tests in this file, but
> > it also has bad patterns. Specifically, the 'git rev-list' command
> > is fed directly into a pipe. I include a patch below that applies
> > directly on this one to rewrite these tests. If you want, you could
> > rebase to have that test refactor happen before you add your new
> > --ancestry-path=3D<X> option tests.
>
> Thanks, I was going to comment on the same, but your solution is much
> better (I was just going to suggest using intermediate files).
>
> > [...]
> > -test_expect_success 'rev-list --ancestry-path D..M -- M.t' '
> > -     echo M >expect &&
> > -     git rev-list --ancestry-path --format=3D%s D..M -- M.t |
> > -     sed -e "/^commit /d" >actual &&
> > -     test_cmp expect actual
> > -'
> > +test_ancestry () {
> > +     args=3D$1
> > +     expected=3D$2
>
> Maybe add &&-chaining here (we do it in some cases, but I'm not sure
> when such assignments would ever fail).
>
> > +     test_expect_success "rev-list $args" "
> > +             test_write_lines $expected >expect &&
> > +             git rev-list --format=3D%s $args >raw &&
> > +
> > +             if test -n \"$expected\"
>
> Aren't you making things harder for yourself here than required by using
> ""-quoting for the body of the test.
>
> We eval it into existence, so you can use ''-quotes, and then you don't
> need to escape e.g. the "" quotes here for expected, no?
>
> > +             then
> > +                     sed -e \"/^commit /d\" raw | sort >actual &&
>
> nit for debuggability (and not correctness), maybe using intermediate
> files here would be nicer? And then perhaps call them "actual" and
> "actual.sorted".

Would be better to just nuke the sed by replacing 'rev-list' with
'log' (the line already has a --format option, so might as well get
the output we want).

> > +                     test_cmp expect actual || return 1
>
> No need for a "return 1" here when we're not in a loop. It's redundant,
> and makes the -x output on failure confusing ("why didn't I fail on the
> test_cmp, but on this stray return?...").
>
> ...
>
> > +             else
> > +                     test_must_be_empty raw
>
> ...which would also allow you to extract much of this if/else at the
> cost of not using test_must_be_empty, i.e. just make the "expected"
> empty unless "$expected" is provided. Just a thought/nit, we could also
> leave this as-is :)
>
> Also does the "compare rev" part of this want test_cmp_rev instead?

Um, I don't see any "compare rev" part of this, or any revision
comparing.  What are you referring to?
