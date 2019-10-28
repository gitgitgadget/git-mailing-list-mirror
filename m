Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14D11F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 16:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390786AbfJ1QGJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 12:06:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:57757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730627AbfJ1QGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 12:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572278755;
        bh=aTUwWXsQ0cM4QsHga/a2HWhEWtvmkoRSCWpxXyJO6tY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R1+eaSZUKR0l1yG3qMk5uW0bhmYyUJLffrm5h9oLq+qpcBe/2Uh6l0wPvoey3XMON
         xhYAICudqEYMDkYD5h++5DLLWrp6O3rTkpjjWGBz0IcYglITbyB614OMyOe9Vkit/2
         V2pK8flMUySR5/CoBInx/d3+HBqOHoUYdg+3ey+Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSbxD-1iZxGs0wpd-00St2z; Mon, 28
 Oct 2019 17:05:55 +0100
Date:   Mon, 28 Oct 2019 17:05:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
In-Reply-To: <20191026213648.GA7331@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1910281701430.46@tvgsbejvaqbjf.bet>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com> <pull.407.v2.git.1571755538.gitgitgadget@gmail.com> <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
 <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com> <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet> <20191025221118.GA29213@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1910262040360.46@tvgsbejvaqbjf.bet> <20191026213648.GA7331@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1973625787-1572278755=:46"
X-Provags-ID: V03:K1:pt/O9xmG0T8p9ov73HovB6pkKSIyJynrKi66ySrXutgDjghoASr
 HvWCrF/Mn4VF2cLZ4QNd8uZ9M/H2B1KgYiWHQEslkUoO9CNDpES6bJgUDmwy4Qlx1bjAlSI
 RrBh+Ftl1u1Zduxnd03pU4k773/prTmZbRebsMcz+IOHotuHO/SXyb/Nra+CCszEjSIVUrH
 H+lQm/vQIDGl48mBZjk1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/8CmyEZXCNg=:yas4xCRhFHWcb0Fo2qG+up
 95pA/HY6RWmuaaQXbl7AwzESdApq+TgoACyPhspU6XSBucsJamJjnM8gOY7onIKQ6YlHrTkIi
 7I8iqvIdBlqqATnmnA4m713NSycwsHmE3Iw89459zc105TZ3GwwJ3b6dQNQKj8xv1tCd7WARS
 qWf2NAdHS6jKBqmPodQ2BRLM29jfJ5dBLmudenWepc9bZgaMH/Vdyj0MbLNK3DUc2vvJjsY4j
 RHefSZKlGm761xWb1W3RmwLDVD1fWoiVHQHYa+duLa8/WX0hngXIBUjjsJXNCTnBUFaginhJc
 xM2HoLP6kGt4Bbkdf0LgdpHc864Yqt0AbFa5Nxjh9NWsWSCgmSE5ViKol5HsQOM8sPV68oKKq
 vAExGpPIK9fwTX8QSF/wWrvp4gfCtwWY2m6a6P5/ZtavNfcNSF+U24Ha+0U5VHK5OwRTSWKhy
 d+JALUhFeNbvrbpcrXL0SrRPU6unWUtDUMOQrhEbNMwZsaWDMQ2sb+5gVn9gseX+6ZsOICRGv
 m8Rd8kezDYjwfvj4jTyriLSeSeRHN5Q+IbXT3WTZ8nEdXR6StPr/TTi4O2Qw4CdId21t7AcVX
 HZSWXK/csnPthU4GQISx42hdgUvEKuSzX3Vx4z82ADbZU1w1AI0C8f74TKCLcdqGaAu4nj/fd
 eR53N805Q/pFbERXWPb+ZXAJ8PiEa3FCElGrvbTLbNLRcbzJKvWPKl6uwKascTBfzD6LYwSrj
 tCAXg89yROa69ZL77MnL/6/Z+LC8flJXYxUw+d3fA9lC+IjgsDsOzIfq+4OkQk3nMlWzbPycq
 SDKBDncwtboznxX+/qMRwNIWFfRi6FcH3BTwDn1g17ERYwIDCV/h8Kzz7a2dR0lZ/YhQV8xP/
 Tujf1mJCE3JHS+eSq8LoQEUjA2AeZEVCEtZcfQSGGBSfRbH7FSY1iP1idY7L1AV0WW9eQO6CC
 whbZM2LPD8l00ndr/W3FVyF0lPOKnvv85DflcIXL+kRtJAgaF0Sr7BOUpyPBdokaD6glNePuK
 GQyQtfotdxruUyKo5mhDsPAHQp2T61cF7Wh78RzgjfIZtKNAoTOdrv/Ql5+JWrhTTsK1YlYrr
 qsNsu3n0CJDjsYCKx2jAWQ632GPJJLerKTGlGTEq2wjCaEC8IIBZOEColcjHZKD6RXEowu8ZT
 daB3KcDmBSjGLAaz0C+nEwo7UnFJ8EM15JDtjObE/uzvjoxT0Q6q5vDHZswecA1TbAwZ2NTj1
 hOug624JLzN0VXNk+KswVZfzXx5M2LDBa0UzcxfR/x84jFw6mf/Obbk7aarI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1973625787-1572278755=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Sat, 26 Oct 2019, Jeff King wrote:

