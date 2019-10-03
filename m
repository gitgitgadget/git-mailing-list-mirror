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
	by dcvr.yhbt.net (Postfix) with ESMTP id F126E1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 18:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388492AbfJCSYA (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 14:24:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:45909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731101AbfJCSX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 14:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570127033;
        bh=iUaIRSRorFcvuYGfQUfor5jDTnhP8GJzZtVHmSVIBdY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GqtdOh4Dk/XMcpOkYofMOSe2Pno9T2bhgODMmf/dVJSpYfiKh5H++iieJnWY8DQoy
         osrGv+ij4F1pCiyl7AuT4Suj0G4tS+mb+gfCsGcJagbG4kCJyWORCfWh1bNbXXtG/W
         EjzvPAaKKFTpGGwqPphNy6THjPzgfr3NoJWORyyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1idkdn1S0I-00XaB1; Thu, 03
 Oct 2019 20:23:53 +0200
Date:   Thu, 3 Oct 2019 20:23:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com, l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v5 2/3] grep: make PCRE2 aware of custom allocator
In-Reply-To: <CAPUEspiMOn8h0+WEkpe0CRgOQohKL-07TacM6CmiZBZh7GBCnw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910032022180.46@tvgsbejvaqbjf.bet>
References: <20190807213945.10464-1-carenas@gmail.com> <20190809030210.18353-1-carenas@gmail.com> <20190809030210.18353-3-carenas@gmail.com> <nycvar.QRO.7.76.6.1908271057280.46@tvgsbejvaqbjf.bet> <CAPUEspjJNSrJQT7xV2fsdp2t5odW5fzzPdDxuar_5x_JPUtf6Q@mail.gmail.com>
 <xmqqwodmbewl.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910031007060.46@tvgsbejvaqbjf.bet> <CAPUEspiMOn8h0+WEkpe0CRgOQohKL-07TacM6CmiZBZh7GBCnw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NEZh1qWydexCTH1Se7WRazeoWxb27rH3PTqKJMR34PpomdQhWUz
 KKQCs/0uGH02JjTtOKig+5GOJ8otTnxQ1s8Pxo1dM1WWm1nPd/dpd+Ypd+kEZAyVjgzvIBj
 NqNPcpMO1SmCBch+KuAO+ca2+nfutBn5p5QXZqON9cws0NB0MzzLy7b7eG/NcyxAy3mcwpy
 Ii1p7mq8ZUWKiXCW5NeXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9XwHlmFgCTE=:cXt5aoVfQxLQ3uxIrdeQGt
 ZwflbhLoQ28USvgxVOVXZcN8lIt5AMPqSIGrEJaZp0ym1GXwRcuV5Kp3wgympZKQrUb0Rh61U
 fiKI2XlSpGD7ukN6FL0+J/fZezCA1yA+/0hMT1vm7MWhChFVgyCRSdI+zSf8QXHJCGER2dc9z
 r+2cqp2l6yfrZAuT4nH3IVYSXQl0hrYbp/ge9nxZoZmnUn0F1F9gEqAO0gy9euGS5zVWVyebD
 6gyuz1LhTG+W3JEzGDjU/YDI8+ioCLPZZ5JR+ZI3HXhTM8Roda7p9EK72u/am8xTYmiAgoeGx
 MTX6VA1d7Abt7igXl5LDjgb1PjNWtRPGiCD9MjvrVA3kWQmpS78lNY3oz4zuFz/cip9XLnfpk
 2pX3f9/dW71BB6R2oMyN4aKheiqtYJNu4dN6rLwo5uj005iuz7PmWGEUN19m3vtIYp8F2aPTt
 yWNkuNZFgDC8DgJv8J8Y8NY05xcaKnIcTWxJSJeg/rO/yp230pW7DuKOK9fAhgzT0GW5H/yly
 Z1q9688JVqvtvwO+B1sJ3NUUsoQJbMCrbSpXxBftH4EMqFcKEt2dMRgRXQsH0YRyv+ElbTvcb
 7B5AgrSBRz2ztYr+OyfC2J6zDX02YAFb2ew6lVUOAxm1n1Mc0Sunxa7ZOaM+53Z+9OVl4k/e7
 wMO4vP+RBzndHWayB3ABJDmddQWO1lSVj7B2MkvMStY6SL4iZKM0OIQs3RJcHiKmKlrK+ti2u
 IazPCpHwqZPJBOxxaHEmEdBY39axXVo1F522cUb+8XUA+KmqH/n3eOGRnjtHy+C8x1imT7rRR
 JaFjGoJjeELRf5Aj/tQjSnLz0DrAMPfaaGO+juHWoOG0v5VhY196vOa2igASC7MnY4CjZoTFa
 pHxetKP5N+N7OmEJeIPVd7rMNxksBUr0bQOJ5CwrESojDfshk8KsUcgZvqJvT3Q6L3VD9R7Bh
 7XJlOSVBBAmSlRJUq89OFa+W1ItpVucIMMj2JPAjP6QxU5WxVY7HKytljYy7bEG1jiakjeN1q
 CNg0Z4wIC4mTxjVisloF02ZnSKdLN9RioP2Hnt4LpGa1ekjF5vsl4HkYTUts0C0gQ3pqH8IY7
 ivPNcOWi7jK2/G6lFp6roBTW3f1NvZfCUBcuzZ6N67xMhtvQ2Uv+m1uwEDgChWFrC7/ivY4ID
 rkSiP8sqhEJlc1XkVFVWobVj5XEXW0j9nDWa6+KT0Wzhc6gl/CCSrMbPLDmUvcgLg5KaD5xni
 EtgMDzGcdtGXgkccKSozHCOtuuIdwt92UZgNxCryCvgKI6j67gawUnfrv+w4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Thu, 3 Oct 2019, Carlo Arenas wrote:

> On Thu, Oct 3, 2019 at 1:09 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > I still need
> > https://github.com/git-for-windows/git/commit/719beb813e4f27f090696ce5=
83df3e5f3c480545
> > and
> > https://github.com/git-for-windows/git/commit/3369c322bbd95820b971701f=
ef7db44b26dd826f
> > to fix that part in Git for Windows' `shears/pu` branch (i.e. the
> > continuously rebased patch thicket).
>
> or we could drop the current branch in pu and start again from scratch
> now that all of the required dependencies had been merged.

I hope that your next iteration won't have any `#ifdef NED` in it?

>
> apologize for the delays otherwise; $DAYJOB has taken a toll lately
> and even my new shiny windows dev box hasn't seen much action.
>
> will update here and in github shortly (which might mean up to this
> weekend, being realistic), but should be better code (since it is
> mostly Rene's) and better tested that way and hopefully won't cause
> more breakage (specially in Windows, sorry Dscho)

I appreciate all your work!

Thanks,
Dscho
