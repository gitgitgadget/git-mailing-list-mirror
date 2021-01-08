Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8561C433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A912388B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 15:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbhAHPGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 10:06:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:59889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbhAHPGF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 10:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610118253;
        bh=qPNjHgCnsbApdFfe4kgJoZdb//UD5dVjVCZlUqTcGQI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kcDdbghfKzhvmoe7UM/GHtyHifpDImZ26+UZQWKQFYZTgrhxlrUvH7rDvQWLaLY5p
         fVQ/O2d4lh94esXO7DzA5mHJFvMWXCvljx222M6MLLNFNUo3CFj1MuE3/WU+9UgE4H
         28Ib/la1q8eY2k7vBRVVX+M4OUZkKGC4evzwLJ6s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwYu-1k64GW3ccO-00uKoP; Fri, 08
 Jan 2021 16:04:12 +0100
Date:   Fri, 8 Jan 2021 16:04:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Seth House <seth@eseth.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 5/5] mergetool: add automerge_enabled tool-specific
 override function
In-Reply-To: <xmqq1rewl9qe.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101081602410.2213@tvgsbejvaqbjf.bet>
References: <20201228045427.1166911-1-seth@eseth.com> <20201228192919.1195211-1-seth@eseth.com> <20201228192919.1195211-6-seth@eseth.com> <xmqqpn2ivcc1.fsf@gitster.c.googlers.com> <20210107035806.GA530261@ellen> <xmqqy2h5meum.fsf@gitster.c.googlers.com>
 <20210107092716.GA548935@ellen> <xmqq1rewl9qe.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:suByEuGzO2jAMMAoRTToUGkWvwkGJqtmsVPu/stTWdjuransE4W
 llCj9X/WF4XwgGVur13F0fY9UBIUfhHaBRAtoWWUPY0vXGGSPy1nKT0wfB8p69gphTQVhMp
 WMF0V/xDeLAYBw+197qku334iIZXjEfwrSFz98YqzUgGTWl0uIewM7pwDp2nwOiPe5FwK6a
 fL6LfcD3CWv+aae0RhrQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:418aRJ06JhI=:osQ7IL77KQnlF8jlywejYD
 GI1cW95P7etvjpJlsjTEU8qWqbXPK4HroLwGYXaB7xGRKIUAi8YLm6pmhsXQdC5jaQBtpg2i/
 h8uSKiFraxJo7kOMvA3z9Slj5dbMS+AY+tCy0mWfNMqHtB3FbudnngAoYfUSxpCZOpHy0r2y/
 MMdo3vxwB0uMVraV9kCt1D7/oh9SKHLZC5Ynv3ImWzGCtkC4fEFOvCqofEmP0bYuJGlMiCopA
 A4K/A3FRVFsGIZdGAv/4lEB0Z6HjOCPRoVuiM9r7GJVJvgielzErEtHsVH0Qcu5hBECiz9p5z
 V9LDffjRhW2m11G0Bo38w+XUcavt+sLwLMnCJjPi4rXEsxOEMNkcXkCHBu887NRjE1qqG6tsR
 kMTLHXKngg8LLCJgBfMvB1WgOg3pBLMiXO3VQKx7wH58CMrTZtWhpW4j3+tj8V7vOg5wBnfJ6
 +fMRnH+YOZIQXtjbXBENA/9B2xrlzSmMd6uBwDaWnQJKncrDKNi0zbgNdsARvSuowT8tJGsxZ
 UvrD8OzAKxboaa4VJcDFOpEjyEkV1KIVjjiy99/dxEzoGIUKb+aLdfaCFSwEytEu5cEKElozm
 psp5wUIufXW8bbgz940Y0DsIz2RtJklIoWHzU7IYLjBIvKcT5rTT/vNUf1O3zOA4kACh+O4JJ
 ad4KQaTSkNbCOoPyLEWx08qK6IQ44MKyJWNX7QRmfVtVPbFEM0VRG2RHIvt5nwLsCVlZy2hcV
 ROYqm5tuASooByUZnu3xNz/uVhEfio1gXA2uaAuxwbTMzwgRZrk4IP50lMLT2CORd8I2nvbom
 jbjfEgNI126sYJj0qJqEYwFPOB5qmNe1Jr1VqRQq4BaADZca+B1dR/Pt5avyYeG/3XujLkeyR
 o1DErJ63duk0g8XpdakjBaP7tCbXmY8/Bygx7Fxhc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 7 Jan 2021, Junio C Hamano wrote:

> Seth House <seth@eseth.com> writes:
>
> > On Wed, Jan 06, 2021 at 10:38:09PM -0800, Junio C Hamano wrote:
> >> By the way, do you have any idea why we see test breakages only on
> >> macos when this topic is merged to 'seen'?
> >
> > Thanks for those links. I have an OSX machine nearby and will
> > investigate tomorrow.
> >
> > Related: are the Windows tests affected by this patch? I wanted to che=
ck
> > for myself but I've been struggling with getting Git-for-Windows
> > installed in a VM.
>
> On the left hand side of the page I gave the links to, it shows that
> 'windows-build' job is failing (and windows-test jobs are not run as
> a consequence).  I am not sure why it failed, but I have a feeling
> that the build machinery hasn't even seen the code being built when
> it errored out.
>
>   cf. https://github.com/git/git/runs/1659807855?check_suite_focus=3Dtru=
e#step:3:40
>
> So we cannot tell (yet).

There are unfortunately intermittent failures while downloading
git-sdk-64-minimal; That's what this job is seeing. I restarted that build=
:
https://github.com/git/git/runs/1659807855?check_suite_focus=3Dtrue#step:3=
:40

Ciao,
Dscho
