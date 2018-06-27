Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289801F516
	for <e@80x24.org>; Wed, 27 Jun 2018 11:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeF0Lsz (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 07:48:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:52107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934048AbeF0Lsx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 07:48:53 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQMBU-1fk8S815xM-00Tlk2; Wed, 27
 Jun 2018 13:48:44 +0200
Date:   Wed, 27 Jun 2018 13:48:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Tiago Botelho <tiagonbotelho@gmail.com>,
        git <git@vger.kernel.org>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list
 --bisect
In-Reply-To: <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1806271254210.21419@tvgsbejvaqbjf.bet>
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com> <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com> <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com> <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
 <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com> <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:epNcrZdrr+tco8U9k2DZf0KsNcQPmGVOiKMWj4iUL661FBvAlFy
 xxUjhutZYltZAb1ng+E2I7D5GWcSjJK9WpHiHVl0adnXRCGX1gTXe2cmM+VH1ucRu6nEDhy
 sPrOnx2GnMXetvRbvjDdB3ANGeVVmpAER9gNmqLhjhWghCIolblMjy81iSiGzg4/iC1NHYi
 E2E/pNA8X3trBMGGofXcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LetMc27y5/4=:4O/AFxp0NKhlGl4mrkyD/s
 h9JlG28WNd07hwpqp3HsPLudm9aKFIsegzVxrdfiU9Xv1htAUHzt67gGLSRuEhR5anveOHWi8
 vrv7WXENRuGCmhs13KoQB25LLlNfyQc2eGFmXTq6jDcYboG8OhqJiLbAuaRUuz7+1mp0S2rEF
 AYNAA3Wq1TkHTngzp/noLXkjnyuAoCfxctOVbMoJlEFNk9bXU7n+vmLlHgaXWsu3msu0yq0xq
 mA9ledns4ZrHIZ/bQ/q/dxG4l2FL1N6wEm8mBp+OjcjFuLoE2SmjR0HQY2QdxSzRIwwWvWNsA
 xGhE1aB2D1aPo1KgJI31TgJS+z83smC9T/VP5zKQGF678Wd2TQSkcawx3w0gcPi3aEGX8fP1g
 ts1YL+IWIa+6UVuH3bSgYfRGlu668cRuhtGIdOL7zIa+eW2lu0uAhtCZSAcCLHPoXnG5ixzHS
 x7Mx9ZqejBm/WTKATcCIEoiW0PeOqMHS69tAHcAy0lAtPbBCsW1UVsUM39Av3UkdYBft/NaY1
 5bkoyMDwyx2/bJxH+N5WB7JoEvplIIxwKixaTZRXf1vuz+mJXJnI8OfUHL6/uz0wgaOHaelC3
 rjpsA89h8IZUySD2Jd6r0VRUbl5Qv/7uluXFGMvMpCN2jq8zXCKZMfWYR8k5fXFd821IbLiCl
 n6W5FWUG56mmL5UyAbiMZpZrYQOQK58Y6S4r+v8yunKxWEs4vwThKiEeEOXDknhZN6lj/Nctx
 Nx9yM7d4wcIGYNt9IgeA2BPGhYIn+olMMMB8JPud2LiCbeVDWthO8BNZEInUoSRX7RFbvq4g/
 6Sj7pyv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 26 Jun 2018, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
> 
> > Obviousness is often not the same for everybody.
> 
> ... which you just learned---what you thought obvious turns out to
> be not so obvious after all, so you adjust to help your readers.

Indeed. And trying to tell the reader that they should find it obvious is
not exactly productive. It only causes bad feelings and can be easily
avoided.

> >> In this particular case it even feels as if this test is not even
> >> testing what it should test at all:
> >>
> >> - it should verify that all of the commits in the first parent
> >> lineage are part of the list
> >
> > It does that.
> >
> >> - it should verify that none of the other commits are in the list
> >
> > It does that too.
> 
> But the point is it does a lot more by insisting exact output.

Indeed. One thing it does in addition is to make the test code a lot less
obvious for readers in general.

Let me summarize again what good regression tests have to deliver, because
I think it cannot be stressed enough, especially in this context where we
run the danger of adding poor regression tests:

- a regression test needs to catch regressions (d'oh)

- a regression test needs to be *quick*. Otherwise developers will skip
  running them, which is worse than having no tests at all (because the
  effort to develop them is wasted)

- a regression test must make it as easy as possible to fix regressions

There are quite a few corollaries to that last point, some of which are:

- a regression test that fails for anything but an obvious reason is
  *useless*

- a regression test that tries to test for *everything* (including dogs and
  cats) not only breaks the quickness requirement, but it also makes it
  confusing where to start fixing things. "The test talked about --bisect
  but now I am stuck somewhere in XYZ.c, what has *that* to do with
  --bisect?" is *not* something you want to risk any developer yelling at
  the test code that you authored

- less is more. If you can use commits that were already generated in the
  common "setup" step, there is literally a negative value in generating a
  new set of commits instead

- less is more. If you can catch the same regressions in three, concise
  *and* understandable lines, avoid using thirty lines instead

- regression tests should not need to be adjusted when the logic changes
  in an intended way. It is a strong sign that a regression test was
  written badly if it starts failing for any reason other than a
  regression

The overzealous "I want this output to be exactly this" stance of the
tests we are discussing here is a very obvious violation here.

Regression tests should fail only to indicate regressions.

Really. Let me repeat that because it is so obvious when you think about
it, but it is easy to forget when writing regression tests:

Regression tests should fail only to indicate regressions.

> For example, the version I reviewed had a two "expected output", and
> said that the actual output must match either one of them.  I guess it
> was because there were two entries with the same distance and we cannot
> rely on which order they appear in the result?  If a test history gained
> another entry with the same distance, then would we need 6 possible
> expected output because we cannot rely on the order in which these three
> come out?

It is totally unnecessary to go there, as it would make those regression
tests a lot less valuable than they could otherwise be. Let me elaborate
further below.

> That was the only thing I was complaining about.  Dscho gave me too
> much credit and read a lot more good things than what I actually
> meant to say ;-).

Why don't you just accept my praise gracefully? ;-)

It's not that I gave you a lot of praise recently, even if you clearly
deserve it.

> >> And that is really all there is to test.
> 
> Another is that "rev-list --bisect-all" promises that the entries
> are ordered by the distance value.

Yes! And you know what we can do there? We can test *precisely* that!

	# verify that the output is sorted by `dist` (descending)
	sed "s/.*dist=\([0-9]*\).*/\1/" <revs >dist &&
	sort -n -r <dist >dist.sorted &&
	test_cmp dist dist.sorted

This extracts the distance numbers into their own file, then verifies that
they were already sorted.

The really big advantage here is that any future change that might result
in a different order of entries with the same "dist" value *will not cause
this regression test to fail*. And for a good reason: because ordering
identical "dist" values differently is not a regression at all.

> So taking the above three points, perhaps
> 
> 	cat >expect <<EOF &&
> 	... as written in one of the expect list in Tiago's patch
> 	EOF

Please no. Please let's *not* generate more commits when we already have a
perfectly fine set of commits generated by the setup phase of the very
same script. Please let's not use confusing names for those commits.
Please let's not add a diagram whos layout deviates for no good reason
from the layout used by the existing diagram in the same file.

> 	# Make sure we have the same entries, nothing more, nothing less
> 	git rev-list --bisect-all $other_args >actual &&
> 	sort actual >actual.sorted &&
> 	sort expect >expect.sorted &&
> 	test_cmp expect.sorted actual.sorted

With plenty experience in investigating test failures of Git's test suite
under my belt, let me tell you how much faster it is for me to start
debugging when reading this code instead:

	git rev-list --bisect-all --first-parent F..E >revs &&
	# only E, e1..e8 should be listed, nothing else
	test_line_count = 9 revs &&
	for rev in E e1 e2 e3 e4 e5 e6 e7 e8
	do
		grep "^$(git rev-parse $rev) " revs || return
	done

I am faster by... a lot. Like, seconds instead of minutes.

As a bonus, it is also shorter. Quicker to read. Easier to grok. Quicker
to validate manually.

> 	# Make sure the entries are sorted in the dist order
> 	sed -e 's/.*(dist=\([1-9]*[0-9]\)).*/\1/' actual >actual.dists &&
> 	sort actual.dists >actual.dists.sorted &&
> 	test_cmp actual.dists.sorted actual.dists
> 
> is what I would have expected.

... but without the [1-9] because the distance can be 0. And with a star
after the [0-9] instead.

And then you have essentially the very same thing I suggested above. A
readable regression test, that only triggers failures upon the regression
we want to prevent, is fast to grok, actionable, and leads to fast
debugging.

Just to make sure: I am utterly disinterested in pushing "my" code
through. I am very much interested in having a good patch with a good
regression test and a good commit message. Otherwise I would not put up
with what it takes to review it.

So Chris, if you feel that you must "win" against me, just take Junio's
code already. In that case, however, do change his code to avoid
generating those unnecessary commits.

Thanks,
Dscho
