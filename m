Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D58C43466
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 15:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CEB20866
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 15:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB0NGprY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIUPZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 11:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUPZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 11:25:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A65C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 08:25:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so13225700wrx.7
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1Rr0fHiJg2sJBl2WymWitWzCPXZTuoD5RncjPLsUZq8=;
        b=YB0NGprYn7RnmYG7k8j9bUeaM0jEZ0/HvA47rTE6WiotRr9mQKxAttXVRcfUiKEWIj
         kdmblniD2FMnxLaOh3rgPZZvnsW/Lreg3LEzvADKKrWkvcdV6JMFaiioDZRlCK1Tl9hL
         +JeI2bzO9+MiQKyJaeWCSA7rizHwJib1iQiLBm+wOY4MQXKlslgiai5cJKnGr1s1vXdc
         YZLHfUCtPtxWLkPfpwPnOb9j13InQJok5nL6m2SZGYFp3t8jfB8F2ItI19TM0IwalU98
         0/urvR0hGpdsWTvIu3UZvMHW9V2dv4S0Spiq65eZsfK1HlJQ5yTvM9Q4oxKUq44C1c/0
         TENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Rr0fHiJg2sJBl2WymWitWzCPXZTuoD5RncjPLsUZq8=;
        b=kBxpbDAejQgDDivPdhkkmqc27DbBshFw7JbFPuySzABuQrzw0HBU734y6oS5j1GQuO
         YsWMb+bJUF8oFp2dMq3dNuPjZTarfOVGuX5sS2JUu3P0oz4e2POdea7vL3kXHBYyITGA
         37ej4R9ue7/pAwoUwXt1aZr89/Do9Vy1vAecypz7pqIbl1KLgV6TCY1NfRlG6ZtFP9Ao
         N12GC33pa1QzTmczpGeraTxcpiwXAlsOg2sCXIsrIaZUhd4MQwnERGzvr1gDwZbnlcqo
         WfPFgjeqZC09DvxrbMWNzYQ/B8YtsV2wxvG4SNC16/EQVnqZyNTrNq9BYsZsZJwPJxIM
         lruA==
X-Gm-Message-State: AOAM530vZ37ka7RaXkNaPK01d48Sjz1V1T7UoC/QODriQQlL2sEdtNgx
        x1c9/zhFI/+VcDX3XJ8htHePzjKZBvPSJXNIKEg=
X-Google-Smtp-Source: ABdhPJwuG/IGhwVphTVFuosrI5wiExWJrf8ccwnkwPRkMIyGy1MedA+7+D9JGqInJKjqdjK9MEHbrTbMVtJ6o2Ip6JI=
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr291029wrx.3.1600701905486;
 Mon, 21 Sep 2020 08:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200918222103.GA3352870@google.com> <CAN05THSUN4YToYRqWUxZ0r2=wVxJU0V2iWumx1jjx=eTQ7rAYw@mail.gmail.com>
 <20200919195545.GH67496@camp.crustytoothpaste.net> <xmqqtuvtiec8.fsf@gitster.c.googlers.com>
 <20200920161652.GF331156@google.com>
In-Reply-To: <20200920161652.GF331156@google.com>
From:   Richard Sharpe <realrichardsharpe@gmail.com>
Date:   Mon, 21 Sep 2020 08:24:02 -0700
Message-ID: <CACyXjPxAXgpEmK0buarb3ToHwnonLM6TG9-J-=GysXfGkmsSrg@mail.gmail.com>
Subject: Re: [Wireshark-dev] Joint project with Git for outreachy
To:     Developer support list for Wireshark <wireshark-dev@wireshark.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 21, 2020 at 8:01 AM Emily Shaffer via Wireshark-dev
<wireshark-dev@wireshark.org> wrote:
>
> On Sat, Sep 19, 2020 at 03:36:23PM -0700, Junio C Hamano wrote:
> >
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> > > On 2020-09-19 at 09:12:53, ronnie sahlberg wrote:
> > >> Hi Jonathan,
> > >> Hi Emily
> > >>
> > >> Emily, you want to contribute to wireshark? That is awesome. I think=
 I
> > >> speak for everyone to send a HUGE welcome
> > >> your way and hope your experience working on and with wireshark be e=
xcellent!
> > >
> > > I think there's been a misunderstanding.  I think the proposal was to
> > > have Emily and Jonathan, who are both significant contributors to Git=
,
> > > doing the mentoring from the Git side, along with someone from the
> > > Wireshark side.  I don't think we know yet if anyone will be interest=
ed
> > > in working on it, but it seems from the response to be a proposal tha=
t
> > > has interest in both projects.
> > >
> > > Feel free to correct me if I've misunderstood.
> >
> > That matches my understanding.
>
> Right - brian and Junio are correct, I'm hoping to co-mentor with
> Jonathan. Ronnie, I'm really pleased to see this warm welcome, which
> makes me optimistic about the kind of experience an intern would have on
> this project. It would be really great if we could get a volunteer to
> serve as point-of-contact if the mentee is not sure about something
> they want to send to the Wireshark list, and possibly to come to an
> introductory real-time chat (video/voice/IM) to provide a little
> overview and nudge in the right direction.

I am in the Bay Area so I can serve as the point of contact for some
geographies, while Ronnie is in Australasia so he might make a better
point of contact for those geographies.

There is quite a bit of information in the Wireshark sources in the
doc directory, including several README.* files. There is also a
sample dissector in doc/packet-PROTOABBREV.c

However, it can all be a bit daunting for a beginner so I am willing
to help get things started.

I should also point out that there are many people on the
wireshark-developer mailing list who will be more than happy to help.

--=20
Regards,
Richard Sharpe
(=E4=BD=95=E4=BB=A5=E8=A7=A3=E6=86=82=EF=BC=9F=E5=94=AF=E6=9C=89=E6=9D=9C=
=E5=BA=B7=E3=80=82--=E6=9B=B9=E6=93=8D)(=E4=BC=A0=E8=AF=B4=E6=9D=9C=E5=BA=
=B7=E6=98=AF=E9=85=92=E7=9A=84=E5=8F=91=E6=98=8E=E8=80=85)
