Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81334C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2972075B
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lDEdkgOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgHYLVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:21:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:49159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729958AbgHYLV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 07:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598354480;
        bh=0OsEsiwU5n2VKb+QiT7eaC1+3NDAPLPczZKjdn7LskQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lDEdkgOqy+JewunW7wAUdbs8wgpFs2u+WIio8hPtNLkAcp0gpVY5LCd4B5sgCbRUi
         gujHdC19uA4XQ/sSE2CtlbYqpOt8b9PepE9YP3Fqyz7lOHOd7J1jvailh1YkRXARUR
         CkIFn+688zgtvkeWD3Q1fT+03rvgL6dkTRyzM1ww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([213.196.212.184]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1k3pzD3k3E-00Sg0t; Tue, 25
 Aug 2020 13:21:20 +0200
Date:   Tue, 25 Aug 2020 10:07:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Optionally skip linking/copying the built-ins
In-Reply-To: <xmqqzh6j51j0.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008251006210.56@tvgsbejvaqbjf.bet>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2008170653440.56@tvgsbejvaqbjf.bet> <xmqqblj92lro.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2008241445200.56@tvgsbejvaqbjf.bet> <xmqqzh6j51j0.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:peELSe1b6A4aWu0rjvauRKX1H51CySQaIrOFc8CYUkCHUvux8WD
 Ss7lINb7Y/x6hr1lPptYGPHVSmgl+tiEw2AO2/5Ce5j6HuDx7BpFP0hEnXvWoSvVIKhvOFV
 F86fuQ2LOrBJEk6kvmF64cQtFe6Y8B3RhcB/zI/nEgLxxFctFOwMQU8Qiq2nvNuhnVYtIc6
 jnCwIppWuSrXs5pjtCIKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LYYSGFRJJNE=:659oHqvBirfD4jsVLzLW6W
 qYb1ySQGJC7MY73ASpiPLQu88drWdkAciCq8rykDdHUjBY5CntDTlJXFZCK89/0puUrlPxJTn
 dSgp9gXCG/1bDIka8tAVYiwPEuLCgp7VFooJcBDa00q0M2WSmEVfHK/d+IC7A44wscOLQHYQq
 /OR7LbS/Oy7saqMNGGJx0C4jYP613I38O3XSTTKvKOr03MP0GZsaYkJSA/I3oDRJBFVB53M/n
 jObq3kXvgZ7Tm7IT9DzrcbArnP3Imw0pbXLx/4frYTvKv90wELfZEkoVk7GAKRY+0r+N+QHjQ
 /VAWUgh4sTWiN1edqDVnw8J6paqC2LoLyj+nfeMLVfDsVhL+/AWcCzHonnO6p/usQpKg9/DKO
 V+X9n32mnpp+TZW1uqpMYnns10NlQsHppS2tN4wlJCeOdFJpkIAFbQpAXuIS1oSZ9bPmZ+mtP
 Pwkd/Vq7DOWbOcdXaQf4vrJw9o2QDviUmgEveuwEGGDxf0Y7iEBsrNgG5dDe9I8aSjgUVFTO1
 9TCaNZJEMdDin1UShes8IZToHmkkKbN8z08DM6ywoMT+LVnaBnFKCbOg4swcWF+BKOpFdsLcT
 FADaVL3lYsfjzPzmB9jwIBXSczmQd71BqpeEKEWgFcOMXN7jTJ6Q5/LZMQ2Yt+xwSFKMwjvPp
 FPZPCzXwwXj1Chx/r1caQK99NFHkviC/fwxCpn+YiKampgAwRVPQzKKFnwZphdI7HH16DRnQ8
 bkI4/lMCXrn30HG+GbV21Fa2rbuh8217pGkVEOlfBqi1Qgp00jMUDJqAqicbAZolPruVKe5v1
 oWMIxqMxR1BTeNhg9TVXxd++OOL67GbmzAz4R4hIjW+9iU8hEnN18pdcQESAU22W3VOQGNyFS
 mN37WqeOo3C4bnm2Qusc+d5M62VfjKNY1BUSCjVwgkEVD8QRunsQiXb0LxeSvjWDRXauJl1IM
 PLPFS6PZVNIkfqEfUX5rINZFTbRcU0xO/HnWF7eNuL/jgl1ILANSYGW5kHqRr7vOSvX0OwsJR
 4rqxw1lKicQLfyIiXyoA6IXp12BQlIBdQgfyM8BPW2gJcwO75UiR61B+HTiG4r49dxHIxLFK/
 rx3DaDYJxuY/pRQ1/BGObvgX0OWEoPnBLQerefMTgd0S13e02+n2UKqjxAVyEaYYeBX64+KOw
 9Td9wpYxXRv/p714VEvoTcvHAJ9m1Q5oTKYpxm3SV9Hz69FLTl1db0e+epihp7bCcv4WHnV1N
 LHWoROO/O90hjVUAm6Ur9QL7YujH1wBFlAJIlJw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 24 Aug 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> It is close ;-)
> >>
> >> The author name is correctly on "From:" but not the address.
> >
> > Yes, but the problem seems to be insurmountable, as I _think_ it is to
> > prevent spammers from successfully sending "from abitrary email
> > addresses".
>
> At least, even with only the name correction, the threads were
> easier to locate.  Perhaps you can leave the in-body From: in to
> help "git am" but keep the half-successful attempt to give the human
> readable name to humans who are reading in their MUA?

But if all you're interested in is the part before the actual email
address, isn't "Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com>" almost identical to "Johannes Schindelin
<gitgitgadget@gmail.com>"?

Sorry, I seem to be slow understanding you :-(

Ciao,
Dscho
