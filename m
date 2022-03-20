Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CC6C433EF
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 19:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245093AbiCTTP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiCTTP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 15:15:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564D53B00C
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 12:14:34 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn33so17412596ljb.6
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XJJ7lqm8taoRuZhnLrx2pfeiicgPsoubN2XRivgbXFA=;
        b=l5PXe72vcwDLvg8yABl2D2fbUWM1KpSlomK9MPrRH1gQdT2xDSiH1Sx1GSb7ytZMTJ
         EZjQaMcoq1GWbUK10xjNw+Oe9PFtoQK0NhI0r1E7ODs7rurQr07rMnixKZwhwoJ0N/bx
         C8k2nxEjU/kr/2a/kwNKfps08lrpksABkDIMpnsdXwiJU2Wjan7fszViqL9ZCmFXJFHi
         fr7KHDHLvNhHHTTr7KfoTlYaGPV02yYvxP1gJZnQ7vVMrcy/9vH1/RcHzEuTPyzq4c/i
         SC7XJOXEKQ6COr68OIfMcVDoocMiOdF+BzY9M9uqAy22zpCcookrMdhUyPKKSne2ffoj
         jMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=XJJ7lqm8taoRuZhnLrx2pfeiicgPsoubN2XRivgbXFA=;
        b=oMK2pMS+iOB9PLk5T494bCMckZ28UfYLTJqBuo/MHMS2lh+sgY3h0Qv0EyvE42FQ3b
         qqLfkhaoqdNj20EH+gVBC+H2SHIHYwq5TDU/aB4Wst970slJvhnb52F6ulosBH0KRfrd
         W6YBk/ZgCDnmv0JcKS8usPjJ0EIsCDiIC6sTR7GSESA4oCTFYJ6HBIUptBhALPDEZwSf
         rAtLL/zJWIIchfJA2OsvrV2kAZTdCPw8msuSTlzvpf2N2lvJ4x8kyjvWaTb0QbyXAwm/
         PaOZ3LEpEGyHWbachk2yB7OTqcFmA7bxwrrm0oFuFc65jnhcl6tfSMkrJxcDIZaz+lwb
         n0Sg==
X-Gm-Message-State: AOAM531Wot5a1xGavHiBAUNLrYgwHF2wUMOTWMUrM9GaqstmR5/ENRZx
        Nha+8Q9IYfsK8hOEHryGxnDar2D5xt93RDyjpwJGkQ4ciTw=
X-Google-Smtp-Source: ABdhPJwrsmWCmm7q9TAC9Kady7cUKu1Dt7kcpjdZ/331U6QmvmGqGfYKqnCvvCEIkDN8XCEzku+gEl04pax71xr4g4Q=
X-Received: by 2002:a2e:9d83:0:b0:246:2c6:79df with SMTP id
 c3-20020a2e9d83000000b0024602c679dfmr12647375ljj.280.1647803672137; Sun, 20
 Mar 2022 12:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <87in9ucsbb.fsf@evledraar.gmail.com> <20220318220623.50528-1-gaurijove@gmail.com>
 <CANsrJQdNKiX93GnVXztmvYQQBxr6-HsYNx5UvYXSFg32Op3ZPQ@mail.gmail.com>
 <CANsrJQe1YuggxdBHdSdukXRj3myVCTNwLiiWNLrAzPpzA4FOOA@mail.gmail.com>
 <220319.86ee2yds2f.gmgdl@evledraar.gmail.com> <CANsrJQdJ1wBThUyJ=QSt6NwU8HzQY2VaWc11UfZQ+ktRQs_YTQ@mail.gmail.com>
 <220319.86a6dlewyj.gmgdl@evledraar.gmail.com>
In-Reply-To: <220319.86a6dlewyj.gmgdl@evledraar.gmail.com>
From:   Jayati Shrivastava <gaurijove@gmail.com>
Date:   Mon, 21 Mar 2022 00:44:20 +0530
Message-ID: <CANsrJQdqoz7mZ9Fj08owgVWGKs25nPzE1g1dLASL=fz9j485hw@mail.gmail.com>
Subject: Re: Having grep support the -o option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 19, 2022 at 9:49 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> One thing I'd *really* like to see is the bits of %(if) %(then)
> etc. extracted from ref-filter.c into some general API other commands
> could use with strbuf_expand() and friends.
>
> I.e. if you could in addition to the strbuf_expand() callback define
> what verbs you support for "if" and the like, or have callbacks for
> their comparison functions.
>
> Then have that machinery drive the whole format expansion, which
> eventually would expand your %(some-custom-thing) via a callback.
>
> I.e. the whole "valid_atom" state machine in ref-filter.c.

So, the end goal is to design a formatting API that can be used by any
command that takes --format option? Previous interns worked on
unifying pretty.c and cat-file.c with ref-filter.c and so the next task can
be to extend "valid_atom" state machine to work with more commands.
Do you have any suggestions for new atoms/verbs I could add
support for or any such similar small exercise to start with?
+Hariom verma
+Christian Couder
+Git List
