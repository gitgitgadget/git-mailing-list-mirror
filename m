Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 063CD1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 08:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfJIISF (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 04:18:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:54913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJIISE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 04:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570609079;
        bh=rdiHYPrMzr+XgU+zG85TZ2OoyFmEvCoS8HtaLaANUMc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NYcClGdMy1l/2CNzYPqBhKLQp63VlMOniEjfpIQFdsqFzzIYiUk7861Dj5hSsM7GX
         IxXPyd5M+vYw4eDXFH3L7z3mcVz25u391eNaqxzPQs8/s3BKNIsMOlwY7wEZesbHKL
         LJpDar3yMEGfhh3BmP6CZl9/ig+dK8B+pwVByzWk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1iEFHR374M-00519L; Wed, 09
 Oct 2019 10:17:59 +0200
Date:   Wed, 9 Oct 2019 10:17:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Add a helper to reverse index_pos_to_insert_pos()
In-Reply-To: <623fcd51-5f0d-bc5b-f70d-0224a054ec5c@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1910091015090.46@tvgsbejvaqbjf.bet>
References: <pull.378.git.gitgitgadget@gmail.com> <81648344bbab4219c0bfc60d1e5f02473ea7d495.1570517329.git.gitgitgadget@gmail.com> <75a9c7ce-893c-6341-ba8d-eed3ccba7ee3@kdbg.org> <xmqq5zkyn2a7.fsf@gitster-ct.c.googlers.com>
 <623fcd51-5f0d-bc5b-f70d-0224a054ec5c@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P8RZ8HdN9oH5D6cPgQveChxNhkMG9FO3g7AQVRJtpsQpTs+ORmV
 Q+GLtuSXdPncUrihFAq/Ll8/Ek1/JgeQcBzXP9+B15TtwizZsV57wWSr2gps3I1DNe+P/F9
 Y8EBRIbWri0d48wKTUG2uKEIOHV6imsnGA/ImifPsJXmxCeX+kl5GZA2SoKBs1qgvliYOTi
 YhHiQokFQJOSBsFO8vCPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gtLKbh9uR0c=:9x9nK7TXH+yYY9u6vOifTo
 RGHhClapmp/nuTjlQokImBIgzwL32VlB14b6GJyPUVGGeGXYqLM8O56n6TYITlO1m4Gp7INBc
 Fz2KgOp5jGHfhummzJQJlsno3XoJkhstTiamA5pCWRAhCYJy94xhg/X32mGCF1nVpPsLIhryC
 oh8vO1d3h6BErs7CmKq6EeAXPlbSUHCoX14LJyscqjQTUGdMzSgZSe/swyXzSpdb2H91gy5dS
 oLQyYN6n4vup5Yu/i/YKYYghF42L+HVnQvVIND63PQ+1NIvaJItmcpoRpqBZjUqLneo5JRnMQ
 vCQJmcYALXKHkOQiK5fiMctkAnKXUtvWklqSXMcQPvCa3MvamTWWR7f0MlJsql4sqMZdI2GnQ
 TrS7uYa7rkcLHoEw4cIfUgQSMtmdKy5NtJ4iLYkLuPo48DgNesr7JM4lIzIyISbu5/gIiL260
 phsadrmt+SK6sMFPodiFBoEZQrnEnh3DmtKhoXfe+047KfaLhhKo6/GBY6k7gPADVWjMnNMi6
 rYJY/p8Uytp0voEGK4aYn5YvM9kRBTewFUcSMu6uwusZw6yHPAhEX10IiR2J9rEn7YVnJXpZW
 oMQHOwHjkU/gQiDKZs3mInXTGNVcOZRTe7lpQTYV3cyTGwhzQozoiW8vIFVt3qOy059rY5w29
 GY4LBl4us3Ga4GbeVhS6dV4vZ00xvP7KUu/iaMQR+ZvLHIB0v/5uUMJesBJegzgQo8QebYVo5
 XT1RxJrjIL93nXoa0MK7bRyiY9EFGni2MIhcDnaQmQKW8M3vg1cBKoT5vcKXRQ1jErUKOGzrx
 26NGsHepluRmDjeAcLmoZXmCQtObhDd7sucMDN5XjnyDe1SGZBYrgl0Lw5Npil8BZG8na2x43
 YYfYhbr6ZRbzRblVsZTfwLOqRrKcKMYbDDau5Z7+yZDcmo4uGmKtUsT0I69PZYY/qb28v2DNZ
 1uSlRLfWBBodyfme5J2HR9GtjWNRAgR/c/LOl+JTFQbVtJ2l8ny4LBCw2G2blRqWOIrAliZ6x
 9LPLVsKtmNScM1vAjomJ133/QEn5sal4fgbkHfPy0gAGfsbP0592chIi9KiOutZQMvC4Hl5MQ
 d314rt+9s2mzr7KMip3DpidPOxOp43C4beSC9QQam6AamS5p3MJiOKgLiXRU2wgLp7JznwObv
 EqiTzBpn657FjYHSjGBWLIji2hawxuy6m5RNigeRooB+f4LDB0YOLTM1HzhcpBapSREbimcFw
 1hs51TRte1s1WGUhl6VaWSBOaasmUqVpmpz+D660Xb7mKwjVF0IxybbyLiSU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Wed, 9 Oct 2019, Johannes Sixt wrote:

> Am 09.10.19 um 03:19 schrieb Junio C Hamano:
> > Johannes Sixt <j6t@kdbg.org> writes:
>
> >  After all, the primary purpose of
> > inventing the encoder was to catch the arith overflow, wasn't it?
>
> That was *your* motivation for the helper function. But IMO it is a
> wrong design decision.

I wish that comment, and the argument following it, would have come as
part of the review of the patch series that already made it to `next`.

FWIW I actually agree with Junio about the helper, but in hindsight I
could have used a better name (not one that is tied to the "index").
Something like `unsigned_one_complement()`. But of course, that would
say _what_ it does, not _why_.

And yes, I would wish we had C++ templates so that the helper could use
the exact type of the caller.

Ciao,
Dscho

> Whether or not the index calculation overflows is a matter of the type
> that is used for the index, and that in turn is dicated by the
> possible sizes of the collections that are indexed. IOW, the index
> overflow check is (*if* it is necessary) a policy decision that must
> be made at a higher level and must not be hidden away in a helper
> function whose purpose (as suggested by its name) is something
> entirely different.
>
> Unless, of course, we declare "all our indexes are of type int". But
> that ship has sailed long ago, because there are too many cases where we
> are forced to use size_t as index (strlen, sizeof...).
>
> Meta note: We know that we are painting a tiny shed here (Replacing a
> one-liner by a one-liner, huh?) If anyone of you has better things to
> do, please move on. My interest in this discussion are just the design
> decisions that are made, not the actual outcome of this particular case.
>
> -- Hannes
>
