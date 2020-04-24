Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF651C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D04D20767
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lxmAdlGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgDXLgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:36:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:55957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgDXLgo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 07:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587728193;
        bh=rBU8+Nfoz8JWshvse2WLaPqVucqVWuI25dqC7sx9RPw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lxmAdlGyJXkw4/mnPW6S2lGaVc5mT75p6ToyyUZ7vi2F3OUxvEHK3C0kn6melvS0T
         taGsE3ZCdO/wcNLHOUzObbwY2Ca1z1jCOFNwiWws/P79C1XEhJMcOhTNl0nItljrur
         N7iiWXa8kcc7IdUcSqIBncj1aAv0ERQ5/Fp5pNGQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.1]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M8QS2-1jWMU51wDA-004U0c; Fri, 24 Apr 2020 13:36:33 +0200
Date:   Fri, 24 Apr 2020 13:36:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH v2 3/3] credential: handle `credential.<partial-URL>.<key>`
 again
In-Reply-To: <xmqqlfmlemxk.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004241336170.18039@tvgsbejvaqbjf.bet>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>        <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>        <daedaffe960581733c25383a2a1b30056a415594.1587685397.git.gitgitgadget@gmail.com>        <20200424000558.GB20669@Carlos-MBP>      
  <xmqqpnbxen6h.fsf@gitster.c.googlers.com> <xmqqlfmlemxk.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-146235200-1587728194=:18039"
X-Provags-ID: V03:K1:BAcHXs+olBerOxYGfhtf9+QoBcz9oPAh+OWH2GB8MOdAriC7wUb
 hokKz0p1Ou3OTYAFv0YljyJ5GHm/NpgdRNd3DEv+jOEvDZN/VAUPqoxP63nphSp47+28rw5
 JQZKEnjhdVsbxh1M5NUbgkK9befrlOp7bOrcsidJAgiZZq5LGpAKfCl227UANyMZGgiE20h
 KjpRcTqNTUorxaI5/j5kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bup+/70IQ54=:HY2A+1tmUYlVEsQr+74w6n
 iQSl657GbT6Hs75vw4ju7gl9AaoSM2YGW2RUpVL2fd+b6SdKU+3xd7dKd2ti7yeTGyWw+lyjG
 pK4qylE+QZsQPW0Tia1ljVlje+t5PRZhRia4R++ucONNop/vf37/OnSrjj9HvuOTE9kH7pwx7
 xHU0B8hjWM5q2TturcU+uGBpkx0fgG71d7shfKd6RzeesSfz/VPX0F/Axyy1ZF053U4reusIa
 RN+CBCQOAUwELv9hcUdHntIBoClK/ZWRXmXn4kDDhFa+N31Bo7LJbeI5XDoOQjn/RuYlW6rfr
 /Qb58aWVt2c6Y4+1OAXJOb/aRHO1FYM7AMXQGSHl+7z2JhYZhIn5rM7UpJA4vNgKej3prmgaK
 2JmWEOFwQNzUwL4urhtCXy5AZOUFEyws7PmalfBiZwioy1C8uznmo5nhpft6/EKvUxHCybgZP
 keNuA3p0bAoGXQNrB4zutLX+Cw7Zpt4lYc00UTvkfw/YerqH7UX6KV/m3kADITJ8Ic1MlUGtL
 AXZ4kFHmNZLgnK6MRKAQ9eaQuCAcl03LjXGmH4xdYZaNSEKT8E/OCG8RuazFnTOSO3JDFIOoD
 OfV6ayDKVPJe+5lF0qTiA1bcNXM++UsqmmhE61d2AAg1xuf9xdpzM60mII9e9PCL8wm+nBAaD
 n0hVti0KmZp3XSns8mcZYcIuLyRXFY7Dh4+pfXqYbRaKRjp/cyTw3wb+HfDHrHTYc2cd3DOUW
 6viiDUKJy0bbPg31iKz1JBlykgMOj+tzgkrvzNmMCxVNTQKIzOZsm5JTfhqdvSNPwF5qAAq21
 JHahnwCoOBvpesuqnFtoYcLdWdF5AWRAVC5NCmJND9YJSsyPcgjTugjd1V2GcNujhpwEMpFfa
 XnuCE4qjCJh+DVm/l0QMxJOEsxYyJEJQwX44eqo+nvmFAI1F7OVX+rTYF/9bg80Yg46DEuJP9
 Ga5IdtyIsaw9kdGcXcVShlv2FcLBHPC3DcohY7r+mLuZjTkg2inIUZEzsC+teVw1LHmeQOIpn
 1UXv006Lv6IdjdKvLEQM8wLTNPg+C143ISSMq2m1uU+luFD9M1dm7/b4d3Nva1B3H3Ec+FckP
 FJIYqt5nIypmnu0GJzhQ2+ntI2C/V0F3qqP2JFZUOyJYi5L45hw6aQQwOzdHPF0amPwWEt71C
 V3uvheE5fUmWW27sOjPFEt2eDJW8KMw+rimuR0BMM+PCutWLdB12vScFqphJv48ykduy/t3Jh
 iNDDfai92gun88upq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-146235200-1587728194=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 23 Apr 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
> >
> >> On Thu, Apr 23, 2020 at 11:43:17PM +0000, Johannes Schindelin via Git=
GitGadget wrote:
> >>> diff --git a/credential.c b/credential.c
> >>> index 52965a5122c..3505f6356d8 100644
> >>> --- a/credential.c
> >>> +++ b/credential.c
> >>> @@ -53,7 +53,13 @@ static int credential_config_callback(const char =
*var, const char *value,
> >>>  		char *url =3D xmemdupz(key, dot - key);
> >>>  		int matched;
> >>>
> >>> -		credential_from_url(&want, url);
> >>> +		if (credential_from_url_gently(&want, url, 1, 0) < 0) {
> >>
> >> definitely not worth a reroll, but just wondering if would make sense=
 to call
> >> credential_from_url_gently(!quiet) here, just for consistency?
> >
> > Speaking of which, it is not clear which one of "...url, 1, 0)" is
> > the "quiet" bit.  I somehow thought that somebody suggested to roll
> > these two into a flags word and give quiet and the other bit a name,
> > and after seeing this line, I tend to agree that would be great for
> > readability.
>
> Ah, I should have checked before opening my mouth.  It was this
> message <20200422233854.GE140314@google.com> from Jonathan Nieder.
>
> I also am OK with his "two thin wrappers around the underlying
> helper that takes two separate arguments", if that makes the
> resulting code easier to follow.  I have a feeling that the caller
> knows (from the context, or the reason why it calls the
> credential-from-url code) if it wants strict or nonstrict variant
> and that is not something the caller is told from its caller.  And
> if that is the case, "two thin wrappers" approach does make a lot of
> sense.

All right, two wrapper functions it is.

Ciao,
Dscho

--8323328-146235200-1587728194=:18039--
