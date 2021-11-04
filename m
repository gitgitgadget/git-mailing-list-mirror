Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34332C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 08:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FF4611C3
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 08:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhKDIgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 04:36:46 -0400
Received: from mout.web.de ([212.227.15.4]:37971 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhKDIgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 04:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1636014837;
        bh=nMNBTFlhSmwXVKNdBplx67dhPsyLvqcQCthWSUHGmcw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YgfGMuTGg3zJB9MLDJSwtrJqDy6CN/INbjqt4RLHVTe/Kqw288nx7Ln964D8QawmX
         julXPzklNeXZzS2iEoHylT4j7pQgg+we/npQFDNFHi2FiFE6Ts4t3D2FR6Yy5QzVEA
         S0lgj6dNPbidD5AzCmZXdZYIVoiAwsXXDIg2M94w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMWA2-1mpfzu3OSE-008JUE; Thu, 04
 Nov 2021 09:33:56 +0100
Date:   Thu, 4 Nov 2021 09:33:55 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v4 8/8] clean/smudge: allow clean filters to process
 extremely large files
Message-ID: <20211104083355.wybcczuwktlu2fmu@tb-raspi4>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
 <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
 <41fda423982d99847d3879f5ea1eb3570ae9eab6.1635867971.git.gitgitgadget@gmail.com>
 <20211102204737.3wzphfcd6ne3sj2n@tb-raspi4>
 <nycvar.QRO.7.76.6.2111040109440.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <nycvar.QRO.7.76.6.2111040109440.56@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:F3da10D1Gh/eujvG6A7DqBA9EbwLdih+o8XGvW6U9X17mYRwowL
 dRF6Mgcxsf1zt074Mqi4xA2/Q82yrw1d5VI6YK056jONEidM/8IlspXi+6ihi+QndAGy6Sy
 Bl2VuXK/e9BP1T05SO1VJ+64N/3wrNpqmTmzwChXk1p5yJFVOVrmRMQ2exxjFKYpBF9oNx1
 cROgdT75tuhWqkEZKwLSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:egTvvrifYbM=:IF4/mjLSNgpZRzNcPfDmcG
 CRExOTvyI4TXZsuhpriqTxWY5EXjfZxLcvVWS85uXWuqhiJy8WY7mQ5yI6Yw9nt0hShShwc0q
 rr6ocEQFgg+o1u5qlCO/XQ50ypDjyoEGWfkmDUea/dvSlp9ByDNa4i3pf0mDPdoWnmbOlPpwP
 DdFbFXL51Fd0/C0hsz5dfZAKrJ/oz6mWwmBkPNo+HqejGoPO7t6vnOIZS1w7xKulnpSfNyyp6
 taOW8/CsFxIvn0P17tqTGI4wPci5ydKEOiqMiY8xWvrV7hGujrQQnaBWkRxUWIzdOuuuSVuU8
 NXlbjKNiK3HEucNQYsR6a3dXWRnSICuTKtEx2bZxivtrjCgheZjhPtG45jGblfVB1R69/S1Qx
 LnFd+c0uc8udzH1hZbiybWLzPDb1V+V55LkYAPQhGwLFGmHv6kVdeD64T2vaDud2+Hh+OSWrb
 iEBOfmcuEEghMuOsc3Bf2vtnQitgKQillw/oA6hI3DzIlHlz0AcfZ7K7MNsajy5lA8buhsglq
 z63ihydJhxdp8Y9QMGLnKvQJ0kK96yV242NQL7VsR64ZyWgqU4bkjRS/g7eez9eV5X05suxyM
 +7bCnUkdSagL4a8eYcDvbR9D5wyEpCHBIpGinnj40+7rxkDbxx715srQnRhP811UMUwywym+U
 Us7D9xj3qn0VbP6t7k/UOTdnSHe/MAEa8vSq+a8vW7Aoq7FU56//203c9WPckTdFLPijA6dtE
 2qi07yNTzDb3U+2h93OGqKrwFvg0Tgoi8Ln4PNtFasOIFpl0IeYDB1nrUY2+UZd7iKzYfVcyU
 DT70Fq6VrRNPgYXmnzOURQcgTKwmL07En3aZipT0MBKkhYikK5Obf48ZggzghG6zANbkr8vy7
 cRTUz9fWZoQ1wo8fCnSsN7Cs5eagfboKKXZ/HGIsoa2p+CEKl20H+PKAdL5pm1F6tECrUzClA
 umphI2iOKS4BoE4UcbkWKxYfu8bzaurGIoZ3JasjXqzu2LWCI7lAs+Qi0F0DnHPTUI42jAIqJ
 sNG+qtL0nZMSFcvisD/Kd8rI1HYBs9IW1AachMJ6ovKWNelcQF7BseFLMNh8yjfM8zrz/j5Mh
 wT+RDBUa6VKxvE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 04, 2021 at 01:11:44AM +0100, Johannes Schindelin wrote:
> Hi Torsten,
>
> On Tue, 2 Nov 2021, Torsten B=F6gershausen wrote:
>
> > On Tue, Nov 02, 2021 at 03:46:11PM +0000, Matt Cooper via GitGitGadget=
 wrote:
> > > From: Matt Cooper <vtbassmatt@gmail.com>
> > >
> > > The filter system allows for alterations to file contents when they'=
re
> >
> > Some nit-picking:
> > looking at
> > https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes
> > we can read
> > "...substitutions in files on commit/checkout."
> >
> > Should we use this wording here as well ?
>
> Again, I believe that Matt's command of the English language is pretty
> good (but then, I have the advantage of knowing him and I very much enjo=
y
> learning new English words while chatting with him). I would therefore
> chalk it up to artistic license when he uses the word "alterations".

That was not really what my comment was about.
We have exising documentations about Git at other places, and my question
was if we can/should/could use the same terminolgy here in the commit mess=
age
as well.
This could make it easier for readers, if the same words are used for the =
same
thing.

>
> Since you did not comment on the patch, may I assume that you find it
> flawless?

I could not find any flaws.

>
> Ciao,
> Dscho

