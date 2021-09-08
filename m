Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA16C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04D5610FF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350342AbhIHTYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:24:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:36759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350096AbhIHTYd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631128993;
        bh=IfZzVnPzxr4c2jceeKWhQW02X2Zar+j52fbuUL5RbxQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PUESXDPoCUaONX2nR2HVZpuJuW1fsneFu2yOut9VJTrhnCtCn6pHmywoDVxFMvO6e
         TyPBlT/JIG8rGkzZqX6rYIeERiJOFd0ghEr2dDHufr8JqwPpx9FK6pzcSkWfSeOoiI
         dthrqHbCmQGB43/JFdxJNJp4vDlX0cRbxY4CyMZo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1mTwSk2cf1-00WmTs; Wed, 08
 Sep 2021 21:23:13 +0200
Date:   Wed, 8 Sep 2021 21:23:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 08/15] scalar: implement the `clone` subcommand
In-Reply-To: <8735qipkqd.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109082112270.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com> <f3223c10788fe836d0322006dc2dcbafe08f6b5b.1630691688.git.gitgitgadget@gmail.com> <8735qipkqd.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2103751648-1631129011=:55"
X-Provags-ID: V03:K1:MXEFvnNe7IucCMZyFl1826J9m05LgGhibDL0o+2oVqvGDll3XCe
 B/71hZCx6feg+vKXGwBpNbwUfzcz6IUCWBUlEO5h9WAsrZ9bPUxIFYApwzO4NeayzDCK7Ng
 9hH0Ws7/JSURwzAq75Ekd1Q50xIIt42tRA5H+1NWi6eiiWb/ic6p7nEjTd8gtQNwrKOs5H8
 VACuMxyfvHjws+jyHbsUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bjWDYNdNzTo=:7O15wxs8wqjT/l4noLaf3Y
 es/Yl+qkgd+i2+MWY5kYefgTDx+afj6ZvpuzPZ8jOvfwaaw9zQS9H+azU+t+6+DVhSRM7o+ON
 ifEpkDn8vy3AnxeSQp5gsQc3d6vDvohayTuoSE1jdFDQx0ZsgounuMMDeqLWbkPtrpqYygyUl
 ir54azRGwDDAVv24FPL7WE3hAq2wARpXIl1Lr8x2Qz/RSExIqtn3JJMtB4ET+S+9VnUKiN2o4
 37RURjPzgtxOXrToUtpNmtDW+5a+RGkRsolNMXvwIllj2ote501A58gNxhUKce64o5er+PfKA
 oYuIKNiRZ8VBs37tMtE1NULu4AjxMtR9O8ri3HU62tw3x/dJlrMGAFQEs+YIBashrAiTgKS17
 NtVBig+PZNWWLQozYknu6XW9Tw8ED9H6s/oyEeD/od9GD8+WJruoX3+vYjxJarvdYK/YHndQB
 Me87i3WFcgVYsFOq6IBl8Lmk/i5ZZ27DodXadmUB7P27sAlHO0vWuRiB4zoy0Fgzgum1PPMUE
 1GIDiJWy72+y9bS3KKpOjn0GGOTl2WOKBasiPTpnzfjkN48EgVgC/0E4K9IW9QkreG68d8ieR
 Qaz33FiD44zVNrdEmups12cgJh9w1bw2c1CMNK5x0cmTgmcYHiNhKOsxYZdc76bGAZHNqjgK6
 eLm32dyndofbbVG2EqfCjuTJmAdx1TJTqdjlUrslu47uSBj2/GAosUv6Pmv9B/bIIbtAU8YJH
 CcLKWSiAq/MlaDszpEi5p2mUdqbtrvfZD11hUkh3M/nwVVwwLs6iewfGA7PGoniU9BflCAvDw
 EVzL+tpd4iM43fbj4uGl7ICrjhAoLZ3jzBdNzT2rrLTflZ81BDfThDArntPv4HVOng+9kKkU+
 EbhpwJdD2zna19+dolO47CHV0FSvzMXPh0sgHte8rqNEv5q2uhjX9uHGVTpiT2fmPvsbTWRgx
 xPJt8EDWC0gnL0/3WPdj6k3j44TIlUgxgKhJ8wmP5nlZTfM4NNgLrS4WzN7qrnXMmPc+r3xW0
 CUwNLbmcGEpx2HdA/ypoNRoi1FwwYPYViKS5bwAk12NLs/t4FcZBFeYVXCdKsnYog0F5ndTkT
 9b+OLQQNFrlSc4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2103751648-1631129011=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 6 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Fri, Sep 03 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This implements Scalar's opinionated `clone` command: it tries to use =
a
> > partial clone and sets up a sparse checkout by default. In contrast to
> > `git clone`, `scalar clone` sets up the worktree in the `src/`
> > subdirectory, to encourage a separation between the source files and t=
he
> > build output (which helps Git tremendously because it avoids untracked
> > files that have to be specifically ignored when refreshing the index).
>
> Perhaps it's simpler to just say about that /src/ injection:
>
>     `scalar clone` adds an implicit "/src" subdirectory to whatever
>     directory the user provides, with the added stricture on top of
>     doing that with "git clone" that the "src" cannot exist already.

It would not only be simpler, it would also skip an important point I
tried to make, namely how this _differs_ from `git clone`. Rather crucial,
really.

> ...
>
> > +	if (is_directory(enlistment))
> > +		die(_("directory '%s' exists already"), enlistment);
> > +
> > +	dir =3D xstrfmt("%s/src", enlistment);
>
> Which also seems to suggest a bug here. I.e. if I "git clone <repo>
> /tmp/xyz/abc" and Ctrl+C it we'll remove "abc", but leave "xyz"
> behind. Since we're creating that "xyz" (or "src") implicitly here an
> abort/ctrl+C followed by a retry is going to run into this error, isn't
> it?

Sure, it's just like calling `git clone <url> a/b/c` and upon failure
seeing only the `c` directory removed, while `a/b` is left behind.

> I.e. it seems what's missing in this state machine is checking if the
> directory was there already, and if it isn't add it to the existing
> atexit() removals.
>
> Which may be tricky seeing as this is shelling out to "init" then
> "fetch" etc, i.e. who removes it? But maybe not.

I would rather spend time (after this patch series landed, of course) on
teaching `git clone` to handle what Scalar needs, and upon Ctrl+C to
optionally remove _all_ the directories it created, not just the innermost
one.

Then we get that functionality "for free", without spending a lot of time
on code that will be obsolete soon enough anyway.

Ciao,
Johannes

--8323328-2103751648-1631129011=:55--
