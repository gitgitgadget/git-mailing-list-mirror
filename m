Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5792C3F6B0
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 10:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiHPKkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 06:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiHPKk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 06:40:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A352E0FCD
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660643763;
        bh=TB9z6hZV142sC983ZkIeeO5QPgOiK9N6oybjO32jy/w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SpHSB3IwaysLsYq7CEuREmrh32p7nEdxXxqcFs1QK5y3KCwrzaI+FWQD7r2U5d52O
         g8MAxxTirHklHy5Z6sBpsxqxlcwLIeoadP4N607H/L1CEJsY31KHYym2XOvt2mhR3w
         oBVeNjd1VkofqVc6XYb4tQao6iisPkIb1q1YcGwI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1nYGcZ1h8m-00s9qj; Tue, 16
 Aug 2022 11:56:03 +0200
Date:   Tue, 16 Aug 2022 11:56:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] add -p: avoid ambiguous signed/unsigned comparison
In-Reply-To: <xmqq7d3gm1bl.fsf@gitster.g>
Message-ID: <r1461365-9np6-n988-0288-9ps4o944qqp4@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <4d24a4345ba66031d2ccf7ce472ed93ace82e9d6.1660143750.git.gitgitgadget@gmail.com> <xmqq7d3gm1bl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NoNs6ulb+gMnNWU/7ycWilygcI0qJAvRe8CZp4aigF/ylIrPB4m
 1m25C54p7IIe6v1HmJBuejTMC/gVPWp8Dqq28PxO9llU/rwoBTaT75EGo7KAtMCQztmjlWl
 sGAuCusde3yBBHt0sJ8YKGQ+PLaunm2RbYl2y+a2iWlOeJWFZNjyDXMOx/b1sFOVu1fcVzA
 kUNZ0WplJzVQWXA3a5fzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xG01TliZELs=:lxnYTfNCmlcWB6F6uRVfsG
 xJq9p1UTPYr4mStpjBkwo+Xq+PdMdbIjDO2UBafwSdumXWKdbiZJbCLN7JB59zBMobs92U14+
 ZGEYmbLj6rR8sLN3BhFjTVApVjlkPTCU6zbDJ8m6RbRC9ARXoJsv+v+PMH2tcH0lMIArsTlA6
 l8bcGCPn+FCSv5AmEm5svAYvhOvPbe5tb2zBEkS+elcsoT6ZnRXhLxDM8gct2rB+ZQJS9gHmR
 GEXcFFJKLR28W5w7317WKYlb8YuP0aWhknUZY5FIyAS8SKbEJ1BE8eEqHMZL81etMHLMdlz2o
 T47NnHNSW3C7MqLV5+XBCOFGBiF9Z21t/UB5sYg0cs2KJto0UCw/UJZcVn3/MszHikdzzfVjx
 SKP68VFAUFHhDDP8y/3XAK+acrJq3RxXtI+1P+P2fCADoUUHaukBnerJemtirgwNwxkewsInG
 YA/bEjTv05h5zUNyI3p/h4VTEIJpwgyvPzI/VX4ZMSpO+fJe3Yq/2bIOWADNeSRNx0Ng6nfk9
 lbm004lgPOIGzw5juohqa/blDDIp3unLSZr/WgCPdSfP9xLiMb2QxWxn4dTL/r29EHSE2pX7v
 TCvshPY5RrcKhB76OZvp81iNoqJNT/QSEBghzSeXOQRoz3OOX1n/O5ZJOwwh8d7ArSYPdJM6U
 YJ/91Xd7fXYUmhcX372VgYYekVY7VQ+9pI7O3nD/4BHjQyRQJEqHPt4+wJ1IJUpHly6+MsiCK
 9fkNKHah+45wyKF+cGbH9eJR0wuieT97lS7PblyYqLAdCPU2fopxu3O2ZgubkfEN3ftO6G+dk
 q1Ym2f7FkYvzy3bd+FGrG7vuHuPe+UAGM8aO6EUxbWBky/MYCUsnbD/BGv0cR308OYrThqL+w
 TKdyeMhKhGEGNpfx88koCRwZf0w5JPdMtJflc94nbJ5Lq4/BcAHRUXxKUl7tzyOYiMMJVr1+n
 e/lQ3TIa8+8NaN50Mz2syWryU76qWSq6RdI7nxdSYFJab19MlXbF63EFba9PJ9fmVe77lQ7Vi
 KH7JUAglv0vpArZFouycAwzNqM0vKU6VOWbeIW8HPB4Bk+1d4tCCPXygGAUIxGXWtbTUpywUK
 mAEfTma8zNZimEtvvUj9p3/v6GsrewWa9KNVvwT8/NHsxSw/U/7A4DpFQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Aug 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In the interactive `add` operation, users can choose to jump to specif=
ic
> > hunks, and Git will present the hunk list in that case. To avoid showi=
ng
> > too many lines at once, only a maximum of 21 hunks are shown, skipping
> > the "mode change" pseudo hunk.
> >
> > The comparison performed to skip the "mode change" pseudo hunk (if any=
)
> > compares a signed integer `i` to the unsigned value `mode_change` (whi=
ch
> > can be 0 or 1 because it is a 1-bit type).
> >
> > According to section 6.3.1.8 of the C99 standard (see e.g.
> > https://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf), what shou=
ld
> > happen is an automatic conversion of the "lesser" type to the "greater=
"
> > type, but since the types differ in signedness, it is ill-defined what
> > is the correct "usual arithmetic conversion".
> >
> > Which means that Visual C's behavior can (and does) differ from GCC's:
> > When compiling Git using the latter, `add -p`'s `goto` command shows n=
o
> > hunks by default because it casts a negative start offset to a pretty
> > large unsigned value, breaking the "goto hunk" test case in
> > `t3701-add-interactive.sh`.
> >
> > Let's avoid that by converting the unsigned bit explicitly to a signed
> > integer.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
>
> This looks more like a fix to a general problem, not limited to
> windows or cmake, that we had since 9254bdfb (built-in add -p:
> implement the 'g' ("goto") command, 2019-12-13).
>
> Please pull this out of the series and let's have it reviewed
> separately.

The scope of this patch series is to fix running the tests in Visual
Studio when building using CMake.

Pulling out this patch would break that patch series because it would
leave that breakage in place.

Except if you are asking to put this patch series on the back burner and
prioritize the patch that fixes an ambiguous implicit cast between signed
and unsigned data types?

However, that would mean that I'd now have to address all of those
implicit casts, which is unfortunately a larger amount of work than I can
justify to take on.

Therefore I move that in this instance, the perfect is the enemy of the
good, and that the patch should remain within this patch series, even if
the larger-scoped project to avoid any implicit signed/unsigned casts
remains unaddressed.

BTW I would have expected your review to ask the (in hindsight, obvious)
question why the test suite still passes even with `vs-test` exercising
the code that is compiled using Visual C?

The answer to that would have been that the `vs-test` job of our CI runs
defines `NO_PERL`, and t3701 is skipped completely if that is the case.

Ciao,
Dscho
