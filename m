Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE8C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AE0206D5
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aZx2NzRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgA3PS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:18:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:38783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbgA3PS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580397504;
        bh=Sy/gI8ohJgVq0b+PuexvsXw2L10e9mA0cwulJeyMn7Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aZx2NzRzB7qwvdJ31t1dzylwDJStcxnjGm8e7xgtbMDZdf1eRwZeu04iQjSsfsr29
         4Eme/PZS6khyfSiZdj7hjPCdWxTnDL9QkcsBUmeLZY39HyaEqYcOJJTMU9UzFoAqR6
         MxJUghQcl/zrd8/ravBKzVWm8ffLSFSeVWCj6juk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4QsY-1jfUhF3S6Q-011REV; Thu, 30
 Jan 2020 16:18:23 +0100
Date:   Thu, 30 Jan 2020 16:18:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH 11/29] bisect: libify `bisect_next_all`
In-Reply-To: <CAP8UFD3QP3QXe32cdK+q=P+v3dK1Bfws5KgNnm-JfDnPkpBZfw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001301614410.46@tvgsbejvaqbjf.bet>
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-12-mirucam@gmail.com> <nycvar.QRO.7.76.6.2001202325000.46@tvgsbejvaqbjf.bet> <CAP8UFD3QP3QXe32cdK+q=P+v3dK1Bfws5KgNnm-JfDnPkpBZfw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ljQT7cmQbeQuQd1QxmRqeJwG8xOeqe03oI/ubBfYdiXcJwbp4Kp
 tGx9MLp/jU3FgX9WjLcnFTgQ4yV/zrbn79WbpopVNwGO8S0zcxhTGVabWEGHxUBXnJuMAqQ
 dYJZuJQ22y5mLR95Jz2M7vqV2LR9CYn0PIzEP8SLl2RPJFj6eLo4i0R3LSaIU4OLpPc4rr7
 8kH9i2gsUw2/3YNXcBmUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CetL402ANqA=:V1btWdXMc80B/yuGcupKnZ
 zKR5Lb355Kv06f9sJHrDFy8aMJ4ReRgOO2FWwF5d8W7id/qhgub1DMdFiEXpaQ2AxqsZNbUDJ
 raeoU4bSN9rXrnF6P+kmvFS1v6hrcynOy1ZMeoVh630kZf9KPSwlsQ7IK9PH9B7LexpFNrKh5
 OC8cFpf1Uu2MuxY982RnbWo0s5lGux4KOm7mxVJVF3G+ixOlD3lJLSj5aeU/TspU5/U/nAnfx
 KiYwVX7JYhcauTF1J0w+D1DaOoapzzw3vtD9PVjOVRRzTXW4Cu13ZKpI5zewCh7mDLErJSSsb
 slD6PhFjvMxtoQ1rBiom/5kcix1HSn9Kl5rdkxr0jao+zsYeDMznPWBi2oJBhVogb9L4Ludqv
 KkW1tEU3ev0HC6ssmsEUgb8OIw8x3HKPjZgZoEv+XhIxqsNRNIwKyfGoka+/Mwk/hngIJrIG9
 sRPZ+mYidtNam2foqRijJVr6psjkvIDZD+e/i6jAHb5kXLIkZPCGU9ihkQ18xIXBwb1+1kkRK
 HtfPRF5YWXPCqZPAXzWwomR3pr8sVbGGlsIV0y0GoDxKrBfjNtluB+sfx8rc+0pPn8JVz0Rsa
 mj6L8ggrlqGaYMzaiTH7vriB8Y1OYHd0VMmEN5OJ02LAl2mXspMeRIy4xB5ERUBrAgn7bSuwW
 4ITqeIB/82OZUv51wXAiQYYfKmQEWgUfnUp/PhnUYQDVMzxjYs29xZTu3CTXTxaNzA+m+xBVo
 1LVTBCorkFqPrMCtTUiyM/T6/QvFpZe/b6Al8H0fdvm4uIF1PSf77RMQRk2869ii33imwwSwS
 6sDGKsrDqyEOkfuTP+pUR4lHqPmKReqgYAinrgaA14M6I8ScK3FEvJcl/GXNfP16LvWYhyHs1
 envjQEpPxqPlWjjoQqDRRgRllI1Eeg/LcfEFr0x6ZWYxnbgYVjl1Uv++EoRln2dkUse+gRtDH
 NwV9/IPFerLtgzmXFyk/5tRq/06Ibwxp/4Ehrk5m2Ji/xeC1LGCybzqZzHNdCmEoGxWDkzkJg
 FFJQ+dHmMcR1Qz2JozQ5oAqngwqdcJmgzXkD9lkgR+V8RZxHHlOyDmBz/Mkcl9yJhBYoXaosy
 aXWf/fUNA8Sxrb4PusJJjy+oJHaxlV8ol4QehoKiZrykiKc88ClaVsP9FvxE8t9b4zKbKITaL
 wNX0evLZ/KSTGU8y6XOs4F/JmFpoVWgxJwdTU6MNg7R2JTRn8hi1NreiSVyWanFqpT3ul2Zir
 iE2nWGu/ji3obO49l
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Tue, 21 Jan 2020, Christian Couder wrote:

> On Mon, Jan 20, 2020 at 11:29 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Mon, 20 Jan 2020, Miriam Rubio wrote:
>
> > > Since we want to get rid of git-bisect.sh it would be necessary to
> > > convert those exit() calls to return statements so that errors can b=
e
> > > reported.
> > >
> > > Emulate try catch in C by converting `exit(<positive-value>)` to
> > > `return <negative-value>`. Follow POSIX conventions to return
> > > <negative-value> to indicate error.
> > >
> > > Turn `exit()` to `return` calls in `bisect_next_all()`.
> > >
> > > All the functions calling `bisect_next_all()` are already able to
> > > handle return values from it.
> >
> > So this patch brings more magic values that really would like to becom=
e
> > `enum` values. At this point, we're talking about `bisect_next_all()`
> > which is _not_ a file-local (`static`) function. Therefore, we now rea=
lly
> > wade into API territory where an `enum` is no longer just a nice thing=
,
> > but a necessary thing: `bisect_next_all()` is a function that can be
> > called from other source files.
>
> I agree that return values could be better documented. About enum
> though, I am perhaps wrong but I don't think that we use them often
> for error codes.

It does not matter how often we actually use them, it matters more whether
we _want_ to use them. And in the recent years, we have definitely made
more use of enums than before, to allow the compiler to catch mistakes
earlier. We even started to convert existing constants to enums, for
example.

So I don't think that it is sound advice here to point to the code base.

If you _must_ value the existing practice over a clearly communicated
review, then please look no further than at the declaration of
`safe_create_leading_directories()`.

> Do you have examples in the code base where they are used for such a
> purpose along with regular `error(...)` calls?

It's all in the code. You don't need me to read it aloud for you.

:-)

Ciao,
Dscho
