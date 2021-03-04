Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C219FC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 19:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804AF64F65
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 19:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbhCDToT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhCDTn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 14:43:59 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4774C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 11:43:19 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id w3so8714229oti.8
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 11:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kt2PrjWckN7YklOoRNiUjKOEuRuGT8bo22L0tQVVNBw=;
        b=jTs4/ItS0SsS1k75p0H7hALF32HnxRjqddDl8W/mHU8lA9ZdBg2J9pc9p728zN6xT7
         xMHIqKgpofMycasqLJURY/1E6GQY/5pxAkBvOpylbNeNamR2QdiTtQSG7haUmMJGfixh
         CP73DcmE0HJUutpGQNGzg85j97Fv8YwFFzYOHy0wAVblnbSUQIWJQV3DdVm/FxLrdwsu
         srXVZV+WvI0s56N7g3Ne0SfyfSUADNwePQUUz0mV23atDnU7ci0dKEF5uYn+5l5ePE+E
         MUiO5NEArAFJOW/QXMUgEvOEO+PZYgJXRHpYNI0yYidptxP7pkfuOUzJouTH+tjJQnUm
         WDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kt2PrjWckN7YklOoRNiUjKOEuRuGT8bo22L0tQVVNBw=;
        b=XBy+hkRcvNZ6yKrjy40u/cjSMCnj9iX8WXhTKkD792e/9wm3JeZ1gTwcA+BG9F1Bo5
         o+IaYZoNL9X9y5J0BgVa1UTe/XZ6+s1waOKl433bqQxlQkDMGLpgbmkSgaUaE8W8NKcK
         kxo+L4ieH7sAxjImU4Q5LTWDAXrYzjfRZIedhT6NhbRpopK3WiSLo7n1F2TJrdoxcbg0
         Um7BKtXnrvPocmPt8LsDtg4kRVoy9U2K0GYVP0AomxmeaGCYlMv0bcffA4yIcKA+rutT
         2MBcXvOIAv0kyBShCsLW6fx3ncVH6wy1vdnMaW1761nZ2bYJB7nvLYamH293m/aLgZHN
         2C5w==
X-Gm-Message-State: AOAM5322qBR92UEryk8067Whs/UhNahmoOVlQFI6LyX3h6W/kRlLy0qZ
        MYshR2txGWDv22NbxFJnaxLriwQQ1i5bPVUf3WEYgTCIbAyC2Q==
X-Google-Smtp-Source: ABdhPJz23NEPPa5WIgPZ0A2KMVtAuypu6Rwy/zFZ1t51FnBU4Ah5iFK0vHWUgnClOkiOhGXZqGocLeRVdTOsVxQEYhg=
X-Received: by 2002:a9d:7459:: with SMTP id p25mr4680459otk.316.1614886999061;
 Thu, 04 Mar 2021 11:43:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <pull.815.v2.git.1609468488.gitgitgadget@gmail.com> <69129a20edcfb57a3278285f31584ffcc2b3bad7.1609468488.git.gitgitgadget@gmail.com>
 <877dmmkhnt.fsf@evledraar.gmail.com>
