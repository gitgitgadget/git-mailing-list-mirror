Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C7DC433DF
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13705206DA
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 10:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Gt9/iIc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgHTKR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:17:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:37721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbgHTKRW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 06:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597918597;
        bh=zdx4JDuknqVUyhquQ9a8qCOnRrOmDX1E51104l+VRWk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Gt9/iIc61fg0x6FRPrRFgK+ibwmGxHJp7D0FxZ3nKd3nXDb65ai0k+zNvr1uz9CKV
         rpNq6iobdXlzHD6U53ZPZsGii7Viw83eTsvHm9QNSsDJ4D5qVX8ndT6uINDYt6h0kt
         Xf4Wn217u6KCd5Sr+ptRwfp81aRF7Cbo4ZuVKCUg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.215.144]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlKy-1kdeez1GxE-00dnDU; Thu, 20
 Aug 2020 12:16:37 +0200
Date:   Thu, 20 Aug 2020 12:16:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Lukas Straub' <lukasstraub2@web.de>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
In-Reply-To: <20200819203825.GA2511902@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2008201214110.56@tvgsbejvaqbjf.bet>
References: <cover.1597853634.git.lukasstraub2@web.de> <xmqqr1s2tswd.fsf@gitster.c.googlers.com> <04aa01d67659$2dc217b0$89464710$@nexbridge.com> <xmqqimdetpuw.fsf@gitster.c.googlers.com> <20200819201736.GA2511157@coredump.intra.peff.net>
 <xmqqa6yqtm03.fsf@gitster.c.googlers.com> <20200819203825.GA2511902@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d3iRFriNg1Rm++15HTXIZV+wSVDA5TBNc57mqnL2nCaO+i9htRv
 Ef8A38q/bFef3ZPIC2dcnMW+J5y5kmWGdIn7OBVUCMGWjwAU49aa5kC+eUTA7oM8DEmRjn2
 yHO94m3mojhwmS9DHEAPwOCNhaqsV9irnfJ/GWWJu3GDw8Ga4tHK+2itr9M2e7W6Ei9XX22
 0Po5L17A0Q3LDC8b3ww1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rCSs2aK+SlI=:QqR9oieUyl2qeNPleMersD
 tO7jVVqWchDhm7KL+X6EHiRCluxP+k1F73GZinf+IpxDqyvxKeCETrFHY9oStGx+KXRvR5uBY
 3o0HtQaJcdbcoy6AqzLFdy+LRH+nyZq2njsWuguxEkyMRC4AvTfKxYqbWInpncQAIdj0uf9y4
 ExAwacGm5Dpipcexg+c7gK0+KxNwIfhsag9ElxZyZHujM0ANZzo1snsYITkRP8VVzXzbLUQpj
 IA8G/PIlp4GRPgDn9+p00uImQ+qUz8J2tZrYV3HkpmXVLHsNt87CeFaVKPlm5h5jUfSWOlao3
 ij/fXPqEJPk+G3QCR4iaU4lYf1p+LG9h+jXWxBnvAm5W0icbgyxoxvxE6vbZ4s2QjBea7AjwK
 bfcEN8ixbVpbuPUicomIUvYei6rXRTamyEszs6LBMtZ1QY6LHeM2nkPkyGTN39/AXsgVezbvj
 7Idz2wvRh/M80pqJdAOKEJBhwdIjqOY9Rg52RV4aicbGN7bxzrMv54s4EW2s4jDUoFITVN1vX
 JqmiT+oJzdM5eXJ15YoPm5qtecKliuESPikf7oawC+nHQxNo0F7lle8ZHlAcSh0GJ840QdHaE
 Ra0J1Z1kKmroNsp/MTVPxFrZGceb4KIxkhmJkNVd0qM/nB6RTxVTkRey2EcRAXHpFrXBDDLaI
 Knz4DsgHUGZGfNBMMOQuqkB1cbdC6p1AvrHnfMC9/DYgzkGQTZ1cL9c/Tf7pZYpsfUDYLKodc
 pHRbkK+3kRL/cpw/alMmNiLXHxv9zJig4nkkrt7CHCzc3q0AUJqQh6sCWtIToGLWsABcAoEEP
 0RaPG2f3K8917sgjgrBcIvIiJv5iq6Q6WBc1A4pCG2agLPqT+gsxdgVNdG9vAWnuOpyftymhC
 KPnKAkyC3DodW/AuqBxtQmhfhOjFGBgjAj/B3U+3IGbTuC0dLIaZBPqVn7LF0KwBvbcnWoRt4
 u5KHvCtfcy+GPqHEoG8K88TA/KEmhi6T0FkIhspp02w5jlnzHF25qqmCu5ID4PiImiSGWPRl1
 DecRjy0aA6viuKr5r+rjDspdoum4Vz0u8FomFYpgge6SHmerhMBED1RxrNG+lgIVSBht0lmA9
 HirxIGlxTOi0VzKFnFqRbTv7LqXwTpTNny+F3jgOhlNTyx1JJmT9fZMq6Q9nzJ0y/DeDXbWQg
 B+Ra7CIIMiYZdbp/twy3Wu0Vih+PZ8xT+4j5lCruF/6YgTGQnHWR3oVghxil/qNXqLQ1EtG/X
 5hRjfiZPrLUuW7Uc7ixBuPbKdbGwVYuuhwSuGeQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 19 Aug 2020, Jeff King wrote:

> On Wed, Aug 19, 2020 at 01:32:28PM -0700, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > It _could_ still be useful in a more isolated environment (e.g., you=
r
> > > company server that is serving only internal repos to employees). Bu=
t I
> > > have misgivings about a feature that lets people intentionally creat=
e
> > > repositories whose history cannot ever interact with other users who
> > > haven't set a special config flag. It's one thing to say "to take
> > > advantage of this feature, we must all agree to have version X, or s=
et
> > > flag Y". But it's another to bake that restriction into the reposito=
ry
> > > history for all time.
> >
> > If people want a pre-prepared repository propagated to CI
> > environment and keep trakc of the state of such repository over
> > time, for example, they can use (versioned) tarballs.  Such a
> > tarball won't automatically get extracted after "git pull" (which
> > is a feature), but those who want such a pre-prepared repository
> > for CI can make the extraction step as a part of their CI build
> > procedure.
>
> Yeah, I almost went into more detail there. There are lots of solutions
> that make accessing an embedded sub-repository only one command away for
> the person who clones. :)  Some others are:
>
>   - just call it "foo.git", and "mv foo.git .git" solves it (you'd
>     probably want to "git checkout -f" after that, but even if it were
>     embedded it seems silly to hold the data in two separate formats
>     anyway
>
>   - just hold a bare repository ("foo.git") and then clone it
>
> etc. I think this is really a solution in search of a problem.

As far as testing goes, libgit2 already commits such bare repositories
under names like `shallow.git`.

So yeah, I also do not see the need for this patch series, and I do have
serious doubts about wanting to risk the security implications.

Ciao,
Dscho
