Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C717C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 08:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E45206D6
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 08:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Y9760Bgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfLHIyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 03:54:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:43801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfLHIyl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 03:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575795259;
        bh=Y6JVmC9GhH2IbfsvoaQi3DoyMHU5HdYNlptBWvTrYow=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Y9760Bgx9T0OqDMqMyQvtZbau6z3pH7nOSmGVI+90s7GzRYROOM1lzb1TwXpTo2vz
         +TIaCru9BztNiuxbv6KROsk6JtUC+Rm0aNEr+YbBY0KoEboyvxUos5wSMYuHJF2GAP
         R/uICzYp0GjPWPTPvulkQs9uOhpghMte/wIphH4M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lcJ-1iehPU0Zxj-000s5p; Sun, 08
 Dec 2019 09:54:19 +0100
Date:   Sun, 8 Dec 2019 09:54:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
In-Reply-To: <CAP8UFD1rmv7dvWBe5=dnrh8icfsE_PWEukmuUmqB9dWJ9NQTkg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912080942360.31080@tvgsbejvaqbjf.bet>
References: <20191115141541.11149-1-chriscool@tuxfamily.org> <20191115180319.113991-1-jonathantanmy@google.com> <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com> <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com> <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD20LMxuV7KWAvobybHYZruDiADX-yOFPLyMxsHS7HZN0g@mail.gmail.com> <nycvar.QRO.7.76.6.1912072145290.31080@tvgsbejvaqbjf.bet> <CAP8UFD1rmv7dvWBe5=dnrh8icfsE_PWEukmuUmqB9dWJ9NQTkg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OIeXnVmwxMkDK9Owcpe30LYCAGI01h04ANNLo81plIJuSw6VU1v
 KoUdqloMfjuoxFNG5S3g0g8A5gs92Su444qXrSoyqloKsMGSIsIQ58wTuRuJnIbCr8ClW3g
 AEWsgIprhGrDwLI7ZnATrcw1eWgWi4rW6OOmpu8FgMNVf9pFUl/kXfsQIVSWBiXB7VaCiP9
 NqEgMUoOk+zRHGI1fk0dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9oZsUKQqenw=:MNhLmp8wZN8R+aqDzc8fbo
 PdeAfU2ZwQEbh7JdXRIXJrk6GT6kTQTMPwxcU8ac3EXJn6OndmaYUWhY58VzMCgW/bYBG/hrj
 fYAJLYiRmBJtGbGFCdNssKCTMV7ghi40ZTTgrP4rvIu0g9zf8DAWPX039vYdAbYu7YW5mGEnh
 qW4FmJp9kPGDxzR6wq59/WVJqu9wfvdBfHh83CkEMm3/4oRn2TFZtz2MCeYMeZ7DTLbqSWjns
 wZ7sXOG9DfUW10NOPebm3EQ9YlIAEiaIzx9hjh5Q/oCthQlRQVCRhr+o+47DUX/K7vE7QwNmX
 OHGSFNB+6qvE7bFMv7RKklgI4QSN7Rot86b5uzSYIAShdfniQ7zB7ZD6aZOuZrLtr9amLcFui
 CzClifVT3FCp0FTZbOgzoNbRr8BIJe5MFFs+GlKwt0t5N8jyoOux7PS6ogYQecU9TBLvscAfe
 ZvMfDUg9PaYJ9Y3j6k4i0sUx2ogVIkQSBuhmBK5+GEQD6WgjuWSBvfpkoTePQ7G7HqCWwd7Qp
 EYHBF2qFXM6d5iy3JX041q8dAkwD76+sbeVYqJbOxFNno+izrAN6M7DjucSZC1cm5vkk+4elC
 BLoDCbq40N8ONleGei/JR1MbqWKq3ZQg/O8O1A5xKczG9jr4FOi81qf1AqUGdCP/nsDVo/LDY
 qJWmQTDzm4HkLWXBlmaHxGMIM+xCDmYNZEsVBLnCDVPrzQ7SwGMwEKHa7VAb7pJijMm5/lML+
 LNQrWQHilphfDE/aaOT6q+nOdf/SKCS+ZxfPyAbJyq1uLD8D0cMUVqQ0vTzt8yVc6VQUNKgmW
 a0NQ8GlcWKzb7wJIy9QIUMveDRR8jMGPPrb97nuqbGaztXIZWW/ngiz2DKvvu9/PSMFBkb3Ov
 eEP9bTGAQQ3o6Qq3wG+aF0UX5WLtukrSrT/TFDKHkfA8eWjsYJYv1x0zuCR3z+f8qLk89d9a9
 uAQyN1cbSDqcoyNcLEmdUkbLHh/QLejFFPiNMvBJegibHC68Csyzef/dx7ACWn4dO7lYg72KR
 57rjUJi3JXmoUX5IsVXhIetx4ggn79/M1HDzVLcyDZN2K+RJ5pALEpM0AV4VeAWjPxz7cMz+E
 W2WFyZN0CxakGWX+x8T3mValyPWLp+7PE0iROp0f+HEmNe8K896wLB1GnhWfELGL2E0eeJ/hr
 EDDLpdKsXlpxapknoL1xxHm3lsQfo1S1Ug3K/bvbF3Su2t/+O/MMUSFzZmWEShcDCOZZjl/zo
 Jxu8mBEBxHe+MiyQMXbUvH/TrU9yHR9UJDoKrVA3g64UJyxGFJX8wsBVT5bM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Sun, 8 Dec 2019, Christian Couder wrote:

> Peff wrote:
>
> > It's been on my todo list to upstream for a while, but I've dragged my
> > feet on it because there's a lot of cleanup/polishing from the origina=
l
> > patches (they were never very clean in the first place, and we've merg=
ed
> > a dozen or more times with upstream since then, so the updates are
> > spread across a bunch of merge commits).
>
> and then:
>
> > Yeah, I think we should work on getting our changes (including those
> > stats) into upstream.
>
> So actually I thought that I was helping Peff on this, though I know
> of course that it's also helping GitLab and everyone else.

In my experience, sending the initial set of patches is the easiest part
of contributing patches, by far. The most involved part of the process is
to react to reviewer comments and to prepare new iterations.

You can see this challenge in action in all the Git for Windows
patches/patch series I am "upstreaming".

So actually I think that you are doing a disservice to Peff: if he had
time for that tedious part of the patch contribution, I am sure it would
have been no burden at all to send the initial set of patches.

> That's why I put Peff as the author of the patches.

No, that is not the reason. You might think that that is the reason, but
the real reason why Peff is marked as the author of those patches is that
he really authored those patches.

In light of what you said, I don't think that it is a good idea to go
forward by leaning even further on Peff. From his activity on the Git
mailing list, I deduce that he is not exactly in need of even more work.

Instead, I think that if you truly want to push these patches forward, you
will have to dig deeper yourself, and answer Jonathan Tan's questions, and
possibly adjust the patches accordingly and send a new iteration.

I perceive it as very unfair toward Peff that this has not yet happened.

Ciao,
Johannes
