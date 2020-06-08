Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BB5C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 15:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF649206C3
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 15:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L6VTEZ2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgFHPwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:52:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:34097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730281AbgFHPwg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 11:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591631545;
        bh=v1zG9KirOgzMAQKIzKd7/wisP5wcDxU02WKX6+hqfI4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L6VTEZ2ZhbJtBcmkgdynz2a/kDZJzybXu3vzNxzh5X4vQLJhPawCCSwcLKqX+aPj0
         36cgngjnpLHMKr9pNarkaA2u7B++1VWsJGt8dQ1IbNQ7QNOzvpNnz8eko5q7IlA8Ou
         ssfvmBGUpFLnpZeJKA+9obl5kgPt8GQ/K3vbW/lc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.65.3] ([178.164.145.149]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzyuS-1ilWNr1lLC-00x0uf; Mon, 08
 Jun 2020 17:52:25 +0200
Date:   Mon, 8 Jun 2020 17:52:16 +0200 (CEST)
From:   Tibor Billes <tbilles@gmx.com>
X-X-Sender: tbilles@serpens
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: fix incomplete conversion with multiple
 mark files
In-Reply-To: <20200606002241.1578150-1-sandals@crustytoothpaste.net>
Message-ID: <alpine.DEB.2.21.2006081739520.9949@serpens>
References: <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com> <20200606002241.1578150-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ebTXRgVJyWZqd1yAz8bkDGj0Oet8J8yVh4w3Hq+FpMsyXBK2O8K
 lHi3CorImyVg1PoNkRp3luVTOEoc9EcXUld9Fpv5aH21VYnaMwyY4L1AqGXHs82DT5OeiTQ
 X1GAuino88XnyrU4MN16OWcltyBEwJnbeYcWg1QLJLvj3zDwRalOLZsTBWEAcZ3pmdwHI71
 VNeTWOO3A5GLYVR7pOoqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+OSrTUtOlIE=:A0wS027M7qOCQwy2uewL/z
 N0d/mUsZKBWK8geVnrSLu/C8K2TGHQQPrMaa8AKuGpXG33vDb3JdOzUqWKZb1YhOjcoH3ZSd9
 D1YLQN8+a5HqRqScmH4oqStkuopaAp6AU1Iml232sFUOIW7RKqKubx/cEsE2tgP31wxw+fbHz
 d2vbm0MNaUc7QyoDHhe7AYRQ2Q14QmTJNDZYHo4COaaq4SUaGnO3VLF3ZRGHMRpeUkrJQ87wI
 5NH1Tb77rmtzvUTIJEmIcutkTB3wY+/VNCgnG3Hs5jwivNSZvFtkVKfBUxBcP0ucCCeeSyt3Q
 Htxwem7QEUk6hpi4UFmbpF2HVCARgwMJSTruIbBksx3rdWWLuFl+/2uk6vWinIENYXmA3lv+b
 b/yga7PKTKz/FetAoNg8xKTg9+055FJf3HMGoznBj/6FLUw7Lo6LlNJaL8ucjslZ9T9vdzxDn
 mOCxxGZ05pouj2lNEHPu29j9wXWARHfv4av+Y6iKM5+ZnIZsjmYf/hZ2vXqfN4Xejg9/A3C5T
 7L+6k6zx+OngRkdhqR2Glhub6cGI27CqHkph4eZU+/y4Xs1EGUdsEFpQYHc4KuNIkPSRf1Bbe
 JSlmGGZMmEhzPoL9n1bsFHEHDTr2n4+RwE/FuCXd/XN2FltpGIIkmfVkCq7AfHHDQ2cF+r8ZS
 q5L0SFQiOCxgLxArFs/S3aHNDuovE2Ew576W2/ogIoaHR54qv/RfMhipCDijr9XY66R1IrDHs
 bn4zS1MnIWnt2ZgwNFu7bU9j13hTixc3mUPrGBv98XniDDPt9Eyw0jBLwTYWQKf1QQQZ29O/M
 7/l9txX0tjJdLWxfIrEhreX4S/VF3+VKvf1mgjz0F9UEvkI3ZEMhGbhvIvZmJ8FVOd8zNRxNn
 wcgS+RCdSyL4hj1SsaQFOGVbiWBYaydUywTpL8KsFkJCBh/v5P6rd2MWF5NFLV89MV/DKXfx/
 B4FlOrk1d4R4mSWEH+P2ed6c3B16WVzZHZJ0Z0F0kaLGCUhsOrxCrSQ+1yG8msXU2B/Wxr4wf
 rIeV304bybv9eaI6ZnnTtF+lYu1p2b4zsTeDWd7ixqj0tbXbnmB7lGzTTQqH4lQ0JHk0RSHzC
 Q5qfqVeIn/jCd4gac0/spgw3bCCJUUemWbmi5UAVeYUG+xdVKV67X/UNSL2lRJzeNhnx6IUDI
 hD5dGS6bX9hzAeS5syDAQxrLBKJ8reBlEHxL9nC5IeXqzeYK2mbgKs7SbFyUT8/Lfq2XEBPK1
 Z+U192u1sPAgN0d+0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 6 Jun 2020, brian m. carlson wrote:

> When ddddf8d7e2 ("fast-import: permit reading multiple marks files",
> 2020-02-22) converted fast-import to handle multiple marks files in
> preparation for submodule support, the conversion was incomplete.  With
> a large number of marks, we would actually modify the marks variable
> even though we had passed in a different variable to operate on.  In
> addition, we didn't consider the fact that the code can replace the mark
> set passed in, so when we did so we happened to leak quite a bit of
> memory, since we never reused the structure we created, instead
> reallocating a new one each time.
>
> It doesn't appear from some testing that we actually produce incorrect
> results in this case, only that we leak a substantial amount of memory.
> To make things work properly and avoid leaking, pass a pointer to
> pointer to struct mark_set, which allows us to modify the set of marks
> when the number of marks is large.
>
> With this patch, importing a dump of git.git with a set of exported
> marks goes from taking in excess of 15 GiB of memory (and being killed
> by the Linux OOM killer) to using a maximum of 1.4 GiB of memory.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Thanks for the quickly patching it! I tested the patch and I can confirm t=
his
solves the memory leak for me.

Thanks,
Tibor Billes
