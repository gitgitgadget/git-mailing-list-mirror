Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2335EC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E2C20780
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ivj6u+8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgDWWDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:03:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:49203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDWWDd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 18:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587679398;
        bh=BHBPlC7sxLUmQq/1t3/Rg1iKHiidATS8tiXN8YgS/Wo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ivj6u+8gUCRarIVnuZY6NEc4lb/X2ktvMsOKk6QxEQRpSemNeDyuIrsS17rfgHzFA
         GbFSet4IoAizhMnvT3SaJWuGBw4h218izc+EdmEdSZ2DPGPc+Wa8x5X9F2y9ahimli
         QRqKWLh6jiYsseEbat8F7voCru8L1TNI24XnZclw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.237]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MAwbz-1jLSXM4ALB-00BM2t; Fri, 24 Apr 2020 00:03:18 +0200
Date:   Fri, 24 Apr 2020 00:03:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 2/3] credential: teach `credential_from_url()` a non-strict
 mode
In-Reply-To: <20200423212212.GA20669@Carlos-MBP>
Message-ID: <nycvar.QRO.7.76.6.2004232359120.18039@tvgsbejvaqbjf.bet>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com> <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com> <20200422233854.GE140314@google.com> <CAPUEspgJvN6f6Wjo-yjYj-x+bYtC3vdSvwUtrF=MbJDjwYUTdA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2004231433060.18039@tvgsbejvaqbjf.bet> <20200423212212.GA20669@Carlos-MBP>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1962019752-1587679399=:18039"
X-Provags-ID: V03:K1:pIrwNeD+nPKxemp3PUx++OSoXkTmUvvP3P5x7l8uywwp+F5hM0h
 y0RiKpJZmJuUFStWZFLgDEkNAa5HbHC0Of4OL1HmYJv1B+V4esIqJRfJFC0y2Gco5jqo6IC
 H1XuuQeZuuJJ48k1SQ9qufvGSJPIiJlMG8xK411EdlJ5PdzI6Mbqw3xBgiFVPRlrG+AHOG3
 iC1KRphmn01Dlg6t9Jeqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tuX5+pv9DUA=:vuRiJrrcrDgyf6pLAJdaXE
 amwLTUwzhRS4PJ8vi29v4hTNyJC80b0IGVY8i6+FMqMKCxe5jhMDLRnJGV6p+qk6bQ6G43aks
 KoVjF9RgvFcVd5Iq8YVJfmo7nl+Ew6gX7wO5rSSYozhvHUniXBRRf62eaqqFrcIsXK3qrF+0E
 OkVllCLfFxAEFTV0EhrrJriUD26AqgbGt2hnypzv1vEspL+UqhL+ueoGl7uAK2tsucbFYrBwG
 wpKN+gCpUbZiQvoF8NH7vq6081v8DlJSz0wEP6VjKUPsHuBV5MRjKRdAPkKOoYovvhsjJVIBq
 P6+w3Aqs4UuuTVpU+NO7p4yq0xmKasRhzlbjG6uJo69CyCdSbQ8muH29gLpEdFNTbffmPEqHH
 KSyRP/rGzkn0spRC9aKieHwge0JJ9BphZGQwlY33PSOknD7huTh46MFxCy5hW95I8hGeeqUpY
 6HWnYHd9zHhifdwZhEMqVSODu0jU4qKkII+qURnatlX7mWqby9eSMEE/da3sEZjldvn09wWbO
 K6TRiivzMczJ2jRnpi2D6DSXuQQxiacob7PnC8I1mAOAOZIwCVt4ZLdwdTEwAG/MiyK9E0ZI9
 o2etaOj0TkNsXC6Yo4UYye1sU/iqiT/YFIgT22d0okISW4e4MlXbSSPk8x6vMip6nBt9NrrGD
 v3+rBbP4XeF6c98AGzMT1sjRVyxh/oPcQWwrBMR3g4vvblUueZyhxt6oBq+AHkoAfVWbpTRo5
 FQnN/PdA0K0id4tr4Pe3w7ls0rivfGg0t1aFKYQwmH6eQ3lXL0CRGjGSaT/mm1AQ3PncY8Y+K
 cMX/d848Ktey63qt6pbd7TNVmqKGxvgslselryKubbyOMWpn4ATeZRVUw7PZRo+KfwB4VhBMY
 nXwO0KAYrMzWpf/ztp608u+PQLPLUyKKFWxS7Hr2Mtjk8xYtsOwFCNwXT79exoIrJKhx8GLST
 X3QXxmTzCiMfADkLsyEhsX01mGPbi0Hww61VghuXDj0+BMtH/ll5UtJzbc0XFCn3HhXX35CWN
 +jVC39SdH/7FG0f8TFG2gaz7BZcxioLyB/xnHBi9q2FQ4ceG3FtDSN9DxktPAk3xnch6+6mps
 vXgCGNAjCvw+Yw0VvkXmOXo0yzJs+iQwGXTVLQJpCAcw7CPs1RexuvDdgpFa1w1A0278GXJc9
 5qVnluiadA5tAz/eApiTptCJXci3la0ZlN8KwSGqkLCGZ2J2VpwOv75GofdgJp/mNhbljKy5O
 Od0cgOKg/GpfzoHl7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1962019752-1587679399=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Thu, 23 Apr 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> On Thu, Apr 23, 2020 at 03:28:13PM +0200, Johannes Schindelin wrote:
