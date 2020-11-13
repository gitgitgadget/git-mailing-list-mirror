Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC22DC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 22:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6355420B80
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 22:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="C5OQ1I+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgKMWCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 17:02:38 -0500
Received: from mout.gmx.net ([212.227.15.19]:54321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgKMWC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 17:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605304907;
        bh=B2BLUJM4AG4OlRIqYeco2kc6fJkpDCOQja0C3SPNIfc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C5OQ1I+XS14lj52j5ucxzkV8w3xMHjV5RayCKzv7S1JistiTk0z1zaRInBKKvfK1/
         p6eIK3XsgCPOuVc0s0ZdzEnDg6jmDqMNZp6QAAYD2Lhmv/xzWIvHlydff6j2hOij5+
         XY0FzuNCUvBjUVOzFmUKM+GOU2jL6bgoihihRvpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRRZ-1knzrk26Qd-00Xsjk; Fri, 13
 Nov 2020 23:01:47 +0100
Date:   Fri, 13 Nov 2020 23:00:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default
 branch (sort of)
In-Reply-To: <20201113191418.GA764688@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet> <20201113161320.16458-1-avarab@gmail.com> <20201113191418.GA764688@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-78184385-1605304851=:18437"
X-Provags-ID: V03:K1:4V40vKBqKAzK4Fg16hImpjXsrDtdD1MBzQ+ckqDAq7Nujxdx96m
 9H9bgql0V3ncoZphikq/+B4ToPCLkyVOjRo3E7GCzAneBm0X4qg6WGu/IzcBWuV7FY5BCnp
 fwxGh1CEajJnlvzxKZVrrX458bZ2m+6ciQFJAozNWhGZDJ+xE7v9BioZ+DFLUhuYL2zQppq
 /qLz70pRglng6kUajEbfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HPZzdtm8KMk=:/fDAdamHSfrcrRHVEER45L
 3wlckd+cfQJuvXQ6pK0G21J5tEq2otOalZ4+sg/uchfmeKRMt5S1rlM8oWYwH5IARUdZYhx8M
 r+luyav1Xy1hgLS6pz1zgtZRUb2yIF7whNDs7hh0cr+mozZI598aHBp47oVT4QPRxxhRY+KoK
 XKmFOmLat9E3VGZNeNb+M/w+jGyh2L/DXJhBf9Ubzdvd7IgxU6Unq3EWorYFRmnA2cDnXVF4e
 10UtRnLF2FHt8m1zrkAZBh43Tl1gTbnFplT9dLVFQ0rZDBqkjWBtOuDuNijEgi5gOtmU4WE3+
 9RnH9V2PlsSfRt8/YbdBFzGcMlTg9HLIYVDK+HmUjaj7sT+4bKRBfmknQKKOUrTTzTUFMtQx0
 5PWHd3RCiBpf0DQ2wRDnJRcWB0VOGF7mLezDVaLe6NBvUD8qrRER8nu5qH18PQXdOWai9/6bS
 LcO/8FfHIojUVT/W0T0ApAOGRrB1t3yP83EGmXr3LSpcO7dvLn8z8IJEoaWxjHUrlY/fM6kCg
 RXXMraLvj5qpxcNINdzZiDMtZUCoWLHIB4sKuKijOkk9eBVoU9pyrUi/ksCcq+8uch5NyTL+4
 LA4eaLwcvsO4UKrQy3HDFWJXY8Sd6nSFYcTP7Lp7i+jrh0n4rc7OH1Tv+OzH1+5zj7a/AnPFw
 0CLS7dQ0ttR9CK85tptBJWrjW/qxXHh3Ppu54tws1QPEyqCM/nNvbMravxVa96R8iub/uQ82g
 KBOZaJvHjAC6GTwA/1Gq84455q/Bzd22stzCv/Fr+KHewc24j12kriyFslpGryXoxrQRca1hN
 vteJbkKwyjOqOcdW0dvEzXuFQfpGg9Hq4zqLAj9Va0YJ7yiR2t8BrWhhiaODqfWSPoOBkT9aM
 B3NoMbk6Zel5JbIL048Eq8799obuE/ugjAW0HMr9A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-78184385-1605304851=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff and =C3=86var,

On Fri, 13 Nov 2020, Jeff King wrote:

> On Fri, Nov 13, 2020 at 05:13:20PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>
> >  * A lot of tests (but a small minority of the total) have master
> >    "master" hardcoded in some way. We now inventory them in
> >    tests-that-need-master.txt, we can still remove the names from that
> >    file and manually change the code later, but this accomplishes a
> >    clean test run with a relatively easy-to-review diff.
> >
> >    We ignore GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3D<name> when it com=
es
> >    to these files, unless
> >    GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME_HARDER=3Dtrue is set.
>
> I'm confused how this is better. We could just be setting
> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME at the top of those files, couldn't
> we? (Likewise, I think annotating individual scripts is more
> decentralized than a magic pattern in test-lib.sh, though it amounts to
> the same thing).

I considered this alternative very briefly, and rejected it immediately
because it would have implied a drawn-out limbo where the test suite will
be inconsistent. That's not what I want.

> And if I understand the current state of Dscho's patches, we don't
> _have_ to convert any tests right now. We could just annotate those
> scripts which are not yet converted to have them use the old name.

And that's what I did in some cases, see e.g. 5d5f4ea30de (t5411: finish
preparing for `main` being the default branch name, 2020-10-31).

