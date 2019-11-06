Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6849D1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 11:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfKFLas (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 06:30:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:40923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfKFLar (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 06:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573039838;
        bh=Vi4pNJt1QUvb6VVa0hS+Rndk1NJoChZ0QrlM8HNG8Yg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FreYlUQPSAvH8SYblO4LMoQDiL6upw8pWdN+qbL0KOK4/3f5XjbODlzytxhJ1aXqY
         hAbWOm9ecK/g+BTAcia2GJB8azfnLObbwyQbm774nEGAhxEcxLU975M20z5fJKvM7K
         g/l9zPmBWVVO/v71u2UHNLkvJulrbMIQT1egFMn4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My36T-1hisKX2Sxr-00zTiA; Wed, 06
 Nov 2019 12:30:38 +0100
Date:   Wed, 6 Nov 2019 12:30:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Tan <jonathantanmy@google.com>, workingjubilee@gmail.com,
        git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v7 1/1] Implement rev-list --bisect* --first-parent
In-Reply-To: <xmqqtv7hvi6r.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911061228340.46@tvgsbejvaqbjf.bet>
References: <20191105052141.15913-2-workingjubilee@gmail.com> <20191105230403.5542-1-jonathantanmy@google.com> <xmqqtv7hvi6r.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QYb7n0cNljWwTDDLrEy8XAWMsuC+W7RdjmBzAZX8l/zxkMJra/y
 rKz9dKrbAB+RHxHl+iQYxWp/Je49HW1xtljgCLwQEE1XbrfAv5EKAoa6D7x8HyJXsaDDDdB
 JfUwHwX1n9kBm1s8Rm7RennWQUWxpe50fRkhNG74NgWrJn9Qn+qNJsA1X3qgPX6PYlC/sDo
 OUPO+aTYm9qaelilrsSBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1388N4d6ukk=:1J05gGsgNL34D+Bsgro3e4
 FaIjWofx6tOYu8egFO0Gh6atsKY42jJGsdLQgDb3tzWzLA3SHemUGTc5TcHYtWHG9EreY3jVQ
 oVNzayd1TZkYEsqc/uSsUg4LBXJgtPZAxy2nFtRmPN9zC3WEKi59d74XUA9Rm8Ic+RoxBpK4L
 r1wz0+Nrby0r5YChK1Y7mB3qvYQYkrUPFT7rQLlFAn+MFTTochJ/OBgGlUraGfjMvtkaTS7WV
 gttFejSXtfl9Tqe8k/2Eltp799DBbewirItodDk8Oq1ekkrPSONdyqPpUpHFHRytjYCkYXgA0
 pm/nAkSVm8yapNczMz31We6d61/IcGahB25W6On1U08VyobZzT2jUdQX304lsqg+p4Rcx+a3v
 8RqJnPND7Ln7Gk0Zl3GjWdDvTLOeDISk2SijBio7CPC7ORMquWD1h9hn+U4iFKdgCKWJsiyLu
 BszPGRcxpRAqXQnktqo/J0lRvb08JvOEJD3WQGfcgWm4fax/4cv2dJdKKMHjCv+K7MxhfiWqD
 hkE6/XgiPZ9iBY4DuuqqIq+m18sR1Gyh7aGLdxrwml7Sp40qvnSDfxK3b8L9O4KFBVi79W14i
 GPhSTLC8nZdaLiNXhYOLWNUTWP47LKRYD0SqPzSRiWu1EoYG0TfP4J7Pw7njzZpLGwXN3OSdw
 OswXgL9RNU7irnABzLTD+6TNA7ORpaYnC+5mYlbDqx4K9PVdUlss/Li0CG2qp663VWFY0z7S8
 C498mx3eX2UxcVERsK7zsd4z7JVqD3KTOLo05jrOPcJE4ghKcvuIbYB0oEOcQWSIOdYtfBTBr
 RTBZT+oDPK6OzaZXHdJsTkuysZAJNyE+wl/QlCb7u50KBfbIl+ZM2YkyxP54NhP8ORl+/vrMA
 cgfdqp85z3UciqivgH7QJFNWNaxLGTrZl3irbxevoWmWJEbUi1Z+Wx2PjxDPHE4rWcWC33ln6
 Cuh1TZes1T/GFNN8lqzZrK0CNTJg2F7HOEOv2k0TkohU0eGS+7tyMfYUICeodQoqAmqZfXeXL
 RpcvYd+c3BT0+jPfjDtL22poZlvbfncnMdYgfR8MGw0qHxBpYKuQWK41Sa3Qu9s61xi8AACfW
 lonX9/nQUYoV/osbdI+zu86judbJLosb+OS9D69csvvgGB+L3ZQHN/PQMMnehMobwVm+pll/T
 Fu673c6dKy3rPv28Tz0s00UX9FX142+dvyimzEZ8WD9rh0hPCSi3qJCJsywHGdPWu0zNp6ajS
 RtIkE0b6xCUAPljKdvKNZ/eyBpjqHkERLHL08HoHIpqP/7FSiAX9Rad9xk+Y=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 6 Nov 2019, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
> > Your commit message title should be of the form "<component>: <change>=
",
> > e.g.:
> >
> >   rev-list: support --first-parent with --bisect*
>
> Good suggestion.
>
> > I would be much more laconic (in particular, omitting subjective terms
> > like "minutiae" and "mountains of irrelevant data"), but perhaps that =
is
> > just a matter of subjective style.
>
> FWIW, I had the same reaction.  That part of the message was too
> noisy without adding much actual value.
>
> >> Note, bisecting on --first-parent becomes part of findall's previousl=
y
> >> existing pass-through as an "option state" flag.
> >
> > I don't understand this part.
>
> Me neither.
>
> > Also, clarify in the commit message somewhere that this commit does no=
t
> > change the behavior of "git bisect".
>
> s/\.$/ when used without the "--first-parent" option&/; you mean?
>
> > As for the diff, besides my comments below, a change in the user-facin=
g
> > documentation of "rev-list" is needed, since --bisect and --first-pare=
nt
> > now work together.
>
> True.  I too am, like you are, happy to see that these two options
> made to work well together.
>
> Thanks, both, for the patch and useful comments.  My own review on
> it may take a bit more time.

While I sadly won't have time to review this patch, let me first state
that I am very excited that you revived this stalled patch. Thank you!

In addition to Jonathan's comments, I would like to add another one: I
would have loved for this patch to be split in two, the first one
introducing the `bisect_flags` and using it with `BISECT_FIND_ALL`
instead of doing the `find_all` thing, the second one building the
first-parent feature on top.

Thanks,
Dscho
