Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B4AC433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1568F64FF9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhCDWpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCDWpX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 17:45:23 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F3C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 14:45:23 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id h22so28989067otr.6
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 14:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eiHZ1HL309qDhtkc1Nm2n1jJwsOiEy47LsZ2n2OARFE=;
        b=qC3WiI2SxDBqZ4AQFyxhwEcAbRdF159IlG+4BeaRG47RxRDn3FUWj1ZFgts5sMBml3
         2y2G3+STFV7O4GU+jeIAm8uD5TRxe6haxzk63xUUiMjI3awfCIvrlh0wSuHyzpTYUkXV
         o86dOJVs1Vrvy6uNwCsfq+RflkhdmNWfklDk8ro7t4wWjLgNSu9aK+gnqT5ci0WzW2iX
         MtMXFpzW8oDNc9ZcP9gxwKGynTOhmGNPWRdOb8WomoPTUImBHuDORIjICqIhAk8oTGAA
         KcZrpbEW5DDNzAF9EQBB4teQskiEE2ygDgjw/RzYTam6/3781ZfcQbtEdiajQ5ax4ijF
         qY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eiHZ1HL309qDhtkc1Nm2n1jJwsOiEy47LsZ2n2OARFE=;
        b=mYlHiTnvhd3QxxEpuXj78Omjf3mVWA1IomBcZh/O3J3CBGf0GDFARwabOYreS/DE4J
         pL1gl+qwz0FyveKwHpaf313CbjDX2SIZxRbVvi2loKJy1tU9tfJrIJ+lQiCQliMuhaJ+
         fr6FMIpq7w5LrMKJ8Q8rJynbMpD8rSfio3br8N6KKzdyG1QJu3TfA9g+36jAXMNHdrn1
         IwQyZZ1H5BjSa81E5kGWOafcshvrPe82z5CVOiq9J2M8UnP7i62AvMHArgEZRw8nNMIv
         Fj4jkUmhEC79QmVYhUOdoAUWGWgjxbUz4IQtHYTmicV6zfQ+zFNRbKY0l6VR+Rs0/7ZB
         BKnQ==
X-Gm-Message-State: AOAM531Vj5Qo34YWSjVBkSJ/5bXL6Cm125bcccp84bBjicWE6S1M6EsK
        aP++O/19a4NRy+1w80V/Y3voAGt0UHuzKb1hGWMUGCysI7+ckg==
X-Google-Smtp-Source: ABdhPJxLB4o7VQtW0Iqq/mNQz7OJGLGB4+5O07YFsJcnVIq4fgfDWNw+c4PFZd5ehvNiIuZgNJQT3b7veIeCuuOjzhE=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr5340435otf.345.1614897922247;
 Thu, 04 Mar 2021 14:45:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <pull.815.v2.git.1609468488.gitgitgadget@gmail.com> <69129a20edcfb57a3278285f31584ffcc2b3bad7.1609468488.git.gitgitgadget@gmail.com>
 <877dmmkhnt.fsf@evledraar.gmail.com> <CABPp-BFdN4k=LpAymggw96PPg8dFrzF2FVWLacH2hkrPakhhxg@mail.gmail.com>
 <874khqk3ou.fsf@evledraar.gmail.com>
In-Reply-To: <874khqk3ou.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 4 Mar 2021 14:45:10 -0800
Message-ID: <CABPp-BEdu1PqV5W=FuL0f08iFhGzvzV8oSUybNj4eF0aAwTnAw@mail.gmail.com>
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