It's just quite a ton of work to do this for all the affected test
scripts, and I wanted to automate as much as possible of that process so
that it'll be easier to cope with all the other topics that are in flight.

Therefore, I opted to "annotate the scripts" via a `case` in
`test-lib.sh`. It should be quite a bit easier to understand, too, for the
occasional reader, as it shows you the complete range of scripts that have
been handled so far.

> But I don't think we want to live in that state indefinitely. It's
> slightly annoying to have inconsistent naming within the tests. I'd be
> happy to switch individual tests at a leisurely pace over the next
> couple of months or whatever. But since Dscho has bothered to write all
> of the patches now, why not use them?

Yep, I am a bit puzzled why we need to consider other approaches. I would
have thought that the more pressing issue is to verify that I

1) caught all the necessary conversions,

2) did not miss any non-trivial adjustments (such as `naster` and aligned
   comments).

At the same time, I am quite thankful for all the help =C3=86var provided;
mentioning that I missed `naster` in t1400 was definitely super helpful.

> I'm much more concerned about the lack of documentation changes
> associated with the final patch. We don't necessarily need to eradicate
> every mention of "master" from the documentation, but I think we do need
> to make sure that examples and instructions are consistent with how Git
> will actually behave. And that does need to happen at the same time as
> the user-visible flip of the default.

I am sorry. This is totally my fault. I should have described this much
better in the cover letter. This patch series deliberately omits all the
documentation changes.

I _did_ prepare them, they are pretty much ready-to-go, as part of the
`inclusive-naming` branch I track in
https://github.com/gitgitgadget/git/pull/655 (I use the branch name
`use-main-as-default-branch-name-docs` in the `inclusive-naming` branch
thicket to track the documentation changes).

The decision to separate them out into their own patch series was made
consciously, to avoid having one big, honking, totally unreviewably large
patch series.

Therefore, just like I fed the preparatory patch series in a slow cadence,
I planned on feeding the `-docs` patch series once the dust settles on
this patch series (i.e. once it hits `next`).

> I'm on the fence whether there should be a deprecation period or major
> version bump for the final patch, but making the tests flexible enough
> to handle the before and after state seems like it can be done uncoupled
> from the actual default-flip.

Hmm. On that matter, I wonder what the big fuss is all about. It's not
like Git is forcing anybody to change their default branch. That's not at
all what we're doing. To the contrary: _after_ many projects chose to
change their default branch names, and _after_ GitHub started to follow
that trend, Git added support for `init.defaultBranch` to accommodate that
use case better. So in a sense, we're actually pretty late changing the
fall-back of `init.defaultBranch`, at least from the perspective outside
of the Git project.

There have been plenty of articles about this in the meantime, too, and
I could imagine that most developers are at least aware that the shift
away from `master` is happening, in many quite visible projects.

So to me, this whole discussion about whether this should bump the major
version of Git seems a bit overblown. It's not like the median developer
is creating new repositories on a regular basis, and if they do, chances
are that they go with whatever branch name happens to be the initial one.

What is much more common is that developers clone existing projects. And
guess what, many of those projects already use a different default branch
name. And developers seem to accept that and just go on with their lives.

If it was up to me, I would reserve a major version increment to much
bigger changes.

Ciao,
Dscho

--8323328-78184385-1605304851=:18437--
