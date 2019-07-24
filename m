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
	by dcvr.yhbt.net (Postfix) with ESMTP id 641211F461
	for <e@80x24.org>; Wed, 24 Jul 2019 10:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfGXKre (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 06:47:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:55307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfGXKre (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 06:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563965248;
        bh=uL6zQOS6ElrtVrd/s8MaWPr7e3qlGUTH1miQpdRjAfg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RVuu/5mmMZ9IXNz9Ki+GrsVZvn05CKBo1t60PskTdPF7EvUBk38Ksf8+vzJjBOtH3
         +w8tbQv/A8XbyLd1I5kOeBU8J1nUpJERBhMCid5VltYj7KshFfg6eAFUdFTCO8OhOi
         Hnq98nECwSW10b6CzWMY7TpuUf6weK5qokhISsb4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTO3f-1i0zN13DYF-00SKXs; Wed, 24
 Jul 2019 12:47:28 +0200
Date:   Wed, 24 Jul 2019 12:47:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
In-Reply-To: <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907241245540.21907@tvgsbejvaqbjf.bet>
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet> <87muh57t5r.fsf@evledraar.gmail.com> <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com> <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet>
 <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZGXqO9I6PERCu7CLeLLaT8cr1ZJ0kFHi8FTXXrjuFYfDeDSOM0Q
 s1hVbJd0i3luJLcIlK7jyFFd2DZxrm3w7hvE8pe96wuCOx2qHEeuoiysajyKw70puX1/2ny
 tM5L3cxE4xp80I9cqWNiqTzGEznpMuviOWWABJBMfyhYGqZ65HdM0A26P8zlAAPVb+VNiT2
 lEIpigrK3eessxO58ZL2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y3EQkDfOFVI=:NOdSoAb0HJM1L9oT3OFp0p
 p1WflpxnoecYPo33NxMk8EHLEbYm4oPojnzoj5Mcigbpie4BcCrhamR1R82Y6n8CiUWLztz6w
 BiEQMJ8zQAwoIJiu1X7e1JxiDWqeqX1ABMqUfttXHPKYS5enArfoCV992+ChxCU/DL+z7QvCX
 IGFzGLA/JeMMIKf+kA+Ux5jrsGzlcceLibyi8s5BCOEvwjL+ZY8j9GkPgUXpYqnGPtyWZ7bjT
 XcV5UVInI4dFDpNK400zwx4kKaupfuRDkr+9psyw0n3SAV5Q5uTjyUBi3uBNjatFnwD95glj+
 Q91hnObDr+6X57UlYGvBiM6SljnvodJhTlhgLb2AOTy4gHCghwOSYVM6/7p+9eEBBuHfHOUCe
 WS0eaoFzPHPQJLxsjPz5nOWR80X0MTBPbzmqOeDCGXwePV5KD+27RiFJ5EaF4j1t+g0pwBXTX
 M/G24OFN+UY3axV1POpenBhdABpduCK+Hyb/ceNljZHJaW706L1Twj4ZBtQUO5s8ziYPZ5cui
 s5s1froeWjpCaO6qG8xNGKLihL+IvVe0rXQVt6PA+YeMA0vbzThi+klL8CyyR0Ufp0x/UTedK
 xQty3dRhSM1AKJFr8EZpA0P1PUd/gu5u+0thqYCnFDnP1NukIFHsRLRivnpN5Z8hcSQjb4LM6
 7KOWkOxlk46OfDEPoU2QOgPIDTPVzOMvt4fgmbKjM8jKlcfXWYhc1qzOAERh5STT9wjveDUwr
 qC/OLHr69iFpC2E3R4B5Xwg+PdSZyWGrKTI/0jTHd3Okp+aRFR/0M4fmAU1I7xlVQD2yHshxd
 wdJRX6vL4qRoL5NnowqhNKZFt4u6Wi7NhBNP8os+ewqApwtgh/sYI5pgRq6IIlnxGvt4iNQdM
 NtjsZpg7LD4qMCSl2sSYUIcCTWbA9g3ca0X9jT9x7JfcDlGbExgjREnAq7YkIqElcNif0m0A5
 4d+oJ/g8lmrGajHE0zPDRA2lNfU6vzUgKnw/q3DRMHxZEbCdnXRzSqPx4lQOJ5zdBGVc+WBCt
 LYVTYHg5/25IRu7rSsaTDY0JDEkLaDRwGY2C1+vSeQ6qg6AAH2/YizJJ7kXcq5+R3JjYw0HWE
 /hDrvtyV2+tdBppGW+QYzwqEQ9J/UwY3IKG
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Tue, 23 Jul 2019, Carlo Arenas wrote:

> On Tue, Jul 23, 2019 at 5:47 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > So when PCRE2 complains about the top two bits not being 0x80, it fail=
s
> > to parse the bytes correctly (byte 2 is 0xbb, whose two top bits are
> > indeed 0x80).
>
> the error is confusing but it is not coming from the pattern, but from
> what PCRE2 calls
> the subject.
>
> meaning that while going through the repository it found content that
> it tried to match but
> that it is not valid UTF-8, like all the png and a few txt files that
> are not encoded as
> UTF-8 (ex: t/t3900/ISO8859-1.txt).
>
> > Maybe this is a bug in your PCRE2 version? Mine is 10.33... and this
> > does not happen here... But then, I don't need the `-I` option, and my
> > output looks like this:
>
> -I was just an attempt to workaround the obvious binary files (like
> PNG); I'll assume you
> should be able to reproduce if using a non JIT enabled PCRE2,
> regardless of version.
>
> my point was that unlike in your report, I didn't have any test cases
> failing, because
> AFAIK there are no test cases using broken UTF-8 (the ones with binary d=
ata are
> actually valid zero terminated UTF-8 strings)

Thank you for this explanation. I think it makes a total lot of sense.

So your motivation for this patch is actually a different one than mine,
and I would like to think that this actually strengthens the case _in
favor_ of it. The patch kind of kills two birds with one stone.

Thanks,
Dscho