On Thu, Mar 4, 2021 at 1:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Thu, Mar 04 2021, Elijah Newren wrote:
>
> > Hi =C3=86var,
> >
> > On Thu, Mar 4, 2021 at 8:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> >>
> >> On Fri, Jan 01 2021, Elijah Newren via GitGitGadget wrote:
> >>
> >> > +     else {
> >> > +             /* must be the 100644/100755 case */
> >> > +             assert(S_ISREG(a->mode));
> >> > +             result->mode =3D a->mode;
> >> > +             clean =3D (b->mode =3D=3D o->mode);
> >> > +             /*
> >> > +              * FIXME: If opt->priv->call_depth && !clean, then we =
really
> >> > +              * should not make result->mode match either a->mode o=
r
> >> > +              * b->mode; that causes t6036 "check conflicting mode =
for
> >> > +              * regular file" to fail.  It would be best to use som=
e other
> >> > +              * mode, but we'll confuse all kinds of stuff if we us=
e one
> >> > +              * where S_ISREG(result->mode) isn't true, and if we u=
se
> >> > +              * something like 0100666, then tree-walk.c's calls to
> >> > +              * canon_mode() will just normalize that to 100644 for=
 us and
> >> > +              * thus not solve anything.
> >> > +              *
> >> > +              * Figure out if there's some kind of way we can work =
around
> >> > +              * this...
> >> > +              */
> >>
> >> So if tree-walk.c didn't call canon_mode() you would do:
> >>
> >>     if (opt->priv->call_depth && !clean)
> >>         result->mode =3D 0100666;
> >>     else
> >>         result->mode =3D a->mode;
> >>
> >> I haven't looked at this bit closer, but that doesn't make the test
> >> referenced here pass.
> >>
> >> I'm refactoring tree-walk.h to do that in a WIP series, and ran into
> >> this.
> >
> > Interesting.  Yeah, there might be more steps to make that particular
> > test work, but I couldn't go any further due to canon_mode().  It's a
> > testcase that has always failed under merge-recursive, and which I was
> > resigned to always have fail under merge-ort too; I suspect it's
> > enough of a corner case that no one but me ever really cared before.
> > (And I didn't hit it in the wild or know anyone that did, I just
> > learned of it by trying to clean up merge-recursive.)
>
> I'll send those patches out sooner than later, but as a quick question,
> for merges / writing new files to the index/trees etc. we basically:
>
>  1. sanitize the mode with canon_mode()
>  2. write it to a new object, either index or TREE object
>
> I've been trying to refactor things so those things have canon_mode() as
> close to the time of writing as possible.
>
> Well, mostly to replace the whole S_*(mode) macros all over the place
> with checks against "enum object_type", which is what most of it wants
> anyway.
>
> Do you think the merge logic generally wants to operate on the "raw"
> mode bits (including what may not even pass fsck checks), or the
> sanitized canon_mode()?

This one little special case is the only one when it'd care about the
raw mode bits.  I'm worried that making the code work on raw mode bits
wouldn't be trivial.  In general mode differences between different
sides or the mode base is a conflict as well, so I'd need to add code
around it's-not-really-a-conflict if canon_mode() on both modes map to
the same value.

> >> As an aside, how does one run the merge-ort tests in such a way as
> >> they'll pass on master now? There's now a bunch of failures with
> >> GIT_TEST_MERGE_ALGORITHM=3Dort, well, just for t*merge*.sh:
> >>
> >>     t6409-merge-subtree.sh                        (Wstat: 256 Tests: 1=
2 Failed: 1)
> >>       Failed test:  12
> >>       Non-zero exit status: 1
> >>     t6418-merge-text-auto.sh                      (Wstat: 256 Tests: 1=
0 Failed: 3)
> >>       Failed tests:  4-5, 10
> >>       Non-zero exit status: 1
> >>     t6437-submodule-merge.sh                      (Wstat: 0 Tests: 18 =
Failed: 0)
> >>       TODO passed:   13, 17
> >>     t6423-merge-rename-directories.sh             (Wstat: 256 Tests: 6=
8 Failed: 4)
> >>       Failed tests:  7, 53, 55, 59
> >>       Non-zero exit status: 1
> >
> > Right, I've been sending merge-ort upstream as fast as possible since
> > last September or so, but there's only so much reviewer bandwidth so
> > I've been forced to hold back on dozens of patches.
> >
> > Currently there are 8 test failures (all shown in your output here --
> > 1 in t6409, 3 in t6418, and 4 in t6423), and 12 TODO passed (only two
> > of which you show here).  I was forced to switch my ordering of
> > sending patches upstream late last year due to an intern project that
> > was planned to do significant work within diffcore-rename; I was
> > worried about major conflicts, so I needed to get the diffcore-rename
> > changes upstream earlier.  That's still in-process.
> >
> > By the way, if you'd like to help accelerate the merge-ort work; it's
> > almost entirely review bound.
> > https://lore.kernel.org/git/pull.845.git.1614484707.gitgitgadget@gmail.=
com/
> > still has no comments, then I have optimization series 10-14 to send
> > (viewable up at
> > https://github.com/gitgitgadget/git/pulls?q=3Dis%3Apr+author%3Anewren+O=
ptimization+batch),
> > then I have other fixes -- mostly for the testsuite (viewable at
> > https://github.com/newren/git/tree/ort-remainder), then I need to fix
> > up the TODO passed submodule tests.  Due to how the submodule testing
> > framework functions, I can't just make a simple
> > s/test_expect_failure/test_expect_success/ -- the tests are structured
> > a bit funny and the tests are themselves buggy in some cases.  I
> > talked with jrnieder about it a little bit, just need to spend more
> > time on it.  But it hasn't been critical because the rest of the code
> > was so far away from finally landing anyway.  Finally, and optionally,
> > comes the --remerge-diff and --remerge-diff-only options to log/show
> > (viewable at https://github.com/newren/git/tree/remerge-diff, but
> > these patches need to both be cleaned up and rebased on
> > ort-remainder).
>
> Maybe something like this with a bit of test prereq sprinkle on top? :)
>
>     diff --git a/t/t6423-merge-rename-directories-TARGET-ort.sh b/t/t6423=
-merge-rename-directories-TARGET-ort.sh
>     new file mode 120000
>     index 00000000000..6bf750c4036
>     --- /dev/null
>     +++ b/t/t6423-merge-rename-directories-TARGET-ort.sh
>     @@ -0,0 +1 @@
>     +t6423-merge-rename-directories.sh
>     \ No newline at end of file
>     diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rena=
me-directories.sh
>     index 5d3b711fe68..1e571384223 100755
>     --- a/t/t6423-merge-rename-directories.sh
>     +++ b/t/t6423-merge-rename-directories.sh
>     @@ -3,2 +3,4 @@
>      test_description=3D"recursive merge with directory renames"
>     +# TARGET-ort: GIT_TEST_MERGE_ALGORITHM=3Dort && export GIT_TEST_MERG=
E_ALGORITHM=3Dort

To test my understanding of your proposal, would you need to add this
line to hundreds of files?

>     +
>      # includes checking of many corner cases, with a similar methodology=
 to:
>     diff --git a/t/test-lib.sh b/t/test-lib.sh
>     index d3f6af6a654..8d5da7e0ba9 100644
>     --- a/t/test-lib.sh
>     +++ b/t/test-lib.sh
>     @@ -247,2 +247,11 @@ TEST_STRESS_JOB_SFX=3D"${GIT_TEST_STRESS_JOB_NR:=
+.stress-$GIT_TEST_STRESS_JOB_NR}"
>      TEST_NAME=3D"$(basename "$0" .sh)"
>     +if test -L "$0"
>     +then
>     +       target=3D$(echo "$0" | grep -o "TARGET-[^.]*")
>     +       if test -n "$target"
>     +       then
>     +               to_eval=3D$(grep "^# $target: " "$0" | sed 's/.*://')
>     +               eval $to_eval
>     +       fi
>     +fi
>      TEST_NUMBER=3D"${TEST_NAME%%-*}"
>
> That implementation's a bit of a hack, and requires SYMLINK (could be
> changed), but now I can:
>
>     ./t6423-merge-rename-directories-TARGET-ort.sh
>     ./t6423-merge-rename-directories.sh
>
> And run the whole thing with/without ort in one go.
>
> Then with a trivial symlink-in-a-loop $(git grep -l MERGE_ALGORITHM)
> loop on top I've got ort and non-ort merge tests all in one go on a WIP
> topic.

