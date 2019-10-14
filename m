Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88FB71F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 10:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfJNKmK (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 06:42:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:51897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731249AbfJNKmK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 06:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571049722;
        bh=CJX5aXXrOnH+FbFpklqXFt84t5gIDQtf/8EUw0VEfqg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WZioJzE2oKMQK0UJCr6cONKsxlHjf/jqhdaHl6HMpdDMmJIt9WcUsIUUFc6SQ2LVp
         M78Oj1LwxQ7a8hEonm81vQnAW5ivLtDq+FcC75Old5M7CFe1izBFoX195kOZMdnK8/
         I0kBr7EfQsoSRd/FnCpQvZDDtsry/6MDgFLSfCB8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1i2Qsk1Dpw-00r0ze; Mon, 14
 Oct 2019 12:42:02 +0200
Date:   Mon, 14 Oct 2019 12:41:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge-recursive: fix merging a subdirectory into
 the root directory
In-Reply-To: <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbjf.bet>
References: <pull.390.git.gitgitgadget@gmail.com> <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet> <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BUdtivZen/9hicQYv9Ew3WPMkJvm5bUvOHm67kFrbYo1sUvTFK7
 cZjrBmM+C6kF/XJEso/7c+MGh4Ja+12cAV3P8d7c2eSwvcBc+ZW6TfWEJJ2jqpYrn1LZzan
 u5iQLPzT2OdahmEtig7tRIHBYNmAatgzHe/Ijf+NVcRj53Kg4UTq59bdVb4WzkXEUcfMigU
 b+I+xypD0OeAbo9uybxAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZL8wewe0EJQ=:Ruz0Z7aFml/AWkedhmpVlT
 s4ZckTbFLtkV1oNFqXBO4Mz9hQmaBvhHbu7hVc8du7dU5s9Zj1HKLHqz7AMjZH7B/MKZhJ3ME
 dzzFlPq/gHZGOatlQgyPRD5dJ6UuQJIsWfGam661FaRmGT7pVFwYjx2/ApdglFRPnn3YGMPBI
 CNQNN+H8d8UvbmZvQVJ34eXkyAajV1QPmcVTxsWdCcO3PJ1kGh5gbp9bJjTPA2Mf1pD+V+ApC
 Czykt8osyPOL0TeE0CZWnBTm4y3ymly6OxJrHrnjnb1IumZCRcTJ8VBP5cQ47sGxl2ZCMPuai
 qOcBSqqszn0rbzq+yTbBHkZSYVzitSpadwPocT/hx4NYJF01PnAgba7IERFaXhUqj5dcrrg0+
 eY29bPYjff8aPCW+JywMdglrnfXP+86HxU7U9wEaPX5cg2YiXlPOLVfN2im0z6PGeox0HOGpR
 LexaIrXIS+QRpD0KttQegf0TBbx2Ur50OgV4lmFeLtgp0EfUpN68aZl4J3XQPtLl2q21Ya0S3
 VNhFenqf8pSgPI/UmDsU1zpZ3UitO349fdZoFqNIYR3olYu4ohocWIrck1OkAe8pUB33rD2+/
 6MeNBr/3X+5T5ZH0F4hbAZZC0h4wsbZKwFvk9oXW6Q9wvu6hdd0JGBU9rsk3qbgyBt9x3+RDI
 ZCFEXOyLennWK1Lhjit6SgPkMzORPjg8L4xYsRHIEwB+R6M0SsqvAOckTayrJgKmtrY0akJOP
 MrZhbWdsYY+p9lhpKWC13hPXu6yOKfRrzBoMVsSzIiQCwNSDRZAft79p+yp+QU+fHlOfiFhdM
 tMJ+1SvQ3g+2/ZAytbTFH39NVCTEhy8x0gfc74h7Bb/dukawPV/FT48ew3LBG6KK9gOg3JhZ7
 VUNXsiV5IUHrd6kCAfsZuDPyjl9IigK+iQF5Xs7pNLmkBJekxkSWV1JExHgxioj7L8UgvuA7m
 yLbtwuFMC/c6Dye+re6IcqjI3U+qF4boo8F4IoIa+ejdHYbqjpqpdsekBEAwi+i2Dq2C4xz92
 AdhrdXChuUB2gzo4pf+TWjPXfQ8RqWEidKlFdRfp34/wt1HVhk+Mt1B2AC1N3zHKeb5U+nufx
 htoRaJ8mjcMwZjUWwBM9b1azmtj1Q71BDlwcLfWr6sAnzXD8KSP86kXHmWTRH3G/nWmNwp3/g
 8Q17C5IkTtGHNpEzikrcSakiw15Vhwz8+9SdptQXH48XLpAFKYcY4Jiv/QgDaFtgApLxjw8jR
 /Kpr2gXMJFOavmc9Ji5NRaQKXP+8raygcq319ppMzougCCgpA+9lrhGAUGy0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 12 Oct 2019, Elijah Newren wrote:

> On Sat, Oct 12, 2019 at 1:37 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> [...]
> > For the record: I am still a huge anti-fan of splitting `setup` test
> > cases from the test cases that do actual things, _unless_ it is
> > _one_, and _only one_, big, honking `setup` test case that is the
> > very first one in the test script.
> >
> > Splitting things into two inevitably leads to unnecessary churn when
> > investigating test failures.
> >
> > And that's really what test cases need to be optimized for: when
> > they report breakages. They need to help as much as they can to
> > investigate why things break. Nobody cares when test cases succeed.
> > The ~150k test cases that pass on every CI build: nobody is
> > interested. When a test case reports failure, that's when people pay
> > attention. At least some, including me.
> >
> > The most common case for me (and every other lazy person who relies
> > on CI/PR builds) is when a build breaks, and then I usually get to
> > the trace of the actually failing test case very quickly. The
> > previous test case's trace, not so easy. Clicks involved. Now I lose
> > context. Not good.
> >
> > A less common case for me is when I run test scripts locally, with
> > `-i -v -x`. Still, I need to scroll back to get context. And then,
> > really, I already lost context.
>
> I guess we have some strongly differing opinions here.

And probably experiences, too.

I literally debug something like a dozen per week test failures that are
reported via Azure Pipelines. And yes, I ran into some snags even with
your two-parter test cases in the past, and they did not help me. They
increased my burden of figuring out what is going wrong.

> The one thing I do agree with you on is test cases need to be
> optimized for when they report breakages, but that is precisely what
> led me to splitting setup and testing.

To me, it is so not helpful _not_ to see the output of a `setup` that
succeeded, and only the output of the actual test that actually failed.

It removes context.

I need to understand the scenario where the breakage happens, and the
only way I can understand is when I understand the context.

So the context needs to be as close as possible.

> Way too many tests in the testsuite intersperse several setup and test
> cases together making it really hard to disentangle, understand what
> is going on, or even reverse engineer what is relevant.  The absolute
> worst tests are the ones which just keep making additional changes to
> some existing repo to provide extra setup, causing all sorts of
> problems for skipping and resuming and understanding (to say nothing
> of test prerequisites that aren't always met).

I agree with this sentiment, and have to point out that this is yet
another fallout of the way our test suite is implemented. If you look
e.g. at JUnit, there are no "setup test cases". There are specific setup
steps that you can define, there is even a teardown step you can define,
and those individual test cases? They can run in parallel, or
randomized, and they run in their own sandbox, to make sure that they
don't rely on side effects of unrelated test cases.

We don't do that. We don't enforce the absence of side effects, and
therefore we have a megaton of them.

But note how this actually speaks _against_ separating the setup from
the test? Because then you _explicitly_ want those test cases to rely on
one another. Which flies in the _face_ of trying to disentangling them.

> But the ones with one big honking `setup` test case that is the very
> first one in the test script can often be pretty bad too when you've
> found a bug in testcase 82 and want to have a simple way to reproduce.

Indeed. One of the first things I try when `--run=3D82` fails is
`--run=3D1,82`. That's the best we can do in the absence of a clean design
like JUnit and its `@Before` method.

> It's awesome when someone can just run ./testcase.sh --ver --imm -x
> --run=3D86,87 and reproduce the problem.

But of course, often you would need `--run=3D1,86,87`. And it is totally
not obvious to _anybody_ who wants to contribute a new feature and whose
CI/PR build fails in one of your test cases.

> It feels sadly rare to be able to do that in much of git.git's
> testsuite.  Not accreting ever more changes into a repo to setup
> subsequent problems, using entirely separate repos for different cases
> where testing makes any changes, making it clear what is setup, making
> it clear what's the command being tested, and making it clear what all
> the commands are that are testing that the original test command
> produced the expected behavior all go a long way to making things way
> easier to investigate.

Sorry, I disagree. By squirreling away your setup phase into what looks
like an independent test case, the code is not more obvious, but less
so.

> Now, I will re-use a setup case for multiple tests and even did so in
> t6043, but only when the setup really is identical (e.g. not only are
> the tests expecting an identical setup, but the commands being tested
> are read-only or any changes they make are unconditionally reverted as
> the last step of the testcase).  Naturally, when I re-use a setup
> block multiple times, I really don't want to copy the setup into each
> of those tests either.
>
> It would be really nice, though, if there were some way for me to
> specify that a given "testcase" was just setup (so that they don't
> even get a number in the prove output and don't count as a "test"
> except maybe when they fail), and if there were some way to specify
> which testcases depend on which setup blocks (so that if I want to run
> just a given test, the setup test gets automatically included).
>
>
> Your example of CI/PR builds makes sense to me, and I really would
> like to make that nicer and improve other workflows too, especially if
> it can be done without breaking my ability to investigate test
> failures.  If someone can think of a clever way to do that (e.g. some
> way of implementing my "It would be really nice" in the last
> paragraph, and in a way that could also benefit CI/PR builds), I'd be
> happy to go through and help switch things over.

My suggestion: do not rip apart commands that belong together. The setup
phase is often more important to understand than the actually failing
command. _Especially_ when the setup test case reports success, but
actually failed to set things up as intended (which I encountered more
times than I care to count).

> > > +     (
> > > +             cd 12d &&
> > > +
> > > +             git checkout A^0 &&
> > > +
> > > +             git -c merge.directoryRenames=3Dtrue merge -s recursiv=
e B^0 &&
> > > +
> > > +             git ls-files -s >out &&
> > > +             test_line_count =3D 2 out &&
> >
> > Isn't this a bit overzealous?
> >
> > > +
> > > +             git rev-parse >actual \
> > > +                     HEAD:subdir/foo.c.t   HEAD:bar.c.t &&
> > > +             git rev-parse >expect \
> > > +                     O:a/b/subdir/foo.c.t  B:a/b/bar.c.t &&
> > > +             test_cmp expect actual &&
> >
> > Likewise?
> >
> > > +
> > > +             git hash-object bar.c.t >actual &&
> > > +             git rev-parse B:a/b/bar.c.t >expect &&
> > > +             test_cmp expect actual &&
> >
> > Likewise?
> >
> > > +
> > > +             test_must_fail git rev-parse HEAD:a/b/subdir/foo.c.t &=
&
> > > +             test_must_fail git rev-parse HEAD:a/b/bar.c.t &&
> > > +             test_path_is_missing a/
> >
> > Makes sense, but the part that I am missing is
> >
> >                 test_path_is_file bar.c.t
> >
> > I.e. the _most_ important outcome of this test is: the rename was
> > detected, and the added file was correctly placed into the target
> > directory of the rename.
>
> That's a useful thing to add to the test, I'll add it.  (It's kind of
> included in the 'git hash-object bar.c.t' half a dozen or so lines
> above, but this line helps document the expectation a bit better.)
>
> I'd be very reticent to include only this test_path_is_file check, as
> it makes no guarantee that it has the right contents or that we didn't
> also keep around another copy in a/b/bar.c.t, etc.r

I agree that it has to strike a balance. There are multiple aspects you
need to consider:

- It needs to be easy to understand what the test case tries to ensure.

- While it is important to verify that Git works correctly, you do not
  want to make the test suite so slow as to be useless. I vividly
  remember how Duy mentioned that he does not have the time to run the
  test suite before contributing. That's how bad things are _already_.

As a rule of thumb, I would like to submit that a test case should fail
when the claimed goal (i.e. the test case's title) is, and a breakage in
that should both be sufficient and necessary for it to fail.

In this instance, the title is:

	12d-setup: Rename (merge) of subdirectory into the root

Now, this does not even tell me clearly what it tries to ensure. But
from the code, I guess that it wants to ensure that the directory rename
detection can detect when a directory's contents were moved into the
top-level directory.

Now, let's apply the rule of the "sufficient". I would expect the
outcome to be that the file that was added to that directory in one
branch is moved together with the directory's contents that the other
branch moved into the top-level directory.

I was missing that test, hence I pointed it out.

But testing the absence of the file `foo.c.t` in its original location
which was moved in one branch, and not touched in the other, i.e. with a
_trivial_ three-way merge resolution, that seems to be extra. It would
not break if the directory rename detection is broken, so it is an extra
test that does not do what the test case's title claims to test.

Now for the "necessary" part. It is totally unclear to me how all those
other things you test for would be failing _only_ if the directory
rename detection failed. I would actually expect that there are _many_
ways that this test case could fail in ways that have not the faintest
thing to do with directory rename detection.

As somebody who, as I stated above, investigates dozens of test case
failures per week (although, granted, most of them are relatively
trivial to resolve, it is invariably test cases like the one I am
commenting on that require the most time to get resolved), I have to
admit that there are few more frustrating things in debugging than
having to chase issues that have _nothing_ to do with the stated goal of
the test case.

> I understand my checks above look overzealous, but merge-recursive has
> been a bit of a pain to understand and deal with at times, and I've
> been bitten one too many times with tests (of merge-recursive and
> elsewhere in git.git) that passed but still did the wrong thing
> because they only tested one way in which the test problem failed in
> the past rather than specifying what correct behavior is.  And my
> "overzealousness" in the merge-recursive tests really have caught and
> prevented bugs would have been missed otherwise.

If you must have those tests, then please structure them in a way where
they are much more actionable. Ideally, it should be clear from a glance
at the trace of a failed test case (and _only_ from that test case) for
less than five seconds _what_ is being tested, and it should be obvious
what is going wrong.

I cannot say that about the test case in this mail.

> Oh, and I think there's another place in the code that needs to be
> tweaked to make sure we handle renaming subdirectories into the root
> directory that I missed (and just wasn't tested by this testcase), so
> I'll check into it and if so fix the code and add another testcase,
> and include the fixups I agreed to above and send out a v2.  Probably
> won't get to it until the middle of next week, though.
>
>
> Thanks again for the review and food for thought.  The CI/PR builds
> sound particularly interesting; I'd really like to make those better
> for you if it can be done in a way that doesn't break command line
> builds with clear documentation of setup and expectations while
> supporting test skipping and post-facto investigation (even without
> --immediate or re-running), etc.  Hmm...

My hope was that CI/PR builds could help improve the code quality in
`pu`, and to a large part it did.

The time I need to spend on understanding test cases' code (t0021 is a
particularly nasty one, not your fault, of course) before I can even get
to fire up a debugger, this amount of time is insane, though.

Ciao,
Dscho
