Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D889620248
	for <e@80x24.org>; Wed,  6 Mar 2019 19:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfCFT6o (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 14:58:44 -0500
Received: from smtp-31.italiaonline.it ([213.209.10.31]:56205 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfCFT6o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 14:58:44 -0500
Received: from DESKTOP-E4U7JCE ([158.148.73.124])
        by smtp-31.iol.local with ESMTPA
        id 1cgahvWUnCH4t1cgahoR9E; Wed, 06 Mar 2019 20:58:41 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1551902321; bh=IJqmKY2SJsqoYZq5PI6xmrZOfAKHN9vbsZaj2GhWs80=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=op1yTboBMaatgjYgWpHl1jPr5N/VNAW/0KKm5qkBdAlxX7gU/9w+UDZAekvS16PRu
         0pnuOuXGtCLowm4RJLVWVTM0fkuGBWZVdMp1Wl0QhiJxkxnIHuusw5WHphdbqJ24PQ
         UqaS5ZhMNfCJx+ObNrQiPUL/qLtydjmiPi3f8AGR5z2ged72HBl1a4EbHO1PVwOkwp
         01OyD9kufIVtZ9MIja4xM8qJ8PZeaFQO3M70zHZ9z0UP0c/6fK6Y1aUNtlD3sSYv2p
         OmqlonvqRhKqyyCwuKY6XR1xk1S89owToKvVCVO1qh4oMIWzp+Vua4bCxJIlH/WCRT
         roSNpuhUFBYww==
X-CNFS-Analysis: v=2.3 cv=R4HS5uZX c=1 sm=1 tr=0
 a=lD+Fqu6e8C6S12qGMBovIw==:117 a=lD+Fqu6e8C6S12qGMBovIw==:17
 a=IkcTkHD0fZMA:10 a=UlqV6C1OAAAA:20 a=ZeQt5Yt_D7QRJqUf69oA:9
 a=QEXdDO2ut3YA:10 a=CtvLCtAli4LrSFkZZ_cB:22
Message-ID: <1551902320.1727.1.camel@libero.it>
Subject: Re: Can't build first git commit
From:   Fabio Aiuto <polinice83@libero.it>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Wed, 06 Mar 2019 20:58:40 +0100
In-Reply-To: <20190305191519.GA12791@sigill.intra.peff.net>
References: <1551729517.4092.1.camel@libero.it>
         <20190304204007.GA32691@sigill.intra.peff.net>
         <20190305191519.GA12791@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfP7uE6HUsb9RywHpBExPcBJZLRuUZqd6wk10VeSkmfrr30QBLSLdUZAs4VjoV9sk7c9wi5lb9Qi3HI/ZImiJTIgaLiNETvn/SmL/uc3kUK9uuriQ6wx7
 Yz0xzP17ZLd+nkpY58cBaYHzjSwbJvBd0DWogivlGFwAvYi9D0vGlRDX7ZQspl4G0GJPfyUpQ4zl7GzF0ADAWtvJAd3PHcAq3h4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno mar, 05/03/2019 alle 14.15 -0500, Jeff King ha scritto:
> On Mon, Mar 04, 2019 at 03:40:07PM -0500, Jeff King wrote:
> 
> > You can patch the Makefile, or just override it like:
> > 
> >   make LIBS='-lcrypto -lz'
> > 
> > which builds for me on current Debian unstable. I don't think you
> > can
> > actually fetch with that old build, but I used periodically check
> > that
> > Git v1.0 can fetch happily from GitHub. I haven't in a while, so
> > let me
> > know if you try it and it doesn't work. ;)
> 
> I just tried this, and it does indeed work. I had to build v1.0.0
> with
> 
>   make NO_OPENSSL=Nope
> 
> I think the issue is that some old code embedded openssl's BIGNUM in
> a
> struct, and later versions of openssl stopped publicly defining the
> types.
> 
> I was able to clone git://github.com/git/git with the result, though
> of
> course it chokes no the sha1collisiondetection submodule. You can
> still
> use "git log", though, and checkout older commits.
> 
> -Peff

Hi Jeff,
I've just typed make make LIBS='-lcrypto -lz' from the shell inside the
 
directory containing the whole first commit and it seems to work. I
trace all through the code. Yes the fetch command wasn't written at
that time, right? I didn't understand why should be better to work with
the git code from github. There's something I misunderstood?
Thank you Jeff ;-)