Do you need a symlink for each file as well, thus hundreds of symlinks?

Your idea is a quick way to get testing, that's much better than
duplicating all the files.  I'm still a bit worried that it'd
encourage people to only add it to the "most important" or "most
obvious" test files, which goes somewhat counter to testing merge-ort
as a full replacement of merge-recursive.  While developing merge-ort,
I'd sometimes see failures outside t6*, even when everything under t6*
passed.  For example, t3[45]* and t76*.

> >> And both test_expect_merge_algorithm and what seems to be a common
> >> pattern of e.g.:
> >>
> >>     t6400-merge-df.sh:      if test "$GIT_TEST_MERGE_ALGORITHM" =3D or=
t
> >>     t6400-merge-df.sh-      then
> >>     t6400-merge-df.sh-              test 0 -eq $(git ls-files -o | wc =
-l)
> >>     t6400-merge-df.sh-      else
> >>     t6400-merge-df.sh-              test 1 -eq $(git ls-files -o | wc =
-l)
> >>     t6400-merge-df.sh-      fi &&
> >>
> >> Will not run tests on both backends, I was expecting to find something
> >> so we can the test N times for the backends, and declared if things we=
re
> >> to be skipped on ort or whatever.
> >
> > Yeah, multiple ways of testing were discussed mid last year.  There
> > were lots of tradeoffs.  I think the thing that pushed in this
> > direction is that we're not just aiming to add another optional merge
> > backend, we're aiming to replace merge-recursive entirely.  Since
> > merge tests appear all throughout the code base, many as rebase or
> > cherry-pick or revert or stash tests...or just as simple setup tests,
> > we want all of those tested with the new backend.  Trying to duplicate
> > all those tests in any way other than just re-running the testsuite
> > with a different knob would require huge changes to hundreds
> > (thousands?) of testfiles and conflict with nearly every other topic.
> > So I made an environment variable that would choose which backend to
> > use, but with the downside of having to re-run the testsuite again.
> >
> >> I understand that this is still WIP code, but it would be nice to have
> >> it in a state where one can confidently touch merge-ort.c when changin=
g
> >> some API or whatever and have it be tested by default.
> >
> > Thanks for proactively checking.  To make it easier for you, I'll see
> > if I can submit a series later today that mostly completes the
> > merge-ort implementation; the t6423 testcases won't be fixed until
> > "Optimization batch 12" lands, and I might not be able to fix the
> > "TODO passed" submodule tests in this series, but the rest of the
> > stuff can be fixed with about 10-12 patches.  I had been worried about
> > overloading the list with too many patches at once, but since it
> > sounds like you're willing to review these particular patches...  :-)
>
> *nod*
>
> Also, I'll try to get to reviewing some of it, thanks for all your work.
>
> B.t.w., if the original E-Mail sounded like complaining that wasn't the
> intent. I just thought I'd shoot off a quick message about if I missed
> something about the in-flight status / testing of the ort work...

Nope, didn't sound like complaining; thanks again for checking.