In-Reply-To: <877dmmkhnt.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 4 Mar 2021 11:43:07 -0800
Message-ID: <CABPp-BFdN4k=LpAymggw96PPg8dFrzF2FVWLacH2hkrPakhhxg@mail.gmail.com>
Subject: Re: A merge-ort TODO comment, and how to test merge-ort?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Thu, Mar 4, 2021 at 8:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Fri, Jan 01 2021, Elijah Newren via GitGitGadget wrote:
>
> > +     else {
> > +             /* must be the 100644/100755 case */
> > +             assert(S_ISREG(a->mode));
> > +             result->mode =3D a->mode;
> > +             clean =3D (b->mode =3D=3D o->mode);
> > +             /*
> > +              * FIXME: If opt->priv->call_depth && !clean, then we rea=
lly
> > +              * should not make result->mode match either a->mode or
> > +              * b->mode; that causes t6036 "check conflicting mode for
> > +              * regular file" to fail.  It would be best to use some o=
ther
> > +              * mode, but we'll confuse all kinds of stuff if we use o=
ne
> > +              * where S_ISREG(result->mode) isn't true, and if we use
> > +              * something like 0100666, then tree-walk.c's calls to
> > +              * canon_mode() will just normalize that to 100644 for us=
 and
> > +              * thus not solve anything.
> > +              *
> > +              * Figure out if there's some kind of way we can work aro=
und
> > +              * this...
> > +              */
>
> So if tree-walk.c didn't call canon_mode() you would do:
>
>     if (opt->priv->call_depth && !clean)
>         result->mode =3D 0100666;
>     else
>         result->mode =3D a->mode;
>
> I haven't looked at this bit closer, but that doesn't make the test
> referenced here pass.
>
> I'm refactoring tree-walk.h to do that in a WIP series, and ran into
> this.

Interesting.  Yeah, there might be more steps to make that particular
test work, but I couldn't go any further due to canon_mode().  It's a
testcase that has always failed under merge-recursive, and which I was
resigned to always have fail under merge-ort too; I suspect it's
enough of a corner case that no one but me ever really cared before.
(And I didn't hit it in the wild or know anyone that did, I just
learned of it by trying to clean up merge-recursive.)

> As an aside, how does one run the merge-ort tests in such a way as
> they'll pass on master now? There's now a bunch of failures with
> GIT_TEST_MERGE_ALGORITHM=3Dort, well, just for t*merge*.sh:
>
>     t6409-merge-subtree.sh                        (Wstat: 256 Tests: 12 F=
ailed: 1)
>       Failed test:  12
>       Non-zero exit status: 1
>     t6418-merge-text-auto.sh                      (Wstat: 256 Tests: 10 F=
ailed: 3)
>       Failed tests:  4-5, 10
>       Non-zero exit status: 1
>     t6437-submodule-merge.sh                      (Wstat: 0 Tests: 18 Fai=
led: 0)
>       TODO passed:   13, 17
>     t6423-merge-rename-directories.sh             (Wstat: 256 Tests: 68 F=
ailed: 4)
>       Failed tests:  7, 53, 55, 59
>       Non-zero exit status: 1

Right, I've been sending merge-ort upstream as fast as possible since
last September or so, but there's only so much reviewer bandwidth so
I've been forced to hold back on dozens of patches.

Currently there are 8 test failures (all shown in your output here --
1 in t6409, 3 in t6418, and 4 in t6423), and 12 TODO passed (only two
of which you show here).  I was forced to switch my ordering of
sending patches upstream late last year due to an intern project that
was planned to do significant work within diffcore-rename; I was
worried about major conflicts, so I needed to get the diffcore-rename
changes upstream earlier.  That's still in-process.

By the way, if you'd like to help accelerate the merge-ort work; it's
almost entirely review bound.
https://lore.kernel.org/git/pull.845.git.1614484707.gitgitgadget@gmail.com/
still has no comments, then I have optimization series 10-14 to send
(viewable up at
https://github.com/gitgitgadget/git/pulls?q=3Dis%3Apr+author%3Anewren+Optim=
ization+batch),
then I have other fixes -- mostly for the testsuite (viewable at
https://github.com/newren/git/tree/ort-remainder), then I need to fix
up the TODO passed submodule tests.  Due to how the submodule testing
framework functions, I can't just make a simple
s/test_expect_failure/test_expect_success/ -- the tests are structured
a bit funny and the tests are themselves buggy in some cases.  I
talked with jrnieder about it a little bit, just need to spend more
time on it.  But it hasn't been critical because the rest of the code
was so far away from finally landing anyway.  Finally, and optionally,
comes the --remerge-diff and --remerge-diff-only options to log/show
(viewable at https://github.com/newren/git/tree/remerge-diff, but
these patches need to both be cleaned up and rebased on
ort-remainder).

> And both test_expect_merge_algorithm and what seems to be a common
> pattern of e.g.:
>
>     t6400-merge-df.sh:      if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
>     t6400-merge-df.sh-      then
>     t6400-merge-df.sh-              test 0 -eq $(git ls-files -o | wc -l)
>     t6400-merge-df.sh-      else
>     t6400-merge-df.sh-              test 1 -eq $(git ls-files -o | wc -l)
>     t6400-merge-df.sh-      fi &&
>
> Will not run tests on both backends, I was expecting to find something
> so we can the test N times for the backends, and declared if things were
> to be skipped on ort or whatever.

Yeah, multiple ways of testing were discussed mid last year.  There
were lots of tradeoffs.  I think the thing that pushed in this
direction is that we're not just aiming to add another optional merge
backend, we're aiming to replace merge-recursive entirely.  Since
merge tests appear all throughout the code base, many as rebase or
cherry-pick or revert or stash tests...or just as simple setup tests,
we want all of those tested with the new backend.  Trying to duplicate
all those tests in any way other than just re-running the testsuite
with a different knob would require huge changes to hundreds
(thousands?) of testfiles and conflict with nearly every other topic.
So I made an environment variable that would choose which backend to
use, but with the downside of having to re-run the testsuite again.

> I understand that this is still WIP code, but it would be nice to have
> it in a state where one can confidently touch merge-ort.c when changing
> some API or whatever and have it be tested by default.

Thanks for proactively checking.  To make it easier for you, I'll see
if I can submit a series later today that mostly completes the
merge-ort implementation; the t6423 testcases won't be fixed until
"Optimization batch 12" lands, and I might not be able to fix the
"TODO passed" submodule tests in this series, but the rest of the
stuff can be fixed with about 10-12 patches.  I had been worried about
overloading the list with too many patches at once, but since it
sounds like you're willing to review these particular patches...  :-)

> Or maybe that's the case, and I've missed how it's happening...