> On Sat, Oct 26, 2019 at 10:56:45PM +0200, Johannes Schindelin wrote:
>
> > Back to the issue at hand: I did open a GitGitGadget PR with my propos=
ed
> > change, in the hopes that I could somehow fast-track this fix into the
> > CI/PR builds over at https://github.com/gitgitgadget/git, but there ar=
e
> > problems: it seems that now there is an at least occasional broken pip=
e
> > in the same test when run on macOS.
>
> Yes, I think that's another issue in the same test. There's more
> discussion further down in the thread I linked earlier, starting here:
>
>   https://public-inbox.org/git/20190829143805.GB1746@sigill.intra.peff.n=
et/
>
> and I think G=C3=A1bor's solution here:
>
>   https://public-inbox.org/git/20190830121005.GI8571@szeder.dev/
>
> is the right direction (and note that this _isn't_ just a test artifact,
> but a bug that occasionally hits real-world cases, too).

That sounds good! I guess I should continue _that_ thread.

> > There _also_ seems to be something spooky going on in t3510.12 and .13=
,
> > where the expected output differs from the actual output only by a
> > re-ordering of the lines:
> >
> > -- snip --
> > [...]
> > +++ diff -u expect advice
> > --- expect	2019-10-25 22:17:44.982884700 +0000
> > +++ advice	2019-10-25 22:17:45.278884500 +0000
> > @@ -1,3 +1,3 @@
> >  error: cherry-pick is already in progress
> > -hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
> >  fatal: cherry-pick failed
> > +hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
> > -- snap --
>
> Hrm. I'd have thought those are both coming from the same process. Which
> implies that we're not fflushing stderr before calling write(2). But
> your patch seems to do so...
>
> <scratches head> Aha. I think you force-pushed up as I am typing this.
> :) So I think that is indeed the solution.

Yes, sorry, I had this idea and it worked locally, and I wanted to know
whether it would turn the PR build green.

> > So much as I would love to see the flakiness of t5516 be fixed as soon
> > as possible, I fear we will have to look at the underlying issue a bit
> > closer: there are two processes writing to `stderr` concurrently. I
> > don't know whether there would be a good way for the `stderr` of the
> > `upload-pack` process to be consumed by the `fetch` process, and to be
> > printed by the latter.
>
> The worst part is that this message already _is_ consumed by fetch: we
> send it twice, once over the sideband, and once directly to stderr. In
> most cases the stderr version is lost, but some server providers might
> be collecting it. I wouldn't mind seeing the direct-to-stderr one
> dropped. There's some more discussion in (from the same thread linked
> earlier):
>
>   https://public-inbox.org/git/20190828145412.GB14432@sigill.intra.peff.=
net/

It is tricky all right.

Full disclosure: I am mainly interested in having lots less failing
builds (which I all re-run manually when I see that a known-flaky test
failed).

Ciao,
Dscho

--8323328-1973625787-1572278755=:46--
