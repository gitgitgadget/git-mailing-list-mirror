Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFBCC433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 15:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE4E613BD
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 15:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbhD1PBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:01:31 -0400
Received: from mout.web.de ([212.227.15.3]:42719 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240705AbhD1O70 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 10:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1619621906;
        bh=YHKyj4dUKTxLtnDX6/hvJh8rEJ0m3wEU28Rc7FLU5/k=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gAorXhNZRaL/ZapCSpG4GKGEIdIsSFbIUNQPgJwhVnibOSIWA13pTOee8NKTIdwUQ
         QcLR3QzdFN1GzPgxdKuzINF6B8NcvBCyT0cIDZkunD02Ay/v4ChdiTt5eTTLW1b5nT
         /faQ924dWwFewvajKQ5yD0iZI5kmR/KyNMNHw4Bc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkVZr-1l0mGf0rBD-00cPmM; Wed, 28
 Apr 2021 16:58:26 +0200
Date:   Wed, 28 Apr 2021 16:58:24 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v5] add git-p4.fallbackEncoding config variable, to
 prevent git-p4 from crashing on non UTF-8 changeset descriptions
Message-ID: <20210428145824.43c4t7hkjfqjyspb@tb-raspi4>
References: <20210424081447.uxabqbxc54k6yxrg@tb-raspi4>
 <20210427053916.1977-1-tzadik.vanderhoof@gmail.com>
 <xmqqr1ivauph.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1ivauph.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:G4r4nHqp6DDMP53SLYb6uRL6gfheUAc1p0VEMvaiWmmKaK+9qlR
 cgJWIW9yZtgaagh0qhkd5BBuS7ApnQ5bP731KNn5f/EusTzQubouwPl7aAk502lFUdYPCrh
 cuM9uLqkpW0N1Im7skT/86q/H2nrLFy9yLt9tFG+rvjWT8H6Y3AQhP+7/QU35BE1CTUoy5v
 dZa/liZ3lg5LaJDmrUZqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RkArHOUedu8=:Kgqcyy5kwABetvybAQCnOQ
 Uw4xi+KSoMXV/zOf+OANK4lfo57e5bhrJw2wICCG04o6vMGmpI7RqIabm0R9F2VMgKaSJZB0B
 dvFhrKlpDqcEVvXUygInggYor8hiLiNmoIYFuhTLuAadHrsgq9j04JfpWHZPLW2gSdwLkSs3r
 MUGVE+q6pj3icxVKAesFsVsOdh5lBi8RO526MB/ItbM5tap9md2QlOrotOsbPKEbxvbXfSNYG
 zgA+ehD1KgdadbLTM/UhOdu0EQYtI/+X5HLOSamKb1sLpxlh2OSs1ig/CP5KVUGd5HGWNcmpl
 PKk99hPHwjNeZ8mtRe9+d5AnrMnhhW2yTB5ggkz2Wh+ocN2fj6penIiOG1An7TuQHQDeXAWNL
 oNvzHoLx2zQsQ5NE5ypriHebSDjxEEXLware/rek792pDd36S6qXpPe1cL86fIpqTV1oDnZd3
 LMutKfeoI4JYmLepexyes6r2HhpFF+jcIurTmEF8Oied0kWjPJ1HU+uQ3+RcYp5gcQ1WmNfgG
 UvFoPSIRDMhtxFDu8cqYC7Nbacy2OY4KUZhtSM/FtnOLpWO7O99SkLVAtkba++aCLwRDQbooa
 WqpTGU5Wml0Wf/yUvpW8/tzkmuX0srVncoXglXsbE8/veoTTyvfzUknyl97AA6L5k/WZne/Bp
 uOjfI02xvItQOUVKK3Dz+rug3+udQp/XD2GfMMNytoJBfBDijxeFQzOiRRVvz6SwetRxy8TNt
 kbJKhQiY4Au4R4X+gVDP55jGyGGk0Ld2KnKjEJoPrZdvrhvp8iE7ccpmnbo0inUeAjGq6KSke
 /uxu3FWTxVTHgN5m32C0eKct4cRalOAU23JoOKahNc+fnPTDQm1iji0Dse64TXBE+4pFzHu57
 HHL1LdHP7GbrZqGdd4dvVCMA/kXf3w5Nml0HF9Ln1xmXCf8pE9ql68HyUcU8+eBFjxVQ6fYjA
 aXEBPOOBheVYpcH3JwtjypQASPybFATMlEB3TIPRSzL1zpBxR4nSle018RJCIjLF9WwvyNkrH
 zlNJKNRUABgBaDQNtDMN61k9dQYuZqi2+bC1UEKm7hiBFhnOTDmkIFj6b3FenUxIq7SKGSR9k
 Um37IKq0QGNHOvqBoV0bx4WL937nb8VC/+nHtzCs8dQApGNMgSQmudn5i2km5AfTdAaW5flbJ
 Bcs1ZVol/XidxHTKg0huQVGzsUesm87PKWp+YyBfW1jQKjNygRgQBBCOkODOHeGHb9MNM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 01:39:38PM +0900, Junio C Hamano wrote:
> Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com> writes:
>
> >  t/t9835-git-p4-config-fallback-encoding.sh | 87 +++++++++++++++++++++=
+
> >  3 files changed, 106 insertions(+), 1 deletion(-)
> >  create mode 100755 t/t9835-git-p4-config-fallback-encoding.sh
>
> 9835 is already taken (see 'seen').

In general, this looks good to me.
There are two minor nitpicks to make the patch more the git-way:

> Subject: [PATCH v5] add git-p4.fallbackEncoding config variable, to prev=
ent git-p4 from crashing on non UTF-8 changeset descriptionsw

The head line is somewhat too long.
It should be much shorter, like 50-55 characters, if I recall it rigth.
The first line of the commit message is what we see under PATCH in the ema=
il,
followed by a blank line (that's what we have) and a detailed description
(Which we have)

How abut this ?

git-p4: Add git-p4.fallbackEncoding

Add git-p4.fallbackEncoding config variable,
to prevent git-p4 from crashing on non UTF-8 changeset descriptions.

When git-p4 reads the output from a p4 command, it assumes it will be
100% UTF-8. If even one character in the output of one p4 command is
not UTF-8, git-p4 crashes with:

    File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
        value =3D value.decode() UnicodeDecodeError: 'utf-8' codec can't
        decode byte Ox93 in position 42: invalid start byte

This is especially a problem for the "git p4 clone ... @all" command,
where git-p4 needs to read thousands of changeset descriptions, one of
which may have a stray smart quote, causing the whole clone operation
to fail.

Add a new config setting, allowing git-p4 to try a fallback encoding
(for example, "cp1252") and/or use the Unicode replacement character,
to prevent the whole program from crashing on such a minor problem.


[]

And then, somewhere in the test:

			cp /dev/null "$clone_fails" &&

This should create an empty file, right ?
Then we can use a simple output-redirection:

			>"$clone_fails" &&

