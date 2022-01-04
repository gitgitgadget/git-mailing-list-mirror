Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CDAC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiADMpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:45:22 -0500
Received: from mout.gmx.net ([212.227.17.22]:60303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231926AbiADMpW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641300296;
        bh=S/V90fFdBY8tcD3I5/GE+jrLUNXOkOmh9hxyRwKK0P4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gr0dCnrwDhnC/y44Wn9h4gqlnpCgiRAS+j5Ne4d1rUS8JG2v7Z16cLJSrnZQna2n6
         IdEYyWfgeCHpFbliJievakukriFCdQR5tRViB+Svu1TK+qBAu8o+4m7rlekJSBuKCV
         Rm1cFVkghAJwFOz7xuI3ixEBangP5G2NabkiNDfs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4z6q-1mLjqe143Y-010t7S; Tue, 04
 Jan 2022 13:44:56 +0100
Date:   Tue, 4 Jan 2022 13:44:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH v2 0/2] Generate temporary files using a CSPRNG
In-Reply-To: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2201041334430.7076@tvgsbejvaqbjf.bet>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KlfNkK2hIcgI/BTAxIg5Q9tTAzPnz62AppE+AoPAGS1+YQNxw1J
 HmmnZYUUGVm6/zZM7ftu8wlPrJ/dP2CN4I3x894LXzJzvH7B6HLDwq2gBovlxE+AyExSDRX
 eguAEb/reKMEjIsn0vOYWzuvvJjB1Tgho1/8APvM4ef7dkcWnCk6hwavH78ZZkHv20twd49
 TaQEcWqXAUYrmx11kgcHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6JIH1vkwo1U=:ifmZqNu9uE0P+Rweq+jIzV
 +jg6WueYCL561Cs4k8z71di5GUvH5TvhiCXauR2DGTaTnl4IFI2yBAqStY/x5FG1XXAoYSq5a
 V7fuuovf3ChU/g9HRb181xUy7VyfmUG2ZBGVI/uMcQaVNns8ngpE1j7mZ0XIud6M193c2D0Ax
 sNaiG6zMv3t6F+S6oIJJKsWnxVtOy6RNwGebJcB4XG7VUGKLwDefzM1ZEqFO89LAcoZM+GS/l
 SXjt2vizkKAxuWfaGThfFTptkVx+20Z/K5TBIM5wd2bkmlhOQO71yObBrDkui32TE+8lftE5o
 DROz7k7KhZfHcgLcGj39F5n2HBKY28VFGNhUuFCEOO1bohLvh6Gat9q0lTCtCnbaHonfzmdIw
 l88oYYqvFQRhW1KCRLcOiUBpHbLdi/hM4L7sQZa3+wF9DUacWexVomZmK1Lbp9DhGFlu+EW2G
 sJPU7p1dBZ7L04XXKn0h1n1CzxoyFsep0gzC2qQc3xDUSS6x5umtboBjWGeSd+jG/1herkbuH
 WgNeH7BIvndGo0944ZQKHOx4WNOHK48/mW1M+BVJjBjEeOSqeYngc7sL754bRODCZQgllbtwP
 RQpRSOOr3B31aWErylFMe4oNBx8A/mjuhprRukKPeWk1PS/Q/pjJJGXp60J+cp7NUXtzx0Rqg
 vfnCy6TpRTei/LBEEtu1ZzxKQ7T8KjTIeyz/GPHLFt7KIHeq14txEHmY18t3noWTMwpFp2SML
 PUrD6onUmOKFwhsTt4mLBSXsTl9ko4t6az9dac0eChAQ/HGCHlfaIWnZ5xaBIVuYqqk5G77T8
 iG3qq/5tltP8Ew+LH7x1hJ/bwh+eU7vFU4bLgq2pvNPAu0GpqW6OZO6WXr88T2W/1gCL+V+sf
 hIc0lgdjVaiVnHs9sehsgLDrfcvHO/dX63j4DQ1FxAJs64l+C2r5jyoOAY0x15eoBcfbz4xDy
 t0XWx7//YA775LQx946h/gZCloVOJP7+E51PvKLfbThhLs2MYc4lF3FHlbRnSdgifEaAWhKVj
 7henHMbAa2fWjJFCw9yyEj/V5pZJ4tyN9u9gS8lyWuotIUg989i48yyePmTenzPO1sRIEyDJE
 KrD6x1EPb+Ameg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Tue, 4 Jan 2022, brian m. carlson wrote:

> Currently, when we generate a temporary file name, we use the seconds,
> microseconds, and the PID to generate a unique value.  The resulting
> value, while changing frequently, is actually predictable and on some
> systems, it may be possible to cause a DoS by creating all potential
> temporary files when the temporary file is being created in TMPDIR.
>
> The solution to this is to use the system CSPRNG to generate the
> temporary file name.  This is the approach taken by FreeBSD, NetBSD, and
> OpenBSD, and glibc also recently switched to this approach from an
> approach that resembled ours in many ways.
>
> [...]

This gets my happy Reviewed-By:, and I very much liked the thoroughness
and diligence of your work. It does an excellent job of motivating the
change, and documents the consideration and diligence that has gone into
the patches. Thank you for this refreshing patch series, which provided me
with a nice start into the new year.

To show that I did not just glance over this for five minutes and then
moved on to the next email in order to throw as many emails at the Git
mailing list as possible, I'd like to state that I mulled for a while over
the change in `compat/winansi.c`. It first got me concerned that the
changes to `git-compat-util.h` might be done at the wrong layer: if
something as unrelated to the winansi emulation as temporary files
creation requires fiddling, so that it can continue to include the headers
it requires, wouldn't it make more sense to create a new file called
`csprng.c` and add the new conditional `#include`s _there? Alas, it _is_
Git's custom to hide platform-dependent parts in `git-compat-util.h` as
much as possible. And personal opinions should always stand back in favor
of consistency of the code base. In short: I agree with your choice to add
the conditional `#include`s to `git-compat-util.h` even if it requires a
somewhat stray (but of course well-documented, thank you for that!)
`#undef` in `compat/winansi.c`.

Thanks!
Dscho
