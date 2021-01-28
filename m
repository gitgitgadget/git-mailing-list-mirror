Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0BCC433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FB864DCE
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 15:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhA1PkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 10:40:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:51033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhA1PkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 10:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611848319;
        bh=CA+LWrlF4pO4Cwwj029LFvteiQChjJEzypZhMphsY1U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ftp8leGDn8tSu8b9r+p+pQFes1jgm7yD+5UYOB7ZgeOm1rtXFHJl1euL3G9mlgraq
         4dlFNOEoDF4HK2almqBWBCgOUmcHJQmH/K9y+QtOXk6JXGrxm97w8yz+ry7TVKF5LC
         DUvACKcoAb6ySjm7ycgSAu47ltAg80pSo1GJJ9Us=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.213.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnakR-1loQPa0tW9-00jdYt; Thu, 28
 Jan 2021 16:38:39 +0100
Date:   Thu, 28 Jan 2021 16:38:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
In-Reply-To: <xmqqa6sty55k.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101281636400.54@tvgsbejvaqbjf.bet>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com> <pull.841.v2.git.1611339373.gitgitgadget@gmail.com> <2c2744333ecf5662d4198bdddeee80ff4adf6acd.1611339373.git.gitgitgadget@gmail.com> <xmqqv9bo7lwd.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2101270342140.57@tvgsbejvaqbjf.bet> <xmqqa6sty55k.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:co7VMD/ea14AyPSQJK/OMjjxJjIhEqwMvmd69nURd8ek6Xnfl7d
 nRgwQI+GHhpuwRkFz5tX1lgs/d3X33Q7GrP5uipGeKuI4ZD2ZcIkH6oaY9nWz5b48ZjGpZ9
 c3/N1l8sxUt6um6XGtbSUh2eX3x+nGG1WbjWthVUXUxZOV6f+VWXbjW7NXR3WAbUUaiExw7
 kOD7ptNja+pDhCrsg8rIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ynTBmefmmi8=:2hdviu8EOeEmATI5vDwyKG
 R1BjxSwGOo3sBncKD+3Qx2EyPGzA7LHjgxmOSchOge/dVWXuJhFMs2KQVUE2CK7IjTvTc8feq
 EDD1Ra05A6nZANCWCcxPBC1gDpGcA+lCKgNuC0bM6Q47yfsFlrF7x0sW3mPVmSONWAc6c9kh/
 XR+ocX2FtMtztt/EyyJ4WrEWpxOJhdgnNQlIDvvP/YvQ9wJFab//iX2uMvm+YM7kPAPgamPFs
 yNXiS3Ib2Y7b/jQ3J13/UIAkJtQRNuP6pV6343mHNvF3wxQaImCXyt63FLs46YjZ/q7+1MI6K
 CRHYAN7H5rqvDM4Wc12S8iyPwv9vFmOlQERsOtGGjhPXK9forloxqAUJiwKW+R7YgHR74PNJi
 CG3s8EPCQpmUstVTGD36q60f5f6My6G20VqBHjD5anx9XFp1+N4KK3niqKtFtV3t7VAU/qn0Z
 nNqClVJTQBG06QafL9NSPzrnV8WZKgVRkWY6nHPsVIYC7AbwX8lJnJ0XH7MHZ6VnRIy2VpSDu
 73iwX/dx8SdBJ+nd7ga+SMjqPNvXggVJ7FZqeStMqKSGPdxUo/v98lIASESt/89ruf6uxGuGq
 x6yqPeBjduYhFh0l4KaRaPdI8zMGP5IetyF3Gc8m6eK9yt1WswGCJPl8/n3SaGlMGBlBv4moE
 J73j0ieO3deZRA7fXw7vJsYGBFN3xBpTKTTKG5k1aIXlt7sseh4SCcqhWvycBhkFgUzCcISnO
 KNNYXHIB576wI2HerEbr4w4f6KDJ4KirbyRPQGG11YTmE0pM1XyzM7FoaCperwtbwdPJogp7+
 YIRS2nszRgm46u0dOAyYQjh75o5CKazwijGpM/Ukd62aX2FEiPhuSs0ETCBQlRCNNgpMQZgKj
 G+2oMIXtgUyCsMMqlLoyLG/eaAzv2DNPVUkDqYUWg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 27 Jan 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Maybe I am too stuck with the idea of avoiding regular expressions aft=
er
> > that StackOverflow incident... Maybe
> >
> > 	static regex_t *regex;
> >
> > 	if (strstr(range, ".."))
> > 		return 1;
> >
> > 	if (!regex) {
> > 		regex =3D xmalloc(sizeof(*regex));
> > 		if (regcomp(regex, "\\^(!|-[0-9]*)$", REG_EXTENDED))
> > 			BUG("could not compile regex");
> > 	}
> >
> > 	return !regexec(regex, range, 0, NULL, 0);
> >
> > is more readable, and acceptable in this context?
>
> Readable, yes, acceptable, I don't know, and I am not even sure if I
> want to be the one to judge to be honest ;-)
>
> Have you tried the approach to feed the thing to setup_revisions()
> and inspect what objects are in revs.pending?

I hadn't thought of that.

> When you got a valid range, you should find one or more positive and
> one or more negative commits , and the approach won't be fooled by
> strings like "HEAD^{/other than A..B/}".
>
> Or does the revision parsing machinery too eager to "die" when we
> find a syntax error?  If so, scratch that idea, but in the longer
> haul, fixing these die's would also be something we'd want to do to
> make more parts of libgit.a callable as a proper library.

It should probably be libified anyway if it calles `die()` (I don't know
off the top of my head).

Worse than the `die()` is probably the allocated memory; IIRC there is no
way to release the memory allocated by `setup_revisions()` unless one
performs a revwalk.

Will try to find some time to play with the `setup_revisions()` idea.

Ciao,
Dscho
