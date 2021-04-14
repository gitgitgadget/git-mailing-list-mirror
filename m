Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C204C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC9961164
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 15:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350556AbhDNPls (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 11:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350497AbhDNPls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 11:41:48 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5CCC061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 08:41:26 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id p206so1958156vkd.4
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ArtjCFKTTZPZIZYQzXTB4UE9BPUMAe7ACv5z9YeNnkI=;
        b=crDltfofAwnmFKNwMUMgumdg64hunGjN7kJmSPJRkh/Q9NNblWla9lc+5nQy3SFQMO
         tOpqgQzexCSS8xYRf3DpOnb9tfEu3GKb+FyHMsgkb8+R+kiKDLqeLAjdBCSX99Ic+sN0
         8MMO4ARgZqGlaIaBtkan5obt1s5sw5CSPPJrJxr0+Vqekk4PLWR6rZI31TeoqqWSBVRl
         3ZXlLAq7wAN+r57QgkuWyRh+R369fP/58HI47CEOdlgBV9z4AKM72cqVjPQ3AmRHZXHd
         UyAOkFyBqF5z7MzG+USK5rrjkNIbQUZbRFnD8McbeAgas+SVDqCC9HhHWTtcMVhlxcwo
         WcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ArtjCFKTTZPZIZYQzXTB4UE9BPUMAe7ACv5z9YeNnkI=;
        b=Xk1dTvYEt181fktrRl8eOWvHMr5ey3Qq7B7h4d2ria/qdOQZj6F0DYbGgZlRKDSRIg
         d6QGHlaNCjJjBV3BRm6vp/9xa2cD05SKTdUWcNIy3J0Yw5ueOE9dWLtxIDdJdGNTRZQK
         FKTiEVOHCDJrAI8dbGb48ykFY/BM8/vjEX2/e2GS0gEh+Va6pzn8hIyXEFj6tCjtBNVT
         NzRbsHpsf9aVbjmA0rkTfvuGDpcseV5mCGT/RJoLSzkopuGG3GRj41oYF3hxIUH+veOu
         fxgDR06eHYdAsM5fkFrnJ/nbE7LA02WsTIXJbxkMpimdCWb6G8HrHPj4EUXPMsInorjN
         t2ow==
X-Gm-Message-State: AOAM531v7MTv2uU0xLhlYKPZXikN/xwYI06SaMRdkEF1KYIRC+F4p2Pz
        kJ4j4zu0vzu8RZknFMp53YUKK8JlhqugT6SwP4FmgXwhgWM+bE0b
X-Google-Smtp-Source: ABdhPJyTE1UzmWhB/ZTTgxYJGcdaBZC8cJZi6qEVL6qoidt+tVw9Sf4eg3zEvPPlxh4ln4sh5xBrD3FGB/LacVjjdH4=
X-Received: by 2002:a1f:fcc5:: with SMTP id a188mr28836326vki.4.1618414885514;
 Wed, 14 Apr 2021 08:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAEaE=iyUGiPK-HX850mEgC=X6atEhbjJ0dCK0dci0nOCahPhgQ@mail.gmail.com>
 <YHYxtvKgKz+Uv2xO@camp.crustytoothpaste.net> <CAEaE=izSNyxRcvMd5bArHnmi0F2G83nouge9e_qxiQmA0AsWog@mail.gmail.com>
 <YHbWtlJDSyuAO+vf@camp.crustytoothpaste.net> <2a8d01d73129$cb798d40$626ca7c0$@pdinc.us>
In-Reply-To: <2a8d01d73129$cb798d40$626ca7c0$@pdinc.us>
From:   Vitaly VS <strikervitaly@gmail.com>
Date:   Wed, 14 Apr 2021 18:41:12 +0300
Message-ID: <CAEaE=iyxs-vgSq2x6Pb0ASCRVoSENE6fwiARmEXObs2wOTt-wA@mail.gmail.com>
Subject: Re: Git via MITM transparent proxy with HTTPS Interception
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vitaly VS <strikervitaly@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your answers and recommendations!

I totally agree that https interception is a bad idea, but we can't
get away from it.

We have been living with this problem for about 1.5 years. It gets
worse every month. We have reached the boiling point and want to solve
the problem without turning off https interception.


> You are more likely to be able to setup a local git mirror, within your s=
ecurity perimeter and enforce a review (think peer review software) of outb=
ound pushes on a non-MITM connection between those two points only. Securit=
y management are much more likely to approve this bypassing your security a=
ppliance.

We have a local mirror(artifactory) inside the security perimeter, but
it's impossible for us to download tons of terabytes from GitHub...


> Yes, that's because you're tampering with the data. The output you're
> getting clearly indicates something is modifying the data. TLS normally
> protects the data from accidental as well as intentional errors, so
> there's no situation in which this could be an accident but for your
> proxy.

> Git will work in this case if and only if your proxy does the things I
> told you, which your proxy doesn't. It isn't a transparent proxy, since
> that by definition requires that requests and responses are not
> modified.

> This is a non-supported use case for Git. That being said - you are going=
 to have to trace out the communications. This is going to start with GIT_T=
RACE =3D true GIT_CURL_VERBOSE =3D 1 on your command.

> You are going to need to invest in the time and knowledge to identify why=
 your Cisco WSA is modifying data.

Think it is. We think this is a bug on Cisco WSA that in some cases
traffic may change. Let's look at the decrypted traffic.

> I do appreciate you mentioning the proxy you're using so we can include
> it as a known broken proxy in future versions of the Git FAQ.

Hmmm, is there already such a list in the Git FAQ?


> Git sends data that is compressed but not using a normal compressed
> archive format. Thus, if you do anything that inspects the data to see
> if it is "malicious" or "inappropriate," your technology will likely
> flag data that just happens to have a byte sequence that collides with
> something that you think is bad. For example, if you flag the text
> "sex" because you think it is inappropriate, then the probably is about
> 1 in 2 ^ 24 that sequence will appear in the stream and you will break th=
e
> protocol, since compressed data often appears random.

Good idea, it might be. Thank you, we will look in this direction.

=D1=81=D1=80, 14 =D0=B0=D0=BF=D1=80. 2021 =D0=B3. =D0=B2 15:29, Jason Pyero=
n <jpyeron@pdinc.us>:

>
> > From: brian m. Carlson
> > Sent: Wednesday, April 14, 2021 7:49 AM
> >
> > On 2021-04-14 at 09:35:48, Vitaly VS wrote:
> > > Thank you for the fast response.
> > >
> > > About our network environment
> > > We are Cisco WSA(Servers SW, ASA, ISR) that proxies http/https
> > > traffic. Client requests a website, network device redirects traffic
> > > to WSA using WCCPv2, then WSA proxies the request to Cisco ASA
> > > Firewall and internet.
> > >
> > > Yes, that our transparent proxy is not completely transparent because
> > > HTTPS Interception.
> > > If network guys turning off HTTPS Interception for github.com "git
> > > clone" work well through the transparent proxy...
> >
> > Yes, that's because you're tampering with the data.  The output you're
> > getting clearly indicates something is modifying the data.  TLS normall=
y
> > protects the data from accidental as well as intentional errors, so
> > there's no situation in which this could be an accident but for your
> > proxy.
> >
> > Git will work in this case if and only if your proxy does the things I
> > told you, which your proxy doesn't.  It isn't a transparent proxy, sinc=
e
> > that by definition requires that requests and responses are not
> > modified.
> >
> > I do appreciate you mentioning the proxy you're using so we can include
> > it as a known broken proxy in future versions of the Git FAQ.
> >
>
> This is a non-supported use case for Git. That being said - you are going=
 to have to trace out the communications. This is going to start with GIT_T=
RACE=3Dtrue GIT_CURL_VERBOSE=3D1 on your command.
>
> You are going to need to invest in the time and knowledge to identify why=
 your Cisco WSA is modifying data.
>
> > > Disabled https interception for github is a security issue for
> > > us(corporate risks, code leak, etc). That's why I asked about can the
> > > git client working with https interception.
> >
> > Many major companies manage to avoid these risks without introducing
> > security holes into their network and breaking common applications that
> > speak standard protocols by avoiding using TLS-intercepting proxies.  I=
n
> > fact, I've worked at a company which was very diligent about these
> > matters and had strict policies on them, and in no situation did we
> > intercept TLS traffic.
> >
> > > Proxy didn't alter any of the contents of the stream(that says to me
> > > our SecOps), but I've not received decrypted traffic yet to be sure.
> > > HTTPS traffic caching but we are also disabled this feature for githu=
b.
> > >
> > > Common downloads with curl or browser from the same sources from
> > > github or gitlab working well.
> >
> > Git sends data that is compressed but not using a normal compressed
> > archive format.  Thus, if you do anything that inspects the data to see
> > if it is "malicious" or "inappropriate," your technology will likely
> > flag data that just happens to have a byte sequence that collides with
> > something that you think is bad.  For example, if you flag the text
> > "sex" because you think it is inappropriate, then the probably is about
> > 1 in 2^24 that sequence will appear in the stream and you will break th=
e
> > protocol, since compressed data often appears random.
> >
> > This is, I suspect, why Git tends to break in situations where other
> > programs do not.
> >
> > If you want Git to work reliably, you can never modify the data of the
> > stream, no matter what.  You also can't buffer the stream (for
> > example, try to turn chunked encoding to non-chunked).  This is
> > something you're going to have to accept; bargaining isn't going to wor=
k
> > here, no matter how much you want it to.
> >
> > I can't force you to listen to me here, but I strongly recommend that i=
f
> > you don't, you clearly communicate to your users using Git what you're
> > doing and that you know this will break Git so other parties don't have
> > to.  I'm sure that the support teams for GitHub and GitLab will tell yo=
u
> > that it's your proxy and that you have to remove or disable it just as =
I
> > am here.
> >
> > > Brian, really thank you for pdf but we haven't Client-end TLS
> > > interception on our clients.
> >
> > Here are some articles covering hardware middleboxes as well:
> >
> > https://blog.cloudflare.com/monsters-in-the-middleboxes/
> > https://jhalderm.com/pub/papers/interception-ndss17.pdf
> >
> > I should point out that this problem is so pervasive that TLS 1.3
> > includes intentional countermeasures against some of the worst practice=
s
> > of TLS middleboxes.  I'm certain that most of the TLS working group
> > would prevent TLS middleboxes from working at all if they could find a
> > way to do so, and many of those people are at the vanguard of Internet
> > security.
>
> While I agree, I work in environments where I do not have the luxury to c=
hange their minds. As a result I sometimes have to develop (very expensive =
use of time) test suites to tease out the secret sauce of security applianc=
es. Sometimes we are fortunate that there is enough money to get the vendor=
 to care and share.
>
> You are more likely to be able to setup a local git mirror, within your s=
ecurity perimeter and enforce a review (think peer review software) of outb=
ound pushes on a non-MITM connection between those two points only. Securit=
y management are much more likely to approve this bypassing your security a=
ppliance.
>
> [I set the reply to header, don=E2=80=99t email me directly I am on the l=
ist]
>
> --
> Jason Pyeron  | Architect
> PD Inc        |
> 10 w 24th St  |
> Baltimore, MD |
>
> .mil: jason.j.pyeron.ctr@mail.mil
> .com: jpyeron@pdinc.us
> tel : 202-741-9397
>
>
>
>
