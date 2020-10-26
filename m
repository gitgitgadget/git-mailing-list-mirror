Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74100C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA6322404
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gdqnlzv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784773AbgJZQEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:04:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:33581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784769AbgJZQEi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 12:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603728252;
        bh=ni7+VFff4xstFHFo6kyzHIwwLafLl+HB2h80MUzYTC8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gdqnlzv8UxZ0VbRq3NiAKoItm9boL49i2Dh1UWVHQ8VYuaSgik9lDse/r2rhdqauH
         40LKnXhw/m5Bjhl39wyKuAiN2PVfrs6KZAti8WVnDCet4FE1BCr5RceBchW4XJqJWW
         P4AN+/0rC4PUfG9VAE6nMEXg6o0nR3yO/7mOAf88=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.213.122]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1kmOto0fJQ-00OGKs; Mon, 26
 Oct 2020 17:04:12 +0100
Date:   Mon, 26 Oct 2020 17:04:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/3] Work around flakiness in t5500.43
In-Reply-To: <20201023085021.GF4012156@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2010261702410.56@tvgsbejvaqbjf.bet>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com> <pull.753.v2.git.1603136142.gitgitgadget@gmail.com> <20201023085021.GF4012156@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6TUNXIGjldlc7RhsrSjPw4goBL3i4zyVS4CUsqXkDQ2+kKML7tS
 FOh1ESfFcsCdb19nWqZL4vyslJGrpRiI0d9IXx+lGo62OcK1EwOeospFCjYrdcbnhbUOYhX
 pdEDUjsGmGvgQ+LbaotA7vmK4QG4l15fDe5SU6/JyT7BofjMV29j0eajR0ib73W3BJ4lP9c
 27iMt2xfr0T+khMgEHkxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vpR7LOPRfos=:GH52jNVGn5d3RGKl1cw0nA
 Yvpe/6O3Vb3nAVMivaZf/JHoVwgy7hXvcVjPXEnVgfkFCclifA5++FFY7Kz+PCFw11FzspTYG
 P3q3y3mj2Lc5E1Jda8uuFxyO5Y8vcrYsWdaXjukNkc8O3lT5S2+toU8UOnRWtBvH9bw8OXGMN
 mIUwhRV5Z2KIMF5BHl5Rl+VUuCfBZkxk/RaPUmeimABwsRqLqhsRAX/guc1OgA95V34JCxHE8
 Wl2RxosK568tQocDB7FtNQ9WF94XoSsey0rEivTIFBwGCEZZKuAe0cl/MuLOj4Peo/pK/G5A9
 aN2yJgpINcJwx9zE42rm6HDdYD3VLKCi5u1w/EDNxG/dzmXv+GRbwU/aaekAYHaIw4tG2aeJL
 1GZfeqCOOuXZTKbuWQVOYSwXucOtSpyhgweo37TVm8TiM9+HHLC/8jperMkEh9blGplCbipTT
 SDNv6ZRi4HT7ZXrv+PQ090ydio9geuiHtzIhTswh23KSOYjzjN289TCn+H5m19vb1jyGmKfD4
 gkcpvjvAa3de7W39JAZJa8EnocbDMyKssxj8q1J2biqSw5+jf61vMJtlFK5XAZWaxpckG4Pis
 qxW3zJy/Sv72XZzqhTIVBhXrmv/0voEVkxoB1AWwwdNa/ba6zx1nAGArzvHiQh8neysDzqZ/Z
 ilvqNa83gbt8y+6nwtwbBEUIvF7Vz129hdmbtLX2BJMQCGuRGuNjtwH8Ovc8T7NEM2zsEvben
 v3UVhMol39QhJ8ZzVXjiGDE0i3SsOvRegAGAeMZ4CzFVSbwnpktyPzV7wxOCdSQNpVZQhGRRm
 xDCnM+5QxGbTJNBGCVlxhY3Ecgi0ueZRIjTuauVImsa9rqx/UcCybwhXPsuw0kCdgdmboHwtp
 C5sQB8AEe0xcaOk6H5u3i8nHQ2C+v/BviVM6ErpqU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 23 Oct 2020, Jeff King wrote:

> On Mon, Oct 19, 2020 at 07:35:39PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > Changes since v1:
> >
> >  * Instead of papering over the underlying cause, the patch was comple=
tely
> >    changed to actually fix the bug and add a proper regression test fo=
r it
> >    (originally, I wanted to act according to the common notion that go=
od
> >    programmers are lazy, oh my, see how well that worked out for me).
>
> Thanks for fixing this. Your explanation looks thorough and the code
> looks correct. Definitely patches 1 and 2 look good to me. I left a few
> comments on patch 3.

Thank you.

After thinking about this for several days, I will drop patch 3/3 because
it is unclear to me how to implement what you suggested without reverting
the intention of Jonathan's patch that made `pkt-line` depend on
`sideband` instead of the other way round.

Ciao,
Dscho
