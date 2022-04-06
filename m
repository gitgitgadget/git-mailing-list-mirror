Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D425C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 13:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiDFNZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiDFNYw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 09:24:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9684B8B3F
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 03:20:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so3282003ejb.4
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 03:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=hWU8jM4hWTvCzc1ubZC5xC7TdZ+P/UeEZsyTCCqvTEU=;
        b=jXKW2YGrc5oQ96h3SpxVRNZ8nCpbT9+kuFvB6yfY+Zu0KDeqO+AO0YJkY/H52AQ1QX
         8p4hGDFDn7ruWn9njifYwxNUkAbyUW2TbUlBvViVJrj5/r4JRfHmmxKNWEuEfejFRvc/
         1VVGbcEkUojzD7jrGtf0uqiqKvGx3jYQ5WFSoN6J+EvAUdPBDN88guiJ0Aimd70mvYWg
         npLZNOxoKlBdHpcIbRaL+Wq1GkrVPBbo8BI75fg6uAu/XTQG070djXfCjK5Z8JLdf7e2
         ki5Ds2YuV171+0EQoNRZkR0g096657x1pw5r5fEeQSsX1VmSLQ8ehXX86KuhHypO0V1S
         pNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=hWU8jM4hWTvCzc1ubZC5xC7TdZ+P/UeEZsyTCCqvTEU=;
        b=BnLPgGq4EElv0OoxGE4JUCqcpbS1xDFGYP+S21ORR/B3XdMTmaET93aO858wupTyoR
         5UmyyoyW2GV9lJDukvhBJRx32coAQknAwdWXvlQNomqHIwFQ82K2heQQ18yvO3FcVQWC
         fBJpJMbbAol9NJ0kBgxq6ARuAfwiNbxwZUS29lMp1FMVoAlp3yWQ7s4K03/ByvoVUS5p
         JJk1xAKjlyCr+uXfPJWy0WgDNhh0Wpvy8UZxrXyebBnQWQOEltks0gCv0095H0WmtSoc
         b6lbr75DSl2Se3zy1IzOQAZCk415N8mG1AUXv70RhDlOCQT3Sd+ooEY8Vg5IFDF8cwbn
         7hdg==
X-Gm-Message-State: AOAM533W5QSyLVa0f0v8Rx8HQbM6rogTZUu2nSuraJDOrRf2E8E4uWRk
        366o0xE9tddgo2/TzuuKQE8=
X-Google-Smtp-Source: ABdhPJwdXnCdzcDCMK5OovQfhJ291MgHrKL3edKt+0vHSyYtZ0pGEwFdGEt8xlx8PQYOc4EwLDhQAg==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id g17-20020a17090669d100b006ce7201ec26mr7481718ejs.105.1649240399033;
        Wed, 06 Apr 2022 03:19:59 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jr16-20020a170906a99000b006e4c05e8919sm6373718ejb.35.2022.04.06.03.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 03:19:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nc2lZ-000crB-Cj;
        Wed, 06 Apr 2022 12:19:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
Date:   Wed, 06 Apr 2022 11:29:18 +0200
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
        <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2203301430540.379@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2203301430540.379@tvgsbejvaqbjf.bet>
Message-ID: <220406.86bkxeecoi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 05 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Fri, 25 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> A re-roll of my improvements my series to simplify the CI setup a lot
>> (see diffstat), much of it was dealing with constraints that went away
>> with Travis et al.
>
> This type of work causes me a lot of follow-up work e.g. many merge
> conflicts in the latest Git for Windows rebases.

Can you elaborate a bit on why? These patches are currently in "seen"
and not "next", and I thought GFW merged git.git's "master" for new
releases, and e.g. in:

    git diff --stat -p v2.36.0-rc0..v2.36.0-rc0.windows.1 -- ci t

I don't see anything related to those sorts of CI changes.

I.e. I understand that you may have something out-of-git.git that may
conflict with this, I'm confused about the GFW reference in particular.

> Perhaps it is worth taking a step back and evaluating the return on this
> investment in the CI setup. While this can be characterized as a
> simplification taking the diffstat as proof, one could challenge that the
> diffstat does not actually measure whether the code is simple or not, it
> just measures whether there are less lines in the end.
>
> If the diffstat was a good measure, then the optimum would be one 0-byte
> `.c` file (which some C compilers compile without error). Another obvious
> way to optimize the diffstat would be to remove all code comments. Would I
> suggest to do either? Of course not.

This is a misunderstanding I really didn't expect, but no. I'm not
suggesting that the diffstat being shorter is a value in and of itself.

Clearly that's ridiculous, as we could make the code "better" by
removing subsequent newlines or whatever.

I thought it was clear in context that the v2 CL's reference to this is
a shorthand for us being able to generally "do more with less"
summarized in the v1:
https://lore.kernel.org/git/cover-00.25-00000000000-20220221T143936Z-avarab=
@gmail.com

