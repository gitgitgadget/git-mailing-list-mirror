Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B0C433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 12:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhKTMiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 07:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhKTMiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 07:38:09 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A9CC061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:35:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so10068713eds.10
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=JVvezGyd2wvciujtJ/8d5jdfEsbqCwpYqX93s5IgWzE=;
        b=CRxfPCnO17XmFcvH2KCyEtj4XjIl6qAEGNkn36ZB5UsLKhCy4sXmV3q9Dc5fsrj+gI
         hnPkFvg4Y2pSAka1AZEfVet39cmtuA5yeveZBvHGPRg4M3iVEDdIX2ny2RqS6zC3s5An
         38ejhn0rr/0m8nvmhQgREIJVhI8ZGBwpnwzEzwEN9tzD0grAEhPwEcys//KSsQCjI+YE
         jAKC0uUurwNTQIjvy4dMc2Nw1Awrd5hHz3yRVL22fc/9QRZsIXZwsZgROjvHt+xZcmnC
         j1jLX0+E9SoAx+QcB+z3O736UHQFrTuxuxb44UkMb/zgaYAMciVmnPpTeyNd0kLtWCP0
         btvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=JVvezGyd2wvciujtJ/8d5jdfEsbqCwpYqX93s5IgWzE=;
        b=vaJz1FV/rqpYJtpn+UXv8F1pFRHz0XtGyGfNcpy6C3bReAj5TsSnBRNKy2yKttAtlq
         5DCGBNRlGn1xik+kBb03OX/9fSRpuYlE0/uWeeKgpT1wepVsdqkK+dtDE4R3lpABg3BX
         jaX1HdYGQcnXIzxG+LPJOikaLYGhu8SzaC66TpKY4Deit0VFJFABqARA808ZiLj2BShx
         Z6YLlrcp4MntfX1PEl/PEGRwpp1vXVPC5qbT0tLZRiltGzpcxAnoHDy+TuurKgh0l9Wv
         +/dLYEkGu2ZJ6gTeWokQeN2le8nD5izE3WoRLdzgtSqLnaKXz82wcZH54Bzk18b2wVPr
         4G8A==
X-Gm-Message-State: AOAM531jQy7hFOiHxyuVBNwjdWWGsqeE6tVG6DsNFsS+BO1a54EwPapU
        mkEebEu3PDwvU2glYtDiM/Y=
X-Google-Smtp-Source: ABdhPJxfD5NcDinizsTZjzr5TsEqTVIXCXXxbkKyeMN0cm/yhUZbzbQEQFEO67EsSzqJvVYDdRInYA==
X-Received: by 2002:a50:bf4d:: with SMTP id g13mr37447523edk.195.1637411705030;
        Sat, 20 Nov 2021 04:35:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z7sm1179245edj.51.2021.11.20.04.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 04:35:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1moPaB-000vaj-Th;
        Sat, 20 Nov 2021 13:35:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 0/6] CI: Remove Travis CI, shorten names for GH
 tooltips, split jobs
Date:   Sat, 20 Nov 2021 13:14:51 +0100
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
 <BED25714-4917-46CB-AAD4-C30158A7A42C@gmx.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <BED25714-4917-46CB-AAD4-C30158A7A42C@gmx.de>
Message-ID: <211120.86k0h30zuw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 20 2021, Johannes Schindelin wrote:

> On November 20, 2021 4:28:30 AM GMT+01:00, "=C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason" <avarab@gmail.com> wrote:
>>
>>  CI: remove Travis CI support
>
> This is a patch I am in favor of, and would prefer in its own patch
> "series": separation of concern, and consideration in avoiding
> reviewer fatigue, are two aspects I would like to see you optimize for
> a bit more.

It's included due to a comment on the v1 from Jeff King. I could have
gone either way, but I'm not going to change it around now.

I think it's fair enough to keep up the quality of series's, but I also
don't think it would help to go back & forth with including or not
including this travis removal.

If I don't include it I've got to patch "dead" code for the rest of the
series, if I re-roll and have two sets of patches depending on each
other that's its own reviewer fatigue etc.

For some counter-advice it would be nice to see you optimize for
responding to reviews, cf.:
https://lore.kernel.org/git/211118.86zgq14jp1.gmgdl@evledraar.gmail.com/
:)

