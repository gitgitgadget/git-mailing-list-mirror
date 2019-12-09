Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E9EC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 09:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5982073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 09:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="COsJiNgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfLIJ3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:29:11 -0500
Received: from mout.gmx.net ([212.227.17.21]:51799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIJ3L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 04:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575883732;
        bh=Mw12Kjgf2O4fZwHMOGlDahxy8/bUVIYFCubjA36YUnE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=COsJiNggB9Jn/rIiZsUn9Llys2XAoQSnEs/fPfX+PEVSw9wNMuKGUstwXOcNCSl7E
         IwHUgbWGOoWPASk7l8cDMVfKb6/XUp0rdw/ndeePKN9LXitjwZZLhHrYlTEv2Q62RK
         De73Ye/3w9VFRnku1cwJNWKR3rBgubCbnlhg5YvE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvLB-1iD85Z0KKz-00Rs2h; Mon, 09
 Dec 2019 10:28:52 +0100
Date:   Mon, 9 Dec 2019 10:28:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
In-Reply-To: <20191209061853.GA38588@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1912091023040.31080@tvgsbejvaqbjf.bet>
References: <20191115141541.11149-1-chriscool@tuxfamily.org> <20191115180319.113991-1-jonathantanmy@google.com> <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com> <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com> <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD20LMxuV7KWAvobybHYZruDiADX-yOFPLyMxsHS7HZN0g@mail.gmail.com> <nycvar.QRO.7.76.6.1912072145290.31080@tvgsbejvaqbjf.bet> <CAP8UFD1rmv7dvWBe5=dnrh8icfsE_PWEukmuUmqB9dWJ9NQTkg@mail.gmail.com> <nycvar.QRO.7.76.6.1912080942360.31080@tvgsbejvaqbjf.bet>
 <20191209061853.GA38588@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XRW6m2JAM8PVKp0pcpWZlSxRTt1Vtl6AOYGSfHXJ5RI02qYxenM
 aG6W11Qp4EjaUPgqWku81+VQFoAojKbLjIYSIC6Upn8NZw/JlXNtYihs+U+gBMrzm2gs230
 FBF7kKBCKLCHyt0q565VZO9WlPbYqs1hnce5qe2qj2gI217cVX7Id7QA7U89Oz64ugW+J+S
 4M7lfJTALVS+66aMtLGKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MmbV+li76fE=:kCdoZZZdGOioUSNgHaS72/
 ROf0A964y6k+HBET0npj/BR3zmZGSKjZ84CS0zXk7fpxmYiNMEjGoa37UyQnQqnyumjC+K+eJ
 0zi/ewNSzHAzz91FRjomeEibYRAqKzFxH2kroxQMZDkaaWVAUzrgxLW9as0ZUwWWeWPd+0LWQ
 TmfrJaz1XYApLh1kx2cSez5S3pWUN1cNPEc2DNp3zTZI3qQ2f3lJU+OvTiRiqrgMjaK+mmj2q
 qIuvnSMoUpv4b9+G9aEtr6Q20tOKgcuDmQVdM7BIUmWRxBF2k3RoCrGAaQk1DvgUDoU3aC4bD
 f6t4IwgHt/AWYXg3hQXxpBGKCD/FPuc9s/fHp3ZGGW4M6n3b7/wKClOIHpUh+b6SIVTsBinPK
 y8ErvIeCXO2bHdpQt7DmEh34k/H6n8p++vof3Oc3QnyLaLHy887/qIFHkL/HN9rtU+2mea1dw
 G+PStOvPZ1A8fEOuxhI/qKky8zylpyW+GpZkE0uiWRpCwkqCy2R2qjgOcAxJRHE0uzh+l/SEv
 SJs+OqhtLtvXhjDleG9h+W0X63YG8blKqF4ZK+8bXymuyUIUrXvKV9TwHYeyDJvFVaWgZOyuy
 3/UHMig1Z6ZuZC5QHogSFPaZGa17yhGP5BkFoPYBTtwu3ooS13Xh2cMASr1o9pZ29jXq3XSO7
 S8ZP7LccL1Fwl7JVn9APno/GKRcQG9ZeQ6FRJXco7N3+VgjkFwWMLk35YUqdC5oBybf+5KEC4
 tfoGJuOlohMDwL4G9i1VWn6m82SBFI3WONGsTylohRg3LiNx+nj/4KiTrzDfm7KCcvkxrop5K
 oqre3e/BjYC66al20pCQnIuZcZiiZkGI0sa/14M1omQugfr4wZeVB8caq+2PirrxS9FZFGEAK
 Iw7tjS24puBf2qT2ZDS39jst2hDGhc8J5arwAhrHhXNx7JD5OKMwMfLmNtoZj9juW+qgfm7no
 C918PG0WStrT2bo040f9S/PlolStw+l0FYVZ88czLCxjppZkDYoEstn/AhhU0QbrDT/bKWqc7
 iYj5sO97J5XLh3ayBhOCyB0f0D8A/v9vN3O8/s2mmu/3cEtxsrarDI14fAob9+FrW2gvkmGcu
 WA5ANVYChvbkWv0lIPvWDsmKjzG8zOPGRBkfqH+owa9uek1yJqaAOUsZCe3jlzBFBEghkeQ5k
 Rkk42JVAFY8daJGW0E9aCjvLaR1w86o1YXL6eVVQK3wv9wSe6T6HDOwdMFnMAbuqvO53g65zg
 gKmilu1i0ZvIkYZHdHFNRmcg3ruPKiULxo9k2Qljr+CSEwzdPhM+RZTaf1sQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 9 Dec 2019, Jeff King wrote:

> On Sun, Dec 08, 2019 at 09:54:01AM +0100, Johannes Schindelin wrote:
>
> > > That's why I put Peff as the author of the patches.
> >
> > No, that is not the reason. You might think that that is the reason, b=
ut
> > the real reason why Peff is marked as the author of those patches is t=
hat
> > he really authored those patches.
> >
> > In light of what you said, I don't think that it is a good idea to go
> > forward by leaning even further on Peff. From his activity on the Git
> > mailing list, I deduce that he is not exactly in need of even more wor=
k.
> >
> > Instead, I think that if you truly want to push these patches forward,=
 you
> > will have to dig deeper yourself, and answer Jonathan Tan's questions,=
 and
> > possibly adjust the patches accordingly and send a new iteration.
> >
> > I perceive it as very unfair toward Peff that this has not yet happene=
d.
>
> To be clear, I am not bothered by this. And in fact I feel bad that I
> promised Christian that I take a careful look at the patches again, but
> haven't gotten around to it (for an embarrassingly long time now).
>
> Now I would _love_ if somebody else dug into the topic enough to
> understand all of the ins and outs, and whether what they're doing is
> sane (or could be done better).

That's what I thought.

When I bring patches to the Git mailing list, it means implicitly not only
that I understand the ins and outs of them, but also that I am fully
prepared to address reviewer comments and send out new, enhanced
iterations.

That holds when I send patch series that include patches authored by
someone else than me. I thought that that is kind of expected, otherwise
there would be no good reason for _me_ to send those patches, right?

> But barring that, these patches have been battle-tested for many years
> on GitHub's servers, so even if we just take them as-is I hope it would
> be an improvement.
>
> Fortunately I have some other work to do that I would like very much to
> procrastinate on, so let me see if that can summon the willpower for me
> to review these.

Heh, I know that feeling.

> > Well, you have time enough to send lengthy replies on a Sunday morning
> > (while Peff apparently did not even have time to say that he lacks the
> > time to work on this).
>
> One tricky thing here is that I leave messages or subthreads that I
> intend to act on in my incoming Git mbox. And of course as time goes on,
> those get pushed further back in the pile. But when new messages arrive,
> mutt attaches them to the old threads, and I sometimes don't see them
> (until I go back and sift through the pile).
>
> I wish there was a good way to have mutt remain in threaded mode, but
> sort the threads by recent activity. Setting sort_aux=3Dlast-date kind o=
f
> works, but last time I tried it, I got annoyed that it did funny things
> with the order of patches within a thread (if somebody replies to patch
> 3/5, and then 2/5, it will pull 3/5 down as "more recent").

When I hit such a situation, I usually go on this kind of insane
side-track to figure out whether it would be easy to fix this (it's open
source, after all). Last time I tried such a thing, though, I had to admit
that it was not easy (but I use Alpine, not mutt, out of sheer inability
to adjust my muscle memory).

> Dscho, you may feel free to roll your eyes and mutter under your breath
> about email if you wish. ;)

Done.

;-)

Ciao,
Dscho
