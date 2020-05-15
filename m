Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11607C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED2320643
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d5MvLp4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgEOVfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 17:35:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:43505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgEOVfO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 17:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589578509;
        bh=3hmJCiTV3T0zbqE0H+3dtfgjoms7tv2x1dGb0/Gny/M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d5MvLp4xUYe0YkkwIXNbvxP/de522SPbO05Shp/miZJ9RvMSVJatDSkiZJDpfW7gg
         OJvnq++U+caG6LBTJBd3E5BlFLFtxcNMErAPqAlfKicTjLwbWZSpA8OzMS98JFO3bO
         mc5f1PRSEB8aBLSWhYSaLinFE0EHPLEl0+WzbMkc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.131.160] ([89.1.215.229]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1ijvAe0gw9-00qE2F; Fri, 15
 May 2020 23:35:09 +0200
Date:   Fri, 15 May 2020 23:35:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] ci: avoid pounding on the poor ci-artifacts
 container
In-Reply-To: <xmqq4kshnsjz.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005152334550.55@tvgsbejvaqbjf.bet>
References: <pull.632.git.1589316430595.gitgitgadget@gmail.com> <pull.632.v2.git.1589529318969.gitgitgadget@gmail.com> <xmqq4kshnsjz.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-341061325-1589578509=:55"
X-Provags-ID: V03:K1:c+ay/pI2eH4+Y3h6aM/N18IedALwonvGdohPCqmPC+11afMKEbb
 YwcRKxYciMJvjnAmfWg9McHsvlK6GzgbxySAJ4CgRul4xET9r/hi6AMyjhbyAfnD5iG+UBH
 6TGosRUHkPEV1Wo6zuAWPTwVbQVxOWUM7LHHmCSSYj1eVpcCf08CvZdWGI5A84RYSBvQgZb
 auI6sDSqcWsdCXZUrkXCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PfCYMSyoy1I=:G2hSfsIih1UM8RQ/EUE7Xl
 EgS6aj9WfslL4zMj6z7UPfJAqkAk933kguow7iw5Wf1s5KFgXGqmJ2+g+hNIK++P+ruot//3n
 m6pimD9aSjEnWyhmWceJG3lgR2zOAtlUtLv8Z0fRopeNmxvG4AOG3bksVMvR18N1id9dXb2a2
 2MG3OgZh/4NxWS/xX+ic0l0sjQ9Z5H/GJNf/brd5fjXy+Lb1230dp/ZVv2b3R8CzP3oTCu+D4
 3S3EVI9LNLctdYEk2fDIivgGTIEbx20UzSf9/oeVZ+6uFS2CcpEjD94tbRo4oyKGBRwFHALiO
 be42T7r5Pycvq7lm/i5E8wt2XOVoBTrqqAb2iVGWOT0MAwnEp6vC2a+LIyaQJwPHHQVvmJUhz
 frYTAR3wRal0lQWDFpAiPaZcQafoSCtB0yPkGWx9OB64HnRe66CzDxsy3WMDWgDneVjQt65dN
 nReXOWxrtMaoxy6B/2l6uI5asKwJfxPk1tJpVu5qwaCxs5M9t8I02TReXUy6ExlELeh2tcefn
 X4nK3tIl3qtBEDRpLxfbY2rahBWHOjWDERIBRL6iGfyv0WHk3chxOtefAPMd6n2wLXV2Cit9f
 3WowbmvdrbMo44saEv4NJViDX+Pqpw18LP2WsLbRsMeBPQL3DysQXLPHmkONFboVxOFvKQL0d
 lV+bNLS6IOK1bjuZvG5NfIxOBlMgqH3dCnVzeL8kcXzwNqn5YjJ5UmrLB4lf1fTEHH9MmE/ET
 LXfOLem8hYqEJjbUPo7/6z+JDWJFe7Tl4jA8thrzDj0zyAJRqLN2iElE9ZNofF1olMj4xuhFn
 zynovglk2ENQC1DgSu+jde+LtvvQQ5IfVNmWGStQ0ytv2m8GdfmZKtUBL0HFTxiGDpV36Z8He
 GMgbD0VjdmJGT72+8q/WjOIu4wGVnk9aHkJz7eQ8paBKETrkxVmfuBaggq6ZQm+3TwPvXsppv
 yoFRi3RzU14FssiX/jZub8OGcuEYcDwlIhS/mErQxOXnvhjrFF+w4Dc9C50VVQSMV7SMExjRV
 D4DXPKTUGSYir2okA1SOQxHO8jU8J1+bUpNGRT1+novB/Xlv1rSOv6JAqbevOYsofZPwBMbVs
 zTDyWEcAZKv4q0dilY09WR8mrC0JtD80TEdZYmLlDtbgYxz72sQ0SKWrOf/kz6hYO7UoKiWEO
 7M09SozgCxEFLcUG57sXPGmJh0EYIYo47zf/I89/qNAX4k/6LmEJZmfqen8Rv5Doz17k9av2W
 5q0meDNSf6OIF657g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-341061325-1589578509=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 15 May 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When this developer tested how the git-sdk-64-minimal artifact could b=
e
> > served to all the GitHub workflow runs that need it, Azure Blobs looke=
d
> > like a pretty good choice: it is reliable, fast and we already use it =
in
> > Git for Windows to serve components like OpenSSL, cURL, etc
> >
> > It came as an unpleasant surprise just _how many_ times this artifact
> > was downloaded. It exploded the bandwidth to a point where the free ti=
er
> > would no longer be enough, threatening to block other, essential Git f=
or
> > Windows services.
> >
> > Let's switch back to using the Build Artifacts of our trusty Azure
> > Pipeline for the time being.
> >
> > To avoid unnecessary hammering of the Azure Pipeline artifacts, we use
> > the GitHub Action `actions/upload-artifact` in the `windows-build` job
> > and the GitHub Action `actions/download-artifact` in the `windows-test=
`
> > and `vs-test` jobs (the latter now depends on `windows-build` for that
> > reason, too).
> >
> > Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmai=
l.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> >     Change since v1:
> >
> >      * Simplifying the scripted code by using jq (thanks, Danh!)
>
> Thanks, both.  Will replace and let's merge it down before -rc1.

Thank you!
Dscho

--8323328-341061325-1589578509=:55--
