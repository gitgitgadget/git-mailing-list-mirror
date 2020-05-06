Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3FCC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A7452076D
	for <git@archiver.kernel.org>; Wed,  6 May 2020 15:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="abwI8vx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgEFPJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 11:09:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:50713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgEFPJy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 11:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588777781;
        bh=raNREtm1wlgUHgOiwYSNhm+oF6FAg7WEL3upqMIzXXA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=abwI8vx0TiFcLebvHFvn4WHI7HhE0VtONKDWJtjmoBNlJcgXYAgwzz1bu8DTVX80Y
         Flo9znNvpafZ5OpEamGx7dKv+JAJrOz+DQVjU/aUKh2CmUcqXPgvvVW/7jQ7oqfh58
         eSXhtbeLmyTfhB7iY/lqHNIC3xkLoZqubkzKXCEQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([89.1.213.224]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1jquhW245P-00LmD3; Wed, 06
 May 2020 17:09:41 +0200
Date:   Wed, 6 May 2020 17:09:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
In-Reply-To: <xmqqlfm69il6.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005061623520.56@tvgsbejvaqbjf.bet>
References: <20200504150105.GB11373@coredump.intra.peff.net>        <cover.1588607262.git.congdanhqx@gmail.com>        <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>        <20200504162311.GE12842@coredump.intra.peff.net>   
     <20200504215824.GC45250@syl.local>        <20200504233634.GB39798@coredump.intra.peff.net>        <20200505002055.GC64230@syl.local>        <20200505164326.GA64077@coredump.intra.peff.net>        <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>       
 <20200505182418.GA66702@coredump.intra.peff.net>        <20200505210451.GA645290@coredump.intra.peff.net> <xmqqlfm69il6.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rM+De7gL8DfeVI74nhYTc5qu1I2H4CPMJeX5UmDoQu0PQZA8tTH
 8IN0oERfQWbPu5mgfhhMjbTVc5I3Nrq3FuXobQ/L6l0ffJJnkHh4CJHE6c6RVltNetCWPRS
 ugToMN5JiC6jv6kqqIcjq6Z9IT7I75PdZMjJVGwNZwpnIBRRr4MOAjbUOy3mRKHVJ6Ry3tz
 ySv+K4Hyn4HKiO2AsZ/Xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OK0vEgigs98=:xaw3Y348XyjHXU1lkIlvn5
 +fLM5aUV08opfYZUQxkUiekVDGaIOtOY93qJT0x+9ZDazS18jD8XWpodpekFyzCqWZy4u9SZ5
 +W0nVt0vjDdQ5n+mnkvIrXILyNg3J6H+wdJwILKClyamQ5QGo0GMzWIxk3i5QXGL9tiddo0f/
 W+j7Fq2s4PQC6i7eSs4JGJadjaiEAouAENqhvBoA10Kcx66OgAj9oJf7/1A4SZJr7qeoGgnrC
 3ZTPRMehJkL5tJJkiBHFyfc4vpj0Codq97LKEM9rSCYrbCIVA8SbDPBnmPtmbpIECZCjFouoW
 P3vy6AiQyryKb4nxhnfeTuX76tWAS4bdqzoJiS5JAVVBHZbHZBbGTSrtj2EPmhKXB80KP8cXH
 l74WvX++C/r+01GhabERTb9f0PChnkxQzeAYjjGnG3x7eG9xuAYu5x++CeLPMKQvM92IsRkxQ
 JSslC0oqhgbvyFzhddBoBneBrlK7E1YC/ZpzGfX/UGOKp2OMbk3A1dQ8Y+MnBbj23GIWS59Td
 eDagxbPAT0PyZW/3u/vkvcYNnJtuHG+gVdAyiLR0XDSf6yKejv5AcFJvsNqNvnDvLepfUDFXA
 N/ap/+UbvvBQvTrEdlSubJ6uPqP/j9zhgkiG7JN2WQNdEePq1+mPT9JkuiThSCkerDsBAl3Or
 YaHbJHed0kn+DayRkY68brZQkecbSvWxbu7M3VedwFM3AHxZMOMeWzPz/2iQ++bjfuOsUNaqV
 7DxoLNA1MBMqArzR/LrqIIa53jz/uqqU5anyf1KgRpKBT0QFhcHDTACkHxZOHIkG7DytECvQD
 SLJ/WOy2VdhX1tlRWU6jvOONOuhYdO9Qsl+J90IosmoS8SRPrdQyIUXe+QBvEAwJLq93NlNS7
 yioKYXJZXCXuhE1k4BuuzBWzVFtiyZfhzDYi2h/+cvYoFfooXicMXSiUo9QAg/3k5+ej83nfl
 wlU9++GNW4YkPdlcBazBjuqmwBP8UTtGAZAlfsIsgy9xgGM11gh8PUrvmqLYvNPvtYiTuQvxV
 QOPto7dVd1Cn13M0bKsN+dqf5iLlziplJbhmiqYozue8OgmJ3mzTQXGsWlk61wn4MLexfMh54
 IJ8KF0yHIXv28iH1SJrBi1FI7WkQj/ZY4oCtr7kJksVuyBlaERNu3um/87U3Ko0Z4r5gWNBmd
 peTWZr9WDF1Q4mo5W/pibQz3Zf09Se8dp62f0u+2uf+Pp50AgAvY724g6+87bgkeqKtYeA+5h
 Np7zy89Wrux7nWLYM
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 5 May 2020, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> >  jobs:
> > +  check-ci:
> > +      runs-on: ubuntu-latest
> > +      outputs:
> > +        enabled: ${{ steps.check-ref.outputs.enabled }}
> > +      steps:
> > +        - uses: actions/checkout@v2
> > +          continue-on-error: true
> > +          with:
> > +            ref: refs/ci/config
> > +        - id: check-ref
> > +          name: check whether CI is enabled for ref
> > +          run: |
> > +            enabled=3Dyes
> > +            if test -e ref-whitelist &&
> > +               ! grep '^${{ github.ref }}$' ref-whitelist
> > +            then
> > +              enabled=3Dno
> > +            fi
> > +            echo "::set-output name=3Denabled::$enabled"
> > +
> >    windows-build:
> > +    needs: check-ci
> > +    if: needs.check-ci.outputs.enabled =3D=3D 'yes'
> >      runs-on: windows-latest
> >      steps:
> >      - uses: actions/checkout@v1
>
> Oh, quite nice.  Simple and clean.

The idea is indeed very neat. I think we can do a bit better with resource
usage by not even bothering to check this branch out. Something along
those lines (sorry, I really would love to have the time to test this...):

      - id: check-ref
        name: check whether CI is enabled for ref
        uses: actions/github-script@0.9.0
        with:
          script: |
            const req =3D {
              owner: context.repo.owner,
              repo: context.repo.repo,
              ref: "ci/config"
            };

            try {
              req.tree_sha =3D (await github.git.getRef(req)).data.object.=
sha;
              (await github.git.getTree(req))
              .tree.filter(e =3D> e.path =3D=3D 'ref-whitelist').map(e =3D=
> {
                req.file_sha =3D e.sha;
              });
              const list =3D Buffer.from((await github.git.getBlob(req)).d=
ata.content, 'base64').toString('UTF-8');
              core.setOutput('enabled', `\n${list}`.indexOf(`\n${{github.r=
ef}}\n`) < 0 ? 'no' : 'yes');
            } catch (e) {
              core.setOutput('enabled', 'yes');
            }

Ciao,
Dscho
