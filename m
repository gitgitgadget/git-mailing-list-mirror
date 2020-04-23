Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE8C55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A87D20784
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YwK+/HmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgDWXWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:22:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:37419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgDWXWw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587684159;
        bh=FQh56TeFYRyYmRVQXTzelrFj3FFLs6ug2HN9LOjA6T4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YwK+/HmZR+CdnNIdgGQeNTJnyQE/aDd7nA0clFdcHdJgkz6MEHN4RBPzx06MdixD8
         SeTq+2dykQRVt5gLr81CIAqqIHdDj7XT7vZwt7HtIY/mQK3R8vaK5YHWwcSapAd0nE
         5ebjmBhy16VO30J24oHlQUrdAu3/J8FCl16ii8OM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.237]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N4hzZ-1j2MOG07iZ-011fGD; Fri, 24 Apr 2020 01:22:39 +0200
Date:   Fri, 24 Apr 2020 01:22:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 2/3] credential: teach `credential_from_url()` a non-strict
 mode
In-Reply-To: <xmqqtv19etkx.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004240121180.18039@tvgsbejvaqbjf.bet>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>        <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com>        <20200422233854.GE140314@google.com>        <CAPUEspgJvN6f6Wjo-yjYj-x+bYtC3vdSvwUtrF=MbJDjwYUTdA@mail.gmail.com>
        <nycvar.QRO.7.76.6.2004231433060.18039@tvgsbejvaqbjf.bet>        <20200423212212.GA20669@Carlos-MBP>        <nycvar.QRO.7.76.6.2004232359120.18039@tvgsbejvaqbjf.bet>        <xmqqy2qlette.fsf@gitster.c.googlers.com>
 <xmqqtv19etkx.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cg3fYR2XkhSVWKpQgzAQXmMrLe2iXUknhRnt9BQ4JLiL64JAPgl
 aloh9qRO+mJAl8qMPCPnVTEv+nC6yQr1/YjVOFgJCMTwMs+6Qt28CmN4rococze6p858DVE
 4NYU1gx3LbaReywQJ071zmAWQOigkWR0PTmJY+pns0GsEC9G9Mp/75g5DJ6001JhJ6wK7a8
 RjwTFUvUva95t3fqQOqAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RdyG/K0GRPk=:uCuT8QomERVfcmd73qoGJR
 J4m0SJpzmDKBnIWeK9wAgUUW2s9Tvq0wP6Dpw/4a3+uidYmUT4N2xXWMezRUUKl9h0muLsC/p
 ZkpWx70kbdTQUJCryjBlsTqEweq0OPO/0mAiGjiD9JwSIIH5271/bqlh2iTbAd74Z3ZjPoaC6
 DDkwl52XSKPnpzVcoakzZagB6pE9Er35PsyESf6FKNOoo5kwarkerYDo2ah/qz/DY51qNKTDM
 rgU2K0oFIvagzNIw9usjmpfV7Qx+80tzIx0bxkO4tuY2gzn5AqPHqCsgA2u6mwGNHoFPg05zX
 GPc3gwnM//S5bylmIb8lXxhkoopvzR9/E/OMnA4a0NziOP6qnwZWaRRqV47K34sI/TUmCB9zl
 30eimDAAELlG6yjT8+N78zd0B/KfR2gszPhEdemDy/j7ug7mMUl0w7Q0phfmww9Lk3FeCBUjr
 wx+Oc3/nahVGGrtkPlBRPEzQyYPOTrndw5hj9LTsIreubABha6qzBhZjogQBcDfFWGYM0HeCV
 yQd1b4H8/N38Oq4TccntwDjZgkMCnZCZCuJRHOkkXkWrAshPJe2YtY8sQjUPkHavq3QqHjqrH
 9GFD8f0EVrG5mszuNZY3pJ89FA0nmUMbFrwT/BzMGJWIYFON+Hq9SQs4ulpU4bY6oAVl+XY84
 xNpcR2nRHbAknygiI3wnJJjarCAQc0IXx+K4f/EqSKBvI0yTfxZ2hFthNHDuTnnK1YgKKUWpE
 9GPTQpMjWTsB5petvIYqjFw7dJrGYI9NDqVRLpWduvkZPriGIAJ2TV9U4OeC93c/0M8fJH0BL
 OG5PAKaiWyPDo5VncUDwk+yxJk0qRnxPu7Xnet0MoERXCdkAaJxnXaRlQSEPGO9/XvJkuxelR
 lN5kc0niFxQ6/br+gLJpXTY4DnJlgYMpDx5GzL7idG6e9L/T0mBiXHp8EchTKSbUN2jCQUxC9
 +9S/Ms0kzNA9yIxoPUPhoRuxcs0TAQ4KZKYa9RDj0MuccQpTKRLxIJYckp0yPRxj0+aSyXJ2o
 cwUlv0QYd0cl9GkCiGY6uJooIR3ExgU5awKyZf+nHFoGI8DSa8KvBokprIH364tpb6oWMUb8O
 sqh6xAOaG7mYOVzj/ZGDOVYiDhiu/T7TOJGe0ARf519wE8gO0Syzl68Wj9tDg7bT1iEzqZGy3
 3WmXF9FAPHMN9YVHWS9PM8SFsM9pVRTdc0VPKLzM9V7f1zWbVbZD2k1VaMOOupZrGBxUX1PZY
 plTHOv65yjg1LpZNJ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 23 Apr 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> Yes (modulo doing "greater than" comparison on pointers which is IIRC=
 not
> >> permitted in C in general).
> >
> > Of course, people write a loop like this
> >
> > 	char *cp, *ep =3D strchr(string, '\n');
> >
> > 	for (cp =3D string; cp < ep; cp++)
> > 		...
> >
> > all the time, and forbidding pointer comparison would make the
> > language impossible to use ;-)
> >
> > I think you are confused with a different rule---what is not kosher
> > is to compare two pointers that do not point into elements of the
> > same array.  Whether the comparison is done in (ptr1 < ptr2) way, or
> > (ptr2 - ptr1 < 0) way, does not change the equation.

Yep, that's my confusion all right.

> Having said that, between
>
> 1.	if (strict || slash - url > 0)
> 2.	if (strict || slash > url)
>  		c->host =3D url_decode_mem(host, slash - host);
>
> I think the former is moderately easier to read.  It still has the
> same "Huh?" factor that a comparison between slash and URL guards
> the size of the region being decoded, which is slash - host, and
> makes the reader wonder how these two variables, URL and host,
> relate to each other at this point in the code, though, either way
> the comparison is spelled.

I fully agree! That's why I use `strict || slash - host > 0` in my next
iteration (actually, I decided to rename `strict`, but that's beside the
point).

Ciao,
Dscho
