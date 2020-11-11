Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60359C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E634D20678
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Zj3HvkAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKKQXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:23:38 -0500
Received: from mout.gmx.net ([212.227.15.15]:57367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgKKQXi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 11:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605111803;
        bh=U/iU9OsgzFBcT+Kf6El0d6LpmdTdyMPdCwpO5T07UxE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Zj3HvkAQNJpU+2A2qXDb9SuQL+CwwkO4gl8yxsDhM0Zy+LrCmi1RYyCREM2xBWnxf
         iIfm6jFKlwmGYv++gFAJopEOZDa/jzkBmjZyAi008oUSeTlQ14ejX2IwnedVNqM9S/
         ralSwMrA+urlaxKUF76kCGjMIbuyQ1eiEqiROzGk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1kJ04K25Ff-00v6sI; Wed, 11
 Nov 2020 17:23:23 +0100
Date:   Wed, 11 Nov 2020 17:23:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Daniel Gurney <dgurney99@gmail.com>
cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/bswap.h: don't assume MSVC is little-endian
In-Reply-To: <20201111083227.605518-1-dgurney99@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011111723050.18437@tvgsbejvaqbjf.bet>
References: <20201111083227.605518-1-dgurney99@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pqKfTD8qeODrEEmWLKx9oO2wdEvOl7J1O6BC0VxhZLs7FFKkDHO
 rXtmqX04oaQU4jlvj9lTFDB0AnsqSxVm98CGLhjAG0oyzHvLB59lk6nC0y2Re99mFaULpWU
 tUBOlPRLamzuOoF0vhau4fZR+fdRm/JsXCTxCAHvkGlbri/ydfwaursIeFRiqIrBJZZaQOY
 kv4PCyIc/4y2qpqkjZEZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jPjn7rv0uRI=:4sdHdS+mgbdMGCWifZpZ9T
 B3/IacXmzAuQv3bhWZhY5LRhhocrG/IpLCqxn9AAOf8wRzUWsLUb+xwQEWb/GFfejq0AimPWG
 FoozMZsNtp3gah7buqW/VNjNIwldhDwSbLBE17i2fn+jUdlHeGajM1ajrc9yudy9PfizaPeLc
 1T0j8d8c+Y7Fu5qX4aJGbAU+8G81I1+65mNBLzXhtHaK79czGxHn3a0OJ2JQSNw7KmtDlZnLe
 uhvoujoE0oTZq0YRXTbs9eOutp57PTOwdOTVtO2tUUXNPYsjd1ke1pc3aFShNkzC5wOFeCkjB
 zTf3p6QxNDGdrw9kPPyevrxJ7yzDQ5mTbq3b87hPMx/VFS5oYATKVNH2Q+5IUuTATFLdcnEIK
 ++JxGJPFD2zaEBCXQ8r8Q/JVLStmP128Xncb1VYOiLZI2q4yEiKNaniKnyi8xx6RJD/Ubr4uS
 CZ7AI4tkep9u0ihTR0DHpD4qAK9tTNlNPL9W80+C7N/UWNaxhqLEY7WeZMVF2Uy3yWLGjEeje
 aDmNR3BSnqJl12QDvw0EWo/hU8IQvt6t7vZ5mwUR5R9potJc7t+xvWz6tW7GqdTEgzPOMUYq6
 JSQXzDbBDXuIveVFbjWB0Vlb0AqdhDoLL0ynrpqJQUfNqOGAOmM6bJEYaExGoHidm+QvhtdHl
 PGQcdT3GZl4tP/e8F3HkoGz80NdQxMxn/NOT9tVo1c0zBqiO0k8O+boq6pacViZQPfdHaw533
 JxSSH2mwLbcGh0hNAr2HzVTmxR+EdRztF8g2Iw2m0KsJHHV0pS3BgBt9DGLrNpCcx6060Xmou
 yARFK0Mx5rzPTP31vMw6HYu1jotCtc3AFSTW6L5uAQuw9TqRQkXLGon0p2dBHa8TvFUHEGmzP
 hErWE6PeFpeY1LAjokYOr3kZlBt5Odp0u/9Plf3TU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Wed, 11 Nov 2020, Daniel Gurney wrote:

> In 1af265f0 (compat/bswap.h: simplify MSVC endianness
> detection, 2020-11-08) we attempted to simplify code by assuming MSVC
> builds will be for little-endian machines, since only unusably old
> versions of MSVC supported big-endian MIPS and m68k architectures.
>
> However, it's possible that MSVC could be ported to build for a
> big-endian architecture again, so the simplification wasn't as
> future-proof as hoped.
>
> So let's go back to the old way of detecting MSVC, and then checking
> architecture from a list of little-endian architecture macros.
>
> Note that MSVC does not treat ARM64 as bi-endian, so we can safely treat
> it as little-endian.
>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Daniel Gurney <dgurney99@gmail.com>

ACK!

Thank you so much,
Dscho

> ---
>  compat/bswap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/bswap.h b/compat/bswap.h
> index 72f225eaa8..512f6f4b99 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -74,7 +74,7 @@ static inline uint64_t git_bswap64(uint64_t x)
>  }
>  #endif
>
> -#elif defined(_MSC_VER)
> +#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64) || defi=
ned(_M_ARM64))
>
>  #include <stdlib.h>
>
> --
> 2.29.2
>
>
