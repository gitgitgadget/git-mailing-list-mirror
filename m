Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED54C63697
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 11:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520F62080A
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 11:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="esh8WNsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgKRLc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 06:32:56 -0500
Received: from mout.gmx.net ([212.227.17.21]:50827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgKRLc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 06:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605699136;
        bh=lK01bRL9gxsydOkVl0rMGeLki//MlvV8N9UhR2SysUY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=esh8WNsDL3xf7wfbkZfU70piqgORweE1S1dpMvJH28GJvUApibvfUgRjyztN6AdFE
         pzHfA81fDnO0xxd4Olm00HZdmRZe5dnBo7QW6LPk/V/EI3oNtL3McaxP4nBP/FsAAM
         SgYEoQnYt9a79qt3cDCVYd/VdAmmATI4c9nJ/YpE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1kGIPM2oLU-0137W7; Wed, 18
 Nov 2020 12:32:16 +0100
Date:   Wed, 18 Nov 2020 12:32:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH 00/28] Use main as default branch name
In-Reply-To: <xmqqima343vb.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011181207220.56@tvgsbejvaqbjf.bet>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <87r1oraewl.fsf@x220.int.ebiederm.org> <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com> <20201117233313.GB642410@coredump.intra.peff.net> <xmqqr1or4jen.fsf@gitster.c.googlers.com>
 <20201118012544.GC650959@coredump.intra.peff.net> <20201118024028.GE360414@google.com> <xmqqima343vb.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kFkZhEo+TEBb4iYWrISHnawFyMMGFc1ZIdTZXQaxarsAjlY5zzP
 HRXeiGZ1lA8RHHNndLKCaXJDpjJjfvu1yIBKr1HM8UHi6+X56gb/tY8YQF3gHa07IOn6Tof
 4f7PEXGNBenOcbzDnF4RYDPmO9yk8KOxpmXFCvaDnYdXhAIW8MsP7ZpjFLHOPgVNBo41GwI
 ruxcalsyjAd/uE0qYTO4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VH0bqjYVZjk=:qPfj4hqoF1HgDnYyVO5F38
 93PilpsKx446xwcwXXrD4k5SlF+s60tahupsXsy9VWMjeOLANDC2U731FOxRbCkPj3bfX9QTH
 D5SsK/ji7tK8BS8eP494A2Lq1wUJKBwpX1Cvg3xQcoppqwGrGdBXAQXBzm9+NYYXTODzIgHBT
 s2Yg8FN82ezVbj0D9cq30BOnKpNZ1sodsklBQ5z6wSxkvdsHYNm5FibSWm522v81u2NSXdS2K
 EMlsXvFAgLbuAcLuXfY0TK/IzKFBMIzEs0dYA9hSxMZvpc7DAmwvCSaGOBnZm2aqGqntiaHEa
 EAXh1vp6/WvFoOwW+2W73yvyvlZhHvS9ndm5E86TmG9hNUEfZcBNBVxwtEejQriLaMtUGHWPU
 QahhJ3WOXglBS/jPZniZeK86lEbU1YS67EMV8du2S7OOwJ67LbXZ90YscDqYy8GcvyAIwDjII
 5yKR3Xwh1QL8GaYkAyll7YDE/WOT+0AK772O5hxi02HskMikL7R2mLrtcw3BgGhSvMXC9FvPm
 V+SZSUMiLGkmKTuwlSDQq5nxITRHtVcGyqPrlbpsgX+kR5fncYu/vzItbo9YQm3Xb9ZddAVVp
 Baul/ynocWb+pTAUNp9dXjtcY5Z0kX7VgXlMILB020PIedhG0xjhURzXkuz5HyfCej8h+jQvJ
 NrD9rDv0syXg5p0AYpEXtjJ3u6BRp54yqA0AOd0bKoNfv1GqMhyeZTu3lxGEItQaIjdFEZ0lj
 dFmL/mRsckErJ9wiAFYcTHsfcrqosIcF4R1x9kBi1FbMPv+cDitw6KcW+yIweySAcrb4n5iAb
 VkrhJPoMPuZswYD1gZEEAdQXLbvt7dCA+K26H8O+d168LavFRZ0BawZWkpp/vDqwIDfn+y+HP
 eQkn5bBJQuJqs0KZ2SwQ6iQsrTtNllz+5yaeWLcMA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Nov 2020, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> >> IMHO, though, all of this is orthogonal to question of what the defau=
lt
> >> is. Unless we are thinking the basename thing would work as a default=
,
> >> but I don't think that resolves any of the backwards-compatibility
> >> concerns.
> >
> > If we think it would make sense as the *eventual* default, we could us=
e
> >
> > 	[init]
> > 		defaultBranchName =3D
> >
> > (i.e., an empty string) to request it early.
>
> I am not opposed to the idea to invent a notation that asks for the
> basename behaviour, but I do not think it is a good idea to use "an
> empty string" for that.  I'd rather see us use some consistent
> naming convention to denote any new "non-constant string" thing.

At least in the tests, using the empty string for
`GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME` is equivalent for not setting it at
all, i.e. to trigger the fall-back.

So yes, I totally agree that triggering an interactive prompt by the empty
value is not really a good idea (nor a particularly intuitive behavior).

With your idea to special-case any value starting with a colon, `:ask:`
seems like a saner approach.

Having said that, I would still favor the fall-back `main` over this idea:
it is a much smaller (and less annoying) change of behavior to use a less
loaded name than to change from a previously non-interactive to a
now-interactive operation.

As to using the base name by default: I don't think that is a good idea at
all. Not only doesn't it work when you run `git init` in the root
directory (which some people do, and that's totally okay with me), it also
does not work with any base name that isn't a valid ref name. Try this at
home:

	$ git check-ref-format --branch "My Documents"
	fatal: 'My Documents' is not a valid branch name

So while it is a cute idea, in general it will simply fail, and is
therefore worse than any alternative that does _not_ fail in general.

> What Peff suggested is a more viable possibility, for example.  When
> "[init] defaultBranchAlgorithm =3D <name>" is set, the fixed string
> "init.defaultBranch" is ignored and the algorithm specified with its
> name is invoked to come up with a name dynamically.  We may start
> with something like 'dirname' as the only supported algorithm but
> that way we would avoid painting ourselves in a corner out of which
> we cannot escape (e.g. we may come up with a better way than the
> basename thing, and we would not have a good way to give it a name
> that is easy to use if we wasted "an empty string" for the basename
> thing).

Indeed. In the spirit of minimizing disruption (as promised in
https://sfconservancy.org/news/2020/jun/23/gitbranchname/), I would like
to stay away from changing the default behavior _that_ much.

My current plan is to implement a warning in `git init` (much like the
`pull.rebase` one, which I thought would raise outcries of frustration,
but to my surprise this did not happen, and `git init` is _a lot_ less
common than `git pull`).

This needs to be done with care, obviously. I haven't looked yet, but I
think there is a chance that `git clone` would implicitly look at
`init.defaultBranch` only to override it later by the name of the remote
primary branch. In that case, we obviously do not want to warn the user
because the `init.defaultBranch` value is not actually used.

Ciao,
Dscho