>>  CI: use shorter names that fit in UX tooltips
>>  CI: rename the "Linux32" job to lower-case "linux32"
>>  CI: use "$runs_on_pool", not "$jobname" to select packages & config
>
> These strike me as simply shuffling things around and ramping up commit c=
ount in git/git, without actually addressing any of the problems our GitHub=
 workflow _definitely_ has.
>
> One quite obvious problem is that any failing run is very cumbersome
> to diagnose, and you kind of have to know where you're looking. A
> troublesome and off-putting experience for newcomers (and even some
> oldtimers). You have to expand the print-failures step logs and search
> for "not ok" to get even close to the relevant part of the failing
> test case's details.
>
> Yes, addressing this would be much harder and take more effort than just =
going ahead and renaming things. It would also be much more useful.

FWIW I do have patches for that, but getting anything in takes time etc.

To do that properly needed to parse TAP, which I've got patches for in
pure-C (not Perl or whatever) locally.

One of the reasons I didn't submit that UX improvement yet is because I
know it'll run afoul of one of your hobby horses.

I.e. I'll either need to fix in-tree dead code relating to the test
suite's XML generation blindly (it's not used, so how am I going to test
it?), or argue with you about it being worth to remove it to move the
test suite UX forward without having to spending time on it.

Another is that someone (I think SZEDER, hopefully I'm not
misattributing there) pointed out that they liked to have the current
print-failure firehose of "set -x" output for both failures and
successes, and would object to e.g. something that just peeled out the
specific failure output.

I don't think that opinion is wrong (if I even understood it
correctl). I disagree, but I see how it's clearly a matter of
preference. Some would like that, some don't.

But whatever anyone's preference on that I think it clearly shows that
what you're suggesting here isn't as easy as you make it
out.

I.e. something to the effect of "instead of renaming things work on
<thing I consider a clear UX improvement>".

Even if I agree that it would be an improvement in this case others
won't, and getting that past review is a matter of arguing about that,
addressing feedback on that topic etc.

The reason I submitted this is because I thought "I'd like to rename
this thing, not because of bikeshedding, but because I literally cannot
see the relevant information" wouldn't be in any way contentious, but
here we are :)

If you'd like to test some of that referenced UX work out it's
avar/support-test-verbose-under-prove-2 in my git.git clone (the CI
changes aren't there yet, but they're made easy by the changes).

>>  CI: don't run "make test" twice in one job
>
> I am in favor of the idea. As is obvious from the fact that I already pro=
posed this years ago.
>
> The commit message, however, is mum about that. And about the reasons
> why my proposal was shot down. And why those reasons should somehow no
> longer apply (and I would strongly suggest to aim for providing
> convincing evidence over mere opinions, to back up the patch).
>
> As has been mentioned before, this lack of diligence is
> disappointing. Reviewers should not be forced to look up previous
> related discussions on the Git mailing list. I would do that for a
> first-time contributor, but you are a long-term contributor who
> clearly has the ability, the knowledge, and the time, to accompany
> patches with such vital information.

I think in terms of over-explaining something in commit messages &
including references to past commit I'm doing better than most in terms
of commit messages to this project.

But you've got to stop somewhere, exhaustive explanations of past
caveats etc. are also its own fatigue.

In this case I think the explanations I've provided as they stand
suffice. Curious archaeologists can always dig in the archives for more.

>>  CI: run "documentation" via run-build-and-test.sh
>
> This patch has a commit message that explains what the patch does, and de=
scribes a little bit of related commit history.
>
> It does not talk about any convincing reasons why the change should be de=
sirable.

I just ejected this in v3, yeah it's a bit of a mixed bag with the
runtime of the installation.

The benefit, which I thought was a bit too obvious to even point out, is
that you can plainly see which half of asciidoc/asciidoctor fails, or
both. So it's clear if it's a compatibility issue or doc ource issue.

> This is troubling, in particular since it counteracts the major benefit o=
f the preceding patch: to reduce the jobs' runtime.
>
> Also, while the preceding patch makes each job's focus more obvious,
> so that it no longer requires careful study of the entire test log
> merely to find out which `GIT_TEST_*` settings are set, _this_ patch
> crams the check-docs into the same job as the pretty unrelated test
> suite run. In other words, it combines even _more unrelated_ things
> into the same job.

The "check-docs" run was already there in the pre-image, so nothing
changed there.

I agree that it would be beneficial to e.g. split out all this ci/
script wrapping into "make" targets at the top-level, but that's a
separate future improvement.

> [...]
