Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABD2C3F68F
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5744208C4
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="k6HjwQWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLZVUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:20:17 -0500
Received: from mout.gmx.net ([212.227.17.21]:40623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfLZVUP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 16:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577395210;
        bh=2hea/jABR1/tZ8coVTNkvxjifg48rFzV3M0AtPtnW/w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k6HjwQWnwFlySS/FZMoAPS7zBVw8tej2ClM/hpqdYI6dSkKH0CNUSsgHgDjFPuE1M
         KXyJ6G6FMxtFCm3WJhi1cbLuh+HdvqqC86gMFY2wYZUfMADHMQnXGlvFmGX3GD0UKp
         smA+NYbB1HwHY1AmYPpc1weW1BgX6dEAn745s+uY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.lan ([136.243.159.11]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCOK-1j5ZLp3JCu-00N9w3; Thu, 26
 Dec 2019 22:20:10 +0100
Date:   Thu, 26 Dec 2019 22:19:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Disallow writing, but not fetching commits with file
 names containing backslashes
In-Reply-To: <xmqqk16ilwnw.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912262216540.46@tvgsbejvaqbjf.bet>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com> <xmqqk16ilwnw.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9W8Cn+sdi7Nhvb5HExXZudpNYYf2bvNOftagKkcsmOCfMj4/tCo
 tN9hisvW9st9Eh/XBykbepPpDh6bBZmRCwhKkjWi4mCTaLBK3+a27HJLFRajnhBqt01TdsZ
 tQXP5DiDhDtaUQ/0ouwFAPVl89gpxOFxhoYummJ8UkomCVAEy9rAz9666Ayu3ns1pD90ZAm
 xg652Z/cXHsLAdVMcwY7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W1Rx5/o2Ti8=:xHUFWwlry/g/uG1aDoOvBn
 4BQYzr88CtLvt9LUjZafFgP75eu0s35quJsrNHzU+W/gvbe34Q6xE70n+hVuyWtOlESOJbIWU
 8A0ELr9pC6dSbVBQGrueqEEAUxmJIOkWOh6ctdz8Av0DhJBpLdDwutWqdSuBLPzmXMr1YBqJP
 3/aM65Qtt6tnXb2h1EiZPigT2z1Mz/0JfNxf9Oax2Dy0HJQbqJ9P+EDZxpKHeHVH6Gzo7EiLH
 gVO2ryrYsUv+dRkajNgvjImovNpfReKS658rcSeRdgIbm2D5TcQD4PBbdqautGi1g3LtOzot6
 Eqrhapi2r2LYKjVZjElg9LCdiyKAe2vtxK1OgFuuLJmkrh9l7ETgoaLiQOTcYI4iDjt0vVanD
 3isQzzTCWIB0E1KaFQpRlXpvE3rePa8itncqiz+fDvMlnL3HsXwEeknmJsjkH2pZBr27V00K9
 8GenPbhzh+6fkv3SZ8L/UsGXr07gsg8IccBLnF8eUr1U6D6D6n1nkWYjErNfsH1TY7MidRCY6
 5F683CkIZ/CyJLxEUaHE6zTHiK37spyQfnwvOq4K2qDfQ8NqrLtVFB0oyduwfceH/goxFb0rX
 PSpDG+PZ/QGKCGkilDv21lrZsSALJS5v5sKqVlG6OVXcDWxwlSRy9ZMt72hQRp3ZPPp1zeg3l
 ngUoXbzT4MuW3rSMsQUClZPTtvza4avNlXu+gdsuyBgOOktahElDI870DrVjffotorMOC4lkC
 ndXvOoLsklBQUeja1xFuGf3WKWk2Qy0ws2HFwX7J7sIZ485ohLJUhGZmPt7GnPq0sOWGCuYip
 hH9zywAEAAT7jzy6k4/UvDZaYVnWiO+y24Ig1GX2u1KBaa9/6Bsn0jmOZ1OwSAW2rXA7V2lP4
 T5d0bp2pFevIGXii629Z0KF6+mueutBAK6hW+GdaPVSki65aJ++InhDwMH7FvQHjh/TQbY6cC
 0bKDezneP5cKJyOTjVMKoWnFzQ3ZbyRA28XqnCFzQVc7f1A2QVpoEN4KfiYvJKZhotrHLqjOQ
 7BviNtNfKqfbUpk6NWwzcod9cA1fUp1UStmUJFzlYplUzAQ3RQD5bzGw8IB7l3HMEFg8Q1bhm
 yviU2/vMSr9yhU0+F7UTQAwGQ8FWNTVGkg4R5lSyFpdR+KMo6sW7ZpbzX//PZ+oIZueKyoxu8
 soV8099ZwRdtmuhYYbytJoBn76eLUPym3XVrf1jfji5LbX+hQaDaOGMhNfRQuzDTv/QQcrLAn
 xStbX6/gvI7Iq6GuwqUmd2zqCkkHSWd18Vivp0MliZ3ciZnlv95ORQoz+evs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 26 Dec 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > I would appreciate reviews with a particular eye on keeping users safe=
: I am
> > not 100% certain that all relevant file writes go through the index (I=
 think
> > that they all go through the index, but I might have well missed a cor=
ner
> > case).
>
> There are peripheral commands that do not use the index at all, such
> as "archive"; piping "git archive" output to unarchiver that writes
> into the filesystem would be a way.  But I do not think that
> qualifies as an attack vector you are looking for.

Yes, I thought about `git archive`, too. The thing is, I could imagine
legitimate use cases where a user wants to generate e.g. a `.zip` on
Windows, with the intention to unpack it on Linux. In such a case, we
would not want to prevent said `.zip` from being generated.

I also briefly considered the scripts that write some trees into a
temporary location, but those scripts typically use `git read-tree -u -m`
with a temporary index, i.e. they _do_ go through the index, still.

Thank you for your thoughts about this issue,
Dscho
