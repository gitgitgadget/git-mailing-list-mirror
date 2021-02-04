Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6733DC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E3764FA0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhBDVnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:43:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:53683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229513AbhBDVnp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612474929;
        bh=R92/KYxzKsHZ5zwMwiVjrEirT6RKWvdzqtXx8jMEXmk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AJigMiYUG08z8PounD3fPMg40Lh3L5vwbNFlEYfUzKUt7jsg+XKuJvp7ssryN9xmR
         rc6I0c3NBPY9M8r3cqz8GtXTsZtnuGJ5QxfUkf2s7C3BqOWrcmBU6yqOYJu1vRWT/+
         UxYS3IhSkl08gN0Xq32ZqkHOc/aQYe6SvJzZF1Xo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1m2kwp47vj-0169lp; Thu, 04
 Feb 2021 22:42:09 +0100
Date:   Thu, 4 Feb 2021 22:42:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
In-Reply-To: <xmqq7dnn7jjz.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2102042027570.54@tvgsbejvaqbjf.bet>
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com> <pull.841.v4.git.1612431093.gitgitgadget@gmail.com> <448e6a64fa157990fcc973ce2fe4a9fc2ba1ab32.1612431093.git.gitgitgadget@gmail.com> <xmqq7dnn7jjz.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:x0Zzyff+qEr9iVA+Ypb52XoiLnEj4MSWBlMuITSulpUjPcHQreI
 NpTpgSejtGXYxwjg3/CuMIGDMu7YudMpp30WVDL/XFPH6XA6BsopbfTF00OkGYtReSjelnm
 hB1YWIQTpBwEWlJ7tSa6t8oY9CqhOekh7NGPopzWmOv2o4P7M7DPNW7BIOuXTtjksFl2Gy5
 SrgVIhaYww+AMjrQgKrCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S92h5GZdmuk=:5sOHW/neQlmGUVgMPt411h
 CO9z7J+7qOs+rZVPmitR/yiEqOjzBWH9OauG86YkkddpU3QChxzrYL8eQy0VomaYePmY4PxOl
 8E9RP3FvhcGhMQ/tKNAjIa9/CUDuGwDwN7F+c3W3FreNql9UKHV45h/JQOEmiFePrsy5r+8ky
 5i6YYssx6+mwufve626aK5EylinERlypY6/UYSH9jibfcF44buOPGmdhvw820iWU6qmuJD7G9
 UqWxjayZBwoji3/K88CFsCqQMp2eNLAjar13Q9dORKi17m+odHpusee1KAw0TvAjGELldqUlT
 CSy8hAe2tKPrfadssglYxXa1P9MGPB3soJWpcsd4iXCgrlJg13xpZCkoK03vhhTAcjkUBMxSQ
 g/pgtuw1TwR80TC8QUJKCVGj6mPkqnJACWt7d+3hxtu3EX7pFhqQ1fl8LEMiKTk8EGPP/PD3L
 hoAvCdhNNdBJAzN/70x9PEweIGyL3clMzYumDWj9kSO895stcwz8GrgtVKkxeH+TK9bx5L+B5
 ZIxzLZLlNXryDsn4HS/AtdepJxeN9Yn3IO9Oj+ZZLBCl0y8XoZpaQNCj6c65kFmMFmD0biUsR
 IlSCZJ6rVXzPsYZ0JqSrOd9ajPJTd/PhHErZhzQ/vjUxGr9sT93BZDaL5cQEJ8IqYXaKYoqRI
 NYRrtc9Ljz303FOoVrwww+A8fKS2dkSe7pr+IoVHwOOdprkjkrnANNS77i2V35c7bCRXV668o
 xb39Qc1in0r0FoV8+sWTeQoGs0pCSIXJiWohyIRrrJiiqx15DPp/iYjoEJ5Ea3yQBXy9VrCB9
 asceYchGr5lYmBqepX6ZCERZrxq7dXkuQNGGxPh046iLKk2J7OfXfOFylShN8OlGjRGOL+gg4
 Prt4qKlTYMwyBsNwEYxwbqNXPDXkR0RJ+XcmBNu8g=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 4 Feb 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> >  int is_range_diff_range(const char *arg)
> >  {
> > -	return !!strstr(arg, "..");
> > +	char *copy =3D xstrdup(arg); /* setup_revisions() modifies it */
> > +	const char *argv[] =3D { "", copy, "--", NULL };
> > +	int i, positive =3D 0, negative =3D 0;
> > +	struct rev_info revs;
> > +
> > +	init_revisions(&revs, NULL);
> > +	if (setup_revisions(3, argv, &revs, 0) =3D=3D 1) {
> > +		for (i =3D 0; i < revs.pending.nr; i++)
> > +			if (revs.pending.objects[i].item->flags & UNINTERESTING)
> > +				negative++;
> > +			else
> > +				positive++;
> > +	}
> > +
> > +	free(copy);
> > +	object_array_clear(&revs.pending);
> > +	return negative > 0 && positive > 0;
> >  }
>
> One thing that worries me with this code is that I do not see
> anybody that clears UNINTERESTING bit in the flags.  In-core objects
> are singletons, so if a user fed the command two ranges,
>
> 	git range-diff A..B C..A
>
> and this code first handled "A..B", smudging the in-core instance of
> the commit object A with UNINTERESTING bit, that in-core instance
> will be reused when the second range argument "C..A" is given to
> this function again.
>
> At that point, has anybody cleared the UNINTERESTING bit in the
> flags word for the in-core commit A?  I do not see it done in this
> function, but perhaps I am missing it done in the init/setup
> functions (I somehow doubt it, though)?
>
> Shoudn't we be calling clear_commit_marks(ALL_REF_FLAGS) on the
> commits in revs.pending[] array before we clear it?

Yes, we should ;-)

> Depending on the shape of "arg" that is end-user supplied, we may have
> walked the history in handle_dotdot_1() to parse it (e.g. "A...B").

The code in `handle_dotdot_1()` that handles `...` calls
`get_merge_bases()`, which eventually calls `get_merge_bases_many_0()`
with the `cleanup` parameter set to `1`, i.e. it _does_ clean up the
flags.

Otherwise, `git log A...B` couldn't work, could it? ;-)

> Also we'd want to see what needs to be cleared in revs.cmdline
> that would have been populated by calls to add_rev_cmdline().

Is this cleared, like, ever? I don't see any code that handles `cmdline`
that way. Seems as we're willfully leaking this.

Ciao,
Dscho

> Other than that, I quite like the way the actual code turned out to
> be.
>
> > diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> > index 6eb344be0312..e217cecac9ed 100755
> > --- a/t/t3206-range-diff.sh
> > +++ b/t/t3206-range-diff.sh
> > @@ -150,6 +150,14 @@ test_expect_success 'simple A B C (unmodified)' '
> >  	test_cmp expect actual
> >  '
> >
> > +test_expect_success 'A^! and A^-<n> (unmodified)' '
> > +	git range-diff --no-color topic^! unmodified^-1 >actual &&
> > +	cat >expect <<-EOF &&
> > +	1:  $(test_oid t4) =3D 1:  $(test_oid u4) s/12/B/
> > +	EOF
> > +	test_cmp expect actual
> > +'
> > +
> >  test_expect_success 'trivial reordering' '
> >  	git range-diff --no-color master topic reordered >actual &&
> >  	cat >expect <<-EOF &&
>