> > On Wed, 22 Apr 2020, Carlo Arenas wrote:
> > > On Wed, Apr 22, 2020 at 4:41 PM Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
> > > > Johannes Schindelin wrote:
> > > > > @@ -382,8 +382,10 @@ int credential_from_url_gently(struct crede=
ntial *c, const char *url,
> > > > >               host =3D at + 1;
> > > > >       }
> > > > >
> > > > > -     c->protocol =3D xmemdupz(url, proto_end - url);
> > > > > -     c->host =3D url_decode_mem(host, slash - host);
> > > > > +     if (proto_end && proto_end - url > 0)
> > > > > +             c->protocol =3D xmemdupz(url, proto_end - url);
> > > >
> > > > What should happen when the protocol isn't present?  Does this mea=
n
> > > > callers will need to be audited to make sure they handle NULL?
> > >
> > > the previous code was ensuring protocol was always at least "" (albe=
it it
> > > might had been easier to understand with a comment)
> >
> > I fear that my patches did not make it clear that the lenient mode is
> > _only_ used in the config parsing, in which case we very much do not w=
ant
> > to have the unspecified parts be interpreted as empty strings.
>
> I think the concern raised was that since we are using the same function
> in both cases there might be unintended consequences on changing the
> semantics for the other case.

Indeed, I share that concern. That's why I wanted to be extra careful
there to make sure that introducing this lenient mode does _not_ change
the non-lenient mode in the least, i.e. it is the reason why I kept 2/3
separate from 3/3.

> the argument made by Jonathan to use something else for configuration
> (as is done in master) will help in that direction, and might be needed
> anyway as your code it otherwise broken for current maint and master,

I am in general not a fan of the idea to have two separate parsers for
essentially the same thing. In this instance, the difference between the
lenient mode and the non-lenient mode is so obvious that I'd rather reuse
the same code (think: Don't Repeat Yourself).

> but if not possible (maybe later?) something like this could probably
> help :
>
> diff --git a/credential.c b/credential.c
> index 88612e583c..f972fcc895 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -389,8 +389,9 @@ int credential_from_url_gently(struct credential *c,=
 const char *url,
>
>  	if (proto_end && proto_end - url > 0)
>  		c->protocol =3D xmemdupz(url, proto_end - url);
> -	if (slash - url > 0)
> +	if (strict || slash > url)
>  		c->host =3D url_decode_mem(host, slash - host);
> +
>  	/* Trim leading and trailing slashes from path */
>  	while (*slash =3D=3D '/')
>  		slash++;
>
> changing the condition there as you suggested to Junio would be a plus I=
MHO
> as well as getting some test that would excercise the new warning that w=
as
> introduced in credential.c:57

Yes (modulo doing "greater than" comparison on pointers which is IIRC not
permitted in C in general).

Ciao,
Dscho

--8323328-1962019752-1587679399=:18039--
