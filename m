Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF73C433FE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C0C61131
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhKSQzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:55:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:60065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhKSQzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 11:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637340721;
        bh=HYxOgCrm1azT++s4z3r6pcF3HUbSLSqM1OLoYsLAs7M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gApgpVJXVr4cyveQgKBKVwpyKBjng2aS/tduUcyluuHJA5mvSo9h7QsApKjQEwIqf
         qHlpHJw7A+rx95wc3Yaj9w/SE1HTOGg3Wh1Phk3BLy3kBTDXbWW/N04WnqxdwUHMTx
         vp0bIlkdnH7r2aJ53yOYmdTUd3+VhJyyNeNVlr28=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([213.196.212.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzBj-1n5N1E1kIr-00HtkC; Fri, 19
 Nov 2021 17:52:01 +0100
Date:   Fri, 19 Nov 2021 17:51:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergesort: avoid left shift overflow
In-Reply-To: <7fbd4cf4-5f66-a4cd-0c41-e5b12d14d761@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2111191750400.63@tvgsbejvaqbjf.bet>
References: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de> <7fbd4cf4-5f66-a4cd-0c41-e5b12d14d761@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-335973563-1637340721=:63"
X-Provags-ID: V03:K1:6wsnDsjRFhpPkPy5I8wku4yDopyREhfiXnq5SfEBHN9I0BoAcjW
 B7tG+RzGCvsoFERzSBDBgUnOd6S4Na8ViGwx8Yw/gZOKvVwm7ctzvVqoG5cadyDi5FLUY5h
 AXZ5Uc6K9ekmQf5MH+PdOCfRfK3zefYEWePJTt6vHqSNzWkMmb29WlZDXa16EnYA6jldfoV
 oF18yHvaTuozoOCzRBW5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JF9N++X5dNQ=:LwsN83WZZ4N/EXuZ1cK07S
 F+6qhYTs0l45XqeR7Z0nsrVklmamKCXRJKuGNLbFeTni8czWhfp9rvaB8BJW8WPm8KGk6pI2x
 tymdnEIsuAt/I7db3opgaMn6hKsdhlFLDA0qEK7lPZBqNJ3DpkeZPVkX5F7IqOk9HrU4XdBu+
 n0cd0sIPsz324ZZP90tf161EqfZhx1vUQkKP0MM1WlWLf5SeJB5ZhSi59ejy1EacWhXBBM5jV
 QV9F3iv2P3FVT9JCai5pFkqE93COTywUDR6GG8Q2W52U9kf1O6zTnANq3C48BmE3Gb+8kywML
 fjgt5Oh0v8szosXu4nGayzoYtfQnx2tYd4u6PjtEFllJIEv7T28nChW5oohgQSvJI/TQy1HQz
 QfmlQYg7QpDN1ivJ3fXi1U1LgKYPeldN+zWVhREtkjGV3oA5zpxroYAMkT7UFDYjGLUpA7Eek
 bX7iTkhO4POzoVl9725Y0TerkW6f1SLxQ6qKnlhTQT0Oo298JrD0zeTTVDa7m6jp1i4Gd5UL8
 U1fUXSI2Es71RDVPEcWmM7TNpiHAaCo9OD2vmN6/DeaxxA6boHLUXkmPrwEGnvRiQa4SyKW3W
 GSSfv4nN+jXd5i9knWPc2ApgX2ILQfnJPk0/hcetbQsSmqVomZeZVdWZDw++Hy98ew9pnD/Pe
 ACCjMhmaQuwKxImCd1yuue7aiZK9GHxywCZK6pcJmPaU+RzKPcOor4Urq2qPlqOufX8GHxloo
 AczPRfnMDzprKh/ZQ1zzW1CJoQP+gScRoJKeZ2gGW3GxHadqPBKtHgE8VpOkF4VczR9zrGzsJ
 YJTVPY+Z2qYNudOwGU7O2EUJKLyFnYQ85R89sZtgY9uDBDhDeN0LyfHpSKCfNSqv1du2DZ0dM
 4jKI4RrtY5HTlCuEzU80Ovfv4E3SJQ7tnBgzgFXWzNYBCVVOccAcqf6HdarnUkagX3XKotFZ8
 kDM5tdbRPN0foemJfOXGrNC4kDcYRjXaIv+m/iEPW3ENayz0+ixN3HDoWYLaZqzuDEpQ0mUBy
 9VJsU8tBl7tIqG5Cpy/IKVSOthYXEuEckao2uabntfW42jc9zdWFJuZoQVUSB5Ta2lNUBUq9V
 /tPKuiv0Iyc6kc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-335973563-1637340721=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On Thu, 18 Nov 2021, Philip Oakley wrote:

> On 15/11/2021 23:19, Ren=C3=A9 Scharfe wrote:
> > Use size_t to match n when building the bitmask for checking whether a
> > rank is occupied, instead of the default signed int.
> >
> > Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> > ---
> > Ugh, sorry. :(
> >
> >  mergesort.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mergesort.c b/mergesort.c
> > index 6216835566..bd9c6ef8ee 100644
> > --- a/mergesort.c
> > +++ b/mergesort.c
> > @@ -63,7 +63,7 @@ void *llist_mergesort(void *list,
> >  		void *next =3D get_next_fn(list);
> >  		if (next)
> >  			set_next_fn(list, NULL);
> > -		for (i =3D 0; n & (1 << i); i++)
> > +		for (i =3D 0; n & ((size_t)1 << i); i++)
> >  			list =3D llist_merge(ranks[i], list, get_next_fn,
> >  					   set_next_fn, compare_fn);
> >  		n++;
> > --
> > 2.33.1
> Looks good to me.
>
> I already had this locally as part of an MSVC (Visual Studio) fix for
> the various C4334 warnings.
>
> The other cases are in object-file.c, diffcore-delta.c (2 occurrences) ,
> and repack.c.
>
> My patches are in https://github.com/PhilipOakley/git/tree/oneU_t

How about rebasing the remaining patches from
https://github.com/git-for-windows/git/compare/main...PhilipOakley:oneU_t
on top of `rs/mergesort` and then submitting them, to avoid duplicate
efforts?

Ciao,
Dscho

--8323328-335973563-1637340721=:63--
