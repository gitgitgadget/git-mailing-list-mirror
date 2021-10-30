Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA2C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F033560FC3
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 17:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhJ3Rie (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 13:38:34 -0400
Received: from mout.web.de ([212.227.15.3]:35419 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhJ3Rid (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 13:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635615349;
        bh=hJQons6bm1LshL/lCOanUoBRyG+s9mw2YEA29w+2PJY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GyDw//T8LQKWgabHx+hJ85kxW4bjRyAnamwFnXGmlJKs55Lyc1RY9DxuU7p7R9G8Q
         9d+Yhj9MVZktWKHdyHt5SBFw+NjTHYVZWP+IkPq2QNZ9J7HwRuTKdz0mOlR84W4Hri
         WHtn9ZcOsb4hvXfio2ly6QAClXhr5DoY1rvWHzz0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MJkvs-1mfmL23edA-001BJ2; Sat, 30
 Oct 2021 19:35:48 +0200
Date:   Sat, 30 Oct 2021 19:35:47 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin <johannes.schindelin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/8] Allow clean/smudge filters to handle huge files
 in the LLP64 data model
Message-ID: <20211030173547.fse5iuq7omvfalke@tb-raspi4>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
 <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
 <xmqqk0hvllxp.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2110292239170.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110292311200.56@tvgsbejvaqbjf.bet>
 <ae900419-39ca-10f6-8ff2-d278f1b8e2e0@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae900419-39ca-10f6-8ff2-d278f1b8e2e0@iee.email>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:ifZcVHaETzq2ZrZKSJKWWePPBZ/UCo3I/NjKsVerbsmcgbtxd5y
 69cIhEPps12JBXXGXHQHE77+8NMNPAlhSXZETdBsfB3RmTu3GIfl5DbimY14LOiCjbifQQn
 8+5KSRlr49W41Em2nG1crj8LwtjDLYqDpkwuP33pUTc2gaPutH+MSe5jLvnzl0MKjymAMEE
 wm4/C701V5i/nIorCO+NQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1cIKHsDxfAc=:Wno54yWvWqn/I0QyRZ2v8L
 vzo15rtx1rU7+4ibdVWDEL3Xd/w3fqwkz75osbYBeczqFF9m2S/YTfKFGlARAWFj+StVLX1mN
 OJxhHLwK7oX/Dsvq75ZqoCz7MUxEasbpCZMI3gbfI6ur2cNTiVO5GUPzOI5EVHTdoQMM9yneZ
 eLnRGtGinIG3/4nDkbiLZ5pFVM2QHfgAXSM/sdoAcfcHSZQqeTY4LDj8SIXwWe2+KTavmRBBp
 u9AoPAEszXmyFD2s+xtOtb2m3+Nq6SFKYkrwqIgHz7TL7ARQTtSwmwCz+UpE3ld0zYXBWyI7J
 pm6VqX87DEFayl65X7qR3cY+NqQZEpQDaqNLb8grX5mSOSrmsMXxjvMEkYOvmpZ1aCda69pAJ
 1F7IU30VuZ+QCANwKNnxM7mRxwEXF2nHy3/VMAtoJ3GUbdYxgxzm3rkXTBb3rGtrYZC6r9FfI
 Zz2Sk3cvSJwvIPAA8nr4r90HgduqaArZLVWK9Kw0RBBNT6WGNBOPv+PmmHtSoa51w4kCUJYGz
 0NEj7XChDA9t5sMU4EIqYbmPtyGwQpw9YbRQRnpdAiztegbnbgL1Z8EknYOLBK34Mcf76Vfke
 BqNrYA73YD0O3IxGZte39I/I7UB3LnfJvO3PTyorRZJd5isGgfFqAFLZenRZajI14U4zHsxNk
 rT48rtfnwlFUmUjLIHb38syMynrFRQtHfm5tLjTJKWYwQsptE3eQXlTumm7rbxzSiGDOkKjHk
 +rV+lMryLKqqzEvAphdFwaBEIlLb+JJQ9J5HG0vxmpKdpVg8YlVZTRcWO/CTGGKpRALntnqFE
 0FLF8r9eALfd0ozdKOpIR01mfRuxT3a5pl9H40+xABX6D6Lul8lQC0kg4ShL+ipu1MxAvOkzk
 YiQHI08HU2p2wxa2fgDefjFuzneu1riQMZS3H+XxYIuH2Rnu6xfnoR7h2tcJTvAkXHkxyRrqk
 9ODUPJI3adJAWpTUhan2ZS1YZgBeGvUZDqI5Dlcqa/yd9j0i+9F3tevDZy/GHWA2CWd+ama21
 BKoVA8mTRIiw0YhiDX6Bro5HM4OupEmwG7nh5lHijGyB70YEnsrU97/ZXOIuIELJh/S3l3cjG
 rFFeegITb38nq4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 30, 2021 at 04:16:31PM +0100, Philip Oakley wrote:
>
> On 29/10/2021 22:12, Johannes Schindelin wrote:
> > I am not aware of any other popular platform using the LLP64 data mode=
l,
> > therefore I do not even think that these patches have to be fast-track=
ed
> > into Git v2.34.0, next cycle would be good enough. Unless you are awar=
e of
> > other such platforms that do not rely on the Git for Windows fork, but=
 on
> > Git built from your repository?
>
> I was under the impression that the original Raspberry Pi also used the
> LLP64 model, or similar, and that had started of Torsten (tboegi) on the
> extensive early work on this. I was just looking at the zlib parts
> following the Git Merge.
>
> Torsten was compiling for Rasbian (gcc (Raspbian 6.3.0-18+rpi1+deb9u1)
> 6.3.0 20170516)
>
> Philip

The raspi does not use LLP64.
However, the gcc from above did warn about a long - size_t mixup.
Even if both are 32 bit.