> The reduction in code size of this patch series also comes at quite a
> steep cost: After all, the way Lars and G=C3=A1bor set things up was alre=
ady
> easy to reuse with Azure Pipeline and GitHub Actions.
>
> Removing this type of generic, easily-to-adapt code can remove a lot of
> lines at the expense of making the code less generic and harder to adapt,
> and leads us directly to CI lock-in.

It's really hard to try to come to some sort of landing with changes in
ci/ when it looks as though you haven't read my side of the patches or
why these changes were made.

So in liue of some long summary of that I'll just say briefly that the
reason for why I made those changes is covered in detail in commits you
haven't replied to, and which argue the opposite of what you do here.

Briefly: The entire reason I changed those bits is exactly to avoid the
sort of CI lock-in you're talking about, to th point where this series
effectively adds another CI target: You can run everything it's doing
with a normal "make" invocation.

> A better approach would be to use the already-generic code and adapt it
> e.g. to extend to the CirrusCI definition we have.

This series doesn't change .cirrus.yml or how it functions, but it just
does:

  build_script:
    - su git -c gmake
  test_script:
    - su git -c 'gmake test'

Which, after this series is exactly what your "main" CI does. So we're
set up to make it easier to unify the two.

> Even if you do not care about extending our FreeBSD coverage,

FWIW I do care, and I've sent in various portability patches for
FreeBSD, but I haven't used that CI in particular.

> I would like
> to ask to slow down on refactoring as it is done in this patch series. As
> indicated in my comment above, these types of refactorings lead to a lot
> of complications in Git for Windows's processes, which are time-consuming
> to resolve. I understand your motivation, but if you wouldn't mind taking
> some time to weigh the criticality of these changes against the overhead
> incurred for maintainers, it would be appreciated.

Sure, I'm happy to accommodate that.

As this v2 CL notes I'd asked you a month before submitting it in [1]
what I could do to make the parts of it you seemed to find most
objectionable easier or different for you.

>> I think just removing it is OK, we can always bring it back if needed,
>> and doing so is actually going to be simpler on top of this since the CI
>> is now less special, and leans more heavily on the logic of our normal
>> build process.
>
> Removing and re-adding things does take time, though. Again, I think it
> would be helpful to step back and try to understand the value of this
> removal versus the projected time it would take (from all involved) to
> re-add.

Having prepped this v2 + the RFC of your (then smaller) patches on top
I'm pretty sure it would be trivial for either of us compared to
continuing this verbal back & forth.

So, to that end I re-rolled the two in combination, I think it would be
much more helpful to comment on the substance of the changes here.

E.g. we can now see the sum of my patches and yours in "seen", they both
change the CI UI in what I think are complimentary ways (issues of
e.g. added slowness in your patches aside, which has been discussed).

For easy comparison I prepared this the other day, and committed the
same "make CI fail" commit on top to all of them:

 * Your original patches, just rebased on master:
   https://github.com/avar/git/tree/avar-pr-1117/dscho/use-grouping-in-ci-v=
2-FAIL-TEST
 * Just my v2 series here:
   https://github.com/avar/git/tree/avar/ci-unroll-make-commands-to-ci-reci=
pe-FAIL-TEST
 * The sum of the two, i.e. the v2 + your "RFC" (the RFC label being mine) =
on top:
   https://github.com/avar/git/tree/avar-dscho/use-grouping-in-ci-v2-FAIL-T=
EST

If you've got some conflicts or whatever with something out of tree
you'd like me to accommodate or even resolve for you I'd be happy to do
so, just send me the specifics.

> Besides, given how much is shuffled around in this patch series (e.g. some
> files in ci/ are removed altogether and their equivalent code is moved
> into various other places), doubt must be cast on the idea that it would
> be simple to bring back anything here.

I'm assuming you're talking about resurrecting Azure CI, i.e. (mostly)
this would semantically conflict:

    git grep ci/ 6081d3898fe^ -- azure-pipelines.yml

One thing I can see right away that would need adjusting is that I "git
rm" the "ci/mount-fileshare.sh" script as unused. It's part of what I
asked about in [1], but I could just leave that in place, would you like
me to do that for a re-roll & would that help?

For the rest "ci/install-dependencies.sh" is the same,
"ci/run-build-and-tests.sh" would be an easy matter of making it run
"make test" instead after invoking ci/lib.sh.

We're really just talking about a few lines of boilerplate here, I
really don't see what the big deal is.

As my patches also note there's things that the azure-pipelines.yml
assumed that are no longer true (before any changes I made), so some of
this would need adjusting in any case.

It also does a test run followed by ci/print-test-failures.sh, which as
I understand you've been maintaining quite adamantly insisting is pretty
much useless compared to the new GitHub-specific output your series
adds, and which is CI-specific. Presumably most of the work of getting
Azure running again would be (in your version) to adjust that to
something Azure-specific.

Whereas on the CI portability front I noted in [2] and [3] that we could
do pretty much the same without adding CI-specific output targets.

Anyway, I really hope we can find some way past what seems to be an
impasse with these various CI changes. All the best.

1. https://lore.kernel.org/git/220222.86y2236ndp.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220324.8635j7nyvw.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/220302.86mti87cj2.gmgdl@evledraar.gmail.com/
