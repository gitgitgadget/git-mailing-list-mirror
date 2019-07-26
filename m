Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDD61F462
	for <e@80x24.org>; Fri, 26 Jul 2019 11:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfGZLZr (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 07:25:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:35887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfGZLZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 07:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564140341;
        bh=i3e+QioUYts5pZBmPpmlX5f/wQYmldq4nKXsvKB8jDE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PbCW5Qr9351LO+f4jCRup/Ipqph23+5vRRJkS3aBRLS8scQsKjdExs2ufoKJulnPi
         hjr3hajpzSBoqOHa4QCUzvpE/JNriZQPPnq5V7hGdKrQm96tAEE0qrPRZOMxDw8400
         o1UgU8xS4LpamwibgOBj4AHSmsuI0kh3izvUbOVE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1hdkvc3bRg-00DDMP; Fri, 26
 Jul 2019 13:25:40 +0200
Date:   Fri, 26 Jul 2019 13:25:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/19] merge-recursive: split internal fields into a
 separate struct
In-Reply-To: <CABPp-BGpCEZ-40_SsT_vU+hCP=MiKzhky6yBr6G=UMnwLNR2Ow@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907261325120.21907@tvgsbejvaqbjf.bet>
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-16-newren@gmail.com> <nycvar.QRO.7.76.6.1907252206180.21907@tvgsbejvaqbjf.bet> <CABPp-BGpCEZ-40_SsT_vU+hCP=MiKzhky6yBr6G=UMnwLNR2Ow@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lO6nr/+BoCp/j9nZCztHNnFZFM0GLlymer8gojeMpjTmoU1j8F1
 REnTZP9qo7PSjJbF4vcflGpF3xnJ5JXPuCdTATNNX/nJlFRsuzknMuVzqVfy7q019jxNnz0
 4EdSR1Ei5i4x1q6elGbBwGokhxF3Y5Pun9tsl79eYwcr7sDf/0SFggv/mS78bQ5/QzYB1+D
 7+ajLa2Jv75OA1WauLgYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cwok4VfQ91I=:MUjMm8OllfgXUsNwJSsU6d
 +IICBjDpM+cQMoJ3bhOxLKU43zpscaxJPabLEgzMZEfljBRVBIubVVoemNpTv33ibuiNUA8WH
 TW5UJdbH7sa7NXnm48uDKF/yaHV81g5yTk0/yfKIWIbsP8qGRV4TLnUwr8AGJvz7KkS/N2eSN
 w9t31zb66+8EGs8m3M3Ziihcxx5IWuUxj42jt9mdK75UD4FKGDSQ+W0oDgGn6Q3zQTissaFkv
 vqdz1ueVDsgxRramzD5T/hDSb8GCHQXQvTLKcFlxNnaAcJ456dGLxFPr6bZ4ZUhPBPLOV8zTU
 13XAxVBvZ6STO7RUsUkWK2YLc5dER7XMbWy38SfEpSKKUgO0gyV0cdDg+gLfhZErQpGlD+J9L
 3Ofj3qtV6iHbe68+oeM6oUzRsU0BEBPTO08RJeQ+pGrOfsZPXGhDBIGildA+d5yhNITa2bS7p
 EHMCREvmO5xHK5RxIsoFn2IPHD3h0WjhydV1T1cylT01zjaaCgfs4aVqVkXhjBazHbA+d9e61
 fNhLrrqy9nvVdXNPH6Xu8qBK3WYFCEmfNPuk3gFQIcp2foOSkXJJ7SLXCGOUXTFPPTHTOobCv
 i0gfgfySyFHvA/nG7ra+rjdY+jvWNOVgFqSsQ8nzz2dBXFrZd+zDBtDgF0CkFtZ60Uy9v4nMD
 39gTdkUcCMOgG2iJ06sNca+m1ZbviTDKsGzoigr7pOhSuuSbspcTyC7ySL4JzoKaU1p+QRIBp
 Fnp0/YEz1U3UVkEmk6FWzjFpTDczhuCSA1tS1leiUG3Vo+Qko4qZkLvVw/YVtDKNBi64Lpsmw
 itYL0W0Mn4KAimonfyqC3bEJf+uadoyuQItESGztIo6LMWZBNbwzOKn3yfwK4dvyztQ2/nse3
 dmcOsHBjGkSO0ybE35ufFWIx7MI14CWLTX1ewCEybl4Uqlk5au6iFa8XXKXBT2boG3Mmr1VHI
 qtemXs0+dhImCTt6hQZ6GBAsCcNCdLKa3oWAHzkctY+CMBwqR+DWEi+wTtQF0LEK9PUoAhseJ
 kkpgGTtqtEdEEbY3LOjKvg1aJZxdIH5aQ0iV0c7ynaSKeu3UizG5f+WDHT0nPjSstrznvHSpM
 sW4QDsdhNttTTt0L1LgaiF6pe6/B6SptmdT
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 25 Jul 2019, Elijah Newren wrote:

> On Thu, Jul 25, 2019 at 1:12 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Elijah,
> >
> > On Thu, 25 Jul 2019, Elijah Newren wrote:
> >
> > > merge_options has several internal fields that should not be set or =
read
> > > by external callers.  This just complicates the API.  Move them into=
 an
> > > opaque merge_options_internal struct that is defined only in
> > > merge-recursive.c and keep these out of merge-recursive.h.
> >
> > This method requires an extra `malloc()`/`free()` pair, leaving room f=
or
> > leaks.
> >
> > I'd rather keep the definition of that struct in `merge-recursive.h`,
> > and make the `priv` field a full struct instead of a pointer. That wou=
ld
> > save on that extra allocation.
>
> Yes, it has one extra malloc()/free() pair for the entire merge operatio=
n.  But:
>   * That's a drop in the bucket compared to the allocations already
> performed during a merge
>   * The allocation and free happen in merge_start() and
> merge_finalize().  Not much to keep track of, so not much room for
> leaks.
>   * I want what's currently in merge-recursive.h to be as simple as
> possible; I implemented your suggestion first, but it doesn't simplify
> as much as possible.
>
> But, more importantly:
>   * I want to write an alternative merge strategy providing drop-in
> replacement functions for merge_trees(), merge_recursive(), and
> merge_recursive_generic(). Defining merge_options_internal inside
> merge-recursive.h would mean that I have to have _exactly_ the same
> internal options in my implementation of merge-ort.c.  That doesn't
> make sense.

Fair enough.

I'm curious: what merge strategy are you planning on implementing?

Ciao,
Dscho
