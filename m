Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9367CC38BE1
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D5F2080D
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aLRoBDw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgBXS6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:58:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:50285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbgBXS6p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582570720;
        bh=lA9xXv+ehKymK2LwbHqMk3uyBs0dfm3U2kHaLSKvzgE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aLRoBDw4UfkGe+t2xSyeAfHBPPSWkKfJ2Kudaq320MYCvtIndRFmVQzB/k0fJOSRR
         VoT/jpa6R2wlvppJ3prFa1NT5Ik6Yr7tEzDJX8tN0p6DALHxrh/touLZc8wLabyEss
         9J2KcptM/7HT4drrpXErfhnBScaMeVMNK5ONPOAI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1jbUxd1YbR-00e8HL; Mon, 24
 Feb 2020 19:58:40 +0100
Date:   Mon, 24 Feb 2020 19:58:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Hariom verma <hariom18599@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] get_main_worktree(): allow it to be called in
 the Git directory
In-Reply-To: <CA+CkUQ8ZsxesE=d+DQ+67SEHPJXdHjbSKhWeVifPeKBymqy8pw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002241942120.46@tvgsbejvaqbjf.bet>
References: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com> <pull.535.v3.git.1582484231.gitgitgadget@gmail.com> <8718facbc951614f19407afa6ca8d6110507483d.1582484231.git.gitgitgadget@gmail.com> <CAPig+cTh-uu-obh9aeDOV9ptbVwRmkujgucbu9ei1Qa3qSNG_A@mail.gmail.com>
 <CA+CkUQ8ZsxesE=d+DQ+67SEHPJXdHjbSKhWeVifPeKBymqy8pw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tFRdGQ5FQBrMJaisr3Eacqo7WEIpz/ie4HGOzQjiBvCdueOxOms
 6W+GeIr7qo3qMVm8l3f+rL8C6/v4FTSHyLxCG7TZhC2d5xJcacIfXEXHXH0gGpLwt133ajG
 +5J6ub7xeuZAV2XG4FPLLJOm2c+0VaM8k/klyHQ95unyU2+n8WWTVRJi2b7VgkfR7riAzUN
 CohKx4WRDgWXH3sIEUzOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LyRDLAWbE1U=:/qrijGCD0PhgYvRHQe/c3g
 RueI/pNGIbG8DuC/eUYh65MSwdtvbl8BOdZLGi74Hv6gJE120JphnxUdhMuqNjvnbvkdwV/k7
 owKP08GE+X2ypR5B4YUQux01XGlZ/v/KbC8bOrGPpWRMGogc1pEtZ/ZFCRETJYuY2XoYevx+Z
 qh9MZheaobfl8UNpyR2qPPi8clDdwnjiAuBpXJDWgYTg96v4JK/TOslngZvNUsjKSnEZ/uRFO
 g4qk9yqE3NWAOOnrlztxpRf71dvKihZe+0qyIlIPsAADg5rQ97RNQ1K4jOPQZfQJqokfZAm8U
 Wrc26tNb1AFMdY/Nc/5RlHBIihstG3vDm+E7WX6FprgxNg5Dz3+0Wf4E86TzqPFus2r1ZVZkx
 ERY3o2We0yTd0A1vCD+tu6HhSigZE6748/AFHsW0+SUyhAt8VfFvjQmfbnJ9QQa1A+Wrly+o6
 lE8gNlkN8Pv7fMOkGCAy49iX5sioDMaZ7+Am7NbAF8DzDL118RI3/QbzU3xCRFfR8RuCXEW1j
 U25ByU440qnImjpy1e09WKKHrLLmuOCjWvTlRObp3j24ukDQOfjx7IendbRHe66IbVztrjKzf
 b4/h18xngwLxI4q7AkQWLDF6cEJAqNBHAxVLt3s3Q6tXB21MPlKgFrVv1VDhVuGnyY0YKiHnp
 84wn1dgMzqUXE1ozgERjdwgxG1CADQmnpmPs2KIhjURO3K8S+V/M4NFA76RG4YdsL2lgOyBQB
 vIFHInICWIsF+UXcEfKIkrKD4vBBb0naKMXgGyS2rmHH1HvVYf5fpeoj9wb5XN+QoI8y6A0uG
 0bC5bs4d02K6y1o3avewkodzTOq9C+eYNQM4iylwLccKhdoeo//9Y2NfjQ5uL2nJtPbzh4tDy
 LJ6iECEgs0ieJEhalCQcgEKVen2MFcjc1AXlrNCnindxRINL7VVN6w5rbY4aW4WOSBkKcCUSX
 90TajrmHvAHYnti0Bn2jA8YZe9IndBtnZ3mwi7hd8XIIeJOqipJ4xGupqXk3IUbNqh7FB1Nfp
 oS8MbwqvHJyVGAixgBNTmHDXf0pOglAVpLqHqB8ktwjR7XCaW4XbrLR0Lb0UZVzpa1YSqPj29
 4SKOL4CiBLJZI7g/c1Zpx1YFaAGAeXFzCARABGSL3Q2GEGj0J4oQCny9BYg7RBOEenNa2/gX3
 kXg0XWNEpNYuk4wUBJrEttu7aeFPP1ktuAndu6exALrt/AC/SsyS/HZTYzFLPuzYfsYWi1MF7
 9f3XF7/xL9yxmiS3j
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 24 Feb 2020, Hariom verma wrote:

> On Mon, Feb 24, 2020 at 7:12 AM Eric Sunshine <sunshine@sunshineco.com> =
wrote:
> >
> > This title is a bit too generic; it fails to explain what this patch
> > is really fixing. Perhaps:
> >
> >     get_main_worktree: correctly normalize worktree path when in .git =
dir
> >
> > or something.
> >
> > "Git directory" is imprecise. As a reader, I can't tell if this means
> > the main worktree into which the project is checked out or the `.git`
> > directory itself. Please write it instead as "`.git` directory".
> > [...]
> > This change makes the code unnecessarily confusing and effectively
> > turns the final line into dead code. I would much rather see the three
> > cases spelled out explicitly, perhaps like this:
> >
> >     if (!strbuf_strip_suffix(&worktree_path, "/.git/.") && /* in .git =
dir */
> >         !strbuf_strip_suffix(&worktree_path, "/.git/")) /* in worktree=
 */
> >             strbuf_strip_suffix(&worktree_path, "/."); /* in bare repo=
 */

I would be really cautious about that.

To me, the originally proposed change says: strip `/.`, if any. Then,
strip `/.git`, and if successful, strip another `/.`, if any.

That reads pretty fine to me. It makes sense.

Above-mentioned proposal, however, puts quite a few twists into my brain,
as is a "if neither X nor Y then Z", and I find the code comments outright
confusing.

> I'll implement these comments in the next revision for sure.

I'd like to suggest taking a step back and reflecting whether _you_ like
the suggested version better. It is just a suggestion, after all, and if
it was up to me, I would argue against it.

> > Also, please add a test to ensure that this behavior doesn't regress
> > in the future. You can probably test it via the "git worktree list"
> > command, so perhaps add the test to t/t2402-worktree-list.sh.
>
> There already exists tests in "t/t2402-worktree-list.sh" which lists and
> verifies all worktrees. Does this make sense to write a new test that
> also does kinda the same thing?

The scenario in which we found the buggy behavior involved calling
`find_shared_symref()`. I imagine that we could use `git branch -D` inside
the `.git` directory for the new regression test.

But yes, in my testing, `git worktree list` and `git -C .git worktree
list` do show a different top-level directory (the latter shows an
incorrect one). Such a test case would find a splendid home in t2402.

Ciao,
Dscho
